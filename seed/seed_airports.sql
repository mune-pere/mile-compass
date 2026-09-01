DELETE FROM airports;

-- 日本発着(出発地候補)
INSERT INTO airports (iata,name_ja,city_ja,country_ja,kana,region,lat,lon,is_japan) VALUES
('HND','東京国際空港(羽田)','東京','日本','はねだ 羽田 とうきょう 東京 hnd tokyo haneda',            'Japan',35.5494,139.7798,1),
('NRT','成田国際空港','東京','日本','なりた 成田 とうきょう 東京 narita nrt tokyo',                'Japan',35.7647,140.3864,1),
('KIX','関西国際空港','大阪','日本','かんさい 関西 おおさか 大阪 kansai osaka kix',                'Japan',34.4347,135.2440,1),
('ITM','大阪国際空港(伊丹)','大阪','日本','いたみ 伊丹 おおさか 大阪 itami osaka itm',              'Japan',34.7855,135.4382,1),
('NGO','中部国際空港(セントレア)','名古屋','日本','ちゅうぶ 中部 せんとれあ なごや 名古屋 centrair nagoya ngo', 'Japan',34.8584,136.8054,1),
('FUK','福岡空港','福岡','日本','ふくおか 福岡 fukuoka fuk',                                    'Japan',33.5859,130.4506,1),
('CTS','新千歳空港','札幌','日本','ちとせ 千歳 しんちとせ 新千歳 さっぽろ 札幌 sapporo chitose cts', 'Japan',42.7752,141.6923,1),
('OKA','那覇空港','那覇','日本','なは 那覇 おきなわ 沖縄 naha okinawa oka',                       'Japan',26.1958,127.6459,1),
('MMY','宮古空港','宮古島','日本','みやこじま 宮古島 みやこ 宮古 mmy miyako miyakojima',              'Japan',24.7828,125.2951,1),
('ISG','南ぬ島石垣空港','石垣島','日本','いしがき 石垣 いしがきじま 石垣島 isg ishigaki',                'Japan',24.3964,124.2450,1);

-- 目的地候補
INSERT INTO airports (iata,name_ja,city_ja,country_ja,kana,region,lat,lon,is_japan) VALUES
('LAX','ロサンゼルス国際空港','ロサンゼルス','アメリカ','ろさんぜるす ロサンゼルス la lax los angeles usa アメリカ', 'North America',33.9416,-118.4085,0),
('SFO','サンフランシスコ国際空港','サンフランシスコ','アメリカ','さんふらんしすこ サンフランシスコ sfo san francisco usa アメリカ','North America',37.6213,-122.3790,0),
('SEA','シアトル・タコマ国際空港','シアトル','アメリカ','しあとる シアトル seattle sea usa アメリカ',                 'North America',47.4502,-122.3088,0),
('JFK','ジョン・F・ケネディ国際空港','ニューヨーク','アメリカ','にゅーよーく ニューヨーク nyc jfk new york usa アメリカ',  'North America',40.6413,-73.7781,0),
('ORD','オヘア国際空港','シカゴ','アメリカ','しかご シカゴ chicago ord usa アメリカ',                        'North America',41.9742,-87.9073,0),
('YVR','バンクーバー国際空港','バンクーバー','カナダ','ばんくーばー バンクーバー vancouver yvr canada かなだ',       'North America',49.1967,-123.1815,0),
('HNL','ダニエル・K・イノウエ国際空港','ホノルル','アメリカ','ほのるる ホノルル はわい ハワイ honolulu hawaii hnl',    'Hawaii',21.3187,-157.9224,0),
('BKK','スワンナプーム国際空港','バンコク','タイ','ばんこく バンコク たい タイ bangkok thailand bkk',            'Southeast Asia',13.6900,100.7501,0),
('SIN','チャンギ国際空港','シンガポール','シンガポール','しんがぽーる シンガポール singapore sin',               'Southeast Asia',1.3644,103.9915,0),
('HKG','香港国際空港','香港','香港','ほんこん ホンコン 香港 hongkong hkg',                              'Northeast Asia',22.3080,113.9185,0),
('ICN','仁川国際空港','ソウル','韓国','そうる ソウル いんちょん 仁川 かんこく 韓国 seoul incheon korea icn', 'Northeast Asia',37.4602,126.4407,0),
('TPE','台湾桃園国際空港','台北','台湾','たいぺい タイペイ たいわん 台湾 桃園 taipei taiwan tpe',           'Northeast Asia',25.0777,121.2328,0),
('PVG','上海浦東国際空港','上海','中国','しゃんはい 上海 ぷーとん 浦東 しゃんはい中国 shanghai china pvg',    'Northeast Asia',31.1443,121.8083,0),
('SYD','シドニー国際空港','シドニー','オーストラリア','しどにー シドニー おーすとらりあ オーストラリア sydney australia syd', 'Oceania',-33.9399,151.1753,0),
('LHR','ロンドン・ヒースロー国際空港','ロンドン','イギリス','ろんどん ロンドン いぎりす イギリス london uk lhr', 'Europe',51.4700,-0.4543,0),
('CDG','パリ・シャルル・ド・ゴール国際空港','パリ','フランス','ぱり パリ ふらんす フランス paris france cdg', 'Europe',49.0097,2.5479,0),
('FRA','フランクフルト国際空港','フランクフルト','ドイツ','ふらんくふると フランクフルト どいつ ドイツ frankfurt germany fra', 'Europe',50.0379,8.5622,0),
('AMS','アムステルダム・スキポール空港','アムステルダム','オランダ','あむすてるだむ アムステルダム おらんだ オランダ amsterdam netherlands ams', 'Europe',52.3105,4.7683,0),
('IST','イスタンブール空港','イスタンブール','トルコ','いすたんぶーる イスタンブール とるこ トルコ istanbul turkey ist', 'Europe',41.2753,28.7519,0),
('DXB','ドバイ国際空港','ドバイ','アラブ首長国連邦','どばい ドバイ dubai dxb uae', 'Middle East',25.2532,55.3657,0),
('DOH','ハマド国際空港','ドーハ','カタール','どーは ドーハ かたーる カタール doha qatar doh', 'Middle East',25.2731,51.6081,0),
('DEL','インディラ・ガンディー国際空港','デリー','インド','でりー デリー いんど インド delhi india del', 'South Asia',28.5562,77.1000,0);
