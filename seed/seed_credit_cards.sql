DELETE FROM card_transfer_rates;
DELETE FROM credit_cards;

INSERT INTO credit_cards (code,name_ja,points_name_ja,annual_fee_note_ja,notes_ja) VALUES
('BONVOY','Marriott Bonvoy アメリカン・エキスプレス・カード','Marriott Bonvoyポイント',NULL,
 '3ポイント=1マイルが標準レート。多くの提携航空会社で60,000ポイント単位の移行ごとに+5,000マイルのボーナスが付与される(一部例外あり)。'),
('AMEX_GP','アメリカン・エキスプレス・ゴールド・プリファード・カード','メンバーシップ・リワードポイント',
 'マイル移行には「メンバーシップ・リワード・プラス」登録が必要(ゴールド・プリファード会員は無料・自動付帯)。ANAへの移行のみ別途「メンバーシップ・リワード ANAコース」への年間参加費5,500円(税込)が必要(ゴールド・プリファードでも免除されない)。',
 'カードにより有効期限や移行条件が異なるため、実際の移行前にAmex公式サイトで最新の参加費・レートをご確認ください。');

-- Bonvoy→各マイルプログラムの交換レート(標準3:1、60,000pt移行ごとに+5,000マイルボーナスが基本。UA/AA/DLは例外)
INSERT INTO card_transfer_rates (card_code,program_code,ratio_points_per_mile,bonus_block,bonus_miles,notes_ja,confidence) VALUES
('BONVOY','ANA',3,60000,5000,'標準レート。ANA・JALともBonvoyの正式な移行提携先(想定に反し提携あり)。','high'),
('BONVOY','JAL',3,60000,5000,'標準レート。','high'),
('BONVOY','AS',3,60000,5000,'標準レート。','high'),
('BONVOY','BA',3,60000,5000,'標準レート(Avios)。','high'),
('BONVOY','VS',3,60000,5000,'標準レート。','high'),
('BONVOY','AFKL',3,60000,5000,'標準レート。','high'),
('BONVOY','KE',3,60000,5000,'標準レート。','medium'),
('BONVOY','SQ',3,60000,5000,'標準レート。','high'),
('BONVOY','CX',3,60000,5000,'標準レート。','high'),
('BONVOY','TK',3,60000,5000,'標準レート。','high'),
('BONVOY','AA',3,NULL,NULL,'ボーナス特典なし(数少ない例外プログラムの一つ)。','high'),
('BONVOY','UA',3,60000,10000,'他社より優遇: 60,000pt移行で+10,000マイル(実質約2.4:1相当)。','high'),
('BONVOY','DL',3,NULL,NULL,'ボーナス特典なし(数少ない例外プログラムの一つ)。','high'),
('BONVOY','EY',3,60000,5000,'標準レート。ただしEtihadは日本発着に実用性が低い。','medium'),
('BONVOY','QR',3,60000,5000,'標準レート(Avios)。','high');

-- アメックスGP(メンバーシップ・リワード・プラス)→各マイルプログラムの交換レート(2026年調査時点)
-- AS/KE/TK/UA/AA/EYはアメックスジャパンの提携航空会社リストに含まれないため未投入(検索結果にはAMEX_GP列が表示されません)
INSERT INTO card_transfer_rates (card_code,program_code,ratio_points_per_mile,bonus_block,bonus_miles,notes_ja,confidence) VALUES
('AMEX_GP','ANA',1,NULL,NULL,'スターアライアンス最大の優遇レート(1,000pt=1,000マイル)。ただし移行には別途「メンバーシップ・リワード ANAコース」への年間参加費5,500円(税込)の登録が必要(ゴールド・プリファードでも免除なし)。年間移行上限80,000ポイント(=40,000マイル)。初回移行は2週間以内。','high'),
('AMEX_GP','JAL',2.5,NULL,NULL,'2,500pt=1,000マイル。ANAと異なりJAL専用の追加年会費は不要。年間移行上限なし。','high'),
('AMEX_GP','BA',1.25,NULL,NULL,'1,250pt=1,000 Avios。最低移行単位2,000ポイント。','medium'),
('AMEX_GP','VS',1.25,NULL,NULL,'1,250pt=1,000ポイント相当とみられる(独立系情報源、公式ページでの明示的確証はやや弱い)。','medium'),
('AMEX_GP','AFKL',1.25,NULL,NULL,'1,250pt=1,000マイル。','medium'),
('AMEX_GP','SQ',1.25,NULL,NULL,'1,250pt=1,000マイル。','medium'),
('AMEX_GP','CX',1.25,NULL,NULL,'1,250pt=1,000マイル。最低移行単位2,000ポイント。','medium'),
('AMEX_GP','DL',1.25,NULL,NULL,'1,250pt=1,000マイル。最低移行単位2,000ポイント。','high'),
('AMEX_GP','QR',1.25,NULL,NULL,'1,250pt=1,000 Avios相当とみられる(独立系情報源)。','medium');
