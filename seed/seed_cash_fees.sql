DELETE FROM cash_fees;

-- ANA(自社運航便の燃油特別付加運賃。2026年9-10月発券分。片道・円)
INSERT INTO cash_fees (program_code,to_region,economy_low_yen,economy_high_yen,premium_economy_low_yen,premium_economy_high_yen,business_low_yen,business_high_yen,first_low_yen,first_high_yen,notes_ja,confidence) VALUES
('ANA','North America',50000,56000,50000,56000,50000,56000,50000,56000,'ANA運航便の燃油特別付加運賃。隔月改定・為替連動のため変動あり。','high'),
('ANA','Europe',50000,56000,50000,56000,50000,56000,50000,56000,'ANA運航便の燃油特別付加運賃。隔月改定・為替連動のため変動あり。','high'),
('ANA','Southeast Asia',27300,29000,27300,29000,27300,29000,NULL,NULL,'ANA運航便の燃油特別付加運賃。隔月改定・為替連動のため変動あり。','high'),
('ANA','Northeast Asia',6500,14700,6500,14700,6500,14700,NULL,NULL,'ANA運航便の燃油特別付加運賃。区間により幅が大きい。','high'),
('ANA','Hawaii',35800,36800,35800,36800,35800,36800,35800,36800,'ANA運航便の燃油特別付加運賃。','high');

-- JAL(自社運航便の燃油特別付加運賃。2026年9-10月発券分。片道・円)
INSERT INTO cash_fees (program_code,to_region,economy_low_yen,economy_high_yen,premium_economy_low_yen,premium_economy_high_yen,business_low_yen,business_high_yen,first_low_yen,first_high_yen,notes_ja,confidence) VALUES
('JAL','North America',45000,50000,45000,50000,45000,50000,45000,50000,'JAL運航便の燃油特別付加運賃。ANAよりやや安い水準で推移。隔月改定。','high'),
('JAL','Europe',45000,50000,45000,50000,45000,50000,45000,50000,'JAL運航便の燃油特別付加運賃。隔月改定。','high'),
('JAL','Southeast Asia',26000,29000,26000,29000,26000,29000,NULL,NULL,'JAL運航便の燃油特別付加運賃。','high'),
('JAL','Northeast Asia',5900,12400,5900,12400,5900,12400,NULL,NULL,'JAL運航便の燃油特別付加運賃。区間により幅が大きい。','high'),
('JAL','Hawaii',30900,36000,30900,36000,30900,36000,NULL,NULL,'JAL運航便の燃油特別付加運賃。','high');

-- アラスカ航空マイレージプラン(燃油サーチャージ非転嫁。空港税等のみの実質負担額目安。片道・円)
INSERT INTO cash_fees (program_code,to_region,economy_low_yen,economy_high_yen,premium_economy_low_yen,premium_economy_high_yen,business_low_yen,business_high_yen,first_low_yen,first_high_yen,notes_ja,confidence) VALUES
('AS','North America',3000,9000,3000,9000,3000,9000,3000,9000,'燃油サーチャージなし。空港税・諸税のみの実質負担。','medium'),
('AS','Europe',3000,9000,NULL,NULL,3000,9000,NULL,NULL,'燃油サーチャージなし。空港税・諸税のみの実質負担。','medium'),
('AS','Southeast Asia',3000,9000,NULL,NULL,3000,9000,NULL,NULL,'燃油サーチャージなし。空港税・諸税のみの実質負担。','medium'),
('AS','Northeast Asia',1500,7500,NULL,NULL,1500,7500,1500,9000,'燃油サーチャージなし。空港税・諸税のみの実質負担。','medium'),
('AS','Hawaii',3000,9000,NULL,NULL,3000,9000,NULL,NULL,'燃油サーチャージなし。空港税・諸税のみの実質負担。','medium');

-- ブリティッシュ・エアウェイズ Avios(BA運航便のキャリア課徴金込み。片道・円、確度はやや低め)
INSERT INTO cash_fees (program_code,to_region,economy_low_yen,economy_high_yen,premium_economy_low_yen,premium_economy_high_yen,business_low_yen,business_high_yen,first_low_yen,first_high_yen,notes_ja,confidence) VALUES
('BA','North America',15000,30000,25000,40000,45000,80000,60000,100000,'BA運航便は業界屈指の高額なキャリア課徴金。提携便(JAL等)経由なら大幅に安くなる場合あり。','low'),
('BA','Europe',15000,30000,25000,40000,65000,100000,80000,120000,'東京-ロンドン間の実例で片道65,000円程度。BA運航便は特に高額。','low'),
('BA','Southeast Asia',8000,20000,15000,25000,25000,45000,NULL,NULL,'BA運航便のキャリア課徴金目安。','low'),
('BA','Northeast Asia',3000,10000,NULL,NULL,10000,20000,NULL,NULL,'BA運航便のキャリア課徴金目安。','low'),
('BA','Hawaii',15000,25000,NULL,NULL,40000,70000,NULL,NULL,'BA運航便のキャリア課徴金目安。','low');
