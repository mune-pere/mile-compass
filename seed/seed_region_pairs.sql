DELETE FROM region_pairs;

-- ANA(ゾーン制、日本発、片道・レギュラーシーズン目安)
INSERT INTO region_pairs (program_code,to_region,economy,premium_economy,business,first) VALUES
('ANA','Northeast Asia',6000,NULL,10000,NULL),
('ANA','Southeast Asia',12500,17500,30000,NULL),
('ANA','South Asia',15000,20000,35000,NULL),
('ANA','Hawaii',17500,22500,40000,NULL),
('ANA','Oceania',20000,25000,45000,NULL),
('ANA','North America',20000,27500,50000,75000),
('ANA','Europe',22500,30000,55000,88000),
('ANA','Middle East',20000,25000,45000,NULL);

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
