DELETE FROM region_pairs;

-- ANA(ゾーン制、日本発、片道。ロー/レギュラー/ハイシーズンで3段階、検索日付に応じて自動選択)
-- 北米はANA公式チャートの往復実数を片道換算(高確度)、その他7地域はゾーン構造からの比例推定(中確度、要確認)
INSERT INTO region_pairs (program_code,to_region,season,economy,premium_economy,business,first) VALUES
('ANA','Northeast Asia','low',6000,NULL,9000,NULL),
('ANA','Northeast Asia','regular',7500,NULL,10500,NULL),
('ANA','Northeast Asia','high',9000,NULL,15000,NULL),

('ANA','Southeast Asia','low',10000,13500,20000,NULL),
('ANA','Southeast Asia','regular',12000,15500,22500,NULL),
('ANA','Southeast Asia','high',16000,20500,30000,NULL),

('ANA','South Asia','low',11500,15000,22500,NULL),
('ANA','South Asia','regular',13500,17500,25000,NULL),
('ANA','South Asia','high',17500,22500,33000,NULL),

('ANA','Hawaii','low',17500,27500,42500,NULL),
('ANA','Hawaii','regular',20000,30000,47500,NULL),
('ANA','Hawaii','high',27000,37500,65000,NULL),

('ANA','Oceania','low',17500,27500,42500,NULL),
('ANA','Oceania','regular',20000,30000,47500,NULL),
('ANA','Oceania','high',27000,37500,65000,NULL),

('ANA','North America','low',20000,31000,50000,75000),
('ANA','North America','regular',25000,36000,52500,85000),
('ANA','North America','high',36000,51500,82500,150000),

('ANA','Europe','low',22500,32500,55000,82500),
('ANA','Europe','regular',27500,38000,60000,92500),
('ANA','Europe','high',37500,52500,90000,155000),

('ANA','Middle East','low',20000,30000,50000,NULL),
('ANA','Middle East','regular',24000,34000,55000,NULL),
('ANA','Middle East','high',32000,45000,75000,NULL);

-- アラスカ航空マイレージプラン(提携社別チャートの日本関連区間のみ)
INSERT INTO region_pairs (program_code,to_region,economy,premium_economy,business,first) VALUES
('AS','North America',30000,NULL,60000,70000),
('AS','Hawaii',25000,NULL,45000,NULL),
('AS','Southeast Asia',20000,NULL,40000,NULL),
('AS','Europe',30000,NULL,70000,90000);

-- ヴァージン・アトランティック フライングクラブ(北米は西/東海岸の平均値)
INSERT INTO region_pairs (program_code,to_region,economy,premium_economy,business,first) VALUES
('VS','North America',22500,36000,56000,NULL),
('VS','Hawaii',15000,25000,37500,NULL),
('VS','Europe',22500,NULL,47500,NULL);

-- シンガポール航空クリスフライヤー(北米は西/東海岸の平均値、多くはSIN乗継)
INSERT INTO region_pairs (program_code,to_region,economy,premium_economy,business,first) VALUES
('SQ','Southeast Asia',18500,27500,42000,NULL),
('SQ','South Asia',22000,33000,55000,NULL),
('SQ','Oceania',24000,36000,60000,NULL),
('SQ','North America',40000,56000,95000,124000),
('SQ','Europe',41500,58000,97000,121000),
('SQ','Middle East',33000,NULL,66000,92000);

-- ターキッシュエアラインズ マイル・アンド・スマイルズ(地域ペア制、トルコ発チャートからの推定含む)
INSERT INTO region_pairs (program_code,to_region,economy,premium_economy,business,first) VALUES
('TK','Middle East',25000,NULL,45000,NULL),
('TK','Europe',40000,NULL,78000,NULL),
('TK','North America',45000,NULL,90000,NULL),
('TK','Southeast Asia',20000,NULL,40000,NULL);
