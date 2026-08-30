DELETE FROM dynamic_ranges;

-- エールフランスKLM フライングブルー(2025年1月〜フロア価格制。実勢レンジの目安)
INSERT INTO dynamic_ranges (program_code,to_region,economy_min,economy_max,premium_economy_min,premium_economy_max,business_min,business_max,first_min,first_max) VALUES
('AFKL','North America',25000,60000,40000,75000,60000,160000,NULL,NULL),
('AFKL','Europe',30000,70000,45000,85000,80000,180000,NULL,NULL),
('AFKL','Southeast Asia',15000,35000,25000,45000,40000,90000,NULL,NULL);

-- アメリカン航空アドバンテージ(提携チャート基準の実勢レンジ。2026年7月改定反映)
INSERT INTO dynamic_ranges (program_code,to_region,economy_min,economy_max,premium_economy_min,premium_economy_max,business_min,business_max,first_min,first_max) VALUES
('AA','North America',30000,55000,45000,70000,60000,100000,80000,140000),
('AA','Europe',40000,70000,55000,85000,70000,120000,90000,160000),
('AA','Southeast Asia',25000,45000,35000,55000,50000,80000,NULL,NULL);

-- ユナイテッド航空マイレージプラス(完全動的価格制。カード会員有無で幅が大きい)
INSERT INTO dynamic_ranges (program_code,to_region,economy_min,economy_max,premium_economy_min,premium_economy_max,business_min,business_max,first_min,first_max) VALUES
('UA','North America',30000,60000,45000,75000,70000,150000,NULL,NULL),
('UA','Europe',35000,65000,50000,80000,75000,160000,NULL,NULL),
('UA','Southeast Asia',20000,40000,30000,50000,45000,90000,NULL,NULL);

-- デルタ航空スカイマイル(完全動的価格制。2025年2月改定で大幅値上げ、振れ幅が非常に大きい)
INSERT INTO dynamic_ranges (program_code,to_region,economy_min,economy_max,premium_economy_min,premium_economy_max,business_min,business_max,first_min,first_max) VALUES
('DL','North America',35000,90000,55000,110000,85000,400000,NULL,NULL),
('DL','Europe',40000,80000,55000,100000,80000,180000,NULL,NULL),
('DL','Southeast Asia',25000,55000,35000,65000,55000,120000,NULL,NULL);
