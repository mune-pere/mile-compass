const CABIN_LABEL = {
  economy: "エコノミー",
  premium_economy: "プレミアムエコノミー",
  business: "ビジネス",
  first: "ファースト",
};
const ALLIANCE_LABEL = { star: "STAR ALLIANCE", oneworld: "ONEWORLD", skyteam: "SKYTEAM", none: "非加盟" };
const ALLIANCE_COLOR = { star: "#0f3092", oneworld: "#6f2c91", skyteam: "#00695c", none: "#8e8e93" };
const STOPS_LABEL = { 0: "直行", 1: "1経由" };
const CARD_ORDER = ["BONVOY", "AMEX_GP"];
const CARD_SHORT_LABEL = { BONVOY: "Bonvoy", AMEX_GP: "Amex GP" };
const CARD_ICON = { BONVOY: "M", AMEX_GP: "A" };
const YQ_BADGE = {
  yes: { label: "燃油サーチャージあり", cls: "yq-yes" },
  no: { label: "燃油サーチャージなし", cls: "yq-no" },
  varies: { label: "燃油サーチャージ変動あり", cls: "yq-varies" },
};

const AIRLINE_COLOR = {
  JL: "#C8102E", NH: "#13448F", UA: "#005DAA", DL: "#C01933", AA: "#0078D2",
  HA: "#653A75", TG: "#5C2D91", SQ: "#0A3161", CX: "#006564", KE: "#0F3092",
  OZ: "#E4002B", CI: "#C00000", BR: "#006A4E", MU: "#7B1F3A", QF: "#E40521",
  BA: "#075AAA", AF: "#002157", LH: "#05164D", KL: "#00A1DE", TK: "#E81932",
  EK: "#D71921", QR: "#5C0632", AI: "#D9251D", AC: "#F01428",
  MH: "#00644D", CA: "#C8161D", PR: "#1B3E94",
};

const FLAG_EMOJI = {
  "日本": "🇯🇵", "アメリカ": "🇺🇸", "タイ": "🇹🇭", "シンガポール": "🇸🇬", "香港": "🇭🇰",
  "韓国": "🇰🇷", "台湾": "🇹🇼", "中国": "🇨🇳", "オーストラリア": "🇦🇺", "イギリス": "🇬🇧",
  "フランス": "🇫🇷", "ドイツ": "🇩🇪", "オランダ": "🇳🇱", "トルコ": "🇹🇷",
  "アラブ首長国連邦": "🇦🇪", "カタール": "🇶🇦", "インド": "🇮🇳", "カナダ": "🇨🇦",
  "マレーシア": "🇲🇾", "インドネシア": "🇮🇩", "フィリピン": "🇵🇭", "ベトナム": "🇻🇳",
  "ミャンマー": "🇲🇲", "カンボジア": "🇰🇭", "ラオス": "🇱🇦", "イタリア": "🇮🇹",
  "スペイン": "🇪🇸", "スイス": "🇨🇭", "オーストリア": "🇦🇹", "デンマーク": "🇩🇰",
  "ベルギー": "🇧🇪", "ニュージーランド": "🇳🇿", "フィジー": "🇫🇯", "スリランカ": "🇱🇰",
  "ネパール": "🇳🇵", "メキシコ": "🇲🇽",
};

function flagFor(airport) {
  return (airport && FLAG_EMOJI[airport.country_ja]) || "🌐";
}

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
      li.textContent = `${flagFor(a)} ${a.name_ja}（${a.iata}）- ${a.city_ja}`;
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
  const date = document.getElementById("depart-date").value;

  if (!origin || !dest) {
    errorEl.textContent = "候補一覧から出発地・到着地を選択してください。";
    errorEl.classList.remove("hidden");
    return;
  }

  const params = new URLSearchParams({ origin, dest, stops, infant });
  if (date) params.set("date", date);

  const res = await fetch(`/api/search?${params.toString()}`);
  if (!res.ok) {
    errorEl.textContent = await res.text();
    errorEl.classList.remove("hidden");
    return;
  }
  lastData = await res.json();
  renderSummary(lastData);
  updateTabsForMode(lastData.is_domestic);
  document.getElementById("cabin-tabs").classList.remove("hidden");
  if (lastData.is_domestic && !["economy", "premium_economy"].includes(activeCabin)) {
    activeCabin = "economy";
  }
  document.querySelectorAll(".cabin-tabs .tab").forEach((t) => t.classList.toggle("active", t.dataset.cabin === activeCabin));
  renderCabin(activeCabin);
});

function updateTabsForMode(isDomestic) {
  const premiumTab = document.querySelector('.tab[data-cabin="premium_economy"]');
  const businessTab = document.querySelector('.tab[data-cabin="business"]');
  const firstTab = document.querySelector('.tab[data-cabin="first"]');
  if (isDomestic) {
    premiumTab.textContent = "プレミアムクラス/クラスJ";
    businessTab.classList.add("hidden");
    firstTab.classList.add("hidden");
  } else {
    premiumTab.textContent = "プレミアムエコノミー";
    businessTab.classList.remove("hidden");
    firstTab.classList.remove("hidden");
  }
}

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
  const seasonNote = data.season_note_ja ? ` <span class="distance-pill">${data.season_note_ja}</span>` : "";
  el.innerHTML = `
    <span>${flagFor(data.origin)} <strong>${data.origin.city_ja}（${data.origin.iata}）</strong> → ${flagFor(data.destination)} <strong>${data.destination.city_ja}（${data.destination.iata}）</strong></span>
    <span class="distance-pill">約${data.distance_miles.toLocaleString()}マイル</span>${seasonNote}
  `;
}

function renderCabin(cabin) {
  const container = document.getElementById("results");
  container.innerHTML = "";
  if (!lastData) return;

  const isDomestic = !!lastData.is_domestic;

  if (isDomestic && cabin === "premium_economy" && lastData.domestic_premium_note_ja) {
    const note = document.createElement("p");
    note.className = "domestic-note";
    note.textContent = lastData.domestic_premium_note_ja;
    container.appendChild(note);
  }

  const rows = lastData.cabins[cabin] || [];
  if (rows.length === 0) {
    const label = isDomestic && cabin === "premium_economy" ? "プレミアムクラス/クラスJ" : CABIN_LABEL[cabin];
    const empty = document.createElement("div");
    empty.className = "empty-state";
    empty.textContent = `${label}で比較できるデータが現在ありません。`;
    container.appendChild(empty);
    return;
  }

  const infantChecked = document.getElementById("infant-check").checked;

  rows.forEach((row, i) => {
    const card = document.createElement("article");
    card.className = "result-card" + (i === 0 ? " rank-1" : "");

    const milesText = row.is_dynamic
      ? `${row.miles_low.toLocaleString()}〜${row.miles_high.toLocaleString()}`
      : row.miles_low.toLocaleString();

    const chartFlag =
      row.chart_confidence && row.chart_confidence !== "high"
        ? `<span class="confidence-flag" title="公表チャートの改定が多く、実際の数値は要確認です">要確認</span>`
        : "";

    const allianceColor = ALLIANCE_COLOR[row.alliance] || ALLIANCE_COLOR.none;
    const allianceLabel = ALLIANCE_LABEL[row.alliance] || row.alliance;

    const airlineCode = row.operating_airline_code || "";
    const monogramColor = AIRLINE_COLOR[airlineCode] || "#8e8e93";
    const monogramText = airlineCode || "?";

    let stopsClass = "unknown";
    let stopsLabel = "経路データ準備中";
    if (row.stops === 0) { stopsClass = "direct"; stopsLabel = "直行"; }
    else if (row.stops != null) { stopsClass = "transit"; stopsLabel = STOPS_LABEL[row.stops] || `${row.stops}経由`; }
    const viaText = row.via_ja ? `（${row.via_ja}経由）` : "";

    const airlineText = row.operating_airline_ja
      ? `<strong>${row.operating_airline_ja}</strong>運航`
      : `${allianceLabel}系パートナー運航（詳細未整備）`;

    const conversions = row.card_conversions || [];
    const chipsHtml = conversions.length
      ? conversions
          .map((c) => {
            const cssClass = c.card_code.toLowerCase();
            const text = c.points_high != null
              ? `${c.points_low.toLocaleString()}〜${c.points_high.toLocaleString()}pt`
              : `${c.points_low.toLocaleString()}pt`;
            const flag = c.confidence && c.confidence !== "high"
              ? `<span class="confidence-flag" title="${c.notes_ja || ""}">要確認</span>`
              : "";
            const label = CARD_SHORT_LABEL[c.card_code] || c.card_name_ja;
            return `<span class="card-chip ${cssClass}"><span class="chip-icon">${CARD_ICON[c.card_code] || "$"}</span>${label} ${text}</span>${flag}`;
          })
          .join("")
      : `<span class="card-chip unavailable">対応カードなし</span>`;

    let infantRow = "";
    if (infantChecked) {
      if (isDomestic) {
        infantRow = `<div class="rc-meta-row">👶 <span>${lastData.domestic_infant_note_ja || "国内線の幼児・小児特典は要確認です。"}</span></div>`;
      } else {
        let infantText = "要確認";
        if (row.infant_rule === "no_miles_required") infantText = "マイル不要（現金の諸税等のみ）";
        else if (row.infant_rule === "reduced_percentage")
          infantText = `大人の${Math.round((row.infant_extra_miles / row.miles_low) * 100)}%（${row.infant_extra_miles?.toLocaleString()}マイル）`;
        else if (row.infant_rule === "full_adult_miles_required") infantText = "大人と同額のマイルが必要";
        else if (row.infant_rule === "child_fare_required") infantText = "現金の幼児運賃が別途必要";
        else if (row.infant_rule === "varies") infantText = "路線・条件により変動（現金ベース）";
        const flag = row.infant_notes_ja
          ? `<span class="confidence-flag" title="${row.infant_notes_ja}">詳細</span>`
          : "";
        infantRow = `<div class="rc-meta-row">👶 <span><strong>2歳未満特典:</strong> ${infantText} ${flag}</span></div>`;
      }
    }

    let feesRow = "";
    if (!isDomestic) {
      const yq = YQ_BADGE[row.yq_status];
      const yqBadgeHtml = yq ? `<span class="yq-badge ${yq.cls}">${yq.label}</span>` : "";
      const feeText =
        row.cash_fee_low_yen != null
          ? `¥${row.cash_fee_low_yen.toLocaleString()}〜¥${row.cash_fee_high_yen.toLocaleString()}（片道）`
          : "金額は要確認（予約時にご案内）";
      const feeConfidenceFlag =
        row.cash_fee_confidence && row.cash_fee_confidence !== "high"
          ? `<span class="confidence-flag" title="${row.cash_fee_notes_ja || ""}">要確認</span>`
          : "";
      const surchargeTitle = row.surcharge_notes_ja ? ` title="${row.surcharge_notes_ja}"` : "";
      feesRow = `<div class="rc-meta-row"${surchargeTitle}>💴 <span><strong>諸税・燃油サーチャージ目安:</strong> ${feeText} ${feeConfidenceFlag}</span>${yqBadgeHtml}</div>`;
    }

    card.innerHTML = `
      <div class="rc-top">
        <span class="rc-rank">${i + 1}</span>
        <span class="rc-program-name">${row.program_name_ja}</span>
        ${isDomestic ? "" : `<span class="alliance-badge" style="background:${allianceColor}">${allianceLabel}</span>`}
      </div>
      <div class="rc-flight-row">
        <span class="airline-monogram" style="background:${monogramColor}">${monogramText}</span>
        <span class="rc-flight-text">${airlineText}<span class="stops-pill ${stopsClass}">${stopsLabel}${viaText}</span></span>
      </div>
      <div class="rc-miles-row">
        <span class="rc-miles-value">${milesText}</span>
        <span class="rc-miles-unit">マイル（片道）</span>
        ${chartFlag}
      </div>
      <div class="card-chips">${chipsHtml}</div>
      ${feesRow || infantRow ? `<div class="rc-meta">${feesRow}${infantRow}</div>` : ""}
    `;
    container.appendChild(card);
  });
}
