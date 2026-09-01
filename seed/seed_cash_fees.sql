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

-- ヴァージン・アトランティック フライングクラブ(ANA運航便経由。片道・円、確度は中程度で幅が大きい)
INSERT INTO cash_fees (program_code,to_region,economy_low_yen,economy_high_yen,premium_economy_low_yen,premium_economy_high_yen,business_low_yen,business_high_yen,first_low_yen,first_high_yen,notes_ja,confidence) VALUES
('VS','North America',NULL,NULL,NULL,NULL,23000,62000,NULL,NULL,'ANA運航便をVSポイントで予約した場合の目安。ANA自社発券より低いがコロナ後は完全無料ではない。','medium'),
('VS','Hawaii',NULL,NULL,NULL,NULL,40000,55000,NULL,NULL,'ANA運航便をVSポイントで予約した場合の目安。','medium');

-- 大韓航空SKYPASS(自社運航便に燃油特別付加運賃あり。2026年は乱高下、片道・円)
INSERT INTO cash_fees (program_code,to_region,economy_low_yen,economy_high_yen,premium_economy_low_yen,premium_economy_high_yen,business_low_yen,business_high_yen,first_low_yen,first_high_yen,notes_ja,confidence) VALUES
('KE','North America',25000,68000,25000,68000,25000,68000,25000,68000,'2026年は原油価格・ウォン安の影響で改定ごとに大きく変動。ANA/JALより高くなる場合もある。','medium'),
('KE','Europe',25000,68000,25000,68000,25000,68000,25000,68000,'2026年7月発券分パリ路線実例で片道68,300円。','medium'),
('KE','Southeast Asia',15000,19000,15000,19000,15000,19000,NULL,NULL,'2026年の改定に連動し変動。','medium'),
('KE','Northeast Asia',5000,10000,NULL,NULL,5000,10000,NULL,NULL,'日韓区間は比較的安価だが2026年に値上げ傾向。','medium'),
('KE','Hawaii',15000,19000,NULL,NULL,15000,19000,NULL,NULL,'東南アジアと同水準のグルーピングで改定される。','medium');

-- シンガポール航空クリスフライヤー(自社運航便は2017年以降燃油サーチャージ撤廃。片道・円)
INSERT INTO cash_fees (program_code,to_region,economy_low_yen,economy_high_yen,premium_economy_low_yen,premium_economy_high_yen,business_low_yen,business_high_yen,first_low_yen,first_high_yen,notes_ja,confidence) VALUES
('SQ','Southeast Asia',7000,8000,7000,8000,7000,8000,7000,8000,'シンガポール航空自社運航便は2017年3月以降、燃油サーチャージを運賃に統合済み。空港税等のみで全クラス定額。提携便(スターアライアンス他社)経由の場合は運航会社次第で大きく変動(高額な場合あり)。','high');

-- ターキッシュエアラインズ マイル・アンド・スマイルズ(自社・提携便とも燃油サーチャージあり。片道・円、推定USD換算のため確度は低め)
INSERT INTO cash_fees (program_code,to_region,economy_low_yen,economy_high_yen,premium_economy_low_yen,premium_economy_high_yen,business_low_yen,business_high_yen,first_low_yen,first_high_yen,notes_ja,confidence) VALUES
('TK','North America',15000,25000,NULL,NULL,30000,40000,NULL,NULL,'USD建て情報からの円換算推定。ユナイテッド運航便経由なら燃油サーチャージなし。','low'),
('TK','Europe',20000,30000,NULL,NULL,55000,60000,NULL,NULL,'トルコ航空自社便(イスタンブール経由)の推定額。ルフトハンザグループ運航便は往復20万円超になる場合もあり要注意。','low'),
('TK','Southeast Asia',10000,20000,NULL,NULL,20000,30000,NULL,NULL,'USD建て情報からの円換算推定。','low'),
('TK','Middle East',10000,20000,NULL,NULL,20000,30000,NULL,NULL,'イスタンブール自体を含むトルコ航空自社便の推定額。','low');

-- カタール航空プリビレッジクラブ(Avios)(自社便は定額発券手数料制。提携便は実額より上乗せされる報告あり。片道・円)
INSERT INTO cash_fees (program_code,to_region,economy_low_yen,economy_high_yen,premium_economy_low_yen,premium_economy_high_yen,business_low_yen,business_high_yen,first_low_yen,first_high_yen,notes_ja,confidence) VALUES
('QR','North America',9000,13000,10000,14000,14000,18000,15000,20000,'カタール運航便(ドーハ経由)の自社発券手数料+空港税の推定。JAL等提携便経由だと実際のYQより上乗せされる報告あり。','low'),
('QR','Europe',8000,12000,9000,13000,13000,17000,NULL,NULL,'カタール運航便(ドーハ経由)の推定額。','low'),
('QR','Southeast Asia',6000,9000,7000,10000,11000,15000,NULL,NULL,'カタール運航便(ドーハ経由)の推定額。','low'),
('QR','Northeast Asia',5000,8000,6000,9000,10000,14000,NULL,NULL,'カタール運航便(ドーハ経由)の推定額。JAL国内線区間は実際より高く請求される報告あり。','low'),
('QR','Middle East',5000,7000,6000,8000,9000,13000,10000,14000,'ドーハ自体を含むカタール運航便の推定額。','low');

-- アメリカン航空アドバンテージ(JAL運航便経由。BA/イベリア以外は燃油サーチャージなしが原則。片道・円)
INSERT INTO cash_fees (program_code,to_region,economy_low_yen,economy_high_yen,premium_economy_low_yen,premium_economy_high_yen,business_low_yen,business_high_yen,first_low_yen,first_high_yen,notes_ja,confidence) VALUES
('AA','North America',1000,5000,3800,5000,5000,21000,18000,24000,'JAL運航便をAAマイルで予約する場合、JAL自社発券(片道4.5〜6.5万円)より大幅に安い。BA/イベリア運航便経由の場合は高額な燃油サーチャージが発生するため要注意。','medium');

-- ユナイテッド航空マイレージプラス(ANA運航便経由。燃油サーチャージなしが原則。片道・円)
INSERT INTO cash_fees (program_code,to_region,economy_low_yen,economy_high_yen,premium_economy_low_yen,premium_economy_high_yen,business_low_yen,business_high_yen,first_low_yen,first_high_yen,notes_ja,confidence) VALUES
('UA','North America',3000,10000,3000,10000,22000,27000,NULL,NULL,'ANA運航便をユナイテッドマイルで予約する場合、ANA自社発券(片道5〜5.6万円)より大幅に安い。ビジネスクラスの推定額はやや粗め。','medium');

-- デルタ航空スカイマイル(デルタ運航便・大韓航空運航便とも燃油サーチャージなしが原則。片道・円)
INSERT INTO cash_fees (program_code,to_region,economy_low_yen,economy_high_yen,premium_economy_low_yen,premium_economy_high_yen,business_low_yen,business_high_yen,first_low_yen,first_high_yen,notes_ja,confidence) VALUES
('DL','North America',4000,10000,4000,10000,4000,15000,NULL,NULL,'デルタ運航便は燃油サーチャージなしが原則で空港税等のみ。中国東方航空等の一部提携便運航区間は例外的に発生する場合あり。','medium'),
('DL','Northeast Asia',3500,7500,NULL,NULL,3500,7500,NULL,NULL,'デルタ・大韓航空とも燃油サーチャージなし(日韓路線の実例に基づく)。','medium'),
('DL','Hawaii',3700,10000,NULL,NULL,3700,15000,NULL,NULL,'デルタ運航便は燃油サーチャージなし。羽田-ホノルル実例あり。','medium');

-- キャセイパシフィック航空アジアマイル(2021年に燃油サーチャージ復活。全クラス定額・片道・円、2026年7月時点)
INSERT INTO cash_fees (program_code,to_region,economy_low_yen,economy_high_yen,premium_economy_low_yen,premium_economy_high_yen,business_low_yen,business_high_yen,first_low_yen,first_high_yen,notes_ja,confidence) VALUES
('CX','Northeast Asia',7000,8000,7000,8000,7000,8000,NULL,NULL,'日本-香港/台北間の燃油サーチャージ(全クラス定額)。2026年7月時点。','medium'),
('CX','North America',18500,21500,18500,21500,18500,21500,18500,21500,'香港経由の日本-北米間の燃油サーチャージ合算(日本-香港区間+香港-北米区間、全クラス定額)。2026年7月時点。','medium'),
('CX','Europe',18500,21500,18500,21500,18500,21500,18500,21500,'香港経由の日本-欧州間の燃油サーチャージ合算(全クラス定額)。2026年7月時点。','medium'),
('CX','Southeast Asia',10000,11000,10000,11000,10000,11000,NULL,NULL,'香港経由の日本-東南アジア間の燃油サーチャージ合算(推定、全クラス定額)。','low'),
('CX','South Asia',12000,14000,12000,14000,12000,14000,NULL,NULL,'香港経由の日本-南アジア間の燃油サーチャージ合算(推定、全クラス定額)。','low');
