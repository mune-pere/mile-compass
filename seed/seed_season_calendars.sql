DELETE FROM season_calendars;

-- ANA国際線特典のロー/レギュラー/ハイシーズン カレンダー(月日、年をまたいで毎年繰り返す)
-- 出典: upgradedpoints.com / awardwallet.com (2件の独立情報源で一致、北米・欧州長距離路線基準)
INSERT INTO season_calendars (program_code,season,start_month,start_day,end_month,end_day,note_ja) VALUES
('ANA','low',1,6,2,28,'1月中旬〜2月末（正月明け〜春休み前）'),
('ANA','low',4,1,4,28,'4月上旬（春休み後、ゴールデンウィーク前）'),

('ANA','regular',1,4,1,5,'正月直前の数日'),
('ANA','regular',3,1,3,31,'3月（春休み・年度末）'),
('ANA','regular',5,10,7,15,'ゴールデンウィーク後〜夏休み前'),
('ANA','regular',8,24,12,18,'夏休み後〜年末年始前'),

('ANA','high',1,1,1,3,'正月三が日'),
('ANA','high',4,29,5,9,'ゴールデンウィーク'),
('ANA','high',7,16,8,23,'夏休み（お盆を含む）'),
('ANA','high',12,19,12,31,'年末（クリスマス〜大晦日）');
