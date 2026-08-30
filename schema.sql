-- スキーマ変更時に毎回クリーンな状態から作り直す(参照データのみのため破壊的変更でも問題なし)
DROP TABLE IF EXISTS card_transfer_rates;
DROP TABLE IF EXISTS credit_cards;
DROP TABLE IF EXISTS dynamic_ranges;
DROP TABLE IF EXISTS region_pairs;
DROP TABLE IF EXISTS distance_bands;
DROP TABLE IF EXISTS flights;
DROP TABLE IF EXISTS programs;
DROP TABLE IF EXISTS airports;

-- 空港マスタ（日本発着の主要空港＋主要目的地空港）
CREATE TABLE IF NOT EXISTS airports (
  iata TEXT PRIMARY KEY,
  name_ja TEXT NOT NULL,
  city_ja TEXT NOT NULL,
  country_ja TEXT NOT NULL,
  kana TEXT NOT NULL, -- 検索用のかな・別名（スペース区切り）
  region TEXT NOT NULL, -- Japan/North America/Hawaii/Europe/Southeast Asia/Northeast Asia/Oceania/Middle East/South Asia
  lat REAL NOT NULL,
  lon REAL NOT NULL,
  is_japan INTEGER NOT NULL DEFAULT 0
);

-- マイレージプログラム（マイルを貯める/使う口座のプログラム）
CREATE TABLE IF NOT EXISTS programs (
  code TEXT PRIMARY KEY,
  name_ja TEXT NOT NULL,
  name_en TEXT NOT NULL,
  alliance TEXT NOT NULL, -- star / oneworld / skyteam / none
  pricing_type TEXT NOT NULL, -- distance_band / region_pair / dynamic
  can_book_jal INTEGER NOT NULL DEFAULT 0, -- JAL運航便を特典交換できるか
  can_book_ana INTEGER NOT NULL DEFAULT 0, -- ANA運航便を特典交換できるか
  infant_rule TEXT, -- no_miles_required / reduced_percentage / full_adult_miles_required / child_fare_required / varies
  infant_pct REAL, -- reduced_percentageの場合の割合(0-1)
  infant_notes_ja TEXT,
  infant_confidence TEXT, -- high/medium/low
  chart_confidence TEXT, -- high/medium/low(マイルチャート数値自体の確度)
  notes_ja TEXT,
  sources TEXT -- 参考url（改行区切り）
);

-- 距離帯別マイルチャート（ANA/JAL/BAなど distance_band タイプのプログラム用）
CREATE TABLE IF NOT EXISTS distance_bands (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  program_code TEXT NOT NULL REFERENCES programs(code),
  max_distance_miles INTEGER NOT NULL, -- この距離以下ならこの帯（片道マイル区分の上限）
  economy INTEGER,
  premium_economy INTEGER,
  business INTEGER,
  first INTEGER
);

-- 地域ペア別マイルチャート（Alaska/Virgin Atlanticなど region_pair タイプのプログラム用）
CREATE TABLE IF NOT EXISTS region_pairs (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  program_code TEXT NOT NULL REFERENCES programs(code),
  to_region TEXT NOT NULL, -- 日本発なので from は常にJapan
  economy INTEGER,
  premium_economy INTEGER,
  business INTEGER,
  first INTEGER
);

-- ダイナミックプライシング系プログラムの典型レンジ（UA/DLなど。片道の目安レンジ）
CREATE TABLE IF NOT EXISTS dynamic_ranges (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  program_code TEXT NOT NULL REFERENCES programs(code),
  to_region TEXT NOT NULL,
  economy_min INTEGER, economy_max INTEGER,
  premium_economy_min INTEGER, premium_economy_max INTEGER,
  business_min INTEGER, business_max INTEGER,
  first_min INTEGER, first_max INTEGER
);

-- クレジットカードのポイントプログラム（Marriott Bonvoy、アメックスGPなど）
CREATE TABLE IF NOT EXISTS credit_cards (
  code TEXT PRIMARY KEY, -- 例: BONVOY, AMEX_GP
  name_ja TEXT NOT NULL,
  points_name_ja TEXT NOT NULL, -- 例: Marriott Bonvoyポイント、メンバーシップ・リワードポイント
  annual_fee_note_ja TEXT, -- 年会費・移行に必要な追加プログラムの注記
  notes_ja TEXT
);

-- カードポイント→マイルの交換レート（プログラムごと、カードごと）
CREATE TABLE IF NOT EXISTS card_transfer_rates (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  card_code TEXT NOT NULL REFERENCES credit_cards(code),
  program_code TEXT NOT NULL REFERENCES programs(code),
  ratio_points_per_mile REAL NOT NULL, -- 例 3 = 3ポイントで1マイル、1 = 1ポイントで1マイル
  bonus_block INTEGER, -- ボーナス適用単位（例 60000ポイント単位）。なければNULL
  bonus_miles INTEGER, -- ボーナス単位ごとの追加マイル数。なければNULL
  notes_ja TEXT,
  confidence TEXT -- high/medium/low
);

-- 実際に飛べる便（運航会社・直行/経由）のネットワーク情報
CREATE TABLE IF NOT EXISTS flights (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  origin_iata TEXT NOT NULL,
  dest_iata TEXT NOT NULL,
  operating_airline_code TEXT NOT NULL,
  operating_airline_ja TEXT NOT NULL,
  alliance TEXT NOT NULL, -- star / oneworld / skyteam / none
  stops INTEGER NOT NULL, -- 0=direct, 1=one stop, 2=two or more
  via_ja TEXT, -- 経由地（stops>0の場合）
  notes_ja TEXT
);
