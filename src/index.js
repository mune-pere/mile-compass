const CABINS = ["economy", "premium_economy", "business", "first"];
const CABIN_LABEL_JA = {
  economy: "エコノミー",
  premium_economy: "プレミアムエコノミー",
  business: "ビジネス",
  first: "ファースト",
};

// マイルプログラムの「自社運航便」に該当する運航会社コード（燃油サーチャージの自社/提携判定に使用）
const PROGRAM_HOME_AIRLINE_CODES = {
  ANA: ["NH"],
  JAL: ["JL"],
  AS: ["AS"],
  BA: ["BA"],
  VS: ["VS"],
  AFKL: ["AF", "KL"],
  KE: ["KE"],
  SQ: ["SQ"],
  CX: ["CX"],
  TK: ["TK"],
  AA: ["AA"],
  UA: ["UA"],
  DL: ["DL"],
  EY: ["EY"],
  QR: ["QR"],
};

export default {
  async fetch(request, env) {
    const url = new URL(request.url);

    if (url.pathname === "/api/airports" && request.method === "GET") {
      return handleAirportSearch(url, env);
    }

    if (url.pathname === "/api/search" && request.method === "GET") {
      return handleSearch(url, env);
    }

    return env.ASSETS.fetch(request);
  },
};

async function handleAirportSearch(url, env) {
  const q = (url.searchParams.get("q") || "").trim().toLowerCase();
  const type = url.searchParams.get("type") === "origin" ? 1 : 0; // 1=japan origin, 0=destination
  if (!q) return Response.json([]);

  const { results } = await env.DB.prepare(
    `SELECT iata, name_ja, city_ja, country_ja, region FROM airports
     WHERE is_japan = ? AND (
       lower(kana) LIKE ? OR lower(iata) = ? OR lower(name_ja) LIKE ? OR lower(city_ja) LIKE ?
     )
     ORDER BY iata LIMIT 8`
  )
    .bind(type, `%${q}%`, q, `%${q}%`, `%${q}%`)
    .all();

  return Response.json(results);
}

async function handleSearch(url, env) {
  const origin = (url.searchParams.get("origin") || "").toUpperCase();
  const dest = (url.searchParams.get("dest") || "").toUpperCase();
  const stopsFilter = url.searchParams.get("stops") || "any"; // nonstop | onestop | any
  const withInfant = url.searchParams.get("infant") === "1";
  const dateParam = url.searchParams.get("date"); // YYYY-MM-DD (任意)

  if (!origin || !dest) {
    return new Response("出発地と到着地を指定してください", { status: 400 });
  }

  const [originAirport, destAirport] = await Promise.all([
    env.DB.prepare("SELECT * FROM airports WHERE iata = ?").bind(origin).first(),
    env.DB.prepare("SELECT * FROM airports WHERE iata = ?").bind(dest).first(),
  ]);

  if (!originAirport || !destAirport) {
    return new Response("空港が見つかりません", { status: 404 });
  }

  const distanceMiles = Math.round(
    haversineMiles(originAirport.lat, originAirport.lon, destAirport.lat, destAirport.lon)
  );

  const region = destAirport.region;

  const PROGRAM_FIELDS = `p.name_ja, p.name_en, p.alliance, p.can_book_jal, p.can_book_ana,
              p.infant_rule, p.infant_pct, p.infant_notes_ja, p.infant_confidence, p.chart_confidence, p.notes_ja,
              p.charges_yq_own_metal, p.charges_yq_partner, p.surcharge_notes_ja`;

  const [regionRows, dynamicRows, distanceBandRows, flightRows, cardRateRows, seasonCalendarRows, cashFeeRows] = await Promise.all([
    env.DB.prepare(
      `SELECT rp.*, ${PROGRAM_FIELDS}
       FROM region_pairs rp JOIN programs p ON p.code = rp.program_code
       WHERE rp.to_region = ? AND rp.season = 'regular'`
    )
      .bind(region)
      .all(),
    env.DB.prepare(
      `SELECT dr.*, ${PROGRAM_FIELDS}
       FROM dynamic_ranges dr JOIN programs p ON p.code = dr.program_code
       WHERE dr.to_region = ?`
    )
      .bind(region)
      .all(),
    env.DB.prepare(
      `SELECT db.*, ${PROGRAM_FIELDS}
       FROM distance_bands db JOIN programs p ON p.code = db.program_code
       WHERE p.pricing_type = 'distance_band'`
    ).all(),
    env.DB.prepare(
      `SELECT * FROM flights WHERE origin_iata = ? AND dest_iata = ?
       UNION ALL
       SELECT * FROM flights WHERE origin_iata = 'HND' AND dest_iata = ? AND ? != 'HND'`
    )
      .bind(origin, dest, dest, origin)
      .all(),
    env.DB.prepare(
      `SELECT ctr.*, cc.name_ja AS card_name_ja, cc.points_name_ja
       FROM card_transfer_rates ctr JOIN credit_cards cc ON cc.code = ctr.card_code`
    ).all(),
    env.DB.prepare(`SELECT * FROM season_calendars`).all(),
    env.DB.prepare(`SELECT * FROM cash_fees WHERE to_region = ?`).bind(region).all(),
  ]);

  const cashFeeByProgram = new Map();
  for (const f of cashFeeRows.results) {
    cashFeeByProgram.set(f.program_code, f);
  }

  // 検索日付が指定されている場合、季節カレンダーを持つプログラム(現状ANAのみ)の該当シーズンを解決し、
  // regularシーズンの行を置き換える
  let seasonNoteJa = null;
  if (dateParam) {
    const d = new Date(dateParam + "T00:00:00Z");
    if (!isNaN(d.getTime())) {
      const month = d.getUTCMonth() + 1;
      const day = d.getUTCDate();
      const byProgram = new Map();
      for (const c of seasonCalendarRows.results) {
        if (!byProgram.has(c.program_code)) byProgram.set(c.program_code, []);
        byProgram.get(c.program_code).push(c);
      }

      for (const [programCode, calendarRows] of byProgram) {
        const match = calendarRows.find((c) => {
          const key = month * 100 + day;
          return key >= c.start_month * 100 + c.start_day && key <= c.end_month * 100 + c.end_day;
        });
        const resolvedSeason = match ? match.season : "regular";
        if (resolvedSeason !== "regular") {
          const seasonalRows = await env.DB.prepare(
            `SELECT rp.*, ${PROGRAM_FIELDS}
             FROM region_pairs rp JOIN programs p ON p.code = rp.program_code
             WHERE rp.to_region = ? AND rp.program_code = ? AND rp.season = ?`
          )
            .bind(region, programCode, resolvedSeason)
            .all();
          if (seasonalRows.results.length > 0) {
            regionRows.results = regionRows.results.filter((r) => r.program_code !== programCode);
            regionRows.results.push(...seasonalRows.results);
            const seasonLabelJa = { low: "ローシーズン", high: "ハイシーズン" }[resolvedSeason] || resolvedSeason;
            const programNameJa = seasonalRows.results[0].name_ja;
            seasonNoteJa = `${programNameJa}: ${seasonLabelJa}料金を表示中`;
          }
        }
      }
    }
  }

  const cardRatesByProgram = new Map();
  for (const r of cardRateRows.results) {
    if (!cardRatesByProgram.has(r.program_code)) cardRatesByProgram.set(r.program_code, []);
    cardRatesByProgram.get(r.program_code).push(r);
  }

  const bandsByProgram = new Map();
  for (const b of distanceBandRows.results) {
    if (!bandsByProgram.has(b.program_code)) bandsByProgram.set(b.program_code, []);
    bandsByProgram.get(b.program_code).push(b);
  }
  const distanceBandBest = [];
  for (const bands of bandsByProgram.values()) {
    bands.sort((a, b) => a.max_distance_miles - b.max_distance_miles);
    const match = bands.find((b) => b.max_distance_miles >= distanceMiles) || bands[bands.length - 1];
    if (match) distanceBandBest.push(match);
  }

  const flights = flightRows.results;

  function bestFlightFor(program) {
    const candidates = flights.filter((f) => {
      if (f.alliance === program.alliance && program.alliance !== "none") return true;
      if (f.operating_airline_code === "JL" && program.can_book_jal) return true;
      if (f.operating_airline_code === "NH" && program.can_book_ana) return true;
      return false;
    });
    if (candidates.length === 0) return null;
    candidates.sort((a, b) => a.stops - b.stops);
    return candidates[0];
  }

  const cabinResults = { economy: [], premium_economy: [], business: [], first: [] };

  for (const row of regionRows.results) {
    const flight = bestFlightFor(row);
    addRowsForProgram(cabinResults, row, flight, {
      distanceMiles,
      stopsFilter,
      withInfant,
      isDynamic: false,
      cardRates: cardRatesByProgram.get(row.program_code) || [],
      cashFee: cashFeeByProgram.get(row.program_code) || null,
    });
  }

  for (const row of dynamicRows.results) {
    const flight = bestFlightFor(row);
    addRowsForProgram(cabinResults, row, flight, {
      distanceMiles,
      stopsFilter,
      withInfant,
      isDynamic: true,
      cardRates: cardRatesByProgram.get(row.program_code) || [],
      cashFee: cashFeeByProgram.get(row.program_code) || null,
    });
  }

  for (const row of distanceBandBest) {
    const flight = bestFlightFor(row);
    addRowsForProgram(cabinResults, row, flight, {
      distanceMiles,
      stopsFilter,
      withInfant,
      isDynamic: false,
      cardRates: cardRatesByProgram.get(row.program_code) || [],
      cashFee: cashFeeByProgram.get(row.program_code) || null,
    });
  }

  for (const cabin of CABINS) {
    cabinResults[cabin].sort((a, b) => a.miles_sort - b.miles_sort);
  }

  return Response.json({
    origin: originAirport,
    destination: destAirport,
    distance_miles: distanceMiles,
    region,
    season_note_ja: seasonNoteJa,
    cabins: cabinResults,
  });
}

function addRowsForProgram(cabinResults, row, flight, opts) {
  const { distanceMiles, stopsFilter, withInfant, isDynamic, cardRates, cashFee } = opts;
  const stops = flight ? flight.stops : null;

  if (stopsFilter === "nonstop" && stops !== 0) return;
  if (stopsFilter === "onestop" && !(stops === 0 || stops === 1)) return;

  const homeCodes = PROGRAM_HOME_AIRLINE_CODES[row.program_code] || [];
  const isOwnMetal = flight ? homeCodes.includes(flight.operating_airline_code) : null;
  const yqStatus = isOwnMetal == null ? row.charges_yq_partner : isOwnMetal ? row.charges_yq_own_metal : row.charges_yq_partner;

  for (const cabin of CABINS) {
    let milesLow, milesHigh;
    if (isDynamic) {
      milesLow = row[`${cabin}_min`];
      milesHigh = row[`${cabin}_max`];
    } else {
      milesLow = row[cabin];
      milesHigh = row[cabin];
    }
    if (milesLow == null) continue;

    const cardConversions = (cardRates || []).map((cr) => ({
      card_code: cr.card_code,
      card_name_ja: cr.card_name_ja,
      points_name_ja: cr.points_name_ja,
      points_low: milesToCardPoints(milesLow, cr.ratio_points_per_mile, cr.bonus_block, cr.bonus_miles),
      points_high: isDynamic
        ? milesToCardPoints(milesHigh, cr.ratio_points_per_mile, cr.bonus_block, cr.bonus_miles)
        : null,
      notes_ja: cr.notes_ja,
      confidence: cr.confidence,
    }));

    let infantMiles = null;
    if (withInfant && row.infant_rule === "reduced_percentage" && row.infant_pct != null) {
      infantMiles = Math.ceil(milesLow * row.infant_pct);
    } else if (withInfant && row.infant_rule === "full_adult_miles_required") {
      infantMiles = milesLow;
    } else if (withInfant && row.infant_rule === "no_miles_required") {
      infantMiles = 0;
    }

    let cashFeeLow = null;
    let cashFeeHigh = null;
    if (cashFee) {
      cashFeeLow = cashFee[`${cabin}_low_yen`];
      cashFeeHigh = cashFee[`${cabin}_high_yen`];
    }

    cabinResults[cabin].push({
      program_code: row.program_code,
      program_name_ja: row.name_ja,
      alliance: row.alliance,
      operating_airline_ja: flight ? flight.operating_airline_ja : null,
      operating_airline_code: flight ? flight.operating_airline_code : null,
      stops,
      via_ja: flight ? flight.via_ja : null,
      is_dynamic: isDynamic,
      miles_low: milesLow,
      miles_high: isDynamic ? milesHigh : null,
      miles_sort: milesLow,
      distance_miles: distanceMiles,
      card_conversions: cardConversions,
      infant_rule: row.infant_rule,
      infant_notes_ja: row.infant_notes_ja,
      infant_confidence: row.infant_confidence,
      infant_extra_miles: infantMiles,
      chart_confidence: row.chart_confidence,
      notes_ja: row.notes_ja,
      cash_fee_low_yen: cashFeeLow ?? null,
      cash_fee_high_yen: cashFeeHigh ?? null,
      cash_fee_confidence: cashFee ? cashFee.confidence : null,
      cash_fee_notes_ja: cashFee ? cashFee.notes_ja : null,
      is_own_metal: isOwnMetal,
      yq_status: yqStatus,
      surcharge_notes_ja: row.surcharge_notes_ja,
    });
  }
}

function milesToCardPoints(miles, ratio, bonusBlock, bonusMiles) {
  if (!miles || !ratio) return null;
  if (bonusBlock && bonusMiles) {
    const milesPerBlock = bonusBlock / ratio + bonusMiles;
    const blocks = Math.floor(miles / milesPerBlock);
    const remainder = miles - blocks * milesPerBlock;
    return blocks * bonusBlock + Math.ceil(remainder * ratio);
  }
  return Math.ceil(miles * ratio);
}

function haversineMiles(lat1, lon1, lat2, lon2) {
  const R = 3958.8; // 地球半径(マイル)
  const toRad = (d) => (d * Math.PI) / 180;
  const dLat = toRad(lat2 - lat1);
  const dLon = toRad(lon2 - lon1);
  const a =
    Math.sin(dLat / 2) ** 2 +
    Math.cos(toRad(lat1)) * Math.cos(toRad(lat2)) * Math.sin(dLon / 2) ** 2;
  const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  return R * c;
}
