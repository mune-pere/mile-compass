DELETE FROM domestic_routes;
DELETE FROM domestic_bands;

-- ANA国内線特典航空券(距離帯×シーズン制。プレミアムクラスは現状マイルのみでの新規予約不可のため現金アップグレード前提の旨をUIで案内)
-- 2024年10月27日改定後のシーズン別必要マイルチャート(ブログ経由の確認、confidence medium)
INSERT INTO domestic_bands (program_code,max_distance_miles,season,economy,premium,notes_ja,confidence) VALUES
('ANA',350,'low',6000,NULL,'短距離帯(例: 秋田-東京)','medium'),
('ANA',350,'regular',6500,NULL,'短距離帯(例: 秋田-東京)','medium'),
('ANA',350,'high',9000,NULL,'短距離帯(例: 秋田-東京)','medium'),

('ANA',700,'low',7000,NULL,'中距離帯(例: 札幌-東京)','medium'),
('ANA',700,'regular',8500,NULL,'中距離帯(例: 札幌-東京)','medium'),
('ANA',700,'high',10500,NULL,'中距離帯(例: 札幌-東京)','medium'),

('ANA',1300,'low',8000,NULL,'長距離帯(例: 那覇-東京)','medium'),
('ANA',1300,'regular',9500,NULL,'長距離帯(例: 那覇-東京)','medium'),
('ANA',1300,'high',12000,NULL,'長距離帯(例: 那覇-東京)','medium'),

('ANA',99999,'low',9500,NULL,'最長距離帯(例: 石垣・宮古-東京、那覇-新千歳)','medium'),
('ANA',99999,'regular',10500,NULL,'最長距離帯(例: 石垣・宮古-東京、那覇-新千歳)','medium'),
('ANA',99999,'high',13000,NULL,'最長距離帯(例: 石垣・宮古-東京、那覇-新千歳)','medium');

-- JAL国内線特典航空券(ゾーンA〜G制、季節変動なし。2025年6月10日発券分改定後の現行チャート、confidence medium)
-- 実際のゾーン割当は路線ごとの公式区分のため、距離帯はおおよその目安(未確定路線用のフォールバック)
INSERT INTO domestic_bands (program_code,max_distance_miles,season,economy,premium,notes_ja,confidence) VALUES
('JAL',300,'regular',4500,5500,'ゾーンA相当(推定)','low'),
('JAL',450,'regular',5500,6500,'ゾーンB相当(推定)','low'),
('JAL',600,'regular',6500,7500,'ゾーンC相当(推定)','low'),
('JAL',750,'regular',7500,7500,'ゾーンD相当(推定)','low'),
('JAL',1000,'regular',8500,10000,'ゾーンE相当(推定)','low'),
('JAL',1300,'regular',9500,11500,'ゾーンF相当(推定)','low'),
('JAL',99999,'regular',10500,13500,'ゾーンG相当(推定)','low');

-- JALの公式に近い一次情報で確認できた具体的な区間(距離帯フォールバックより優先)
INSERT INTO domestic_routes (program_code,origin_iata,dest_iata,economy,premium,notes_ja,confidence) VALUES
('JAL','HND','OKA',9500,11500,'ゾーンF(東京-沖縄)。ファーストクラスは別途22,000マイル程度で特典予約可能。','medium'),
('JAL','OKA','HND',9500,11500,'ゾーンF(東京-沖縄)。ファーストクラスは別途22,000マイル程度で特典予約可能。','medium'),
('JAL','HND','MMY',10500,13500,'ゾーンG(東京-宮古)。ファーストクラスは別途24,000マイル程度で特典予約可能。','medium'),
('JAL','MMY','HND',10500,13500,'ゾーンG(東京-宮古)。ファーストクラスは別途24,000マイル程度で特典予約可能。','medium'),
('JAL','HND','ISG',10500,13500,'ゾーンG(東京-石垣)。ファーストクラスは別途24,000マイル程度で特典予約可能。','medium'),
('JAL','ISG','HND',10500,13500,'ゾーンG(東京-石垣)。ファーストクラスは別途24,000マイル程度で特典予約可能。','medium');
