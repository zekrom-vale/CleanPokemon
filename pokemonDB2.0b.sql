create table ITEMS(
NAME varchar2(50) primary key, --Name of the item
GEN number(2,0) references GENERATION(GEN) check(gen>0), --Generation of first implimintaation
GEN2 number(2,0) references GENERATION(GEN) check(gen2>0), --Last generation implemented, null if still exists
DESCRIPTION clob, --An explination of what the item is
NOTE clob, --Syntax notes
JAPANESE_KANA nvarchar2(200), --The item's name in JAPANESE_KANA
JAPANESE_ROMAJI nvarchar2(200), --The item's name in JAPANESE_ROMAJI
FRENCH nvarchar2(200), --The item's name in FRENCH
GERMAN nvarchar2(200), --The item's name in GERMAN
ITALIAN nvarchar2(200), --The item's name in ITALIAN
SPANISH nvarchar2(200), --The item's name in SPANISH
KOREAN_HANGUL nvarchar2(200), --The item's name in KOREAN_HANGUL
KOREAN_ROMANIZED nvarchar2(200), --The item's name in KOREAN_ROMANIZED
CHINESE_HANZI nvarchar2(200), --The item's name in CHINESE_HANZI
CHINESE_ROMANIZED nvarchar2(200), --The item's name in CHINESE_ROMANIZED
STAR number(8,0) check(star>=0) --A binary mask indicating what had an astrict
);

create table itemIDs(
ID number(5,0) not null check(id>=0), --The ingame numeric identifyer
HEX varchar2(10), --The hexadesimal value of the ID
NAME nvarchar2(100), --The name of the item
POKCET varchar2(50), --The location of the item, in the bag
GAME varchar2(200), --The game the item is limited to, null if not
GEN number(2,0) references GENERATION(GEN) check(gen>0), --The generation the ID and item corisponds to
CONSTRAINT un_ID unique(ID, GEN, GAME), --Ensure no duplicates per GEN and GAME, by ID
CONSTRAINT un_ID_NAME unique(NAME, GEN, GAME) --Ensure no duplicates per GEN and GAME, by NAME
);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Blu ID Badge|', 3, q'|One of four keys needed to unlock the north door of Realgam Tower.|', nq'|ＩＤバッジあお|', nq'|ID Badge Ao|', nq'|Passe Bleu|', nq'|Blaue ID-Marke|', nq'|Pass Blu|', nq'|Pase Azul|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Miracle Seed|', 2, q'|Raises the power of Grass-type moves.|', nq'|きせきのタネ|', nq'|Kiseki no Tane|', nq'|Grain Miracle|', nq'|Wundersaat|', nq'|Miracolseme|', nq'|Semilla Milagro|', nq'|기적의씨|', nq'|Gijeogui Ssi|', nq'|奇跡種子 / 奇迹种子|', nq'|Qíjī Zhǒngzǐ / Kèihjīk Júngjí|', 128);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Audinite|', 6, q'|Allows Audino to Mega Evolve into Mega Audino.|', nq'|タブンネナイト|', nq'|Tabunnenite|', nq'|Nanméouïte|', nq'|Ohrdochnit|', nq'|Audinite|', nq'|Audinita|', nq'|다부니나이트|', nq'|Dabunienite|', nq'|差不多娃娃進化石 / 差不多娃娃进化石|', nq'|Chàbùduōwáwá Jìnhuà Shí / Chābātdōwāwā Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Purple Petal|', 7, q'|A purple petal required to complete Mina's Trial.|', nq'|むらさきはなびら|', nq'|Murasaki Hanabira|', nq'|Pétale Violet|', nq'|Violettes Blatt|', nq'|Petalo violetto|', nq'|Pétalo Violeta|', nq'|보라꽃잎|', nq'|Bora Kkochip|', nq'|紫色花瓣|', nq'|Zǐ-sè Huābàn / Jí-sīk Fāfáan|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Mech Mail|', 3, q'|Mail with a mechanical pattern. To be held by a Pokémon for delivery.|', nq'|メカニカルメール|', nq'|Mechanical Mail|', nq'|Lettre Meca|', nq'|Eilbrief|', nq'|Mess. Tecno|', nq'|Carta Imán|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Silver Wing|', 2, q'|Summons Lugia.|', nq'|ぎんいろのはね|', nq'|Gin'iro no Hane|', nq'|Argent'Aile|', nq'|Silberflügel|', nq'|Aladargento|', nq'|Ala Plateada|', nq'|은빛날개|', nq'|Eunbit Nalgae|', nq'|銀色之羽 / 银色之羽|', nq'|Yín-sè-zhī Yǔ / Ngàhn-sīk-jī Yúh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Meadow Plate|', 4, q'|Raises the power of Grass-type moves.|', nq'|みどりのプレート|', nq'|Midori no Purēto|', nq'|Plaque Herbe|', nq'|Wiesentafel|', nq'|Lastraprato|', nq'|Tabla Pradal|', nq'|초록플레이트|', nq'|Chorok Plate|', nq'|碧綠石板 / 碧绿石板|', nq'|Bìlǜ Shíbǎn / Bīkluhk Sehkbáan|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Belue Berry|', 3, q'|Poffin and Pokéblock ingredient.|', nq'|ベリブのみ|', nq'|Beribu no Mi|', nq'|Baie Myrte|', nq'|Myrtilbeere|', nq'|Baccartillo|', nq'|Baya Andano|', nq'|루베열매|', nq'|Luebe Yeolmae|', nq'|靛莓果|', nq'|Diànméi Guǒ / Dihnmùih Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Medichamite|', 6, q'|Allows Medicham to Mega Evolve into Mega Medicham.|', nq'|チャーレムナイト|', nq'|Charemnite|', nq'|Charminite|', nq'|Meditalisnit|', nq'|Medichamite|', nq'|Medichamita|', nq'|요가램나이트|', nq'|Yogaramnite|', nq'|恰雷姆進化石 / 恰雷姆进化石|', nq'|Qiàléimǔ Jìnhuà Shí / Hāplèuihmóuh Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Grubby Hanky|', 5, q'|Can be exchanged for a Fluffy Tail at Café Warehouse.|', nq'|よごれたハンカチ|', nq'|Dirty Handkerchief|', nq'|MouchoirSale|', nq'|Schnäuztuch|', nq'|Pezza Sporca|', nq'|Pan. Sucio|', nq'|더러손수건|', nq'|Deoreo Sonsugeon|', nq'|髒手帕 / 脏手帕|', nq'|Zāng Shǒupà / Jōng Sáupaak|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Rock Incense|', 4, q'|Raises the power of Rock-type moves. A Sudowoodo holding this can breed to produce Bonsly Eggs.|', nq'|がんせきおこう|', nq'|Ganseki Okō|', nq'|Encens Roc|', nq'|Steinrauch|', nq'|Roccioaroma|', nq'|Incienso roca|', nq'|암석향로|', nq'|Amseog Hyangno|', nq'|岩石薰香|', nq'|Yánshí Xūnxiāng / Ngàahmsehk Fānhēung|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Red ID Badge|', 3, q'|One of four keys needed to open the front door of Realgam Tower.|', nq'|ＩＤバッジあか|', nq'|ID Badge Aka|', nq'|Passe Rouge|', nq'|Rote ID-Marke|', nq'|Pass Rosso|', nq'|Pase Rojo|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Solganium Z|', 7, q'|Allows Solgaleo and Dusk Mane Necrozma to upgrade Sunsteel Strike to the special Z-Move Searing Sunraze Smash.|', nq'|ソルガレオＺ|', nq'|Solgaleo-Z|', nq'|Solgazélite|', nq'|Solgalium Z|', nq'|Solgaleium Z|', nq'|Solgaleostal Z|', nq'|솔가레오Z|', nq'|Solgaleo-Z|', nq'|索爾迦雷歐Ｚ / 索尔迦雷欧Ｚ|', nq'|Suǒ'ěrjiāléiōu-Z / Sokyíhgālèuihāu-Z|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Max Repel|', 1, q'|Prevents wild Pokémon with a lower level than the first member of the party from appearing for 250 steps|', nq'|ゴールドスプレー|', nq'|Gold Spray|', nq'|Max Repousse|', nq'|Top-Schutz|', nq'|Repellente Max|', nq'|Repelente Maximo|', nq'|골드스프레이|', nq'|Gold Spray|', nq'|黃金噴霧 / 黄金喷雾|', nq'|Huángjīn Pēnwù / Wòhnggām Panmouh|', 48);
insert into ITEMS(NAME, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(q'|HM|', nq'|ひでんマシン|', nq'|Hiden Machine|', nq'|CS|', nq'|VM|', nq'|MN|', nq'|MO|', nq'|비전머신|', nq'|Bijeon Machine|', nq'|秘傳學習器 / 秘传学习器|', nq'|Mìchuán Xuéxíqì / Beichyùhn Hohkjaahphei|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Scope Lens|', 3, q'|Raises chances of getting a critical hit.|', nq'|ピントレンズ|', nq'|Pint Lens|', nq'|Lentilscope|', nq'|Scope-Linse|', nq'|Mirino|', nq'|Periscopio|', nq'|초점렌즈|', nq'|Chojeom Lens|', nq'|焦點鏡 / 焦点镜|', nq'|Jiāodiǎn Jìng / Jīudím Geng|', 0);
insert into ITEMS(NAME, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(q'|Roto Encounter|', nq'|みっけポン|', nq'|Mikke Pon|', nq'|Moti-Appât|', nq'|Lockbon|', nq'|Incontra'n'roll|', nq'|Cupón Reclamo|', nq'| ???|', nq'| ???|', nq'|相遇碰碰|', nq'|Xiāngyù Pèngpèng / Sēungyuh Pungpung|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Star Piece|', 2, q'|Can be sold for 4900.|', nq'|ほしのかけら|', nq'|Hoshi no Kakera|', nq'|Morceau d'Étoile|', nq'|Sternenstück|', nq'|Pezzo Stella|', nq'|Trozo Estrella|', nq'|별의조각|', nq'|Byeorui Jogak|', nq'|星星碎片|', nq'|Xīngxīng Suìpiàn / Sīngsīng Seuipín|', 144);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Explorer Kit|', 4, q'|A Key Item which can be used to go to Sinnoh Underground.|', nq'|たんけんセット|', nq'|Tanken Set|', nq'|Explorakit|', nq'|Forschersack|', nq'|Esplorokit|', nq'|Kit Explor.|', nq'|탐험세트|', nq'|Tamheom Set|', nq'|探險組合*|'||chr(10)||nq'|探险套装|', nq'|Tànxiǎn Zǔhé / Taamhím Jóuhahp*|'||chr(10)||nq'|Tànxiǎn Tàozhuāng|', 3);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Eviolite|', 5, q'|Raises the holder's Defense and Special Defense by 50% if the holder is capable of evolving.|', nq'|しんかのきせき|', nq'|Shinka no Kiseki|', nq'|Évoluroc|', nq'|Evolith|', nq'|Evolcondensa|', nq'|Mineral Evol|', nq'|진화의 휘석|', nq'|Jinhwa-yi Hwiseok|', nq'|進化奇石 / 进化奇石|', nq'|Jìnhuà Qíshí / Jeunfa Kèihsehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Ghost Gem|', 5, q'|Increases the power of the holder's first Ghost-type move by 50%, and is consumed after use.|', nq'|ゴーストジュエル|', nq'|Ghost Jewel|', nq'|Joyau Spectre|', nq'|Geisterjuwel|', nq'|Bijouspettro|', nq'|Gema Fantasma|', nq'|고스트주얼|', nq'|Ghost Jewel|', nq'|幽靈寶石 / 幽灵宝石|', nq'|Yōulíng Bǎoshí / Yāulìhng Bóusehk|', 208);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Fairy Memory|', 7, q'|Makes Silvally a Fairy-type Pokémon and makes Multi-Attack a Fairy-type move.|', nq'|フェアリーメモリ|', nq'|Fairy Memory|', nq'|ROM Fée|', nq'|Feen-Disc|', nq'|ROM Folletto|', nq'|Disco Hada|', nq'|페어리메모리|', nq'|Fairy Memory|', nq'|妖精記憶碟*|'||chr(10)||nq'|妖精存储碟|', nq'|Yāojing Jìyìdié / Yíujīng Geiyīkdihp*|'||chr(10)||nq'|Yāojīng Cúnchǔdié|', 3);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Berry Pots|', 4, q'|Allows Berry growth while traveling.|', nq'|きのみプランター|', nq'|Kinomi Planter|', nq'|Plante Baies|', nq'|Pflanzset|', nq'|Piantabacche|', nq'|Plantabayas|', nq'|나무열매플랜터|', nq'|Namu Yeolmae Planter|', nq'|樹果種植盆 / 树果种植盆|', nq'|Shùguǒ Zhòngzhí Pén / Syuhgwó Júngjihk Pùhn|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Ride Pager|', 7, q'|By entering certain numbers on this pager, you can summon Ride Pokémon in an instant.|', nq'|ライドギア|', nq'|Ride Gear|', nq'|Appel-Monture|', nq'|PokéMobil-Funk|', nq'|Chiamapassaggio|', nq'|Buscamontura|', nq'|라이드기어|', nq'|Ride Gear|', nq'|騎行裝置 / 骑行装置|', nq'|Qíxíng Zhuāngzhì / Kèihhàahng Jōngji|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Berry|', 2, q'|Restores 10 HP. A Pokémon can use it automatically if it is holding it.|', nq'|きのみ|', nq'|Kino Mi|', nq'|Baie|', nq'|Beere|', nq'|Bacca|', nq'|Baya|', nq'|나무열매|', nq'|Namu Yeolmae|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Binding Band|', 5, q'|Increases the end of turn damage of partially trapping moves from 1/16 to ⅛ of the target's maximum HP.|', nq'|しめつけバンド|', nq'|Shimetsuke Band|', nq'|Bande Étreinte|', nq'|Klammerband|', nq'|Legafascia|', nq'|Banda Atadura|', nq'|조임밴드|', nq'|Joim Band|', nq'|緊綁束帶 / 紧绑束带|', nq'|Jǐnbǎng Shùdài / Gánbóng Chūkdáai|', 144);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Zoom Lens|', 4, q'|A held item that boosts the critical hit ratio if the holder moves after the foe.|', nq'|フォーカスレンズ|', nq'|Focus Lens|', nq'|Lentille Zoom|', nq'|Zoomlinse|', nq'|Zoomlente|', nq'|Telescopio|', nq'|포커스렌즈|', nq'|Focus Lens|', nq'|對焦鏡 / 对焦镜|', nq'|Duìjiāo Jìng / Deuijīu Geng|', 128);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Contest Costume|', 6, q'|Worn during Pokémon Contest Spectacular performances.|', nq'|ライブスーツ|'||chr(10)||nq'|ライブドレス|', nq'|Live Suit|'||chr(10)||nq'|Live Dress|', nq'|Costume Live|'||chr(10)||nq'|Robe Live|', nq'|Live-Anzug|'||chr(10)||nq'|Live-Kleid|', nq'|Costume Live|'||chr(10)||nq'|Vestito Live|', nq'|Traje de Gala|'||chr(10)||nq'|Vestido de Gala|', nq'|라이브슈트|'||chr(10)||nq'|라이브드레스|', nq'|Live Suit|'||chr(10)||nq'|Live Dress|', nq'|演出禮服 / 演出礼服|'||chr(10)||nq'|演出禮裙 / 演出礼裙|', nq'|Yǎnchū Lǐfú / Yínchēut Láihfuhk|'||chr(10)||nq'|Yǎnchū Lǐqún / Yínchēut Láihkwàhn|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Focus Band|', 2, q'|May leave the holder with 1 HP when a move would normally cause them to faint.|', nq'|きあいのハチマキ|', nq'|Kiai no Hachimaki|', nq'|Bandeau|', nq'|Fokus-Band|', nq'|Bandana|', nq'|Cinta Focus|', nq'|기합의머리띠|', nq'|Gihabui Meoritti|', nq'|氣勢頭帶 / 气势头带|', nq'|Qìshì Tóudài / Heisai Tàuhdaai|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|X Sp. Def 2|', 5, q'|Sharply raises a Pokémon's Special Defense. Wonder Launcher only.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Insect Plate|', 4, q'|Raises the power of Bug-type moves.|', nq'|たまむしプレート|', nq'|Tamamushi Purēto|', nq'|Plaquinsect|', nq'|Käfertafel|', nq'|Lastrabaco|', nq'|Tabla Bicho|', nq'|비단벌레플레이트|', nq'|Bidanbeolle Plate|', nq'|玉蟲石板 / 玉虫石板|', nq'|Yùchóng Shíbǎn / Yuhkchùhng Sehkbáan|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|F-Disk|', 3, q'|Moves the UFO in The Under to the Under Colosseum.|', nq'|Ｆ－ディスク|', nq'|F-Disk|', nq'|Disque-A|', nq'|V-Disc|', nq'|Disco Avanti|', nq'|Disco A|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|Kuo Berry|', 3, q'|Cures Burn status. If transferred to Generation IV via Pal Park, it will turn into an Enigma Berry.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Intriguing Stone|', 6, q'|Can be exchanged for a Sun StoneXY/PidgeotiteORAS.|', nq'|すごそうないし|', nq'|Sugosōna Ishi|', nq'|Pierre Insolite|', nq'|Kurioser Stein|', nq'|Sasso suggestivo|', nq'|Piedra Insólita|', nq'|대단할듯한돌|', nq'|Daedanhaldeushan Dol|', nq'|似珍石|', nq'|Sì Zhēnshí / Chíh Jānsehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Item Urge|', 5, q'|Causes an ally to use its held item. Wonder Launcher only.|', nq'|アイテムコール|', nq'|Item Call|', nq'|Appel Objet|', nq'|Itemappell|', nq'|Chiamoggetto|', nq'|Activaobjeto|', nq'|아이템콜|', nq'|Item Call|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Pink Apricorn|', 2, q'|Kurt will make a Love Ball out of it.|', q'|Formatted as Pnk Apricorn prior to Generation VI.|', nq'|ももぼんぐり|', nq'|Momo Bonguri|', nq'|Noigrume Ros|', nq'|Aprikoko Pnk|', nq'|Ghicocca Rosa|', nq'|Bonguri Rosa|', nq'|담홍규토리|', nq'|Damhong Gyutori|', nq'|粉球果|', nq'|Fěn Qiúguǒ / Fán Kàuhgwó|', 1072);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Gardevoirite|', 6, q'|Allows Gardevoir to Mega Evolve into Mega Gardevoir.|', nq'|サーナイトナイト|', nq'|Sirknightnite|', nq'|Gardevoirite|', nq'|Guardevoirnit|', nq'|Gardevoirite|', nq'|Gardevoirita|', nq'|가디안나이트|', nq'|Gadiannite|', nq'|沙奈朵進化石 / 沙奈朵进化石|', nq'|Shānàiduǒ Jìnhuà Shí / Sānoihdó Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Charti Berry|', 4, q'|Reduces damage from a super effective Rock-type move by 50%.|', nq'|ヨロギのみ|', nq'|Yorogi no Mi|', nq'|Baie Charti|', nq'|Chiaribeere|', nq'|Baccaciofo|', nq'|Baya Alcho|', nq'|루미열매|', nq'|Rumi Yeolmae|', nq'|草蠶果 / 草蚕果|', nq'|Cǎocán Guǒ / Chóuchàahm Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|PP Max|', 3, q'|Raises the PP of a move to the maximum.|', nq'|ポイントマックス|', nq'|Point Max|', nq'|PP Max|', nq'|AP-Top|', nq'|PP-Max|', nq'|PP Máximos|', nq'|포인트 맥스|', nq'|Point Max|', nq'|ＰＰ極限提升劑 / ＰＰ极限提升剂|', nq'|PP Jíxiàn Tíshēngjì / PP Gihkhaahn Tàihsīngjaih|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Mago Berry|', 3, q'|When HP falls below 25%, restores 50% HP, but confuses Pokémon that dislike spicy food (12.5% when below 50% before Gen. VII).|', nq'|マゴのみ|', nq'|Mago no Mi|', nq'|Baie Mago|', nq'|Magobeere|', nq'|Baccamango|', nq'|Baya Ango|', nq'|마고열매|', nq'|Mago Yeolmae|', nq'|芒芒果|', nq'|Mángmáng Guǒ / Mòhngmòhng Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Soot Sack|', 3, q'|Allows player to gather soot from Mt. Chimney and exchange for Flutes.|', nq'|はいぶくろ|', nq'|Hai Bukuro|', nq'|Sac à Suie|', nq'|Aschetasche|', nq'|Sacco Cenere|', nq'|Saco hollín|', nq'|검댕자루|', nq'|Geomdaeng Jaru|', nq'|集灰袋|', nq'|Jíhuī Dài / Jaahpfūi Doih|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Paralyze Heal|', 1, q'|Heals paralysis.|', q'|Called Parlyz Heal prior to Generation VI.|', nq'|まひなおし|', nq'|Mahi Naoshi|', nq'|Anti-Para|', nq'|Para-Heiler|', nq'|Antiparalisi|', nq'|Antiparalizador|', nq'|마비치료제|', nq'|Mabi Chiryoje|', nq'|解麻藥 / 解麻药|', nq'|Jiěmáyào / Gáaimàhyeuhk|', 16);
insert into ITEMS(NAME, GEN, GEN2, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Coin Case|', 1, 4, q'|A Key Item that stores the coins collected at the local Game Corner.|', nq'|コインケース|', nq'|Coin Case|', nq'|Boite Jetons|', nq'|Münzkorb|', nq'|Salvadanaio|', nq'|Monedero|', nq'|동전케이스|', nq'|Dongjeon Case|', nq'|代幣盒 / 代币盒|', nq'|Dàibì Hé / Doihbaih Hahp|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Swift Wing|', 5, q'|Raises the Speed of a Pokémon.|', nq'|しゅんぱつのハネ|', nq'|Shunpatsu no Hane|', nq'|Aile Sprint|', nq'|Flinkfeder|', nq'|Piumreazione|', nq'|Pluma Ímpetu|', nq'|순발력날개|', nq'|Sunballyeok Nalgae|', nq'|瞬發之羽 / 瞬发之羽|', nq'|Shùnfā-zhī Yǔ / Seunfaat-jī Yúh|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Colress Machine|', 5, q'|A special device that wrings out the potential of Pokémon. It is an imperfect prototype.|', q'|Formatted as Colress MCHN prior to Generation VI.|', nq'|アクロママシーン|', nq'|Achroma Machine|', nq'|Nikodule|', nq'|Achromat|', nq'|Acrocongegno|', nq'|Acromáquina|', nq'|아크로마머신|', nq'|Achroma Machine|', nq'|阿克羅瑪機器 / 阿克罗玛机器|', nq'|Ākèluómǎ Jīqì / Ahāklòhmáh Gēihei|', 1024);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Power Lens|', 4, q'|Promotes Special Attack EVs, but lowers Speed in battle.|', nq'|パワーレンズ|', nq'|Power Lens|', nq'|Lentille Pouvoir|', nq'|Machtlinse|', nq'|Vigorlente|', nq'|Lente Recia|', nq'|파워렌즈|', nq'|Power Lens|', nq'|力量鏡 / 力量镜|', nq'|Lìliàng Jìng / Lihkleuhng Geng|', 128);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|X Attack|', 1, q'|Raises a Pokémon's Attack by 2 stages (1 stage before Gen. VII).|', nq'|プラスパワー|', nq'|Plus Power|', nq'|Attaque +|', nq'|X-Angriff|', nq'|Attacco X|', nq'|Ataque X|', nq'|플러스파워|', nq'|Plus Power|', nq'|力量強化 / 力量强化|', nq'|Lìliàng Qiánghuà / Lihkleuhng Kèuhngfa|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Beedrillite|', 6, q'|Allows Beedrill to Mega Evolve into Mega Beedrill.|', nq'|スピアナイト|', nq'|Speanite|', nq'|Dardargnite|', nq'|Bibornit|', nq'|Beedrillite|', nq'|Beedrillita|', nq'|독침붕나이트|', nq'|Tokchimbungnite|', nq'|大針蜂進化石 / 大针蜂进化石|', nq'|Dàzhēnfēng Jìnhuà Shí / Daaihjāmfūng Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|Dire Hit 2|', 5, q'|Raises critical hit ratio by 2 levels in battle. Wonder Launcher only.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Amaze Mulch|', 6, q'|Combines the effects of Boost Mulch, Rich Mulch, and Surprise Mulch: Causes an applied Berry patch's soil to dry quicker, increases final Berry harvest by 2 Berries, and makes Berry mutations more likely.|', nq'|とんでもこやし|', nq'|Tondemo Koyashi|', nq'|Fertiprodige|', nq'|Ultramulch|', nq'|Fertilprodigio|', nq'|Abono Insólito|', nq'|기절초풍비료|', nq'|Gijeolchopung Biryo|', nq'|超效肥|', nq'|Chāoxiào Féi / Chīuhaauh Fèih|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Vs. Recorder|', 4, q'|Used to record and replay battles.|', nq'|バトルレコーダー|', nq'|Battle Recorder|', nq'|Magnéto VS|', nq'|Kampfkamera|', nq'|Registradati|', nq'|Cámara Lucha|', nq'|배틀레코더|', nq'|Battle Recorder|', nq'|對戰記錄器 / 对战记录器|', nq'|Duìzhàn Jìlù Qì / Deuijin Geiluhk Hei|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Ampharosite|', 6, q'|Allows Ampharos to Mega Evolve into Mega Ampharos.|', nq'|デンリュウナイト|', nq'|Denryunite|', nq'|Pharampite|', nq'|Ampharosnit|', nq'|Ampharosite|', nq'|Ampharosita|', nq'|전룡나이트|', nq'|Jeonryongnite|', nq'|電龍進化石 / 电龙进化石|', nq'|Diànlóng Jìnhuà Shí / Dihnlùhng Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Thick Club|', 3, q'|Doubles Cubone and Marowak's Attack.|', nq'|ふといホネ|', nq'|Futoi Hone|', nq'|Masse Os|', nq'|Kampfknochen|', nq'|Ossospesso|', nq'|Hueso Grueso|', nq'|굵은뼈|', nq'|Gulgeun Ppyeo|', nq'|粗骨頭 / 粗骨头|', nq'|Cū Gǔtou / Chōu Gwāttàuh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Poké Ball|', 1, q'|A ball used to catch Pokémon.|', nq'|モンスターボール|', nq'|Monster Ball|', nq'|Poké Ball|', nq'|Pokéball|', nq'|Poké Ball|', nq'|Poké Ball|', nq'|몬스터볼|', nq'|Monster Ball|', nq'|精靈球 / 精灵球|', nq'|Jīnglíng Qiú / Jīnglìhng Kàuh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Excite Scent|', 3, q'|Reduces heart gauge, increases friendship.|', nq'|ワクワクのかおり|', nq'|Wakuwaku no Kaori|', nq'|P. Tonifiant|', nq'|Glücks-E.|', nq'|Olio di Rosa|', nq'|Ar. Emoción|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|Drash Berry|', 3, q'|Cures Poison status. Will turn into an Enigma Berry if transferred to Generation IV via Pal Park.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Misty Seed|', 7, q'|A one-time use item that raises the holder's Sp. Defense by one stage upon activation of Misty Terrain.|', nq'|ミストシード|', nq'|Mist Seed|', nq'|Graine Brume|', nq'|Nebel-Samen|', nq'|Nebbiaseme|', nq'|Semilla Bruma|', nq'|미스트시드|', nq'|Mist Seed|', nq'|薄霧種子 / 薄雾种子|', nq'|Bówù Zhǒngzi / Báowù Zhǒngzi / Bohkmouh Júngjí|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Lucky Punch|', 3, q'|Raises Chansey's critical hit rate.|', nq'|ラッキーパンチ|', nq'|Lucky Punch|', nq'|Poing Chance|', nq'|Lucky Punch|', nq'|Fortunpugno|', nq'|Puño Suerte|', nq'|럭키펀치|', nq'|Lucky Punch|', nq'|吉利拳|', nq'|Jílì Quán / Gātleih Kyùhn|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Power Bracer|', 4, q'|Promotes Attack EVs, but lowers Speed in battle.|', nq'|パワーリスト|', nq'|Power Wrist|', nq'|Poignée Pouvoir|', nq'|Machtreif|', nq'|Vigorcerchio|', nq'|Brazal Recio|', nq'|파워리스트|', nq'|Power Wrist|', nq'|力量護腕 / 力量护腕|', nq'|Lìliàng Hùwàn / Lihkleuhng Wuhwún|', 128);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Eon Mail|', 2, q'|Eevee-printed mail. To be held by a Pokémon for delivery.|', nq'|ブイブイメール|', nq'|Vui-Vui Mail|', nq'|Lettre Evoli|', nq'|Anara-Brief|', nq'|Mess. Eon|', nq'|Carta Eón|', nq'|브이브이메일|', nq'|Beuibeui Mail|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Card Key|', 3, q'|Allows the player to access the east wing of the Shadow PKMN Lab.|', nq'|カードキー|', nq'|Card Key|', nq'|Carte Magn.|'||chr(10)||nq'|Cle Magnetique|', nq'|Türöffner|'||chr(10)||nq'|Schlüsselkarte|', nq'|Apriporta|', nq'|Llave Magnética|'||chr(10)||nq'|T. Magnética|', nq'|카드키|', nq'|Card Key|', nq'|鑰匙卡 / 钥匙卡|', nq'|Yàoshi Kǎ / Yeuhksìh Kāat|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Electrium Z|', 7, q'|Allows a Pokémon to upgrade their Electric-type damaging moves to the Z-Move Gigavolt Havoc or upgrade their Electric-type status moves into Z-Moves. Makes Arceus an Electric-type Pokémon.|', nq'|デンキＺ|', nq'|Electric-Z|', nq'|Voltazélite|', nq'|Voltium Z|', nq'|Electrium Z|', nq'|Electrostal Z|', nq'|전기Z|', nq'|Jeon-gi-Z|', nq'|電Ｚ / 电Ｚ|', nq'|Diàn-Z / Dihn-Z|', 0);
insert into ITEMS(NAME, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(q'|Roto HP Restore|', nq'|ＨＰかいふくポン|', nq'|HP Kaifuku Pon|', nq'|Moti-Récup' PV|', nq'|KP-Bon|', nq'|PS'n'roll|', nq'|Cupón PS|', nq'| ???|', nq'| ???|', nq'|ＨＰ回復碰碰 /|'||chr(10)||nq'|ＨＰ回复碰碰|', nq'|HP Huífù Pèngpèng / HP Wùihfuhk Pungpung|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Lycanium Z|', 7, q'|Allows Lycanroc to upgrade Stone Edge to the special Z-Move Splintered Stormshards.|', nq'|ルガルガンＺ|', nq'|Lugarugan-Z|', nq'|Lougarozélite|', nq'|Wolwerockium Z|', nq'|Lycanrochium Z|', nq'|Lycanrostal Z|', nq'|루가루암Z|', nq'|Rugaruam-Z|', nq'|鬃岩狼人Ｚ|', nq'|Zōngyánlángrén-Z / Jūngngàahmlòhngyàhn-Z|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Grepa Berry|', 3, q'|Raises friendship, but lowers Special Defense EVs.|', nq'|ウブのみ|', nq'|Ubu no Mi|', nq'|Baie Resin|', nq'|Labrusbeere|', nq'|Baccauva|', nq'|Baya Uvav|', nq'|또뽀열매|', nq'|Ttoppo Yeolmae|', nq'|萄葡果|', nq'|Táopú Guǒ / Tòuhpòuh Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Fightinium Z|', 7, q'|Allows a Pokémon to upgrade their Fighting-type damaging moves to the Z-Move All-Out Pummeling or upgrade their Fighting-type status moves into Z-Moves. Makes Arceus a Fighting-type Pokémon.|', nq'|カクトウＺ|', nq'|Fighting-Z|', nq'|Combazélite|', nq'|Battalium Z|', nq'|Luctium Z|', nq'|Lizastal Z|', nq'|격투Z|', nq'|Gyeoktu-Z|', nq'|格鬥Ｚ / 格斗Ｚ|', nq'|Gédòu-Z / Gaakdau-Z|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Discount Coupon|', 6, q'|Used at any boutique for a one-time 50% discount.|', nq'|バーゲンチケット|', nq'|Bargain Ticket|', nq'|Bon Réduction|', nq'|Rabattmarke|', nq'|Buono sconto|', nq'|Vale Descuento|', nq'|바겐세일티켓|', nq'|Bargain Ticket|', nq'|折價券 / 折价券|', nq'|Zhéjià Quàn / Jitga Gyun|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Charcoal|', 2, q'|Raises the power of Fire-type moves.|', nq'|もくたん|', nq'|Mokutan|', nq'|Charbon|', nq'|Holzkohle|', nq'|Carbonella|', nq'|Carbón|', nq'|목탄|', nq'|Moktan|', nq'|木炭|', nq'|Mùtàn / Muhktaan|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Purple Nectar|', 7, q'|Changes Oricorio to its Sensu Style.|', nq'|むらさきのミツ|', nq'|Murasaki no Mitsu|', nq'|Nectar Mauve|', nq'|Purpurner Nektar|', nq'|Nettare viola|', nq'|Néctar Violeta|', nq'|보라꿀|', nq'|Bora Kkul|', nq'|蘭紫色花蜜 / 兰紫色花蜜|', nq'|Lánzǐ-sè Huāmì / Làahnjí-sīk Fāmaht|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Odd Keystone|', 4, q'|A stone that can trap Spiritomb.|', nq'|かなめいし|', nq'|Kaname Ishi|', nq'|Clé de Voûte|', nq'|Spiritkern|', nq'|Roccianima|', nq'|Piedra Espíritu|', nq'|쐐기돌|', nq'|Sswaegi Dol|', nq'|楔石|', nq'|Xiē Shí / Sit Sehk|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Repel|', 1, q'|Prevents wild Pokémon with a lower level than the first member of the party from appearing for 100 steps|', nq'|むしよけスプレー|', nq'|Mushi Yoke Spray|', nq'|Repousse|', nq'|Schutz|', nq'|Repellente|', nq'|Repelente|', nq'|벌레회피스프레이|', nq'|Beolle Hoepi Spray|', nq'|除蟲噴霧 / 除虫喷雾|', nq'|Chúchóng Pēnwù / Chèuihchùhng Panmouh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Wacan Berry|', 4, q'|Reduces damage taken from a super effective Electric-type move.|', nq'|ソクノのみ|', nq'|Sokuno no Mi|', nq'|Baie Parma|', nq'|Kerzalberre|', nq'|Baccaparmen|', nq'|Baya Gualot|', nq'|초나열매|', nq'|Chona Yeolmae|', nq'|獨木果 / 独木果|', nq'|Zhúmù Guǒ / Jūkmuhk Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Wiki Berry|', 3, q'|When HP falls below 25%, restores 50% HP, but confuses Pokémon that dislike dry food (12.5% when below 50% before Gen. VII).|', nq'|ウイのみ|', nq'|Wi no Mi|', nq'|Baie Wiki|', nq'|Wikibeere|', nq'|Baccakiwi|', nq'|Baya Wiki|', nq'|위키열매|', nq'|Wiki Yeolmae|', nq'|異奇果 / 异奇果|', nq'|Yìqí Guǒ / Yihkèih Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|Yago Berry|', 3, q'|Pokéblock ingredient. Will turn into an Enigma Berry if transferred to Generation IV via Pal Park.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Shell Bell|', 3, q'|Restores HP to the holder based on damage inflicted to the opponent.|', nq'|かいがらのすず|', nq'|Kaigara no Suzu|', nq'|Grelot Coque|', nq'|Seegesang|', nq'|Conchinella|', nq'|Campana Concha|', nq'|조개껍질방울|', nq'|Jogaekkeopjil Bang-ul|', nq'|貝殼之鈴 / 贝壳之铃|', nq'|Bèiké-zhī Líng / Buihok-jī Lìhng|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|TMV Pass|', 6, q'|Allows the player to ride the TMV and access Kiloude City.|', nq'|TMVパス|', nq'|TMV Pass|', nq'|Passe TMV|', nq'|TMV-Pass|', nq'|Pass TMV|', nq'|Abono del TMV|', nq'|TMV패스|', nq'|TMV Pass|', nq'|ＴＭＶ自由票|', nq'|TMV Zìyóu Piào / TMV Jihyàuh Piu|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Full Restore|', 1, q'|Fully restores all HP and cures all status problems of a Pokémon.|', nq'|かいふくのくすり|', nq'|Kaifuku no Kusuri|', nq'|Guerison|', nq'|Top-Genesung|', nq'|Ricarica Totale|', nq'|Restaurar Todo|', nq'|회복약|', nq'|Hoebok Yak|', nq'|全復藥 / 全复药|', nq'|Quánfùyào / Chyùhnfuhkyeuhk|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Poison Gem|', 5, q'|Increases the power of the holder's first Poison-type move by 50%, and is consumed after use.|', nq'|どくのジュエル|', nq'|Doku no Jewel|', nq'|Joyau Poison|', nq'|Giftjuwel|', nq'|Bijouveleno|', nq'|Gema Veneno|', nq'|독주얼|', nq'|Dok Jewel|', nq'|毒之寶石 / 毒之宝石|', nq'|Dú-zhī Bǎoshí / Duhk-jī Bóusehk|', 16);
insert into ITEMS(NAME, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(q'|Roto Boost|', nq'|おうえんポン|', nq'|Ōen Pon|', nq'|Moti-Soutien|', nq'|Statuswertebon|', nq'|Stat'n'roll|', nq'|Cupón Refuerzo|', nq'| ???|', nq'| ???|', nq'|加油碰碰|', nq'|Jiāyóu Pèngpèng / Gāyáu Pungpung|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Salamencite|', 6, q'|Allows Salamence to Mega Evolve into Mega Salamence.|', nq'|ボーマンダナイト|', nq'|Bohmandanite|', nq'|Drattakite|', nq'|Brutalandanit|', nq'|Salamencite|', nq'|Salamencita|', nq'|보만다나이트|', nq'|Bomandanite|', nq'|暴飛龍進化石 / 暴飞龙进化石|', nq'|Bàofēilóng Jìnhuà Shí / Bouhfēilùhng Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Awakening|', 1, q'|Awakens a sleeping Pokémon.|', nq'|ねむけざまし|', nq'|Nemuke Zamashi|', nq'|Reveil|', nq'|Aufwecker|', nq'|Sveglia|', nq'|Despertar|', nq'|잠깨는약|', nq'|Jam Kkaeneun Yak|', nq'|解眠藥 / 解眠药|', nq'|Jiěmiányào / Gáaimìhnyeuhk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|X Sp. Def|', 2, q'|Raises a Pokémon's Special Defense by 2 stages (1 stage before Gen. VII).|', nq'|スペシャルガード|', nq'|Special Guard|', nq'|Def. Spé. +|', nq'|X-Spezial-Vert.|', nq'|Dif. Sp. X|', nq'|Def. Esp. X|', nq'|스페셜가드|', nq'|Special Guard|', nq'|特防強化 / 特防强化|', nq'|Tèfáng Qiánghuà / Dahkfòhng Kèuhngfa|', 0);
insert into ITEMS(NAME, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(q'|TM|', nq'|わざマシン|', nq'|Waza Machine|', nq'|CT|', nq'|TM|', nq'|MT|', nq'|MT|', nq'|기술머신|', nq'|Gisul Machine|', nq'|招式學習器 / 招式学习器|', nq'|Zhāoshì Xuéxíqì / Jīusīk Hohkjaahphei|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Zygarde Cube|', 7, q'|Holds collected Zygarde Cores and Cells and teaches Zygarde moves.|', nq'|ジガルデキューブ|', nq'|Zygarde Cube|', nq'|Boîte Zygarde|', nq'|Zygarde-Würfel|', nq'|Teca Zygarde|', nq'|Arca de Zygarde|', nq'|지가르데큐브|', nq'|Zygarde Cube|', nq'|基格爾德多面體 / 基格尔德多面体|', nq'|Jīgé'ěrdé Duōmiàntǐ / Gēigaakyíhdāk Dōmihntái|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Burn Heal|', 1, q'|Heals a burn.|', nq'|やけどなおし|', nq'|Yakedo Naoshi|', nq'|Anti-Brûle|', nq'|Feuerheiler|', nq'|Antiscottatura|', nq'|Antiquemar|', nq'|화상치료제|', nq'|Hwasang Chiryoje|', nq'|灼傷藥 / 灼伤药|', nq'|Zhuóshāngyào / Cheuksēungyeuhk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Mach Bike|', 3, q'|A speedy bike that can even go up muddy slopes. It is harder to control than the Acro Bike, and cannot do tricks.|', nq'|マッハじてんしゃ|', nq'|Mach Jitensha|', nq'|Vélo de Course|', nq'|Eilrad|', nq'|Bici da corsa|', nq'|Bici de Carreras|', nq'|마하자전거|', nq'|Mach Jajeongeo|', nq'|音速自行車 / 音速自行车|', nq'|Yīnsù Zìxíngchē / Yāmchūk Jihhàhngchē|', 176);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|TM Case|', 3, q'|Holds TMs.|', nq'|わざマシンケース|', nq'|Waza Machine Case|', nq'|Boite CT|', nq'|VM/TM Box|', nq'|Porta MT-MN|', nq'|Tubo MT-MO|', nq'|기술머신케이스|', nq'|Gisul Machine Case|', nq'|招式學習器盒 / 招式学习器盒|', nq'|Zhāoshì Xuéxíqì Hé / Jīusīk Hohkjaahphei Hahp|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Go-Goggles|', 3, q'|A Key Item that allows the player to travel in sandstorm conditions. Unnecessary in Generations IV and V, as the player may enter sandstorm conditions without protection.|', nq'|ゴーゴーゴーグル|', nq'|Go Go Goggle|', nq'|Lunettes Sable|', nq'|Wüstenglas|', nq'|Occhialoni|', nq'|Gafas Aislantes|', nq'|고고고글|', nq'|Go-Go Goggle|', nq'|ＧＯＧＯ護目鏡 / ＧＯＧＯ护目镜|', nq'|GOGO Hù Mùjìng / GOGO Wuh Muhkgeng|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Roller Skates|', 6, q'|Allows the player to glide around and perform tricks.|', nq'|ローラースケート|', nq'|Roller Skate|', nq'|Rollers|', nq'|Rollerskates|', nq'|Pattini|', nq'|Patines|', nq'|롤러스케이트|', nq'|Roller Skate|', nq'|溜冰鞋*|'||chr(10)||nq'|轮滑鞋|', nq'|Liūbīng Xié / Làuhbīng Hàaih*|'||chr(10)||nq'|Lúnhuá Xié|', 3);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Relic Gold|', 5, q'|Can be sold for 10000 to the villa owner in Undella Town.|', nq'|こだいのきんか|', nq'|Kodai no Kinka|', nq'|Vieux Ducat|', nq'|Alter Dukat|', nq'|Doblonantico|', nq'|Real Oro|', nq'|고대의금화|', nq'|Godae-yi Geumhwa|', nq'|古代金幣 / 古代金币|', nq'|Gǔdài Jīnbì / Gúdoih Gāmbaih|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|MysticTicket|', 3, q'|Allows the player to access Navel Rock and catch Lugia and Ho-Oh.|', nq'|しんぴのチケット|', nq'|Shinpi no Ticket|', nq'|Ticketmystik|', nq'|Geheimticket|', nq'|Biglietto Magico|', nq'|Misti-Ticket|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Litebluemail|', 2, q'|Mail with a Dratini pattern. To be held by a Pokémon for delivery.|', nq'|みずいろメール|', nq'|Mizuiro Mail|', nq'|LetrBleuCiel|', nq'|Cyanbrief|', nq'|Mess. Azzurro|', nq'|Carta Azul|', nq'|옥빛메일|', nq'|Okbit Mail|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Gram 3|', 5, q'|An important letter which Wingull delivers.|', nq'|はいたつぶつ３|', nq'|Haitatsubutsu 3|', nq'|Courrier 3|', nq'|Briefpost 3|', nq'|Missiva 3|', nq'|Envío 3|', nq'|배달물3|', nq'|Baedalmul 3|', nq'|配送物品３|', nq'|Pèisòng Wùpǐn 3 / Puisung Mahtbán 3|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Waterium Z|', 7, q'|Allows a Pokémon to upgrade their Water-type damaging moves to the Z-Move Hydro Vortex or upgrade their Water-type status moves into Z-Moves. Makes Arceus a Water-type Pokémon.|', nq'|ミズＺ|', nq'|Water-Z|', nq'|Aquazélite|', nq'|Aquium Z|', nq'|Idrium Z|', nq'|Hidrostal Z|', nq'|물Z|', nq'|Mul-Z|', nq'|水Ｚ|', nq'|Shuǐ-Z / Séui-Z|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Item Drop|', 5, q'|Causes an ally to drop its held item. Wonder Launcher only.|', nq'|アイテムドロップ|', nq'|Item Drop|', nq'|Jette Objet|', nq'|Itemabwurf|', nq'|Lascioggetto|', nq'|Tiraobjeto|', nq'|아이템드롭|', nq'|Item Drop|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Protector|', 4, q'|A held item that allows Rhydon to evolve when traded.|', nq'|プロテクター|', nq'|Protector|', nq'|Protecteur|', nq'|Schützer|', nq'|Copertura|', nq'|Protector|', nq'|프로텍터|', nq'|Protector|', nq'|護具 / 护具|', nq'|Hùjù / Wuhgeuih|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Fame Checker|', 3, q'|Records information on famous people, such as Gym Leaders.|', nq'|ボイスチェッカー|', nq'|Voice Checker|', nq'|Memorydex|', nq'|Ruhmesdatei|', nq'|PokéVIP|', nq'|Memorín|', 0);
insert into ITEMS(NAME, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(q'|Roto Stealth|', nq'|かくれポン|', nq'|Kakure Pon|', nq'|Moti-Camouflage|', nq'|Schutzbon|', nq'|Repelle'n'roll|', nq'|Cupón Sigilo|', nq'| ???|', nq'| ???|', nq'|隱身碰碰 / 隐身碰碰|', nq'|Yǐnshēn Pèngpèng / Yánsān Pungpung|');
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|X Special 2|', 5, q'|Sharply raises a Pokémon's Special Attack. Wonder Launcher only.|');
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|Pumkin Berry|', 3, q'|Cures a frozen Pokémon. If transferred to Generation IV via Pal Park, it will turn into an Enigma Berry.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Magmarizer|', 4, q'|A held item that allows Magmar to evolve when traded.|', nq'|マグマブースター|', nq'|Magma Booster|', nq'|Magmariseur|', nq'|Magmaisierer|', nq'|Magmatore|', nq'|Magmatizador|', nq'|마그마부스터|', nq'|Magma Booster|', nq'|熔岩增幅器|', nq'|Róngyán Zēngfú Qì / Yùhngngàahm Jāngfūk Hei|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Eon Ticket|', 3, q'|Allows player to access Southern Island.|', nq'|むげんのチケット|', nq'|Mugen no Ticket|', nq'|Passe Éon|', nq'|Äon-Ticket|', nq'|Biglietto Eone|', nq'|Ticket Eón|', nq'|무한티켓|', nq'|Muhan Ticket|', nq'|無限船票 / 无限船票|', nq'|Wúxiàn Chuánpiào / Mòuhhaahn Syùhnpiu|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Blue Scarf|', 3, q'|Raises the Beautiful condition.|', nq'|あおいバンダナ|', nq'|Aoi Bandanna|', nq'|Foul. Bleu|', nq'|Blauer Schal|', nq'|Fascia Blu|', nq'|Pañuelo Azul|', nq'|파랑밴드|', nq'|Parang Band|', nq'|藍色頭巾 / 蓝色头巾|', nq'|Lán-sè Tóujīn / Làahm-sīk Tàuhgān|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Glitter Mail|', 3, q'|Mail with a Pikachu pattern.|', nq'|キラキラメール|', nq'|Kira Kira Mail|', nq'|Lettre Brill|', nq'|Glitzerbrief|', nq'|Mess. Luci|', nq'|Carta Brillo|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Powerup Part|', 3, q'|Used to fix the Kids Grid system.|', nq'|きょうかパーツ|', nq'|Kyōka Parts|', nq'|Amplificateur|', nq'|Ersatzteil|', nq'|Espansione|', nq'|Potenciador|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Lift Key|', 1, q'|Allows operation of the elevator (lift) in the Team Rocket Hideout.|', nq'|エレベータのカギ|', nq'|Elevator no Kagi|', nq'|Cle Asc.|', nq'|Liftöffner|', nq'|Chiave Ascensore|', nq'|Llave Ascensor|', nq'|엘리베이터열쇠|', nq'|Elevator Yeolsoe|', nq'|電梯鑰匙 / 电梯钥匙|', nq'|Dìantī Yàoshi / Dihntāi Yeuhksìh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Sablenite|', 6, q'|Allows Sableye to Mega Evolve into Mega Sableye.|', nq'|ヤミラミナイト|', nq'|Yamiraminite|', nq'|Ténéfixite|', nq'|Zobirisnit|', nq'|Sableyeite|', nq'|Sableynita|', nq'|깜까미나이트|', nq'|Kamkaminite|', nq'|勾魂眼進化石 / 勾魂眼进化石|', nq'|Gōuhúnyǎn Jìnhuà Shí / Ngāuwàhnngáahn Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Jail Key|', 3, q'|The key to jail cells in Pyrite Town.|', nq'|ろうやのカギ|', nq'|Rōya no Kagi|', nq'|Cle de la Prison|', nq'|Zellenschlüssel|', nq'|Chiave Celle|', nq'|Llave Celdas|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|X Attack 6|', 5, q'|Immensely raises a Pokémon's Attack. Wonder Launcher only.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Relic Vase|', 5, q'|Can be sold for 50000 to the villa owner in Undella Town.|', nq'|こだいのツボ|', nq'|Kodai no Tsubo|', nq'|Vieux Vase|', nq'|Alte Vase|', nq'|Vasantico|', nq'|Ánfora|', nq'|고대의항아리|', nq'|Godae-yi Hang'ari|', nq'|古代之壺 / 古代之壶|', nq'|Gǔdài-zhī Hú / Gúdoih-jī Wùh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Iron Ball|', 4, q'|Cuts a Pokémon's Speed and makes it susceptible to Ground-type moves.|', nq'|くろいてっきゅう|', nq'|Kuroi Tekkyū|', nq'|Balle Fer|', nq'|Eisenkugel|', nq'|Ferropalla|', nq'|Bola Férrea|', nq'|검은철구|', nq'|Geomeun Cheolgu|', nq'|黑色鐵球 / 黑色铁球|', nq'|Hēi-sè Tiěqiú / Hāak-sīk Titkàuh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Grassy Seed|', 7, q'|A one-time use item that raises the holder's Defense by one stage upon activation of Grassy Terrain.|', nq'|グラスシード|', nq'|Grass Seed|', nq'|Graine Herbe|', nq'|Gras-Samen|', nq'|Erbaseme|', nq'|Semilla Hierba|', nq'|그래스시드|', nq'|Grass Seed|', nq'|青草種子 / 青草种子|', nq'|Qīngcǎo Zhǒngzi / Chēngchóu Júngjí|', 0);
insert into ITEMS(NAME, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(q'|Roto Prize Money|', nq'|おこづかいポン|', nq'|Okozukai Pon|', nq'|Moti-Magot|', nq'|Preisgeldbon|', nq'|Soldi'n'roll|', nq'|Cupón Botín|', nq'| ???|', nq'| ???|', nq'|零花錢碰碰 / 零花钱碰碰|', nq'|Líng Huāqián Pèngpèng / Lìhng Fāchín Pungpung|');
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|Travel Trunk|', 6, q'|Not available without cheating. Allows the player to switch their clothes, just like in a Pokémon Center.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Iron|', 1, q'|Raises the Defense of a Pokémon.|', nq'|ブロムヘキシン|', nq'|Bromhexine|', nq'|Fer|', nq'|Eisen|', nq'|Ferro|', nq'|Hierro|', nq'|사포닌|', nq'|Saponin|', nq'|防禦增強劑 / 防御增强剂|', nq'|Fángyù Zēngqiángjì / Fòhngyuh Jāngkèuhngjaih|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|Common Stone|', 6, q'|Not available without cheating. Currently has no use.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Armor Fossil|', 4, q'|A Fossil from which a Shieldon can be resurrected.|', nq'|たてのカセキ|', nq'|Tate no Kaseki|', nq'|Fossile Armure|', nq'|Panzerfossil|', nq'|Fossilscudo|', nq'|Fósil Coraza|', nq'|방패의화석|', nq'|Bangpae-ui Hwaseok|', nq'|盾甲化石|', nq'|Dùnjiǎ Huàshí / Téuhngaap Fasehk|', 128);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Sharpedonite|', 6, q'|Allows Sharpedo to Mega Evolve into Mega Sharpedo.|', nq'|サメハダナイト|', nq'|Samehadenite|', nq'|Sharpedite|', nq'|Tohaidonit|', nq'|Sharpedite|', nq'|Sharpedonita|', nq'|샤크니아나이트|', nq'|Sharknianite|', nq'|巨牙鯊進化石 / 巨牙鲨进化石|', nq'|Jùyáshā Jìnhuà Shí / Geuihngàhsā Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Pikashunium Z|', 7, q'|Allows Pikachu in a cap to upgrade Thunderbolt to the special Z-Move 10,000,000 Volt Thunderbolt.|', nq'|サトピカＺ|', nq'|Satopika-Z|', nq'|Pikachazélite|', nq'|Ash-Pikachium Z|', nq'|Ashpikacium Z|', nq'|Ash-Pikastal Z|', nq'|지우피카Z|', nq'|Jiupika-Z|', nq'|智皮卡Ｚ|', nq'|Zhìpíkǎ-Z / Jipèihkā-Z|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Tidal Bell|', 4, q'|Allows the Kimono Girls to summon Lugia.|', nq'|うみなりのスズ|', nq'|Uminari no Suzu|', nq'|Glas tempête|', nq'|Gischtglocke|', nq'|Camp. Onda|', nq'|Camp. Oleaje|', nq'|해명의방울|', nq'|Haemyeong-ui Bang-ul|', nq'|海聲鈴鐺 / 海声铃铛|', nq'|Hǎishēng Língdāng / Hóisīng Lìhngdōng|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Mimikium Z|', 7, q'|Allows Mimikyu to upgrade Play Rough to the special Z-Move Let's Snuggle Forever.|', nq'|ミミッキュＺ|', nq'|Mimikkyu-Z|', nq'|Mimiquizélite|', nq'|Mimigmium Z|', nq'|Mimikyum Z|', nq'|Mimikyustal Z|', nq'|따라큐Z|', nq'|Ttarakyu-Z|', nq'|謎擬ＱＺ / 谜拟ＱＺ|', nq'|Mínǐ-Q-Z / Màihyìh-Q-Z|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Cry Analyzer|', 3, q'|Detaches certain translators.|', nq'|かいどくそうち|', nq'|Kaidoku Sōchi|', nq'|Decodeur Cri|', nq'|Stimmkenner|', nq'|Analiz.Verso|', nq'|Gritolector|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Point Card|', 4, q'|Stores Battle Points (BP) earned at the Battle Tower or Battle Frontier.|', nq'|ポイントカード|', nq'|Point Card|', nq'|Carte Points|', nq'|Punktekarte|', nq'|Scheda Punti|', nq'|Tarj. Puntos|', nq'|포인트카드|', nq'|Point Card|', nq'|點數卡 / 点数卡|', nq'|Diǎnshù Kǎ / Dímsou Kāat|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Cornn Berry|', 3, q'|Poffin and Pokéblock ingredient.|', nq'|モコシのみ|', nq'|Mokoshi no Mi|', nq'|Baie Siam|', nq'|Saimbeere|', nq'|Baccavena|', nq'|Baya Mais|', nq'|수숙열매|', nq'|Susuk Yeolmae|', nq'|玉黍果|', nq'|Yùshǔ Guǒ / Yuhksyú Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Coba Berry|', 4, q'|Reduces damage from a super effective Flying-type move by 50%.|', nq'|バコウのみ|', nq'|Baco no Mi|', nq'|Baie Cobaba|', nq'|Kobabeere|', nq'|Baccababa|', nq'|Baya Kouba|', nq'|바코열매|', nq'|Baco Yeolmae|', nq'|棱瓜果|', nq'|Léngguā Guǒ / Lìhnggwā Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|X Special 6|', 5, q'|Immensely raises a Pokémon's Special Attack. Wonder Launcher only.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Grass Mail|', 4, q'|Mail with a grass pattern. To be held by a Pokémon for delivery.|', nq'|グラスメール|', nq'|Grass Mail|', nq'|Lettre Herbe|', nq'|Wiesenbrief|', nq'|Mess. Erba|', nq'|Carta Hierba|', nq'|잔디메일|', nq'|Jandi Mail|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Dowsing Machine|', 1, q'|A Key Item that can be used to detect hidden items.|', q'|Referred to as the Itemfinder prior to Generation IV and as the Dowsing MCHN in Pokémon HeartGold and SoulSilver and the Generation V games.|', nq'|ダウジングマシン|', nq'|Dowsing Machine|', nq'|Cherch'Objet|', nq'|Itemradar|', nq'|Ricerca Strumenti|', nq'|Zahorí|', nq'|다우징머신|', nq'|Dowsing Machine|', nq'|探寶器 / 探宝器|', nq'|Tànbǎo Qì / Taambóu Hei|', 1136);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Voice Case 4|', 3, q'|Apparently heals a Wobbuffet in Agate Village.|', nq'|こえカプセル４|', nq'|Koe Capsule 4|', nq'|Boite Cri 4|', nq'|Stimmbox 4|', nq'|Disco Verso 4|', nq'|Grabación 4|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|Oak's Parcel|', 1, q'|Deliver to Professor Oak to receive a Pokédex.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Mega Ring|', 6, q'|Allows the player to Mega Evolve a Pokémon holding the appropriate Mega Stone.|', nq'|メガリング|', nq'|Mega Ring|', nq'|Méga-Anneau|', nq'|Mega-Ring|', nq'|Megacerchio|', nq'|Mega-Aro|', nq'|메가링|', nq'|Mega Ring|', nq'|超級環 / 超级环|', nq'|Chāojí Huán / Chīukāp Wàahn|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Custap Berry|', 4, q'|Allows holder to move first just once when HP is below ⅓.|', nq'|イバンのみ|', nq'|Iban no Mi|', nq'|Baie Chérim|', nq'|Eipfelbeere|', nq'|Baccacrela|', nq'|Baya Chiri|', nq'|애슈열매|', nq'|Aesyu Yeolmae|', nq'|釋陀果 / 释陀果|', nq'|Shìtuó Guǒ / Sīktòh Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Xtransceiver|', 5, q'|Used to make video calls to other players. Also used by in-game Trainers to advance the story.|', nq'|ライブキャスター|', nq'|Live Caster|', nq'|Vokit|', nq'|Viso-Caster|', nq'|Interpoké|', nq'|Videomisor|', nq'|라이브캐스터|', nq'|Live Caster|', nq'|即時通訊器 / 即时通讯器|', nq'|Jíshí Tōngxùn Qì / Jīksìh Tūngseun Hei|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Ganlon Berry|', 3, q'|Raises Defense if HP is below ⅓ of maximum.|', nq'|リュガのみ|', nq'|Ryuga no Mi|', nq'|Baie Lingan|', nq'|Linganbeere|', nq'|Baccalongan|', nq'|Baya Gonlan|', nq'|용아열매|', nq'|Yong'a Yeolmae|', nq'|龍睛果 / 龙睛果|', nq'|Lóngjīng Guǒ / Lùhngjīng Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Brick Mail|', 4, q'|A brick pattern stationery. To be held by a Pokémon for delivery.|', nq'|ブリックメール|', nq'|Brick Mail|', nq'|Lettre Brik|', nq'|Ziegelbrief|', nq'|Mess. Muro|', nq'|Carta Pared|', nq'|브릭메일|', nq'|Brick Mail|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Black Apricorn|', 2, q'|If taken to Kurt, he will make the player a Fast Ball. Also, Apricorn Drink ingredient.|', q'|Formatted as Blk Apricorn prior to Generation VI.|', nq'|くろぼんぐり|', nq'|Kuro Bonguri|', nq'|Noigrume Noi|', nq'|Aprikoko Swz|', nq'|Ghicocca Nera|', nq'|Bonguri Negro|', nq'|검은규토리|', nq'|Geomeun Gyutori|', nq'|黑球果|', nq'|Hēi Qiúguǒ / Hāak Kàuhgwó|', 1072);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Dire Hit|', 1, q'|Raises critical hit ratio in battle.|', nq'|クリティカット|', nq'|Criticut|', nq'|Muscle +|', nq'|Angriffplus|', nq'|Supercolpo|', nq'|Directo|', nq'|크리티컬커터|', nq'|Critical Cutter|', nq'|要害攻擊 / 要害攻击|', nq'|Yàohài Gōngjí / Yiuhoih Gūnggīk|', 768);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Toxic Orb|', 4, q'|Inflicts the Badly poisoned status on the holder.|', nq'|どくどくだま|', nq'|Dokudoku Dama|', nq'|Orbe Toxique|', nq'|Toxik-Orb|', nq'|Tossicsfera|', nq'|Toxisfera|', nq'|맹독구슬|', nq'|Maengdok Guseul|', nq'|劇毒寶珠 / 剧毒宝珠|', nq'|Jùdú Bǎozhū / Kehkduhk Bóujyū|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Pixie Plate|', 6, q'|Raises the power of Fairy-type moves.|', nq'|せいれいプレート|', nq'|Seirei Purēto|', nq'|Plaque Pixie|', nq'|Feentafel|', nq'|Lastraspiritello|', nq'|Tabla Duende|', nq'|정령플레이트|', nq'|Jeonglyeong Plate|', nq'|妖精石板|', nq'|Yāojīng Shíbǎn / Yīujīng Sehkbáan|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Gold Teeth|', 1, q'|Safari Zone Warden's false teeth. Return for HM04 (Strength)|', nq'|きんのいれば|', nq'|Kin no Ireba|', nq'|Dent D'or|', nq'|Goldzähne|', nq'|Denti d’Oro|', nq'|Dientes Oro|', nq'|금틀니|', nq'|Geum Teulli|', nq'|金假牙|', nq'|Jīn Jǐayá / Gām Gángàh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Makeup Bag|', 7, q'|A case for carrying lipsticks.|', nq'|コスメポーチ|', nq'|Cosmetics Pouch|', nq'|Trousse Beauté|', nq'|Kosmetiketui|', nq'|Trousse|', nq'|Kit Maquillaje|', nq'|코스메틱파우치|', nq'|Cosmetics Pouch|', nq'|化妝包 / 化妆包|', nq'|Huàzhuāng Bāo / Fajōng Bāau|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Red Scale|', 2, q'|Give to Mr. Pokémon for an Exp. Share.|', nq'|あかいウロコ|', nq'|Akai Uroko|', nq'|Écaillerouge|', nq'|Rote Haut|', nq'|Squama Rossa|', nq'|Escama Roja|', nq'|빨간비늘|', nq'|Ppalgan Bineul|', nq'|紅色鱗片 / 红色鳞片|', nq'|Hóng-sè Línpiàn / Hùhng-sīk Lèuhnpin|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Orange Petal|', 7, q'|An orange petal required to complete Mina's Trial.|', nq'|だいだいはなびら|', nq'|Daidai Hanabira|', nq'|Pétale Orange|', nq'|Oranges Blatt|', nq'|Petalo arancione|', nq'|Pétalo Naranja|', nq'|주황꽃잎|', nq'|Juhwang Kkochip|', nq'|橙色花瓣|', nq'|Chéng-sè Huābàn / Chàahng-sīk Fāfáan|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Surf Mail|', 2, q'|Mail with a Lapras pattern. To be held by a Pokémon for delivery.|', nq'|なみのりメール|', nq'|Naminori Mail|', nq'|Lettre Surf|', nq'|Surferbrief|', nq'|Mess. Surf|', nq'|Carta Surf|', nq'|파도타기메일|', nq'|Padotagi Mail|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Red Apricorn|', 2, q'|Kurt will make a Level Ball out of it.|', nq'|あかぼんぐり|', nq'|Aka Bonguri|', nq'|Noigrume Rge|', nq'|Aprikoko Rot|', nq'|Ghicocca Rossa|', nq'|Bonguri Rojo|', nq'|빨간규토리|', nq'|Ppalgan Gyutori|', nq'|紅球果 / 红球果|', nq'|Hóng Qiúguǒ / Hùhng Kàuhgwó|', 48);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Quick Powder|', 4, q'|Raises Ditto's speed.|', nq'|スピードパウダー|', nq'|Speed Powder|', nq'|Poudre Vite|', nq'|Flottstaub|', nq'|Velopolvere|', nq'|Polvo Veloz|', nq'|스피드파우더|', nq'|Speed Powder|', nq'|速度粉|', nq'|Sùdù Fěn / Chūkdouh Fán|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Leftovers|', 2, q'|Heals a little HP at the end of each turn.|', nq'|たべのこし|', nq'|Tabe Nokoshi|', nq'|Restes|', nq'|Überreste|', nq'|Avanzi|', nq'|Restos|', nq'|먹다남은음식|', nq'|Meokda Nameun Eumsik|', nq'|吃剩的東西 / 吃剩的东西|', nq'|Chīshèng-de Dōngxī / Heksihng-dīk Dūngsāi|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Slowpoke Tail|', 2, q'|Can be sold for 4900.|', q'|Formatted as SlowpokeTail prior to Generation VI.|', nq'|おいしいシッポ|', nq'|Oishii Shippo|', nq'|Queueramolos|', nq'|Flegmonrute|', nq'|Codaslowpoke|', nq'|Colaslowpoke|', nq'|맛있는꼬리|', nq'|Masinneun Kkori|', nq'|美味尾巴|', nq'|Měiwèi Wěiba/Měiwèi Yǐba / Méihmeih Méihbā|', 1024);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Rock Memory|', 7, q'|Makes Silvally a Rock-type Pokémon and makes Multi-Attack a Rock-type move.|', nq'|ロックメモリ|', nq'|Rock Memory|', nq'|ROM Roche|', nq'|Gesteins-Disc|', nq'|ROM Roccia|', nq'|Disco Roca|', nq'|락메모리|', nq'|Rock Memory|', nq'|岩石記憶碟*|'||chr(10)||nq'|岩石存储碟|', nq'|Yánshí Jìyìdié / Ngàahmsehk Geiyīkdihp*|'||chr(10)||nq'|Yánshí Cúnchǔdié|', 3);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Quick Claw|', 2, q'|May allow the user to move first.|', nq'|せんせいのツメ|', nq'|Sensei no Tsume|', nq'|Vive Griffe|', nq'|Flinkklaue|', nq'|Rapidartigli|', nq'|Garra Rápida|', nq'|선제공격손톱|', nq'|Seonjegonggyeok Sontop|', nq'|先制之爪|', nq'|Xiānzhì-zhī Zhuǎ / Sīnjai-jī Jáau|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Aerodactylite|', 6, q'|Allows Aerodactyl to Mega Evolve into Mega Aerodactyl.|', nq'|プテラナイト|', nq'|Pteranite|', nq'|Ptéraïte|', nq'|Aerodactylonit|', nq'|Aerodactylite|', nq'|Aerodactylita|', nq'|프테라나이트|', nq'|Pteranite|', nq'|化石翼龍進化石 / 化石翼龙进化石|', nq'|Huàshíyìlóng Jìnhuà Shí / Fasehkyihklùhng Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Slowbronite|', 6, q'|Allows Slowbro to Mega Evolve into Mega Slowbro.|', nq'|ヤドランナイト|', nq'|Yadorannite|', nq'|Flagadossite|', nq'|Lahmusnit|', nq'|Slowbroite|', nq'|Slowbronita|', nq'|야도란나이트|', nq'|Yadonrannite|', nq'|呆殼獸進化石 / 呆壳兽进化石|', nq'|Dāikéshòu Jìnhuà Shí / Ngòihhoksau Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Payapa Berry|', 4, q'|Reduces damage from a super effective Psychic-type move.|', nq'|ウタンのみ|', nq'|Utan no Mi|', nq'|Baie Yapap|', nq'|Pyapabeere|', nq'|Baccapayapa|', nq'|Baya Payapa|', nq'|야파열매|', nq'|Yapa Yeolmae|', nq'|福祿果 / 福禄果|', nq'|Fúlù Guǒ / Fūkluhk Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|White Apricorn|', 2, q'|If taken to Kurt, he will make the player a Fast Ball. Also, Apricorn Drink ingredient.|', q'|Formatted as Wht Apricorn prior to Generation VI.|', nq'|しろぼんぐり|', nq'|Shiro Bonguri|', nq'|Noigrume Blc|', nq'|Aprikoko Wss|', nq'|Ghicocca Bianca|', nq'|Bonguri Blanco|', nq'|하얀규토리|', nq'|Hayan Gyutori|', nq'|白球果|', nq'|Bái Qiúguǒ / Baahk Kàuhgwó|', 1072);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Dusk Stone|', 4, q'|Can be used to evolve Misdreavus, Murkrow, Lampent, and Doublade.|', nq'|やみのいし|', nq'|Yami no Ishi|', nq'|Pierre Nuit|', nq'|Finsterstein|', nq'|Neropietra|', nq'|Piedra Noche|', nq'|어둠의돌|', nq'|Eodumui Dol|', nq'|暗之石|', nq'|Àn-zhī Shí / Am-jī Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Bicycle|', 1, q'|Can be used to travel quickly. Cannot be ridden in swamps, or in very tall grass.|', nq'|じてんしゃ|', nq'|Jitensha|', nq'|Bicyclette|', nq'|Fahrrad|', nq'|Bicicletta|', nq'|Bici|', nq'|자전거|', nq'|Jajeon-geo|', nq'|自行車 / 自行车|', nq'|Zìxíngchē / Jihhàhngchē|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Grip Claw|', 4, q'|Causes trapping moves (e.g. Bind, Wrap) to last for five turns.|', nq'|ねばりのかぎづめ|', nq'|Nebari no Kagidzume|', nq'|Accro Griffe|', nq'|Griffklaue|', nq'|Presartigli|', nq'|Garra Garfio|', nq'|끈기갈고리손톱|', nq'|Kkeun-gi Galgori Sontop|', nq'|緊纏鈎爪 / 紧缠钩爪|', nq'|Jǐnchán Gōuzhuǎ / Gánchìhn Ngāujáau|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Bright Powder|', 2, q'|Lowers the opponent's accuracy.|', q'|Formatted as BrightPowder prior to Generation VI.|', nq'|ひかりのこな|', nq'|Hikari no Kona|', nq'|Poudre Claire|', nq'|Blendpuder|', nq'|Luminpolvere|', nq'|Polvo Brillo|', nq'|반짝가루|', nq'|Banjjak Garu|', nq'|光粉|', nq'|Guāngfěn / Gwōngfán|', 1152);
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|Surfboard|', 1, q'|An item that can be used to travel on water, much like using the hidden move Surf. Unobtainable during normal gameplay.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Tropic Mail|', 3, q'|Mail with a picture of Bellossom. To be held by a Pokémon for delivery.|', nq'|トロピカルメール|', nq'|Tropical Mail|', nq'|Lettre Tropi|', nq'|Tropenbrief|', nq'|Mess. Tropic|', nq'|Carta Tropical|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Kee Berry|', 6, q'|Increases Defense when hit with a physical move.|', nq'|アッキのみ|', nq'|Akki no Mi|', nq'|Baie Éka|', nq'|Akibeere|', nq'|Baccalighia|', nq'|Baya Biglia|', nq'|악키열매|', nq'|Akki Yeolmae|', nq'|亞開果 / 亚开果|', nq'|Yàkāi Guǒ / Ahōi Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|Dire Hit 3|', 5, q'|Raises critical hit ratio by 3 levels in battle. Wonder Launcher only.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Magma Suit|', 6, q'|Allows the player to ride Groudon in the Cave of Origin and fly into space on Rayquaza.|', nq'|マグマスーツ|', nq'|Magma Suit|', nq'|Scaph. Magma|', nq'|Magma-Anzug|', nq'|Tuta Magma|', nq'|Traje Magma|', nq'|마그마슈트|', nq'|Magma Suit|', nq'|熔岩裝 / 熔岩装|', nq'|Róngyán Zhuāng / Yùhngngàahm Jōng|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Metronome|', 4, q'|Raises power of moves used in a row.|', nq'|メトロノーム|', nq'|Metronome|', nq'|Métronome|', nq'|Metronom|', nq'|Plessimetro|', nq'|Metrónomo|', nq'|메트로놈|', nq'|Metronome|', nq'|節拍器 / 节拍器|', nq'|Jiépāiqì / Jitpaakhei|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Silver Powder|', 2, q'|Raises the power of Bug-type moves.|', q'|Formatted as SilverPowder prior to Generation VI.|', nq'|ぎんのこな|', nq'|Gin no Kona|', nq'|Poudre Argentée|', nq'|Silberstaub|', nq'|Argenpolvere|', nq'|Polvo Plata|', nq'|은빛가루|', nq'|Eunbit Garu|', nq'|銀粉 / 银粉|', nq'|Yínfěn / Ngàhnfán|', 1152);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Bonsly Photo|', 3, q'|The Battle Bingo prize for winning/using the Bonsly Card.|', nq'|ウソハチ・フォト|', nq'|Usohachi Photo|', nq'|Photo Manzai|', nq'|Mobai-Foto|', nq'|Foto Bonsly|', nq'|Foto Bonsly|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Gyaradosite|', 6, q'|Allows Gyarados to Mega Evolve into Mega Gyarados.|', nq'|ギャラドスナイト|', nq'|Gyaradosnite|', nq'|Léviatorite|', nq'|Garadosnit|', nq'|Gyaradosite|', nq'|Gyaradosita|', nq'|갸라도스나이트|', nq'|Gyaradosnite|', nq'|暴鯉龍進化石 / 暴鲤龙进化石|', nq'|Bàolǐlóng Jìnhuà Shí / Bouhléihlùhng Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Energy Powder|', 2, q'|Restores 50 HP, but lowers friendship.|', q'|Formatted as EnergyPowder prior to Generation VI.|', nq'|ちからのこな|', nq'|Chikara no Kona|', nq'|Poudre Énergie|', nq'|Energiestaub|', nq'|Polvenergia|', nq'|Polvo Energía|', nq'|힘의가루|', nq'|Himui Garu|', nq'|元氣粉 / 元气粉|', nq'|Yuánqì Fěn / Yùhnhei Fán|', 1168);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Claw Fossil|', 3, q'|A Fossil from which an Anorith can be resurrected.|', nq'|ツメのカセキ|', nq'|Tsume no Kaseki|', nq'|Fossile Griffe|', nq'|Klauenfossil|', nq'|Fossilunghia|', nq'|Fósil Garra|', nq'|발톱화석|', nq'|Baltop Hwaseok|', nq'|爪子化石|', nq'|Zhuǎzi Huàshí / Jáaují Fasehk|', 128);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|X Speed|', 1, q'|Raises a Pokémon's Speed by 2 stages (1 stage before Gen. VII).|', nq'|スピーダー|', nq'|Speeder|', nq'|Vitesse +|', nq'|X-Tempo|', nq'|Velocità X|', nq'|Velocidad X|', nq'|스피드업|', nq'|Speed-Up|', nq'|速度強化 / 速度强化|', nq'|Sùdù Qiánghuà / Chūkdouh Kèuhngfa|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Hard Stone|', 2, q'|Raises the power of Rock-type moves.|', nq'|かたいいし|', nq'|Katai Ishi|', nq'|Pierre Dure|', nq'|Granitstein|', nq'|Pietradura|', nq'|Piedra Dura|', nq'|딱딱한돌|', nq'|Ttakttakhan Dol|', nq'|硬石頭 / 硬石头|', nq'|Yìng Shítou / Ngaahng Sehktàuh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Rare Candy|', 1, q'|Instantly raises a Pokémon's level by 1.|', nq'|ふしぎなアメ|', nq'|Fushigina Ame|', nq'|Super Bonbon|', nq'|Sonderbonbon|', nq'|Caramella Rara|', nq'|Carameloraro|', nq'|이상한사탕|', nq'|Isanghan Satang|', nq'|神奇糖果|', nq'|Shénqí Tángguǒ / Sàhnkèih Tòhnggwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Secret Key|', 4, q'|Allows access to the secret room within the Galactic Veilstone Building.|', nq'|ひみつのカギ|', nq'|Himitsu no Kagi|', nq'|Clé Secrète|', nq'| ?-Öffner|', nq'|Chiave Segreta|', nq'|Ll. Secreta|', nq'|비밀의열쇠|', nq'|Bimirui Yeolsoe|', nq'|秘密鑰匙 / 秘密钥匙|', nq'|Mìmì Yàoshi / Beimaht Yeuhksìh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Card Key|', 1, q'|Allows the player to access more rooms in the Silph Co. headquarters.|', nq'|カードキー|', nq'|Card Key|', nq'|Carte Magn.|'||chr(10)||nq'|Cle Magnetique|', nq'|Türöffner|'||chr(10)||nq'|Schlüsselkarte|', nq'|Apriporta|', nq'|Llave Magnética|'||chr(10)||nq'|T. Magnética|', nq'|카드키|', nq'|Card Key|', nq'|鑰匙卡 / 钥匙卡|', nq'|Yàoshi Kǎ / Yeuhksìh Kāat|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Metal Coat|', 2, q'|Raises the power of Steel-type moves. Allows Onix and Scyther to evolve when traded.|', nq'|メタルコート|', nq'|Metal Coat|', nq'|Peau Metal|', nq'|Metallmantel|', nq'|Metalcoperta|', nq'|Revest. Metálico|', nq'|금속코트|', nq'|Geumsok Coat|', nq'|金屬膜 / 金属膜|', nq'|Jīnshǔ Mó / Gāmsuhk Mohk|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Disc Case|', 3, q'|Holds Battle CDs.|', nq'|ディスクケース|', nq'|Disc Case|', nq'|Boite Holog.|', nq'|CD-Box|', nq'|Porta-CD|', nq'|Caja Discos|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Steelium Z|', 7, q'|Allows a Pokémon to upgrade their Steel-type damaging moves to the Z-Move Corkscrew Crash or upgrade their Steel-type status moves into Z-Moves. Makes Arceus a Steel-type Pokémon.|', nq'|ハガネＺ|', nq'|Steel-Z|', nq'|Métallozélite|', nq'|Metallium Z|', nq'|Metallium Z|', nq'|Metalostal Z|', nq'|강철Z|', nq'|Gangcheol-Z|', nq'|鋼Ｚ / 钢Ｚ|', nq'|Gāng-Z / Gong-Z|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Shock Drive|', 5, q'|Makes Techno Blast an Electric-type move when held by Genesect.|', nq'|イナズマカセット|', nq'|Inazuma Cassette|', nq'|Module Choc|', nq'|Blitzmodul|', nq'|Voltmodulo|', nq'|FulgoROM|', nq'|번개카세트|', nq'|Beongae Cassette|', nq'|閃電卡帶 / 闪电卡带|', nq'|Shǎndiàn Kǎdài / Símdihn Kāatdáai|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Krane Memo 2|', 3, q'|Contains information about the Aura Reader.|', nq'|クレインメモ２|', nq'|Krane Memo 2|', nq'|Memo Syrus 2|', nq'|Klein-Memo 2|', nq'|Appunti 2|', nq'|Parte Cío 2|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Earth Plate|', 4, q'|Raises the power of Ground-type moves.|', nq'|だいちのプレート|', nq'|Daichi no Purēto|', nq'|Plaque Terre|', nq'|Erdtafel|', nq'|Lastrageo|', nq'|Tabla Terrax|', nq'|대지플레이트|', nq'|Daeji Plate|', nq'|大地石板|', nq'|Dàdì Shíbǎn / Daaihdeih Sehkbáan|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Rowap Berry|', 4, q'|If a foe's special move lands, then the foe also takes damage.|', nq'|レンブのみ|', nq'|Renbu no Mi|', nq'|Baie Pommo|', nq'|Roselbeere|', nq'|Baccaroam|', nq'|Baya Magua|', nq'|애터열매|', nq'|Aeteo Yeolmae|', nq'|霧蓮果 / 雾莲果|', nq'|Wùlián Guǒ / Mouhlìhn Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Electric Gem|', 5, q'|Increases the power of the holder's first Electric-type move by 50%, and is consumed after use.|', nq'|でんきのジュエル|', nq'|Denki no Jewel|', nq'|Joyau Électr|', nq'|Elektrojuwel|', nq'|Bijouelettro|', nq'|Gema Eléctrica|', nq'|전기주얼|', nq'|Jeongi Jewel|', nq'|電之寶石 / 电之宝石|', nq'|Diàn-zhī Bǎoshí / Dihn-jī Bóusehk|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Dome Fossil|', 3, q'|A Fossil from which a Kabuto can be resurrected.|', nq'|こうらのカセキ|', nq'|Kōra no Kaseki|', nq'|Fossile Dôme|', nq'|Domfossil|', nq'|Domofossile|', nq'|Fósil Domo|', nq'|껍질화석|', nq'|Kkeopjil Hwaseok|', nq'|甲殼化石 / 甲壳化石|', nq'|Jiǎké Huàshí / Gaaphok Fasehk|', 128);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Moon Ball|', 2, q'|A type of Poké Ball that works better on Pokémon that evolve using the Moon Stone.|', nq'|ムーンボール|', nq'|Moon Ball|', nq'|Lune Ball|', nq'|Mondball|', nq'|Luna Ball|', nq'|Luna Ball|', nq'|문볼|', nq'|Moon Ball|', nq'|月亮球|', nq'|Yuèliàng Qiú / Yuhtleuhng Kàuh|', 0);
insert into ITEMS(NAME, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(q'|N-Lunarizer|', nq'|ネクロプラスルナ|', nq'|Necro Plus Luna|', nq'|Necroluna|', nq'|Necrolun|', nq'|Necrolunix|', nq'|Necroluna|', nq'|네크로플러스루나|', nq'|Necro Plus Luna|', nq'|奈克洛露奈合體器 / 奈克洛露奈合体器|', nq'|Nàikèluò Lùnài Hétǐqì / Noihhāklok Louhnoih Hahptáihei|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Zap Plate|', 4, q'|Raises the power of Electric-type moves.|', nq'|いかずちプレート|', nq'|Ikazuchi Purēto|', nq'|Plaque Volt|', nq'|Blitztafel|', nq'|Lastrasaetta|', nq'|Tabla Trueno|', nq'|우뢰플레이트|', nq'|Uroe Plate|', nq'|雷電石板 / 雷电石板|', nq'|Léidiàn Shíbǎn / Lèuihdihn Sehkbáan|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Ultra Ball|', 1, q'|A Poké Ball with a high capture rate.|', nq'|ハイパーボール|', nq'|Hyper Ball|', nq'|Hyper Ball|', nq'|Hyperball|', nq'|Ultra Ball|', nq'|Ultraball|', nq'|하이퍼볼|', nq'|Hyper Ball|', nq'|高級球 / 高级球|', nq'|Gāojí Qiú / Gōukāp Kàuh|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Machine Part|', 3, q'|Take to the Power Plant to restore power to the Magnet Train.|', nq'|きかいのぶひん|'||chr(10)||nq'|マシンパーツ|', nq'|Kikai no Buhin|'||chr(10)||nq'|Machine Part|', nq'|Partie de Machine|'||chr(10)||nq'|Piece Meca.|', nq'|Spule|'||chr(10)||nq'|Ersatzteil|', nq'|Pezzo macch.|'||chr(10)||nq'|Meccanismo|', nq'|Maquinaria|'||chr(10)||nq'|Pieza Esp.|', nq'|기계부품|', nq'|Gigye Bupum|', nq'|機械零件 / 机械零件|', nq'|Jīxiè Língjiàn / Gēihaaih Lìhnggín|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|Niniku Berry|', 3, q'|Pokéblock ingredient. Will become an Enigma Berry if transferred to Generation IV via Pal Park.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Love Ball|', 2, q'|A type of Poké Ball that works better on Pokémon of the opposite gender.|', nq'|ラブラブボール|', nq'|Love-Love Ball|', nq'|Love Ball|', nq'|Sympaball|', nq'|Love Ball|', nq'|Amor Ball|', nq'|러브러브볼|', nq'|Love-Love Ball|', nq'|甜蜜球|', nq'|Tiánmì Qiú / Tìhmmaht Kàuh|', 0);
insert into ITEMS(NAME, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(q'|Loot Sack|', nq'|たからぶくろ|', nq'|Takara Bukuro|', nq'|Sac Butin|', nq'|Beutesack|', nq'|Bottinosacca|', nq'|Saca Botín|', nq'|보물주머니|', nq'|Bomul Jumeoni|', nq'|寶物袋 / 宝物袋|', nq'|Bǎowù Dài / Bóumaht Doih|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Relic Copper|', 5, q'|Can be sold for 1000 to the villa owner in Undella Town.|', nq'|こだいのどうか|', nq'|Kodai no Dōka|', nq'|Vieux Sou|', nq'|Alter Heller|', nq'|Soldantico|', nq'|Real Cobre|', nq'|고대의동화|', nq'|Godae-yi Donghwa|', nq'|古代銅幣 / 古代铜币|', nq'|Gǔdài Tóngbì / Gúdoih Tùhngbaih|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|U-Disk|', 3, q'|Moves the UFO in The Under to Pyrite Town's windmill.|', nq'|Ｕ－ディスク|', nq'|U-Disk|', nq'|Disque-H|', nq'|O-Disc|', nq'|Disco Su|', nq'|Disco S|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Sachet|', 6, q'|Allows Spritzee to evolve when traded.|', nq'|においぶくろ|', nq'|Nioi Bukuro|', nq'|Sachet Senteur|', nq'|Duftbeutel|', nq'|Bustina Aromi|', nq'|Saquito Fragante|', nq'|향기주머니|', nq'|Hyang-gi Jumeoni|', nq'|香袋|', nq'|Xiāngdài / Hēungdoih|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|Topo Berry|', 3, q'|Pokéblock ingredient. If transferred to Generation IV via Pal Park, it will turn into an Enigma Berry.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Ein File S|', 3, q'|Describes Shadow Pokémon.|', nq'|ボルグファイルＤ|', nq'|Borg File D|', nq'|Dossier Teck O|', nq'|Culpa-Akte C-P|', nq'|Genus.File O|', nq'|Parte Ein: O|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Hyper Potion|', 1, q'|Restores 120 HP. (200HP before Gen. VII).|', nq'|すごいキズぐすり|', nq'|Sugoi Kizugusuri|', nq'|Hyper Potion|', nq'|Hypertrank|', nq'|Iperpozione|', nq'|Hiperpoción|', nq'|고급상처약|', nq'|Gogeup Sangcheo Yak|', nq'|厲害傷藥 / 厉害伤药|', nq'|Lìhài Shāngyào / Leihhhoih Sēungyeuhk|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Big Mushroom|', 2, q'|Can be sold for 2500.|', nq'|おおきなキノコ|', nq'|Ōkina Kinoko|', nq'|Gros Champi|', nq'|Riesenpilz|', nq'|Grande Fungo|', nq'|Seta Grande|', nq'|큰버섯|', nq'|Keun Beoseot|', nq'|大蘑菇|', nq'|Dà Mógū / Daaih Mòhgū|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Vs. Seeker|', 3, q'|Used to prompt Trainers for a rematch.|', nq'|バトルサーチャー|', nq'|Battle Searcher|', nq'|Cherche VS|', nq'|Kampffahnder|', nq'|Cercasfide|', nq'|Buscapelea|', nq'|배틀서처|', nq'|Battle Searcher|', nq'|對戰搜尋器 / 对战搜寻器|', nq'|Duìzhàn Sōuxún Qì / Deuijin Sāuchàhm Hei|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Wave Incense|', 4, q'|Raises the power of Water-type moves. A Mantine holding it can breed to produce Mantyke Eggs.|', nq'|さざなみのおこう|', nq'|Sazanami no Okō|', nq'|Encens Vague|', nq'|Wellenrauch|', nq'|Ondaroma|', nq'|Incienso aqua|', nq'|잔물결향로|', nq'|Janmulgyeol Hyangno|', nq'|漣漪薰香 / 涟漪薰香|', nq'|Liányī Xūnxiāng / Lìhnyí Fānhēung|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Mystic Water|', 2, q'|Raises the power of Water-type moves.|', nq'|しんぴのしずく|', nq'|Shinpi no Shizuku|', nq'|Eau Mystique|', nq'|Zauberwasser|', nq'|Acqua Magica|', nq'|Agua Mística|', nq'|신비의물방울|', nq'|Sinbiui Mulbang-ul|', nq'|神秘水滴|', nq'|Shénmì shuǐdī / Sàhnbei Séuidihk|', 32);
insert into ITEMS(NAME, GEN, DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|X Defense|', 1, q'|Raises a Pokémon's Defense by 2 stages (1 stage before Gen. VII).|', q'|Called X Defend prior to Generation VI.|', nq'|ディフェンダー|', nq'|Defender|', nq'|Defense +|', nq'|X-Abwehr|', nq'|Difesa X|', nq'|Defensa X|', nq'|디펜드업|', nq'|Defend-Up|', nq'|防禦強化 / 防御强化|', nq'|Fángyù Qiánghuà / Fòhngyuh Kèuhngfa|', 1024);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Max Ether|', 1, q'|Restores all the PP of a single move.|', nq'|ピーピーリカバー|', nq'|PP Recover|', nq'|Huile Max|', nq'|Top-Äther|', nq'|Etere Max|', nq'|Éter Máximo|', nq'|PP회복|', nq'|PP Hoebok|', nq'|ＰＰ單項全補劑 / ＰＰ单项全补剂|', nq'|PP Dānxiàng Quánbǔjì / PP Dāanhohng Chyùhnbóujaih|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Ground Gem|', 5, q'|Increases the power of the holder's first Ground-type move by 50%, and is consumed after use.|', nq'|じめんのジュエル|', nq'|Jimen no Jewel|', nq'|Joyau Sol|', nq'|Bodenjuwel|', nq'|Bijouterra|', nq'|Gema Tierra|', nq'|땅주얼|', nq'|Ttang Jewel|', nq'|地面寶石 / 地面宝石|', nq'|Dìmiàn Bǎoshí / Deihmín Bóusehk|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Odd Incense|', 4, q'|Raises the power of Psychic-type moves. Mr. Mime holding this can breed Mime Jr.|', nq'|あやしいおこう|', nq'|Oyashii Okō|', nq'|Encens Bizarre|', nq'|Schrägrauch|', nq'|Bizzoaroma|', nq'|Incienso raro|', nq'|괴상한향로|', nq'|Goesanghan Hyangno|', nq'|奇異薰香 / 奇异薰香|', nq'|Qíyì Xūnxiāng / Kèihyih Fānhēung|', 144);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Oak's Letter|', 4, q'|Opens the Seabreak Path and allows the user to face Shaymin.|', nq'|オーキドのてがみ|', nq'|Okido no Tegami|', nq'|Lettre Chen|', nq'|Eichs Brief|', nq'|Lettera di Oak|', nq'|Carta Pr Oak|', nq'|오박사의 편지|', nq'|O-baksa-ui Pyeonji|', nq'|大木的信|', nq'|Dàmù-de Xìn / Daaihmuhk-dīk Seun|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Garchompite|', 6, q'|Allows Garchomp to Mega Evolve into Mega Garchomp.|', nq'|ガブリアスナイト|', nq'|Gaburiasnite|', nq'|Carchacrokite|', nq'|Knakracknit|', nq'|Garchompite|', nq'|Garchompita|', nq'|한카리아스나이트|', nq'|Hankariasnite|', nq'|烈咬陸鯊進化石 / 烈咬陆鲨进化石|', nq'|Lièyǎolùshā Jìnhuà Shí / Lihtngáauhluhksā Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Groundium Z|', 7, q'|Allows a Pokémon to upgrade their Ground-type damaging moves to the Z-Move Tectonic Rage or upgrade their Ground-type status moves into Z-Moves. Makes Arceus a Ground-type Pokémon.|', nq'|ジメンＺ|', nq'|Ground-Z|', nq'|Terrazélite|', nq'|Terrium Z|', nq'|Terrium Z|', nq'|Geostal Z|', nq'|땅Z|', nq'|Ttang-Z|', nq'|地面Ｚ|', nq'|Dìmiàn-Z / Deihmín-Z|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Full Incense|', 4, q'|Causes holder to move slower than the opponent. A Snorlax holding it can breed to produce Munchlax.|', nq'|まんぷくおこう|', nq'|Manpuku Okō|', nq'|Encens Plein|', nq'|Lahmrauch|', nq'|Gonfioaroma|', nq'|Incienso lento|', nq'|만복향로|', nq'|Manbok Hyangno|', nq'|飽腹薰香 / 饱腹薰香|', nq'|Bǎofù Xūnxiāng / Báaufūk Fānhēung|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Sitrus Berry|', 3, q'|Restores 30 HP in Generation III. Restores ¼ of maximum HP from Generation IV onwards.|', nq'|オボンのみ|', nq'|Obon no Mi|', nq'|Baie Sitrus|', nq'|Tsitrubeere|', nq'|Baccacedro|', nq'|Baya Zidra|', nq'|자뭉열매|', nq'|Jamung Yeolmae|', nq'|文柚果|', nq'|Wényòu Guǒ / Màhnyauh Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Gorgeous Box|', 2, q'|Sometimes held by a reward Pokémon from Pokémon Stadium if traded to Generation II.|', nq'|きりのはこ|', nq'|Kiri no Hako|', nq'|Coffre Luxe|', nq'|Schatulle|', nq'|Scat. Lusso|', nq'|Caja Grande|', nq'|오동나무상자|', nq'|Odongnamu Sangja|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Coupon 2|', 4, q'|Used to obtain the Pokétch in Jubilife City.|', nq'|ひきかえけん２|', nq'|Hikikaeken 2|', nq'|Bon 2|', nq'|Kupon 2|', nq'|Coupon 2|', nq'|Cupón 2|', nq'|교환권 2|', nq'|Gyohwangwon 2|', nq'|兌換券２ / 兑换券２|', nq'|Duìhuàn Quàn 2 / Deuiwuhn Hyun 2|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Guard Spec.|', 1, q'|Temporarily prevents stat reduction.|', nq'|エフェクトガード|', nq'|Effect Guard|', nq'|Defense Spec|', nq'|Megablock|', nq'|Superguardia|', nq'|Protec. Esp.|', nq'|이펙트가드|', nq'|Effect Guard|', nq'|能力防守|', nq'|Nénglì Fángshǒu / Nàhnglihk Fòhngsáu|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Shuca Berry|', 4, q'|Reduces damage taken from a super effective Ground-type move.|', nq'|シュカのみ|', nq'|Shuca no Mi|', nq'|Baie Jouca|', nq'|Schukebeere|', nq'|Baccanaca|', nq'|Baya Acardo|', nq'|슈캐열매|', nq'|Shewca Yeolmae|', nq'|腰木果|', nq'|Yāomù Guǒ / Yīumuhk Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Bike Voucher|', 1, q'|Used to pay for a Bicycle.|', nq'|ひきかえけん|', nq'|Hikikaeken|', nq'|Bon Commande|', nq'|Rad Coupon|', nq'|Buono Bici|', nq'|Bono Bici|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Meteorite|', 3, q'|Deliver to Professor CozmoRSE or Lostelle's fatherFRLG. Enables the Rayquaza featured in the Delta Episode to Mega Evolve.ORAS|', nq'|いんせき|', nq'|Inseki|', nq'|Météorite|', nq'|Meteorit|', nq'|Meteorite|', nq'|Meteorito|', nq'|운석|', nq'|Unseok|', nq'|隕石 / 陨石|', nq'|Yǔnshí / Wáhnsehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Sky Plate|', 4, q'|Raises the power of Flying-type moves.|', nq'|あおぞらプレート|', nq'|Aozora Purēto|', nq'|Plaque Ciel|', nq'|Wolkentafel|', nq'|Lastracielo|', nq'|Tabla Cielo|', nq'|푸른하늘플레이트|', nq'|Pureun Haneul Plate|', nq'|藍天石板 / 蓝天石板|', nq'|Lántiān Shíbǎn / Làahmtīn Sehkbáan|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Beast Ball|', 7, q'|Allows the player to catch wild Pokémon; works better on Ultra Beasts.|', nq'|ウルトラボール|', nq'|Ultra Ball|', nq'|Ultra Ball|', nq'|Ultraball|', nq'|UC Ball|', nq'|Ente Ball|', nq'|울트라볼|', nq'|Ultra Ball|', nq'|究極球 / 究极球|', nq'|Jiūjí Qiú / Gaugihk Kàuh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Bead Mail|', 3, q'|A bead-printed stationery. To be held by a Pokémon for delivery.|', nq'|トレジャーメール|', nq'|Treasure Mail|', nq'|Lettre Bulle|', nq'|Perlenbrief|', nq'|Mess. Perle|', nq'|Carta Imagen|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|L-Disk|', 3, q'|Moves the UFO in The Under to the Amulet Coin.|', nq'|Ｌ－ディスク|', nq'|L-Disk|', nq'|Disque-G|', nq'|L-Disc|', nq'|Disco Sx|', nq'|Disco I|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Inquiry Mail|', 5, q'|Stationary for writing questions. To be held by a Pokémon for delivery.|', nq'|しつもんメール|', nq'|Shitsumon Mail|', nq'|Let. Demande|', nq'|Fragebrief|', nq'|Mess. Chiedi|', nq'|C. Pregunta|', nq'|질문메일|', nq'|Jilmun Mail|', nq'|詢問郵件 / 询问邮件|', nq'|Xúnwèn Yóujiàn / Sēunmahn Yàuhgín|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Berry Juice|', 2, q'|Restores 20 HP.|', nq'|きのみジュース|', nq'|Kinomi Juice|', nq'|Jus De Baie|', nq'|Beerensaft|', nq'|Succo di Bacca|', nq'|Zumo de Baya|', nq'|나무열매쥬스|', nq'|Namu Yeolmae Juice|', nq'|樹果汁 / 树果汁|', nq'|Shù Guǒzhī / Syuh Gwójāp|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Psychium Z|', 7, q'|Allows a Pokémon to upgrade their Psychic-type damaging moves to the Z-Move Shattered Psyche or upgrade their Psychic-type status moves into Z-Moves. Makes Arceus a Psychic-type Pokémon.|', nq'|エスパーＺ|', nq'|Esper-Z|', nq'|Psychézélite|', nq'|Psium Z|', nq'|Psichium Z|', nq'|Psicostal Z|', nq'|에스퍼Z|', nq'|Esper-Z|', nq'|超能力Ｚ|', nq'|Chāonénglì-Z / Chīunàhnglihk-Z|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Diancite|', 6, q'|Allows Diancie to Mega Evolve into Mega Diancie.|', nq'|ディアンシナイト|', nq'|Diancinite|', nq'|Diancite|', nq'|Diancienit|', nq'|Diancite|', nq'|Diancita|', nq'|디안시나이트|', nq'|Diancienite|', nq'|蒂安希進化石 / 蒂安希进化石|', nq'|Dì'ānxī Jìnhuà Shí / Dai'ōnhēi Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Ylw ID Badge|', 3, q'|One of four keys needed to unlock the north door of Realgam Tower.|', nq'|ＩＤバッジきいろ|', nq'|ID Badge Kīro|', nq'|Passe Jaune|', nq'|Gelbe ID-Marke|', nq'|Pass Giallo|', nq'|P. Amarillo|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Flyinium Z|', 7, q'|Allows a Pokémon to upgrade their Flying-type damaging moves to the Z-Move Supersonic Skystrike or upgrade their Flying-type status moves into Z-Moves. Makes Arceus a Flying-type Pokémon.|', nq'|ヒコウＺ|', nq'|Flying-Z|', nq'|Aérozélite|', nq'|Aerium Z|', nq'|Volantium Z|', nq'|Aerostal Z|', nq'|비행Z|', nq'|Bihaeng-Z|', nq'|飛行Ｚ / 飞行Ｚ|', nq'|Fēixíng-Z / Fēihàhng-Z|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|BridgeMail S|', 5, q'|Stationary with a sky-piercing bridge print. To be held by a Pokémon for delivery.|', nq'|ブリッジメールＳ|', nq'|Bridge Mail S|', nq'|Lettre PontS|', nq'|Brückbrief H|', nq'|Mess. Frec.|', nq'|C. Puente S|', nq'|브리지메일S|', nq'|Bridge Mail S|', nq'|橋梁郵件Ｓ / 桥梁邮件Ｓ|', nq'|Qiáoliáng Yóujiàn S / Kìuhlèuhng Yàuhgín S|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Damp Mulch|', 4, q'|Causes the soil to dry out more slowly, but also causes the Berry plant to grow more slowly.|', nq'|じめじめこやし|', nq'|Jimejime Koyashi|', nq'|Fertihumide|', nq'|Feuchtmulch|', nq'|Fertilidro|', nq'|Abono Lento|', nq'|축축이비료|', nq'|Chukchug'i Biryo|', nq'|濕濕肥 / 湿湿肥|', nq'|Shīshī Féi / Sāpsāp Fèih|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Town Map|', 1, q'|Contains an interactive map of the region and where the player is at the time.|', nq'|タウンマップ|', nq'|Town Map|', nq'|Carte|', nq'|Karte|', nq'|Mappa|', nq'|Mapa|', nq'|타운맵|', nq'|Town Map|', nq'|城鎮地圖 / 城镇地图|', nq'|Chéngzhèn Dìtú / Sìhngjan Deihtòuh|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Everstone|', 2, q'|A hold item that prevents the holder from evolving.|', nq'|かわらずのいし|', nq'|Kawarazu no Ishi|', nq'|Pierre Stase|', nq'|Ewigstein|', nq'|Pietrastante|', nq'|Piedra Eterna|', nq'|변함없는돌|', nq'|Byeonhameomneun Dol|', nq'|不變之石 / 不变之石|', nq'|Bùbiàn-zhī Shí / Bātbin-jī Sehk|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Elevator Key|', 3, q'|Unlocks the elevator in Pyrite Bldg giving the player access to The Under.|', nq'|エレベーターキー|'||chr(10)||nq'|エレベーターのキー|', nq'|Elevator Key|'||chr(10)||nq'|Elevator no Key|', nq'|Cle Ascens.*|'||chr(10)||nq'|Clé Ascenseur|', nq'|Liftkarte*|'||chr(10)||nq'|Liftschlüssel|', nq'|Chiave Asc.|'||chr(10)||nq'|Chiave ascensore|', nq'|Ll. Ascensor|'||chr(10)||nq'|Llave Ascensor|', nq'|엘리베이터키|', nq'|Elevator Key|', nq'|電梯鑰匙 / 电梯钥匙|', nq'|Diàntī Yàoshi / Dihntāi Yeuhksìh|', 192);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Data ROM|', 3, q'|Holds data on Shadow Pokémon.|', nq'|データロム|', nq'|Data ROM|', nq'|Disque-ROM|', nq'|CD-ROM|', nq'|CD ROM|', nq'|Disquete|', 32);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Figy Berry|', 3, q'|When HP falls below 25%, restores 50% HP, but confuses Pokémon that dislike spicy food (12.5% when below 50% before Gen. VII).|', nq'|フィラのみ|', nq'|Fira no Mi|', nq'|Baie Figuy|', nq'|Giefebeere|', nq'|Baccafico|', nq'|Baya Higog|', nq'|무화열매|', nq'|Muhwa Yeolmae|', nq'|勿花果|', nq'|Wùhuā Guǒ / Mahtfā Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Absolite|', 6, q'|Allows Absol to Mega Evolve into Mega Absol.|', nq'|アブソルナイト|', nq'|Absolnite|', nq'|Absolite|', nq'|Absolnit|', nq'|Absolite|', nq'|Absolita|', nq'|앱솔나이트|', nq'|Absolnite|', nq'|阿勃梭魯進化石 / 阿勃梭鲁进化石|', nq'|Ābósuōlǔ Jìnhuà Shí / Abuhtsōlóuh Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Steelixite|', 6, q'|Allows Steelix to Mega Evolve into Mega Steelix.|', nq'|ハガネールナイト|', nq'|Haganeilnite|', nq'|Steelixite|', nq'|Stahlosnit|', nq'|Steelixite|', nq'|Steelixita|', nq'|강철톤나이트|', nq'|Gangcheoltonnite|', nq'|大鋼蛇進化石 / 大钢蛇进化石|', nq'|Dàgāngshé Jìnhuà Shí / Daaihgongsèh Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Sapphire|', 3, q'|To be given to Celio along with Ruby to set up the Network Machine of the Pokémon Network Center, allowing the player to trade with Ruby, Sapphire, and Emerald.|', nq'|サファイア|', nq'|Sapphire|', nq'|Saphir|', nq'|Saphir|', nq'|Zaffiro|', nq'|Zafiro|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Aguav Berry|', 3, q'|When HP falls below 25%, restores 50% HP, but confuses Pokémon that dislike bitter food (12.5% when below 50% before Gen. VII).|', nq'|バンジのみ|', nq'|Banji no Mi|', nq'|Baie Gowav|', nq'|Gauvebeere|', nq'|Baccaguava|', nq'|Baya Guaya|', nq'|아바열매|', nq'|Ava Yeolmae|', nq'|樂芭果 / 乐芭果|', nq'|Lèbā Guǒ / Lohkbā Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|R-Disk|', 3, q'|Moves the UFO in The Under to the Under TV Station.|', nq'|Ｒ－ディスク|', nq'|R-Disk|', nq'|Disque-D|', nq'|R-Disc|', nq'|Disco Dx|', nq'|Disco D|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Flame Plate|', 4, q'|Raises the power of Fire-type moves.|', nq'|ひのたまプレート|', nq'|Hi no Tama Purēto|', nq'|Plaque Flam|', nq'|Feuertafel|', nq'|Lastrarogo|', nq'|Tabla Llama|', nq'|불구슬플레이트|', nq'|Bulguseul Plate|', nq'|火球石板|', nq'|Huǒqiú Shíbǎn / Fókàuh Sehkbáan|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|BridgeMail M|', 5, q'|Stationary with an arched bridge print. To be held by a Pokémon for delivery.|', nq'|ブリッジメールＷ|', nq'|Bridge Mail W|', nq'|Lettre PontI|', nq'|Brückbrief W|', nq'|Mess. Merav.|', nq'|C. Puente P|', nq'|브리지메일W|', nq'|Bridge Mail W|', nq'|橋梁郵件Ｗ / 桥梁邮件Ｗ|', nq'|Qiáoliáng Yóujiàn W / Kìuhlèuhng Yàuhgín W|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Whipped Dream|', 6, q'|Allows Swirlix to evolve when traded.|', nq'|ホイップポップ|', nq'|Whip Pop|', nq'|Chantibonbon|', nq'|Sahnehäubchen|', nq'|Dolcespuma|', nq'|Dulce de Nata|', nq'|휘핑팝|', nq'|Whipping Pop|', nq'|泡沫奶油|', nq'|Pàomò nǎiyóu / Póuhmuht Náaihyàuh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Apricorn Box|', 4, q'|Contains Apricorns.|', nq'|ぼんぐりケース|', nq'|Bonguri Case|', nq'|Bte Noigrume|', nq'|Aprikokobox|', nq'|Ghicobox|', nq'|Caja Bonguri|', nq'|규토리케이스|', nq'|Gyutori Case|', nq'|球果盒|', nq'|Qiúguǒ Hé / Kàuhgwó Hahp|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Light Clay|', 4, q'|Extends the duration of the moves Reflect and Light Screen.|', nq'|ひかりのねんど|', nq'|Hikari no Nendo|', nq'|Lumargile|', nq'|Lichtlehm|', nq'|Creta Luce|', nq'|Refleluz|', nq'|빛의점토|', nq'|Bichui Jeomto|', nq'|光之黏土|', nq'|Guāng-zhī Niántǔ / Gwōng-jī Nìhmtóu|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Wood Mail|', 3, q'|Mail with picture of a Slakoth.|', nq'|ウッディメール|', nq'|Woody Mail|', nq'|Lettre Bois|', nq'|Waldbrief|', nq'|Mess. Bosco|', nq'|Carta Madera|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Sweet Heart|', 5, q'|A very sugary chocolate. It restores one Pokémon's HP by 20.|', nq'|ハートスイーツ|', nq'|Heart Sweets|', nq'|Chococœur|', nq'|Herzkonfekt|', nq'|Dolcecuore|', nq'|Corazón Dulce|', nq'|하트스위트|', nq'|Sweet Heart|', nq'|心形甜點 / 心形甜点|', nq'|Xīnxíng Tiándiǎn / Sāmyìhng Tìhmdím|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Pink Nectar|', 7, q'|Changes Oricorio to its Pa'u Style.|', nq'|うすもものミツ|', nq'|Usumomo no Mitsu|', nq'|Nectar Rose|', nq'|Rosa Nektar|', nq'|Nettare rosa|', nq'|Néctar Rosa|', nq'|연분홍꿀|', nq'|Yeonbunhong Kkul|', nq'|桃粉色花蜜|', nq'|Táofěn-sè Huāmì / Tòuhfán-sīk Fāmaht|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Power Belt|', 4, q'|Promotes Defense EVs, but lowers Speed in battle.|', nq'|パワーベルト|', nq'|Power Belt|', nq'|Ceinture Pouvoir|', nq'|Machtgurt|', nq'|Vigorfascia|', nq'|Cinto Recio|', nq'|파워벨트|', nq'|Power Belt|', nq'|力量腰帶 / 力量腰带|', nq'|Lìliàng Yāodài / Lihkleuhng Yīudáai|', 128);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Fire Gem|', 5, q'|Increases the power of the holder's first Fire-type move by 50%, and is consumed after use.|', nq'|ほのおのジュエル|', nq'|Honō no Jewel|', nq'|Joyau Feu|', nq'|Feuerjuwel|', nq'|Bijoufuoco|', nq'|Gema Fuego|', nq'|불꽃주얼|', nq'|Bulkkot Jewel|', nq'|火之寶石 / 火之宝石|', nq'|Huǒ-zhī Bǎoshí / Fó-jī Bóusehk|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Pokéblock Kit|', 6, q'|Allows the player to make and store Pokéblocks.|', nq'|ポロックキット|', nq'|Polock Kit|', nq'|Kit Pokébloc|', nq'|Pokériegel-Set|', nq'|Kit Pokémelle|', nq'|Kit de Pokécubos|', nq'|포켓몬스넥키트|', nq'|Pokémon Snack Kit|', nq'|寶可方塊組合*|'||chr(10)||nq'|宝可方块套装|', nq'|Bǎokě Fāngkuài Zǔhé / Bóuhó Fōngfaai Jóuhahp*|'||chr(10)||nq'|Bǎokě Fāngkuài Tàozhuāng|', 3);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Great Ball|', 1, q'|A moderately good type of Poké Ball.|', nq'|スーパーボール|', nq'|Super Ball|', nq'|Super Ball|', nq'|Superball|', nq'|Mega Ball|', nq'|Superball|', nq'|수퍼볼|', nq'|Super Ball|', nq'|超級球 / 超级球|', nq'|Chāojí Qiú / Chīukāp Kàuh|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Eevium Z|', 7, q'|Allows Eevee to upgrade Last Resort to the special Z-Move Extreme Evoboost.|', nq'|イーブイＺ|', nq'|Eievui-Z|', nq'|Évolizélite|', nq'|Evolium Z|', nq'|Eevium Z|', nq'|Eeveestal Z|', nq'|이브이Z|', nq'|Eevee-Z|', nq'|伊布Ｚ|', nq'|Yībù-Z / Yībou-Z|', 0);
insert into ITEMS(NAME, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(q'|Mega Cuff|', nq'|メガブレス|', nq'|Mega Brace|', nq'|Méga-Manchette|', nq'|Mega-Armbänder|', nq'|Megapolsiera|', nq'|Megabrazalete|', nq'|메가블레스|', nq'|Mega Brace|', nq'|超級護腕 / 超级护腕|', nq'|Chāojí Hùwàn / Chīukāp Wuhwún|');
insert into ITEMS(NAME, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(q'|Key Stone|', nq'|キーストーン|', nq'|Key Stone|', nq'|Gemme Sésame|', nq'|Schlüssel-Stein|', nq'|Pietrachiave|', nq'|Piedra Activadora|', nq'|키스톤|', nq'|Key Stone|', nq'|鑰石 / 钥石|', nq'|Yàoshí / Yeuhksehk|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Liberty Pass|', 5, q'|Gives access to Liberty Garden.|', nq'|リバティチケット|', nq'|Liberty Ticket|', nq'|Passe Liberté|', nq'|Gartenpass|', nq'|Liberticket|', nq'|Ticket Libertad|', nq'|리버티티켓|', nq'|Liberty Ticket|', nq'|自由船票|', nq'|Zìyóu Chuánpiào / Jihyàuh Syùhnpiu|', 128);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Chilan Berry|', 3, q'|Pokéblock ingredient.|', nq'|ホズのみ|', nq'|Hozu no Mi|', nq'|Baie Zalis|', nq'|Latchibeere|', nq'|Baccacinlan|', nq'|Baya Chilan|', nq'|카리열매|', nq'|Kari Yeolmae|', nq'|燈漿果 / 燈漿果|', nq'|Dēngjiāng Guǒ / Dāngjēung Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Red Chain|', 4, q'|A mythical chain linked to the legendary Pokémon of the Sinnoh region. Unobtainable without cheating.|', nq'|あかいくさり|', nq'|Akai Kusari|', nq'|Chaîne Rouge|', nq'|Rote Kette|', nq'|Rossocatena|', nq'|Cadena Roja|', nq'|빨강쇠사슬|', nq'|Ppalgang Soesaseul|', nq'|紅色鎖鏈 / 红色锁链|', nq'|Hóng-sè Suǒliàn / Hùhng-sīk Sólín|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Lucky Egg|', 2, q'|Doubles the experience gained during battle.|', nq'|しあわせタマゴ|', nq'|Shiawase Tamago|', nq'|Œuf Chance|', nq'|Glücks-Ei|', nq'|Fortunuovo|', nq'|Huevo Suerte|', nq'|행복의알|', nq'|Haengbogui Al|', nq'|幸運蛋 / 幸运蛋|', nq'|Xìngyùn Dàn / Hahngwahn Daahn|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Egg Ticket|', 2, q'|Can be exchanged for the Odd Egg.|', nq'|タマゴけん|', nq'|Tamago Ken|', nq'|Ticket Oeuf|', nq'|Ei-Ticket|', nq'|Bigl.Uovo|', nq'|Ticket Huevo|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Lum Berry|', 3, q'|Cures any status condition.|', nq'|ラムのみ|', nq'|Ramu no Mi|', nq'|Baie Prine|', nq'|Prunusbeere|', nq'|Baccaprugna|', nq'|Baya Ziuela|', nq'|리샘열매|', nq'|Risaem Yeolmae|', nq'|木子果|', nq'|Mùzi Guǒ / Muhkjí Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|X Special 3|', 5, q'|Drastically raises a Pokémon's Special Attack. Wonder Launcher only.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Vivid Scent|', 3, q'|Reduces the heart gauge by a large amount and increases friendship.|', nq'|ドキドキのかおり|', nq'|Dokidoki no Kaori|', nq'|P. Palpitant|', nq'|Paradies-E.|', nq'|Olio Sublime|', nq'|Ar. Energía|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Relic Crown|', 5, q'|Can be sold for 300000 to the villa owner in Undella Town.|', nq'|こだいのおうかん|', nq'|Kodai no Ōkan|', nq'|Vieux Tortil|', nq'|Alte Krone|', nq'|Coronantica|', nq'|Corona Antigua|', nq'|고대의왕관|', nq'|Godae-yi Wanggwan|', nq'|古代王冠|', nq'|Gǔdài Wángguàn / Gúdoih Wòhnggūn|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Protein|', 1, q'|Raises the Attack of a Pokémon.|', nq'|タウリン|', nq'|Taurine|', nq'|Proteine|', nq'|Protein|', nq'|Proteina|', nq'|Proteína|', nq'|타우린|', nq'|Taurine|', nq'|攻擊增強劑 / 攻击增强剂|', nq'|Gōngjí Zēngqiángjì / Gūnggīk Jāngkèuhngjaih|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Manectite|', 6, q'|Allows Manectric to Mega Evolve into Mega Manectric.|', nq'|ライボルトナイト|', nq'|Livoltnite|', nq'|Élecsprintite|', nq'|Voltensonit|', nq'|Manectricite|', nq'|Manectricita|', nq'|썬더볼트나이트|', nq'|Thundervoltnite|', nq'|雷電獸進化石 / 雷电兽进化石|', nq'|Léidiànshòu Jìnhuà Shí / Lèuihdihnsau Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Ghostium Z|', 7, q'|Allows a Pokémon to upgrade their Ghost-type damaging moves to the Z-Move Never-Ending Nightmare or upgrade their Ghost-type status moves into Z-Moves. Makes Arceus a Ghost-type Pokémon.|', nq'|ゴーストＺ|', nq'|Ghost-Z|', nq'|Spectrozélite|', nq'|Phantomium Z|', nq'|Spectrium Z|', nq'|Espectrostal Z|', nq'|고스트Z|', nq'|Ghost-Z|', nq'|幽靈Ｚ / 幽灵Ｚ|', nq'|Yōulíng-Z / Yāulìhng-Z|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Splash Plate|', 4, q'|Raises the power of Water-type moves.|', nq'|しずくプレート|', nq'|Shizuku Purēto|', nq'|Plaque Hydro|', nq'|Wassertafel|', nq'|Lastraidro|', nq'|Tabla Linfa|', nq'|물방울플레이트|', nq'|Mulbang-ul Plate|', nq'|水滴石板|', nq'|Shuǐdī Shíbǎn / Séuidihk Sehkbáan|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Heal Ball|', 4, q'|A type of Poké Ball that heals the captured Pokémon before it is put in the player's party. If the player's party is full, it will be transferred to the Box, where it would have been healed anyway.|', nq'|ヒールボール|', nq'|Heal Ball|', nq'|Soin Ball|', nq'|Heilball|', nq'|Cura Ball|', nq'|Sana Ball|', nq'|힐볼|', nq'|Heal Ball|', nq'|治癒球 / 治愈球|', nq'|Zhìyù Qiú / Jihyuh Kàuh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Dubious Disc|', 4, q'|A hold item that allows Porygon2 to evolve when traded.|', nq'|あやしいパッチ|', nq'|Ayashii Patch|', nq'|CD Douteux|', nq'|Dubiosdisc|', nq'|Dubbiodisco|', nq'|Discoxtraño|', nq'|괴상한패치|', nq'|Goesanghan Patch|', nq'|可疑補丁 / 可疑补丁|', nq'|Kěyí Bǔdīng / Hóyìh Bóudīng|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|X Attack 2|', 5, q'|Sharply raises a Pokémon's Attack. Wonder Launcher only.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Griseous Orb|', 4, q'|Raises the power of Giratina's Ghost- and Dragon-type moves, and causes it to take on its Origin Forme.|', nq'|はっきんだま|', nq'|Hakkin Dama|', nq'|Orbe Platiné|', nq'|Platinum-Orb|', nq'|Grigiosfera|', nq'|Griseosfera|', nq'|백금옥|', nq'|Baekgeum Ok|', nq'|白金寶珠 / 白金宝珠|', nq'|Báijīn Bǎozhū / Baahkgām Bóujyū|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Normal Gem|', 5, q'|Increases the power of the holder's first Normal-type move by 50%, and is consumed after use.|', nq'|ノーマルジュエル|', nq'|Normal Jewel|', nq'|Joyau Normal|', nq'|Normaljuwel|', nq'|Bijounormale|', nq'|Gema Normal|', nq'|노말주얼|', nq'|Normal Jewel|', nq'|一般寶石 / 一般宝石|', nq'|Yībān Bǎoshí / Yātbūn Bóusehk|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Mayor's Note|', 3, q'|A letter from the Mayor to Justy.|', nq'|しちょうのてがみ|', nq'|Shichō no Tegami|', nq'|Lettre Maire|', nq'|Zettel|', nq'|Nota Sindaco|', nq'|Nota Alcalde|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Grass Memory|', 7, q'|Makes Silvally a Grass-type Pokémon and makes Multi-Attack a Grass-type move.|', nq'|グラスメモリ|', nq'|Grass Memory|', nq'|ROM Plante|', nq'|Pflanzen-Disc|', nq'|ROM Erba|', nq'|Disco Planta|', nq'|그래스메모리|', nq'|Grass Memory|', nq'|青草記憶碟*|'||chr(10)||nq'|青草存储碟|', nq'|Qīngcǎo Jìyìdié / Chīngchóu Geiyīkdihp*|'||chr(10)||nq'|Qīngcǎo Cúnchǔdié|', 3);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Gold Berry|', 2, q'|Restores 30 HP.|', nq'|おうごんのみ|', nq'|Ōgon no Mi|', nq'|Baie Doree|', nq'|Goldbeere|', nq'|Bacca Oro|', nq'|Baya Dorada|', nq'|황금열매|', nq'|Hwanggeum Yeolmae|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Small Tablet|', 3, q'|Used to activate the Relic Stone.|', nq'|ちいさなせきばん|', nq'|Chīsa na Sekiban|', nq'|Ardoise|', nq'|Steintafel|', nq'|Tavola|', nq'|Tablilla|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Poison Barb|', 2, q'|Raises the power of Poison-type moves.|', nq'|どくバリ|', nq'|Doku Bari|', nq'|Pic Venin|', nq'|Giftstich|', nq'|Velenaculeo|', nq'|Flecha Venenosa|', nq'|독바늘|', nq'|Dokbaneul|', nq'|毒針 / 毒针|', nq'|Dúzhēn / Duhkjām|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Micle Berry|', 4, q'|Raises a move's accuracy just once when HP is below ⅓ of maximum.|', nq'|ミクルのみ|', nq'|Micle no Mi|', nq'|Baie Micle|', nq'|Wunfrubeere|', nq'|Baccaracolo|', nq'|Baya Lagro|', nq'|미클열매|', nq'|Micle Yeolmae|', nq'|奇秘果|', nq'|Qímì Guǒ / Kèihbīt Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Chople Berry|', 4, q'|Reduces damage from a super effective Fighting-type move by 50%.|', nq'|ヨプのみ|', nq'|Yop no Mi|', nq'|Baie Pomroz|', nq'|Rospelbeere|', nq'|Baccarosmel|', nq'|Baya Pomaro|', nq'|로플열매|', nq'|Ropeul Yeolmae|', nq'|蓮蒲果 / 莲蒲果|', nq'|Liánpú Guǒ / Lìhnpòuh Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Ein File H|', 3, q'|Describes Hyper Mode.|', nq'|ボルグファイルＨ|', nq'|Borg File H|', nq'|Dossier Teck H|', nq'|Culpa-Akte F-M|', nq'|Genus.File I|', nq'|Parte Ein: H|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Casteliacone|', 5, q'|Cures any status condition.|', nq'|ヒウンアイス|', nq'|Hiun Ice|', nq'|Glace Volute|', nq'|Stratos-Eis|', nq'|Conostropoli|', nq'|Porcehelado|', nq'|구름아이스|', nq'|Gureum Ice|', nq'|飛雲冰淇淋 / 飞云冰淇淋|', nq'|Fēiyún Bīngqílín / Fēiwàhn Bīngkèihlàhm|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|Ginema Berry|', 3, q'|Raises a lowered stat in battle. If transferred to Generation IV via Pal Park, it will turn into an Enigma Berry.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Fast Ball|', 2, q'|A type of Poké Ball that works better on Pokémon that try to flee.|', nq'|スピードボール|', nq'|Speed Ball|', nq'|Speed Ball|', nq'|Turboball|', nq'|Rapid Ball|', nq'|Rapid Ball|', nq'|스피드볼|', nq'|Speed Ball|', nq'|速度球|', nq'|Sùdù Qiú / Chūkdouh Kàuh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Yellow Petal|', 7, q'|A yellow petal required to complete Mina's Trial.|', nq'|きいろのはなびら|', nq'|Kiiro no Hanabira|', nq'|Pétale Jaune|', nq'|Gelbes Blatt|', nq'|Petalo giallo|', nq'|Pétalo Amarillo|', nq'|노랑꽃잎|', nq'|Norang Kkochip|', nq'|黃色花瓣 / 黄色花瓣|', nq'|Huáng-sè Huābàn / Wòhng-sīk Fāfáan|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Rockium Z|', 7, q'|Allows a Pokémon to upgrade their Rock-type damaging moves to the Z-Move Continental Crush or upgrade their Rock-type status moves into Z-Moves. Makes Arceus a Rock-type Pokémon.|', nq'|イワＺ|', nq'|Rock-Z|', nq'|Rocazélite|', nq'|Petrium Z|', nq'|Petrium Z|', nq'|Litostal Z|', nq'|바위Z|', nq'|Bawi-Z|', nq'|岩石Ｚ|', nq'|Yánshí-Z / Ngàahmsehk-Z|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Jade Orb|', 4, q'|Allows the player to encounter Rayquaza in the Embedded Tower.|', nq'|もえぎいろのたま|', nq'|Moegiiro no Tama|', nq'|Orbe Vert|', nq'|Grüne Kugel|', nq'|Sfera Verde|', nq'|Esfera Verde|', nq'|연둣빛구슬|', nq'|Yeondutbit Guseul|', nq'|草綠色寶珠 / 草绿色宝珠|', nq'|Cǎolǜ-sè Bǎo Zhū / Chóuluhk-sīk Bóujyū|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Dawn Stone|', 4, q'|Allows Kirlia (♂) and Snorunt (♀) to evolve.|', nq'|めざめいし|', nq'|Mezame Ishi|', nq'|Pierre Aube|', nq'|Funkelstein|', nq'|Pietralbore|', nq'|Piedra Alba|', nq'|각성의돌|', nq'|Gakseong-ui Dol|', nq'|覺醒之石 / 觉醒之石|', nq'|Juéxǐng-zhī Shí / Gokséng-jī Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Bloom Mail|', 4, q'|A flower-printed stationery. To be held by a Pokémon for delivery.|', nq'|ブルームメール|', nq'|Bloom Mail|', nq'|Lett. Pétale|', nq'|Blütenbrief|', nq'|Mess. Petalo|', nq'|Carta Flores|', nq'|블룸메일|', nq'|Bloom Mail|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Scanner|', 3, q'|To be exchanged for a Deep Sea Scale or Deep Sea Tooth.|', nq'|たんちき|', nq'|Tanchiki|', nq'|Scanner|', nq'|Scanner|', nq'|Scanner|', nq'|Escáner|', nq'|탐지기|', nq'|Tamjigi|', nq'|探測器 / 探测器|', nq'|Tàncèqì / Taamchākhei|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Professor's Mask|', 7, q'|Returned to Professor Kukui at Malie Garden.|', nq'|はかせのふくめん|', nq'|Hakase no Fukumen|', nq'|Masque du Prof|', nq'|Maske des Profs|', nq'|Maschera Prof.|', nq'|Máscara Profesor|', nq'|박사의복면|', nq'|Bagsaui Bogmyeon|', nq'|博士的面罩|', nq'|Bóshì-de Miànzhào / Boksih-dīk Mihnjaau|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Soothe Bell|', 2, q'|Causes the holder to gain friendship more quickly.|', nq'|やすらぎのすず|', nq'|Yasuragi no Suzu|', nq'|Grelot Zen|', nq'|Sanftglocke|', nq'|Calmanella|', nq'|Campana Alivio|', nq'|평온의방울|', nq'|Pyeong'on-ui Bang-ul|', nq'|安撫之鈴 / 安抚之铃|', nq'|Ānfǔ-zhī Líng / Ōnfú-jī Lìhng|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Gonzap's Key|', 3, q'|Opens an item box containing TM30 (Shadow Ball).|', nq'|ゴンザのカギ|', nq'|Gonza no Key|', nq'|Cle Helgonza|', nq'|Schlüssel|', nq'|Chiave Helg.|', nq'|Llave Golka|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Lopunnite|', 6, q'|Allows Lopunny to Mega Evolve into Mega Lopunny.|', nq'|ミミロップナイト|', nq'|Mimilopnite|', nq'|Lockpinite|', nq'|Schlapornit|', nq'|Lopunnite|', nq'|Lopunnita|', nq'|이어롭나이트|', nq'|Ieoropnite|', nq'|長耳兔進化石 / 长耳兔进化石|', nq'|Cháng'ěrtù Jìnhuà Shí / Chèuhngyíhtou Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Protective Pads|', 7, q'|Protects the holder from effects caused by using moves that make contact with the target.|', nq'|ぼうごパット|', nq'|Bōgo Pad|', nq'|Pare-Effet|', nq'|Schutzpolster|', nq'|Smorzaurti|', nq'|Paracontacto|', nq'|방호패드|', nq'|Bangho Pad|', nq'|部位護具 / 部位护具|', nq'|Bùwèi Hùjù / Bouhwaih Wuhgeuih|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Gram 2|', 5, q'|An important letter which Wingull delivers.|', nq'|はいたつぶつ２|', nq'|Haitatsubutsu 2|', nq'|Courrier 2|', nq'|Briefpost 2|', nq'|Missiva 2|', nq'|Envío 2|', nq'|배달물2|', nq'|Baedalmul 2|', nq'|配送物品２|', nq'|Pèisòng Wùpǐn 2 / Puisung Mahtbán 2|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Potion|', 1, q'|Restores 20 HP.|', nq'|キズぐすり|', nq'|Kizu Gusuri|', nq'|Potion|', nq'|Trank|', nq'|Pozione|', nq'|Poción|', nq'|상처약|', nq'|Sangcheo Yak|', nq'|傷藥 / 伤药|', nq'|Shāngyào / Sēungyeuhk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Super Repel|', 1, q'|Prevents wild Pokémon with a lower level than the first member of the party from appearing for 200 steps|', nq'|シルバースプレー|', nq'|Silver Spray|', nq'|Superepousse|', nq'|Superschutz|', nq'|Superrepellente|', nq'|Superrepelente|', nq'|실버스프레이|', nq'|Silver Spray|', nq'|白銀噴霧 / 白银喷雾|', nq'|Báiyín Pēnwù / Baahkngàhn Panmouh|', 48);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Power Anklet|', 4, q'|Promotes Speed EVs, but lowers Speed in battle.|', nq'|パワーアンクル|', nq'|Power Ankle|', nq'|Chaîne Pouvoir|', nq'|Machtkette|', nq'|Vigorgliera|', nq'|Franja Recia|', nq'|파워앵클릿|', nq'|Power Anklet|', nq'|力量護踝 / 力量护踝|', nq'|Lìliàng Hùhuái / Lihkleuhng Wuhwahng|', 128);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Coupon 1|', 4, q'|Used to obtain the Pokétch in Jubilife City.|', nq'|ひきかえけん１|', nq'|Hikikaeken 1|', nq'|Bon 1|', nq'|Kupon 1|', nq'|Coupon 1|', nq'|Cupón 1|', nq'|교환권 1|', nq'|Gyohwangwon 1|', nq'|兌換券１ / 兑换券１|', nq'|Duìhuàn Quàn 1 / Deuiwuhn Hyun 1|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Bonsly Card|', 3, q'|Allows play of the card in Battle Bingo.|', nq'|ウソハチシート|', nq'|Usohachi Sheet|', nq'|Carte Manzai|', nq'|Mobai-Karte|', nq'|Scheda Bonsly|', nq'|Cart. Bonsly|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Big Root|', 4, q'|Increases the amount of HP restored when an HP-draining move is used by 30%.|', nq'|おおきなねっこ|', nq'|Ōkina Nekko|', nq'|Grosse Racine|', nq'|Großwurzel|', nq'|Granradice|', nq'|Raíz Grande|', nq'|큰뿌리|', nq'|Keun Ppuri|', nq'|大根莖 / 大根茎|', nq'|Dà Gēnjīng / Daaih Gānging|', 128);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Pidgeotite|', 6, q'|Allows Pidgeot to Mega Evolve into Mega Pidgeot.|', nq'|ピジョットナイト|', nq'|Pigeotnite|', nq'|Roucarnagite|', nq'|Taubossnit|', nq'|Pidgeotite|', nq'|Pidgeotita|', nq'|피죤투나이트|', nq'|Pijontoonite|', nq'|大比鳥進化石 / 大比鸟进化石|', nq'|Dàbǐniǎo Jìnhuà Shí / Daaihbéiníuh Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Passho Berry|', 4, q'|Reduces damage from a super effective Water-type move.|', nq'|イトケのみ|', nq'|Itoke no Mi|', nq'|Baie Pocpoc|', nq'|Foepasbeere|', nq'|Baccapasflo|', nq'|Baya Pasio|', nq'|꼬시개열매|', nq'|Kkosigae Yeolmae|', nq'|千香果|', nq'|Qiānxiāng Guǒ / Chīnhēung Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Luxury Ball|', 3, q'|A Pokémon caught in a Luxury Ball will gain friendship more quickly.|', nq'|ゴージャスボール|', nq'|Gorgeous Ball|', nq'|Luxe Ball|', nq'|Luxusball|', nq'|Chich Ball|', nq'|Lujo Ball|', nq'|럭셔리볼|', nq'|Luxury Ball|', nq'|豪華球 / 豪华球|', nq'|Háohuá Qiú / Hòuhwàh Kàuh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Durin Berry|', 3, q'|Poffin and Pokéblock ingredient.|', nq'|ドリのみ|', nq'|Dori no Mi|', nq'|Baie Durin|', nq'|Durinbeere|', nq'|Baccadurian|', nq'|Baya Rudion|', nq'|두리열매|', nq'|Duri Yeolmae|', nq'|金枕果|', nq'|Jīnzhěn Guǒ / Gāmjám Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Rare Bone|', 4, q'|Can be sold for 5000.|', nq'|きちょうなホネ|', nq'|Kichōna Hone|', nq'|Os Rare|', nq'|Steinknochen|', nq'|Osso Raro|', nq'|Hueso Raro|', nq'|귀중한뼈|', nq'|Gwijunghan Ppyeo|', nq'|貴重骨頭 / 贵重骨头|', nq'|Guìzhòng Gǔtou / Gwaijuhng Gwāttàuh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|MysteryBerry|', 2, q'|Restores 5 PP.|', nq'|ふしぎなきのみ|', nq'|Fushigina Kino Mi|', nq'|Baie Mystere|', nq'|Rätselbeere|', nq'|Bacca Mist.|', nq'|Bayamisterio|', nq'|이상한나무열매|', nq'|Isanghan Namu Yeolmae|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Blue Card|', 2, q'|Allows player to answer daily question on Buena's show to get points exchangeable for items.|', nq'|ブルーカード|', nq'|Blue Card|', nq'|Carte Bleue|', nq'|Blaue Karte|', nq'|Carta Blu|', nq'|Tarjeta Azul|', nq'|블루카드|', nq'|Blue Card|', nq'|藍卡 / 蓝卡|', nq'|Lán Kǎ / Làahm Kāat|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Stardust|', 2, q'|Can be sold for 1000.|', nq'|ほしのすな|', nq'|Hoshi no Suna|', nq'|Poussière Étoile|', nq'|Sternenstaub|', nq'|Polvostella|', nq'|Polvoestelar|', nq'|별의모래|', nq'|Byeorui Morae|', nq'|星星沙子|', nq'|Xīngxīng Shāzi / Sīngsīng Sājí|', 128);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Sprayduck|', 4, q'|Used to water Berry plants.|', nq'|コダックじょうろ|', nq'|Koduck Jōro|', nq'|Kwakarrosoir|', nq'|Entonkanne|', nq'|Sprayduck|', nq'|Psydugadera|', nq'|고라파덕물뿌리개|', nq'|Gorapaduck Mulppurigae|', nq'|可達鴨噴壺 / 可达鸭喷壶|', nq'|Kědáyā Pēnhú / Hódaahtáap Panwùh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Galladite|', 6, q'|Allows Gallade to Mega Evolve into Mega Gallade.|', nq'|エルレイドナイト|', nq'|Erureidonite|', nq'|Gallamite|', nq'|Galagladinit|', nq'|Galladite|', nq'|Galladita|', nq'|엘레이드나이트|', nq'|Elladenite|', nq'|艾路雷朵進化石 / 艾路雷朵进化石|', nq'|Àilùléiduǒ Jìnhuà Shí / Ngaaihlouhlèuidó Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Wave Mail|', 3, q'|Mail with a Wailmer design. To be held by a Pokémon for delivery.|', nq'|クロスメール|', nq'|Cross Mail|', nq'|Lettre Vague|', nq'|Wellenbrief|', nq'|Mess. Onda|', nq'|Carta Ola|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Fire Stone|', 1, q'|Can be used to evolve Vulpix, Growlithe, Eevee, and Pansear.|', nq'|ほのおのいし|', nq'|Honō no Ishi|', nq'|Pierre Feu|', nq'|Feuerstein|', nq'|Pietrafocaia|', nq'|Piedra Fuego|', nq'|불꽃의돌|', nq'|Bulkkoch-ui Dol|', nq'|火之石|', nq'|Huǒ-zhī Shí / Fó-jī Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Key to Room 2|', 6, q'|Opens Room 2 of the Abandoned ShipRSE/Sea MauvilleORAS.|', q'|Called Rm. 2 Key in Generation III.|', nq'|にごうしつのカギ|', nq'|Ni-gō Shitsu no Kagi|', nq'|Clé Salle 2|', nq'|R2-Schlüssel|', nq'|Chiave stanza 2|', nq'|Ll. Habitación 2|', nq'|이호실열쇠|', nq'|I-hosil Yeolsoe|', nq'|２號客房的鑰匙 /|'||chr(10)||nq'|２号客房的钥匙|', nq'|2 Hào Kèfáng-de Yàoshi / 2 Houh Haakfóng-dīk Yeuhksìh|', 1616);
insert into ITEMS(NAME, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(q'|Surge Badge|', nq'|だいだいバッジ|', nq'|Daidai Badge|', nq'|Fulguro-Badge|', nq'|Gewitterorden|', nq'|Medaglia Tonante|', nq'|Medalla Fulgor|', nq'|주황배지|', nq'|Juhwang Badge|', nq'|橘色徽章 / 桔色徽章|', nq'|Jú-sè Huīzhāng / Gwāt-sīk Fāijēung|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Dread Plate|', 4, q'|Raises the power of Dark-type moves.|', nq'|こわもてプレート|', nq'|Kowamote Purēto|', nq'|Plaque Ombre|', nq'|Furchttafel|', nq'|Lastratimore|', nq'|Tabla Oscura|', nq'|공포플레이트|', nq'|Gongpo Plate|', nq'|惡顏石板 / 恶颜石板|', nq'|È'yán Shíbǎn / Okngàahn Sehkbáan|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Lens Case|', 6, q'|Stores colored contact lenses that allow the player to change their eye color.|', nq'|レンズケース|', nq'|Lens Case|', nq'|Boîte Lentilles|', nq'|Linsenetui|', nq'|Portalenti|', nq'|Portalentillas|', nq'|렌즈케이스|', nq'|Lens Case|', nq'|隱形眼鏡盒 / 隐形眼镜盒|', nq'|Yǐnxíng Yǎnjìng Hé / Yányìhng Ngáahngeng Hahp|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Poké Toy|', 5, q'|Allows the player to flee from any battle with a wild Pokémon.|', nq'|ポケじゃらし|', nq'|Poké Jarashi|', nq'|Poképlumet|', nq'|Pokéwedel|', nq'|Pokégingillo|', nq'|Pokéseñuelo|', nq'|포켓풀|', nq'|Pocket Pul|', nq'|寶可尾草 / 宝可尾草|', nq'|Bǎokě Wěicǎo / Bóuhó Méihchóu|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Mawilite|', 6, q'|Allows Mawile to Mega Evolve into Mega Mawile.|', nq'|クチートナイト|', nq'|Kucheatnite|', nq'|Mysdibulite|', nq'|Flunkifernit|', nq'|Mawilite|', nq'|Mawilita|', nq'|입치트나이트|', nq'|Ipchittnite|', nq'|大嘴娃進化石 / 大嘴娃进化石|', nq'|Dàzuǐwá Jìnhuà Shí / Daaihjéuiwā Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Tyranitarite|', 6, q'|Allows Tyranitar to Mega Evolve into Mega Tyranitar.|', nq'|バンギラスナイト|', nq'|Bangirasnite|', nq'|Tyranocivite|', nq'|Despotarnit|', nq'|Tyranitarite|', nq'|Tyranitarita|', nq'|마기라스나이트|', nq'|Magirasnite|', nq'|班基拉斯進化石 / 班基拉斯进化石|', nq'|Bānjīlāsī Jìnhuà Shí / Bāangēilāaisī Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Max Revive|', 1, q'|Revives a Pokémon to full health.|', nq'|げんきのかたまり|', nq'|Genki no Katamari|', nq'|Rappel Max|', nq'|Top-Beleber|', nq'|Revitalizz. Max|', nq'|Revivir Máximo|', nq'|기력의덩어리|', nq'|Giryeog-ui Deong-eori|', nq'|活力塊 / 活力块|', nq'|Huólì Kuài / Wuhtlihk Faai|', 48);
insert into ITEMS(NAME, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(q'|Squirt Bottle|', nq'|ゼニガメじょうろ|', nq'|Zenigame Jōro|', nq'|Carapuce à O|', nq'|Schiggykanne|', nq'|Annaffiatoio|', nq'|Regadera|', nq'|꼬부기물뿌리개|', nq'|Kkobugi Mulppurigae|', nq'|傑尼龜噴壺 / 杰尼龟喷壶|', nq'|Jiéníguī Pēnhú / Gihtnèihgwāi Panwùh|');
insert into ITEMS(NAME, GEN, DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Tiny Mushroom|', 2, q'|Exchangeable in return for services.|', q'|Formatted as TinyMushroom prior to Generation VI.|', nq'|ちいさなキノコ|', nq'|Chiisana Kinoko|', nq'|Petit Champi|', nq'|Minipilz|', nq'|Piccolo Fungo|', nq'|Mini Seta|', nq'|작은버섯|', nq'|Jageun Beoseot|', nq'|小蘑菇|', nq'|Xiǎo Mógū / Síu Mòhgū|', 1024);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Shoal Salt|', 3, q'|Can be used to make a Shell Bell. Does not have any use in Generation IV. Can be sold to an item maniac in the Icirrus City Pokémon Center for 7000 in Generation V.|', nq'|あさせのしお|', nq'|Asase no Shio|', nq'|Sel Trefonds|', nq'|Küstensalz|', nq'|Sale Ondoso|', nq'|Sal Cardumen|', nq'|여울소금|', nq'|Yeoul Sogeum|', nq'|淺灘海鹽 / 浅滩海盐|', nq'|Qiǎntān Hǎiyán / Chíntāan Hóiyìhm|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Pal Pad|', 4, q'|Used to record friends on Nintendo Wi-Fi Connection and register Friend Codes.|', nq'|ともだちてちょう|', nq'|Tomodachi Techō|', nq'|Registre Ami|', nq'|Adressbuch|', nq'|Blocco Amici|', nq'|Bloc amigos|', nq'|친구수첩|', nq'|Chingu Sucheop|', nq'|朋友手冊 / 朋友手册|', nq'|Péngyǒu Shǒucè / Pàhngyáuh Sáuchaak|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Occa Berry|', 4, q'|Reduces damage taken from a super effective Fire-type move.|', nq'|オッカのみ|', nq'|Occa no Mi|', nq'|Baie Chocco|', nq'|Koakobeere|', nq'|Baccacao|', nq'|Baya Caoca|', nq'|오카열매|', nq'|Oca Yeolmae|', nq'|巧可果|', nq'|Qiǎokě Guǒ / HáauhóGwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Thunder Stone|', 1, q'|Can be used to evolve Pikachu into Raichu, Eevee into Jolteon, and Eelektrik to Eelektross.|', q'|Formatted as Thunderstone prior to Generation VI.|', nq'|かみなりのいし|', nq'|Kaminari no Ishi|', nq'|Pierre Foudre|', nq'|Donnerstein|', nq'|Pietratuono|', nq'|Piedra Trueno|', nq'|천둥의돌|', nq'|Cheondung-ui Dol|', nq'|雷之石|', nq'|Léi-zhī Shí / Lèuih-jī Sehk|', 1168);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Pink Petal|', 7, q'|A pink petal required to complete Mina's Trial.|', nq'|ももいろはなびら|', nq'|Momoiro Hanabira|', nq'|Pétale Rose|', nq'|Rosa Blatt|', nq'|Petalo rosa|', nq'|Pétalo Rosa|', nq'|담홍꽃잎|', nq'|Damhong Kkochip|', nq'|粉紅花瓣 / 粉红花瓣|', nq'|Fěnhóng Huābàn / Fánhùhng Fāfáan|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Bubble Mail|', 4, q'|Stationery with a bubble print. To be held by a Pokémon for delivery.|', nq'|ブルーメール|', nq'|Blue Mail|', nq'|Lettre Mer|', nq'|Wasserbrief|', nq'|Mess. Bolla|', nq'|Carta Pompas|', nq'|블루메일|', nq'|Blue Mail|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Yellow Scarf|', 3, q'|Raises the Tough condition.|', nq'|きいろのバンダナ|', nq'|Kiiro no Bandana|', nq'|Foul. Jaune|', nq'|Gelber Schal|', nq'|Fascia Gialla|', nq'|Pañuelo Amarillo|', nq'|노랑밴드|', nq'|Norang Band|', nq'|黃色頭巾 / 黄色头巾|', nq'|Huáng-sè Tóujīn / Wòhng-sīk Tàuhgān|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|Running Shoes|', 3, q'|Allows the player to run faster.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Buginium Z|', 7, q'|Allows a Pokémon to upgrade their Bug-type damaging moves to the Z-Move Savage Spin-Out or upgrade their Bug-type status moves into Z-Moves. Makes Arceus a Bug-type Pokémon.|', nq'|ムシＺ|', nq'|Bug-Z|', nq'|Insectozélite|', nq'|Insectium Z|', nq'|Insectium Z|', nq'|Insectostal Z|', nq'|벌레Z|', nq'|Beolle-Z|', nq'|蟲Ｚ / 虫Ｚ|', nq'|Chóng-Z / Chùhng-Z|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Green Shard|', 3, q'|Exchangeable for a variety of services.|', nq'|みどりのかけら|', nq'|Midori no Kakera|', nq'|Tesson Vert|', nq'|Grünstück|', nq'|Coccio Verde|', nq'|Parte Verde|', nq'|초록조각|', nq'|Chorok Jogak|', nq'|綠色碎片 / 绿色碎片|', nq'|Lǜsè Suìpiàn / Luhksīk Seuipin|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Reaper Cloth|', 4, q'|A held item that allows Dusclops to evolve into Dusknoir when traded.|', nq'|れいかいのぬの|', nq'|Reikai no Nuno|', nq'|Tissu Fauche|', nq'|Düsterumhang|', nq'|Terrorpanno|', nq'|Tela Terrible|', nq'|영계의천|', nq'|Yeonggye-ui Cheon|', nq'|靈界之布 / 灵界之布|', nq'|Língjiè-zhī Bù / Lìhnggaai-jī Bou|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Bottle Cap|', 7, q'|Can be traded to Mr. Hyper to maximize one of a Pokémon's IVs in Hyper Training.|', nq'|ぎんのおうかん|', nq'|Gin no Ōkan|', nq'|Capsule d'Argent|', nq'|Silberkronkorken|', nq'|Tappo d'argento|', nq'|Chapa Plateada|', nq'|은왕관|', nq'|Eun Wanggwan|', nq'|銀色王冠 / 银色王冠|', nq'|Yínsè Wángguān / Ngàhnsīk Wòhnggūn|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Eon Flute|', 6, q'|Summons LatiasAS or LatiosOR to soar in the sky above Hoenn, and fly to any city, route, or island.|', nq'|むげんのふえ|', nq'|Mugen no Fue|', nq'|Flûte Éon|', nq'|Äon-Flöte|', nq'|Flauto Eone|', nq'|Flauta Eón|', nq'|무한의피리|', nq'|Muhan Uipili|', nq'|無限之笛 / 无限之笛|', nq'|Wúxiàn-zhī Dí / Mòuhhaahn-jī Dehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|Strib Berry|', 3, q'|Pokéblock ingredient. Will become an Enigma Berry if transferred to Generation IV via Pal Park.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Oran Berry|', 3, q'|Restores 10 HP.|', nq'|オレンのみ|', nq'|Oren no Mi|', nq'|Baie Oran|', nq'|Sinelbeere|', nq'|Baccarancia|', nq'|Baya Aranja|', nq'|오랭열매|', nq'|Oraeng Yeolmae|', nq'|橙橙果|', nq'|Chéngchéng Guǒ / Chàahngchàahng Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|X Accuracy 6|', 5, q'|Immensely raises a Pokémon's accuracy. Wonder Launcher only.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Spell Tag|', 2, q'|Raises the power of Ghost-type moves.|', nq'|のろいのおふだ|', nq'|Noroi no Ofuda|', nq'|Rune Sort|', nq'|Bannsticker|', nq'|Spettrotarga|', nq'|Hechizo|', nq'|저주의부적|', nq'|Jeojuui Bujeok|', nq'|詛咒之符 / 诅咒之符|', nq'|Zǔzhòu-zhī Fú / Jojau-jī Fùh|', 0);
insert into ITEMS(NAME, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(q'|Roto PP Restore|', nq'|ＰＰかいふくポン|', nq'|PP Kaifuku Pon|', nq'|Moti-Récup' PP|', nq'|AP-Bon|', nq'|PP'n'roll|', nq'|Cupón PP|', nq'| ???|', nq'| ???|', nq'|ＰＰ回復碰碰 /|'||chr(10)||nq'|ＰＰ回复碰碰|', nq'|PP Huífù Pèngpèng / PP Wùihfuhk Pungpung|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Damp Rock|', 4, q'|Increases the duration of heavy rain.|', nq'|しめったいわ|', nq'|Shimetta Iwa|', nq'|Roche Humide|', nq'|Nassbrocken|', nq'|Rocciaumida|', nq'|Roca Lluvia|', nq'|축축한바위|', nq'|Chukchukhan Bawi|', nq'|潮濕岩石 / 潮湿岩石|', nq'|Cháoshī Yánshí / Chìuhsāp Ngàahmsehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Ruby|', 3, q'|Give to Celio along with Sapphire to set up the Network Machine of the Pokémon Network Center. It allows the player to trade with Ruby, Sapphire, and Emerald.|', nq'|ルビー|', nq'|Ruby|', nq'|Rubis|', nq'|Rubin|', nq'|Rubino|', nq'|Rubí|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Psychic Memory|', 7, q'|Makes Silvally a Psychic-type Pokémon and makes Multi-Attack a Psychic-type move.|', nq'|サイキックメモリ|', nq'|Psychic Memory|', nq'|ROM Psy|', nq'|Psycho-Disc|', nq'|ROM Psico|', nq'|Disco Psíquico|', nq'|사이킥메모리|', nq'|Psychic Memory|', nq'|精神記憶碟*|'||chr(10)||nq'|精神存储碟|', nq'|Jīngshén Jìyìdié / Jīngsàhn Geiyīkdihp*|'||chr(10)||nq'|Jīngshén Cúnchǔdié|', 3);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Silph Scope|', 1, q'|Used to identify ghosts in Pokémon Tower.|', nq'|シルフスコープ|', nq'|Silph Scope|', nq'|Scope Sylphe|', nq'|Silph Scope|', nq'|Spettrosonda|', nq'|Scope Silph|', nq'|실프스코프|', nq'|Silph Scope|', nq'|西爾佛檢視鏡 / 西尔佛检视镜|', nq'|Xīěrfu Jiǎnshìjìng / Sāiyíhfaht Gímsihgeng|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Reveal Glass|', 5, q'|A glass that tells the truth. It is a mysterious glass that returns a Pokémon back to its original shape.|', nq'|うつしかがみ|', nq'|Reflecting Mirror|', nq'|Miroir Sacré|', nq'|Wahrspiegel|', nq'|Verispecchio|', nq'|Espejo Veraz|', nq'|비추는거울|', nq'|Bichu-neun Geoul|', nq'|現形鏡 / 现形镜|', nq'|Xiànxíng Jìng / Yihnyìhng Geng|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Oval Stone|', 4, q'|When held, allows Happiny to evolve.|', nq'|まんまるいし|', nq'|Manmaru Ishi|', nq'|Pierre Ovale|', nq'|Ovaler Stein|', nq'|Pietraovale|', nq'|Piedra Oval|', nq'|동글동글돌|', nq'|Donggeuldonggeul Dol|', nq'|渾圓之石 / 浑圆之石|', nq'|Húnyuán-zhī Shí / Wahnyùhn-jī Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Maingate Key|', 3, q'|Opens the front gate to the Shadow PKMN Lab.|', nq'|メインゲートキー|', nq'|Main Gate Key|', nq'|Cle Labo|', nq'|Torschlüssel|', nq'|Chiave Canc.|', nq'|Ll. Entrada|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Dragon Scale|', 2, q'|A hold item that allows Seadra to evolve when traded.|', nq'|りゅうのウロコ|', nq'|Ryū no Uroko|', nq'|Écaille Draco|', nq'|Drachenhaut|', nq'|Squama Drago|', nq'|Escamadragón|', nq'|용의비늘|', nq'|Yong-ui Bineul|', nq'|龍之鱗片 / 龙之鳞片|', nq'|Lóng zhī línpiàn / Lùhng-jī Lèuhnpin|', 128);
insert into ITEMS(NAME, GEN, DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Green Apricorn|', 2, q'|Kurt will make the player a Friend Ball out of it.|', q'|Formatted as Grn Apricorn prior to Generation VI.|', nq'|みどぼんぐり|', nq'|Mido Bonguri|', nq'|Noigrume Ver|', nq'|Aprikoko Grn|', nq'|Ghicocca Verde|', nq'|Bonguri Verde|', nq'|초록규토리|', nq'|Chorok Gyutori|', nq'|綠球果 / 绿球果|', nq'|Lǜ Qiúguǒ / Luhk Kàuhgwó|', 1072);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Charizardite Y|', 6, q'|Allows Charizard to Mega Evolve into Mega Charizard Y.|', nq'|リザードナイトY|', nq'|Lizardonite Y|', nq'|Dracaufite Y|', nq'|Gluraknit Y|', nq'|Charizardite Y|', nq'|Charizardita Y|', nq'|리자몽나이트Y|', nq'|Rizamonnite Y|', nq'|噴火龍進化石Y / 喷火龙进化石Y|', nq'|Pēnhuǒlóng Jìnhuà Shí Y / Panfólùhng Jeunfa Sehk Y|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Secret Potion|', 2, q'|Used to cure Amphy's sicknessGSCHGSS or the Psyduck's headachesDPPt. Is produced by the Cianwood City Pharmacy.|', q'|Formatted as SecretPotion prior to Generation VI.|', nq'|ひでんのくすり|', nq'|Hiden no Kusuri|', nq'|Potionsecret|', nq'|Geheimtrank|', nq'|Poz. Segreta|', nq'|Poc. Secreta|', nq'|비전신약|', nq'|Bijeon Sin-yak|', nq'|秘傳之藥 / 秘传之药|', nq'|Mìchuán-zhī Yào / Beichyùhn-jī Yeuhk|', 1024);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Gooey Mulch|', 4, q'|Increases the number of times new Berry plants can grow where old ones withered.|', nq'|ねばねばこやし|', nq'|Nebaneba Koyashi|', nq'|Fertiglu|', nq'|Neumulch|', nq'|Fertilcolla|', nq'|Abono Brote|', nq'|끈적끈적비료|', nq'|Kkeunjeok-kkeunjeok Biryo|', nq'|黏黏肥 / 粘粘肥|', nq'|Niánnián Féi / Nīmnīm Fèih|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Firium Z|', 7, q'|Allows a Pokémon to upgrade their Fire-type damaging moves to the Z-Move Inferno Overdrive or upgrade their Fire-type status moves into Z-Moves. Makes Arceus a Fire-type Pokémon.|', nq'|ホノオＺ|', nq'|Flame-Z|', nq'|Pyrozélite|', nq'|Pyrium Z|', nq'|Pirium Z|', nq'|Pirostal Z|', nq'|불꽃Z|', nq'|Bulkkot-Z|', nq'|火Ｚ|', nq'|Huǒ-Z / Fó-Z|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Destiny Knot|', 4, q'|Infatuates the foe if the holder becomes infatuated.|', nq'|あかいいと|', nq'|Akai Ito|', nq'|Nœud Destin|', nq'|Fatumknoten|', nq'|Destincomune|', nq'|Lazo Destino|', nq'|빨간실|', nq'|Ppalgan Sil|', nq'|紅線 / 红线|', nq'|Hóngxiàn / Hùhngsin|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Snowball|', 6, q'|Raises the holder's Attack by one stage after being hit by an Ice-type attack. Consumed after use.|', nq'|ゆきだま|', nq'|Yukidama|', nq'|Boule de Neige|', nq'|Schneeball|', nq'|Palla di Neve|', nq'|Bola de Nieve|', nq'|눈덩이|', nq'|Nundeong-i|', nq'|雪球|', nq'|Xuěqiú / Syutkàuh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|BridgeMail V|', 5, q'|Stationary with a brick bridge print. To be held by a Pokémon for delivery.|', nq'|ブリッジメールＶ|', nq'|Bridge Mail V|', nq'|Lettre PontH|', nq'|Brückbrief D|', nq'|Mess. Vill.|', nq'|C. Puente V|', nq'|브리지메일V|', nq'|Bridge Mail V|', nq'|橋梁郵件Ｖ / 桥梁邮件Ｖ|', nq'|Qiáoliáng Yóujiàn V / Kìuhlèuhng Yàuhgín V|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Nugget|', 1, q'|Can be sold for 5000.|', nq'|きんのたま|', nq'|Kin no Tama|', nq'|Pepite|', nq'|Nugget|', nq'|Pepita|', nq'|Pepita|', nq'|금구슬|', nq'|Geum Guseul|', nq'|金珠|', nq'|Jīnzhū / Gāmjyū|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Mind Plate|', 4, q'|Raises the power of Psychic-type moves.|', nq'|ふしぎのプレート|', nq'|Fushigi no Purēto|', nq'|Plaque Esprit|', nq'|Hirntafel|', nq'|Lastramente|', nq'|Tabla Mental|', nq'|이상한플레이트|', nq'|Isanghan Plate|', nq'|神奇石板|', nq'|Shénqí Shíbǎn / Sàhnkèih Sehkbáan|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|White Flute|', 3, q'|Attracts wild Pokémon to the player.RSEFRLGDPPtHGSS Can be sold for 8000.BWB2W2 Decreases the level of wild Pokémon by one to three levels.ORAS|', nq'|しろいビードロ|', nq'|Shiroi Vidro|', nq'|Flûte Blanche|', nq'|Weisse Flöte|', nq'|Flauto Bianco|', nq'|Flauta Blanca|', nq'|하양비드로|', nq'|Hayang Vidro|', nq'|白色玻璃哨|', nq'|Bái-sè Bōlí Shào / Baahk-sīk Bōlèih Saau|', 128);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Old Sea Map|', 3, q'|Event item that gives player access to Faraway Island, where Mew can be caught.|', nq'|ふるびたかいず|', nq'|Furubita Kaizu|', nq'|Vieille Carte|', nq'|Alte Karte|', nq'|Mappa Stinta|', nq'|Mapa Viejo|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Music Mail|', 2, q'|Mail with a Natu design. Only available through Mystery Gift. To be held by a Pokémon for delivery.|', nq'|おんぷメール|', nq'|Onpu Mail|', nq'|Lettre Musique|', nq'|Melodiebrief|', nq'|Mess. Musica|', nq'|Carta Música|', nq'|음표메일|', nq'|Eumpyo Mail|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Bluk Berry|', 3, q'|Poffin and Pokéblock ingredient.|', nq'|ブリーのみ|', nq'|Burī no Mi|', nq'|Baie Remu|', nq'|Morbbeere|', nq'|Baccamora|', nq'|Baya Oram|', nq'|블리열매|', nq'|Beulli Yeolmae|', nq'|墨莓果|', nq'|Mòméi Guǒ / Mahkmùih Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Psychic Seed|', 7, q'|A one-time use item that raises the holder's Sp. Defense by one stage upon activation of Psychic Terrain.|', nq'|サイコシード|', nq'|Psycho Seed|', nq'|Graine Psychique|', nq'|Psycho-Samen|', nq'|Psicoseme|', nq'|Semilla Psique|', nq'|사이코시드|', nq'|Psycho Seed|', nq'|精神種子 / 精神种子|', nq'|Jīngshén Zhǒngzi / Jīngsàhn Júngjí|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Leaf Stone|', 1, q'|Can be used to evolve Gloom into Vileplume, Weepinbell into Victreebel, Exeggcute into Exeggutor, Nuzleaf into Shiftry, and Pansage into Simisage.|', nq'|リーフのいし|', nq'|Leaf no Ishi|', nq'|Pierre Plante|', nq'|Blattstein|', nq'|Pietrafoglia|', nq'|Piedra Hoja|', nq'|리프의돌|', nq'|Leaf-ui Dol|', nq'|葉之石 / 叶之石|', nq'|Yè-zhī Shí / Yihp-jī Sehk|', 128);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Chesto Berry|', 3, q'|Awakens a Pokémon from sleep.|', nq'|カゴのみ|', nq'|Kago no Mi|', nq'|Baie Maron|', nq'|Maronbeere|', nq'|Baccastagna|', nq'|Baya Atania|', nq'|유루열매|', nq'|Yuru Yeolmae|', nq'|零餘果 / 零余果|', nq'|Língyú Guǒ / Lìhngyùh Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Apicot Berry|', 3, q'|Raises Special Defense when HP is below ⅓.|', nq'|ズアのみ|', nq'|Zua no Mi|', nq'|Baie Abriko|', nq'|Apikobeere|', nq'|Baccacocca|', nq'|Baya Aricoc|', nq'|규살열매|', nq'|Gyusal Yeolmae|', nq'|杏仔果|', nq'|Xìngzǐ Guǒ / Hahngjái Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Full Heal|', 1, q'|Cures any status condition.|', nq'|なんでもなおし|', nq'|Nandemo Naoshi|', nq'|Total Soin|', nq'|Hyperheiler|', nq'|Cura Totale|', nq'|Cura Total|', nq'|만병통치약|', nq'|Manbyeongtongchiyak|', nq'|萬靈藥 / 万灵药|', nq'|Wànlíngyào / Maahnlìhngyeuhk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Fab Mail|', 3, q'|Mail with an extremely decorative design. To be held by a Pokémon for delivery.|', nq'|ミラクルメール|', nq'|Miracle Mail|', nq'|Lettre Cool|', nq'|Edelbrief|', nq'|Mess. Fab|', nq'|Carta Fabulosa|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Basement Key|', 2, q'|Allows the player to access the basement of the Goldenrod Tunnel.|', nq'|ちかのカギ|', nq'|Chika no Kagi|', nq'|Clé Sous-Sol|', nq'|Kelleröffner|', nq'|Chiave sotterr.|', nq'|Llave del Sótano|', nq'|지하열쇠|', nq'|Jiha Yeolsoe|', nq'|地下鑰匙 / 地下钥匙|', nq'|Dìxià Yàoshi / Deihhah Yeuhksìh|', 28);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Aqua Suit|', 6, q'|Allows the player to ride Kyogre in the Cave of Origin and fly into space on Rayquaza.|', nq'|アクアスーツ|', nq'|Aqua Suit|', nq'|Scaphandre Aqua|', nq'|Aqua-Anzug|', nq'|Tuta Idro|', nq'|Traje Aqua|', nq'|아쿠아슈트|', nq'|Aqua Suit|', nq'|海洋裝 / 海洋装|', nq'|Hǎiyáng Zhuāng / Hóiyèuhng Jōng|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Rich Mulch|', 6, q'|When applied to a Berry patch, increases the final Berry harvest by 2 Berries.|', nq'|たわわこやし|', nq'|Tawawa Koyashi|', nq'|Fertibondance|', nq'|Sprießmulch|', nq'|Fertilflorido|', nq'|Abono Fértil|', nq'|주렁주렁비료|', nq'|Jureong-jureong Biryo|', nq'|碩果肥 / 硕果肥|', nq'|Shuòguǒ Féi / Sehkgwó Fèih|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Kelpsy Berry|', 3, q'|Raises friendship, but lowers Attack EV.|', nq'|ネコブのみ|', nq'|Nekobu no Mi|', nq'|Baie Alga|', nq'|Setangbeere|', nq'|Baccalga|', nq'|Baya Algama|', nq'|시마열매|', nq'|Sima Yeolmae|', nq'|藻根果|', nq'|Zǎogēn Guǒ / Jóugān Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|GS Ball|', 2, q'|Allows Celebi to be caught in Pokémon Crystal.|', nq'|ジーエスボール|', nq'|GS Ball|', nq'|GS Ball|', nq'|GS-Ball|', nq'|GS Ball|', nq'|GS Ball|', nq'|GS볼|', nq'|GS Ball|', nq'|ＧＳ球|', nq'|GS Qiú / GS Kàuh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Chilan Berry|', 4, q'|Reduces damage from a Normal-type move by 50%.|', nq'|ホズのみ|', nq'|Hozu no Mi|', nq'|Baie Zalis|', nq'|Latchibeere|', nq'|Baccacinlan|', nq'|Baya Chilan|', nq'|카리열매|', nq'|Kari Yeolmae|', nq'|燈漿果 / 燈漿果|', nq'|Dēngjiāng Guǒ / Dāngjēung Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Swampertite|', 6, q'|Allows Swampert to Mega Evolve into Mega Swampert.|', nq'|ラグラージナイト|', nq'|Laglargenite|', nq'|Laggronite|', nq'|Sumpexnit|', nq'|Swampertite|', nq'|Swampertita|', nq'|대짱이나이트|', nq'|Daejjanginite|', nq'|巨沼怪進化石 / 巨沼怪进化石|', nq'|Jùzhǎoguài Jìnhuà Shí / Geuihjíugwaai Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Magost Berry|', 3, q'|Pokéblock and Poffin ingredient.|', nq'|ゴスのみ|', nq'|Gosu no Mi|', nq'|Baie Mangou|', nq'|Magostbeere|', nq'|Baccagostan|', nq'|Baya Aostan|', nq'|고스티열매|', nq'|Gostee Yeolmae|', nq'|岳竹果|', nq'|Yuèzhú Guǒ / Ngohkjūk Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Voice Case 3|', 3, q'|Heals a Taillow in Agate Village.|', nq'|こえカプセル３|', nq'|Koe Capsule 3|', nq'|Boite Cri 3|', nq'|Stimmbox 3|', nq'|Disco Verso 3|', nq'|Grabación 3|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Powder Jar|', 3, q'|Stores Berry Powder made from Berry Crush.|', nq'|こないれ|', nq'|Konaire|', nq'|Pot Poudre|', nq'|Puderdöschen|', nq'|Portafarina|', nq'|Bote Polvos|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|X Sp. Atk|', 1, q'|Raises a Pokémon's Special Attack (Special in Generation I) by 2 stages (1 stage before Gen. VII).|', q'|Called X Special prior to Generation VI.|', nq'|スペシャルアップ|', nq'|Special Up|', nq'|Special +|', nq'|X-Spezial|', nq'|Att. Speciale X|', nq'|Especial X|', nq'|스페셜업|', nq'|Special-Up|', nq'|特攻強化 / 特攻强化|', nq'|Tègōng Qiánghuà / Dahkgūng Kèuhngfa|', 1056);
insert into ITEMS(NAME, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(q'|N-Solarizer|', nq'|ネクロプラスソル|', nq'|Necro Plus Sol|', nq'|Necrosol|', nq'|Necrosol|', nq'|Necrosolix|', nq'|Necrosol|', nq'|네크로플러스솔|', nq'|Necro Plus Sol|', nq'|奈克洛索爾合體器 / 奈克洛索尔合体器|', nq'|Nàikèluò Suǒěr Hétǐqì / Noihhāklok Sokyíh Hahptáihei|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Snow Mail|', 4, q'|Mail with a snow print. To be held by a Pokémon for delivery.|', nq'|ブリザードメール|', nq'|Blizzard Mail|', nq'|Lettre Neige|', nq'|Schneebrief|', nq'|Mess. Neve|', nq'|Carta Nieve|', nq'|블리자드메일|', nq'|Blizzard Mail|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Sport Ball|', 2, q'|A type of Poké Ball that is used in the Bug-Catching Contest.|', q'|Called Park Ball in Generation II.|', nq'|コンペボール|', nq'|Compe Ball|', nq'|Compét'Ball|', nq'|Turnierball|', nq'|Gara Ball|', nq'|Competi Ball|', nq'|콤페볼|', nq'|Compe Ball|', nq'|競賽球 / 竞赛球|', nq'|Jìngsài Qiú / Gihngchoi Kàuh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|MiracleBerry|', 2, q'|Cures any status condition.|', nq'|きせきのみ|', nq'|Kiseki no Mi|', nq'|Baie Miracle|', nq'|Wunderbeere|', nq'|Bacca Mirac.|', nq'|Baya Milagro|', nq'|기적의열매|', nq'|Gijeogui Yeolmae|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Heavy Ball|', 2, q'|A type of Poké Ball that works better on heavier Pokémon.|', nq'|ヘビーボール|', nq'|Heavy Ball|', nq'|Masse Ball|', nq'|Schwerball|', nq'|Peso Ball|', nq'|Peso Ball|', nq'|헤비볼|', nq'|Heavy Ball|', nq'|沉重球|', nq'|Chénzhòng Qiú / Chàhmchúhng Kàuh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Burnt Berry|', 2, q'|Thaws out a frozen Pokémon.|', nq'|やけたきのみ|', nq'|Yaketa Kino Mi|', nq'|Baie Brulure|', nq'|Brandbeere|', nq'|Bacca Bruc.|', nq'|Antiquembaya|', nq'|불탄나무열매|', nq'|Bultan Namu Yeolmae|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Ein File C|', 3, q'|Describes Celebi.|', nq'|ボルグファイルＣ|', nq'|Borg File C|', nq'|Dossier Teck C|', nq'|Culpa-Akte C|', nq'|Genus.File C|', nq'|Parte Ein: C|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Pinap Berry|', 3, q'|Pokéblock and Poffin ingredient.|', nq'|パイルのみ|', nq'|Pairu no Mi|', nq'|Baie Nanana|', nq'|Sananabeere|', nq'|Baccananas|', nq'|Baya Pinia|', nq'|파인열매|', nq'|Pine Yeolmae|', nq'|凰梨果|', nq'|Huánglí Guǒ / Wòhnglèih Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Enigmatic Card|', 7, q'|Allows the player to enter Looker and Anabel's motel room on Route 8.|', nq'|あやしいカード|', nq'|Ayashī Card|', nq'|Message Mystère|', nq'|Seltsame Karte|', nq'|Lettera segreta|', nq'|Nota Intrigante|', nq'|괴상한카드|', nq'|Goesanghan Card|', nq'|奇異卡片 / 奇异卡片|', nq'|Qíyì Kǎpiàn / Kèihyih Kāatpín|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|D-Disk|', 3, q'|Moves the UFO in The Under downward into Deep Colosseum.|', nq'|Ｄ－ディスク|', nq'|D-Disk|', nq'|Disque-B|', nq'|U-Disc|', nq'|Disco Giù|', nq'|Disco B|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Helix Fossil|', 1, q'|A Fossil from which an Omanyte can be resurrected.|', nq'|かいのカセキ|', nq'|Kai no Kaseki|', nq'|Fossile Nautile|', nq'|Helixfossil|', nq'|Helixfossile|', nq'|Fósil Helix|', nq'|조개화석|', nq'|Jogae Hwaseok|', nq'|貝殼化石 / 贝壳化石|', nq'|Bèiké Huàshí / Buihok Fasehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Nomel Berry|', 3, q'|Pokéblock and Poffin ingredient.|', nq'|ノメルのみ|', nq'|Nomel no Mi|', nq'|Baie Tronci|', nq'|Tronzibeere|', nq'|Baccalemon|', nq'|Baya Monli|', nq'|노멜열매|', nq'|Nomel Yeolmae|', nq'|檬檸果 / 檬柠果|', nq'|Méngníng Guǒ / Mūngnìhng Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Azure Flute|', 4, q'|Key Item used to access the Hall of Origin and face Arceus.|', nq'|てんかいのふえ|', nq'|Tenkai no Fue|', nq'|Flûte Azur|', nq'|Azurflöte|', nq'|Flauto Cielo|', nq'|Flauta Azur|', nq'|천계의 피리|', nq'|Cheongye-ui Piri|', nq'|天界之笛|', nq'|Tiānjiè-zhī Dí / Tīngaai-jī Dehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Cologne Case|', 3, q'|Holds Scents.|', nq'|コロンケース|', nq'|Cologne Case|', nq'|Boite a Parfums|', nq'|Essenz-Kiste|', nq'|Portaolio|', nq'|Caja Aromas|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Fist Plate|', 4, q'|Raises the power of Fighting-type moves.|', nq'|こぶしのプレート|', nq'|Kobushi no Purēto|', nq'|Plaque Poing|', nq'|Fausttafel|', nq'|Lastrapugno|', nq'|Tabla Fuerte|', nq'|주먹플레이트|', nq'|Jumeok Plate|', nq'|拳頭石板 / 拳头石板|', nq'|Quántóu Shíbǎn / Kyùhntàuh Sehkbáan|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Light Stone|', 5, q'|Stone used to revive Reshiram|', nq'|ライトストーン|', nq'|Light Stone|', nq'|Galet Blanc|', nq'|Lichtstein|', nq'|Chiarolite|', nq'|Orbe Claro|', nq'|라이트스톤|', nq'|Light Stone|', nq'|光明石|', nq'|Guāngmíng Shí / Gwōngmìhng Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Steel Gem|', 5, q'|Increases the power of the holder's first Steel-type move by 50%, and is consumed after use.|', nq'|はがねのジュエル|', nq'|Hagane no Jewel|', nq'|Joyau Acier|', nq'|Stahljuwel|', nq'|Bijouacciaio|', nq'|Gema Acero|', nq'|강철주얼|', nq'|Gangcheol Jewel|', nq'|鋼之寶石 / 钢之宝石|', nq'|Gāng-zhī Bǎoshí / Gong-jī Bóusehk|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|ID Card|', 3, q'|Permits access to a restricted elevator at the Cipher Lab.|', nq'|ＩＤカード|', nq'|ID Card|', nq'|Badge|', nq'|ID-Karte|', nq'|Tessera|', nq'|Tarjeta ID|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Icium Z|', 7, q'|Allows a Pokémon to upgrade their Ice-type damaging moves to the Z-Move Subzero Slammer or upgrade their Ice-type status moves into Z-Moves. Makes Arceus an Ice-type Pokémon.|', nq'|コオリＺ|', nq'|Ice-Z|', nq'|Cryozélite|', nq'|Glacium Z|', nq'|Glacium Z|', nq'|Criostal Z|', nq'|얼음Z|', nq'|Eol-eum-Z|', nq'|冰Ｚ|', nq'|Bīng-Z / Bīng-Z|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Holo Caster|', 6, q'|Allows the player to view hologram clips and communicate with others.|', nq'|ホロキャスター|', nq'|Holo Caster|', nq'|Holokit|', nq'|Holo-Log|', nq'|Holovox|', nq'|Holomisor|', nq'|홀로캐시터|', nq'|Holo Caster|', nq'|全像投影通訊器*|'||chr(10)||nq'|全息影像通讯器|', nq'|Quánxiàng Tóuyǐng Tōngxùn Qì / Chyùhnjeuhng Tàuhyíng Tūngseun Hei*|'||chr(10)||nq'|Quánxī Yǐngxiàng Tōngxùn Qì|', 3);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Ground Memory|', 7, q'|Makes Silvally a Ground-type Pokémon and makes Multi-Attack a Ground-type move.|', nq'|グラウンドメモリ|', nq'|Ground Memory|', nq'|ROM Sol|', nq'|Boden-Disc|', nq'|ROM Terra|', nq'|Disco Tierra|', nq'|그라운드메모리|', nq'|Ground Memory|', nq'|大地記憶碟*|'||chr(10)||nq'|大地存储碟|', nq'|Dàdì Jìyìdié / Daaihdeih Geiyīkdihp*|'||chr(10)||nq'|Dàdì Cúnchǔdié|', 3);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Yellow Flute|', 3, q'|Snaps a Pokémon out of Confusion.RSEFRLGColoXDDPPtHGSSORAS Can be sold for 7500.BWB2W2|', nq'|きいろビードロ|', nq'|Kiiro Vidro|', nq'|Flûte Jaune|', nq'|Gelbe Flöte|', nq'|Flauto Giallo|', nq'|Flauta Amarilla|', nq'|노랑비드로|', nq'|Norang Vidro|', nq'|黃色玻璃哨 / 黄色玻璃哨|', nq'|Huáng-sè Bōlí Shào / Wòhng-sīk Bōlèih Saau|', 176);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Shadow Mail|', 3, q'|Mail with a picture of Duskull. To be held by a Pokémon for delivery.|', nq'|シャドーメール|', nq'|Shadow Mail|', nq'|Lettre Ombre|', nq'|Dunkelbrief|', nq'|Mess. Ombra|', nq'|Carta Sombra|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Ice Memory|', 7, q'|Makes Silvally a Ice-type Pokémon and makes Multi-Attack a Ice-type move.|', nq'|アイスメモリ|', nq'|Ice Memory|', nq'|ROM Glace|', nq'|Eis-Disc|', nq'|ROM Ghiaccio|', nq'|Disco Hielo|', nq'|아이스메모리|', nq'|Ice Memory|', nq'|冰雪記憶碟*|'||chr(10)||nq'|冰雪存储碟|', nq'|Bīngxuě Jìyìdié / Bīngsyut Geiyīkdihp*|'||chr(10)||nq'|Bīngxuě Cúnchǔdié|', 3);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Metal Powder|', 2, q'|Raises Ditto's Defense.|', nq'|メタルパウダー|', nq'|Metal Powder|', nq'|Poudre Metal|', nq'|Metallstaub|', nq'|Metalpolvere|', nq'|Polvo Metálico|', nq'|금속파우더|', nq'|Geumsok Powder|', nq'|金屬粉 / 金属粉|', nq'|Jīnshǔ Fěn / Gāmsuhk Fán|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Cherish Ball|', 4, q'|A special type of Poké Ball in which event Pokémon are usually distributed.|', nq'|プレジャスボール|', nq'|Precious Ball|', nq'|Mémoire Ball|', nq'|Jubelball|', nq'|Pregio Ball|', nq'|Gloria Ball|', nq'|프레셔스볼|', nq'|Precious Ball|', nq'|貴重球 / 贵重球|', nq'|Guìzhòng Qiú / Gwaijuhng Kàuh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Magnet|', 2, q'|Raises the power of Electric-type moves.|', nq'|じしゃく|', nq'|Jishaku|', nq'|Aimant|', nq'|Magnet|', nq'|Calamita|', nq'|Imán|', nq'|자석|', nq'|Jaseok|', nq'|磁鐵 / 磁铁|', nq'|Cítiě / Chìhtit|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Grass Gem|', 5, q'|Increases the power of the holder's first Grass-type move by 50%, and is consumed after use.|', nq'|くさのジュエル|', nq'|Kusa no Jewel|', nq'|Joyau Plante|', nq'|Pflanzenjuwel|', nq'|Bijouerba|', nq'|Gema Planta|', nq'|풀주얼|', nq'|Pul Jewel|', nq'|草之寶石 / 草之宝石|', nq'|Cǎo-zhī Bǎoshí / Chóu-jī Bóusehk|', 80);
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|X Speed 6|', 5, q'|Immensely raises a Pokémon's Speed. Wonder Launcher only.|');
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|X Defend 2|', 5, q'|Sharply raises a Pokémon's Defense. Wonder Launcher only.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Sun Flute|', 7, q'|Used to evolve Nebby into Solgaleo at the Altar of the Sunne.|', nq'|たいようのふえ|', nq'|Taiyō no Fue|', nq'|Flûte du Soleil|', nq'|Sonnenflöte|', nq'|Flauto solare|', nq'|Flauta Solar|', nq'|태양의피리|', nq'|Taeyang Uipili|', nq'|太陽之笛 / 太阳之笛|', nq'|Tàiyáng-zhī Dí / Taaiyèuhng-jī Dehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Green Scarf|', 3, q'|Raises the Clever condition.|', nq'|みどりのバンダナ|', nq'|Midori no Bandana|', nq'|Foul. Vert|', nq'|Grüner Schal|', nq'|Fascia Verde|', nq'|Pañuelo Verde|', nq'|초록밴드|', nq'|Chorok Band|', nq'|綠色頭巾 / 绿色头巾|', nq'|Lǜ-sè Tóujīn / Luhk-sīk Tàuhgān|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Lost Item|', 2, q'|Return to Copycat for access to Magnet Train.|', nq'|おとしもの|', nq'|Otoshi Mono|', nq'|Poupée perdue|', nq'|Fundsache|', nq'|Strumento Perso|', nq'|Obj. Perdido|', nq'|분실물|', nq'|Bunsilmul|', nq'|遺失物 / 遗失物|', nq'|Yíshī Wù / Wàihsāt Maht|', 0);
insert into ITEMS(NAME, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(q'|Roto Bargain|', nq'|やすうりポン|', nq'|Yasu'uri Pon|', nq'|Moti-Promo|', nq'|Schnäppchenbon|', nq'|Sconto'n'roll|', nq'|Cupón Rebaja|', nq'| ???|', nq'| ???|', nq'|優惠碰碰 / 优惠碰碰|', nq'|Yōuhuì Pèngpèng / Yāuwaih Pungpung|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Premier Ball|', 3, q'|A Poké Ball with special coloring. The Poké Mart cashier will give one to the player for free if ten or more standard Poké Balls are purchased.|', nq'|プレミアボール|', nq'|Premier Ball|', nq'|Honor Ball|', nq'|Premierball|', nq'|Premier Ball|', nq'|Honor Ball|', nq'|프레미어볼|', nq'|Premier Ball|', nq'|紀念球 / 纪念球|', nq'|Jìniàn Qiú / Géinihm Kàuh|', 0);
insert into ITEMS(NAME, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(q'|Roto Friendship|', nq'|なつきポン|', nq'|Natsuki Pon|', nq'|Moti-Cœur|', nq'|Freundschaftsbon|', nq'|Affetto'n'roll|', nq'|Cupón Amistad|', nq'| ???|', nq'| ???|', nq'|親密碰碰 / 亲密碰碰|', nq'|Qīnmì Pèngpèng / Chānmaht Pungpung|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Water Stone|', 1, q'|Can be used to evolve Poliwhirl into Poliwrath, Shellder into Cloyster, Staryu into Starmie, Eevee into Vaporeon, Lombre into Ludicolo, and Panpour into Simipour.|', nq'|みずのいし|', nq'|Mizu no Ishi|', nq'|Pierre Eau|', nq'|Wasserstein|', nq'|Pietraidrica|', nq'|Piedra Agua|', nq'|물의돌|', nq'|Murui Dol|', nq'|水之石|', nq'|Shuǐ-zhī Shí / Séui-jī Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Moon Flute|', 7, q'|Used to evolve Nebby into Lunala at the Altar of the Moone.|', nq'|つきのふえ|', nq'|Tsuki no Fue|', nq'|Flûte de la Lune|', nq'|Mondflöte|', nq'|Flauto lunare|', nq'|Flauta Lunar|', nq'|달의피리|', nq'|Dal Uipili|', nq'|月亮之笛|', nq'|Yuèliàng-zhī Dí / Yuhtleuhng-jī Dehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Red Flute|', 3, q'|Snaps a Pokémon out of attraction.RSEFRLGColoXDDPPtHGSS Can be sold for 7500.BWB2W2|', nq'|あかいビードロ|', nq'|Akai Vidro|', nq'|Flûte Rouge|', nq'|Rote Flöte|', nq'|Flauto Rosso|', nq'|Flauta Roja|', nq'|빨강비드로|', nq'|Ppalgang Vidro|', nq'|紅色玻璃哨 / 红色玻璃哨|', nq'|Hóngsè Bōlí Shào / Hùhng-sīk Bōlèih Saau|', 128);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Dream Ball|', 5, q'|Used to catch Pokémon in Entralink.|', nq'|ドリームボール|', nq'|Dream Ball|', nq'|Rêve Ball|', nq'|Traumball|', nq'|Dream Ball|', nq'|Ensueño Ball|', nq'|드림볼|', nq'|Dream Ball|', nq'|夢境球 / 梦境球|', nq'|Mèngjìng Qiú / Muhnggíng Kàuh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Sun Shard|', 3, q'|Allows Eevee to evolve into Espeon.|', nq'|たいようのかけら|', nq'|Taiyō no Kakera|', nq'|Eclat Soleil|', nq'|Sonnsplitter|', nq'|Coccio Solare|', nq'|Ápice Sol|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Ring Target|', 5, q'|The holder loses its type immunities.|', nq'|ねらいのまと|', nq'|Nerai no Mato|', nq'|Point de Mire|', nq'|Zielscheibe|', nq'|Facilsaglio|', nq'|Blanco|', nq'|겨냥표적|', nq'|Gyeonyang Pyojeok|', nq'|標靶 / 标靶|', nq'|Biāobǎ / Bīubá|', 128);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Krane Memo 4|', 3, q'|Contains information about purification.|', nq'|クレインメモ４|', nq'|Krane Memo 4|', nq'|Memo Syrus 4|', nq'|Klein-Memo 4|', nq'|Appunti 4|', nq'|Parte Cío 4|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Rawst Berry|', 3, q'|Cures a burn.|', nq'|チーゴのみ|', nq'|Chīgo no Mi|', nq'|Baie Fraive|', nq'|Fragiabeere|', nq'|Baccafrago|', nq'|Baya Safre|', nq'|복분열매|', nq'|Bokbun Yeolmae|', nq'|莓莓果|', nq'|Méiméi Guǒ / Mùihmùih Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Watmel Berry|', 3, q'|Pokéblock and Poffin ingredient.|', nq'|カイスのみ|', nq'|Kaisu no Mi|', nq'|Baie Stekpa|', nq'|Wasmelbeere|', nq'|Baccacomero|', nq'|Baya Sambia|', nq'|슈박열매|', nq'|Syubak Yeolmae|', nq'|瓜西果|', nq'|Guāxī Guǒ / Gwāsāi Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Kommonium Z|', 7, q'|Allows Kommo-o to upgrade Clanging Scales to the special Z-Move Clangorous Soulblaze.|', nq'|ジャラランガＺ|', nq'|Jararanga-Z|', nq'|Ékaïzélite|', nq'|Grandirasium Z|', nq'|Kommonium Z|', nq'|Kommostal Z|', nq'|짜랑고우거Z|', nq'|Jjaranggougeo-Z|', nq'|杖尾鱗甲龍Ｚ / 杖尾鳞甲龙Ｚ|', nq'|Zhàngwěilínjiǎlóng-Z / Jeuhngméihlèuhngaaplùhng-Z|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|HMs|', 1, q'|Can be used to teach a field move to a Pokémon. HMs will not break up after use and as such can be used over and over again.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Dark Gem|', 5, q'|Increases the power of the holder's first Dark-type move by 50%, and is consumed after use.|', nq'|あくのジュエル|', nq'|Aku no Jewel|', nq'|Joyau Ténèbres|', nq'|Unlichtjuwel|', nq'|Bijoubuio|', nq'|Gema Siniestra|', nq'|악주얼|', nq'|Ak Jewel|', nq'|惡之寶石 / 恶之宝石|', nq'|È-zhī Bǎoshí / Ok-jī Bóusehk|', 144);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Pink Bow|', 2, q'|Raises the power of Normal-type moves.|', nq'|ピンクのリボン|', nq'|Pink no Ribbon|', nq'|Ruban Rose|', nq'|Rosa Band|', nq'|Fiocco Rosa|', nq'|Lazo Rosa|', nq'|핑크빛리본|', nq'|Pink-bit Ribon|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Soul Dew|', 3, q'|Increases the power of Psychic-type and Dragon-type moves used by Latias and Latios by 20%. (Raises the Special Attack and Special Defense of Latias and Latios before Gen. VII).|', nq'|こころのしずく|', nq'|Kokoro no Shizuku|', nq'|Rosée Âme|', nq'|Seelentau|', nq'|Cuorugiada|', nq'|Rocío Bondad|', nq'|마음의물방울|', nq'|Ma-eumui Mulbang-ul|', nq'|心之水滴|', nq'|Xīn-zhī Shuǐdī / Sām-jī Séuidihk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Choice Scarf|', 4, q'|Raises user's Speed, but they can only use one move.|', nq'|こだわりスカーフ|', nq'|Kodawari Scarf|', nq'|Mouchoir Choix|', nq'|Wahlschal|', nq'|Stolascelta|', nq'|Pañuelo Elegido|', nq'|구애스카프|', nq'|Guae Scarf|', nq'|講究圍巾 / 讲究围巾|', nq'|Jiǎngjiù Wéijīn / Gónggau Wàihgān|', 144);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Enigma Stone|', 4, q'|Allows for the capture of either Latias or Latios.|', nq'|なぞのすいしょう|', nq'|Nazo no Suishō|', nq'|Mystécristal|', nq'|Mytokristall|', nq'|Misticristal|', nq'|Misticristal|', nq'|수수께끼의수정|', nq'|Susukkekki-ui Sujeong|', nq'|謎之水晶 / 谜之水晶|', nq'|Mí-zhī Shuǐjīng / Màih-jī Séuijīng|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Wepear Berry|', 3, q'|Pokéblock and Poffin ingredient.|', nq'|セシナのみ|', nq'|Seshina no Mi|', nq'|Baie Repoi|', nq'|Nirbebeere|', nq'|Baccapera|', nq'|Baya Peragu|', nq'|서배열매|', nq'|Seobae Yeolmae|', nq'|西梨果|', nq'|Xīlí Guǒ / Sāilèih Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Dusk Ball|', 4, q'|A type of Poké Ball that works especially well in dark places such as caves or at night.|', nq'|ダークボール|', nq'|Dark Ball|', nq'|Sombre Ball|', nq'|Finsterball|', nq'|Scuro Ball|', nq'|Ocaso Ball|', nq'|다크볼|', nq'|Dark Ball|', nq'|黑暗球|', nq'|Hēi'àn Qiú / Hākam Kàuh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Blastoisinite|', 6, q'|Allows Blastoise to Mega Evolve into Mega Blastoise.|', nq'|カメックスナイト|', nq'|Kamexnite|', nq'|Tortankite|', nq'|Turtoknit|', nq'|Blastoisite|', nq'|Blastoisita|', nq'|거북왕나이트|', nq'|Geobugwangnite|', nq'|水箭龜進化石 / 水箭龟进化石|', nq'|Shuǐjiànguī Jìnhuà Shí / Séuijingwāi Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Blue Flute|', 3, q'|Awakens sleeping Pokémon when used, can be used an unlimited number of times. May be used in battle or in the field.RSEFRLGColoXDDPPtHGSSORAS Can be sold for 7000.BWB2W2|', nq'|あおいビードロ|', nq'|Aoi Vidro|', nq'|Flûte Bleue|', nq'|Blaue Flöte|', nq'|Flauto Blu|', nq'|Flauta Azul|', nq'|파랑비드로|', nq'|Parang Vidro|', nq'|藍色玻璃哨 / 蓝色玻璃哨|', nq'|Lán-sè Bōlí Shào / Làahm-sīk Bōlèih Saau|', 128);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Poké Flute|', 1, q'|Awakens sleeping Pokémon.|', nq'|ポケモンのふえ|', nq'|Pokémon no Fue|', nq'|Pokéflute|', nq'|Pokéflöte|', nq'|Pokéflauto|', nq'|Poké Flauta|', nq'|포켓몬피리|', nq'|Pocketmon Piri|', nq'|寶可夢之笛 / 宝可梦之笛|', nq'|Bǎokěmèng-zhī Dí / Bóuhómuhng-jī Dehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Safety Goggles|', 6, q'|Grants the holder immunity to weather-related damage and powder moves.|', nq'|ぼうじんゴーグル|', nq'|Bōjin Goggle|', nq'|Lunettes Filtre|', nq'|Schutzbrille|', nq'|Visierantisabbia|', nq'|Gafa Protectora|', nq'|방진고글|', nq'|Bangjin Goggle|', nq'|防塵護目鏡 / 防尘护目镜|', nq'|Fángchén Hù Mùjìng / Fòhngchàhn Wuh Muhkgeng|', 0);
insert into ITEMS(NAME, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(q'|Rage Candy Bar|', nq'|いかりまんじゅう|', nq'|Ikari Manjū|', nq'|Bonbon Rage|', nq'|Wutkeks|', nq'|Iramella|', nq'|Caram. Furia|', nq'|분노의호두과자|', nq'|Bunno-ui Hodugwaja|', nq'|憤怒饅頭 / 愤怒馒头|', nq'|Fènnù Mántou / Fáhnnouh Màahntàuh|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Salac Berry|', 3, q'|Raises Speed when HP is below ⅓ of maximum.|', nq'|カムラのみ|', nq'|Camula no Mi|', nq'|Baie Sailak|', nq'|Salkabeere|', nq'|Baccasalak|', nq'|Baya Aslac|', nq'|캄라열매|', nq'|Kamra Yeolmae|', nq'|沙鱗果 / 沙鳞果|', nq'|Shālín Guǒ / Sālèuhn Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Kebia Berry|', 4, q'|Lowers effectiveness of a super effective Poison-type move.|', nq'|ビアーのみ|', nq'|Biah no Mi|', nq'|Baie Kébia|', nq'|Grarzbeere|', nq'|Baccakebia|', nq'|Baya Kebia|', nq'|으름열매|', nq'|Eureum Yeolmae|', nq'|通通果|', nq'|Tōngtōng Guǒ / Tūngtūng Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Pass|', 2, q'|Allows the player to ride the Magnet Train between Saffron City, Kanto; and Goldenrod City, Johto.|', nq'|リニアパス|', nq'|Linear Pass|', nq'|Passe Train|', nq'|Fahrschein|', nq'|Superpass|', nq'|Magnetopase|', nq'|리니어패스|', nq'|Linear Pass|', nq'|定期月票|', nq'|Dìngqī Yuèpiào / Dihngkèih Yuhtpiu|', 956);
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|X Attack 3|', 5, q'|Drastically raises a Pokémon's Attack. Wonder Launcher only.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Devon Scope|', 3, q'|Reveals hidden Pokémon.|', nq'|デボンスコープ|', nq'|Devon Scope|', nq'|Devon Scope|', nq'|Devon-Scope|', nq'|Devonscopio|', nq'|Detector Devon|', nq'|데봉스코프|', nq'|Devon Scope|', nq'|得文偵測鏡 / 得文侦测镜|', nq'|Déwén Zhēncèjìng / Dākmàhn Jīngchākgeng|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Dark Stone|', 5, q'|Stone used to summon Zekrom.|', nq'|ダークストーン|', nq'|Dark Stone|', nq'|Galet Noir|', nq'|Dunkelstein|', nq'|Scurolite|', nq'|Orbe Oscuro|', nq'|다크스톤|', nq'|Dark Stone|', nq'|黑闇石 / 黑暗石|', nq'|Hēi'àn Shí / Hākam Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Clear Bell|', 2, q'|Summons SuicuneC or Ho-OhHGOR.|', nq'|とうめいなスズ|', nq'|Tōmei-na Suzu|', nq'|Glas Transparent|', nq'|Klarglocke|', nq'|Campana Chiara|', nq'|Campana Clara|', nq'|크리스탈방울|', nq'|Crystal Bang-ul|', nq'|透明鈴鐺 / 透明铃铛|', nq'|Tòumíng Língdāng / Taumìhng Lìhngdōng|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Spooky Plate|', 4, q'|Raises the power of Ghost-type moves.|', nq'|もののけプレート|', nq'|Mononoke Purēto|', nq'|Plaque Fantô|', nq'|Spuktafel|', nq'|Lastratetra|', nq'|Tabla Terror|', nq'|원령플레이트|', nq'|Wollyeong Plate|', nq'|妖怪石板|', nq'|Yāoguài Shíbǎn / Yīugwaai Sehkbáan|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Sail Fossil|', 6, q'|A Fossil from which an Amaura can be resurrected.|', nq'|ヒレのカセキ|', nq'|Hire no Kaseki|', nq'|Fossile Nageoire|', nq'|Flossenfossil|', nq'|Fossilpinna|', nq'|Fósil Aleta|', nq'|지느러미화석|', nq'|Jineuleomi Hwaseok|', nq'|鰭之化石 / 鳍之化石|', nq'|Qí-zhī Huàshí / Kèih-jī Fasehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Stick|', 2, q'|Raises Farfetch'd's critical hit ratio.|', nq'|ながねぎ|', nq'|Naganegi|', nq'|Baton|', nq'|Lauchstange|', nq'|Gambo|', nq'|Palo|', nq'|대파|', nq'|Daepa|', nq'|大蔥 / 大葱|', nq'|Dàcōng / Daaihchūng|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Harbor Mail|', 3, q'|Mail with a nautical design. To be held by a Pokémon for delivery.|', nq'|ハーバーメール|', nq'|Harbor Mail|', nq'|Lettre Port|', nq'|Hafenbrief|', nq'|Mess. Porto|', nq'|Carta Puerto|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Tapunium Z|', 7, q'|Allows the guardian deities to upgrade Nature's Madness to the special Z-Move Guardian of Alola.|', nq'|カプＺ|', nq'|Kapu-Z|', nq'|Tokozélite|', nq'|Kapium Z|', nq'|Tapium Z|', nq'|Tapistal Z|', nq'|카푸Z|', nq'|Kapu-Z|', nq'|卡璞Ｚ|', nq'|Kǎpú-Z / Kāpok-Z|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Shed Shell|', 4, q'|Allows the holder to escape from battle.|', nq'|きれいなぬけがら|', nq'|Kirei-na Nukegara|', nq'|Carapace Mue|', nq'|Wechselhülle|', nq'|Disfoguscio|', nq'|Muda Concha|', nq'|아름다운허물|', nq'|Areumdaun Heomul|', nq'|美麗空殼 / 美丽空壳|', nq'|Měilì Kōngké / Méihlaih Hūnghok|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Mosaic Mail|', 4, q'|Mail with a rainbow pattern. To be held by a Pokémon for delivery.|', nq'|モザイクメール|', nq'|Mosaic Mail|', nq'|Lettremosaik|', nq'|Mosaikbrief|', nq'|Mess. Iride|', nq'|Car. Mosaico|', nq'|모자이크메일|', nq'|Mosaic Mail|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Marshadium Z|', 7, q'|Allows Marshadow to upgrade Spectral Thief to the special Z-Move Soul-Stealing 7-Star Strike.|', nq'|マーシャドーＺ|', nq'|Marshadow-Z|', nq'|Marshadozélite|', nq'|Marshadownium Z|', nq'|Marshadium Z|', nq'|Marshastal Z|', nq'|마샤도Z|', nq'|Masyado-Z|', nq'|瑪夏多Ｚ / 玛夏多Ｚ|', nq'|Mǎxiàduō-Z / Máhahdō-Z|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Exp. Share|', 1, q'|A held item that allows Pokémon to gain experience without battling.|', q'|Named Exp.All prior to Generation II.|', nq'|がくしゅうそうち|', nq'|Gakushū Sōchi|', nq'|Multi Exp|', nq'|EP-Teiler|', nq'|Condividi Esp.|', nq'|Repartir Exp|', nq'|학습장치|', nq'|Hakseup Jangchi|', nq'|學習裝置 / 学习装置|', nq'|Xuéxí Zhuāngzhì / Hohkjaahp Jōngji|', 1056);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Razor Claw|', 4, q'|Raises the chance of getting a critical hit. Allows Sneasel to evolve at night.|', nq'|するどいツメ|', nq'|Surudoi Tsume|', nq'|Griffe Rasoir|', nq'|Scharfklaue|', nq'|Affilartigli|', nq'|Garra Afilada|', nq'|예리한손톱|', nq'|Yerihan Sontop|', nq'|銳利之爪 / 锐利之爪|', nq'|Ruìlì-zhī Zhuǎ / Yeuihleih-jī Jáau|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Prop Case|', 5, q'|Used to hold Props for the Pokémon Musical.|', nq'|グッズケース|', nq'|Goods Case|', nq'|Boîte Parure|', nq'|Deko-Box|', nq'|Portagadget|', nq'|Neceser|', nq'|굿즈케이스|', nq'|Goods Case|', nq'|物品箱|', nq'|Wùpǐn Xiāng / Mahtbán Sēung|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Fluffy Tail|', 3, q'|Allows the player to flee from any wild Pokémon battle.|', nq'|エネコのシッポ|', nq'|Eneco no Shippo|', nq'|Queue Skitty|', nq'|Eneco-Rute|', nq'|Coda Skitty|', nq'|Cola Skitty|', nq'|에나비꼬리|', nq'|Enabi Kkori|', nq'|向尾喵的尾巴|', nq'|Xiàngwěimiāo-de Wěibā/Xiàngwěimiāo-de Yǐba / Heungméihmīu-dīk Méihbā|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|SquirtBottle|', 2, q'|Used to bring Sudowoodo out of hiding.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|RSVP Mail|', 5, q'|Stationary designed for invitations. To be held by a Pokémon for delivery.|', nq'|おさそいメール|', nq'|Osasoi Mail|', nq'|Lettre Invit|', nq'|Einladebrief|', nq'|Mess. Invito|', nq'|C. Invitar|', nq'|권유메일|', nq'|Gweon'yu Mail|', nq'|邀請郵件 / 邀请邮件|', nq'|Yāoqǐng Yóujiàn / Yīuchíng Yàuhgín|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Macho Brace|', 2, q'|Raises Effort values but lowers Speed.|', nq'|きょうせいギプス|', nq'|Kyōsei Gips|', nq'|Bracelet Macho|', nq'|Machoband|', nq'|Crescicappa|', nq'|Brazal Firme|', nq'|교정깁스|', nq'|Gyojeong Gips|', nq'|強制鍛鍊器 / 强制锻炼器|', nq'|Qiángzhì Duànliànqì / Kèuhngjai Dyunlihnhei|', 144);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Lava Cookie|', 3, q'|Cures any status condition.|', nq'|フエンせんべい|', nq'|Fuen Senbei|', nq'|Lava Cookie|', nq'|Lavakeks|', nq'|Lavottino|', nq'|Galleta Lava|', nq'|용암전병|', nq'|Yong-am Jeonbyeong|', nq'|釜炎仙貝 / 釜炎仙贝|', nq'|Fǔyán Xiānbèi / Fúyìhm Sīnbui|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Lure Ball|', 2, q'|A type of Poké Ball that works best on Pokémon caught using a rod.|', nq'|ルアーボール|', nq'|Lure Ball|', nq'|Appat Ball|', nq'|Köderball|', nq'|Esca Ball|', nq'|Cebo Ball|', nq'|루어볼|', nq'|Lure Ball|', nq'|誘餌球 / 诱饵球|', nq'|Yòu'ěr Qiú / Yáuhneih Kàuh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Expert Belt|', 4, q'|Increases the power of super effective moves.|', nq'|たつじんのおび|', nq'|Tatsujin no Obi|', nq'|Ceinture Pro|', nq'|Expertengurt|', nq'|Abilcintura|', nq'|Cinta Experto|', nq'|달인의띠|', nq'|Darinui Tti|', nq'|達人帶 / 达人带|', nq'|Dárén Dài / Daahtyàhn Daai|', 0);
insert into ITEMS(NAME, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(q'|Photo Album|', nq'|フォトアルバム|', nq'|Photo Album|', nq'|Album Photo|', nq'|Fotoalbum|', nq'|Album|', nq'|Álbum|', nq'|포토앨범|', nq'|Photo Album|', nq'|相簿*|'||chr(10)||nq'|相册|', nq'|Xiàngbù / Séungbóu*|'||chr(10)||nq'|Xiàngcè|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Sea Incense|', 3, q'|Raises the power of Water-type moves. A Marill or Azumarill holding this can breed to produce Azurill Eggs.|', nq'|うしおのおこう|', nq'|Ushio no Okou|', nq'|Encens Mer|', nq'|Seerauch|', nq'|Marearoma|', nq'|Incienso marino|', nq'|바닷물향로|', nq'|Badasmul Hyangno|', nq'|海潮薰香|', nq'|Hǎicháo Xūnxiāng / Hóichìuh Fānhēung|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Muscle Wing|', 5, q'|Raises the Attack of a Pokémon.|', nq'|きんりょくのハネ|', nq'|Kinryoku no Hane|', nq'|Aile Force|', nq'|Kraftfeder|', nq'|Piumpotenza|', nq'|Pluma Músculo|', nq'|근력날개|', nq'|Geunryeok Nalgae|', nq'|肌力之羽|', nq'|Jīlì-zhī Yǔ / Gēilihk-jī Yúh|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Honey|', 4, q'|Can be slathered on orange trees to attract rare Pokémon; or used in grass to attract wild Pokémon the same way Sweet Scent does.|', nq'|あまいミツ|', nq'|Amai Mitsu|', nq'|Miel|', nq'|Honig|', nq'|Miele|', nq'|Miel|', nq'|달콤한꿀|', nq'|Dalkomhan Kkul|', nq'|甜甜蜜|', nq'|Tiántián Mì / Tìhmtìhm Maht|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Decidium Z|', 7, q'|Allows Decidueye to upgrade Spirit Shackle to the special Z-Move Sinister Arrow Raid.|', nq'|ジュナイパーＺ|', nq'|Junaiper-Z|', nq'|Archézélite|', nq'|Silvarronium Z|', nq'|Deciduenium Z|', nq'|Dueyestal Z|', nq'|모크나이퍼Z|', nq'|Mokeunaipeo-Z|', nq'|狙射樹梟Ｚ / 狙射树枭Ｚ|', nq'|Jūshèshùxiāo-Z / Jēuisehsyuhhīu-Z|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Journal|', 4, q'|Keeps track of events and accomplishments of the player.|', nq'|ぼうけんノート|', nq'|Bōken Note|', nq'|Journal|', nq'|Tagebuch|', nq'|Agenda|', nq'|Diario|', nq'|모험노트|', nq'|Moheom Note|', nq'|冒險筆記 / 冒险笔记|', nq'|Màoxiǎn Bǐjì / Mouhhím Bātgei|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Reset Urge|', 5, q'|Eliminates stat changes from an ally Pokémon. Wonder Launcher only.|', nq'|フラットコール|', nq'|Flat Call|', nq'|Réamorçage|', nq'|Umkehrappell|', nq'|Ripristino|', nq'|Quitaestado|', nq'|플랫콜|', nq'|Flat Call|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Orange Mail|', 3, q'|Mail with a Zigzagoon print. To be held by a Pokémon for delivery.|', nq'|オレンジメール|', nq'|Orange Mail|', nq'|Lettre Oranj|', nq'|Zigzagbrief|', nq'|Mess. Agrume|', nq'|Carta Naranja|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Max Potion|', 1, q'|Restores all of a Pokémon's HP.|', nq'|まんたんのくすり|', nq'|Mantan no Kusuri|', nq'|Potion Max|', nq'|Top-Trank|', nq'|Pozione Max|', nq'|Máxima Poción|', nq'|풀회복약|', nq'|Full Hoebok Yak|', nq'|全滿藥 / 全满药|', nq'|Quánmǎn Yào / Chyùhnmúhn Yeuhk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Amulet Coin|', 2, q'|Doubles the earned money after a battle against a Trainer.|', nq'|おまもりこばん|', nq'|Omamori Koban|', nq'|Piece Rune|', nq'|Münzamulett|', nq'|Monetamuleto|', nq'|Moneda Amuleto|', nq'|부적금화|', nq'|Bujeok Geumhwa|', nq'|護符金幣 / 护符金币|', nq'|Hùfú Jīnbì / Wuhfùh Gāmbaih|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Lemonade|', 1, q'|Restores 70 HP. (80HP before Gen. VII)|', nq'|ミックスオレ|', nq'|Mix au Lait|', nq'|Limonade|', nq'|Limonade|', nq'|Lemonsucco|', nq'|Limonada|', nq'|후르츠밀크|', nq'|Fruits Milk|', nq'|果汁牛奶|', nq'|Guǒzhī Niúnǎi / Gwójāp Ngàuhnáaih|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Incinium Z|', 7, q'|Allows Incineroar to upgrade Darkest Lariat to the special Z-Move Malicious Moonsault.|', nq'|ガオガエンＺ|', nq'|Gaogaen-Z|', nq'|Félinozélite|', nq'|Fuegronium Z|', nq'|Incineronium Z|', nq'|Incinostal Z|', nq'|어흥염Z|', nq'|Eoheungyeom-Z|', nq'|熾焰咆哮虎Ｚ / 炽焰咆哮虎Ｚ|', nq'|Chìyànpáoxiāohǔ-Z / Chiyihmpàauhhāaufú-Z|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Big Nugget|', 5, q'|Can be sold for 30000.|', nq'|でかいきんのたま|', nq'|Dekai Kin no Tama|', nq'|Maxi Pépite|', nq'|Riesennugget|', nq'|Granpepita|', nq'|Maxipepita|', nq'|큰금구슬|', nq'|Keun Geum Guseul|', nq'|巨大金珠|', nq'|Jùdà Jīnzhū / Geuihdaaih Gāmjyū|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Relic Band|', 5, q'|Can be sold for 100000 to the villa owner in Undella Town.|', nq'|こだいのうでわ|', nq'|Kodai no Udewa|', nq'|Vieux Bijou|', nq'|Alter Reif|', nq'|Bracciantico|', nq'|Brazal|', nq'|고대의팔찌|', nq'|Godae-yi Paljji|', nq'|古代手鐲 / 古代手镯|', nq'|Gǔdài Shǒuzhuó / Gúdoih Sáujuhk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Green Petal|', 7, q'|A green petal required to complete Mina's Trial.|', nq'|みどりのはなびら|', nq'|Midori no Hanabira|', nq'|Pétale Vert|', nq'|Grünes Blatt|', nq'|Petalo verde|', nq'|Pétalo Verde|', nq'|초록꽃잎|', nq'|Chorok Kkochip|', nq'|綠色花瓣 / 绿色花瓣|', nq'|Lǜ-sè Huābàn / Luhk-sīk Fāfáan|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Stable Mulch|', 4, q'|Extends the time ripened Berries will stay on the plant before falling.|', nq'|ながながこやし|', nq'|Naganaga Koyashi|', nq'|Fertistable|', nq'|Stabilmulch|', nq'|Fertilsaldo|', nq'|Abono Fijador|', nq'|오래오래비료|', nq'|Orae-orae Biryo|', nq'|久久肥|', nq'|Jiǔjiǔ Féi / Gáugáu Fèih|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Devon Parts|', 3, q'|To be delivered to Captain Stern.|', q'|Called Devon Goods in Generation III.|', nq'|デボンのにもつ|', nq'|Devon no Nimotsu|', nq'|Pack Devon|', nq'|Devon-Waren|', nq'|Merce Devon|', nq'|Piezas Devon|', nq'|데봉화물|', nq'|Devon Hwamul|', nq'|得文的物品|', nq'|Déwén-de Wùpǐn / Dākmàhn-dīk Mahtbán|', 1024);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Rainbow Flower|', 7, q'|A rainbow flower created from the Seven Petals obtained from Mina's trial, and required to finish Mina's Trial.|', nq'|にじいろのはな|', nq'|Nijiiro no Hana|', nq'|Fleur 7 Couleurs|', nq'|Regenbogenblüte|', nq'|Fiore arcobaleno|', nq'|Flor Irisada|', nq'|무지개꽃|', nq'|Mujigae Kkot|', nq'|虹色之花|', nq'|Hóng-sè-zhī Huā / Hùhng-sīk-jī Fā|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Terrain Extender|', 7, q'|Lengthens duration of Electric Terrain, Psychic Terrain, Grassy Terrain, Misty Terrain, as well as Electric Surge, Psychic Surge, Grassy Surge, and Misty Surge from 5 turns to 8 turns when used by the holder.|', nq'|グランドコート|', nq'|Ground Coat|', nq'|Champ'Duit|', nq'|Feldbeschichtung|', nq'|Fissacampo|', nq'|Cubresuelos|', nq'|그라운드코트|', nq'|Ground Coat|', nq'|大地膜|', nq'|Dàdì Mó / Daaihdeih Mohk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Antidote|', 1, q'|Heals the poisoning of a Pokémon.|', nq'|どくけし|', nq'|Dokukeshi|', nq'|Antidote|', nq'|Gegengift|', nq'|Antidoto|', nq'|Antídoto|', nq'|해독제|', nq'|Haedokje|', nq'|解毒藥 / 解毒药|', nq'|Jiědúyào / Gáaiduhkyeuhk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Power Band|', 4, q'|Promotes Special Defense EVs, but lowers Speed in battle.|', nq'|パワーバンド|', nq'|Power Band|', nq'|Bandeau Pouvoir|', nq'|Machtband|', nq'|Vigorbanda|', nq'|Banda Recia|', nq'|파워밴드|', nq'|Power Band|', nq'|力量束帶 / 力量束带|', nq'|Lìliàng Shùdài / Lihkleuhng Chūkdaai|', 128);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Tamato Berry|', 3, q'|Raises friendship, but lowers Speed EVs.|', nq'|マトマのみ|', nq'|Matoma no Mi|', nq'|Baie Tamato|', nq'|Tamotbeere|', nq'|Baccamodoro|', nq'|Baya Tamate|', nq'|토망열매|', nq'|Tomang Yeolmae|', nq'|茄番果|', nq'|Qiéfān Guǒ / Kéfāan Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Z-Ring|', 7, q'|Allows the player to use Z-Moves when a Pokémon is holding an appropriate Z-Crystal. Allows the player to use Mega Evolution after obtaining a Key Stone when a Pokémon is holding the appropriate Mega Stone.|', nq'|Ｚリング|', nq'|Z-Ring|', nq'|Bracelet Z|', nq'|Z-Ring|', nq'|Cerchio Z|', nq'|Pulsera Z|', nq'|Z링|', nq'|Z Ring|', nq'|Ｚ手環 / Ｚ手环|', nq'|Z Shǒuhuán / Z Sáuwàahn|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|BridgeMail D|', 5, q'|Stationary with a red drawbridge print. To be held by a Pokémon for delivery.|', nq'|ブリッジメールＨ|', nq'|Bridge Mail H|', nq'|Lettre PontY|', nq'|Brückbrief M|', nq'|Mess. Libec.|', nq'|C. Puente F|', nq'|브리지메일M|', nq'|Bridge Mail M|', nq'|橋梁郵件Ｈ / 桥梁邮件Ｈ|', nq'|Qiáoliáng Yóujiàn H / Kìuhlèuhng Yàuhgín H|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Wide Lens|', 4, q'|Boosts accuracy of holder by an 110%.|', nq'|こうかくレンズ|', nq'|Kōkaku Lens|', nq'|Loupe|', nq'|Großlinse|', nq'|Grandelente|', nq'|Lupa|', nq'|광각렌즈|', nq'|Gwanggak-lens|', nq'|廣角鏡 / 广角镜|', nq'|Guǎngjiǎo Jìng / Gwónggok Geng|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Subway Key|', 3, q'|Operates the subway between The Under and the Shadow PKMN Lab.|', nq'|ちかてつのカギ|', nq'|Chikatetsu no Kagi|', nq'|Cle de Contact|', nq'|Zugschlüssel|', nq'|Chiave Metro|', nq'|Llave Metro|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|King's Rock|', 2, q'|Slightly increases the chances of inflicting the Flinch condition on the opponent. Allows Slowpoke and Poliwhirl to evolve when traded.|', nq'|おうじゃのしるし|', nq'|Ōja no Shirushi|', nq'|Roche Royale|', nq'|King-Stein|', nq'|Roccia Di Re|', nq'|Roca del Rey|', nq'|왕의징표석|', nq'|Wang-ui Jingpyoseok|', nq'|王者之證 / 王者之证|', nq'|Wángzhě-zhī Zhèng / Wòhngjé-jī Jing|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Red Shard|', 3, q'|Exchangeable for a variety of services.|', nq'|あかいかけら|', nq'|Akai Kakera|', nq'|Tesson Rouge|', nq'|Purpurstück|', nq'|Coccio Rosso|', nq'|Parte Roja|', nq'|빨강조각|', nq'|Ppalgang Jogak|', nq'|紅色碎片 / 红色碎片|', nq'|Hóngsè Suìpiàn / Hùhngsīk Seuipin|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Shoal Shell|', 3, q'|Can be used to make a Shell Bell. Does not have any use in Generation IV. Can be sold to an item maniac in Route 5 for 7000 in Generation V.|', nq'|あさせのかいがら|', nq'|Asase no Kaigara|', nq'|CoquilleTréfonds|', nq'|Küstenschale|', nq'|Gusciondoso|', nq'|Concha Cardumen|', nq'|여울조개껍질|', nq'|Yeoul Jogaekkeopjil|', nq'|淺灘貝殼 / 浅滩贝壳|', nq'|Qiǎntān Bèiké / Chíntāan Buihok|', 144);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Razor Fang|', 4, q'|Raises the chance of causing an opponent to flinch. Allows Gligar to evolve at night.|', nq'|するどいキバ|', nq'|Surudoi Kiba|', nq'|Croc Rasoir|', nq'|Scharfzahn|', nq'|Affilodente|', nq'|Colmillo Agudo|', nq'|예리한이빨|', nq'|Yerihan Ippal|', nq'|銳利之牙 / 锐利之牙|', nq'|Ruìlì-zhī Yá / Yeuihleih-jī Ngàh|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Forage Bag|', 7, q'|Holds ingredients found during Mallow's trial.|', nq'|ざいりょうぶくろ|', nq'|Zairyō Bukuro|', nq'|Sac Ingrédients|', nq'|Zutatenbeutel|', nq'|Portaingredienti|', nq'|Zurrón|', nq'|재료주머니|', nq'|Jaelyo Jumeoni|', nq'|材料袋|', nq'|Cáiliào Dài / Chòihlíu Doih|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Aspear Berry|', 3, q'|Removes the frozen condition from a Pokémon.|', nq'|ナナシのみ|', nq'|Nanashi no Mi|', nq'|Baie Willia|', nq'|Wilbirbeere|', nq'|Baccaperina|', nq'|Baya Perasi|', nq'|배리열매|', nq'|Baeri Yeolmae|', nq'|利木果|', nq'|Lìmù Guǒ / Leihmuhk Gwó|', 0);
insert into ITEMS(NAME, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(q'|Seal Bag|', nq'|シールぶくろ|', nq'|Seal Bukuro|', nq'|Sac Sceaux|', nq'|Stickertüte|', nq'|Bollosacca|', nq'|Bolsa Sellos|', nq'|실주머니|', nq'|Seal Jumeoni|', nq'|貼紙袋 / 贴纸袋|', nq'|Tiēzhǐ Dài / Tipjí Doih|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Up-Grade|', 2, q'|A held item which allows Porygon to evolve when traded.|', nq'|アップグレード|', nq'|Upgrade|', nq'|Améliorator|', nq'|Up-Grade|', nq'|Upgrade|', nq'|Mejora|', nq'|업그레이드|', nq'|Upgrade|', nq'|升級資料*|'||chr(10)||nq'|升级数据|', nq'|Shēngjí Zīliào / Sīngkāp Jīlíu*|'||chr(10)||nq'|Shēngjí Shùjù|', 3);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Tunnel Mail|', 4, q'|Mail with a picture of a dark tunnel/mine. To be held by a Pokémon for delivery.|', nq'|トンネルメール|', nq'|Tunnel Mail|', nq'|Lettre Mine|', nq'|Minenbrief|', nq'|Mess. Tunnel|', nq'|Carta Mina|', nq'|터널메일|', nq'|Tunnel Mail|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Lagging Tail|', 4, q'|Causes the holder to move after the opponent.|', nq'|こうこうのしっぽ|', nq'|Kōkō no Shippo|', nq'|Ralentiqueue|', nq'|Schwerschwf.|', nq'|Rallentocoda|', nq'|Cola Plúmbea|', nq'|느림보꼬리|', nq'|Neurimbo Kkori|', nq'|後攻之尾 / 后攻之尾|', nq'|Hòugōng-zhī Wěi/Hòugōng-zhī Yǐ/ Hauhgūng-jī Méih|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Cleanse Tag|', 3, q'|Repels Pokémon if the holder is first in the party.|', nq'|きよめのおふだ|', nq'|Kiyome no Ofuda|', nq'|Rune Purifiante|', nq'|Schutzband|', nq'|Velopuro|', nq'|Amuleto|', nq'|순결의부적|', nq'|Sun-gyeorui Bujeok|', nq'|潔淨之符 / 洁净之符|', nq'|Jiéjìng-zhī Fú / Gitjihng-jī Fùh|', 128);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Persim Berry|', 3, q'|Cures confusion.|', nq'|キーのみ|', nq'|Kī no Mi|', nq'|Baie Kika|', nq'|Persimbeere|', nq'|Baccaki|', nq'|Baya Caquic|', nq'|시몬열매|', nq'|Simmon Yeolmae|', nq'|柿仔果|', nq'|Shìzǐ Guǒ / Chíhjái Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Pamtre Berry|', 3, q'|Pokéblock and Poffin ingredient.|', nq'|シーヤのみ|', nq'|Shīya no Mi|', nq'|Baie Palma|', nq'|Pallmbeere|', nq'|Baccapalma|', nq'|Baya Plama|', nq'|자야열매|', nq'|Jaya Yeolmae|', nq'|椰木果|', nq'|Yēmù Guǒ / Yèhmuhk Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|Eggant Berry|', 3, q'|Cures infatuation status. Will turn into an Enigma Berry if transferred to Generation IV via Pal Park.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Gram 1|', 5, q'|An important letter which Wingull delivers.|', nq'|はいたつぶつ１|', nq'|Haitatsubutsu 1|', nq'|Courrier 1|', nq'|Briefpost 1|', nq'|Missiva 1|', nq'|Envío 1|', nq'|배달물1|', nq'|Baedalmul 1|', nq'|配送物品１|', nq'|Pèisòng Wùpǐn 1 / Puisung Mahtbán 1|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Blue Petal|', 7, q'|A blue petal required to complete Mina's Trial.|', nq'|あおのはなびら|', nq'|Ao no Hanabira|', nq'|Pétale Bleu|', nq'|Blaues Blatt|', nq'|Petalo azzurro|', nq'|Pétalo Azul|', nq'|파랑꽃잎|', nq'|Parang Kkochip|', nq'|藍色花瓣 / 蓝色花瓣|', nq'|Lán-sè Huābàn / Làahm-sīk Fāfáan|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Ein File F|', 3, q'|Describes additional details on purification.|', nq'|ボルグファイルＦ|', nq'|Borg File F|', nq'|Dossier Teck F|', nq'|Culpa-Akte A-B|', nq'|Genus.File F|', nq'|Parte Ein: F|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Jaboca Berry|', 4, q'|If the foe's physical move hits, then the foe will also take damage.|', nq'|ジャポのみ|', nq'|Japo no Mi|', nq'|Baie Jacoba|', nq'|Jabocabeere|', nq'|Baccajaba|', nq'|Baya Jaboca|', nq'|자보열매|', nq'|Jabo Yeolmae|', nq'|嘉珍果|', nq'|Jiāzhēn Guǒ / Gājān Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Snorlium Z|', 7, q'|Allows Snorlax to upgrade Giga Impact to the special Z-Move Pulverizing Pancake.|', nq'|カビゴンＺ|', nq'|Kabigon-Z|', nq'|Ronflézélite|', nq'|Relaxonium Z|', nq'|Snorlactium Z|', nq'|Snorlastal Z|', nq'|잠만보Z|', nq'|Jammanbo-Z|', nq'|卡比獸Ｚ / 卡比兽Ｚ|', nq'|Kǎbǐshòu-Z / Kábeihsau-Z|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Rabuta Berry|', 3, q'|Pokéblock and Poffin ingredient.|', nq'|ラブタのみ|', nq'|Rabuta no Mi|', nq'|Baie Rabuta|', nq'|Rabutabeere|', nq'|Baccambutan|', nq'|Baya Rautan|', nq'|라부탐열매|', nq'|Rabutam Yeolmae|', nq'|茸丹果|', nq'|Rōngdān Guǒ / Yùhngdāan Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Super Rod|', 1, q'|Can be used next to or while Surfing on water to encounter high-level wild aquatic Pokémon.|', nq'|すごいつりざお|', nq'|Sugoi Tsurizao|', nq'|Mega Canne|', nq'|Superangel|', nq'|Super Amo|', nq'|Supercaña|', nq'|대단한낚싯대|', nq'|Daedanhan Naksitdae|', nq'|厲害釣竿 / 厉害钓竿|', nq'|Lìhài Diàogān / Laihhoih Diugōn|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Looker Ticket|', 6, q'|Must find five to advance the plot of the Looker post-game quest.|', nq'|ハンサムチケット|', nq'|Handsome Ticket|', nq'|Ticket Beladonis|', nq'|LeBelle-Ticket|', nq'|Carta Bellocchio|', nq'|Boleto Handsome|', nq'|핸섬티켓|', nq'|Handsome Ticket|', nq'|帥哥券 / 帅哥券|', nq'|Shuàigē Quàn / Seuigō Hyun|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Grn ID Badge|', 3, q'|One of four keys needed to unlock the north door of Realgam Tower.|', nq'|ＩＤバッジみどり|', nq'|ID Badge Midori|', nq'|Passe Vert|', nq'|Grüne ID-Marke|', nq'|Pass Verde|', nq'|Pase Verde|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Spelon Berry|', 3, q'|Pokéblock and Poffin ingredient.|', nq'|ノワキのみ|', nq'|Nowaki no Mi|', nq'|Baie Kiwan|', nq'|Kiwanbeere|', nq'|Baccamelos|', nq'|Baya Wikano|', nq'|메호키열매|', nq'|Mehoki Yeolmae|', nq'|刺角果|', nq'|Cìjiǎo Guǒ / Chigok Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Gear|', 3, q'|Keeps the Pyrite Town generators going.|', nq'|はぐるま|', nq'|Haguruma|', nq'|Roue Dentee|', nq'|Zahnrad|', nq'|Ingranaggio|', nq'|Rueda|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Pink Scarf|', 3, q'|Raises the Cute condition.|', nq'|ピンクのバンダナ|', nq'|Pink no Bandana|', nq'|Foul. Rose|', nq'|Rosa Schal|', nq'|Fascia Rosa|', nq'|Pañuelo Rosa|', nq'|분홍밴드|', nq'|Bunhong Band|', nq'|粉紅頭巾 / 粉红头巾|', nq'|Fěnhóng Tóujīn / Fánhùhng Tàuhgān|', 0);
insert into ITEMS(NAME, GEN, GEN2, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Good Rod|', 1, 4, q'|Allows the player to fish for medium-level aquatic Pokémon.|', nq'|いいつりざお|', nq'|Ii Tsurizao|', nq'|Super Canne|', nq'|Profiangel|', nq'|Amo Buono|', nq'|Caña Buena|', nq'|좋은낚싯대|', nq'|Jo-eun Naksitdae|', nq'|好釣竿 / 好钓竿|', nq'|Hǎo Diàogān / Hóu Diugōn|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Black Flute|', 3, q'|Repels wild Pokémon.RSEFRLGDPPtHGSS Can be sold for 8000.BWB2W2 Increases the level of wild Pokémon by one to three levels.ORAS|', nq'|くろいビードロ|', nq'|Kuroi Vidro|', nq'|Flûte Noire|', nq'|Schw. Flöte|', nq'|Flauto Nero|', nq'|Flauta Negra|', nq'|검정비드로|', nq'|Geomjeong Vidro|', nq'|黑色玻璃哨|', nq'|Hēi-sè Bōlí Shào / Hāak-sīk Bōlèih Saau|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Yellow Nectar|', 7, q'|Changes Oricorio to its Pom-Pom Style.|', nq'|やまぶきのミツ|', nq'|Yamabuki no Mitsu|', nq'|Nectar Jaune|', nq'|Gelber Nektar|', nq'|Nettare giallo|', nq'|Néctar Amarillo|', nq'|진노랑꿀|', nq'|Jinnorang Kkul|', nq'|金黃色花蜜 / 金黄色花蜜|', nq'|Jīnhuáng-sè Huāmì / Gāmwòhng-sīk Fāmaht|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Root Fossil|', 3, q'|A Fossil from which a Lileep can be resurrected.|', nq'|ねっこのカセキ|', nq'|Nekko no Kaseki|', nq'|Fossile Racine|', nq'|Wurzelfossil|', nq'|Radifossile|', nq'|Fósil Raíz|', nq'|뿌리화석|', nq'|Ppuri Hwaseok|', nq'|根狀化石 / 根状化石|', nq'|Gēnzhuàng Huàshí / Gānjohng Fasehk|', 128);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Banettite|', 6, q'|Allows Banette to Mega Evolve into Mega Banette.|', nq'|ジュペッタナイト|', nq'|Juppetanite|', nq'|Branettite|', nq'|Banetteonit|', nq'|Banettite|', nq'|Banettita|', nq'|다크펫나이트|', nq'|Darkpetnite|', nq'|詛咒娃娃進化石 / 诅咒娃娃进化石|', nq'|Zǔzhòuwáwá Jìnhuà Shí / Jojauwāwā Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Altarianite|', 6, q'|Allows Altaria to Mega Evolve into Mega Altaria.|', nq'|チルタリスナイト|', nq'|Tyltalisnite|', nq'|Altarite|', nq'|Altarianit|', nq'|Altarite|', nq'|Altarianita|', nq'|파비코리나이트|', nq'|Pavicorinite|', nq'|七夕青鳥進化石 / 七夕青鸟进化石|', nq'|Qīxìqīngniǎo Jìnhuà Shí / Chātjihkchīngníuh Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Krane Memo 3|', 3, q'|Contains information about the Snag Machine.|', nq'|クレインメモ３|', nq'|Krane Memo 3|', nq'|Memo Syrus 3|', nq'|Klein-Memo 3|', nq'|Appunti 3|', nq'|Parte Cío 3|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Assault Vest|', 6, q'|Raises Sp. Def but prevents the use of status moves.|', nq'|とつげきチョッキ|', nq'|Totsugeki Chokki|', nq'|Veste de Combat|', nq'|Offensivweste|', nq'|Corpetto Assalto|', nq'|Chaleco Asalto|', nq'|돌격조끼|', nq'|Dolgyeok Jokki|', nq'|突擊背心 / 突击背心|', nq'|Tújí Bèixīn / Dahtgīk Buisām|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Elevator Key|', 6, q'|Activates the elevator in Lysandre Labs.|', nq'|エレベーターキー|'||chr(10)||nq'|エレベーターのキー|', nq'|Elevator Key|'||chr(10)||nq'|Elevator no Key|', nq'|Cle Ascens.*|'||chr(10)||nq'|Clé Ascenseur|', nq'|Liftkarte*|'||chr(10)||nq'|Liftschlüssel|', nq'|Chiave Asc.|'||chr(10)||nq'|Chiave ascensore|', nq'|Ll. Ascensor|'||chr(10)||nq'|Llave Ascensor|', nq'|엘리베이터키|', nq'|Elevator Key|', nq'|電梯鑰匙 / 电梯钥匙|', nq'|Diàntī Yàoshi / Dihntāi Yeuhksìh|', 192);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Kasib Berry|', 4, q'|Lowers effectiveness of a super effective Ghost-type move.|', nq'|カシブのみ|', nq'|Kasib no Mi|', nq'|Baie Sédra|', nq'|Zitarzbeere|', nq'|Baccacitrus|', nq'|Baya Drasi|', nq'|수불열매|', nq'|Subul Yeolmae|', nq'|佛柑果|', nq'|Fógān Guǒ / Fahtgām Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Power Herb|', 4, q'|Allows user to skip first turn of moves that require charging.|', nq'|パワフルハーブ|', nq'|Powerful Herb|', nq'|Herbe Pouvoir|', nq'|Energiekraut|', nq'|Vigorerba|', nq'|Hierba Única|', nq'|파워풀허브|', nq'|Powerful Herb|', nq'|強力香草 / 强力香草|', nq'|Qiánglì Xiāngcǎo / Kèuhnglihk Hēungchóu|', 128);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Safari Ball|', 1, q'|A type of Poké Ball to be used in the Safari Zone.|', nq'|サファリボール|', nq'|Safari Ball|', nq'|Safari Ball|', nq'|Safariball|', nq'|Safari Ball|', nq'|Safari Ball|', nq'|사파리볼|', nq'|Safari Ball|', nq'|狩獵球 / 狩猎球|', nq'|Shòuliè Qiú / Sáulihp Kàuh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Never-Melt Ice|', 2, q'|Raises the power of Ice-type moves.|', q'|Formatted as NeverMeltIce prior to Generation VI.|', nq'|とけないこおり|', nq'|Tokenai Kōri|', nq'|Glace Éternelle|', nq'|Ewiges Eis|', nq'|Gelomai|', nq'|Antiderretir|', nq'|녹지않는얼음|', nq'|Nokji Anneun Eoreum|', nq'|不融冰|', nq'|Bù Róng Bīng / Bāt Yùhng Bīng|', 1152);
insert into ITEMS(NAME, GEN, DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Yellow Apricorn|', 2, q'|If taken to Kurt, he will make the player a Moon Ball out of it.|', q'|Formatted as Ylw Apricorn prior to Generation VI.|', nq'|きぼんぐり|', nq'|Ki Bonguri|', nq'|Noigrume Jne|', nq'|Aprikoko Glb|', nq'|Ghicocca Gialla|', nq'|Bonguri Amarillo|', nq'|노랑규토리|', nq'|Norang Gyutori|', nq'|黃球果 / 黄球果|', nq'|Huáng Qiúguǒ / Wòhng Kàuhgwó|', 1072);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Pair of Tickets|', 6, q'|Allows entry for two to the Mossdeep Space Center for the Litleonid star show.|', nq'|ペアチケット|', nq'|Pair Ticket|', nq'|Ticket Duo|', nq'|Zweierticket|', nq'|Biglietto doppio|', nq'|Entrada para dos|', nq'|페어티켓|', nq'|Pair of Tickets|', nq'|雙人票 / 双人票|', nq'|Shuāngrén Piào / Sēungyàhn Piu|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Krane Memo 1|', 3, q'|Contains information about snagging.|', nq'|クレインメモ１|', nq'|Krane Memo 1|', nq'|Memo Syrus 1|', nq'|Klein-Memo 1|', nq'|Appunti 1|', nq'|Parte Cío 1|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Power Weight|', 4, q'|Promotes HP EVs, but lowers Speed in battle.|', nq'|パワーウエイト|', nq'|Power Weight|', nq'|Poids Pouvoir|', nq'|Machtgewicht|', nq'|Vigorpeso|', nq'|Pesa Recia|', nq'|파워웨이트|', nq'|Power Weight|', nq'|力量負重 / 力量负重|', nq'|Lìliàng Fùzhòng / Lihkleuhng Fuhchúhng|', 128);
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|X Sp. Def 3|', 5, q'|Drastically raises a Pokémon's Special Defense. Wonder Launcher only.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Lucarionite|', 6, q'|Allows Lucario to Mega Evolve into Mega Lucario.|', nq'|ルカリオナイト|', nq'|Lucarionite|', nq'|Lucarite|', nq'|Lucarionit|', nq'|Lucarite|', nq'|Lucarita|', nq'|루카리오나이트|', nq'|Lucarionite|', nq'|路卡利歐進化石 / 路卡利欧进化石|', nq'|Lùkǎlì'ōu Jìnhuà Shí / Louhkāleih'āu Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Red Card|', 5, q'|Forces the opponent to switch to a random Pokémon when the holder is hit by a contact move. Consumed after use.|', nq'|レッドカード|', nq'|Red Card|', nq'|Carton Rouge|', nq'|Rote Karte|', nq'|Cartelrosso|', nq'|Tarjeta Roja|', nq'|레드카드|', nq'|Red Card|', nq'|紅牌 / 红牌|', nq'|Hóngpái / Hùhngpáai|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Pure Incense|', 4, q'|Causes Chimecho to produce a Chingling Egg at the Pokémon Day Care. Also lowers wild Pokémon encounter rate.|', nq'|きよめのおこう|', nq'|Kiyome no Okō|', nq'|Encens Pur|', nq'|Scheuchrauch|', nq'|Puroaroma|', nq'|Incienso puro|', nq'|순결의향로|', nq'|Sun-gyeorui Hyangno|', nq'|潔淨薰香 / 洁净薰香|', nq'|Jiéjìng Xūnxiāng / Gitjehng Fānhēung|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Pearl|', 2, q'|Can be sold for 3750.|', nq'|しんじゅ|', nq'|Shinju|', nq'|Perle|', nq'|Perle|', nq'|Perla|', nq'|Perla|', nq'|진주|', nq'|Jinju|', nq'|珍珠|', nq'|Zhēnzhū / Jānjyū|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Lax Incense|', 3, q'|Lowers the foe's accuracy. A Wobbuffet holding it can breed to produce a Wynaut.|', nq'|のんきのおこう|', nq'|Nonki no Okou|', nq'|Encens Doux|', nq'|Laxrauch|', nq'|Distraroma|', nq'|Incienso suave|', nq'|무사태평향로|', nq'|Musataepyeong Hyangno|', nq'|悠閒薰香 / 悠闲薰香|', nq'|Yōuxián Xūnxiāng / Yàuhhàahn Fānhēung|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Berry Pouch|', 3, q'|Holds Berries.|', nq'|きのみぶくろ|', nq'|Kinomi Bukuro|', nq'|Sac A Baies|', nq'|Beerentüte|', nq'|Porta Bacche|', nq'|Saco Bayas|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Pomeg Berry|', 3, q'|Makes a Pokémon more happy, but lowers EVs for HP.|', nq'|ザロクのみ|', nq'|Zaroku no Mi|', nq'|Baie Grena|', nq'|Granabeere|', nq'|Baccagrana|', nq'|Baya Grana|', nq'|유석열매|', nq'|Yuseok Yeolmae|', nq'|榴石果|', nq'|Liúshí Guǒ / Làuhsehk Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Cheri Berry|', 3, q'|Heals paralysis.|', nq'|クラボのみ|', nq'|Kurabo no Mi|', nq'|Baie Ceriz|', nq'|Amrenabeere|', nq'|Baccaliegia|', nq'|Baya Zreza|', nq'|버치열매|', nq'|Beochi Yeolmae|', nq'|櫻子果 / 樱子果|', nq'|Yīngzi Guǒ / Yīngjí Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Works Key|', 4, q'|Allows player access to the Valley Windworks near Floaroma Town.|', nq'|はつでんしょキー|', nq'|Hatsudensho Key|', nq'|Clé Centrale|', nq'|K-Schlüssel|', nq'|Turbinchiave|', nq'|Ll. Central|', nq'|발전소키|', nq'|Baljeonso Key|', nq'|發電廠鑰匙 / 发电厂钥匙|', nq'|Fādiànchǎng Yàoshi / Faatdihnchóng Yeuhksìh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Heart Scale|', 3, q'|Exchangeable for a variety of services.|', nq'|ハートのウロコ|', nq'|Heart no Uroko|', nq'|Écaille Cœur|', nq'|Herzschuppe|', nq'|Squama Cuore|', nq'|Escama Corazón|', nq'|하트비늘|', nq'|Heart Bineul|', nq'|心之鱗片 / 心之鳞片|', nq'|Xīn-zhī Línpiàn / Sām-jī Lèuhnpin|', 144);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Maranga Berry|', 6, q'|Increases Special Defense when hit by a special move.|', nq'|タラプのみ|', nq'|Tarapu no Mi|', nq'|Baie Rangma|', nq'|Tarabeere|', nq'|Baccapane|', nq'|Baya Maranga|', nq'|타라프열매|', nq'|Tarapeu Yeolmae|', nq'|香羅果 / 香罗果|', nq'|Xiāngluó Guǒ / Hēunglòh Gwó|', 0);
insert into ITEMS(NAME, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(q'|Roto Catch|', nq'|つかまえポン|', nq'|Tsukamae Pon|', nq'|Moti-Capture|', nq'|Fangbon|', nq'|Acchiappa'n'roll|', nq'|Cupón Captura|', nq'| ???|', nq'| ???|', nq'|捕捉碰碰|', nq'|Bǔzhuō Pèngpèng / Bouhjūk Pungpung|');
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|Teru-sama|', 2, q'|A group of dummy items. Unobtainable during normal gameplay.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Resist Wing|', 5, q'|Raises the Defense of a Pokémon.|', nq'|ていこうのハネ|', nq'|Teikō no Hane|', nq'|Aile Armure|', nq'|Abwehrfeder|', nq'|Piumtutela|', nq'|Pluma Aguante|', nq'|저항력날개|', nq'|Jeohangryeok Nalgae|', nq'|抵抗之羽|', nq'|Dǐkàng-zhī Yǔ / Dáikong-jī Yúh|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Tanga Berry|', 3, q'|Lowers effectiveness of a super effective Bug-type move.|', nq'|タンガのみ|', nq'|Tanga no Mi|', nq'|Baie Panga|', nq'|Tanigabeere|', nq'|Baccaitan|', nq'|Baya Yecana|', nq'|리체열매|', nq'|Riche Yeolmae|', nq'|扁櫻果 / 扁樱果|', nq'|Biǎnyīng Guǒ / Bínyīng Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Ability Urge|', 5, q'|Activates the Ability of an ally Pokémon. Wonder Launcher only.|', nq'|スキルコール|', nq'|Skill Call|', nq'|Appel CapSpé|', nq'|Fäh.-Appell|', nq'|Chiamabilità|', nq'|Habilitador|', nq'|스킬콜|', nq'|Skill Call|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Down St. Key|', 3, q'|Allows the player to access the basement floor of the Shadow PKMN Lab.|', nq'|ちかつうろのカギ|', nq'|Chikatsūro no Kagi|', nq'|Cle du Sous-Sol|', nq'|Ug-Schlüssel|', nq'|Chiave Sott.|', nq'|Llave Sótano|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Nest Ball|', 3, q'|A type of Poké Ball that works better on low-level Pokémon.|', nq'|ネストボール|', nq'|Nest Ball|', nq'|Faiblo Ball|', nq'|Nestball|', nq'|Minor Ball|', nq'|Nido Ball|', nq'|네스트볼|', nq'|Nest Ball|', nq'|巢穴球|', nq'|Cháoxuè Qiú / Chàauhyuht Kàuh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Pinsirite|', 6, q'|Allows Pinsir to Mega Evolve into Mega Pinsir.|', nq'|カイロスナイト|', nq'|Kailiosnite|', nq'|Scarabruite|', nq'|Pinsirnit|', nq'|Pinsirite|', nq'|Pinsirita|', nq'|쁘사이저나이트|', nq'|Ppeusaizeonite|', nq'|凱羅斯進化石 / 凯罗斯进化石|', nq'|Kǎiluósī Jìnhuà Shí / Hóilòhsī Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|HP Up|', 1, q'|Raises the HP of a Pokémon.|', nq'|マックスアップ|', nq'|Max Up|', nq'|PV Plus|', nq'|KP-Plus|', nq'|PS-Su|', nq'|Más PS|', nq'|맥스업|', nq'|Max Up|', nq'|ＨＰ增強劑 / ＨＰ增强剂|', nq'|HP Zēngqiángjì / HP Jāngkèuhngjaih|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Ghost Memory|', 7, q'|Makes Silvally a Ghost-type Pokémon and makes Multi-Attack a Ghost-type move.|', nq'|ゴーストメモリ|', nq'|Ghost Memory|', nq'|ROM Spectre|', nq'|Geister-Disc|', nq'|ROM Spettro|', nq'|Disco Fantasma|', nq'|고스트메모리|', nq'|Ghost Memory|', nq'|幽靈記憶碟*|'||chr(10)||nq'|幽灵存储碟|', nq'|Yōulíng Jìyìdié / Yāulìhng Geiyīkdihp*|'||chr(10)||nq'|Yōulíng Cúnchǔdié|', 3);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Joy Scent|', 3, q'|Reduces heart gauge by a small amount, but increases friendship.|', nq'|ルンルンのかおり|', nq'|Runrun no Kaori|', nq'|P. Doux|', nq'|Froh-E.|', nq'|Olio di Pino|', nq'|Ar. Alegría|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|X Accuracy 2|', 5, q'|Sharply raises a Pokémon's accuracy. Wonder Launcher only.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Wailmer Pail|', 3, q'|Used to water Berry plants.|', nq'|ホエルコじょうろ|', nq'|Hoeruko Jōro|', nq'|Wailmerrosoir|', nq'|Wailmerkanne|', nq'|Vaso Wailmer|', nq'|Wailmegadera|', nq'|고래왕자물뿌리개|', nq'|Goraewangja Mulppurigae|', nq'|吼吼鯨噴壺 / 吼吼鲸喷壶|', nq'|Hǒuhǒujīng Pēnhú / Hāauhāaukìhng Panwùh|', 144);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Ein File P|', 3, q'|Describes purification.|', nq'|ボルグファイルＲ|', nq'|Borg File R|', nq'|Dossier Teck P|', nq'|Culpa-Akte C-E|', nq'|Genus.File P|', nq'|Parte Ein: P|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Stone Plate|', 4, q'|Raises the power of Rock-type moves.|', nq'|がんせきプレート|', nq'|Ganseki Purēto|', nq'|Plaque Roc|', nq'|Steintafel|', nq'|Lastrapietra|', nq'|Tabla Pétrea|', nq'|암석플레이트|', nq'|Amseok Plate|', nq'|岩石石板|', nq'|Yánshí Shíbǎn / Ngàahmsehk Sehkbáan|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Dive Ball|', 3, q'|A type of Poké Ball that works better on Pokémon encountered underwaterRSEORAS or while Surfing or fishingFRLGDPPtHGSSBWB2W2XY.|', nq'|ダイブボール|', nq'|Dive Ball|', nq'|Scuba Ball|', nq'|Tauchball|', nq'|Sub Ball|', nq'|Buceo Ball|', nq'|다이브볼|', nq'|Dive Ball|', nq'|潛水球 / 潜水球|', nq'|Qiánshuǐ Qiú / Chìhmséui Kàuh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Deep Sea Scale|', 3, q'|A hold item that allows Clamperl to evolve into Gorebyss when traded.|', q'|Formatted as DeepSeaScale prior to Generation VI.|', nq'|しんかいのウロコ|', nq'|Shinkai no Uroko|', nq'|Écaille Océan|', nq'|Abyssplatte|', nq'|Squamabissi|', nq'|Escama Marina|', nq'|심해의비늘|', nq'|Simhae-ui Bineul|', nq'|深海鱗片 / 深海鳞片|', nq'|Shēnhǎi Línpiàn / Sāmhói Lèuhnpin|', 1152);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Abomasite|', 6, q'|Allows Abomasnow to Mega Evolve into Mega Abomasnow.|', nq'|ユキノオナイト|', nq'|Yukinoonite|', nq'|Blizzarite|', nq'|Rexblisarnit|', nq'|Abomasnowite|', nq'|Abomasnowita|', nq'|눈설왕나이트|', nq'|Nunseolwangnite|', nq'|暴雪王進化石 / 暴雪王进化石|', nq'|Bàoxuěwáng Jìnhuà Shí / Bouhsyutwòhng Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Silk Scarf|', 3, q'|Raises the power of Normal-type moves.|', nq'|シルクのスカーフ|', nq'|Silk no Scarf|', nq'|Mouchoir Soie|', nq'|Seidenschal|', nq'|Sciarpa Seta|', nq'|Pañuelo Seda|', nq'|실크스카프|', nq'|Silk Scarf|', nq'|絲綢圍巾 / 丝绸围巾|', nq'|Sīchóu Wéijīn / Sīchàuh Wàihgān|', 160);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Galactic Key|', 4, q'|Allows player to access the Galactic HQ in Veilstone City.|', nq'|ギンガだんのカギ|', nq'|Ginga-dan no Kagi|', nq'|Clé Galaxie|', nq'|G-Schlüssel|', nq'|Galachiave|', nq'|Ll. Galaxia|', nq'|갤럭시단의 열쇠|', nq'|Galaxy Dan-ui Yeolsoe|', nq'|銀河隊鑰匙 / 银河队钥匙|', nq'|Yínhé Duì Yàoshi / Ngàhnhòh Déui Yeuhksìh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Dragonium Z|', 7, q'|Allows a Pokémon to upgrade their Dragon-type damaging moves to the Z-Move Devastating Drake or upgrade their Dragon-type status moves into Z-Moves. Makes Arceus a Dragon-type Pokémon.|', nq'|ドラゴンＺ|', nq'|Dragon-Z|', nq'|Dracozélite|', nq'|Dracium Z|', nq'|Draconium Z|', nq'|Dracostal Z|', nq'|드개곤Z|', nq'|Dragon-Z|', nq'|龍Ｚ / 龙Ｚ|', nq'|Lóng-Z / Lùhng-Z|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Timer Ball|', 3, q'|A type of Poké Ball that works better the longer the battle has lasted.|', nq'|タイマーボール|', nq'|Timer Ball|', nq'|Chrono Ball|', nq'|Timerball|', nq'|Timer Ball|', nq'|Turno Ball|', nq'|타이마볼|', nq'|Timer Ball|', nq'|計時球 / 计时球|', nq'|Jìshí Qiú / Gaisìh Kàuh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Eject Button|', 5, q'|Forces the holder to switch out when hit by an attack that makes contact. Consumed after use.|', nq'|だっしゅつボタン|', nq'|Dasshutsu Button|', nq'|Bouton Fuite|', nq'|Fluchtknopf|', nq'|Pulsantefuga|', nq'|Botón Escape|', nq'|탈출버튼|', nq'|Talchul Button|', nq'|逃脫按鍵 / 逃脱按键|', nq'|Táotuō Ànjiàn / Tòuhtyut Ongihn|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|X Accuracy|', 1, q'|Raises a Pokémon's Accuracy by 2 stages (1 stage before Gen. VII).|', nq'|ヨクアタール|', nq'|Yokuatāru|', nq'|Precision +|', nq'|X-Treffer|', nq'|Precisione X|', nq'|Precisión X|', nq'|잘-맞히기|', nq'|Jal-Machigi|', nq'|命中強化 / 命中强化|', nq'|Mìngzhòng Qiánghuà / Mihngjung Kèuhngfa|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Secret Key|', 1, q'|Allows access to the Cinnabar Gym.|', nq'|ひみつのカギ|', nq'|Himitsu no Kagi|', nq'|Clé Secrète|', nq'| ?-Öffner|', nq'|Chiave Segreta|', nq'|Ll. Secreta|', nq'|비밀의열쇠|', nq'|Bimirui Yeolsoe|', nq'|秘密鑰匙 / 秘密钥匙|', nq'|Mìmì Yàoshi / Beimaht Yeuhksìh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Black Belt|', 2, q'|Raises the power of Fighting-type moves.|', q'|Formatted as Blackbelt in Generation II.|', nq'|くろおび|', nq'|Kuro Obi|', nq'|Ceinture Noire|', nq'|Schwarzgurt|', nq'|Cinturanera|', nq'|Cinturón Negro|', nq'|검은띠|', nq'|Geomeun Tti|', nq'|黑帶 / 黑带|', nq'|Hēidài / Hāakdaai|', 128);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Escape Rope|', 1, q'|Teleports the player out of a cave or dungeon if the player cannot find the way out.|', nq'|あなぬけのヒモ|', nq'|Ananuke no Himo|', nq'|Corde Sortie|', nq'|Fluchtseil|', nq'|Fune di Fuga|', nq'|Cuerda Huida|', nq'|동굴탈출로프|', nq'|Donggul Talchul Rope|', nq'|離洞繩 / 离洞绳|', nq'|Lídòng Shéng / Lèihduhng Sìhng|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Voice Case 5|', 3, q'|Heals a Shroomish at ONBS.|', nq'|こえカプセル５|', nq'|Koe Capsule 5|', nq'|Boite Cri 5|', nq'|Stimmbox 5|', nq'|Disco Verso 5|', nq'|Grabación 5|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Pikanium Z|', 7, q'|Allows Pikachu to upgrade Volt Tackle to the special Z-Move Catastropika.|', nq'|ピカチュウＺ|', nq'|Pikachu-Z|', nq'|Pikazélite|', nq'|Pikachium Z|', nq'|Pikacium Z|', nq'|Pikastal Z|', nq'|피카츄Z|', nq'|Pikachu-Z|', nq'|皮卡丘Ｚ|', nq'|Píkǎqiū-Z / Pèihkāyāu-Z|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Fresh Water|', 1, q'|Restores 30 HP. (50HP before Gen. VII).|', nq'|おいしいみず|', nq'|Oishii Mizu|', nq'|Eau Fraiche|', nq'|Tafelwasser|', nq'|Acqua Fresca|', nq'|Agua Fresca|', nq'|맛있는물|', nq'|Masinneun Mul|', nq'|美味之水|', nq'|Měiwèi-zhī Shuǐ / Méihmeih-jī Séui|', 0);
insert into ITEMS(NAME, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH)
values(q'|Battle CD|', nq'|バトルディスク|', nq'|Battle Disk|', nq'|Holodisk|', nq'|Kampf-CD|', nq'|CD Lotta|', nq'|Disco C.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Dragon Skull|', 5, q'|Stolen from the Nacrene Museum by a Team Plasma Grunt.|', nq'|ドラゴンのホネ|', nq'|Dragon no Hone|', nq'|Crâne Dragon|', nq'|Drakoschädel|', nq'|Teschio|', nq'|Crán. Dragón|', nq'|드래곤의뼈|', nq'|Dragon-yi Ppyeo|', nq'|龍之骨 / 龙之骨|', nq'|Lóng-zhī Gǔ / Lùhng-jī Gwāt|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Revive|', 1, q'|Revives a Pokémon to half of maximum HP.|', nq'|げんきのかけら|', nq'|Genki no Kakera|', nq'|Rappel|', nq'|Beleber|', nq'|Revitalizzante|', nq'|Revivir|', nq'|기력의조각|', nq'|Giryeog-ui Jogak|', nq'|活力碎片|', nq'|Huólì Suìpiàn / Wuhtlihk Seuipín|', 32);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Blue Orb|', 3, q'|Used to awaken Kyogre. It also turns Kyogre into Primal Kyogre during battle when holding the item.ORAS|', nq'|あいいろのたま|', nq'|Aiiro no Tama|', nq'|Gemme Bleue|', nq'|Blauer Edelstein|', nq'|Gemma blu|', nq'|Prisma Azul|', nq'|쪽빛구슬|', nq'|Jjokbit Guseul|', nq'|靛藍色寶珠 / 靛蓝色宝珠|', nq'|Diànlán-sè Bǎozhū / Dihnlàahm-sīk Bóujyū|', 240);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|AuroraTicket|', 3, q'|Event item that allows player to catch Deoxys.|', nq'|オーロラチケット|', nq'|Aurora Ticket|', nq'|Ticketaurora|', nq'|Auroraticket|', nq'|Biglietto Aurora|', nq'|Ori-Ticket|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Bitter Berry|', 2, q'|Heals confusion.|', nq'|にがいきのみ|', nq'|Nigai Kino Mi|', nq'|Baie Amere|', nq'|Bitterbeere|', nq'|Bacca Amara|', nq'|Bayamarga|', nq'|쓴맛나무열매|', nq'|Sseunmat Namu Yeolmae|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Normalium Z|', 7, q'|Allows a Pokémon to upgrade their Normal-type damaging moves to the Z-Move Breakneck Blitz or upgrade their Normal-type status moves into Z-Moves.|', nq'|ノーマルＺ|', nq'|Normal-Z|', nq'|Normazélite|', nq'|Normium Z|', nq'|Normium Z|', nq'|Normastal Z|', nq'|노말Z|', nq'|Normal-Z|', nq'|一般Ｚ|', nq'|Yī​bān-Z / Yātbūn-Z|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Adventure Rules|', 6, q'|Contains information new Trainers should know.|', nq'|たんけんこころえ|', nq'|Tanken Kokoroe|', nq'|ABC Aventure|', nq'|Abenteuerfibel|', nq'|Guida Avventura|', nq'|Guía de Máximas|', nq'|탐험수칙|', nq'|Tamheom Suchig|', nq'|探險心得 / 探险心得|', nq'|Tànxiǎn Xīndé / Taamhím Sāmdāk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Old Amber|', 1, q'|A Fossil from which an Aerodactyl can be resurrected.|', nq'|ひみつのコハク|', nq'|Himitsu no Kohaku|', nq'|Vieil Ambre|', nq'|Altbernstein|', nq'|Ambra Antica|', nq'|Ambar Viejo|', nq'|비밀의호박|', nq'|Bimirui Hobak|', nq'|秘密琥珀|', nq'|Mìmì Hǔpò / Beimaht Fúpaak|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Ether|', 1, q'|Restores 10 PP of one move of a Pokémon.|', nq'|ピーピーエイド|', nq'|PP Aid|', nq'|Huile|', nq'|Äther|', nq'|Etere|', nq'|Éter|', nq'|PP에이드|', nq'|PP Aid|', nq'|ＰＰ單項小補劑 / ＰＰ单项小补剂|', nq'|PP Dānxiàng Xiǎobǔjì / PP Dāanhohng Síubóujaih|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Space Mail|', 4, q'|Mail with an outer space pattern. To be held by a Pokémon for delivery.|', nq'|スペースメール|', nq'|Space Mail|', nq'|Lettre Cosmo|', nq'|Sternbrief|', nq'|Mess. Spazio|', nq'|Car. Sideral|', nq'|스페이스메일|', nq'|Space Mail|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Flying Gem|', 5, q'|Increases the power of the holder's first Flying-type move by 50%, and is consumed after use.|', nq'|ひこうのジュエル|', nq'|Hikō no Jewel|', nq'|Joyau Vol|', nq'|Flugjuwel|', nq'|Bijouvolante|', nq'|Gema Voladora|', nq'|비행주얼|', nq'|Bihaeng Jewel|', nq'|飛行寶石 / 飞行宝石|', nq'|Fēixíng Bǎoshí / Fēihàhng Bóusehk|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Dropped Item|', 5, q'|The Xtransceiver found at the Nimbasa City amusement park. It seems it belongs to a boy/girl.|', nq'|わすれもの|', nq'|Forgotten Item|', nq'|Objet Trouvé|', nq'|Fundsache|', nq'|Oggetto Perso|', nq'|Obj. Perdido|', nq'|잊은물건|', nq'|Ijeun Mulgeon|', nq'|遺忘物 / 遗忘物|', nq'|Yíwàng Wù / Wàihmòhng Maht|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Heracronite|', 6, q'|Allows Heracross to Mega Evolve into Mega Heracross.|', nq'|ヘラクロスナイト|', nq'|Heracrosnite|', nq'|Scarhinoïte|', nq'|Skarabornit|', nq'|Heracrossite|', nq'|Heracrossita|', nq'|헤라크로스나이트|', nq'|Heracrossnite|', nq'|赫拉剋羅斯進化石 / 赫拉克罗斯进化石|', nq'|Hèlākèluósī Jìnhuà Shí / Hāklāaihāklòhsī Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Flower Mail|', 2, q'|Mail with a flower pattern. To be held by a Pokémon for delivery.|', nq'|はながらメール|', nq'|Hanagara Mail|', nq'|Lettre Fleur|', nq'|Blumenbrief|', nq'|Messaggio Fiore|', nq'|Carta Flor|', nq'|꽃무늬메일|', nq'|Kkonmunui Mail|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Blue Apricorn|', 2, q'|If taken to Kurt, he will make the player a Lure Ball. Also, Apricorn Drink ingredient.|', q'|Formatted as Blu Apricorn prior to Generation VI.|', nq'|あおぼんぐり|', nq'|Ao Bonguri|', nq'|Noigrume Blu|', nq'|Aprikoko Blu|', nq'|Ghicocca Blu|', nq'|Bonguri Azul|', nq'|파란규토리|', nq'|Paran Gyutori|', nq'|藍球果 / 蓝球果|', nq'|Lán Qiúguǒ / Làahm Kàuhgwó|', 1072);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Muscle Band|', 4, q'|Raises the power of physical moves.|', nq'|ちからのハチマキ|', nq'|Chikara no Hachimaki|', nq'|Bandeau Muscle|', nq'|Muskelband|', nq'|Muscolbanda|', nq'|Cinta Fuerte|', nq'|힘의머리띠|', nq'|Himui Meoritti|', nq'|力量頭帶 / 力量头带|', nq'|Lìliàng Tóudài / Lihkleuhng Tàuhdaai|', 128);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Glalitite|', 6, q'|Allows Glalie to Mega Evolve into Mega Glalie.|', nq'|オニゴーリナイト|', nq'|Onigohrinite|', nq'|Oniglalite|', nq'|Firnontornit|', nq'|Glalite|', nq'|Glalita|', nq'|얼음귀신나이트|', nq'|Urumkisinnite|', nq'|冰鬼護進化石 / 冰鬼护进化石|', nq'|Bīngguǐhù Jìnhuà Shí / Bīnggwáiwuh Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|DNA Splicers|', 5, q'|Combines and separates Kyurem with Reshiram or Zekrom, transforming them into White Kyurem or Black Kyurem, respectively.|', nq'|いでんしのくさび|', nq'|Gene Wedge|', nq'|Pointeau ADN|', nq'|DNS-Keil|', nq'|Cuneo DNA|', nq'|Punta ADN|', nq'|유전자쐐기|', nq'|Yujeonja Swae-gi|', nq'|基因之楔|', nq'|Jīyīn-zhī Xiē / Gēiyān-jī Sit|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Ability Capsule|', 6, q'|Allows a Pokémon with two Abilities to switch between these Abilities.|', nq'|とくせいカプセル|', nq'|Tokusei Capsule|', nq'|Pilule Talent|', nq'|Fähigk.-Kapsel|', nq'|Capsula Abilità|', nq'|Cáps. Habilidad|', nq'|특성캡슐|', nq'|Teukseong Capsule|', nq'|特性膠囊 / 特性胶囊|', nq'|Tèxìng Jiāonáng / Dahksing Gāaunòhng|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Tri-Pass|', 3, q'|Allows the player to travel to the first three Sevii Islands.|', nq'|トライパス|', nq'|Tri Pass|', nq'|Tri-Pass|', nq'|Tri-Pass|', nq'|Tri-Pass|', nq'|Tri-Ticket|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Mint Berry|', 2, q'|Awakens a sleeping Pokémon.|', nq'|はっかのみ|', nq'|Hakka no Mi|', nq'|Baie Menthe|', nq'|Minzbeere|', nq'|Bacca Menta|', nq'|Baya Menta|', nq'|박하열매|', nq'|Bakha Yeolmae|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Greet Mail|', 5, q'|Stationary for introductory greetings. To be held by a Pokémon for delivery.|', nq'|はじめてメール|', nq'|Hajimete Mail|', nq'|Lettre Salut|', nq'|Grußbrief|', nq'|Mess. Inizio|', nq'|C. Inicial|', nq'|첫메일|', nq'|Cheot Mail|', nq'|初次郵件 / 初次邮件|', nq'|Chūcì Yóujiàn / Chōchi Yàuhgín|', 0);
insert into ITEMS(NAME, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(q'|Roto Hatch|', nq'|タマゴふかポン|', nq'|Tamago fuka Pon|', nq'|Moti-Couveuse|', nq'|Brutbon|', nq'|Cova'n'roll|', nq'|Cupón Eclosión|', nq'| ???|', nq'| ???|', nq'|孵蛋碰碰|', nq'|Fūdàn Pèngpèng / Fūdaahn Pungpung|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Acro Bike|', 3, q'|A bicycle with which the player can do tricks such as jump sideways.|', nq'|ダートじてんしゃ|', nq'|Dirt Jitensha|', nq'|Vélo Cross|', nq'|Kunstrad|', nq'|Bici da cross|', nq'|Bici Acrobática|', nq'|더트자전거|', nq'|Dirt Jajeongeo|', nq'|越野自行車 / 越野自行车|', nq'|Yuèyě Zìxíngchē / Yuhtyéh Jihhàhngchē|', 32);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Lunalium Z|', 7, q'|Allows Lunala and Dawn Wings Necrozma to upgrade Moongeist Beam to the special Z-Move Menacing Moonraze Maelstrom.|', nq'|ルナアーラＺ|', nq'|Lunala-Z|', nq'|Lunazélite|', nq'|Lunalium Z|', nq'|Lunalium Z|', nq'|Lunalastal Z|', nq'|루나아라Z|', nq'|Lunala-Z|', nq'|露奈雅拉Ｚ|', nq'|Lùnàiyǎlā-Z / Louhnoihngáhlāai-Z|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Adamant Orb|', 4, q'|Boosts Dialga's Steel- and Dragon-type attacks.|', nq'|こんごうだま|', nq'|Kongō Dama|', nq'|Orbe Adamant|', nq'|Adamant-Orb|', nq'|Adamasfera|', nq'|Diamansfera|', nq'|금강옥|', nq'|Geumgang Ok|', nq'|金剛寶珠 / 金刚宝珠|', nq'|Jīngāng Bǎozhū / Gāmgōng Bóujyū|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Smooth Rock|', 4, q'|Extends the duration of sandstorms.|', nq'|さらさらいわ|', nq'|Sarasara Iwa|', nq'|Roche Lisse|', nq'|Glattbrocken|', nq'|Roccialiscia|', nq'|Roca Suave|', nq'|보송보송바위|', nq'|Bosongbosong Bawi|', nq'|沙沙岩石|', nq'|Shāshā Yánshí / Sāsā Ngàahmsehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|Pokédex|', 1, q'|Stores info about Pokémon that have been seen/caught.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Like Mail|', 5, q'|Stationary designed for writing recommendations. To be held by a Pokémon for delivery.|', nq'|おすすめメール|', nq'|Osusume Mail|', nq'|Lettre Avis|', nq'|Insiderbrief|', nq'|Mess. Sugg.|', nq'|C. Gustos|', nq'|추천메일|', nq'|Chucheon Mail|', nq'|推薦郵件 / 推荐邮件|', nq'|Tuījiàn Yóujiàn / Tēuijin Yàuhgín|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|God Stone|', 5, q'|Not available without cheating. Currently has no use.|', nq'|ゴッドストーン|', nq'|God Stone|', nq'|神石|', nq'|Shénshí / Sàhnsehk|', 1024);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Jaw Fossil|', 6, q'|A Fossil from which a Tyrunt can be resurrected.|', nq'|アゴのカセキ|', nq'|Ago no Kaseki|', nq'|Fossile Mâchoire|', nq'|Kieferfossil|', nq'|Fossilmascella|', nq'|Fósil Mandíbula|', nq'|턱화석|', nq'|Teok Hwaseok|', nq'|顎之化石 / 颚之化石|', nq'|È-zhī Huàshí / Ngohk-jī Fasehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Festival Ticket|', 7, q'|A ticket that allows you to host a mission in Festival Plaza.|', nq'|フェスチケット|', nq'|Fest Ticket|', nq'|Festicket|', nq'|Festival-Ticket|', nq'|Festicket|', nq'|Festicupón|', nq'|페스티켓|', nq'|Fest Ticket|', nq'|圓慶票 / 圆庆票|', nq'|Yuánqìng Piào / Yùhnhing Piu|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Fire Memory|', 7, q'|Makes Silvally a Fire-type Pokémon and makes Multi-Attack a Fire-type move.|', nq'|ファイヤーメモリ|', nq'|Fire Memory|', nq'|ROM Feu|', nq'|Feuer-Disc|', nq'|ROM Fuoco|', nq'|Disco Fuego|', nq'|파이어메모리|', nq'|Fire Memory|', nq'|火焰記憶碟*|'||chr(10)||nq'|火焰存储碟|', nq'|Huǒyàn Jìyìdié / Fóyihm Geiyīkdihp*|'||chr(10)||nq'|Huǒyàn Cúnchǔdié|', 3);
insert into ITEMS(NAME, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(q'|Roto Exp. Points|', nq'|けいけんポン|', nq'|Keiken Pon|', nq'|Molti-Exp|', nq'|EP-Bon|', nq'|Esp'n'roll|', nq'|Cupón Exp|', nq'| ???|', nq'| ???|', nq'|經驗碰碰 / 经验碰碰|', nq'|Jīngyàn Pèngpèng / Gīngyihm Pungpung|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Lock Capsule|', 5, q'|Not available without cheating. Can be relocated from HeartGold or Soul Silver to obtain TM95 (Snarl).|', nq'|ロックカプセル|', nq'|Lock Capsule|', nq'|Capsule Anti-vol|', nq'|Tresorkapsel|', nq'|Cap. Scrigno|', nq'|Cáp. Candado|', nq'|록캡슐|', nq'|Lock Capsule|', nq'|上鎖的容器 / 上锁的容器|', nq'|Shàngsuǒ-de Róngqì / Séuhngsó-dīk Yùhnghei|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Poffin Case|', 4, q'|Stores Poffins.|', nq'|ポフィンケース|', nq'|Poffin Case|', nq'|Boîte Poffin|', nq'|Knurspbox|', nq'|Portapoffin|', nq'|Pokochera|', nq'|포핀케이스|', nq'|Poffin Case|', nq'|寶芬盒 / 宝芬盒|', nq'|Bǎofēn Hé / Bǎofēn Hahp|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Mental Herb|', 3, q'|Prevents attraction. Consumed after use.|', nq'|メンタルハーブ|', nq'|Mental Herb|', nq'|Herbe Mental|', nq'|Mentalkraut|', nq'|Mentalerba|', nq'|Hierba Mental|', nq'|멘탈허브|', nq'|Mental Herb|', nq'|心靈香草 / 心灵香草|', nq'|Xīnlíng Xiāngcǎo / Sāmlìhng Hēungchóu|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Gold Leaf|', 2, q'|Can be sold for 1000.|', nq'|きんのはっぱ|', nq'|Kin no Happa|', nq'|Feuille D'Or|', nq'|Goldblatt|', nq'|Fogliadoro|', nq'|Hoja Dorada|', nq'|금빛나뭇잎|', nq'|Geumbit Namunnip|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Heal Powder|', 2, q'|Heals any status condition, but lowers friendship.|', nq'|ばんのうごな|', nq'|Bannō Gona|', nq'|Poudre Soin|', nq'|Heilpuder|', nq'|Polvocura|', nq'|Polvo Curación|', nq'|만능가루|', nq'|Manneung Garu|', nq'|萬能粉 / 万能粉|', nq'|Wànnéng Fěn / Maahnnàhng Fán|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Growth Mulch|', 4, q'|Causes Berries to grow faster, but makes the soil dry faster.|', nq'|すくすくこやし|', nq'|Sukusuku Koyashi|', nq'|Fertipousse|', nq'|Wachsmulch|', nq'|Fertilrapido|', nq'|Abono Rápido|', nq'|무럭무럭비료|', nq'|Mureokmureok Biryo|', nq'|速速肥|', nq'|Sùsù Féi / Chūkchūk Fèih|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Adrenaline Orb|', 7, q'|When used, makes wild Pokémon more likely to call allies for help in an SOS Battle. Is not consumed if it fails. If the holder is affected by Intimidate, its Speed is increased by one stage.|', nq'|ビビリだま|', nq'|Bibiri Dama|', nq'|Orbe Frousse|', nq'|Zitterorb|', nq'|Fifasfera|', nq'|Nerviosfera|', nq'|주눅구슬|', nq'|Junuk Guseul|', nq'|膽怯球 / 胆怯球|', nq'|Dǎnqiè Qiú / Dáamhip Kàuh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Pretty Wing|', 5, q'|An item that does absolutely nothing.|', nq'|きれいなハネ|', nq'|Kireina Hane|', nq'|Jolie Aile|', nq'|Prachtfeder|', nq'|Piumabella|', nq'|Pluma Bella|', nq'|고운날개|', nq'|Goun Nalgae|', nq'|美麗之羽 / 美丽之羽|', nq'|Měilì-zhī Yǔ / Méihlaih-jī Yúh|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Liechi Berry|', 3, q'|Raises Attack when HP is below ⅓ of maximum.|', nq'|チイラのみ|', nq'|Chyla no Mi|', nq'|Baie Lichii|', nq'|Lydzibeere|', nq'|Baccalici|', nq'|Baya Lichi|', nq'|치리열매|', nq'|Cheely Yeolmae|', nq'|枝荔果|', nq'|Zhīlì Guǒ / Jīlaih Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Dream Mail|', 3, q'|To be held by a Pokémon for delivery.|', nq'|ドリームメール|', nq'|Dream Mail|', nq'|Lettre Songe|', nq'|Traumbrief|', nq'|Mess. Sogno|', nq'|Carta Sueño|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Venusaurite|', 6, q'|Allows Venusaur to Mega Evolve into Mega Venusaur.|', nq'|フシギバナイト|', nq'|Fushigibanite|', nq'|Florizarrite|', nq'|Bisaflornit|', nq'|Venusaurite|', nq'|Venusaurita|', nq'|이상해꽃나이트|', nq'|Isanghekkotnite|', nq'|妙蛙花進化石 / 妙蛙花进化石|', nq'|Miàowāhuā Jìnhuà Shí / Miuhwāfā Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Moon Stone|', 1, q'|Can be used to evolve Clefairy, Jigglypuff, Nidorino, Nidorina, and Skitty.|', nq'|つきのいし|', nq'|Tsuki no Ishi|', nq'|Pierre Lune|', nq'|Mondstein|', nq'|Pietralunare|', nq'|Piedra Lunar|', nq'|달의돌|', nq'|Dar-ui Dol|', nq'|月之石|', nq'|Yuè-zhī Shí / Yuht-jī Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Boost Mulch|', 6, q'|When applied to a Berry patch, causes the soil to dry out in 4 hours.|', nq'|ぐんぐんこやし|', nq'|Gungun Koyashi|', nq'|Fertibérance|', nq'|Wuchermulch|', nq'|Fertilcopioso|', nq'|Abono Fructífero|', nq'|부쩍부쩍비료|', nq'|Bujjeok-bujjeok Biryo|', nq'|勁勁肥 / 劲劲肥|', nq'|Jìnjìn Féi / Gihnggihng Fèih|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Key to Room 6|', 6, q'|Opens Room 6 of the Abandoned ShipRSE/Sea MauvilleORAS.|', q'|Called Rm. 6 Key in Generation III.|', nq'|ろくごうしつのカギ|', nq'|Roku-gō Shitsu no Kagi|', nq'|Clé Salle 6|', nq'|R6-Schlüssel|', nq'|Chiave stanza 6|', nq'|Ll. Habitación 6|', nq'|육호실열쇠|', nq'|Yuk-hosil Yeolsoe|', nq'|６號客房的鑰匙 /|'||chr(10)||nq'|６号客房的钥匙|', nq'|6 Hào Kèfáng-de Yàoshi / 6 Houh Haakfóng-dīk Yeuhksìh|', 1616);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Focus Sash|', 4, q'|Prevents a one-hit knockout.|', nq'|きあいのタスキ|', nq'|Kiai no Tasuki|', nq'|Ceinture Force|', nq'|Fokusgurt|', nq'|Focalnastro|', nq'|Banda Focus|', nq'|기합의띠|', nq'|Gihabui Tti|', nq'|氣勢披帶 / 气势披带|', nq'|Qìshì Pīdài / Heisai Pēidaai|', 128);
insert into ITEMS(NAME, GEN, DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Black Glasses|', 2, q'|Raises the power of Dark-type moves.|', q'|Formatted as BlackGlasses prior to Generation VI.|', nq'|くろいメガネ|', nq'|Kuroi Megane|', nq'|Lunettes Noires|', nq'|Schattenglas|', nq'|Occhialineri|', nq'|Gafas de Sol|', nq'|검은안경|', nq'|Geomeun An-gyeong|', nq'|黑色眼鏡 / 黑色眼镜|', nq'|Hēi-sè Yǎnjìng / Hāak-sīk Ngáahngeng|', 1152);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Poison Memory|', 7, q'|Makes Silvally a Poison-type Pokémon and makes Multi-Attack a Poison-type move.|', nq'|ポイズンメモリ|', nq'|Poison Memory|', nq'|ROM Poison|', nq'|Gift-Disc|', nq'|ROM Veleno|', nq'|Disco Veneno|', nq'|포이즌메모리|', nq'|Poison Memory|', nq'|毒記憶碟*|'||chr(10)||nq'|毒存储碟|', nq'|Dú Jìyìdié / Duhk Geiyīkdihp*|'||chr(10)||nq'|Dú Cúnchǔdié|', 3);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Devon Scuba Gear|', 6, q'|Worn while underwater.|', nq'|デボンボンベ|', nq'|Devon Bombe|', nq'|Plongeur Devon|', nq'|Devon-Atemgerät|', nq'|Maschera Devon|', nq'|Bombona Devon|', nq'|데봉봄베|', nq'|Devon Bombe|', nq'|得文潛水裝備 / 得文潜水装备|', nq'|Déwén Qiánshuǐ Zhuāngbèi / Dākmàhn Chìhmséui Jōngbeih|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Comet Shard|', 5, q'|Can be sold for 60000.|', nq'|すいせいのかけら|', nq'|Suisei no Kakera|', nq'|Morceau Comète|', nq'|Kometstück|', nq'|Pezzo Cometa|', nq'|Fragmento Cometa|', nq'|혜성조각|', nq'|Hyeseong Jogak|', nq'|彗星碎片|', nq'|Huìxīng Suìpiàn / Seuihsīng Seuipín|', 144);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Darkinium Z|', 7, q'|Allows a Pokémon to upgrade their Dark-type damaging moves to the Z-Move Black Hole Eclipse or upgrade their Dark-type status moves into Z-Moves. Makes Arceus a Dark-type Pokémon.|', nq'|アクＺ|', nq'|Evil-Z|', nq'|Ténébrozélite|', nq'|Noctium Z|', nq'|Obscurium Z|', nq'|Nictostal Z|', nq'|악Z|', nq'|Ak-Z|', nq'|惡Ｚ / 恶Ｚ|', nq'|È-Z / Ok-Z|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|PSNCureBerry|', 2, q'|Cures poison.|', nq'|どくけしのみ|', nq'|Dokukeshi no Mi|', nq'|Baie Antidot|', nq'|Ggngiftbeere|', nq'|Baccantivel.|', nq'|Bayantídoto|', nq'|해독열매|', nq'|Haedok Yeolmae|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Heart Mail|', 4, q'|Mail with a heart pattern. To be held by a Pokémon for delivery.|', nq'|ラブラブメール|', nq'|Love-Love Mail|', nq'|Lettre Coeur|', nq'|Rosabrief|', nq'|Mess. Cuore|', nq'|Car. Corazón|', nq'|러브러브메일|', nq'|Love-Love Mail|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Parcel|', 4, q'|To be delivered to rival. Contains two Town Maps.|', nq'|おとどけもの|', nq'|Otodoke Mono|', nq'|Colis|', nq'|Paket|', nq'|Pacco|', nq'|Paquete|', nq'|전해줄물건|', nq'|Jeonhaejul Mulgeon|', nq'|包裹|', nq'|Bāoguǒ / Bāaugwó|', 1264);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Dark Memory|', 7, q'|Makes Silvally a Dark-type Pokémon and makes Multi-Attack a Dark-type move.|', nq'|ダークメモリ|', nq'|Dark Memory|', nq'|ROM Ténèbres|', nq'|Unlicht-Disc|', nq'|ROM Buio|', nq'|Disco Siniestro|', nq'|다크메모리|', nq'|Dark Memory|', nq'|黑暗記憶碟*|'||chr(10)||nq'|黑暗存储碟|', nq'|Hēi'àn Jìyìdié / Hāk'am Geiyīkdihp*|'||chr(10)||nq'|Hēi'àn Cúnchǔdié|', 3);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Gengarite|', 6, q'|Allows Gengar to Mega Evolve into Mega Gengar.|', nq'|ゲンガナイト|', nq'|Ganganite|', nq'|Ectoplasmite|', nq'|Gengarnit|', nq'|Gengarite|', nq'|Gengarita|', nq'|팬텀나이트|', nq'|Penteomnite|', nq'|耿鬼進化石 / 耿鬼进化石|', nq'|Gěngguǐ Jìnhuà Shí / Gánggwái Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Miror Radar|', 3, q'|Keeps track of Miror B.|', nq'|ミラーボレーダー|', nq'|Mirorbo Radar|', nq'|Radar Disco|', nq'|Queen-Radar|', nq'|Discoradar|', nq'|Radar Discal|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Strange Souvenir|', 6, q'|Currently has no use.|', nq'|ふしぎなおきもの|', nq'|Fushigina Okimono|', nq'|Bibelot Bizarre|', nq'|Skurriloskulptur|', nq'|Strano ninnolo|', nq'|Estatuilla Rara|', nq'|이상한장식품|', nq'|Isanghae Jangsikpum|', nq'|神秘擺設 / 神秘摆设|', nq'|Shénmì Bǎishè / Sàhnbei Báaichit|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Calcium|', 1, q'|Raises the Special Attack of a Pokémon.|', nq'|リゾチウム|', nq'|Lysozyme|', nq'|Calcium|', nq'|Kalzium|', nq'|Calcio|', nq'|Calcio|', nq'|리보플라빈|', nq'|Riboflavin|', nq'|特攻增強劑 / 特攻增强剂|', nq'|Tègōng Zēngqiángjì / Dahkgūng Jāngkèuhngjaih|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Z-Power Ring|', 7, q'|Allows the player to use Z-Moves when a Pokémon is holding an appropriate Z-Crystal. Allows the player to use Mega Evolution after obtaining a Key Stone when a Pokémon is holding the appropriate Mega Stone.|', nq'|Ｚパワーリング|', nq'|Z Power Ring|', nq'|Super Bracelet Z|', nq'|Z-Kraftring|', nq'|Supercerchio Z|', nq'|Superpulsera Z|', nq'|Z파워링|', nq'|Z-Power Ring|', nq'|Ｚ強力手環 / Ｚ强力手环|', nq'|Z Qiánglì Shǒuhuán / Z Kèuhnglihk Sáuwàahn|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Lovely Mail|', 2, q'|Mail with a heart design. To be held by a Pokémon for delivery.|', nq'|ラブリーメール|', nq'|Lovely Mail|', nq'|LetrCharm.|', nq'|Herzbrief|', nq'|Mess. Dolce|', nq'|Carta Amor|', nq'|러브리메일|', nq'|Lovely Mail|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Deep Sea Tooth|', 3, q'|A hold item that allows Clamperl to evolve into Huntail when traded.|', q'|Formatted as DeepSeaTooth prior to Generation VI.|', nq'|しんかいのキバ|', nq'|Shinkai no Kiba|', nq'|Dent Océan|', nq'|Abysszahn|', nq'|Dente Abissi|', nq'|Diente Marino|', nq'|심해의이빨|', nq'|Simhae-ui Ippal|', nq'|深海之牙|', nq'|Shēnhǎi-zhī Yá / Sāmhói-jī Ngàh|', 1056);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Bug Gem|', 5, q'|Increases the power of the holder's first Bug-type move by 50%, and is consumed after use.|', nq'|むしのジュエル|', nq'|Mushi no Jewel|', nq'|Joyau Insecte|', nq'|Käferjuwel|', nq'|Bijoucoleottero|', nq'|Gema Bicho|', nq'|벌레주얼|', nq'|Beolle Jewel|', nq'|蟲之寶石 / 虫之宝石|', nq'|Chóng-zhī Bǎoshí / Chùhng-jī Bóusehk|', 176);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|White Herb|', 3, q'|Raises a lowered stat.|', nq'|しろいハーブ|', nq'|Shiroi Herb|', nq'|Herbe Blanche|', nq'|Schlohkraut|', nq'|Erbachiara|', nq'|Hierba Blanca|', nq'|하양허브|', nq'|Hayang Herb|', nq'|白色香草|', nq'|Bái-sè Xiāngcǎo / Baahk-sīk Hēungchóu|', 144);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Red Orb|', 3, q'|Awakens Groudon. It also turns Groudon into Primal Groudon during battle when holding the item.ORAS|', nq'|べにいろのたま|', nq'|Beniiro no Tama|', nq'|Gemme Rouge|', nq'|Roter Edelstein|', nq'|Gemma rossa|', nq'|Prisma Roja|', nq'|주홍구슬|', nq'|Juhong Guseul|', nq'|朱紅色寶珠 / 朱红色宝珠|', nq'|Zhūhóng-sè Bǎozhū / Jyūhùhng-sīk Bóujyū|', 240);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Poisonium Z|', 7, q'|Allows a Pokémon to upgrade their Poison-type damaging moves to the Z-Move Acid Downpour or upgrade their Poison-type status moves into Z-Moves. Makes Arceus a Poison-type Pokémon.|', nq'|ドクＺ|', nq'|Poison-Z|', nq'|Toxizélite|', nq'|Toxium Z|', nq'|Venenium Z|', nq'|Toxistal Z|', nq'|독Z|', nq'|Dok-Z|', nq'|毒Ｚ|', nq'|Dú-Z / Duhk-Z|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Super Potion|', 1, q'|Restores 60 HP. (50HP before Gen. VII).|', nq'|いいキズぐすり|', nq'|Ii Kizu Gusuri|', nq'|Super Potion|', nq'|Supertrank|', nq'|Super Pozione|', nq'|Superpoción|', nq'|좋은상처약|', nq'|Jo-eun Sangcheo Yak|', nq'|好傷藥 / 好伤药|', nq'|Hǎo Shāngyào / Hóu Sēungyeuhk|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Letter|', 3, q'|To be delivered to Steven Stone.|', nq'|ダイゴへのてがみ|', nq'|Daigo e no Tsugami|', nq'|Lettre à Pierre|', nq'|Brief an Troy|', nq'|Lettera|', nq'|Carta a Máximo|', nq'|성호에게줄편지|', nq'|Seongho-e Gejul Pyeonji|', nq'|給大吾的信 / 给大吾的信|', nq'|Gěi Dàwú-de Xìn / Kāp Daaihǹgh-dīk Seun|', 208);
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|X Speed 2|', 5, q'|Sharply raises a Pokémon's Speed. Wonder Launcher only.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Prison Bottle|', 6, q'|Used to transform Hoopa Confined to Hoopa Unbound.|', nq'|いましめのつぼ|', nq'|Imashime no Tsubo|', nq'|Vase Scellé|', nq'|Banngefäß|', nq'|Vaso del vincolo|', nq'|Vasija Castigo|', nq'|굴레의항아리|', nq'|Gulle-yi Hang-ari|', nq'|懲戒之壺 / 惩戒之壶|', nq'|Chéngjiè-zhī Hú / Chìhnggaai-jī Wùh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Health Wing|', 5, q'|Raises the HP of a Pokémon.|', nq'|たいりょくのハネ|', nq'|Tairyoku no Hane|', nq'|Aile Santé|', nq'|Heilfeder|', nq'|Piumsalute|', nq'|Pluma Vigor|', nq'|체력날개|', nq'|Cheryeok Nalgae|', nq'|體力之羽 / 体力之羽|', nq'|Tǐlì-zhī Yǔ / Táilihk-jī Yúh|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|BridgeMail T|', 5, q'|Stationary with a steel suspension bridge print. To be held by a Pokémon for delivery.|', nq'|ブリッジメールＣ|', nq'|Bridge Mail C|', nq'|Lettre PontF|', nq'|Brückbrief Z|', nq'|Mess. Prop.|', nq'|C. Puente A|', nq'|브리지메일C|', nq'|Bridge Mail C|', nq'|橋梁郵件Ｃ / 桥梁邮件Ｃ|', nq'|Qiáoliáng Yóujiàn C / Kìuhlèuhng Yàuhgín C|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Poké Radar|', 4, q'|Allows player to encounter wild Pokémon not usually seen in the area. Obtained after receiving National Pokédex.|', nq'|ポケトレ|', nq'|Poké-Tra|', nq'|Poké Radar|', nq'|Pokéradar|', nq'|Poké Radar|', nq'|Pokéradar|', nq'|포켓트레|', nq'|Poké-Tra|', nq'|寶可追蹤 / 宝可追踪|', nq'|Bǎokě Zhuīzōng / Bóuhó Jēuijūng|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Time Flute|', 3, q'|Can be used to instantly purify a Shadow Pokémon.|', nq'|ときのふえ|', nq'|Toki no Fue|', nq'|Flute du Temps|', nq'|Zeitflöte|', nq'|Flauto Tempo|', nq'|Fl. Tiempo|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Alakazite|', 6, q'|Allows Alakazam to Mega Evolve into Mega Alakazam.|', nq'|フーディナイト|', nq'|Foodinite|', nq'|Alakazamite|', nq'|Simsalanit|', nq'|Alakazamite|', nq'|Alakazamita|', nq'|후디나이트|', nq'|Fudinnite|', nq'|胡地進化石 / 胡地进化石|', nq'|Húdì Jìnhuà Shí / Wùhdeih Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Gracidea|', 4, q'|Allows Shaymin to change form.|', nq'|グラシデアのはな|', nq'|Gracidea no Hana|', nq'|Gracidée|', nq'|Gracidea|', nq'|Gracidea|', nq'|Gracídea|', nq'|그라시데아꽃|', nq'|Gracidea Kkot|', nq'|葛拉西蒂亞花 / 葛拉西蒂亚花|', nq'|Gélāxīdìyǎ Huā / Gotlāaisāidaia Fā|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Roseli Berry|', 6, q'|Reduces damage from a super effective Fairy-type move.|', nq'|ロゼルのみ|', nq'|Rozelle no Mi|', nq'|Baie Selro|', nq'|Hibisbeere|', nq'|Baccarcadè|', nq'|Baya Hibis|', nq'|로셀열매|', nq'|Rosel Yeolmae|', nq'|洛玫果|', nq'|Luòméi Guǒ / Lokmùih Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Shalour Sable|', 6, q'|Cures any status condition.|', nq'|シャラサブレ|', nq'|Shala Sable|', nq'|Sablé Yantreizh|', nq'|Yantara-Sablé|', nq'|Yantafrollino|', nq'|Galleta Yantra|', nq'|사라사블레|', nq'|Sara Sable|', nq'|娑羅沙布蕾 / 娑罗沙布蕾|', nq'|Suōluó Shābùlěi / Sōlòh Sāboulèuih|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Skull Fossil|', 4, q'|A Fossil from which a Cranidos can be resurrected.|', nq'|ずがいのカセキ|', nq'|Zugai no Kaseki|', nq'|Fossile Crâne|', nq'|Kopffossil|', nq'|Fossilcranio|', nq'|Fósil Cráneo|', nq'|두개의화석|', nq'|Dugae-ui Hwaseok|', nq'|頭蓋化石 / 头盖化石|', nq'|Tóugài Huàshí / Tàuhgoi Fasehk|', 128);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Icy Rock|', 4, q'|Extends the duration of hail.|', nq'|つめたいいわ|', nq'|Tsumetai Iwa|', nq'|Roche Glace|', nq'|Eisbrocken|', nq'|Rocciafredda|', nq'|Roca Helada|', nq'|차가운바위|', nq'|Chagaun Bawi|', nq'|冰冷岩石|', nq'|Bīnglěng Yánshí / Bīngláahng Ngàahmsehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Starf Berry|', 3, q'|Raises a random stat when HP is below ⅓.|', nq'|スターのみ|', nq'|Star no Mi|', nq'|Baie Frista|', nq'|Krambobeere|', nq'|Baccambola|', nq'|Baya Arabol|', nq'|스타열매|', nq'|Star Yeolmae|', nq'|星桃果|', nq'|Xīngtáo Guǒ / Sīngtòuh Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Flame Mail|', 4, q'|Mail with a fire design. To be held by a Pokémon for delivery.|', nq'|フレイムメール|', nq'|Flame Mail|', nq'|Lettre Feu|', nq'|Feuerbrief|', nq'|Mess. Fiamma|', nq'|Carta Fuego|', nq'|플레임메일|', nq'|Flame Mail|', 0);
insert into ITEMS(NAME, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH)
values(q'|Poké Snack|', nq'|ポケまんま|', nq'|Poké Manma|', nq'|Poké Snack|', nq'|Pokésnack|', nq'|Poké Snack|', nq'|Poké Dulce|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Pass Orb|', 5, q'|Used for purchasing Pass Powers at the Entralink.|', nq'|デルダマ|', nq'|Derudama|', nq'|Offrisphère|', nq'|Transferorb|', nq'|Passabilia|', nq'|Regalosfera|', nq'|딜구슬|', nq'|Dil Guseul|', nq'|釋出之玉 / 释出之玉|', nq'|Shìchū-zhī Yù / Sīkchēut-jī Yúk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Electric Memory|', 7, q'|Makes Silvally a Electric-type Pokémon and makes Multi-Attack a Electric-type move.|', nq'|エレクトロメモリ|', nq'|Electro Memory|', nq'|ROM Électrik|', nq'|Elektro-Disc|', nq'|ROM Elettro|', nq'|Disco Eléctrico|', nq'|일렉트릭메모리|', nq'|Electric Memory|', nq'|電子記憶碟*|'||chr(10)||nq'|电子存储碟|', nq'|Diànzǐ Jìyìdié / Dihnjí Geiyīkdihp*|'||chr(10)||nq'|Diànzǐ Cúnchǔdié|', 3);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Pokéblock Case|', 3, q'|Stores Pokéblocks.|', nq'|ポロックケース|', nq'|Polock Case|', nq'|Boite Pokéblocs|', nq'|Pokériegel Box|', nq'|Porta Pokémelle|', nq'|Tubo PokéCubos|', nq'|포켓몬스넥케이스|', nq'|Pokémon Snack Case|', nq'|寶可方塊盒 / 宝可方块盒|', nq'|Bǎokě Fāngkuài Hé / Bóuhó Fōngfaai Hahp|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Elevator Key|', 3, q'|Unlocks the Prestige Precept Center's elevator.|', nq'|エレベーターキー|'||chr(10)||nq'|エレベーターのキー|', nq'|Elevator Key|'||chr(10)||nq'|Elevator no Key|', nq'|Cle Ascens.*|'||chr(10)||nq'|Clé Ascenseur|', nq'|Liftkarte*|'||chr(10)||nq'|Liftschlüssel|', nq'|Chiave Asc.|'||chr(10)||nq'|Chiave ascensore|', nq'|Ll. Ascensor|'||chr(10)||nq'|Llave Ascensor|', nq'|엘리베이터키|', nq'|Elevator Key|', nq'|電梯鑰匙 / 电梯钥匙|', nq'|Diàntī Yàoshi / Dihntāi Yeuhksìh|', 192);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Steel Memory|', 7, q'|Makes Silvally a Steel-type Pokémon and makes Multi-Attack a Steel-type move.|', nq'|スチールメモリ|', nq'|Steel Memory|', nq'|ROM Acier|', nq'|Stahl-Disc|', nq'|ROM Acciaio|', nq'|Disco Acero|', nq'|스틸메모리|', nq'|Steel Memory|', nq'|鋼鐵記憶碟*|'||chr(10)||nq'|钢铁存储碟|', nq'|Gāngtiě Jìyìdié / Gōngtit Geiyīkdihp*|'||chr(10)||nq'|Gāngtiě Cúnchǔdié|', 3);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Machine Part|', 2, q'|The missing part from the Power Plant.|', nq'|きかいのぶひん|'||chr(10)||nq'|マシンパーツ|', nq'|Kikai no Buhin|'||chr(10)||nq'|Machine Part|', nq'|Partie de Machine|'||chr(10)||nq'|Piece Meca.|', nq'|Spule|'||chr(10)||nq'|Ersatzteil|', nq'|Pezzo macch.|'||chr(10)||nq'|Meccanismo|', nq'|Maquinaria|'||chr(10)||nq'|Pieza Esp.|', nq'|기계부품|', nq'|Gigye Bupum|', nq'|機械零件 / 机械零件|', nq'|Jīxiè Língjiàn / Gēihaaih Lìhnggín|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Permit|', 5, q'|A permit needed to enter the Nature Preserve. Only a few know about this place.|', nq'|きょかしょう|', nq'|License|', nq'|Permis|', nq'|Genehmigung|', nq'|Permesso|', nq'|Pase|', nq'|허가증|', nq'|Heogajeung|', nq'|許可證 / 许可证|', nq'|Xǔkě Zhèng / Héuihó Jing|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Iapapa Berry|', 3, q'|When HP falls below 25%, restores 50% HP, but confuses Pokémon that dislike sour food (12.5% when below 50% before Gen. VII).|', nq'|イアのみ|', nq'|Ia no Mi|', nq'|Baie Papaya|', nq'|Yapabeere|', nq'|Baccapaia|', nq'|Baya Pabaya|', nq'|파야열매|', nq'|Paya Yeolmae|', nq'|芭亞果 / 芭亚果|', nq'|Bāyà Guǒ / Bā'a Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Ultranecrozium Z|', 7, q'|Allows Necrozma to transform into Ultra Necrozma after fusing with Solgaleo or Lunala, also upgrades Photon Geyser to the special Z-Move Light That Burns the Sky as Ultra Necrozma.|', nq'|ウルトラネクロＺ|', nq'|Ultranecro-Z|', nq'|Ultranécrozélite|', nq'|Ultranecrozium Z|', nq'|Ultranecrozium Z|', nq'|Ultranecrostal Z|', nq'|울트라네크로Z|', nq'|Ultranecro-Z|', nq'|究極奈克洛Ｚ / 究极奈克洛Ｚ|', nq'|Jiūjí Nàikèluò-Z / Gaugihk Noihhāklok-Z|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Toxic Plate|', 4, q'|Raises the power of Poison-type moves.|', nq'|もうどくプレート|', nq'|Moudoku Purēto|', nq'|Plaque Toxic|', nq'|Gifttafel|', nq'|Lastrafiele|', nq'|Tabla Tóxica|', nq'|맹독플레이트|', nq'|Maengdok Plate|', nq'|劇毒石板 / 剧毒石板|', nq'|Jùdú Shíbǎn / Kehkduhk Sehkbáan|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Douse Drive|', 5, q'|Makes Techno Blast a Water-type move when held by Genesect.|', nq'|アクアカセット|', nq'|Aqua Cassette|', nq'|Module Aqua|', nq'|Aquamodul|', nq'|Idromodulo|', nq'|HidroROM|', nq'|아쿠아카세트|', nq'|Aqua Cassette|', nq'|水流卡帶 / 水流卡带|', nq'|Shuǐliú Kǎdài / Séuilàuh Kāatdáai|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Krane Memo 5|', 3, q'|Contains information about the Purify Chamber.|', nq'|クレインメモ５|', nq'|Krane Memo 5|', nq'|Memo Syrus 5|', nq'|Klein-Memo 5|', nq'|Appunti 5|', nq'|Parte Cío 5|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Relic Silver|', 5, q'|Can be sold for 5000 to the villa owner in Undella Town.|', nq'|こだいのぎんか|', nq'|Kodai no Ginka|', nq'|Vieil Écu|', nq'|Alter Taler|', nq'|Ducatantico|', nq'|Real Plata|', nq'|고대의은화|', nq'|Godae-yi Eunhwa|', nq'|古代銀幣 / 古代银币|', nq'|Gǔdài Yínbì / Gúdoih Ngàhnbaih|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Prof's Letter|', 6, q'|Given to the player's mother in exchange for a Town Map and a Potion.|', nq'|はかせのてがみ|', nq'|Hakase no Tegami|', nq'|Lettre du Prof|', nq'|Brief vom Prof|', nq'|Lettera del Prof|', nq'|Carta Profesor|', nq'|박사의편지|', nq'|Baksa-ui Pyeonji|', nq'|博士的信|', nq'|Bóshì-de Xìn / Boksih-dīk Seun|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Razz Berry|', 3, q'|Pokéblock and Poffin ingredient.|', nq'|ズリのみ|', nq'|Zuri no Mi|', nq'|Baie Framby|', nq'|Himmihbeere|', nq'|Baccalampon|', nq'|Baya Frambu|', nq'|라즈열매|', nq'|Ras Yeolmae|', nq'|蔓莓果|', nq'|Mànméi Guǒ / Màahnmùih Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Qualot Berry|', 3, q'|Raises friendship, but lowers Defense EVs.|', nq'|タポルのみ|', nq'|Tapol no Mi|', nq'|Baie Qualot|', nq'|Qualotbeere|', nq'|Baccaloquat|', nq'|Baya Ispero|', nq'|파비열매|', nq'|Pabi Yeolmae|', nq'|比巴果|', nq'|Bǐbā Guǒ / Béibā Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Iron Plate|', 4, q'|Raises the power of Steel-type moves.|', nq'|こうてつプレート|', nq'|Koutetsu Purēto|', nq'|Plaque Fer|', nq'|Eisentafel|', nq'|Lastraferro|', nq'|Tabla Acero|', nq'|강철플레이트|', nq'|Gangcheol Plate|', nq'|鋼鐵石板 / 钢铁石板|', nq'|Gāngtiě Shíbǎn / Gongtit Sehkbáan|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Wise Glasses|', 4, q'|Raises the power of special moves.|', nq'|ものしりメガネ|', nq'|Monoshiri Megane|', nq'|Lunettes Sages|', nq'|Schlauglas|', nq'|Saviocchiali|', nq'|Gafas Especiales|', nq'|박식안경|', nq'|Baksik An-gyeong|', nq'|博識眼鏡 / 博识眼镜|', nq'|Bóshì Yǎnjìng / Boksīk Ngáahngeng|', 144);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Sceptilite|', 6, q'|Allows Sceptile to Mega Evolve into Mega Sceptile.|', nq'|ジュカインナイト|', nq'|Jukainnite|', nq'|Jungkite|', nq'|Gewaldronit|', nq'|Sceptilite|', nq'|Sceptilita|', nq'|나무킹나이트|', nq'|Namukingnite|', nq'|蜥蜴王進化石 / 蜥蜴王进化石|', nq'|Xīyìwáng Jìnhuà Shí / Sīkyihkwòhng Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Latiasite|', 6, q'|Allows Latias to Mega Evolve into Mega Latias.|', nq'|ラティアスナイト|', nq'|Latiasnite|', nq'|Latiasite|', nq'|Latiasnit|', nq'|Latiasite|', nq'|Latiasita|', nq'|라티아스나이트|', nq'|Latiasnite|', nq'|拉帝亞斯進化石 / 拉帝亚斯进化石|', nq'|Lādìyāsī Jìnhuà Shí / Lāaidai'asī Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Dragon Fang|', 2, q'|Raises the power of Dragon-type moves.|', nq'|りゅうのキバ|', nq'|Ryū no Kiba|', nq'|Croc Dragon|', nq'|Drachenzahn|', nq'|Dentedidrago|', nq'|Colmillo Dragón|', nq'|용의이빨|', nq'|Yong-ui Ippal|', nq'|龍之牙 / 龙之牙|', nq'|Lóng-zhī Yá / Lùhng-jī Ngàh|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Energy Root|', 2, q'|Restores 200 HP, but lowers friendship.|', nq'|ちからのねっこ|', nq'|Chikara no Nekko|', nq'|Racine Énergie|', nq'|Kraftwurzel|', nq'|Radicenergia|', nq'|Raíz Energía|', nq'|힘의뿌리|', nq'|Himui Ppuri|', nq'|元氣根 / 元气根|', nq'|Yuánqì Gēn / Yùhnhei Gān|', 128);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Basement Key|', 3, q'|Allows the player to access New Mauville.|', nq'|ちかのカギ|', nq'|Chika no Kagi|', nq'|Clé Sous-Sol|', nq'|Kelleröffner|', nq'|Chiave sotterr.|', nq'|Llave del Sótano|', nq'|지하열쇠|', nq'|Jiha Yeolsoe|', nq'|地下鑰匙 / 地下钥匙|', nq'|Dìxià Yàoshi / Deihhah Yeuhksìh|', 28);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Soft Sand|', 2, q'|Raises the power of Ground-type moves.|', nq'|やわらかいすな|', nq'|Yawarakai Suna|', nq'|Sable Doux|', nq'|Pudersand|', nq'|Sabbia Soffice|', nq'|Arena Fina|', nq'|부드러운모래|', nq'|Budeureoun Morae|', nq'|柔軟沙子 / 柔软沙子|', nq'|Róuruǎn Shāzi / Yàuhyúhn Sājí|', 32);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Burn Drive|', 5, q'|Makes Techno Blast a Fire-type move when held by Genesect.|', nq'|ブレイズカセット|', nq'|Blaze Cassette|', nq'|Module Pyro|', nq'|Flammenmodul|', nq'|Piromodulo|', nq'|PiroROM|', nq'|블레이즈카세트|', nq'|Blaze Cassette|', nq'|火焰卡帶 / 火焰卡带|', nq'|Huǒyàn Kǎdài / Fóyihm Kāatdáai|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Tea|', 3, q'|To be given to the thirsty guards to gain entry to Saffron City.|', nq'|おちゃ|', nq'|Ocha|', nq'|The|', nq'|Tee|', nq'|Tè|', nq'|Té|', nq'|차|', nq'|Cha|', nq'|茶|', nq'|Chá / Chàh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Suite Key|', 4, q'|Give to NPC in exchange for Lava Cookie.|', nq'|ルームキー|', nq'|Room Key|', nq'|Clé Chambre|', nq'|B-Schlüssel|', nq'|Chiave Suite|', nq'|Llave Suite|', nq'|룸키|', nq'|Room Key|', nq'|房間鑰匙 / 房间钥匙|', nq'|Fángjiān Yàoshi / Fòhnggāan Yeuhksìh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Old Charm|', 4, q'|Cynthia asks the player to deliver to Celestic Town. Is made of Pokémon bones.|', nq'|こだいのおまもり|', nq'|Kodai no Omamori|', nq'|Vieux Grigri|', nq'|Talisman|', nq'|Arcamuleto|', nq'|Talismán|', nq'|고대의부적|', nq'|Godae-ui Bujeok|', nq'|古代護符 / 古代护符|', nq'|Gǔdài Hùfú / Gúdoih Wuhfùh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|X Defend 6|', 5, q'|Immensely raises a Pokémon's Defense. Wonder Launcher only.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Retro Mail|', 3, q'|Mail with a picture of the three Kanto Starter Pokémon.|', nq'|レトロメール|', nq'|Retro Mail|', nq'|Lettre Retro|', nq'|Retrobrief|', nq'|Mess. Retro|', nq'|Carta Retro|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|PRZCureBerry|', 2, q'|Cures paralysis.|', nq'|まひなおしのみ|', nq'|Mahinaoshi no Mi|', nq'|Baie AntiPAR|', nq'|AntiPARBeere|', nq'|Baccantipar.|', nq'|Antiparabaya|', nq'|마비치료열매|', nq'|Mabi Chiryo Yeolmae|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|S.S. Ticket|', 1, q'|Allows the player to board the S.S. AnneRBYFRLG, S.S. AquaGSCHGSS, or S.S TidalRSEORAS|', nq'|ふねのチケット|', nq'|Fune no Ticket|', nq'|Passe Bateau|', nq'|Bootsticket|', nq'|Biglietto Nave|', nq'|Ticket Barco|', nq'|승선티켓|', nq'|Seungseon Ticket|', nq'|船票|', nq'|Chuánpiào / Syùhnpiu|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Air Mail|', 4, q'|A red- and blue-striped stationery. To be held by a Pokémon for delivery.|', nq'|エアメール|', nq'|Air Mail|', nq'|Lettre Avion|', nq'|Luftbrief|', nq'|Mess. Aereo|', nq'|Carta Aérea|', nq'|에어메일|', nq'|Air Mail|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Ice Gem|', 5, q'|Increases the power of the holder's first Ice-type move by 50%, and is consumed after use.|', nq'|こおりのジュエル|', nq'|Kōri no Jewel|', nq'|Joyau Glace|', nq'|Eisjuwel|', nq'|Bijoughiaccio|', nq'|Gema Hielo|', nq'|얼음주얼|', nq'|Eol'eum Jewel|', nq'|冰之寶石 / 冰之宝石|', nq'|Bīng-zhī Bǎoshí / Bīng-jī Bóusehk|', 48);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Draco Plate|', 4, q'|Raises the power of Dragon-type moves.|', nq'|りゅうのプレート|', nq'|Ryuu no Purēto|', nq'|Plaque Draco|', nq'|Dracotafel|', nq'|Lastradrakon|', nq'|Tabla Draco|', nq'|용의플레이트|', nq'|Yong-ui Plate|', nq'|龍之石板 / 龙之石板|', nq'|Lóng-zhī Shíbǎn / Lùhng-jī Sehkbáan|', 0);
insert into ITEMS(NAME, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(q'|Data Card|', nq'|データカード|', nq'|Data Card|', nq'|Carte Mémo|', nq'|Datenkarte|', nq'|Scheda Dati|', nq'|Tarjeta Datos|', nq'|데이터카드|', nq'|Data Card|', nq'|資料卡*|'||chr(10)||nq'|数据卡|', nq'|Zīliào Kǎ / Jīlíu Kāat*|'||chr(10)||nq'|Shùjù Kǎ|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Gold Bottle Cap|', 7, q'|Can be traded to Mr. Hyper to maximize all of a Pokémon's IVs in Hyper Training.|', nq'|きんのおうかん|', nq'|Kin no Ōkan|', nq'|Capsule d'Or|', nq'|Goldkronkorken|', nq'|Tappo d'oro|', nq'|Chapa Dorada|', nq'|금왕관|', nq'|Geum Wanggwan|', nq'|金色王冠|', nq'|Jīnsè Wángguān / Gāmsīk Wòhnggūn|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Kangaskhanite|', 6, q'|Allows Kangaskhan to Mega Evolve into Mega Kangaskhan.|', nq'|ガルーラナイト|', nq'|Garuranite|', nq'|Kangourexite|', nq'|Kangamanit|', nq'|Kangaskhanite|', nq'|Kangaskhanita|', nq'|캥카나이트|', nq'|Kengkanite|', nq'|袋獸進化石 / 袋兽进化石|', nq'|Dàishòu Jìnhuà Shí / Doihsau Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Colbur Berry|', 4, q'|Reduces damage from a super effective Dark-type move by 50%.|', nq'|ナモのみ|', nq'|Namo no Mi|', nq'|Baie Lampou|', nq'|Burleobeere|', nq'|Baccaxan|', nq'|Baya Dillo|', nq'|마코열매|', nq'|Mako Yeolmae|', nq'|刺耳果|', nq'|Cì'ěr Guǒ / Chiyíh Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Luminous Moss|', 6, q'|Raises the holder's Special Defense by one stage after being hit by a Water-type attack. Consumed after use.|', nq'|ひかりごけ|', nq'|Hikari Goke|', nq'|Lichen Lumineux|', nq'|Leuchtmoos|', nq'|Muschioluce|', nq'|Musgo Brillante|', nq'|빛이끼|', nq'|Bit Ikki|', nq'|光苔|', nq'|Guāngtái / Gwōngtòih|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Choice Band|', 3, q'|Raises user's Attack, but they can only use one move.|', nq'|こだわりハチマキ|', nq'|Kodawari Hachimaki|', nq'|Bandeau Choix|', nq'|Wahlband|', nq'|Bendascelta|', nq'|Cinta Elegida|', nq'|구애머리띠|', nq'|Guae Meoritti|', nq'|講究頭帶 / 讲究头带|', nq'|Jiǎngjiù Tóudài / Gónggau Tàuhdaai|', 144);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|PP Up|', 1, q'|Raises the PP of a move.|', nq'|ポイントアップ|', nq'|Point Up|', nq'|PP Plus|', nq'|AP-Plus|', nq'|PP-Su|', nq'|Más PP|', nq'|포인트 업|', nq'|Point Up|', nq'|ＰＰ提升劑 / ＰＰ提升剂|', nq'|PP Tíshēngjì / PP Tàihsīngjaih|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Net Ball|', 3, q'|A type of Poké Ball that works better on Water- and Bug-type Pokémon.|', nq'|ネットボール|', nq'|Net Ball|', nq'|Filet Ball|', nq'|Netzball|', nq'|Rete Ball|', nq'|Malla Ball|', nq'|넷트볼|', nq'|Net Ball|', nq'|捕網球 / 捕网球|', nq'|Bǔwǎng Qiú / Bouhmóhng Kàuh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Choice Specs|', 4, q'|Raises user's Special Attack, but they can only use one move.|', nq'|こだわりメガネ|', nq'|Kodawari Megane|', nq'|Lunettes Choix|', nq'|Wahlglas|', nq'|Lentiscelta|', nq'|Gafas Elegid|', nq'|구애안경|', nq'|Guae An-gyeong|', nq'|講究眼鏡 / 讲究眼镜|', nq'|Jiǎngjiù Yǎnjìng / Gónggau Ngáahngeng|', 128);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Red Petal|', 7, q'|A red petal required to complete Mina's Trial.|', nq'|あかのはなびら|', nq'|Aka no Hanabira|', nq'|Pétale Rouge|', nq'|Rotes Blatt|', nq'|Petalo rosso|', nq'|Pétalo Rojo|', nq'|빨강꽃잎|', nq'|Ppalgang Kkochip|', nq'|紅色花瓣 / 红色花瓣|', nq'|Hóng-sè Huābàn / Hùhng-sīk Fāfáan|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Ice Heal|', 1, q'|Thaws out a frozen Pokémon.|', nq'|こおりなおし|', nq'|Kōri Naoshi|', nq'|Antigel|', nq'|Eisheiler|', nq'|Antigelo|', nq'|Antihielo|', nq'|얼음상태치료제|', nq'|Eoreum Sangtae Chiryoje|', nq'|解凍藥 / 解冻药|', nq'|Jiědòngyào / Gáaidungyeuhk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Magma Emblem|', 3, q'|Allows entrance into the Team Magma Hideout.|', nq'|マグマのしるし|', nq'|Magma no Shirushi|', nq'|Emblème Magma|', nq'|Magmaemblem|', nq'|Stemma Magma|', nq'|Signo Magma|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Moon Shard|', 3, q'|Allows Eevee to evolve into Umbreon in Pokémon XD: Gale of Darkness.|', nq'|つきのかけら|', nq'|Tsuki no Kakera|', nq'|Eclat Lune|', nq'|Mondsplitter|', nq'|Coccio Lunare|', nq'|Ápice Luna|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Favored Mail|', 5, q'|Stationary designed for writing about your favorite things. To be held by a Pokémon for delivery.|', nq'|だいすきメール|', nq'|Daisuki Mail|', nq'|Lettre Fan|', nq'|Faiblebrief|', nq'|Mess. TVB|', nq'|C. Favoritos|', nq'|애호메일|', nq'|Aeho Mail|', nq'|喜愛郵件 / 喜爱邮件|', nq'|Xǐ'ài Yóujiàn / Héi'oi Yàuhgín|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Big Pearl|', 2, q'|Can be sold for 3750.|', nq'|おおきなしんじゅ|', nq'|Ōkina Shinju|', nq'|Grande Perle|', nq'|Riesenperle|', nq'|Grande Perla|', nq'|Perla Grande|', nq'|큰진주|', nq'|Keun Jinju|', nq'|大珍珠|', nq'|Dà Zhēnzhū / Daaih Jānjyū|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Reply Mail|', 5, q'|Stationary for writing a reply. To be held by a Pokémon for delivery.|', nq'|おかえしメール|', nq'|Okaeshi Mail|', nq'|Let. Réponse|', nq'|Rückbrief|', nq'|Mess. Risp.|', nq'|C. Respuesta|', nq'|답장메일|', nq'|Dapjang Mail|', nq'|回覆郵件 / 回复邮件|', nq'|Huífù Yóujiàn / Wùihfūk Yàuhgín|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Electric Seed|', 7, q'|A one-time use item that raises the holder's Defense by one stage upon activation of Electric Terrain.|', nq'|エレキシード|', nq'|Electric Seed|', nq'|Graine Électrik|', nq'|Elektro-Samen|', nq'|Elettroseme|', nq'|Semilla Electro|', nq'|일렉트릭시드|', nq'|Electric Seed|', nq'|電氣種子 / 电气种子|', nq'|Diànqì Zhǒngzi / Dihnhei Júngjí|', 0);
insert into ITEMS(NAME, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(q'|Mega Bracelet|', nq'|メガバングル|', nq'|Mega Bangle|', nq'|Méga-Bracelet|', nq'|Mega-Armreife|', nq'|Megabracciale|', nq'|Megapulsera|', nq'|메가뱅글|', nq'|Mega Bangle|', nq'|超級手鐲 / 超级手镯|', nq'|Chāojí Shǒuzhuó / Chīukāp Sáujuhk|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Seal Case|', 4, q'|Holds Seals.|', nq'|シールいれ|', nq'|Seal Ire|', nq'|Boîte Sceaux|', nq'|Stick.Koffer|', nq'|Portabolli|', nq'|Caja Sellos|', nq'|실상자|', nq'|Seal Sangja|', nq'|貼紙盒 / 贴纸盒|', nq'|Tiēzhǐ Hé / Tipjí Hahp|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Old Rod|', 1, q'|Can be used in or next to water to initiate a battle with a low-level aquatic Pokémon.|', nq'|ボロのつりざお|', nq'|Boro no Tsurizao|', nq'|Canne|', nq'|Angel|', nq'|Amo Vecchio|', nq'|Caña Vieja|', nq'|낡은낚싯대|', nq'|Nalgeun Naksitdae|', nq'|破舊釣竿 / 破旧钓竿|', nq'|Pòjiù Diàogān / Pogauh Diugōn|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Prism Scale|', 5, q'|A hold item that allows Feebas to evolve when traded.|', nq'|きれいなウロコ|', nq'|Kireina Uroko|', nq'|Bel'Écaille|', nq'|Schönschuppe|', nq'|Squama Bella|', nq'|Escama Bella|', nq'|고운비늘|', nq'|Goun Bineul|', nq'|美麗鱗片 / 美丽鳞片|', nq'|Měilì Línpiàn / Méihlaih Lèuhnpin|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Polkadot Bow|', 2, q'|Raises the power of Normal-type moves.|', nq'|みずたまりボン|', nq'|Mizutama Ribbon|', nq'|Ruban à Pois|', nq'|Punkt-Band|', nq'|Fiocco Pois|', nq'|Cintalunares|', nq'|물방울리본|', nq'|Mulbang-ul Ribon|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|TMs (50-100 different)|', 1, q'|One-time use items that can teach moves to Pokémon.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Nanab Berry|', 3, q'|Pokéblock and Poffin ingredient.|', nq'|ナナのみ|', nq'|Nana no Mi|', nq'|Baie Nanab|', nq'|Nanabbeere|', nq'|Baccabana|', nq'|Baya Latano|', nq'|나나열매|', nq'|Nana Yeolmae|', nq'|蕉香果|', nq'|Jiāoxiāng Guǒ / Jīuhēung Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Sparkling Stone|', 7, q'|Given to Hala to make a Z-RingSM or Z-Power RingUSUM.|', nq'|かがやくいし|', nq'|Kagayaku Ishi|', nq'|Gemme Lumière|', nq'|Glitzerstein|', nq'|Pietra lucente|', nq'|Piedra Brillante|', nq'|빛나는돌|', nq'|Bichnaneun Dol|', nq'|光輝石 / 光辉石|', nq'|Guānghuī Shí / Gwōngfāi Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Flame Orb|', 4, q'|Inflicts a burn on the holder.|', nq'|かえんだま|', nq'|Kaen Dama|', nq'|Orbe Flamme|', nq'|Heiß-Orb|', nq'|Fiammosfera|', nq'|Llamasfera|', nq'|화염구슬|', nq'|Hwayeom Guseul|', nq'|火焰寶珠 / 火焰宝珠|', nq'|Huǒyàn Bǎozhū / Fóyihm Bóujyū|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Carbos|', 1, q'|Raises the Speed of a Pokémon.|', nq'|インドメタシン|', nq'|Indometacin|', nq'|Carbone|', nq'|Carbon|', nq'|Carburante|', nq'|Carburante|', nq'|알칼로이드|', nq'|Alkaloid|', nq'|速度增強劑 / 速度增强剂|', nq'|Sùdù Zēngqiángjì / Chūkdouh Jāngkèuhngjaih|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Repeat Ball|', 3, q'|A type of Poké Ball that works better on Pokémon already caught before.|', nq'|リピートボール|', nq'|Repeat Ball|', nq'|Bis Ball|', nq'|Wiederball|', nq'|Bis Ball|', nq'|Acopio Ball|', nq'|리피드볼|', nq'|Ripideu Ball|', nq'|重複球 / 重复球|', nq'|Chóngfù Qiú / Chùhngfūk Kàuh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Mirage Mail|', 2, q'|Mail with a Mew pattern. Available only through Mystery Gift. To be held by a Pokémon for delivery.|', nq'|まぼろしメール|', nq'|Maboroshi Mail|', nq'|Lettre Mirage|', nq'|Trugbrief|', nq'|Mess. Visione|', nq'|C.Espejismo|', nq'|환상의메일|', nq'|Hwansang-ui Mail|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Surprise Mulch|', 6, q'|When applied to a Berry patch, increases the chance of Berry mutation.|', nq'|びっくりこやし|', nq'|Bikkuri Koyashi|', nq'|Fertistantané|', nq'|Wundermulch|', nq'|Fertilsorpresa|', nq'|Abono Sorpresa|', nq'|깜놀비료|', nq'|Kkamnol Biryo|', nq'|吃驚肥 / 吃惊肥|', nq'|Chījīng Féi / Hekgīng Fèih|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Portraitmail|', 2, q'|Mail that contains a silhouette of the Pokémon holding it. To be held by a Pokémon for delivery.|', nq'|にがおえメール|', nq'|Nigaoe Mail|', nq'|LetrPortrait|', nq'|Portraitbrief|', nq'|Mess. Ritratto|', nq'|Cart-Retrato|', nq'|초상화메일|', nq'|Chosanghwa Mail|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Leppa Berry|', 3, q'|Restores 10 PP.|', nq'|ヒメリのみ|', nq'|Himeri no Mi|', nq'|Baie Mepo|', nq'|Jonagobeere|', nq'|Baccamela|', nq'|Baya Zanama|', nq'|과사열매|', nq'|Gwasa Yeolmae|', nq'|蘋野果 / 苹野果|', nq'|Píngyě Guǒ / Pìhngyéh Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Lumiose Galette|', 6, q'|Cures any status condition.|', nq'|ミアレガレット|', nq'|Miare Galette|', nq'|Galette Illumis|', nq'|Illumina-Galette|', nq'|Pan di Lumi|', nq'|Crêpe Luminalia|', nq'|미르갈레트|', nq'|Mireu Galette|', nq'|密阿雷格雷派餅 / 密阿雷格雷派饼|', nq'|Mì'āléi Géléi Pàibǐng / Maht'alèuih Gaaklèuih Paaibéng|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Fighting Gem|', 5, q'|Increases the power of the holder's first Fighting-type move by 50%, and is consumed after use.|', nq'|かくとうジュエル|', nq'|Kakutō Jewel|', nq'|Joyau Combat|', nq'|Kampfjuwel|', nq'|Bijoulotta|', nq'|Gema Lucha|', nq'|격투주얼|', nq'|Gyeoktu Jewel|', nq'|格鬥寶石 / 格斗宝石|', nq'|Gédòu Bǎoshí / Gaakdau Bóusehk|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Rainbow Pass|', 3, q'|Allows the player access to all of the Sevii Islands.|', nq'|レインボーパス|', nq'|Rainbow Pass|', nq'|Passe Prisme|', nq'|Bunt-Pass|', nq'|Sette Pass|', nq'|Iris-Ticket|', 0);
insert into ITEMS(NAME, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(q'|Ilima's Normalium Z|', nq'|イリマのノーマルＺ|', nq'|Irima no Normal Z|', nq'|Cristal Z Althéo|', nq'|Elimas Normium Z|', nq'|Normium Z Liam|', nq'|Cristal Z (Liam)|', nq'|일리마의 노말Z|', nq'|Illima-ui Normal-Z|', nq'|伊利馬的一般Ｚ / 伊利马的一般Ｚ|', nq'|Yīlìmǎ-de Yībān-Z / Yīleihmáh-dīk Yātbūn-Z|');
insert into ITEMS(NAME, GEN, DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Key to Room 1|', 6, q'|Opens Room 1 of the Abandoned ShipRSE/Sea MauvilleORAS.|', q'|Called Rm. 1 Key in Generation III.|', nq'|いちごうしつのカギ|', nq'|Ichi-gō Shitsu no Kagi|', nq'|Clé Salle 1|', nq'|R1-Schlüssel|', nq'|Chiave stanza 1|', nq'|Ll. Habitación 1|', nq'|일호실열쇠|', nq'|Il-hosil Yeolsoe|', nq'|１號客房的鑰匙 /|'||chr(10)||nq'|１号客房的钥匙|', nq'|1 Hào Kèfáng-de Yàoshi / 1 Houh Haakfóng-dīk Yeuhksìh|', 1616);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Mewnium Z|', 7, q'|Allows Mew to upgrade Psychic to the special Z-Move Genesis Supernova.|', nq'|ミュウＺ|', nq'|Mew-Z|', nq'|Mewzélite|', nq'|Mewnium Z|', nq'|Mewnium Z|', nq'|Mewstal Z|', nq'|뮤Z|', nq'|Mew-Z|', nq'|夢幻Ｚ / 梦幻Ｚ|', nq'|Mènghuàn-Z / Muhngwaahn-Z|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Fairium Z|', 7, q'|Allows a Pokémon to upgrade their Fairy-type damaging moves to the Z-Move Twinkle Tackle or upgrade their Fairy-type status moves into Z-Moves. Makes Arceus a Fairy-type Pokémon.|', nq'|フェアリーＺ|', nq'|Fairy-Z|', nq'|Nymphézélite|', nq'|Sylphium Z|', nq'|Follectium Z|', nq'|Feeristal Z|', nq'|페어리Z|', nq'|Fairy-Z|', nq'|妖精Ｚ|', nq'|Yāojing-Z / Yíujīng-Z|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Zinc|', 3, q'|Raises the Special Defense of a Pokémon.|', nq'|キトサン|', nq'|Chitosan|', nq'|Zinc|', nq'|Zink|', nq'|Zinco|', nq'|Zinc|', nq'|키토산|', nq'|Chitosan|', nq'|特防增強劑 / 特防增强剂|', nq'|PP Tíshēngjì / PP Tàihsīngjaih|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Magma Stone|', 5, q'|Allows the player to battle Heatran.|', nq'|かざんのおきいし|', nq'|Kazan no Okiishi|', nq'|Pierre Magma|', nq'|Magmastein|', nq'|Magmapietra|', nq'|Piedra Magma|', nq'|화산의 돌|', nq'|Hwasan-ui Dol|', nq'|火山鎮石 / 火山镇石|', nq'|Huǒshān Zhènshí / Fósāan Jansehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|X Defend 3|', 5, q'|Drastically raises a Pokémon's Defense. Wonder Launcher only.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Friend Ball|', 2, q'|A type of Poké Ball that causes the Pokémon to become friendly.|', nq'|フレンドボール|', nq'|Friend Ball|', nq'|Copain Ball|', nq'|Freundesball|', nq'|Friend Ball|', nq'|Amigo Ball|', nq'|프랜드볼|', nq'|Friend Ball|', nq'|友友球|', nq'|Yǒuyǒu Qiú / Yáuhyáuh Kàuh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Big Malasada|', 7, q'|Used to heal poison, paralysis, sleep, burn, freeze, and confusion.|', nq'|おおきいマラサダ|', nq'|Ōkī Malasada|', nq'|Malasada Maxi|', nq'|Maxi-Malasada|', nq'|Malasada maxi|', nq'|Malasada Maxi|', nq'|큰 말라사다|', nq'|Keun Malasada|', nq'|大馬拉薩達 / 大马拉萨达|', nq'|Dà Mǎlāsàdá / Daaih Máhlāaisaatdaaht|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Twisted Spoon|', 2, q'|Raises the power of Psychic-type moves.|', q'|Formatted as TwistedSpoon prior to Generation VI.|', nq'|まがったスプーン|', nq'|Magatta Spoon|', nq'|Cuiller Tordue|', nq'|Krümmlöffel|', nq'|Cucchiaio Torto|', nq'|Cuchara Torcida|', nq'|휘어진스푼|', nq'|Hwieojin Spoon|', nq'|彎曲的湯匙 / 弯曲的汤匙|', nq'|Wānqū-de Tāngchí / Wāankūk-dīk Tōngchìh|', 1184);
insert into ITEMS(NAME, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(q'|Left Poké Ball|', nq'|のこされたボール|', nq'|Nokosareta Ball|', nq'|Poké Ball donnée|', nq'|Nachlassball|', nq'|Poké Ball altrui|', nq'|Poké Ball Ajena|', nq'|남겨진 볼|', nq'|Namgyeojin Ball|', nq'|留下的精靈球 / 留下的精灵球|', nq'|Liúxià-de Jīnglíngqiú / Làuhhah-dīk Jīnglìhng Kàuh|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Fairy Gem|', 6, q'|Increases the power of the holder's first Fairy-type move by 50%, and is consumed after use.|', nq'|フェアリージュエル|', nq'|Fairy Jewel|', nq'|Joyau Fée|', nq'|Feenjuwel|', nq'|Bijoufolletto|', nq'|Gema Hada|', nq'|페어리주얼|', nq'|Fairy Jewel|', nq'|妖精寶石 / 妖精宝石|', nq'|Yāojing Bǎoshí / Yīujīng Bóusehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Member Card|', 4, q'|Allows access to the Canalave City hotel to face Darkrai.|', nq'|メンバーズカード|', nq'|Member's Card|', nq'|Carte Membre|', nq'|Mitgl.Karte|', nq'|Scheda Soci|', nq'|Carné Socio|', nq'|멤버스카드|', nq'|Membership Card|', nq'|會員卡 / 会员卡|', nq'|Huìyuán Kǎ / Wúiyùhn Kāat|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Clever Wing|', 5, q'|Raises the Special Defense of a Pokémon.|', nq'|せいしんのハネ|', nq'|Seishin no Hane|', nq'|Aile Mental|', nq'|Espritfeder|', nq'|Piumintuito|', nq'|Pluma Mente|', nq'|정신력날개|', nq'|Jeongsinryeok Nalgae|', nq'|精神之羽|', nq'|Jīngshén-zhī Yǔ / Jīngsàhn-jī Yúh|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Mystery Egg|', 2, q'|Hatches into Togepi.|', nq'|ふしぎなタマゴ|', nq'|Fushigina Tamago|', nq'|Œuf Mystère|', nq'|Rätsel-Ei|', nq'|Uovo Mistero|', nq'|Huevo Mist|', nq'|이상한알|', nq'|Isanghan Al|', nq'|神奇蛋|', nq'|Shénqí Dàn / Sàhnkèih Dáan|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Level Ball|', 2, q'|A type of Poké Ball that works better on Pokémon with a lower level than the player's.|', nq'|レベルボール|', nq'|Level Ball|', nq'|Niveau Ball|', nq'|Levelball|', nq'|Level Ball|', nq'|Nivel Ball|', nq'|레벨볼|', nq'|Level Ball|', nq'|等級球 / 等级球|', nq'|Děngjí Qiú / Dángkāp Kàuh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Aloraichium Z|', 7, q'|Allows Alolan Raichu to upgrade Thunderbolt to the special Z-Move Stoked Sparksurfer.|', nq'|アロライＺ|', nq'|Alorai-Z|', nq'|Aloraïzélite|', nq'|A-Raichunium Z|', nq'|Aloraicium Z|', nq'|Alo-Raistal Z|', nq'|알로라이Z|', nq'|Allorai-Z|', nq'|阿羅雷Ｚ / 阿罗雷Ｚ|', nq'|Āluóléi-Z / Alòhlèuih-Z|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Luck Incense|', 4, q'|Causes earnings to double in battles against other Trainers. A Chansey or Blissey holding it can breed to produce a Happiny.|', nq'|こううんのおこう|', nq'|Kōun no Okō|', nq'|Encens Veine|', nq'|Glücksrauch|', nq'|Fortunaroma|', nq'|Incienso duplo|', nq'|행운의향로|', nq'|Haeng-unui Hyangno|', nq'|幸運薰香 / 幸运薰香|', nq'|Xìngyùn Xūnxiāng / Hahngwahn Fānhēung|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Music Disc|', 3, q'|Allows a change of music in Trest's house.|', nq'|おんがくソフト|', nq'|Ongaku Soft|', nq'|CD Musique|', nq'|Musik-CD|', nq'|CD Musicale|', nq'|Disco Música|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|GB Sounds|', 4, q'|Allows player to listen to 8-bit background music in Johto.|', nq'|ＧＢプレイヤー|', nq'|GB Player|', nq'|Lecteur GB|', nq'|GB-Player|', nq'|Lettore GB|', nq'|Lector GB|', nq'|GB플레이어|', nq'|GB Player|', nq'|ＧＢ播放器|', nq'|GB Bōfàng Qì / GB Bofong Hei|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Cameruptite|', 6, q'|Allows Camerupt to Mega Evolve into Mega Camerupt.|', nq'|バクーダナイト|', nq'|Bakuudanite|', nq'|Caméruptite|', nq'|Cameruptnit|', nq'|Cameruptite|', nq'|Cameruptita|', nq'|폭타나이트|', nq'|Poktanite|', nq'|噴火駝進化石 / 喷火驼进化石|', nq'|Pēnhuǒtuó Jìnhuà Shí / Panfótòh Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Water Memory|', 7, q'|Makes Silvally a Water-type Pokémon and makes Multi-Attack a Water-type move.|', nq'|ウオーターメモリ|', nq'|Water Memory|', nq'|ROM Eau|', nq'|Wasser-Disc|', nq'|ROM Acqua|', nq'|Disco Agua|', nq'|워터메모리|', nq'|Water Memory|', nq'|清水記憶碟*|'||chr(10)||nq'|清水存储碟|', nq'|Qīngshuǐ Jìyìdié / Chīngséui Geiyīkdihp*|'||chr(10)||nq'|Qīngshuǐ Cúnchǔdié|', 3);
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|Touga Berry|', 3, q'|Cures Confusion. If transferred to Generation IV via Pal Park, it will turn into an Enigma Berry.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Latiosite|', 6, q'|Allows Latios to Mega Evolve into Mega Latios.|', nq'|ラティオスナイト|', nq'|Latiosnite|', nq'|Latiosite|', nq'|Latiosnit|', nq'|Latiosite|', nq'|Latiosita|', nq'|라티오스나이트|', nq'|Latiosnite|', nq'|拉帝歐斯進化石 / 拉帝欧斯进化石|', nq'|Lādì'ōusī Jìnhuà Shí / Lāaidai'āusī Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Rocky Helmet|', 5, q'|Any contact moves against the holder will deal 1/6 damage to the attacker.|', nq'|ゴツゴツメット|', nq'|Gotsugotsu Met|', nq'|Casque Brut|', nq'|Beulenhelm|', nq'|Bitorzolelmo|', nq'|Casco Dentado|', nq'|울퉁불퉁멧|', nq'|Ultungbultung-Met|', nq'|凸凸頭盔 / 凸凸头盔|', nq'|Tūtū Tóukuī / Dahtdaht Tàuhkwāi|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Teachy TV|', 3, q'|Gives tutorials of game functions.|', nq'|おしえテレビ|', nq'|Oshie Televi|', nq'|TV ABC|', nq'|Lehrkanal|', nq'|Poké TV|', nq'|Poké Tele|', nq'|가르침TV|', nq'|Gareuchim TV|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Rock Gem|', 5, q'|Increases the power of the holder's first Rock-type move by 50%, and is consumed after use.|', nq'|いわのジュエル|', nq'|Iwa no Jewel|', nq'|Joyau Roche|', nq'|Gesteinsjuwel|', nq'|Bijouroccia|', nq'|Gema Roca|', nq'|바위주얼|', nq'|Bawi Jewel|', nq'|岩石寶石 / 岩石宝石|', nq'|Yánshí Bǎoshí / Ngàahmsehk Bóusehk|', 80);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Genius Wing|', 5, q'|Raises the Special Attack of a Pokémon.|', nq'|ちりょくのハネ|', nq'|Chiryoku no Hane|', nq'|Aile Esprit|', nq'|Geniefeder|', nq'|Piumingegno|', nq'|Pluma Intelecto|', nq'|지력날개|', nq'|Jiryeok Nalgae|', nq'|智力之羽|', nq'|Zhìlì-zhī Yǔ / Jilihk-jī Yúh|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Blazikenite|', 6, q'|Allows Blaziken to Mega Evolve into Mega Blaziken.|', nq'|バシャーモナイト|', nq'|Bursyamonite|', nq'|Braségalite|', nq'|Lohgocknit|', nq'|Blazikenite|', nq'|Blazikenita|', nq'|번치코나이트|', nq'|Bunchikonite|', nq'|火焰雞進化石 / 火焰鸡进化石|', nq'|Huǒyànjī Jìnhuà Shí / Fóyihmgāi Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Ice Stone|', 7, q'|Can be used to evolve Alolan Sandshrew and Alolan Vulpix.|', nq'|こおりのいし|', nq'|Kōri no Ishi|', nq'|Pierre Glace|', nq'|Eisstein|', nq'|Pietragelo|', nq'|Piedra Hielo|', nq'|얼음의돌|', nq'|Eoreum-ui Dol|', nq'|冰之石|', nq'|Bīng-zhī Shí / Bīng-jī Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Houndoominite|', 6, q'|Allows Houndoom to Mega Evolve into Mega Houndoom.|', nq'|ヘルガナイト|', nq'|Hellganite|', nq'|Démolossite|', nq'|Hundemonit|', nq'|Houndoomite|', nq'|Houndoomita|', nq'|헬가나이트|', nq'|Helganite|', nq'|黑魯加進化石 / 黑鲁加进化石|', nq'|Hēilǔjiā Jìnhuà Shí / Hāklóuhgā Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|DNA Sample|', 3, q'|Used to deduce the code to a lock in the Shadow PKMN Lab.|', nq'|ＤＮＡサンプル|', nq'|DNA Sample|', nq'|Echantillon ADN|', nq'|DNS-Probe|', nq'|Campione DNA|', nq'|Muestra ADN|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Coupon 3|', 4, q'|Used to obtain the Pokétch in Jubilife City.|', nq'|ひきかえけん３|', nq'|Hikikaeken 3|', nq'|Bon 3|', nq'|Kupon 3|', nq'|Coupon 3|', nq'|Cupón 3|', nq'|교환권 3|', nq'|Gyohwangwon 3|', nq'|兌換券３ / 兑换券３|', nq'|Duìhuàn Quàn 3 / Deuiwuhn Hyun 3|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Sticky Barb|', 4, q'|Damages the holder. May latch onto the foe if a physical move is used and the foe is not already holding an item.|', nq'|くっつきバリ|', nq'|Kuttsuki Bari|', nq'|Piquants|', nq'|Klettdorn|', nq'|Vischiopunta|', nq'|Toxiestrella|', nq'|끈적끈적바늘|', nq'|Kkeunjeokkkeunjeok Baneul|', nq'|附著針 / 附着针|', nq'|Fùzhuó Zhēn / Fuhjeuhk Jām|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Dragon Memory|', 7, q'|Makes Silvally a Dragon-type Pokémon and makes Multi-Attack a Dragon-type move.|', nq'|ドラゴンメモリ|', nq'|Dragon Memory|', nq'|ROM Dragon|', nq'|Drachen-Disc|', nq'|ROM Drago|', nq'|Disco Dragón|', nq'|드래곤메모리|', nq'|Dragon Memory|', nq'|龍記憶碟*|'||chr(10)||nq'|龙存储碟|', nq'|Lóng Jìyìdié / Lùhng Geiyīkdihp*|'||chr(10)||nq'|Lóng Cúnchǔdié|', 3);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Scizorite|', 6, q'|Allows Scizor to Mega Evolve into Mega Scizor.|', nq'|ハッサムナイト|', nq'|Hassamnite|', nq'|Cizayoxite|', nq'|Scheroxnit|', nq'|Scizorite|', nq'|Scizorita|', nq'|핫삼나이트|', nq'|Hatsamnite|', nq'|巨鉗螳螂進化石 / 巨钳螳螂进化石|', nq'|Jùqiántángláng Jìnhuà Shí / Geuihkìhmtòhnglòhng Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Revival Herb|', 2, q'|Revives a Pokémon to full HP, but lowers friendship.|', nq'|ふっかつそう|', nq'|Fukkatsu Sō|', nq'|Herbe Rappel|', nq'|Vitalkraut|', nq'|Vitalerba|', nq'|Hierba Revivir|', nq'|부활 초|', nq'|Buhwal Cho|', nq'|復活草 / 复活草|', nq'|Fùhuó Cǎo / Fuhkwuht Chóu|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|RageCandyBar|', 2, q'|In Johto, can be exchanged for TM64.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Honor of Kalos|', 6, q'|Proof of defeating Team Flare and becoming Champion of the Kalos Pokémon League.|', nq'|カロスエンブレム|', nq'|Kalos Emblem|', nq'|Insigne de Kalos|', nq'|Kalos-Emblem|', nq'|Emblema di Kalos|', nq'|Emblema de Kalos|', nq'|칼로스엠블럼|', nq'|Kalos Emblem|', nq'|卡洛斯勳章 / 卡洛斯勋章|', nq'|Kǎluòsī Xūnzhāng / Kāloksī Fānjēung|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Thanks Mail|', 5, q'|Stationary designed for a thank you note. To be held by a Pokémon for delivery.|', nq'|かんしゃメール|', nq'|Kansha Mail|', nq'|Lettre Merci|', nq'|Dankesbrief|', nq'|Mess. Grazie|', nq'|C. Gracias|', nq'|감사메일|', nq'|Gamsa Mail|', nq'|感謝郵件 / 感谢邮件|', nq'|Gǎnxiè Yóujiàn / Gámjeh Yàuhgín|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Red Nectar|', 7, q'|Changes Oricorio to its Baile Style.|', nq'|くれないのミツ|', nq'|Kurenai no Mitsu|', nq'|Nectar Rouge|', nq'|Roter Nektar|', nq'|Nettare rosso|', nq'|Néctar Rojo|', nq'|다홍꿀|', nq'|Dahong Kkul|', nq'|朱紅色花蜜|', nq'|Zhūhóng-sè Huāmì / Jyūhùhng-sīk Fāmaht|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Aggronite|', 6, q'|Allows Aggron to Mega Evolve into Mega Aggron.|', nq'|ボスゴドラナイト|', nq'|Bossgodoranite|', nq'|Galekingite|', nq'|Stollossnit|', nq'|Aggronite|', nq'|Aggronita|', nq'|보스로라나이트|', nq'|Bosroranite|', nq'|波士可多拉進化石 / 波士可多拉进化石|', nq'|Bōshìkěduōlā Jìnhuà Shí / Bōsihhódōlāai Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|X Sp. Def 6|', 5, q'|Immensely raises a Pokémon's Special Defense. Wonder Launcher only.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Fashion Case|', 4, q'|Stores Accessories.|', nq'|アクセサリーいれ|', nq'|Accessory Ire|', nq'|Coffret Mode|', nq'|Modekoffer|', nq'|Scatola Chic|', nq'|Caja Corazón|', nq'|액세서리상자|', nq'|Accessory Sangja|', nq'|飾品盒 / 饰品盒|', nq'|Shìpǐn Hé / Sīkbán Hahp|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Plume Fossil|', 5, q'|A Fossil from which an Archen can be resurrected.|', nq'|はねのカセキ|', nq'|Hane no Kaseki|', nq'|Fossile Plume|', nq'|Federfossil|', nq'|Fossilpiuma|', nq'|Fósil Pluma|', nq'|날개화석|', nq'|Nalgae Hwaseok|', nq'|羽毛化石|', nq'|Yǔmáo Huàshí / Yúhmòuh Fasehk|', 128);
insert into ITEMS(NAME, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(q'|Mega Charm|', nq'|メガチャーム|', nq'|Mega Charm|', nq'|Méga-Charme|', nq'|Megaillon|', nq'|Megaciondolo|', nq'|Megacolgante|', nq'|메가참이|', nq'|Mega Charm|', nq'|超級墜飾 / 超级坠饰|', nq'|Chāojí Zhuìshì / Chīukāp Jeuihsīk|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Oval Charm|', 5, q'|An oval charm said to increase the chance of Eggs being found at the Day Care.|', nq'|まるいおまもり|', nq'|Round Charm|', nq'|Charme Ovale|', nq'|Ovalpin|', nq'|Ovamuleto|', nq'|Amuleto Oval|', nq'|둥근부적|', nq'|Dunggeun Bujeok|', nq'|圓形護符 / 圆形护符|', nq'|Yuánxíng Hùfú / Yùhnyìhng Wuhfùh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Life Orb|', 4, q'|Raises the power of moves, but causes recoil damage.|', nq'|いのちのたま|', nq'|Inochi no Tama|', nq'|Orbe Vie|', nq'|Leben-Orb|', nq'|Assorbisfera|', nq'|Vidasfera|', nq'|생명의구슬|', nq'|Saengmyeong-ui Guseul|', nq'|生命寶珠 / 生命宝珠|', nq'|Shēngmìng Bǎozhū / Sāngmihng Bóujyū|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Normal Box|', 2, q'|Sometimes held by reward Pokémon from clearing Gym Leader Castle in Pokémon Stadium when traded to Generation II or Pokémon Stadium 2.|', nq'|きのはこ|', nq'|Ki no Hako|', nq'|Coffre Normal|', nq'|Schachtel|', nq'|Scat. Normale|', nq'|Caja Normal|', nq'|나무상자|', nq'|Namu Sangja|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Yellow Shard|', 3, q'|Exchangeable for a variety of services.|', nq'|きいろいかけら|', nq'|Kiiroi Kakera|', nq'|Tesson Jaune|', nq'|Gelbstück|', nq'|Coccio Giallo|', nq'|Parte Amarilla|', nq'|노랑조각|', nq'|Norang Jogak|', nq'|黃色碎片 / 黄色碎片|', nq'|Huángsè Suìpiàn / Wòhngsīk Seuipin|', 48);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Lustrous Orb|', 4, q'|Boosts Palkia's Water- and Dragon-type attacks.|', nq'|しらたま|', nq'|Shiratama|', nq'|Orbe Perlé|', nq'|Weiß-Orb|', nq'|Splendisfera|', nq'|Lustresfera|', nq'|백옥|', nq'|Baegok|', nq'|白玉寶珠 / 白玉宝珠|', nq'|Báiyù Bǎozhū / Baahkyuhk Bóujyū|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Park Ball|', 4, q'|A type of Poké Ball that is used to recapture Generation III Pokémon in the Pal Park.|', nq'|パークボール|', nq'|Park Ball|', nq'|Parc Ball|', nq'|Parkball|', nq'|Parco Ball|', nq'|Parque Ball|', nq'|파크볼|', nq'|Park Ball|', nq'|公園球 / 公园球|', nq'|Gōngyuán Qiú / Gūngyún Kàuh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Metagrossite|', 6, q'|Allows Metagross to Mega Evolve into Mega Metagross.|', nq'|メタグロスナイト|', nq'|Metagrossnite|', nq'|Métalossite|', nq'|Metagrossnit|', nq'|Metagrossite|', nq'|Metagrossita|', nq'|메타그로스나이트|', nq'|Metagrossnite|', nq'|巨金怪進化石 / 巨金怪进化石|', nq'|Jùjīnguài Jìnhuà Shí / Geuihgāmgwaai Jeunfa Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Meteorite Shard|', 6, q'|To be delivered to Steven Stone and Professor Cozmo.|', nq'|いんせきのかけら|', nq'|Inseki no Kakera|', nq'|Éclat Météorite|', nq'|Meteoritenstück|', nq'|Framm. meteorite|', nq'|Frag. Meteorito|', nq'|운석조각|', nq'|Unseok Jogag|', nq'|隕石碎片 / 陨石碎片|', nq'|Yǔnshí suìpiàn / Wáhnsehk Seuipín|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Rose Incense|', 4, q'|Raises the power of Grass-type moves. Roselia and Roserade holding this can breed Budew.|', nq'|おはなのおこう|', nq'|Ohana no Okō|', nq'|Encens Fleur|', nq'|Rosenrauch|', nq'|Rosaroma|', nq'|Incienso floral|', nq'|꽃향로|', nq'|Kkoch Hyangno|', nq'|花朵薰香|', nq'|Huāduǒ Xūnxiāng / Fādó Fānhēung|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Petaya Berry|', 3, q'|Raises Special Attack if HP is below ⅓ of maximum.|', nq'|ヤタピのみ|', nq'|Yatapi no Mi|', nq'|Baie Pitaye|', nq'|Tahaybeere|', nq'|Baccapitaya|', nq'|Baya Yapati|', nq'|야타비열매|', nq'|Yatabi Yeolmae|', nq'|龍火果 / 龙火果|', nq'|Lónghuǒ Guǒ / Lùhngfó Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Brick Piece|', 2, q'|Can be sold for 50.|', nq'|かわらのかけら|', nq'|Kawara no Kakera|', nq'|Morc. Brique|', nq'|Ziegelstein|', nq'|Mattoncino|', nq'|Ladrillo|', nq'|기와조각|', nq'|Giwa Jogak|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Soda Pop|', 1, q'|Restores 50 HP. (60HP before Gen. VII).|', nq'|サイコソーダ|', nq'|Saiko Soda|', nq'|Soda Cool|', nq'|Sprudel|', nq'|Gassosa|', nq'|Refresco|', nq'|미네랄사이다|', nq'|Mineral Cider|', nq'|勁爽汽水 / 劲爽汽水|', nq'|Jìnshuǎng Qìshuǐ / Gihngsóng Heiséui|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Morph Mail|', 2, q'|Mail with a Ditto design. To be held by a Pokémon for delivery.|', nq'|へんしんメール|', nq'|Henshin Mail|', nq'|Lettre Morph|', nq'|Morph-Brief|', nq'|Mess. Morph|', nq'|Cartmorfosis|', nq'|변신메일|', nq'|Byeonsin Mail|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Psychic Gem|', 5, q'|Increases the power of the holder's first Psychic-type move by 50%, and is consumed after use.|', nq'|エスパージュエル|', nq'|Esper Jewel|', nq'|Joyau Psy|', nq'|Psychojuwel|', nq'|Bijoupsico|', nq'|Gema Psíquica|', nq'|에스퍼주얼|', nq'|Esper Jewel|', nq'|超能力寶石 / 超能力宝石|', nq'|Chāonénglì Bǎoshí / Chīunàhnglihk Bóusehk|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Medal Box|', 5, q'|A box-shaped machine that stores Medals and Medal information.|', nq'|メダルボックス|', nq'|Medal Box|', nq'|B. Médailles|', nq'|Medaillenbox|', nq'|Box Premi|', nq'|C. Insignias|', nq'|메달박스|', nq'|Medal Box|', nq'|獎牌盒 / 奖牌盒|', nq'|Jiǎngpái Hé / Jéungpáai Hahp|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Contest Pass|', 3, q'|Allows the player to enter Contests.|', nq'|コンテストパス|', nq'|Contest Pass|', nq'|Passe Concours|', nq'|Wettb.-Karte|', nq'|Tessera Gare|', nq'|Pase Concurso|', nq'|콘테스트패스|', nq'|Contest Pass|', nq'|華麗大賽參加證 / 华丽大赛参加证|', nq'|Huálì Dàsài Cānjiā Zhèng / Wàhlaih Daaihchoi Chāamgā Jing|', 160);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Silver Leaf|', 2, q'|May be held by a Pokémon transferred from Generation I.|', nq'|ぎんのはっぱ|', nq'|Gin no Happa|', nq'|Feuille Arg.|', nq'|Silberblatt|', nq'|Fogliargento|', nq'|Hoja Plata|', nq'|은빛나뭇잎|', nq'|Eunbit Namunnip|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Haban Berry|', 4, q'|Halves the power of super effective Dragon-type moves.|', nq'|ハバンのみ|', nq'|Haban no Mi|', nq'|Baie Fraigo|', nq'|Terirobeere|', nq'|Baccahaban|', nq'|Baya Anjiro|', nq'|하반열매|', nq'|Haban Yeolmae|', nq'|莓榴果|', nq'|Méiliú Guǒ / Mùihlàuh Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Float Stone|', 5, q'|Halves the weight of the holder.|', nq'|かるいし|', nq'|Karuishi|', nq'|Pierrallégée|', nq'|Leichtstein|', nq'|Pietralieve|', nq'|Piedra Pómez|', nq'|가벼운돌|', nq'|Gabyeoun Dol|', nq'|輕石 / 轻石|', nq'|Qīngshí / Hīngsehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Cover Fossil|', 5, q'|A Fossil from which a Tirtouga can be resurrected.|', nq'|ふたのカセキ|', nq'|Futa no Kaseki|', nq'|Fossile Plaque|', nq'|Schildfossil|', nq'|Fossiltappo|', nq'|Fósil Tapa|', nq'|덮개화석|', nq'|Deopgae Hwaseok|', nq'|背蓋化石 / 背盖化石|', nq'|Bèigài Huàshí / Buihgoi Fasehk|', 128);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Grassium Z|', 7, q'|Allows a Pokémon to upgrade their Grass-type damaging moves to the Z-Move Bloom Doom or upgrade their Grass-type status moves into Z-Moves. Makes Arceus a Grass-type Pokémon.|', nq'|クサＺ|', nq'|Grass-Z|', nq'|Florazélite|', nq'|Botanium Z|', nq'|Herbium Z|', nq'|Fitostal Z|', nq'|풀Z|', nq'|Pul-Z|', nq'|草Ｚ|', nq'|Cǎo-Z / Chóu-Z|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Bug Memory|', 7, q'|Makes Silvally a Bug-type Pokémon and makes Multi-Attack a Bug-type move.|', nq'|バグメモリ|', nq'|Bug Memory|', nq'|ROM Insecte|', nq'|Käfer-Disc|', nq'|ROM Coleottero|', nq'|Disco Bicho|', nq'|버그메모리|', nq'|Bug Memory|', nq'|蟲子記憶碟*|'||chr(10)||nq'|虫子存储碟|', nq'|Chóngzǐ Jìyìdié / Chùhngjí Geiyīkdihp*|'||chr(10)||nq'|Chóngzǐ Cúnchúdié|', 3);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Pearl String|', 5, q'|Can be sold for 25000 to the ore collector|', nq'|おだんごしんじゅ|', nq'|Odango Shinju|', nq'|Perle Triple|', nq'|Triperle|', nq'|Trittiperla|', nq'|Sarta Perlas|', nq'|경단진주|', nq'|Gyeongdan Jinju|', nq'|丸子珍珠|', nq'|Wánzi Zhēnzhū / Yùhnjí Jānjyū|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Lansat Berry|', 3, q'|Raises critical-hit ratio if HP is below ⅓ of maximum.|', nq'|サンのみ|', nq'|San no Mi|', nq'|Baie Lansat|', nq'|Lansatbeere|', nq'|Baccalangsa|', nq'|Baya Zonlan|', nq'|랑사열매|', nq'|Langsa Yeolmae|', nq'|蘭薩果 / 兰萨果|', nq'|Lánsà Guǒ / Làahnsaat Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Black Sludge|', 4, q'|Restores 1/16 of the Pokémon's maximum HP each turn when held by Poison-type Pokémon; damages all other types by ⅛ of maximum HP each turn.|', nq'|くろいヘドロ|', nq'|Kuroi Hedoro|', nq'|Boue Noire|', nq'|Giftschleim|', nq'|Fangopece|', nq'|Lodo Negro|', nq'|검은진흙|', nq'|Geomeun Jinheuk|', nq'|黑色污泥|', nq'|Hēi-sè Wūní / Hāak-sīk Wūnàih|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Primarium Z|', 7, q'|Allows Primarina to upgrade Sparkling Aria to the special Z-Move Oceanic Operetta.|', nq'|アシレーヌＺ|', nq'|Ashirene-Z|', nq'|Oratozélite|', nq'|Primarenium Z|', nq'|Primarinium Z|', nq'|Primastal Z|', nq'|누리레느Z|', nq'|Nurireneu-Z|', nq'|西獅海壬Ｚ / 西狮海壬Ｚ|', nq'|Xīshīhǎirén-Z / Sāisīhóiyàhm-Z|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Charizardite X|', 6, q'|Allows Charizard to Mega Evolve into Mega Charizard X.|', nq'|リザードナイトX|', nq'|Lizardonite X|', nq'|Dracaufite X|', nq'|Gluraknit X|', nq'|Charizardite X|', nq'|Charizardita X|', nq'|리자몽나이트X|', nq'|Rizamonnite X|', nq'|噴火龍進化石X / 喷火龙进化石X|', nq'|Pēnhuǒlóng Jìnhuà Shí X / Panfólùhng Jeunfa Sehk X|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Heat Rock|', 4, q'|Extends the duration of harsh sunlight.|', nq'|あついいわ|', nq'|Atsui Iwa|', nq'|Roche Chaude|', nq'|Heißbrocken|', nq'|Rocciacalda|', nq'|Roca Calor|', nq'|뜨거운바위|', nq'|Tteugeoun Bawi|', nq'|熾熱岩石 / 炽热岩石|', nq'|Chìrè Yánshí / Chiyiht Ngàahmsehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Dragon Gem|', 5, q'|Increases the power of the holder's first Dragon-type move by 50%, and is consumed after use.|', nq'|ドラゴンジュエル|', nq'|Dragon Jewel|', nq'|Joyau Dragon|', nq'|Drakojuwel|', nq'|Bijoudrago|', nq'|Gema Dragón|', nq'|드래곤주얼|', nq'|Dragon Jueol|', nq'|龍之寶石 / 龙之宝石|', nq'|Lóng-zhī Bǎoshí / Lùhng-jī Bóusehk|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Weakness Policy|', 6, q'|Attack and Sp. Atk sharply increase if the holder is hit with a super effective move.|', nq'|じゃくてんほけん|', nq'|Jakuten Hoken|', nq'|Vulné-Assurance|', nq'|Schwächenschutz|', nq'|Vulneropolizza|', nq'|Seguro Debilidad|', nq'|약점보험|', nq'|Yagjeom Boheom|', nq'|弱點保險 / 弱点保险|', nq'|Ruòdiǎn Bǎoxiǎn / Yeuhkdím Bóuhím|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Plasma Card|', 5, q'|A card key needed to enter the password inside the Plasma Frigate.|', nq'|プラズマカード|', nq'|Plasma Card|', nq'|Carte Plasma|', nq'|Plasmakarte|', nq'|Carta Plasma|', nq'|Tarjeta Plasma|', nq'|플라스마카드|', nq'|Plasma Card|', nq'|等離子卡 / 等离子卡|', nq'|Děnglízǐ Kǎ / Dánglèihjí Kāat|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Bluesky Mail|', 4, q'|A sky-print mail. To be held by a Pokémon for delivery.|', nq'|あおぞらメール|', nq'|Aozora Mail|', nq'|LetrCielBleu|', nq'|Kobaltbrief|', nq'|Mess. Cielo|', nq'|Cartaceleste|', nq'|푸른하늘메일|', nq'|Pureun Haneul Mail|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Sprinklotad|', 6, q'|Used to water Berry plants.|', nq'|ハスボーじょうろ|', nq'|Hassboh Jōro|', nq'|Nénurrosoir|', nq'|Loturzelkanne|', nq'|Irrigalotad|', nq'|Lotadgadera|', nq'|연꽃몬물뿌리개|', nq'|Yeonkkotmon Mulppurigae|', nq'|蓮葉童子噴壺 / 莲叶童子喷壶|', nq'|Liányètóngzǐ Pēnhú / Lìhnyihptùhngjí Panwùh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Fishing Rod|', 7, q'|Allows the player to fish near underwater piles of rock.|', nq'|つりざお|', nq'|Tsurizao|', nq'|Canne à Pêche|', nq'|Angel|', nq'|Amo|', nq'|Caña|', nq'|낚싯대|', nq'|Nakksisdae|', nq'|釣竿 / 钓竿|', nq'|Diàogān / Diugōn|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Balm Mushroom|', 5, q'|Can be sold for 25000.|', q'|Formatted as BalmMushroom in Generation V.|', nq'|かおるキノコ|', nq'|Kaoru Kinoko|', nq'|Champi Suave|', nq'|Duftpilz|', nq'|Profumfungo|', nq'|Seta Aroma|', nq'|향기버섯|', nq'|Hyanggi Beoseot|', nq'|芳香蘑菇|', nq'|Fāngxiāng Mógū / Fōnghēung Mòhgū|', 1024);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Smoke Ball|', 3, q'|A held item that allows the user to flee from any wild Pokémon battle. Can be used an unlimited number of times.|', nq'|けむりだま|', nq'|Kemuri Dama|', nq'|Boule Fumée|', nq'|Rauchball|', nq'|Palla Fumo|', nq'|Bola Humo|', nq'|연막탄|', nq'|Yeonmaktan|', nq'|煙霧球 / 烟雾球|', nq'|Yānwù Qiú / Yīnmouh Kàuh|', 128);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Quick Ball|', 4, q'|A type of Poké Ball that works better the earlier in battle it is used.|', nq'|クイックボール|', nq'|Quick Ball|', nq'|Rapide Ball|', nq'|Flottball|', nq'|Velox Ball|', nq'|Veloz Ball|', nq'|퀵볼|', nq'|Quick Ball|', nq'|先機球 / 先机球|', nq'|Xiānjī Qiú / Sīngēi Kàuh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Ice Berry|', 2, q'|Heals a burn.|', nq'|こおったきのみ|', nq'|Kōtta Kino Mi|', nq'|Baie Gel|', nq'|Eisbeere|', nq'|Bacca Ghiac.|', nq'|Baya Hielo|', nq'|얼은나무열매|', nq'|Eoreun Namu Yeolmae|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Power Plant Pass|', 6, q'|Allows access to the Kalos Power Plant.|', nq'|はつでんしょパス|', nq'|Hatsudensho Pass|', nq'|Passe Centrale|', nq'|Kraftwerks-Pass|', nq'|Pass Centrale|', nq'|Pase Central|', nq'|발전소패스|', nq'|Baljeonso Pass|', nq'|發電廠通行證 / 发电厂通行证|', nq'|Fādiànchǎng Tōngxíngzhèng / Faatdihnchóng Tūnghàhngjing|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Steel Teeth|', 3, q'|Give to the old man in front of Under Colosseum to obtain the L-Disk.|', nq'|はがねのいれば|', nq'|Hagane no Ireba|', nq'|Dentier d'Acier|', nq'|Zahnprothese|', nq'|Dentacciaio|', nq'|Dentadura|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Max Elixir|', 1, q'|Restores all of a Pokémon's PP.|', nq'|ピーピーマックス|', nq'|PP Max|', nq'|Max Elixir|', nq'|Top-Elixier|', nq'|Elisir Max|', nq'|Elixir Máximo|', nq'|PP맥스|', nq'|PP Max|', nq'|ＰＰ多項全補劑 / ＰＰ多项全补剂|', nq'|PP Duōxiàng Quánbǔjì / PP Dōhohng Chyùhnbóujaih|', 1024);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Card Key|', 2, q'|Allows the player to access the third floor of Radio Tower while it is under siege by Team Rocket.|', nq'|カードキー|', nq'|Card Key|', nq'|Carte Magn.|'||chr(10)||nq'|Cle Magnetique|', nq'|Türöffner|'||chr(10)||nq'|Schlüsselkarte|', nq'|Apriporta|', nq'|Llave Magnética|'||chr(10)||nq'|T. Magnética|', nq'|카드키|', nq'|Card Key|', nq'|鑰匙卡 / 钥匙卡|', nq'|Yàoshi Kǎ / Yeuhksìh Kāat|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|Shiny Leaf|', 4, q'|Note: Can only be held by Pokémon and found on certain tiles in certain areas by checking the Pokémon that follows the player. No guarantee that the player can find it even in the right place.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Babiri Berry|', 4, q'|Reduces damage from a super effective Steel-type move by 50%.|', nq'|リリバのみ|', nq'|Ririba no Mi|', nq'|Baie Babiri|', nq'|Babiribeere|', nq'|Baccababiri|', nq'|Baya Baribá|', nq'|바리비열매|', nq'|Baribi Yeolmae|', nq'|霹霹果|', nq'|Pīpī Guǒ / Pīkpīk Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Rainbow Wing|', 2, q'|Summons Ho-Oh.|', nq'|にじいろのはね|', nq'|Nijiiro no Hane|', nq'|Arcenci'Aile|', nq'|Buntschwinge|', nq'|Ala d'Iride|', nq'|Ala Arcoíris|', nq'|무지개빛날개|', nq'|Mujigaebit Nalgae|', nq'|虹色之羽|', nq'|Hóng-sè-zhī Yǔ / Hùhng-sīk-jī Yúh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Flying Memory|', 7, q'|Makes Silvally a Flying-type Pokémon and makes Multi-Attack a Flying-type move.|', nq'|フライングメモリ|', nq'|Flying Memory|', nq'|ROM Vol|', nq'|Flug-Disc|', nq'|ROM Volante|', nq'|Disco Volador|', nq'|플라잉메모리|', nq'|Flying Memory|', nq'|飛翔記憶碟*|'||chr(10)||nq'|飞翔存储碟|', nq'|Fēixiáng Jìyìdié / Fēichèuhng Geiyīkdihp*|'||chr(10)||nq'|Fēixiáng Cúnchǔdié|', 3);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Voice Case 1|', 3, q'|Heals a Combusken in Agate Village.|', nq'|こえカプセル１|', nq'|Koe Capsule 1|', nq'|Boite Cri 1|', nq'|Stimmbox 1|', nq'|Disco Verso 1|', nq'|Grabación 1|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Sharp Beak|', 2, q'|Raises the power of Flying-type moves.|', nq'|するどいくちばし|', nq'|Surudoi Kuchibashi|', nq'|Bec Pointu|', nq'|Hackattack|', nq'|Beccaffilato|', nq'|Pico Afilado|', nq'|예리한부리|', nq'|Yerihan Buri|', nq'|銳利鳥嘴 / 锐利鸟嘴|', nq'|Ruìlì Niǎozuǐ / Yeuihleih Níuhjéui|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Poké Doll|', 1, q'|Allows the player to flee from any battle with a wild Pokémon.|', nq'|ピッピにんぎょう|', nq'|Pippi Ningyō|', nq'|Poképoupée|', nq'|Poképuppe|', nq'|Poké Bambola|', nq'|Poké Muñeco|', nq'|삐삐인형|', nq'|Ppippi Inhyeong|', nq'|皮皮玩偶|', nq'|Pípí Wán'ǒu / Pèihpèih Wuhnngáuh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Air Balloon|', 5, q'|Gives the holder an immunity to Ground-type moves but is popped when the holder is hit by any non-Ground-type attacks.|', nq'|ふうせん|', nq'|Fūsen|', nq'|Ballon|', nq'|Luftballon|', nq'|Palloncino|', nq'|Globo Helio|', nq'|풍선|', nq'|Pungseon|', nq'|氣球 / 气球|', nq'|Qìqiú / Heikàuh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|System Lever|', 3, q'|Shuts down the Cipher Key Lair.|', nq'|かいじょレバー|', nq'|Kaijo Lever|', nq'|Levier|', nq'|Systemhebel|', nq'|Leva|', nq'|Palanca|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Shiny Stone|', 4, q'|Can be used to evolve Togetic, Roselia, Minccino, and Floette.|', nq'|ひかりのいし|', nq'|Hikari no Ishi|', nq'|Pierre Éclat|', nq'|Leuchtstein|', nq'|Pietrabrillo|', nq'|Piedra Día|', nq'|빛의돌|', nq'|Bichui Dol|', nq'|光之石|', nq'|Guāng-zhī Shí / Gwōng-jī Sehk|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|Nutpea Berry|', 3, q'|Pokéblock ingredient. It will become an Enigma Berry if transferred to Generation IV via Pal Park.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Lunar Wing|', 4, q'|Cures an endless nightmare.|', nq'|みかづきのはね|', nq'|Mikadzuki no Hane|', nq'|Lun'Aile|', nq'|Lunarfeder|', nq'|Ala Lunare|', nq'|Pluma Lunar|', nq'|초승달날개|', nq'|Choseungdal Nalgae|', nq'|新月之羽|', nq'|Xīnyuè-zhī Yǔ / Sānyuht-jī Yúh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Master Ball|', 1, q'|A rare type of Poké Ball that catches any wild Pokémon without fail. Generally available only once in the game, though it may be obtained again in very unlikely situations (such as winning the lottery), cheating, or on the GTS in Generation IV.|', nq'|マスターボール|', nq'|Master Ball|', nq'|Master Ball|', nq'|Meisterball|', nq'|Master Ball|', nq'|Master Ball|', nq'|마스터볼|', nq'|Master Ball|', nq'|大師球 / 大师球|', nq'|Dàshī Qiú / Daaihsī Kàuh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Shiny Charm|', 5, q'|A shiny charm said to increase the chance of finding a Shiny Pokémon.|', nq'|ひかるおまもり|', nq'|Shining Charm|', nq'|Charme Chroma|', nq'|Schillerpin|', nq'|Cromamuleto|', nq'|Amuleto Iris|', nq'|빚나는부적|', nq'|Bitna-neun Bujeok|', nq'|閃耀護符 / 闪耀护符|', nq'|Shǎnyào Hùfú / Símyiuh Wuhfùh|', 128);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Electirizer|', 4, q'|A hold item that allows Electabuzz to evolve when traded.|', nq'|エレキブースター|', nq'|Elec Booster|', nq'|Électiriseur|', nq'|Stromisierer|', nq'|Elettritore|', nq'|Electrizador|', nq'|에레키부스터|', nq'|Elec Booster|', nq'|電力增幅器 / 电力增幅器|', nq'|Diànlì Zēngfú Qì / Dihnlihk Jāngfūk Hei|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Moomoo Milk|', 2, q'|Restores 100 HP.|', nq'|モーモーミルク|', nq'|Mō Mō Milk|', nq'|Lait Meumeu|', nq'|Kuhmuh-Milch|', nq'|Latte Mumu|', nq'|Leche Mu-Mu|', nq'|튼튼밀크|', nq'|Teunteun Milk|', nq'|哞哞鮮奶 / 哞哞鲜奶|', nq'|Mōumōu Xiānnǎi / Māumāu Sīnnáaih|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Sacred Ash|', 2, q'|Revives all fainted Pokémon in the party to full HP.|', nq'|せいなるはい|', nq'|Seinaru Hai|', nq'|Cendres Sacrées|', nq'|Zauberasche|', nq'|Magicenere|', nq'|Ceniza Sagrada|', nq'|성스러운분말|', nq'|Seongseureoun Bunmal|', nq'|聖灰 / 圣灰|', nq'|Shènghuī / Singfūi|', 128);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Yache Berry|', 4, q'|Reduces damage taken from a super effective Ice-type move.|', nq'|ヤチェのみ|', nq'|Yache no Mi|', nq'|Baie Nanone|', nq'|Kiroyabeere|', nq'|Baccamoya|', nq'|Baya Rimoya|', nq'|플카열매|', nq'|Peulka Yeolmae|', nq'|番荔果|', nq'|Fānlì Guǒ / Fāanlaih Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Old Gateau|', 4, q'|Cures any status condition.|', nq'|もりのヨウカン|', nq'|Mori no Yōkan|', nq'|Vieux Gâteau|', nq'|Spezialität|', nq'|Dolce Gateau|', nq'|Barrita Plus|', nq'|숲의양갱|', nq'|Sup-ui Yanggaeng|', nq'|森之羊羹|', nq'|Sēn-zhī Yánggēng / Sām-jī Yèuhnggāng|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Key to Room 4|', 6, q'|Opens Room 4 of the Abandoned ShipRSE/Sea MauvilleORAS.|', q'|Called Rm. 4 Key in Generation III.|', nq'|よんごうしつのカギ|', nq'|Yon-gō Shitsu no Kagi|', nq'|Clé Salle 4|', nq'|R4-Schlüssel|', nq'|Chiave stanza 4|', nq'|Ll. Habitación 4|', nq'|사호실열쇠|', nq'|Sa-hosil Yeolsoe|', nq'|４號客房的鑰匙 /|'||chr(10)||nq'|４号客房的钥匙|', nq'|4 Hào Kèfáng-de Yàoshi / 4 Houh Haakfóng-dīk Yeuhksìh|', 1616);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Mewtwonite Y|', 6, q'|Allows Mewtwo to Mega Evolve into Mega Mewtwo Y.|', nq'|ミュウツナイトY|', nq'|Mewtwonite Y|', nq'|Mewtwoïte Y|', nq'|Mewtunit Y|', nq'|Mewtwoite Y|', nq'|Mewtwoita Y|', nq'|뮤츠나이트Y|', nq'|Mewtwonite Y|', nq'|超夢進化石Y / 超梦进化石Y|', nq'|Chāomèng Jìnhuà Shí Y / Chīumuhng Jeunfa Sehk Y|', 0);
insert into ITEMS(NAME, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(q'|Rule Book|', nq'|ルールブック|', nq'|Rule Book|', nq'|Livre Règles|', nq'|Regelbuch|', nq'|Libro Regole|', nq'|Reglamento|', nq'|룰북|', nq'|Rule Book|', nq'|規則書 / 规则书|', nq'|Guīzé Shū / Kwāijāk Syū|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Berserk Gene|', 2, q'|Confuses the holder and raises Attack.|', nq'|はかいのいでんし|', nq'|Hakai no Idenshi|', nq'|ADN Berzerk|', nq'|Berserk-Gen|', nq'|Gene Furioso|', nq'|Gen Loco|', nq'|파괴의유전자|', nq'|Pagoe-ui Yujeonja|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Absorb Bulb|', 5, q'|Raises the holder's Special Attack after being hit by a Water-type attack. Consumed after use.|', nq'|きゅうこん|', nq'|Kyūkon|', nq'|Bulbe|', nq'|Knolle|', nq'|Bulbo|', nq'|Tubérculo|', nq'|구근|', nq'|Gugeun|', nq'|球根|', nq'|Qiúgēn / Kàuhgān|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Water Gem|', 5, q'|Increases the power of the holder's first Water-type move by 50%, and is consumed after use.|', nq'|みずのジュエル|', nq'|Mizu no Jewel|', nq'|Joyau Eau|', nq'|Wasserjuwel|', nq'|Bijouacqua|', nq'|Gema Agua|', nq'|물주얼|', nq'|Mul Jewel|', nq'|水之寶石 / 水之宝石|', nq'|Shuǐ-zhī Bǎoshí / Séui-jī Bóusehk|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Storage Key|', 3, q'|Allows a door to be opened on the Abandoned ShipRSE or the storage hold on the Sea MauvilleORAS.|', nq'|そうこのカギ|', nq'|Sōko no Kagi|', nq'|Clé Stockage|', nq'|Lagerschlüssel|', nq'|Chiave magazzino|', nq'|Llave Almacén|', nq'|창고열쇠|', nq'|Changgo Yeolsoe|', nq'|倉庫鑰匙 / 仓库钥匙|', nq'|Cāngkù Yàoshi / Chōngfu Yeuhksìh|', 32);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, STAR)
values(q'|Voice Case 2|', 3, q'|Heals a Poochyena in Agate Village.|', nq'|こえカプセル２|', nq'|Koe Capsule 2|', nq'|Boite Cri 2|', nq'|Stimmbox 2|', nq'|Disco Verso 2|', nq'|Grabación 2|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Elixir|', 1, q'|Restores 10 PP of each move of a Pokémon.|', nq'|ピーピーエイダー|', nq'|PP Aider|', nq'|Elixir|', nq'|Elixier|', nq'|Elisir|', nq'|Elixir|', nq'|PP에이더|', nq'|PP Aider|', nq'|ＰＰ多項小補劑 / ＰＰ多项小补剂|', nq'|PP Duōxiàng Xiǎobǔjì / PP Dōhohng Síubóujaih|', 1024);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Blue Shard|', 3, q'|Exchangeable for a variety of services.|', nq'|あおいかけら|', nq'|Aoi Kakera|', nq'|Tesson Bleu|', nq'|Indigostück|', nq'|Coccio Blu|', nq'|Parte Azul|', nq'|파랑조각|', nq'|Parang Jogak|', nq'|藍色碎片 / 蓝色碎片|', nq'|Lánsè Suìpiàn / Làahmsīk Seuipin|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Relic Statue|', 5, q'|Can be sold for 200000 to the villa owner in Undella Town.|', nq'|こだいのせきぞう|', nq'|Kodai no Sekizō|', nq'|Vieux Santon|', nq'|Alte Statue|', nq'|Statuantica|', nq'|Efigie Antigua|', nq'|고대의석상|', nq'|Godae-yi Seoksang|', nq'|古代石像|', nq'|Gǔdài Shíxiàng / Gúdoih Sehkjeuhng|', 16);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Hondew Berry|', 3, q'|Lowers Special Attack EV, but raises friendship.|', nq'|ロメのみ|', nq'|Rome no Mi|', nq'|Baie Lonme|', nq'|Honmelbeere|', nq'|Baccamelon|', nq'|Baya Meluce|', nq'|로매열매|', nq'|Lome Yeolmae|', nq'|哈密果|', nq'|Hāmì Guǒ / Hāmaht Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Pecha Berry|', 3, q'|Cures poison.|', nq'|モモンのみ|', nq'|Momon no Mi|', nq'|Baie Pecha|', nq'|Pirsifbeere|', nq'|Baccapesca|', nq'|Baya Meloc|', nq'|복슝열매|', nq'|Boksyung Yeolmae|', nq'|桃桃果|', nq'|Táotáo Guǒ / Tòuhtòuh Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Light Ball|', 2, q'|Raises the Attack and Special Attack of Pikachu.|', nq'|でんきだま|', nq'|Denki Dama|', nq'|Ballelumiere|', nq'|Kugelblitz|', nq'|Elettropalla|', nq'|Bolaluminosa|', nq'|전기구슬|', nq'|Jeon-gi Guseul|', nq'|電氣球 / 电气球|', nq'|Diàn Qìqiú / Dihn Heikàuh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Icicle Plate|', 4, q'|Raises the power of Ice-type moves.|', nq'|つららのプレート|', nq'|Tsurara no Purēto|', nq'|Plaque Glace|', nq'|Frosttafel|', nq'|Lastragelo|', nq'|Tabla Helada|', nq'|고드름플레이트|', nq'|Godeureum Plate|', nq'|冰柱石板|', nq'|Bīngzhù Shíbǎn / Bīngchyúh Sehkbáan|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Fighting Memory|', 7, q'|Makes Silvally a Fighting-type Pokémon and makes Multi-Attack a Fighting-type move.|', nq'|ファイトメモリ|', nq'|Fight Memory|', nq'|ROM Combat|', nq'|Kampf-Disc|', nq'|ROM Lotta|', nq'|Disco Lucha|', nq'|파이팅메모리|', nq'|Fighting Memory|', nq'|戰鬥記憶碟*|'||chr(10)||nq'|战斗存储碟|', nq'|Zhàndòu Jìyìdié / Jindau Geiyīkdihp*|'||chr(10)||nq'|Zhàndòu Cúnchǔdié|', 3);
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|X Accuracy 3|', 5, q'|Drastically raises a Pokémon's accuracy. Wonder Launcher only.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Sun Stone|', 2, q'|Can be used to evolve Sunkern, Gloom, Cottonee, Petilil, and Helioptile.|', nq'|たいようのいし|', nq'|Taiyō no Ishi|', nq'|Pierre Soleil|', nq'|Sonnenstein|', nq'|Pietrasolare|', nq'|Piedra Solar|', nq'|태양의돌|', nq'|Taeyang-ui Dol|', nq'|日之石|', nq'|Rì-zhī Shí / Yaht-jī Sehk|', 128);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Enigma Berry|', 3, q'|Restores ¼ of a Pokémon's HP after being hit by a super effective.|', nq'|ナゾのみ|', nq'|Nazo no Mi|', nq'|Baie Enigma|', nq'|Enigmabeere|', nq'|Baccaenigma|', nq'|Baya Enigma|', nq'|의문열매|', nq'|Uimun Yeolmae|', nq'|謎芝果 / 谜芝果|', nq'|Mízhī Guǒ / Màihjī Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Red Scarf|', 3, q'|Raises the Cool condition.|', nq'|あかいバンダナ|', nq'|Akai Bandana|', nq'|Foul. Rouge|', nq'|Roter Schal|', nq'|Fascia Rossa|', nq'|Pañuelo Rojo|', nq'|빨강밴드|', nq'|Ppalgang Band|', nq'|紅色頭巾 / 红色头巾|', nq'|Hóng-sè Tóujīn / Hùhng-sīk Tàuhgān|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Cell Battery|', 5, q'|Raises the holder's Attack one stage when hit with an Electric-type attack. Consumed after use.|', nq'|じゅうでんち|', nq'|Jūdenchi|', nq'|Pile|', nq'|Akku|', nq'|Ricaripila|', nq'|Pila|', nq'|충전지|', nq'|Chungjeonji|', nq'|充電電池 / 充电电池|', nq'|Chōngdiàn Diànchí / Chūngdihn Dihnchìh|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Chill Drive|', 5, q'|Makes Techno Blast an Ice-type move when held by Genesect.|', nq'|フリーズカセット|', nq'|Freeze Cassette|', nq'|Module Cryo|', nq'|Gefriermodul|', nq'|Gelomodulo|', nq'|CrioROM|', nq'|프리즈카세트|', nq'|Freeze Cassette|', nq'|冰凍卡帶 / 冰冻卡带|', nq'|Bīngdòng Kǎdài / Bīngdung Kāatdáai|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Unown Report|', 4, q'|Lists the caught Unown forms. Replaces the Unown Mode of Generation II.|', nq'|アンノーンノート|', nq'|Unknown Note|', nq'|Carnet Zarbi|', nq'|Icognitoheft|', nq'|UnownBloc|', nq'|Bloc Unown|', nq'|안농노트|', nq'|Annong Note|', nq'|未知圖騰筆記 / 未知图腾笔记|', nq'|Wèizhītúténg Bǐjì / Meihjītòuhtàhng Bātgei|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Storage Key|', 4, q'|Gives the player access to the Galactic Warehouse in Veilstone City.|', nq'|そうこのカギ|', nq'|Sōko no Kagi|', nq'|Clé Stockage|', nq'|Lagerschlüssel|', nq'|Chiave magazzino|', nq'|Llave Almacén|', nq'|창고열쇠|', nq'|Changgo Yeolsoe|', nq'|倉庫鑰匙 / 仓库钥匙|', nq'|Cāngkù Yàoshi / Chōngfu Yeuhksìh|', 32);
insert into ITEMS(NAME, GEN, DESCRIPTION)
values(q'|X Speed 3|', 5, q'|Drastically raises a Pokémon's Speed. Wonder Launcher only.|');
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Mewtwonite X|', 6, q'|Allows Mewtwo to Mega Evolve into Mega Mewtwo X.|', nq'|ミュウツナイトX|', nq'|Mewtwonite X|', nq'|Mewtwoïte X|', nq'|Mewtunit X|', nq'|Mewtwoite X|', nq'|Mewtwoita X|', nq'|뮤츠나이트X|', nq'|Mewtwonite X|', nq'|超夢進化石X / 超梦进化石X|', nq'|Chāomèng Jìnhuà Shí X / Chīumuhng Jeunfa Sehk X|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR)
values(q'|Rindo Berry|', 4, q'|Reduces damage from a super effective Grass-type move.|', nq'|リンドのみ|', nq'|Rindo no Mi|', nq'|Baie Ratam|', nq'|Grindobeere|', nq'|Baccarindo|', nq'|Baya Tamar|', nq'|린드열매|', nq'|Rind Yeolmae|', nq'|羅子果 / 罗子果|', nq'|Luózi Guǒ / Lòhjí Gwó|', 0);
insert into ITEMS(NAME, GEN, DESCRIPTION, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, STAR)
values(q'|Steel Mail|', 4, q'|Mail with a metallic design. To be held by a Pokémon for delivery.|', nq'|スチールメール|', nq'|Steel Mail|', nq'|Lettre Acier|', nq'|Stahlbrief|', nq'|Mess. Lega|', nq'|Carta Acero|', nq'|스틸메일|', nq'|Steel Mail|', 0);

insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(568, '0x0238', nq'|Battle CD 35|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(370, '0x0172', nq'|TM43|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(916, '0x0394', nq'|Psychic Memory|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(109, '0x006D', nq'|Dawn Stone|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(849, '0x0351', nq'|Ice Stone|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(114, '0x0072', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(12, '0x000C', nq'|Premier Ball|', q'|Poké Balls|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(675, '0x02A3', nq'|Kangaskhanite|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(415, '0x019F', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(725, '0x02D5', nq'|Letter|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(278, '0x0116', nq'|Iron Ball|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(457, '0x01C9', nq'|Contest Pass|', q'|Key items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(69, '0x0045', nq'|PP Up|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(569, '0x0239', nq'|Clever Wing|', q'|Medicine|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(30, '0x001E', nq'|Fresh Water|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(383, '0x017F', nq'|TM56|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(475, '0x01DB', nq'|Card Key|', q'|Key items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(196, '0x00C4', nq'|Kasib Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(859, '0x035B', nq'|???|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(837, '0x0345', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(67, '0x0043', nq'|Calcium|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(483, '0x01E3', nq'|Rainbow Wing|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(272, '0x0110', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(252, '0x00FC', nq'|Up-Grade|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(573, '0x023D', nq'|Plume Fossil|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(85, '0x0055', nq'|Leaf Stone|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(95, '0x005F', nq'|Growth Mulch|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(730, '0x02DA', nq'|Key to Room 1|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(283, '0x011B', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(470, '0x01D6', nq'|Berry Pots|', q'|Key items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(138, '0x008A', nq'|Flame Mail|', q'|Mail|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(100, '0x64', nq'|Teru-sama|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(536, '0x0218', nq'|Enigma Stone|', q'|Key items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(607, '0x025F', nq'|X Sp. Def 6|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(773, '0x0305', nq'|Key Stone|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(648, '0x0288', nq'|Luminous Moss|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(305, '0x0131', nq'|Earth Plate|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(500, '0x01F4', nq'|Park Ball|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(289, '0x0121', nq'|Power Bracer|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(739, '0x02E3', nq'|Contest Costume|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(39, '0x27', nq'|Revive|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(131, '0x83', nq'|Stardust|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(226, '0x00E2', nq'|Deep Sea Tooth|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(64, '0x40', nq'|Max Ether|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(69, '0x0045', nq'|White Flute|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(133, '0x0085', nq'|unknown|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(486, '0x01E6', nq'|Blue Apricorn|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(178, '0x00B2', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(37, '0x0025', nq'|Revival Herb|', q'|Medicine|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(383, '0x017F', nq'|TM56|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(865, '0x0361', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(675, '0x02A3', nq'|Kangaskhanite|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(652, '0x028C', nq'|Rich Mulch|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(199, '0x00C7', nq'|Metal Coat|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(663, '0x0297', nq'|Mewtwonite Y|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(252, '0x00FC', nq'|Up-Grade|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(64, '0x0040', nq'|Protein|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(637, '0x027D', nq'|Dropped Item|', q'|Key items|', q'|Black 2, White 2|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(407, '0x0197', nq'|TM80|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(200, '0x00C8', nq'|Chilan Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(249, '0x00F9', nq'|Charcoal|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(546, '0x0222', nq'|Cell Battery|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(95, '0x005F', nq'|Growth Mulch|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(113, '0x0071', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(945, '0x03B1', nq'|N-Solarizer|', q'|Key items|', q'|Ultra Sun, Ultra Moon|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(26, '0x001A', nq'|Fresh Water|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(348, '0x15C', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(43, '0x002B', nq'|Berry Juice|', q'|Medicine|', 4);
insert into itemIDs(ID, HEX, NAME, GEN)
values(899, '0x0383', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(305, '0x0131', nq'|Earth Plate|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(289, '0x0121', nq'|Power Bracer|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(416, '0x01A0', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(694, '0x02B6', nq'|TM100|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(69, '0x0045', nq'|White Flute|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(37, '0x0025', nq'|Revival Herb|', q'|Medicine|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(742, '0x02E6', nq'|Aqua Suit|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(779, '0x030B', nq'|Electrium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(354, '0x0162', nq'|TM27|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(181, '0x00B5', nq'|Macho Brace|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(523, '0x020B', nq'|Data Card 19|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(821, '0x0335', nq'|Dragonium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(87, '0x57', nq'|Big Mushroom|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(569, '0x0239', nq'|Clever Wing|', q'|Medicine|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(23, '0x0017', nq'|Full Restore|', q'|Medicine|', 4);
insert into itemIDs(ID, HEX, NAME, GEN)
values(214, '0xD6', nq'|TM14|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(30, '0x001E', nq'|Fresh Water|', q'|Medicine|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(422, '0x01A6', nq'|HM03|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(204, '0x00CC', nq'|Hard Stone|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(200, '0x00C8', nq'|Chilan Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(846, '0x034E', nq'|Adrenaline Orb|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(362, '0x016A', nq'|TM35|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(41, '0x29', nq'|Guard Spec.|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(394, '0x018A', nq'|TM67|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(75, '0x004B', nq'|Green Shard|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(74, '0x004A', nq'|Dire Hit|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(134, '0x0086', nq'|Sweet Heart|', q'|Medicine|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(309, '0x0135', nq'|Stone Plate|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(174, '0xAE', nq'|Gold Berry|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(58, '0x003A', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(530, '0x0212', nq'|Voice Case 3|', q'|Key items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(607, '0x025F', nq'|X Sp. Def 6|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(305, '0x0131', nq'|Earth Plate|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(833, '0x0341', nq'|Eevium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(917, '0x0395', nq'|Ice Memory|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(167, '0x00A7', nq'|Belue Berry|', q'|Berries|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(442, '0x01BA', nq'|Town Map|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(412, '0x019C', nq'|TM85|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(289, '0x0121', nq'|Power Bracer|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(474, '0x01DA', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(532, '0x0214', nq'|Jade Orb|', q'|Key items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(341, '0x0155', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(317, '0x013D', nq'|Wave Incense|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(453, '0x01C5', nq'|Lunar Wing|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(38, '0x0026', nq'|Lava Cookie|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(293, '0x0125', nq'|Power Anklet|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(523, '0x020B', nq'|Data Card 19|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(278, '0x0116', nq'|Iron Ball|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(513, '0x0201', nq'|Data Card 09|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(306, '0x0132', nq'|Sky Plate|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(207, '0x00CF', nq'|Starf Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(569, '0x0239', nq'|Clever Wing|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(226, '0x00E2', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(298, '0x012A', nq'|Flame Plate|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(530, '0x0212', nq'|Data Card 26|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(885, '0x0375', nq'|Stretchy Spring|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(897, '0x0381', nq'|???|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(176, '0x00B0', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(268, '0x010C', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(200, '0x00C8', nq'|Chilan Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(122, '0x7A', nq'|Energy Root|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(571, '0x023B', nq'|Pretty Wing|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(216, '0x00D8', nq'|Dragon Fang|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(399, '0x018F', nq'|TM72|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(140, '0x8C', nq'|Scope Lens|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(34, '0x0022', nq'|Ether|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(111, '0x006F', nq'|Odd Keystone|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(452, '0x01C4', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(514, '0x0202', nq'|Data Card 10|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(75, '0x004B', nq'|Green Shard|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(95, '0x005F', nq'|Growth Mulch|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(450, '0x01C2', nq'|Bike|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(660, '0x0294', nq'|Charizardite X|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(106, '0x006A', nq'|Rare Bone|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(607, '0x025F', nq'|X Sp. Def 6|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(305, '0x0131', nq'|Earth Plate|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GEN)
values(235, '0x00EB', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(503, '0x01F7', nq'|F-Disk|', q'|Key items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(442, '0x01BA', nq'|Town Map|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(502, '0x01F6', nq'|Bonsly Card|', q'|Key items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(490, '0x01EA', nq'|Wht Apricorn|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(14, '0x000E', nq'|Antidote|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(91, '0x005B', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(170, '0x00AA', nq'|Kelpsy Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(604, '0x025C', nq'|X Accuracy 3|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(83, '0x0053', nq'|Thunder Stone|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(289, '0x0121', nq'|Power Bracer|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(293, '0x0125', nq'|Power Anklet|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(37, '0x0025', nq'|Revival Herb|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(167, '0x00A7', nq'|Wepear Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(780, '0x030C', nq'|Grassium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(453, '0x01C5', nq'|Lunar Wing|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(210, '0x00D2', nq'|Sharp Beak|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(725, '0x02D5', nq'|Letter|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(16, '0x0010', nq'|Cherish Ball|', q'|Poké Balls|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(530, '0x0212', nq'|Data Card 26|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(411, '0x019B', nq'|TM84|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(663, '0x0297', nq'|Mewtwonite Y|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(79, '0x004F', nq'|X Special|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(218, '0xDA', nq'|TM27|', q'|TMs and HMs|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(200, '0x00C8', nq'|Chilan Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(546, '0x0222', nq'|Cell Battery|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(254, '0x00FE', nq'|Red Scarf|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(75, '0x004B', nq'|Green Shard|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(3, '0x0003', nq'|Great Ball|', q'|Poké Balls|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(507, '0x01FB', nq'|Data Card 03|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(134, '0x0086', nq'|Sweet Heart|', q'|Medicine|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(740, '0x02E4', nq'|Contest Costume|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(693, '0x02B5', nq'|TM99|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(415, '0x019F', nq'|TM88|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, GEN)
values(104, '0x68', nq'|バラバッヂ (RoseBadge - D)|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(910, '0x038E', nq'|Ghost Memory|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(442, '0x01BA', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(307, '0x0133', nq'|TM19|', q'|TMs and HMs|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(151, '0x0097', nq'|Pecha Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(39, '0x0027', nq'|Blue Flute|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(914, '0x0392', nq'|Grass Memory|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(83, '0x0053', nq'|Thunder Stone|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(604, '0x025C', nq'|X Accuracy 3|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(464, '0x01D0', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(262, '0x0106', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(384, '0x0180', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(696, '0x02B8', nq'|Mega Ring|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(583, '0x0247', nq'|Battle CD 50|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(334, '0x014E', nq'|TM07|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(523, '0x020B', nq'|Data Card 19|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(389, '0x0185', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(12, '0x000C', nq'|Premier Ball|', q'|Poké Balls|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(453, '0x01C5', nq'|Lunar Wing|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(18, '0x0012', nq'|Antidote|', q'|Medicine|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(724, '0x02D4', nq'|Pokéblock Kit|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(236, '0x00EC', nq'|Light Ball|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(32, '0x0020', nq'|Heal Powder|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(16, '0x0010', nq'|Cherish Ball|', q'|Poké Balls|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(444, '0x01BC', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(231, '0x00E7', nq'|Lucky Egg|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(185, '0x00B9', nq'|Passho Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(530, '0x0212', nq'|Data Card 26|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(940, '0x03AC', nq'|Purple Petal|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(832, '0x0340', nq'|Snorlium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(291, '0x0123', nq'|Power Lens|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(241, '0xF1', nq'|TM41|', 1);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(978, '0x03D2', nq'|Bulbasaur Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(472, '0x01D8', nq'|Blue Card|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(327, '0x0147', nq'|TM39|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(185, '0x00B9', nq'|Passho Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(11, '0x0B', nq'|Antidote|', 1);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(123, '0x007B', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(448, '0x01C0', nq'|Sprayduck|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(126, '0x7E', nq'|Lucky Egg|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(229, '0xE5', nq'|TM37|', q'|TMs and HMs|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(106, '0x006A', nq'|Rare Bone|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(723, '0x02D3', nq'|Basement Key|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(442, '0x01BA', nq'|Town Map|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(243, '0x00F3', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(531, '0x0213', nq'|Data Card 27|', q'|Items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(226, '0x00E2', nq'|Deep Sea Tooth|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(126, '0x007E', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(482, '0x01E2', nq'|Silver Wing|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(472, '0x01D8', nq'|Blue Card|', q'|Key items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(53, '0x0035', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(757, '0x02F5', nq'|Audinite|', q'|Items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(250, '0x00FA', nq'|Dragon Fang|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(317, '0x013D', nq'|Wave Incense|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(299, '0x012B', nq'|TM11|', q'|TMs and HMs|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(696, '0x02B8', nq'|Mega Ring|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(942, '0x03AE', nq'|Surge Badge|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(285, '0x011D', nq'|Damp Rock|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(5, '0x0005', nq'|Safari Ball|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(859, '0x035B', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(325, '0x0145', nq'|TM37|', q'|TMs and HMs|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(293, '0x0125', nq'|Power Anklet|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(18, '0x0012', nq'|Antidote|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(985, '0x03D9', nq'|Spearow Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(278, '0x0116', nq'|Iron Ball|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(234, '0x00EA', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(12, '0x000C', nq'|Premier Ball|', q'|Poké Balls|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(236, '0x00EC', nq'|Light Ball|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(26, '0x001A', nq'|Super Potion|', q'|Medicine|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(120, '0x0078', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1008, '0x03F0', nq'|Geodude Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(341, '0x0155', nq'|TM14|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(185, '0x00B9', nq'|Passho Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(602, '0x025A', nq'|X Defense 3|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(344, '0x0158', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(760, '0x02F8', nq'|Slowbronite|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(158, '0x009E', nq'|Tamato Berry|', q'|Berries|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(343, '0x0157', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(460, '0x01CC', nq'|Coupon 1|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(563, '0x0233', nq'|Steel Gem|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(234, '0x00EA', nq'|Leftovers|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(546, '0x0222', nq'|Cell Battery|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(738, '0x02E2', nq'|Devon Scuba Gear|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(143, '0x008F', nq'|Figy Berry|', q'|Berries|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(527, '0x020F', nq'|Krane Memo 5|', q'|Key items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(578, '0x0242', nq'|Battle CD 45|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(480, '0x01E0', nq'|Pass|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(413, '0x019D', nq'|TM86|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(473, '0x01D9', nq'|SlowpokeTail|', q'|Key items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, GEN)
values(197, '0xC5', nq'|HM02|', 1);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(373, '0x0175', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(136, '0x0088', nq'|Lustrous Orb|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(274, '0x0112', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(206, '0x00CE', nq'|BlackGlasses|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(496, '0x01F0', nq'|Love Ball|', q'|Poké Balls|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(400, '0x0190', nq'|TM73|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(250, '0x00FA', nq'|Dragon Fang|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GEN)
values(867, '0x0363', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(585, '0x0249', nq'|Relic Silver|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(388, '0x0184', nq'|TM61|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(247, '0xF7', nq'|TM47|', 1);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(57, '0x0039', nq'|X Attack|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(298, '0x012A', nq'|TM10|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(884, '0x0374', nq'|Grassy Seed|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(18, '0x0012', nq'|Antidote|', q'|Medicine|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(481, '0x01E1', nq'|Machine Part|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(208, '0x00D0', nq'|Enigma Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(236, '0x00EC', nq'|Light Ball|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(773, '0x0305', nq'|Key Stone|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(24, '0x0018', nq'|Max Potion|', q'|Medicine|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(185, '0x00B9', nq'|Passho Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(548, '0x0224', nq'|Fire Gem|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(370, '0x0172', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(319, '0x013F', nq'|TM31|', q'|TMs and HMs|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(139, '0x008B', nq'|Oran Berry|', q'|Berries|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(460, '0x01CC', nq'|Coupon 1|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(467, '0x01D3', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(90, '0x005A', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(389, '0x0185', nq'|TM62|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(364, '0x016C', nq'|TM37|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(309, '0x0135', nq'|Stone Plate|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(41, '0x0029', nq'|Red Flute|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(210, '0x00D2', nq'|Sharp Beak|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(215, '0xD7', nq'|TM15|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(422, '0x01A6', nq'|HM03|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(463, '0x01CF', nq'|Storage Key|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(250, '0x00FA', nq'|Dragon Fang|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(84, '0x54', nq'|B2F (G)|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(713, '0x02C9', nq'|Bike|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(317, '0x013D', nq'|Wave Incense|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(62, '0x003E', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(185, '0x00B9', nq'|Mental Herb|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(585, '0x0249', nq'|Relic Silver|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(369, '0x0171', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(520, '0x0208', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(301, '0x012D', nq'|TM13|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(483, '0x01E3', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(473, '0x01D9', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(160, '0x00A0', nq'|Magost Berry|', q'|Berries|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(158, '0x009E', nq'|Sitrus Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(174, '0x00AE', nq'|Tamato Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(208, '0x00D0', nq'|Enigma Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(236, '0x00EC', nq'|Light Ball|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(332, '0x014C', nq'|TM05|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(370, '0x0172', nq'|MysticTicket|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(548, '0x0224', nq'|Fire Gem|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(11, '0x000B', nq'|Luxury Ball|', q'|Poké Balls|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(272, '0x0110', nq'|Toxic Orb|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(185, '0x00B9', nq'|Passho Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(122, '0x007A', nq'|Medicine Pocket|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(324, '0x0144', nq'|TM36|', q'|TMs and HMs|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(125, '0x007D', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(580, '0x0244', nq'|Balm Mushroom|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(224, '0xE0', nq'|TM32|', q'|TMs and HMs|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(234, '0x00EA', nq'|Leftovers|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(36, '0x24', nq'|Protein|', 1);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(641, '0x0281', nq'|Holo Caster|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1001, '0x03E9', nq'|Mankey Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(718, '0x02CE', nq'|Mach Bike|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(626, '0x0272', nq'|Xtransceiver|', q'|Key items|', q'|Black 2, White 2|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(905, '0x0389', nq'|Flying Memory|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(136, '0x0088', nq'|Lustrous Orb|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(316, '0x013C', nq'|Full Incense|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(154, '0x009A', nq'|Leppa Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(317, '0x013D', nq'|Wave Incense|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(293, '0x0125', nq'|Power Anklet|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(250, '0x00FA', nq'|Dragon Fang|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(5, '0x0005', nq'|Safari Ball|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(447, '0x01BF', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1004, '0x03EC', nq'|Abra Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(158, '0x009E', nq'|Sitrus Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(801, '0x0321', nq'|Tapunium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(83, '0x53', nq'|Bitter Berry|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(208, '0x00D0', nq'|Enigma Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(803, '0x0323', nq'|Aloraichium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(464, '0x01D0', nq'|Secret Potion|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(548, '0x0224', nq'|Fire Gem|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(30, '0x001E', nq'|EnergyPowder|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(11, '0x000B', nq'|Luxury Ball|', q'|Poké Balls|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(845, '0x034D', nq'|Sparkling Stone|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(272, '0x0110', nq'|Toxic Orb|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(480, '0x01E0', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(222, '0x00DE', nq'|Lucky Punch|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(51, '0x0033', nq'|Green Shard|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(254, '0x00FE', nq'|Sea Incense|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(316, '0x013C', nq'|Full Incense|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(129, '0x0081', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(234, '0x00EA', nq'|Leftovers|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(90, '0x5A', nq'|Teru-sama|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(758, '0x02F6', nq'|Metagrossite|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(396, '0x018C', nq'|TM69|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(309, '0x0135', nq'|Stone Plate|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(526, '0x020E', nq'|DNA Sample|', q'|Key items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(18, '0x12', nq'|Hyper Potion|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(227, '0x00E3', nq'|DeepSeaScale|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(325, '0x0145', nq'|Reaper Cloth|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(593, '0x0251', nq'|X Speed 2|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(6, '0x0006', nq'|Net Ball|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(222, '0x00DE', nq'|SilverPowder|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(493, '0x01ED', nq'|Level Ball|', q'|Poké Balls|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(491, '0x01EB', nq'|Black Apricorn|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(136, '0x0088', nq'|Lustrous Orb|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(667, '0x029B', nq'|Aggronite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(471, '0x01D7', nq'|Dowsing Machine|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(189, '0xBD', nq'|Mirage Mail|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(488, '0x01E8', nq'|Green Apricorn|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(316, '0x013C', nq'|Full Incense|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(341, '0x0155', nq'|TM14|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(338, '0x0152', nq'|TM11|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(283, '0x011B', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(25, '0x0019', nq'|Max Revive|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(541, '0x021D', nq'|Air Balloon|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(250, '0x00FA', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(143, '0x008F', nq'|Reply Mail|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(158, '0x009E', nq'|Sitrus Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(464, '0x01D0', nq'|Secret Potion|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(206, '0x00CE', nq'|Lansat Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(313, '0x0139', nq'|Iron Plate|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(280, '0x0118', nq'|Destiny Knot|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(50, '0x0032', nq'|Yellow Shard|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(466, '0x01D2', nq'|Gracidea|', q'|Key items|', q'|Platinum, HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(254, '0x00FE', nq'|Sea Incense|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(221, '0x00DD', nq'|King's Rock|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(515, '0x0203', nq'|Data Card 11|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(525, '0x020D', nq'|DNA Sample|', q'|Key items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(112, '0x0070', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(6, '0x0006', nq'|Net Ball|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(325, '0x0145', nq'|Reaper Cloth|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(233, '0xE9', nq'|TM41|', q'|TMs and HMs|', 2);
insert into itemIDs(ID, HEX, NAME, GEN)
values(0, '0x0000', nq'|Nothing|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(474, '0x01DA', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(222, '0x00DE', nq'|SilverPowder|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(98, '0x62', nq'|Blackbelt|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(293, '0x0125', nq'|TM05|', q'|TMs and HMs|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(445, '0x01BD', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(462, '0x01CE', nq'|Coupon 3|', q'|Key items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(273, '0x0111', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(676, '0x02A4', nq'|Gyaradosite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(65, '0x0041', nq'|Iron|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(227, '0xE3', nq'|TM27|', 1);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(315, '0x013B', nq'|Rock Incense|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(186, '0x00BA', nq'|Choice Band|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(555, '0x022B', nq'|Ground Gem|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(23, '0x17', nq'|ThunderBadge|', 1);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(367, '0x016F', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(316, '0x013C', nq'|Full Incense|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(338, '0x0152', nq'|TM11|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(206, '0x00CE', nq'|BlackGlasses|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(192, '0x00C0', nq'|DeepSeaTooth|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(739, '0x02E3', nq'|Contest Costume|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(341, '0x0155', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(143, '0x008F', nq'|Reply Mail|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(401, '0x0191', nq'|TM74|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(125, '0x007D', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(112, '0x0070', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(504, '0x01F8', nq'|RageCandyBar|', q'|Key items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(197, '0x00C5', nq'|Lucky Egg|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(280, '0x0118', nq'|Destiny Knot|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(234, '0x00EA', nq'|Leftovers|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(221, '0x00DD', nq'|King's Rock|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(867, '0x0363', nq'|???|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(880, '0x0370', nq'|Protective Pads|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(503, '0x01F7', nq'|Tidal Bell|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(221, '0xDD', nq'|TM29|', q'|TMs and HMs|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(515, '0x0203', nq'|Data Card 11|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(120, '0x0078', nq'|???|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(188, '0xBC', nq'|Music Mail|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(141, '0x008D', nq'|Inquiry Mail|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(107, '0x006B', nq'|Big Pearl|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(315, '0x013B', nq'|TM27|', q'|TMs and HMs|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(479, '0x01DF', nq'|Lost Item|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(376, '0x0178', nq'|TM49|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(749, '0x02ED', nq'|Mega Tiara|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(136, '0x0088', nq'|Lustrous Orb|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(151, '0x0097', nq'|Pecha Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(1, '0x01', nq'|Master Ball|', q'|Poké Balls|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(137, '0x0089', nq'|Aspear Berry|', q'|Berries|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(42, '0x002A', nq'|Lava Cookie|', q'|Medicine|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(50, '0x0032', nq'|Yellow Shard|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(643, '0x0283', nq'|Roller Skates|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(462, '0x01CE', nq'|Coupon 3|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(56, '0x0038', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(162, '0xA2', nq'|Teru-sama|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(133, '0x85', nq'|Basement Key|', q'|Key items|', 2);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(895, '0x037F', nq'|Leaf Letter|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(239, '0x00EF', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(53, '0x0035', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(258, '0x0102', nq'|Thick Club|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(806, '0x0326', nq'|Mewnium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(549, '0x0225', nq'|Battle CD 16|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(143, '0x008F', nq'|Reply Mail|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(344, '0x0158', nq'|TM17|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1038, '0x040E', nq'|Electabuzz Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(206, '0x00CE', nq'|Lansat Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(121, '0x0079', nq'|Pokémon Box|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(345, '0x0159', nq'|TM18|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(20, '0x0014', nq'|Ice Heal|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(48, '0x0030', nq'|Carbos|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(117, '0x0075', nq'|Shock Drive|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1039, '0x040F', nq'|Pinsir Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(700, '0x02BC', nq'|Elevator Key|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(157, '0x009D', nq'|Grepa Berry|', q'|Berries|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(369, '0x0171', nq'|Tea|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(574, '0x023E', nq'|Liberty Pass|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(404, '0x0194', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(651, '0x028B', nq'|Poké Flute|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(326, '0x0146', nq'|Razor Claw|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(325, '0x0145', nq'|Reaper Cloth|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(376, '0x0178', nq'|TM49|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(125, '0x007D', nq'|Wood Mail|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(700, '0x02BC', nq'|Elevator Key|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(309, '0x0135', nq'|Stone Plate|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(286, '0x011E', nq'|Root Fossil|', q'|Key items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(195, '0x00C3', nq'|Charti Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(37, '0x0025', nq'|Revival Herb|', q'|Medicine|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(462, '0x01CE', nq'|Coupon 3|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(485, '0x01E5', nq'|Red Apricorn|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(245, '0x00F5', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(56, '0x0038', nq'|Dire Hit|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(341, '0x0155', nq'|TM14|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(604, '0x025C', nq'|X Accuracy 3|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(579, '0x0243', nq'|Dragon Skull|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(353, '0x0161', nq'|Gold Teeth|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(325, '0x0145', nq'|TM37|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(621, '0x026D', nq'|Xtransceiver|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(179, '0x00B3', nq'|BrightPowder|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(447, '0x01BF', nq'|Super Rod|', q'|Key items|', 4);
insert into itemIDs(ID, HEX, NAME, GEN)
values(122, '0x007A', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(5, '0x0005', nq'|Safari Ball|', q'|Poké Balls|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(142, '0x008E', nq'|Like Mail|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(85, '0x0055', nq'|Escape Rope|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(28, '0x001C', nq'|Lemonade|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(230, '0x00E6', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(102, '0x66', nq'|BlackGlasses|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, GEN)
values(10, '0x0A', nq'|Moon Stone|', 1);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(961, '0x03C1', nq'|Mighty Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(236, '0xEC', nq'|TM36|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(206, '0x00CE', nq'|Lansat Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(345, '0x0159', nq'|TM18|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(542, '0x021E', nq'|Red Card|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(580, '0x0244', nq'|Balm Mushroom|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(799, '0x031F', nq'|Incinium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(956, '0x03BC', nq'|Roto HP Restore|', q'|Ultra Sun, Ultra Moon|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(318, '0x013E', nq'|Rose Incense|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(365, '0x016D', nq'|TM38|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(221, '0x00DD', nq'|King's Rock|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(20, '0x0014', nq'|Ice Heal|', q'|Medicine|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(106, '0x006A', nq'|Pearl|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(518, '0x0206', nq'|Data Card 14|', q'|Items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(77, '0x004D', nq'|X Speed|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(515, '0x0203', nq'|Data Card 11|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(533, '0x0215', nq'|Lock Capsule|', q'|Key items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(643, '0x0283', nq'|Roller Skates|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(493, '0x01ED', nq'|Level Ball|', q'|Poké Balls|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(410, '0x019A', nq'|TM83|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(233, '0x00E9', nq'|Metal Coat|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(66, '0x0042', nq'|Yellow Flute|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(237, '0x00ED', nq'|Soft Sand|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(187, '0x00BB', nq'|Rindo Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(462, '0x01CE', nq'|Coupon 3|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(720, '0x02D0', nq'|Wailmer Pail|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(767, '0x02FF', nq'|Cameruptite|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(621, '0x026D', nq'|Xtransceiver|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(55, '0x0037', nq'|Guard Spec.|', q'|Battle items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(149, '0x0095', nq'|Bluk Berry|', q'|Berries|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(579, '0x0243', nq'|Dragon Skull|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(403, '0x0193', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(874, '0x036A', nq'|Silph Scope|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(779, '0x030B', nq'|Electrium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(648, '0x0288', nq'|Luminous Moss|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(150, '0x0096', nq'|Nanab Berry|', q'|Berries|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(314, '0x013A', nq'|TM26|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(528, '0x0210', nq'|Data Card 24|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(84, '0x0054', nq'|Max Repel|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(184, '0x00B8', nq'|Soothe Bell|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(816, '0x0330', nq'|Flyinium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(312, '0x0138', nq'|Dread Plate|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(383, '0x017F', nq'|TM56|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(339, '0x0153', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(879, '0x036F', nq'|Terrain Extender|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(345, '0x0159', nq'|TM18|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(20, '0x0014', nq'|Ice Heal|', q'|Medicine|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(102, '0x0066', nq'|Dome Fossil|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(516, '0x0204', nq'|Data Card 12|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(937, '0x03A9', nq'|Red Petal|', q'|Key items|', q'|Ultra Sun, Ultra Moon|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(2, '0x0002', nq'|Ultra Ball|', q'|Poké Balls|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(318, '0x013E', nq'|Rose Incense|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(1, '0x0001', nq'|Master Ball|', q'|Poké Balls|', 5);
insert into itemIDs(ID, HEX, NAME, GEN)
values(897, '0x0381', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(334, '0x014E', nq'|TM07|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(915, '0x0393', nq'|Electric Memory|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(410, '0x019A', nq'|TM83|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(593, '0x0251', nq'|X Speed 2|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(598, '0x0256', nq'|X Accuracy 2|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(233, '0x00E9', nq'|Metal Coat|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(777, '0x0309', nq'|Firium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(25, '0x0019', nq'|Hyper Potion|', q'|Medicine|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(162, '0x00A2', nq'|Nomel Berry|', q'|Berries|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(367, '0x016F', nq'|TM40|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(99, '0x63', nq'|Blk Apricorn|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(349, '0x015D', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(404, '0x0194', nq'|TM77|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(91, '0x005B', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(145, '0x0091', nq'|Mago Berry|', q'|Berries|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(239, '0x00EF', nq'|Miracle Seed|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(441, '0x01B9', nq'|Red Chain|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(158, '0x009E', nq'|Sitrus Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(403, '0x0193', nq'|TM76|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(206, '0x00CE', nq'|Lansat Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(150, '0x0096', nq'|Chesto Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(101, '0x0065', nq'|Helix Fossil|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(363, '0x016B', nq'|TM36|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(20, '0x0014', nq'|Ice Heal|', q'|Medicine|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(619, '0x026B', nq'|TM94|', q'|TMs and HMs|', q'|X, Y|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(148, '0x0094', nq'|Bridge Mail M|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(606, '0x025E', nq'|X Sp. Atk 6|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(466, '0x01D2', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(588, '0x024C', nq'|Relic Band|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(450, '0x01C2', nq'|Bicycle|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(598, '0x0256', nq'|X Accuracy 2|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(332, '0x014C', nq'|TM05|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(325, '0x0145', nq'|Reaper Cloth|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(233, '0x00E9', nq'|Metal Coat|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(391, '0x0187', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(361, '0x0169', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(114, '0x0072', nq'|???|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(179, '0x00B3', nq'|Spelon Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(383, '0x017F', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(45, '0x002D', nq'|Sacred Ash|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(765, '0x02FD', nq'|Prison Bottle|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(626, '0x0272', nq'|Xtransceiver|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(225, '0x00E1', nq'|Stick|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(342, '0x0156', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(264, '0x0108', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(570, '0x023A', nq'|Swift Wing|', q'|Medicine|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(928, '0x03A0', nq'|Lunalium Z|', q'|Z-Crystals|', q'|Ultra Sun, Ultra Moon|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(541, '0x021D', nq'|Air Balloon|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(401, '0x0191', nq'|TM74|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(480, '0x01E0', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(260, '0x0104', nq'|Coin Case|', q'|Key items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(90, '0x005A', nq'|Stardust|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(136, '0x0088', nq'|Rawst Berry|', q'|Berries|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(280, '0x0118', nq'|Destiny Knot|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(306, '0x0132', nq'|TM18|', q'|TMs and HMs|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(284, '0x011C', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(370, '0x0172', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(448, '0x01C0', nq'|Sprayduck|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(957, '0x03BD', nq'|Roto PP Restore|', q'|Ultra Sun, Ultra Moon|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(401, '0x0191', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(575, '0x023F', nq'|Pass Orb|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(32, '0x0020', nq'|Heal Powder|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(148, '0x0094', nq'|Bridge Mail M|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(593, '0x0251', nq'|X Speed 2|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(481, '0x01E1', nq'|Machine Part|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(250, '0x00FA', nq'|Dragon Fang|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(233, '0x00E9', nq'|Metal Coat|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(924, '0x039C', nq'|Mimikium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(28, '0x001C', nq'|Revive|', q'|Medicine|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(706, '0x02C2', nq'|Makeup Bag|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(92, '0x005C', nq'|Nugget|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(87, '0x57', nq'|2F (G)|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(738, '0x02E2', nq'|Devon Scuba Gear|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(314, '0x013A', nq'|Odd Incense|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1034, '0x040A', nq'|Staryu Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(697, '0x02B9', nq'|Intriguing Stone|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(749, '0x02ED', nq'|Mega Tiara|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(344, '0x0158', nq'|HM06|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(602, '0x025A', nq'|X Defense 3|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(441, '0x01B9', nq'|Red Chain|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(904, '0x0388', nq'|Fighting Memory|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(562, '0x0232', nq'|Dark Gem|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(931, '0x03A3', nq'|Lycanium Z|', q'|Z-Crystals|', q'|Ultra Sun, Ultra Moon|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(138, '0x008A', nq'|Leppa Berry|', q'|Berries|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(541, '0x021D', nq'|Air Balloon|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(570, '0x023A', nq'|Swift Wing|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(90, '0x005A', nq'|Stardust|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(280, '0x0118', nq'|Destiny Knot|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(197, '0x00C5', nq'|Haban Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(245, '0x00F5', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(182, '0x00B6', nq'|Durin Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(456, '0x01C8', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(366, '0x016E', nq'|TM39|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(588, '0x024C', nq'|Relic Band|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(619, '0x026B', nq'|TM94|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(582, '0x0246', nq'|Pearl String|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(598, '0x0256', nq'|X Accuracy 2|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(187, '0x00BB', nq'|King's Rock|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(381, '0x017D', nq'|TM54|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(73, '0x49', nq'|Poké Flute|', 1);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(520, '0x0208', nq'|Data Card 16|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(326, '0x0146', nq'|Razor Claw|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(369, '0x0171', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(485, '0x01E5', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(643, '0x0283', nq'|Roller Skates|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(54, '0x0036', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(314, '0x013A', nq'|Odd Incense|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(995, '0x03E3', nq'|Oddish Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(435, '0x01B3', nq'|Fashion Case|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, GEN)
values(238, '0xEE', nq'|TM38|', 1);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(259, '0x0103', nq'|Stick|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(441, '0x01B9', nq'|Red Chain|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(602, '0x025A', nq'|X Defense 3|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(375, '0x0177', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(949, '0x03B5', nq'|Roto Hatch|', q'|Ultra Sun, Ultra Moon|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(666, '0x029A', nq'|Houndoominite|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(882, '0x0372', nq'|Psychic Seed|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(345, '0x0159', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(150, '0x0096', nq'|Chesto Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(260, '0x0104', nq'|Red Scarf|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(401, '0x0191', nq'|TM74|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(570, '0x023A', nq'|Swift Wing|', q'|Medicine|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(31, '0x1F', nq'|Calcium|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(90, '0x005A', nq'|Stardust|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(89, '0x0059', nq'|Big Pearl|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(438, '0x01B6', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(295, '0x0127', nq'|TM07|', q'|TMs and HMs|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(135, '0x0087', nq'|Pecha Berry|', q'|Berries|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(505, '0x01F9', nq'|Data Card 01|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(43, '0x002B', nq'|Berry Juice|', q'|Medicine|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(311, '0x0137', nq'|Draco Plate|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(31, '0x001F', nq'|Energy Root|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(113, '0x0071', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(89, '0x0059', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(366, '0x016E', nq'|TM39|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1037, '0x040D', nq'|Jynx Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(582, '0x0246', nq'|Pearl String|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(231, '0x00E7', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(227, '0x00E3', nq'|DeepSeaScale|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(633, '0x0279', nq'|Plasma Card|', q'|Key items|', q'|Black 2, White 2|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(588, '0x024C', nq'|Relic Band|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(342, '0x0156', nq'|TM15|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(606, '0x025E', nq'|X Sp. Atk 6|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(700, '0x02BC', nq'|Elevator Key|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(463, '0x01CF', nq'|Storage Key|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(71, '0x47', nq'|Itemfinder|', 1);
insert into itemIDs(ID, HEX, NAME, GEN)
values(3, '0x03', nq'|Great Ball|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(326, '0x0146', nq'|Razor Claw|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(203, '0x00CB', nq'|Salac Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(376, '0x0178', nq'|TM49|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(639, '0x027F', nq'|Weakness Policy|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(605, '0x025D', nq'|X Speed 6|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(515, '0x0203', nq'|DNA Sample|', q'|Key items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(612, '0x0264', nq'|Item Drop|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(917, '0x0395', nq'|Ice Memory|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(365, '0x016D', nq'|Berry Pouch|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(537, '0x0219', nq'|Prism Scale|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(166, '0x00A6', nq'|Durin Berry|', q'|Berries|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(106, '0x006A', nq'|Pearl|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(351, '0x015F', nq'|Secret Key|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(61, '0x003D', nq'|X Sp. Atk|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(510, '0x01FE', nq'|Data Card 06|', q'|Items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(681, '0x02A9', nq'|Mawilite|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(399, '0x018F', nq'|TM72|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(678, '0x02A6', nq'|Charizardite Y|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(202, '0xCA', nq'|TM02|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(834, '0x0342', nq'|Mewnium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(728, '0x02D8', nq'|Go-Goggles|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(202, '0x00CA', nq'|Ganlon Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(458, '0x01CA', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(336, '0x0150', nq'|TM48|', q'|TMs and HMs|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(342, '0x0156', nq'|TM15|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(448, '0x01C0', nq'|Sprayduck|', q'|Key items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(124, '0x007C', nq'|Candy Jar|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(446, '0x01BE', nq'|Good Rod|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(507, '0x01FB', nq'|Data Card 03|', q'|Items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(128, '0x0080', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(582, '0x0246', nq'|Pearl String|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(245, '0x00F5', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(205, '0xCD', nq'|TM14|', q'|TMs and HMs|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(915, '0x0393', nq'|Electric Memory|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(605, '0x025D', nq'|X Speed 6|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(374, '0x0176', nq'|Sapphire (item)|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(326, '0x0146', nq'|Razor Claw|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(144, '0x0090', nq'|BridgeMail S|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(738, '0x02E2', nq'|Devon Scuba Gear|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(203, '0x00CB', nq'|Salac Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(537, '0x0219', nq'|Prism Scale|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GEN)
values(200, '0xC8', nq'|HM05|', 1);
insert into itemIDs(ID, HEX, NAME, GEN)
values(207, '0xCF', nq'|TM07|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(28, '0x001C', nq'|Revive|', q'|Medicine|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(435, '0x01B3', nq'|Fashion Case|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(101, '0x0065', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(141, '0x008D', nq'|Lum Berry|', q'|Berries|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(681, '0x02A9', nq'|Mawilite|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(403, '0x0193', nq'|TM76|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(214, '0x00D6', nq'|White Herb|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(94, '0x005E', nq'|Moon Stone|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(312, '0x0138', nq'|Dread Plate|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(144, '0x0090', nq'|Bridge Mail S|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(149, '0x95', nq'|Teru-sama|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(89, '0x0059', nq'|Big Pearl|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(107, '0x006B', nq'|Shiny Stone|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(1, '0x0001', nq'|Master Ball|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(331, '0x014B', nq'|TM04|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(572, '0x023C', nq'|Cover Fossil|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(354, '0x0162', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(99, '0x0063', nq'|Root Fossil|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(153, '0x0099', nq'|Pomeg Berry|', q'|Berries|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(366, '0x016E', nq'|TM39|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(36, '0x0024', nq'|Heal Powder|', q'|Medicine|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(201, '0x00C9', nq'|Dragon Scale|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(537, '0x0219', nq'|Battle CD 04|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(854, '0x0356', nq'|Yellow Nectar|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(141, '0x008D', nq'|Inquiry Mail|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(100, '0x0064', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(259, '0x0103', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(147, '0x0093', nq'|Iapapa Berry|', q'|Berries|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(40, '0x0028', nq'|Yellow Flute|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(203, '0x00CB', nq'|Salac Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(145, '0x0091', nq'|Bridge Mail D|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(221, '0x00DD', nq'|Lax Incense|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(246, '0x00F6', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(861, '0x035D', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(67, '0x0043', nq'|Calcium|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(411, '0x019B', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(713, '0x02C9', nq'|Bicycle|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(403, '0x0193', nq'|TM76|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(891, '0x037B', nq'|Silver Leaf|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(533, '0x0215', nq'|Red ID Badge|', q'|Key items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(674, '0x02A2', nq'|Abomasite|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(825, '0x0339', nq'|Pikanium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(338, '0x0152', nq'|TM11|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(145, '0x0091', nq'|Mago Berry|', q'|Berries|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(55, '0x0037', nq'|Guard Spec.|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(312, '0x0138', nq'|Dread Plate|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(491, '0x01EB', nq'|Blk Apricorn|', q'|Items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(1, '0x0001', nq'|Master Ball|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(166, '0x00A6', nq'|Durin Berry|', q'|Berries|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(89, '0x0059', nq'|Big Pearl|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(339, '0x0153', nq'|TM12|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(693, '0x02B5', nq'|TM99|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(101, '0x0065', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(458, '0x01CA', nq'|Magma Stone|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, GEN)
values(115, '0x73', nq'|マスター (Master - D)|', 1);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(705, '0x02C1', nq'|Lens Case|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(11, '0x0B', nq'|Ice Heal|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(66, '0x0042', nq'|Carbos|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(274, '0x0112', nq'|Letter|', q'|Key items|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(466, '0x01D2', nq'|Gracidea|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(230, '0xE6', nq'|TM30|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(511, '0x01FF', nq'|Down St. Key|', q'|Key items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(933, '0x03A5', nq'|Z-Power Ring|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(463, '0x01CF', nq'|Storage Key|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(172, '0x00AC', nq'|Hondew Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(622, '0x026E', nq'|God Stone|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(481, '0x01E1', nq'|Machine Part|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(417, '0x01A1', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(106, '0x006A', nq'|Pearl|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(399, '0x018F', nq'|TM72|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(490, '0x01EA', nq'|White Apricorn|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(263, '0x0107', nq'|Green Scarf|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(45, '0x002D', nq'|HP Up|', q'|Medicine|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(537, '0x0219', nq'|Prism Scale|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(92, '0x005C', nq'|Nugget|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(178, '0xB2', nq'|Rainbow Wing|', q'|Key items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(697, '0x02B9', nq'|Intriguing Stone|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(30, '0x1E', nq'|Lucky Punch|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(604, '0x025C', nq'|X Accuracy 3|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(262, '0x0106', nq'|Pink Scarf|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(677, '0x02A5', nq'|Absolite|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(160, '0x00A0', nq'|Wiki Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(109, '0x006D', nq'|Star Piece|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(674, '0x02A2', nq'|Abomasite|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(179, '0x00B3', nq'|BrightPowder|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(538, '0x021A', nq'|Eviolite|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(22, '0x0016', nq'|Parlyz Heal|', q'|Medicine|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(203, '0x00CB', nq'|Soft Sand|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(331, '0x014B', nq'|TM04|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(208, '0x00D0', nq'|Enigma Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(982, '0x03D6', nq'|Weedle Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(82, '0x0052', nq'|Fire Stone|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(722, '0x02D2', nq'|Soot Sack|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(619, '0x026B', nq'|TM94|', q'|TMs and HMs|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(122, '0x007A', nq'|unknown|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(458, '0x01CA', nq'|Magma Stone|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(488, '0x01E8', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(142, '0x008E', nq'|Sitrus Berry|', q'|Berries|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(364, '0x016C', nq'|TM Case|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(129, '0x81', nq'|Egg Ticket|', q'|Key items|', q'|Crystal|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(450, '0x01C2', nq'|Bicycle|', q'|Key items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(141, '0x008D', nq'|Inquiry Mail|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(475, '0x01DB', nq'|Card Key|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(172, '0x00AC', nq'|Hondew Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(481, '0x01E1', nq'|Machine Part|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(399, '0x018F', nq'|TM72|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, GEN)
values(237, '0xED', nq'|TM37|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(45, '0x002D', nq'|HP Up|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(974, '0x03CE', nq'|Tough Candy XL|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(851, '0x0353', nq'|Beast Ball|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(666, '0x029A', nq'|Houndoominite|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(576, '0x0240', nq'|Dream Ball|', q'|Poké Balls|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(258, '0x0102', nq'|Yellow Scarf|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(68, '0x44', nq'|X Special|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(144, '0x0090', nq'|Bridge Mail S|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(538, '0x021A', nq'|Eviolite|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(2, '0x02', nq'|Ultra Ball|', q'|Poké Balls|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(599, '0x0257', nq'|X Speed 3|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(89, '0x0059', nq'|Big Pearl|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(369, '0x0171', nq'|TM42|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(331, '0x014B', nq'|TM04|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(63, '0x003F', nq'|Poké Doll|', q'|Battle items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(90, '0x005A', nq'|Stardust|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(360, '0x0168', nq'|TM33|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(381, '0x017D', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(458, '0x01CA', nq'|Magma Stone|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(18, '0x0012', nq'|Antidote|', q'|Medicine|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(600, '0x0258', nq'|X Sp. Atk 3|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(58, '0x003A', nq'|X Defense|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(724, '0x02D4', nq'|Pokéblock Kit|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(259, '0x0103', nq'|Stick|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(497, '0x01F1', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(113, '0x0071', nq'|unknown|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(99, '0x0063', nq'|Root Fossil|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(247, '0x00F7', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(748, '0x02EC', nq'|Mega Stickpin|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(129, '0x0081', nq'|unknown|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(639, '0x027F', nq'|Weakness Policy|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(68, '0x0044', nq'|Rare Candy|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(226, '0xE2', nq'|TM26|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(543, '0x021F', nq'|Ring Target|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(519, '0x0207', nq'|Data Card 15|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(841, '0x0349', nq'|Forage Bag|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(17, '0x0011', nq'|Awakening|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(92, '0x005C', nq'|Nugget|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(400, '0x0190', nq'|TM73|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(184, '0x00B8', nq'|Occa Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(513, '0x0201', nq'|Joy Scent|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(99, '0x0063', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(199, '0xC7', nq'|HM04|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(54, '0x0036', nq'|Old Gateau|', q'|Medicine|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(411, '0x019B', nq'|TM84|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(599, '0x0257', nq'|X Speed 3|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(369, '0x0171', nq'|TM42|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(81, '0x0051', nq'|Fluffy Tail|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1023, '0x03FF', nq'|Cubone Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(185, '0xB9', nq'|Eon Mail|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(360, '0x0168', nq'|TM33|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(442, '0x01BA', nq'|Town Map|', q'|Key items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(386, '0x0182', nq'|TM59|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(291, '0x0123', nq'|TM03|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(321, '0x0141', nq'|Protector|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(66, '0x0042', nq'|Yellow Flute|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(52, '0x0034', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(426, '0x01AA', nq'|unknown|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(605, '0x025D', nq'|X Speed 6|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(130, '0x0082', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(612, '0x0264', nq'|Item Drop|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(129, '0x0081', nq'|unknown|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(20, '0x0014', nq'|Max Potion|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(620, '0x026C', nq'|TM95|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(241, '0x00F1', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(116, '0x0074', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(840, '0x0348', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(490, '0x01EA', nq'|White Apricorn|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(13, '0x0D', nq'|Ice Heal|', 1);
insert into itemIDs(ID, HEX, NAME, GEN)
values(7, '0x07', nq'|?????|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(852, '0x0354', nq'|Big Malasada|', q'|Medicine|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(259, '0x0103', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(435, '0x01B3', nq'|Fashion Case|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(82, '0x0052', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(677, '0x02A5', nq'|Absolite|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(489, '0x01E9', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(591, '0x024F', nq'|Battle CD 58|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(61, '0x3D', nq'|Soda Pop|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(492, '0x01EC', nq'|Fast Ball|', q'|Poké Balls|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(593, '0x0251', nq'|X Speed 2|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(304, '0x0130', nq'|TM16|', q'|TMs and HMs|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(150, '0x0096', nq'|Chesto Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(667, '0x029B', nq'|Aggronite|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(492, '0x01EC', nq'|Fast Ball|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(599, '0x0257', nq'|X Speed 3|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(160, '0x00A0', nq'|Wiki Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(369, '0x0171', nq'|TM42|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(210, '0x00D2', nq'|Sharp Beak|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(491, '0x01EB', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(805, '0x0325', nq'|Eevium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(360, '0x0168', nq'|TM33|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(215, '0x00D7', nq'|Charcoal|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(72, '0x48', nq'|Moomoo Milk|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(215, '0x00D7', nq'|Macho Brace|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(572, '0x023C', nq'|Cover Fossil|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(159, '0x9F', nq'|Level Ball|', q'|Poké Balls|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(154, '0x009A', nq'|Leppa Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(420, '0x01A4', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(175, '0x00AF', nq'|Enigma Berry|', q'|Berries|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(130, '0x0082', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(368, '0x0170', nq'|TM41|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(321, '0x0141', nq'|Protector|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(723, '0x02D3', nq'|Basement Key|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(911, '0x038F', nq'|Steel Memory|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(129, '0x0081', nq'|unknown|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(93, '0x005D', nq'|Sun Stone|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(340, '0x0154', nq'|HM02|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(187, '0x00BB', nq'|Rindo Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(743, '0x02E7', nq'|Pair of Tickets|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(270, '0x010E', nq'|Life Orb|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(203, '0x00CB', nq'|Salac Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(390, '0x0186', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(425, '0x01A9', nq'|HM06|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(252, '0xFC', nq'|HM10|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(189, '0x00BD', nq'|Amulet Coin|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1012, '0x03F4', nq'|Farfetch'd Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(47, '0x2F', nq'|Soda Pop|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, GEN)
values(892, '0x037C', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(178, '0x00B2', nq'|Nomel Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(19, '0x0013', nq'|Full Restore|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(195, '0x00C3', nq'|Charti Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(11, '0x000B', nq'|Luxury Ball|', q'|Poké Balls|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(667, '0x029B', nq'|Aggronite|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(160, '0x00A0', nq'|Wiki Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(375, '0x0177', nq'|Magma Emblem|', q'|Key items|', q'|Emerald|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(96, '0x0060', nq'|Thunderstone|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(249, '0xF9', nq'|HM07|', q'|TMs and HMs|', 2);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(424, '0x01A8', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(572, '0x023C', nq'|Cover Fossil|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(9, '0x0009', nq'|Repeat Ball|', q'|Poké Balls|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(621, '0x026D', nq'|Xtransceiver|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(294, '0x0126', nq'|TM06|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(58, '0x003A', nq'|X Defense|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(349, '0x015D', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(203, '0xCB', nq'|TM12|', q'|TMs and HMs|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(321, '0x0141', nq'|Protector|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(720, '0x02D0', nq'|Wailmer Pail|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(473, '0x01D9', nq'|SlowpokeTail|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(241, '0x00F1', nq'|Black Belt|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(524, '0x020C', nq'|Data Card 20|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(625, '0x0271', nq'|Gram 3|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(186, '0x00BA', nq'|Choice Band|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(934, '0x03A6', nq'|Pink Petal|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(259, '0x0103', nq'|Stick|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(354, '0x0162', nq'|TM27|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(568, '0x0238', nq'|Genius Wing|', q'|Medicine|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(263, '0x0107', nq'|Green Scarf|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(175, '0x00AF', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(492, '0x01EC', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(880, '0x0370', nq'|Protective Pads|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(437, '0x01B5', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(240, '0xF0', nq'|TM40|', 1);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(959, '0x03BF', nq'|Roto Catch|', q'|Ultra Sun, Ultra Moon|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(691, '0x02B3', nq'|TM97|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(373, '0x0175', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(29, '0x001D', nq'|Max Revive|', q'|Medicine|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(178, '0x00B2', nq'|Nomel Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(237, '0xED', nq'|TM45|', q'|TMs and HMs|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(712, '0x02C8', nq'|Looker Ticket|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(160, '0x00A0', nq'|Wiki Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(820, '0x0334', nq'|Ghostium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(137, '0x0089', nq'|Greet Mail|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GEN)
values(224, '0xE0', nq'|TM24|', 1);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(204, '0x00CC', nq'|Petaya Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(283, '0x011B', nq'|Rm. 4 Key|', q'|Key items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(182, '0x00B6', nq'|Durin Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(248, '0xF8', nq'|TM48|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(312, '0x0138', nq'|Dread Plate|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(102, '0x0066', nq'|Dome Fossil|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(433, '0x01B1', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(226, '0x00E2', nq'|Deep Sea Tooth|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(343, '0x0157', nq'|TM16|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(476, '0x01DC', nq'|Basement Key|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(14, '0x0E', nq'|Awakening|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(308, '0x0134', nq'|TM20|', q'|TMs and HMs|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(494, '0x01EE', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(247, '0x00F7', nq'|Spell Tag|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(341, '0x0155', nq'|TM14|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(241, '0x00F1', nq'|Black Belt|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(625, '0x0271', nq'|Gram 3|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(620, '0x026C', nq'|TM95|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(187, '0x00BB', nq'|Rindo Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(263, '0x0107', nq'|Green Scarf|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(193, '0x00C1', nq'|Payapa Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(434, '0x01B2', nq'|Seal Case|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1055, '0x041F', nq'|Mew Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(120, '0x0078', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(416, '0x01A0', nq'|TM89|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(546, '0x0222', nq'|Powerup Part|', q'|Key items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(754, '0x02F2', nq'|Sablenite|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(286, '0x011E', nq'|Grip Claw|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(29, '0x001D', nq'|Max Revive|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(14, '0x000E', nq'|Antidote|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(31, '0x001F', nq'|Energy Root|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(621, '0x026D', nq'|Xtransceiver|', q'|Key items|', q'|Black 2, White 2|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(236, '0x00EC', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(54, '0x36', nq'|Coin Case|', q'|Key items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(716, '0x02CC', nq'|Mega Charm|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(160, '0x00A0', nq'|Wiki Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(613, '0x0265', nq'|Item Urge|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(195, '0x00C3', nq'|Charti Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(178, '0x00B2', nq'|Nomel Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(420, '0x01A4', nq'|HM01|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(339, '0x0153', nq'|TM12|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(783, '0x030F', nq'|Poisonium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(182, '0x00B6', nq'|Durin Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(102, '0x0066', nq'|Dome Fossil|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(267, '0x010B', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(373, '0x0175', nq'|TM46|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(188, '0x00BC', nq'|SilverPowder|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(154, '0x009A', nq'|Leppa Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(600, '0x0258', nq'|X Sp. Atk 3|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(734, '0x02DE', nq'|Storage Key|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(448, '0x01C0', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(508, '0x01FC', nq'|Subway Key|', q'|Key items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(241, '0x00F1', nq'|Black Belt|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(343, '0x0157', nq'|TM16|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(742, '0x02E6', nq'|Aqua Suit|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(588, '0x024C', nq'|Battle CD 55|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(284, '0x011C', nq'|Rm. 6 Key|', q'|Key items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(508, '0x01FC', nq'|Data Card 04|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(882, '0x0372', nq'|Psychic Seed|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(263, '0x0107', nq'|Green Scarf|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(558, '0x022E', nq'|Bug Gem|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(435, '0x01B3', nq'|Fashion Case|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(410, '0x019A', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(67, '0x0043', nq'|Red Flute|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(286, '0x011E', nq'|Grip Claw|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(29, '0x001D', nq'|Max Revive|', q'|Medicine|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(378, '0x017A', nq'|TM51|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(112, '0x0070', nq'|Griseous Orb|', q'|Items|', q'|Platinum, HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(510, '0x01FE', nq'|Card Key|', q'|Key items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(296, '0x0128', nq'|Big Root|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(244, '0x00F4', nq'|Sharp Beak|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(102, '0x0066', nq'|Dome Fossil|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(310, '0x0136', nq'|TM22|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(45, '0x002D', nq'|Sacred Ash|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(235, '0xEB', nq'|TM35|', 1);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(398, '0x018E', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(523, '0x020B', nq'|Data Card 19|', q'|Items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(29, '0x001D', nq'|Moomoo Milk|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(87, '0x0057', nq'|Big Mushroom|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GEN)
values(113, '0x0071', nq'|unknown|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(573, '0x023D', nq'|Plume Fossil|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(116, '0x0074', nq'|unknown|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(241, '0x00F1', nq'|Black Belt|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(124, '0x7C', nq'|Revival Herb|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(625, '0x0271', nq'|Gram 3|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(6, '0x0006', nq'|Net Ball|', q'|Poké Balls|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(568, '0x0238', nq'|Genius Wing|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(500, '0x01F4', nq'|Jail Key|', q'|Key items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(586, '0x024A', nq'|Relic Gold|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(530, '0x0212', nq'|Data Card 26|', q'|Items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(28, '0x001C', nq'|Revive|', q'|Medicine|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(558, '0x022E', nq'|Bug Gem|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(890, '0x037A', nq'|Gold Leaf|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(286, '0x011E', nq'|Grip Claw|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(986, '0x03DA', nq'|Ekans Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(862, '0x035E', nq'|Golden Razz Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(764, '0x02FC', nq'|Diancite|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(814, '0x032E', nq'|Poisonium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(60, '0x003C', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(107, '0x006B', nq'|Shiny Stone|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(424, '0x01A8', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(476, '0x01DC', nq'|Basement Key|', q'|Key items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, GEN)
values(240, '0x00F0', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(437, '0x01B5', nq'|Pal Pad|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(204, '0x00CC', nq'|Hard Stone|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(432, '0x01B0', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(456, '0x01C8', nq'|S.S. Ticket|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(894, '0x037E', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(182, '0x00B6', nq'|Durin Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(512, '0x0200', nq'|Data Card 08|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(102, '0x0066', nq'|Dome Fossil|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(42, '0x002A', nq'|Black Flute|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(216, '0x00D8', nq'|Dragon Fang|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(227, '0x00E3', nq'|Deep Sea Scale|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(54, '0x0036', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(491, '0x01EB', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(310, '0x0136', nq'|Spooky Plate|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(282, '0x011A', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(523, '0x020B', nq'|Data Card 19|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(590, '0x024E', nq'|Battle CD 57|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(329, '0x0149', nq'|TM02|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(187, '0x00BB', nq'|Rindo Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(302, '0x012E', nq'|Icicle Plate|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(486, '0x01E6', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(403, '0x0193', nq'|TM76|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(232, '0x00E8', nq'|Scope Lens|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(293, '0x0125', nq'|TM05|', q'|TMs and HMs|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(720, '0x02D0', nq'|Wailmer Pail|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(311, '0x0137', nq'|TM23|', q'|TMs and HMs|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(28, '0x001C', nq'|Revive|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(208, '0x00D0', nq'|Enigma Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(539, '0x021B', nq'|Ein File H|', q'|Key items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(251, '0xFB', nq'|HM09|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(130, '0x82', nq'|Lost Item|', q'|Key items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(40, '0x0028', nq'|Elixir|', q'|Medicine|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(46, '0x002E', nq'|Protein|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(565, '0x0235', nq'|Health Wing|', q'|Medicine|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(286, '0x011E', nq'|Grip Claw|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(22, '0x0016', nq'|Parlyz Heal|', q'|Medicine|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(19, '0x0013', nq'|Full Restore|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(172, '0x00AC', nq'|Apicot Berry|', q'|Berries|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(819, '0x0333', nq'|Rockium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(340, '0x0154', nq'|TM13|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(195, '0x00C3', nq'|Charti Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(102, '0x66', nq'|ひんやりバッヂ (CoolBadge - D)|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(220, '0x00DC', nq'|Choice Band|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(808, '0x0328', nq'|Firium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(171, '0x00AB', nq'|Petaya Berry|', q'|Berries|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(177, '0xB1', nq'|Park Ball|', q'|Poké Balls|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(339, '0x0153', nq'|TM12|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(135, '0x0087', nq'|Adamant Orb|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(31, '0x001F', nq'|Soda Pop|', q'|Medicine|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(120, '0x0078', nq'|unknown|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(104, '0x68', nq'|Pink Bow|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(50, '0x0032', nq'|Rare Candy|', q'|Medicine|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(489, '0x01E9', nq'|Pink Apricorn|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(482, '0x01E2', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(106, '0x6A', nq'|ゴールドバッヂ (GoldBadge - D)|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(191, '0x00BF', nq'|Soul Dew|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(335, '0x014F', nq'|TM08|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(413, '0x019D', nq'|TM86|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(612, '0x0264', nq'|Item Drop|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(500, '0x01F4', nq'|Park Ball|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(329, '0x0149', nq'|TM02|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(293, '0x0125', nq'|Power Anklet|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(635, '0x027B', nq'|Colress Machine|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(558, '0x022E', nq'|Bug Gem|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(52, '0x0034', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(712, '0x02C8', nq'|Looker Ticket|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(67, '0x43', nq'|SecretPotion|', q'|Key items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(74, '0x004A', nq'|Yellow Shard|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(345, '0x0159', nq'|TM18|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(494, '0x01EE', nq'|Lure Ball|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(627, '0x0273', nq'|Medal Box|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(99, '0x0063', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(85, '0x55', nq'|B1F (G)|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(340, '0x0154', nq'|TM13|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(351, '0x015F', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(634, '0x027A', nq'|Grubby Hanky|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(220, '0x00DC', nq'|Choice Band|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(939, '0x03AB', nq'|Yellow Petal|', q'|Key items|', q'|Ultra Sun, Ultra Moon|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(920, '0x0398', nq'|Fairy Memory|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(614, '0x0266', nq'|Reset Urge|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(175, '0xAF', nq'|SquirtBottle|', q'|Key items|', 2);
insert into itemIDs(ID, HEX, NAME, GEN)
values(120, '0x0078', nq'|unknown|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(122, '0x007A', nq'|unknown|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(58, '0x3A', nq'|Old Rod|', q'|Key items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(50, '0x0032', nq'|Rare Candy|', q'|Medicine|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(307, '0x0133', nq'|Mind Plate|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(66, '0x42', nq'|Red Scale|', q'|Key items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(626, '0x0272', nq'|Xtransceiver|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(113, '0x0071', nq'|unknown|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(287, '0x011F', nq'|Choice Scarf|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(866, '0x0362', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(710, '0x02C6', nq'|Jaw Fossil|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(823, '0x0337', nq'|Steelium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(568, '0x0238', nq'|Genius Wing|', q'|Medicine|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(205, '0xCD', nq'|TM05|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(586, '0x024A', nq'|Relic Gold|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(435, '0x01B3', nq'|Fashion Case|', q'|Key items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(129, '0x0081', nq'|???|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(190, '0x00BE', nq'|Cleanse Tag|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(74, '0x004A', nq'|Yellow Shard|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(426, '0x01AA', nq'|???|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(533, '0x0215', nq'|Lock Capsule|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(768, '0x0300', nq'|Lopunnite|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(151, '0x0097', nq'|Pecha Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(58, '0x003A', nq'|X Defense|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(118, '0x0076', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(476, '0x01DC', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(823, '0x0337', nq'|Steelium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(220, '0x00DC', nq'|Choice Band|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(107, '0x006B', nq'|Shiny Stone|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(224, '0x00E0', nq'|Thick Club|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(137, '0x0089', nq'|Greet Mail|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(512, '0x0200', nq'|Data Card 08|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(235, '0x00EB', nq'|Dragon Scale|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(315, '0x013B', nq'|Rock Incense|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(261, '0x0105', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(244, '0x00F4', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(120, '0x0078', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(122, '0x007A', nq'|unknown|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(509, '0x01FD', nq'|Maingate Key|', q'|Key items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(223, '0x00DF', nq'|Metal Powder|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(57, '0x39', nq'|Exp.Share|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(50, '0x0032', nq'|Rare Candy|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(307, '0x0133', nq'|Mind Plate|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(626, '0x0272', nq'|Xtransceiver|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(341, '0x0155', nq'|TM14|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(466, '0x01D2', nq'|Gracidea|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(760, '0x02F8', nq'|Slowbronite|', q'|Items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(77, '0x004D', nq'|Max Repel|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(524, '0x020C', nq'|Data Card 20|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(938, '0x03AA', nq'|Green Petal|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(201, '0x00C9', nq'|Liechi Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(7, '0x0007', nq'|Dive Ball|', q'|Poké Balls|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(312, '0x0138', nq'|TM24|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(543, '0x021F', nq'|Ring Target|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(329, '0x0149', nq'|TM02|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(953, '0x03B9', nq'|Roto Friendship|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(519, '0x0207', nq'|Data Card 15|', q'|Items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(355, '0x0163', nq'|TM28|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(931, '0x03A3', nq'|Lycanium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(461, '0x01CD', nq'|Coupon 2|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(732, '0x02DC', nq'|Key to Room 4|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(151, '0x0097', nq'|Pecha Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(168, '0x00A8', nq'|Liechi Berry|', q'|Berries|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(336, '0x0150', nq'|TM09|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(505, '0x01F9', nq'|Data Card 01|', q'|Items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(262, '0x0106', nq'|Pink Scarf|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(266, '0x010A', nq'|Contest Pass|', q'|Key items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(171, '0x00AB', nq'|Petaya Berry|', q'|Berries|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(137, '0x0089', nq'|Greet Mail|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(68, '0x44', nq'|S.S. Ticket|', q'|Key items|', 2);
insert into itemIDs(ID, HEX, NAME, GEN)
values(44, '0x2C', nq'|?????|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(835, '0x0343', nq'|Pikashunium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(121, '0x0079', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(120, '0x0078', nq'|unknown|', 4);
insert into itemIDs(ID, HEX, NAME, GEN)
values(228, '0x00E4', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(300, '0x012C', nq'|TM12|', q'|TMs and HMs|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(186, '0x00BA', nq'|Wacan Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(466, '0x01D2', nq'|Gracidea|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(50, '0x0032', nq'|Rare Candy|', q'|Medicine|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(427, '0x01AB', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(335, '0x014F', nq'|TM08|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(174, '0x00AE', nq'|Tamato Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(585, '0x0249', nq'|Battle CD 52|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(184, '0x00B8', nq'|Soothe Bell|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(159, '0x009F', nq'|Figy Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(164, '0x00A4', nq'|Razz Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(392, '0x0188', nq'|TM65|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(543, '0x021F', nq'|Ring Target|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(231, '0x00E7', nq'|Lucky Egg|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(461, '0x01CD', nq'|Coupon 2|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(5, '0x05', nq'|Poké Ball|', q'|Poké Balls|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(193, '0x00C1', nq'|DeepSeaScale|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(397, '0x018D', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(77, '0x004D', nq'|X Speed|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(747, '0x02EB', nq'|Mega Anchor|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(627, '0x0273', nq'|Medal Box|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(381, '0x017D', nq'|TM54|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(533, '0x0215', nq'|Lock Capsule|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(148, '0x0094', nq'|Razz Berry|', q'|Berries|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(454, '0x01C6', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(44, '0x2C', nq'|Dire Hit|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(494, '0x01EE', nq'|Lure Ball|', q'|Poké Balls|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(759, '0x02F7', nq'|Sharpedonite|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(54, '0x0036', nq'|Old Gateau|', q'|Medicine|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(447, '0x01BF', nq'|Super Rod|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(248, '0x00F8', nq'|Twisted Spoon|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(634, '0x027A', nq'|Grubby Hanky|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(545, '0x0221', nq'|Absorb Bulb|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(600, '0x0258', nq'|X Sp. Atk 3|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(420, '0x01A4', nq'|HM01|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(629, '0x0275', nq'|DNA Splicers|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(110, '0x006E', nq'|Nugget|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(186, '0x00BA', nq'|Wacan Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(135, '0x0087', nq'|Adamant Orb|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(85, '0x0055', nq'|Escape Rope|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(937, '0x03A9', nq'|Red Petal|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(112, '0x70', nq'|プチキャプテン (Petit Captain - D)|', 1);
insert into itemIDs(ID, HEX, NAME, GEN)
values(890, '0x037A', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(82, '0x0052', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(174, '0x00AE', nq'|Tamato Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(42, '0x002A', nq'|Black Flute|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(164, '0x00A4', nq'|Razz Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(395, '0x018B', nq'|TM68|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(554, '0x022A', nq'|Poison Gem|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(454, '0x01C6', nq'|Member Card|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(233, '0x00E9', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(636, '0x027C', nq'|Dropped Item|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(41, '0x0029', nq'|Red Flute|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(131, '0x0083', nq'|???|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(216, '0x00D8', nq'|Exp. Share|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(997, '0x03E5', nq'|Venonat Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(968, '0x03C8', nq'|Tough Candy L|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(984, '0x03D8', nq'|Rattata Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(533, '0x0215', nq'|Lock Capsule|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(222, '0x00DE', nq'|Lucky Punch|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(661, '0x0295', nq'|Blastoisinite|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(565, '0x0235', nq'|Health Wing|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(242, '0x00F2', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(199, '0xC7', nq'|TM08|', q'|TMs and HMs|', 2);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(609, '0x0261', nq'|X Attack 6|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(212, '0x00D4', nq'|Rowap Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(254, '0x00FE', nq'|Sea Incense|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(247, '0x00F7', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(134, '0x0086', nq'|Sweet Heart|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(567, '0x0237', nq'|Resist Wing|', q'|Medicine|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(61, '0x003D', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(110, '0x6E', nq'|シルバー (Silver - D)|', 1);
insert into itemIDs(ID, HEX, NAME, GEN)
values(895, '0x037F', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(181, '0x00B5', nq'|Macho Brace|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(135, '0x0087', nq'|Adamant Orb|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(174, '0x00AE', nq'|Tamato Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(623, '0x026F', nq'|Gram 1|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(396, '0x018C', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(413, '0x019D', nq'|TM86|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(682, '0x02AA', nq'|Manectite|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(544, '0x0220', nq'|Binding Band|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(860, '0x035C', nq'|Enigmatic Card|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(698, '0x02BA', nq'|Common Stone|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(146, '0x0092', nq'|BridgeMail T|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(554, '0x022A', nq'|Poison Gem|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(636, '0x027C', nq'|Dropped Item|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(423, '0x01A7', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(885, '0x0375', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(216, '0x00D8', nq'|Exp. Share|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(81, '0x0051', nq'|Fluffy Tail|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(199, '0x00C7', nq'|Babiri Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(39, '0x0027', nq'|Blue Flute|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(876, '0x036C', nq'|Card Key|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(52, '0x34', nq'|Full Heal|', 1);
insert into itemIDs(ID, HEX, NAME, GEN)
values(126, '0x007E', nq'|unknown|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(371, '0x0173', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(661, '0x0295', nq'|Blastoisinite|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(54, '0x0036', nq'|Old Gateau|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1047, '0x0417', nq'|Kabuto Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(809, '0x0329', nq'|Waterium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(178, '0x00B2', nq'|Nomel Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(352, '0x0160', nq'|TM25|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(707, '0x02C3', nq'|Travel Trunk|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(463, '0x01CF', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(434, '0x01B2', nq'|Seal Case|', q'|Key items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(372, '0x0174', nq'|Powder Jar|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(632, '0x0278', nq'|Shiny Charm|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(36, '0x0024', nq'|Elixir|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(543, '0x021F', nq'|Ring Target|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(135, '0x0087', nq'|Adamant Orb|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(842, '0x034A', nq'|Fishing Rod|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(587, '0x024B', nq'|Relic Vase|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(494, '0x01EE', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(0, '0x0000', nq'|None|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(174, '0x00AE', nq'|Tamato Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(225, '0xE1', nq'|TM33|', q'|TMs and HMs|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(413, '0x019D', nq'|TM86|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(164, '0x00A4', nq'|Razz Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(231, '0x00E7', nq'|Lucky Egg|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(544, '0x0220', nq'|Binding Band|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(387, '0x0183', nq'|TM60|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(37, '0x0025', nq'|Max Elixir|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(744, '0x02E8', nq'|Mega Bracelet|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(386, '0x0182', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(393, '0x0189', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(554, '0x022A', nq'|Poison Gem|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(217, '0x00D9', nq'|Silk Scarf|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(637, '0x027D', nq'|Dropped Item|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(628, '0x0274', nq'|DNA Splicers|', q'|Key items|', q'|Black 2, White 2|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1042, '0x0412', nq'|Lapras Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(290, '0x0122', nq'|Power Belt|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(396, '0x018C', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(126, '0x007E', nq'|unknown|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(66, '0x0042', nq'|Carbos|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(964, '0x03C4', nq'|Courage Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(342, '0x0156', nq'|TM15|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(289, '0x0121', nq'|Power Bracer|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(483, '0x01E3', nq'|Rainbow Wing|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(372, '0x0174', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(54, '0x0036', nq'|Old Gateau|', q'|Medicine|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(379, '0x017B', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(248, '0x00F8', nq'|Twisted Spoon|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(500, '0x01F4', nq'|Park Ball|', q'|Poké Balls|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(15, '0x000F', nq'|Burn Heal|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(888, '0x0378', nq'|Lone Earring|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(872, '0x0368', nq'|Secret Key|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(477, '0x01DD', nq'|SquirtBottle|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(525, '0x020D', nq'|Data Card 21|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(587, '0x024B', nq'|Relic Vase|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(715, '0x02CB', nq'|Fairy Gem|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(538, '0x021A', nq'|Ein File S|', q'|Key items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(523, '0x020B', nq'|DNA Sample|', q'|Key items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(198, '0x00C6', nq'|Scope Lens|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(544, '0x0220', nq'|Binding Band|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(138, '0x8A', nq'|Charcoal|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(418, '0x01A2', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(368, '0x0170', nq'|TM41|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, GEN)
values(0, '0x0000', nq'|None|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(47, '0x002F', nq'|Iron|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(7, '0x0007', nq'|Dive Ball|', q'|Poké Balls|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(213, '0x00D5', nq'|Spell Tag|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(55, '0x0037', nq'|Guard Spec.|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(228, '0x00E4', nq'|Smoke Ball|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(307, '0x0133', nq'|Mind Plate|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(756, '0x02F4', nq'|Galladite|', q'|Items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(74, '0x4A', nq'|Lift Key|', 1);
insert into itemIDs(ID, HEX, NAME, GEN)
values(82, '0x52', nq'|Elixer|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(721, '0x02D1', nq'|Devon Parts|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(52, '0x0034', nq'|Zinc|', q'|Medicine|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(79, '0x004F', nq'|X Special|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(629, '0x0275', nq'|DNA Splicers|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(454, '0x01C6', nq'|Member Card|', q'|Key items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(575, '0x023F', nq'|Pass Orb|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(804, '0x0324', nq'|Snorlium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(625, '0x0271', nq'|Gram 3|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(291, '0x0123', nq'|Power Lens|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(494, '0x01EE', nq'|Lure Ball|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(377, '0x0179', nq'|TM50|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(134, '0x0086', nq'|Chesto Berry|', q'|Berries|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(275, '0x0113', nq'|Focus Sash|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(483, '0x01E3', nq'|Rainbow Wing|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(692, '0x02B4', nq'|TM98|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(399, '0x018F', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(579, '0x0243', nq'|Dragon Skull|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(419, '0x01A3', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(150, '0x96', nq'|MysteryBerry|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(559, '0x022F', nq'|Rock Gem|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(148, '0x0094', nq'|Razz Berry|', q'|Berries|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(715, '0x02CB', nq'|Fairy Gem|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(478, '0x01DE', nq'|Red Scale|', q'|Key items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(434, '0x01B2', nq'|Seal Case|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(223, '0x00DF', nq'|Amulet Coin|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(542, '0x021E', nq'|Battle CD 09|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(360, '0x0168', nq'|TM33|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(1, '0x01', nq'|Master Ball|', 1);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(886, '0x0376', nq'|Chalky Stone|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(299, '0x012B', nq'|TM11|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(595, '0x0253', nq'|X Sp. Def 2|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(49, '0x0031', nq'|Calcium|', q'|Medicine|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(311, '0x0137', nq'|Draco Plate|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(368, '0x0170', nq'|TM41|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(594, '0x0252', nq'|X Sp. Atk 2|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(377, '0x0179', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(682, '0x02AA', nq'|Manectite|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(71, '0x0047', nq'|PP Max|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(149, '0x0095', nq'|Cheri Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(524, '0x020C', nq'|Data Card 20|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(671, '0x029F', nq'|Pinsirite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(307, '0x0133', nq'|Mind Plate|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GEN)
values(66, '0x42', nq'|X Defend|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(228, '0x00E4', nq'|Smoke Ball|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(80, '0x0050', nq'|Sun Stone|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(116, '0x74', nq'|Blue Card|', q'|Key items|', q'|Crystal|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(461, '0x01CD', nq'|Coupon 2|', q'|Key items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(499, '0x01F3', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(45, '0x2D', nq'|Teru-sama|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(203, '0x00CB', nq'|Soft Sand|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(269, '0x010D', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(105, '0x0069', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(83, '0x0053', nq'|Thunderstone|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(381, '0x017D', nq'|TM54|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(82, '0x0052', nq'|Fire Stone|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(721, '0x02D1', nq'|Devon Parts|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(483, '0x01E3', nq'|Rainbow Wing|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(275, '0x0113', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(20, '0x0014', nq'|Max Potion|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(124, '0x007C', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(274, '0x0112', nq'|Quick Powder|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(305, '0x0131', nq'|TM17|', q'|TMs and HMs|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(8, '0x0008', nq'|Nest Ball|', q'|Poké Balls|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(262, '0x0106', nq'|Pink Scarf|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(447, '0x01BF', nq'|Super Rod|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(953, '0x03B9', nq'|Roto Friendship|', q'|Ultra Sun, Ultra Moon|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(559, '0x022F', nq'|Rock Gem|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(518, '0x0206', nq'|DNA Sample|', q'|Key items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(434, '0x01B2', nq'|Seal Case|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(62, '0x003E', nq'|X Sp. Def|', q'|Battle items|', 4);
insert into itemIDs(ID, HEX, NAME, GEN)
values(64, '0x40', nq'|Gold Teeth|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(499, '0x01F3', nq'|Sport Ball|', q'|Poké Balls|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(701, '0x02BD', nq'|TMV Pass|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(563, '0x0233', nq'|Steel Gem|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(375, '0x0177', nq'|TM48|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(256, '0x0100', nq'|Lucky Punch|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(649, '0x0289', nq'|Snowball|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(211, '0x00D3', nq'|Jaboca Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(311, '0x0137', nq'|Draco Plate|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(0, '0x0000', nq'|None|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(141, '0x008D', nq'|Lum Berry|', q'|Berries|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(267, '0x010B', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(39, '0x0027', nq'|Max Ether|', q'|Medicine|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(175, '0x00AF', nq'|Cornn Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(298, '0x012A', nq'|TM10|', q'|TMs and HMs|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(994, '0x03E2', nq'|Zubat Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(231, '0x00E7', nq'|Lucky Egg|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(80, '0x0050', nq'|Sun Stone|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(575, '0x023F', nq'|Pass Orb|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(84, '0x0054', nq'|Max Repel|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(597, '0x0255', nq'|X Attack 2|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(459, '0x01CB', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(454, '0x01C6', nq'|Member Card|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(461, '0x01CD', nq'|Coupon 2|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(107, '0x6B', nq'|NeverMeltIce|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1036, '0x040C', nq'|Scyther Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(49, '0x0031', nq'|Calcium|', q'|Medicine|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(147, '0x0093', nq'|Mosaic Mail|', q'|Mail|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(460, '0x01CC', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(529, '0x0211', nq'|Data Card 25|', q'|Items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(132, '0x0084', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(925, '0x039D', nq'|Lycanium Z|', q'|Z-Crystals|', q'|Ultra Sun, Ultra Moon|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(168, '0x00A8', nq'|Pinap Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(82, '0x0052', nq'|Fire Stone|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(871, '0x0367', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(381, '0x017D', nq'|TM54|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(118, '0x0076', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(376, '0x0178', nq'|Old Sea Map|', q'|Key items|', q'|Emerald|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(500, '0x01F4', nq'|Safe Key|', q'|Key items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(277, '0x0115', nq'|Metronome|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(516, '0x0204', nq'|Data Card 12|', q'|Items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(866, '0x0362', nq'|Golden Pinap Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(8, '0x0008', nq'|Nest Ball|', q'|Poké Balls|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(262, '0x0106', nq'|Pink Scarf|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(525, '0x020D', nq'|Data Card 21|', q'|Items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(245, '0xF5', nq'|HM03|', q'|TMs and HMs|', 2);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(460, '0x01CC', nq'|Coupon 1|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(68, '0x0044', nq'|Black Flute|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(138, '0x008A', nq'|Leppa Berry|', q'|Berries|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(216, '0x00D8', nq'|Exp. Share|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(156, '0x009C', nq'|Persim Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(30, '0x1E', nq'|Repel|', 1);
insert into itemIDs(GAME, GEN)
values(q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(649, '0x0289', nq'|Snowball|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(832, '0x0340', nq'|Snorlium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(542, '0x021E', nq'|Red Card|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(311, '0x0137', nq'|Draco Plate|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(153, '0x99', nq'|Teru-sama|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(0, '0x00', nq'|?|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, GEN)
values(251, '0x00FB', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(803, '0x0323', nq'|Aloraichium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(698, '0x02BA', nq'|Common Stone|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(368, '0x0170', nq'|TM41|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(446, '0x01BE', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(530, '0x0212', nq'|Data ROM|', q'|Key items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(661, '0x0295', nq'|Blastoisinite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(483, '0x01E3', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(545, '0x0221', nq'|Absorb Bulb|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(19, '0x0013', nq'|Full Restore|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(128, '0x0080', nq'|Battle Pocket|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(80, '0x0050', nq'|Sun Stone|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(454, '0x01C6', nq'|Member Card|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(597, '0x0255', nq'|X Attack 2|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(701, '0x02BD', nq'|TMV Pass|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(135, '0x87', nq'|Teru-sama|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(74, '0x004A', nq'|Yellow Shard|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(549, '0x0225', nq'|Water Gem|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(97, '0x0061', nq'|Stable Mulch|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(360, '0x0168', nq'|Bicycle|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(2, '0x02', nq'|Ultra Ball|', 1);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(708, '0x02C4', nq'|Lumiose Galette|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(274, '0x0112', nq'|Quick Powder|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(912, '0x0390', nq'|Fire Memory|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(88, '0x0058', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(118, '0x0076', nq'|unknown|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(447, '0x01BF', nq'|Super Rod|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(513, '0x0201', nq'|Data Card 09|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(514, '0x0202', nq'|DNA Sample|', q'|Key items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(559, '0x022F', nq'|Rock Gem|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(125, '0x007D', nq'|unknown|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(111, '0x006F', nq'|Heart Scale|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(144, '0x90', nq'|Dragon Fang|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(216, '0x00D8', nq'|Exp. Share|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(632, '0x0278', nq'|Shiny Charm|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(420, '0x01A4', nq'|HM01|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(264, '0x0108', nq'|Super Rod|', q'|Key items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(305, '0x0131', nq'|TM17|', q'|TMs and HMs|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(398, '0x018E', nq'|TM71|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(402, '0x0192', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(373, '0x0175', nq'|TM46|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(26, '0x1A', nq'|MarshBadge|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(542, '0x021E', nq'|Red Card|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(320, '0x0140', nq'|TM32|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(594, '0x0252', nq'|X Sp. Atk 2|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(384, '0x0180', nq'|TM57|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(423, '0x01A7', nq'|HM04|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(318, '0x013E', nq'|TM30|', q'|TMs and HMs|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(694, '0x02B6', nq'|TM100|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(220, '0xDC', nq'|TM20|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(545, '0x0221', nq'|Absorb Bulb|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(169, '0x00A9', nq'|Ganlon Berry|', q'|Berries|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(511, '0x01FF', nq'|Data Card 07|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(96, '0x60', nq'|TwistedSpoon|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(542, '0x021E', nq'|Cologne Case|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(80, '0x0050', nq'|Sun Stone|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(597, '0x0255', nq'|X Attack 2|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(91, '0x005B', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(49, '0x0031', nq'|Calcium|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(74, '0x004A', nq'|Yellow Shard|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(265, '0x0109', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(74, '0x4A', nq'|PSNCureBerry|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(82, '0x0052', nq'|Fire Stone|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(531, '0x0213', nq'|Data Card 27|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(63, '0x003F', nq'|Poké Doll|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(288, '0x0120', nq'|Sticky Barb|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(746, '0x02EA', nq'|Mega Glasses|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(274, '0x0112', nq'|Quick Powder|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(502, '0x01F6', nq'|Small Tablet|', q'|Key items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(6, '0x0006', nq'|Net Ball|', q'|Poké Balls|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(318, '0x013E', nq'|Rose Incense|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(262, '0x0106', nq'|Pink Scarf|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(79, '0x4F', nq'|PP Up|', 1);
insert into itemIDs(ID, HEX, NAME, GEN)
values(37, '0x25', nq'|Iron|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(133, '0x0085', nq'|Cheri Berry|', q'|Berries|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(211, '0x00D3', nq'|Jaboca Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(799, '0x031F', nq'|Incinium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(500, '0x01F4', nq'|Park Ball|', q'|Poké Balls|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(141, '0x008D', nq'|Tunnel Mail|', q'|Mail|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(563, '0x0233', nq'|Steel Gem|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(328, '0x0148', nq'|TM01|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(38, '0x0026', nq'|Ether|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(512, '0x0200', nq'|DNA Sample|', q'|Key items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(0, '0x0000', nq'|None|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(321, '0x0141', nq'|Protector|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(792, '0x0318', nq'|Steelium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(581, '0x0245', nq'|Big Nugget|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(496, '0x01F0', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(52, '0x0034', nq'|Zinc|', q'|Medicine|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(231, '0x00E7', nq'|Lucky Egg|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(209, '0x00D1', nq'|Mystic Water|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(575, '0x023F', nq'|Pass Orb|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(56, '0x38', nq'|Teru-sama|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(830, '0x033E', nq'|Marshadium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(283, '0x011B', nq'|Smooth Rock|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(291, '0x0123', nq'|Power Lens|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(65, '0x0041', nq'|Blue Flute|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(108, '0x006C', nq'|Stardust|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(531, '0x0213', nq'|Data Card 27|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(524, '0x020C', nq'|DNA Sample|', q'|Key items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(63, '0x003F', nq'|Poké Doll|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(920, '0x0398', nq'|Fairy Memory|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(980, '0x03D4', nq'|Squirtle Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(29, '0x001D', nq'|Max Revive|', q'|Medicine|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(591, '0x024F', nq'|Casteliacone|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(449, '0x01C1', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(579, '0x0243', nq'|Battle CD 46|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(38, '0x0026', nq'|Ether|', q'|Medicine|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(333, '0x014D', nq'|TM45|', q'|TMs and HMs|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(300, '0x012C', nq'|Zap Plate|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(99, '0x63', nq'|かいがらバッヂ (ShellBadge - D)|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(312, '0x0138', nq'|TM24|', q'|TMs and HMs|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(326, '0x0146', nq'|TM38|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(52, '0x0034', nq'|Zinc|', q'|Medicine|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(172, '0x00AC', nq'|Hondew Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(226, '0x00E2', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(511, '0x01FF', nq'|Data Card 07|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(46, '0x002E', nq'|Shoal Salt|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(44, '0x002C', nq'|Sacred Ash|', q'|Medicine|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(265, '0x0109', nq'|Wide Lens|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(184, '0x00B8', nq'|Soothe Bell|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(528, '0x0210', nq'|Data Card 24|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(724, '0x02D4', nq'|Pokéblock Kit|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(291, '0x0123', nq'|Power Lens|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(225, '0x00E1', nq'|Soul Dew|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(443, '0x01BB', nq'|Vs. Seeker|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(531, '0x0213', nq'|Data Card 27|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(288, '0x0120', nq'|Sticky Barb|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(497, '0x01F1', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(228, '0x00E4', nq'|Smoke Ball|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(689, '0x02B1', nq'|Sprinklotad|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(364, '0x016C', nq'|TM37|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(183, '0xB7', nq'|Portraitmail|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(256, '0x0100', nq'|Lucky Punch|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(212, '0x00D4', nq'|Rowap Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(571, '0x023B', nq'|Battle CD 38|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(365, '0x016D', nq'|TM38|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(467, '0x01D3', nq'|Secret Key|', q'|Key items|', q'|Platinum, HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(66, '0x0042', nq'|Yellow Flute|', q'|Battle items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(565, '0x0235', nq'|Health Wing|', q'|Medicine|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(591, '0x024F', nq'|Casteliacone|', q'|Medicine|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(853, '0x0355', nq'|Red Nectar|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(477, '0x01DD', nq'|Squirt Bottle|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(810, '0x032A', nq'|Electrium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(20, '0x0014', nq'|Ice Heal|', q'|Medicine|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(513, '0x0201', nq'|Data Card 09|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(6, '0x06', nq'|Teru-sama|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(211, '0x00D3', nq'|Jaboca Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(54, '0x36', nq'|Max Revive|', 1);
insert into itemIDs(ID, HEX, NAME, GEN)
values(204, '0xCC', nq'|TM04|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(850, '0x0352', nq'|Ride Pager|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(373, '0x0175', nq'|TM46|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(899, '0x0383', nq'|???|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(253, '0x00FD', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(328, '0x0148', nq'|TM01|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(320, '0x0140', nq'|TM32|', q'|TMs and HMs|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(403, '0x0193', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(55, '0x0037', nq'|Guard Spec.|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(228, '0x00E4', nq'|Smoke Ball|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(52, '0x0034', nq'|Zinc|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(422, '0x01A6', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(104, '0x0068', nq'|Armor Fossil|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(199, '0x00C7', nq'|Babiri Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(441, '0x01B9', nq'|Red Chain|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(416, '0x01A0', nq'|TM89|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(44, '0x002C', nq'|Sacred Ash|', q'|Medicine|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(665, '0x0299', nq'|Medichamite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(49, '0x0031', nq'|Calcium|', q'|Medicine|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(208, '0x00D0', nq'|Magnet|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(291, '0x0123', nq'|Power Lens|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(327, '0x0147', nq'|TM39|', q'|TMs and HMs|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(346, '0x015A', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(37, '0x25', nq'|Poké Doll|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(256, '0x0100', nq'|Lucky Punch|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(212, '0x00D4', nq'|Rowap Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, GEN)
values(55, '0x0037', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(189, '0x00BD', nq'|Chople Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(713, '0x02C9', nq'|Bicycle|', q'|Key items|', q'|X, Y|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(413, '0x019D', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(477, '0x01DD', nq'|Squirt Bottle|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(25, '0x19', nq'|SoulBadge|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(7, '0x0007', nq'|Dive Ball|', q'|Poké Balls|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(211, '0x00D3', nq'|Jaboca Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(330, '0x014A', nq'|TM03|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(38, '0x0026', nq'|Ether|', q'|Medicine|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(382, '0x017E', nq'|TM55|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(274, '0x0112', nq'|Quick Powder|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(328, '0x0148', nq'|TM01|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(57, '0x0039', nq'|X Attack|', q'|Battle items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(462, '0x01CE', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(61, '0x003D', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(689, '0x02B1', nq'|Sprinklotad|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(236, '0x00EC', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(135, '0x0087', nq'|Adamant Orb|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(528, '0x0210', nq'|Data Card 24|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(417, '0x01A1', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(243, '0x00F3', nq'|Mystic Water|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(152, '0x0098', nq'|Pinap Berry|', q'|Berries|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(772, '0x0304', nq'|Meteorite|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(416, '0x01A0', nq'|TM89|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(44, '0x002C', nq'|Sacred Ash|', q'|Medicine|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(123, '0x007B', nq'|TM Case|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(289, '0x0121', nq'|TM01|', q'|TMs and HMs|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(11, '0x000B', nq'|Luxury Ball|', q'|Poké Balls|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(95, '0x005F', nq'|Growth Mulch|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(535, '0x0217', nq'|Blue Orb|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(213, '0x00D5', nq'|Spell Tag|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(281, '0x0119', nq'|Rm. 1 Key|', q'|Key items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(4, '0x0004', nq'|Poké Ball|', q'|Poké Balls|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(358, '0x0166', nq'|Dome Fossil|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(299, '0x012B', nq'|Splash Plate|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(222, '0x00DE', nq'|Silver Powder|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(225, '0x00E1', nq'|Soul Dew|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(487, '0x01E7', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(161, '0x00A1', nq'|Mago Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(632, '0x0278', nq'|Shiny Charm|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(212, '0x00D4', nq'|Rowap Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(521, '0x0209', nq'|DNA Sample|', q'|Key items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(144, '0x0090', nq'|Wiki Berry|', q'|Berries|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(17, '0x11', nq'|Max Potion|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(879, '0x036F', nq'|Terrain Extender|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(189, '0x00BD', nq'|Chople Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(591, '0x024F', nq'|Casteliacone|', q'|Medicine|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(200, '0xC8', nq'|TM09|', q'|TMs and HMs|', 2);
insert into itemIDs(ID, HEX, NAME, GEN)
values(903, '0x0387', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(326, '0x0146', nq'|TM38|', q'|TMs and HMs|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(16, '0x0010', nq'|Ice Heal|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(330, '0x014A', nq'|TM03|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(165, '0x00A5', nq'|Watmel Berry|', q'|Berries|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(300, '0x012C', nq'|Zap Plate|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(877, '0x036D', nq'|Gold Teeth|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(350, '0x015E', nq'|TM23|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(190, '0x00BE', nq'|Cleanse Tag|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(104, '0x0068', nq'|Big Mushroom|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(545, '0x0221', nq'|Absorb Bulb|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(199, '0x00C7', nq'|Babiri Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1048, '0x0418', nq'|Aerodactyl Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(374, '0x0176', nq'|TM47|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(111, '0x006F', nq'|Heart Scale|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(528, '0x0210', nq'|Data Card 24|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(511, '0x01FF', nq'|Data Card 07|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(44, '0x002C', nq'|Sacred Ash|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(173, '0xAD', nq'|Berry|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(310, '0x0136', nq'|Spooky Plate|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(461, '0x01CD', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(772, '0x0304', nq'|Meteorite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(407, '0x0197', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(299, '0x012B', nq'|Splash Plate|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(35, '0x0023', nq'|Max Ether|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(845, '0x034D', nq'|Sparkling Stone|', q'|Key items|', q'|Sun, Moon|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(14, '0x000E', nq'|Heal Ball|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(288, '0x0120', nq'|Sticky Barb|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GEN)
values(62, '0x003E', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(377, '0x0179', nq'|TM50|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(225, '0x00E1', nq'|Soul Dew|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(197, '0x00C5', nq'|Lucky Egg|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(911, '0x038F', nq'|Steel Memory|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(395, '0x018B', nq'|TM68|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(207, '0x00CF', nq'|Black Belt|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(415, '0x019F', nq'|TM88|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(189, '0x00BD', nq'|Chople Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(753, '0x02F1', nq'|Sceptilite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(92, '0x5C', nq'|Ylw Apricorn|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(74, '0x004A', nq'|Dire Hit|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(115, '0x0073', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(793, '0x0319', nq'|Fairium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(57, '0x0039', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(40, '0x28', nq'|Max Revive|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(317, '0x013D', nq'|TM29|', q'|TMs and HMs|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(142, '0x008E', nq'|Sitrus Berry|', q'|Berries|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(125, '0x007D', nq'|unknown|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(513, '0x0201', nq'|Data Card 09|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(82, '0x0052', nq'|Fire Stone|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(924, '0x039C', nq'|Mimikium Z|', q'|Z-Crystals|', q'|Ultra Sun, Ultra Moon|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(92, '0x005C', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(357, '0x0165', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(339, '0x0153', nq'|TM12|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(76, '0x004C', nq'|Super Repel|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(878, '0x036E', nq'|Lift Key|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(352, '0x0160', nq'|TM25|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(487, '0x01E7', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(527, '0x020F', nq'|DNA Sample|', q'|Key items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(55, '0x0037', nq'|Guard Spec.|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(713, '0x02C9', nq'|Bicycle|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(273, '0x0111', nq'|Pokéblock Case|', q'|Key items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(736, '0x02E0', nq'|S.S. Ticket|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(224, '0x00E0', nq'|Thick Club|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(401, '0x0191', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(977, '0x03D1', nq'|Quick Candy XL|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(310, '0x0136', nq'|Spooky Plate|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(434, '0x01B2', nq'|Seal Case|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(421, '0x01A5', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(395, '0x018B', nq'|TM68|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(187, '0x00BB', nq'|Rindo Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(189, '0x00BD', nq'|Chople Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(338, '0x0152', nq'|TM11|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(771, '0x0303', nq'|Meteorite|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(224, '0x00E0', nq'|Cleanse Tag|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(703, '0x02BF', nq'|Adventure Rules|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(125, '0x007D', nq'|unknown|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(940, '0x03AC', nq'|Purple Petal|', q'|Key items|', q'|Ultra Sun, Ultra Moon|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(198, '0x00C6', nq'|Colbur Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(474, '0x01DA', nq'|Clear Bell|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(451, '0x01C3', nq'|Suite Key|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(522, '0x020A', nq'|Data Card 18|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(175, '0x00AF', nq'|Cornn Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(127, '0x007F', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(615, '0x0267', nq'|Dire Hit 3|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(158, '0x009E', nq'|Tamato Berry|', q'|Berries|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(963, '0x03C3', nq'|Smart Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(730, '0x02DA', nq'|Key to Room 1|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(654, '0x028E', nq'|Boost Mulch|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(199, '0x00C7', nq'|Babiri Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(55, '0x37', nq'|Guard Spec.|', 1);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(426, '0x01AA', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(944, '0x03B0', nq'|N-Lunarizer|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(201, '0x00C9', nq'|Dragon Scale|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(528, '0x0210', nq'|Data Card 24|', q'|Items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(718, '0x02CE', nq'|Mach Bike|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(132, '0x0084', nq'|unknown|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(195, '0x00C3', nq'|Everstone|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(335, '0x014F', nq'|TM08|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(94, '0x5E', nq'|Cleanse Tag|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(532, '0x0214', nq'|Jade Orb|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(155, '0x009B', nq'|Qualot Berry|', q'|Berries|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(285, '0x011D', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(61, '0x003D', nq'|X Sp. Atk|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(493, '0x01ED', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(800, '0x0320', nq'|Primarium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(567, '0x0237', nq'|Resist Wing|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(618, '0x026A', nq'|TM93|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(296, '0x0128', nq'|TM08|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(77, '0x004D', nq'|Max Repel|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(464, '0x01D0', nq'|Secret Potion|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(422, '0x01A6', nq'|HM03|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(64, '0x0040', nq'|Protein|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(217, '0x00D9', nq'|Quick Claw|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(224, '0x00E0', nq'|Cleanse Tag|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(703, '0x02BF', nq'|Adventure Rules|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(96, '0x0060', nq'|Thunderstone|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(249, '0xF9', nq'|TM49|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(474, '0x01DA', nq'|Clear Bell|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(567, '0x0237', nq'|Resist Wing|', q'|Medicine|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(267, '0x010B', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(88, '0x58', nq'|3F (G)|', 1);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(912, '0x0390', nq'|Fire Memory|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(273, '0x0111', nq'|Flame Orb|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(217, '0x00D9', nq'|Quick Claw|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(199, '0x00C7', nq'|Babiri Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(820, '0x0334', nq'|Ghostium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(233, '0x00E9', nq'|Metal Coat|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(111, '0x006F', nq'|Heart Scale|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(405, '0x0195', nq'|TM78|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(14, '0x000E', nq'|Heal Ball|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(140, '0x008C', nq'|Thanks Mail|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(347, '0x15B', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(395, '0x018B', nq'|TM68|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(256, '0x0100', nq'|Lucky Punch|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(18, '0x0012', nq'|Parlyz Heal|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(104, '0x0068', nq'|Big Mushroom|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(77, '0x004D', nq'|Max Repel|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(388, '0x0184', nq'|TM61|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(281, '0x0119', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(422, '0x01A6', nq'|HM03|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(831, '0x033F', nq'|Aloraichium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(656, '0x0290', nq'|Gengarite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(659, '0x0293', nq'|Venusaurite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(224, '0x00E0', nq'|Cleanse Tag|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(162, '0x00A2', nq'|Aguav Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(217, '0x00D9', nq'|Quick Claw|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(268, '0x010C', nq'|Expert Belt|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(459, '0x01CB', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(522, '0x020A', nq'|Data Card 18|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(474, '0x01DA', nq'|Clear Bell|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(63, '0x003F', nq'|HP Up|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(244, '0xF4', nq'|HM02|', q'|TMs and HMs|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(567, '0x0237', nq'|Resist Wing|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(193, '0x00C1', nq'|Payapa Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(860, '0x035C', nq'|Enigmatic Card|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(173, '0x00AD', nq'|Lansat Berry|', q'|Berries|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(160, '0x00A0', nq'|Magost Berry|', q'|Berries|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(615, '0x0267', nq'|Dire Hit 3|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(198, '0x00C6', nq'|Colbur Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(688, '0x02B0', nq'|Maranga Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(664, '0x0298', nq'|Blazikenite|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(410, '0x019A', nq'|TM83|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(847, '0x034F', nq'|Zygarde Cube|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(132, '0x0084', nq'|unknown|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(405, '0x0195', nq'|TM78|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(6, '0x0006', nq'|Net Ball|', q'|Poké Balls|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(140, '0x008C', nq'|Thanks Mail|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(34, '0x22', nq'|Leaf Stone|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(188, '0x00BC', nq'|SilverPowder|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(96, '0x60', nq'|11F (G)|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(396, '0x018C', nq'|TM69|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(268, '0x010C', nq'|Expert Belt|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(183, '0x00B7', nq'|Quick Claw|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(558, '0x022E', nq'|Battle CD 25|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(422, '0x01A6', nq'|HM03|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(4, '0x0004', nq'|Poké Ball|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1046, '0x0416', nq'|Omanyte Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(754, '0x02F2', nq'|Sablenite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(16, '0x10', nq'|Hyper Potion|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(262, '0x0106', nq'|Old Rod|', q'|Key items|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(757, '0x02F5', nq'|Audinite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(469, '0x01D5', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(72, '0x0048', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(193, '0x00C1', nq'|Payapa Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(640, '0x0280', nq'|Assault Vest|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(259, '0x0103', nq'|Stick|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(418, '0x01A2', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(378, '0x017A', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(755, '0x02F3', nq'|Altarianite|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(902, '0x0386', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(615, '0x0267', nq'|Dire Hit 3|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(25, '0x19', nq'|Teru-sama|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(220, '0x00DC', nq'|Sea Incense|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(332, '0x014C', nq'|TM44|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(242, '0xF2', nq'|TM50|', q'|TMs and HMs|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(212, '0xD4', nq'|TM21|', q'|TMs and HMs|', 2);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(436, '0x01B4', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(807, '0x0327', nq'|Normalium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(365, '0x016D', nq'|TM38|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(146, '0x0092', nq'|Bridge Mail T|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(664, '0x0298', nq'|Blazikenite|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(83, '0x0053', nq'|Thunderstone|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(272, '0x0110', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(561, '0x0231', nq'|Dragon Gem|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(419, '0x01A3', nq'|TM92|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(372, '0x0174', nq'|TM45|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(225, '0x00E1', nq'|Stick|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(410, '0x019A', nq'|TM83|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(231, '0xE7', nq'|TM39|', q'|TMs and HMs|', 2);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(622, '0x026E', nq'|???|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(145, '0x91', nq'|Teru-sama|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(405, '0x0195', nq'|TM78|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(404, '0x0194', nq'|TM77|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(540, '0x021C', nq'|Ein File C|', q'|Key items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(299, '0x012B', nq'|Splash Plate|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(246, '0x00F6', nq'|Never-Melt Ice|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(352, '0x0160', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(396, '0x018C', nq'|TM69|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(790, '0x0316', nq'|Dragonium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(268, '0x010C', nq'|Expert Belt|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(322, '0x0142', nq'|Electirizer|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(350, '0x015E', nq'|TM23|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(154, '0x009A', nq'|Kelpsy Berry|', q'|Berries|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(300, '0x012C', nq'|Zap Plate|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(65, '0x0041', nq'|Iron|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(4, '0x0004', nq'|Poké Ball|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(350, '0x015E', nq'|Poké Flute|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(340, '0x0154', nq'|TM13|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(381, '0x017D', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(418, '0x01A2', nq'|TM91|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(217, '0x00D9', nq'|Quick Claw|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(289, '0x0121', nq'|TM01|', q'|TMs and HMs|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(38, '0x0026', nq'|Ether|', q'|Medicine|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(812, '0x032C', nq'|Icium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(48, '0x30', nq'|Card Key|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(193, '0x00C1', nq'|Payapa Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(27, '0x001B', nq'|Soda Pop|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(171, '0x00AB', nq'|Petaya Berry|', q'|Berries|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(640, '0x0280', nq'|Assault Vest|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(259, '0x0103', nq'|Stick|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(75, '0x004B', nq'|X Attack|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(108, '0x006C', nq'|Dusk Stone|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(69, '0x0045', nq'|PP Up|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(236, '0x00EC', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(189, '0x00BD', nq'|Amulet Coin|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(355, '0x0163', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(414, '0x019E', nq'|TM87|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(538, '0x021A', nq'|Eviolite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(365, '0x016D', nq'|TM38|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(540, '0x021C', nq'|Rocky Helmet|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(405, '0x0195', nq'|TM78|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1010, '0x03F2', nq'|Slowpoke Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(217, '0x00D9', nq'|Silk Scarf|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(299, '0x012B', nq'|Splash Plate|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(222, '0x00DE', nq'|Silver Powder|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(1, '0x0001', nq'|Master Ball|', q'|Poké Balls|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(396, '0x018C', nq'|TM69|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(566, '0x0236', nq'|Muscle Wing|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(103, '0x67', nq'|SlowpokeTail|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(140, '0x008C', nq'|Thanks Mail|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(22, '0x0016', nq'|Paralyze Heal|', q'|Medicine|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(213, '0x00D5', nq'|Spell Tag|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(448, '0x01C0', nq'|Sprayduck|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(830, '0x033E', nq'|Marshadium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(752, '0x02F0', nq'|Swampertite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(340, '0x0154', nq'|TM13|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(131, '0x0083', nq'|Fab Mail|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(418, '0x01A2', nq'|TM91|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(522, '0x020A', nq'|Data Card 18|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(109, '0x006D', nq'|Star Piece|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(193, '0x00C1', nq'|Payapa Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(261, '0x0105', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(849, '0x0351', nq'|Ice Stone|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(398, '0x018E', nq'|TM71|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(209, '0x00D1', nq'|Mystic Water|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(89, '0x59', nq'|4F (G)|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(28, '0x001C', nq'|Lemonade|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(324, '0x0144', nq'|Dubious Disc|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(368, '0x0170', nq'|Rainbow Pass|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(74, '0x004A', nq'|Dire Hit|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(950, '0x03B6', nq'|Roto Bargain|', q'|Ultra Sun, Ultra Moon|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(88, '0x58', nq'|SilverPowder|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(59, '0x003B', nq'|X Speed|', q'|Battle items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(28, '0x1C', nq'|Iron|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(43, '0x002B', nq'|White Flute|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(404, '0x0194', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(618, '0x026A', nq'|TM93|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(200, '0x00C8', nq'|Leftovers|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(51, '0x33', nq'|Poké Doll|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(215, '0xD7', nq'|TM24|', q'|TMs and HMs|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(324, '0x0144', nq'|TM36|', q'|TMs and HMs|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(73, '0x49', nq'|Quick Claw|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, GEN)
values(427, '0x01AB', nq'|unknown|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(240, '0x00F0', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(418, '0x01A2', nq'|TM91|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(592, '0x0250', nq'|Dire Hit 2|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(69, '0x0045', nq'|PP Up|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(119, '0x0077', nq'|Chill Drive|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(298, '0x012A', nq'|TM10|', q'|TMs and HMs|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(252, '0x00FC', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(670, '0x029E', nq'|Scizorite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1054, '0x041E', nq'|Mewtwo Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(89, '0x0059', nq'|Big Pearl|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(943, '0x03AF', nq'|N-Solarizer|', q'|Key items|', q'|Ultra Sun, Ultra Moon|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(88, '0x0058', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(631, '0x0277', nq'|Oval Charm|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(762, '0x02FA', nq'|Pidgeotite|', q'|Items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(118, '0x0076', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(922, '0x039A', nq'|Lunalium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(536, '0x0218', nq'|Ylw ID Badge|', q'|Key items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(348, '0x015C', nq'|TM21|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(286, '0x011E', nq'|Grip Claw|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(833, '0x0341', nq'|Eevium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(753, '0x02F1', nq'|Sceptilite|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(404, '0x0194', nq'|TM77|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(524, '0x020C', nq'|Krane Memo 2|', q'|Key items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(242, '0xF2', nq'|TM42|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(220, '0x00DC', nq'|Sea Incense|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(83, '0x53', nq'|Max Elixer|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(170, '0xAA', nq'|Polkadot Bow|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(535, '0x0217', nq'|Blue Orb|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(246, '0xF6', nq'|TM46|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(256, '0x0100', nq'|Lucky Punch|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(868, '0x0364', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(72, '0x0048', nq'|Red Shard|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(518, '0x0206', nq'|Data Card 14|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(482, '0x01E2', nq'|Silver Wing|', q'|Key items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(889, '0x0379', nq'|Beach Glass|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(67, '0x0043', nq'|Red Flute|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(78, '0x4E', nq'|Super Rod|', 1);
insert into itemIDs(ID, HEX, NAME, GEN)
values(72, '0x48', nq'|Silph Scope|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(504, '0x01F8', nq'|Gonzap's Key|', q'|Key items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(225, '0xE1', nq'|TM25|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(93, '0x5D', nq'|Grn Apricorn|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(282, '0x011A', nq'|Rm. 2 Key|', q'|Key items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(224, '0x00E0', nq'|Cleanse Tag|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(217, '0x00D9', nq'|Quick Claw|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(257, '0x0101', nq'|Green Scarf|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(409, '0x0199', nq'|TM82|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(279, '0x0117', nq'|Lagging Tail|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(297, '0x0129', nq'|Choice Specs|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(741, '0x02E5', nq'|Magma Suit|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(362, '0x016A', nq'|TM35|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(76, '0x004C', nq'|Super Repel|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(13, '0x000D', nq'|Potion|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(480, '0x01E0', nq'|Pass|', q'|Key items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, GEN)
values(93, '0x5D', nq'|8F (G)|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(246, '0x00F6', nq'|NeverMeltIce|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(335, '0x014F', nq'|TM08|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(688, '0x02B0', nq'|Maranga Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(21, '0x0015', nq'|Awakening|', q'|Medicine|', 4);
insert into itemIDs(ID, HEX, NAME, GEN)
values(132, '0x0084', nq'|unknown|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(528, '0x0210', nq'|Voice Case 1|', q'|Key items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(182, '0x00B6', nq'|Exp. Share|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(248, '0x00F8', nq'|Twisted Spoon|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1030, '0x0406', nq'|Tangela Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(83, '0x0053', nq'|Thunder Stone|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(506, '0x01FA', nq'|Data Card 02|', q'|Items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(212, '0x00D4', nq'|NeverMeltIce|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(438, '0x01B6', nq'|Works Key|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(68, '0x0044', nq'|Rare Candy|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(580, '0x0244', nq'|Battle CD 47|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(312, '0x0138', nq'|TM24|', q'|TMs and HMs|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(132, '0x0084', nq'|???|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(212, '0xD4', nq'|TM12|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(142, '0x008E', nq'|Steel Mail|', q'|Mail|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(591, '0x024F', nq'|Casteliacone|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(682, '0x02AA', nq'|Manectite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(657, '0x0291', nq'|Gardevoirite|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(347, '0x015B', nq'|TM20|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(650, '0x028A', nq'|Safety Goggles|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(28, '0x1C', nq'|EarthBadge|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(76, '0x004C', nq'|Super Repel|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(198, '0xC6', nq'|TM07|', q'|TMs and HMs|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(313, '0x0139', nq'|TM25|', q'|TMs and HMs|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(552, '0x0228', nq'|Ice Gem|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(52, '0x34', nq'|X Speed|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(289, '0x0121', nq'|TM01|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(246, '0x00F6', nq'|NeverMeltIce|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(689, '0x02B1', nq'|Sprinklotad|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(672, '0x02A0', nq'|Aerodactylite|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(784, '0x0310', nq'|Groundium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(727, '0x02D7', nq'|Scanner|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(90, '0x005A', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(230, '0x00E6', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(47, '0x002F', nq'|Iron|', q'|Medicine|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(583, '0x0247', nq'|Comet Shard|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1043, '0x0413', nq'|Ditto Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(726, '0x02D6', nq'|Eon Ticket|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(21, '0x0015', nq'|Awakening|', q'|Medicine|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(288, '0x0120', nq'|Sticky Barb|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(9, '0x0009', nq'|Repeat Ball|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(397, '0x018D', nq'|TM70|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(431, '0x01AF', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(4, '0x0004', nq'|Poké Ball|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(518, '0x0206', nq'|Data Card 14|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(438, '0x01B6', nq'|Works Key|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(268, '0x010C', nq'|Expert Belt|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(642, '0x0282', nq'|Prof's Letter|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(63, '0x003F', nq'|Poké Doll|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GEN)
values(872, '0x0368', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(574, '0x023E', nq'|Battle CD 41|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(391, '0x0187', nq'|TM64|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(178, '0x00B2', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(552, '0x0228', nq'|Battle CD 19|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(51, '0x0033', nq'|Green Shard|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(114, '0x72', nq'|RageCandyBar|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1032, '0x0408', nq'|Horsea Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(76, '0x004C', nq'|Super Repel|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(718, '0x02CE', nq'|Mach Bike|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(929, '0x03A1', nq'|Ultranecrozium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(510, '0x01FE', nq'|Data Card 06|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(552, '0x0228', nq'|Ice Gem|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(672, '0x02A0', nq'|Aerodactylite|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(65, '0x0041', nq'|Iron|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(195, '0x00C3', nq'|Charti Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(23, '0x0017', nq'|Full Restore|', q'|Medicine|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(583, '0x0247', nq'|Comet Shard|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(404, '0x0194', nq'|TM77|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(97, '0x0061', nq'|Water Stone|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(319, '0x013F', nq'|Luck Incense|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(955, '0x03BB', nq'|Roto Stealth|', q'|Ultra Sun, Ultra Moon|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(631, '0x0277', nq'|Oval Charm|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(47, '0x002F', nq'|Iron|', q'|Medicine|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(59, '0x003B', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(264, '0x0108', nq'|Yellow Scarf|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(200, '0x00C8', nq'|Leftovers|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(18, '0x0012', nq'|Parlyz Heal|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(347, '0x015B', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(69, '0x0045', nq'|White Flute|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(143, '0x008F', nq'|Figy Berry|', q'|Berries|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(361, '0x0169', nq'|TM34|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(438, '0x01B6', nq'|Works Key|', q'|Key items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(518, '0x0206', nq'|Data Card 14|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(268, '0x010C', nq'|Expert Belt|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(824, '0x0338', nq'|Fairium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(11, '0x000B', nq'|Luxury Ball|', q'|Poké Balls|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(691, '0x02B3', nq'|TM97|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(60, '0x003C', nq'|X Accuracy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(366, '0x016E', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(562, '0x0232', nq'|Dark Gem|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(206, '0x00CE', nq'|Lansat Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(352, '0x0160', nq'|TM25|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(67, '0x0043', nq'|Calcium|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(308, '0x0134', nq'|Insect Plate|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(542, '0x021E', nq'|Red Card|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(136, '0x88', nq'|Teru-sama|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(34, '0x0022', nq'|Ether|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(552, '0x0228', nq'|Ice Gem|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(487, '0x01E7', nq'|Ylw Apricorn|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GEN)
values(100, '0x0064', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(828, '0x033C', nq'|Primarium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(534, '0x0216', nq'|Red Orb|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(117, '0x0075', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(415, '0x019F', nq'|TM88|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(203, '0x00CB', nq'|Soft Sand|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(636, '0x027C', nq'|Dropped Item|', q'|Key items|', q'|Black 2, White 2|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(586, '0x024A', nq'|Relic Gold|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(766, '0x02FE', nq'|Mega Cuff|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(118, '0x0076', nq'|Burn Drive|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(589, '0x024D', nq'|Battle CD 56|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(130, '0x0082', nq'|Dream Mail|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(222, '0xDE', nq'|TM22|', 1);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(763, '0x02FB', nq'|Glalitite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(886, '0x0376', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(156, '0x009C', nq'|Hondew Berry|', q'|Berries|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(338, '0x0152', nq'|TM50|', q'|TMs and HMs|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(177, '0x00B1', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(10, '0x000A', nq'|Timer Ball|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(237, '0x00ED', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(371, '0x0173', nq'|TM44|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(562, '0x0232', nq'|Dark Gem|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(385, '0x0181', nq'|TM58|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(906, '0x038A', nq'|Poison Memory|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(114, '0x0072', nq'|unknown|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(308, '0x0134', nq'|Insect Plate|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(230, '0x00E6', nq'|Focus Band|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(205, '0x00CD', nq'|Apicot Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, GEN)
values(130, '0x0082', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(43, '0x002B', nq'|White Flute|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(84, '0x0054', nq'|Max Repel|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(243, '0xF3', nq'|TM43|', 1);
insert into itemIDs(ID, HEX, NAME, GEN)
values(426, '0x01AA', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(408, '0x0198', nq'|TM81|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(602, '0x025A', nq'|X Defend 3|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(496, '0x01F0', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(583, '0x0247', nq'|Comet Shard|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(32, '0x0020', nq'|Heal Powder|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(687, '0x02AF', nq'|Kee Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(697, '0x02B9', nq'|Intriguing Stone|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(673, '0x02A1', nq'|Lucarionite|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(503, '0x01F7', nq'|Machine Part|', q'|Key items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(336, '0x0150', nq'|TM09|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(471, '0x01D7', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(909, '0x038D', nq'|Bug Memory|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(9, '0x09', nq'|Pokédex|', 1);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(216, '0x00D8', nq'|Exp. Share|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(642, '0x0282', nq'|Prof's Letter|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(826, '0x033A', nq'|Decidium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(20, '0x0014', nq'|Max Potion|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(121, '0x79', nq'|EnergyPowder|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(70, '0x46', nq'|Clear Bell|', q'|Key items|', q'|Crystal|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(205, '0x00CD', nq'|Miracle Seed|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(102, '0x0066', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(465, '0x01D1', nq'|Vs. Recorder|', q'|Key items|', q'|Platinum, HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(137, '0x0089', nq'|Grass Mail|', q'|Mail|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(205, '0x00CD', nq'|Apicot Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(378, '0x017A', nq'|TM51|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(930, '0x03A2', nq'|Mimikium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(40, '0x0028', nq'|Elixir|', q'|Medicine|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(362, '0x016A', nq'|TM35|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(103, '0x0067', nq'|TinyMushroom|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(898, '0x0382', nq'|???|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(153, '0x0099', nq'|Pomeg Berry|', q'|Berries|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(147, '0x0093', nq'|Iapapa Berry|', q'|Berries|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(389, '0x0185', nq'|TM62|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(316, '0x013C', nq'|TM28|', q'|TMs and HMs|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(301, '0x012D', nq'|Meadow Plate|', q'|Items|', 5);
insert into itemIDs(GEN)
values(7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(310, '0x0136', nq'|Spooky Plate|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(173, '0x00AD', nq'|Lansat Berry|', q'|Berries|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(362, '0x016A', nq'|TM35|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(244, '0x00F4', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(288, '0x0120', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(168, '0x00A8', nq'|Liechi Berry|', q'|Berries|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(68, '0x0044', nq'|Rare Candy|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(687, '0x02AF', nq'|Kee Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(44, '0x002C', nq'|Berry Juice|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(587, '0x024B', nq'|Battle CD 54|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(274, '0x0112', nq'|Quick Powder|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(513, '0x0201', nq'|Data Card 09|', q'|Items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(492, '0x01EC', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(177, '0x00B1', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(21, '0x15', nq'|Max Elixer|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(19, '0x0013', nq'|Burn Heal|', q'|Medicine|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(59, '0x003B', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(53, '0x35', nq'|X Special|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(167, '0xA7', nq'|Normal Box|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(333, '0x014D', nq'|TM06|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(245, '0x00F5', nq'|Poison Barb|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(410, '0x019A', nq'|TM83|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(356, '0x0164', nq'|TM29|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(255, '0x00FF', nq'|Blue Scarf|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(319, '0x013F', nq'|TM31|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(267, '0x010B', nq'|Wise Glasses|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(78, '0x004E', nq'|Escape Rope|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(287, '0x011F', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(114, '0x0072', nq'|unknown|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(33, '0x21', nq'|Thunderstone|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(657, '0x0291', nq'|Gardevoirite|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(496, '0x01F0', nq'|Love Ball|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(169, '0x00A9', nq'|Ganlon Berry|', q'|Berries|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(205, '0x00CD', nq'|Apicot Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(129, '0x0081', nq'|Tropic Mail|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(362, '0x016A', nq'|TM35|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(223, '0x00DF', nq'|Amulet Coin|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(369, '0x0171', nq'|TM42|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(949, '0x03B5', nq'|Roto Hatch|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(782, '0x030E', nq'|Fightinium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(72, '0x0048', nq'|Red Shard|', q'|Items|', 6);
insert into itemIDs(GEN)
values(6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(310, '0x0136', nq'|Spooky Plate|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(235, '0x00EB', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(301, '0x012D', nq'|Meadow Plate|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(326, '0x0146', nq'|Razor Claw|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(778, '0x030A', nq'|Waterium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(70, '0x0046', nq'|Shoal Salt|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(415, '0x019F', nq'|TM88|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(336, '0x0150', nq'|TM09|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(105, '0x69', nq'|Stick|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(504, '0x01F8', nq'|RageCandyBar|', q'|Medicine|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(672, '0x02A0', nq'|Aerodactylite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(4, '0x04', nq'|Poké Ball|', 1);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(435, '0x01B3', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(495, '0x01EF', nq'|Heavy Ball|', q'|Poké Balls|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(556, '0x022C', nq'|Battle CD 23|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(514, '0x0202', nq'|Data Card 10|', q'|Items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(497, '0x01F1', nq'|Friend Ball|', q'|Poké Balls|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(148, '0x0094', nq'|BridgeMail M|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(41, '0x0029', nq'|Red Flute|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(116, '0x0074', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(958, '0x03BE', nq'|Roto Boost|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(21, '0x0015', nq'|Awakening|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(743, '0x02E7', nq'|Pair of Tickets|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(361, '0x0169', nq'|TM34|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(331, '0x014B', nq'|TM04|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(582, '0x0246', nq'|Battle CD 49|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(578, '0x0242', nq'|Prop Case|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(114, '0x0072', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(78, '0x004E', nq'|Escape Rope|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(488, '0x01E8', nq'|Green Apricorn|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(412, '0x019C', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(402, '0x0192', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(233, '0xE9', nq'|TM33|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(99, '0x0063', nq'|Root Fossil|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(205, '0x00CD', nq'|Apicot Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(92, '0x005C', nq'|Nugget|', q'|Items|', 4);
insert into itemIDs(GEN)
values(5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(652, '0x028C', nq'|Rich Mulch|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(495, '0x01EF', nq'|Heavy Ball|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(372, '0x0174', nq'|TM45|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(108, '0x006C', nq'|Stardust|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(526, '0x020E', nq'|Data Card 22|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(2, '0x0002', nq'|Ultra Ball|', q'|Poké Balls|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(78, '0x004E', nq'|X Accuracy|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(769, '0x0301', nq'|Salamencite|', q'|Items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(552, '0x0228', nq'|Ice Gem|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(301, '0x012D', nq'|Meadow Plate|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(117, '0x0075', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(881, '0x0371', nq'|Electric Seed|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(151, '0x0097', nq'|Pecha Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(253, '0xFD', nq'|HM11|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(52, '0x0034', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(673, '0x02A1', nq'|Lucarionite|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(419, '0x01A3', nq'|TM92|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(336, '0x0150', nq'|TM09|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(46, '0x2E', nq'|Fresh Water|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(253, '0x00FD', nq'|Shell Bell|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(549, '0x0225', nq'|Water Gem|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(19, '0x0013', nq'|Burn Heal|', q'|Medicine|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(438, '0x01B6', nq'|Works Key|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(438, '0x01B6', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(392, '0x0188', nq'|TM65|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(182, '0x00B6', nq'|Exp. Share|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(53, '0x0035', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(465, '0x01D1', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(145, '0x0091', nq'|Bridge Mail D|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(242, '0x00F2', nq'|Magnet|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(610, '0x0262', nq'|X Accuracy 6|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(100, '0x64', nq'|おじぞうバッヂ (JizoBadge - D)|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(488, '0x01E8', nq'|Green Apricorn|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(94, '0x005E', nq'|Honey|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(335, '0x014F', nq'|TM08|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(468, '0x01D4', nq'|Apricorn Box|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(430, '0x01AE', nq'|Rule Book|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(452, '0x01C4', nq'|Oak's Letter|', q'|Key items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(935, '0x03A7', nq'|Orange Petal|', q'|Key items|', q'|Ultra Sun, Ultra Moon|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(857, '0x0359', nq'|Sun Flute|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(44, '0x002C', nq'|Sacred Ash|', q'|Medicine|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(113, '0x0071', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(563, '0x0233', nq'|Steel Gem|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(40, '0x0028', nq'|Yellow Flute|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(258, '0x0102', nq'|Thick Club|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(343, '0x0157', nq'|HM05|', q'|TMs and HMs|', 3);
insert into itemIDs(GEN)
values(4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(290, '0x0122', nq'|Power Belt|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(652, '0x028C', nq'|Rich Mulch|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(526, '0x020E', nq'|Data Card 22|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(900, '0x0384', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(420, '0x01A4', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(196, '0x00C4', nq'|Focus Band|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(128, '0x0080', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(9, '0x0009', nq'|Repeat Ball|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(132, '0x0084', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(358, '0x0166', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(390, '0x0186', nq'|TM63|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(673, '0x02A1', nq'|Lucarionite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1028, '0x0404', nq'|Rhyhorn Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(509, '0x01FD', nq'|Data Card 05|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(19, '0x0013', nq'|Burn Heal|', q'|Medicine|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(371, '0x0173', nq'|TM44|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(145, '0x0091', nq'|Bridge Mail D|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(342, '0x0156', nq'|TM15|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(292, '0x0124', nq'|Power Band|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(491, '0x01EB', nq'|Black Apricorn|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(608, '0x0260', nq'|X Defense 6|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(377, '0x0179', nq'|TM50|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(610, '0x0262', nq'|X Accuracy 6|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(362, '0x016A', nq'|VS Seeker|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(331, '0x014B', nq'|TM43|', q'|TMs and HMs|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(505, '0x01F9', nq'|Data Card 01|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(921, '0x0399', nq'|Solganium Z|', q'|Z-Crystals|', q'|Ultra Sun, Ultra Moon|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(440, '0x01B8', nq'|Galactic Key|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(230, '0x00E6', nq'|Focus Band|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(430, '0x01AE', nq'|Rule Book|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(504, '0x01F8', nq'|R-Disk|', q'|Key items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(773, '0x0305', nq'|Key Stone|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(78, '0x004E', nq'|Escape Rope|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(337, '0x0151', nq'|TM49|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(99, '0x0063', nq'|Root Fossil|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(258, '0x0102', nq'|Thick Club|', q'|Items|', 7);
insert into itemIDs(GEN)
values(3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(378, '0x017A', nq'|TM51|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(475, '0x01DB', nq'|Card Key|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(290, '0x0122', nq'|Power Belt|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(336, '0x0150', nq'|TM48|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(499, '0x01F3', nq'|Sport Ball|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(339, '0x0153', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(72, '0x0048', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(363, '0x016B', nq'|TM36|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(244, '0x00F4', nq'|Sharp Beak|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(129, '0x0081', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(419, '0x01A3', nq'|TM92|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(932, '0x03A4', nq'|Kommonium Z|', q'|Z-Crystals|', q'|Ultra Sun, Ultra Moon|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(27, '0x001B', nq'|Full Heal|', q'|Medicine|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(390, '0x0186', nq'|TM63|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(146, '0x0092', nq'|Bridge Mail T|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(573, '0x023D', nq'|Battle CD 40|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(491, '0x01EB', nq'|Black Apricorn|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(333, '0x014D', nq'|TM06|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(478, '0x01DE', nq'|Red Scale|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(269, '0x010D', nq'|Light Clay|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(73, '0x0049', nq'|Blue Shard|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(6, '0x0006', nq'|Net Ball|', q'|Poké Balls|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(149, '0x0095', nq'|Bluk Berry|', q'|Berries|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(137, '0x0089', nq'|Aspear Berry|', q'|Berries|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(371, '0x0173', nq'|TM44|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(923, '0x039B', nq'|Ultranecrozium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(623, '0x026F', nq'|Gram 1|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(444, '0x01BC', nq'|Coin Case|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(577, '0x0241', nq'|Battle CD 44|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(789, '0x0315', nq'|Ghostium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(292, '0x0124', nq'|Power Band|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(77, '0x004D', nq'|X Speed|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(244, '0x00F4', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(112, '0x0070', nq'|Griseous Orb|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(219, '0x00DB', nq'|Mental Herb|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(187, '0x00BB', nq'|King's Rock|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(448, '0x01C0', nq'|Sprayduck|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(126, '0x007E', nq'|Clothing Trunk|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(99, '0x0063', nq'|Root Fossil|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(258, '0x0102', nq'|Thick Club|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(110, '0x006E', nq'|Nugget|', q'|Items|', 3);
insert into itemIDs(GEN)
values(2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(475, '0x01DB', nq'|Card Key|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(242, '0x00F2', nq'|Magnet|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(495, '0x01EF', nq'|Heavy Ball|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(220, '0x00DC', nq'|Choice Band|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(176, '0x00B0', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(290, '0x0122', nq'|Power Belt|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(547, '0x0223', nq'|Eject Button|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(727, '0x02D7', nq'|Scanner|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(887, '0x0377', nq'|Marble|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(296, '0x0128', nq'|TM08|', q'|TMs and HMs|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(145, '0x0091', nq'|Space Mail|', q'|Mail|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(118, '0x0076', nq'|Burn Drive|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(329, '0x0149', nq'|TM41|', q'|TMs and HMs|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(146, '0x0092', nq'|Bridge Mail T|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(50, '0x0032', nq'|Rare Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(333, '0x014D', nq'|TM06|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(357, '0x0165', nq'|TM30|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(116, '0x0074', nq'|Douse Drive|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(227, '0x00E3', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(6, '0x0006', nq'|Net Ball|', q'|Poké Balls|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(168, '0xA8', nq'|Gorgeous Box|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(205, '0x00CD', nq'|Miracle Seed|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(371, '0x0173', nq'|TM44|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(722, '0x02D2', nq'|Soot Sack|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(255, '0x00FF', nq'|Blue Scarf|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(610, '0x0262', nq'|X Accuracy 6|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(366, '0x016E', nq'|Teachy TV|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(190, '0x00BE', nq'|Kebia Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(524, '0x020C', nq'|Data Card 20|', q'|Items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(199, '0x00C7', nq'|Metal Coat|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(379, '0x017B', nq'|TM52|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(623, '0x026F', nq'|Gram 1|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(118, '0x0076', nq'|Burn Drive|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(58, '0x003A', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(292, '0x0124', nq'|Power Band|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(971, '0x03CB', nq'|Quick Candy L|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(376, '0x0178', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(873, '0x0369', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(313, '0x0139', nq'|TM25|', q'|TMs and HMs|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(20, '0x14', nq'|Repel|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(184, '0x00B8', nq'|Occa Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(112, '0x0070', nq'|Griseous Orb|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(579, '0x0243', nq'|Dragon Skull|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(660, '0x0294', nq'|Charizardite X|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(219, '0x00DB', nq'|Mental Herb|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(452, '0x01C4', nq'|Oak's Letter|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(939, '0x03AB', nq'|Yellow Petal|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(260, '0x0104', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(484, '0x01E4', nq'|Mystery Egg|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(143, '0x008F', nq'|Heart Mail|', q'|Mail|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(334, '0x014E', nq'|TM07|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(708, '0x02C4', nq'|Lumiose Galette|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(72, '0x0048', nq'|Red Shard|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(273, '0x0111', nq'|Flame Orb|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(835, '0x0343', nq'|Pikashunium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(118, '0x0076', nq'|Burn Drive|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(959, '0x03BF', nq'|Roto Catch|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(401, '0x0191', nq'|TM74|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(270, '0x010E', nq'|Life Orb|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(182, '0x00B6', nq'|Durin Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(47, '0x002F', nq'|Iron|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(164, '0x00A4', nq'|Pamtre Berry|', q'|Berries|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(390, '0x0186', nq'|TM63|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(447, '0x01BF', nq'|Super Rod|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(54, '0x0036', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(78, '0x004E', nq'|Escape Rope|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(599, '0x0257', nq'|X Speed 3|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(900, '0x0384', nq'|Lure|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(73, '0x0049', nq'|Blue Shard|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(379, '0x017B', nq'|TM52|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(29, '0x001D', nq'|Moomoo Milk|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(342, '0x0156', nq'|TM15|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(618, '0x026A', nq'|TM93|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(476, '0x01DC', nq'|Basement Key|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(207, '0xCF', nq'|TM16|', q'|TMs and HMs|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(292, '0x0124', nq'|Power Band|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(326, '0x0146', nq'|TM38|', q'|TMs and HMs|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(85, '0x55', nq'|Red Apricorn|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(587, '0x024B', nq'|Relic Vase|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(467, '0x01D3', nq'|Secret Key|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(184, '0x00B8', nq'|Occa Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(775, '0x0307', nq'|Eon Flute|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(109, '0x006D', nq'|Dawn Stone|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(181, '0x00B5', nq'|Watmel Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(88, '0x0058', nq'|Pearl|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(34, '0x0022', nq'|EnergyPowder|', q'|Medicine|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(519, '0x0207', nq'|Data Card 15|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(358, '0x0166', nq'|TM31|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(286, '0x011E', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(572, '0x023C', nq'|Cover Fossil|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(363, '0x016B', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(142, '0x8E', nq'|Teru-sama|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(475, '0x01DB', nq'|Card Key|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(72, '0x0048', nq'|Red Shard|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(223, '0x00DF', nq'|Amulet Coin|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(269, '0x010D', nq'|Light Clay|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(143, '0x8F', nq'|Metal Coat|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(51, '0x0033', nq'|PP Up|', q'|Medicine|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1041, '0x0411', nq'|Magikarp Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(301, '0x012D', nq'|Meadow Plate|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(24, '0x18', nq'|Water Stone|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, GEN)
values(108, '0x6C', nq'|ひよこ (Chick - D)|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(345, '0x0159', nq'|HM07|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(47, '0x002F', nq'|Iron|', q'|Medicine|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(243, '0x00F3', nq'|Mystic Water|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(893, '0x037D', nq'|Tropical Shell|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(270, '0x010E', nq'|Life Orb|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(429, '0x01AD', nq'|Loot Sack|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(379, '0x017B', nq'|TM52|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(352, '0x0160', nq'|TM25|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(535, '0x0217', nq'|Blue Orb|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(192, '0x00C0', nq'|DeepSeaTooth|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(62, '0x003E', nq'|X Sp. Def|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(537, '0x0219', nq'|Time Flute|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(409, '0x0199', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(86, '0x0056', nq'|Repel|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(460, '0x01CC', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(941, '0x03AD', nq'|Rainbow Flower|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(706, '0x02C2', nq'|Makeup Bag|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(742, '0x02E6', nq'|Aqua Suit|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(409, '0x0199', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(62, '0x3E', nq'|Lemonade|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(623, '0x026F', nq'|Gram 1|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(253, '0x00FD', nq'|Shell Bell|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(433, '0x01B1', nq'|Journal|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(33, '0x21', nq'|X Accuracy|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(161, '0x00A1', nq'|Mago Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(33, '0x0021', nq'|Moomoo Milk|', q'|Medicine|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(470, '0x01D6', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(3, '0x0003', nq'|Great Ball|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(540, '0x021C', nq'|Rocky Helmet|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(223, '0x00DF', nq'|Metal Powder|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(587, '0x024B', nq'|Relic Vase|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(521, '0x0209', nq'|Data Card 17|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(775, '0x0307', nq'|Eon Flute|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(761, '0x02F9', nq'|Steelixite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(790, '0x0316', nq'|Dragonium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(184, '0x00B8', nq'|Occa Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(433, '0x01B1', nq'|Journal|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(232, '0x00E8', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(94, '0x005E', nq'|Honey|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(181, '0x00B5', nq'|Watmel Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(358, '0x0166', nq'|TM31|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(787, '0x0313', nq'|Buginium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(456, '0x01C8', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(539, '0x021B', nq'|Battle CD 06|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(314, '0x013A', nq'|Odd Incense|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(487, '0x01E7', nq'|Yellow Apricorn|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(519, '0x0207', nq'|Cry Analyzer|', q'|Key items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(334, '0x014E', nq'|TM07|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(72, '0x0048', nq'|Red Shard|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(774, '0x0306', nq'|Meteorite Shard|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(374, '0x0176', nq'|TM47|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(338, '0x0152', nq'|TM50|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(512, '0x0200', nq'|Data Card 08|', q'|Items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(436, '0x01B4', nq'|Seal Bag|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(347, '0x015B', nq'|TM20|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(449, '0x01C1', nq'|Poffin Case|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(578, '0x0242', nq'|Prop Case|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(511, '0x01FF', nq'|Poké Snack|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(352, '0x0160', nq'|TM25|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(19, '0x13', nq'|Escape Rope|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(60, '0x003C', nq'|X Accuracy|', q'|Battle items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(62, '0x003E', nq'|X Sp. Def|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(48, '0x0030', nq'|Red Shard|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(443, '0x01BB', nq'|Vs. Seeker|', q'|Key items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(428, '0x01AC', nq'|Explorer Kit|', q'|Key items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(875, '0x036B', nq'|Parcel|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(421, '0x01A5', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(130, '0x0082', nq'|unknown|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(64, '0x0040', nq'|Fluffy Tail|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(253, '0x00FD', nq'|Shell Bell|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(111, '0x6F', nq'|ゴールド (Gold - D)|', 1);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(175, '0x00AF', nq'|Cornn Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(735, '0x02DF', nq'|Devon Scope|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(454, '0x01C6', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(670, '0x029E', nq'|Scizorite|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(544, '0x0220', nq'|Battle CD 11|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(56, '0x0038', nq'|Dire Hit|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(379, '0x017B', nq'|TM52|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(526, '0x020E', nq'|Krane Memo 4|', q'|Key items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1040, '0x0410', nq'|Tauros Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(161, '0x00A1', nq'|Mago Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(21, '0x0015', nq'|Awakening|', q'|Medicine|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(308, '0x0134', nq'|Insect Plate|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(323, '0x0143', nq'|TM35|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(356, '0x0164', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(769, '0x0301', nq'|Salamencite|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(540, '0x021C', nq'|Rocky Helmet|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(98, '0x0062', nq'|Leaf Stone|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(452, '0x01C4', nq'|Oak's Letter|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(58, '0x003A', nq'|X Defend|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(590, '0x024E', nq'|Relic Crown|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(184, '0x00B8', nq'|Occa Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(230, '0x00E6', nq'|Focus Band|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(433, '0x01B1', nq'|Journal|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(236, '0xEC', nq'|TM44|', q'|TMs and HMs|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(358, '0x0166', nq'|TM31|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(181, '0x00B5', nq'|Watmel Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(449, '0x01C1', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(334, '0x014E', nq'|TM07|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(203, '0x00CB', nq'|Salac Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(715, '0x02CB', nq'|Fairy Gem|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(906, '0x038A', nq'|Poison Memory|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(223, '0xDF', nq'|TM23|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(38, '0x0026', nq'|Lava Cookie|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(436, '0x01B4', nq'|Seal Bag|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(270, '0x010E', nq'|Life Orb|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(183, '0x00B7', nq'|Belue Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(62, '0x003E', nq'|X Sp. Def|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(143, '0x008F', nq'|Figy Berry|', q'|Berries|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(988, '0x03DC', nq'|Sandshrew Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(47, '0x002F', nq'|Shoal Shell|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(253, '0x00FD', nq'|Shell Bell|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(155, '0x009B', nq'|Qualot Berry|', q'|Berries|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(242, '0x00F2', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(179, '0xB3', nq'|Teru-sama|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(351, '0x015F', nq'|TM24|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(412, '0x019C', nq'|TM85|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(403, '0x0193', nq'|TM76|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(726, '0x02D6', nq'|Eon Ticket|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1021, '0x03FD', nq'|Voltorb Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1029, '0x0405', nq'|Chansey Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(926, '0x039E', nq'|Kommonium Z|', q'|Z-Crystals|', q'|Ultra Sun, Ultra Moon|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(337, '0x0151', nq'|TM10|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(230, '0x00E6', nq'|Focus Band|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(521, '0x0209', nq'|Data Card 17|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(753, '0x02F1', nq'|Sceptilite|', q'|Items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(951, '0x03B7', nq'|Roto Prize Money|', q'|Ultra Sun, Ultra Moon|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(120, '0x78', nq'|Teru-sama|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(519, '0x0207', nq'|Data Card 15|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(580, '0x0244', nq'|BalmMushroom|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(735, '0x02DF', nq'|Devon Scope|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(258, '0x0102', nq'|Thick Club|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(744, '0x02E8', nq'|Mega Bracelet|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(595, '0x0253', nq'|X Sp. Def 2|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(269, '0x010D', nq'|Light Clay|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(642, '0x0282', nq'|Prof's Letter|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(40, '0x0028', nq'|Elixir|', q'|Medicine|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(956, '0x03BC', nq'|Roto HP Restore|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(374, '0x0176', nq'|TM47|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(173, '0x00AD', nq'|Grepa Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(436, '0x01B4', nq'|Seal Bag|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(870, '0x0366', nq'|???|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(594, '0x0252', nq'|X Special 2|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(838, '0x0346', nq'|???|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(183, '0x00B7', nq'|Belue Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(0, '0x0000', nq'|Nothing|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1052, '0x041C', nq'|Moltres Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(175, '0x00AF', nq'|Cornn Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(565, '0x0235', nq'|Health Wing|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(142, '0x008E', nq'|Sitrus Berry|', q'|Berries|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1049, '0x0419', nq'|Snorlax Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(908, '0x038C', nq'|Rock Memory|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(328, '0x0148', nq'|TM01|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(444, '0x01BC', nq'|Coin Case|', q'|Key items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(34, '0x0022', nq'|Energy Powder|', q'|Medicine|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(450, '0x01C2', nq'|Bicycle|', q'|Key items|', q'|X, Y|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(375, '0x0177', nq'|TM48|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(77, '0x004D', nq'|Max Repel|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(180, '0x00B4', nq'|Pamtre Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(317, '0x013D', nq'|TM29|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(412, '0x019C', nq'|TM85|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(627, '0x0273', nq'|Medal Box|', q'|Key items|', q'|Black 2, White 2|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(161, '0x00A1', nq'|Mago Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(56, '0x0038', nq'|Dire Hit|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(490, '0x01EA', nq'|Wht Apricorn|', q'|Items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(3, '0x0003', nq'|Great Ball|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(378, '0x017A', nq'|TM51|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(540, '0x021C', nq'|Rocky Helmet|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(657, '0x0291', nq'|Gardevoirite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(296, '0x0128', nq'|Big Root|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(78, '0x004E', nq'|Escape Rope|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(457, '0x01C9', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(119, '0x0077', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(804, '0x0324', nq'|Snorlium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(616, '0x0268', nq'|Light Stone|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(64, '0x0040', nq'|Fluffy Tail|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(735, '0x02DF', nq'|Devon Scope|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(708, '0x02C4', nq'|Lumiose Galette|', q'|Medicine|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(677, '0x02A5', nq'|Absolite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(146, '0x0092', nq'|Aguav Berry|', q'|Berries|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(40, '0x0028', nq'|Elixir|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(632, '0x0278', nq'|Shiny Charm|', q'|Key items|', q'|Black 2, White 2|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(374, '0x0176', nq'|TM47|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(273, '0x0111', nq'|Flame Orb|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(173, '0x00AD', nq'|Grepa Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(424, '0x01A8', nq'|HM05|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(578, '0x0242', nq'|Prop Case|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(86, '0x0056', nq'|Repel|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(183, '0x00B7', nq'|Belue Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(951, '0x03B7', nq'|Roto Prize Money|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(310, '0x0136', nq'|TM22|', q'|TMs and HMs|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(295, '0x0127', nq'|TM07|', q'|TMs and HMs|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(191, '0x00BF', nq'|Shuca Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(175, '0x00AF', nq'|Cornn Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(130, '0x0082', nq'|unknown|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(303, '0x012F', nq'|TM15|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(300, '0x012C', nq'|TM12|', q'|TMs and HMs|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(8, '0x08', nq'|Safari Ball|', 1);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(329, '0x0149', nq'|TM02|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(494, '0x01EE', nq'|Lure Ball|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(282, '0x011A', nq'|Icy Rock|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(77, '0x004D', nq'|Max Repel|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(908, '0x038C', nq'|Rock Memory|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(31, '0x1F', nq'|Old Amber|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(628, '0x0274', nq'|DNA Splicers|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(117, '0x75', nq'|Miracle Seed|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(425, '0x01A9', nq'|HM06|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(499, '0x01F3', nq'|Sport Ball|', q'|Poké Balls|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(383, '0x017F', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(388, '0x0184', nq'|TM61|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(795, '0x031B', nq'|Bottle Cap|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(35, '0x23', nq'|HP Up|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(499, '0x01F3', nq'|Sport Ball|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(452, '0x01C4', nq'|Oak's Letter|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(378, '0x017A', nq'|TM51|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(279, '0x0117', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(296, '0x0128', nq'|Big Root|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GEN)
values(114, '0x0072', nq'|unknown|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(307, '0x0133', nq'|Mind Plate|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(595, '0x0253', nq'|X Sp. Def 2|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(386, '0x0182', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(351, '0x015F', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(406, '0x0196', nq'|TM79|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(603, '0x025B', nq'|X Attack 3|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(396, '0x018C', nq'|TM69|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(249, '0x00F9', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(51, '0x0033', nq'|PP Up|', q'|Medicine|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(616, '0x0268', nq'|Light Stone|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(192, '0x00C0', nq'|DeepSeaTooth|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(223, '0x00DF', nq'|Amulet Coin|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(520, '0x0208', nq'|DNA Sample|', q'|Key items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(273, '0x0111', nq'|Flame Orb|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(183, '0x00B7', nq'|Belue Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(198, '0xC6', nq'|HM03|', 1);
insert into itemIDs(ID, HEX, NAME, GEN)
values(239, '0xEF', nq'|TM39|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(243, '0xF3', nq'|HM01|', q'|TMs and HMs|', 2);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(497, '0x01F1', nq'|Friend Ball|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(366, '0x016E', nq'|TM39|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(172, '0x00AC', nq'|Apicot Berry|', q'|Berries|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(228, '0x00E4', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(634, '0x027A', nq'|Grubby Hanky|', q'|Key items|', q'|Black 2, White 2|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(400, '0x0190', nq'|TM73|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(282, '0x011A', nq'|Icy Rock|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(263, '0x0107', nq'|Good Rod|', q'|Key items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(321, '0x0141', nq'|TM33|', q'|TMs and HMs|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(180, '0x00B4', nq'|Pamtre Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(351, '0x015F', nq'|TM24|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(476, '0x01DC', nq'|Basement Key|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(427, '0x01AB', nq'|unknown|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(202, '0x00CA', nq'|Light Ball|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(628, '0x0274', nq'|DNA Splicers|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(843, '0x034B', nq'|Professor's Mask|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(429, '0x01AD', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(472, '0x01D8', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(329, '0x0149', nq'|TM41|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(159, '0x009F', nq'|Cornn Berry|', q'|Berries|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(388, '0x0184', nq'|TM61|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(17, '0x0011', nq'|Potion|', q'|Medicine|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(397, '0x018D', nq'|TM70|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(199, '0x00C7', nq'|Metal Coat|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(746, '0x02EA', nq'|Mega Glasses|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(298, '0x012A', nq'|Flame Plate|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(491, '0x01EB', nq'|Blk Apricorn|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(27, '0x001B', nq'|Soda Pop|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(296, '0x0128', nq'|Big Root|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(21, '0x0015', nq'|Hyper Potion|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(70, '0x0046', nq'|Shoal Salt|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(414, '0x019E', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(404, '0x0194', nq'|TM77|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(217, '0xD9', nq'|TM26|', q'|TMs and HMs|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(373, '0x0175', nq'|Ruby (item)|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(616, '0x0268', nq'|Light Stone|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, GEN)
values(75, '0x4B', nq'|Exp. All|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(425, '0x01A9', nq'|HM06|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(51, '0x0033', nq'|PP Up|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(347, '0x15B', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(313, '0x0139', nq'|Iron Plate|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(40, '0x0028', nq'|Elixir|', q'|Medicine|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(321, '0x0141', nq'|TM33|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(33, '0x0021', nq'|Revival Herb|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(548, '0x0224', nq'|Battle CD 15|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(318, '0x013E', nq'|TM30|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(73, '0x0049', nq'|Guard Spec.|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(76, '0x004C', nq'|X Defend|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(477, '0x01DD', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(517, '0x0205', nq'|DNA Sample|', q'|Key items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(130, '0x0082', nq'|unknown|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(894, '0x037E', nq'|Leaf Letter|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(445, '0x01BD', nq'|Old Rod|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(371, '0x0173', nq'|AuroraTicket|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(400, '0x0190', nq'|TM73|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(521, '0x0209', nq'|Data Card 17|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(627, '0x0273', nq'|Medal Box|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(337, '0x0151', nq'|TM10|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(298, '0x012A', nq'|Flame Plate|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(376, '0x0178', nq'|TM49|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(253, '0x00FD', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(555, '0x022B', nq'|Battle CD 22|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(622, '0x026E', nq'|???|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(620, '0x026C', nq'|TM95|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(444, '0x01BC', nq'|Coin Case|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(670, '0x029E', nq'|Scizorite|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(119, '0x77', nq'|Focus Band|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(1, '0x0001', nq'|Master Ball|', q'|Poké Balls|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(476, '0x01DC', nq'|Basement Key|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(214, '0x00D6', nq'|TwistedSpoon|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(998, '0x03E6', nq'|Diglett Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(128, '0x0080', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(696, '0x02B8', nq'|Mega Ring|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(296, '0x0128', nq'|Big Root|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(433, '0x01B1', nq'|Journal|', q'|Key items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(740, '0x02E4', nq'|Contest Costume|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(70, '0x0046', nq'|Shoal Salt|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(44, '0x002C', nq'|Berry Juice|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(142, '0x008E', nq'|Like Mail|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(376, '0x0178', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(181, '0x00B5', nq'|Watmel Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(141, '0x008D', nq'|Lum Berry|', q'|Berries|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(34, '0x0022', nq'|EnergyPowder|', q'|Medicine|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(990, '0x03DE', nq'|Nidoran♂ Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(350, '0x015E', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(313, '0x0139', nq'|Iron Plate|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(196, '0x00C4', nq'|Focus Band|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(747, '0x02EB', nq'|Mega Anchor|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(223, '0x00DF', nq'|Amulet Coin|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(608, '0x0260', nq'|X Defend 6|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(328, '0x0148', nq'|TM01|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(519, '0x0207', nq'|DNA Sample|', q'|Key items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(352, '0x0160', nq'|Bike Voucher|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(379, '0x017B', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(564, '0x0234', nq'|Normal Gem|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(12, '0x0C', nq'|Awakening|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(481, '0x01E1', nq'|Machine Part|', q'|Key items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(460, '0x01CC', nq'|Coupon 1|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(778, '0x030A', nq'|Waterium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(445, '0x01BD', nq'|Old Rod|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(631, '0x0277', nq'|Oval Charm|', q'|Key items|', q'|Black 2, White 2|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(477, '0x01DD', nq'|Squirt Bottle|', q'|Key items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(173, '0x00AD', nq'|Grepa Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(919, '0x0397', nq'|Dark Memory|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(337, '0x0151', nq'|TM10|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(298, '0x012A', nq'|Flame Plate|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(235, '0x00EB', nq'|Dragon Scale|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(957, '0x03BD', nq'|Roto PP Restore|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(127, '0x007F', nq'|unknown|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(280, '0x0118', nq'|Meteorite|', q'|Key items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(647, '0x0287', nq'|Sachet|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(622, '0x026E', nq'|???|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(654, '0x028E', nq'|Boost Mulch|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(319, '0x013F', nq'|TM31|', q'|TMs and HMs|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(504, '0x01F8', nq'|Rage Candy Bar|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(70, '0x0046', nq'|Shoal Salt|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(2, '0x0002', nq'|Ultra Ball|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(595, '0x0253', nq'|X Sp. Def 2|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(945, '0x03B1', nq'|N-Solarizer|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(313, '0x0139', nq'|Iron Plate|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(219, '0xDB', nq'|TM28|', q'|TMs and HMs|', 2);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(388, '0x0184', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(487, '0x01E7', nq'|Yellow Apricorn|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(375, '0x0177', nq'|TM48|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(279, '0x0117', nq'|Lagging Tail|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(22, '0x0016', nq'|Paralyze Heal|', q'|Medicine|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(505, '0x01F9', nq'|L-Disk|', q'|Key items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(21, '0x15', nq'|BoulderBadge|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(436, '0x01B4', nq'|Seal Bag|', q'|Key items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(3, '0x03', nq'|BrightPowder|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(802, '0x0322', nq'|Marshadium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(244, '0x00F4', nq'|Sharp Beak|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(507, '0x01FB', nq'|Data Card 03|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(146, '0x0092', nq'|Aguav Berry|', q'|Berries|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(426, '0x01AA', nq'|HM07|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(236, '0x00EC', nq'|Light Ball|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(43, '0x002B', nq'|White Flute|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1015, '0x03F7', nq'|Grimer Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(647, '0x0287', nq'|Sachet|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(343, '0x0157', nq'|TM16|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(460, '0x01CC', nq'|Coupon 1|', q'|Key items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(522, '0x020A', nq'|Data Card 18|', q'|Items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(664, '0x0298', nq'|Blazikenite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(445, '0x01BD', nq'|Old Rod|', q'|Key items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(156, '0x009C', nq'|Hondew Berry|', q'|Berries|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(262, '0x0106', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(173, '0x00AD', nq'|Grepa Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(93, '0x005D', nq'|Heart Scale|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(164, '0x00A4', nq'|Razz Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(774, '0x0306', nq'|Meteorite Shard|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(235, '0x00EB', nq'|Dragon Scale|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(104, '0x0068', nq'|Big Mushroom|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(298, '0x012A', nq'|Flame Plate|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(14, '0x000E', nq'|Heal Ball|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(444, '0x01BC', nq'|Coin Case|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(32, '0x0020', nq'|Lemonade|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(56, '0x0038', nq'|Dire Hit|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(180, '0x00B4', nq'|Pamtre Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(82, '0x52', nq'|King's Rock|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(489, '0x01E9', nq'|Pnk Apricorn|', q'|Items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(351, '0x015F', nq'|TM24|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(308, '0x0134', nq'|Insect Plate|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(504, '0x01F8', nq'|Rage Candy Bar|', q'|Medicine|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(36, '0x0024', nq'|Elixir|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(75, '0x004B', nq'|X Attack|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(323, '0x0143', nq'|TM35|', q'|TMs and HMs|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(355, '0x0163', nq'|Card Key|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(70, '0x0046', nq'|Shoal Salt|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(960, '0x03C0', nq'|Health Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(13, '0x000D', nq'|Dusk Ball|', q'|Poké Balls|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(212, '0x00D4', nq'|NeverMeltIce|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(375, '0x0177', nq'|TM48|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(149, '0x0095', nq'|Cheri Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(629, '0x0275', nq'|DNA Splicers|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(23, '0x17', nq'|Thunderstone|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(477, '0x01DD', nq'|Squirt Bottle|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(507, '0x01FB', nq'|Data Card 03|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(747, '0x02EB', nq'|Mega Anchor|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(429, '0x01AD', nq'|Loot Sack|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1009, '0x03F1', nq'|Ponyta Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(142, '0x008E', nq'|Like Mail|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(264, '0x0108', nq'|Yellow Scarf|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(992, '0x03E0', nq'|Vulpix Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(268, '0x010C', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(610, '0x0262', nq'|X Accuracy 6|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(445, '0x01BD', nq'|Old Rod|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(340, '0x0154', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(358, '0x0166', nq'|TM31|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(93, '0x005D', nq'|Heart Scale|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(758, '0x02F6', nq'|Metagrossite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(266, '0x010A', nq'|Muscle Band|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(235, '0x00EB', nq'|Dragon Scale|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(209, '0x00D1', nq'|Micle Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(760, '0x02F8', nq'|Slowbronite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(39, '0x0027', nq'|Blue Flute|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(82, '0x0052', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(390, '0x0186', nq'|TM63|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(208, '0xD0', nq'|TM17|', q'|TMs and HMs|', 2);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(471, '0x01D7', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(518, '0x0206', nq'|Data Card 14|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(214, '0x00D6', nq'|TwistedSpoon|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(338, '0x0152', nq'|TM11|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(412, '0x019C', nq'|TM85|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(125, '0x7D', nq'|Hard Stone|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, GEN)
values(6, '0x06', nq'|Bicycle|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(276, '0x0114', nq'|Zoom Lens|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(142, '0x008E', nq'|Like Mail|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(954, '0x03BA', nq'|Roto Encounter|', q'|Ultra Sun, Ultra Moon|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(461, '0x01CD', nq'|Coupon 2|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(221, '0x00DD', nq'|King's Rock|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(13, '0x000D', nq'|Dusk Ball|', q'|Poké Balls|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(98, '0x0062', nq'|Gooey Mulch|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(427, '0x01AB', nq'|HM08|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(109, '0x006D', nq'|Dawn Stone|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(430, '0x01AE', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(559, '0x022F', nq'|Battle CD 26|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(108, '0x006C', nq'|Stardust|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(318, '0x013E', nq'|TM30|', q'|TMs and HMs|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(630, '0x0276', nq'|Permit|', q'|Key items|', q'|Black 2, White 2|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(3, '0x0003', nq'|Great Ball|', q'|Poké Balls|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(429, '0x01AD', nq'|Loot Sack|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(61, '0x003D', nq'|X Special|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(273, '0x0111', nq'|Flame Orb|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(513, '0x0201', nq'|DNA Sample|', q'|Key items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(525, '0x020D', nq'|Data Card 21|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(958, '0x03BE', nq'|Roto Boost|', q'|Ultra Sun, Ultra Moon|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(235, '0x00EB', nq'|Dragon Scale|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(108, '0x006C', nq'|Dusk Stone|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(209, '0x00D1', nq'|Micle Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(119, '0x0077', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(320, '0x0140', nq'|Pure Incense|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(161, '0x00A1', nq'|Rabuta Berry|', q'|Berries|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(853, '0x0355', nq'|Red Nectar|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(73, '0x0049', nq'|Guard Spec.|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(32, '0x0020', nq'|Lemonade|', q'|Medicine|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(2, '0x0002', nq'|Ultra Ball|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(527, '0x020F', nq'|Data Card 23|', q'|Items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(194, '0x00C2', nq'|Smoke Ball|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(432, '0x01B0', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(181, '0x00B5', nq'|Watmel Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(162, '0x00A2', nq'|Aguav Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(109, '0x006D', nq'|Dawn Stone|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(138, '0x008A', nq'|Leppa Berry|', q'|Berries|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(716, '0x02CC', nq'|Mega Charm|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(842, '0x034A', nq'|Fishing Rod|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(393, '0x0189', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(375, '0x0177', nq'|TM48|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(51, '0x0033', nq'|PP Up|', q'|Medicine|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(149, '0x0095', nq'|Cheri Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(482, '0x01E2', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(507, '0x01FB', nq'|Data Card 03|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(274, '0x0112', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(429, '0x01AD', nq'|Loot Sack|', q'|Key items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(242, '0x00F2', nq'|Magnet|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(25, '0x0019', nq'|Hyper Potion|', q'|Medicine|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(428, '0x01AC', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(705, '0x02C1', nq'|Lens Case|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(264, '0x0108', nq'|Yellow Scarf|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(137, '0x0089', nq'|Aspear Berry|', q'|Berries|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(819, '0x0333', nq'|Rockium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(68, '0x0044', nq'|Black Flute|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(108, '0x006C', nq'|Dusk Stone|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(242, '0x00F2', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(347, '0x015B', nq'|TM20|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(32, '0x0020', nq'|Lemonade|', q'|Medicine|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(240, '0x00F0', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(796, '0x031C', nq'|Gold Bottle Cap|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(433, '0x01B1', nq'|Journal|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(601, '0x0259', nq'|X Sp. Def 3|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(560, '0x0230', nq'|Ghost Gem|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(162, '0x00A2', nq'|Nomel Berry|', q'|Berries|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(457, '0x01C9', nq'|Contest Pass|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(544, '0x0220', nq'|Binding Band|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(798, '0x031E', nq'|Decidium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(878, '0x036E', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(149, '0x0095', nq'|Cheri Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(41, '0x29', nq'|Dome Fossil|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(237, '0x00ED', nq'|Soft Sand|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(44, '0x002C', nq'|Berry Juice|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(25, '0x0019', nq'|Hyper Potion|', q'|Medicine|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(308, '0x0134', nq'|Insect Plate|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(242, '0x00F2', nq'|Magnet|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(495, '0x01EF', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(710, '0x02C6', nq'|Jaw Fossil|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(705, '0x02C1', nq'|Lens Case|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(514, '0x0202', nq'|Excite Scent|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(420, '0x01A4', nq'|HM01|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(38, '0x0026', nq'|Ether|', q'|Medicine|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(335, '0x014F', nq'|TM47|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(510, '0x01FE', nq'|Data Card 06|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(194, '0x00C2', nq'|Smoke Ball|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(108, '0x006C', nq'|Dusk Stone|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(856, '0x0358', nq'|Purple Nectar|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(256, '0x0100', nq'|Pink Scarf|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(422, '0x01A6', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(210, '0xD2', nq'|TM10|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(347, '0x015B', nq'|TM20|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(97, '0x0061', nq'|Water Stone|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(524, '0x020C', nq'|Data Card 20|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(721, '0x02D1', nq'|Devon Parts|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(504, '0x01F8', nq'|Rage Candy Bar|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(266, '0x010A', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(618, '0x026A', nq'|TM93|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(522, '0x020A', nq'|DNA Sample|', q'|Key items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(457, '0x01C9', nq'|Contest Pass|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(109, '0x006D', nq'|Dawn Stone|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(741, '0x02E5', nq'|Magma Suit|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(484, '0x01E4', nq'|Mystery Egg|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(0, '0x0000', nq'|Nothing|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(98, '0x0062', nq'|Gooey Mulch|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(304, '0x0130', nq'|TM16|', q'|TMs and HMs|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(313, '0x0139', nq'|Iron Plate|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(486, '0x01E6', nq'|Blue Apricorn|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(508, '0x01FC', nq'|Data Card 04|', q'|Items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(25, '0x0019', nq'|Hyper Potion|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(616, '0x0268', nq'|Light Stone|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(237, '0x00ED', nq'|Soft Sand|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(242, '0x00F2', nq'|Magnet|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(966, '0x03C6', nq'|Health Candy L|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(127, '0x007F', nq'|unknown|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(163, '0x00A3', nq'|Iapapa Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(562, '0x0232', nq'|Dark Gem|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(343, '0x0157', nq'|TM16|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(710, '0x02C6', nq'|Jaw Fossil|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1006, '0x03EE', nq'|Bellsprout Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(813, '0x032D', nq'|Fightinium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(281, '0x0119', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(489, '0x01E9', nq'|Pnk Apricorn|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(25, '0x0019', nq'|Hyper Potion|', q'|Medicine|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(362, '0x016A', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(108, '0x006C', nq'|Dusk Stone|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(68, '0x0044', nq'|Black Flute|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(117, '0x0075', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(498, '0x01F2', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(845, '0x034D', nq'|Sparkling Stone|', q'|Key items|', q'|Ultra Sun, Ultra Moon|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(196, '0xC4', nq'|TM05|', q'|TMs and HMs|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(32, '0x0020', nq'|Lemonade|', q'|Medicine|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(728, '0x02D8', nq'|Go-Goggles|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(160, '0x00A0', nq'|Magost Berry|', q'|Berries|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(89, '0x0059', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(166, '0x00A6', nq'|Nanab Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(55, '0x0037', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(16, '0x0010', nq'|Ice Heal|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(290, '0x0122', nq'|TM02|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(470, '0x01D6', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(499, '0x01F3', nq'|Sport Ball|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(839, '0x0347', nq'|???|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(421, '0x01A5', nq'|HM02|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(269, '0x010D', nq'|Light Clay|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(921, '0x0399', nq'|Solganium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(502, '0x01F6', nq'|GB Sounds|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(332, '0x014C', nq'|TM44|', q'|TMs and HMs|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(563, '0x0233', nq'|Battle CD 30|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(3, '0x0003', nq'|Great Ball|', q'|Poké Balls|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(508, '0x01FC', nq'|System Lever|', q'|Key items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(473, '0x01D9', nq'|Slowpoke Tail|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(484, '0x01E4', nq'|Mystery Egg|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(291, '0x0123', nq'|TM03|', q'|TMs and HMs|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(431, '0x01AF', nq'|Poké Radar|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(237, '0x00ED', nq'|Soft Sand|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(250, '0xFA', nq'|HM08|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(950, '0x03B6', nq'|Roto Bargain|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(374, '0x0176', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(624, '0x0270', nq'|Gram 2|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(253, '0x00FD', nq'|Shell Bell|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(349, '0x015D', nq'|TM22|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(979, '0x03D3', nq'|Charmander Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(593, '0x0251', nq'|Battle CD 60|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(156, '0x009C', nq'|Persim Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(355, '0x0163', nq'|TM28|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(97, '0x61', nq'|Wht Apricorn|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(474, '0x01DA', nq'|Clear Bell|', q'|Key items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(93, '0x005D', nq'|Heart Scale|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(68, '0x0044', nq'|Black Flute|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(505, '0x01F9', nq'|Data ROM|', q'|Key items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(237, '0x00ED', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(788, '0x0314', nq'|Rockium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(353, '0x0161', nq'|TM26|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(490, '0x01EA', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(529, '0x0211', nq'|Data Card 25|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(85, '0x0055', nq'|Leaf Stone|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(551, '0x0227', nq'|Battle CD 18|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(531, '0x0213', nq'|Voice Case 4|', q'|Key items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(249, '0x00F9', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(94, '0x005E', nq'|Honey|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(342, '0x0156', nq'|HM04|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(560, '0x0230', nq'|Ghost Gem|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(695, '0x02B7', nq'|Power Plant Pass|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(57, '0x0039', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(26, '0x001A', nq'|Fresh Water|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(98, '0x0062', nq'|Gooey Mulch|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(431, '0x01AF', nq'|Poké Radar|', q'|Key items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(22, '0x0016', nq'|Paralyze Heal|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(174, '0x00AE', nq'|Starf Berry|', q'|Berries|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(662, '0x0296', nq'|Mewtwonite X|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(87, '0x0057', nq'|Big Mushroom|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(37, '0x0025', nq'|Revival Herb|', q'|Medicine|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1035, '0x040B', nq'|Mr. Mime Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(251, '0x00FB', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(506, '0x01FA', nq'|D-Disk|', q'|Key items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(42, '0x2A', nq'|Super Repel|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(525, '0x020D', nq'|Data Card 21|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(349, '0x015D', nq'|TM22|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(343, '0x0157', nq'|TM16|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(668, '0x029C', nq'|Banettite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(646, '0x0286', nq'|Whipped Dream|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(891, '0x037B', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(282, '0x011A', nq'|Icy Rock|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(441, '0x01B9', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(93, '0x005D', nq'|Heart Scale|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(256, '0x0100', nq'|Pink Scarf|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(370, '0x0172', nq'|TM43|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1005, '0x03ED', nq'|Machop Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(351, '0x015F', nq'|TM24|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(549, '0x0225', nq'|Water Gem|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(736, '0x02E0', nq'|S.S. Ticket|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(679, '0x02A7', nq'|Alakazite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(353, '0x0161', nq'|TM26|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(79, '0x004F', nq'|Repel|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(154, '0x009A', nq'|Leppa Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(412, '0x019C', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(314, '0x013A', nq'|Odd Incense|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(727, '0x02D7', nq'|Scanner|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(164, '0x00A4', nq'|Razz Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(177, '0x00B1', nq'|Rabuta Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(93, '0x005D', nq'|Sun Stone|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(209, '0x00D1', nq'|Micle Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(432, '0x01B0', nq'|Point Card|', q'|Key items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(179, '0x00B3', nq'|BrightPowder|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(12, '0x0C', nq'|Burn Heal|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(68, '0x0044', nq'|Black Flute|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(180, '0x00B4', nq'|Pamtre Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(766, '0x02FE', nq'|Mega Cuff|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(758, '0x02F6', nq'|Metagrossite|', q'|Items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(734, '0x02DE', nq'|Storage Key|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(27, '0x1B', nq'|VolcanoBadge|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(279, '0x0117', nq'|Lagging Tail|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(200, '0x00C8', nq'|Leftovers|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(162, '0x00A2', nq'|Aguav Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(932, '0x03A4', nq'|Kommonium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(858, '0x035A', nq'|Moon Flute|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(425, '0x01A9', nq'|HM06|', q'|TMs and HMs|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(596, '0x0254', nq'|X Defense 2|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(98, '0x0062', nq'|Gooey Mulch|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(269, '0x010D', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(737, '0x02E1', nq'|HM07|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(81, '0x0051', nq'|Moon Stone|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(408, '0x0198', nq'|TM81|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(534, '0x0216', nq'|Battle CD 01|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(264, '0x0108', nq'|Yellow Scarf|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GEN)
values(226, '0x00E2', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(124, '0x007C', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(213, '0xD5', nq'|TM13|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(525, '0x020D', nq'|Data Card 21|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(240, '0x00F0', nq'|Black Glasses|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(889, '0x0379', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(146, '0x92', nq'|Leftovers|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(251, '0x00FB', nq'|Silk Scarf|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(112, '0x0070', nq'|Griseous Orb|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(123, '0x007B', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(827, '0x033B', nq'|Incinium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(170, '0x00AA', nq'|Salac Berry|', q'|Berries|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(815, '0x032F', nq'|Groundium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(549, '0x0225', nq'|Water Gem|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(154, '0x9A', nq'|Teru-sama|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(374, '0x0176', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(353, '0x0161', nq'|TM26|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(314, '0x013A', nq'|Odd Incense|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(79, '0x004F', nq'|Repel|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(46, '0x002E', nq'|Shoal Salt|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(73, '0x0049', nq'|Blue Shard|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(8, '0x0008', nq'|Nest Ball|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(311, '0x0137', nq'|TM23|', q'|TMs and HMs|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(506, '0x01FA', nq'|Data Card 02|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(209, '0x00D1', nq'|Micle Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(337, '0x0151', nq'|TM10|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(70, '0x0046', nq'|Zinc|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(533, '0x0215', nq'|Disc Case|', q'|Key items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(260, '0x0104', nq'|Red Scarf|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(400, '0x0190', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(269, '0x010D', nq'|Light Clay|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(393, '0x0189', nq'|TM66|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(162, '0x00A2', nq'|Aguav Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(61, '0x003D', nq'|X Sp. Atk|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(675, '0x02A3', nq'|Kangaskhanite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(170, '0x00AA', nq'|Kelpsy Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(796, '0x031C', nq'|Gold Bottle Cap|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(279, '0x0117', nq'|Lagging Tail|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(596, '0x0254', nq'|X Defense 2|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(87, '0x0057', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(510, '0x01FE', nq'|Data Card 06|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(755, '0x02F3', nq'|Altarianite|', q'|Items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(247, '0x00F7', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(858, '0x035A', nq'|Moon Flute|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(124, '0x007C', nq'|unknown|', 5);
insert into itemIDs(ID, HEX, NAME, GEN)
values(127, '0x007F', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(864, '0x0360', nq'|Golden Nanab Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(69, '0x45', nq'|Coin Case|', 1);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(429, '0x01AD', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(349, '0x015D', nq'|TM22|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(681, '0x02A9', nq'|Mawilite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(156, '0x009C', nq'|Persim Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(122, '0x007A', nq'|Harbor Mail|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(337, '0x0151', nq'|TM49|', q'|TMs and HMs|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(307, '0x0133', nq'|TM19|', q'|TMs and HMs|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(361, '0x0169', nq'|TM34|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(108, '0x6C', nq'|Magnet|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1002, '0x03EA', nq'|Growlithe Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(526, '0x020E', nq'|Data Card 22|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GEN)
values(65, '0x41', nq'|X Attack|', 1);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(103, '0x0067', nq'|Old Amber|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(399, '0x018F', nq'|TM72|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(634, '0x027A', nq'|Grubby Hanky|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(430, '0x01AE', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(243, '0x00F3', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(495, '0x01EF', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(271, '0x010F', nq'|Power Herb|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(317, '0x013D', nq'|Wave Incense|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(391, '0x0187', nq'|TM64|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(703, '0x02BF', nq'|Adventure Rules|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(781, '0x030D', nq'|Icium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(94, '0x005E', nq'|Honey|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(640, '0x0280', nq'|Assault Vest|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(560, '0x0230', nq'|Ghost Gem|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(162, '0x00A2', nq'|Aguav Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(874, '0x036A', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(457, '0x01C9', nq'|Contest Pass|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1019, '0x03FB', nq'|Drowzee Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(581, '0x0245', nq'|Big Nugget|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(137, '0x89', nq'|Teru-sama|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(918, '0x0396', nq'|Dragon Memory|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(443, '0x01BB', nq'|Vs. Seeker|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(344, '0x0158', nq'|TM17|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(157, '0x009D', nq'|Lum Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(127, '0x007F', nq'|unknown|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(529, '0x0211', nq'|Voice Case 2|', q'|Key items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(366, '0x016E', nq'|TM39|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(245, '0xF5', nq'|TM45|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(97, '0x0061', nq'|Stable Mulch|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(86, '0x56', nq'|TinyMushroom|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(14, '0x000E', nq'|Heal Ball|', q'|Poké Balls|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(361, '0x0169', nq'|TM34|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(35, '0x0023', nq'|Max Ether|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(478, '0x01DE', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(499, '0x01F3', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(353, '0x0161', nq'|TM26|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(247, '0xF7', nq'|HM05|', q'|TMs and HMs|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(180, '0x00B4', nq'|Pamtre Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(79, '0x004F', nq'|Repel|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(154, '0x009A', nq'|Leppa Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(58, '0x3A', nq'|Dire Hit|', 1);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(834, '0x0342', nq'|Mewnium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(439, '0x01B7', nq'|Old Charm|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(27, '0x001B', nq'|Full Heal|', q'|Medicine|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(314, '0x013A', nq'|TM26|', q'|TMs and HMs|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(533, '0x0215', nq'|Lock Capsule|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(481, '0x01E1', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(516, '0x0204', nq'|DNA Sample|', q'|Key items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(144, '0x0090', nq'|Snow Mail|', q'|Mail|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(153, '0x0099', nq'|Aspear Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(254, '0x00FE', nq'|Red Scarf|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(279, '0x0117', nq'|Lagging Tail|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(484, '0x01E4', nq'|Mystery Egg|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(75, '0x4B', nq'|Gold Leaf|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(510, '0x01FE', nq'|Data Card 06|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(47, '0x2F', nq'|Leaf Stone|', 1);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(902, '0x0386', nq'|Max Lure|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(295, '0x0127', nq'|Shed Shell|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(456, '0x01C8', nq'|S.S. Ticket|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(756, '0x02F4', nq'|Galladite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(443, '0x01BB', nq'|Vs. Seeker|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(447, '0x01BF', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(344, '0x0158', nq'|TM17|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(387, '0x0183', nq'|TM60|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(138, '0x008A', nq'|Favored Mail|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(425, '0x01A9', nq'|HM06|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(240, '0x00F0', nq'|Black Glasses|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(156, '0x009C', nq'|Persim Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, GEN)
values(201, '0xC9', nq'|TM01|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(97, '0x0061', nq'|Stable Mulch|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(311, '0x0137', nq'|Draco Plate|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(255, '0x00FF', nq'|Lax Incense|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(192, '0x00C0', nq'|Coba Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(103, '0x67', nq'|なかよしバッヂ (FriendshipBadge - D)|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(904, '0x0388', nq'|Fighting Memory|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(733, '0x02DD', nq'|Key to Room 6|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(26, '0x001A', nq'|Super Potion|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(586, '0x024A', nq'|Relic Gold|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(238, '0xEE', nq'|TM46|', q'|TMs and HMs|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(417, '0x01A1', nq'|TM90|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(59, '0x003B', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(485, '0x01E5', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(132, '0x84', nq'|Star Piece|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(8, '0x0008', nq'|Nest Ball|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(271, '0x010F', nq'|Power Herb|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GEN)
values(217, '0xD9', nq'|TM17|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(786, '0x0312', nq'|Psychium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(92, '0x005C', nq'|Nugget|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(411, '0x019B', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(333, '0x014D', nq'|TM45|', q'|TMs and HMs|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(453, '0x01C5', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(397, '0x018D', nq'|TM70|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(776, '0x0308', nq'|Normalium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(213, '0xD5', nq'|TM22|', q'|TMs and HMs|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(581, '0x0245', nq'|Big Nugget|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(840, '0x0348', nq'|???|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(456, '0x01C8', nq'|S.S. Ticket|', q'|Key items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(113, '0x0071', nq'|Tea|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(443, '0x01BB', nq'|Vs. Seeker|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(95, '0x005F', nq'|Growth Mulch|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(759, '0x02F7', nq'|Sharpedonite|', q'|Items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(565, '0x0235', nq'|Battle CD 32|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(91, '0x005B', nq'|Star Piece|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(12, '0x000C', nq'|Premier Ball|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(688, '0x02B0', nq'|Maranga Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(292, '0x0124', nq'|TM04|', q'|TMs and HMs|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(42, '0x2A', nq'|Helix Fossil|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(156, '0x009C', nq'|Persim Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(641, '0x0281', nq'|Holo Caster|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(97, '0x0061', nq'|Stable Mulch|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(455, '0x01C7', nq'|Azure Flute|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(767, '0x02FF', nq'|Cameruptite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(127, '0x007F', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(117, '0x0075', nq'|unknown|', 4);
insert into itemIDs(ID, HEX, NAME, GEN)
values(20, '0x14', nq'|Potion|', 1);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1044, '0x0414', nq'|Eevee Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(26, '0x001A', nq'|Super Potion|', q'|Medicine|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(165, '0x00A5', nq'|Watmel Berry|', q'|Berries|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(165, '0x00A5', nq'|Watmel Berry|', q'|Berries|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(271, '0x010F', nq'|Power Herb|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(132, '0x0084', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(221, '0x00DD', nq'|Lax Incense|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(226, '0x00E2', nq'|DeepSeaTooth|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(356, '0x0164', nq'|TM29|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(240, '0x00F0', nq'|BlackGlasses|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(23, '0x0017', nq'|Full Heal|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(418, '0x01A2', nq'|TM91|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(276, '0x0114', nq'|Zoom Lens|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(303, '0x012F', nq'|Fist Plate|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(501, '0x01F5', nq'|Photo Album|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(619, '0x026B', nq'|TM94|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(29, '0x1D', nq'|Carbos|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(126, '0x007E', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(13, '0x0D', nq'|Parlyz Heal|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(456, '0x01C8', nq'|S.S. Ticket|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(571, '0x023B', nq'|Pretty Wing|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(344, '0x0158', nq'|TM17|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(166, '0x00A6', nq'|Nanab Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(232, '0x00E8', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(152, '0x0098', nq'|Pinap Berry|', q'|Berries|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(367, '0x016F', nq'|TM40|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(547, '0x0223', nq'|Ein File F|', q'|Key items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(161, '0x00A1', nq'|Rabuta Berry|', q'|Berries|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(240, '0x00F0', nq'|Black Glasses|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(641, '0x0281', nq'|Holo Caster|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(97, '0x0061', nq'|Stable Mulch|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(161, '0xA1', nq'|Fast Ball|', q'|Poké Balls|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(455, '0x01C7', nq'|Azure Flute|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(570, '0x023A', nq'|Swift Wing|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(748, '0x02EC', nq'|Mega Stickpin|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(26, '0x001A', nq'|Super Potion|', q'|Medicine|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(162, '0x00A2', nq'|Nomel Berry|', q'|Berries|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(464, '0x01D0', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(79, '0x004F', nq'|Repel|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(330, '0x014A', nq'|TM03|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(472, '0x01D8', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(263, '0x0107', nq'|Green Scarf|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(284, '0x011C', nq'|Heat Rock|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(78, '0x004E', nq'|X Accuracy|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(498, '0x01F2', nq'|Moon Ball|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(666, '0x029A', nq'|Houndoominite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(451, '0x01C3', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(224, '0x00E0', nq'|Thick Club|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(569, '0x0239', nq'|Battle CD 36|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(456, '0x01C8', nq'|S.S. Ticket|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(295, '0x0127', nq'|Shed Shell|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(36, '0x24', nq'|Nugget|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(78, '0x004E', nq'|X Accuracy|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(96, '0x0060', nq'|Damp Mulch|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(138, '0x008A', nq'|Favored Mail|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(124, '0x007C', nq'|unknown|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(136, '0x0088', nq'|Rawst Berry|', q'|Berries|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(686, '0x02AE', nq'|Roseli Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(128, '0x0080', nq'|unknown|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(478, '0x01DE', nq'|Red Scale|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(450, '0x01C2', nq'|Bike|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(19, '0x0013', nq'|Burn Heal|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(518, '0x0206', nq'|Bonsly Photo|', q'|Key items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(187, '0xBB', nq'|Bluesky Mail|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(347, '0x015B', nq'|TM20|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(535, '0x0217', nq'|Blue Orb|', q'|Key items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(26, '0x001A', nq'|Super Potion|', q'|Medicine|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(322, '0x0142', nq'|TM34|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(826, '0x033A', nq'|Decidium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(761, '0x02F9', nq'|Steelixite|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(248, '0x00F8', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(763, '0x02FB', nq'|Glalitite|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(271, '0x010F', nq'|Power Herb|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(51, '0x0033', nq'|PP Up|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(551, '0x0227', nq'|Grass Gem|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(391, '0x0187', nq'|TM64|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(176, '0x00B0', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(365, '0x016D', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(337, '0x0151', nq'|TM49|', q'|TMs and HMs|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(276, '0x0114', nq'|Zoom Lens|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(432, '0x01B0', nq'|Point Card|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(248, '0xF8', nq'|HM06|', q'|TMs and HMs|', 2);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(453, '0x01C5', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1014, '0x03F6', nq'|Seel Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(553, '0x0229', nq'|Fighting Gem|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(80, '0x0050', nq'|Poké Doll|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(193, '0xC1', nq'|TM03|', q'|TMs and HMs|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(498, '0x01F2', nq'|Moon Ball|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(13, '0x000D', nq'|Dusk Ball|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(64, '0x0040', nq'|Fluffy Tail|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(785, '0x0311', nq'|Flyinium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(914, '0x0392', nq'|Grass Memory|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(201, '0xC9', nq'|TM10|', q'|TMs and HMs|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(478, '0x01DE', nq'|Red Scale|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(686, '0x02AE', nq'|Roseli Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(575, '0x023F', nq'|Battle CD 42|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(402, '0x0192', nq'|TM75|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(333, '0x014D', nq'|TM06|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(360, '0x0168', nq'|TM33|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(485, '0x01E5', nq'|Red Apricorn|', q'|Items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(935, '0x03A7', nq'|Orange Petal|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(297, '0x0129', nq'|TM09|', q'|TMs and HMs|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(16, '0x0010', nq'|Ice Heal|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(2, '0x0002', nq'|Ultra Ball|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(719, '0x02CF', nq'|Acro Bike|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(157, '0x9D', nq'|Heavy Ball|', q'|Poké Balls|', 2);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(851, '0x0353', nq'|Beast Ball|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(636, '0x027C', nq'|Dropped Item|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(8, '0x0008', nq'|Nest Ball|', q'|Poké Balls|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(303, '0x012F', nq'|Fist Plate|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(465, '0x01D1', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(517, '0x0205', nq'|Data Card 13|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(276, '0x0114', nq'|Zoom Lens|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(115, '0x0073', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(553, '0x0229', nq'|Fighting Gem|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(644, '0x0284', nq'|Pixie Plate|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(336, '0x0150', nq'|TM09|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(170, '0x00AA', nq'|Salac Berry|', q'|Berries|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(168, '0x00A8', nq'|Pinap Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(64, '0x0040', nq'|Fluffy Tail|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(568, '0x0238', nq'|Genius Wing|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(295, '0x0127', nq'|Shed Shell|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GEN)
values(38, '0x26', nq'|Carbos|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(164, '0xA4', nq'|Friend Ball|', q'|Poké Balls|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(87, '0x0057', nq'|Big Mushroom|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(124, '0x007C', nq'|unknown|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(925, '0x039D', nq'|Lycanium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(251, '0xFB', nq'|TM51|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(269, '0x010D', nq'|Devon Goods|', q'|Key items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(206, '0x00CE', nq'|BlackGlasses|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(28, '0x001C', nq'|Revive|', q'|Medicine|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(847, '0x034F', nq'|Zygarde Cube|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(306, '0x0132', nq'|Sky Plate|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(351, '0x015F', nq'|TM24|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(256, '0x0100', nq'|Pink Scarf|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(215, '0x00D7', nq'|Macho Brace|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(376, '0x0178', nq'|TM49|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(910, '0x038E', nq'|Ghost Memory|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(354, '0x0162', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(133, '0x0085', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(281, '0x0119', nq'|Black Sludge|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(219, '0x00DB', nq'|Mental Herb|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(271, '0x010F', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(702, '0x02BE', nq'|Honor of Kalos|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(559, '0x022F', nq'|Rock Gem|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(140, '0x008C', nq'|Persim Berry|', q'|Berries|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(54, '0x0036', nq'|Old Gateau|', q'|Medicine|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(109, '0x006D', nq'|Star Piece|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(27, '0x001B', nq'|Full Heal|', q'|Medicine|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(222, '0xDE', nq'|TM30|', q'|TMs and HMs|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(566, '0x0236', nq'|Muscle Wing|', q'|Medicine|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(157, '0x009D', nq'|Grepa Berry|', q'|Berries|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(553, '0x0229', nq'|Fighting Gem|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(268, '0x010C', nq'|Wailmer Pail|', q'|Key items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(389, '0x0185', nq'|TM62|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(80, '0x0050', nq'|Poké Doll|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(295, '0x0127', nq'|Shed Shell|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(445, '0x01BD', nq'|Old Rod|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(353, '0x0161', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(547, '0x0223', nq'|Eject Button|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(21, '0x0015', nq'|Awakening|', q'|Medicine|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(384, '0x0180', nq'|TM57|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(87, '0x0057', nq'|Big Mushroom|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(138, '0x008A', nq'|Favored Mail|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(56, '0x0038', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(138, '0x008A', nq'|Favored Mail|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(299, '0x012B', nq'|TM11|', q'|TMs and HMs|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(478, '0x01DE', nq'|Red Scale|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(431, '0x01AF', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(63, '0x003F', nq'|Poké Doll|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(228, '0x00E4', nq'|Smoke Ball|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(197, '0x00C5', nq'|Lucky Egg|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(207, '0x00CF', nq'|Black Belt|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(306, '0x0132', nq'|Sky Plate|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(989, '0x03DD', nq'|Nidoran♀ Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(215, '0x00D7', nq'|Macho Brace|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(281, '0x0119', nq'|Black Sludge|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(24, '0x0018', nq'|Revive|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(211, '0x00D3', nq'|Poison Barb|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(416, '0x01A0', nq'|TM89|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(241, '0x00F1', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(161, '0x00A1', nq'|Mago Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(294, '0x0126', nq'|TM06|', q'|TMs and HMs|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(93, '0x005D', nq'|Heart Scale|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(702, '0x02BE', nq'|Honor of Kalos|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(99, '0x0063', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(26, '0x001A', nq'|Fresh Water|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(75, '0x004B', nq'|Green Shard|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(37, '0x0025', nq'|Max Elixir|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(468, '0x01D4', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(617, '0x0269', nq'|Dark Stone|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(303, '0x012F', nq'|Fist Plate|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(556, '0x022C', nq'|Flying Gem|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(521, '0x0209', nq'|Data Card 17|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(213, '0x00D5', nq'|Bright Powder|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(291, '0x0123', nq'|TM03|', q'|TMs and HMs|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(454, '0x01C6', nq'|Member Card|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(231, '0x00E7', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(27, '0x001B', nq'|Full Heal|', q'|Medicine|', 4);
insert into itemIDs(ID, HEX, NAME, GEN)
values(115, '0x0073', nq'|unknown|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(432, '0x01B0', nq'|Point Card|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(229, '0x00E5', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(655, '0x028F', nq'|Amaze Mulch|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(732, '0x02DC', nq'|Key to Room 4|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(556, '0x022C', nq'|Flying Gem|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(613, '0x0265', nq'|Item Urge|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(302, '0x012E', nq'|Icicle Plate|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(266, '0x010A', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(389, '0x0185', nq'|TM62|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(776, '0x0308', nq'|Normalium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(166, '0x00A6', nq'|Nanab Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(547, '0x0223', nq'|Eject Button|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(53, '0x0035', nq'|PP Max|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(8, '0x0008', nq'|Nest Ball|', q'|Poké Balls|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(131, '0x0083', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(852, '0x0354', nq'|Big Malasada|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(415, '0x019F', nq'|TM88|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(185, '0x00B9', nq'|Mental Herb|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(473, '0x01D9', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(365, '0x016D', nq'|TM38|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(409, '0x0199', nq'|TM82|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(73, '0x0049', nq'|Blue Shard|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(418, '0x01A2', nq'|TM91|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(261, '0x0105', nq'|Blue Scarf|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(302, '0x012E', nq'|TM14|', q'|TMs and HMs|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(215, '0x00D7', nq'|Macho Brace|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(187, '0x00BB', nq'|King's Rock|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(659, '0x0293', nq'|Venusaurite|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(364, '0x016C', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(147, '0x0093', nq'|Iapapa Berry|', q'|Berries|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(784, '0x0310', nq'|Groundium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(303, '0x012F', nq'|Fist Plate|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(529, '0x0211', nq'|DNA Sample|', q'|Key items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(140, '0x008C', nq'|Persim Berry|', q'|Berries|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(205, '0x00CD', nq'|Miracle Seed|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(115, '0x0073', nq'|unknown|', 4);
insert into itemIDs(ID, HEX, NAME, GEN)
values(119, '0x0077', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(424, '0x01A8', nq'|HM05|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(512, '0x0200', nq'|Cologne Case|', q'|Key items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(757, '0x02F5', nq'|Audinite|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(81, '0x0051', nq'|Fluffy Tail|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(471, '0x01D7', nq'|Dowsing MCHN|', q'|Key items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(166, '0x00A6', nq'|Nanab Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(374, '0x0176', nq'|TM47|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(484, '0x01E4', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(407, '0x0197', nq'|TM80|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(553, '0x0229', nq'|Battle CD 20|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(19, '0x13', nq'|Super Potion|', 1);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(380, '0x017C', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(354, '0x0162', nq'|Old Amber|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(10, '0x000A', nq'|Timer Ball|', q'|Poké Balls|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(547, '0x0223', nq'|Eject Button|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(846, '0x034E', nq'|Adrenaline Orb|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(121, '0x0079', nq'|Orange Mail|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(12, '0x000C', nq'|Premier Ball|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(308, '0x0134', nq'|TM20|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(755, '0x02F3', nq'|Altarianite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(741, '0x02E5', nq'|Magma Suit|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(426, '0x01AA', nq'|unknown|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(306, '0x0132', nq'|Sky Plate|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(824, '0x0338', nq'|Fairium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(198, '0x00C6', nq'|Scope Lens|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(455, '0x01C7', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(335, '0x014F', nq'|TM47|', q'|TMs and HMs|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(52, '0x0034', nq'|Zinc|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(161, '0x00A1', nq'|Rabuta Berry|', q'|Berries|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(215, '0x00D7', nq'|Macho Brace|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(869, '0x0365', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(771, '0x0303', nq'|Meteorite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(292, '0x0124', nq'|TM04|', q'|TMs and HMs|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(324, '0x0144', nq'|TM36|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(57, '0x0039', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(27, '0x001B', nq'|Full Heal|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(644, '0x0284', nq'|Pixie Plate|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(509, '0x01FD', nq'|Data Card 05|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(566, '0x0236', nq'|Muscle Wing|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(424, '0x01A8', nq'|HM05|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(687, '0x02AF', nq'|Kee Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(414, '0x019E', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(212, '0x00D4', nq'|Rowap Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(389, '0x0185', nq'|TM62|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(195, '0x00C3', nq'|Everstone|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(737, '0x02E1', nq'|HM07|', q'|TMs and HMs|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(515, '0x0203', nq'|Data Card 11|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(166, '0x00A6', nq'|Nanab Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(123, '0x007B', nq'|unknown|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(37, '0x0025', nq'|Max Elixir|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(397, '0x018D', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(539, '0x021B', nq'|Float Stone|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(361, '0x0169', nq'|TM34|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(722, '0x02D2', nq'|Soot Sack|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(149, '0x0095', nq'|Cheri Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(43, '0x2B', nq'|Max Repel|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(139, '0x008B', nq'|RSVP Mail|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(668, '0x029C', nq'|Banettite|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(365, '0x016D', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(340, '0x0154', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(302, '0x012E', nq'|Icicle Plate|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(434, '0x01B2', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(335, '0x014F', nq'|TM47|', q'|TMs and HMs|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(338, '0x0152', nq'|TM50|', q'|TMs and HMs|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(155, '0x009B', nq'|Oran Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(436, '0x01B4', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(359, '0x0167', nq'|Silph Scope|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(213, '0x00D5', nq'|Bright Powder|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(171, '0x00AB', nq'|Qualot Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(519, '0x0207', nq'|Data Card 15|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(644, '0x0284', nq'|Pixie Plate|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(509, '0x01FD', nq'|Data Card 05|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(432, '0x01B0', nq'|Point Card|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(163, '0x00A3', nq'|Spelon Berry|', q'|Berries|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(60, '0x3C', nq'|Fresh Water|', 1);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(825, '0x0339', nq'|Pikanium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(123, '0x007B', nq'|unknown|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(239, '0x00EF', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(86, '0x0056', nq'|Repel|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(901, '0x0385', nq'|Super Lure|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(125, '0x007D', nq'|Power-Up Pocket|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(90, '0x005A', nq'|Stardust|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(210, '0x00D2', nq'|Custap Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(234, '0x00EA', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(424, '0x01A8', nq'|HM05|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(668, '0x029C', nq'|Banettite|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(392, '0x0188', nq'|TM65|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(704, '0x02C0', nq'|Strange Souvenir|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(409, '0x0199', nq'|TM82|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(394, '0x018A', nq'|TM67|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(277, '0x0115', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(198, '0x00C6', nq'|Scope Lens|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(394, '0x018A', nq'|TM67|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(96, '0x0060', nq'|Damp Mulch|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(844, '0x034C', nq'|Festival Ticket|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(434, '0x01B2', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(89, '0x59', nq'|Blu Apricorn|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, GEN)
values(838, '0x0346', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(133, '0x0085', nq'|???|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(372, '0x0174', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(387, '0x0183', nq'|TM60|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(659, '0x0293', nq'|Venusaurite|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(321, '0x0141', nq'|Protector|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(413, '0x019D', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(220, '0x00DC', nq'|Sea Incense|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(278, '0x0116', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(509, '0x01FD', nq'|Data Card 05|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GEN)
values(119, '0x0077', nq'|unknown|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(277, '0x0115', nq'|Metronome|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(523, '0x020B', nq'|Krane Memo 1|', q'|Key items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(439, '0x01B7', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(123, '0x007B', nq'|unknown|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(59, '0x3B', nq'|Good Rod|', q'|Key items|', 2);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(58, '0x003A', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(511, '0x01FF', nq'|Data Card 07|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(581, '0x0245', nq'|Battle CD 48|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(534, '0x0216', nq'|Red Orb|', q'|Key items|', q'|X, Y|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(490, '0x01EA', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(412, '0x019C', nq'|TM85|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(229, '0x00E5', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(80, '0x50', nq'|Ether|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(96, '0x0060', nq'|Damp Mulch|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(362, '0x016A', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(276, '0x0114', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(163, '0x00A3', nq'|Iapapa Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(844, '0x034C', nq'|Festival Ticket|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(394, '0x018A', nq'|TM67|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(765, '0x02FD', nq'|Prison Bottle|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(189, '0x00BD', nq'|Amulet Coin|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(282, '0x011A', nq'|Icy Rock|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(373, '0x0175', nq'|TM46|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(473, '0x01D9', nq'|Slowpoke Tail|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(348, '0x15C', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(471, '0x01D7', nq'|Dowsing Machine|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(281, '0x0119', nq'|Black Sludge|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(387, '0x0183', nq'|TM60|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, GEN)
values(109, '0x6D', nq'|ブロンズ (Bronze - D)|', 1);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(112, '0x0070', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(527, '0x020F', nq'|Data Card 23|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(452, '0x01C4', nq'|Oak's Letter|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(566, '0x0236', nq'|Muscle Wing|', q'|Medicine|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(171, '0x00AB', nq'|Qualot Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(277, '0x0115', nq'|Metronome|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(476, '0x01DC', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(297, '0x0129', nq'|Choice Specs|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(168, '0x00A8', nq'|Pinap Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(378, '0x017A', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(102, '0x0066', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(402, '0x0192', nq'|TM75|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(580, '0x0244', nq'|Balm Mushroom|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(442, '0x01BA', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(79, '0x004F', nq'|Repel|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(761, '0x02F9', nq'|Steelixite|', q'|Items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(510, '0x01FE', nq'|Miror Radar|', q'|Key items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(81, '0x0051', nq'|Moon Stone|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(186, '0x00BA', nq'|Wacan Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(116, '0x0074', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(214, '0x00D6', nq'|White Herb|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(246, '0xF6', nq'|HM04|', q'|TMs and HMs|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(210, '0x00D2', nq'|Custap Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(463, '0x01CF', nq'|Storage Key|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(163, '0x00A3', nq'|Iapapa Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(409, '0x0199', nq'|TM82|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(302, '0x012E', nq'|Icicle Plate|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(276, '0x0114', nq'|Zoom Lens|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(277, '0x0115', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(61, '0x003D', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(699, '0x02BB', nq'|Discount Coupon|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(405, '0x0195', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(251, '0x00FB', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(856, '0x0358', nq'|Purple Nectar|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(952, '0x03B8', nq'|Roto Exp. Points|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(469, '0x01D5', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(42, '0x002A', nq'|Lava Cookie|', q'|Medicine|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(172, '0xAC', nq'|Up-Grade|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(468, '0x01D4', nq'|Apricorn Box|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(263, '0x0107', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(346, '0x015A', nq'|TM19|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(387, '0x0183', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(443, '0x01BB', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(247, '0x00F7', nq'|Spell Tag|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(316, '0x013C', nq'|TM28|', q'|TMs and HMs|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(913, '0x0391', nq'|Water Memory|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(344, '0x0158', nq'|TM17|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(281, '0x0119', nq'|Black Sludge|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(34, '0x0022', nq'|Ether|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(577, '0x0241', nq'|Poké Toy|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(13, '0x000D', nq'|Potion|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(388, '0x0184', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(348, '0x015C', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(290, '0x0122', nq'|Power Belt|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(288, '0x0120', nq'|Sticky Barb|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(171, '0x00AB', nq'|Qualot Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(127, '0x007F', nq'|Catching Pocket|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(277, '0x0115', nq'|Metronome|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(458, '0x01CA', nq'|Magma Stone|', q'|Key items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(534, '0x0216', nq'|Red Orb|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(165, '0x00A5', nq'|Bluk Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(139, '0x8B', nq'|Berry Juice|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(213, '0x00D5', nq'|Bright Powder|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(626, '0x0272', nq'|Xtransceiver|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(171, '0x00AB', nq'|Qualot Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(737, '0x02E1', nq'|HM07|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(312, '0x0138', nq'|Dread Plate|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(383, '0x017F', nq'|TM56|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(96, '0x0060', nq'|Damp Mulch|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(81, '0x0051', nq'|Moon Stone|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(83, '0x0053', nq'|Super Repel|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(392, '0x0188', nq'|TM65|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(210, '0x00D2', nq'|Custap Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(214, '0x00D6', nq'|White Herb|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(163, '0x00A3', nq'|Iapapa Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(782, '0x030E', nq'|Fightinium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(83, '0x0053', nq'|Super Repel|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(345, '0x0159', nq'|TM18|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(22, '0x0016', nq'|Super Potion|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(807, '0x0327', nq'|Normalium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(536, '0x0218', nq'|Enigma Stone|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(630, '0x0276', nq'|Permit|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(35, '0x23', nq'|Metal Powder|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(9, '0x09', nq'|Antidote|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(271, '0x010F', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(435, '0x01B3', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(462, '0x01CE', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(344, '0x0158', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(525, '0x020D', nq'|Krane Memo 3|', q'|Key items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(241, '0x00F1', nq'|Black Belt|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(280, '0x0118', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(16, '0x0010', nq'|Cherish Ball|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(190, '0x00BE', nq'|Cleanse Tag|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(527, '0x020F', nq'|Data Card 23|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(680, '0x02A8', nq'|Heracronite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(45, '0x002D', nq'|Sacred Ash|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(387, '0x0183', nq'|TM60|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(246, '0x00F6', nq'|Never-Melt Ice|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(26, '0x1A', nq'|HP Up|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(170, '0x00AA', nq'|Salac Berry|', q'|Berries|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(277, '0x0115', nq'|Metronome|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(184, '0xB8', nq'|Lovely Mail|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, GEN)
values(134, '0x0086', nq'|unknown|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(45, '0x002D', nq'|HP Up|', q'|Medicine|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(168, '0x00A8', nq'|Pinap Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(167, '0x00A7', nq'|Belue Berry|', q'|Berries|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(497, '0x01F1', nq'|Friend Ball|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(638, '0x027E', nq'|Reveal Glass|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(431, '0x01AF', nq'|Poké Radar|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(297, '0x0129', nq'|Choice Specs|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(169, '0x00A9', nq'|Pomeg Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(91, '0x5B', nq'|Amulet Coin|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(417, '0x01A1', nq'|TM90|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(402, '0x0192', nq'|TM75|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(33, '0x0021', nq'|Moomoo Milk|', q'|Medicine|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(165, '0x00A5', nq'|Bluk Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(380, '0x017C', nq'|TM53|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(373, '0x0175', nq'|TM46|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(762, '0x02FA', nq'|Pidgeotite|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(357, '0x0165', nq'|TM30|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(719, '0x02CF', nq'|Acro Bike|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(381, '0x017D', nq'|TM54|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(406, '0x0196', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(402, '0x0192', nq'|TM75|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(907, '0x038B', nq'|Ground Memory|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(163, '0x00A3', nq'|Iapapa Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(946, '0x03B2', nq'|N-Lunarizer|', q'|Key items|', q'|Ultra Sun, Ultra Moon|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(81, '0x0051', nq'|Moon Stone|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(302, '0x012E', nq'|Icicle Plate|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(468, '0x01D4', nq'|Apricorn Box|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(394, '0x018A', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(42, '0x002A', nq'|Lava Cookie|', q'|Medicine|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(4, '0x04', nq'|Great Ball|', q'|Poké Balls|', 2);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(972, '0x03CC', nq'|Health Candy XL|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(794, '0x031A', nq'|Pikanium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(46, '0x002E', nq'|Shoal Salt|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(393, '0x0189', nq'|TM66|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(635, '0x027B', nq'|Colress Machine|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(406, '0x0196', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(17, '0x0011', nq'|Potion|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(246, '0x00F6', nq'|Never-Melt Ice|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(527, '0x020F', nq'|Data Card 23|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(577, '0x0241', nq'|Poké Toy|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(631, '0x0277', nq'|Oval Charm|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(348, '0x015C', nq'|TM21|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(638, '0x027E', nq'|Reveal Glass|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(147, '0x0093', nq'|Bridge Mail V|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(168, '0x00A8', nq'|Pinap Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(45, '0x002D', nq'|HP Up|', q'|Medicine|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(39, '0x0027', nq'|Max Ether|', q'|Medicine|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(12, '0x000C', nq'|Premier Ball|', q'|Poké Balls|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(297, '0x0129', nq'|Choice Specs|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(67, '0x0043', nq'|Red Flute|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(574, '0x023E', nq'|Liberty Pass|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(863, '0x035F', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(444, '0x01BC', nq'|Coin Case|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(216, '0xD8', nq'|TM16|', 1);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1025, '0x0401', nq'|Hitmonchan Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(115, '0x73', nq'|GS Ball|', q'|Key items|', q'|Crystal|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(684, '0x02AC', nq'|Latiasite|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(357, '0x0165', nq'|TM30|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(570, '0x023A', nq'|Battle CD 37|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(56, '0x0038', nq'|Dire Hit|', q'|Battle items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(322, '0x0142', nq'|TM34|', q'|TMs and HMs|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(507, '0x01FB', nq'|U-Disk|', q'|Key items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(297, '0x0129', nq'|TM09|', q'|TMs and HMs|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(210, '0x00D2', nq'|Custap Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(81, '0x0051', nq'|Moon Stone|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(609, '0x0261', nq'|X Attack 6|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(486, '0x01E6', nq'|Ylw Apricorn|', q'|Items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(55, '0x0037', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(60, '0x003C', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(572, '0x023C', nq'|Battle CD 39|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(18, '0x12', nq'|Potion|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(42, '0x002A', nq'|Lava Cookie|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(461, '0x01CD', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(635, '0x027B', nq'|Colress Machine|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(247, '0x00F7', nq'|Spell Tag|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(17, '0x0011', nq'|Potion|', q'|Medicine|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(139, '0x008B', nq'|Oran Berry|', q'|Berries|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(175, '0x00AF', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(111, '0x006F', nq'|Odd Keystone|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(577, '0x0241', nq'|Poké Toy|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(938, '0x03AA', nq'|Green Petal|', q'|Key items|', q'|Ultra Sun, Ultra Moon|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(377, '0x0179', nq'|TM50|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(976, '0x03D0', nq'|Courage Candy XL|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(817, '0x0331', nq'|Psychium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(95, '0x005F', nq'|Fire Stone|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(462, '0x01CE', nq'|Coupon 3|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(22, '0x0016', nq'|Super Potion|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(158, '0x9E', nq'|Flower Mail|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(613, '0x0265', nq'|Item Urge|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(751, '0x02EF', nq'|Meteorite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(94, '0x005E', nq'|Moon Stone|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(150, '0x0096', nq'|Chesto Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(684, '0x02AC', nq'|Latiasite|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(417, '0x01A1', nq'|TM90|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(357, '0x0165', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(357, '0x0165', nq'|TM30|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(96, '0x0060', nq'|Damp Mulch|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(913, '0x0391', nq'|Water Memory|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(392, '0x0188', nq'|TM65|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(238, '0x00EE', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(12, '0x000C', nq'|Premier Ball|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(16, '0x10', nq'|Full Restore|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(706, '0x02C2', nq'|Travel Trunk|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(733, '0x02DD', nq'|Key to Room 6|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(707, '0x02C3', nq'|Travel Trunk|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(267, '0x010B', nq'|Wise Glasses|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(346, '0x015A', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(165, '0x00A5', nq'|Bluk Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(660, '0x0294', nq'|Charizardite X|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(554, '0x022A', nq'|Battle CD 21|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(284, '0x011C', nq'|Heat Rock|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(954, '0x03BA', nq'|Roto Encounter|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(17, '0x0011', nq'|Potion|', q'|Medicine|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(377, '0x0179', nq'|TM50|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(827, '0x033B', nq'|Incinium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(29, '0x001D', nq'|Moomoo Milk|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(543, '0x021F', nq'|Joy Scent|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(870, '0x0366', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(229, '0x00E5', nq'|Everstone|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(165, '0xA5', nq'|Moon Ball|', q'|Poké Balls|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(67, '0x0043', nq'|Red Flute|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(398, '0x018E', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(417, '0x01A1', nq'|TM90|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(402, '0x0192', nq'|TM75|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(606, '0x025E', nq'|X Sp. Atk 6|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(390, '0x0186', nq'|TM63|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(439, '0x01B7', nq'|Old Charm|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(311, '0x0137', nq'|TM23|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(550, '0x0226', nq'|Electric Gem|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(707, '0x02C3', nq'|Travel Trunk|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(42, '0x002A', nq'|Lava Cookie|', q'|Medicine|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(328, '0x0148', nq'|TM40|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(711, '0x02C7', nq'|Sail Fossil|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(467, '0x01D3', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(294, '0x0126', nq'|Power Weight|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(330, '0x014A', nq'|TM03|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(382, '0x017E', nq'|TM55|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(111, '0x006F', nq'|Odd Keystone|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(714, '0x02CA', nq'|Holo Caster|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(229, '0x00E5', nq'|Everstone|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(39, '0x0027', nq'|Max Ether|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(86, '0x0056', nq'|Tiny Mushroom|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1057, '0x0421', nq'|Magmar Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(613, '0x0265', nq'|Item Urge|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(419, '0x01A3', nq'|TM92|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(502, '0x01F6', nq'|GB Sounds|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(614, '0x0266', nq'|Reset Urge|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(13, '0x000D', nq'|Dusk Ball|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(488, '0x01E8', nq'|Grn Apricorn|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(176, '0x00B0', nq'|Magost Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(97, '0x61', nq'|B4F (G)|', 1);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(301, '0x012D', nq'|Meadow Plate|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(301, '0x012D', nq'|TM13|', q'|TMs and HMs|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(923, '0x039B', nq'|Ultranecrozium Z|', q'|Z-Crystals|', q'|Ultra Sun, Ultra Moon|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(479, '0x01DF', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(6, '0x0006', nq'|Net Ball|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(550, '0x0226', nq'|Electric Gem|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(267, '0x010B', nq'|Wise Glasses|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(983, '0x03D7', nq'|Pidgey Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(282, '0x011A', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(363, '0x016B', nq'|TM36|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(86, '0x0056', nq'|Tiny Mushroom|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(511, '0x01FF', nq'|Data Card 07|', q'|Items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(49, '0x0031', nq'|Blue Shard|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(469, '0x01D5', nq'|Unown Report|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(292, '0x0124', nq'|TM04|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(299, '0x012B', nq'|Splash Plate|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(331, '0x014B', nq'|TM04|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(469, '0x01D5', nq'|Unown Report|', q'|Key items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(171, '0x00AB', nq'|Qualot Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(470, '0x01D6', nq'|Berry Pots|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(363, '0x016B', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(521, '0x0209', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(463, '0x01CF', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(229, '0x00E5', nq'|Everstone|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(584, '0x0248', nq'|Battle CD 51|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(862, '0x035E', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(869, '0x0365', nq'|???|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(165, '0x00A5', nq'|Bluk Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(614, '0x0266', nq'|Reset Urge|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(230, '0x00E6', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(745, '0x02E9', nq'|Mega Pendant|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(739, '0x02E3', nq'|Contest Costume|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(653, '0x028D', nq'|Surprise Mulch|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(540, '0x021C', nq'|Battle CD 07|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(875, '0x036B', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(714, '0x02CA', nq'|Holo Caster|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(433, '0x01B1', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(550, '0x0226', nq'|Electric Gem|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(126, '0x007E', nq'|unknown|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(169, '0xA9', nq'|Sun Stone|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(109, '0x6D', nq'|MiracleBerry|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(452, '0x01C4', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(363, '0x016B', nq'|TM36|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(394, '0x018A', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(155, '0x009B', nq'|Qualot Berry|', q'|Berries|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(136, '0x0088', nq'|Rawst Berry|', q'|Berries|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(126, '0x007E', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(103, '0x0067', nq'|TinyMushroom|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(459, '0x01CB', nq'|Parcel|', q'|Key items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(522, '0x020A', nq'|Data Card 18|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(186, '0xBA', nq'|Morph Mail|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(770, '0x0302', nq'|Beedrillite|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(279, '0x0117', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(386, '0x0182', nq'|TM59|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(40, '0x0028', nq'|Yellow Flute|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(229, '0x00E5', nq'|Everstone|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(165, '0x00A5', nq'|Bluk Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, GEN)
values(24, '0x18', nq'|RainbowBadge|', 1);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(364, '0x016C', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(277, '0x0115', nq'|Blue Orb|', q'|Key items|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(367, '0x016F', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(232, '0x00E8', nq'|Scope Lens|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(401, '0x0191', nq'|TM74|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(469, '0x01D5', nq'|Unown Report|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(209, '0x00D1', nq'|Mystic Water|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(496, '0x01F0', nq'|Love Ball|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(59, '0x3B', nq'|Coin|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(11, '0x000B', nq'|Luxury Ball|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(22, '0x16', nq'|Fire Stone|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(86, '0x0056', nq'|TinyMushroom|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(214, '0x00D6', nq'|White Herb|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(639, '0x027F', nq'|Weakness Policy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(33, '0x0021', nq'|Revival Herb|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(630, '0x0276', nq'|Permit|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(394, '0x018A', nq'|TM67|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(180, '0x00B4', nq'|White Herb|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(174, '0x00AE', nq'|Starf Berry|', q'|Berries|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(466, '0x01D2', nq'|Gracidea|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(2, '0x0002', nq'|Ultra Ball|', q'|Poké Balls|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(70, '0x0046', nq'|Zinc|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(111, '0x006F', nq'|Odd Keystone|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(33, '0x0021', nq'|Revival Herb|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(716, '0x02CC', nq'|Mega Charm|', q'|Key items|', q'|X, Y|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(180, '0x00B4', nq'|White Herb|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(855, '0x0357', nq'|Pink Nectar|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(273, '0x0111', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(86, '0x56', nq'|1F (G)|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(386, '0x0182', nq'|TM59|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(348, '0x015C', nq'|TM21|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(41, '0x0029', nq'|Max Elixir|', q'|Medicine|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(470, '0x01D6', nq'|Berry Pots|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(556, '0x022C', nq'|Flying Gem|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(391, '0x0187', nq'|TM64|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(232, '0x00E8', nq'|Scope Lens|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(427, '0x01AB', nq'|???|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(431, '0x01AF', nq'|Poké Radar|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(240, '0x00F0', nq'|BlackGlasses|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(582, '0x0246', nq'|Pearl String|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(169, '0x00A9', nq'|Pomeg Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(197, '0xC5', nq'|TM06|', q'|TMs and HMs|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(237, '0x00ED', nq'|Soft Sand|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(789, '0x0315', nq'|Ghostium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(614, '0x0266', nq'|Reset Urge|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(163, '0xA3', nq'|Light Ball|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(13, '0x000D', nq'|Dusk Ball|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(382, '0x017E', nq'|TM55|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, GEN)
values(238, '0x00EE', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(406, '0x0196', nq'|TM79|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(66, '0x0042', nq'|Carbos|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(534, '0x0216', nq'|Red Orb|', q'|Items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(578, '0x0242', nq'|Prop Case|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(453, '0x01C5', nq'|Lunar Wing|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(87, '0x0057', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(86, '0x0056', nq'|TinyMushroom|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(214, '0x00D6', nq'|White Herb|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(589, '0x024D', nq'|Relic Statue|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(363, '0x016B', nq'|TM36|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(531, '0x0213', nq'|Steel Teeth|', q'|Key items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(828, '0x033C', nq'|Primarium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(91, '0x005B', nq'|Star Piece|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(346, '0x015A', nq'|TM19|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(211, '0x00D3', nq'|Poison Barb|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(284, '0x011C', nq'|Heat Rock|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(183, '0x00B7', nq'|Belue Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(366, '0x016E', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(536, '0x0218', nq'|Enigma Stone|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(158, '0x009E', nq'|Sitrus Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(485, '0x01E5', nq'|Red Apricorn|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(493, '0x01ED', nq'|Level Ball|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(469, '0x01D5', nq'|Unown Report|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(416, '0x01A0', nq'|TM89|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(193, '0x00C1', nq'|DeepSeaScale|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(680, '0x02A8', nq'|Heracronite|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(17, '0x0011', nq'|Potion|', q'|Medicine|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(153, '0x0099', nq'|Pomeg Berry|', q'|Berries|', q'|XD|', 3);
insert into itemIDs(GAME, GEN)
values(q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(857, '0x0359', nq'|Sun Flute|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(468, '0x01D4', nq'|Apricorn Box|', q'|Key items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(55, '0x37', nq'|Itemfinder|', q'|Key items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(168, '0x00A8', nq'|Liechi Berry|', q'|Berries|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(348, '0x015C', nq'|TM21|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(470, '0x01D6', nq'|Berry Pots|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(556, '0x022C', nq'|Flying Gem|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(479, '0x01DF', nq'|Lost Item|', q'|Key items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(290, '0x0122', nq'|TM02|', q'|TMs and HMs|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(520, '0x0208', nq'|Data Card 16|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(189, '0x00BD', nq'|Chople Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(272, '0x0110', nq'|Toxic Orb|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(744, '0x02E8', nq'|Mega Bracelet|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(759, '0x02F7', nq'|Sharpedonite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(592, '0x0250', nq'|Dire Hit 2|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(283, '0x011B', nq'|Smooth Rock|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(70, '0x0046', nq'|Zinc|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(117, '0x0075', nq'|Shock Drive|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(382, '0x017E', nq'|TM55|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(380, '0x017C', nq'|TM53|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, GEN)
values(227, '0x00E3', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(439, '0x01B7', nq'|Old Charm|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(368, '0x0170', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(14, '0x0E', nq'|Full Restore|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(638, '0x027E', nq'|Reveal Glass|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(332, '0x014C', nq'|TM44|', q'|TMs and HMs|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(589, '0x024D', nq'|Relic Statue|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(364, '0x016C', nq'|TM37|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(91, '0x005B', nq'|Star Piece|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(103, '0x0067', nq'|Old Amber|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(346, '0x015A', nq'|TM19|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(188, '0x00BC', nq'|Yache Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(284, '0x011C', nq'|Heat Rock|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(916, '0x0394', nq'|Psychic Memory|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(536, '0x0218', nq'|Enigma Stone|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(148, '0x0094', nq'|Brick Mail|', q'|Mail|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(680, '0x02A8', nq'|Heracronite|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(111, '0x006F', nq'|Odd Keystone|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(665, '0x0299', nq'|Medichamite|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(151, '0x97', nq'|Dragon Scale|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(300, '0x012C', nq'|Zap Plate|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(2, '0x0002', nq'|Ultra Ball|', q'|Poké Balls|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(155, '0x9B', nq'|Teru-sama|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, GEN)
values(131, '0x0083', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(375, '0x0177', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(408, '0x0198', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(170, '0x00AA', nq'|Kelpsy Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, GEN)
values(121, '0x0079', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(729, '0x02D9', nq'|Meteorite|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(674, '0x02A2', nq'|Abomasite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(75, '0x004B', nq'|X Attack|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(367, '0x016F', nq'|Tri-Pass|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(306, '0x0132', nq'|TM18|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(508, '0x01FC', nq'|Data Card 04|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1022, '0x03FE', nq'|Exeggcute Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(283, '0x011B', nq'|Smooth Rock|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(734, '0x02DE', nq'|Storage Key|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(227, '0x00E3', nq'|Deep Sea Scale|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(208, '0x00D0', nq'|Magnet|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(283, '0x011B', nq'|Smooth Rock|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(117, '0x0075', nq'|Shock Drive|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(406, '0x0196', nq'|TM79|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(117, '0x0075', nq'|Shock Drive|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(86, '0x0056', nq'|Tiny Mushroom|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(91, '0x005B', nq'|Star Piece|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(267, '0x010B', nq'|Wise Glasses|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(451, '0x01C3', nq'|Suite Key|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(364, '0x016C', nq'|TM37|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(520, '0x0208', nq'|Data Card 16|', q'|Items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(329, '0x0149', nq'|TM41|', q'|TMs and HMs|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(534, '0x0216', nq'|Grn ID Badge|', q'|Key items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(506, '0x01FA', nq'|ID Card|', q'|Key items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(284, '0x011C', nq'|Heat Rock|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(238, '0x00EE', nq'|Hard Stone|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(331, '0x014B', nq'|TM43|', q'|TMs and HMs|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(128, '0x0080', nq'|Shadow Mail|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(318, '0x013E', nq'|Rose Incense|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(665, '0x0299', nq'|Medichamite|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(176, '0xB0', nq'|Teru-sama|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(669, '0x029D', nq'|Tyranitarite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(282, '0x011A', nq'|Icy Rock|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(125, '0x007D', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(115, '0x0073', nq'|unknown|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(15, '0x000F', nq'|Quick Ball|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(765, '0x02FD', nq'|Prison Bottle|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(427, '0x01AB', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(492, '0x01EC', nq'|Fast Ball|', q'|Poké Balls|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(181, '0x00B5', nq'|Macho Brace|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(139, '0x008B', nq'|Bubble Mail|', q'|Mail|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(72, '0x0048', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(692, '0x02B4', nq'|TM98|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(508, '0x01FC', nq'|Data Card 04|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(926, '0x039E', nq'|Kommonium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(275, '0x0113', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1053, '0x041D', nq'|Dratini Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(686, '0x02AE', nq'|Roseli Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(397, '0x018D', nq'|TM70|', q'|TMs and HMs|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(244, '0x00F4', nq'|Sharp Beak|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(265, '0x0109', nq'|Wide Lens|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(576, '0x0240', nq'|Dream Ball|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(382, '0x017E', nq'|TM55|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(359, '0x0167', nq'|TM32|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(286, '0x011E', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(270, '0x010E', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(541, '0x021D', nq'|Ein File P|', q'|Key items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(128, '0x0080', nq'|unknown|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(589, '0x024D', nq'|Relic Statue|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(283, '0x011B', nq'|Smooth Rock|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(821, '0x0335', nq'|Dragonium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(91, '0x005B', nq'|Star Piece|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(157, '0x009D', nq'|Lum Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(829, '0x033D', nq'|Tapunium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(624, '0x0270', nq'|Gram 2|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(260, '0x0104', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(14, '0x000E', nq'|Heal Ball|', q'|Poké Balls|', 4);
insert into itemIDs(ID, HEX, NAME, GEN)
values(77, '0x4D', nq'|Good Rod|', 1);
insert into itemIDs(ID, HEX, NAME, GEN)
values(255, '0xFF', nq'|Cancel|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(471, '0x01D7', nq'|Dowsing Machine|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(46, '0x2E', nq'|X Accuracy|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(905, '0x0389', nq'|Flying Memory|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(409, '0x0199', nq'|TM82|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(332, '0x014C', nq'|TM05|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(714, '0x02CA', nq'|Holo Caster|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(864, '0x0360', nq'|???|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(229, '0x00E5', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(318, '0x013E', nq'|Rose Incense|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(346, '0x015A', nq'|TM19|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(716, '0x02CC', nq'|Mega Charm|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(34, '0x0022', nq'|Energy Powder|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(811, '0x032B', nq'|Grassium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(503, '0x01F7', nq'|Tidal Bell|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(71, '0x0047', nq'|Shoal Shell|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(73, '0x0049', nq'|Blue Shard|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(92, '0x005C', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(987, '0x03DB', nq'|Pikachu Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(191, '0x00BF', nq'|Soul Dew|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(228, '0xE4', nq'|TM36|', q'|TMs and HMs|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(107, '0x006B', nq'|Big Pearl|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(788, '0x0314', nq'|Rockium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(219, '0x00DB', nq'|Mental Herb|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(353, '0x0161', nq'|TM26|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(683, '0x02AB', nq'|Garchompite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(265, '0x0109', nq'|Wide Lens|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(449, '0x01C1', nq'|Poffin Case|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(11, '0x000B', nq'|Luxury Ball|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(496, '0x01F0', nq'|Love Ball|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(128, '0x0080', nq'|unknown|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(35, '0x0023', nq'|Energy Root|', q'|Medicine|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(157, '0x009D', nq'|Lum Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(638, '0x027E', nq'|Reveal Glass|', q'|Key items|', q'|Black 2, White 2|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(541, '0x021D', nq'|Air Balloon|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(624, '0x0270', nq'|Gram 2|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(130, '0x0082', nq'|???|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(515, '0x0203', nq'|Data Card 11|', q'|Items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(685, '0x02AD', nq'|Latiosite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(805, '0x0325', nq'|Eevium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(304, '0x0130', nq'|Toxic Plate|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(385, '0x0181', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(191, '0x00BF', nq'|Soul Dew|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(249, '0x00F9', nq'|Charcoal|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(211, '0xD3', nq'|TM20|', q'|TMs and HMs|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(421, '0x01A5', nq'|HM02|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(252, '0x00FC', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(780, '0x030C', nq'|Grassium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(0, '0x00', nq'|Nothing|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(50, '0x0032', nq'|Yellow Shard|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(816, '0x0330', nq'|Flyinium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(232, '0x00E8', nq'|Scope Lens|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(290, '0x0122', nq'|TM02|', q'|TMs and HMs|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(437, '0x01B5', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(265, '0x0109', nq'|Wide Lens|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(261, '0x0105', nq'|Itemfinder|', q'|Key items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(219, '0x00DB', nq'|Mental Herb|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(238, '0x00EE', nq'|Hard Stone|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(762, '0x02FA', nq'|Pidgeotite|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(449, '0x01C1', nq'|Poffin Case|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(315, '0x013B', nq'|Rock Incense|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(437, '0x01B5', nq'|Pal Pad|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(350, '0x015E', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(1003, '0x03EB', nq'|Poliwag Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(530, '0x0212', nq'|Data Card 26|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(227, '0x00E3', nq'|Deep Sea Scale|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(736, '0x02E0', nq'|S.S. Ticket|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(110, '0x006E', nq'|Oval Stone|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(178, '0x00B2', nq'|Nomel Berry|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(624, '0x0270', nq'|Gram 2|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(428, '0x01AC', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(39, '0x27', nq'|Calcium|', 1);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(65, '0x0041', nq'|Blue Flute|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(95, '0x5F', nq'|Mystic Water|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(330, '0x014A', nq'|TM42|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(717, '0x02CD', nq'|Mega Glove|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(314, '0x013A', nq'|TM26|', q'|TMs and HMs|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(153, '0x0099', nq'|Aspear Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(71, '0x0047', nq'|PP Max|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(450, '0x01C2', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(42, '0x002A', nq'|Black Flute|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(211, '0x00D3', nq'|Poison Barb|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(764, '0x02FC', nq'|Diancite|', q'|Items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(38, '0x0026', nq'|Lava Cookie|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(493, '0x01ED', nq'|Level Ball|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(331, '0x014B', nq'|TM43|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(243, '0x00F3', nq'|Mystic Water|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(503, '0x01F7', nq'|Tidal Bell|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(169, '0x00A9', nq'|Pomeg Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(943, '0x03AF', nq'|N-Solarizer|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(278, '0x0116', nq'|Scanner|', q'|Key items|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(357, '0x0165', nq'|TM30|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(100, '0x0064', nq'|Claw Fossil|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(814, '0x032E', nq'|Poisonium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(440, '0x01B8', nq'|Galactic Key|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(361, '0x0169', nq'|Town Map|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(327, '0x0147', nq'|TM39|', q'|TMs and HMs|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(232, '0x00E8', nq'|Scope Lens|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GEN)
values(206, '0xCE', nq'|TM06|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(484, '0x01E4', nq'|Mystery Egg|', q'|Key items|', q'|HeartGold, SoulSilver|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(482, '0x01E2', nq'|Silver Wing|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(265, '0x0109', nq'|Wide Lens|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(592, '0x0250', nq'|Dire Hit 2|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(33, '0x0021', nq'|Moomoo Milk|', q'|Medicine|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(238, '0x00EE', nq'|Hard Stone|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(3, '0x0003', nq'|Great Ball|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(745, '0x02E9', nq'|Mega Pendant|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(244, '0x00F4', nq'|Sharp Beak|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(315, '0x013B', nq'|Rock Incense|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(437, '0x01B5', nq'|Pal Pad|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(346, '0x015A', nq'|TM19|', q'|TMs and HMs|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(227, '0x00E3', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(495, '0x01EF', nq'|Heavy Ball|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(157, '0x009D', nq'|Lum Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, GEN)
values(234, '0xEA', nq'|TM34|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(327, '0x0147', nq'|Razor Fang|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(546, '0x0222', nq'|Cell Battery|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(695, '0x02B7', nq'|Power Plant Pass|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(22, '0x16', nq'|CascadeBadge|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(164, '0x00A4', nq'|Pamtre Berry|', q'|Berries|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(815, '0x032F', nq'|Groundium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(218, '0x00DA', nq'|Up-Grade|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(417, '0x01A1', nq'|TM90|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(63, '0x003F', nq'|HP Up|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(717, '0x02CD', nq'|Mega Glove|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(247, '0x00F7', nq'|Spell Tag|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(228, '0xE4', nq'|TM28|', 1);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(288, '0x0120', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(84, '0x0054', nq'|Water Stone|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(319, '0x013F', nq'|Luck Incense|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(2, '0x0002', nq'|Ultra Ball|', q'|Poké Balls|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(330, '0x014A', nq'|TM03|', q'|TMs|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(94, '0x005E', nq'|Moon Stone|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(34, '0x0022', nq'|Energy Powder|', q'|Medicine|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(254, '0x00FE', nq'|Red Scarf|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(243, '0x00F3', nq'|Mystic Water|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(170, '0x00AA', nq'|Kelpsy Berry|', q'|Berries|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(169, '0x00A9', nq'|Pomeg Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(100, '0x0064', nq'|Claw Fossil|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(309, '0x0135', nq'|Stone Plate|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(361, '0x0169', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(83, '0x0053', nq'|Super Repel|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(139, '0x008B', nq'|RSVP Mail|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(944, '0x03B0', nq'|N-Lunarizer|', q'|Key items|', q'|Ultra Sun, Ultra Moon|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(33, '0x0021', nq'|Moomoo Milk|', q'|Medicine|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(482, '0x01E2', nq'|Silver Wing|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(218, '0x00DA', nq'|Soothe Bell|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(501, '0x01F5', nq'|Photo Album|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(502, '0x01F6', nq'|GB Sounds|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(356, '0x0164', nq'|TM29|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(775, '0x0307', nq'|Eon Flute|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(315, '0x013B', nq'|Rock Incense|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(437, '0x01B5', nq'|Pal Pad|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(493, '0x01ED', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(822, '0x0336', nq'|Darkinium Z|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(439, '0x01B7', nq'|Old Charm|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(567, '0x0237', nq'|Battle CD 34|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(475, '0x01DB', nq'|unknown|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(98, '0x0062', nq'|Gooey Mulch|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(309, '0x0135', nq'|TM21|', q'|TMs and HMs|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(371, '0x0173', nq'|TM44|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(327, '0x0147', nq'|Razor Fang|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(370, '0x0172', nq'|TM43|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(962, '0x03C2', nq'|Tough Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(151, '0x0097', nq'|Wepear Berry|', q'|Berries|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(80, '0x0050', nq'|Sun Stone|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(451, '0x01C3', nq'|Suite Key|', q'|Key items|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(695, '0x02B7', nq'|Power Plant Pass|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(16, '0x0010', nq'|Cherish Ball|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(358, '0x0166', nq'|TM31|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(355, '0x0163', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(810, '0x032A', nq'|Electrium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(536, '0x0218', nq'|Enigma Stone|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(388, '0x0184', nq'|TM61|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(485, '0x01E5', nq'|Red Apricorn|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(153, '0x0099', nq'|Aspear Berry|', q'|Berries|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(586, '0x024A', nq'|Battle CD 53|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(62, '0x3E', nq'|PP Up|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(426, '0x01AA', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(319, '0x013F', nq'|Luck Incense|', q'|Items|', 5);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(630, '0x0276', nq'|Permit|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(731, '0x02DB', nq'|Key to Room 2|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(459, '0x01CB', nq'|Parcel|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(243, '0x00F3', nq'|Mystic Water|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(841, '0x0349', nq'|Forage Bag|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(204, '0x00CC', nq'|Hard Stone|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GEN)
values(121, '0x0079', nq'|unknown|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(58, '0x003A', nq'|X Defense|', q'|Battle items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(170, '0x00AA', nq'|Kelpsy Berry|', q'|Berries|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(350, '0x015E', nq'|TM23|', q'|TMs and HMs|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(4, '0x0004', nq'|Poké Ball|', q'|Poké Balls|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(267, '0x010B', nq'|Wise Glasses|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(265, '0x0109', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(750, '0x02EE', nq'|Mega Anklet|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(227, '0xE3', nq'|TM35|', q'|TMs and HMs|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(756, '0x02F4', nq'|Galladite|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(139, '0x008B', nq'|RSVP Mail|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(797, '0x031D', nq'|Z-Ring|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(39, '0x0027', nq'|Max Ether|', q'|Medicine|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(245, '0x00F5', nq'|Poison Barb|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(817, '0x0331', nq'|Psychium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(592, '0x0250', nq'|Dire Hit 2|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(33, '0x0021', nq'|Moomoo Milk|', q'|Medicine|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(137, '0x0089', nq'|Greet Mail|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(15, '0x0F', nq'|Parlyz Heal|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(482, '0x01E2', nq'|Silver Wing|', q'|Key items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(502, '0x01F6', nq'|GB Sounds|', q'|Key items|', 6);
insert into itemIDs(ID, HEX, NAME, GEN)
values(252, '0xFC', nq'|TM52|', 1);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(219, '0x00DB', nq'|Shell Bell|', q'|Items|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(122, '0x007A', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(360, '0x0168', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(176, '0x00B0', nq'|Magost Berry|', q'|Berries|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(300, '0x012C', nq'|Zap Plate|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(991, '0x03DF', nq'|Clefairy Candy|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(494, '0x01EE', nq'|Lure Ball|', q'|Poké Balls|', 5);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(437, '0x01B5', nq'|Pal Pad|', q'|Key items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(110, '0x6E', nq'|Pearl|', q'|Items|', 2);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(699, '0x02BB', nq'|Discount Coupon|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(327, '0x0147', nq'|Razor Fang|', q'|Items|', 4);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(451, '0x01C3', nq'|Suite Key|', q'|Key items|', 4);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(527, '0x020F', nq'|Data Card 23|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(239, '0x00EF', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(295, '0x0127', nq'|Shed Shell|', q'|Let's Go|', 7);
insert into itemIDs(ID, HEX, NAME, GEN)
values(250, '0x00FA', nq'|unknown|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(124, '0x007C', nq'|Mech Mail|', q'|Items|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(322, '0x0142', nq'|TM34|', q'|TMs and HMs|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(218, '0x00DA', nq'|Up-Grade|', q'|Items|', q'|Colosseum|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(16, '0x0010', nq'|Cherish Ball|', q'|Items|', 7);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(783, '0x030F', nq'|Poisonium Z|', q'|Z-Crystals|', 7);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(115, '0x0073', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(408, '0x0198', nq'|unknown|', q'|XD|', 3);
insert into itemIDs(ID, HEX, NAME, POKCET, GEN)
values(319, '0x013F', nq'|Luck Incense|', q'|Items|', 6);
insert into itemIDs(ID, HEX, NAME, POKCET, GAME, GEN)
values(754, '0x02F2', nq'|Sablenite|', q'|Items|', q'|Omega Ruby, Alpha Sapphire|', 6);
insert into itemIDs(ID, HEX, NAME, GAME, GEN)
values(818, '0x0332', nq'|Buginium Z|', q'|Let's Go|', 7);