const CABIN_LABEL = {
  economy: "エコノミー",
  premium_economy: "プレミアムエコノミー",
  business: "ビジネス",
  first: "ファースト",
};
const ALLIANCE_LABEL = {
  star: "スターアライアンス",
  oneworld: "ワンワールド",
  skyteam: "スカイチーム",
  none: "非加盟",
};
const STOPS_LABEL = { 0: "直行", 1: "1経由" };
const CARD_ORDER = ["BONVOY", "AMEX_GP"];
const CARD_SHORT_LABEL = { BONVOY: "Bonvoyポイント", AMEX_GP: "Amex GPポイント" };

function setupAutocomplete(inputId, hiddenId, suggestionsId, type) {
  const input = document.getElementById(inputId);
  const hidden = document.getElementById(hiddenId);
  const list = document.getElementById(suggestionsId);
  let timer = null;

  input.addEventListener("input", () => {
    hidden.value = "";
    clearTimeout(timer);
    const q = input.value.trim();
    if (!q) {
      list.innerHTML = "";
      list.classList.add("hidden");
      return;
    }
    timer = setTimeout(async () => {
      const res = await fetch(`/api/airports?q=${encodeURIComponent(q)}&type=${type}`);
      const airports = await res.json();
      renderSuggestions(airports);
    }, 200);
  });

  function renderSuggestions(airports) {
    list.innerHTML = "";
    if (airports.length === 0) {
      list.classList.add("hidden");
      return;
    }
    for (const a of airports) {
      const li = document.createElement("li");
      li.textContent = `${a.name_ja}（${a.iata}）- ${a.city_ja}`;
      li.addEventListener("click", () => {
        input.value = `${a.city_ja}（${a.iata}）`;
        hidden.value = a.iata;
        list.innerHTML = "";
        list.classList.add("hidden");
      });
      list.appendChild(li);
    }
    list.classList.remove("hidden");
  }

  document.addEventListener("click", (e) => {
    if (!input.parentElement.contains(e.target)) {
      list.classList.add("hidden");
    }
  });
}

setupAutocomplete("origin-input", "origin-iata", "origin-suggestions", "origin");
setupAutocomplete("dest-input", "dest-iata", "dest-suggestions", "dest");

let lastData = null;
let activeCabin = "economy";

document.getElementById("search-form").addEventListener("submit", async (e) => {
  e.preventDefault();
  const errorEl = document.getElementById("search-error");
  errorEl.classList.add("hidden");

  const origin = document.getElementById("origin-iata").value;
  const dest = document.getElementById("dest-iata").value;
  const stops = document.getElementById("stops-select").value;
  const infant = document.getElementById("infant-check").checked ? "1" : "0";

  if (!origin || !dest) {
    errorEl.textContent = "候補一覧から出発地・到着地を選択してください。";
    errorEl.classList.remove("hidden");
    return;
  }

  const res = await fetch(
    `/api/search?origin=${origin}&dest=${dest}&stops=${stops}&infant=${infant}`
  );
  if (!res.ok) {
    errorEl.textContent = await res.text();
    errorEl.classList.remove("hidden");
    return;
  }
  lastData = await res.json();
  renderSummary(lastData);
  document.getElementById("cabin-tabs").classList.remove("hidden");
  renderCabin(activeCabin);
});

document.getElementById("cabin-tabs").addEventListener("click", (e) => {
  const btn = e.target.closest(".tab");
  if (!btn) return;
  document.querySelectorAll(".cabin-tabs .tab").forEach((t) => t.classList.remove("active"));
  btn.classList.add("active");
  activeCabin = btn.dataset.cabin;
  renderCabin(activeCabin);
});

function renderSummary(data) {
  const el = document.getElementById("result-summary");
  el.classList.remove("hidden");
  el.textContent = `${data.origin.city_ja}（${data.origin.iata}） → ${data.destination.city_ja}（${data.destination.iata}） 概算距離 約${data.distance_miles.toLocaleString()}マイル / 地域: ${data.region}`;
}

function renderCabin(cabin) {
  const container = document.getElementById("results");
  container.innerHTML = "";
  if (!lastData) return;

  const rows = lastData.cabins[cabin] || [];
  if (rows.length === 0) {
    container.innerHTML = `<div class="empty-state">${CABIN_LABEL[cabin]}クラスで比較できるデータが現在ありません。</div>`;
    return;
  }

  // このカビンに登場するカードだけ列として出す(CARD_ORDER優先、それ以外はコード順)
  const cardCodesPresent = new Set();
  rows.forEach((r) => (r.card_conversions || []).forEach((c) => cardCodesPresent.add(c.card_code)));
  const cardColumns = [
    ...CARD_ORDER.filter((c) => cardCodesPresent.has(c)),
    ...[...cardCodesPresent].filter((c) => !CARD_ORDER.includes(c)).sort(),
  ];
  const cardFullNameByCode = {};
  rows.forEach((r) => (r.card_conversions || []).forEach((c) => (cardFullNameByCode[c.card_code] = c.card_name_ja)));
  const cardNameByCode = {};
  cardColumns.forEach((code) => (cardNameByCode[code] = CARD_SHORT_LABEL[code] || cardFullNameByCode[code] || code));

  const table = document.createElement("table");
  table.className = "result-table";
  const cardHeaders = cardColumns
    .map((code) => `<th title="${cardFullNameByCode[code] || ""}">${cardNameByCode[code]}換算</th>`)
    .join("");
  table.innerHTML = `
    <thead>
      <tr>
        <th>順位</th>
        <th>マイルプログラム</th>
        <th>実際に乗る航空会社</th>
        <th>直行/経由</th>
        <th>必要マイル(片道)</th>
        ${cardHeaders}
        <th>幼児(2歳未満)特典</th>
      </tr>
    </thead>
    <tbody></tbody>
  `;
  const tbody = table.querySelector("tbody");

  rows.forEach((row, i) => {
    const tr = document.createElement("tr");

    const milesText = row.is_dynamic
      ? `${row.miles_low.toLocaleString()}〜${row.miles_high.toLocaleString()}`
      : row.miles_low.toLocaleString();

    const stopsText =
      row.stops === null
        ? "経路データ準備中"
        : STOPS_LABEL[row.stops] || `${row.stops}経由`;
    const viaText = row.via_ja ? `（${row.via_ja}経由）` : "";

    const airlineText = row.operating_airline_ja
      ? `${row.operating_airline_ja}`
      : `${ALLIANCE_LABEL[row.alliance] || row.alliance}系（詳細未整備）`;

    let infantText = "-";
    if (document.getElementById("infant-check").checked) {
      if (row.infant_rule === "no_miles_required") infantText = "マイル不要";
      else if (row.infant_rule === "reduced_percentage")
        infantText = `大人の${Math.round((row.infant_extra_miles / row.miles_low) * 100)}%(${row.infant_extra_miles?.toLocaleString()}マイル)`;
      else if (row.infant_rule === "full_adult_miles_required") infantText = "大人と同額必要";
      else if (row.infant_rule === "child_fare_required") infantText = "現金の幼児運賃が別途必要";
      else infantText = "要確認";
      if (row.infant_notes_ja) infantText += ` <span class="confidence-flag" title="${row.infant_notes_ja}">詳細</span>`;
    }

    const chartFlag =
      row.chart_confidence && row.chart_confidence !== "high"
        ? `<span class="confidence-flag">要確認</span>`
        : "";

    const cardCells = cardColumns
      .map((code) => {
        const c = (row.card_conversions || []).find((cc) => cc.card_code === code);
        if (!c || c.points_low == null) return `<td data-label="${cardNameByCode[code] || code}換算">対象外</td>`;
        const text = c.points_high != null
          ? `${c.points_low.toLocaleString()}〜${c.points_high.toLocaleString()}pt`
          : `${c.points_low.toLocaleString()}pt`;
        const flag = c.confidence && c.confidence !== "high" ? ` <span class="confidence-flag" title="${c.notes_ja || ""}">要確認</span>` : "";
        return `<td data-label="${cardNameByCode[code] || code}換算">${text}${flag}</td>`;
      })
      .join("");

    tr.innerHTML = `
      <td data-label="順位"><span class="rank-badge">${i + 1}</span></td>
      <td data-label="マイルプログラム">${row.program_name_ja}</td>
      <td data-label="実際に乗る航空会社">${airlineText}</td>
      <td data-label="直行/経由">${stopsText}${viaText}</td>
      <td data-label="必要マイル(片道)" class="miles-cell">${milesText}マイル ${chartFlag}</td>
      ${cardCells}
      <td data-label="幼児(2歳未満)特典">${infantText}</td>
    `;
    tbody.appendChild(tr);
  });

  container.appendChild(table);
}
