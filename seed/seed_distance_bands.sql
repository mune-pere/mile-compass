DELETE FROM distance_bands;

-- JALマイレージバンク(提携航空会社特典。片道・総距離マイル)
INSERT INTO distance_bands (program_code,max_distance_miles,economy,premium_economy,business,first) VALUES
('JAL',1000,12000,NULL,17500,NULL),
('JAL',2000,15000,20000,25000,NULL),
('JAL',3000,20000,27000,37500,NULL),
('JAL',4500,23000,32000,45000,NULL),
('JAL',6500,27000,40000,55000,110000),
('JAL',8000,33000,46000,65000,125000),
('JAL',999999,38000,52000,75000,140000);

-- ブリティッシュ・エアウェイズ Avios(9ゾーン距離帯、Off-Peak目安)
INSERT INTO distance_bands (program_code,max_distance_miles,economy,premium_economy,business,first) VALUES
('BA',650,4000,NULL,8500,NULL),
('BA',1150,7500,12000,15000,21000),
('BA',2000,9500,15500,19500,27000),
('BA',3000,12500,20500,26000,36000),
('BA',4000,17000,28500,38000,51000),
('BA',5500,20500,34500,46000,62000),
('BA',6000,26000,46500,65000,92750),
('BA',7000,30500,54000,75000,108000),
('BA',999999,35000,62000,85000,130000);

-- 大韓航空SKYPASS(2023年4月〜距離帯制。プレミアムエコノミー区分なし)
INSERT INTO distance_bands (program_code,max_distance_miles,economy,premium_economy,business,first) VALUES
('KE',500,10000,NULL,20000,30000),
('KE',999,12500,NULL,25000,37500),
('KE',1499,15000,NULL,30000,45000),
('KE',1999,17500,NULL,35000,52500),
('KE',2999,22500,NULL,45000,67500),
('KE',3999,27500,NULL,55000,82500),
('KE',4999,32500,NULL,65000,97500),
('KE',6499,40000,NULL,80000,120000),
('KE',9999,45000,NULL,90000,135000),
('KE',999999,60000,NULL,120000,180000);

-- キャセイパシフィック アジアマイル(距離帯制。日本発着は短距離帯でも割高なType2区分に該当)
INSERT INTO distance_bands (program_code,max_distance_miles,economy,premium_economy,business,first) VALUES
('CX',750,6000,NULL,20000,NULL),
('CX',2750,10000,17500,27000,NULL),
('CX',5000,20000,32500,60000,NULL),
('CX',7500,30000,47500,91000,130000),
('CX',999999,37500,60000,119000,160000);

-- カタール航空プリビレッジクラブ(Avios、提携チャート。日本発はドーハ乗継前提のため距離は直行区間の概算)
INSERT INTO distance_bands (program_code,max_distance_miles,economy,premium_economy,business,first) VALUES
('QR',650,6000,NULL,12500,NULL),
('QR',1650,9500,NULL,20000,NULL),
('QR',3000,13000,NULL,27500,NULL),
('QR',4500,18000,NULL,37500,NULL),
('QR',6000,24000,NULL,50000,75000),
('QR',7000,28000,NULL,60000,90000),
('QR',999999,32000,NULL,70000,105000);
