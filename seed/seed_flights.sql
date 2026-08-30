-- 実際の直行便ネットワーク（羽田/関西を中心とした主要路線。簡易版・就航状況は変動するため参考情報）
DELETE FROM flights;

INSERT INTO flights (origin_iata,dest_iata,operating_airline_code,operating_airline_ja,alliance,stops,via_ja,notes_ja) VALUES
('HND','LAX','JL','日本航空(JAL)','oneworld',0,NULL,NULL),
('HND','LAX','NH','全日空(ANA)','star',0,NULL,NULL),
('HND','LAX','UA','ユナイテッド航空','star',0,NULL,NULL),
('HND','LAX','DL','デルタ航空','skyteam',0,NULL,NULL),

('HND','SFO','JL','日本航空(JAL)','oneworld',0,NULL,NULL),
('HND','SFO','NH','全日空(ANA)','star',0,NULL,NULL),
('HND','SFO','UA','ユナイテッド航空','star',0,NULL,NULL),

('HND','SEA','NH','全日空(ANA)','star',0,NULL,NULL),
('HND','SEA','DL','デルタ航空','skyteam',0,NULL,NULL),

('HND','JFK','JL','日本航空(JAL)','oneworld',0,NULL,NULL),
('HND','JFK','NH','全日空(ANA)','star',0,NULL,NULL),
('HND','JFK','DL','デルタ航空','skyteam',0,NULL,NULL),
('HND','JFK','AA','アメリカン航空','oneworld',0,NULL,NULL),

('HND','ORD','NH','全日空(ANA)','star',0,NULL,NULL),
('HND','ORD','UA','ユナイテッド航空','star',0,NULL,NULL),

('HND','YVR','NH','全日空(ANA)','star',0,NULL,NULL),
('HND','YVR','AC','エア・カナダ','star',0,NULL,NULL),

('HND','HNL','JL','日本航空(JAL)','oneworld',0,NULL,NULL),
('HND','HNL','NH','全日空(ANA)','star',0,NULL,NULL),
('HND','HNL','HA','ハワイアン航空','none',0,NULL,'ハワイアン航空は現在特定アライアンス非加盟'),
('HND','HNL','DL','デルタ航空','skyteam',0,NULL,NULL),

('HND','BKK','JL','日本航空(JAL)','oneworld',0,NULL,NULL),
('HND','BKK','NH','全日空(ANA)','star',0,NULL,NULL),
('HND','BKK','TG','タイ国際航空','star',0,NULL,NULL),

('HND','SIN','JL','日本航空(JAL)','oneworld',0,NULL,NULL),
('HND','SIN','NH','全日空(ANA)','star',0,NULL,NULL),
('HND','SIN','SQ','シンガポール航空','star',0,NULL,NULL),

('HND','HKG','JL','日本航空(JAL)','oneworld',0,NULL,NULL),
('HND','HKG','NH','全日空(ANA)','star',0,NULL,NULL),
('HND','HKG','CX','キャセイパシフィック航空','oneworld',0,NULL,NULL),

('HND','ICN','JL','日本航空(JAL)','oneworld',0,NULL,NULL),
('HND','ICN','NH','全日空(ANA)','star',0,NULL,NULL),
('HND','ICN','KE','大韓航空','skyteam',0,NULL,NULL),
('HND','ICN','OZ','アシアナ航空','star',0,NULL,NULL),

('HND','TPE','JL','日本航空(JAL)','oneworld',0,NULL,NULL),
('HND','TPE','NH','全日空(ANA)','star',0,NULL,NULL),
('HND','TPE','CI','チャイナエアライン','skyteam',0,NULL,NULL),
('HND','TPE','BR','エバー航空','star',0,NULL,NULL),

('HND','PVG','JL','日本航空(JAL)','oneworld',0,NULL,NULL),
('HND','PVG','NH','全日空(ANA)','star',0,NULL,NULL),
('HND','PVG','MU','中国東方航空','skyteam',0,NULL,NULL),

('HND','SYD','JL','日本航空(JAL)','oneworld',0,NULL,NULL),
('HND','SYD','NH','全日空(ANA)','star',0,NULL,NULL),
('HND','SYD','QF','カンタス航空','oneworld',0,NULL,NULL),

('HND','LHR','JL','日本航空(JAL)','oneworld',0,NULL,NULL),
('HND','LHR','NH','全日空(ANA)','star',0,NULL,NULL),
('HND','LHR','BA','ブリティッシュ・エアウェイズ','oneworld',0,NULL,NULL),

('HND','CDG','JL','日本航空(JAL)','oneworld',0,NULL,NULL),
('HND','CDG','NH','全日空(ANA)','star',0,NULL,NULL),
('HND','CDG','AF','エールフランス航空','skyteam',0,NULL,NULL),

('HND','FRA','NH','全日空(ANA)','star',0,NULL,NULL),
('HND','FRA','LH','ルフトハンザドイツ航空','star',0,NULL,NULL),

('HND','AMS','NH','全日空(ANA)','star',0,NULL,NULL),
('HND','AMS','KL','KLMオランダ航空','skyteam',0,NULL,NULL),

('HND','IST','TK','ターキッシュ エアラインズ','star',0,NULL,NULL),

('HND','DXB','EK','エミレーツ航空','none',0,NULL,'エミレーツ航空は主要アライアンス非加盟のため提携マイルでの直行予約は限定的'),
('HND','DOH','QR','カタール航空','oneworld',0,NULL,NULL),

('HND','DEL','NH','全日空(ANA)','star',0,NULL,NULL),
('HND','DEL','AI','エア・インディア','star',0,NULL,NULL),

-- 関西発の一部路線
('KIX','ICN','OZ','アシアナ航空','star',0,NULL,NULL),
('KIX','ICN','KE','大韓航空','skyteam',0,NULL,NULL),
('KIX','TPE','CI','チャイナエアライン','skyteam',0,NULL,NULL),
('KIX','TPE','BR','エバー航空','star',0,NULL,NULL),
('KIX','HKG','CX','キャセイパシフィック航空','oneworld',0,NULL,NULL),
('KIX','BKK','TG','タイ国際航空','star',0,NULL,NULL),

-- 主要な経由便の例（直行がない/少ない組み合わせの代表例）
('HND','CDG','BA','ブリティッシュ・エアウェイズ','oneworld',1,'ロンドン(LHR)','JAL/AF以外のoneworld提携での代表的な経由例'),
('HND','DXB','QR','カタール航空','oneworld',1,'ドーハ(DOH)','ドバイへの提携マイル利用時の代表的な経由例');
