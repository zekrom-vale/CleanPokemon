create table ITEMS(
NAME varchar2(50) primary key, --Name of the item
GEN number(2,0) references GENERATION(GEN) check(gen>0), --Generation of first implimintaation
GEN2 number(2,0) references GENERATION(GEN) check(gen2>0), --Last generation implemented, null if still exists
DESCRIPTION clob , --An explination of what the item is
NOTE clob , --Syntax notes
JAPANESE_KANA nvarchar2(200) , --The item's name in JAPANESE_KANA
JAPANESE_ROMAJI nvarchar2(200) , --The item's name in JAPANESE_ROMAJI
FRENCH nvarchar2(200) , --The item's name in FRENCH
GERMAN nvarchar2(200) , --The item's name in GERMAN
ITALIAN nvarchar2(200) , --The item's name in ITALIAN
SPANISH nvarchar2(200) , --The item's name in SPANISH
KOREAN_HANGUL nvarchar2(200) , --The item's name in KOREAN_HANGUL
KOREAN_ROMANIZED nvarchar2(200) , --The item's name in KOREAN_ROMANIZED
CHINESE_HANZI nvarchar2(200) , --The item's name in CHINESE_HANZI
CHINESE_ROMANIZED nvarchar2(200) , --The item's name in CHINESE_ROMANIZED
STAR number(8,0) check(star>=0) --A binary mask indicating what had an astrict
);

create table itemIDs(
ID number(5,0) not null check(id>=0), --The ingame numeric identifyer
HEX varchar2(10) , --The hexadesimal value of the ID
NAME varchar2(50) , --The name of the item
POKCET varchar2(50) , --The location of the item, in the bag
GAME varchar2(200) , --The game the item is limited to, null if not
GEN number(2,0) references GENERATION(GEN) check(gen>0), --The generation the ID and item corisponds to
CONSTRAINT un_ID unique(ID, GEN, GAME), --Ensure no duplicates per GEN and GAME, by ID
CONSTRAINT un_ID_NAME unique(NAME, GEN, GAME) --Ensure no duplicates per GEN and GAME, by NAME
);






insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Blu ID Badge|', 3 , q'|One of four keys needed to unlock the north door of Realgam Tower.|' , nq'|ID?????|', nq'|ID Badge Ao|', nq'|Passe Bleu|', nq'|Blaue ID-Marke|', nq'|Pass Blu|', nq'|Pase Azul|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Miracle Seed|', 2 , q'|Raises the power of Grass-type moves.|' , nq'|??????|', nq'|Kiseki no Tane|', nq'|Grain Miracle|', nq'|Wundersaat|', nq'|Miracolseme|', nq'|Semilla Milagro|', nq'|????|', nq'|Gijeogui Ssi|', nq'|???? / ????|', nq'|Q�ji Zhongzi / K�ihjik J�ngj�|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Audinite|', 6 , q'|Allows Audino to Mega Evolve into Mega Audino.|' , nq'|???????|', nq'|Tabunnenite|', nq'|Nanm�ou�te|', nq'|Ohrdochnit|', nq'|Audinite|', nq'|Audinita|', nq'|??????|', nq'|Dabunienite|', nq'|???????? / ????????|', nq'|Ch�b�duow�w� J�nhu� Sh� / Chabatdowawa Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Purple Petal|', 7 , q'|A purple petal required to complete Mina's Trial.|' , nq'|????????|', nq'|Murasaki Hanabira|', nq'|P�tale Violet|', nq'|Violettes Blatt|', nq'|Petalo violetto|', nq'|P�talo Violeta|', nq'|????|', nq'|Bora Kkochip|', nq'|????|', nq'|Zi-s� Huab�n / J�-sik Faf�an|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Mech Mail|', 3 , q'|Mail with a mechanical pattern. To be held by a Pok�mon for delivery.|' , nq'|????????|', nq'|Mechanical Mail|', nq'|Lettre Meca|', nq'|Eilbrief|', nq'|Mess. Tecno|', nq'|Carta Im�n|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Silver Wing|', 2 , q'|Summons Lugia.|' , nq'|???????|', nq'|Gin'iro no Hane|', nq'|Argent'Aile|', nq'|Silberfl�gel|', nq'|Aladargento|', nq'|Ala Plateada|', nq'|????|', nq'|Eunbit Nalgae|', nq'|???? / ????|', nq'|Y�n-s�-zhi Yu / Ng�hn-sik-ji Y�h|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Meadow Plate|', 4 , q'|Raises the power of Grass-type moves.|' , nq'|????????|', nq'|Midori no Pureto|', nq'|Plaque Herbe|', nq'|Wiesentafel|', nq'|Lastraprato|', nq'|Tabla Pradal|', nq'|??????|', nq'|Chorok Plate|', nq'|???? / ????|', nq'|B�lu Sh�ban / Bikluhk Sehkb�an|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Belue Berry|', 3 , q'|Poffin and Pok�block ingredient.|' , nq'|?????|', nq'|Beribu no Mi|', nq'|Baie Myrte|', nq'|Myrtilbeere|', nq'|Baccartillo|', nq'|Baya Andano|', nq'|????|', nq'|Luebe Yeolmae|', nq'|???|', nq'|Di�nm�i Guo / Dihnm�ih Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Medichamite|', 6 , q'|Allows Medicham to Mega Evolve into Mega Medicham.|' , nq'|????????|', nq'|Charemnite|', nq'|Charminite|', nq'|Meditalisnit|', nq'|Medichamite|', nq'|Medichamita|', nq'|??????|', nq'|Yogaramnite|', nq'|?????? / ??????|', nq'|Qi�l�imu J�nhu� Sh� / Hapl�uihm�uh Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Grubby Hanky|', 5 , q'|Can be exchanged for a Fluffy Tail at Caf� Warehouse.|' , nq'|????????|', nq'|Dirty Handkerchief|', nq'|MouchoirSale|', nq'|Schn�uztuch|', nq'|Pezza Sporca|', nq'|Pan. Sucio|', nq'|?????|', nq'|Deoreo Sonsugeon|', nq'|??? / ???|', nq'|Zang Shoup� / Jong S�upaak|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Rock Incense|', 4 , q'|Raises the power of Rock-type moves. A Sudowoodo holding this can breed to produce Bonsly Eggs.|' , nq'|???????|', nq'|Ganseki Oko|', nq'|Encens Roc|', nq'|Steinrauch|', nq'|Roccioaroma|', nq'|Incienso roca|', nq'|????|', nq'|Amseog Hyangno|', nq'|????|', nq'|Y�nsh� Xunxiang / Ng�ahmsehk Fanheung|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Red ID Badge|', 3 , q'|One of four keys needed to open the front door of Realgam Tower.|' , nq'|ID?????|', nq'|ID Badge Aka|', nq'|Passe Rouge|', nq'|Rote ID-Marke|', nq'|Pass Rosso|', nq'|Pase Rojo|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Solganium Z|', 7 , q'|Allows Solgaleo and Dusk Mane Necrozma to upgrade Sunsteel Strike to the special Z-Move Searing Sunraze Smash.|' , nq'|?????Z|', nq'|Solgaleo-Z|', nq'|Solgaz�lite|', nq'|Solgalium Z|', nq'|Solgaleium Z|', nq'|Solgaleostal Z|', nq'|????Z|', nq'|Solgaleo-Z|', nq'|?????Z / ?????Z|', nq'|Suo'erjial�iou-Z / Soky�hgal�uihau-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Max Repel|', 1 , q'|Prevents wild Pok�mon with a lower level than the first member of the party from appearing for 250 steps|' , nq'|????????|', nq'|Gold Spray|', nq'|Max Repousse|', nq'|Top-Schutz|', nq'|Repellente Max|', nq'|Repelente Maximo|', nq'|??????|', nq'|Gold Spray|', nq'|???? / ????|', nq'|Hu�ngjin Penw� / W�hnggam Panmouh|', 48 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( q'|HM|' , nq'|??????|', nq'|Hiden Machine|', nq'|CS|', nq'|VM|', nq'|MN|', nq'|MO|', nq'|????|', nq'|Bijeon Machine|', nq'|????? / ?????|', nq'|M�chu�n Xu�x�q� / Beichy�hn Hohkjaahphei|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Scope Lens|', 3 , q'|Raises chances of getting a critical hit.|' , nq'|??????|', nq'|Pint Lens|', nq'|Lentilscope|', nq'|Scope-Linse|', nq'|Mirino|', nq'|Periscopio|', nq'|????|', nq'|Chojeom Lens|', nq'|??? / ???|', nq'|Jiaodian J�ng / Jiud�m Geng|', 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( q'|Roto Encounter|' , nq'|?????|', nq'|Mikke Pon|', nq'|Moti-App�t|', nq'|Lockbon|', nq'|Incontra'n'roll|', nq'|Cup�n Reclamo|', nq'|�???|', nq'|�???|', nq'|????|', nq'|Xiangy� P�ngp�ng / Seungyuh Pungpung|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Star Piece|', 2 , q'|Can be sold for 4900.|' , nq'|??????|', nq'|Hoshi no Kakera|', nq'|Morceau d'�toile|', nq'|Sternenst�ck|', nq'|Pezzo Stella|', nq'|Trozo Estrella|', nq'|????|', nq'|Byeorui Jogak|', nq'|????|', nq'|Xingxing Su�pi�n / Singsing Seuip�n|', 144 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Explorer Kit|', 4 , q'|A Key Item which can be used to go to Sinnoh Underground.|' , nq'|???????|', nq'|Tanken Set|', nq'|Explorakit|', nq'|Forschersack|', nq'|Esplorokit|', nq'|Kit Explor.|', nq'|????|', nq'|Tamheom Set|', nq'|????*|'||chr(10)||nq'|????|', nq'|T�nxian Zuh� / Taamh�m J�uhahp*|'||chr(10)||nq'|T�nxian T�ozhuang|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Eviolite|', 5 , q'|Raises the holder's Defense and Special Defense by 50% if the holder is capable of evolving.|' , nq'|???????|', nq'|Shinka no Kiseki|', nq'|�voluroc|', nq'|Evolith|', nq'|Evolcondensa|', nq'|Mineral Evol|', nq'|??? ??|', nq'|Jinhwa-yi Hwiseok|', nq'|???? / ????|', nq'|J�nhu� Q�sh� / Jeunfa K�ihsehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Ghost Gem|', 5 , q'|Increases the power of the holder's first Ghost-type move by 50%, and is consumed after use.|' , nq'|????????|', nq'|Ghost Jewel|', nq'|Joyau Spectre|', nq'|Geisterjuwel|', nq'|Bijouspettro|', nq'|Gema Fantasma|', nq'|?????|', nq'|Ghost Jewel|', nq'|???? / ????|', nq'|Youl�ng Baosh� / Yaul�hng B�usehk|', 208 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Fairy Memory|', 7 , q'|Makes Silvally a Fairy-type Pok�mon and makes Multi-Attack a Fairy-type move.|' , nq'|????????|', nq'|Fairy Memory|', nq'|ROM F�e|', nq'|Feen-Disc|', nq'|ROM Folletto|', nq'|Disco Hada|', nq'|??????|', nq'|Fairy Memory|', nq'|?????*|'||chr(10)||nq'|?????|', nq'|Yaojing J�y�di� / Y�ujing Geiyikdihp*|'||chr(10)||nq'|Yaojing C�nchudi�|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Berry Pots|', 4 , q'|Allows Berry growth while traveling.|' , nq'|????????|', nq'|Kinomi Planter|', nq'|Plante Baies|', nq'|Pflanzset|', nq'|Piantabacche|', nq'|Plantabayas|', nq'|???????|', nq'|Namu Yeolmae Planter|', nq'|????? / ?????|', nq'|Sh�guo Zh�ngzh� P�n / Syuhgw� J�ngjihk P�hn|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Ride Pager|', 7 , q'|By entering certain numbers on this pager, you can summon Ride Pok�mon in an instant.|' , nq'|?????|', nq'|Ride Gear|', nq'|Appel-Monture|', nq'|Pok�Mobil-Funk|', nq'|Chiamapassaggio|', nq'|Buscamontura|', nq'|?????|', nq'|Ride Gear|', nq'|???? / ????|', nq'|Q�x�ng Zhuangzh� / K�ihh�ahng Jongji|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Berry|', 2 , q'|Restores 10 HP. A Pok�mon can use it automatically if it is holding it.|' , nq'|???|', nq'|Kino Mi|', nq'|Baie|', nq'|Beere|', nq'|Bacca|', nq'|Baya|', nq'|????|', nq'|Namu Yeolmae|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Binding Band|', 5 , q'|Increases the end of turn damage of partially trapping moves from 1/16 to ? of the target's maximum HP.|' , nq'|???????|', nq'|Shimetsuke Band|', nq'|Bande �treinte|', nq'|Klammerband|', nq'|Legafascia|', nq'|Banda Atadura|', nq'|????|', nq'|Joim Band|', nq'|???? / ????|', nq'|Jinbang Sh�d�i / G�nb�ng Chukd�ai|', 144 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Zoom Lens|', 4 , q'|A held item that boosts the critical hit ratio if the holder moves after the foe.|' , nq'|????????|', nq'|Focus Lens|', nq'|Lentille Zoom|', nq'|Zoomlinse|', nq'|Zoomlente|', nq'|Telescopio|', nq'|?????|', nq'|Focus Lens|', nq'|??? / ???|', nq'|Du�jiao J�ng / Deuijiu Geng|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Contest Costume|', 6 , q'|Worn during Pok�mon Contest Spectacular performances.|' , nq'|??????|'||chr(10)||nq'|??????|', nq'|Live Suit|'||chr(10)||nq'|Live Dress|', nq'|Costume Live|'||chr(10)||nq'|Robe Live|', nq'|Live-Anzug|'||chr(10)||nq'|Live-Kleid|', nq'|Costume Live|'||chr(10)||nq'|Vestito Live|', nq'|Traje de Gala|'||chr(10)||nq'|Vestido de Gala|', nq'|?????|'||chr(10)||nq'|??????|', nq'|Live Suit|'||chr(10)||nq'|Live Dress|', nq'|???? / ????|'||chr(10)||nq'|???? / ????|', nq'|Yanchu Lif� / Y�ncheut L�ihfuhk|'||chr(10)||nq'|Yanchu Liq�n / Y�ncheut L�ihkw�hn|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Focus Band|', 2 , q'|May leave the holder with 1 HP when a move would normally cause them to faint.|' , nq'|????????|', nq'|Kiai no Hachimaki|', nq'|Bandeau|', nq'|Fokus-Band|', nq'|Bandana|', nq'|Cinta Focus|', nq'|??????|', nq'|Gihabui Meoritti|', nq'|???? / ????|', nq'|Q�sh� T�ud�i / Heisai T�uhdaai|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|X Sp. Def 2|', 5 , q'|Sharply raises a Pok�mon's Special Defense. Wonder Launcher only.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Insect Plate|', 4 , q'|Raises the power of Bug-type moves.|' , nq'|????????|', nq'|Tamamushi Pureto|', nq'|Plaquinsect|', nq'|K�fertafel|', nq'|Lastrabaco|', nq'|Tabla Bicho|', nq'|????????|', nq'|Bidanbeolle Plate|', nq'|???? / ????|', nq'|Y�ch�ng Sh�ban / Yuhkch�hng Sehkb�an|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|F-Disk|', 3 , q'|Moves the UFO in The Under to the Under Colosseum.|' , nq'|F-????|', nq'|F-Disk|', nq'|Disque-A|', nq'|V-Disc|', nq'|Disco Avanti|', nq'|Disco A|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|Kuo Berry|', 3 , q'|Cures Burn status. If transferred to Generation IV via Pal Park, it will turn into an Enigma Berry.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Intriguing Stone|', 6 , q'|Can be exchanged for a Sun StoneXY/PidgeotiteORAS.|' , nq'|???????|', nq'|Sugosona Ishi|', nq'|Pierre Insolite|', nq'|Kurioser Stein|', nq'|Sasso suggestivo|', nq'|Piedra Ins�lita|', nq'|??????|', nq'|Daedanhaldeushan Dol|', nq'|???|', nq'|S� Zhensh� / Ch�h Jansehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Item Urge|', 5 , q'|Causes an ally to use its held item. Wonder Launcher only.|' , nq'|???????|', nq'|Item Call|', nq'|Appel Objet|', nq'|Itemappell|', nq'|Chiamoggetto|', nq'|Activaobjeto|', nq'|????|', nq'|Item Call|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pink Apricorn|', 2 , q'|Kurt will make a Love Ball out of it.|', q'|Formatted as Pnk Apricorn prior to Generation VI.|', nq'|??????|', nq'|Momo Bonguri|', nq'|Noigrume Ros|', nq'|Aprikoko Pnk|', nq'|Ghicocca Rosa|', nq'|Bonguri Rosa|', nq'|?????|', nq'|Damhong Gyutori|', nq'|???|', nq'|Fen Qi�guo / F�n K�uhgw�|', 1072 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Gardevoirite|', 6 , q'|Allows Gardevoir to Mega Evolve into Mega Gardevoir.|' , nq'|????????|', nq'|Sirknightnite|', nq'|Gardevoirite|', nq'|Guardevoirnit|', nq'|Gardevoirite|', nq'|Gardevoirita|', nq'|??????|', nq'|Gadiannite|', nq'|?????? / ??????|', nq'|Shan�iduo J�nhu� Sh� / Sanoihd� Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Charti Berry|', 4 , q'|Reduces damage from a super effective Rock-type move by 50%.|' , nq'|?????|', nq'|Yorogi no Mi|', nq'|Baie Charti|', nq'|Chiaribeere|', nq'|Baccaciofo|', nq'|Baya Alcho|', nq'|????|', nq'|Rumi Yeolmae|', nq'|??? / ???|', nq'|Caoc�n Guo / Ch�uch�ahm Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|PP Max|', 3 , q'|Raises the PP of a move to the maximum.|' , nq'|????????|', nq'|Point Max|', nq'|PP Max|', nq'|AP-Top|', nq'|PP-Max|', nq'|PP M�ximos|', nq'|??? ??|', nq'|Point Max|', nq'|PP????? / PP?????|', nq'|PP J�xi�n T�shengj� / PP Gihkhaahn T�ihsingjaih|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Mago Berry|', 3 , q'|When HP falls below 25%, restores 50% HP, but confuses Pok�mon that dislike spicy food (12.5% when below 50% before Gen. VII).|' , nq'|????|', nq'|Mago no Mi|', nq'|Baie Mago|', nq'|Magobeere|', nq'|Baccamango|', nq'|Baya Ango|', nq'|????|', nq'|Mago Yeolmae|', nq'|???|', nq'|M�ngm�ng Guo / M�hngm�hng Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Soot Sack|', 3 , q'|Allows player to gather soot from Mt. Chimney and exchange for Flutes.|' , nq'|?????|', nq'|Hai Bukuro|', nq'|Sac � Suie|', nq'|Aschetasche|', nq'|Sacco Cenere|', nq'|Saco holl�n|', nq'|????|', nq'|Geomdaeng Jaru|', nq'|???|', nq'|J�hui D�i / Jaahpfui Doih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Paralyze Heal|', 1 , q'|Heals paralysis.|', q'|Called Parlyz Heal prior to Generation VI.|', nq'|?????|', nq'|Mahi Naoshi|', nq'|Anti-Para|', nq'|Para-Heiler|', nq'|Antiparalisi|', nq'|Antiparalizador|', nq'|?????|', nq'|Mabi Chiryoje|', nq'|??? / ???|', nq'|Jiem�y�o / G�aim�hyeuhk|', 16 );
insert into ITEMS( NAME, GEN, GEN2, DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Coin Case|', 1, 4, q'|A Key Item that stores the coins collected at the local Game Corner.|' , nq'|??????|', nq'|Coin Case|', nq'|Boite Jetons|', nq'|M�nzkorb|', nq'|Salvadanaio|', nq'|Monedero|', nq'|?????|', nq'|Dongjeon Case|', nq'|??? / ???|', nq'|D�ib� H� / Doihbaih Hahp|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Swift Wing|', 5 , q'|Raises the Speed of a Pok�mon.|' , nq'|????????|', nq'|Shunpatsu no Hane|', nq'|Aile Sprint|', nq'|Flinkfeder|', nq'|Piumreazione|', nq'|Pluma �mpetu|', nq'|?????|', nq'|Sunballyeok Nalgae|', nq'|???? / ????|', nq'|Sh�nfa-zhi Yu / Seunfaat-ji Y�h|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Colress Machine|', 5 , q'|A special device that wrings out the potential of Pok�mon. It is an imperfect prototype.|', q'|Formatted as Colress MCHN prior to Generation VI.|', nq'|????????|', nq'|Achroma Machine|', nq'|Nikodule|', nq'|Achromat|', nq'|Acrocongegno|', nq'|Acrom�quina|', nq'|??????|', nq'|Achroma Machine|', nq'|?????? / ??????|', nq'|Ak�lu�ma Jiq� / Ahakl�hm�h Geihei|', 1024 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Power Lens|', 4 , q'|Promotes Special Attack EVs, but lowers Speed in battle.|' , nq'|??????|', nq'|Power Lens|', nq'|Lentille Pouvoir|', nq'|Machtlinse|', nq'|Vigorlente|', nq'|Lente Recia|', nq'|????|', nq'|Power Lens|', nq'|??? / ???|', nq'|L�li�ng J�ng / Lihkleuhng Geng|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|X Attack|', 1 , q'|Raises a Pok�mon's Attack by 2 stages (1 stage before Gen. VII).|' , nq'|??????|', nq'|Plus Power|', nq'|Attaque +|', nq'|X-Angriff|', nq'|Attacco X|', nq'|Ataque X|', nq'|?????|', nq'|Plus Power|', nq'|???? / ????|', nq'|L�li�ng Qi�nghu� / Lihkleuhng K�uhngfa|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Beedrillite|', 6 , q'|Allows Beedrill to Mega Evolve into Mega Beedrill.|' , nq'|??????|', nq'|Speanite|', nq'|Dardargnite|', nq'|Bibornit|', nq'|Beedrillite|', nq'|Beedrillita|', nq'|??????|', nq'|Tokchimbungnite|', nq'|?????? / ??????|', nq'|D�zhenfeng J�nhu� Sh� / Daaihjamfung Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|Dire Hit 2|', 5 , q'|Raises critical hit ratio by 2 levels in battle. Wonder Launcher only.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Amaze Mulch|', 6 , q'|Combines the effects of Boost Mulch, Rich Mulch, and Surprise Mulch: Causes an applied Berry patch's soil to dry quicker, increases final Berry harvest by 2 Berries, and makes Berry mutations more likely.|' , nq'|???????|', nq'|Tondemo Koyashi|', nq'|Fertiprodige|', nq'|Ultramulch|', nq'|Fertilprodigio|', nq'|Abono Ins�lito|', nq'|??????|', nq'|Gijeolchopung Biryo|', nq'|???|', nq'|Chaoxi�o F�i / Chiuhaauh F�ih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Vs. Recorder|', 4 , q'|Used to record and replay battles.|' , nq'|????????|', nq'|Battle Recorder|', nq'|Magn�to VS|', nq'|Kampfkamera|', nq'|Registradati|', nq'|C�mara Lucha|', nq'|?????|', nq'|Battle Recorder|', nq'|????? / ?????|', nq'|Du�zh�n J�l� Q� / Deuijin Geiluhk Hei|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Ampharosite|', 6 , q'|Allows Ampharos to Mega Evolve into Mega Ampharos.|' , nq'|????????|', nq'|Denryunite|', nq'|Pharampite|', nq'|Ampharosnit|', nq'|Ampharosite|', nq'|Ampharosita|', nq'|?????|', nq'|Jeonryongnite|', nq'|????? / ?????|', nq'|Di�nl�ng J�nhu� Sh� / Dihnl�hng Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Thick Club|', 3 , q'|Doubles Cubone and Marowak's Attack.|' , nq'|?????|', nq'|Futoi Hone|', nq'|Masse Os|', nq'|Kampfknochen|', nq'|Ossospesso|', nq'|Hueso Grueso|', nq'|???|', nq'|Gulgeun Ppyeo|', nq'|??? / ???|', nq'|Cu Gutou / Chou Gwatt�uh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pok� Ball|', 1 , q'|A ball used to catch Pok�mon.|' , nq'|????????|', nq'|Monster Ball|', nq'|Pok� Ball|', nq'|Pok�ball|', nq'|Pok� Ball|', nq'|Pok� Ball|', nq'|????|', nq'|Monster Ball|', nq'|??? / ???|', nq'|Jingl�ng Qi� / Jingl�hng K�uh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Excite Scent|', 3 , q'|Reduces heart gauge, increases friendship.|' , nq'|????????|', nq'|Wakuwaku no Kaori|', nq'|P. Tonifiant|', nq'|Gl�cks-E.|', nq'|Olio di Rosa|', nq'|Ar. Emoci�n|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|Drash Berry|', 3 , q'|Cures Poison status. Will turn into an Enigma Berry if transferred to Generation IV via Pal Park.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Misty Seed|', 7 , q'|A one-time use item that raises the holder's Sp. Defense by one stage upon activation of Misty Terrain.|' , nq'|??????|', nq'|Mist Seed|', nq'|Graine Brume|', nq'|Nebel-Samen|', nq'|Nebbiaseme|', nq'|Semilla Bruma|', nq'|?????|', nq'|Mist Seed|', nq'|???? / ????|', nq'|B�w� Zhongzi / B�ow� Zhongzi / Bohkmouh J�ngj�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lucky Punch|', 3 , q'|Raises Chansey's critical hit rate.|' , nq'|???????|', nq'|Lucky Punch|', nq'|Poing Chance|', nq'|Lucky Punch|', nq'|Fortunpugno|', nq'|Pu�o Suerte|', nq'|????|', nq'|Lucky Punch|', nq'|???|', nq'|J�l� Qu�n / Gatleih Ky�hn|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Power Bracer|', 4 , q'|Promotes Attack EVs, but lowers Speed in battle.|' , nq'|??????|', nq'|Power Wrist|', nq'|Poign�e Pouvoir|', nq'|Machtreif|', nq'|Vigorcerchio|', nq'|Brazal Recio|', nq'|?????|', nq'|Power Wrist|', nq'|???? / ????|', nq'|L�li�ng H�w�n / Lihkleuhng Wuhw�n|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Eon Mail|', 2 , q'|Eevee-printed mail. To be held by a Pok�mon for delivery.|' , nq'|???????|', nq'|Vui-Vui Mail|', nq'|Lettre Evoli|', nq'|Anara-Brief|', nq'|Mess. Eon|', nq'|Carta E�n|', nq'|??????|', nq'|Beuibeui Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Card Key|', 3 , q'|Allows the player to access the east wing of the Shadow PKMN Lab.|' , nq'|?????|', nq'|Card Key|', nq'|Carte Magn.|'||chr(10)||nq'|Cle Magnetique|', nq'|T�r�ffner|'||chr(10)||nq'|Schl�sselkarte|', nq'|Apriporta|', nq'|Llave Magn�tica|'||chr(10)||nq'|T. Magn�tica|', nq'|???|', nq'|Card Key|', nq'|??? / ???|', nq'|Y�oshi Ka / Yeuhks�h Kaat|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Electrium Z|', 7 , q'|Allows a Pok�mon to upgrade their Electric-type damaging moves to the Z-Move Gigavolt Havoc or upgrade their Electric-type status moves into Z-Moves. Makes Arceus an Electric-type Pok�mon.|' , nq'|???Z|', nq'|Electric-Z|', nq'|Voltaz�lite|', nq'|Voltium Z|', nq'|Electrium Z|', nq'|Electrostal Z|', nq'|??Z|', nq'|Jeon-gi-Z|', nq'|?Z / ?Z|', nq'|Di�n-Z / Dihn-Z|', 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( q'|Roto HP Restore|' , nq'|HP??????|', nq'|HP Kaifuku Pon|', nq'|Moti-R�cup' PV|', nq'|KP-Bon|', nq'|PS'n'roll|', nq'|Cup�n PS|', nq'|�???|', nq'|�???|', nq'|HP???? /|'||chr(10)||nq'|HP????|', nq'|HP Hu�f� P�ngp�ng / HP W�ihfuhk Pungpung|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lycanium Z|', 7 , q'|Allows Lycanroc to upgrade Stone Edge to the special Z-Move Splintered Stormshards.|' , nq'|?????Z|', nq'|Lugarugan-Z|', nq'|Lougaroz�lite|', nq'|Wolwerockium Z|', nq'|Lycanrochium Z|', nq'|Lycanrostal Z|', nq'|????Z|', nq'|Rugaruam-Z|', nq'|????Z|', nq'|Zongy�nl�ngr�n-Z / Jungng�ahml�hngy�hn-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Grepa Berry|', 3 , q'|Raises friendship, but lowers Special Defense EVs.|' , nq'|????|', nq'|Ubu no Mi|', nq'|Baie Resin|', nq'|Labrusbeere|', nq'|Baccauva|', nq'|Baya Uvav|', nq'|????|', nq'|Ttoppo Yeolmae|', nq'|???|', nq'|T�op� Guo / T�uhp�uh Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Fightinium Z|', 7 , q'|Allows a Pok�mon to upgrade their Fighting-type damaging moves to the Z-Move All-Out Pummeling or upgrade their Fighting-type status moves into Z-Moves. Makes Arceus a Fighting-type Pok�mon.|' , nq'|????Z|', nq'|Fighting-Z|', nq'|Combaz�lite|', nq'|Battalium Z|', nq'|Luctium Z|', nq'|Lizastal Z|', nq'|??Z|', nq'|Gyeoktu-Z|', nq'|??Z / ??Z|', nq'|G�d�u-Z / Gaakdau-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Discount Coupon|', 6 , q'|Used at any boutique for a one-time 50% discount.|' , nq'|????????|', nq'|Bargain Ticket|', nq'|Bon R�duction|', nq'|Rabattmarke|', nq'|Buono sconto|', nq'|Vale Descuento|', nq'|??????|', nq'|Bargain Ticket|', nq'|??? / ???|', nq'|Zh�ji� Qu�n / Jitga Gyun|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Charcoal|', 2 , q'|Raises the power of Fire-type moves.|' , nq'|????|', nq'|Mokutan|', nq'|Charbon|', nq'|Holzkohle|', nq'|Carbonella|', nq'|Carb�n|', nq'|??|', nq'|Moktan|', nq'|??|', nq'|M�t�n / Muhktaan|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Purple Nectar|', 7 , q'|Changes Oricorio to its Sensu Style.|' , nq'|???????|', nq'|Murasaki no Mitsu|', nq'|Nectar Mauve|', nq'|Purpurner Nektar|', nq'|Nettare viola|', nq'|N�ctar Violeta|', nq'|???|', nq'|Bora Kkul|', nq'|????? / ?????|', nq'|L�nzi-s� Huam� / L�ahnj�-sik Famaht|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Odd Keystone|', 4 , q'|A stone that can trap Spiritomb.|' , nq'|?????|', nq'|Kaname Ishi|', nq'|Cl� de Vo�te|', nq'|Spiritkern|', nq'|Roccianima|', nq'|Piedra Esp�ritu|', nq'|???|', nq'|Sswaegi Dol|', nq'|??|', nq'|Xie Sh� / Sit Sehk|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Repel|', 1 , q'|Prevents wild Pok�mon with a lower level than the first member of the party from appearing for 100 steps|' , nq'|????????|', nq'|Mushi Yoke Spray|', nq'|Repousse|', nq'|Schutz|', nq'|Repellente|', nq'|Repelente|', nq'|????????|', nq'|Beolle Hoepi Spray|', nq'|???? / ????|', nq'|Ch�ch�ng Penw� / Ch�uihch�hng Panmouh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Wacan Berry|', 4 , q'|Reduces damage taken from a super effective Electric-type move.|' , nq'|?????|', nq'|Sokuno no Mi|', nq'|Baie Parma|', nq'|Kerzalberre|', nq'|Baccaparmen|', nq'|Baya Gualot|', nq'|????|', nq'|Chona Yeolmae|', nq'|??? / ???|', nq'|Zh�m� Guo / Jukmuhk Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Wiki Berry|', 3 , q'|When HP falls below 25%, restores 50% HP, but confuses Pok�mon that dislike dry food (12.5% when below 50% before Gen. VII).|' , nq'|????|', nq'|Wi no Mi|', nq'|Baie Wiki|', nq'|Wikibeere|', nq'|Baccakiwi|', nq'|Baya Wiki|', nq'|????|', nq'|Wiki Yeolmae|', nq'|??? / ???|', nq'|Y�q� Guo / Yihk�ih Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|Yago Berry|', 3 , q'|Pok�block ingredient. Will turn into an Enigma Berry if transferred to Generation IV via Pal Park.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Shell Bell|', 3 , q'|Restores HP to the holder based on damage inflicted to the opponent.|' , nq'|???????|', nq'|Kaigara no Suzu|', nq'|Grelot Coque|', nq'|Seegesang|', nq'|Conchinella|', nq'|Campana Concha|', nq'|??????|', nq'|Jogaekkeopjil Bang-ul|', nq'|???? / ????|', nq'|B�ik�-zhi L�ng / Buihok-ji L�hng|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|TMV Pass|', 6 , q'|Allows the player to ride the TMV and access Kiloude City.|' , nq'|TMV??|', nq'|TMV Pass|', nq'|Passe TMV|', nq'|TMV-Pass|', nq'|Pass TMV|', nq'|Abono del TMV|', nq'|TMV??|', nq'|TMV Pass|', nq'|TMV???|', nq'|TMV Z�y�u Pi�o / TMV Jihy�uh Piu|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Full Restore|', 1 , q'|Fully restores all HP and cures all status problems of a Pok�mon.|' , nq'|????????|', nq'|Kaifuku no Kusuri|', nq'|Guerison|', nq'|Top-Genesung|', nq'|Ricarica Totale|', nq'|Restaurar Todo|', nq'|???|', nq'|Hoebok Yak|', nq'|??? / ???|', nq'|Qu�nf�y�o / Chy�hnfuhkyeuhk|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Poison Gem|', 5 , q'|Increases the power of the holder's first Poison-type move by 50%, and is consumed after use.|' , nq'|???????|', nq'|Doku no Jewel|', nq'|Joyau Poison|', nq'|Giftjuwel|', nq'|Bijouveleno|', nq'|Gema Veneno|', nq'|???|', nq'|Dok Jewel|', nq'|???? / ????|', nq'|D�-zhi Baosh� / Duhk-ji B�usehk|', 16 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( q'|Roto Boost|' , nq'|??????|', nq'|Oen Pon|', nq'|Moti-Soutien|', nq'|Statuswertebon|', nq'|Stat'n'roll|', nq'|Cup�n Refuerzo|', nq'|�???|', nq'|�???|', nq'|????|', nq'|Jiay�u P�ngp�ng / Gay�u Pungpung|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Salamencite|', 6 , q'|Allows Salamence to Mega Evolve into Mega Salamence.|' , nq'|????????|', nq'|Bohmandanite|', nq'|Drattakite|', nq'|Brutalandanit|', nq'|Salamencite|', nq'|Salamencita|', nq'|??????|', nq'|Bomandanite|', nq'|?????? / ??????|', nq'|B�ofeil�ng J�nhu� Sh� / Bouhfeil�hng Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Awakening|', 1 , q'|Awakens a sleeping Pok�mon.|' , nq'|??????|', nq'|Nemuke Zamashi|', nq'|Reveil|', nq'|Aufwecker|', nq'|Sveglia|', nq'|Despertar|', nq'|????|', nq'|Jam Kkaeneun Yak|', nq'|??? / ???|', nq'|Jiemi�ny�o / G�aim�hnyeuhk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|X Sp. Def|', 2 , q'|Raises a Pok�mon's Special Defense by 2 stages (1 stage before Gen. VII).|' , nq'|????????|', nq'|Special Guard|', nq'|Def. Sp�. +|', nq'|X-Spezial-Vert.|', nq'|Dif. Sp. X|', nq'|Def. Esp. X|', nq'|?????|', nq'|Special Guard|', nq'|???? / ????|', nq'|T�f�ng Qi�nghu� / Dahkf�hng K�uhngfa|', 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( q'|TM|' , nq'|?????|', nq'|Waza Machine|', nq'|CT|', nq'|TM|', nq'|MT|', nq'|MT|', nq'|????|', nq'|Gisul Machine|', nq'|????? / ?????|', nq'|Zhaosh� Xu�x�q� / Jiusik Hohkjaahphei|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Zygarde Cube|', 7 , q'|Holds collected Zygarde Cores and Cells and teaches Zygarde moves.|' , nq'|????????|', nq'|Zygarde Cube|', nq'|Bo�te Zygarde|', nq'|Zygarde-W�rfel|', nq'|Teca Zygarde|', nq'|Arca de Zygarde|', nq'|??????|', nq'|Zygarde Cube|', nq'|??????? / ???????|', nq'|Jig�'erd� Duomi�nti / Geigaaky�hdak Domihnt�i|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Burn Heal|', 1 , q'|Heals a burn.|' , nq'|??????|', nq'|Yakedo Naoshi|', nq'|Anti-Br�le|', nq'|Feuerheiler|', nq'|Antiscottatura|', nq'|Antiquemar|', nq'|?????|', nq'|Hwasang Chiryoje|', nq'|??? / ???|', nq'|Zhu�shangy�o / Cheukseungyeuhk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Mach Bike|', 3 , q'|A speedy bike that can even go up muddy slopes. It is harder to control than the Acro Bike, and cannot do tricks.|' , nq'|????????|', nq'|Mach Jitensha|', nq'|V�lo de Course|', nq'|Eilrad|', nq'|Bici da corsa|', nq'|Bici de Carreras|', nq'|?????|', nq'|Mach Jajeongeo|', nq'|????? / ?????|', nq'|Yins� Z�x�ngche / Yamchuk Jihh�hngche|', 176 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|TM Case|', 3 , q'|Holds TMs.|' , nq'|????????|', nq'|Waza Machine Case|', nq'|Boite CT|', nq'|VM/TM Box|', nq'|Porta MT-MN|', nq'|Tubo MT-MO|', nq'|???????|', nq'|Gisul Machine Case|', nq'|?????? / ??????|', nq'|Zhaosh� Xu�x�q� H� / Jiusik Hohkjaahphei Hahp|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Go-Goggles|', 3 , q'|A Key Item that allows the player to travel in sandstorm conditions. Unnecessary in Generations IV and V, as the player may enter sandstorm conditions without protection.|' , nq'|????????|', nq'|Go Go Goggle|', nq'|Lunettes Sable|', nq'|W�stenglas|', nq'|Occhialoni|', nq'|Gafas Aislantes|', nq'|????|', nq'|Go-Go Goggle|', nq'|GOGO??? / GOGO???|', nq'|GOGO H� M�j�ng / GOGO Wuh Muhkgeng|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Roller Skates|', 6 , q'|Allows the player to glide around and perform tricks.|' , nq'|????????|', nq'|Roller Skate|', nq'|Rollers|', nq'|Rollerskates|', nq'|Pattini|', nq'|Patines|', nq'|??????|', nq'|Roller Skate|', nq'|???*|'||chr(10)||nq'|???|', nq'|Liubing Xi� / L�uhbing H�aih*|'||chr(10)||nq'|L�nhu� Xi�|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Relic Gold|', 5 , q'|Can be sold for 10000 to the villa owner in Undella Town.|' , nq'|???????|', nq'|Kodai no Kinka|', nq'|Vieux Ducat|', nq'|Alter Dukat|', nq'|Doblonantico|', nq'|Real Oro|', nq'|?????|', nq'|Godae-yi Geumhwa|', nq'|???? / ????|', nq'|Gud�i Jinb� / G�doih Gambaih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|MysticTicket|', 3 , q'|Allows the player to access Navel Rock and catch Lugia and Ho-Oh.|' , nq'|????????|', nq'|Shinpi no Ticket|', nq'|Ticketmystik|', nq'|Geheimticket|', nq'|Biglietto Magico|', nq'|Misti-Ticket|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Litebluemail|', 2 , q'|Mail with a Dratini pattern. To be held by a Pok�mon for delivery.|' , nq'|???????|', nq'|Mizuiro Mail|', nq'|LetrBleuCiel|', nq'|Cyanbrief|', nq'|Mess. Azzurro|', nq'|Carta Azul|', nq'|????|', nq'|Okbit Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Gram 3|', 5 , q'|An important letter which Wingull delivers.|' , nq'|??????3|', nq'|Haitatsubutsu 3|', nq'|Courrier 3|', nq'|Briefpost 3|', nq'|Missiva 3|', nq'|Env�o 3|', nq'|???3|', nq'|Baedalmul 3|', nq'|????3|', nq'|P�is�ng W�pin 3 / Puisung Mahtb�n 3|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Waterium Z|', 7 , q'|Allows a Pok�mon to upgrade their Water-type damaging moves to the Z-Move Hydro Vortex or upgrade their Water-type status moves into Z-Moves. Makes Arceus a Water-type Pok�mon.|' , nq'|??Z|', nq'|Water-Z|', nq'|Aquaz�lite|', nq'|Aquium Z|', nq'|Idrium Z|', nq'|Hidrostal Z|', nq'|?Z|', nq'|Mul-Z|', nq'|?Z|', nq'|Shui-Z / S�ui-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Item Drop|', 5 , q'|Causes an ally to drop its held item. Wonder Launcher only.|' , nq'|????????|', nq'|Item Drop|', nq'|Jette Objet|', nq'|Itemabwurf|', nq'|Lascioggetto|', nq'|Tiraobjeto|', nq'|?????|', nq'|Item Drop|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Protector|', 4 , q'|A held item that allows Rhydon to evolve when traded.|' , nq'|??????|', nq'|Protector|', nq'|Protecteur|', nq'|Sch�tzer|', nq'|Copertura|', nq'|Protector|', nq'|????|', nq'|Protector|', nq'|?? / ??|', nq'|H�j� / Wuhgeuih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Fame Checker|', 3 , q'|Records information on famous people, such as Gym Leaders.|' , nq'|????????|', nq'|Voice Checker|', nq'|Memorydex|', nq'|Ruhmesdatei|', nq'|Pok�VIP|', nq'|Memor�n|' , 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( q'|Roto Stealth|' , nq'|?????|', nq'|Kakure Pon|', nq'|Moti-Camouflage|', nq'|Schutzbon|', nq'|Repelle'n'roll|', nq'|Cup�n Sigilo|', nq'|�???|', nq'|�???|', nq'|???? / ????|', nq'|Yinshen P�ngp�ng / Y�nsan Pungpung|' );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|X Special 2|', 5 , q'|Sharply raises a Pok�mon's Special Attack. Wonder Launcher only.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|Pumkin Berry|', 3 , q'|Cures a frozen Pok�mon. If transferred to Generation IV via Pal Park, it will turn into an Enigma Berry.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Magmarizer|', 4 , q'|A held item that allows Magmar to evolve when traded.|' , nq'|????????|', nq'|Magma Booster|', nq'|Magmariseur|', nq'|Magmaisierer|', nq'|Magmatore|', nq'|Magmatizador|', nq'|??????|', nq'|Magma Booster|', nq'|?????|', nq'|R�ngy�n Zengf� Q� / Y�hngng�ahm Jangfuk Hei|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Eon Ticket|', 3 , q'|Allows player to access Southern Island.|' , nq'|????????|', nq'|Mugen no Ticket|', nq'|Passe �on|', nq'|�on-Ticket|', nq'|Biglietto Eone|', nq'|Ticket E�n|', nq'|????|', nq'|Muhan Ticket|', nq'|???? / ????|', nq'|W�xi�n Chu�npi�o / M�uhhaahn Sy�hnpiu|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Blue Scarf|', 3 , q'|Raises the Beautiful condition.|' , nq'|???????|', nq'|Aoi Bandanna|', nq'|Foul. Bleu|', nq'|Blauer Schal|', nq'|Fascia Blu|', nq'|Pa�uelo Azul|', nq'|????|', nq'|Parang Band|', nq'|???? / ????|', nq'|L�n-s� T�ujin / L�ahm-sik T�uhgan|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Glitter Mail|', 3 , q'|Mail with a Pikachu pattern.|' , nq'|???????|', nq'|Kira Kira Mail|', nq'|Lettre Brill|', nq'|Glitzerbrief|', nq'|Mess. Luci|', nq'|Carta Brillo|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Powerup Part|', 3 , q'|Used to fix the Kids Grid system.|' , nq'|???????|', nq'|Kyoka Parts|', nq'|Amplificateur|', nq'|Ersatzteil|', nq'|Espansione|', nq'|Potenciador|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lift Key|', 1 , q'|Allows operation of the elevator (lift) in the Team Rocket Hideout.|' , nq'|????????|', nq'|Elevator no Kagi|', nq'|Cle Asc.|', nq'|Lift�ffner|', nq'|Chiave Ascensore|', nq'|Llave Ascensor|', nq'|???????|', nq'|Elevator Yeolsoe|', nq'|???? / ????|', nq'|D�anti Y�oshi / Dihntai Yeuhks�h|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Sablenite|', 6 , q'|Allows Sableye to Mega Evolve into Mega Sableye.|' , nq'|???????|', nq'|Yamiraminite|', nq'|T�n�fixite|', nq'|Zobirisnit|', nq'|Sableyeite|', nq'|Sableynita|', nq'|??????|', nq'|Kamkaminite|', nq'|?????? / ??????|', nq'|Gouh�nyan J�nhu� Sh� / Ngauw�hnng�ahn Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Jail Key|', 3 , q'|The key to jail cells in Pyrite Town.|' , nq'|??????|', nq'|Roya no Kagi|', nq'|Cle de la Prison|', nq'|Zellenschl�ssel|', nq'|Chiave Celle|', nq'|Llave Celdas|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|X Attack 6|', 5 , q'|Immensely raises a Pok�mon's Attack. Wonder Launcher only.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Relic Vase|', 5 , q'|Can be sold for 50000 to the villa owner in Undella Town.|' , nq'|??????|', nq'|Kodai no Tsubo|', nq'|Vieux Vase|', nq'|Alte Vase|', nq'|Vasantico|', nq'|�nfora|', nq'|??????|', nq'|Godae-yi Hang'ari|', nq'|???? / ????|', nq'|Gud�i-zhi H� / G�doih-ji W�h|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Iron Ball|', 4 , q'|Cuts a Pok�mon's Speed and makes it susceptible to Ground-type moves.|' , nq'|????????|', nq'|Kuroi Tekkyu|', nq'|Balle Fer|', nq'|Eisenkugel|', nq'|Ferropalla|', nq'|Bola F�rrea|', nq'|????|', nq'|Geomeun Cheolgu|', nq'|???? / ????|', nq'|Hei-s� Tieqi� / Haak-sik Titk�uh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Grassy Seed|', 7 , q'|A one-time use item that raises the holder's Defense by one stage upon activation of Grassy Terrain.|' , nq'|??????|', nq'|Grass Seed|', nq'|Graine Herbe|', nq'|Gras-Samen|', nq'|Erbaseme|', nq'|Semilla Hierba|', nq'|?????|', nq'|Grass Seed|', nq'|???? / ????|', nq'|Qingcao Zhongzi / Chengch�u J�ngj�|', 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( q'|Roto Prize Money|' , nq'|???????|', nq'|Okozukai Pon|', nq'|Moti-Magot|', nq'|Preisgeldbon|', nq'|Soldi'n'roll|', nq'|Cup�n Bot�n|', nq'|�???|', nq'|�???|', nq'|????? / ?????|', nq'|L�ng Huaqi�n P�ngp�ng / L�hng Fach�n Pungpung|' );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|Travel Trunk|', 6 , q'|Not available without cheating. Allows the player to switch their clothes, just like in a Pok�mon Center.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Iron|', 1 , q'|Raises the Defense of a Pok�mon.|' , nq'|???????|', nq'|Bromhexine|', nq'|Fer|', nq'|Eisen|', nq'|Ferro|', nq'|Hierro|', nq'|???|', nq'|Saponin|', nq'|????? / ?????|', nq'|F�ngy� Zengqi�ngj� / F�hngyuh Jangk�uhngjaih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|Common Stone|', 6 , q'|Not available without cheating. Currently has no use.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Armor Fossil|', 4 , q'|A Fossil from which a Shieldon can be resurrected.|' , nq'|??????|', nq'|Tate no Kaseki|', nq'|Fossile Armure|', nq'|Panzerfossil|', nq'|Fossilscudo|', nq'|F�sil Coraza|', nq'|?????|', nq'|Bangpae-ui Hwaseok|', nq'|????|', nq'|D�njia Hu�sh� / T�uhngaap Fasehk|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Sharpedonite|', 6 , q'|Allows Sharpedo to Mega Evolve into Mega Sharpedo.|' , nq'|???????|', nq'|Samehadenite|', nq'|Sharpedite|', nq'|Tohaidonit|', nq'|Sharpedite|', nq'|Sharpedonita|', nq'|???????|', nq'|Sharknianite|', nq'|?????? / ??????|', nq'|J�y�sha J�nhu� Sh� / Geuihng�hsa Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pikashunium Z|', 7 , q'|Allows Pikachu in a cap to upgrade Thunderbolt to the special Z-Move 10,000,000 Volt Thunderbolt.|' , nq'|????Z|', nq'|Satopika-Z|', nq'|Pikachaz�lite|', nq'|Ash-Pikachium Z|', nq'|Ashpikacium Z|', nq'|Ash-Pikastal Z|', nq'|????Z|', nq'|Jiupika-Z|', nq'|???Z|', nq'|Zh�p�ka-Z / Jip�ihka-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Tidal Bell|', 4 , q'|Allows the Kimono Girls to summon Lugia.|' , nq'|???????|', nq'|Uminari no Suzu|', nq'|Glas temp�te|', nq'|Gischtglocke|', nq'|Camp. Onda|', nq'|Camp. Oleaje|', nq'|?????|', nq'|Haemyeong-ui Bang-ul|', nq'|???? / ????|', nq'|Haisheng L�ngdang / H�ising L�hngdong|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Mimikium Z|', 7 , q'|Allows Mimikyu to upgrade Play Rough to the special Z-Move Let's Snuggle Forever.|' , nq'|?????Z|', nq'|Mimikkyu-Z|', nq'|Mimiquiz�lite|', nq'|Mimigmium Z|', nq'|Mimikyum Z|', nq'|Mimikyustal Z|', nq'|???Z|', nq'|Ttarakyu-Z|', nq'|??QZ / ??QZ|', nq'|M�ni-Q-Z / M�ihy�h-Q-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Cry Analyzer|', 3 , q'|Detaches certain translators.|' , nq'|???????|', nq'|Kaidoku Sochi|', nq'|Decodeur Cri|', nq'|Stimmkenner|', nq'|Analiz.Verso|', nq'|Gritolector|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Point Card|', 4 , q'|Stores Battle Points (BP) earned at the Battle Tower or Battle Frontier.|' , nq'|???????|', nq'|Point Card|', nq'|Carte Points|', nq'|Punktekarte|', nq'|Scheda Punti|', nq'|Tarj. Puntos|', nq'|?????|', nq'|Point Card|', nq'|??? / ???|', nq'|Diansh� Ka / D�msou Kaat|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Cornn Berry|', 3 , q'|Poffin and Pok�block ingredient.|' , nq'|?????|', nq'|Mokoshi no Mi|', nq'|Baie Siam|', nq'|Saimbeere|', nq'|Baccavena|', nq'|Baya Mais|', nq'|????|', nq'|Susuk Yeolmae|', nq'|???|', nq'|Y�shu Guo / Yuhksy� Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Coba Berry|', 4 , q'|Reduces damage from a super effective Flying-type move by 50%.|' , nq'|?????|', nq'|Baco no Mi|', nq'|Baie Cobaba|', nq'|Kobabeere|', nq'|Baccababa|', nq'|Baya Kouba|', nq'|????|', nq'|Baco Yeolmae|', nq'|???|', nq'|L�nggua Guo / L�hnggwa Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|X Special 6|', 5 , q'|Immensely raises a Pok�mon's Special Attack. Wonder Launcher only.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Grass Mail|', 4 , q'|Mail with a grass pattern. To be held by a Pok�mon for delivery.|' , nq'|??????|', nq'|Grass Mail|', nq'|Lettre Herbe|', nq'|Wiesenbrief|', nq'|Mess. Erba|', nq'|Carta Hierba|', nq'|????|', nq'|Jandi Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dowsing Machine|', 1 , q'|A Key Item that can be used to detect hidden items.|', q'|Referred to as the Itemfinder prior to Generation IV and as the Dowsing MCHN in Pok�mon HeartGold and SoulSilver and the Generation V games.|', nq'|????????|', nq'|Dowsing Machine|', nq'|Cherch'Objet|', nq'|Itemradar|', nq'|Ricerca Strumenti|', nq'|Zahor�|', nq'|?????|', nq'|Dowsing Machine|', nq'|??? / ???|', nq'|T�nbao Q� / Taamb�u Hei|', 1136 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Voice Case 4|', 3 , q'|Apparently heals a Wobbuffet in Agate Village.|' , nq'|??????4|', nq'|Koe Capsule 4|', nq'|Boite Cri 4|', nq'|Stimmbox 4|', nq'|Disco Verso 4|', nq'|Grabaci�n 4|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|Oak's Parcel|', 1 , q'|Deliver to Professor Oak to receive a Pok�dex.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Mega Ring|', 6 , q'|Allows the player to Mega Evolve a Pok�mon holding the appropriate Mega Stone.|' , nq'|?????|', nq'|Mega Ring|', nq'|M�ga-Anneau|', nq'|Mega-Ring|', nq'|Megacerchio|', nq'|Mega-Aro|', nq'|???|', nq'|Mega Ring|', nq'|??? / ???|', nq'|Chaoj� Hu�n / Chiukap W�ahn|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Custap Berry|', 4 , q'|Allows holder to move first just once when HP is below ?.|' , nq'|?????|', nq'|Iban no Mi|', nq'|Baie Ch�rim|', nq'|Eipfelbeere|', nq'|Baccacrela|', nq'|Baya Chiri|', nq'|????|', nq'|Aesyu Yeolmae|', nq'|??? / ???|', nq'|Sh�tu� Guo / Sikt�h Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Xtransceiver|', 5 , q'|Used to make video calls to other players. Also used by in-game Trainers to advance the story.|' , nq'|????????|', nq'|Live Caster|', nq'|Vokit|', nq'|Viso-Caster|', nq'|Interpok�|', nq'|Videomisor|', nq'|??????|', nq'|Live Caster|', nq'|????? / ?????|', nq'|J�sh� Tongx�n Q� / Jiks�h Tungseun Hei|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Ganlon Berry|', 3 , q'|Raises Defense if HP is below ? of maximum.|' , nq'|?????|', nq'|Ryuga no Mi|', nq'|Baie Lingan|', nq'|Linganbeere|', nq'|Baccalongan|', nq'|Baya Gonlan|', nq'|????|', nq'|Yong'a Yeolmae|', nq'|??? / ???|', nq'|L�ngjing Guo / L�hngjing Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Brick Mail|', 4 , q'|A brick pattern stationery. To be held by a Pok�mon for delivery.|' , nq'|???????|', nq'|Brick Mail|', nq'|Lettre Brik|', nq'|Ziegelbrief|', nq'|Mess. Muro|', nq'|Carta Pared|', nq'|????|', nq'|Brick Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Black Apricorn|', 2 , q'|If taken to Kurt, he will make the player a Fast Ball. Also, Apricorn Drink ingredient.|', q'|Formatted as Blk Apricorn prior to Generation VI.|', nq'|??????|', nq'|Kuro Bonguri|', nq'|Noigrume Noi|', nq'|Aprikoko Swz|', nq'|Ghicocca Nera|', nq'|Bonguri Negro|', nq'|?????|', nq'|Geomeun Gyutori|', nq'|???|', nq'|Hei Qi�guo / Haak K�uhgw�|', 1072 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dire Hit|', 1 , q'|Raises critical hit ratio in battle.|' , nq'|???????|', nq'|Criticut|', nq'|Muscle +|', nq'|Angriffplus|', nq'|Supercolpo|', nq'|Directo|', nq'|??????|', nq'|Critical Cutter|', nq'|???? / ????|', nq'|Y�oh�i Gongj� / Yiuhoih Gunggik|', 768 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Toxic Orb|', 4 , q'|Inflicts the Badly poisoned status on the holder.|' , nq'|??????|', nq'|Dokudoku Dama|', nq'|Orbe Toxique|', nq'|Toxik-Orb|', nq'|Tossicsfera|', nq'|Toxisfera|', nq'|????|', nq'|Maengdok Guseul|', nq'|???? / ????|', nq'|J�d� Baozhu / Kehkduhk B�ujyu|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pixie Plate|', 6 , q'|Raises the power of Fairy-type moves.|' , nq'|????????|', nq'|Seirei Pureto|', nq'|Plaque Pixie|', nq'|Feentafel|', nq'|Lastraspiritello|', nq'|Tabla Duende|', nq'|??????|', nq'|Jeonglyeong Plate|', nq'|????|', nq'|Yaojing Sh�ban / Yiujing Sehkb�an|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Gold Teeth|', 1 , q'|Safari Zone Warden's false teeth. Return for HM04 (Strength)|' , nq'|??????|', nq'|Kin no Ireba|', nq'|Dent D'or|', nq'|Goldz�hne|', nq'|Denti d�Oro|', nq'|Dientes Oro|', nq'|???|', nq'|Geum Teulli|', nq'|???|', nq'|Jin Jiay� / Gam G�ng�h|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Makeup Bag|', 7 , q'|A case for carrying lipsticks.|' , nq'|??????|', nq'|Cosmetics Pouch|', nq'|Trousse Beaut�|', nq'|Kosmetiketui|', nq'|Trousse|', nq'|Kit Maquillaje|', nq'|???????|', nq'|Cosmetics Pouch|', nq'|??? / ???|', nq'|Hu�zhuang Bao / Fajong Baau|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Red Scale|', 2 , q'|Give to Mr. Pok�mon for an Exp. Share.|' , nq'|??????|', nq'|Akai Uroko|', nq'|�caillerouge|', nq'|Rote Haut|', nq'|Squama Rossa|', nq'|Escama Roja|', nq'|????|', nq'|Ppalgan Bineul|', nq'|???? / ????|', nq'|H�ng-s� L�npi�n / H�hng-sik L�uhnpin|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Orange Petal|', 7 , q'|An orange petal required to complete Mina's Trial.|' , nq'|????????|', nq'|Daidai Hanabira|', nq'|P�tale Orange|', nq'|Oranges Blatt|', nq'|Petalo arancione|', nq'|P�talo Naranja|', nq'|????|', nq'|Juhwang Kkochip|', nq'|????|', nq'|Ch�ng-s� Huab�n / Ch�ahng-sik Faf�an|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Surf Mail|', 2 , q'|Mail with a Lapras pattern. To be held by a Pok�mon for delivery.|' , nq'|???????|', nq'|Naminori Mail|', nq'|Lettre Surf|', nq'|Surferbrief|', nq'|Mess. Surf|', nq'|Carta Surf|', nq'|??????|', nq'|Padotagi Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Red Apricorn|', 2 , q'|Kurt will make a Level Ball out of it.|' , nq'|??????|', nq'|Aka Bonguri|', nq'|Noigrume Rge|', nq'|Aprikoko Rot|', nq'|Ghicocca Rossa|', nq'|Bonguri Rojo|', nq'|?????|', nq'|Ppalgan Gyutori|', nq'|??? / ???|', nq'|H�ng Qi�guo / H�hng K�uhgw�|', 48 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Quick Powder|', 4 , q'|Raises Ditto's speed.|' , nq'|????????|', nq'|Speed Powder|', nq'|Poudre Vite|', nq'|Flottstaub|', nq'|Velopolvere|', nq'|Polvo Veloz|', nq'|??????|', nq'|Speed Powder|', nq'|???|', nq'|S�d� Fen / Chukdouh F�n|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Leftovers|', 2 , q'|Heals a little HP at the end of each turn.|' , nq'|?????|', nq'|Tabe Nokoshi|', nq'|Restes|', nq'|�berreste|', nq'|Avanzi|', nq'|Restos|', nq'|??????|', nq'|Meokda Nameun Eumsik|', nq'|????? / ?????|', nq'|Chish�ng-de Dongxi / Heksihng-dik Dungsai|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Slowpoke Tail|', 2 , q'|Can be sold for 4900.|', q'|Formatted as SlowpokeTail prior to Generation VI.|', nq'|???????|', nq'|Oishii Shippo|', nq'|Queueramolos|', nq'|Flegmonrute|', nq'|Codaslowpoke|', nq'|Colaslowpoke|', nq'|?????|', nq'|Masinneun Kkori|', nq'|????|', nq'|Meiw�i Weiba/Meiw�i Yiba / M�ihmeih M�ihba|', 1024 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Rock Memory|', 7 , q'|Makes Silvally a Rock-type Pok�mon and makes Multi-Attack a Rock-type move.|' , nq'|??????|', nq'|Rock Memory|', nq'|ROM Roche|', nq'|Gesteins-Disc|', nq'|ROM Roccia|', nq'|Disco Roca|', nq'|????|', nq'|Rock Memory|', nq'|?????*|'||chr(10)||nq'|?????|', nq'|Y�nsh� J�y�di� / Ng�ahmsehk Geiyikdihp*|'||chr(10)||nq'|Y�nsh� C�nchudi�|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Quick Claw|', 2 , q'|May allow the user to move first.|' , nq'|???????|', nq'|Sensei no Tsume|', nq'|Vive Griffe|', nq'|Flinkklaue|', nq'|Rapidartigli|', nq'|Garra R�pida|', nq'|??????|', nq'|Seonjegonggyeok Sontop|', nq'|????|', nq'|Xianzh�-zhi Zhua / Sinjai-ji J�au|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Aerodactylite|', 6 , q'|Allows Aerodactyl to Mega Evolve into Mega Aerodactyl.|' , nq'|??????|', nq'|Pteranite|', nq'|Pt�ra�te|', nq'|Aerodactylonit|', nq'|Aerodactylite|', nq'|Aerodactylita|', nq'|??????|', nq'|Pteranite|', nq'|??????? / ???????|', nq'|Hu�sh�y�l�ng J�nhu� Sh� / Fasehkyihkl�hng Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Slowbronite|', 6 , q'|Allows Slowbro to Mega Evolve into Mega Slowbro.|' , nq'|???????|', nq'|Yadorannite|', nq'|Flagadossite|', nq'|Lahmusnit|', nq'|Slowbroite|', nq'|Slowbronita|', nq'|??????|', nq'|Yadonrannite|', nq'|?????? / ??????|', nq'|Daik�sh�u J�nhu� Sh� / Ng�ihhoksau Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Payapa Berry|', 4 , q'|Reduces damage from a super effective Psychic-type move.|' , nq'|?????|', nq'|Utan no Mi|', nq'|Baie Yapap|', nq'|Pyapabeere|', nq'|Baccapayapa|', nq'|Baya Payapa|', nq'|????|', nq'|Yapa Yeolmae|', nq'|??? / ???|', nq'|F�l� Guo / Fukluhk Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|White Apricorn|', 2 , q'|If taken to Kurt, he will make the player a Fast Ball. Also, Apricorn Drink ingredient.|', q'|Formatted as Wht Apricorn prior to Generation VI.|', nq'|??????|', nq'|Shiro Bonguri|', nq'|Noigrume Blc|', nq'|Aprikoko Wss|', nq'|Ghicocca Bianca|', nq'|Bonguri Blanco|', nq'|?????|', nq'|Hayan Gyutori|', nq'|???|', nq'|B�i Qi�guo / Baahk K�uhgw�|', 1072 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dusk Stone|', 4 , q'|Can be used to evolve Misdreavus, Murkrow, Lampent, and Doublade.|' , nq'|?????|', nq'|Yami no Ishi|', nq'|Pierre Nuit|', nq'|Finsterstein|', nq'|Neropietra|', nq'|Piedra Noche|', nq'|????|', nq'|Eodumui Dol|', nq'|???|', nq'|�n-zhi Sh� / Am-ji Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Bicycle|', 1 , q'|Can be used to travel quickly. Cannot be ridden in swamps, or in very tall grass.|' , nq'|?????|', nq'|Jitensha|', nq'|Bicyclette|', nq'|Fahrrad|', nq'|Bicicletta|', nq'|Bici|', nq'|???|', nq'|Jajeon-geo|', nq'|??? / ???|', nq'|Z�x�ngche / Jihh�hngche|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Grip Claw|', 4 , q'|Causes trapping moves (e.g. Bind, Wrap) to last for five turns.|' , nq'|????????|', nq'|Nebari no Kagidzume|', nq'|Accro Griffe|', nq'|Griffklaue|', nq'|Presartigli|', nq'|Garra Garfio|', nq'|???????|', nq'|Kkeun-gi Galgori Sontop|', nq'|???? / ????|', nq'|Jinch�n Gouzhua / G�nch�hn Ngauj�au|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Bright Powder|', 2 , q'|Lowers the opponent's accuracy.|', q'|Formatted as BrightPowder prior to Generation VI.|', nq'|??????|', nq'|Hikari no Kona|', nq'|Poudre Claire|', nq'|Blendpuder|', nq'|Luminpolvere|', nq'|Polvo Brillo|', nq'|????|', nq'|Banjjak Garu|', nq'|??|', nq'|Guangfen / Gwongf�n|', 1152 );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|Surfboard|', 1 , q'|An item that can be used to travel on water, much like using the hidden move Surf. Unobtainable during normal gameplay.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Tropic Mail|', 3 , q'|Mail with a picture of Bellossom. To be held by a Pok�mon for delivery.|' , nq'|????????|', nq'|Tropical Mail|', nq'|Lettre Tropi|', nq'|Tropenbrief|', nq'|Mess. Tropic|', nq'|Carta Tropical|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Kee Berry|', 6 , q'|Increases Defense when hit with a physical move.|' , nq'|?????|', nq'|Akki no Mi|', nq'|Baie �ka|', nq'|Akibeere|', nq'|Baccalighia|', nq'|Baya Biglia|', nq'|????|', nq'|Akki Yeolmae|', nq'|??? / ???|', nq'|Y�kai Guo / Ahoi Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|Dire Hit 3|', 5 , q'|Raises critical hit ratio by 3 levels in battle. Wonder Launcher only.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Magma Suit|', 6 , q'|Allows the player to ride Groudon in the Cave of Origin and fly into space on Rayquaza.|' , nq'|??????|', nq'|Magma Suit|', nq'|Scaph. Magma|', nq'|Magma-Anzug|', nq'|Tuta Magma|', nq'|Traje Magma|', nq'|?????|', nq'|Magma Suit|', nq'|??? / ???|', nq'|R�ngy�n Zhuang / Y�hngng�ahm Jong|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Metronome|', 4 , q'|Raises power of moves used in a row.|' , nq'|??????|', nq'|Metronome|', nq'|M�tronome|', nq'|Metronom|', nq'|Plessimetro|', nq'|Metr�nomo|', nq'|????|', nq'|Metronome|', nq'|??? / ???|', nq'|Ji�paiq� / Jitpaakhei|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Silver Powder|', 2 , q'|Raises the power of Bug-type moves.|', q'|Formatted as SilverPowder prior to Generation VI.|', nq'|?????|', nq'|Gin no Kona|', nq'|Poudre Argent�e|', nq'|Silberstaub|', nq'|Argenpolvere|', nq'|Polvo Plata|', nq'|????|', nq'|Eunbit Garu|', nq'|?? / ??|', nq'|Y�nfen / Ng�hnf�n|', 1152 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Bonsly Photo|', 3 , q'|The Battle Bingo prize for winning/using the Bonsly Card.|' , nq'|????�???|', nq'|Usohachi Photo|', nq'|Photo Manzai|', nq'|Mobai-Foto|', nq'|Foto Bonsly|', nq'|Foto Bonsly|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Gyaradosite|', 6 , q'|Allows Gyarados to Mega Evolve into Mega Gyarados.|' , nq'|????????|', nq'|Gyaradosnite|', nq'|L�viatorite|', nq'|Garadosnit|', nq'|Gyaradosite|', nq'|Gyaradosita|', nq'|???????|', nq'|Gyaradosnite|', nq'|?????? / ??????|', nq'|B�olil�ng J�nhu� Sh� / Bouhl�ihl�hng Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Energy Powder|', 2 , q'|Restores 50 HP, but lowers friendship.|', q'|Formatted as EnergyPowder prior to Generation VI.|', nq'|??????|', nq'|Chikara no Kona|', nq'|Poudre �nergie|', nq'|Energiestaub|', nq'|Polvenergia|', nq'|Polvo Energ�a|', nq'|????|', nq'|Himui Garu|', nq'|??? / ???|', nq'|Yu�nq� Fen / Y�hnhei F�n|', 1168 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Claw Fossil|', 3 , q'|A Fossil from which an Anorith can be resurrected.|' , nq'|??????|', nq'|Tsume no Kaseki|', nq'|Fossile Griffe|', nq'|Klauenfossil|', nq'|Fossilunghia|', nq'|F�sil Garra|', nq'|????|', nq'|Baltop Hwaseok|', nq'|????|', nq'|Zhuazi Hu�sh� / J�auj� Fasehk|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|X Speed|', 1 , q'|Raises a Pok�mon's Speed by 2 stages (1 stage before Gen. VII).|' , nq'|?????|', nq'|Speeder|', nq'|Vitesse +|', nq'|X-Tempo|', nq'|Velocit� X|', nq'|Velocidad X|', nq'|????|', nq'|Speed-Up|', nq'|???? / ????|', nq'|S�d� Qi�nghu� / Chukdouh K�uhngfa|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Hard Stone|', 2 , q'|Raises the power of Rock-type moves.|' , nq'|?????|', nq'|Katai Ishi|', nq'|Pierre Dure|', nq'|Granitstein|', nq'|Pietradura|', nq'|Piedra Dura|', nq'|????|', nq'|Ttakttakhan Dol|', nq'|??? / ???|', nq'|Y�ng Sh�tou / Ngaahng Sehkt�uh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Rare Candy|', 1 , q'|Instantly raises a Pok�mon's level by 1.|' , nq'|??????|', nq'|Fushigina Ame|', nq'|Super Bonbon|', nq'|Sonderbonbon|', nq'|Caramella Rara|', nq'|Carameloraro|', nq'|?????|', nq'|Isanghan Satang|', nq'|????|', nq'|Sh�nq� T�ngguo / S�hnk�ih T�hnggw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Secret Key|', 4 , q'|Allows access to the secret room within the Galactic Veilstone Building.|' , nq'|??????|', nq'|Himitsu no Kagi|', nq'|Cl� Secr�te|', nq'|�?-�ffner|', nq'|Chiave Segreta|', nq'|Ll. Secreta|', nq'|?????|', nq'|Bimirui Yeolsoe|', nq'|???? / ????|', nq'|M�m� Y�oshi / Beimaht Yeuhks�h|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Card Key|', 1 , q'|Allows the player to access more rooms in the Silph Co. headquarters.|' , nq'|?????|', nq'|Card Key|', nq'|Carte Magn.|'||chr(10)||nq'|Cle Magnetique|', nq'|T�r�ffner|'||chr(10)||nq'|Schl�sselkarte|', nq'|Apriporta|', nq'|Llave Magn�tica|'||chr(10)||nq'|T. Magn�tica|', nq'|???|', nq'|Card Key|', nq'|??? / ???|', nq'|Y�oshi Ka / Yeuhks�h Kaat|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Metal Coat|', 2 , q'|Raises the power of Steel-type moves. Allows Onix and Scyther to evolve when traded.|' , nq'|??????|', nq'|Metal Coat|', nq'|Peau Metal|', nq'|Metallmantel|', nq'|Metalcoperta|', nq'|Revest. Met�lico|', nq'|????|', nq'|Geumsok Coat|', nq'|??? / ???|', nq'|Jinshu M� / Gamsuhk Mohk|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Disc Case|', 3 , q'|Holds Battle CDs.|' , nq'|???????|', nq'|Disc Case|', nq'|Boite Holog.|', nq'|CD-Box|', nq'|Porta-CD|', nq'|Caja Discos|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Steelium Z|', 7 , q'|Allows a Pok�mon to upgrade their Steel-type damaging moves to the Z-Move Corkscrew Crash or upgrade their Steel-type status moves into Z-Moves. Makes Arceus a Steel-type Pok�mon.|' , nq'|???Z|', nq'|Steel-Z|', nq'|M�talloz�lite|', nq'|Metallium Z|', nq'|Metallium Z|', nq'|Metalostal Z|', nq'|??Z|', nq'|Gangcheol-Z|', nq'|?Z / ?Z|', nq'|Gang-Z / Gong-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Shock Drive|', 5 , q'|Makes Techno Blast an Electric-type move when held by Genesect.|' , nq'|????????|', nq'|Inazuma Cassette|', nq'|Module Choc|', nq'|Blitzmodul|', nq'|Voltmodulo|', nq'|FulgoROM|', nq'|?????|', nq'|Beongae Cassette|', nq'|???? / ????|', nq'|Shandi�n Kad�i / S�mdihn Kaatd�ai|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Krane Memo 2|', 3 , q'|Contains information about the Aura Reader.|' , nq'|??????2|', nq'|Krane Memo 2|', nq'|Memo Syrus 2|', nq'|Klein-Memo 2|', nq'|Appunti 2|', nq'|Parte C�o 2|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Earth Plate|', 4 , q'|Raises the power of Ground-type moves.|' , nq'|????????|', nq'|Daichi no Pureto|', nq'|Plaque Terre|', nq'|Erdtafel|', nq'|Lastrageo|', nq'|Tabla Terrax|', nq'|??????|', nq'|Daeji Plate|', nq'|????|', nq'|D�d� Sh�ban / Daaihdeih Sehkb�an|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Rowap Berry|', 4 , q'|If a foe's special move lands, then the foe also takes damage.|' , nq'|?????|', nq'|Renbu no Mi|', nq'|Baie Pommo|', nq'|Roselbeere|', nq'|Baccaroam|', nq'|Baya Magua|', nq'|????|', nq'|Aeteo Yeolmae|', nq'|??? / ???|', nq'|W�li�n Guo / Mouhl�hn Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Electric Gem|', 5 , q'|Increases the power of the holder's first Electric-type move by 50%, and is consumed after use.|' , nq'|????????|', nq'|Denki no Jewel|', nq'|Joyau �lectr|', nq'|Elektrojuwel|', nq'|Bijouelettro|', nq'|Gema El�ctrica|', nq'|????|', nq'|Jeongi Jewel|', nq'|???? / ????|', nq'|Di�n-zhi Baosh� / Dihn-ji B�usehk|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dome Fossil|', 3 , q'|A Fossil from which a Kabuto can be resurrected.|' , nq'|???????|', nq'|Kora no Kaseki|', nq'|Fossile D�me|', nq'|Domfossil|', nq'|Domofossile|', nq'|F�sil Domo|', nq'|????|', nq'|Kkeopjil Hwaseok|', nq'|???? / ????|', nq'|Jiak� Hu�sh� / Gaaphok Fasehk|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Moon Ball|', 2 , q'|A type of Pok� Ball that works better on Pok�mon that evolve using the Moon Stone.|' , nq'|??????|', nq'|Moon Ball|', nq'|Lune Ball|', nq'|Mondball|', nq'|Luna Ball|', nq'|Luna Ball|', nq'|??|', nq'|Moon Ball|', nq'|???|', nq'|Yu�li�ng Qi� / Yuhtleuhng K�uh|', 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( q'|N-Lunarizer|' , nq'|????????|', nq'|Necro Plus Luna|', nq'|Necroluna|', nq'|Necrolun|', nq'|Necrolunix|', nq'|Necroluna|', nq'|????????|', nq'|Necro Plus Luna|', nq'|???????? / ????????|', nq'|N�ik�lu� L�n�i H�tiq� / Noihhaklok Louhnoih Hahpt�ihei|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Zap Plate|', 4 , q'|Raises the power of Electric-type moves.|' , nq'|????????|', nq'|Ikazuchi Pureto|', nq'|Plaque Volt|', nq'|Blitztafel|', nq'|Lastrasaetta|', nq'|Tabla Trueno|', nq'|??????|', nq'|Uroe Plate|', nq'|???? / ????|', nq'|L�idi�n Sh�ban / L�uihdihn Sehkb�an|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Ultra Ball|', 1 , q'|A Pok� Ball with a high capture rate.|' , nq'|???????|', nq'|Hyper Ball|', nq'|Hyper Ball|', nq'|Hyperball|', nq'|Ultra Ball|', nq'|Ultraball|', nq'|????|', nq'|Hyper Ball|', nq'|??? / ???|', nq'|Gaoj� Qi� / Goukap K�uh|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Machine Part|', 3 , q'|Take to the Power Plant to restore power to the Magnet Train.|' , nq'|???????|'||chr(10)||nq'|??????|', nq'|Kikai no Buhin|'||chr(10)||nq'|Machine Part|', nq'|Partie de Machine|'||chr(10)||nq'|Piece Meca.|', nq'|Spule|'||chr(10)||nq'|Ersatzteil|', nq'|Pezzo macch.|'||chr(10)||nq'|Meccanismo|', nq'|Maquinaria|'||chr(10)||nq'|Pieza Esp.|', nq'|????|', nq'|Gigye Bupum|', nq'|???? / ????|', nq'|Jixi� L�ngji�n / Geihaaih L�hngg�n|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|Niniku Berry|', 3 , q'|Pok�block ingredient. Will become an Enigma Berry if transferred to Generation IV via Pal Park.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Love Ball|', 2 , q'|A type of Pok� Ball that works better on Pok�mon of the opposite gender.|' , nq'|???????|', nq'|Love-Love Ball|', nq'|Love Ball|', nq'|Sympaball|', nq'|Love Ball|', nq'|Amor Ball|', nq'|?????|', nq'|Love-Love Ball|', nq'|???|', nq'|Ti�nm� Qi� / T�hmmaht K�uh|', 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( q'|Loot Sack|' , nq'|??????|', nq'|Takara Bukuro|', nq'|Sac Butin|', nq'|Beutesack|', nq'|Bottinosacca|', nq'|Saca Bot�n|', nq'|?????|', nq'|Bomul Jumeoni|', nq'|??? / ???|', nq'|Baow� D�i / B�umaht Doih|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Relic Copper|', 5 , q'|Can be sold for 1000 to the villa owner in Undella Town.|' , nq'|???????|', nq'|Kodai no Doka|', nq'|Vieux Sou|', nq'|Alter Heller|', nq'|Soldantico|', nq'|Real Cobre|', nq'|?????|', nq'|Godae-yi Donghwa|', nq'|???? / ????|', nq'|Gud�i T�ngb� / G�doih T�hngbaih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|U-Disk|', 3 , q'|Moves the UFO in The Under to Pyrite Town's windmill.|' , nq'|U-????|', nq'|U-Disk|', nq'|Disque-H|', nq'|O-Disc|', nq'|Disco Su|', nq'|Disco S|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Sachet|', 6 , q'|Allows Spritzee to evolve when traded.|' , nq'|??????|', nq'|Nioi Bukuro|', nq'|Sachet Senteur|', nq'|Duftbeutel|', nq'|Bustina Aromi|', nq'|Saquito Fragante|', nq'|?????|', nq'|Hyang-gi Jumeoni|', nq'|??|', nq'|Xiangd�i / Heungdoih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|Topo Berry|', 3 , q'|Pok�block ingredient. If transferred to Generation IV via Pal Park, it will turn into an Enigma Berry.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Ein File S|', 3 , q'|Describes Shadow Pok�mon.|' , nq'|???????D|', nq'|Borg File D|', nq'|Dossier Teck O|', nq'|Culpa-Akte C-P|', nq'|Genus.File O|', nq'|Parte Ein: O|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Hyper Potion|', 1 , q'|Restores 120 HP. (200HP before Gen. VII).|' , nq'|????????|', nq'|Sugoi Kizugusuri|', nq'|Hyper Potion|', nq'|Hypertrank|', nq'|Iperpozione|', nq'|Hiperpoci�n|', nq'|?????|', nq'|Gogeup Sangcheo Yak|', nq'|???? / ????|', nq'|L�h�i Shangy�o / Leihhhoih Seungyeuhk|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Big Mushroom|', 2 , q'|Can be sold for 2500.|' , nq'|???????|', nq'|Okina Kinoko|', nq'|Gros Champi|', nq'|Riesenpilz|', nq'|Grande Fungo|', nq'|Seta Grande|', nq'|???|', nq'|Keun Beoseot|', nq'|???|', nq'|D� M�gu / Daaih M�hgu|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Vs. Seeker|', 3 , q'|Used to prompt Trainers for a rematch.|' , nq'|????????|', nq'|Battle Searcher|', nq'|Cherche VS|', nq'|Kampffahnder|', nq'|Cercasfide|', nq'|Buscapelea|', nq'|????|', nq'|Battle Searcher|', nq'|????? / ?????|', nq'|Du�zh�n Soux�n Q� / Deuijin Sauch�hm Hei|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Wave Incense|', 4 , q'|Raises the power of Water-type moves. A Mantine holding it can breed to produce Mantyke Eggs.|' , nq'|????????|', nq'|Sazanami no Oko|', nq'|Encens Vague|', nq'|Wellenrauch|', nq'|Ondaroma|', nq'|Incienso aqua|', nq'|?????|', nq'|Janmulgyeol Hyangno|', nq'|???? / ????|', nq'|Li�nyi Xunxiang / L�hny� Fanheung|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Mystic Water|', 2 , q'|Raises the power of Water-type moves.|' , nq'|???????|', nq'|Shinpi no Shizuku|', nq'|Eau Mystique|', nq'|Zauberwasser|', nq'|Acqua Magica|', nq'|Agua M�stica|', nq'|??????|', nq'|Sinbiui Mulbang-ul|', nq'|????|', nq'|Sh�nm� shuidi / S�hnbei S�uidihk|', 32 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|X Defense|', 1 , q'|Raises a Pok�mon's Defense by 2 stages (1 stage before Gen. VII).|', q'|Called X Defend prior to Generation VI.|', nq'|???????|', nq'|Defender|', nq'|Defense +|', nq'|X-Abwehr|', nq'|Difesa X|', nq'|Defensa X|', nq'|????|', nq'|Defend-Up|', nq'|???? / ????|', nq'|F�ngy� Qi�nghu� / F�hngyuh K�uhngfa|', 1024 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Max Ether|', 1 , q'|Restores all the PP of a single move.|' , nq'|????????|', nq'|PP Recover|', nq'|Huile Max|', nq'|Top-�ther|', nq'|Etere Max|', nq'|�ter M�ximo|', nq'|PP??|', nq'|PP Hoebok|', nq'|PP????? / PP?????|', nq'|PP Danxi�ng Qu�nbuj� / PP Daanhohng Chy�hnb�ujaih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Ground Gem|', 5 , q'|Increases the power of the holder's first Ground-type move by 50%, and is consumed after use.|' , nq'|????????|', nq'|Jimen no Jewel|', nq'|Joyau Sol|', nq'|Bodenjuwel|', nq'|Bijouterra|', nq'|Gema Tierra|', nq'|???|', nq'|Ttang Jewel|', nq'|???? / ????|', nq'|D�mi�n Baosh� / Deihm�n B�usehk|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Odd Incense|', 4 , q'|Raises the power of Psychic-type moves. Mr. Mime holding this can breed Mime Jr.|' , nq'|???????|', nq'|Oyashii Oko|', nq'|Encens Bizarre|', nq'|Schr�grauch|', nq'|Bizzoaroma|', nq'|Incienso raro|', nq'|?????|', nq'|Goesanghan Hyangno|', nq'|???? / ????|', nq'|Q�y� Xunxiang / K�ihyih Fanheung|', 144 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Oak's Letter|', 4 , q'|Opens the Seabreak Path and allows the user to face Shaymin.|' , nq'|????????|', nq'|Okido no Tegami|', nq'|Lettre Chen|', nq'|Eichs Brief|', nq'|Lettera di Oak|', nq'|Carta Pr Oak|', nq'|???? ??|', nq'|O-baksa-ui Pyeonji|', nq'|????|', nq'|D�m�-de X�n / Daaihmuhk-dik Seun|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Garchompite|', 6 , q'|Allows Garchomp to Mega Evolve into Mega Garchomp.|' , nq'|????????|', nq'|Gaburiasnite|', nq'|Carchacrokite|', nq'|Knakracknit|', nq'|Garchompite|', nq'|Garchompita|', nq'|????????|', nq'|Hankariasnite|', nq'|??????? / ???????|', nq'|Li�yaol�sha J�nhu� Sh� / Lihtng�auhluhksa Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Groundium Z|', 7 , q'|Allows a Pok�mon to upgrade their Ground-type damaging moves to the Z-Move Tectonic Rage or upgrade their Ground-type status moves into Z-Moves. Makes Arceus a Ground-type Pok�mon.|' , nq'|???Z|', nq'|Ground-Z|', nq'|Terraz�lite|', nq'|Terrium Z|', nq'|Terrium Z|', nq'|Geostal Z|', nq'|?Z|', nq'|Ttang-Z|', nq'|??Z|', nq'|D�mi�n-Z / Deihm�n-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Full Incense|', 4 , q'|Causes holder to move slower than the opponent. A Snorlax holding it can breed to produce Munchlax.|' , nq'|???????|', nq'|Manpuku Oko|', nq'|Encens Plein|', nq'|Lahmrauch|', nq'|Gonfioaroma|', nq'|Incienso lento|', nq'|????|', nq'|Manbok Hyangno|', nq'|???? / ????|', nq'|Baof� Xunxiang / B�aufuk Fanheung|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Sitrus Berry|', 3 , q'|Restores 30 HP in Generation III. Restores � of maximum HP from Generation IV onwards.|' , nq'|?????|', nq'|Obon no Mi|', nq'|Baie Sitrus|', nq'|Tsitrubeere|', nq'|Baccacedro|', nq'|Baya Zidra|', nq'|????|', nq'|Jamung Yeolmae|', nq'|???|', nq'|W�ny�u Guo / M�hnyauh Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Gorgeous Box|', 2 , q'|Sometimes held by a reward Pok�mon from Pok�mon Stadium if traded to Generation II.|' , nq'|?????|', nq'|Kiri no Hako|', nq'|Coffre Luxe|', nq'|Schatulle|', nq'|Scat. Lusso|', nq'|Caja Grande|', nq'|??????|', nq'|Odongnamu Sangja|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Coupon 2|', 4 , q'|Used to obtain the Pok�tch in Jubilife City.|' , nq'|??????2|', nq'|Hikikaeken 2|', nq'|Bon 2|', nq'|Kupon 2|', nq'|Coupon 2|', nq'|Cup�n 2|', nq'|??? 2|', nq'|Gyohwangwon 2|', nq'|???2 / ???2|', nq'|Du�hu�n Qu�n 2 / Deuiwuhn Hyun 2|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Guard Spec.|', 1 , q'|Temporarily prevents stat reduction.|' , nq'|????????|', nq'|Effect Guard|', nq'|Defense Spec|', nq'|Megablock|', nq'|Superguardia|', nq'|Protec. Esp.|', nq'|?????|', nq'|Effect Guard|', nq'|????|', nq'|N�ngl� F�ngshou / N�hnglihk F�hngs�u|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Shuca Berry|', 4 , q'|Reduces damage taken from a super effective Ground-type move.|' , nq'|?????|', nq'|Shuca no Mi|', nq'|Baie Jouca|', nq'|Schukebeere|', nq'|Baccanaca|', nq'|Baya Acardo|', nq'|????|', nq'|Shewca Yeolmae|', nq'|???|', nq'|Yaom� Guo / Yiumuhk Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Bike Voucher|', 1 , q'|Used to pay for a Bicycle.|' , nq'|??????|', nq'|Hikikaeken|', nq'|Bon Commande|', nq'|Rad Coupon|', nq'|Buono Bici|', nq'|Bono Bici|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Meteorite|', 3 , q'|Deliver to Professor CozmoRSE or Lostelle's fatherFRLG. Enables the Rayquaza featured in the Delta Episode to Mega Evolve.ORAS|' , nq'|????|', nq'|Inseki|', nq'|M�t�orite|', nq'|Meteorit|', nq'|Meteorite|', nq'|Meteorito|', nq'|??|', nq'|Unseok|', nq'|?? / ??|', nq'|Yunsh� / W�hnsehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Sky Plate|', 4 , q'|Raises the power of Flying-type moves.|' , nq'|????????|', nq'|Aozora Pureto|', nq'|Plaque Ciel|', nq'|Wolkentafel|', nq'|Lastracielo|', nq'|Tabla Cielo|', nq'|????????|', nq'|Pureun Haneul Plate|', nq'|???? / ????|', nq'|L�ntian Sh�ban / L�ahmtin Sehkb�an|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Beast Ball|', 7 , q'|Allows the player to catch wild Pok�mon; works better on Ultra Beasts.|' , nq'|???????|', nq'|Ultra Ball|', nq'|Ultra Ball|', nq'|Ultraball|', nq'|UC Ball|', nq'|Ente Ball|', nq'|????|', nq'|Ultra Ball|', nq'|??? / ???|', nq'|Jiuj� Qi� / Gaugihk K�uh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Bead Mail|', 3 , q'|A bead-printed stationery. To be held by a Pok�mon for delivery.|' , nq'|????????|', nq'|Treasure Mail|', nq'|Lettre Bulle|', nq'|Perlenbrief|', nq'|Mess. Perle|', nq'|Carta Imagen|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|L-Disk|', 3 , q'|Moves the UFO in The Under to the Amulet Coin.|' , nq'|L-????|', nq'|L-Disk|', nq'|Disque-G|', nq'|L-Disc|', nq'|Disco Sx|', nq'|Disco I|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Inquiry Mail|', 5 , q'|Stationary for writing questions. To be held by a Pok�mon for delivery.|' , nq'|???????|', nq'|Shitsumon Mail|', nq'|Let. Demande|', nq'|Fragebrief|', nq'|Mess. Chiedi|', nq'|C. Pregunta|', nq'|????|', nq'|Jilmun Mail|', nq'|???? / ????|', nq'|X�nw�n Y�uji�n / Seunmahn Y�uhg�n|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Berry Juice|', 2 , q'|Restores 20 HP.|' , nq'|???????|', nq'|Kinomi Juice|', nq'|Jus De Baie|', nq'|Beerensaft|', nq'|Succo di Bacca|', nq'|Zumo de Baya|', nq'|??????|', nq'|Namu Yeolmae Juice|', nq'|??? / ???|', nq'|Sh� Guozhi / Syuh Gw�jap|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Psychium Z|', 7 , q'|Allows a Pok�mon to upgrade their Psychic-type damaging moves to the Z-Move Shattered Psyche or upgrade their Psychic-type status moves into Z-Moves. Makes Arceus a Psychic-type Pok�mon.|' , nq'|????Z|', nq'|Esper-Z|', nq'|Psych�z�lite|', nq'|Psium Z|', nq'|Psichium Z|', nq'|Psicostal Z|', nq'|???Z|', nq'|Esper-Z|', nq'|???Z|', nq'|Chaon�ngl�-Z / Chiun�hnglihk-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Diancite|', 6 , q'|Allows Diancie to Mega Evolve into Mega Diancie.|' , nq'|????????|', nq'|Diancinite|', nq'|Diancite|', nq'|Diancienit|', nq'|Diancite|', nq'|Diancita|', nq'|??????|', nq'|Diancienite|', nq'|?????? / ??????|', nq'|D�'anxi J�nhu� Sh� / Dai'onhei Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Ylw ID Badge|', 3 , q'|One of four keys needed to unlock the north door of Realgam Tower.|' , nq'|ID??????|', nq'|ID Badge Kiro|', nq'|Passe Jaune|', nq'|Gelbe ID-Marke|', nq'|Pass Giallo|', nq'|P. Amarillo|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Flyinium Z|', 7 , q'|Allows a Pok�mon to upgrade their Flying-type damaging moves to the Z-Move Supersonic Skystrike or upgrade their Flying-type status moves into Z-Moves. Makes Arceus a Flying-type Pok�mon.|' , nq'|???Z|', nq'|Flying-Z|', nq'|A�roz�lite|', nq'|Aerium Z|', nq'|Volantium Z|', nq'|Aerostal Z|', nq'|??Z|', nq'|Bihaeng-Z|', nq'|??Z / ??Z|', nq'|Feix�ng-Z / Feih�hng-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|BridgeMail S|', 5 , q'|Stationary with a sky-piercing bridge print. To be held by a Pok�mon for delivery.|' , nq'|???????S|', nq'|Bridge Mail S|', nq'|Lettre PontS|', nq'|Br�ckbrief H|', nq'|Mess. Frec.|', nq'|C. Puente S|', nq'|?????S|', nq'|Bridge Mail S|', nq'|????S / ????S|', nq'|Qi�oli�ng Y�uji�n S / K�uhl�uhng Y�uhg�n S|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Damp Mulch|', 4 , q'|Causes the soil to dry out more slowly, but also causes the Berry plant to grow more slowly.|' , nq'|???????|', nq'|Jimejime Koyashi|', nq'|Fertihumide|', nq'|Feuchtmulch|', nq'|Fertilidro|', nq'|Abono Lento|', nq'|?????|', nq'|Chukchug'i Biryo|', nq'|??? / ???|', nq'|Shishi F�i / Sapsap F�ih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Town Map|', 1 , q'|Contains an interactive map of the region and where the player is at the time.|' , nq'|??????|', nq'|Town Map|', nq'|Carte|', nq'|Karte|', nq'|Mappa|', nq'|Mapa|', nq'|???|', nq'|Town Map|', nq'|???? / ????|', nq'|Ch�ngzh�n D�t� / S�hngjan Deiht�uh|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Everstone|', 2 , q'|A hold item that prevents the holder from evolving.|' , nq'|???????|', nq'|Kawarazu no Ishi|', nq'|Pierre Stase|', nq'|Ewigstein|', nq'|Pietrastante|', nq'|Piedra Eterna|', nq'|?????|', nq'|Byeonhameomneun Dol|', nq'|???? / ????|', nq'|B�bi�n-zhi Sh� / Batbin-ji Sehk|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Elevator Key|', 3 , q'|Unlocks the elevator in Pyrite Bldg giving the player access to The Under.|' , nq'|????????|'||chr(10)||nq'|?????????|', nq'|Elevator Key|'||chr(10)||nq'|Elevator no Key|', nq'|Cle Ascens.*|'||chr(10)||nq'|Cl� Ascenseur|', nq'|Liftkarte*|'||chr(10)||nq'|Liftschl�ssel|', nq'|Chiave Asc.|'||chr(10)||nq'|Chiave ascensore|', nq'|Ll. Ascensor|'||chr(10)||nq'|Llave Ascensor|', nq'|??????|', nq'|Elevator Key|', nq'|???? / ????|', nq'|Di�nti Y�oshi / Dihntai Yeuhks�h|', 192 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Data ROM|', 3 , q'|Holds data on Shadow Pok�mon.|' , nq'|?????|', nq'|Data ROM|', nq'|Disque-ROM|', nq'|CD-ROM|', nq'|CD ROM|', nq'|Disquete|' , 32 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Figy Berry|', 3 , q'|When HP falls below 25%, restores 50% HP, but confuses Pok�mon that dislike spicy food (12.5% when below 50% before Gen. VII).|' , nq'|?????|', nq'|Fira no Mi|', nq'|Baie Figuy|', nq'|Giefebeere|', nq'|Baccafico|', nq'|Baya Higog|', nq'|????|', nq'|Muhwa Yeolmae|', nq'|???|', nq'|W�hua Guo / Mahtfa Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Absolite|', 6 , q'|Allows Absol to Mega Evolve into Mega Absol.|' , nq'|???????|', nq'|Absolnite|', nq'|Absolite|', nq'|Absolnit|', nq'|Absolite|', nq'|Absolita|', nq'|?????|', nq'|Absolnite|', nq'|??????? / ???????|', nq'|Ab�suolu J�nhu� Sh� / Abuhtsol�uh Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Steelixite|', 6 , q'|Allows Steelix to Mega Evolve into Mega Steelix.|' , nq'|????????|', nq'|Haganeilnite|', nq'|Steelixite|', nq'|Stahlosnit|', nq'|Steelixite|', nq'|Steelixita|', nq'|??????|', nq'|Gangcheoltonnite|', nq'|?????? / ??????|', nq'|D�gangsh� J�nhu� Sh� / Daaihgongs�h Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Sapphire|', 3 , q'|To be given to Celio along with Ruby to set up the Network Machine of the Pok�mon Network Center, allowing the player to trade with Ruby, Sapphire, and Emerald.|' , nq'|?????|', nq'|Sapphire|', nq'|Saphir|', nq'|Saphir|', nq'|Zaffiro|', nq'|Zafiro|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Aguav Berry|', 3 , q'|When HP falls below 25%, restores 50% HP, but confuses Pok�mon that dislike bitter food (12.5% when below 50% before Gen. VII).|' , nq'|?????|', nq'|Banji no Mi|', nq'|Baie Gowav|', nq'|Gauvebeere|', nq'|Baccaguava|', nq'|Baya Guaya|', nq'|????|', nq'|Ava Yeolmae|', nq'|??? / ???|', nq'|L�ba Guo / Lohkba Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|R-Disk|', 3 , q'|Moves the UFO in The Under to the Under TV Station.|' , nq'|R-????|', nq'|R-Disk|', nq'|Disque-D|', nq'|R-Disc|', nq'|Disco Dx|', nq'|Disco D|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Flame Plate|', 4 , q'|Raises the power of Fire-type moves.|' , nq'|????????|', nq'|Hi no Tama Pureto|', nq'|Plaque Flam|', nq'|Feuertafel|', nq'|Lastrarogo|', nq'|Tabla Llama|', nq'|???????|', nq'|Bulguseul Plate|', nq'|????|', nq'|Huoqi� Sh�ban / F�k�uh Sehkb�an|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|BridgeMail M|', 5 , q'|Stationary with an arched bridge print. To be held by a Pok�mon for delivery.|' , nq'|???????W|', nq'|Bridge Mail W|', nq'|Lettre PontI|', nq'|Br�ckbrief W|', nq'|Mess. Merav.|', nq'|C. Puente P|', nq'|?????W|', nq'|Bridge Mail W|', nq'|????W / ????W|', nq'|Qi�oli�ng Y�uji�n W / K�uhl�uhng Y�uhg�n W|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Whipped Dream|', 6 , q'|Allows Swirlix to evolve when traded.|' , nq'|???????|', nq'|Whip Pop|', nq'|Chantibonbon|', nq'|Sahneh�ubchen|', nq'|Dolcespuma|', nq'|Dulce de Nata|', nq'|???|', nq'|Whipping Pop|', nq'|????|', nq'|P�om� naiy�u / P�uhmuht N�aihy�uh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Apricorn Box|', 4 , q'|Contains Apricorns.|' , nq'|???????|', nq'|Bonguri Case|', nq'|Bte Noigrume|', nq'|Aprikokobox|', nq'|Ghicobox|', nq'|Caja Bonguri|', nq'|??????|', nq'|Gyutori Case|', nq'|???|', nq'|Qi�guo H� / K�uhgw� Hahp|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Light Clay|', 4 , q'|Extends the duration of the moves Reflect and Light Screen.|' , nq'|???????|', nq'|Hikari no Nendo|', nq'|Lumargile|', nq'|Lichtlehm|', nq'|Creta Luce|', nq'|Refleluz|', nq'|????|', nq'|Bichui Jeomto|', nq'|????|', nq'|Guang-zhi Ni�ntu / Gwong-ji N�hmt�u|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Wood Mail|', 3 , q'|Mail with picture of a Slakoth.|' , nq'|???????|', nq'|Woody Mail|', nq'|Lettre Bois|', nq'|Waldbrief|', nq'|Mess. Bosco|', nq'|Carta Madera|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Sweet Heart|', 5 , q'|A very sugary chocolate. It restores one Pok�mon's HP by 20.|' , nq'|???????|', nq'|Heart Sweets|', nq'|Chococ�ur|', nq'|Herzkonfekt|', nq'|Dolcecuore|', nq'|Coraz�n Dulce|', nq'|?????|', nq'|Sweet Heart|', nq'|???? / ????|', nq'|Xinx�ng Ti�ndian / Samy�hng T�hmd�m|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pink Nectar|', 7 , q'|Changes Oricorio to its Pa'u Style.|' , nq'|???????|', nq'|Usumomo no Mitsu|', nq'|Nectar Rose|', nq'|Rosa Nektar|', nq'|Nettare rosa|', nq'|N�ctar Rosa|', nq'|????|', nq'|Yeonbunhong Kkul|', nq'|?????|', nq'|T�ofen-s� Huam� / T�uhf�n-sik Famaht|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Power Belt|', 4 , q'|Promotes Defense EVs, but lowers Speed in battle.|' , nq'|??????|', nq'|Power Belt|', nq'|Ceinture Pouvoir|', nq'|Machtgurt|', nq'|Vigorfascia|', nq'|Cinto Recio|', nq'|????|', nq'|Power Belt|', nq'|???? / ????|', nq'|L�li�ng Yaod�i / Lihkleuhng Yiud�ai|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Fire Gem|', 5 , q'|Increases the power of the holder's first Fire-type move by 50%, and is consumed after use.|' , nq'|????????|', nq'|Hono no Jewel|', nq'|Joyau Feu|', nq'|Feuerjuwel|', nq'|Bijoufuoco|', nq'|Gema Fuego|', nq'|????|', nq'|Bulkkot Jewel|', nq'|???? / ????|', nq'|Huo-zhi Baosh� / F�-ji B�usehk|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pok�block Kit|', 6 , q'|Allows the player to make and store Pok�blocks.|' , nq'|???????|', nq'|Polock Kit|', nq'|Kit Pok�bloc|', nq'|Pok�riegel-Set|', nq'|Kit Pok�melle|', nq'|Kit de Pok�cubos|', nq'|???????|', nq'|Pok�mon Snack Kit|', nq'|??????*|'||chr(10)||nq'|??????|', nq'|Baoke Fangku�i Zuh� / B�uh� Fongfaai J�uhahp*|'||chr(10)||nq'|Baoke Fangku�i T�ozhuang|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Great Ball|', 1 , q'|A moderately good type of Pok� Ball.|' , nq'|???????|', nq'|Super Ball|', nq'|Super Ball|', nq'|Superball|', nq'|Mega Ball|', nq'|Superball|', nq'|???|', nq'|Super Ball|', nq'|??? / ???|', nq'|Chaoj� Qi� / Chiukap K�uh|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Eevium Z|', 7 , q'|Allows Eevee to upgrade Last Resort to the special Z-Move Extreme Evoboost.|' , nq'|????Z|', nq'|Eievui-Z|', nq'|�voliz�lite|', nq'|Evolium Z|', nq'|Eevium Z|', nq'|Eeveestal Z|', nq'|???Z|', nq'|Eevee-Z|', nq'|??Z|', nq'|Yib�-Z / Yibou-Z|', 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( q'|Mega Cuff|' , nq'|?????|', nq'|Mega Brace|', nq'|M�ga-Manchette|', nq'|Mega-Armb�nder|', nq'|Megapolsiera|', nq'|Megabrazalete|', nq'|?????|', nq'|Mega Brace|', nq'|???? / ????|', nq'|Chaoj� H�w�n / Chiukap Wuhw�n|' );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( q'|Key Stone|' , nq'|??????|', nq'|Key Stone|', nq'|Gemme S�same|', nq'|Schl�ssel-Stein|', nq'|Pietrachiave|', nq'|Piedra Activadora|', nq'|???|', nq'|Key Stone|', nq'|?? / ??|', nq'|Y�osh� / Yeuhksehk|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Liberty Pass|', 5 , q'|Gives access to Liberty Garden.|' , nq'|????????|', nq'|Liberty Ticket|', nq'|Passe Libert�|', nq'|Gartenpass|', nq'|Liberticket|', nq'|Ticket Libertad|', nq'|?????|', nq'|Liberty Ticket|', nq'|????|', nq'|Z�y�u Chu�npi�o / Jihy�uh Sy�hnpiu|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Chilan Berry|', 3 , q'|Pok�block ingredient.|' , nq'|????|', nq'|Hozu no Mi|', nq'|Baie Zalis|', nq'|Latchibeere|', nq'|Baccacinlan|', nq'|Baya Chilan|', nq'|????|', nq'|Kari Yeolmae|', nq'|??? / ???|', nq'|Dengjiang Guo / Dangjeung Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Red Chain|', 4 , q'|A mythical chain linked to the legendary Pok�mon of the Sinnoh region. Unobtainable without cheating.|' , nq'|??????|', nq'|Akai Kusari|', nq'|Cha�ne Rouge|', nq'|Rote Kette|', nq'|Rossocatena|', nq'|Cadena Roja|', nq'|?????|', nq'|Ppalgang Soesaseul|', nq'|???? / ????|', nq'|H�ng-s� Suoli�n / H�hng-sik S�l�n|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lucky Egg|', 2 , q'|Doubles the experience gained during battle.|' , nq'|???????|', nq'|Shiawase Tamago|', nq'|�uf Chance|', nq'|Gl�cks-Ei|', nq'|Fortunuovo|', nq'|Huevo Suerte|', nq'|????|', nq'|Haengbogui Al|', nq'|??? / ???|', nq'|X�ngy�n D�n / Hahngwahn Daahn|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Egg Ticket|', 2 , q'|Can be exchanged for the Odd Egg.|' , nq'|?????|', nq'|Tamago Ken|', nq'|Ticket Oeuf|', nq'|Ei-Ticket|', nq'|Bigl.Uovo|', nq'|Ticket Huevo|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lum Berry|', 3 , q'|Cures any status condition.|' , nq'|????|', nq'|Ramu no Mi|', nq'|Baie Prine|', nq'|Prunusbeere|', nq'|Baccaprugna|', nq'|Baya Ziuela|', nq'|????|', nq'|Risaem Yeolmae|', nq'|???|', nq'|M�zi Guo / Muhkj� Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|X Special 3|', 5 , q'|Drastically raises a Pok�mon's Special Attack. Wonder Launcher only.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Vivid Scent|', 3 , q'|Reduces the heart gauge by a large amount and increases friendship.|' , nq'|????????|', nq'|Dokidoki no Kaori|', nq'|P. Palpitant|', nq'|Paradies-E.|', nq'|Olio Sublime|', nq'|Ar. Energ�a|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Relic Crown|', 5 , q'|Can be sold for 300000 to the villa owner in Undella Town.|' , nq'|????????|', nq'|Kodai no Okan|', nq'|Vieux Tortil|', nq'|Alte Krone|', nq'|Coronantica|', nq'|Corona Antigua|', nq'|?????|', nq'|Godae-yi Wanggwan|', nq'|????|', nq'|Gud�i W�nggu�n / G�doih W�hnggun|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Protein|', 1 , q'|Raises the Attack of a Pok�mon.|' , nq'|????|', nq'|Taurine|', nq'|Proteine|', nq'|Protein|', nq'|Proteina|', nq'|Prote�na|', nq'|???|', nq'|Taurine|', nq'|????? / ?????|', nq'|Gongj� Zengqi�ngj� / Gunggik Jangk�uhngjaih|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Manectite|', 6 , q'|Allows Manectric to Mega Evolve into Mega Manectric.|' , nq'|????????|', nq'|Livoltnite|', nq'|�lecsprintite|', nq'|Voltensonit|', nq'|Manectricite|', nq'|Manectricita|', nq'|???????|', nq'|Thundervoltnite|', nq'|?????? / ??????|', nq'|L�idi�nsh�u J�nhu� Sh� / L�uihdihnsau Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Ghostium Z|', 7 , q'|Allows a Pok�mon to upgrade their Ghost-type damaging moves to the Z-Move Never-Ending Nightmare or upgrade their Ghost-type status moves into Z-Moves. Makes Arceus a Ghost-type Pok�mon.|' , nq'|????Z|', nq'|Ghost-Z|', nq'|Spectroz�lite|', nq'|Phantomium Z|', nq'|Spectrium Z|', nq'|Espectrostal Z|', nq'|???Z|', nq'|Ghost-Z|', nq'|??Z / ??Z|', nq'|Youl�ng-Z / Yaul�hng-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Splash Plate|', 4 , q'|Raises the power of Water-type moves.|' , nq'|???????|', nq'|Shizuku Pureto|', nq'|Plaque Hydro|', nq'|Wassertafel|', nq'|Lastraidro|', nq'|Tabla Linfa|', nq'|???????|', nq'|Mulbang-ul Plate|', nq'|????|', nq'|Shuidi Sh�ban / S�uidihk Sehkb�an|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Heal Ball|', 4 , q'|A type of Pok� Ball that heals the captured Pok�mon before it is put in the player's party. If the player's party is full, it will be transferred to the Box, where it would have been healed anyway.|' , nq'|??????|', nq'|Heal Ball|', nq'|Soin Ball|', nq'|Heilball|', nq'|Cura Ball|', nq'|Sana Ball|', nq'|??|', nq'|Heal Ball|', nq'|??? / ???|', nq'|Zh�y� Qi� / Jihyuh K�uh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dubious Disc|', 4 , q'|A hold item that allows Porygon2 to evolve when traded.|' , nq'|???????|', nq'|Ayashii Patch|', nq'|CD Douteux|', nq'|Dubiosdisc|', nq'|Dubbiodisco|', nq'|Discoxtra�o|', nq'|?????|', nq'|Goesanghan Patch|', nq'|???? / ????|', nq'|Key� Buding / H�y�h B�uding|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|X Attack 2|', 5 , q'|Sharply raises a Pok�mon's Attack. Wonder Launcher only.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Griseous Orb|', 4 , q'|Raises the power of Giratina's Ghost- and Dragon-type moves, and causes it to take on its Origin Forme.|' , nq'|??????|', nq'|Hakkin Dama|', nq'|Orbe Platin�|', nq'|Platinum-Orb|', nq'|Grigiosfera|', nq'|Griseosfera|', nq'|???|', nq'|Baekgeum Ok|', nq'|???? / ????|', nq'|B�ijin Baozhu / Baahkgam B�ujyu|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Normal Gem|', 5 , q'|Increases the power of the holder's first Normal-type move by 50%, and is consumed after use.|' , nq'|????????|', nq'|Normal Jewel|', nq'|Joyau Normal|', nq'|Normaljuwel|', nq'|Bijounormale|', nq'|Gema Normal|', nq'|????|', nq'|Normal Jewel|', nq'|???? / ????|', nq'|Yiban Baosh� / Yatbun B�usehk|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Mayor's Note|', 3 , q'|A letter from the Mayor to Justy.|' , nq'|????????|', nq'|Shicho no Tegami|', nq'|Lettre Maire|', nq'|Zettel|', nq'|Nota Sindaco|', nq'|Nota Alcalde|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Grass Memory|', 7 , q'|Makes Silvally a Grass-type Pok�mon and makes Multi-Attack a Grass-type move.|' , nq'|??????|', nq'|Grass Memory|', nq'|ROM Plante|', nq'|Pflanzen-Disc|', nq'|ROM Erba|', nq'|Disco Planta|', nq'|??????|', nq'|Grass Memory|', nq'|?????*|'||chr(10)||nq'|?????|', nq'|Qingcao J�y�di� / Chingch�u Geiyikdihp*|'||chr(10)||nq'|Qingcao C�nchudi�|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Gold Berry|', 2 , q'|Restores 30 HP.|' , nq'|??????|', nq'|Ogon no Mi|', nq'|Baie Doree|', nq'|Goldbeere|', nq'|Bacca Oro|', nq'|Baya Dorada|', nq'|????|', nq'|Hwanggeum Yeolmae|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Small Tablet|', 3 , q'|Used to activate the Relic Stone.|' , nq'|????????|', nq'|Chisa na Sekiban|', nq'|Ardoise|', nq'|Steintafel|', nq'|Tavola|', nq'|Tablilla|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Poison Barb|', 2 , q'|Raises the power of Poison-type moves.|' , nq'|????|', nq'|Doku Bari|', nq'|Pic Venin|', nq'|Giftstich|', nq'|Velenaculeo|', nq'|Flecha Venenosa|', nq'|???|', nq'|Dokbaneul|', nq'|?? / ??|', nq'|D�zhen / Duhkjam|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Micle Berry|', 4 , q'|Raises a move's accuracy just once when HP is below ? of maximum.|' , nq'|?????|', nq'|Micle no Mi|', nq'|Baie Micle|', nq'|Wunfrubeere|', nq'|Baccaracolo|', nq'|Baya Lagro|', nq'|????|', nq'|Micle Yeolmae|', nq'|???|', nq'|Q�m� Guo / K�ihbit Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Chople Berry|', 4 , q'|Reduces damage from a super effective Fighting-type move by 50%.|' , nq'|????|', nq'|Yop no Mi|', nq'|Baie Pomroz|', nq'|Rospelbeere|', nq'|Baccarosmel|', nq'|Baya Pomaro|', nq'|????|', nq'|Ropeul Yeolmae|', nq'|??? / ???|', nq'|Li�np� Guo / L�hnp�uh Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Ein File H|', 3 , q'|Describes Hyper Mode.|' , nq'|???????H|', nq'|Borg File H|', nq'|Dossier Teck H|', nq'|Culpa-Akte F-M|', nq'|Genus.File I|', nq'|Parte Ein: H|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Casteliacone|', 5 , q'|Cures any status condition.|' , nq'|??????|', nq'|Hiun Ice|', nq'|Glace Volute|', nq'|Stratos-Eis|', nq'|Conostropoli|', nq'|Porcehelado|', nq'|?????|', nq'|Gureum Ice|', nq'|????? / ?????|', nq'|Feiy�n Bingq�l�n / Feiw�hn Bingk�ihl�hm|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|Ginema Berry|', 3 , q'|Raises a lowered stat in battle. If transferred to Generation IV via Pal Park, it will turn into an Enigma Berry.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Fast Ball|', 2 , q'|A type of Pok� Ball that works better on Pok�mon that try to flee.|' , nq'|???????|', nq'|Speed Ball|', nq'|Speed Ball|', nq'|Turboball|', nq'|Rapid Ball|', nq'|Rapid Ball|', nq'|????|', nq'|Speed Ball|', nq'|???|', nq'|S�d� Qi� / Chukdouh K�uh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Yellow Petal|', 7 , q'|A yellow petal required to complete Mina's Trial.|' , nq'|????????|', nq'|Kiiro no Hanabira|', nq'|P�tale Jaune|', nq'|Gelbes Blatt|', nq'|Petalo giallo|', nq'|P�talo Amarillo|', nq'|????|', nq'|Norang Kkochip|', nq'|???? / ????|', nq'|Hu�ng-s� Huab�n / W�hng-sik Faf�an|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Rockium Z|', 7 , q'|Allows a Pok�mon to upgrade their Rock-type damaging moves to the Z-Move Continental Crush or upgrade their Rock-type status moves into Z-Moves. Makes Arceus a Rock-type Pok�mon.|' , nq'|??Z|', nq'|Rock-Z|', nq'|Rocaz�lite|', nq'|Petrium Z|', nq'|Petrium Z|', nq'|Litostal Z|', nq'|??Z|', nq'|Bawi-Z|', nq'|??Z|', nq'|Y�nsh�-Z / Ng�ahmsehk-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Jade Orb|', 4 , q'|Allows the player to encounter Rayquaza in the Embedded Tower.|' , nq'|????????|', nq'|Moegiiro no Tama|', nq'|Orbe Vert|', nq'|Gr�ne Kugel|', nq'|Sfera Verde|', nq'|Esfera Verde|', nq'|?????|', nq'|Yeondutbit Guseul|', nq'|????? / ?????|', nq'|Caolu-s� Bao Zhu / Ch�uluhk-sik B�ujyu|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dawn Stone|', 4 , q'|Allows Kirlia (?) and Snorunt (?) to evolve.|' , nq'|?????|', nq'|Mezame Ishi|', nq'|Pierre Aube|', nq'|Funkelstein|', nq'|Pietralbore|', nq'|Piedra Alba|', nq'|????|', nq'|Gakseong-ui Dol|', nq'|???? / ????|', nq'|Ju�xing-zhi Sh� / Goks�ng-ji Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Bloom Mail|', 4 , q'|A flower-printed stationery. To be held by a Pok�mon for delivery.|' , nq'|???????|', nq'|Bloom Mail|', nq'|Lett. P�tale|', nq'|Bl�tenbrief|', nq'|Mess. Petalo|', nq'|Carta Flores|', nq'|????|', nq'|Bloom Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Scanner|', 3 , q'|To be exchanged for a Deep Sea Scale or Deep Sea Tooth.|' , nq'|????|', nq'|Tanchiki|', nq'|Scanner|', nq'|Scanner|', nq'|Scanner|', nq'|Esc�ner|', nq'|???|', nq'|Tamjigi|', nq'|??? / ???|', nq'|T�nc�q� / Taamchakhei|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Professor's Mask|', 7 , q'|Returned to Professor Kukui at Malie Garden.|' , nq'|????????|', nq'|Hakase no Fukumen|', nq'|Masque du Prof|', nq'|Maske des Profs|', nq'|Maschera Prof.|', nq'|M�scara Profesor|', nq'|?????|', nq'|Bagsaui Bogmyeon|', nq'|?????|', nq'|B�sh�-de Mi�nzh�o / Boksih-dik Mihnjaau|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Soothe Bell|', 2 , q'|Causes the holder to gain friendship more quickly.|' , nq'|???????|', nq'|Yasuragi no Suzu|', nq'|Grelot Zen|', nq'|Sanftglocke|', nq'|Calmanella|', nq'|Campana Alivio|', nq'|?????|', nq'|Pyeong'on-ui Bang-ul|', nq'|???? / ????|', nq'|Anfu-zhi L�ng / Onf�-ji L�hng|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Gonzap's Key|', 3 , q'|Opens an item box containing TM30 (Shadow Ball).|' , nq'|??????|', nq'|Gonza no Key|', nq'|Cle Helgonza|', nq'|Schl�ssel|', nq'|Chiave Helg.|', nq'|Llave Golka|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lopunnite|', 6 , q'|Allows Lopunny to Mega Evolve into Mega Lopunny.|' , nq'|????????|', nq'|Mimilopnite|', nq'|Lockpinite|', nq'|Schlapornit|', nq'|Lopunnite|', nq'|Lopunnita|', nq'|??????|', nq'|Ieoropnite|', nq'|?????? / ??????|', nq'|Ch�ng'ert� J�nhu� Sh� / Ch�uhngy�htou Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Protective Pads|', 7 , q'|Protects the holder from effects caused by using moves that make contact with the target.|' , nq'|??????|', nq'|Bogo Pad|', nq'|Pare-Effet|', nq'|Schutzpolster|', nq'|Smorzaurti|', nq'|Paracontacto|', nq'|????|', nq'|Bangho Pad|', nq'|???? / ????|', nq'|B�w�i H�j� / Bouhwaih Wuhgeuih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Gram 2|', 5 , q'|An important letter which Wingull delivers.|' , nq'|??????2|', nq'|Haitatsubutsu 2|', nq'|Courrier 2|', nq'|Briefpost 2|', nq'|Missiva 2|', nq'|Env�o 2|', nq'|???2|', nq'|Baedalmul 2|', nq'|????2|', nq'|P�is�ng W�pin 2 / Puisung Mahtb�n 2|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Potion|', 1 , q'|Restores 20 HP.|' , nq'|?????|', nq'|Kizu Gusuri|', nq'|Potion|', nq'|Trank|', nq'|Pozione|', nq'|Poci�n|', nq'|???|', nq'|Sangcheo Yak|', nq'|?? / ??|', nq'|Shangy�o / Seungyeuhk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Super Repel|', 1 , q'|Prevents wild Pok�mon with a lower level than the first member of the party from appearing for 200 steps|' , nq'|????????|', nq'|Silver Spray|', nq'|Superepousse|', nq'|Superschutz|', nq'|Superrepellente|', nq'|Superrepelente|', nq'|??????|', nq'|Silver Spray|', nq'|???? / ????|', nq'|B�iy�n Penw� / Baahkng�hn Panmouh|', 48 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Power Anklet|', 4 , q'|Promotes Speed EVs, but lowers Speed in battle.|' , nq'|???????|', nq'|Power Ankle|', nq'|Cha�ne Pouvoir|', nq'|Machtkette|', nq'|Vigorgliera|', nq'|Franja Recia|', nq'|?????|', nq'|Power Anklet|', nq'|???? / ????|', nq'|L�li�ng H�hu�i / Lihkleuhng Wuhwahng|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Coupon 1|', 4 , q'|Used to obtain the Pok�tch in Jubilife City.|' , nq'|??????1|', nq'|Hikikaeken 1|', nq'|Bon 1|', nq'|Kupon 1|', nq'|Coupon 1|', nq'|Cup�n 1|', nq'|??? 1|', nq'|Gyohwangwon 1|', nq'|???1 / ???1|', nq'|Du�hu�n Qu�n 1 / Deuiwuhn Hyun 1|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Bonsly Card|', 3 , q'|Allows play of the card in Battle Bingo.|' , nq'|???????|', nq'|Usohachi Sheet|', nq'|Carte Manzai|', nq'|Mobai-Karte|', nq'|Scheda Bonsly|', nq'|Cart. Bonsly|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Big Root|', 4 , q'|Increases the amount of HP restored when an HP-draining move is used by 30%.|' , nq'|???????|', nq'|Okina Nekko|', nq'|Grosse Racine|', nq'|Gro�wurzel|', nq'|Granradice|', nq'|Ra�z Grande|', nq'|???|', nq'|Keun Ppuri|', nq'|??? / ???|', nq'|D� Genjing / Daaih Ganging|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pidgeotite|', 6 , q'|Allows Pidgeot to Mega Evolve into Mega Pidgeot.|' , nq'|????????|', nq'|Pigeotnite|', nq'|Roucarnagite|', nq'|Taubossnit|', nq'|Pidgeotite|', nq'|Pidgeotita|', nq'|??????|', nq'|Pijontoonite|', nq'|?????? / ??????|', nq'|D�biniao J�nhu� Sh� / Daaihb�in�uh Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Passho Berry|', 4 , q'|Reduces damage from a super effective Water-type move.|' , nq'|?????|', nq'|Itoke no Mi|', nq'|Baie Pocpoc|', nq'|Foepasbeere|', nq'|Baccapasflo|', nq'|Baya Pasio|', nq'|?????|', nq'|Kkosigae Yeolmae|', nq'|???|', nq'|Qianxiang Guo / Chinheung Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Luxury Ball|', 3 , q'|A Pok�mon caught in a Luxury Ball will gain friendship more quickly.|' , nq'|????????|', nq'|Gorgeous Ball|', nq'|Luxe Ball|', nq'|Luxusball|', nq'|Chich Ball|', nq'|Lujo Ball|', nq'|????|', nq'|Luxury Ball|', nq'|??? / ???|', nq'|H�ohu� Qi� / H�uhw�h K�uh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Durin Berry|', 3 , q'|Poffin and Pok�block ingredient.|' , nq'|????|', nq'|Dori no Mi|', nq'|Baie Durin|', nq'|Durinbeere|', nq'|Baccadurian|', nq'|Baya Rudion|', nq'|????|', nq'|Duri Yeolmae|', nq'|???|', nq'|Jinzhen Guo / Gamj�m Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Rare Bone|', 4 , q'|Can be sold for 5000.|' , nq'|???????|', nq'|Kichona Hone|', nq'|Os Rare|', nq'|Steinknochen|', nq'|Osso Raro|', nq'|Hueso Raro|', nq'|????|', nq'|Gwijunghan Ppyeo|', nq'|???? / ????|', nq'|Gu�zh�ng Gutou / Gwaijuhng Gwatt�uh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|MysteryBerry|', 2 , q'|Restores 5 PP.|' , nq'|???????|', nq'|Fushigina Kino Mi|', nq'|Baie Mystere|', nq'|R�tselbeere|', nq'|Bacca Mist.|', nq'|Bayamisterio|', nq'|???????|', nq'|Isanghan Namu Yeolmae|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Blue Card|', 2 , q'|Allows player to answer daily question on Buena's show to get points exchangeable for items.|' , nq'|??????|', nq'|Blue Card|', nq'|Carte Bleue|', nq'|Blaue Karte|', nq'|Carta Blu|', nq'|Tarjeta Azul|', nq'|????|', nq'|Blue Card|', nq'|?? / ??|', nq'|L�n Ka / L�ahm Kaat|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Stardust|', 2 , q'|Can be sold for 1000.|' , nq'|?????|', nq'|Hoshi no Suna|', nq'|Poussi�re �toile|', nq'|Sternenstaub|', nq'|Polvostella|', nq'|Polvoestelar|', nq'|????|', nq'|Byeorui Morae|', nq'|????|', nq'|Xingxing Shazi / Singsing Saj�|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Sprayduck|', 4 , q'|Used to water Berry plants.|' , nq'|????????|', nq'|Koduck Joro|', nq'|Kwakarrosoir|', nq'|Entonkanne|', nq'|Sprayduck|', nq'|Psydugadera|', nq'|????????|', nq'|Gorapaduck Mulppurigae|', nq'|????? / ?????|', nq'|Ked�ya Penh� / H�daaht�ap Panw�h|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Galladite|', 6 , q'|Allows Gallade to Mega Evolve into Mega Gallade.|' , nq'|????????|', nq'|Erureidonite|', nq'|Gallamite|', nq'|Galagladinit|', nq'|Galladite|', nq'|Galladita|', nq'|???????|', nq'|Elladenite|', nq'|??????? / ???????|', nq'|�il�l�iduo J�nhu� Sh� / Ngaaihlouhl�uid� Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Wave Mail|', 3 , q'|Mail with a Wailmer design. To be held by a Pok�mon for delivery.|' , nq'|??????|', nq'|Cross Mail|', nq'|Lettre Vague|', nq'|Wellenbrief|', nq'|Mess. Onda|', nq'|Carta Ola|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Fire Stone|', 1 , q'|Can be used to evolve Vulpix, Growlithe, Eevee, and Pansear.|' , nq'|??????|', nq'|Hono no Ishi|', nq'|Pierre Feu|', nq'|Feuerstein|', nq'|Pietrafocaia|', nq'|Piedra Fuego|', nq'|????|', nq'|Bulkkoch-ui Dol|', nq'|???|', nq'|Huo-zhi Sh� / F�-ji Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Key to Room 2|', 6 , q'|Opens Room 2 of the Abandoned ShipRSE/Sea MauvilleORAS.|', q'|Called Rm. 2 Key in Generation III.|', nq'|????????|', nq'|Ni-go Shitsu no Kagi|', nq'|Cl� Salle 2|', nq'|R2-Schl�ssel|', nq'|Chiave stanza 2|', nq'|Ll. Habitaci�n 2|', nq'|?????|', nq'|I-hosil Yeolsoe|', nq'|2?????? /|'||chr(10)||nq'|2??????|', nq'|2 H�o K�f�ng-de Y�oshi / 2 Houh Haakf�ng-dik Yeuhks�h|', 1616 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( q'|Surge Badge|' , nq'|???????|', nq'|Daidai Badge|', nq'|Fulguro-Badge|', nq'|Gewitterorden|', nq'|Medaglia Tonante|', nq'|Medalla Fulgor|', nq'|????|', nq'|Juhwang Badge|', nq'|???? / ????|', nq'|J�-s� Huizhang / Gwat-sik Faijeung|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dread Plate|', 4 , q'|Raises the power of Dark-type moves.|' , nq'|????????|', nq'|Kowamote Pureto|', nq'|Plaque Ombre|', nq'|Furchttafel|', nq'|Lastratimore|', nq'|Tabla Oscura|', nq'|??????|', nq'|Gongpo Plate|', nq'|???? / ????|', nq'|�'y�n Sh�ban / Okng�ahn Sehkb�an|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lens Case|', 6 , q'|Stores colored contact lenses that allow the player to change their eye color.|' , nq'|??????|', nq'|Lens Case|', nq'|Bo�te Lentilles|', nq'|Linsenetui|', nq'|Portalenti|', nq'|Portalentillas|', nq'|?????|', nq'|Lens Case|', nq'|????? / ?????|', nq'|Yinx�ng Yanj�ng H� / Y�ny�hng Ng�ahngeng Hahp|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pok� Toy|', 5 , q'|Allows the player to flee from any battle with a wild Pok�mon.|' , nq'|??????|', nq'|Pok� Jarashi|', nq'|Pok�plumet|', nq'|Pok�wedel|', nq'|Pok�gingillo|', nq'|Pok�se�uelo|', nq'|???|', nq'|Pocket Pul|', nq'|???? / ????|', nq'|Baoke Weicao / B�uh� M�ihch�u|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Mawilite|', 6 , q'|Allows Mawile to Mega Evolve into Mega Mawile.|' , nq'|???????|', nq'|Kucheatnite|', nq'|Mysdibulite|', nq'|Flunkifernit|', nq'|Mawilite|', nq'|Mawilita|', nq'|??????|', nq'|Ipchittnite|', nq'|?????? / ??????|', nq'|D�zuiw� J�nhu� Sh� / Daaihj�uiwa Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Tyranitarite|', 6 , q'|Allows Tyranitar to Mega Evolve into Mega Tyranitar.|' , nq'|????????|', nq'|Bangirasnite|', nq'|Tyranocivite|', nq'|Despotarnit|', nq'|Tyranitarite|', nq'|Tyranitarita|', nq'|???????|', nq'|Magirasnite|', nq'|??????? / ???????|', nq'|Banjilasi J�nhu� Sh� / Baangeilaaisi Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Max Revive|', 1 , q'|Revives a Pok�mon to full health.|' , nq'|????????|', nq'|Genki no Katamari|', nq'|Rappel Max|', nq'|Top-Beleber|', nq'|Revitalizz. Max|', nq'|Revivir M�ximo|', nq'|??????|', nq'|Giryeog-ui Deong-eori|', nq'|??? / ???|', nq'|Hu�l� Ku�i / Wuhtlihk Faai|', 48 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( q'|Squirt Bottle|' , nq'|????????|', nq'|Zenigame Joro|', nq'|Carapuce � O|', nq'|Schiggykanne|', nq'|Annaffiatoio|', nq'|Regadera|', nq'|???????|', nq'|Kkobugi Mulppurigae|', nq'|????? / ?????|', nq'|Ji�n�gui Penh� / Gihtn�ihgwai Panw�h|' );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Tiny Mushroom|', 2 , q'|Exchangeable in return for services.|', q'|Formatted as TinyMushroom prior to Generation VI.|', nq'|???????|', nq'|Chiisana Kinoko|', nq'|Petit Champi|', nq'|Minipilz|', nq'|Piccolo Fungo|', nq'|Mini Seta|', nq'|????|', nq'|Jageun Beoseot|', nq'|???|', nq'|Xiao M�gu / S�u M�hgu|', 1024 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Shoal Salt|', 3 , q'|Can be used to make a Shell Bell. Does not have any use in Generation IV. Can be sold to an item maniac in the Icirrus City Pok�mon Center for 7000 in Generation V.|' , nq'|??????|', nq'|Asase no Shio|', nq'|Sel Trefonds|', nq'|K�stensalz|', nq'|Sale Ondoso|', nq'|Sal Cardumen|', nq'|????|', nq'|Yeoul Sogeum|', nq'|???? / ????|', nq'|Qiantan Haiy�n / Ch�ntaan H�iy�hm|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pal Pad|', 4 , q'|Used to record friends on Nintendo Wi-Fi Connection and register Friend Codes.|' , nq'|????????|', nq'|Tomodachi Techo|', nq'|Registre Ami|', nq'|Adressbuch|', nq'|Blocco Amici|', nq'|Bloc amigos|', nq'|????|', nq'|Chingu Sucheop|', nq'|???? / ????|', nq'|P�ngyou Shouc� / P�hngy�uh S�uchaak|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Occa Berry|', 4 , q'|Reduces damage taken from a super effective Fire-type move.|' , nq'|?????|', nq'|Occa no Mi|', nq'|Baie Chocco|', nq'|Koakobeere|', nq'|Baccacao|', nq'|Baya Caoca|', nq'|????|', nq'|Oca Yeolmae|', nq'|???|', nq'|Qiaoke Guo / H�auh�Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Thunder Stone|', 1 , q'|Can be used to evolve Pikachu into Raichu, Eevee into Jolteon, and Eelektrik to Eelektross.|', q'|Formatted as Thunderstone prior to Generation VI.|', nq'|???????|', nq'|Kaminari no Ishi|', nq'|Pierre Foudre|', nq'|Donnerstein|', nq'|Pietratuono|', nq'|Piedra Trueno|', nq'|????|', nq'|Cheondung-ui Dol|', nq'|???|', nq'|L�i-zhi Sh� / L�uih-ji Sehk|', 1168 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pink Petal|', 7 , q'|A pink petal required to complete Mina's Trial.|' , nq'|????????|', nq'|Momoiro Hanabira|', nq'|P�tale Rose|', nq'|Rosa Blatt|', nq'|Petalo rosa|', nq'|P�talo Rosa|', nq'|????|', nq'|Damhong Kkochip|', nq'|???? / ????|', nq'|Fenh�ng Huab�n / F�nh�hng Faf�an|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Bubble Mail|', 4 , q'|Stationery with a bubble print. To be held by a Pok�mon for delivery.|' , nq'|??????|', nq'|Blue Mail|', nq'|Lettre Mer|', nq'|Wasserbrief|', nq'|Mess. Bolla|', nq'|Carta Pompas|', nq'|????|', nq'|Blue Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Yellow Scarf|', 3 , q'|Raises the Tough condition.|' , nq'|????????|', nq'|Kiiro no Bandana|', nq'|Foul. Jaune|', nq'|Gelber Schal|', nq'|Fascia Gialla|', nq'|Pa�uelo Amarillo|', nq'|????|', nq'|Norang Band|', nq'|???? / ????|', nq'|Hu�ng-s� T�ujin / W�hng-sik T�uhgan|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|Running Shoes|', 3 , q'|Allows the player to run faster.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Buginium Z|', 7 , q'|Allows a Pok�mon to upgrade their Bug-type damaging moves to the Z-Move Savage Spin-Out or upgrade their Bug-type status moves into Z-Moves. Makes Arceus a Bug-type Pok�mon.|' , nq'|??Z|', nq'|Bug-Z|', nq'|Insectoz�lite|', nq'|Insectium Z|', nq'|Insectium Z|', nq'|Insectostal Z|', nq'|??Z|', nq'|Beolle-Z|', nq'|?Z / ?Z|', nq'|Ch�ng-Z / Ch�hng-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Green Shard|', 3 , q'|Exchangeable for a variety of services.|' , nq'|???????|', nq'|Midori no Kakera|', nq'|Tesson Vert|', nq'|Gr�nst�ck|', nq'|Coccio Verde|', nq'|Parte Verde|', nq'|????|', nq'|Chorok Jogak|', nq'|???? / ????|', nq'|Lus� Su�pi�n / Luhksik Seuipin|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Reaper Cloth|', 4 , q'|A held item that allows Dusclops to evolve into Dusknoir when traded.|' , nq'|???????|', nq'|Reikai no Nuno|', nq'|Tissu Fauche|', nq'|D�sterumhang|', nq'|Terrorpanno|', nq'|Tela Terrible|', nq'|????|', nq'|Yeonggye-ui Cheon|', nq'|???? / ????|', nq'|L�ngji�-zhi B� / L�hnggaai-ji Bou|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Bottle Cap|', 7 , q'|Can be traded to Mr. Hyper to maximize one of a Pok�mon's IVs in Hyper Training.|' , nq'|???????|', nq'|Gin no Okan|', nq'|Capsule d'Argent|', nq'|Silberkronkorken|', nq'|Tappo d'argento|', nq'|Chapa Plateada|', nq'|???|', nq'|Eun Wanggwan|', nq'|???? / ????|', nq'|Y�ns� W�ngguan / Ng�hnsik W�hnggun|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Eon Flute|', 6 , q'|Summons LatiasAS or LatiosOR to soar in the sky above Hoenn, and fly to any city, route, or island.|' , nq'|??????|', nq'|Mugen no Fue|', nq'|Fl�te �on|', nq'|�on-Fl�te|', nq'|Flauto Eone|', nq'|Flauta E�n|', nq'|?????|', nq'|Muhan Uipili|', nq'|???? / ????|', nq'|W�xi�n-zhi D� / M�uhhaahn-ji Dehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|Strib Berry|', 3 , q'|Pok�block ingredient. Will become an Enigma Berry if transferred to Generation IV via Pal Park.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Oran Berry|', 3 , q'|Restores 10 HP.|' , nq'|?????|', nq'|Oren no Mi|', nq'|Baie Oran|', nq'|Sinelbeere|', nq'|Baccarancia|', nq'|Baya Aranja|', nq'|????|', nq'|Oraeng Yeolmae|', nq'|???|', nq'|Ch�ngch�ng Guo / Ch�ahngch�ahng Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|X Accuracy 6|', 5 , q'|Immensely raises a Pok�mon's accuracy. Wonder Launcher only.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Spell Tag|', 2 , q'|Raises the power of Ghost-type moves.|' , nq'|???????|', nq'|Noroi no Ofuda|', nq'|Rune Sort|', nq'|Bannsticker|', nq'|Spettrotarga|', nq'|Hechizo|', nq'|?????|', nq'|Jeojuui Bujeok|', nq'|???? / ????|', nq'|Zuzh�u-zhi F� / Jojau-ji F�h|', 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( q'|Roto PP Restore|' , nq'|PP??????|', nq'|PP Kaifuku Pon|', nq'|Moti-R�cup' PP|', nq'|AP-Bon|', nq'|PP'n'roll|', nq'|Cup�n PP|', nq'|�???|', nq'|�???|', nq'|PP???? /|'||chr(10)||nq'|PP????|', nq'|PP Hu�f� P�ngp�ng / PP W�ihfuhk Pungpung|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Damp Rock|', 4 , q'|Increases the duration of heavy rain.|' , nq'|??????|', nq'|Shimetta Iwa|', nq'|Roche Humide|', nq'|Nassbrocken|', nq'|Rocciaumida|', nq'|Roca Lluvia|', nq'|?????|', nq'|Chukchukhan Bawi|', nq'|???? / ????|', nq'|Ch�oshi Y�nsh� / Ch�uhsap Ng�ahmsehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Ruby|', 3 , q'|Give to Celio along with Sapphire to set up the Network Machine of the Pok�mon Network Center. It allows the player to trade with Ruby, Sapphire, and Emerald.|' , nq'|???|', nq'|Ruby|', nq'|Rubis|', nq'|Rubin|', nq'|Rubino|', nq'|Rub�|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Psychic Memory|', 7 , q'|Makes Silvally a Psychic-type Pok�mon and makes Multi-Attack a Psychic-type move.|' , nq'|????????|', nq'|Psychic Memory|', nq'|ROM Psy|', nq'|Psycho-Disc|', nq'|ROM Psico|', nq'|Disco Ps�quico|', nq'|??????|', nq'|Psychic Memory|', nq'|?????*|'||chr(10)||nq'|?????|', nq'|Jingsh�n J�y�di� / Jings�hn Geiyikdihp*|'||chr(10)||nq'|Jingsh�n C�nchudi�|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Silph Scope|', 1 , q'|Used to identify ghosts in Pok�mon Tower.|' , nq'|???????|', nq'|Silph Scope|', nq'|Scope Sylphe|', nq'|Silph Scope|', nq'|Spettrosonda|', nq'|Scope Silph|', nq'|?????|', nq'|Silph Scope|', nq'|?????? / ??????|', nq'|Xierfu Jiansh�j�ng / Saiy�hfaht G�msihgeng|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Reveal Glass|', 5 , q'|A glass that tells the truth. It is a mysterious glass that returns a Pok�mon back to its original shape.|' , nq'|??????|', nq'|Reflecting Mirror|', nq'|Miroir Sacr�|', nq'|Wahrspiegel|', nq'|Verispecchio|', nq'|Espejo Veraz|', nq'|?????|', nq'|Bichu-neun Geoul|', nq'|??? / ???|', nq'|Xi�nx�ng J�ng / Yihny�hng Geng|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Oval Stone|', 4 , q'|When held, allows Happiny to evolve.|' , nq'|??????|', nq'|Manmaru Ishi|', nq'|Pierre Ovale|', nq'|Ovaler Stein|', nq'|Pietraovale|', nq'|Piedra Oval|', nq'|?????|', nq'|Donggeuldonggeul Dol|', nq'|???? / ????|', nq'|H�nyu�n-zhi Sh� / Wahny�hn-ji Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Maingate Key|', 3 , q'|Opens the front gate to the Shadow PKMN Lab.|' , nq'|????????|', nq'|Main Gate Key|', nq'|Cle Labo|', nq'|Torschl�ssel|', nq'|Chiave Canc.|', nq'|Ll. Entrada|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dragon Scale|', 2 , q'|A hold item that allows Seadra to evolve when traded.|' , nq'|???????|', nq'|Ryu no Uroko|', nq'|�caille Draco|', nq'|Drachenhaut|', nq'|Squama Drago|', nq'|Escamadrag�n|', nq'|????|', nq'|Yong-ui Bineul|', nq'|???? / ????|', nq'|L�ng zhi l�npi�n / L�hng-ji L�uhnpin|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Green Apricorn|', 2 , q'|Kurt will make the player a Friend Ball out of it.|', q'|Formatted as Grn Apricorn prior to Generation VI.|', nq'|??????|', nq'|Mido Bonguri|', nq'|Noigrume Ver|', nq'|Aprikoko Grn|', nq'|Ghicocca Verde|', nq'|Bonguri Verde|', nq'|?????|', nq'|Chorok Gyutori|', nq'|??? / ???|', nq'|Lu Qi�guo / Luhk K�uhgw�|', 1072 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Charizardite Y|', 6 , q'|Allows Charizard to Mega Evolve into Mega Charizard Y.|' , nq'|???????Y|', nq'|Lizardonite Y|', nq'|Dracaufite Y|', nq'|Gluraknit Y|', nq'|Charizardite Y|', nq'|Charizardita Y|', nq'|??????Y|', nq'|Rizamonnite Y|', nq'|??????Y / ??????Y|', nq'|Penhuol�ng J�nhu� Sh� Y / Panf�l�hng Jeunfa Sehk Y|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Secret Potion|', 2 , q'|Used to cure Amphy's sicknessGSCHGSS or the Psyduck's headachesDPPt. Is produced by the Cianwood City Pharmacy.|', q'|Formatted as SecretPotion prior to Generation VI.|', nq'|???????|', nq'|Hiden no Kusuri|', nq'|Potionsecret|', nq'|Geheimtrank|', nq'|Poz. Segreta|', nq'|Poc. Secreta|', nq'|????|', nq'|Bijeon Sin-yak|', nq'|???? / ????|', nq'|M�chu�n-zhi Y�o / Beichy�hn-ji Yeuhk|', 1024 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Gooey Mulch|', 4 , q'|Increases the number of times new Berry plants can grow where old ones withered.|' , nq'|???????|', nq'|Nebaneba Koyashi|', nq'|Fertiglu|', nq'|Neumulch|', nq'|Fertilcolla|', nq'|Abono Brote|', nq'|??????|', nq'|Kkeunjeok-kkeunjeok Biryo|', nq'|??? / ???|', nq'|Ni�nni�n F�i / Nimnim F�ih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Firium Z|', 7 , q'|Allows a Pok�mon to upgrade their Fire-type damaging moves to the Z-Move Inferno Overdrive or upgrade their Fire-type status moves into Z-Moves. Makes Arceus a Fire-type Pok�mon.|' , nq'|???Z|', nq'|Flame-Z|', nq'|Pyroz�lite|', nq'|Pyrium Z|', nq'|Pirium Z|', nq'|Pirostal Z|', nq'|??Z|', nq'|Bulkkot-Z|', nq'|?Z|', nq'|Huo-Z / F�-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Destiny Knot|', 4 , q'|Infatuates the foe if the holder becomes infatuated.|' , nq'|?????|', nq'|Akai Ito|', nq'|N�ud Destin|', nq'|Fatumknoten|', nq'|Destincomune|', nq'|Lazo Destino|', nq'|???|', nq'|Ppalgan Sil|', nq'|?? / ??|', nq'|H�ngxi�n / H�hngsin|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Snowball|', 6 , q'|Raises the holder's Attack by one stage after being hit by an Ice-type attack. Consumed after use.|' , nq'|????|', nq'|Yukidama|', nq'|Boule de Neige|', nq'|Schneeball|', nq'|Palla di Neve|', nq'|Bola de Nieve|', nq'|???|', nq'|Nundeong-i|', nq'|??|', nq'|Xueqi� / Syutk�uh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|BridgeMail V|', 5 , q'|Stationary with a brick bridge print. To be held by a Pok�mon for delivery.|' , nq'|???????V|', nq'|Bridge Mail V|', nq'|Lettre PontH|', nq'|Br�ckbrief D|', nq'|Mess. Vill.|', nq'|C. Puente V|', nq'|?????V|', nq'|Bridge Mail V|', nq'|????V / ????V|', nq'|Qi�oli�ng Y�uji�n V / K�uhl�uhng Y�uhg�n V|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Nugget|', 1 , q'|Can be sold for 5000.|' , nq'|?????|', nq'|Kin no Tama|', nq'|Pepite|', nq'|Nugget|', nq'|Pepita|', nq'|Pepita|', nq'|???|', nq'|Geum Guseul|', nq'|??|', nq'|Jinzhu / Gamjyu|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Mind Plate|', 4 , q'|Raises the power of Psychic-type moves.|' , nq'|????????|', nq'|Fushigi no Pureto|', nq'|Plaque Esprit|', nq'|Hirntafel|', nq'|Lastramente|', nq'|Tabla Mental|', nq'|???????|', nq'|Isanghan Plate|', nq'|????|', nq'|Sh�nq� Sh�ban / S�hnk�ih Sehkb�an|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|White Flute|', 3 , q'|Attracts wild Pok�mon to the player.RSEFRLGDPPtHGSS Can be sold for 8000.BWB2W2 Decreases the level of wild Pok�mon by one to three levels.ORAS|' , nq'|???????|', nq'|Shiroi Vidro|', nq'|Fl�te Blanche|', nq'|Weisse Fl�te|', nq'|Flauto Bianco|', nq'|Flauta Blanca|', nq'|?????|', nq'|Hayang Vidro|', nq'|?????|', nq'|B�i-s� Bol� Sh�o / Baahk-sik Bol�ih Saau|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Old Sea Map|', 3 , q'|Event item that gives player access to Faraway Island, where Mew can be caught.|' , nq'|???????|', nq'|Furubita Kaizu|', nq'|Vieille Carte|', nq'|Alte Karte|', nq'|Mappa Stinta|', nq'|Mapa Viejo|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Music Mail|', 2 , q'|Mail with a Natu design. Only available through Mystery Gift. To be held by a Pok�mon for delivery.|' , nq'|??????|', nq'|Onpu Mail|', nq'|Lettre Musique|', nq'|Melodiebrief|', nq'|Mess. Musica|', nq'|Carta M�sica|', nq'|????|', nq'|Eumpyo Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Bluk Berry|', 3 , q'|Poffin and Pok�block ingredient.|' , nq'|?????|', nq'|Buri no Mi|', nq'|Baie Remu|', nq'|Morbbeere|', nq'|Baccamora|', nq'|Baya Oram|', nq'|????|', nq'|Beulli Yeolmae|', nq'|???|', nq'|M�m�i Guo / Mahkm�ih Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Psychic Seed|', 7 , q'|A one-time use item that raises the holder's Sp. Defense by one stage upon activation of Psychic Terrain.|' , nq'|??????|', nq'|Psycho Seed|', nq'|Graine Psychique|', nq'|Psycho-Samen|', nq'|Psicoseme|', nq'|Semilla Psique|', nq'|?????|', nq'|Psycho Seed|', nq'|???? / ????|', nq'|Jingsh�n Zhongzi / Jings�hn J�ngj�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Leaf Stone|', 1 , q'|Can be used to evolve Gloom into Vileplume, Weepinbell into Victreebel, Exeggcute into Exeggutor, Nuzleaf into Shiftry, and Pansage into Simisage.|' , nq'|??????|', nq'|Leaf no Ishi|', nq'|Pierre Plante|', nq'|Blattstein|', nq'|Pietrafoglia|', nq'|Piedra Hoja|', nq'|????|', nq'|Leaf-ui Dol|', nq'|??? / ???|', nq'|Y�-zhi Sh� / Yihp-ji Sehk|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Chesto Berry|', 3 , q'|Awakens a Pok�mon from sleep.|' , nq'|????|', nq'|Kago no Mi|', nq'|Baie Maron|', nq'|Maronbeere|', nq'|Baccastagna|', nq'|Baya Atania|', nq'|????|', nq'|Yuru Yeolmae|', nq'|??? / ???|', nq'|L�ngy� Guo / L�hngy�h Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Apicot Berry|', 3 , q'|Raises Special Defense when HP is below ?.|' , nq'|????|', nq'|Zua no Mi|', nq'|Baie Abriko|', nq'|Apikobeere|', nq'|Baccacocca|', nq'|Baya Aricoc|', nq'|????|', nq'|Gyusal Yeolmae|', nq'|???|', nq'|X�ngzi Guo / Hahngj�i Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Full Heal|', 1 , q'|Cures any status condition.|' , nq'|???????|', nq'|Nandemo Naoshi|', nq'|Total Soin|', nq'|Hyperheiler|', nq'|Cura Totale|', nq'|Cura Total|', nq'|?????|', nq'|Manbyeongtongchiyak|', nq'|??? / ???|', nq'|W�nl�ngy�o / Maahnl�hngyeuhk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Fab Mail|', 3 , q'|Mail with an extremely decorative design. To be held by a Pok�mon for delivery.|' , nq'|???????|', nq'|Miracle Mail|', nq'|Lettre Cool|', nq'|Edelbrief|', nq'|Mess. Fab|', nq'|Carta Fabulosa|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Basement Key|', 2 , q'|Allows the player to access the basement of the Goldenrod Tunnel.|' , nq'|?????|', nq'|Chika no Kagi|', nq'|Cl� Sous-Sol|', nq'|Keller�ffner|', nq'|Chiave sotterr.|', nq'|Llave del S�tano|', nq'|????|', nq'|Jiha Yeolsoe|', nq'|???? / ????|', nq'|D�xi� Y�oshi / Deihhah Yeuhks�h|', 28 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Aqua Suit|', 6 , q'|Allows the player to ride Kyogre in the Cave of Origin and fly into space on Rayquaza.|' , nq'|??????|', nq'|Aqua Suit|', nq'|Scaphandre Aqua|', nq'|Aqua-Anzug|', nq'|Tuta Idro|', nq'|Traje Aqua|', nq'|?????|', nq'|Aqua Suit|', nq'|??? / ???|', nq'|Haiy�ng Zhuang / H�iy�uhng Jong|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Rich Mulch|', 6 , q'|When applied to a Berry patch, increases the final Berry harvest by 2 Berries.|' , nq'|??????|', nq'|Tawawa Koyashi|', nq'|Fertibondance|', nq'|Sprie�mulch|', nq'|Fertilflorido|', nq'|Abono F�rtil|', nq'|??????|', nq'|Jureong-jureong Biryo|', nq'|??? / ???|', nq'|Shu�guo F�i / Sehkgw� F�ih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Kelpsy Berry|', 3 , q'|Raises friendship, but lowers Attack EV.|' , nq'|?????|', nq'|Nekobu no Mi|', nq'|Baie Alga|', nq'|Setangbeere|', nq'|Baccalga|', nq'|Baya Algama|', nq'|????|', nq'|Sima Yeolmae|', nq'|???|', nq'|Zaogen Guo / J�ugan Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|GS Ball|', 2 , q'|Allows Celebi to be caught in Pok�mon Crystal.|' , nq'|???????|', nq'|GS Ball|', nq'|GS Ball|', nq'|GS-Ball|', nq'|GS Ball|', nq'|GS Ball|', nq'|GS?|', nq'|GS Ball|', nq'|GS?|', nq'|GS Qi� / GS K�uh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Chilan Berry|', 4 , q'|Reduces damage from a Normal-type move by 50%.|' , nq'|????|', nq'|Hozu no Mi|', nq'|Baie Zalis|', nq'|Latchibeere|', nq'|Baccacinlan|', nq'|Baya Chilan|', nq'|????|', nq'|Kari Yeolmae|', nq'|??? / ???|', nq'|Dengjiang Guo / Dangjeung Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Swampertite|', 6 , q'|Allows Swampert to Mega Evolve into Mega Swampert.|' , nq'|????????|', nq'|Laglargenite|', nq'|Laggronite|', nq'|Sumpexnit|', nq'|Swampertite|', nq'|Swampertita|', nq'|??????|', nq'|Daejjanginite|', nq'|?????? / ??????|', nq'|J�zhaogu�i J�nhu� Sh� / Geuihj�ugwaai Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Magost Berry|', 3 , q'|Pok�block and Poffin ingredient.|' , nq'|????|', nq'|Gosu no Mi|', nq'|Baie Mangou|', nq'|Magostbeere|', nq'|Baccagostan|', nq'|Baya Aostan|', nq'|?????|', nq'|Gostee Yeolmae|', nq'|???|', nq'|Yu�zh� Guo / Ngohkjuk Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Voice Case 3|', 3 , q'|Heals a Taillow in Agate Village.|' , nq'|??????3|', nq'|Koe Capsule 3|', nq'|Boite Cri 3|', nq'|Stimmbox 3|', nq'|Disco Verso 3|', nq'|Grabaci�n 3|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Powder Jar|', 3 , q'|Stores Berry Powder made from Berry Crush.|' , nq'|????|', nq'|Konaire|', nq'|Pot Poudre|', nq'|Puderd�schen|', nq'|Portafarina|', nq'|Bote Polvos|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|X Sp. Atk|', 1 , q'|Raises a Pok�mon's Special Attack (Special in Generation I) by 2 stages (1 stage before Gen. VII).|', q'|Called X Special prior to Generation VI.|', nq'|????????|', nq'|Special Up|', nq'|Special +|', nq'|X-Spezial|', nq'|Att. Speciale X|', nq'|Especial X|', nq'|????|', nq'|Special-Up|', nq'|???? / ????|', nq'|T�gong Qi�nghu� / Dahkgung K�uhngfa|', 1056 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( q'|N-Solarizer|' , nq'|????????|', nq'|Necro Plus Sol|', nq'|Necrosol|', nq'|Necrosol|', nq'|Necrosolix|', nq'|Necrosol|', nq'|???????|', nq'|Necro Plus Sol|', nq'|???????? / ????????|', nq'|N�ik�lu� Suoer H�tiq� / Noihhaklok Soky�h Hahpt�ihei|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Snow Mail|', 4 , q'|Mail with a snow print. To be held by a Pok�mon for delivery.|' , nq'|????????|', nq'|Blizzard Mail|', nq'|Lettre Neige|', nq'|Schneebrief|', nq'|Mess. Neve|', nq'|Carta Nieve|', nq'|??????|', nq'|Blizzard Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Sport Ball|', 2 , q'|A type of Pok� Ball that is used in the Bug-Catching Contest.|', q'|Called Park Ball in Generation II.|', nq'|??????|', nq'|Compe Ball|', nq'|Comp�t'Ball|', nq'|Turnierball|', nq'|Gara Ball|', nq'|Competi Ball|', nq'|???|', nq'|Compe Ball|', nq'|??? / ???|', nq'|J�ngs�i Qi� / Gihngchoi K�uh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|MiracleBerry|', 2 , q'|Cures any status condition.|' , nq'|?????|', nq'|Kiseki no Mi|', nq'|Baie Miracle|', nq'|Wunderbeere|', nq'|Bacca Mirac.|', nq'|Baya Milagro|', nq'|?????|', nq'|Gijeogui Yeolmae|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Heavy Ball|', 2 , q'|A type of Pok� Ball that works better on heavier Pok�mon.|' , nq'|??????|', nq'|Heavy Ball|', nq'|Masse Ball|', nq'|Schwerball|', nq'|Peso Ball|', nq'|Peso Ball|', nq'|???|', nq'|Heavy Ball|', nq'|???|', nq'|Ch�nzh�ng Qi� / Ch�hmch�hng K�uh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Burnt Berry|', 2 , q'|Thaws out a frozen Pok�mon.|' , nq'|??????|', nq'|Yaketa Kino Mi|', nq'|Baie Brulure|', nq'|Brandbeere|', nq'|Bacca Bruc.|', nq'|Antiquembaya|', nq'|??????|', nq'|Bultan Namu Yeolmae|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Ein File C|', 3 , q'|Describes Celebi.|' , nq'|???????C|', nq'|Borg File C|', nq'|Dossier Teck C|', nq'|Culpa-Akte C|', nq'|Genus.File C|', nq'|Parte Ein: C|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pinap Berry|', 3 , q'|Pok�block and Poffin ingredient.|' , nq'|?????|', nq'|Pairu no Mi|', nq'|Baie Nanana|', nq'|Sananabeere|', nq'|Baccananas|', nq'|Baya Pinia|', nq'|????|', nq'|Pine Yeolmae|', nq'|???|', nq'|Hu�ngl� Guo / W�hngl�ih Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Enigmatic Card|', 7 , q'|Allows the player to enter Looker and Anabel's motel room on Route 8.|' , nq'|???????|', nq'|Ayashi Card|', nq'|Message Myst�re|', nq'|Seltsame Karte|', nq'|Lettera segreta|', nq'|Nota Intrigante|', nq'|?????|', nq'|Goesanghan Card|', nq'|???? / ????|', nq'|Q�y� Kapi�n / K�ihyih Kaatp�n|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|D-Disk|', 3 , q'|Moves the UFO in The Under downward into Deep Colosseum.|' , nq'|D-????|', nq'|D-Disk|', nq'|Disque-B|', nq'|U-Disc|', nq'|Disco Gi�|', nq'|Disco B|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Helix Fossil|', 1 , q'|A Fossil from which an Omanyte can be resurrected.|' , nq'|??????|', nq'|Kai no Kaseki|', nq'|Fossile Nautile|', nq'|Helixfossil|', nq'|Helixfossile|', nq'|F�sil Helix|', nq'|????|', nq'|Jogae Hwaseok|', nq'|???? / ????|', nq'|B�ik� Hu�sh� / Buihok Fasehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Nomel Berry|', 3 , q'|Pok�block and Poffin ingredient.|' , nq'|?????|', nq'|Nomel no Mi|', nq'|Baie Tronci|', nq'|Tronzibeere|', nq'|Baccalemon|', nq'|Baya Monli|', nq'|????|', nq'|Nomel Yeolmae|', nq'|??? / ???|', nq'|M�ngn�ng Guo / Mungn�hng Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Azure Flute|', 4 , q'|Key Item used to access the Hall of Origin and face Arceus.|' , nq'|???????|', nq'|Tenkai no Fue|', nq'|Fl�te Azur|', nq'|Azurfl�te|', nq'|Flauto Cielo|', nq'|Flauta Azur|', nq'|??? ??|', nq'|Cheongye-ui Piri|', nq'|????|', nq'|Tianji�-zhi D� / Tingaai-ji Dehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Cologne Case|', 3 , q'|Holds Scents.|' , nq'|??????|', nq'|Cologne Case|', nq'|Boite a Parfums|', nq'|Essenz-Kiste|', nq'|Portaolio|', nq'|Caja Aromas|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Fist Plate|', 4 , q'|Raises the power of Fighting-type moves.|' , nq'|????????|', nq'|Kobushi no Pureto|', nq'|Plaque Poing|', nq'|Fausttafel|', nq'|Lastrapugno|', nq'|Tabla Fuerte|', nq'|??????|', nq'|Jumeok Plate|', nq'|???? / ????|', nq'|Qu�nt�u Sh�ban / Ky�hnt�uh Sehkb�an|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Light Stone|', 5 , q'|Stone used to revive Reshiram|' , nq'|???????|', nq'|Light Stone|', nq'|Galet Blanc|', nq'|Lichtstein|', nq'|Chiarolite|', nq'|Orbe Claro|', nq'|?????|', nq'|Light Stone|', nq'|???|', nq'|Guangm�ng Sh� / Gwongm�hng Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Steel Gem|', 5 , q'|Increases the power of the holder's first Steel-type move by 50%, and is consumed after use.|' , nq'|????????|', nq'|Hagane no Jewel|', nq'|Joyau Acier|', nq'|Stahljuwel|', nq'|Bijouacciaio|', nq'|Gema Acero|', nq'|????|', nq'|Gangcheol Jewel|', nq'|???? / ????|', nq'|Gang-zhi Baosh� / Gong-ji B�usehk|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|ID Card|', 3 , q'|Permits access to a restricted elevator at the Cipher Lab.|' , nq'|ID???|', nq'|ID Card|', nq'|Badge|', nq'|ID-Karte|', nq'|Tessera|', nq'|Tarjeta ID|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Icium Z|', 7 , q'|Allows a Pok�mon to upgrade their Ice-type damaging moves to the Z-Move Subzero Slammer or upgrade their Ice-type status moves into Z-Moves. Makes Arceus an Ice-type Pok�mon.|' , nq'|???Z|', nq'|Ice-Z|', nq'|Cryoz�lite|', nq'|Glacium Z|', nq'|Glacium Z|', nq'|Criostal Z|', nq'|??Z|', nq'|Eol-eum-Z|', nq'|?Z|', nq'|Bing-Z / Bing-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Holo Caster|', 6 , q'|Allows the player to view hologram clips and communicate with others.|' , nq'|???????|', nq'|Holo Caster|', nq'|Holokit|', nq'|Holo-Log|', nq'|Holovox|', nq'|Holomisor|', nq'|?????|', nq'|Holo Caster|', nq'|???????*|'||chr(10)||nq'|???????|', nq'|Qu�nxi�ng T�uying Tongx�n Q� / Chy�hnjeuhng T�uhy�ng Tungseun Hei*|'||chr(10)||nq'|Qu�nxi Yingxi�ng Tongx�n Q�|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Ground Memory|', 7 , q'|Makes Silvally a Ground-type Pok�mon and makes Multi-Attack a Ground-type move.|' , nq'|????????|', nq'|Ground Memory|', nq'|ROM Sol|', nq'|Boden-Disc|', nq'|ROM Terra|', nq'|Disco Tierra|', nq'|???????|', nq'|Ground Memory|', nq'|?????*|'||chr(10)||nq'|?????|', nq'|D�d� J�y�di� / Daaihdeih Geiyikdihp*|'||chr(10)||nq'|D�d� C�nchudi�|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Yellow Flute|', 3 , q'|Snaps a Pok�mon out of Confusion.RSEFRLGColoXDDPPtHGSSORAS Can be sold for 7500.BWB2W2|' , nq'|???????|', nq'|Kiiro Vidro|', nq'|Fl�te Jaune|', nq'|Gelbe Fl�te|', nq'|Flauto Giallo|', nq'|Flauta Amarilla|', nq'|?????|', nq'|Norang Vidro|', nq'|????? / ?????|', nq'|Hu�ng-s� Bol� Sh�o / W�hng-sik Bol�ih Saau|', 176 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Shadow Mail|', 3 , q'|Mail with a picture of Duskull. To be held by a Pok�mon for delivery.|' , nq'|???????|', nq'|Shadow Mail|', nq'|Lettre Ombre|', nq'|Dunkelbrief|', nq'|Mess. Ombra|', nq'|Carta Sombra|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Ice Memory|', 7 , q'|Makes Silvally a Ice-type Pok�mon and makes Multi-Attack a Ice-type move.|' , nq'|??????|', nq'|Ice Memory|', nq'|ROM Glace|', nq'|Eis-Disc|', nq'|ROM Ghiaccio|', nq'|Disco Hielo|', nq'|??????|', nq'|Ice Memory|', nq'|?????*|'||chr(10)||nq'|?????|', nq'|Bingxue J�y�di� / Bingsyut Geiyikdihp*|'||chr(10)||nq'|Bingxue C�nchudi�|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Metal Powder|', 2 , q'|Raises Ditto's Defense.|' , nq'|???????|', nq'|Metal Powder|', nq'|Poudre Metal|', nq'|Metallstaub|', nq'|Metalpolvere|', nq'|Polvo Met�lico|', nq'|?????|', nq'|Geumsok Powder|', nq'|??? / ???|', nq'|Jinshu Fen / Gamsuhk F�n|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Cherish Ball|', 4 , q'|A special type of Pok� Ball in which event Pok�mon are usually distributed.|' , nq'|????????|', nq'|Precious Ball|', nq'|M�moire Ball|', nq'|Jubelball|', nq'|Pregio Ball|', nq'|Gloria Ball|', nq'|?????|', nq'|Precious Ball|', nq'|??? / ???|', nq'|Gu�zh�ng Qi� / Gwaijuhng K�uh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Magnet|', 2 , q'|Raises the power of Electric-type moves.|' , nq'|????|', nq'|Jishaku|', nq'|Aimant|', nq'|Magnet|', nq'|Calamita|', nq'|Im�n|', nq'|??|', nq'|Jaseok|', nq'|?? / ??|', nq'|C�tie / Ch�htit|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Grass Gem|', 5 , q'|Increases the power of the holder's first Grass-type move by 50%, and is consumed after use.|' , nq'|???????|', nq'|Kusa no Jewel|', nq'|Joyau Plante|', nq'|Pflanzenjuwel|', nq'|Bijouerba|', nq'|Gema Planta|', nq'|???|', nq'|Pul Jewel|', nq'|???? / ????|', nq'|Cao-zhi Baosh� / Ch�u-ji B�usehk|', 80 );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|X Speed 6|', 5 , q'|Immensely raises a Pok�mon's Speed. Wonder Launcher only.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|X Defend 2|', 5 , q'|Sharply raises a Pok�mon's Defense. Wonder Launcher only.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Sun Flute|', 7 , q'|Used to evolve Nebby into Solgaleo at the Altar of the Sunne.|' , nq'|???????|', nq'|Taiyo no Fue|', nq'|Fl�te du Soleil|', nq'|Sonnenfl�te|', nq'|Flauto solare|', nq'|Flauta Solar|', nq'|?????|', nq'|Taeyang Uipili|', nq'|???? / ????|', nq'|T�iy�ng-zhi D� / Taaiy�uhng-ji Dehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Green Scarf|', 3 , q'|Raises the Clever condition.|' , nq'|????????|', nq'|Midori no Bandana|', nq'|Foul. Vert|', nq'|Gr�ner Schal|', nq'|Fascia Verde|', nq'|Pa�uelo Verde|', nq'|????|', nq'|Chorok Band|', nq'|???? / ????|', nq'|Lu-s� T�ujin / Luhk-sik T�uhgan|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lost Item|', 2 , q'|Return to Copycat for access to Magnet Train.|' , nq'|?????|', nq'|Otoshi Mono|', nq'|Poup�e perdue|', nq'|Fundsache|', nq'|Strumento Perso|', nq'|Obj. Perdido|', nq'|???|', nq'|Bunsilmul|', nq'|??? / ???|', nq'|Y�shi W� / W�ihsat Maht|', 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( q'|Roto Bargain|' , nq'|??????|', nq'|Yasu'uri Pon|', nq'|Moti-Promo|', nq'|Schn�ppchenbon|', nq'|Sconto'n'roll|', nq'|Cup�n Rebaja|', nq'|�???|', nq'|�???|', nq'|???? / ????|', nq'|Youhu� P�ngp�ng / Yauwaih Pungpung|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Premier Ball|', 3 , q'|A Pok� Ball with special coloring. The Pok� Mart cashier will give one to the player for free if ten or more standard Pok� Balls are purchased.|' , nq'|???????|', nq'|Premier Ball|', nq'|Honor Ball|', nq'|Premierball|', nq'|Premier Ball|', nq'|Honor Ball|', nq'|?????|', nq'|Premier Ball|', nq'|??? / ???|', nq'|J�ni�n Qi� / G�inihm K�uh|', 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( q'|Roto Friendship|' , nq'|?????|', nq'|Natsuki Pon|', nq'|Moti-C�ur|', nq'|Freundschaftsbon|', nq'|Affetto'n'roll|', nq'|Cup�n Amistad|', nq'|�???|', nq'|�???|', nq'|???? / ????|', nq'|Qinm� P�ngp�ng / Chanmaht Pungpung|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Water Stone|', 1 , q'|Can be used to evolve Poliwhirl into Poliwrath, Shellder into Cloyster, Staryu into Starmie, Eevee into Vaporeon, Lombre into Ludicolo, and Panpour into Simipour.|' , nq'|?????|', nq'|Mizu no Ishi|', nq'|Pierre Eau|', nq'|Wasserstein|', nq'|Pietraidrica|', nq'|Piedra Agua|', nq'|???|', nq'|Murui Dol|', nq'|???|', nq'|Shui-zhi Sh� / S�ui-ji Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Moon Flute|', 7 , q'|Used to evolve Nebby into Lunala at the Altar of the Moone.|' , nq'|?????|', nq'|Tsuki no Fue|', nq'|Fl�te de la Lune|', nq'|Mondfl�te|', nq'|Flauto lunare|', nq'|Flauta Lunar|', nq'|????|', nq'|Dal Uipili|', nq'|????|', nq'|Yu�li�ng-zhi D� / Yuhtleuhng-ji Dehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Red Flute|', 3 , q'|Snaps a Pok�mon out of attraction.RSEFRLGColoXDDPPtHGSS Can be sold for 7500.BWB2W2|' , nq'|???????|', nq'|Akai Vidro|', nq'|Fl�te Rouge|', nq'|Rote Fl�te|', nq'|Flauto Rosso|', nq'|Flauta Roja|', nq'|?????|', nq'|Ppalgang Vidro|', nq'|????? / ?????|', nq'|H�ngs� Bol� Sh�o / H�hng-sik Bol�ih Saau|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dream Ball|', 5 , q'|Used to catch Pok�mon in Entralink.|' , nq'|???????|', nq'|Dream Ball|', nq'|R�ve Ball|', nq'|Traumball|', nq'|Dream Ball|', nq'|Ensue�o Ball|', nq'|???|', nq'|Dream Ball|', nq'|??? / ???|', nq'|M�ngj�ng Qi� / Muhngg�ng K�uh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Sun Shard|', 3 , q'|Allows Eevee to evolve into Espeon.|' , nq'|????????|', nq'|Taiyo no Kakera|', nq'|Eclat Soleil|', nq'|Sonnsplitter|', nq'|Coccio Solare|', nq'|�pice Sol|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Ring Target|', 5 , q'|The holder loses its type immunities.|' , nq'|??????|', nq'|Nerai no Mato|', nq'|Point de Mire|', nq'|Zielscheibe|', nq'|Facilsaglio|', nq'|Blanco|', nq'|????|', nq'|Gyeonyang Pyojeok|', nq'|?? / ??|', nq'|Biaoba / Biub�|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Krane Memo 4|', 3 , q'|Contains information about purification.|' , nq'|??????4|', nq'|Krane Memo 4|', nq'|Memo Syrus 4|', nq'|Klein-Memo 4|', nq'|Appunti 4|', nq'|Parte C�o 4|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Rawst Berry|', 3 , q'|Cures a burn.|' , nq'|?????|', nq'|Chigo no Mi|', nq'|Baie Fraive|', nq'|Fragiabeere|', nq'|Baccafrago|', nq'|Baya Safre|', nq'|????|', nq'|Bokbun Yeolmae|', nq'|???|', nq'|M�im�i Guo / M�ihm�ih Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Watmel Berry|', 3 , q'|Pok�block and Poffin ingredient.|' , nq'|?????|', nq'|Kaisu no Mi|', nq'|Baie Stekpa|', nq'|Wasmelbeere|', nq'|Baccacomero|', nq'|Baya Sambia|', nq'|????|', nq'|Syubak Yeolmae|', nq'|???|', nq'|Guaxi Guo / Gwasai Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Kommonium Z|', 7 , q'|Allows Kommo-o to upgrade Clanging Scales to the special Z-Move Clangorous Soulblaze.|' , nq'|??????Z|', nq'|Jararanga-Z|', nq'|�ka�z�lite|', nq'|Grandirasium Z|', nq'|Kommonium Z|', nq'|Kommostal Z|', nq'|?????Z|', nq'|Jjaranggougeo-Z|', nq'|?????Z / ?????Z|', nq'|Zh�ngweil�njial�ng-Z / Jeuhngm�ihl�uhngaapl�hng-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|HMs|', 1 , q'|Can be used to teach a field move to a Pok�mon. HMs will not break up after use and as such can be used over and over again.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dark Gem|', 5 , q'|Increases the power of the holder's first Dark-type move by 50%, and is consumed after use.|' , nq'|???????|', nq'|Aku no Jewel|', nq'|Joyau T�n�bres|', nq'|Unlichtjuwel|', nq'|Bijoubuio|', nq'|Gema Siniestra|', nq'|???|', nq'|Ak Jewel|', nq'|???? / ????|', nq'|�-zhi Baosh� / Ok-ji B�usehk|', 144 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Pink Bow|', 2 , q'|Raises the power of Normal-type moves.|' , nq'|???????|', nq'|Pink no Ribbon|', nq'|Ruban Rose|', nq'|Rosa Band|', nq'|Fiocco Rosa|', nq'|Lazo Rosa|', nq'|?????|', nq'|Pink-bit Ribon|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Soul Dew|', 3 , q'|Increases the power of Psychic-type and Dragon-type moves used by Latias and Latios by 20%. (Raises the Special Attack and Special Defense of Latias and Latios before Gen. VII).|' , nq'|???????|', nq'|Kokoro no Shizuku|', nq'|Ros�e �me|', nq'|Seelentau|', nq'|Cuorugiada|', nq'|Roc�o Bondad|', nq'|??????|', nq'|Ma-eumui Mulbang-ul|', nq'|????|', nq'|Xin-zhi Shuidi / Sam-ji S�uidihk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Choice Scarf|', 4 , q'|Raises user's Speed, but they can only use one move.|' , nq'|????????|', nq'|Kodawari Scarf|', nq'|Mouchoir Choix|', nq'|Wahlschal|', nq'|Stolascelta|', nq'|Pa�uelo Elegido|', nq'|?????|', nq'|Guae Scarf|', nq'|???? / ????|', nq'|Jiangji� W�ijin / G�nggau W�ihgan|', 144 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Enigma Stone|', 4 , q'|Allows for the capture of either Latias or Latios.|' , nq'|????????|', nq'|Nazo no Suisho|', nq'|Myst�cristal|', nq'|Mytokristall|', nq'|Misticristal|', nq'|Misticristal|', nq'|???????|', nq'|Susukkekki-ui Sujeong|', nq'|???? / ????|', nq'|M�-zhi Shuijing / M�ih-ji S�uijing|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Wepear Berry|', 3 , q'|Pok�block and Poffin ingredient.|' , nq'|?????|', nq'|Seshina no Mi|', nq'|Baie Repoi|', nq'|Nirbebeere|', nq'|Baccapera|', nq'|Baya Peragu|', nq'|????|', nq'|Seobae Yeolmae|', nq'|???|', nq'|Xil� Guo / Sail�ih Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dusk Ball|', 4 , q'|A type of Pok� Ball that works especially well in dark places such as caves or at night.|' , nq'|??????|', nq'|Dark Ball|', nq'|Sombre Ball|', nq'|Finsterball|', nq'|Scuro Ball|', nq'|Ocaso Ball|', nq'|???|', nq'|Dark Ball|', nq'|???|', nq'|Hei'�n Qi� / Hakam K�uh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Blastoisinite|', 6 , q'|Allows Blastoise to Mega Evolve into Mega Blastoise.|' , nq'|????????|', nq'|Kamexnite|', nq'|Tortankite|', nq'|Turtoknit|', nq'|Blastoisite|', nq'|Blastoisita|', nq'|??????|', nq'|Geobugwangnite|', nq'|?????? / ??????|', nq'|Shuiji�ngui J�nhu� Sh� / S�uijingwai Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Blue Flute|', 3 , q'|Awakens sleeping Pok�mon when used, can be used an unlimited number of times. May be used in battle or in the field.RSEFRLGColoXDDPPtHGSSORAS Can be sold for 7000.BWB2W2|' , nq'|???????|', nq'|Aoi Vidro|', nq'|Fl�te Bleue|', nq'|Blaue Fl�te|', nq'|Flauto Blu|', nq'|Flauta Azul|', nq'|?????|', nq'|Parang Vidro|', nq'|????? / ?????|', nq'|L�n-s� Bol� Sh�o / L�ahm-sik Bol�ih Saau|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pok� Flute|', 1 , q'|Awakens sleeping Pok�mon.|' , nq'|???????|', nq'|Pok�mon no Fue|', nq'|Pok�flute|', nq'|Pok�fl�te|', nq'|Pok�flauto|', nq'|Pok� Flauta|', nq'|?????|', nq'|Pocketmon Piri|', nq'|????? / ?????|', nq'|Baokem�ng-zhi D� / B�uh�muhng-ji Dehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Safety Goggles|', 6 , q'|Grants the holder immunity to weather-related damage and powder moves.|' , nq'|????????|', nq'|Bojin Goggle|', nq'|Lunettes Filtre|', nq'|Schutzbrille|', nq'|Visierantisabbia|', nq'|Gafa Protectora|', nq'|????|', nq'|Bangjin Goggle|', nq'|????? / ?????|', nq'|F�ngch�n H� M�j�ng / F�hngch�hn Wuh Muhkgeng|', 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( q'|Rage Candy Bar|' , nq'|????????|', nq'|Ikari Manju|', nq'|Bonbon Rage|', nq'|Wutkeks|', nq'|Iramella|', nq'|Caram. Furia|', nq'|???????|', nq'|Bunno-ui Hodugwaja|', nq'|???? / ????|', nq'|F�nn� M�ntou / F�hnnouh M�ahnt�uh|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Salac Berry|', 3 , q'|Raises Speed when HP is below ? of maximum.|' , nq'|?????|', nq'|Camula no Mi|', nq'|Baie Sailak|', nq'|Salkabeere|', nq'|Baccasalak|', nq'|Baya Aslac|', nq'|????|', nq'|Kamra Yeolmae|', nq'|??? / ???|', nq'|Shal�n Guo / Sal�uhn Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Kebia Berry|', 4 , q'|Lowers effectiveness of a super effective Poison-type move.|' , nq'|?????|', nq'|Biah no Mi|', nq'|Baie K�bia|', nq'|Grarzbeere|', nq'|Baccakebia|', nq'|Baya Kebia|', nq'|????|', nq'|Eureum Yeolmae|', nq'|???|', nq'|Tongtong Guo / Tungtung Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pass|', 2 , q'|Allows the player to ride the Magnet Train between Saffron City, Kanto; and Goldenrod City, Johto.|' , nq'|?????|', nq'|Linear Pass|', nq'|Passe Train|', nq'|Fahrschein|', nq'|Superpass|', nq'|Magnetopase|', nq'|?????|', nq'|Linear Pass|', nq'|????|', nq'|D�ngqi Yu�pi�o / Dihngk�ih Yuhtpiu|', 956 );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|X Attack 3|', 5 , q'|Drastically raises a Pok�mon's Attack. Wonder Launcher only.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Devon Scope|', 3 , q'|Reveals hidden Pok�mon.|' , nq'|???????|', nq'|Devon Scope|', nq'|Devon Scope|', nq'|Devon-Scope|', nq'|Devonscopio|', nq'|Detector Devon|', nq'|?????|', nq'|Devon Scope|', nq'|????? / ?????|', nq'|D�w�n Zhenc�j�ng / Dakm�hn Jingchakgeng|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dark Stone|', 5 , q'|Stone used to summon Zekrom.|' , nq'|???????|', nq'|Dark Stone|', nq'|Galet Noir|', nq'|Dunkelstein|', nq'|Scurolite|', nq'|Orbe Oscuro|', nq'|????|', nq'|Dark Stone|', nq'|??? / ???|', nq'|Hei'�n Sh� / Hakam Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Clear Bell|', 2 , q'|Summons SuicuneC or Ho-OhHGOR.|' , nq'|???????|', nq'|Tomei-na Suzu|', nq'|Glas Transparent|', nq'|Klarglocke|', nq'|Campana Chiara|', nq'|Campana Clara|', nq'|??????|', nq'|Crystal Bang-ul|', nq'|???? / ????|', nq'|T�um�ng L�ngdang / Taum�hng L�hngdong|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Spooky Plate|', 4 , q'|Raises the power of Ghost-type moves.|' , nq'|????????|', nq'|Mononoke Pureto|', nq'|Plaque Fant�|', nq'|Spuktafel|', nq'|Lastratetra|', nq'|Tabla Terror|', nq'|??????|', nq'|Wollyeong Plate|', nq'|????|', nq'|Yaogu�i Sh�ban / Yiugwaai Sehkb�an|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Sail Fossil|', 6 , q'|A Fossil from which an Amaura can be resurrected.|' , nq'|??????|', nq'|Hire no Kaseki|', nq'|Fossile Nageoire|', nq'|Flossenfossil|', nq'|Fossilpinna|', nq'|F�sil Aleta|', nq'|??????|', nq'|Jineuleomi Hwaseok|', nq'|???? / ????|', nq'|Q�-zhi Hu�sh� / K�ih-ji Fasehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Stick|', 2 , q'|Raises Farfetch'd's critical hit ratio.|' , nq'|????|', nq'|Naganegi|', nq'|Baton|', nq'|Lauchstange|', nq'|Gambo|', nq'|Palo|', nq'|??|', nq'|Daepa|', nq'|?? / ??|', nq'|D�cong / Daaihchung|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Harbor Mail|', 3 , q'|Mail with a nautical design. To be held by a Pok�mon for delivery.|' , nq'|???????|', nq'|Harbor Mail|', nq'|Lettre Port|', nq'|Hafenbrief|', nq'|Mess. Porto|', nq'|Carta Puerto|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Tapunium Z|', 7 , q'|Allows the guardian deities to upgrade Nature's Madness to the special Z-Move Guardian of Alola.|' , nq'|??Z|', nq'|Kapu-Z|', nq'|Tokoz�lite|', nq'|Kapium Z|', nq'|Tapium Z|', nq'|Tapistal Z|', nq'|??Z|', nq'|Kapu-Z|', nq'|??Z|', nq'|Kap�-Z / Kapok-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Shed Shell|', 4 , q'|Allows the holder to escape from battle.|' , nq'|????????|', nq'|Kirei-na Nukegara|', nq'|Carapace Mue|', nq'|Wechselh�lle|', nq'|Disfoguscio|', nq'|Muda Concha|', nq'|??????|', nq'|Areumdaun Heomul|', nq'|???? / ????|', nq'|Meil� Kongk� / M�ihlaih Hunghok|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Mosaic Mail|', 4 , q'|Mail with a rainbow pattern. To be held by a Pok�mon for delivery.|' , nq'|???????|', nq'|Mosaic Mail|', nq'|Lettremosaik|', nq'|Mosaikbrief|', nq'|Mess. Iride|', nq'|Car. Mosaico|', nq'|??????|', nq'|Mosaic Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Marshadium Z|', 7 , q'|Allows Marshadow to upgrade Spectral Thief to the special Z-Move Soul-Stealing 7-Star Strike.|' , nq'|??????Z|', nq'|Marshadow-Z|', nq'|Marshadoz�lite|', nq'|Marshadownium Z|', nq'|Marshadium Z|', nq'|Marshastal Z|', nq'|???Z|', nq'|Masyado-Z|', nq'|???Z / ???Z|', nq'|Maxi�duo-Z / M�hahdo-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Exp. Share|', 1 , q'|A held item that allows Pok�mon to gain experience without battling.|', q'|Named Exp.All prior to Generation II.|', nq'|????????|', nq'|Gakushu Sochi|', nq'|Multi Exp|', nq'|EP-Teiler|', nq'|Condividi Esp.|', nq'|Repartir Exp|', nq'|????|', nq'|Hakseup Jangchi|', nq'|???? / ????|', nq'|Xu�x� Zhuangzh� / Hohkjaahp Jongji|', 1056 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Razor Claw|', 4 , q'|Raises the chance of getting a critical hit. Allows Sneasel to evolve at night.|' , nq'|??????|', nq'|Surudoi Tsume|', nq'|Griffe Rasoir|', nq'|Scharfklaue|', nq'|Affilartigli|', nq'|Garra Afilada|', nq'|?????|', nq'|Yerihan Sontop|', nq'|???? / ????|', nq'|Ru�l�-zhi Zhua / Yeuihleih-ji J�au|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Prop Case|', 5 , q'|Used to hold Props for the Pok�mon Musical.|' , nq'|??????|', nq'|Goods Case|', nq'|Bo�te Parure|', nq'|Deko-Box|', nq'|Portagadget|', nq'|Neceser|', nq'|?????|', nq'|Goods Case|', nq'|???|', nq'|W�pin Xiang / Mahtb�n Seung|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Fluffy Tail|', 3 , q'|Allows the player to flee from any wild Pok�mon battle.|' , nq'|???????|', nq'|Eneco no Shippo|', nq'|Queue Skitty|', nq'|Eneco-Rute|', nq'|Coda Skitty|', nq'|Cola Skitty|', nq'|?????|', nq'|Enabi Kkori|', nq'|??????|', nq'|Xi�ngweimiao-de Weiba/Xi�ngweimiao-de Yiba / Heungm�ihmiu-dik M�ihba|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|SquirtBottle|', 2 , q'|Used to bring Sudowoodo out of hiding.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|RSVP Mail|', 5 , q'|Stationary designed for invitations. To be held by a Pok�mon for delivery.|' , nq'|???????|', nq'|Osasoi Mail|', nq'|Lettre Invit|', nq'|Einladebrief|', nq'|Mess. Invito|', nq'|C. Invitar|', nq'|????|', nq'|Gweon'yu Mail|', nq'|???? / ????|', nq'|Yaoqing Y�uji�n / Yiuch�ng Y�uhg�n|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Macho Brace|', 2 , q'|Raises Effort values but lowers Speed.|' , nq'|????????|', nq'|Kyosei Gips|', nq'|Bracelet Macho|', nq'|Machoband|', nq'|Crescicappa|', nq'|Brazal Firme|', nq'|????|', nq'|Gyojeong Gips|', nq'|????? / ?????|', nq'|Qi�ngzh� Du�nli�nq� / K�uhngjai Dyunlihnhei|', 144 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lava Cookie|', 3 , q'|Cures any status condition.|' , nq'|???????|', nq'|Fuen Senbei|', nq'|Lava Cookie|', nq'|Lavakeks|', nq'|Lavottino|', nq'|Galleta Lava|', nq'|????|', nq'|Yong-am Jeonbyeong|', nq'|???? / ????|', nq'|Fuy�n Xianb�i / F�y�hm Sinbui|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lure Ball|', 2 , q'|A type of Pok� Ball that works best on Pok�mon caught using a rod.|' , nq'|??????|', nq'|Lure Ball|', nq'|Appat Ball|', nq'|K�derball|', nq'|Esca Ball|', nq'|Cebo Ball|', nq'|???|', nq'|Lure Ball|', nq'|??? / ???|', nq'|Y�u'er Qi� / Y�uhneih K�uh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Expert Belt|', 4 , q'|Increases the power of super effective moves.|' , nq'|???????|', nq'|Tatsujin no Obi|', nq'|Ceinture Pro|', nq'|Expertengurt|', nq'|Abilcintura|', nq'|Cinta Experto|', nq'|????|', nq'|Darinui Tti|', nq'|??? / ???|', nq'|D�r�n D�i / Daahty�hn Daai|', 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( q'|Photo Album|' , nq'|???????|', nq'|Photo Album|', nq'|Album Photo|', nq'|Fotoalbum|', nq'|Album|', nq'|�lbum|', nq'|????|', nq'|Photo Album|', nq'|??*|'||chr(10)||nq'|??|', nq'|Xi�ngb� / S�ungb�u*|'||chr(10)||nq'|Xi�ngc�|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Sea Incense|', 3 , q'|Raises the power of Water-type moves. A Marill or Azumarill holding this can breed to produce Azurill Eggs.|' , nq'|???????|', nq'|Ushio no Okou|', nq'|Encens Mer|', nq'|Seerauch|', nq'|Marearoma|', nq'|Incienso marino|', nq'|?????|', nq'|Badasmul Hyangno|', nq'|????|', nq'|Haich�o Xunxiang / H�ich�uh Fanheung|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Muscle Wing|', 5 , q'|Raises the Attack of a Pok�mon.|' , nq'|????????|', nq'|Kinryoku no Hane|', nq'|Aile Force|', nq'|Kraftfeder|', nq'|Piumpotenza|', nq'|Pluma M�sculo|', nq'|????|', nq'|Geunryeok Nalgae|', nq'|????|', nq'|Jil�-zhi Yu / Geilihk-ji Y�h|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Honey|', 4 , q'|Can be slathered on orange trees to attract rare Pok�mon; or used in grass to attract wild Pok�mon the same way Sweet Scent does.|' , nq'|?????|', nq'|Amai Mitsu|', nq'|Miel|', nq'|Honig|', nq'|Miele|', nq'|Miel|', nq'|????|', nq'|Dalkomhan Kkul|', nq'|???|', nq'|Ti�nti�n M� / T�hmt�hm Maht|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Decidium Z|', 7 , q'|Allows Decidueye to upgrade Spirit Shackle to the special Z-Move Sinister Arrow Raid.|' , nq'|??????Z|', nq'|Junaiper-Z|', nq'|Arch�z�lite|', nq'|Silvarronium Z|', nq'|Deciduenium Z|', nq'|Dueyestal Z|', nq'|?????Z|', nq'|Mokeunaipeo-Z|', nq'|????Z / ????Z|', nq'|Jush�sh�xiao-Z / Jeuisehsyuhhiu-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Journal|', 4 , q'|Keeps track of events and accomplishments of the player.|' , nq'|???????|', nq'|Boken Note|', nq'|Journal|', nq'|Tagebuch|', nq'|Agenda|', nq'|Diario|', nq'|????|', nq'|Moheom Note|', nq'|???? / ????|', nq'|M�oxian Bij� / Mouhh�m Batgei|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Reset Urge|', 5 , q'|Eliminates stat changes from an ally Pok�mon. Wonder Launcher only.|' , nq'|???????|', nq'|Flat Call|', nq'|R�amor�age|', nq'|Umkehrappell|', nq'|Ripristino|', nq'|Quitaestado|', nq'|???|', nq'|Flat Call|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Orange Mail|', 3 , q'|Mail with a Zigzagoon print. To be held by a Pok�mon for delivery.|' , nq'|???????|', nq'|Orange Mail|', nq'|Lettre Oranj|', nq'|Zigzagbrief|', nq'|Mess. Agrume|', nq'|Carta Naranja|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Max Potion|', 1 , q'|Restores all of a Pok�mon's HP.|' , nq'|????????|', nq'|Mantan no Kusuri|', nq'|Potion Max|', nq'|Top-Trank|', nq'|Pozione Max|', nq'|M�xima Poci�n|', nq'|????|', nq'|Full Hoebok Yak|', nq'|??? / ???|', nq'|Qu�nman Y�o / Chy�hnm�hn Yeuhk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Amulet Coin|', 2 , q'|Doubles the earned money after a battle against a Trainer.|' , nq'|???????|', nq'|Omamori Koban|', nq'|Piece Rune|', nq'|M�nzamulett|', nq'|Monetamuleto|', nq'|Moneda Amuleto|', nq'|????|', nq'|Bujeok Geumhwa|', nq'|???? / ????|', nq'|H�f� Jinb� / Wuhf�h Gambaih|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lemonade|', 1 , q'|Restores 70 HP. (80HP before Gen. VII)|' , nq'|??????|', nq'|Mix au Lait|', nq'|Limonade|', nq'|Limonade|', nq'|Lemonsucco|', nq'|Limonada|', nq'|?????|', nq'|Fruits Milk|', nq'|????|', nq'|Guozhi Ni�nai / Gw�jap Ng�uhn�aih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Incinium Z|', 7 , q'|Allows Incineroar to upgrade Darkest Lariat to the special Z-Move Malicious Moonsault.|' , nq'|?????Z|', nq'|Gaogaen-Z|', nq'|F�linoz�lite|', nq'|Fuegronium Z|', nq'|Incineronium Z|', nq'|Incinostal Z|', nq'|???Z|', nq'|Eoheungyeom-Z|', nq'|?????Z / ?????Z|', nq'|Ch�y�np�oxiaohu-Z / Chiyihmp�auhhaauf�-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Big Nugget|', 5 , q'|Can be sold for 30000.|' , nq'|????????|', nq'|Dekai Kin no Tama|', nq'|Maxi P�pite|', nq'|Riesennugget|', nq'|Granpepita|', nq'|Maxipepita|', nq'|????|', nq'|Keun Geum Guseul|', nq'|????|', nq'|J�d� Jinzhu / Geuihdaaih Gamjyu|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Relic Band|', 5 , q'|Can be sold for 100000 to the villa owner in Undella Town.|' , nq'|???????|', nq'|Kodai no Udewa|', nq'|Vieux Bijou|', nq'|Alter Reif|', nq'|Bracciantico|', nq'|Brazal|', nq'|?????|', nq'|Godae-yi Paljji|', nq'|???? / ????|', nq'|Gud�i Shouzhu� / G�doih S�ujuhk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Green Petal|', 7 , q'|A green petal required to complete Mina's Trial.|' , nq'|????????|', nq'|Midori no Hanabira|', nq'|P�tale Vert|', nq'|Gr�nes Blatt|', nq'|Petalo verde|', nq'|P�talo Verde|', nq'|????|', nq'|Chorok Kkochip|', nq'|???? / ????|', nq'|Lu-s� Huab�n / Luhk-sik Faf�an|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Stable Mulch|', 4 , q'|Extends the time ripened Berries will stay on the plant before falling.|' , nq'|???????|', nq'|Naganaga Koyashi|', nq'|Fertistable|', nq'|Stabilmulch|', nq'|Fertilsaldo|', nq'|Abono Fijador|', nq'|??????|', nq'|Orae-orae Biryo|', nq'|???|', nq'|Jiujiu F�i / G�ug�u F�ih|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Devon Parts|', 3 , q'|To be delivered to Captain Stern.|', q'|Called Devon Goods in Generation III.|', nq'|???????|', nq'|Devon no Nimotsu|', nq'|Pack Devon|', nq'|Devon-Waren|', nq'|Merce Devon|', nq'|Piezas Devon|', nq'|????|', nq'|Devon Hwamul|', nq'|?????|', nq'|D�w�n-de W�pin / Dakm�hn-dik Mahtb�n|', 1024 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Rainbow Flower|', 7 , q'|A rainbow flower created from the Seven Petals obtained from Mina's trial, and required to finish Mina's Trial.|' , nq'|???????|', nq'|Nijiiro no Hana|', nq'|Fleur 7 Couleurs|', nq'|Regenbogenbl�te|', nq'|Fiore arcobaleno|', nq'|Flor Irisada|', nq'|????|', nq'|Mujigae Kkot|', nq'|????|', nq'|H�ng-s�-zhi Hua / H�hng-sik-ji Fa|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Terrain Extender|', 7 , q'|Lengthens duration of Electric Terrain, Psychic Terrain, Grassy Terrain, Misty Terrain, as well as Electric Surge, Psychic Surge, Grassy Surge, and Misty Surge from 5 turns to 8 turns when used by the holder.|' , nq'|???????|', nq'|Ground Coat|', nq'|Champ'Duit|', nq'|Feldbeschichtung|', nq'|Fissacampo|', nq'|Cubresuelos|', nq'|??????|', nq'|Ground Coat|', nq'|???|', nq'|D�d� M� / Daaihdeih Mohk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Antidote|', 1 , q'|Heals the poisoning of a Pok�mon.|' , nq'|????|', nq'|Dokukeshi|', nq'|Antidote|', nq'|Gegengift|', nq'|Antidoto|', nq'|Ant�doto|', nq'|???|', nq'|Haedokje|', nq'|??? / ???|', nq'|Jied�y�o / G�aiduhkyeuhk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Power Band|', 4 , q'|Promotes Special Defense EVs, but lowers Speed in battle.|' , nq'|??????|', nq'|Power Band|', nq'|Bandeau Pouvoir|', nq'|Machtband|', nq'|Vigorbanda|', nq'|Banda Recia|', nq'|????|', nq'|Power Band|', nq'|???? / ????|', nq'|L�li�ng Sh�d�i / Lihkleuhng Chukdaai|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Tamato Berry|', 3 , q'|Raises friendship, but lowers Speed EVs.|' , nq'|?????|', nq'|Matoma no Mi|', nq'|Baie Tamato|', nq'|Tamotbeere|', nq'|Baccamodoro|', nq'|Baya Tamate|', nq'|????|', nq'|Tomang Yeolmae|', nq'|???|', nq'|Qi�fan Guo / K�faan Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Z-Ring|', 7 , q'|Allows the player to use Z-Moves when a Pok�mon is holding an appropriate Z-Crystal. Allows the player to use Mega Evolution after obtaining a Key Stone when a Pok�mon is holding the appropriate Mega Stone.|' , nq'|Z???|', nq'|Z-Ring|', nq'|Bracelet Z|', nq'|Z-Ring|', nq'|Cerchio Z|', nq'|Pulsera Z|', nq'|Z?|', nq'|Z Ring|', nq'|Z?? / Z??|', nq'|Z Shouhu�n / Z S�uw�ahn|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|BridgeMail D|', 5 , q'|Stationary with a red drawbridge print. To be held by a Pok�mon for delivery.|' , nq'|???????H|', nq'|Bridge Mail H|', nq'|Lettre PontY|', nq'|Br�ckbrief M|', nq'|Mess. Libec.|', nq'|C. Puente F|', nq'|?????M|', nq'|Bridge Mail M|', nq'|????H / ????H|', nq'|Qi�oli�ng Y�uji�n H / K�uhl�uhng Y�uhg�n H|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Wide Lens|', 4 , q'|Boosts accuracy of holder by an 110%.|' , nq'|???????|', nq'|Kokaku Lens|', nq'|Loupe|', nq'|Gro�linse|', nq'|Grandelente|', nq'|Lupa|', nq'|????|', nq'|Gwanggak-lens|', nq'|??? / ???|', nq'|Guangjiao J�ng / Gw�nggok Geng|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Subway Key|', 3 , q'|Operates the subway between The Under and the Shadow PKMN Lab.|' , nq'|???????|', nq'|Chikatetsu no Kagi|', nq'|Cle de Contact|', nq'|Zugschl�ssel|', nq'|Chiave Metro|', nq'|Llave Metro|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|King's Rock|', 2 , q'|Slightly increases the chances of inflicting the Flinch condition on the opponent. Allows Slowpoke and Poliwhirl to evolve when traded.|' , nq'|????????|', nq'|Oja no Shirushi|', nq'|Roche Royale|', nq'|King-Stein|', nq'|Roccia Di Re|', nq'|Roca del Rey|', nq'|?????|', nq'|Wang-ui Jingpyoseok|', nq'|???? / ????|', nq'|W�ngzhe-zhi Zh�ng / W�hngj�-ji Jing|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Red Shard|', 3 , q'|Exchangeable for a variety of services.|' , nq'|??????|', nq'|Akai Kakera|', nq'|Tesson Rouge|', nq'|Purpurst�ck|', nq'|Coccio Rosso|', nq'|Parte Roja|', nq'|????|', nq'|Ppalgang Jogak|', nq'|???? / ????|', nq'|H�ngs� Su�pi�n / H�hngsik Seuipin|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Shoal Shell|', 3 , q'|Can be used to make a Shell Bell. Does not have any use in Generation IV. Can be sold to an item maniac in Route 5 for 7000 in Generation V.|' , nq'|????????|', nq'|Asase no Kaigara|', nq'|CoquilleTr�fonds|', nq'|K�stenschale|', nq'|Gusciondoso|', nq'|Concha Cardumen|', nq'|??????|', nq'|Yeoul Jogaekkeopjil|', nq'|???? / ????|', nq'|Qiantan B�ik� / Ch�ntaan Buihok|', 144 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Razor Fang|', 4 , q'|Raises the chance of causing an opponent to flinch. Allows Gligar to evolve at night.|' , nq'|??????|', nq'|Surudoi Kiba|', nq'|Croc Rasoir|', nq'|Scharfzahn|', nq'|Affilodente|', nq'|Colmillo Agudo|', nq'|?????|', nq'|Yerihan Ippal|', nq'|???? / ????|', nq'|Ru�l�-zhi Y� / Yeuihleih-ji Ng�h|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Forage Bag|', 7 , q'|Holds ingredients found during Mallow's trial.|' , nq'|????????|', nq'|Zairyo Bukuro|', nq'|Sac Ingr�dients|', nq'|Zutatenbeutel|', nq'|Portaingredienti|', nq'|Zurr�n|', nq'|?????|', nq'|Jaelyo Jumeoni|', nq'|???|', nq'|C�ili�o D�i / Ch�ihl�u Doih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Aspear Berry|', 3 , q'|Removes the frozen condition from a Pok�mon.|' , nq'|?????|', nq'|Nanashi no Mi|', nq'|Baie Willia|', nq'|Wilbirbeere|', nq'|Baccaperina|', nq'|Baya Perasi|', nq'|????|', nq'|Baeri Yeolmae|', nq'|???|', nq'|L�m� Guo / Leihmuhk Gw�|', 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( q'|Seal Bag|' , nq'|??????|', nq'|Seal Bukuro|', nq'|Sac Sceaux|', nq'|Stickert�te|', nq'|Bollosacca|', nq'|Bolsa Sellos|', nq'|????|', nq'|Seal Jumeoni|', nq'|??? / ???|', nq'|Tiezhi D�i / Tipj� Doih|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Up-Grade|', 2 , q'|A held item which allows Porygon to evolve when traded.|' , nq'|???????|', nq'|Upgrade|', nq'|Am�liorator|', nq'|Up-Grade|', nq'|Upgrade|', nq'|Mejora|', nq'|?????|', nq'|Upgrade|', nq'|????*|'||chr(10)||nq'|????|', nq'|Shengj� Zili�o / Singkap Jil�u*|'||chr(10)||nq'|Shengj� Sh�j�|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Tunnel Mail|', 4 , q'|Mail with a picture of a dark tunnel/mine. To be held by a Pok�mon for delivery.|' , nq'|???????|', nq'|Tunnel Mail|', nq'|Lettre Mine|', nq'|Minenbrief|', nq'|Mess. Tunnel|', nq'|Carta Mina|', nq'|????|', nq'|Tunnel Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lagging Tail|', 4 , q'|Causes the holder to move after the opponent.|' , nq'|????????|', nq'|Koko no Shippo|', nq'|Ralentiqueue|', nq'|Schwerschwf.|', nq'|Rallentocoda|', nq'|Cola Pl�mbea|', nq'|?????|', nq'|Neurimbo Kkori|', nq'|???? / ????|', nq'|H�ugong-zhi Wei/H�ugong-zhi Yi/ Hauhgung-ji M�ih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Cleanse Tag|', 3 , q'|Repels Pok�mon if the holder is first in the party.|' , nq'|???????|', nq'|Kiyome no Ofuda|', nq'|Rune Purifiante|', nq'|Schutzband|', nq'|Velopuro|', nq'|Amuleto|', nq'|?????|', nq'|Sun-gyeorui Bujeok|', nq'|???? / ????|', nq'|Ji�j�ng-zhi F� / Gitjihng-ji F�h|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Persim Berry|', 3 , q'|Cures confusion.|' , nq'|????|', nq'|Ki no Mi|', nq'|Baie Kika|', nq'|Persimbeere|', nq'|Baccaki|', nq'|Baya Caquic|', nq'|????|', nq'|Simmon Yeolmae|', nq'|???|', nq'|Sh�zi Guo / Ch�hj�i Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pamtre Berry|', 3 , q'|Pok�block and Poffin ingredient.|' , nq'|?????|', nq'|Shiya no Mi|', nq'|Baie Palma|', nq'|Pallmbeere|', nq'|Baccapalma|', nq'|Baya Plama|', nq'|????|', nq'|Jaya Yeolmae|', nq'|???|', nq'|Yem� Guo / Y�hmuhk Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|Eggant Berry|', 3 , q'|Cures infatuation status. Will turn into an Enigma Berry if transferred to Generation IV via Pal Park.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Gram 1|', 5 , q'|An important letter which Wingull delivers.|' , nq'|??????1|', nq'|Haitatsubutsu 1|', nq'|Courrier 1|', nq'|Briefpost 1|', nq'|Missiva 1|', nq'|Env�o 1|', nq'|???1|', nq'|Baedalmul 1|', nq'|????1|', nq'|P�is�ng W�pin 1 / Puisung Mahtb�n 1|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Blue Petal|', 7 , q'|A blue petal required to complete Mina's Trial.|' , nq'|???????|', nq'|Ao no Hanabira|', nq'|P�tale Bleu|', nq'|Blaues Blatt|', nq'|Petalo azzurro|', nq'|P�talo Azul|', nq'|????|', nq'|Parang Kkochip|', nq'|???? / ????|', nq'|L�n-s� Huab�n / L�ahm-sik Faf�an|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Ein File F|', 3 , q'|Describes additional details on purification.|' , nq'|???????F|', nq'|Borg File F|', nq'|Dossier Teck F|', nq'|Culpa-Akte A-B|', nq'|Genus.File F|', nq'|Parte Ein: F|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Jaboca Berry|', 4 , q'|If the foe's physical move hits, then the foe will also take damage.|' , nq'|?????|', nq'|Japo no Mi|', nq'|Baie Jacoba|', nq'|Jabocabeere|', nq'|Baccajaba|', nq'|Baya Jaboca|', nq'|????|', nq'|Jabo Yeolmae|', nq'|???|', nq'|Jiazhen Guo / Gajan Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Snorlium Z|', 7 , q'|Allows Snorlax to upgrade Giga Impact to the special Z-Move Pulverizing Pancake.|' , nq'|????Z|', nq'|Kabigon-Z|', nq'|Ronfl�z�lite|', nq'|Relaxonium Z|', nq'|Snorlactium Z|', nq'|Snorlastal Z|', nq'|???Z|', nq'|Jammanbo-Z|', nq'|???Z / ???Z|', nq'|Kabish�u-Z / K�beihsau-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Rabuta Berry|', 3 , q'|Pok�block and Poffin ingredient.|' , nq'|?????|', nq'|Rabuta no Mi|', nq'|Baie Rabuta|', nq'|Rabutabeere|', nq'|Baccambutan|', nq'|Baya Rautan|', nq'|?????|', nq'|Rabutam Yeolmae|', nq'|???|', nq'|Rongdan Guo / Y�hngdaan Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Super Rod|', 1 , q'|Can be used next to or while Surfing on water to encounter high-level wild aquatic Pok�mon.|' , nq'|???????|', nq'|Sugoi Tsurizao|', nq'|Mega Canne|', nq'|Superangel|', nq'|Super Amo|', nq'|Superca�a|', nq'|??????|', nq'|Daedanhan Naksitdae|', nq'|???? / ????|', nq'|L�h�i Di�ogan / Laihhoih Diugon|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Looker Ticket|', 6 , q'|Must find five to advance the plot of the Looker post-game quest.|' , nq'|????????|', nq'|Handsome Ticket|', nq'|Ticket Beladonis|', nq'|LeBelle-Ticket|', nq'|Carta Bellocchio|', nq'|Boleto Handsome|', nq'|????|', nq'|Handsome Ticket|', nq'|??? / ???|', nq'|Shu�ige Qu�n / Seuigo Hyun|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Grn ID Badge|', 3 , q'|One of four keys needed to unlock the north door of Realgam Tower.|' , nq'|ID??????|', nq'|ID Badge Midori|', nq'|Passe Vert|', nq'|Gr�ne ID-Marke|', nq'|Pass Verde|', nq'|Pase Verde|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Spelon Berry|', 3 , q'|Pok�block and Poffin ingredient.|' , nq'|?????|', nq'|Nowaki no Mi|', nq'|Baie Kiwan|', nq'|Kiwanbeere|', nq'|Baccamelos|', nq'|Baya Wikano|', nq'|?????|', nq'|Mehoki Yeolmae|', nq'|???|', nq'|C�jiao Guo / Chigok Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Gear|', 3 , q'|Keeps the Pyrite Town generators going.|' , nq'|????|', nq'|Haguruma|', nq'|Roue Dentee|', nq'|Zahnrad|', nq'|Ingranaggio|', nq'|Rueda|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pink Scarf|', 3 , q'|Raises the Cute condition.|' , nq'|????????|', nq'|Pink no Bandana|', nq'|Foul. Rose|', nq'|Rosa Schal|', nq'|Fascia Rosa|', nq'|Pa�uelo Rosa|', nq'|????|', nq'|Bunhong Band|', nq'|???? / ????|', nq'|Fenh�ng T�ujin / F�nh�hng T�uhgan|', 0 );
insert into ITEMS( NAME, GEN, GEN2, DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Good Rod|', 1, 4, q'|Allows the player to fish for medium-level aquatic Pok�mon.|' , nq'|??????|', nq'|Ii Tsurizao|', nq'|Super Canne|', nq'|Profiangel|', nq'|Amo Buono|', nq'|Ca�a Buena|', nq'|?????|', nq'|Jo-eun Naksitdae|', nq'|??? / ???|', nq'|Hao Di�ogan / H�u Diugon|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Black Flute|', 3 , q'|Repels wild Pok�mon.RSEFRLGDPPtHGSS Can be sold for 8000.BWB2W2 Increases the level of wild Pok�mon by one to three levels.ORAS|' , nq'|???????|', nq'|Kuroi Vidro|', nq'|Fl�te Noire|', nq'|Schw. Fl�te|', nq'|Flauto Nero|', nq'|Flauta Negra|', nq'|?????|', nq'|Geomjeong Vidro|', nq'|?????|', nq'|Hei-s� Bol� Sh�o / Haak-sik Bol�ih Saau|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Yellow Nectar|', 7 , q'|Changes Oricorio to its Pom-Pom Style.|' , nq'|???????|', nq'|Yamabuki no Mitsu|', nq'|Nectar Jaune|', nq'|Gelber Nektar|', nq'|Nettare giallo|', nq'|N�ctar Amarillo|', nq'|????|', nq'|Jinnorang Kkul|', nq'|????? / ?????|', nq'|Jinhu�ng-s� Huam� / Gamw�hng-sik Famaht|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Root Fossil|', 3 , q'|A Fossil from which a Lileep can be resurrected.|' , nq'|???????|', nq'|Nekko no Kaseki|', nq'|Fossile Racine|', nq'|Wurzelfossil|', nq'|Radifossile|', nq'|F�sil Ra�z|', nq'|????|', nq'|Ppuri Hwaseok|', nq'|???? / ????|', nq'|Genzhu�ng Hu�sh� / Ganjohng Fasehk|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Banettite|', 6 , q'|Allows Banette to Mega Evolve into Mega Banette.|' , nq'|????????|', nq'|Juppetanite|', nq'|Branettite|', nq'|Banetteonit|', nq'|Banettite|', nq'|Banettita|', nq'|??????|', nq'|Darkpetnite|', nq'|??????? / ???????|', nq'|Zuzh�uw�w� J�nhu� Sh� / Jojauwawa Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Altarianite|', 6 , q'|Allows Altaria to Mega Evolve into Mega Altaria.|' , nq'|????????|', nq'|Tyltalisnite|', nq'|Altarite|', nq'|Altarianit|', nq'|Altarite|', nq'|Altarianita|', nq'|???????|', nq'|Pavicorinite|', nq'|??????? / ???????|', nq'|Qix�qingniao J�nhu� Sh� / Chatjihkchingn�uh Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Krane Memo 3|', 3 , q'|Contains information about the Snag Machine.|' , nq'|??????3|', nq'|Krane Memo 3|', nq'|Memo Syrus 3|', nq'|Klein-Memo 3|', nq'|Appunti 3|', nq'|Parte C�o 3|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Assault Vest|', 6 , q'|Raises Sp. Def but prevents the use of status moves.|' , nq'|????????|', nq'|Totsugeki Chokki|', nq'|Veste de Combat|', nq'|Offensivweste|', nq'|Corpetto Assalto|', nq'|Chaleco Asalto|', nq'|????|', nq'|Dolgyeok Jokki|', nq'|???? / ????|', nq'|T�j� B�ixin / Dahtgik Buisam|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Elevator Key|', 6 , q'|Activates the elevator in Lysandre Labs.|' , nq'|????????|'||chr(10)||nq'|?????????|', nq'|Elevator Key|'||chr(10)||nq'|Elevator no Key|', nq'|Cle Ascens.*|'||chr(10)||nq'|Cl� Ascenseur|', nq'|Liftkarte*|'||chr(10)||nq'|Liftschl�ssel|', nq'|Chiave Asc.|'||chr(10)||nq'|Chiave ascensore|', nq'|Ll. Ascensor|'||chr(10)||nq'|Llave Ascensor|', nq'|??????|', nq'|Elevator Key|', nq'|???? / ????|', nq'|Di�nti Y�oshi / Dihntai Yeuhks�h|', 192 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Kasib Berry|', 4 , q'|Lowers effectiveness of a super effective Ghost-type move.|' , nq'|?????|', nq'|Kasib no Mi|', nq'|Baie S�dra|', nq'|Zitarzbeere|', nq'|Baccacitrus|', nq'|Baya Drasi|', nq'|????|', nq'|Subul Yeolmae|', nq'|???|', nq'|F�gan Guo / Fahtgam Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Power Herb|', 4 , q'|Allows user to skip first turn of moves that require charging.|' , nq'|???????|', nq'|Powerful Herb|', nq'|Herbe Pouvoir|', nq'|Energiekraut|', nq'|Vigorerba|', nq'|Hierba �nica|', nq'|?????|', nq'|Powerful Herb|', nq'|???? / ????|', nq'|Qi�ngl� Xiangcao / K�uhnglihk Heungch�u|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Safari Ball|', 1 , q'|A type of Pok� Ball to be used in the Safari Zone.|' , nq'|???????|', nq'|Safari Ball|', nq'|Safari Ball|', nq'|Safariball|', nq'|Safari Ball|', nq'|Safari Ball|', nq'|????|', nq'|Safari Ball|', nq'|??? / ???|', nq'|Sh�uli� Qi� / S�ulihp K�uh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Never-Melt Ice|', 2 , q'|Raises the power of Ice-type moves.|', q'|Formatted as NeverMeltIce prior to Generation VI.|', nq'|???????|', nq'|Tokenai Kori|', nq'|Glace �ternelle|', nq'|Ewiges Eis|', nq'|Gelomai|', nq'|Antiderretir|', nq'|??????|', nq'|Nokji Anneun Eoreum|', nq'|???|', nq'|B� R�ng Bing / Bat Y�hng Bing|', 1152 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Yellow Apricorn|', 2 , q'|If taken to Kurt, he will make the player a Moon Ball out of it.|', q'|Formatted as Ylw Apricorn prior to Generation VI.|', nq'|?????|', nq'|Ki Bonguri|', nq'|Noigrume Jne|', nq'|Aprikoko Glb|', nq'|Ghicocca Gialla|', nq'|Bonguri Amarillo|', nq'|?????|', nq'|Norang Gyutori|', nq'|??? / ???|', nq'|Hu�ng Qi�guo / W�hng K�uhgw�|', 1072 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pair of Tickets|', 6 , q'|Allows entry for two to the Mossdeep Space Center for the Litleonid star show.|' , nq'|??????|', nq'|Pair Ticket|', nq'|Ticket Duo|', nq'|Zweierticket|', nq'|Biglietto doppio|', nq'|Entrada para dos|', nq'|????|', nq'|Pair of Tickets|', nq'|??? / ???|', nq'|Shuangr�n Pi�o / Seungy�hn Piu|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Krane Memo 1|', 3 , q'|Contains information about snagging.|' , nq'|??????1|', nq'|Krane Memo 1|', nq'|Memo Syrus 1|', nq'|Klein-Memo 1|', nq'|Appunti 1|', nq'|Parte C�o 1|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Power Weight|', 4 , q'|Promotes HP EVs, but lowers Speed in battle.|' , nq'|???????|', nq'|Power Weight|', nq'|Poids Pouvoir|', nq'|Machtgewicht|', nq'|Vigorpeso|', nq'|Pesa Recia|', nq'|?????|', nq'|Power Weight|', nq'|???? / ????|', nq'|L�li�ng F�zh�ng / Lihkleuhng Fuhch�hng|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|X Sp. Def 3|', 5 , q'|Drastically raises a Pok�mon's Special Defense. Wonder Launcher only.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lucarionite|', 6 , q'|Allows Lucario to Mega Evolve into Mega Lucario.|' , nq'|???????|', nq'|Lucarionite|', nq'|Lucarite|', nq'|Lucarionit|', nq'|Lucarite|', nq'|Lucarita|', nq'|???????|', nq'|Lucarionite|', nq'|??????? / ???????|', nq'|L�kal�'ou J�nhu� Sh� / Louhkaleih'au Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Red Card|', 5 , q'|Forces the opponent to switch to a random Pok�mon when the holder is hit by a contact move. Consumed after use.|' , nq'|??????|', nq'|Red Card|', nq'|Carton Rouge|', nq'|Rote Karte|', nq'|Cartelrosso|', nq'|Tarjeta Roja|', nq'|????|', nq'|Red Card|', nq'|?? / ??|', nq'|H�ngp�i / H�hngp�ai|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pure Incense|', 4 , q'|Causes Chimecho to produce a Chingling Egg at the Pok�mon Day Care. Also lowers wild Pok�mon encounter rate.|' , nq'|???????|', nq'|Kiyome no Oko|', nq'|Encens Pur|', nq'|Scheuchrauch|', nq'|Puroaroma|', nq'|Incienso puro|', nq'|?????|', nq'|Sun-gyeorui Hyangno|', nq'|???? / ????|', nq'|Ji�j�ng Xunxiang / Gitjehng Fanheung|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pearl|', 2 , q'|Can be sold for 3750.|' , nq'|????|', nq'|Shinju|', nq'|Perle|', nq'|Perle|', nq'|Perla|', nq'|Perla|', nq'|??|', nq'|Jinju|', nq'|??|', nq'|Zhenzhu / Janjyu|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lax Incense|', 3 , q'|Lowers the foe's accuracy. A Wobbuffet holding it can breed to produce a Wynaut.|' , nq'|???????|', nq'|Nonki no Okou|', nq'|Encens Doux|', nq'|Laxrauch|', nq'|Distraroma|', nq'|Incienso suave|', nq'|??????|', nq'|Musataepyeong Hyangno|', nq'|???? / ????|', nq'|Youxi�n Xunxiang / Y�uhh�ahn Fanheung|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Berry Pouch|', 3 , q'|Holds Berries.|' , nq'|??????|', nq'|Kinomi Bukuro|', nq'|Sac A Baies|', nq'|Beerent�te|', nq'|Porta Bacche|', nq'|Saco Bayas|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pomeg Berry|', 3 , q'|Makes a Pok�mon more happy, but lowers EVs for HP.|' , nq'|?????|', nq'|Zaroku no Mi|', nq'|Baie Grena|', nq'|Granabeere|', nq'|Baccagrana|', nq'|Baya Grana|', nq'|????|', nq'|Yuseok Yeolmae|', nq'|???|', nq'|Li�sh� Guo / L�uhsehk Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Cheri Berry|', 3 , q'|Heals paralysis.|' , nq'|?????|', nq'|Kurabo no Mi|', nq'|Baie Ceriz|', nq'|Amrenabeere|', nq'|Baccaliegia|', nq'|Baya Zreza|', nq'|????|', nq'|Beochi Yeolmae|', nq'|??? / ???|', nq'|Yingzi Guo / Yingj� Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Works Key|', 4 , q'|Allows player access to the Valley Windworks near Floaroma Town.|' , nq'|????????|', nq'|Hatsudensho Key|', nq'|Cl� Centrale|', nq'|K-Schl�ssel|', nq'|Turbinchiave|', nq'|Ll. Central|', nq'|????|', nq'|Baljeonso Key|', nq'|????? / ?????|', nq'|Fadi�nchang Y�oshi / Faatdihnch�ng Yeuhks�h|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Heart Scale|', 3 , q'|Exchangeable for a variety of services.|' , nq'|???????|', nq'|Heart no Uroko|', nq'|�caille C�ur|', nq'|Herzschuppe|', nq'|Squama Cuore|', nq'|Escama Coraz�n|', nq'|????|', nq'|Heart Bineul|', nq'|???? / ????|', nq'|Xin-zhi L�npi�n / Sam-ji L�uhnpin|', 144 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Maranga Berry|', 6 , q'|Increases Special Defense when hit by a special move.|' , nq'|?????|', nq'|Tarapu no Mi|', nq'|Baie Rangma|', nq'|Tarabeere|', nq'|Baccapane|', nq'|Baya Maranga|', nq'|?????|', nq'|Tarapeu Yeolmae|', nq'|??? / ???|', nq'|Xianglu� Guo / Heungl�h Gw�|', 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( q'|Roto Catch|' , nq'|??????|', nq'|Tsukamae Pon|', nq'|Moti-Capture|', nq'|Fangbon|', nq'|Acchiappa'n'roll|', nq'|Cup�n Captura|', nq'|�???|', nq'|�???|', nq'|????|', nq'|Buzhuo P�ngp�ng / Bouhjuk Pungpung|' );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|Teru-sama|', 2 , q'|A group of dummy items. Unobtainable during normal gameplay.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Resist Wing|', 5 , q'|Raises the Defense of a Pok�mon.|' , nq'|???????|', nq'|Teiko no Hane|', nq'|Aile Armure|', nq'|Abwehrfeder|', nq'|Piumtutela|', nq'|Pluma Aguante|', nq'|?????|', nq'|Jeohangryeok Nalgae|', nq'|????|', nq'|Dik�ng-zhi Yu / D�ikong-ji Y�h|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Tanga Berry|', 3 , q'|Lowers effectiveness of a super effective Bug-type move.|' , nq'|?????|', nq'|Tanga no Mi|', nq'|Baie Panga|', nq'|Tanigabeere|', nq'|Baccaitan|', nq'|Baya Yecana|', nq'|????|', nq'|Riche Yeolmae|', nq'|??? / ???|', nq'|Bianying Guo / B�nying Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Ability Urge|', 5 , q'|Activates the Ability of an ally Pok�mon. Wonder Launcher only.|' , nq'|??????|', nq'|Skill Call|', nq'|Appel CapSp�|', nq'|F�h.-Appell|', nq'|Chiamabilit�|', nq'|Habilitador|', nq'|???|', nq'|Skill Call|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Down St. Key|', 3 , q'|Allows the player to access the basement floor of the Shadow PKMN Lab.|' , nq'|????????|', nq'|Chikatsuro no Kagi|', nq'|Cle du Sous-Sol|', nq'|Ug-Schl�ssel|', nq'|Chiave Sott.|', nq'|Llave S�tano|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Nest Ball|', 3 , q'|A type of Pok� Ball that works better on low-level Pok�mon.|' , nq'|??????|', nq'|Nest Ball|', nq'|Faiblo Ball|', nq'|Nestball|', nq'|Minor Ball|', nq'|Nido Ball|', nq'|????|', nq'|Nest Ball|', nq'|???|', nq'|Ch�oxu� Qi� / Ch�auhyuht K�uh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pinsirite|', 6 , q'|Allows Pinsir to Mega Evolve into Mega Pinsir.|' , nq'|???????|', nq'|Kailiosnite|', nq'|Scarabruite|', nq'|Pinsirnit|', nq'|Pinsirite|', nq'|Pinsirita|', nq'|???????|', nq'|Ppeusaizeonite|', nq'|?????? / ??????|', nq'|Kailu�si J�nhu� Sh� / H�il�hsi Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|HP Up|', 1 , q'|Raises the HP of a Pok�mon.|' , nq'|???????|', nq'|Max Up|', nq'|PV Plus|', nq'|KP-Plus|', nq'|PS-Su|', nq'|M�s PS|', nq'|???|', nq'|Max Up|', nq'|HP??? / HP???|', nq'|HP Zengqi�ngj� / HP Jangk�uhngjaih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Ghost Memory|', 7 , q'|Makes Silvally a Ghost-type Pok�mon and makes Multi-Attack a Ghost-type move.|' , nq'|???????|', nq'|Ghost Memory|', nq'|ROM Spectre|', nq'|Geister-Disc|', nq'|ROM Spettro|', nq'|Disco Fantasma|', nq'|??????|', nq'|Ghost Memory|', nq'|?????*|'||chr(10)||nq'|?????|', nq'|Youl�ng J�y�di� / Yaul�hng Geiyikdihp*|'||chr(10)||nq'|Youl�ng C�nchudi�|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Joy Scent|', 3 , q'|Reduces heart gauge by a small amount, but increases friendship.|' , nq'|????????|', nq'|Runrun no Kaori|', nq'|P. Doux|', nq'|Froh-E.|', nq'|Olio di Pino|', nq'|Ar. Alegr�a|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|X Accuracy 2|', 5 , q'|Sharply raises a Pok�mon's accuracy. Wonder Launcher only.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Wailmer Pail|', 3 , q'|Used to water Berry plants.|' , nq'|????????|', nq'|Hoeruko Joro|', nq'|Wailmerrosoir|', nq'|Wailmerkanne|', nq'|Vaso Wailmer|', nq'|Wailmegadera|', nq'|????????|', nq'|Goraewangja Mulppurigae|', nq'|????? / ?????|', nq'|Houhoujing Penh� / Haauhaauk�hng Panw�h|', 144 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Ein File P|', 3 , q'|Describes purification.|' , nq'|???????R|', nq'|Borg File R|', nq'|Dossier Teck P|', nq'|Culpa-Akte C-E|', nq'|Genus.File P|', nq'|Parte Ein: P|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Stone Plate|', 4 , q'|Raises the power of Rock-type moves.|' , nq'|????????|', nq'|Ganseki Pureto|', nq'|Plaque Roc|', nq'|Steintafel|', nq'|Lastrapietra|', nq'|Tabla P�trea|', nq'|??????|', nq'|Amseok Plate|', nq'|????|', nq'|Y�nsh� Sh�ban / Ng�ahmsehk Sehkb�an|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dive Ball|', 3 , q'|A type of Pok� Ball that works better on Pok�mon encountered underwaterRSEORAS or while Surfing or fishingFRLGDPPtHGSSBWB2W2XY.|' , nq'|??????|', nq'|Dive Ball|', nq'|Scuba Ball|', nq'|Tauchball|', nq'|Sub Ball|', nq'|Buceo Ball|', nq'|????|', nq'|Dive Ball|', nq'|??? / ???|', nq'|Qi�nshui Qi� / Ch�hms�ui K�uh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Deep Sea Scale|', 3 , q'|A hold item that allows Clamperl to evolve into Gorebyss when traded.|', q'|Formatted as DeepSeaScale prior to Generation VI.|', nq'|????????|', nq'|Shinkai no Uroko|', nq'|�caille Oc�an|', nq'|Abyssplatte|', nq'|Squamabissi|', nq'|Escama Marina|', nq'|?????|', nq'|Simhae-ui Bineul|', nq'|???? / ????|', nq'|Shenhai L�npi�n / Samh�i L�uhnpin|', 1152 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Abomasite|', 6 , q'|Allows Abomasnow to Mega Evolve into Mega Abomasnow.|' , nq'|???????|', nq'|Yukinoonite|', nq'|Blizzarite|', nq'|Rexblisarnit|', nq'|Abomasnowite|', nq'|Abomasnowita|', nq'|??????|', nq'|Nunseolwangnite|', nq'|?????? / ??????|', nq'|B�oxuew�ng J�nhu� Sh� / Bouhsyutw�hng Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Silk Scarf|', 3 , q'|Raises the power of Normal-type moves.|' , nq'|????????|', nq'|Silk no Scarf|', nq'|Mouchoir Soie|', nq'|Seidenschal|', nq'|Sciarpa Seta|', nq'|Pa�uelo Seda|', nq'|?????|', nq'|Silk Scarf|', nq'|???? / ????|', nq'|Sich�u W�ijin / Sich�uh W�ihgan|', 160 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Galactic Key|', 4 , q'|Allows player to access the Galactic HQ in Veilstone City.|' , nq'|????????|', nq'|Ginga-dan no Kagi|', nq'|Cl� Galaxie|', nq'|G-Schl�ssel|', nq'|Galachiave|', nq'|Ll. Galaxia|', nq'|????? ??|', nq'|Galaxy Dan-ui Yeolsoe|', nq'|????? / ?????|', nq'|Y�nh� Du� Y�oshi / Ng�hnh�h D�ui Yeuhks�h|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dragonium Z|', 7 , q'|Allows a Pok�mon to upgrade their Dragon-type damaging moves to the Z-Move Devastating Drake or upgrade their Dragon-type status moves into Z-Moves. Makes Arceus a Dragon-type Pok�mon.|' , nq'|????Z|', nq'|Dragon-Z|', nq'|Dracoz�lite|', nq'|Dracium Z|', nq'|Draconium Z|', nq'|Dracostal Z|', nq'|???Z|', nq'|Dragon-Z|', nq'|?Z / ?Z|', nq'|L�ng-Z / L�hng-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Timer Ball|', 3 , q'|A type of Pok� Ball that works better the longer the battle has lasted.|' , nq'|???????|', nq'|Timer Ball|', nq'|Chrono Ball|', nq'|Timerball|', nq'|Timer Ball|', nq'|Turno Ball|', nq'|????|', nq'|Timer Ball|', nq'|??? / ???|', nq'|J�sh� Qi� / Gais�h K�uh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Eject Button|', 5 , q'|Forces the holder to switch out when hit by an attack that makes contact. Consumed after use.|' , nq'|????????|', nq'|Dasshutsu Button|', nq'|Bouton Fuite|', nq'|Fluchtknopf|', nq'|Pulsantefuga|', nq'|Bot�n Escape|', nq'|????|', nq'|Talchul Button|', nq'|???? / ????|', nq'|T�otuo �nji�n / T�uhtyut Ongihn|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|X Accuracy|', 1 , q'|Raises a Pok�mon's Accuracy by 2 stages (1 stage before Gen. VII).|' , nq'|??????|', nq'|Yokuataru|', nq'|Precision +|', nq'|X-Treffer|', nq'|Precisione X|', nq'|Precisi�n X|', nq'|?-???|', nq'|Jal-Machigi|', nq'|???? / ????|', nq'|M�ngzh�ng Qi�nghu� / Mihngjung K�uhngfa|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Secret Key|', 1 , q'|Allows access to the Cinnabar Gym.|' , nq'|??????|', nq'|Himitsu no Kagi|', nq'|Cl� Secr�te|', nq'|�?-�ffner|', nq'|Chiave Segreta|', nq'|Ll. Secreta|', nq'|?????|', nq'|Bimirui Yeolsoe|', nq'|???? / ????|', nq'|M�m� Y�oshi / Beimaht Yeuhks�h|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Black Belt|', 2 , q'|Raises the power of Fighting-type moves.|', q'|Formatted as Blackbelt in Generation II.|', nq'|????|', nq'|Kuro Obi|', nq'|Ceinture Noire|', nq'|Schwarzgurt|', nq'|Cinturanera|', nq'|Cintur�n Negro|', nq'|???|', nq'|Geomeun Tti|', nq'|?? / ??|', nq'|Heid�i / Haakdaai|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Escape Rope|', 1 , q'|Teleports the player out of a cave or dungeon if the player cannot find the way out.|' , nq'|???????|', nq'|Ananuke no Himo|', nq'|Corde Sortie|', nq'|Fluchtseil|', nq'|Fune di Fuga|', nq'|Cuerda Huida|', nq'|??????|', nq'|Donggul Talchul Rope|', nq'|??? / ???|', nq'|L�d�ng Sh�ng / L�ihduhng S�hng|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Voice Case 5|', 3 , q'|Heals a Shroomish at ONBS.|' , nq'|??????5|', nq'|Koe Capsule 5|', nq'|Boite Cri 5|', nq'|Stimmbox 5|', nq'|Disco Verso 5|', nq'|Grabaci�n 5|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pikanium Z|', 7 , q'|Allows Pikachu to upgrade Volt Tackle to the special Z-Move Catastropika.|' , nq'|?????Z|', nq'|Pikachu-Z|', nq'|Pikaz�lite|', nq'|Pikachium Z|', nq'|Pikacium Z|', nq'|Pikastal Z|', nq'|???Z|', nq'|Pikachu-Z|', nq'|???Z|', nq'|P�kaqiu-Z / P�ihkayau-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Fresh Water|', 1 , q'|Restores 30 HP. (50HP before Gen. VII).|' , nq'|??????|', nq'|Oishii Mizu|', nq'|Eau Fraiche|', nq'|Tafelwasser|', nq'|Acqua Fresca|', nq'|Agua Fresca|', nq'|????|', nq'|Masinneun Mul|', nq'|????|', nq'|Meiw�i-zhi Shui / M�ihmeih-ji S�ui|', 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH )
values( q'|Battle CD|' , nq'|???????|', nq'|Battle Disk|', nq'|Holodisk|', nq'|Kampf-CD|', nq'|CD Lotta|', nq'|Disco C.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dragon Skull|', 5 , q'|Stolen from the Nacrene Museum by a Team Plasma Grunt.|' , nq'|???????|', nq'|Dragon no Hone|', nq'|Cr�ne Dragon|', nq'|Drakosch�del|', nq'|Teschio|', nq'|Cr�n. Drag�n|', nq'|?????|', nq'|Dragon-yi Ppyeo|', nq'|??? / ???|', nq'|L�ng-zhi Gu / L�hng-ji Gwat|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Revive|', 1 , q'|Revives a Pok�mon to half of maximum HP.|' , nq'|???????|', nq'|Genki no Kakera|', nq'|Rappel|', nq'|Beleber|', nq'|Revitalizzante|', nq'|Revivir|', nq'|?????|', nq'|Giryeog-ui Jogak|', nq'|????|', nq'|Hu�l� Su�pi�n / Wuhtlihk Seuip�n|', 32 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Blue Orb|', 3 , q'|Used to awaken Kyogre. It also turns Kyogre into Primal Kyogre during battle when holding the item.ORAS|' , nq'|???????|', nq'|Aiiro no Tama|', nq'|Gemme Bleue|', nq'|Blauer Edelstein|', nq'|Gemma blu|', nq'|Prisma Azul|', nq'|????|', nq'|Jjokbit Guseul|', nq'|????? / ?????|', nq'|Di�nl�n-s� Baozhu / Dihnl�ahm-sik B�ujyu|', 240 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|AuroraTicket|', 3 , q'|Event item that allows player to catch Deoxys.|' , nq'|????????|', nq'|Aurora Ticket|', nq'|Ticketaurora|', nq'|Auroraticket|', nq'|Biglietto Aurora|', nq'|Ori-Ticket|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Bitter Berry|', 2 , q'|Heals confusion.|' , nq'|??????|', nq'|Nigai Kino Mi|', nq'|Baie Amere|', nq'|Bitterbeere|', nq'|Bacca Amara|', nq'|Bayamarga|', nq'|??????|', nq'|Sseunmat Namu Yeolmae|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Normalium Z|', 7 , q'|Allows a Pok�mon to upgrade their Normal-type damaging moves to the Z-Move Breakneck Blitz or upgrade their Normal-type status moves into Z-Moves.|' , nq'|????Z|', nq'|Normal-Z|', nq'|Normaz�lite|', nq'|Normium Z|', nq'|Normium Z|', nq'|Normastal Z|', nq'|??Z|', nq'|Normal-Z|', nq'|??Z|', nq'|Yi?ban-Z / Yatbun-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Adventure Rules|', 6 , q'|Contains information new Trainers should know.|' , nq'|????????|', nq'|Tanken Kokoroe|', nq'|ABC Aventure|', nq'|Abenteuerfibel|', nq'|Guida Avventura|', nq'|Gu�a de M�ximas|', nq'|????|', nq'|Tamheom Suchig|', nq'|???? / ????|', nq'|T�nxian Xind� / Taamh�m Samdak|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Old Amber|', 1 , q'|A Fossil from which an Aerodactyl can be resurrected.|' , nq'|???????|', nq'|Himitsu no Kohaku|', nq'|Vieil Ambre|', nq'|Altbernstein|', nq'|Ambra Antica|', nq'|Ambar Viejo|', nq'|?????|', nq'|Bimirui Hobak|', nq'|????|', nq'|M�m� Hup� / Beimaht F�paak|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Ether|', 1 , q'|Restores 10 PP of one move of a Pok�mon.|' , nq'|???????|', nq'|PP Aid|', nq'|Huile|', nq'|�ther|', nq'|Etere|', nq'|�ter|', nq'|PP???|', nq'|PP Aid|', nq'|PP????? / PP?????|', nq'|PP Danxi�ng Xiaobuj� / PP Daanhohng S�ub�ujaih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Space Mail|', 4 , q'|Mail with an outer space pattern. To be held by a Pok�mon for delivery.|' , nq'|???????|', nq'|Space Mail|', nq'|Lettre Cosmo|', nq'|Sternbrief|', nq'|Mess. Spazio|', nq'|Car. Sideral|', nq'|??????|', nq'|Space Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Flying Gem|', 5 , q'|Increases the power of the holder's first Flying-type move by 50%, and is consumed after use.|' , nq'|????????|', nq'|Hiko no Jewel|', nq'|Joyau Vol|', nq'|Flugjuwel|', nq'|Bijouvolante|', nq'|Gema Voladora|', nq'|????|', nq'|Bihaeng Jewel|', nq'|???? / ????|', nq'|Feix�ng Baosh� / Feih�hng B�usehk|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dropped Item|', 5 , q'|The Xtransceiver found at the Nimbasa City amusement park. It seems it belongs to a boy/girl.|' , nq'|?????|', nq'|Forgotten Item|', nq'|Objet Trouv�|', nq'|Fundsache|', nq'|Oggetto Perso|', nq'|Obj. Perdido|', nq'|????|', nq'|Ijeun Mulgeon|', nq'|??? / ???|', nq'|Y�w�ng W� / W�ihm�hng Maht|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Heracronite|', 6 , q'|Allows Heracross to Mega Evolve into Mega Heracross.|' , nq'|????????|', nq'|Heracrosnite|', nq'|Scarhino�te|', nq'|Skarabornit|', nq'|Heracrossite|', nq'|Heracrossita|', nq'|????????|', nq'|Heracrossnite|', nq'|???????? / ????????|', nq'|H�lak�lu�si J�nhu� Sh� / Haklaaihakl�hsi Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Flower Mail|', 2 , q'|Mail with a flower pattern. To be held by a Pok�mon for delivery.|' , nq'|???????|', nq'|Hanagara Mail|', nq'|Lettre Fleur|', nq'|Blumenbrief|', nq'|Messaggio Fiore|', nq'|Carta Flor|', nq'|?????|', nq'|Kkonmunui Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Blue Apricorn|', 2 , q'|If taken to Kurt, he will make the player a Lure Ball. Also, Apricorn Drink ingredient.|', q'|Formatted as Blu Apricorn prior to Generation VI.|', nq'|??????|', nq'|Ao Bonguri|', nq'|Noigrume Blu|', nq'|Aprikoko Blu|', nq'|Ghicocca Blu|', nq'|Bonguri Azul|', nq'|?????|', nq'|Paran Gyutori|', nq'|??? / ???|', nq'|L�n Qi�guo / L�ahm K�uhgw�|', 1072 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Muscle Band|', 4 , q'|Raises the power of physical moves.|' , nq'|????????|', nq'|Chikara no Hachimaki|', nq'|Bandeau Muscle|', nq'|Muskelband|', nq'|Muscolbanda|', nq'|Cinta Fuerte|', nq'|?????|', nq'|Himui Meoritti|', nq'|???? / ????|', nq'|L�li�ng T�ud�i / Lihkleuhng T�uhdaai|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Glalitite|', 6 , q'|Allows Glalie to Mega Evolve into Mega Glalie.|' , nq'|????????|', nq'|Onigohrinite|', nq'|Oniglalite|', nq'|Firnontornit|', nq'|Glalite|', nq'|Glalita|', nq'|???????|', nq'|Urumkisinnite|', nq'|?????? / ??????|', nq'|Bingguih� J�nhu� Sh� / Binggw�iwuh Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|DNA Splicers|', 5 , q'|Combines and separates Kyurem with Reshiram or Zekrom, transforming them into White Kyurem or Black Kyurem, respectively.|' , nq'|????????|', nq'|Gene Wedge|', nq'|Pointeau ADN|', nq'|DNS-Keil|', nq'|Cuneo DNA|', nq'|Punta ADN|', nq'|?????|', nq'|Yujeonja Swae-gi|', nq'|????|', nq'|Jiyin-zhi Xie / Geiyan-ji Sit|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Ability Capsule|', 6 , q'|Allows a Pok�mon with two Abilities to switch between these Abilities.|' , nq'|????????|', nq'|Tokusei Capsule|', nq'|Pilule Talent|', nq'|F�higk.-Kapsel|', nq'|Capsula Abilit�|', nq'|C�ps. Habilidad|', nq'|????|', nq'|Teukseong Capsule|', nq'|???? / ????|', nq'|T�x�ng Jiaon�ng / Dahksing Gaaun�hng|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Tri-Pass|', 3 , q'|Allows the player to travel to the first three Sevii Islands.|' , nq'|?????|', nq'|Tri Pass|', nq'|Tri-Pass|', nq'|Tri-Pass|', nq'|Tri-Pass|', nq'|Tri-Ticket|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Mint Berry|', 2 , q'|Awakens a sleeping Pok�mon.|' , nq'|?????|', nq'|Hakka no Mi|', nq'|Baie Menthe|', nq'|Minzbeere|', nq'|Bacca Menta|', nq'|Baya Menta|', nq'|????|', nq'|Bakha Yeolmae|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Greet Mail|', 5 , q'|Stationary for introductory greetings. To be held by a Pok�mon for delivery.|' , nq'|???????|', nq'|Hajimete Mail|', nq'|Lettre Salut|', nq'|Gru�brief|', nq'|Mess. Inizio|', nq'|C. Inicial|', nq'|???|', nq'|Cheot Mail|', nq'|???? / ????|', nq'|Chuc� Y�uji�n / Chochi Y�uhg�n|', 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( q'|Roto Hatch|' , nq'|???????|', nq'|Tamago fuka Pon|', nq'|Moti-Couveuse|', nq'|Brutbon|', nq'|Cova'n'roll|', nq'|Cup�n Eclosi�n|', nq'|�???|', nq'|�???|', nq'|????|', nq'|Fud�n P�ngp�ng / Fudaahn Pungpung|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Acro Bike|', 3 , q'|A bicycle with which the player can do tricks such as jump sideways.|' , nq'|????????|', nq'|Dirt Jitensha|', nq'|V�lo Cross|', nq'|Kunstrad|', nq'|Bici da cross|', nq'|Bici Acrob�tica|', nq'|?????|', nq'|Dirt Jajeongeo|', nq'|????? / ?????|', nq'|Yu�ye Z�x�ngche / Yuhty�h Jihh�hngche|', 32 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lunalium Z|', 7 , q'|Allows Lunala and Dawn Wings Necrozma to upgrade Moongeist Beam to the special Z-Move Menacing Moonraze Maelstrom.|' , nq'|?????Z|', nq'|Lunala-Z|', nq'|Lunaz�lite|', nq'|Lunalium Z|', nq'|Lunalium Z|', nq'|Lunalastal Z|', nq'|????Z|', nq'|Lunala-Z|', nq'|????Z|', nq'|L�n�iyala-Z / Louhnoihng�hlaai-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Adamant Orb|', 4 , q'|Boosts Dialga's Steel- and Dragon-type attacks.|' , nq'|??????|', nq'|Kongo Dama|', nq'|Orbe Adamant|', nq'|Adamant-Orb|', nq'|Adamasfera|', nq'|Diamansfera|', nq'|???|', nq'|Geumgang Ok|', nq'|???? / ????|', nq'|Jingang Baozhu / Gamgong B�ujyu|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Smooth Rock|', 4 , q'|Extends the duration of sandstorms.|' , nq'|??????|', nq'|Sarasara Iwa|', nq'|Roche Lisse|', nq'|Glattbrocken|', nq'|Roccialiscia|', nq'|Roca Suave|', nq'|??????|', nq'|Bosongbosong Bawi|', nq'|????|', nq'|Shasha Y�nsh� / Sasa Ng�ahmsehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|Pok�dex|', 1 , q'|Stores info about Pok�mon that have been seen/caught.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Like Mail|', 5 , q'|Stationary designed for writing recommendations. To be held by a Pok�mon for delivery.|' , nq'|???????|', nq'|Osusume Mail|', nq'|Lettre Avis|', nq'|Insiderbrief|', nq'|Mess. Sugg.|', nq'|C. Gustos|', nq'|????|', nq'|Chucheon Mail|', nq'|???? / ????|', nq'|Tuiji�n Y�uji�n / Teuijin Y�uhg�n|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI , CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|God Stone|', 5 , q'|Not available without cheating. Currently has no use.|' , nq'|???????|', nq'|God Stone|' , nq'|??|', nq'|Sh�nsh� / S�hnsehk|', 1024 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Jaw Fossil|', 6 , q'|A Fossil from which a Tyrunt can be resurrected.|' , nq'|??????|', nq'|Ago no Kaseki|', nq'|Fossile M�choire|', nq'|Kieferfossil|', nq'|Fossilmascella|', nq'|F�sil Mand�bula|', nq'|???|', nq'|Teok Hwaseok|', nq'|???? / ????|', nq'|�-zhi Hu�sh� / Ngohk-ji Fasehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Festival Ticket|', 7 , q'|A ticket that allows you to host a mission in Festival Plaza.|' , nq'|???????|', nq'|Fest Ticket|', nq'|Festicket|', nq'|Festival-Ticket|', nq'|Festicket|', nq'|Festicup�n|', nq'|????|', nq'|Fest Ticket|', nq'|??? / ???|', nq'|Yu�nq�ng Pi�o / Y�hnhing Piu|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Fire Memory|', 7 , q'|Makes Silvally a Fire-type Pok�mon and makes Multi-Attack a Fire-type move.|' , nq'|????????|', nq'|Fire Memory|', nq'|ROM Feu|', nq'|Feuer-Disc|', nq'|ROM Fuoco|', nq'|Disco Fuego|', nq'|??????|', nq'|Fire Memory|', nq'|?????*|'||chr(10)||nq'|?????|', nq'|Huoy�n J�y�di� / F�yihm Geiyikdihp*|'||chr(10)||nq'|Huoy�n C�nchudi�|', 3 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( q'|Roto Exp. Points|' , nq'|??????|', nq'|Keiken Pon|', nq'|Molti-Exp|', nq'|EP-Bon|', nq'|Esp'n'roll|', nq'|Cup�n Exp|', nq'|�???|', nq'|�???|', nq'|???? / ????|', nq'|Jingy�n P�ngp�ng / Gingyihm Pungpung|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lock Capsule|', 5 , q'|Not available without cheating. Can be relocated from HeartGold or Soul Silver to obtain TM95 (Snarl).|' , nq'|???????|', nq'|Lock Capsule|', nq'|Capsule Anti-vol|', nq'|Tresorkapsel|', nq'|Cap. Scrigno|', nq'|C�p. Candado|', nq'|???|', nq'|Lock Capsule|', nq'|????? / ?????|', nq'|Sh�ngsuo-de R�ngq� / S�uhngs�-dik Y�hnghei|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Poffin Case|', 4 , q'|Stores Poffins.|' , nq'|???????|', nq'|Poffin Case|', nq'|Bo�te Poffin|', nq'|Knurspbox|', nq'|Portapoffin|', nq'|Pokochera|', nq'|?????|', nq'|Poffin Case|', nq'|??? / ???|', nq'|Baofen H� / Baofen Hahp|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Mental Herb|', 3 , q'|Prevents attraction. Consumed after use.|' , nq'|???????|', nq'|Mental Herb|', nq'|Herbe Mental|', nq'|Mentalkraut|', nq'|Mentalerba|', nq'|Hierba Mental|', nq'|????|', nq'|Mental Herb|', nq'|???? / ????|', nq'|Xinl�ng Xiangcao / Saml�hng Heungch�u|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Gold Leaf|', 2 , q'|Can be sold for 1000.|' , nq'|??????|', nq'|Kin no Happa|', nq'|Feuille D'Or|', nq'|Goldblatt|', nq'|Fogliadoro|', nq'|Hoja Dorada|', nq'|?????|', nq'|Geumbit Namunnip|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Heal Powder|', 2 , q'|Heals any status condition, but lowers friendship.|' , nq'|??????|', nq'|Banno Gona|', nq'|Poudre Soin|', nq'|Heilpuder|', nq'|Polvocura|', nq'|Polvo Curaci�n|', nq'|????|', nq'|Manneung Garu|', nq'|??? / ???|', nq'|W�nn�ng Fen / Maahnn�hng F�n|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Growth Mulch|', 4 , q'|Causes Berries to grow faster, but makes the soil dry faster.|' , nq'|???????|', nq'|Sukusuku Koyashi|', nq'|Fertipousse|', nq'|Wachsmulch|', nq'|Fertilrapido|', nq'|Abono R�pido|', nq'|??????|', nq'|Mureokmureok Biryo|', nq'|???|', nq'|S�s� F�i / Chukchuk F�ih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Adrenaline Orb|', 7 , q'|When used, makes wild Pok�mon more likely to call allies for help in an SOS Battle. Is not consumed if it fails. If the holder is affected by Intimidate, its Speed is increased by one stage.|' , nq'|?????|', nq'|Bibiri Dama|', nq'|Orbe Frousse|', nq'|Zitterorb|', nq'|Fifasfera|', nq'|Nerviosfera|', nq'|????|', nq'|Junuk Guseul|', nq'|??? / ???|', nq'|Danqi� Qi� / D�amhip K�uh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pretty Wing|', 5 , q'|An item that does absolutely nothing.|' , nq'|??????|', nq'|Kireina Hane|', nq'|Jolie Aile|', nq'|Prachtfeder|', nq'|Piumabella|', nq'|Pluma Bella|', nq'|????|', nq'|Goun Nalgae|', nq'|???? / ????|', nq'|Meil�-zhi Yu / M�ihlaih-ji Y�h|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Liechi Berry|', 3 , q'|Raises Attack when HP is below ? of maximum.|' , nq'|?????|', nq'|Chyla no Mi|', nq'|Baie Lichii|', nq'|Lydzibeere|', nq'|Baccalici|', nq'|Baya Lichi|', nq'|????|', nq'|Cheely Yeolmae|', nq'|???|', nq'|Zhil� Guo / Jilaih Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Dream Mail|', 3 , q'|To be held by a Pok�mon for delivery.|' , nq'|???????|', nq'|Dream Mail|', nq'|Lettre Songe|', nq'|Traumbrief|', nq'|Mess. Sogno|', nq'|Carta Sue�o|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Venusaurite|', 6 , q'|Allows Venusaur to Mega Evolve into Mega Venusaur.|' , nq'|???????|', nq'|Fushigibanite|', nq'|Florizarrite|', nq'|Bisaflornit|', nq'|Venusaurite|', nq'|Venusaurita|', nq'|???????|', nq'|Isanghekkotnite|', nq'|?????? / ??????|', nq'|Mi�owahua J�nhu� Sh� / Miuhwafa Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Moon Stone|', 1 , q'|Can be used to evolve Clefairy, Jigglypuff, Nidorino, Nidorina, and Skitty.|' , nq'|?????|', nq'|Tsuki no Ishi|', nq'|Pierre Lune|', nq'|Mondstein|', nq'|Pietralunare|', nq'|Piedra Lunar|', nq'|???|', nq'|Dar-ui Dol|', nq'|???|', nq'|Yu�-zhi Sh� / Yuht-ji Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Boost Mulch|', 6 , q'|When applied to a Berry patch, causes the soil to dry out in 4 hours.|' , nq'|???????|', nq'|Gungun Koyashi|', nq'|Fertib�rance|', nq'|Wuchermulch|', nq'|Fertilcopioso|', nq'|Abono Fruct�fero|', nq'|??????|', nq'|Bujjeok-bujjeok Biryo|', nq'|??? / ???|', nq'|J�nj�n F�i / Gihnggihng F�ih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Key to Room 6|', 6 , q'|Opens Room 6 of the Abandoned ShipRSE/Sea MauvilleORAS.|', q'|Called Rm. 6 Key in Generation III.|', nq'|?????????|', nq'|Roku-go Shitsu no Kagi|', nq'|Cl� Salle 6|', nq'|R6-Schl�ssel|', nq'|Chiave stanza 6|', nq'|Ll. Habitaci�n 6|', nq'|?????|', nq'|Yuk-hosil Yeolsoe|', nq'|6?????? /|'||chr(10)||nq'|6??????|', nq'|6 H�o K�f�ng-de Y�oshi / 6 Houh Haakf�ng-dik Yeuhks�h|', 1616 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Focus Sash|', 4 , q'|Prevents a one-hit knockout.|' , nq'|???????|', nq'|Kiai no Tasuki|', nq'|Ceinture Force|', nq'|Fokusgurt|', nq'|Focalnastro|', nq'|Banda Focus|', nq'|????|', nq'|Gihabui Tti|', nq'|???? / ????|', nq'|Q�sh� Pid�i / Heisai Peidaai|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Black Glasses|', 2 , q'|Raises the power of Dark-type moves.|', q'|Formatted as BlackGlasses prior to Generation VI.|', nq'|??????|', nq'|Kuroi Megane|', nq'|Lunettes Noires|', nq'|Schattenglas|', nq'|Occhialineri|', nq'|Gafas de Sol|', nq'|????|', nq'|Geomeun An-gyeong|', nq'|???? / ????|', nq'|Hei-s� Yanj�ng / Haak-sik Ng�ahngeng|', 1152 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Poison Memory|', 7 , q'|Makes Silvally a Poison-type Pok�mon and makes Multi-Attack a Poison-type move.|' , nq'|???????|', nq'|Poison Memory|', nq'|ROM Poison|', nq'|Gift-Disc|', nq'|ROM Veleno|', nq'|Disco Veneno|', nq'|??????|', nq'|Poison Memory|', nq'|????*|'||chr(10)||nq'|????|', nq'|D� J�y�di� / Duhk Geiyikdihp*|'||chr(10)||nq'|D� C�nchudi�|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Devon Scuba Gear|', 6 , q'|Worn while underwater.|' , nq'|??????|', nq'|Devon Bombe|', nq'|Plongeur Devon|', nq'|Devon-Atemger�t|', nq'|Maschera Devon|', nq'|Bombona Devon|', nq'|????|', nq'|Devon Bombe|', nq'|?????? / ??????|', nq'|D�w�n Qi�nshui Zhuangb�i / Dakm�hn Ch�hms�ui Jongbeih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Comet Shard|', 5 , q'|Can be sold for 60000.|' , nq'|????????|', nq'|Suisei no Kakera|', nq'|Morceau Com�te|', nq'|Kometst�ck|', nq'|Pezzo Cometa|', nq'|Fragmento Cometa|', nq'|????|', nq'|Hyeseong Jogak|', nq'|????|', nq'|Hu�xing Su�pi�n / Seuihsing Seuip�n|', 144 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Darkinium Z|', 7 , q'|Allows a Pok�mon to upgrade their Dark-type damaging moves to the Z-Move Black Hole Eclipse or upgrade their Dark-type status moves into Z-Moves. Makes Arceus a Dark-type Pok�mon.|' , nq'|??Z|', nq'|Evil-Z|', nq'|T�n�broz�lite|', nq'|Noctium Z|', nq'|Obscurium Z|', nq'|Nictostal Z|', nq'|?Z|', nq'|Ak-Z|', nq'|?Z / ?Z|', nq'|�-Z / Ok-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|PSNCureBerry|', 2 , q'|Cures poison.|' , nq'|??????|', nq'|Dokukeshi no Mi|', nq'|Baie Antidot|', nq'|Ggngiftbeere|', nq'|Baccantivel.|', nq'|Bayant�doto|', nq'|????|', nq'|Haedok Yeolmae|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Heart Mail|', 4 , q'|Mail with a heart pattern. To be held by a Pok�mon for delivery.|' , nq'|???????|', nq'|Love-Love Mail|', nq'|Lettre Coeur|', nq'|Rosabrief|', nq'|Mess. Cuore|', nq'|Car. Coraz�n|', nq'|??????|', nq'|Love-Love Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Parcel|', 4 , q'|To be delivered to rival. Contains two Town Maps.|' , nq'|??????|', nq'|Otodoke Mono|', nq'|Colis|', nq'|Paket|', nq'|Pacco|', nq'|Paquete|', nq'|?????|', nq'|Jeonhaejul Mulgeon|', nq'|??|', nq'|Baoguo / Baaugw�|', 1264 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dark Memory|', 7 , q'|Makes Silvally a Dark-type Pok�mon and makes Multi-Attack a Dark-type move.|' , nq'|??????|', nq'|Dark Memory|', nq'|ROM T�n�bres|', nq'|Unlicht-Disc|', nq'|ROM Buio|', nq'|Disco Siniestro|', nq'|?????|', nq'|Dark Memory|', nq'|?????*|'||chr(10)||nq'|?????|', nq'|Hei'�n J�y�di� / Hak'am Geiyikdihp*|'||chr(10)||nq'|Hei'�n C�nchudi�|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Gengarite|', 6 , q'|Allows Gengar to Mega Evolve into Mega Gengar.|' , nq'|??????|', nq'|Ganganite|', nq'|Ectoplasmite|', nq'|Gengarnit|', nq'|Gengarite|', nq'|Gengarita|', nq'|?????|', nq'|Penteomnite|', nq'|????? / ?????|', nq'|Genggui J�nhu� Sh� / G�nggw�i Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Miror Radar|', 3 , q'|Keeps track of Miror B.|' , nq'|????????|', nq'|Mirorbo Radar|', nq'|Radar Disco|', nq'|Queen-Radar|', nq'|Discoradar|', nq'|Radar Discal|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Strange Souvenir|', 6 , q'|Currently has no use.|' , nq'|????????|', nq'|Fushigina Okimono|', nq'|Bibelot Bizarre|', nq'|Skurriloskulptur|', nq'|Strano ninnolo|', nq'|Estatuilla Rara|', nq'|??????|', nq'|Isanghae Jangsikpum|', nq'|???? / ????|', nq'|Sh�nm� Baish� / S�hnbei B�aichit|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Calcium|', 1 , q'|Raises the Special Attack of a Pok�mon.|' , nq'|?????|', nq'|Lysozyme|', nq'|Calcium|', nq'|Kalzium|', nq'|Calcio|', nq'|Calcio|', nq'|?????|', nq'|Riboflavin|', nq'|????? / ?????|', nq'|T�gong Zengqi�ngj� / Dahkgung Jangk�uhngjaih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Z-Power Ring|', 7 , q'|Allows the player to use Z-Moves when a Pok�mon is holding an appropriate Z-Crystal. Allows the player to use Mega Evolution after obtaining a Key Stone when a Pok�mon is holding the appropriate Mega Stone.|' , nq'|Z??????|', nq'|Z Power Ring|', nq'|Super Bracelet Z|', nq'|Z-Kraftring|', nq'|Supercerchio Z|', nq'|Superpulsera Z|', nq'|Z???|', nq'|Z-Power Ring|', nq'|Z???? / Z????|', nq'|Z Qi�ngl� Shouhu�n / Z K�uhnglihk S�uw�ahn|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Lovely Mail|', 2 , q'|Mail with a heart design. To be held by a Pok�mon for delivery.|' , nq'|???????|', nq'|Lovely Mail|', nq'|LetrCharm.|', nq'|Herzbrief|', nq'|Mess. Dolce|', nq'|Carta Amor|', nq'|?????|', nq'|Lovely Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Deep Sea Tooth|', 3 , q'|A hold item that allows Clamperl to evolve into Huntail when traded.|', q'|Formatted as DeepSeaTooth prior to Generation VI.|', nq'|???????|', nq'|Shinkai no Kiba|', nq'|Dent Oc�an|', nq'|Abysszahn|', nq'|Dente Abissi|', nq'|Diente Marino|', nq'|?????|', nq'|Simhae-ui Ippal|', nq'|????|', nq'|Shenhai-zhi Y� / Samh�i-ji Ng�h|', 1056 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Bug Gem|', 5 , q'|Increases the power of the holder's first Bug-type move by 50%, and is consumed after use.|' , nq'|???????|', nq'|Mushi no Jewel|', nq'|Joyau Insecte|', nq'|K�ferjuwel|', nq'|Bijoucoleottero|', nq'|Gema Bicho|', nq'|????|', nq'|Beolle Jewel|', nq'|???? / ????|', nq'|Ch�ng-zhi Baosh� / Ch�hng-ji B�usehk|', 176 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|White Herb|', 3 , q'|Raises a lowered stat.|' , nq'|??????|', nq'|Shiroi Herb|', nq'|Herbe Blanche|', nq'|Schlohkraut|', nq'|Erbachiara|', nq'|Hierba Blanca|', nq'|????|', nq'|Hayang Herb|', nq'|????|', nq'|B�i-s� Xiangcao / Baahk-sik Heungch�u|', 144 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Red Orb|', 3 , q'|Awakens Groudon. It also turns Groudon into Primal Groudon during battle when holding the item.ORAS|' , nq'|???????|', nq'|Beniiro no Tama|', nq'|Gemme Rouge|', nq'|Roter Edelstein|', nq'|Gemma rossa|', nq'|Prisma Roja|', nq'|????|', nq'|Juhong Guseul|', nq'|????? / ?????|', nq'|Zhuh�ng-s� Baozhu / Jyuh�hng-sik B�ujyu|', 240 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Poisonium Z|', 7 , q'|Allows a Pok�mon to upgrade their Poison-type damaging moves to the Z-Move Acid Downpour or upgrade their Poison-type status moves into Z-Moves. Makes Arceus a Poison-type Pok�mon.|' , nq'|??Z|', nq'|Poison-Z|', nq'|Toxiz�lite|', nq'|Toxium Z|', nq'|Venenium Z|', nq'|Toxistal Z|', nq'|?Z|', nq'|Dok-Z|', nq'|?Z|', nq'|D�-Z / Duhk-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Super Potion|', 1 , q'|Restores 60 HP. (50HP before Gen. VII).|' , nq'|???????|', nq'|Ii Kizu Gusuri|', nq'|Super Potion|', nq'|Supertrank|', nq'|Super Pozione|', nq'|Superpoci�n|', nq'|?????|', nq'|Jo-eun Sangcheo Yak|', nq'|??? / ???|', nq'|Hao Shangy�o / H�u Seungyeuhk|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Letter|', 3 , q'|To be delivered to Steven Stone.|' , nq'|????????|', nq'|Daigo e no Tsugami|', nq'|Lettre � Pierre|', nq'|Brief an Troy|', nq'|Lettera|', nq'|Carta a M�ximo|', nq'|???????|', nq'|Seongho-e Gejul Pyeonji|', nq'|????? / ?????|', nq'|Gei D�w�-de X�n / Kap Daaih?gh-dik Seun|', 208 );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|X Speed 2|', 5 , q'|Sharply raises a Pok�mon's Speed. Wonder Launcher only.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Prison Bottle|', 6 , q'|Used to transform Hoopa Confined to Hoopa Unbound.|' , nq'|???????|', nq'|Imashime no Tsubo|', nq'|Vase Scell�|', nq'|Banngef��|', nq'|Vaso del vincolo|', nq'|Vasija Castigo|', nq'|??????|', nq'|Gulle-yi Hang-ari|', nq'|???? / ????|', nq'|Ch�ngji�-zhi H� / Ch�hnggaai-ji W�h|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Health Wing|', 5 , q'|Raises the HP of a Pok�mon.|' , nq'|????????|', nq'|Tairyoku no Hane|', nq'|Aile Sant�|', nq'|Heilfeder|', nq'|Piumsalute|', nq'|Pluma Vigor|', nq'|????|', nq'|Cheryeok Nalgae|', nq'|???? / ????|', nq'|Til�-zhi Yu / T�ilihk-ji Y�h|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|BridgeMail T|', 5 , q'|Stationary with a steel suspension bridge print. To be held by a Pok�mon for delivery.|' , nq'|???????C|', nq'|Bridge Mail C|', nq'|Lettre PontF|', nq'|Br�ckbrief Z|', nq'|Mess. Prop.|', nq'|C. Puente A|', nq'|?????C|', nq'|Bridge Mail C|', nq'|????C / ????C|', nq'|Qi�oli�ng Y�uji�n C / K�uhl�uhng Y�uhg�n C|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pok� Radar|', 4 , q'|Allows player to encounter wild Pok�mon not usually seen in the area. Obtained after receiving National Pok�dex.|' , nq'|????|', nq'|Pok�-Tra|', nq'|Pok� Radar|', nq'|Pok�radar|', nq'|Pok� Radar|', nq'|Pok�radar|', nq'|????|', nq'|Pok�-Tra|', nq'|???? / ????|', nq'|Baoke Zhuizong / B�uh� Jeuijung|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Time Flute|', 3 , q'|Can be used to instantly purify a Shadow Pok�mon.|' , nq'|?????|', nq'|Toki no Fue|', nq'|Flute du Temps|', nq'|Zeitfl�te|', nq'|Flauto Tempo|', nq'|Fl. Tiempo|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Alakazite|', 6 , q'|Allows Alakazam to Mega Evolve into Mega Alakazam.|' , nq'|???????|', nq'|Foodinite|', nq'|Alakazamite|', nq'|Simsalanit|', nq'|Alakazamite|', nq'|Alakazamita|', nq'|?????|', nq'|Fudinnite|', nq'|????? / ?????|', nq'|H�d� J�nhu� Sh� / W�hdeih Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Gracidea|', 4 , q'|Allows Shaymin to change form.|' , nq'|????????|', nq'|Gracidea no Hana|', nq'|Gracid�e|', nq'|Gracidea|', nq'|Gracidea|', nq'|Grac�dea|', nq'|??????|', nq'|Gracidea Kkot|', nq'|?????? / ??????|', nq'|G�laxid�ya Hua / Gotlaaisaidaia Fa|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Roseli Berry|', 6 , q'|Reduces damage from a super effective Fairy-type move.|' , nq'|?????|', nq'|Rozelle no Mi|', nq'|Baie Selro|', nq'|Hibisbeere|', nq'|Baccarcad�|', nq'|Baya Hibis|', nq'|????|', nq'|Rosel Yeolmae|', nq'|???|', nq'|Lu�m�i Guo / Lokm�ih Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Shalour Sable|', 6 , q'|Cures any status condition.|' , nq'|??????|', nq'|Shala Sable|', nq'|Sabl� Yantreizh|', nq'|Yantara-Sabl�|', nq'|Yantafrollino|', nq'|Galleta Yantra|', nq'|?????|', nq'|Sara Sable|', nq'|????? / ?????|', nq'|Suolu� Shab�lei / Sol�h Saboul�uih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Skull Fossil|', 4 , q'|A Fossil from which a Cranidos can be resurrected.|' , nq'|???????|', nq'|Zugai no Kaseki|', nq'|Fossile Cr�ne|', nq'|Kopffossil|', nq'|Fossilcranio|', nq'|F�sil Cr�neo|', nq'|?????|', nq'|Dugae-ui Hwaseok|', nq'|???? / ????|', nq'|T�ug�i Hu�sh� / T�uhgoi Fasehk|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Icy Rock|', 4 , q'|Extends the duration of hail.|' , nq'|??????|', nq'|Tsumetai Iwa|', nq'|Roche Glace|', nq'|Eisbrocken|', nq'|Rocciafredda|', nq'|Roca Helada|', nq'|?????|', nq'|Chagaun Bawi|', nq'|????|', nq'|Bingleng Y�nsh� / Bingl�ahng Ng�ahmsehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Starf Berry|', 3 , q'|Raises a random stat when HP is below ?.|' , nq'|?????|', nq'|Star no Mi|', nq'|Baie Frista|', nq'|Krambobeere|', nq'|Baccambola|', nq'|Baya Arabol|', nq'|????|', nq'|Star Yeolmae|', nq'|???|', nq'|Xingt�o Guo / Singt�uh Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Flame Mail|', 4 , q'|Mail with a fire design. To be held by a Pok�mon for delivery.|' , nq'|???????|', nq'|Flame Mail|', nq'|Lettre Feu|', nq'|Feuerbrief|', nq'|Mess. Fiamma|', nq'|Carta Fuego|', nq'|?????|', nq'|Flame Mail|' , 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH )
values( q'|Pok� Snack|' , nq'|?????|', nq'|Pok� Manma|', nq'|Pok� Snack|', nq'|Pok�snack|', nq'|Pok� Snack|', nq'|Pok� Dulce|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pass Orb|', 5 , q'|Used for purchasing Pass Powers at the Entralink.|' , nq'|????|', nq'|Derudama|', nq'|Offrisph�re|', nq'|Transferorb|', nq'|Passabilia|', nq'|Regalosfera|', nq'|???|', nq'|Dil Guseul|', nq'|???? / ????|', nq'|Sh�chu-zhi Y� / Sikcheut-ji Y�k|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Electric Memory|', 7 , q'|Makes Silvally a Electric-type Pok�mon and makes Multi-Attack a Electric-type move.|' , nq'|????????|', nq'|Electro Memory|', nq'|ROM �lectrik|', nq'|Elektro-Disc|', nq'|ROM Elettro|', nq'|Disco El�ctrico|', nq'|???????|', nq'|Electric Memory|', nq'|?????*|'||chr(10)||nq'|?????|', nq'|Di�nzi J�y�di� / Dihnj� Geiyikdihp*|'||chr(10)||nq'|Di�nzi C�nchudi�|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pok�block Case|', 3 , q'|Stores Pok�blocks.|' , nq'|???????|', nq'|Polock Case|', nq'|Boite Pok�blocs|', nq'|Pok�riegel Box|', nq'|Porta Pok�melle|', nq'|Tubo Pok�Cubos|', nq'|????????|', nq'|Pok�mon Snack Case|', nq'|????? / ?????|', nq'|Baoke Fangku�i H� / B�uh� Fongfaai Hahp|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Elevator Key|', 3 , q'|Unlocks the Prestige Precept Center's elevator.|' , nq'|????????|'||chr(10)||nq'|?????????|', nq'|Elevator Key|'||chr(10)||nq'|Elevator no Key|', nq'|Cle Ascens.*|'||chr(10)||nq'|Cl� Ascenseur|', nq'|Liftkarte*|'||chr(10)||nq'|Liftschl�ssel|', nq'|Chiave Asc.|'||chr(10)||nq'|Chiave ascensore|', nq'|Ll. Ascensor|'||chr(10)||nq'|Llave Ascensor|', nq'|??????|', nq'|Elevator Key|', nq'|???? / ????|', nq'|Di�nti Y�oshi / Dihntai Yeuhks�h|', 192 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Steel Memory|', 7 , q'|Makes Silvally a Steel-type Pok�mon and makes Multi-Attack a Steel-type move.|' , nq'|???????|', nq'|Steel Memory|', nq'|ROM Acier|', nq'|Stahl-Disc|', nq'|ROM Acciaio|', nq'|Disco Acero|', nq'|?????|', nq'|Steel Memory|', nq'|?????*|'||chr(10)||nq'|?????|', nq'|Gangtie J�y�di� / Gongtit Geiyikdihp*|'||chr(10)||nq'|Gangtie C�nchudi�|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Machine Part|', 2 , q'|The missing part from the Power Plant.|' , nq'|???????|'||chr(10)||nq'|??????|', nq'|Kikai no Buhin|'||chr(10)||nq'|Machine Part|', nq'|Partie de Machine|'||chr(10)||nq'|Piece Meca.|', nq'|Spule|'||chr(10)||nq'|Ersatzteil|', nq'|Pezzo macch.|'||chr(10)||nq'|Meccanismo|', nq'|Maquinaria|'||chr(10)||nq'|Pieza Esp.|', nq'|????|', nq'|Gigye Bupum|', nq'|???? / ????|', nq'|Jixi� L�ngji�n / Geihaaih L�hngg�n|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Permit|', 5 , q'|A permit needed to enter the Nature Preserve. Only a few know about this place.|' , nq'|??????|', nq'|License|', nq'|Permis|', nq'|Genehmigung|', nq'|Permesso|', nq'|Pase|', nq'|???|', nq'|Heogajeung|', nq'|??? / ???|', nq'|Xuke Zh�ng / H�uih� Jing|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Iapapa Berry|', 3 , q'|When HP falls below 25%, restores 50% HP, but confuses Pok�mon that dislike sour food (12.5% when below 50% before Gen. VII).|' , nq'|????|', nq'|Ia no Mi|', nq'|Baie Papaya|', nq'|Yapabeere|', nq'|Baccapaia|', nq'|Baya Pabaya|', nq'|????|', nq'|Paya Yeolmae|', nq'|??? / ???|', nq'|Bay� Guo / Ba'a Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Ultranecrozium Z|', 7 , q'|Allows Necrozma to transform into Ultra Necrozma after fusing with Solgaleo or Lunala, also upgrades Photon Geyser to the special Z-Move Light That Burns the Sky as Ultra Necrozma.|' , nq'|???????Z|', nq'|Ultranecro-Z|', nq'|Ultran�croz�lite|', nq'|Ultranecrozium Z|', nq'|Ultranecrozium Z|', nq'|Ultranecrostal Z|', nq'|??????Z|', nq'|Ultranecro-Z|', nq'|?????Z / ?????Z|', nq'|Jiuj� N�ik�lu�-Z / Gaugihk Noihhaklok-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Toxic Plate|', 4 , q'|Raises the power of Poison-type moves.|' , nq'|????????|', nq'|Moudoku Pureto|', nq'|Plaque Toxic|', nq'|Gifttafel|', nq'|Lastrafiele|', nq'|Tabla T�xica|', nq'|??????|', nq'|Maengdok Plate|', nq'|???? / ????|', nq'|J�d� Sh�ban / Kehkduhk Sehkb�an|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Douse Drive|', 5 , q'|Makes Techno Blast a Water-type move when held by Genesect.|' , nq'|???????|', nq'|Aqua Cassette|', nq'|Module Aqua|', nq'|Aquamodul|', nq'|Idromodulo|', nq'|HidroROM|', nq'|??????|', nq'|Aqua Cassette|', nq'|???? / ????|', nq'|Shuili� Kad�i / S�uil�uh Kaatd�ai|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Krane Memo 5|', 3 , q'|Contains information about the Purify Chamber.|' , nq'|??????5|', nq'|Krane Memo 5|', nq'|Memo Syrus 5|', nq'|Klein-Memo 5|', nq'|Appunti 5|', nq'|Parte C�o 5|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Relic Silver|', 5 , q'|Can be sold for 5000 to the villa owner in Undella Town.|' , nq'|???????|', nq'|Kodai no Ginka|', nq'|Vieil �cu|', nq'|Alter Taler|', nq'|Ducatantico|', nq'|Real Plata|', nq'|?????|', nq'|Godae-yi Eunhwa|', nq'|???? / ????|', nq'|Gud�i Y�nb� / G�doih Ng�hnbaih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Prof's Letter|', 6 , q'|Given to the player's mother in exchange for a Town Map and a Potion.|' , nq'|???????|', nq'|Hakase no Tegami|', nq'|Lettre du Prof|', nq'|Brief vom Prof|', nq'|Lettera del Prof|', nq'|Carta Profesor|', nq'|?????|', nq'|Baksa-ui Pyeonji|', nq'|????|', nq'|B�sh�-de X�n / Boksih-dik Seun|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Razz Berry|', 3 , q'|Pok�block and Poffin ingredient.|' , nq'|????|', nq'|Zuri no Mi|', nq'|Baie Framby|', nq'|Himmihbeere|', nq'|Baccalampon|', nq'|Baya Frambu|', nq'|????|', nq'|Ras Yeolmae|', nq'|???|', nq'|M�nm�i Guo / M�ahnm�ih Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Qualot Berry|', 3 , q'|Raises friendship, but lowers Defense EVs.|' , nq'|?????|', nq'|Tapol no Mi|', nq'|Baie Qualot|', nq'|Qualotbeere|', nq'|Baccaloquat|', nq'|Baya Ispero|', nq'|????|', nq'|Pabi Yeolmae|', nq'|???|', nq'|Biba Guo / B�iba Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Iron Plate|', 4 , q'|Raises the power of Steel-type moves.|' , nq'|????????|', nq'|Koutetsu Pureto|', nq'|Plaque Fer|', nq'|Eisentafel|', nq'|Lastraferro|', nq'|Tabla Acero|', nq'|??????|', nq'|Gangcheol Plate|', nq'|???? / ????|', nq'|Gangtie Sh�ban / Gongtit Sehkb�an|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Wise Glasses|', 4 , q'|Raises the power of special moves.|' , nq'|???????|', nq'|Monoshiri Megane|', nq'|Lunettes Sages|', nq'|Schlauglas|', nq'|Saviocchiali|', nq'|Gafas Especiales|', nq'|????|', nq'|Baksik An-gyeong|', nq'|???? / ????|', nq'|B�sh� Yanj�ng / Boksik Ng�ahngeng|', 144 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Sceptilite|', 6 , q'|Allows Sceptile to Mega Evolve into Mega Sceptile.|' , nq'|????????|', nq'|Jukainnite|', nq'|Jungkite|', nq'|Gewaldronit|', nq'|Sceptilite|', nq'|Sceptilita|', nq'|??????|', nq'|Namukingnite|', nq'|?????? / ??????|', nq'|Xiy�w�ng J�nhu� Sh� / Sikyihkw�hng Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Latiasite|', 6 , q'|Allows Latias to Mega Evolve into Mega Latias.|' , nq'|????????|', nq'|Latiasnite|', nq'|Latiasite|', nq'|Latiasnit|', nq'|Latiasite|', nq'|Latiasita|', nq'|???????|', nq'|Latiasnite|', nq'|??????? / ???????|', nq'|Lad�yasi J�nhu� Sh� / Laaidai'asi Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dragon Fang|', 2 , q'|Raises the power of Dragon-type moves.|' , nq'|??????|', nq'|Ryu no Kiba|', nq'|Croc Dragon|', nq'|Drachenzahn|', nq'|Dentedidrago|', nq'|Colmillo Drag�n|', nq'|????|', nq'|Yong-ui Ippal|', nq'|??? / ???|', nq'|L�ng-zhi Y� / L�hng-ji Ng�h|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Energy Root|', 2 , q'|Restores 200 HP, but lowers friendship.|' , nq'|???????|', nq'|Chikara no Nekko|', nq'|Racine �nergie|', nq'|Kraftwurzel|', nq'|Radicenergia|', nq'|Ra�z Energ�a|', nq'|????|', nq'|Himui Ppuri|', nq'|??? / ???|', nq'|Yu�nq� Gen / Y�hnhei Gan|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Basement Key|', 3 , q'|Allows the player to access New Mauville.|' , nq'|?????|', nq'|Chika no Kagi|', nq'|Cl� Sous-Sol|', nq'|Keller�ffner|', nq'|Chiave sotterr.|', nq'|Llave del S�tano|', nq'|????|', nq'|Jiha Yeolsoe|', nq'|???? / ????|', nq'|D�xi� Y�oshi / Deihhah Yeuhks�h|', 28 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Soft Sand|', 2 , q'|Raises the power of Ground-type moves.|' , nq'|???????|', nq'|Yawarakai Suna|', nq'|Sable Doux|', nq'|Pudersand|', nq'|Sabbia Soffice|', nq'|Arena Fina|', nq'|??????|', nq'|Budeureoun Morae|', nq'|???? / ????|', nq'|R�uruan Shazi / Y�uhy�hn Saj�|', 32 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Burn Drive|', 5 , q'|Makes Techno Blast a Fire-type move when held by Genesect.|' , nq'|????????|', nq'|Blaze Cassette|', nq'|Module Pyro|', nq'|Flammenmodul|', nq'|Piromodulo|', nq'|PiroROM|', nq'|???????|', nq'|Blaze Cassette|', nq'|???? / ????|', nq'|Huoy�n Kad�i / F�yihm Kaatd�ai|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Tea|', 3 , q'|To be given to the thirsty guards to gain entry to Saffron City.|' , nq'|???|', nq'|Ocha|', nq'|The|', nq'|Tee|', nq'|T�|', nq'|T�|', nq'|?|', nq'|Cha|', nq'|?|', nq'|Ch� / Ch�h|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Suite Key|', 4 , q'|Give to NPC in exchange for Lava Cookie.|' , nq'|?????|', nq'|Room Key|', nq'|Cl� Chambre|', nq'|B-Schl�ssel|', nq'|Chiave Suite|', nq'|Llave Suite|', nq'|??|', nq'|Room Key|', nq'|???? / ????|', nq'|F�ngjian Y�oshi / F�hnggaan Yeuhks�h|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Old Charm|', 4 , q'|Cynthia asks the player to deliver to Celestic Town. Is made of Pok�mon bones.|' , nq'|????????|', nq'|Kodai no Omamori|', nq'|Vieux Grigri|', nq'|Talisman|', nq'|Arcamuleto|', nq'|Talism�n|', nq'|?????|', nq'|Godae-ui Bujeok|', nq'|???? / ????|', nq'|Gud�i H�f� / G�doih Wuhf�h|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|X Defend 6|', 5 , q'|Immensely raises a Pok�mon's Defense. Wonder Launcher only.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Retro Mail|', 3 , q'|Mail with a picture of the three Kanto Starter Pok�mon.|' , nq'|??????|', nq'|Retro Mail|', nq'|Lettre Retro|', nq'|Retrobrief|', nq'|Mess. Retro|', nq'|Carta Retro|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|PRZCureBerry|', 2 , q'|Cures paralysis.|' , nq'|???????|', nq'|Mahinaoshi no Mi|', nq'|Baie AntiPAR|', nq'|AntiPARBeere|', nq'|Baccantipar.|', nq'|Antiparabaya|', nq'|??????|', nq'|Mabi Chiryo Yeolmae|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|S.S. Ticket|', 1 , q'|Allows the player to board the S.S. AnneRBYFRLG, S.S. AquaGSCHGSS, or S.S TidalRSEORAS|' , nq'|???????|', nq'|Fune no Ticket|', nq'|Passe Bateau|', nq'|Bootsticket|', nq'|Biglietto Nave|', nq'|Ticket Barco|', nq'|????|', nq'|Seungseon Ticket|', nq'|??|', nq'|Chu�npi�o / Sy�hnpiu|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Air Mail|', 4 , q'|A red- and blue-striped stationery. To be held by a Pok�mon for delivery.|' , nq'|?????|', nq'|Air Mail|', nq'|Lettre Avion|', nq'|Luftbrief|', nq'|Mess. Aereo|', nq'|Carta A�rea|', nq'|????|', nq'|Air Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Ice Gem|', 5 , q'|Increases the power of the holder's first Ice-type move by 50%, and is consumed after use.|' , nq'|????????|', nq'|Kori no Jewel|', nq'|Joyau Glace|', nq'|Eisjuwel|', nq'|Bijoughiaccio|', nq'|Gema Hielo|', nq'|????|', nq'|Eol'eum Jewel|', nq'|???? / ????|', nq'|Bing-zhi Baosh� / Bing-ji B�usehk|', 48 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Draco Plate|', 4 , q'|Raises the power of Dragon-type moves.|' , nq'|????????|', nq'|Ryuu no Pureto|', nq'|Plaque Draco|', nq'|Dracotafel|', nq'|Lastradrakon|', nq'|Tabla Draco|', nq'|??????|', nq'|Yong-ui Plate|', nq'|???? / ????|', nq'|L�ng-zhi Sh�ban / L�hng-ji Sehkb�an|', 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( q'|Data Card|' , nq'|??????|', nq'|Data Card|', nq'|Carte M�mo|', nq'|Datenkarte|', nq'|Scheda Dati|', nq'|Tarjeta Datos|', nq'|?????|', nq'|Data Card|', nq'|???*|'||chr(10)||nq'|???|', nq'|Zili�o Ka / Jil�u Kaat*|'||chr(10)||nq'|Sh�j� Ka|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Gold Bottle Cap|', 7 , q'|Can be traded to Mr. Hyper to maximize all of a Pok�mon's IVs in Hyper Training.|' , nq'|???????|', nq'|Kin no Okan|', nq'|Capsule d'Or|', nq'|Goldkronkorken|', nq'|Tappo d'oro|', nq'|Chapa Dorada|', nq'|???|', nq'|Geum Wanggwan|', nq'|????|', nq'|Jins� W�ngguan / Gamsik W�hnggun|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Kangaskhanite|', 6 , q'|Allows Kangaskhan to Mega Evolve into Mega Kangaskhan.|' , nq'|???????|', nq'|Garuranite|', nq'|Kangourexite|', nq'|Kangamanit|', nq'|Kangaskhanite|', nq'|Kangaskhanita|', nq'|?????|', nq'|Kengkanite|', nq'|????? / ?????|', nq'|D�ish�u J�nhu� Sh� / Doihsau Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Colbur Berry|', 4 , q'|Reduces damage from a super effective Dark-type move by 50%.|' , nq'|????|', nq'|Namo no Mi|', nq'|Baie Lampou|', nq'|Burleobeere|', nq'|Baccaxan|', nq'|Baya Dillo|', nq'|????|', nq'|Mako Yeolmae|', nq'|???|', nq'|C�'er Guo / Chiy�h Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Luminous Moss|', 6 , q'|Raises the holder's Special Defense by one stage after being hit by a Water-type attack. Consumed after use.|' , nq'|?????|', nq'|Hikari Goke|', nq'|Lichen Lumineux|', nq'|Leuchtmoos|', nq'|Muschioluce|', nq'|Musgo Brillante|', nq'|???|', nq'|Bit Ikki|', nq'|??|', nq'|Guangt�i / Gwongt�ih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Choice Band|', 3 , q'|Raises user's Attack, but they can only use one move.|' , nq'|????????|', nq'|Kodawari Hachimaki|', nq'|Bandeau Choix|', nq'|Wahlband|', nq'|Bendascelta|', nq'|Cinta Elegida|', nq'|?????|', nq'|Guae Meoritti|', nq'|???? / ????|', nq'|Jiangji� T�ud�i / G�nggau T�uhdaai|', 144 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|PP Up|', 1 , q'|Raises the PP of a move.|' , nq'|???????|', nq'|Point Up|', nq'|PP Plus|', nq'|AP-Plus|', nq'|PP-Su|', nq'|M�s PP|', nq'|??? ?|', nq'|Point Up|', nq'|PP??? / PP???|', nq'|PP T�shengj� / PP T�ihsingjaih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Net Ball|', 3 , q'|A type of Pok� Ball that works better on Water- and Bug-type Pok�mon.|' , nq'|??????|', nq'|Net Ball|', nq'|Filet Ball|', nq'|Netzball|', nq'|Rete Ball|', nq'|Malla Ball|', nq'|???|', nq'|Net Ball|', nq'|??? / ???|', nq'|Buwang Qi� / Bouhm�hng K�uh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Choice Specs|', 4 , q'|Raises user's Special Attack, but they can only use one move.|' , nq'|???????|', nq'|Kodawari Megane|', nq'|Lunettes Choix|', nq'|Wahlglas|', nq'|Lentiscelta|', nq'|Gafas Elegid|', nq'|????|', nq'|Guae An-gyeong|', nq'|???? / ????|', nq'|Jiangji� Yanj�ng / G�nggau Ng�ahngeng|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Red Petal|', 7 , q'|A red petal required to complete Mina's Trial.|' , nq'|???????|', nq'|Aka no Hanabira|', nq'|P�tale Rouge|', nq'|Rotes Blatt|', nq'|Petalo rosso|', nq'|P�talo Rojo|', nq'|????|', nq'|Ppalgang Kkochip|', nq'|???? / ????|', nq'|H�ng-s� Huab�n / H�hng-sik Faf�an|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Ice Heal|', 1 , q'|Thaws out a frozen Pok�mon.|' , nq'|??????|', nq'|Kori Naoshi|', nq'|Antigel|', nq'|Eisheiler|', nq'|Antigelo|', nq'|Antihielo|', nq'|???????|', nq'|Eoreum Sangtae Chiryoje|', nq'|??? / ???|', nq'|Jied�ngy�o / G�aidungyeuhk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Magma Emblem|', 3 , q'|Allows entrance into the Team Magma Hideout.|' , nq'|???????|', nq'|Magma no Shirushi|', nq'|Embl�me Magma|', nq'|Magmaemblem|', nq'|Stemma Magma|', nq'|Signo Magma|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Moon Shard|', 3 , q'|Allows Eevee to evolve into Umbreon in Pok�mon XD: Gale of Darkness.|' , nq'|??????|', nq'|Tsuki no Kakera|', nq'|Eclat Lune|', nq'|Mondsplitter|', nq'|Coccio Lunare|', nq'|�pice Luna|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Favored Mail|', 5 , q'|Stationary designed for writing about your favorite things. To be held by a Pok�mon for delivery.|' , nq'|???????|', nq'|Daisuki Mail|', nq'|Lettre Fan|', nq'|Faiblebrief|', nq'|Mess. TVB|', nq'|C. Favoritos|', nq'|????|', nq'|Aeho Mail|', nq'|???? / ????|', nq'|Xi'�i Y�uji�n / H�i'oi Y�uhg�n|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Big Pearl|', 2 , q'|Can be sold for 3750.|' , nq'|????????|', nq'|Okina Shinju|', nq'|Grande Perle|', nq'|Riesenperle|', nq'|Grande Perla|', nq'|Perla Grande|', nq'|???|', nq'|Keun Jinju|', nq'|???|', nq'|D� Zhenzhu / Daaih Janjyu|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Reply Mail|', 5 , q'|Stationary for writing a reply. To be held by a Pok�mon for delivery.|' , nq'|???????|', nq'|Okaeshi Mail|', nq'|Let. R�ponse|', nq'|R�ckbrief|', nq'|Mess. Risp.|', nq'|C. Respuesta|', nq'|????|', nq'|Dapjang Mail|', nq'|???? / ????|', nq'|Hu�f� Y�uji�n / W�ihfuk Y�uhg�n|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Electric Seed|', 7 , q'|A one-time use item that raises the holder's Defense by one stage upon activation of Electric Terrain.|' , nq'|??????|', nq'|Electric Seed|', nq'|Graine �lectrik|', nq'|Elektro-Samen|', nq'|Elettroseme|', nq'|Semilla Electro|', nq'|??????|', nq'|Electric Seed|', nq'|???? / ????|', nq'|Di�nq� Zhongzi / Dihnhei J�ngj�|', 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( q'|Mega Bracelet|' , nq'|??????|', nq'|Mega Bangle|', nq'|M�ga-Bracelet|', nq'|Mega-Armreife|', nq'|Megabracciale|', nq'|Megapulsera|', nq'|????|', nq'|Mega Bangle|', nq'|???? / ????|', nq'|Chaoj� Shouzhu� / Chiukap S�ujuhk|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Seal Case|', 4 , q'|Holds Seals.|' , nq'|?????|', nq'|Seal Ire|', nq'|Bo�te Sceaux|', nq'|Stick.Koffer|', nq'|Portabolli|', nq'|Caja Sellos|', nq'|???|', nq'|Seal Sangja|', nq'|??? / ???|', nq'|Tiezhi H� / Tipj� Hahp|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Old Rod|', 1 , q'|Can be used in or next to water to initiate a battle with a low-level aquatic Pok�mon.|' , nq'|???????|', nq'|Boro no Tsurizao|', nq'|Canne|', nq'|Angel|', nq'|Amo Vecchio|', nq'|Ca�a Vieja|', nq'|?????|', nq'|Nalgeun Naksitdae|', nq'|???? / ????|', nq'|P�ji� Di�ogan / Pogauh Diugon|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Prism Scale|', 5 , q'|A hold item that allows Feebas to evolve when traded.|' , nq'|???????|', nq'|Kireina Uroko|', nq'|Bel'�caille|', nq'|Sch�nschuppe|', nq'|Squama Bella|', nq'|Escama Bella|', nq'|????|', nq'|Goun Bineul|', nq'|???? / ????|', nq'|Meil� L�npi�n / M�ihlaih L�uhnpin|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Polkadot Bow|', 2 , q'|Raises the power of Normal-type moves.|' , nq'|???????|', nq'|Mizutama Ribbon|', nq'|Ruban � Pois|', nq'|Punkt-Band|', nq'|Fiocco Pois|', nq'|Cintalunares|', nq'|?????|', nq'|Mulbang-ul Ribon|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|TMs (50-100 different)|', 1 , q'|One-time use items that can teach moves to Pok�mon.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Nanab Berry|', 3 , q'|Pok�block and Poffin ingredient.|' , nq'|????|', nq'|Nana no Mi|', nq'|Baie Nanab|', nq'|Nanabbeere|', nq'|Baccabana|', nq'|Baya Latano|', nq'|????|', nq'|Nana Yeolmae|', nq'|???|', nq'|Jiaoxiang Guo / Jiuheung Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Sparkling Stone|', 7 , q'|Given to Hala to make a Z-RingSM or Z-Power RingUSUM.|' , nq'|??????|', nq'|Kagayaku Ishi|', nq'|Gemme Lumi�re|', nq'|Glitzerstein|', nq'|Pietra lucente|', nq'|Piedra Brillante|', nq'|????|', nq'|Bichnaneun Dol|', nq'|??? / ???|', nq'|Guanghui Sh� / Gwongfai Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Flame Orb|', 4 , q'|Inflicts a burn on the holder.|' , nq'|?????|', nq'|Kaen Dama|', nq'|Orbe Flamme|', nq'|Hei�-Orb|', nq'|Fiammosfera|', nq'|Llamasfera|', nq'|????|', nq'|Hwayeom Guseul|', nq'|???? / ????|', nq'|Huoy�n Baozhu / F�yihm B�ujyu|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Carbos|', 1 , q'|Raises the Speed of a Pok�mon.|' , nq'|???????|', nq'|Indometacin|', nq'|Carbone|', nq'|Carbon|', nq'|Carburante|', nq'|Carburante|', nq'|?????|', nq'|Alkaloid|', nq'|????? / ?????|', nq'|S�d� Zengqi�ngj� / Chukdouh Jangk�uhngjaih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Repeat Ball|', 3 , q'|A type of Pok� Ball that works better on Pok�mon already caught before.|' , nq'|???????|', nq'|Repeat Ball|', nq'|Bis Ball|', nq'|Wiederball|', nq'|Bis Ball|', nq'|Acopio Ball|', nq'|????|', nq'|Ripideu Ball|', nq'|??? / ???|', nq'|Ch�ngf� Qi� / Ch�hngfuk K�uh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Mirage Mail|', 2 , q'|Mail with a Mew pattern. Available only through Mystery Gift. To be held by a Pok�mon for delivery.|' , nq'|???????|', nq'|Maboroshi Mail|', nq'|Lettre Mirage|', nq'|Trugbrief|', nq'|Mess. Visione|', nq'|C.Espejismo|', nq'|?????|', nq'|Hwansang-ui Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Surprise Mulch|', 6 , q'|When applied to a Berry patch, increases the chance of Berry mutation.|' , nq'|???????|', nq'|Bikkuri Koyashi|', nq'|Fertistantan�|', nq'|Wundermulch|', nq'|Fertilsorpresa|', nq'|Abono Sorpresa|', nq'|????|', nq'|Kkamnol Biryo|', nq'|??? / ???|', nq'|Chijing F�i / Hekging F�ih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Portraitmail|', 2 , q'|Mail that contains a silhouette of the Pok�mon holding it. To be held by a Pok�mon for delivery.|' , nq'|???????|', nq'|Nigaoe Mail|', nq'|LetrPortrait|', nq'|Portraitbrief|', nq'|Mess. Ritratto|', nq'|Cart-Retrato|', nq'|?????|', nq'|Chosanghwa Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Leppa Berry|', 3 , q'|Restores 10 PP.|' , nq'|?????|', nq'|Himeri no Mi|', nq'|Baie Mepo|', nq'|Jonagobeere|', nq'|Baccamela|', nq'|Baya Zanama|', nq'|????|', nq'|Gwasa Yeolmae|', nq'|??? / ???|', nq'|P�ngye Guo / P�hngy�h Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lumiose Galette|', 6 , q'|Cures any status condition.|' , nq'|???????|', nq'|Miare Galette|', nq'|Galette Illumis|', nq'|Illumina-Galette|', nq'|Pan di Lumi|', nq'|Cr�pe Luminalia|', nq'|?????|', nq'|Mireu Galette|', nq'|??????? / ???????|', nq'|M�'al�i G�l�i P�ibing / Maht'al�uih Gaakl�uih Paaib�ng|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Fighting Gem|', 5 , q'|Increases the power of the holder's first Fighting-type move by 50%, and is consumed after use.|' , nq'|????????|', nq'|Kakuto Jewel|', nq'|Joyau Combat|', nq'|Kampfjuwel|', nq'|Bijoulotta|', nq'|Gema Lucha|', nq'|????|', nq'|Gyeoktu Jewel|', nq'|???? / ????|', nq'|G�d�u Baosh� / Gaakdau B�usehk|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Rainbow Pass|', 3 , q'|Allows the player access to all of the Sevii Islands.|' , nq'|???????|', nq'|Rainbow Pass|', nq'|Passe Prisme|', nq'|Bunt-Pass|', nq'|Sette Pass|', nq'|Iris-Ticket|' , 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( q'|Ilima's Normalium Z|' , nq'|????????Z|', nq'|Irima no Normal Z|', nq'|Cristal Z Alth�o|', nq'|Elimas Normium Z|', nq'|Normium Z Liam|', nq'|Cristal Z (Liam)|', nq'|???? ??Z|', nq'|Illima-ui Normal-Z|', nq'|??????Z / ??????Z|', nq'|Yil�ma-de Yiban-Z / Yileihm�h-dik Yatbun-Z|' );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Key to Room 1|', 6 , q'|Opens Room 1 of the Abandoned ShipRSE/Sea MauvilleORAS.|', q'|Called Rm. 1 Key in Generation III.|', nq'|?????????|', nq'|Ichi-go Shitsu no Kagi|', nq'|Cl� Salle 1|', nq'|R1-Schl�ssel|', nq'|Chiave stanza 1|', nq'|Ll. Habitaci�n 1|', nq'|?????|', nq'|Il-hosil Yeolsoe|', nq'|1?????? /|'||chr(10)||nq'|1??????|', nq'|1 H�o K�f�ng-de Y�oshi / 1 Houh Haakf�ng-dik Yeuhks�h|', 1616 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Mewnium Z|', 7 , q'|Allows Mew to upgrade Psychic to the special Z-Move Genesis Supernova.|' , nq'|???Z|', nq'|Mew-Z|', nq'|Mewz�lite|', nq'|Mewnium Z|', nq'|Mewnium Z|', nq'|Mewstal Z|', nq'|?Z|', nq'|Mew-Z|', nq'|??Z / ??Z|', nq'|M�nghu�n-Z / Muhngwaahn-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Fairium Z|', 7 , q'|Allows a Pok�mon to upgrade their Fairy-type damaging moves to the Z-Move Twinkle Tackle or upgrade their Fairy-type status moves into Z-Moves. Makes Arceus a Fairy-type Pok�mon.|' , nq'|?????Z|', nq'|Fairy-Z|', nq'|Nymph�z�lite|', nq'|Sylphium Z|', nq'|Follectium Z|', nq'|Feeristal Z|', nq'|???Z|', nq'|Fairy-Z|', nq'|??Z|', nq'|Yaojing-Z / Y�ujing-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Zinc|', 3 , q'|Raises the Special Defense of a Pok�mon.|' , nq'|????|', nq'|Chitosan|', nq'|Zinc|', nq'|Zink|', nq'|Zinco|', nq'|Zinc|', nq'|???|', nq'|Chitosan|', nq'|????? / ?????|', nq'|PP T�shengj� / PP T�ihsingjaih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Magma Stone|', 5 , q'|Allows the player to battle Heatran.|' , nq'|????????|', nq'|Kazan no Okiishi|', nq'|Pierre Magma|', nq'|Magmastein|', nq'|Magmapietra|', nq'|Piedra Magma|', nq'|??? ?|', nq'|Hwasan-ui Dol|', nq'|???? / ????|', nq'|Huoshan Zh�nsh� / F�saan Jansehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|X Defend 3|', 5 , q'|Drastically raises a Pok�mon's Defense. Wonder Launcher only.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Friend Ball|', 2 , q'|A type of Pok� Ball that causes the Pok�mon to become friendly.|' , nq'|???????|', nq'|Friend Ball|', nq'|Copain Ball|', nq'|Freundesball|', nq'|Friend Ball|', nq'|Amigo Ball|', nq'|????|', nq'|Friend Ball|', nq'|???|', nq'|Youyou Qi� / Y�uhy�uh K�uh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Big Malasada|', 7 , q'|Used to heal poison, paralysis, sleep, burn, freeze, and confusion.|' , nq'|????????|', nq'|Oki Malasada|', nq'|Malasada Maxi|', nq'|Maxi-Malasada|', nq'|Malasada maxi|', nq'|Malasada Maxi|', nq'|? ????|', nq'|Keun Malasada|', nq'|????? / ?????|', nq'|D� Malas�d� / Daaih M�hlaaisaatdaaht|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Twisted Spoon|', 2 , q'|Raises the power of Psychic-type moves.|', q'|Formatted as TwistedSpoon prior to Generation VI.|', nq'|????????|', nq'|Magatta Spoon|', nq'|Cuiller Tordue|', nq'|Kr�mml�ffel|', nq'|Cucchiaio Torto|', nq'|Cuchara Torcida|', nq'|?????|', nq'|Hwieojin Spoon|', nq'|????? / ?????|', nq'|Wanqu-de Tangch� / Waankuk-dik Tongch�h|', 1184 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( q'|Left Pok� Ball|' , nq'|????????|', nq'|Nokosareta Ball|', nq'|Pok� Ball donn�e|', nq'|Nachlassball|', nq'|Pok� Ball altrui|', nq'|Pok� Ball Ajena|', nq'|??? ?|', nq'|Namgyeojin Ball|', nq'|?????? / ??????|', nq'|Li�xi�-de Jingl�ngqi� / L�uhhah-dik Jingl�hng K�uh|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Fairy Gem|', 6 , q'|Increases the power of the holder's first Fairy-type move by 50%, and is consumed after use.|' , nq'|?????????|', nq'|Fairy Jewel|', nq'|Joyau F�e|', nq'|Feenjuwel|', nq'|Bijoufolletto|', nq'|Gema Hada|', nq'|?????|', nq'|Fairy Jewel|', nq'|???? / ????|', nq'|Yaojing Baosh� / Yiujing B�usehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Member Card|', 4 , q'|Allows access to the Canalave City hotel to face Darkrai.|' , nq'|????????|', nq'|Member's Card|', nq'|Carte Membre|', nq'|Mitgl.Karte|', nq'|Scheda Soci|', nq'|Carn� Socio|', nq'|?????|', nq'|Membership Card|', nq'|??? / ???|', nq'|Hu�yu�n Ka / W�iy�hn Kaat|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Clever Wing|', 5 , q'|Raises the Special Defense of a Pok�mon.|' , nq'|???????|', nq'|Seishin no Hane|', nq'|Aile Mental|', nq'|Espritfeder|', nq'|Piumintuito|', nq'|Pluma Mente|', nq'|?????|', nq'|Jeongsinryeok Nalgae|', nq'|????|', nq'|Jingsh�n-zhi Yu / Jings�hn-ji Y�h|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Mystery Egg|', 2 , q'|Hatches into Togepi.|' , nq'|???????|', nq'|Fushigina Tamago|', nq'|�uf Myst�re|', nq'|R�tsel-Ei|', nq'|Uovo Mistero|', nq'|Huevo Mist|', nq'|????|', nq'|Isanghan Al|', nq'|???|', nq'|Sh�nq� D�n / S�hnk�ih D�an|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Level Ball|', 2 , q'|A type of Pok� Ball that works better on Pok�mon with a lower level than the player's.|' , nq'|??????|', nq'|Level Ball|', nq'|Niveau Ball|', nq'|Levelball|', nq'|Level Ball|', nq'|Nivel Ball|', nq'|???|', nq'|Level Ball|', nq'|??? / ???|', nq'|Dengj� Qi� / D�ngkap K�uh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Aloraichium Z|', 7 , q'|Allows Alolan Raichu to upgrade Thunderbolt to the special Z-Move Stoked Sparksurfer.|' , nq'|????Z|', nq'|Alorai-Z|', nq'|Alora�z�lite|', nq'|A-Raichunium Z|', nq'|Aloraicium Z|', nq'|Alo-Raistal Z|', nq'|????Z|', nq'|Allorai-Z|', nq'|???Z / ???Z|', nq'|Alu�l�i-Z / Al�hl�uih-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Luck Incense|', 4 , q'|Causes earnings to double in battles against other Trainers. A Chansey or Blissey holding it can breed to produce a Happiny.|' , nq'|????????|', nq'|Koun no Oko|', nq'|Encens Veine|', nq'|Gl�cksrauch|', nq'|Fortunaroma|', nq'|Incienso duplo|', nq'|?????|', nq'|Haeng-unui Hyangno|', nq'|???? / ????|', nq'|X�ngy�n Xunxiang / Hahngwahn Fanheung|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Music Disc|', 3 , q'|Allows a change of music in Trest's house.|' , nq'|???????|', nq'|Ongaku Soft|', nq'|CD Musique|', nq'|Musik-CD|', nq'|CD Musicale|', nq'|Disco M�sica|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|GB Sounds|', 4 , q'|Allows player to listen to 8-bit background music in Johto.|' , nq'|GB?????|', nq'|GB Player|', nq'|Lecteur GB|', nq'|GB-Player|', nq'|Lettore GB|', nq'|Lector GB|', nq'|GB????|', nq'|GB Player|', nq'|GB???|', nq'|GB Bof�ng Q� / GB Bofong Hei|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Cameruptite|', 6 , q'|Allows Camerupt to Mega Evolve into Mega Camerupt.|' , nq'|???????|', nq'|Bakuudanite|', nq'|Cam�ruptite|', nq'|Cameruptnit|', nq'|Cameruptite|', nq'|Cameruptita|', nq'|?????|', nq'|Poktanite|', nq'|?????? / ??????|', nq'|Penhuotu� J�nhu� Sh� / Panf�t�h Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Water Memory|', 7 , q'|Makes Silvally a Water-type Pok�mon and makes Multi-Attack a Water-type move.|' , nq'|????????|', nq'|Water Memory|', nq'|ROM Eau|', nq'|Wasser-Disc|', nq'|ROM Acqua|', nq'|Disco Agua|', nq'|?????|', nq'|Water Memory|', nq'|?????*|'||chr(10)||nq'|?????|', nq'|Qingshui J�y�di� / Chings�ui Geiyikdihp*|'||chr(10)||nq'|Qingshui C�nchudi�|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|Touga Berry|', 3 , q'|Cures Confusion. If transferred to Generation IV via Pal Park, it will turn into an Enigma Berry.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Latiosite|', 6 , q'|Allows Latios to Mega Evolve into Mega Latios.|' , nq'|????????|', nq'|Latiosnite|', nq'|Latiosite|', nq'|Latiosnit|', nq'|Latiosite|', nq'|Latiosita|', nq'|???????|', nq'|Latiosnite|', nq'|??????? / ???????|', nq'|Lad�'ousi J�nhu� Sh� / Laaidai'ausi Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Rocky Helmet|', 5 , q'|Any contact moves against the holder will deal 1/6 damage to the attacker.|' , nq'|???????|', nq'|Gotsugotsu Met|', nq'|Casque Brut|', nq'|Beulenhelm|', nq'|Bitorzolelmo|', nq'|Casco Dentado|', nq'|?????|', nq'|Ultungbultung-Met|', nq'|???? / ????|', nq'|Tutu T�ukui / Dahtdaht T�uhkwai|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Teachy TV|', 3 , q'|Gives tutorials of game functions.|' , nq'|??????|', nq'|Oshie Televi|', nq'|TV ABC|', nq'|Lehrkanal|', nq'|Pok� TV|', nq'|Pok� Tele|', nq'|???TV|', nq'|Gareuchim TV|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Rock Gem|', 5 , q'|Increases the power of the holder's first Rock-type move by 50%, and is consumed after use.|' , nq'|???????|', nq'|Iwa no Jewel|', nq'|Joyau Roche|', nq'|Gesteinsjuwel|', nq'|Bijouroccia|', nq'|Gema Roca|', nq'|????|', nq'|Bawi Jewel|', nq'|???? / ????|', nq'|Y�nsh� Baosh� / Ng�ahmsehk B�usehk|', 80 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Genius Wing|', 5 , q'|Raises the Special Attack of a Pok�mon.|' , nq'|???????|', nq'|Chiryoku no Hane|', nq'|Aile Esprit|', nq'|Geniefeder|', nq'|Piumingegno|', nq'|Pluma Intelecto|', nq'|????|', nq'|Jiryeok Nalgae|', nq'|????|', nq'|Zh�l�-zhi Yu / Jilihk-ji Y�h|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Blazikenite|', 6 , q'|Allows Blaziken to Mega Evolve into Mega Blaziken.|' , nq'|????????|', nq'|Bursyamonite|', nq'|Bras�galite|', nq'|Lohgocknit|', nq'|Blazikenite|', nq'|Blazikenita|', nq'|??????|', nq'|Bunchikonite|', nq'|?????? / ??????|', nq'|Huoy�nji J�nhu� Sh� / F�yihmgai Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Ice Stone|', 7 , q'|Can be used to evolve Alolan Sandshrew and Alolan Vulpix.|' , nq'|??????|', nq'|Kori no Ishi|', nq'|Pierre Glace|', nq'|Eisstein|', nq'|Pietragelo|', nq'|Piedra Hielo|', nq'|????|', nq'|Eoreum-ui Dol|', nq'|???|', nq'|Bing-zhi Sh� / Bing-ji Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Houndoominite|', 6 , q'|Allows Houndoom to Mega Evolve into Mega Houndoom.|' , nq'|??????|', nq'|Hellganite|', nq'|D�molossite|', nq'|Hundemonit|', nq'|Houndoomite|', nq'|Houndoomita|', nq'|?????|', nq'|Helganite|', nq'|?????? / ??????|', nq'|Heilujia J�nhu� Sh� / Hakl�uhga Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|DNA Sample|', 3 , q'|Used to deduce the code to a lock in the Shadow PKMN Lab.|' , nq'|DNA????|', nq'|DNA Sample|', nq'|Echantillon ADN|', nq'|DNS-Probe|', nq'|Campione DNA|', nq'|Muestra ADN|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Coupon 3|', 4 , q'|Used to obtain the Pok�tch in Jubilife City.|' , nq'|??????3|', nq'|Hikikaeken 3|', nq'|Bon 3|', nq'|Kupon 3|', nq'|Coupon 3|', nq'|Cup�n 3|', nq'|??? 3|', nq'|Gyohwangwon 3|', nq'|???3 / ???3|', nq'|Du�hu�n Qu�n 3 / Deuiwuhn Hyun 3|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Sticky Barb|', 4 , q'|Damages the holder. May latch onto the foe if a physical move is used and the foe is not already holding an item.|' , nq'|??????|', nq'|Kuttsuki Bari|', nq'|Piquants|', nq'|Klettdorn|', nq'|Vischiopunta|', nq'|Toxiestrella|', nq'|??????|', nq'|Kkeunjeokkkeunjeok Baneul|', nq'|??? / ???|', nq'|F�zhu� Zhen / Fuhjeuhk Jam|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dragon Memory|', 7 , q'|Makes Silvally a Dragon-type Pok�mon and makes Multi-Attack a Dragon-type move.|' , nq'|???????|', nq'|Dragon Memory|', nq'|ROM Dragon|', nq'|Drachen-Disc|', nq'|ROM Drago|', nq'|Disco Drag�n|', nq'|??????|', nq'|Dragon Memory|', nq'|????*|'||chr(10)||nq'|????|', nq'|L�ng J�y�di� / L�hng Geiyikdihp*|'||chr(10)||nq'|L�ng C�nchudi�|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Scizorite|', 6 , q'|Allows Scizor to Mega Evolve into Mega Scizor.|' , nq'|???????|', nq'|Hassamnite|', nq'|Cizayoxite|', nq'|Scheroxnit|', nq'|Scizorite|', nq'|Scizorita|', nq'|?????|', nq'|Hatsamnite|', nq'|??????? / ???????|', nq'|J�qi�nt�ngl�ng J�nhu� Sh� / Geuihk�hmt�hngl�hng Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Revival Herb|', 2 , q'|Revives a Pok�mon to full HP, but lowers friendship.|' , nq'|??????|', nq'|Fukkatsu So|', nq'|Herbe Rappel|', nq'|Vitalkraut|', nq'|Vitalerba|', nq'|Hierba Revivir|', nq'|?? ?|', nq'|Buhwal Cho|', nq'|??? / ???|', nq'|F�hu� Cao / Fuhkwuht Ch�u|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|RageCandyBar|', 2 , q'|In Johto, can be exchanged for TM64.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Honor of Kalos|', 6 , q'|Proof of defeating Team Flare and becoming Champion of the Kalos Pok�mon League.|' , nq'|????????|', nq'|Kalos Emblem|', nq'|Insigne de Kalos|', nq'|Kalos-Emblem|', nq'|Emblema di Kalos|', nq'|Emblema de Kalos|', nq'|??????|', nq'|Kalos Emblem|', nq'|????? / ?????|', nq'|Kalu�si Xunzhang / Kaloksi Fanjeung|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Thanks Mail|', 5 , q'|Stationary designed for a thank you note. To be held by a Pok�mon for delivery.|' , nq'|???????|', nq'|Kansha Mail|', nq'|Lettre Merci|', nq'|Dankesbrief|', nq'|Mess. Grazie|', nq'|C. Gracias|', nq'|????|', nq'|Gamsa Mail|', nq'|???? / ????|', nq'|Ganxi� Y�uji�n / G�mjeh Y�uhg�n|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Red Nectar|', 7 , q'|Changes Oricorio to its Baile Style.|' , nq'|???????|', nq'|Kurenai no Mitsu|', nq'|Nectar Rouge|', nq'|Roter Nektar|', nq'|Nettare rosso|', nq'|N�ctar Rojo|', nq'|???|', nq'|Dahong Kkul|', nq'|?????|', nq'|Zhuh�ng-s� Huam� / Jyuh�hng-sik Famaht|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Aggronite|', 6 , q'|Allows Aggron to Mega Evolve into Mega Aggron.|' , nq'|????????|', nq'|Bossgodoranite|', nq'|Galekingite|', nq'|Stollossnit|', nq'|Aggronite|', nq'|Aggronita|', nq'|???????|', nq'|Bosroranite|', nq'|???????? / ????????|', nq'|Bosh�keduola J�nhu� Sh� / Bosihh�dolaai Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|X Sp. Def 6|', 5 , q'|Immensely raises a Pok�mon's Special Defense. Wonder Launcher only.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Fashion Case|', 4 , q'|Stores Accessories.|' , nq'|????????|', nq'|Accessory Ire|', nq'|Coffret Mode|', nq'|Modekoffer|', nq'|Scatola Chic|', nq'|Caja Coraz�n|', nq'|??????|', nq'|Accessory Sangja|', nq'|??? / ???|', nq'|Sh�pin H� / Sikb�n Hahp|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Plume Fossil|', 5 , q'|A Fossil from which an Archen can be resurrected.|' , nq'|??????|', nq'|Hane no Kaseki|', nq'|Fossile Plume|', nq'|Federfossil|', nq'|Fossilpiuma|', nq'|F�sil Pluma|', nq'|????|', nq'|Nalgae Hwaseok|', nq'|????|', nq'|Yum�o Hu�sh� / Y�hm�uh Fasehk|', 128 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( q'|Mega Charm|' , nq'|??????|', nq'|Mega Charm|', nq'|M�ga-Charme|', nq'|Megaillon|', nq'|Megaciondolo|', nq'|Megacolgante|', nq'|????|', nq'|Mega Charm|', nq'|???? / ????|', nq'|Chaoj� Zhu�sh� / Chiukap Jeuihsik|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Oval Charm|', 5 , q'|An oval charm said to increase the chance of Eggs being found at the Day Care.|' , nq'|???????|', nq'|Round Charm|', nq'|Charme Ovale|', nq'|Ovalpin|', nq'|Ovamuleto|', nq'|Amuleto Oval|', nq'|????|', nq'|Dunggeun Bujeok|', nq'|???? / ????|', nq'|Yu�nx�ng H�f� / Y�hny�hng Wuhf�h|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Life Orb|', 4 , q'|Raises the power of moves, but causes recoil damage.|' , nq'|??????|', nq'|Inochi no Tama|', nq'|Orbe Vie|', nq'|Leben-Orb|', nq'|Assorbisfera|', nq'|Vidasfera|', nq'|?????|', nq'|Saengmyeong-ui Guseul|', nq'|???? / ????|', nq'|Shengm�ng Baozhu / Sangmihng B�ujyu|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Normal Box|', 2 , q'|Sometimes held by reward Pok�mon from clearing Gym Leader Castle in Pok�mon Stadium when traded to Generation II or Pok�mon Stadium 2.|' , nq'|????|', nq'|Ki no Hako|', nq'|Coffre Normal|', nq'|Schachtel|', nq'|Scat. Normale|', nq'|Caja Normal|', nq'|????|', nq'|Namu Sangja|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Yellow Shard|', 3 , q'|Exchangeable for a variety of services.|' , nq'|???????|', nq'|Kiiroi Kakera|', nq'|Tesson Jaune|', nq'|Gelbst�ck|', nq'|Coccio Giallo|', nq'|Parte Amarilla|', nq'|????|', nq'|Norang Jogak|', nq'|???? / ????|', nq'|Hu�ngs� Su�pi�n / W�hngsik Seuipin|', 48 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lustrous Orb|', 4 , q'|Boosts Palkia's Water- and Dragon-type attacks.|' , nq'|????|', nq'|Shiratama|', nq'|Orbe Perl�|', nq'|Wei�-Orb|', nq'|Splendisfera|', nq'|Lustresfera|', nq'|??|', nq'|Baegok|', nq'|???? / ????|', nq'|B�iy� Baozhu / Baahkyuhk B�ujyu|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Park Ball|', 4 , q'|A type of Pok� Ball that is used to recapture Generation III Pok�mon in the Pal Park.|' , nq'|??????|', nq'|Park Ball|', nq'|Parc Ball|', nq'|Parkball|', nq'|Parco Ball|', nq'|Parque Ball|', nq'|???|', nq'|Park Ball|', nq'|??? / ???|', nq'|Gongyu�n Qi� / Gungy�n K�uh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Metagrossite|', 6 , q'|Allows Metagross to Mega Evolve into Mega Metagross.|' , nq'|????????|', nq'|Metagrossnite|', nq'|M�talossite|', nq'|Metagrossnit|', nq'|Metagrossite|', nq'|Metagrossita|', nq'|????????|', nq'|Metagrossnite|', nq'|?????? / ??????|', nq'|J�jingu�i J�nhu� Sh� / Geuihgamgwaai Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Meteorite Shard|', 6 , q'|To be delivered to Steven Stone and Professor Cozmo.|' , nq'|????????|', nq'|Inseki no Kakera|', nq'|�clat M�t�orite|', nq'|Meteoritenst�ck|', nq'|Framm. meteorite|', nq'|Frag. Meteorito|', nq'|????|', nq'|Unseok Jogag|', nq'|???? / ????|', nq'|Yunsh� su�pi�n / W�hnsehk Seuip�n|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Rose Incense|', 4 , q'|Raises the power of Grass-type moves. Roselia and Roserade holding this can breed Budew.|' , nq'|???????|', nq'|Ohana no Oko|', nq'|Encens Fleur|', nq'|Rosenrauch|', nq'|Rosaroma|', nq'|Incienso floral|', nq'|???|', nq'|Kkoch Hyangno|', nq'|????|', nq'|Huaduo Xunxiang / Fad� Fanheung|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Petaya Berry|', 3 , q'|Raises Special Attack if HP is below ? of maximum.|' , nq'|?????|', nq'|Yatapi no Mi|', nq'|Baie Pitaye|', nq'|Tahaybeere|', nq'|Baccapitaya|', nq'|Baya Yapati|', nq'|?????|', nq'|Yatabi Yeolmae|', nq'|??? / ???|', nq'|L�nghuo Guo / L�hngf� Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Brick Piece|', 2 , q'|Can be sold for 50.|' , nq'|???????|', nq'|Kawara no Kakera|', nq'|Morc. Brique|', nq'|Ziegelstein|', nq'|Mattoncino|', nq'|Ladrillo|', nq'|????|', nq'|Giwa Jogak|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Soda Pop|', 1 , q'|Restores 50 HP. (60HP before Gen. VII).|' , nq'|??????|', nq'|Saiko Soda|', nq'|Soda Cool|', nq'|Sprudel|', nq'|Gassosa|', nq'|Refresco|', nq'|??????|', nq'|Mineral Cider|', nq'|???? / ????|', nq'|J�nshuang Q�shui / Gihngs�ng Heis�ui|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Morph Mail|', 2 , q'|Mail with a Ditto design. To be held by a Pok�mon for delivery.|' , nq'|???????|', nq'|Henshin Mail|', nq'|Lettre Morph|', nq'|Morph-Brief|', nq'|Mess. Morph|', nq'|Cartmorfosis|', nq'|????|', nq'|Byeonsin Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Psychic Gem|', 5 , q'|Increases the power of the holder's first Psychic-type move by 50%, and is consumed after use.|' , nq'|????????|', nq'|Esper Jewel|', nq'|Joyau Psy|', nq'|Psychojuwel|', nq'|Bijoupsico|', nq'|Gema Ps�quica|', nq'|?????|', nq'|Esper Jewel|', nq'|????? / ?????|', nq'|Chaon�ngl� Baosh� / Chiun�hnglihk B�usehk|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Medal Box|', 5 , q'|A box-shaped machine that stores Medals and Medal information.|' , nq'|???????|', nq'|Medal Box|', nq'|B. M�dailles|', nq'|Medaillenbox|', nq'|Box Premi|', nq'|C. Insignias|', nq'|????|', nq'|Medal Box|', nq'|??? / ???|', nq'|Jiangp�i H� / J�ungp�ai Hahp|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Contest Pass|', 3 , q'|Allows the player to enter Contests.|' , nq'|???????|', nq'|Contest Pass|', nq'|Passe Concours|', nq'|Wettb.-Karte|', nq'|Tessera Gare|', nq'|Pase Concurso|', nq'|??????|', nq'|Contest Pass|', nq'|??????? / ???????|', nq'|Hu�l� D�s�i Canjia Zh�ng / W�hlaih Daaihchoi Chaamga Jing|', 160 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Silver Leaf|', 2 , q'|May be held by a Pok�mon transferred from Generation I.|' , nq'|??????|', nq'|Gin no Happa|', nq'|Feuille Arg.|', nq'|Silberblatt|', nq'|Fogliargento|', nq'|Hoja Plata|', nq'|?????|', nq'|Eunbit Namunnip|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Haban Berry|', 4 , q'|Halves the power of super effective Dragon-type moves.|' , nq'|?????|', nq'|Haban no Mi|', nq'|Baie Fraigo|', nq'|Terirobeere|', nq'|Baccahaban|', nq'|Baya Anjiro|', nq'|????|', nq'|Haban Yeolmae|', nq'|???|', nq'|M�ili� Guo / M�ihl�uh Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Float Stone|', 5 , q'|Halves the weight of the holder.|' , nq'|????|', nq'|Karuishi|', nq'|Pierrall�g�e|', nq'|Leichtstein|', nq'|Pietralieve|', nq'|Piedra P�mez|', nq'|????|', nq'|Gabyeoun Dol|', nq'|?? / ??|', nq'|Qingsh� / Hingsehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Cover Fossil|', 5 , q'|A Fossil from which a Tirtouga can be resurrected.|' , nq'|??????|', nq'|Futa no Kaseki|', nq'|Fossile Plaque|', nq'|Schildfossil|', nq'|Fossiltappo|', nq'|F�sil Tapa|', nq'|????|', nq'|Deopgae Hwaseok|', nq'|???? / ????|', nq'|B�ig�i Hu�sh� / Buihgoi Fasehk|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Grassium Z|', 7 , q'|Allows a Pok�mon to upgrade their Grass-type damaging moves to the Z-Move Bloom Doom or upgrade their Grass-type status moves into Z-Moves. Makes Arceus a Grass-type Pok�mon.|' , nq'|??Z|', nq'|Grass-Z|', nq'|Floraz�lite|', nq'|Botanium Z|', nq'|Herbium Z|', nq'|Fitostal Z|', nq'|?Z|', nq'|Pul-Z|', nq'|?Z|', nq'|Cao-Z / Ch�u-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Bug Memory|', 7 , q'|Makes Silvally a Bug-type Pok�mon and makes Multi-Attack a Bug-type move.|' , nq'|?????|', nq'|Bug Memory|', nq'|ROM Insecte|', nq'|K�fer-Disc|', nq'|ROM Coleottero|', nq'|Disco Bicho|', nq'|?????|', nq'|Bug Memory|', nq'|?????*|'||chr(10)||nq'|?????|', nq'|Ch�ngzi J�y�di� / Ch�hngj� Geiyikdihp*|'||chr(10)||nq'|Ch�ngzi C�nch�di�|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pearl String|', 5 , q'|Can be sold for 25000 to the ore collector|' , nq'|????????|', nq'|Odango Shinju|', nq'|Perle Triple|', nq'|Triperle|', nq'|Trittiperla|', nq'|Sarta Perlas|', nq'|????|', nq'|Gyeongdan Jinju|', nq'|????|', nq'|W�nzi Zhenzhu / Y�hnj� Janjyu|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lansat Berry|', 3 , q'|Raises critical-hit ratio if HP is below ? of maximum.|' , nq'|????|', nq'|San no Mi|', nq'|Baie Lansat|', nq'|Lansatbeere|', nq'|Baccalangsa|', nq'|Baya Zonlan|', nq'|????|', nq'|Langsa Yeolmae|', nq'|??? / ???|', nq'|L�ns� Guo / L�ahnsaat Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Black Sludge|', 4 , q'|Restores 1/16 of the Pok�mon's maximum HP each turn when held by Poison-type Pok�mon; damages all other types by ? of maximum HP each turn.|' , nq'|??????|', nq'|Kuroi Hedoro|', nq'|Boue Noire|', nq'|Giftschleim|', nq'|Fangopece|', nq'|Lodo Negro|', nq'|????|', nq'|Geomeun Jinheuk|', nq'|????|', nq'|Hei-s� Wun� / Haak-sik Wun�ih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Primarium Z|', 7 , q'|Allows Primarina to upgrade Sparkling Aria to the special Z-Move Oceanic Operetta.|' , nq'|?????Z|', nq'|Ashirene-Z|', nq'|Oratoz�lite|', nq'|Primarenium Z|', nq'|Primarinium Z|', nq'|Primastal Z|', nq'|????Z|', nq'|Nurireneu-Z|', nq'|????Z / ????Z|', nq'|Xishihair�n-Z / Saisih�iy�hm-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Charizardite X|', 6 , q'|Allows Charizard to Mega Evolve into Mega Charizard X.|' , nq'|???????X|', nq'|Lizardonite X|', nq'|Dracaufite X|', nq'|Gluraknit X|', nq'|Charizardite X|', nq'|Charizardita X|', nq'|??????X|', nq'|Rizamonnite X|', nq'|??????X / ??????X|', nq'|Penhuol�ng J�nhu� Sh� X / Panf�l�hng Jeunfa Sehk X|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Heat Rock|', 4 , q'|Extends the duration of harsh sunlight.|' , nq'|?????|', nq'|Atsui Iwa|', nq'|Roche Chaude|', nq'|Hei�brocken|', nq'|Rocciacalda|', nq'|Roca Calor|', nq'|?????|', nq'|Tteugeoun Bawi|', nq'|???? / ????|', nq'|Ch�r� Y�nsh� / Chiyiht Ng�ahmsehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dragon Gem|', 5 , q'|Increases the power of the holder's first Dragon-type move by 50%, and is consumed after use.|' , nq'|????????|', nq'|Dragon Jewel|', nq'|Joyau Dragon|', nq'|Drakojuwel|', nq'|Bijoudrago|', nq'|Gema Drag�n|', nq'|?????|', nq'|Dragon Jueol|', nq'|???? / ????|', nq'|L�ng-zhi Baosh� / L�hng-ji B�usehk|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Weakness Policy|', 6 , q'|Attack and Sp. Atk sharply increase if the holder is hit with a super effective move.|' , nq'|????????|', nq'|Jakuten Hoken|', nq'|Vuln�-Assurance|', nq'|Schw�chenschutz|', nq'|Vulneropolizza|', nq'|Seguro Debilidad|', nq'|????|', nq'|Yagjeom Boheom|', nq'|???? / ????|', nq'|Ru�dian Baoxian / Yeuhkd�m B�uh�m|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Plasma Card|', 5 , q'|A card key needed to enter the password inside the Plasma Frigate.|' , nq'|???????|', nq'|Plasma Card|', nq'|Carte Plasma|', nq'|Plasmakarte|', nq'|Carta Plasma|', nq'|Tarjeta Plasma|', nq'|??????|', nq'|Plasma Card|', nq'|???? / ????|', nq'|Dengl�zi Ka / D�ngl�ihj� Kaat|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Bluesky Mail|', 4 , q'|A sky-print mail. To be held by a Pok�mon for delivery.|' , nq'|???????|', nq'|Aozora Mail|', nq'|LetrCielBleu|', nq'|Kobaltbrief|', nq'|Mess. Cielo|', nq'|Cartaceleste|', nq'|??????|', nq'|Pureun Haneul Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Sprinklotad|', 6 , q'|Used to water Berry plants.|' , nq'|????????|', nq'|Hassboh Joro|', nq'|N�nurrosoir|', nq'|Loturzelkanne|', nq'|Irrigalotad|', nq'|Lotadgadera|', nq'|???????|', nq'|Yeonkkotmon Mulppurigae|', nq'|?????? / ??????|', nq'|Li�ny�t�ngzi Penh� / L�hnyihpt�hngj� Panw�h|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Fishing Rod|', 7 , q'|Allows the player to fish near underwater piles of rock.|' , nq'|????|', nq'|Tsurizao|', nq'|Canne � P�che|', nq'|Angel|', nq'|Amo|', nq'|Ca�a|', nq'|???|', nq'|Nakksisdae|', nq'|?? / ??|', nq'|Di�ogan / Diugon|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Balm Mushroom|', 5 , q'|Can be sold for 25000.|', q'|Formatted as BalmMushroom in Generation V.|', nq'|??????|', nq'|Kaoru Kinoko|', nq'|Champi Suave|', nq'|Duftpilz|', nq'|Profumfungo|', nq'|Seta Aroma|', nq'|????|', nq'|Hyanggi Beoseot|', nq'|????|', nq'|Fangxiang M�gu / Fongheung M�hgu|', 1024 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Smoke Ball|', 3 , q'|A held item that allows the user to flee from any wild Pok�mon battle. Can be used an unlimited number of times.|' , nq'|?????|', nq'|Kemuri Dama|', nq'|Boule Fum�e|', nq'|Rauchball|', nq'|Palla Fumo|', nq'|Bola Humo|', nq'|???|', nq'|Yeonmaktan|', nq'|??? / ???|', nq'|Yanw� Qi� / Yinmouh K�uh|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Quick Ball|', 4 , q'|A type of Pok� Ball that works better the earlier in battle it is used.|' , nq'|???????|', nq'|Quick Ball|', nq'|Rapide Ball|', nq'|Flottball|', nq'|Velox Ball|', nq'|Veloz Ball|', nq'|??|', nq'|Quick Ball|', nq'|??? / ???|', nq'|Xianji Qi� / Singei K�uh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Ice Berry|', 2 , q'|Heals a burn.|' , nq'|???????|', nq'|Kotta Kino Mi|', nq'|Baie Gel|', nq'|Eisbeere|', nq'|Bacca Ghiac.|', nq'|Baya Hielo|', nq'|??????|', nq'|Eoreun Namu Yeolmae|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Power Plant Pass|', 6 , q'|Allows access to the Kalos Power Plant.|' , nq'|????????|', nq'|Hatsudensho Pass|', nq'|Passe Centrale|', nq'|Kraftwerks-Pass|', nq'|Pass Centrale|', nq'|Pase Central|', nq'|?????|', nq'|Baljeonso Pass|', nq'|?????? / ??????|', nq'|Fadi�nchang Tongx�ngzh�ng / Faatdihnch�ng Tungh�hngjing|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Steel Teeth|', 3 , q'|Give to the old man in front of Under Colosseum to obtain the L-Disk.|' , nq'|???????|', nq'|Hagane no Ireba|', nq'|Dentier d'Acier|', nq'|Zahnprothese|', nq'|Dentacciaio|', nq'|Dentadura|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Max Elixir|', 1 , q'|Restores all of a Pok�mon's PP.|' , nq'|????????|', nq'|PP Max|', nq'|Max Elixir|', nq'|Top-Elixier|', nq'|Elisir Max|', nq'|Elixir M�ximo|', nq'|PP??|', nq'|PP Max|', nq'|PP????? / PP?????|', nq'|PP Duoxi�ng Qu�nbuj� / PP Dohohng Chy�hnb�ujaih|', 1024 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Card Key|', 2 , q'|Allows the player to access the third floor of Radio Tower while it is under siege by Team Rocket.|' , nq'|?????|', nq'|Card Key|', nq'|Carte Magn.|'||chr(10)||nq'|Cle Magnetique|', nq'|T�r�ffner|'||chr(10)||nq'|Schl�sselkarte|', nq'|Apriporta|', nq'|Llave Magn�tica|'||chr(10)||nq'|T. Magn�tica|', nq'|???|', nq'|Card Key|', nq'|??? / ???|', nq'|Y�oshi Ka / Yeuhks�h Kaat|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|Shiny Leaf|', 4 , q'|Note: Can only be held by Pok�mon and found on certain tiles in certain areas by checking the Pok�mon that follows the player. No guarantee that the player can find it even in the right place.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Babiri Berry|', 4 , q'|Reduces damage from a super effective Steel-type move by 50%.|' , nq'|?????|', nq'|Ririba no Mi|', nq'|Baie Babiri|', nq'|Babiribeere|', nq'|Baccababiri|', nq'|Baya Barib�|', nq'|?????|', nq'|Baribi Yeolmae|', nq'|???|', nq'|Pipi Guo / Pikpik Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Rainbow Wing|', 2 , q'|Summons Ho-Oh.|' , nq'|???????|', nq'|Nijiiro no Hane|', nq'|Arcenci'Aile|', nq'|Buntschwinge|', nq'|Ala d'Iride|', nq'|Ala Arco�ris|', nq'|??????|', nq'|Mujigaebit Nalgae|', nq'|????|', nq'|H�ng-s�-zhi Yu / H�hng-sik-ji Y�h|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Flying Memory|', 7 , q'|Makes Silvally a Flying-type Pok�mon and makes Multi-Attack a Flying-type move.|' , nq'|????????|', nq'|Flying Memory|', nq'|ROM Vol|', nq'|Flug-Disc|', nq'|ROM Volante|', nq'|Disco Volador|', nq'|??????|', nq'|Flying Memory|', nq'|?????*|'||chr(10)||nq'|?????|', nq'|Feixi�ng J�y�di� / Feich�uhng Geiyikdihp*|'||chr(10)||nq'|Feixi�ng C�nchudi�|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Voice Case 1|', 3 , q'|Heals a Combusken in Agate Village.|' , nq'|??????1|', nq'|Koe Capsule 1|', nq'|Boite Cri 1|', nq'|Stimmbox 1|', nq'|Disco Verso 1|', nq'|Grabaci�n 1|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Sharp Beak|', 2 , q'|Raises the power of Flying-type moves.|' , nq'|????????|', nq'|Surudoi Kuchibashi|', nq'|Bec Pointu|', nq'|Hackattack|', nq'|Beccaffilato|', nq'|Pico Afilado|', nq'|?????|', nq'|Yerihan Buri|', nq'|???? / ????|', nq'|Ru�l� Niaozui / Yeuihleih N�uhj�ui|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pok� Doll|', 1 , q'|Allows the player to flee from any battle with a wild Pok�mon.|' , nq'|????????|', nq'|Pippi Ningyo|', nq'|Pok�poup�e|', nq'|Pok�puppe|', nq'|Pok� Bambola|', nq'|Pok� Mu�eco|', nq'|????|', nq'|Ppippi Inhyeong|', nq'|????|', nq'|P�p� W�n'ou / P�ihp�ih Wuhnng�uh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Air Balloon|', 5 , q'|Gives the holder an immunity to Ground-type moves but is popped when the holder is hit by any non-Ground-type attacks.|' , nq'|????|', nq'|Fusen|', nq'|Ballon|', nq'|Luftballon|', nq'|Palloncino|', nq'|Globo Helio|', nq'|??|', nq'|Pungseon|', nq'|?? / ??|', nq'|Q�qi� / Heik�uh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|System Lever|', 3 , q'|Shuts down the Cipher Key Lair.|' , nq'|???????|', nq'|Kaijo Lever|', nq'|Levier|', nq'|Systemhebel|', nq'|Leva|', nq'|Palanca|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Shiny Stone|', 4 , q'|Can be used to evolve Togetic, Roselia, Minccino, and Floette.|' , nq'|??????|', nq'|Hikari no Ishi|', nq'|Pierre �clat|', nq'|Leuchtstein|', nq'|Pietrabrillo|', nq'|Piedra D�a|', nq'|???|', nq'|Bichui Dol|', nq'|???|', nq'|Guang-zhi Sh� / Gwong-ji Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|Nutpea Berry|', 3 , q'|Pok�block ingredient. It will become an Enigma Berry if transferred to Generation IV via Pal Park.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lunar Wing|', 4 , q'|Cures an endless nightmare.|' , nq'|???????|', nq'|Mikadzuki no Hane|', nq'|Lun'Aile|', nq'|Lunarfeder|', nq'|Ala Lunare|', nq'|Pluma Lunar|', nq'|?????|', nq'|Choseungdal Nalgae|', nq'|????|', nq'|Xinyu�-zhi Yu / Sanyuht-ji Y�h|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Master Ball|', 1 , q'|A rare type of Pok� Ball that catches any wild Pok�mon without fail. Generally available only once in the game, though it may be obtained again in very unlikely situations (such as winning the lottery), cheating, or on the GTS in Generation IV.|' , nq'|???????|', nq'|Master Ball|', nq'|Master Ball|', nq'|Meisterball|', nq'|Master Ball|', nq'|Master Ball|', nq'|????|', nq'|Master Ball|', nq'|??? / ???|', nq'|D�shi Qi� / Daaihsi K�uh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Shiny Charm|', 5 , q'|A shiny charm said to increase the chance of finding a Shiny Pok�mon.|' , nq'|???????|', nq'|Shining Charm|', nq'|Charme Chroma|', nq'|Schillerpin|', nq'|Cromamuleto|', nq'|Amuleto Iris|', nq'|?????|', nq'|Bitna-neun Bujeok|', nq'|???? / ????|', nq'|Shany�o H�f� / S�myiuh Wuhf�h|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Electirizer|', 4 , q'|A hold item that allows Electabuzz to evolve when traded.|' , nq'|????????|', nq'|Elec Booster|', nq'|�lectiriseur|', nq'|Stromisierer|', nq'|Elettritore|', nq'|Electrizador|', nq'|??????|', nq'|Elec Booster|', nq'|????? / ?????|', nq'|Di�nl� Zengf� Q� / Dihnlihk Jangfuk Hei|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Moomoo Milk|', 2 , q'|Restores 100 HP.|' , nq'|???????|', nq'|Mo Mo Milk|', nq'|Lait Meumeu|', nq'|Kuhmuh-Milch|', nq'|Latte Mumu|', nq'|Leche Mu-Mu|', nq'|????|', nq'|Teunteun Milk|', nq'|???? / ????|', nq'|Moumou Xiannai / Maumau Sinn�aih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Sacred Ash|', 2 , q'|Revives all fainted Pok�mon in the party to full HP.|' , nq'|??????|', nq'|Seinaru Hai|', nq'|Cendres Sacr�es|', nq'|Zauberasche|', nq'|Magicenere|', nq'|Ceniza Sagrada|', nq'|??????|', nq'|Seongseureoun Bunmal|', nq'|?? / ??|', nq'|Sh�nghui / Singfui|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Yache Berry|', 4 , q'|Reduces damage taken from a super effective Ice-type move.|' , nq'|?????|', nq'|Yache no Mi|', nq'|Baie Nanone|', nq'|Kiroyabeere|', nq'|Baccamoya|', nq'|Baya Rimoya|', nq'|????|', nq'|Peulka Yeolmae|', nq'|???|', nq'|Fanl� Guo / Faanlaih Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Old Gateau|', 4 , q'|Cures any status condition.|' , nq'|???????|', nq'|Mori no Yokan|', nq'|Vieux G�teau|', nq'|Spezialit�t|', nq'|Dolce Gateau|', nq'|Barrita Plus|', nq'|????|', nq'|Sup-ui Yanggaeng|', nq'|????|', nq'|Sen-zhi Y�nggeng / Sam-ji Y�uhnggang|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Key to Room 4|', 6 , q'|Opens Room 4 of the Abandoned ShipRSE/Sea MauvilleORAS.|', q'|Called Rm. 4 Key in Generation III.|', nq'|?????????|', nq'|Yon-go Shitsu no Kagi|', nq'|Cl� Salle 4|', nq'|R4-Schl�ssel|', nq'|Chiave stanza 4|', nq'|Ll. Habitaci�n 4|', nq'|?????|', nq'|Sa-hosil Yeolsoe|', nq'|4?????? /|'||chr(10)||nq'|4??????|', nq'|4 H�o K�f�ng-de Y�oshi / 4 Houh Haakf�ng-dik Yeuhks�h|', 1616 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Mewtwonite Y|', 6 , q'|Allows Mewtwo to Mega Evolve into Mega Mewtwo Y.|' , nq'|???????Y|', nq'|Mewtwonite Y|', nq'|Mewtwo�te Y|', nq'|Mewtunit Y|', nq'|Mewtwoite Y|', nq'|Mewtwoita Y|', nq'|?????Y|', nq'|Mewtwonite Y|', nq'|?????Y / ?????Y|', nq'|Chaom�ng J�nhu� Sh� Y / Chiumuhng Jeunfa Sehk Y|', 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( q'|Rule Book|' , nq'|??????|', nq'|Rule Book|', nq'|Livre R�gles|', nq'|Regelbuch|', nq'|Libro Regole|', nq'|Reglamento|', nq'|??|', nq'|Rule Book|', nq'|??? / ???|', nq'|Guiz� Shu / Kwaijak Syu|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Berserk Gene|', 2 , q'|Confuses the holder and raises Attack.|' , nq'|????????|', nq'|Hakai no Idenshi|', nq'|ADN Berzerk|', nq'|Berserk-Gen|', nq'|Gene Furioso|', nq'|Gen Loco|', nq'|??????|', nq'|Pagoe-ui Yujeonja|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Absorb Bulb|', 5 , q'|Raises the holder's Special Attack after being hit by a Water-type attack. Consumed after use.|' , nq'|?????|', nq'|Kyukon|', nq'|Bulbe|', nq'|Knolle|', nq'|Bulbo|', nq'|Tub�rculo|', nq'|??|', nq'|Gugeun|', nq'|??|', nq'|Qi�gen / K�uhgan|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Water Gem|', 5 , q'|Increases the power of the holder's first Water-type move by 50%, and is consumed after use.|' , nq'|???????|', nq'|Mizu no Jewel|', nq'|Joyau Eau|', nq'|Wasserjuwel|', nq'|Bijouacqua|', nq'|Gema Agua|', nq'|???|', nq'|Mul Jewel|', nq'|???? / ????|', nq'|Shui-zhi Baosh� / S�ui-ji B�usehk|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Storage Key|', 3 , q'|Allows a door to be opened on the Abandoned ShipRSE or the storage hold on the Sea MauvilleORAS.|' , nq'|??????|', nq'|Soko no Kagi|', nq'|Cl� Stockage|', nq'|Lagerschl�ssel|', nq'|Chiave magazzino|', nq'|Llave Almac�n|', nq'|????|', nq'|Changgo Yeolsoe|', nq'|???? / ????|', nq'|Cangk� Y�oshi / Chongfu Yeuhks�h|', 32 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Voice Case 2|', 3 , q'|Heals a Poochyena in Agate Village.|' , nq'|??????2|', nq'|Koe Capsule 2|', nq'|Boite Cri 2|', nq'|Stimmbox 2|', nq'|Disco Verso 2|', nq'|Grabaci�n 2|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Elixir|', 1 , q'|Restores 10 PP of each move of a Pok�mon.|' , nq'|????????|', nq'|PP Aider|', nq'|Elixir|', nq'|Elixier|', nq'|Elisir|', nq'|Elixir|', nq'|PP???|', nq'|PP Aider|', nq'|PP????? / PP?????|', nq'|PP Duoxi�ng Xiaobuj� / PP Dohohng S�ub�ujaih|', 1024 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Blue Shard|', 3 , q'|Exchangeable for a variety of services.|' , nq'|??????|', nq'|Aoi Kakera|', nq'|Tesson Bleu|', nq'|Indigost�ck|', nq'|Coccio Blu|', nq'|Parte Azul|', nq'|????|', nq'|Parang Jogak|', nq'|???? / ????|', nq'|L�ns� Su�pi�n / L�ahmsik Seuipin|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Relic Statue|', 5 , q'|Can be sold for 200000 to the villa owner in Undella Town.|' , nq'|????????|', nq'|Kodai no Sekizo|', nq'|Vieux Santon|', nq'|Alte Statue|', nq'|Statuantica|', nq'|Efigie Antigua|', nq'|?????|', nq'|Godae-yi Seoksang|', nq'|????|', nq'|Gud�i Sh�xi�ng / G�doih Sehkjeuhng|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Hondew Berry|', 3 , q'|Lowers Special Attack EV, but raises friendship.|' , nq'|????|', nq'|Rome no Mi|', nq'|Baie Lonme|', nq'|Honmelbeere|', nq'|Baccamelon|', nq'|Baya Meluce|', nq'|????|', nq'|Lome Yeolmae|', nq'|???|', nq'|Ham� Guo / Hamaht Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pecha Berry|', 3 , q'|Cures poison.|' , nq'|?????|', nq'|Momon no Mi|', nq'|Baie Pecha|', nq'|Pirsifbeere|', nq'|Baccapesca|', nq'|Baya Meloc|', nq'|????|', nq'|Boksyung Yeolmae|', nq'|???|', nq'|T�ot�o Guo / T�uht�uh Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Light Ball|', 2 , q'|Raises the Attack and Special Attack of Pikachu.|' , nq'|?????|', nq'|Denki Dama|', nq'|Ballelumiere|', nq'|Kugelblitz|', nq'|Elettropalla|', nq'|Bolaluminosa|', nq'|????|', nq'|Jeon-gi Guseul|', nq'|??? / ???|', nq'|Di�n Q�qi� / Dihn Heik�uh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Icicle Plate|', 4 , q'|Raises the power of Ice-type moves.|' , nq'|????????|', nq'|Tsurara no Pureto|', nq'|Plaque Glace|', nq'|Frosttafel|', nq'|Lastragelo|', nq'|Tabla Helada|', nq'|???????|', nq'|Godeureum Plate|', nq'|????|', nq'|Bingzh� Sh�ban / Bingchy�h Sehkb�an|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Fighting Memory|', 7 , q'|Makes Silvally a Fighting-type Pok�mon and makes Multi-Attack a Fighting-type move.|' , nq'|???????|', nq'|Fight Memory|', nq'|ROM Combat|', nq'|Kampf-Disc|', nq'|ROM Lotta|', nq'|Disco Lucha|', nq'|??????|', nq'|Fighting Memory|', nq'|?????*|'||chr(10)||nq'|?????|', nq'|Zh�nd�u J�y�di� / Jindau Geiyikdihp*|'||chr(10)||nq'|Zh�nd�u C�nchudi�|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|X Accuracy 3|', 5 , q'|Drastically raises a Pok�mon's accuracy. Wonder Launcher only.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Sun Stone|', 2 , q'|Can be used to evolve Sunkern, Gloom, Cottonee, Petilil, and Helioptile.|' , nq'|???????|', nq'|Taiyo no Ishi|', nq'|Pierre Soleil|', nq'|Sonnenstein|', nq'|Pietrasolare|', nq'|Piedra Solar|', nq'|????|', nq'|Taeyang-ui Dol|', nq'|???|', nq'|R�-zhi Sh� / Yaht-ji Sehk|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Enigma Berry|', 3 , q'|Restores � of a Pok�mon's HP after being hit by a super effective.|' , nq'|????|', nq'|Nazo no Mi|', nq'|Baie Enigma|', nq'|Enigmabeere|', nq'|Baccaenigma|', nq'|Baya Enigma|', nq'|????|', nq'|Uimun Yeolmae|', nq'|??? / ???|', nq'|M�zhi Guo / M�ihji Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Red Scarf|', 3 , q'|Raises the Cool condition.|' , nq'|???????|', nq'|Akai Bandana|', nq'|Foul. Rouge|', nq'|Roter Schal|', nq'|Fascia Rossa|', nq'|Pa�uelo Rojo|', nq'|????|', nq'|Ppalgang Band|', nq'|???? / ????|', nq'|H�ng-s� T�ujin / H�hng-sik T�uhgan|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Cell Battery|', 5 , q'|Raises the holder's Attack one stage when hit with an Electric-type attack. Consumed after use.|' , nq'|??????|', nq'|Judenchi|', nq'|Pile|', nq'|Akku|', nq'|Ricaripila|', nq'|Pila|', nq'|???|', nq'|Chungjeonji|', nq'|???? / ????|', nq'|Chongdi�n Di�nch� / Chungdihn Dihnch�h|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Chill Drive|', 5 , q'|Makes Techno Blast an Ice-type move when held by Genesect.|' , nq'|????????|', nq'|Freeze Cassette|', nq'|Module Cryo|', nq'|Gefriermodul|', nq'|Gelomodulo|', nq'|CrioROM|', nq'|??????|', nq'|Freeze Cassette|', nq'|???? / ????|', nq'|Bingd�ng Kad�i / Bingdung Kaatd�ai|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Unown Report|', 4 , q'|Lists the caught Unown forms. Replaces the Unown Mode of Generation II.|' , nq'|????????|', nq'|Unknown Note|', nq'|Carnet Zarbi|', nq'|Icognitoheft|', nq'|UnownBloc|', nq'|Bloc Unown|', nq'|????|', nq'|Annong Note|', nq'|?????? / ??????|', nq'|W�izhit�t�ng Bij� / Meihjit�uht�hng Batgei|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Storage Key|', 4 , q'|Gives the player access to the Galactic Warehouse in Veilstone City.|' , nq'|??????|', nq'|Soko no Kagi|', nq'|Cl� Stockage|', nq'|Lagerschl�ssel|', nq'|Chiave magazzino|', nq'|Llave Almac�n|', nq'|????|', nq'|Changgo Yeolsoe|', nq'|???? / ????|', nq'|Cangk� Y�oshi / Chongfu Yeuhks�h|', 32 );
insert into ITEMS( NAME, GEN , DESCRIPTION )
values( q'|X Speed 3|', 5 , q'|Drastically raises a Pok�mon's Speed. Wonder Launcher only.|' );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Mewtwonite X|', 6 , q'|Allows Mewtwo to Mega Evolve into Mega Mewtwo X.|' , nq'|???????X|', nq'|Mewtwonite X|', nq'|Mewtwo�te X|', nq'|Mewtunit X|', nq'|Mewtwoite X|', nq'|Mewtwoita X|', nq'|?????X|', nq'|Mewtwonite X|', nq'|?????X / ?????X|', nq'|Chaom�ng J�nhu� Sh� X / Chiumuhng Jeunfa Sehk X|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Rindo Berry|', 4 , q'|Reduces damage from a super effective Grass-type move.|' , nq'|?????|', nq'|Rindo no Mi|', nq'|Baie Ratam|', nq'|Grindobeere|', nq'|Baccarindo|', nq'|Baya Tamar|', nq'|????|', nq'|Rind Yeolmae|', nq'|??? / ???|', nq'|Lu�zi Guo / L�hj� Gw�|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Steel Mail|', 4 , q'|Mail with a metallic design. To be held by a Pok�mon for delivery.|' , nq'|???????|', nq'|Steel Mail|', nq'|Lettre Acier|', nq'|Stahlbrief|', nq'|Mess. Lega|', nq'|Carta Acero|', nq'|????|', nq'|Steel Mail|' , 0 );

insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 67, '0x0043', q'|Calcium|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 779, '0x030B', q'|Electrium Z|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 6, '0x0006', q'|Net Ball|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 216, '0xD8', q'|TM25|', q'|TMs and HMs pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 698, '0x02BA', q'|Common Stone|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 280, '0x0118', q'|Destiny Knot|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 112, '0x0070', q'|Griseous Orb|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 335, '0x014F', q'|TM08|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 411, '0x019B', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 377, '0x0179', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 638, '0x027E', q'|Reveal Glass|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 375, '0x0177', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 173, '0x00AD', q'|Lansat Berry|', q'|Berries pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 27, '0x001B', q'|Full Heal|', q'|Medicine pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 204, '0xCC', q'|TM04|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 883, '0x0373', q'|Misty Seed|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 105, '0x0069', q'|Skull Fossil|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 690, '0x02B2', q'|TM96|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 133, '0x0085', q'|unknown|', q'|Unknown pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 175, '0x00AF', q'|Cornn Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 413, '0x019D', q'|TM86|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 678, '0x02A6', q'|Charizardite Y|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 617, '0x0269', q'|Dark Stone|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 321, '0x0141', q'|Protector|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 157, '0x009D', q'|Lum Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 143, '0x008F', q'|Heart Mail|', q'|Mail pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 556, '0x022C', q'|Flying Gem|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 441, '0x01B9', q'|Red Chain|', q'|Key items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 198, '0xC6', q'|HM03|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 815, '0x032F', q'|Groundium Z|', q'|Z-Crystals pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 475, '0x01DB', q'|Card Key|', q'|Key items pocket|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 60, '0x003C', q'|X Accuracy|', q'|Battle items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 48, '0x0030', q'|Red Shard|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 666, '0x029A', q'|Houndoominite|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 12, '0x000C', q'|Premier Ball|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 91, '0x005B', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 244, '0x00F4', q'|Sharp Beak|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 706, '0x02C2', q'|Makeup Bag|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 143, '0x008F', q'|Reply Mail|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 335, '0x014F', q'|TM47|', q'|TMs and HMs pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 117, '0x0075', q'|unknown|', q'|Unknown pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 122, '0x007A', q'|unknown|', q'|Unknown pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 106, '0x6A', q'|??????? (GoldBadge - D)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 264, '0x0108', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 188, '0x00BC', q'|Yache Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 451, '0x01C3', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 698, '0x02BA', q'|Common Stone|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 785, '0x0311', q'|Flyinium Z|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 500, '0x01F4', q'|Park Ball|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 92, '0x005C', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 291, '0x0123', q'|TM03|', q'|TMs and HMs pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 372, '0x0174', q'|Powder Jar|', q'|Key items pocket|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 32, '0x20', q'|Rare Candy|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 922, '0x039A', q'|Lunalium Z|', q'|Z-Crystals pocket|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 36, '0x0024', q'|Heal Powder|', q'|Medicine pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 27, '0x001B', q'|Full Heal|', q'|Medicine pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 96, '0x0060', q'|Thunderstone|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 36, '0x0024', q'|Elixir|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 105, '0x0069', q'|Skull Fossil|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 476, '0x01DC', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 94, '0x5E', q'|Cleanse Tag|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 308, '0x0134', q'|TM20|', q'|TMs and HMs pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 649, '0x0289', q'|Snowball|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 276, '0x0114', q'|Zoom Lens|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 296, '0x0128', q'|TM08|', q'|TMs and HMs pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 133, '0x0085', q'|unknown|', q'|Unknown pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 65, '0x0041', q'|Blue Flute|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 323, '0x0143', q'|Magmarizer|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 51, '0x33', q'|Pok� Doll|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 214, '0x00D6', q'|TwistedSpoon|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 321, '0x0141', q'|Protector|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 154, '0x009A', q'|Leppa Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 556, '0x022C', q'|Flying Gem|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 167, '0x00A7', q'|Wepear Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 106, '0x006A', q'|Rare Bone|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 441, '0x01B9', q'|Red Chain|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 115, '0x73', q'|GS Ball|', q'|Key items pocket|', q'|Crystal|', 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 314, '0x013A', q'|Odd Incense|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 12, '0x000C', q'|Premier Ball|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 90, '0x005A', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 825, '0x0339', q'|Pikanium Z|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 540, '0x021C', q'|Battle CD 07|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 244, '0x00F4', q'|Sharp Beak|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 1040, '0x0410', q'|Tauros Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 143, '0x008F', q'|Reply Mail|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 470, '0x01D6', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 14, '0x000E', q'|Heal Ball|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 618, '0x026A', q'|TM93|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 602, '0x025A', q'|X Defense 3|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 108, '0x6C', q'|??? (Chick - D)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 74, '0x004A', q'|Yellow Shard|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 474, '0x01DA', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 278, '0x0116', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 24, '0x0018', q'|Max Potion|', q'|Medicine pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 25, '0x19', q'|Teru-sama|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 146, '0x92', q'|Leftovers|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 998, '0x03E6', q'|Diglett Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 280, '0x0118', q'|Destiny Knot|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 656, '0x0290', q'|Gengarite|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 172, '0x00AC', q'|Hondew Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 947, '0x03B3', q'|Ilima Normalium Z|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 163, '0x00A3', q'|Iapapa Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 82, '0x0052', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 781, '0x030D', q'|Icium Z|', q'|Z-Crystals pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 661, '0x0295', q'|Blastoisinite|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 512, '0x0200', q'|Data Card 08|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 1, '0x0001', q'|Master Ball|', q'|Pok� Balls pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 371, '0x0173', q'|TM44|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 65, '0x0041', q'|Iron|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 423, '0x01A7', q'|HM04|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 954, '0x03BA', q'|Roto Encounter|', q'|Unknown pocket|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 282, '0x011A', q'|Icy Rock|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 299, '0x012B', q'|TM11|', q'|TMs and HMs pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 412, '0x019C', q'|TM85|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 276, '0x0114', q'|Zoom Lens|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 887, '0x0377', q'|Marble|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 71, '0x0047', q'|Shoal Shell|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 323, '0x0143', q'|Magmarizer|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 417, '0x01A1', q'|TM90|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 62, '0x3E', q'|PP Up|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 659, '0x0293', q'|Venusaurite|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 215, '0x00D7', q'|Charcoal|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 200, '0x00C8', q'|Chilan Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 852, '0x0354', q'|Big Malasada|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 575, '0x023F', q'|Pass Orb|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 87, '0x0057', q'|Big Mushroom|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 272, '0x0110', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 6, '0x0006', q'|Net Ball|', q'|Pok� Balls pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 503, '0x01F7', q'|F-Disk|', q'|Key items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 358, '0x0166', q'|TM31|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 13, '0x000D', q'|Dusk Ball|', q'|Pok� Balls pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 80, '0x50', q'|Ether|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 74, '0x004A', q'|Yellow Shard|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 533, '0x0215', q'|Red ID Badge|', q'|Key items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 618, '0x026A', q'|TM93|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 231, '0xE7', q'|TM31|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 656, '0x0290', q'|Gengarite|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 76, '0x004C', q'|Super Repel|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 23, '0x0017', q'|Full Heal|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 137, '0x0089', q'|Greet Mail|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 512, '0x0200', q'|Data Card 08|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 371, '0x0173', q'|TM44|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 105, '0x0069', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 464, '0x01D0', q'|SecretPotion|', q'|Key items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 430, '0x01AE', q'|Rule Book|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 287, '0x011F', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 820, '0x0334', q'|Ghostium Z|', q'|Z-Crystals pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 941, '0x03AD', q'|Rainbow Flower|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 103, '0x0067', q'|TinyMushroom|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 568, '0x0238', q'|Genius Wing|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 21, '0x0015', q'|Hyper Potion|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 981, '0x03D5', q'|Caterpie Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 581, '0x0245', q'|Battle CD 48|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 498, '0x01F2', q'|Moon Ball|', q'|Pok� Balls pocket|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 314, '0x013A', q'|Odd Incense|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 157, '0x009D', q'|Lum Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 143, '0x008F', q'|Reply Mail|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 87, '0x0057', q'|Big Mushroom|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 725, '0x02D5', q'|Letter|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 6, '0x0006', q'|Net Ball|', q'|Pok� Balls pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 244, '0x00F4', q'|Sharp Beak|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 715, '0x02CB', q'|Fairy Gem|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 70, '0x0046', q'|Shoal Salt|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 201, '0x00C9', q'|Liechi Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 916, '0x0394', q'|Psychic Memory|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 286, '0x011E', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 16, '0x0010', q'|Cherish Ball|', q'|Pok� Balls pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 5, '0x0005', q'|Safari Ball|', q'|Pok� Balls pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 193, '0x00C1', q'|DeepSeaScale|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 35, '0x0023', q'|Energy Root|', q'|Medicine pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 845, '0x034D', q'|Sparkling Stone|', q'|Key items pocket|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 525, '0x020D', q'|Data Card 21|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 136, '0x0088', q'|Lustrous Orb|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 218, '0xDA', q'|TM27|', q'|TMs and HMs pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 191, '0x00BF', q'|Soul Dew|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 137, '0x0089', q'|Greet Mail|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 126, '0x007E', q'|Clothing Trunk|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 599, '0x0257', q'|X Speed 3|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 175, '0x00AF', q'|Cornn Berry|', q'|Berries pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 886, '0x0376', q'|???|', q'|Unknown pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 234, '0xEA', q'|TM34|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 430, '0x01AE', q'|Rule Book|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 295, '0x0127', q'|Shed Shell|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 523, '0x020B', q'|DNA Sample|', q'|Key items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 966, '0x03C6', q'|Health Candy L|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 758, '0x02F6', q'|Metagrossite|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 16, '0x0010', q'|Ice Heal|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 713, '0x02C9', q'|Bike|', q'|Key items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 146, '0x0092', q'|Bridge Mail T|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 745, '0x02E9', q'|Mega Pendant|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 842, '0x034A', q'|Fishing Rod|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 386, '0x0182', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 314, '0x013A', q'|Odd Incense|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 41, '0x0029', q'|Red Flute|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 485, '0x01E5', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 34, '0x22', q'|Leaf Stone|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 92, '0x5C', q'|Ylw Apricorn|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 456, '0x01C8', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 239, '0x00EF', q'|Miracle Seed|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 481, '0x01E1', q'|Machine Part|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 618, '0x026A', q'|TM93|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 318, '0x013E', q'|Rose Incense|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 70, '0x0046', q'|Shoal Salt|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 52, '0x34', q'|Full Heal|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 184, '0x00B8', q'|Occa Berry|', q'|Berries pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 740, '0x02E4', q'|Contest Costume|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 231, '0x00E7', q'|Lucky Egg|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 145, '0x91', q'|Teru-sama|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 946, '0x03B2', q'|N-Lunarizer|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 74, '0x004A', q'|Yellow Shard|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 431, '0x01AF', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 16, '0x0010', q'|Cherish Ball|', q'|Pok� Balls pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 395, '0x018B', q'|TM68|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 133, '0x0085', q'|Cheri Berry|', q'|Berries pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 862, '0x035E', q'|Golden Razz Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 35, '0x0023', q'|Energy Root|', q'|Medicine pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 657, '0x0291', q'|Gardevoirite|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 112, '0x0070', q'|Griseous Orb|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 870, '0x0366', q'|???|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 125, '0x007D', q'|Power-Up Pocket|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 454, '0x01C6', q'|Member Card|', q'|Key items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 129, '0x0081', q'|???|', q'|Unknown pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 719, '0x02CF', q'|Acro Bike|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 66, '0x0042', q'|Carbos|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 256, '0x0100', q'|Pink Scarf|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 491, '0x01EB', q'|Black Apricorn|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 599, '0x0257', q'|X Speed 3|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 342, '0x0156', q'|TM15|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 371, '0x0173', q'|TM44|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 714, '0x02CA', q'|Holo Caster|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 300, '0x012C', q'|Zap Plate|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 367, '0x016F', q'|TM40|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 508, '0x01FC', q'|Data Card 04|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 670, '0x029E', q'|Scizorite|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 329, '0x0149', q'|TM02|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 214, '0xD6', q'|TM14|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 197, '0x00C5', q'|Haban Berry|', q'|Berries pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 9, '0x0009', q'|Repeat Ball|', q'|Pok� Balls pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 106, '0x006A', q'|Rare Bone|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 244, '0xF4', q'|HM02|', q'|TMs and HMs pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 743, '0x02E7', q'|Pair of Tickets|', q'|Key items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 83, '0x53', q'|Max Elixer|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 379, '0x017B', q'|TM52|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 486, '0x01E6', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 482, '0x01E2', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 17, '0x0011', q'|Potion|', q'|Medicine pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 35, '0x0023', q'|Energy Root|', q'|Medicine pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 385, '0x0181', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 583, '0x0247', q'|Comet Shard|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 337, '0x0151', q'|TM10|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 118, '0x76', q'|Thick Club|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 533, '0x0215', q'|Lock Capsule|', q'|Key items pocket|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 762, '0x02FA', q'|Pidgeotite|', q'|Items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 122, '0x007A', q'|unknown|', q'|Unknown pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 123, '0x007B', q'|Glitter Mail|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 14, '0x000E', q'|Antidote|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 481, '0x01E1', q'|Machine Part|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 123, '0x007B', q'|unknown|', q'|Unknown pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 231, '0x00E7', q'|Lucky Egg|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 684, '0x02AC', q'|Latiasite|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 87, '0x0057', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 892, '0x037C', q'|???|', q'|Unknown pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 287, '0x011F', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 175, '0xAF', q'|SquirtBottle|', q'|Key items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 240, '0xF0', q'|TM48|', q'|TMs and HMs pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 215, '0xD7', q'|TM15|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 500, '0x01F4', q'|Park Ball|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 295, '0x0127', q'|Shed Shell|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 210, '0x00D2', q'|Custap Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 10, '0x000A', q'|Timer Ball|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 21, '0x15', q'|Max Elixer|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 7, '0x0007', q'|Dive Ball|', q'|Pok� Balls pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 137, '0x0089', q'|Greet Mail|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 202, '0xCA', q'|TM02|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 649, '0x0289', q'|Snowball|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 66, '0x0042', q'|Yellow Flute|', q'|Battle items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 367, '0x016F', q'|TM40|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 51, '0x33', q'|X Defend|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 430, '0x01AE', q'|Rule Book|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 96, '0x0060', q'|Damp Mulch|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 133, '0x0085', q'|unknown|', q'|Unknown pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 436, '0x01B4', q'|Seal Bag|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 8, '0x08', q'|Safari Ball|' , 1 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 221, '0xDD', q'|TM21|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 197, '0x00C5', q'|Haban Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 260, '0x0104', q'|Red Scarf|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 314, '0x013A', q'|Odd Incense|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 169, '0x00A9', q'|Pomeg Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 1049, '0x0419', q'|Snorlax Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 81, '0x51', q'|Max Ether|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 106, '0x006A', q'|Rare Bone|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 365, '0x016D', q'|TM38|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 195, '0x00C3', q'|Charti Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 369, '0x0171', q'|Tea|', q'|Key items pocket|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 577, '0x0241', q'|Battle CD 44|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 45, '0x2D', q'|Teru-sama|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 593, '0x0251', q'|X Speed 2|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 79, '0x004F', q'|Repel|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 715, '0x02CB', q'|Fairy Gem|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 231, '0x00E7', q'|Lucky Egg|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 320, '0x0140', q'|Pure Incense|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 218, '0x00DA', q'|Soothe Bell|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 295, '0x0127', q'|Shed Shell|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 170, '0x00AA', q'|Kelpsy Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 234, '0xEA', q'|TM42|', q'|TMs and HMs pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 422, '0x01A6', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 956, '0x03BC', q'|Roto HP Restore|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 599, '0x0257', q'|X Speed 3|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 135, '0x0087', q'|Adamant Orb|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 16, '0x0010', q'|Cherish Ball|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 367, '0x016F', q'|TM40|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 29, '0x001D', q'|Moomoo Milk|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 1011, '0x03F3', q'|Magnemite Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 117, '0x0075', q'|Shock Drive|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 79, '0x004F', q'|Repel|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 404, '0x0194', q'|TM77|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 78, '0x004E', q'|Escape Rope|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 7, '0x0007', q'|Dive Ball|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 918, '0x0396', q'|Dragon Memory|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 84, '0x0054', q'|Water Stone|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 503, '0x01F7', q'|Tidal Bell|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 436, '0x01B4', q'|Seal Bag|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 71, '0x0047', q'|Shoal Shell|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 197, '0x00C5', q'|Haban Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 185, '0x00B9', q'|Passho Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 198, '0x00C6', q'|Scope Lens|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 188, '0x00BC', q'|Yache Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 583, '0x0247', q'|Comet Shard|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 195, '0x00C3', q'|Charti Berry|', q'|Berries pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 833, '0x0341', q'|Eevium Z|', q'|Z-Crystals pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 290, '0x0122', q'|Power Belt|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 292, '0x0124', q'|Power Band|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 304, '0x0130', q'|TM16|', q'|TMs and HMs pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 122, '0x007A', q'|unknown|', q'|Unknown pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 390, '0x0186', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 231, '0x00E7', q'|Lucky Egg|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 27, '0x1B', q'|Protein|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 184, '0x00B8', q'|Occa Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 337, '0x0151', q'|TM49|', q'|TMs and HMs pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 74, '0x004A', q'|Yellow Shard|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 34, '0x0022', q'|EnergyPowder|', q'|Medicine pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 309, '0x0135', q'|TM21|', q'|TMs and HMs pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 170, '0x00AA', q'|Kelpsy Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 1019, '0x03FB', q'|Drowzee Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 295, '0x0127', q'|Shed Shell|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 871, '0x0367', q'|???|', q'|Unknown pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 832, '0x0340', q'|Snorlium Z|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 31, '0x001F', q'|Energy Root|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 799, '0x031F', q'|Incinium Z|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 37, '0x0025', q'|Revival Herb|', q'|Medicine pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 352, '0x0160', q'|Bike Voucher|', q'|Key items pocket|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 117, '0x0075', q'|Shock Drive|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 444, '0x01BC', q'|Coin Case|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 175, '0x00AF', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 370, '0x0172', q'|TM43|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 893, '0x037D', q'|???|', q'|Unknown pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 28, '0x001C', q'|Lemonade|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 197, '0x00C5', q'|Haban Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 266, '0x010A', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 520, '0x0208', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 900, '0x0384', q'|???|', q'|Unknown pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 169, '0x00A9', q'|Pomeg Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 936, '0x03A8', q'|Blue Petal|', q'|Key items pocket|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 200, '0x00C8', q'|Chilan Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 292, '0x0124', q'|Power Band|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 106, '0x006A', q'|Rare Bone|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 458, '0x01CA', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 271, '0x010F', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 370, '0x0172', q'|TM43|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 583, '0x0247', q'|Comet Shard|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 231, '0x00E7', q'|Lucky Egg|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 899, '0x0383', q'|???|', q'|Unknown pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 195, '0x00C3', q'|Charti Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 195, '0x00C3', q'|Everstone|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 848, '0x0350', q'|???|', q'|Unknown pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 191, '0x00BF', q'|Soul Dew|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 813, '0x032D', q'|Fightinium Z|', q'|Z-Crystals pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 138, '0x008A', q'|Leppa Berry|', q'|Berries pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 63, '0x003F', q'|Pok� Doll|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 115, '0x0073', q'|unknown|', q'|Unknown pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 1033, '0x0409', q'|Goldeen Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 665, '0x0299', q'|Medichamite|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 201, '0x00C9', q'|Liechi Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 197, '0xC5', q'|HM02|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 1034, '0x040A', q'|Staryu Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 383, '0x017F', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 130, '0x82', q'|Lost Item|', q'|Key items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 494, '0x01EE', q'|Lure Ball|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 412, '0x019C', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 405, '0x0195', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 501, '0x01F5', q'|Elevator Key|', q'|Key items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 37, '0x0025', q'|Revival Herb|', q'|Medicine pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 377, '0x0179', q'|TM50|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 430, '0x01AE', q'|Rule Book|', q'|Key items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 180, '0x00B4', q'|Pamtre Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 142, '0x008E', q'|Like Mail|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 117, '0x0075', q'|Shock Drive|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 308, '0x0134', q'|Insect Plate|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 315, '0x013B', q'|TM27|', q'|TMs and HMs pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 257, '0x0101', q'|Green Scarf|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 29, '0x001D', q'|Moomoo Milk|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 302, '0x012E', q'|TM14|', q'|TMs and HMs pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 360, '0x0168', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 929, '0x03A1', q'|Ultranecrozium Z|', q'|Z-Crystals pocket|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 555, '0x022B', q'|Battle CD 22|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 378, '0x017A', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 200, '0x00C8', q'|Chilan Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 292, '0x0124', q'|Power Band|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 662, '0x0296', q'|Mewtwonite X|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 306, '0x0132', q'|Sky Plate|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 146, '0x0092', q'|Bridge Mail T|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 608, '0x0260', q'|X Defense 6|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 348, '0x015C', q'|TM21|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 70, '0x0046', q'|Shoal Salt|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 115, '0x0073', q'|unknown|', q'|Unknown pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 748, '0x02EC', q'|Mega Stickpin|', q'|Key items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 63, '0x003F', q'|Pok� Doll|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 184, '0x00B8', q'|Occa Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 280, '0x0118', q'|Meteorite|', q'|Key items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 456, '0x01C8', q'|S.S. Ticket|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 175, '0x00AF', q'|Cornn Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 127, '0x007F', q'|Catching Pocket|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 688, '0x02B0', q'|Maranga Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 942, '0x03AE', q'|Surge Badge|', q'|Key items pocket|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 637, '0x027D', q'|Dropped Item|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 290, '0x0122', q'|TM02|', q'|TMs and HMs pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 683, '0x02AB', q'|Garchompite|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 37, '0x0025', q'|Revival Herb|', q'|Medicine pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 543, '0x021F', q'|Ring Target|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 1, '0x0001', q'|Master Ball|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 1042, '0x0412', q'|Lapras Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 59, '0x3B', q'|Good Rod|', q'|Key items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 394, '0x018A', q'|TM67|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 204, '0x00CC', q'|Petaya Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 343, '0x0157', q'|TM16|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 98, '0x0062', q'|Leaf Stone|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 292, '0x0124', q'|Power Band|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 262, '0x0106', q'|Old Rod|', q'|Key items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 199, '0xC7', q'|TM08|', q'|TMs and HMs pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 6, '0x0006', q'|Net Ball|', q'|Pok� Balls pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 132, '0x0084', q'|???|', q'|Unknown pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 356, '0x0164', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 141, '0x008D', q'|Tunnel Mail|', q'|Mail pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 247, '0xF7', q'|TM47|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 354, '0x0162', q'|Old Amber|', q'|Key items pocket|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 270, '0x010E', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 10, '0x0A', q'|Moon Stone|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 234, '0x00EA', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 67, '0x0043', q'|Red Flute|', q'|Battle items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 188, '0x00BC', q'|Yache Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 5, '0x05', q'|Town Map|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 326, '0x0146', q'|TM38|', q'|TMs and HMs pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 946, '0x03B2', q'|N-Lunarizer|', q'|Key items pocket|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 475, '0x01DB', q'|Card Key|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 5, '0x0005', q'|Safari Ball|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 202, '0xCA', q'|TM11|', q'|TMs and HMs pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 75, '0x4B', q'|Gold Leaf|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 266, '0x010A', q'|Contest Pass|', q'|Key items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 536, '0x0218', q'|Ylw ID Badge|', q'|Key items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 88, '0x58', q'|3F (G)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 363, '0x016B', q'|TM36|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 735, '0x02DF', q'|Devon Scope|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 37, '0x0025', q'|Revival Herb|', q'|Medicine pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 949, '0x03B5', q'|Roto Hatch|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 21, '0x15', q'|BoulderBadge|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 308, '0x0134', q'|Insect Plate|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 208, '0x00D0', q'|Enigma Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 466, '0x01D2', q'|Gracidea|', q'|Key items pocket|', q'|Platinum, HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 167, '0x00A7', q'|Belue Berry|', q'|Berries pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 387, '0x0183', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 60, '0x003C', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 370, '0x0172', q'|TM43|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 189, '0x00BD', q'|Chople Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 934, '0x03A6', q'|Pink Petal|', q'|Key items pocket|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 121, '0x0079', q'|???|', q'|Unknown pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 169, '0x00A9', q'|Pomeg Berry|', q'|Berries pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 427, '0x01AB', q'|???|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 480, '0x01E0', q'|Pass|', q'|Key items pocket|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 378, '0x017A', q'|TM51|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 681, '0x02A9', q'|Mawilite|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 424, '0x01A8', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 18, '0x0012', q'|Antidote|', q'|Medicine pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 392, '0x0188', q'|TM65|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 314, '0x013A', q'|Odd Incense|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 327, '0x0147', q'|TM39|', q'|TMs and HMs pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 737, '0x02E1', q'|HM07|', q'|TMs and HMs pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 104, '0x0068', q'|Armor Fossil|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 393, '0x0189', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 123, '0x007B', q'|unknown|', q'|Unknown pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 386, '0x0182', q'|TM59|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 56, '0x0038', q'|Dire Hit|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 218, '0x00DA', q'|Soothe Bell|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 5, '0x0005', q'|Safari Ball|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 930, '0x03A2', q'|Mimikium Z|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 428, '0x01AC', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 377, '0x0179', q'|TM50|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 338, '0x0152', q'|TM50|', q'|TMs and HMs pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 19, '0x0013', q'|Full Restore|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 78, '0x004E', q'|Escape Rope|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 476, '0x01DC', q'|Basement Key|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 308, '0x0134', q'|Insect Plate|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 7, '0x0007', q'|Dive Ball|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 153, '0x0099', q'|Aspear Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 208, '0x00D0', q'|Enigma Berry|', q'|Berries pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 268, '0x010C', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 867, '0x0363', q'|???|', q'|Unknown pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 635, '0x027B', q'|Colress Machine|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 320, '0x0140', q'|TM32|', q'|TMs and HMs pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 189, '0x00BD', q'|Chople Berry|', q'|Berries pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 783, '0x030F', q'|Poisonium Z|', q'|Z-Crystals pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 576, '0x0240', q'|Dream Ball|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 718, '0x02CE', q'|Mach Bike|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 233, '0x00E9', q'|Metal Coat|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 472, '0x01D8', q'|Blue Card|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 59, '0x003B', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 738, '0x02E2', q'|Devon Scuba Gear|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 531, '0x0213', q'|Steel Teeth|', q'|Key items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 101, '0x0065', q'|Helix Fossil|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 375, '0x0177', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 537, '0x0219', q'|Prism Scale|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 662, '0x0296', q'|Mewtwonite X|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 147, '0x93', q'|Teru-sama|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 152, '0x98', q'|Berserk Gene|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 744, '0x02E8', q'|Mega Bracelet|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 42, '0x002A', q'|Black Flute|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 392, '0x0188', q'|TM65|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 960, '0x03C0', q'|Health Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 18, '0x0012', q'|Antidote|', q'|Medicine pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 394, '0x018A', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 104, '0x0068', q'|Armor Fossil|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 123, '0x007B', q'|unknown|', q'|Unknown pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 1027, '0x0403', q'|Koffing Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 218, '0x00DA', q'|Soothe Bell|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 488, '0x01E8', q'|Grn Apricorn|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 34, '0x0022', q'|EnergyPowder|', q'|Medicine pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 38, '0x26', q'|Full Heal|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 153, '0x0099', q'|Aspear Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 170, '0x00AA', q'|Kelpsy Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 60, '0x003C', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 824, '0x0338', q'|Fairium Z|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 68, '0x0044', q'|Rare Candy|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 460, '0x01CC', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 381, '0x017D', q'|TM54|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 175, '0x00AF', q'|Cornn Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 230, '0x00E6', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 78, '0x004E', q'|Escape Rope|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 476, '0x01DC', q'|Basement Key|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 208, '0x00D0', q'|Enigma Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 5, '0x05', q'|Pok� Ball|', q'|Pok� Balls pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 738, '0x02E2', q'|Devon Scuba Gear|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 513, '0x0201', q'|Data Card 09|', q'|Items pocket|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 855, '0x0357', q'|Pink Nectar|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 246, '0x00F6', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 547, '0x0223', q'|Eject Button|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 941, '0x03AD', q'|Rainbow Flower|', q'|Key items pocket|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 718, '0x02CE', q'|Mach Bike|', q'|Key items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 235, '0x00EB', q'|Dragon Scale|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 317, '0x013D', q'|TM29|', q'|TMs and HMs pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 537, '0x0219', q'|Prism Scale|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 340, '0x0154', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 135, '0x0087', q'|Pecha Berry|', q'|Berries pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 16, '0x0010', q'|Ice Heal|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 432, '0x01B0', q'|Point Card|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 26, '0x001A', q'|Fresh Water|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 400, '0x0190', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 402, '0x0192', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 4, '0x0004', q'|Pok� Ball|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 435, '0x01B3', q'|Fashion Case|', q'|Key items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 188, '0x00BC', q'|Yache Berry|', q'|Berries pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 104, '0x0068', q'|Armor Fossil|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 487, '0x01E7', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 218, '0x00DA', q'|Soothe Bell|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 153, '0x0099', q'|Aspear Berry|', q'|Berries pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 628, '0x0274', q'|DNA Splicers|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 34, '0x22', q'|Water Stone|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 314, '0x013A', q'|TM26|', q'|TMs and HMs pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 170, '0x00AA', q'|Kelpsy Berry|', q'|Berries pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 525, '0x020D', q'|Krane Memo 3|', q'|Key items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 444, '0x01BC', q'|Coin Case|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 27, '0x001B', q'|Full Heal|', q'|Medicine pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 78, '0x004E', q'|Escape Rope|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 419, '0x01A3', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 202, '0x00CA', q'|Ganlon Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 503, '0x01F7', q'|Tidal Bell|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 1013, '0x03F5', q'|Doduo Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 278, '0x0116', q'|Scanner|', q'|Key items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 465, '0x01D1', q'|Vs. Recorder|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 185, '0x00B9', q'|Passho Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 189, '0x00BD', q'|Chople Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 39, '0x27', q'|Calcium|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 201, '0x00C9', q'|Liechi Berry|', q'|Berries pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 252, '0x00FC', q'|Up-Grade|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 57, '0x0039', q'|X Attack|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 212, '0x00D4', q'|Rowap Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 315, '0x013B', q'|Rock Incense|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 64, '0x40', q'|Max Ether|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 267, '0x010B', q'|Wise Glasses|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 410, '0x019A', q'|TM83|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 53, '0x0035', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 111, '0x006F', q'|Odd Keystone|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 481, '0x01E1', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 328, '0x0148', q'|TM40|', q'|TMs and HMs pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 104, '0x0068', q'|Armor Fossil|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 341, '0x0155', q'|TM14|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 361, '0x0169', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 177, '0x00B1', q'|Rabuta Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 408, '0x0198', q'|TM81|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 53, '0x0035', q'|PP Max|', q'|Medicine pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 197, '0x00C5', q'|Lucky Egg|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 164, '0xA4', q'|Friend Ball|', q'|Pok� Balls pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 153, '0x0099', q'|Aspear Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 313, '0x0139', q'|TM25|', q'|TMs and HMs pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 384, '0x0180', q'|TM57|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 237, '0x00ED', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 175, '0x00AF', q'|Cornn Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 444, '0x01BC', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 80, '0x0050', q'|Sun Stone|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 761, '0x02F9', q'|Steelixite|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 46, '0x002E', q'|Protein|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 659, '0x0293', q'|Venusaurite|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 138, '0x008A', q'|Favored Mail|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 444, '0x01BC', q'|Coin Case|', q'|Key items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 45, '0x002D', q'|Sacred Ash|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 728, '0x02D8', q'|Go-Goggles|', q'|Key items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 476, '0x01DC', q'|Basement Key|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 755, '0x02F3', q'|Altarianite|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 563, '0x0233', q'|Steel Gem|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 188, '0x00BC', q'|SilverPowder|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 219, '0x00DB', q'|Shell Bell|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 465, '0x01D1', q'|Vs. Recorder|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 315, '0x013B', q'|Rock Incense|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 573, '0x023D', q'|Plume Fossil|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 279, '0x0117', q'|Go-Goggles|', q'|Key items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 410, '0x019A', q'|TM83|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 341, '0x0155', q'|TM14|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 267, '0x010B', q'|Wise Glasses|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 140, '0x8C', q'|Scope Lens|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 176, '0x00B0', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 207, '0x00CF', q'|Black Belt|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 771, '0x0303', q'|Meteorite|', q'|Key items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 177, '0x00B1', q'|Rabuta Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 219, '0xDB', q'|TM28|', q'|TMs and HMs pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 335, '0x014F', q'|TM08|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 518, '0x0206', q'|Data Card 14|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 53, '0x0035', q'|PP Max|', q'|Medicine pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 100, '0x0064', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 564, '0x0234', q'|Normal Gem|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 220, '0xDC', q'|TM20|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 53, '0x35', q'|X Special|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 747, '0x02EB', q'|Mega Anchor|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 676, '0x02A4', q'|Gyaradosite|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 122, '0x007A', q'|???|', q'|Unknown pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 80, '0x0050', q'|Sun Stone|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 332, '0x014C', q'|TM05|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 138, '0x008A', q'|Favored Mail|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 892, '0x037C', q'|Polished Mud Ball|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 3, '0x0003', q'|Great Ball|', q'|Pok� Balls pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 563, '0x0233', q'|Steel Gem|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 277, '0x0115', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 185, '0x00B9', q'|Passho Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 329, '0x0149', q'|TM02|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 247, '0x00F7', q'|Spell Tag|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 425, '0x01A9', q'|HM06|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 537, '0x0219', q'|Prism Scale|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 344, '0x0158', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 367, '0x016F', q'|TM40|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 315, '0x013B', q'|Rock Incense|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 256, '0x0100', q'|Lucky Punch|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 634, '0x027A', q'|Grubby Hanky|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 13, '0x000D', q'|Dusk Ball|', q'|Pok� Balls pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 162, '0x00A2', q'|Nomel Berry|', q'|Berries pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 727, '0x02D7', q'|Scanner|', q'|Key items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 87, '0x0057', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 310, '0x0136', q'|Spooky Plate|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 523, '0x020B', q'|Data Card 19|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 616, '0x0268', q'|Light Stone|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 135, '0x0087', q'|Pecha Berry|', q'|Berries pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 874, '0x036A', q'|Silph Scope|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 49, '0x31', q'|Nugget|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 564, '0x0234', q'|Normal Gem|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 124, '0x007C', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 573, '0x023D', q'|Plume Fossil|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 463, '0x01CF', q'|Storage Key|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 242, '0x00F2', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 145, '0x0091', q'|Mago Berry|', q'|Berries pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 683, '0x02AB', q'|Garchompite|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 374, '0x0176', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 444, '0x01BC', q'|Coin Case|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 138, '0x008A', q'|Favored Mail|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 675, '0x02A3', q'|Kangaskhanite|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 416, '0x01A0', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 543, '0x021F', q'|Ring Target|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 563, '0x0233', q'|Steel Gem|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 77, '0x004D', q'|X Speed|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 145, '0x0091', q'|Space Mail|', q'|Mail pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 465, '0x01D1', q'|Vs. Recorder|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 185, '0x00B9', q'|Passho Berry|', q'|Berries pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 169, '0x00A9', q'|Pomeg Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 158, '0x009E', q'|Sitrus Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 635, '0x027B', q'|Colress Machine|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 338, '0x0152', q'|TM11|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 189, '0x00BD', q'|Chople Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 201, '0x00C9', q'|Liechi Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 418, '0x01A2', q'|TM91|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 516, '0x0204', q'|Data Card 12|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 96, '0x0060', q'|Damp Mulch|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 351, '0x015F', q'|Secret Key|', q'|Key items pocket|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 427, '0x01AB', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 97, '0x0061', q'|Water Stone|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 469, '0x01D5', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 315, '0x013B', q'|Rock Incense|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 67, '0x0043', q'|Calcium|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 1023, '0x03FF', q'|Cubone Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 1006, '0x03EE', q'|Bellsprout Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 475, '0x01DB', q'|Card Key|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 371, '0x0173', q'|AuroraTicket|', q'|Key items pocket|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 524, '0x020C', q'|Data Card 20|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 330, '0x014A', q'|TM03|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 24, '0x18', q'|Water Stone|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 341, '0x0155', q'|TM14|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 255, '0x00FF', q'|Lax Incense|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 211, '0xD3', q'|TM11|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 177, '0x00B1', q'|Rabuta Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 510, '0x01FE', q'|Card Key|', q'|Key items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 234, '0x00EA', q'|Leftovers|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 573, '0x023D', q'|Plume Fossil|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 377, '0x0179', q'|TM50|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 352, '0x0160', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 324, '0x0144', q'|Dubious Disc|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 829, '0x033D', q'|Tapunium Z|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 411, '0x019B', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 342, '0x0156', q'|TM15|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 498, '0x01F2', q'|Moon Ball|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 454, '0x01C6', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 15, '0x000F', q'|Burn Heal|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 329, '0x0149', q'|TM02|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 476, '0x01DC', q'|Basement Key|', q'|Key items pocket|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 888, '0x0378', q'|???|', q'|Unknown pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 440, '0x01B8', q'|Galactic Key|', q'|Key items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 132, '0x0084', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 776, '0x0308', q'|Normalium Z|', q'|Z-Crystals pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 432, '0x01B0', q'|Point Card|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 770, '0x0302', q'|Beedrillite|', q'|Items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 141, '0x008D', q'|Lum Berry|', q'|Berries pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 549, '0x0225', q'|Battle CD 16|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 165, '0x00A5', q'|Bluk Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 138, '0x008A', q'|Leppa Berry|', q'|Berries pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 451, '0x01C3', q'|Suite Key|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 645, '0x0285', q'|Ability Capsule|', q'|Medicine pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 255, '0x00FF', q'|Lax Incense|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 392, '0x0188', q'|TM65|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 43, '0x002B', q'|White Flute|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 98, '0x0062', q'|Gooey Mulch|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 491, '0x01EB', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 524, '0x020C', q'|Data Card 20|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 831, '0x033F', q'|Aloraichium Z|', q'|Z-Crystals pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 78, '0x004E', q'|X Accuracy|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 598, '0x0256', q'|X Accuracy 2|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 117, '0x0075', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 564, '0x0234', q'|Normal Gem|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 357, '0x0165', q'|Helix Fossil|', q'|Key items pocket|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 542, '0x021E', q'|Red Card|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 502, '0x01F6', q'|GB Sounds|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 324, '0x0144', q'|Dubious Disc|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 342, '0x0156', q'|TM15|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 7, '0x0007', q'|Dive Ball|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 124, '0x007C', q'|Mech Mail|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 209, '0x00D1', q'|Micle Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 424, '0x01A8', q'|HM05|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 250, '0x00FA', q'|Dragon Fang|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 38, '0x0026', q'|Ether|', q'|Medicine pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 301, '0x012D', q'|TM13|', q'|TMs and HMs pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 105, '0x0069', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 465, '0x01D1', q'|Vs. Recorder|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 440, '0x01B8', q'|Galactic Key|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 793, '0x0319', q'|Fairium Z|', q'|Z-Crystals pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 537, '0x0219', q'|Prism Scale|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 41, '0x29', q'|Guard Spec.|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 37, '0x0025', q'|Max Elixir|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 432, '0x01B0', q'|Point Card|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 473, '0x01D9', q'|SlowpokeTail|', q'|Key items pocket|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 744, '0x02E8', q'|Mega Bracelet|', q'|Key items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 1012, '0x03F4', q'|Farfetch'd Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 350, '0x015E', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 96, '0x0060', q'|Damp Mulch|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 858, '0x035A', q'|Moon Flute|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 847, '0x034F', q'|Zygarde Cube|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 362, '0x016A', q'|TM35|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 543, '0x021F', q'|Joy Scent|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 273, '0x0111', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 213, '0x00D5', q'|Bright Powder|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 703, '0x02BF', q'|Adventure Rules|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 98, '0x0062', q'|Gooey Mulch|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 491, '0x01EB', q'|Blk Apricorn|', q'|Items pocket|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 713, '0x02C9', q'|Bicycle|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 738, '0x02E2', q'|Devon Scuba Gear|', q'|Key items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 166, '0xA6', q'|Love Ball|', q'|Pok� Balls pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 476, '0x01DC', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 475, '0x01DB', q'|Card Key|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 721, '0x02D1', q'|Devon Parts|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 439, '0x01B7', q'|Old Charm|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 463, '0x01CF', q'|Storage Key|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 312, '0x0138', q'|TM24|', q'|TMs and HMs pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 560, '0x0230', q'|Battle CD 27|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 248, '0x00F8', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 464, '0x01D0', q'|SecretPotion|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 57, '0x0039', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 778, '0x030A', q'|Waterium Z|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 438, '0x01B6', q'|Works Key|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 58, '0x003A', q'|X Defense|', q'|Battle items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 105, '0x0069', q'|Skull Fossil|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 675, '0x02A3', q'|Kangaskhanite|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 543, '0x021F', q'|Ring Target|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 126, '0x007E', q'|???|', q'|Unknown pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 426, '0x01AA', q'|???|', q'|Unknown pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 244, '0x00F4', q'|Sharp Beak|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 152, '0x0098', q'|Pinap Berry|', q'|Berries pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 516, '0x0204', q'|Data Card 12|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 752, '0x02F0', q'|Swampertite|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 281, '0x0119', q'|Rm. 1 Key|', q'|Key items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 296, '0x0128', q'|TM08|', q'|TMs and HMs pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 436, '0x01B4', q'|Seal Bag|', q'|Key items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 317, '0x013D', q'|TM29|', q'|TMs and HMs pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 305, '0x0131', q'|TM17|', q'|TMs and HMs pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 263, '0x0107', q'|Good Rod|', q'|Key items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 251, '0x00FB', q'|Silk Scarf|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 176, '0x00B0', q'|Magost Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 96, '0x0060', q'|Damp Mulch|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 905, '0x0389', q'|Flying Memory|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 85, '0x0055', q'|Escape Rope|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 84, '0x54', q'|Mint Berry|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 679, '0x02A7', q'|Alakazite|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 159, '0x009F', q'|Figy Berry|', q'|Berries pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 166, '0x00A6', q'|Nanab Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 114, '0x72', q'|RageCandyBar|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 80, '0x0050', q'|Sun Stone|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 586, '0x024A', q'|Relic Gold|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 736, '0x02E0', q'|S.S. Ticket|', q'|Key items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 144, '0x0090', q'|Wiki Berry|', q'|Berries pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 31, '0x001F', q'|Soda Pop|', q'|Medicine pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 53, '0x0035', q'|PP Max|', q'|Medicine pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 375, '0x0177', q'|Magma Emblem|', q'|Key items pocket|', q'|Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 707, '0x02C3', q'|Travel Trunk|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 598, '0x0256', q'|X Accuracy 2|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 172, '0x00AC', q'|Hondew Berry|', q'|Berries pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 220, '0xDC', q'|TM28|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 438, '0x01B6', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 209, '0x00D1', q'|Mystic Water|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 318, '0x013E', q'|Rose Incense|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 620, '0x026C', q'|TM95|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 993, '0x03E1', q'|Jigglypuff Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 819, '0x0333', q'|Rockium Z|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 416, '0x01A0', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 78, '0x004E', q'|X Accuracy|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 235, '0x00EB', q'|Dragon Scale|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 521, '0x0209', q'|Data Card 17|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 250, '0x00FA', q'|Dragon Fang|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 126, '0x7E', q'|Lucky Egg|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 383, '0x017F', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 58, '0x003A', q'|X Defend|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 22, '0x0016', q'|Paralyze Heal|', q'|Medicine pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 325, '0x0145', q'|TM37|', q'|TMs and HMs pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 436, '0x01B4', q'|Seal Bag|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 238, '0x00EE', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 47, '0x002F', q'|Iron|', q'|Medicine pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 365, '0x016D', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 397, '0x018D', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 472, '0x01D8', q'|Blue Card|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 440, '0x01B8', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 339, '0x0153', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 113, '0x71', q'|????? (Captain - D)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 627, '0x0273', q'|Medal Box|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 267, '0x010B', q'|Wise Glasses|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 1004, '0x03EC', q'|Abra Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 755, '0x02F3', q'|Altarianite|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 178, '0x00B2', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 759, '0x02F7', q'|Sharpedonite|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 635, '0x027B', q'|Colress MCHN|', q'|Key items pocket|', q'|Black 2, White 2|', 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 491, '0x01EB', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 613, '0x0265', q'|Item Urge|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 220, '0x00DC', q'|Sea Incense|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 159, '0x009F', q'|Figy Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 529, '0x0211', q'|Data Card 25|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 577, '0x0241', q'|Pok� Toy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 80, '0x0050', q'|Sun Stone|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 523, '0x020B', q'|Data Card 19|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 386, '0x0182', q'|TM59|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 598, '0x0256', q'|X Accuracy 2|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 504, '0x01F8', q'|Gonzap's Key|', q'|Key items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 208, '0x00D0', q'|Enigma Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 277, '0x0115', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 439, '0x01B7', q'|Old Charm|', q'|Key items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 28, '0x001C', q'|Lemonade|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 56, '0x0038', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 156, '0x009C', q'|Hondew Berry|', q'|Berries pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 463, '0x01CF', q'|Storage Key|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 502, '0x01F6', q'|Small Tablet|', q'|Key items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 170, '0x00AA', q'|Kelpsy Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 62, '0x3E', q'|Lemonade|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 223, '0x00DF', q'|Amulet Coin|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 107, '0x006B', q'|Shiny Stone|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 250, '0x00FA', q'|Dragon Fang|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 675, '0x02A3', q'|Kangaskhanite|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 521, '0x0209', q'|Data Card 17|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 588, '0x024C', q'|Relic Band|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 741, '0x02E5', q'|Magma Suit|', q'|Key items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 734, '0x02DE', q'|Storage Key|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 402, '0x0192', q'|TM75|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 325, '0x0145', q'|Reaper Cloth|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 47, '0x002F', q'|Iron|', q'|Medicine pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 26, '0x001A', q'|Fresh Water|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 96, '0x0060', q'|Damp Mulch|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 472, '0x01D8', q'|Blue Card|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 134, '0x0086', q'|Chesto Berry|', q'|Berries pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 104, '0x68', q'|????? (RoseBadge - D)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 216, '0x00D8', q'|Dragon Fang|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 359, '0x0167', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 310, '0x0136', q'|Spooky Plate|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 33, '0x0021', q'|Revival Herb|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 64, '0x0040', q'|Fluffy Tail|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 47, '0x2F', q'|Soda Pop|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 949, '0x03B5', q'|Roto Hatch|', q'|Unknown pocket|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 703, '0x02BF', q'|Adventure Rules|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 513, '0x0201', q'|Data Card 09|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 501, '0x01F5', q'|Elevator Key|', q'|Key items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 529, '0x0211', q'|Data Card 25|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 494, '0x01EE', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 159, '0x009F', q'|Figy Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 73, '0x49', q'|Quick Claw|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 139, '0x8B', q'|Berry Juice|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 386, '0x0182', q'|TM59|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 115, '0x0073', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 200, '0x00C8', q'|Chilan Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 364, '0x016C', q'|TM37|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 166, '0x00A6', q'|Nanab Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 524, '0x020C', q'|Data Card 20|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 518, '0x0206', q'|Data Card 14|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 30, '0x001E', q'|EnergyPowder|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 439, '0x01B7', q'|Old Charm|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 553, '0x0229', q'|Battle CD 20|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 329, '0x0149', q'|TM41|', q'|TMs and HMs pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 318, '0x013E', q'|Rose Incense|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 278, '0x0116', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 108, '0x006C', q'|Stardust|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 17, '0x0011', q'|Potion|', q'|Medicine pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 750, '0x02EE', q'|Mega Anklet|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 299, '0x012B', q'|TM11|', q'|TMs and HMs pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 325, '0x0145', q'|Reaper Cloth|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 195, '0x00C3', q'|Everstone|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 315, '0x013B', q'|TM27|', q'|TMs and HMs pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 209, '0x00D1', q'|Mystic Water|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 123, '0x7B', q'|Heal Powder|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 122, '0x7A', q'|Energy Root|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 376, '0x0178', q'|TM49|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 189, '0x00BD', q'|Amulet Coin|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 60, '0x3C', q'|Silver Leaf|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 46, '0x2E', q'|Fresh Water|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 310, '0x0136', q'|Spooky Plate|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 441, '0x01B9', q'|Red Chain|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 64, '0x0040', q'|Fluffy Tail|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 83, '0x0053', q'|Super Repel|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 742, '0x02E6', q'|Aqua Suit|', q'|Key items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 513, '0x0201', q'|Data Card 09|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 148, '0x0094', q'|Bridge Mail M|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 786, '0x0312', q'|Psychium Z|', q'|Z-Crystals pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 159, '0x009F', q'|Figy Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 31, '0x001F', q'|Soda Pop|', q'|Medicine pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 846, '0x034E', q'|Adrenaline Orb|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 529, '0x0211', q'|Data Card 25|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 523, '0x020B', q'|Data Card 19|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 442, '0x01BA', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 346, '0x015A', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 255, '0x00FF', q'|Lax Incense|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 262, '0x0106', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 166, '0x00A6', q'|Nanab Berry|', q'|Berries pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 300, '0x012C', q'|Zap Plate|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 17, '0x0011', q'|Awakening|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 702, '0x02BE', q'|Honor of Kalos|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 389, '0x0185', q'|TM62|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 512, '0x0200', q'|Data Card 08|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 517, '0x0205', q'|Data Card 13|', q'|Items pocket|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 58, '0x3A', q'|Dire Hit|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 759, '0x02F7', q'|Sharpedonite|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 804, '0x0324', q'|Snorlium Z|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 120, '0x0078', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 588, '0x024C', q'|Relic Band|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 495, '0x01EF', q'|Heavy Ball|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 55, '0x0037', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 286, '0x011E', q'|Grip Claw|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 250, '0x00FA', q'|Dragon Fang|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 10, '0x0A', q'|Burn Heal|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 517, '0x0205', q'|DNA Sample|', q'|Key items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 550, '0x0226', q'|Electric Gem|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 432, '0x01B0', q'|Point Card|', q'|Key items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 374, '0x0176', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 30, '0x001E', q'|EnergyPowder|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 71, '0x47', q'|Silver Wing|', q'|Key items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 943, '0x03AF', q'|N-Solarizer|', q'|Key items pocket|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 325, '0x0145', q'|Reaper Cloth|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 239, '0x00EF', q'|Miracle Seed|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 992, '0x03E0', q'|Vulpix Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 117, '0x0075', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 450, '0x01C2', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 326, '0x0146', q'|Razor Claw|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 52, '0x0034', q'|Zinc|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 126, '0x007E', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 384, '0x0180', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 139, '0x008B', q'|Oran Berry|', q'|Berries pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 255, '0x00FF', q'|Lax Incense|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 863, '0x035F', q'|Silver Nanab Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 500, '0x01F4', q'|Jail Key|', q'|Key items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 246, '0xF6', q'|TM46|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 193, '0x00C1', q'|DeepSeaScale|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 608, '0x0260', q'|X Defense 6|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 420, '0x01A4', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 819, '0x0333', q'|Rockium Z|', q'|Z-Crystals pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 300, '0x012C', q'|Zap Plate|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 358, '0x0166', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 82, '0x0052', q'|Fire Stone|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 343, '0x0157', q'|TM16|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 581, '0x0245', q'|Big Nugget|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 371, '0x0173', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 177, '0x00B1', q'|Rabuta Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 210, '0x00D2', q'|Sharp Beak|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 34, '0x0022', q'|Ether|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 440, '0x01B8', q'|Galactic Key|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 44, '0x2C', q'|Dire Hit|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 404, '0x0194', q'|TM77|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 0, '0x0000', q'|None|', q'|Unknown pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 292, '0x0124', q'|Power Band|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 383, '0x017F', q'|TM56|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 704, '0x02C0', q'|Strange Souvenir|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 286, '0x011E', q'|Grip Claw|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 570, '0x023A', q'|Swift Wing|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 41, '0x0029', q'|Red Flute|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 295, '0x0127', q'|TM07|', q'|TMs and HMs pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 402, '0x0192', q'|TM75|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 291, '0x0123', q'|TM03|', q'|TMs and HMs pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 540, '0x021C', q'|Rocky Helmet|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 327, '0x0147', q'|Razor Fang|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 884, '0x0374', q'|Grassy Seed|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 580, '0x0244', q'|Battle CD 47|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 325, '0x0145', q'|Reaper Cloth|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 369, '0x0171', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 322, '0x0142', q'|Electirizer|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 750, '0x02EE', q'|Mega Anklet|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 353, '0x0161', q'|Gold Teeth|', q'|Key items pocket|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 101, '0x0065', q'|Helix Fossil|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 66, '0x0042', q'|Carbos|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 293, '0x0125', q'|Power Anklet|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 986, '0x03DA', q'|Ekans Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 376, '0x0178', q'|TM49|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 326, '0x0146', q'|Razor Claw|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 310, '0x0136', q'|Spooky Plate|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 543, '0x021F', q'|Ring Target|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 645, '0x0285', q'|Ability Capsule|', q'|Medicine pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 679, '0x02A7', q'|Alakazite|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 620, '0x026C', q'|TM95|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 408, '0x0198', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 180, '0xB4', q'|Brick Piece|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 233, '0x00E9', q'|Metal Coat|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 166, '0x00A6', q'|Nanab Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 132, '0x0084', q'|???|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 518, '0x0206', q'|Data Card 14|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 205, '0x00CD', q'|Miracle Seed|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 628, '0x0274', q'|DNA Splicers|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 300, '0x012C', q'|Zap Plate|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 53, '0x0035', q'|PP Max|', q'|Medicine pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 726, '0x02D6', q'|Eon Ticket|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 62, '0x003E', q'|X Sp. Def|', q'|Battle items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 22, '0x16', q'|CascadeBadge|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 135, '0x0087', q'|Adamant Orb|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 1054, '0x041E', q'|Mewtwo Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 389, '0x0185', q'|TM62|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 702, '0x02BE', q'|Honor of Kalos|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 318, '0x013E', q'|Rose Incense|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 383, '0x017F', q'|TM56|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 404, '0x0194', q'|TM77|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 690, '0x02B2', q'|TM96|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 851, '0x0353', q'|Beast Ball|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 286, '0x011E', q'|Grip Claw|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 56, '0x0038', q'|Dire Hit|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 208, '0x00D0', q'|Enigma Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 482, '0x01E2', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 699, '0x02BB', q'|Discount Coupon|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 952, '0x03B8', q'|Roto Exp. Points|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 222, '0x00DE', q'|Lucky Punch|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 239, '0x00EF', q'|Miracle Seed|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 154, '0x009A', q'|Kelpsy Berry|', q'|Berries pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 856, '0x0358', q'|Purple Nectar|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 293, '0x0125', q'|Power Anklet|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 645, '0x0285', q'|Ability Capsule|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 489, '0x01E9', q'|Pink Apricorn|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 376, '0x0178', q'|TM49|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 606, '0x025E', q'|X Special 6|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 575, '0x023F', q'|Pass Orb|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 568, '0x0238', q'|Battle CD 35|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 719, '0x02CF', q'|Acro Bike|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 469, '0x01D5', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 31, '0x001F', q'|Soda Pop|', q'|Medicine pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 116, '0x0074', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 233, '0x00E9', q'|Metal Coat|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 413, '0x019D', q'|TM86|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 300, '0x012C', q'|Zap Plate|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 628, '0x0274', q'|DNA Splicers|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 135, '0x0087', q'|Adamant Orb|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 527, '0x020F', q'|Data Card 23|', q'|Items pocket|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 421, '0x01A5', q'|HM02|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 389, '0x0185', q'|TM62|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 702, '0x02BE', q'|Honor of Kalos|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 735, '0x02DF', q'|Devon Scope|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 146, '0x0092', q'|Aguav Berry|', q'|Berries pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 242, '0x00F2', q'|Magnet|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 298, '0x012A', q'|Flame Plate|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 286, '0x011E', q'|Grip Claw|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 471, '0x01D7', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 147, '0x0093', q'|Iapapa Berry|', q'|Berries pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 297, '0x0129', q'|TM09|', q'|TMs and HMs pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 56, '0x0038', q'|Dire Hit|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 234, '0x00EA', q'|Leftovers|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 313, '0x0139', q'|TM25|', q'|TMs and HMs pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 402, '0x0192', q'|TM75|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 239, '0x00EF', q'|Miracle Seed|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 881, '0x0371', q'|Electric Seed|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 296, '0x0128', q'|Big Root|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 810, '0x032A', q'|Electrium Z|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 575, '0x023F', q'|Pass Orb|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 483, '0x01E3', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 362, '0x016A', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 85, '0x0055', q'|Escape Rope|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 11, '0x000B', q'|Luxury Ball|', q'|Pok� Balls pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 334, '0x014E', q'|TM07|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 952, '0x03B8', q'|Roto Exp. Points|', q'|Unknown pocket|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 298, '0x012A', q'|TM10|', q'|TMs and HMs pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 105, '0x0069', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 233, '0x00E9', q'|Metal Coat|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 402, '0x0192', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 368, '0x0170', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 160, '0x00A0', q'|Wiki Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 484, '0x01E4', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 466, '0x01D2', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 475, '0x01DB', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 226, '0x00E2', q'|DeepSeaTooth|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 324, '0x0144', q'|Dubious Disc|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 476, '0x01DC', q'|Basement Key|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 789, '0x0315', q'|Ghostium Z|', q'|Z-Crystals pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 450, '0x01C2', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 805, '0x0325', q'|Eevium Z|', q'|Z-Crystals pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 450, '0x01C2', q'|Bike|', q'|Key items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 354, '0x0162', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 492, '0x01EC', q'|Fast Ball|', q'|Pok� Balls pocket|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 298, '0x012A', q'|Flame Plate|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 1037, '0x040D', q'|Jynx Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 197, '0x00C5', q'|Lucky Egg|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 518, '0x0206', q'|Data Card 14|', q'|Items pocket|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 234, '0x00EA', q'|Leftovers|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 237, '0xED', q'|TM45|', q'|TMs and HMs pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 194, '0xC2', q'|TM04|', q'|TMs and HMs pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 322, '0x0142', q'|Electirizer|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 56, '0x0038', q'|Dire Hit|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 378, '0x017A', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 182, '0x00B6', q'|Exp. Share|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 50, '0x0032', q'|Rare Candy|', q'|Medicine pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 612, '0x0264', q'|Item Drop|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 838, '0x0346', q'|???|', q'|Unknown pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 755, '0x02F3', q'|Altarianite|', q'|Items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 414, '0x019E', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 388, '0x0184', q'|TM61|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 363, '0x016B', q'|Fame Checker|', q'|Key items pocket|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 575, '0x023F', q'|Pass Orb|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 712, '0x02C8', q'|Looker Ticket|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 141, '0x008D', q'|Inquiry Mail|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 465, '0x01D1', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 55, '0x0037', q'|Guard Spec.|', q'|Battle items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 4, '0x0004', q'|Pok� Ball|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 370, '0x0172', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 437, '0x01B5', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 177, '0x00B1', q'|Rabuta Berry|', q'|Berries pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 36, '0x0024', q'|Elixir|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 89, '0x59', q'|Blu Apricorn|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 247, '0x00F7', q'|Spell Tag|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 160, '0x00A0', q'|Wiki Berry|', q'|Berries pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 44, '0x002C', q'|Berry Juice|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 898, '0x0382', q'|???|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 226, '0x00E2', q'|DeepSeaTooth|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 179, '0x00B3', q'|Spelon Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 588, '0x024C', q'|Relic Band|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 866, '0x0362', q'|???|', q'|Unknown pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 699, '0x02BB', q'|Discount Coupon|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 283, '0x011B', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 298, '0x012A', q'|Flame Plate|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 175, '0x00AF', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 207, '0x00CF', q'|Starf Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 130, '0x0082', q'|unknown|', q'|Unknown pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 777, '0x0309', q'|Firium Z|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 291, '0x0123', q'|Power Lens|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 90, '0x005A', q'|Stardust|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 296, '0x0128', q'|Big Root|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 23, '0x0017', q'|Full Heal|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 377, '0x0179', q'|TM50|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 50, '0x0032', q'|Rare Candy|', q'|Medicine pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 124, '0x007C', q'|Candy Jar|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 49, '0x0031', q'|Calcium|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 416, '0x01A0', q'|TM89|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 712, '0x02C8', q'|Looker Ticket|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 921, '0x0399', q'|Solganium Z|', q'|Z-Crystals pocket|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 554, '0x022A', q'|Poison Gem|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 279, '0x0117', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 347, '0x15B', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 878, '0x036E', q'|Lift Key|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 102, '0x0066', q'|Dome Fossil|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 172, '0x00AC', q'|Hondew Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 250, '0xFA', q'|HM08|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 247, '0x00F7', q'|Spell Tag|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 48, '0x0030', q'|Carbos|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 535, '0x0217', q'|Blue Orb|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 187, '0xBB', q'|Bluesky Mail|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 179, '0x00B3', q'|Spelon Berry|', q'|Berries pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 478, '0x01DE', q'|Red Scale|', q'|Key items pocket|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 2, '0x02', q'|Ultra Ball|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 836, '0x0344', q'|Pikashunium Z|', q'|Z-Crystals pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 68, '0x0044', q'|Black Flute|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 152, '0x0098', q'|Pinap Berry|', q'|Berries pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 166, '0x00A6', q'|Durin Berry|', q'|Berries pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 624, '0x0270', q'|Gram 2|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 251, '0x00FB', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 298, '0x012A', q'|Flame Plate|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 130, '0x0082', q'|unknown|', q'|Unknown pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 291, '0x0123', q'|Power Lens|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 260, '0x0104', q'|Coin Case|', q'|Key items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 442, '0x01BA', q'|Town Map|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 503, '0x01F7', q'|Tidal Bell|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 134, '0x0086', q'|Chesto Berry|', q'|Berries pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 101, '0x0065', q'|Helix Fossil|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 856, '0x0358', q'|Purple Nectar|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 195, '0x00C3', q'|Charti Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 296, '0x0128', q'|Big Root|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 96, '0x0060', q'|Thunderstone|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 443, '0x01BB', q'|Vs. Seeker|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 50, '0x0032', q'|Rare Candy|', q'|Medicine pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 509, '0x01FD', q'|Data Card 05|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 330, '0x014A', q'|TM03|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 37, '0x25', q'|Iron|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 204, '0x00CC', q'|Petaya Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 504, '0x01F8', q'|Rage Candy Bar|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 395, '0x018B', q'|TM68|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 198, '0x00C6', q'|Scope Lens|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 127, '0x7F', q'|Card Key|', q'|Key items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 416, '0x01A0', q'|TM89|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 64, '0x0040', q'|Protein|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 554, '0x022A', q'|Poison Gem|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 54, '0x36', q'|Max Revive|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 756, '0x02F4', q'|Galladite|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 211, '0x00D3', q'|Jaboca Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 629, '0x0275', q'|DNA Splicers|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 372, '0x0174', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 784, '0x0310', q'|Groundium Z|', q'|Z-Crystals pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 26, '0x001A', q'|Super Potion|', q'|Medicine pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 392, '0x0188', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 343, '0x0157', q'|TM16|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 61, '0x003D', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 791, '0x0317', q'|Darkinium Z|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 268, '0x010C', q'|Expert Belt|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 175, '0x00AF', q'|Enigma Berry|', q'|Berries pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 359, '0x0167', q'|TM32|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 102, '0x0066', q'|Dome Fossil|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 694, '0x02B6', q'|TM100|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 230, '0xE6', q'|TM38|', q'|TMs and HMs pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 865, '0x0361', q'|Silver Pinap Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 15, '0x0F', q'|Max Potion|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 939, '0x03AB', q'|Yellow Petal|', q'|Key items pocket|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 160, '0x00A0', q'|Wiki Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 324, '0x0144', q'|Dubious Disc|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 236, '0xEC', q'|TM44|', q'|TMs and HMs pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 47, '0x002F', q'|Shoal Shell|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 149, '0x0095', q'|Bluk Berry|', q'|Berries pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 68, '0x0044', q'|Black Flute|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 183, '0xB7', q'|Portraitmail|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 124, '0x007C', q'|unknown|', q'|Unknown pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 235, '0x00EB', q'|Dragon Scale|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 242, '0xF2', q'|TM50|', q'|TMs and HMs pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 731, '0x02DB', q'|Key to Room 2|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 369, '0x0171', q'|TM42|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 632, '0x0278', q'|Shiny Charm|', q'|Key items pocket|', q'|Black 2, White 2|', 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 143, '0x008F', q'|Figy Berry|', q'|Berries pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 415, '0x019F', q'|TM88|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 187, '0x00BB', q'|Rindo Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 166, '0x00A6', q'|Nanab Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 130, '0x0082', q'|unknown|', q'|Unknown pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 977, '0x03D1', q'|Quick Candy XL|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 101, '0x0065', q'|Helix Fossil|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 360, '0x0168', q'|TM33|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 443, '0x01BB', q'|Vs. Seeker|', q'|Key items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 134, '0x0086', q'|Sweet Heart|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 458, '0x01CA', q'|Magma Stone|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 47, '0x002F', q'|Iron|', q'|Medicine pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 481, '0x01E1', q'|Machine Part|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 1044, '0x0414', q'|Eevee Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 395, '0x018B', q'|TM68|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 22, '0x0016', q'|Parlyz Heal|', q'|Medicine pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 280, '0x0118', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 634, '0x027A', q'|Grubby Hanky|', q'|Key items pocket|', q'|Black 2, White 2|', 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 322, '0x0142', q'|Electirizer|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 279, '0x0117', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 133, '0x0085', q'|Cheri Berry|', q'|Berries pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 348, '0x15C', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 93, '0x005D', q'|Sun Stone|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 484, '0x01E4', q'|Mystery Egg|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 534, '0x0216', q'|Red Orb|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 722, '0x02D2', q'|Soot Sack|', q'|Key items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 542, '0x021E', q'|Red Card|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 126, '0x007E', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 329, '0x0149', q'|TM41|', q'|TMs and HMs pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 289, '0x0121', q'|TM01|', q'|TMs and HMs pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 16, '0x0010', q'|Cherish Ball|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 395, '0x018B', q'|TM68|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 580, '0x0244', q'|Balm Mushroom|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 156, '0x009C', q'|Hondew Berry|', q'|Berries pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 256, '0x0100', q'|Pink Scarf|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 68, '0x0044', q'|Black Flute|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 802, '0x0322', q'|Marshadium Z|', q'|Z-Crystals pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 387, '0x0183', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 691, '0x02B3', q'|TM97|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 624, '0x0270', q'|Gram 2|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 882, '0x0372', q'|Psychic Seed|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 337, '0x0151', q'|TM49|', q'|TMs and HMs pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 360, '0x0168', q'|TM33|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 396, '0x018C', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 296, '0x0128', q'|Big Root|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 134, '0x86', q'|Pass|', q'|Key items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 458, '0x01CA', q'|Magma Stone|', q'|Key items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 47, '0x002F', q'|Iron|', q'|Medicine pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 395, '0x018B', q'|TM68|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 10, '0x000A', q'|Timer Ball|', q'|Pok� Balls pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 443, '0x01BB', q'|Vs. Seeker|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 293, '0x0125', q'|Power Anklet|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 288, '0x0120', q'|Devon Scope|', q'|Key items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 416, '0x01A0', q'|TM89|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 38, '0x26', q'|Carbos|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 178, '0x00B2', q'|Nomel Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 23, '0x17', q'|ThunderBadge|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 296, '0x0128', q'|Big Root|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 305, '0x0131', q'|TM17|', q'|TMs and HMs pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 299, '0x012B', q'|TM11|', q'|TMs and HMs pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 897, '0x0381', q'|???|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 98, '0x0062', q'|Gooey Mulch|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 250, '0xFA', q'|TM50|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 542, '0x021E', q'|Red Card|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 439, '0x01B7', q'|Old Charm|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 277, '0x0115', q'|Metronome|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 313, '0x0139', q'|Iron Plate|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 507, '0x01FB', q'|Data Card 03|', q'|Items pocket|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 1043, '0x0413', q'|Ditto Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 443, '0x01BB', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 973, '0x03CD', q'|Mighty Candy XL|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 68, '0x0044', q'|Black Flute|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 284, '0x011C', q'|Heat Rock|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 624, '0x0270', q'|Gram 2|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 299, '0x012B', q'|Splash Plate|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 304, '0x0130', q'|Toxic Plate|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 119, '0x0077', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 152, '0x0098', q'|Rawst Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 552, '0x0228', q'|Ice Gem|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 27, '0x1B', q'|VolcanoBadge|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 182, '0x00B6', q'|Durin Berry|', q'|Berries pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 77, '0x4D', q'|Sharp Beak|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 443, '0x01BB', q'|Vs. Seeker|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 458, '0x01CA', q'|Magma Stone|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 451, '0x01C3', q'|Suite Key|', q'|Key items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 753, '0x02F1', q'|Sceptilite|', q'|Items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 64, '0x0040', q'|Fluffy Tail|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 484, '0x01E4', q'|Mystery Egg|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 208, '0x00D0', q'|Magnet|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 345, '0x0159', q'|TM18|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 467, '0x01D3', q'|Secret Key|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 294, '0x0126', q'|TM06|', q'|TMs and HMs pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 161, '0x00A1', q'|Rabuta Berry|', q'|Berries pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 375, '0x0177', q'|TM48|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 98, '0x0062', q'|Gooey Mulch|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 337, '0x0151', q'|TM10|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 160, '0x00A0', q'|Wiki Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 122, '0x007A', q'|Medicine Pocket|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 192, '0xC0', q'|TM02|', q'|TMs and HMs pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 76, '0x004C', q'|X Defend|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 97, '0x0061', q'|Stable Mulch|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 142, '0x008E', q'|Sitrus Berry|', q'|Berries pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 38, '0x0026', q'|Lava Cookie|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 284, '0x011C', q'|Heat Rock|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 176, '0x00B0', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 246, '0x00F6', q'|Never-Melt Ice|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 139, '0x008B', q'|Bubble Mail|', q'|Mail pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 304, '0x0130', q'|Toxic Plate|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 402, '0x0192', q'|TM75|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 119, '0x0077', q'|unknown|', q'|Unknown pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 213, '0x00D5', q'|Bright Powder|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 90, '0x005A', q'|Stardust|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 226, '0xE2', q'|TM26|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 182, '0x00B6', q'|Durin Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 716, '0x02CC', q'|Mega Charm|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 226, '0x00E2', q'|Deep Sea Tooth|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 574, '0x023E', q'|Liberty Pass|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 500, '0x01F4', q'|Park Ball|', q'|Pok� Balls pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 167, '0x00A7', q'|Wepear Berry|', q'|Berries pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 487, '0x01E7', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 458, '0x01CA', q'|Magma Stone|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 22, '0x0016', q'|Parlyz Heal|', q'|Medicine pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 516, '0x0204', q'|Data Card 12|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 322, '0x0142', q'|Electirizer|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 83, '0x0053', q'|Thunderstone|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 484, '0x01E4', q'|Mystery Egg|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 578, '0x0242', q'|Battle CD 45|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 124, '0x7C', q'|Revival Herb|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 332, '0x014C', q'|TM05|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 877, '0x036D', q'|Gold Teeth|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 467, '0x01D3', q'|Secret Key|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 499, '0x01F3', q'|Sport Ball|', q'|Pok� Balls pocket|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 980, '0x03D4', q'|Squirtle Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 747, '0x02EB', q'|Mega Anchor|', q'|Key items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 121, '0x79', q'|EnergyPowder|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 137, '0x0089', q'|Greet Mail|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 605, '0x025D', q'|X Speed 6|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 147, '0x0093', q'|Iapapa Berry|', q'|Berries pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 223, '0xDF', q'|TM31|', q'|TMs and HMs pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 353, '0x0161', q'|TM26|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 511, '0x01FF', q'|Down St. Key|', q'|Key items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 157, '0x9D', q'|Heavy Ball|', q'|Pok� Balls pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 383, '0x017F', q'|TM56|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 163, '0x00A3', q'|Iapapa Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 883, '0x0373', q'|Misty Seed|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 71, '0x0047', q'|Shoal Shell|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 0, '0x0000', q'|None|', q'|Unknown pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 58, '0x003A', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 326, '0x0146', q'|Razor Claw|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 304, '0x0130', q'|Toxic Plate|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 284, '0x011C', q'|Heat Rock|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 727, '0x02D7', q'|Scanner|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 552, '0x0228', q'|Ice Gem|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 50, '0x0032', q'|Rare Candy|', q'|Medicine pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 394, '0x018A', q'|TM67|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 291, '0x0123', q'|Power Lens|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 9, '0x0009', q'|Repeat Ball|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 152, '0x0098', q'|Rawst Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 405, '0x0195', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 90, '0x005A', q'|Stardust|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 49, '0x0031', q'|Blue Shard|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 226, '0x00E2', q'|Deep Sea Tooth|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 167, '0x00A7', q'|Wepear Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 288, '0x0120', q'|Sticky Barb|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 658, '0x0292', q'|Ampharosite|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 529, '0x0211', q'|Voice Case 2|', q'|Key items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 174, '0x00AE', q'|Starf Berry|', q'|Berries pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 158, '0x009E', q'|Sitrus Berry|', q'|Berries pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 141, '0x008D', q'|Inquiry Mail|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 83, '0x0053', q'|Thunderstone|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 405, '0x0195', q'|TM78|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 561, '0x0231', q'|Dragon Gem|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 268, '0x010C', q'|Wailmer Pail|', q'|Key items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 467, '0x01D3', q'|Secret Key|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 385, '0x0181', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 743, '0x02E7', q'|Pair of Tickets|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 228, '0x00E4', q'|Smoke Ball|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 534, '0x0216', q'|Red Orb|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 428, '0x01AC', q'|Explorer Kit|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 10, '0x000A', q'|Timer Ball|', q'|Pok� Balls pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 208, '0x00D0', q'|Magnet|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 82, '0x0052', q'|Fire Stone|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 605, '0x025D', q'|X Speed 6|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 534, '0x0216', q'|Battle CD 01|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 396, '0x018C', q'|TM69|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 264, '0x0108', q'|Yellow Scarf|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 108, '0x006C', q'|Dusk Stone|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 135, '0x0087', q'|Adamant Orb|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 346, '0x015A', q'|TM19|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 283, '0x011B', q'|Rm. 4 Key|', q'|Key items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 284, '0x011C', q'|Heat Rock|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 547, '0x0223', q'|Battle CD 14|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 0, '0x0000', q'|None|', q'|Unknown pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 326, '0x0146', q'|Razor Claw|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 666, '0x029A', q'|Houndoominite|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 440, '0x01B8', q'|Galactic Key|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 214, '0xD6', q'|TM23|', q'|TMs and HMs pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 291, '0x0123', q'|Power Lens|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 16, '0x0010', q'|Ice Heal|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 552, '0x0228', q'|Ice Gem|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 152, '0x0098', q'|Rawst Berry|', q'|Berries pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 407, '0x0197', q'|TM80|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 23, '0x0017', q'|Full Heal|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 905, '0x0389', q'|Flying Memory|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 814, '0x032E', q'|Poisonium Z|', q'|Z-Crystals pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 182, '0x00B6', q'|Durin Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 901, '0x0385', q'|Super Lure|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 994, '0x03E2', q'|Zubat Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 167, '0x00A7', q'|Wepear Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 237, '0x00ED', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 158, '0x009E', q'|Sitrus Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 517, '0x0205', q'|Data Card 13|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 944, '0x03B0', q'|N-Lunarizer|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 37, '0x0025', q'|Max Elixir|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 269, '0x010D', q'|Light Clay|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 148, '0x0094', q'|Bridge Mail M|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 554, '0x022A', q'|Poison Gem|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 429, '0x01AD', q'|Loot Sack|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 428, '0x01AC', q'|Explorer Kit|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 207, '0x00CF', q'|Black Belt|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 920, '0x0398', q'|Fairy Memory|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 390, '0x0186', q'|TM63|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 264, '0x0108', q'|Yellow Scarf|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 408, '0x0198', q'|TM81|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 337, '0x0151', q'|TM10|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 500, '0x01F4', q'|Park Ball|', q'|Pok� Balls pocket|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 409, '0x0199', q'|TM82|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 772, '0x0304', q'|Meteorite|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 108, '0x006C', q'|Dusk Stone|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 168, '0x00A8', q'|Liechi Berry|', q'|Berries pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 345, '0x0159', q'|TM18|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 181, '0x00B5', q'|Macho Brace|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 495, '0x01EF', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 412, '0x019C', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 297, '0x0129', q'|TM09|', q'|TMs and HMs pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 546, '0x0222', q'|Cell Battery|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 219, '0x00DB', q'|Mental Herb|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 124, '0x007C', q'|unknown|', q'|Unknown pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 440, '0x01B8', q'|Galactic Key|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 61, '0x003D', q'|X Sp. Atk|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 2, '0x0002', q'|Ultra Ball|', q'|Pok� Balls pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 228, '0x00E4', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 29, '0x1D', q'|Escape Rope|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 20, '0x0014', q'|Max Potion|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 512, '0x0200', q'|Data Card 08|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 730, '0x02DA', q'|Key to Room 1|', q'|Key items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 17, '0x11', q'|Super Potion|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 64, '0x40', q'|Gold Teeth|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 724, '0x02D4', q'|Pok�block Kit|', q'|Key items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 140, '0x008C', q'|Thanks Mail|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 18, '0x0012', q'|Antidote|', q'|Medicine pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 612, '0x0264', q'|Item Drop|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 63, '0x003F', q'|Pok� Doll|', q'|Battle items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 288, '0x0120', q'|Sticky Barb|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 158, '0x009E', q'|Sitrus Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 141, '0x008D', q'|Inquiry Mail|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 827, '0x033B', q'|Incinium Z|', q'|Z-Crystals pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 388, '0x0184', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 280, '0x0118', q'|Destiny Knot|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 62, '0x003E', q'|X Sp. Def|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 340, '0x0154', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 18, '0x0012', q'|Parlyz Heal|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 45, '0x2D', q'|Bike Voucher|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 149, '0x95', q'|Teru-sama|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 70, '0x46', q'|Oak's Parcel|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 420, '0x01A4', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 847, '0x034F', q'|Zygarde Cube|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 198, '0x00C6', q'|Colbur Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 264, '0x0108', q'|Yellow Scarf|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 494, '0x01EE', q'|Lure Ball|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 82, '0x0052', q'|Fire Stone|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 50, '0x32', q'|Teru-sama|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 258, '0x0102', q'|Yellow Scarf|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 346, '0x015A', q'|TM19|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 345, '0x0159', q'|TM18|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 638, '0x027E', q'|Reveal Glass|', q'|Key items pocket|', q'|Black 2, White 2|', 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 162, '0x00A2', q'|Nomel Berry|', q'|Berries pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 389, '0x0185', q'|TM62|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 152, '0x0098', q'|Rawst Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 1029, '0x0405', q'|Chansey Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 809, '0x0329', q'|Waterium Z|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 271, '0x010F', q'|Power Herb|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 619, '0x026B', q'|TM94|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 546, '0x0222', q'|Cell Battery|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 169, '0x00A9', q'|Ganlon Berry|', q'|Berries pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 227, '0x00E3', q'|Deep Sea Scale|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 219, '0x00DB', q'|Mental Herb|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 0, '0x0000', q'|None|', q'|Unknown pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 118, '0x0076', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 124, '0x007C', q'|unknown|', q'|Unknown pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 44, '0x002C', q'|Berry Juice|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 179, '0x00B3', q'|BrightPowder|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 987, '0x03DB', q'|Pikachu Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 217, '0x00D9', q'|Quick Claw|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 361, '0x0169', q'|TM34|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 18, '0x0012', q'|Antidote|', q'|Medicine pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 288, '0x0120', q'|Sticky Barb|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 158, '0x009E', q'|Sitrus Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 83, '0x0053', q'|Thunder Stone|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 383, '0x017F', q'|TM56|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 328, '0x0148', q'|TM01|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 189, '0xBD', q'|Mirage Mail|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 136, '0x0088', q'|Rawst Berry|', q'|Berries pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 541, '0x021D', q'|Air Balloon|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 238, '0xEE', q'|TM46|', q'|TMs and HMs pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 0, '0x0000', q'|None|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 531, '0x0213', q'|Data Card 27|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 753, '0x02F1', q'|Sceptilite|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 429, '0x01AD', q'|Loot Sack|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 173, '0x00AD', q'|Grepa Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 254, '0x00FE', q'|Red Scarf|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 345, '0x0159', q'|TM18|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 108, '0x006C', q'|Dusk Stone|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 546, '0x0222', q'|Cell Battery|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 346, '0x015A', q'|TM19|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 264, '0x0108', q'|Yellow Scarf|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 428, '0x01AC', q'|Explorer Kit|', q'|Key items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 219, '0x00DB', q'|Mental Herb|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 303, '0x012F', q'|TM15|', q'|TMs and HMs pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 285, '0x011D', q'|Damp Rock|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 546, '0x0222', q'|Cell Battery|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 505, '0x01F9', q'|Data Card 01|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 182, '0x00B6', q'|Durin Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 387, '0x0183', q'|TM60|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 214, '0x00D6', q'|TwistedSpoon|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 179, '0x00B3', q'|Spelon Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 113, '0x71', q'|Spell Tag|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 426, '0x01AA', q'|unknown|', q'|Unknown pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 370, '0x0172', q'|MysticTicket|', q'|Key items pocket|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 330, '0x014A', q'|TM03|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 403, '0x0193', q'|TM76|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 517, '0x0205', q'|Data Card 13|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 1020, '0x03FC', q'|Krabby Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 293, '0x0125', q'|Power Anklet|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 88, '0x0058', q'|Pearl|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 380, '0x017C', q'|TM53|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 53, '0x0035', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 328, '0x0148', q'|TM01|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 389, '0x0185', q'|TM62|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 541, '0x021D', q'|Air Balloon|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 435, '0x01B3', q'|Fashion Case|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 629, '0x0275', q'|DNA Splicers|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 531, '0x0213', q'|Data Card 27|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 386, '0x0182', q'|TM59|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 321, '0x0141', q'|TM33|', q'|TMs and HMs pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 429, '0x01AD', q'|Loot Sack|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 838, '0x0346', q'|???|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 337, '0x0151', q'|TM10|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 816, '0x0330', q'|Flyinium Z|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 271, '0x010F', q'|Power Herb|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 502, '0x01F6', q'|Bonsly Card|', q'|Key items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 830, '0x033E', q'|Marshadium Z|', q'|Z-Crystals pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 204, '0xCC', q'|TM13|', q'|TMs and HMs pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 86, '0x0056', q'|TinyMushroom|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 497, '0x01F1', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 285, '0x011D', q'|Damp Rock|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 61, '0x003D', q'|X Sp. Atk|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 33, '0x0021', q'|Revival Herb|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 394, '0x018A', q'|TM67|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 496, '0x01F0', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 356, '0x0164', q'|TM29|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 319, '0x013F', q'|TM31|', q'|TMs and HMs pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 256, '0x0100', q'|Lucky Punch|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 387, '0x0183', q'|TM60|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 179, '0x00B3', q'|Spelon Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 230, '0x00E6', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 604, '0x025C', q'|X Accuracy 3|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 528, '0x0210', q'|Data Card 24|', q'|Items pocket|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 410, '0x019A', q'|TM83|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 782, '0x030E', q'|Fightinium Z|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 192, '0x00C0', q'|DeepSeaTooth|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 336, '0x0150', q'|TM09|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 171, '0x00AB', q'|Qualot Berry|', q'|Berries pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 426, '0x01AA', q'|unknown|', q'|Unknown pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 288, '0x0120', q'|Sticky Barb|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 199, '0xC7', q'|HM04|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 410, '0x019A', q'|TM83|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 335, '0x014F', q'|TM47|', q'|TMs and HMs pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 368, '0x0170', q'|Rainbow Pass|', q'|Key items pocket|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 221, '0xDD', q'|TM29|', q'|TMs and HMs pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 62, '0x003E', q'|X Sp. Def|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 103, '0x0067', q'|TinyMushroom|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 958, '0x03BE', q'|Roto Boost|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 192, '0x00C0', q'|DeepSeaTooth|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 268, '0x010C', q'|Expert Belt|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 591, '0x024F', q'|Casteliacone|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 343, '0x0157', q'|TM16|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 470, '0x01D6', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 627, '0x0273', q'|Medal Box|', q'|Key items pocket|', q'|Black 2, White 2|', 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 173, '0x00AD', q'|Grepa Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 489, '0x01E9', q'|Pnk Apricorn|', q'|Items pocket|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 212, '0x00D4', q'|NeverMeltIce|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 552, '0x0228', q'|Battle CD 19|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 198, '0xC6', q'|TM07|', q'|TMs and HMs pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 481, '0x01E1', q'|Machine Part|', q'|Key items pocket|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 86, '0x0056', q'|TinyMushroom|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 233, '0xE9', q'|TM41|', q'|TMs and HMs pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 225, '0xE1', q'|TM33|', q'|TMs and HMs pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 799, '0x031F', q'|Incinium Z|', q'|Z-Crystals pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 379, '0x017B', q'|TM52|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 468, '0x01D4', q'|Apricorn Box|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 67, '0x0043', q'|Red Flute|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 229, '0x00E5', q'|Everstone|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 285, '0x011D', q'|Damp Rock|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 265, '0x0109', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 499, '0x01F3', q'|Sport Ball|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 931, '0x03A3', q'|Lycanium Z|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 393, '0x0189', q'|TM66|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 150, '0x0096', q'|Chesto Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 85, '0x0055', q'|Escape Rope|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 394, '0x018A', q'|TM67|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 213, '0x00D5', q'|Bright Powder|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 96, '0x60', q'|TwistedSpoon|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 196, '0xC4', q'|TM05|', q'|TMs and HMs pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 604, '0x025C', q'|X Accuracy 3|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 214, '0x00D6', q'|White Herb|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 171, '0x00AB', q'|Qualot Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 499, '0x01F3', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 388, '0x0184', q'|TM61|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 395, '0x018B', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 68, '0x0044', q'|Black Flute|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 341, '0x0155', q'|HM03|', q'|TMs and HMs pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 541, '0x021D', q'|Air Balloon|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 247, '0x00F7', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 202, '0x00CA', q'|Ganlon Berry|', q'|Berries pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 484, '0x01E4', q'|Mystery Egg|', q'|Key items pocket|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 563, '0x0233', q'|Steel Gem|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 268, '0x010C', q'|Expert Belt|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 531, '0x0213', q'|Data Card 27|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 343, '0x0157', q'|TM16|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 144, '0x0090', q'|Bridge Mail S|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 429, '0x01AD', q'|Loot Sack|', q'|Key items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 245, '0x00F5', q'|Poison Barb|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 319, '0x013F', q'|TM31|', q'|TMs and HMs pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 233, '0x00E9', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 31, '0x001F', q'|Energy Root|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 261, '0x0105', q'|Blue Scarf|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 794, '0x031A', q'|Pikanium Z|', q'|Z-Crystals pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 468, '0x01D4', q'|Apricorn Box|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 499, '0x01F3', q'|Sport Ball|', q'|Pok� Balls pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 229, '0x00E5', q'|Everstone|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 285, '0x011D', q'|Damp Rock|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 836, '0x0344', q'|Pikashunium Z|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 182, '0x00B6', q'|Exp. Share|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 256, '0x0100', q'|Lucky Punch|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 289, '0x0121', q'|Power Bracer|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 505, '0x01F9', q'|Data Card 01|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 306, '0x0132', q'|TM18|', q'|TMs and HMs pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 451, '0x01C3', q'|Suite Key|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 494, '0x01EE', q'|Lure Ball|', q'|Pok� Balls pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 692, '0x02B4', q'|TM98|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 165, '0x00A5', q'|Watmel Berry|', q'|Berries pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 387, '0x0183', q'|TM60|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 336, '0x0150', q'|TM09|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 219, '0x00DB', q'|Shell Bell|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 248, '0x00F8', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 65, '0x0041', q'|Blue Flute|', q'|Battle items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 360, '0x0168', q'|TM33|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 286, '0x011E', q'|Grip Claw|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 215, '0x00D7', q'|Macho Brace|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 385, '0x0181', q'|TM58|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 381, '0x017D', q'|TM54|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 378, '0x017A', q'|TM51|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 677, '0x02A5', q'|Absolite|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 538, '0x021A', q'|Eviolite|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 10, '0x000A', q'|Timer Ball|', q'|Pok� Balls pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 86, '0x0056', q'|Repel|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 202, '0x00CA', q'|Ganlon Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 220, '0x00DC', q'|Sea Incense|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 924, '0x039C', q'|Mimikium Z|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 165, '0x00A5', q'|Bluk Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 222, '0x00DE', q'|Silver Powder|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 766, '0x02FE', q'|Mega Cuff|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 315, '0x013B', q'|TM27|', q'|TMs and HMs pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 846, '0x034E', q'|Adrenaline Orb|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 459, '0x01CB', q'|Parcel|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 454, '0x01C6', q'|Member Card|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 77, '0x004D', q'|X Speed|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 872, '0x0368', q'|Secret Key|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 307, '0x0133', q'|Mind Plate|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 252, '0x00FC', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 213, '0xD5', q'|TM22|', q'|TMs and HMs pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 88, '0x0058', q'|Pearl|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 347, '0x15B', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 229, '0x00E5', q'|Everstone|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 128, '0x0080', q'|Shadow Mail|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 189, '0x00BD', q'|Chople Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 172, '0x00AC', q'|Hondew Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 901, '0x0385', q'|???|', q'|Unknown pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 299, '0x012B', q'|Splash Plate|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 289, '0x0121', q'|Power Bracer|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 451, '0x01C3', q'|Suite Key|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 514, '0x0202', q'|Data Card 10|', q'|Items pocket|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 211, '0x00D3', q'|Poison Barb|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 585, '0x0249', q'|Relic Silver|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 336, '0x0150', q'|TM09|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 171, '0x00AB', q'|Qualot Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 37, '0x25', q'|Pok� Doll|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 437, '0x01B5', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 61, '0x003D', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 549, '0x0225', q'|Water Gem|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 710, '0x02C6', q'|Jaw Fossil|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 471, '0x01D7', q'|Dowsing Machine|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 381, '0x017D', q'|TM54|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 240, '0x00F0', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 25, '0x0019', q'|Max Revive|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 677, '0x02A5', q'|Absolite|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 428, '0x01AC', q'|Explorer Kit|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 157, '0x009D', q'|Lum Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 1, '0x0001', q'|Master Ball|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 673, '0x02A1', q'|Lucarionite|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 55, '0x0037', q'|Guard Spec.|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 115, '0x73', q'|???? (Master - D)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 149, '0x0095', q'|Cheri Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 516, '0x0204', q'|Data Card 12|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 222, '0x00DE', q'|Silver Powder|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 399, '0x018F', q'|TM72|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 173, '0x00AD', q'|Grepa Berry|', q'|Berries pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 204, '0x00CC', q'|Hard Stone|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 267, '0x010B', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 398, '0x018E', q'|TM71|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 55, '0x37', q'|Itemfinder|', q'|Key items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 210, '0xD2', q'|TM19|', q'|TMs and HMs pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 468, '0x01D4', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 77, '0x004D', q'|Max Repel|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 896, '0x0380', q'|Small Bouquet|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 318, '0x013E', q'|Rose Incense|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 229, '0x00E5', q'|Everstone|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 6, '0x06', q'|Teru-sama|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 499, '0x01F3', q'|Sport Ball|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 172, '0x00AC', q'|Hondew Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 309, '0x0135', q'|TM21|', q'|TMs and HMs pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 509, '0x01FD', q'|Maingate Key|', q'|Key items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 66, '0x0042', q'|Yellow Flute|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 299, '0x012B', q'|Splash Plate|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 579, '0x0243', q'|Dragon Skull|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 5, '0x0005', q'|Safari Ball|', q'|Pok� Balls pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 814, '0x032E', q'|Poisonium Z|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 825, '0x0339', q'|Pikanium Z|', q'|Z-Crystals pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 366, '0x016E', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 818, '0x0332', q'|Buginium Z|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 664, '0x0298', q'|Blazikenite|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 215, '0x00D7', q'|Macho Brace|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 549, '0x0225', q'|Water Gem|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 710, '0x02C6', q'|Jaw Fossil|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 139, '0x008B', q'|Oran Berry|', q'|Berries pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 307, '0x0133', q'|TM19|', q'|TMs and HMs pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 385, '0x0181', q'|TM58|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 114, '0x72', q'|?????? (Petit Master - D)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 627, '0x0273', q'|Medal Box|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 652, '0x028C', q'|Rich Mulch|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 417, '0x01A1', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 289, '0x0121', q'|TM01|', q'|TMs and HMs pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 875, '0x036B', q'|Parcel|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 1, '0x0001', q'|Master Ball|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 69, '0x0045', q'|PP Up|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 624, '0x0270', q'|Gram 2|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 865, '0x0361', q'|???|', q'|Unknown pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 493, '0x01ED', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 173, '0x00AD', q'|Grepa Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 271, '0x010F', q'|Power Herb|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 398, '0x018E', q'|TM71|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 172, '0x00AC', q'|Apicot Berry|', q'|Berries pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 135, '0x87', q'|Teru-sama|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 689, '0x02B1', q'|Sprinklotad|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 801, '0x0321', q'|Tapunium Z|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 603, '0x025B', q'|X Attack 3|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 377, '0x0179', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 364, '0x016C', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 25, '0x19', q'|SoulBadge|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 579, '0x0243', q'|Dragon Skull|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 771, '0x0303', q'|Meteorite|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 103, '0x0067', q'|TinyMushroom|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 192, '0x00C0', q'|DeepSeaTooth|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 634, '0x027A', q'|Grubby Hanky|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 956, '0x03BC', q'|Roto HP Restore|', q'|Unknown pocket|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 381, '0x017D', q'|TM54|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 3, '0x03', q'|BrightPowder|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 244, '0x00F4', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 204, '0x00CC', q'|Petaya Berry|', q'|Berries pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 397, '0x018D', q'|TM70|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 385, '0x0181', q'|TM58|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 10, '0x000A', q'|Timer Ball|', q'|Pok� Balls pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 627, '0x0273', q'|Medal Box|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 652, '0x028C', q'|Rich Mulch|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 62, '0x003E', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 228, '0x00E4', q'|Smoke Ball|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 421, '0x01A5', q'|HM02|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 6, '0x0006', q'|Net Ball|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 723, '0x02D3', q'|Basement Key|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 271, '0x010F', q'|Power Herb|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 77, '0x004D', q'|Max Repel|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 454, '0x01C6', q'|Member Card|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 188, '0x00BC', q'|Yache Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 17, '0x11', q'|Max Potion|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 579, '0x0243', q'|Dragon Skull|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 407, '0x0197', q'|TM80|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 299, '0x012B', q'|Splash Plate|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 529, '0x0211', q'|DNA Sample|', q'|Key items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 336, '0x0150', q'|TM48|', q'|TMs and HMs pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 137, '0x0089', q'|Aspear Berry|', q'|Berries pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 721, '0x02D1', q'|Devon Parts|', q'|Key items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 561, '0x0231', q'|Battle CD 28|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 945, '0x03B1', q'|N-Solarizer|', q'|Key items pocket|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 171, '0x00AB', q'|Qualot Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 390, '0x0186', q'|TM63|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 364, '0x016C', q'|TM Case|', q'|Key items pocket|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 344, '0x0158', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 65, '0x41', q'|Elixer|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 612, '0x0264', q'|Item Drop|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 919, '0x0397', q'|Dark Memory|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 205, '0x00CD', q'|Miracle Seed|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 409, '0x0199', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 141, '0x008D', q'|Lum Berry|', q'|Berries pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 860, '0x035C', q'|Enigmatic Card|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 640, '0x0280', q'|Assault Vest|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 695, '0x02B7', q'|Power Plant Pass|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 259, '0x0103', q'|Stick|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 100, '0x0064', q'|Claw Fossil|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 379, '0x017B', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 228, '0x00E4', q'|Smoke Ball|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 421, '0x01A5', q'|HM02|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 453, '0x01C5', q'|Lunar Wing|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 729, '0x02D9', q'|Meteorite|', q'|Key items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 77, '0x004D', q'|Max Repel|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 66, '0x0042', q'|Yellow Flute|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 368, '0x0170', q'|TM41|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 774, '0x0306', q'|Meteorite Shard|', q'|Key items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 486, '0x01E6', q'|Blue Apricorn|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 381, '0x017D', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 732, '0x02DC', q'|Key to Room 4|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 603, '0x025B', q'|X Attack 3|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 857, '0x0359', q'|Sun Flute|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 187, '0x00BB', q'|Rindo Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 437, '0x01B5', q'|Pal Pad|', q'|Key items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 604, '0x025C', q'|X Accuracy 3|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 407, '0x0197', q'|TM80|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 223, '0x00DF', q'|Metal Powder|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 399, '0x018F', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 746, '0x02EA', q'|Mega Glasses|', q'|Key items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 306, '0x0132', q'|TM18|', q'|TMs and HMs pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 479, '0x01DF', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 69, '0x45', q'|Coin Case|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 201, '0x00C9', q'|Dragon Scale|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 567, '0x0237', q'|Battle CD 34|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 127, '0x007F', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 561, '0x0231', q'|Dragon Gem|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 283, '0x011B', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 47, '0x2F', q'|Leaf Stone|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 546, '0x0222', q'|Battle CD 13|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 263, '0x0107', q'|Green Scarf|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 64, '0x0040', q'|Fluffy Tail|', q'|Battle items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 936, '0x03A8', q'|Blue Petal|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 534, '0x0216', q'|Red Orb|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 736, '0x02E0', q'|S.S. Ticket|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 453, '0x01C5', q'|Lunar Wing|', q'|Key items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 742, '0x02E6', q'|Aqua Suit|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 95, '0x005F', q'|Fire Stone|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 454, '0x01C6', q'|Member Card|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 586, '0x024A', q'|Relic Gold|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 224, '0xE0', q'|TM32|', q'|TMs and HMs pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 260, '0x0104', q'|Red Scarf|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 219, '0x00DB', q'|Mental Herb|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 62, '0x003E', q'|X Sp. Def|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 81, '0x0051', q'|Fluffy Tail|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 355, '0x0163', q'|TM28|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 237, '0x00ED', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 289, '0x0121', q'|Power Bracer|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 82, '0x0052', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 237, '0x00ED', q'|Soft Sand|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 407, '0x0197', q'|TM80|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 589, '0x024D', q'|Battle CD 56|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 85, '0x0055', q'|Leaf Stone|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 751, '0x02EF', q'|Meteorite|', q'|Key items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 100, '0x0064', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 177, '0x00B1', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 180, '0x00B4', q'|Pamtre Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 190, '0x00BE', q'|Kebia Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 908, '0x038C', q'|Rock Memory|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 833, '0x0341', q'|Eevium Z|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 103, '0x67', q'|??????? (FriendshipBadge - D)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 985, '0x03D9', q'|Spearow Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 306, '0x0132', q'|Sky Plate|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 1047, '0x0417', q'|Kabuto Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 783, '0x030F', q'|Poisonium Z|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 228, '0x00E4', q'|Smoke Ball|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 202, '0x00CA', q'|Ganlon Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 123, '0x007B', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 421, '0x01A5', q'|HM02|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 232, '0xE8', q'|TM32|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 535, '0x0217', q'|Battle CD 02|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 292, '0x0124', q'|TM04|', q'|TMs and HMs pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 77, '0x004D', q'|Max Repel|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 632, '0x0278', q'|Shiny Charm|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 231, '0x00E7', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 349, '0x015D', q'|TM22|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 66, '0x0042', q'|Yellow Flute|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 449, '0x01C1', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 33, '0x21', q'|Thunderstone|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 586, '0x024A', q'|Relic Gold|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 67, '0x0043', q'|Red Flute|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 260, '0x0104', q'|Red Scarf|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 355, '0x0163', q'|TM28|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 248, '0x00F8', q'|Twisted Spoon|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 437, '0x01B5', q'|Pal Pad|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 237, '0x00ED', q'|Soft Sand|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 107, '0x006B', q'|Shiny Stone|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 469, '0x01D5', q'|Unown Report|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 289, '0x0121', q'|Power Bracer|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 37, '0x0025', q'|Revival Herb|', q'|Medicine pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 327, '0x0147', q'|TM39|', q'|TMs and HMs pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 25, '0x0019', q'|Hyper Potion|', q'|Medicine pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 372, '0x0174', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 85, '0x0055', q'|Leaf Stone|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 8, '0x0008', q'|Nest Ball|', q'|Pok� Balls pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 620, '0x026C', q'|TM95|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 130, '0x0082', q'|???|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 341, '0x0155', q'|TM14|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 459, '0x01CB', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 285, '0x011D', q'|Storage Key|', q'|Key items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 98, '0x0062', q'|Leaf Stone|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 215, '0x00D7', q'|Macho Brace|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 483, '0x01E3', q'|Rainbow Wing|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 549, '0x0225', q'|Water Gem|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 68, '0x44', q'|S.S. Ticket|', q'|Key items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 717, '0x02CD', q'|Mega Glove|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 794, '0x031A', q'|Pikanium Z|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 839, '0x0347', q'|???|', q'|Unknown pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 306, '0x0132', q'|Sky Plate|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 116, '0x0074', q'|Douse Drive|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 671, '0x029F', q'|Pinsirite|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 275, '0x0113', q'|Focus Sash|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 662, '0x0296', q'|Mewtwonite X|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 342, '0x0156', q'|TM15|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 259, '0x0103', q'|Stick|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 8, '0x0008', q'|Nest Ball|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 685, '0x02AD', q'|Latiosite|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 453, '0x01C5', q'|Lunar Wing|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 38, '0x0026', q'|Lava Cookie|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 632, '0x0278', q'|Shiny Charm|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 44, '0x2C', q'|?????|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 868, '0x0364', q'|???|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 373, '0x0175', q'|TM46|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 576, '0x0240', q'|Dream Ball|', q'|Pok� Balls pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 273, '0x0111', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 88, '0x0058', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 689, '0x02B1', q'|Sprinklotad|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 260, '0x0104', q'|Red Scarf|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 603, '0x025B', q'|X Attack 3|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 360, '0x0168', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 891, '0x037B', q'|???|', q'|Unknown pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 437, '0x01B5', q'|Pal Pad|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 187, '0x00BB', q'|King's Rock|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 414, '0x019E', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 253, '0x00FD', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 107, '0x006B', q'|Shiny Stone|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 439, '0x01B7', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 257, '0x0101', q'|Green Scarf|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 144, '0x90', q'|Dragon Fang|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 120, '0x0078', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 245, '0xF5', q'|TM45|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 85, '0x0055', q'|Leaf Stone|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 602, '0x025A', q'|X Defense 3|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 321, '0x0141', q'|TM33|', q'|TMs and HMs pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 561, '0x0231', q'|Dragon Gem|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 69, '0x0045', q'|PP Up|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 756, '0x02F4', q'|Galladite|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 428, '0x01AC', q'|Explorer Kit|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 574, '0x023E', q'|Liberty Pass|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 544, '0x0220', q'|Battle CD 11|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 449, '0x01C1', q'|Poffin Case|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 506, '0x01FA', q'|ID Card|', q'|Key items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 717, '0x02CD', q'|Mega Glove|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 909, '0x038D', q'|Bug Memory|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 93, '0x005D', q'|Heart Scale|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 306, '0x0132', q'|Sky Plate|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 144, '0x0090', q'|Bridge Mail S|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 671, '0x029F', q'|Pinsirite|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 274, '0x0112', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 878, '0x036E', q'|???|', q'|Unknown pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 346, '0x015A', q'|HM08|', q'|TMs and HMs pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 626, '0x0272', q'|Xtransceiver|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 373, '0x0175', q'|TM46|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 586, '0x024A', q'|Relic Gold|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 326, '0x0146', q'|TM38|', q'|TMs and HMs pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 654, '0x028E', q'|Boost Mulch|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 67, '0x0043', q'|Red Flute|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 625, '0x0271', q'|Gram 3|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 260, '0x0104', q'|Red Scarf|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 391, '0x0187', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 256, '0x0100', q'|Lucky Punch|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 289, '0x0121', q'|Power Bracer|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 644, '0x0284', q'|Pixie Plate|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 237, '0x00ED', q'|Soft Sand|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 306, '0x0132', q'|Sky Plate|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 564, '0x0234', q'|Normal Gem|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 352, '0x0160', q'|TM25|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 2, '0x0002', q'|Ultra Ball|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 85, '0x55', q'|B1F (G)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 525, '0x020D', q'|Data Card 21|', q'|Items pocket|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 661, '0x0295', q'|Blastoisinite|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 60, '0x003C', q'|X Accuracy|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 408, '0x0198', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 85, '0x0055', q'|Leaf Stone|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 219, '0x00DB', q'|Mental Herb|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 40, '0x0028', q'|Yellow Flute|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 201, '0xC9', q'|TM01|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 765, '0x02FD', q'|Prison Bottle|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 497, '0x01F1', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 594, '0x0252', q'|X Sp. Atk 2|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 394, '0x018A', q'|TM67|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 204, '0x00CC', q'|Petaya Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 1041, '0x0411', q'|Magikarp Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 316, '0x013C', q'|TM28|', q'|TMs and HMs pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 640, '0x0280', q'|Assault Vest|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 93, '0x005D', q'|Heart Scale|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 827, '0x033B', q'|Incinium Z|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 466, '0x01D2', q'|Gracidea|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 774, '0x0306', q'|Meteorite Shard|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 600, '0x0258', q'|X Sp. Atk 3|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 73, '0x0049', q'|Blue Shard|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 304, '0x0130', q'|TM16|', q'|TMs and HMs pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 948, '0x03B4', q'|Left Pok� Ball|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 920, '0x0398', q'|Fairy Memory|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 913, '0x0391', q'|Water Memory|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 373, '0x0175', q'|TM46|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 206, '0x00CE', q'|Lansat Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 630, '0x0276', q'|Permit|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 13, '0x000D', q'|Dusk Ball|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 243, '0x00F3', q'|Mystic Water|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 80, '0x0050', q'|Pok� Doll|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 430, '0x01AE', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 322, '0x0142', q'|TM34|', q'|TMs and HMs pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 468, '0x01D4', q'|Apricorn Box|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 481, '0x01E1', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 109, '0x006D', q'|Dawn Stone|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 437, '0x01B5', q'|Pal Pad|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 2, '0x0002', q'|Ultra Ball|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 352, '0x0160', q'|TM25|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 88, '0x0058', q'|Pearl|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 507, '0x01FB', q'|Music Disc|', q'|Key items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 25, '0x0019', q'|Hyper Potion|', q'|Medicine pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 748, '0x02EC', q'|Mega Stickpin|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 65, '0x0041', q'|Iron|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 330, '0x014A', q'|TM03|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 60, '0x003C', q'|X Accuracy|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 73, '0x0049', q'|Guard Spec.|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 714, '0x02CA', q'|Holo Caster|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 204, '0x00CC', q'|Petaya Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 857, '0x0359', q'|Sun Flute|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 519, '0x0207', q'|Data Card 15|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 648, '0x0288', q'|Luminous Moss|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 908, '0x038C', q'|Rock Memory|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 312, '0x0138', q'|Dread Plate|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 275, '0x0113', q'|Focus Sash|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 355, '0x0163', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 27, '0x001B', q'|Full Heal|', q'|Medicine pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 466, '0x01D2', q'|Gracidea|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 300, '0x012C', q'|TM12|', q'|TMs and HMs pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 1055, '0x041F', q'|Mew Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 8, '0x0008', q'|Nest Ball|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 73, '0x0049', q'|Blue Shard|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 116, '0x0074', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 453, '0x01C5', q'|Lunar Wing|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 86, '0x0056', q'|Tiny Mushroom|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 25, '0x0019', q'|Hyper Potion|', q'|Medicine pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 31, '0x001F', q'|Energy Root|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 457, '0x01C9', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 331, '0x014B', q'|TM43|', q'|TMs and HMs pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 206, '0x00CE', q'|Lansat Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 903, '0x0387', q'|???|', q'|Unknown pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 109, '0x006D', q'|Dawn Stone|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 256, '0x0100', q'|Lucky Punch|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 521, '0x0209', q'|DNA Sample|', q'|Key items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 797, '0x031D', q'|Z-Ring|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 641, '0x0281', q'|Holo Caster|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 1051, '0x041B', q'|Zapdos Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 123, '0x007B', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 545, '0x0221', q'|Vivid Scent|', q'|Key items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 352, '0x0160', q'|TM25|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 88, '0x0058', q'|Pearl|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 84, '0x0054', q'|Water Stone|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 128, '0x0080', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 321, '0x0141', q'|TM33|', q'|TMs and HMs pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 719, '0x02CF', q'|Acro Bike|', q'|Key items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 60, '0x003C', q'|X Accuracy|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 281, '0x0119', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 133, '0x85', q'|Basement Key|', q'|Key items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 306, '0x0132', q'|TM18|', q'|TMs and HMs pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 189, '0x00BD', q'|Amulet Coin|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 35, '0x0023', q'|Energy Root|', q'|Medicine pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 227, '0x00E3', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 648, '0x0288', q'|Luminous Moss|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 536, '0x0218', q'|Enigma Stone|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 490, '0x01EA', q'|Wht Apricorn|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 312, '0x0138', q'|Dread Plate|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 191, '0x00BF', q'|Shuca Berry|', q'|Berries pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 491, '0x01EB', q'|Blk Apricorn|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 724, '0x02D4', q'|Pok�block Kit|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 439, '0x01B7', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 1053, '0x041D', q'|Dratini Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 56, '0x0038', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 646, '0x0286', q'|Whipped Dream|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 206, '0x00CE', q'|Lansat Berry|', q'|Berries pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 178, '0x00B2', q'|Nomel Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 109, '0x006D', q'|Dawn Stone|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 332, '0x014C', q'|TM44|', q'|TMs and HMs pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 551, '0x0227', q'|Battle CD 18|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 237, '0x00ED', q'|Soft Sand|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 413, '0x019D', q'|TM86|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 29, '0x001D', q'|Max Revive|', q'|Medicine pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 757, '0x02F5', q'|Audinite|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 737, '0x02E1', q'|HM07|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 312, '0x0138', q'|Dread Plate|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 125, '0x7D', q'|Hard Stone|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 88, '0x0058', q'|Pearl|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 84, '0x0054', q'|Water Stone|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 268, '0x010C', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 661, '0x0295', q'|Blastoisinite|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 21, '0x0015', q'|Awakening|', q'|Medicine pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 483, '0x01E3', q'|Rainbow Wing|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 864, '0x0360', q'|???|', q'|Unknown pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 35, '0x0023', q'|Energy Root|', q'|Medicine pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 629, '0x0275', q'|DNA Splicers|', q'|Key items pocket|', q'|Black 2, White 2|', 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 68, '0x44', q'|X Special|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 569, '0x0239', q'|Battle CD 36|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 534, '0x0216', q'|Red Orb|', q'|Items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 312, '0x0138', q'|Dread Plate|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 275, '0x0113', q'|Focus Sash|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 293, '0x0125', q'|Power Anklet|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 283, '0x011B', q'|Smooth Rock|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 734, '0x02DE', q'|Storage Key|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 220, '0x00DC', q'|Choice Band|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 784, '0x0310', q'|Groundium Z|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 643, '0x0283', q'|Roller Skates|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 313, '0x0139', q'|Iron Plate|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 961, '0x03C1', q'|Mighty Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 206, '0x00CE', q'|Lansat Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 365, '0x016D', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 557, '0x022D', q'|Battle CD 24|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 351, '0x015F', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 57, '0x0039', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 630, '0x0276', q'|Permit|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 0, '0x00', q'|?|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 623, '0x026F', q'|Gram 1|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 415, '0x019F', q'|TM88|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 245, '0x00F5', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 83, '0x0053', q'|Thunder Stone|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 894, '0x037E', q'|Leaf Letter|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 252, '0x00FC', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 658, '0x0292', q'|Ampharosite|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 145, '0x0091', q'|Mago Berry|', q'|Berries pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 744, '0x02E8', q'|Mega Bracelet|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 203, '0x00CB', q'|Soft Sand|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 84, '0x0054', q'|Water Stone|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 447, '0x01BF', q'|Super Rod|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 953, '0x03B9', q'|Roto Friendship|', q'|Unknown pocket|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 535, '0x0217', q'|Blue Orb|', q'|Items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 312, '0x0138', q'|Dread Plate|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 55, '0x0037', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 746, '0x02EA', q'|Mega Glasses|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 445, '0x01BD', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 528, '0x0210', q'|Data Card 24|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 295, '0x0127', q'|TM07|', q'|TMs and HMs pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 714, '0x02CA', q'|Holo Caster|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 364, '0x016C', q'|TM37|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 283, '0x011B', q'|Smooth Rock|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 664, '0x0298', q'|Blazikenite|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 275, '0x0113', q'|Focus Sash|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 413, '0x019D', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 355, '0x0163', q'|TM28|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 236, '0xEC', q'|TM36|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 202, '0x00CA', q'|Ganlon Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 643, '0x0283', q'|Roller Skates|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 8, '0x0008', q'|Nest Ball|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 102, '0x0066', q'|Dome Fossil|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 190, '0x00BE', q'|Kebia Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 128, '0x0080', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 239, '0xEF', q'|TM47|', q'|TMs and HMs pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 415, '0x019F', q'|TM88|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 83, '0x0053', q'|Thunder Stone|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 148, '0x0094', q'|Razz Berry|', q'|Berries pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 29, '0x001D', q'|Max Revive|', q'|Medicine pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 42, '0x002A', q'|Lava Cookie|', q'|Medicine pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 196, '0xC4', q'|HM01|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 347, '0x015B', q'|TM20|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 110, '0x6E', q'|Pearl|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 328, '0x0148', q'|TM40|', q'|TMs and HMs pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 107, '0x006B', q'|Shiny Stone|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 350, '0x015E', q'|TM23|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 619, '0x026B', q'|TM94|', q'|TMs and HMs pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 361, '0x0169', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 266, '0x010A', q'|Muscle Band|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 379, '0x017B', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 309, '0x0135', q'|Stone Plate|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 910, '0x038E', q'|Ghost Memory|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 567, '0x0237', q'|Resist Wing|', q'|Medicine pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 22, '0x0016', q'|Super Potion|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 542, '0x021E', q'|Battle CD 09|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 574, '0x023E', q'|Liberty Pass|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 269, '0x010D', q'|Devon Goods|', q'|Key items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 66, '0x42', q'|X Defend|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 950, '0x03B6', q'|Roto Bargain|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 313, '0x0139', q'|Iron Plate|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 97, '0x61', q'|B4F (G)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 102, '0x0066', q'|Dome Fossil|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 564, '0x0234', q'|Battle CD 31|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 533, '0x0215', q'|Disc Case|', q'|Key items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 464, '0x01D0', q'|Secret Potion|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 478, '0x01DE', q'|Red Scale|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 157, '0x009D', q'|Grepa Berry|', q'|Berries pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 344, '0x0158', q'|HM06|', q'|TMs and HMs pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 372, '0x0174', q'|TM45|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 559, '0x022F', q'|Rock Gem|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 29, '0x001D', q'|Max Revive|', q'|Medicine pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 409, '0x0199', q'|TM82|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 234, '0x00EA', q'|Leftovers|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 139, '0x008B', q'|RSVP Mail|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 95, '0x005F', q'|Fire Stone|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 851, '0x0353', q'|Beast Ball|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 40, '0x0028', q'|Elixir|', q'|Medicine pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 266, '0x010A', q'|Muscle Band|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 338, '0x0152', q'|TM11|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 812, '0x032C', q'|Icium Z|', q'|Z-Crystals pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 410, '0x019A', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 19, '0x13', q'|Super Potion|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 76, '0x004C', q'|Super Repel|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 264, '0x0108', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 772, '0x0304', q'|Meteorite|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 118, '0x0076', q'|Burn Drive|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 143, '0x008F', q'|Figy Berry|', q'|Berries pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 567, '0x0237', q'|Resist Wing|', q'|Medicine pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 940, '0x03AC', q'|Purple Petal|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 283, '0x011B', q'|Smooth Rock|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 574, '0x023E', q'|Liberty Pass|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 58, '0x003A', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 536, '0x0218', q'|Enigma Stone|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 313, '0x0139', q'|Iron Plate|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 41, '0x0029', q'|Max Elixir|', q'|Medicine pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 464, '0x01D0', q'|Secret Potion|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 86, '0x0056', q'|Repel|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 327, '0x0147', q'|TM39|', q'|TMs and HMs pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 44, '0x002C', q'|Sacred Ash|', q'|Medicine pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 634, '0x027A', q'|Grubby Hanky|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 248, '0x00F8', q'|Twisted Spoon|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 398, '0x018E', q'|TM71|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 13, '0x0D', q'|Ice Heal|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 423, '0x01A7', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 393, '0x0189', q'|TM66|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 11, '0x000B', q'|Luxury Ball|', q'|Pok� Balls pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 44, '0x002C', q'|Sacred Ash|', q'|Medicine pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 711, '0x02C7', q'|Sail Fossil|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 40, '0x0028', q'|Elixir|', q'|Medicine pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 148, '0x0094', q'|Bridge Mail M|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 502, '0x01F6', q'|GB Sounds|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 338, '0x0152', q'|TM11|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 54, '0x0036', q'|Old Gateau|', q'|Medicine pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 266, '0x010A', q'|Muscle Band|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 132, '0x0084', q'|unknown|', q'|Unknown pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 293, '0x0125', q'|TM05|', q'|TMs and HMs pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 174, '0x00AE', q'|Tamato Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 115, '0x0073', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 76, '0x004C', q'|Super Repel|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 497, '0x01F1', q'|Friend Ball|', q'|Pok� Balls pocket|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 422, '0x01A6', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 132, '0x0084', q'|Retro Mail|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 338, '0x0152', q'|TM50|', q'|TMs and HMs pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 119, '0x0077', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 626, '0x0272', q'|Xtransceiver|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 898, '0x0382', q'|???|', q'|Unknown pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 247, '0x00F7', q'|Spell Tag|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 567, '0x0237', q'|Resist Wing|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 536, '0x0218', q'|Enigma Stone|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 356, '0x0164', q'|Lift Key|', q'|Key items pocket|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 190, '0x00BE', q'|Kebia Berry|', q'|Berries pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 153, '0x99', q'|Teru-sama|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 147, '0x0093', q'|Bridge Mail V|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 44, '0x002C', q'|Sacred Ash|', q'|Medicine pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 455, '0x01C7', q'|Azure Flute|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 25, '0x0019', q'|Hyper Potion|', q'|Medicine pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 566, '0x0236', q'|Muscle Wing|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 236, '0x00EC', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 109, '0x006D', q'|Dawn Stone|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 478, '0x01DE', q'|Red Scale|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 18, '0x0012', q'|Parlyz Heal|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 393, '0x0189', q'|TM66|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 711, '0x02C7', q'|Sail Fossil|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 9, '0x0009', q'|Repeat Ball|', q'|Pok� Balls pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 209, '0x00D1', q'|Micle Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 40, '0x0028', q'|Yellow Flute|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 261, '0x0105', q'|Blue Scarf|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 486, '0x01E6', q'|Blu Apricorn|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 832, '0x0340', q'|Snorlium Z|', q'|Z-Crystals pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 435, '0x01B3', q'|Fashion Case|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 606, '0x025E', q'|X Sp. Atk 6|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 106, '0x006A', q'|Pearl|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 748, '0x02EC', q'|Mega Stickpin|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 132, '0x0084', q'|unknown|', q'|Unknown pocket|' , 5 );
insert into itemIDs( GAME, GEN )
values( q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 29, '0x001D', q'|Max Revive|', q'|Medicine pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 520, '0x0208', q'|DNA Sample|', q'|Key items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 388, '0x0184', q'|TM61|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 115, '0x0073', q'|unknown|', q'|Unknown pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 356, '0x0164', q'|TM29|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 42, '0x2A', q'|Super Repel|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 997, '0x03E5', q'|Venonat Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 191, '0x00BF', q'|Shuca Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 479, '0x01DF', q'|Lost Item|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 414, '0x019E', q'|TM87|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 317, '0x013D', q'|Wave Incense|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 626, '0x0272', q'|Xtransceiver|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 122, '0x007A', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 518, '0x0206', q'|Data Card 14|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 834, '0x0342', q'|Mewnium Z|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 633, '0x0279', q'|Plasma Card|', q'|Key items pocket|', q'|Black 2, White 2|', 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 1018, '0x03FA', q'|Onix Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 313, '0x0139', q'|Iron Plate|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 368, '0x0170', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 247, '0x00F7', q'|Spell Tag|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 520, '0x0208', q'|Data Card 16|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 536, '0x0218', q'|Enigma Stone|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 430, '0x01AE', q'|Rule Book|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 12, '0x000C', q'|Premier Ball|', q'|Pok� Balls pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 163, '0x00A3', q'|Spelon Berry|', q'|Berries pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 962, '0x03C2', q'|Tough Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 36, '0x0024', q'|Heal Powder|', q'|Medicine pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 363, '0x016B', q'|TM36|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 12, '0x000C', q'|Premier Ball|', q'|Pok� Balls pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 41, '0x0029', q'|Max Elixir|', q'|Medicine pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 44, '0x002C', q'|Sacred Ash|', q'|Medicine pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 488, '0x01E8', q'|Green Apricorn|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 209, '0x00D1', q'|Micle Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( GAME, GEN )
values( q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 224, '0x00E0', q'|Thick Club|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 334, '0x014E', q'|TM46|', q'|TMs and HMs pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 526, '0x020E', q'|Krane Memo 4|', q'|Key items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 917, '0x0395', q'|Ice Memory|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 691, '0x02B3', q'|TM97|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 435, '0x01B3', q'|Fashion Case|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 247, '0x00F7', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 361, '0x0169', q'|Town Map|', q'|Key items pocket|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 479, '0x01DF', q'|Lost Item|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 258, '0x0102', q'|Thick Club|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 132, '0x0084', q'|unknown|', q'|Unknown pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 339, '0x0153', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 112, '0x0070', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 496, '0x01F0', q'|Love Ball|', q'|Pok� Balls pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 133, '0x0085', q'|Cheri Berry|', q'|Berries pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 780, '0x030C', q'|Grassium Z|', q'|Z-Crystals pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 388, '0x0184', q'|TM61|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 356, '0x0164', q'|TM29|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 324, '0x0144', q'|Dubious Disc|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 445, '0x01BD', q'|Old Rod|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 274, '0x0112', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 191, '0x00BF', q'|Shuca Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 333, '0x014D', q'|TM06|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 211, '0x00D3', q'|Poison Barb|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 479, '0x01DF', q'|Lost Item|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 90, '0x5A', q'|Teru-sama|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 269, '0x010D', q'|Light Clay|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 317, '0x013D', q'|Wave Incense|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 484, '0x01E4', q'|Mystery Egg|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 443, '0x01BB', q'|Vs. Seeker|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 43, '0x002B', q'|Berry Juice|', q'|Medicine pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 339, '0x0153', q'|HM01|', q'|TMs and HMs pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 474, '0x01DA', q'|Clear Bell|', q'|Key items pocket|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 21, '0x0015', q'|Hyper Potion|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 82, '0x52', q'|King's Rock|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 89, '0x0059', q'|Big Pearl|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 190, '0x00BE', q'|Kebia Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 36, '0x0024', q'|Heal Powder|', q'|Medicine pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 98, '0x62', q'|??????? (ThunderBadge - D)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 72, '0x0048', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 612, '0x0264', q'|Item Drop|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 488, '0x01E8', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 53, '0x0035', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 248, '0x00F8', q'|Twisted Spoon|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 44, '0x002C', q'|Sacred Ash|', q'|Medicine pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 486, '0x01E6', q'|Ylw Apricorn|', q'|Items pocket|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 42, '0x002A', q'|Lava Cookie|', q'|Medicine pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 368, '0x0170', q'|TM41|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 209, '0x00D1', q'|Micle Berry|', q'|Berries pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 578, '0x0242', q'|Prop Case|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 461, '0x01CD', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 261, '0x0105', q'|Blue Scarf|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 220, '0x00DC', q'|Sea Incense|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 517, '0x0205', q'|Data Card 13|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 265, '0x0109', q'|Wide Lens|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 988, '0x03DC', q'|Sandshrew Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 309, '0x0135', q'|Stone Plate|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 19, '0x0013', q'|Burn Heal|', q'|Medicine pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 788, '0x0314', q'|Rockium Z|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 427, '0x01AB', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 9, '0x0009', q'|Repeat Ball|', q'|Pok� Balls pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 591, '0x024F', q'|Battle CD 58|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 244, '0xF4', q'|TM44|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 269, '0x010D', q'|Light Clay|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 187, '0x00BB', q'|Rindo Berry|', q'|Berries pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 317, '0x013D', q'|Wave Incense|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 43, '0x002B', q'|Berry Juice|', q'|Medicine pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 41, '0x0029', q'|Red Flute|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 777, '0x0309', q'|Firium Z|', q'|Z-Crystals pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 241, '0x00F1', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 647, '0x0287', q'|Sachet|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 97, '0x0061', q'|Stable Mulch|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 206, '0x00CE', q'|Lansat Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 36, '0x0024', q'|Heal Powder|', q'|Medicine pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 26, '0x001A', q'|Super Potion|', q'|Medicine pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 126, '0x007E', q'|unknown|', q'|Unknown pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 205, '0x00CD', q'|Miracle Seed|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 515, '0x0203', q'|Data Card 11|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 345, '0x0159', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 477, '0x01DD', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 591, '0x024F', q'|Casteliacone|', q'|Medicine pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 209, '0x00D1', q'|Micle Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 42, '0x002A', q'|Lava Cookie|', q'|Medicine pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 261, '0x0105', q'|Blue Scarf|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 190, '0x00BE', q'|Kebia Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 194, '0x00C2', q'|Tanga Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 113, '0x0071', q'|unknown|', q'|Unknown pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 398, '0x018E', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 138, '0x008A', q'|Flame Mail|', q'|Mail pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 380, '0x017C', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 953, '0x03B9', q'|Roto Friendship|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 309, '0x0135', q'|Stone Plate|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 92, '0x005C', q'|Nugget|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 271, '0x010F', q'|Basement Key|', q'|Key items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 194, '0x00C2', q'|Smoke Ball|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 388, '0x0184', q'|TM61|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 356, '0x0164', q'|TM29|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 475, '0x01DB', q'|Card Key|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 6, '0x06', q'|Bicycle|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 9, '0x09', q'|Antidote|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 483, '0x01E3', q'|Rainbow Wing|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 187, '0x00BB', q'|Rindo Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 447, '0x01BF', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 317, '0x013D', q'|Wave Incense|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 731, '0x02DB', q'|Key to Room 2|', q'|Key items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 43, '0x002B', q'|Berry Juice|', q'|Medicine pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 470, '0x01D6', q'|Berry Pots|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 549, '0x0225', q'|Water Gem|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 493, '0x01ED', q'|Level Ball|', q'|Pok� Balls pocket|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 350, '0x015E', q'|Pok� Flute|', q'|Key items pocket|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 26, '0x001A', q'|Super Potion|', q'|Medicine pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 911, '0x038F', q'|Steel Memory|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 587, '0x024B', q'|Relic Vase|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 41, '0x0029', q'|Max Elixir|', q'|Medicine pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 0, '0x00', q'|Nothing|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 566, '0x0236', q'|Muscle Wing|', q'|Medicine pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 126, '0x007E', q'|unknown|', q'|Unknown pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 515, '0x0203', q'|Data Card 11|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 352, '0x0160', q'|TM25|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 829, '0x033D', q'|Tapunium Z|', q'|Z-Crystals pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 397, '0x018D', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 469, '0x01D5', q'|Unown Report|', q'|Key items pocket|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 591, '0x024F', q'|Casteliacone|', q'|Medicine pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 554, '0x022A', q'|Poison Gem|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 42, '0x002A', q'|Lava Cookie|', q'|Medicine pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 226, '0x00E2', q'|Deep Sea Tooth|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 42, '0x002A', q'|Black Flute|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 578, '0x0242', q'|Prop Case|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 113, '0x0071', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 7, '0x07', q'|?????|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 515, '0x0203', q'|Vivid Scent|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 217, '0x00D9', q'|Quick Claw|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 107, '0x006B', q'|Shiny Stone|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 324, '0x0144', q'|TM36|', q'|TMs and HMs pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 406, '0x0196', q'|TM79|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 40, '0x0028', q'|Elixir|', q'|Medicine pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 266, '0x010A', q'|Muscle Band|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 859, '0x035B', q'|???|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 329, '0x0149', q'|TM02|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 19, '0x0013', q'|Burn Heal|', q'|Medicine pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 881, '0x0371', q'|Electric Seed|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 258, '0x0102', q'|Thick Club|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 92, '0x005C', q'|Nugget|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 269, '0x010D', q'|Light Clay|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 384, '0x0180', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 532, '0x0214', q'|Voice Case 5|', q'|Key items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 76, '0x4C', q'|Old Rod|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 835, '0x0343', q'|Pikashunium Z|', q'|Z-Crystals pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 98, '0x0062', q'|Leaf Stone|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 454, '0x01C6', q'|Member Card|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 1001, '0x03E9', q'|Mankey Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 178, '0x00B2', q'|Nomel Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 205, '0x00CD', q'|Apicot Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 153, '0x0099', q'|Pomeg Berry|', q'|Berries pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 41, '0x0029', q'|Max Elixir|', q'|Medicine pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 515, '0x0203', q'|Data Card 11|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 283, '0x011B', q'|Smooth Rock|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 429, '0x01AD', q'|Loot Sack|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 591, '0x024F', q'|Casteliacone|', q'|Medicine pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 25, '0x0019', q'|Hyper Potion|', q'|Medicine pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 478, '0x01DE', q'|Red Scale|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 105, '0x0069', q'|Skull Fossil|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 241, '0x00F1', q'|Black Belt|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 965, '0x03C5', q'|Quick Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 468, '0x01D4', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 9, '0x0009', q'|Repeat Ball|', q'|Pok� Balls pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 578, '0x0242', q'|Prop Case|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 261, '0x0105', q'|Blue Scarf|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 113, '0x0071', q'|unknown|', q'|Unknown pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 119, '0x0077', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 269, '0x010D', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 40, '0x0028', q'|Elixir|', q'|Medicine pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 380, '0x017C', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 514, '0x0202', q'|Excite Scent|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 102, '0x0066', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 285, '0x011D', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 136, '0x0088', q'|Rawst Berry|', q'|Berries pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 19, '0x0013', q'|Burn Heal|', q'|Medicine pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 1039, '0x040F', q'|Pinsir Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 82, '0x0052', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 165, '0x00A5', q'|Watmel Berry|', q'|Berries pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 971, '0x03CB', q'|Quick Candy L|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 432, '0x01B0', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 474, '0x01DA', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 674, '0x02A2', q'|Abomasite|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 144, '0x0090', q'|Snow Mail|', q'|Mail pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 187, '0x00BB', q'|Rindo Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 297, '0x0129', q'|Choice Specs|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 211, '0x00D3', q'|Poison Barb|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 192, '0x00C0', q'|Coba Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 271, '0x010F', q'|Power Herb|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 711, '0x02C7', q'|Sail Fossil|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 600, '0x0258', q'|X Sp. Atk 3|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 178, '0x00B2', q'|Nomel Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 41, '0x0029', q'|Max Elixir|', q'|Medicine pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 142, '0x008E', q'|Like Mail|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 566, '0x0236', q'|Muscle Wing|', q'|Medicine pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 768, '0x0300', q'|Lopunnite|', q'|Items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 30, '0x001E', q'|EnergyPowder|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 24, '0x0018', q'|Revive|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 754, '0x02F2', q'|Sablenite|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 899, '0x0383', q'|???|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 494, '0x01EE', q'|Lure Ball|', q'|Pok� Balls pocket|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 478, '0x01DE', q'|Red Scale|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 387, '0x0183', q'|TM60|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 169, '0xA9', q'|Sun Stone|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 520, '0x0208', q'|Data Card 16|', q'|Items pocket|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 241, '0x00F1', q'|Black Belt|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 505, '0x01F9', q'|Data Card 01|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 253, '0xFD', q'|HM11|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 113, '0x0071', q'|unknown|', q'|Unknown pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 274, '0x0112', q'|Quick Powder|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 921, '0x0399', q'|Solganium Z|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 237, '0xED', q'|TM37|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 849, '0x0351', q'|Ice Stone|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 720, '0x02D0', q'|Wailmer Pail|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 704, '0x02C0', q'|Strange Souvenir|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 258, '0x0102', q'|Thick Club|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 351, '0x015F', q'|TM24|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 513, '0x0201', q'|Data Card 09|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 92, '0x005C', q'|Nugget|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 227, '0xE3', q'|TM35|', q'|TMs and HMs pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 577, '0x0241', q'|Pok� Toy|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 39, '0x0027', q'|Blue Flute|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 436, '0x01B4', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 473, '0x01D9', q'|Slowpoke Tail|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 674, '0x02A2', q'|Abomasite|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 40, '0x28', q'|Max Revive|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 596, '0x0254', q'|X Defense 2|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 910, '0x038E', q'|Ghost Memory|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 609, '0x0261', q'|X Attack 6|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 105, '0x69', q'|??????? (FireballBadge - D)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 106, '0x006A', q'|Rare Bone|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 648, '0x0288', q'|Luminous Moss|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 683, '0x02AB', q'|Garchompite|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 497, '0x01F1', q'|Friend Ball|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 254, '0x00FE', q'|Red Scarf|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 515, '0x0203', q'|Data Card 11|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 80, '0x0050', q'|Pok� Doll|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 254, '0x00FE', q'|Red Scarf|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 381, '0x017D', q'|TM54|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 288, '0x0120', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 241, '0x00F1', q'|Black Belt|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 17, '0x0011', q'|Awakening|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 792, '0x0318', q'|Steelium Z|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 228, '0x00E4', q'|Smoke Ball|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 248, '0xF8', q'|HM06|', q'|TMs and HMs pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 9, '0x0009', q'|Repeat Ball|', q'|Pok� Balls pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 220, '0x00DC', q'|Choice Band|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 247, '0x00F7', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 705, '0x02C1', q'|Lens Case|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 610, '0x0262', q'|X Accuracy 6|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 435, '0x01B3', q'|Fashion Case|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 452, '0x01C4', q'|Oak's Letter|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 709, '0x02C5', q'|Shalour Sable|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 763, '0x02FB', q'|Glalitite|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 592, '0x0250', q'|Dire Hit 2|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 623, '0x026F', q'|Gram 1|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 704, '0x02C0', q'|Strange Souvenir|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 353, '0x0161', q'|TM26|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 80, '0x50', q'|Ice Berry|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 284, '0x011C', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 258, '0x0102', q'|Thick Club|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 541, '0x021D', q'|Ein File P|', q'|Key items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 19, '0x0013', q'|Burn Heal|', q'|Medicine pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 419, '0x01A3', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 287, '0x011F', q'|Claw Fossil|', q'|Key items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 445, '0x01BD', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 951, '0x03B7', q'|Roto Prize Money|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 503, '0x01F7', q'|Machine Part|', q'|Key items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 331, '0x014B', q'|TM43|', q'|TMs and HMs pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 431, '0x01AF', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 801, '0x0321', q'|Tapunium Z|', q'|Z-Crystals pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 62, '0x003E', q'|X Sp. Def|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 362, '0x016A', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 303, '0x012F', q'|TM15|', q'|TMs and HMs pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 74, '0x004A', q'|Yellow Shard|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 479, '0x01DF', q'|Lost Item|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 596, '0x0254', q'|X Defense 2|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 592, '0x0250', q'|Dire Hit 2|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 304, '0x0130', q'|TM16|', q'|TMs and HMs pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 772, '0x0304', q'|Meteorite|', q'|Key items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 192, '0x00C0', q'|Coba Berry|', q'|Berries pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 673, '0x02A1', q'|Lucarionite|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 450, '0x01C2', q'|Bicycle|', q'|Key items pocket|', q'|X, Y|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 455, '0x01C7', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 272, '0x0110', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 36, '0x0024', q'|Heal Powder|', q'|Medicine pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 334, '0x014E', q'|TM07|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 435, '0x01B3', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 241, '0x00F1', q'|Black Belt|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 230, '0xE6', q'|TM30|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 363, '0x016B', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 207, '0x00CF', q'|Black Belt|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 734, '0x02DE', q'|Storage Key|', q'|Key items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 107, '0x6B', q'|??? (Egg - D)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 56, '0x38', q'|Teru-sama|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 623, '0x026F', q'|Gram 1|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 180, '0x00B4', q'|Pamtre Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 349, '0x015D', q'|TM22|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 567, '0x0237', q'|Resist Wing|', q'|Medicine pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 456, '0x01C8', q'|S.S. Ticket|', q'|Key items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 506, '0x01FA', q'|Data Card 02|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 764, '0x02FC', q'|Diancite|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 351, '0x015F', q'|TM24|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 506, '0x01FA', q'|Data Card 02|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 376, '0x0178', q'|TM49|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 254, '0x00FE', q'|Sea Incense|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 160, '0xA0', q'|Lure Ball|', q'|Pok� Balls pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 170, '0x00AA', q'|Salac Berry|', q'|Berries pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 498, '0x01F2', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 97, '0x0061', q'|Water Stone|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 192, '0x00C0', q'|Coba Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 695, '0x02B7', q'|Power Plant Pass|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 142, '0x008E', q'|Sitrus Berry|', q'|Berries pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 566, '0x0236', q'|Muscle Wing|', q'|Medicine pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 334, '0x014E', q'|TM07|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 463, '0x01CF', q'|Storage Key|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 232, '0xE8', q'|TM40|', q'|TMs and HMs pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 318, '0x013E', q'|TM30|', q'|TMs and HMs pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 534, '0x0216', q'|Red Orb|', q'|Key items pocket|', q'|X, Y|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 614, '0x0266', q'|Reset Urge|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 150, '0x0096', q'|Nanab Berry|', q'|Berries pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 273, '0x0111', q'|Flame Orb|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 594, '0x0252', q'|X Sp. Atk 2|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 54, '0x0036', q'|Old Gateau|', q'|Medicine pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 171, '0x00AB', q'|Petaya Berry|', q'|Berries pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 214, '0x00D6', q'|TwistedSpoon|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 61, '0x003D', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 371, '0x0173', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 658, '0x0292', q'|Ampharosite|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 586, '0x024A', q'|Battle CD 53|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 720, '0x02D0', q'|Wailmer Pail|', q'|Key items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 623, '0x026F', q'|Gram 1|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 406, '0x0196', q'|TM79|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 180, '0x00B4', q'|Pamtre Berry|', q'|Berries pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 349, '0x015D', q'|TM22|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 53, '0x0035', q'|PP Max|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 226, '0x00E2', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 317, '0x013D', q'|Wave Incense|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 506, '0x01FA', q'|Data Card 02|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 351, '0x015F', q'|TM24|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 84, '0x54', q'|B2F (G)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 182, '0xB6', q'|Litebluemail|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 92, '0x005C', q'|Nugget|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 682, '0x02AA', q'|Manectite|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 58, '0x3A', q'|Old Rod|', q'|Key items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 406, '0x0196', q'|TM79|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 283, '0x011B', q'|Smooth Rock|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 384, '0x0180', q'|TM57|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 320, '0x0140', q'|TM32|', q'|TMs and HMs pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 112, '0x0070', q'|Griseous Orb|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 115, '0x0073', q'|???|', q'|Unknown pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 46, '0x002E', q'|Protein|', q'|Medicine pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 444, '0x01BC', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 558, '0x022E', q'|Bug Gem|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 148, '0x0094', q'|Razz Berry|', q'|Berries pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 148, '0x0094', q'|Razz Berry|', q'|Berries pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 774, '0x0306', q'|Meteorite Shard|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 405, '0x0195', q'|TM78|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 323, '0x0143', q'|Magmarizer|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 871, '0x0367', q'|???|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 12, '0x0C', q'|Awakening|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 497, '0x01F1', q'|Friend Ball|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 340, '0x0154', q'|TM13|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 51, '0x0033', q'|Green Shard|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 532, '0x0214', q'|Jade Orb|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 181, '0xB5', q'|Surf Mail|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 587, '0x024B', q'|Relic Vase|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 415, '0x019F', q'|TM88|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 527, '0x020F', q'|Data Card 23|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 559, '0x022F', q'|Battle CD 26|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 203, '0x00CB', q'|Soft Sand|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 594, '0x0252', q'|X Sp. Atk 2|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 255, '0x00FF', q'|Blue Scarf|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 498, '0x01F2', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 220, '0x00DC', q'|Choice Band|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 48, '0x0030', q'|Red Shard|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 335, '0x014F', q'|TM47|', q'|TMs and HMs pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 804, '0x0324', q'|Snorlium Z|', q'|Z-Crystals pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 178, '0xB2', q'|Rainbow Wing|', q'|Key items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 87, '0x0057', q'|Big Mushroom|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 558, '0x022E', q'|Bug Gem|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 255, '0x00FF', q'|Blue Scarf|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 181, '0x00B5', q'|Watmel Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 114, '0x0072', q'|???|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 531, '0x0213', q'|Voice Case 4|', q'|Key items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 46, '0x002E', q'|Protein|', q'|Medicine pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 81, '0x0051', q'|Moon Stone|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 171, '0x00AB', q'|Petaya Berry|', q'|Berries pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 222, '0x00DE', q'|Lucky Punch|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 379, '0x017B', q'|TM52|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 265, '0x0109', q'|Wide Lens|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 483, '0x01E3', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 202, '0x00CA', q'|Light Ball|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 298, '0x012A', q'|TM10|', q'|TMs and HMs pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 587, '0x024B', q'|Relic Vase|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 227, '0x00E3', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 532, '0x0214', q'|Gear|', q'|Key items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 477, '0x01DD', q'|Squirt Bottle|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 127, '0x007F', q'|???|', q'|Unknown pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 68, '0x0044', q'|Rare Candy|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 229, '0x00E5', q'|Everstone|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 516, '0x0204', q'|Data Card 12|', q'|Items pocket|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 944, '0x03B0', q'|N-Lunarizer|', q'|Key items pocket|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 167, '0x00A7', q'|Belue Berry|', q'|Berries pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 217, '0x00D9', q'|Quick Claw|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 404, '0x0194', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 180, '0x00B4', q'|Pamtre Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 456, '0x01C8', q'|S.S. Ticket|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 606, '0x025E', q'|X Sp. Atk 6|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 286, '0x011E', q'|Root Fossil|', q'|Key items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 541, '0x021D', q'|Battle CD 08|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 535, '0x0217', q'|Blue Orb|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 387, '0x0183', q'|TM60|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 1050, '0x041A', q'|Articuno Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 282, '0x011A', q'|Icy Rock|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 209, '0x00D1', q'|Mystic Water|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 14, '0x000E', q'|Heal Ball|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 795, '0x031B', q'|Bottle Cap|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 100, '0x0064', q'|Claw Fossil|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 18, '0x12', q'|Hyper Potion|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 81, '0x0051', q'|Moon Stone|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 379, '0x017B', q'|TM52|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 251, '0x00FB', q'|Silk Scarf|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 609, '0x0261', q'|X Attack 6|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 890, '0x037A', q'|Gold Leaf|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 267, '0x010B', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 178, '0x00B2', q'|Nomel Berry|', q'|Berries pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 677, '0x02A5', q'|Absolite|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 142, '0x008E', q'|Like Mail|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 617, '0x0269', q'|Dark Stone|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 349, '0x015D', q'|TM22|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 891, '0x037B', q'|Silver Leaf|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 106, '0x6A', q'|Smoke Ball|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 147, '0x0093', q'|Bridge Mail V|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 326, '0x0146', q'|TM38|', q'|TMs and HMs pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 536, '0x0218', q'|Battle CD 03|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 587, '0x024B', q'|Relic Vase|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 203, '0x00CB', q'|Salac Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 442, '0x01BA', q'|Town Map|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 390, '0x0186', q'|TM63|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 220, '0x00DC', q'|Choice Band|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 129, '0x0081', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 513, '0x0201', q'|Joy Scent|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 343, '0x0157', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 344, '0x0158', q'|TM17|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 34, '0x0022', q'|Ether|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 216, '0x00D8', q'|Exp. Share|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 338, '0x0152', q'|TM11|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 13, '0x000D', q'|Potion|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 672, '0x02A0', q'|Aerodactylite|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 94, '0x005E', q'|Honey|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 140, '0x008C', q'|Persim Berry|', q'|Berries pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 285, '0x011D', q'|Damp Rock|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 282, '0x011A', q'|Icy Rock|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 100, '0x0064', q'|Claw Fossil|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 411, '0x019B', q'|TM84|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 502, '0x01F6', q'|GB Sounds|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 425, '0x01A9', q'|HM06|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 167, '0xA7', q'|Normal Box|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 104, '0x0068', q'|Big Mushroom|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 716, '0x02CC', q'|Mega Charm|', q'|Key items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 81, '0x0051', q'|Moon Stone|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 251, '0x00FB', q'|Silk Scarf|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 43, '0x002B', q'|Berry Juice|', q'|Medicine pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 379, '0x017B', q'|TM52|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 837, '0x0345', q'|???|', q'|Unknown pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 493, '0x01ED', q'|Level Ball|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 609, '0x0261', q'|X Attack 6|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 508, '0x01FC', q'|Subway Key|', q'|Key items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 326, '0x0146', q'|Razor Claw|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 142, '0x008E', q'|Like Mail|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 45, '0x002D', q'|HP Up|', q'|Medicine pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 914, '0x0392', q'|Grass Memory|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 108, '0x006C', q'|Stardust|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 486, '0x01E6', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 869, '0x0365', q'|???|', q'|Unknown pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 331, '0x014B', q'|TM04|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 425, '0x01A9', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 604, '0x025C', q'|X Accuracy 3|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 686, '0x02AE', q'|Roseli Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 954, '0x03BA', q'|Roto Encounter|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 442, '0x01BA', q'|Town Map|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 203, '0x00CB', q'|Salac Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 220, '0x00DC', q'|Choice Band|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 344, '0x0158', q'|TM17|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 181, '0x00B5', q'|Watmel Berry|', q'|Berries pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 112, '0x70', q'|Everstone|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 533, '0x0215', q'|Lock Capsule|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 428, '0x01AC', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 456, '0x01C8', q'|S.S. Ticket|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 672, '0x02A0', q'|Aerodactylite|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 216, '0x00D8', q'|Exp. Share|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 618, '0x026A', q'|TM93|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 46, '0x002E', q'|Protein|', q'|Medicine pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 265, '0x0109', q'|Wide Lens|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 365, '0x016D', q'|TM38|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 59, '0x003B', q'|X Speed|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 400, '0x0190', q'|TM73|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 238, '0xEE', q'|TM38|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 282, '0x011A', q'|Icy Rock|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 474, '0x01DA', q'|Clear Bell|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 411, '0x019B', q'|TM84|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 502, '0x01F6', q'|GB Sounds|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 382, '0x017E', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 81, '0x0051', q'|Moon Stone|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 414, '0x019E', q'|TM87|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 65, '0x0041', q'|Blue Flute|', q'|Medicine pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 749, '0x02ED', q'|Mega Tiara|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 151, '0x97', q'|Dragon Scale|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 130, '0x0082', q'|???|', q'|Unknown pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 75, '0x4B', q'|Exp. All|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 113, '0x0071', q'|Tea|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 372, '0x0174', q'|TM45|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 251, '0x00FB', q'|Silk Scarf|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 55, '0x0037', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 334, '0x014E', q'|TM07|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 252, '0x00FC', q'|Up-Grade|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 845, '0x034D', q'|Sparkling Stone|', q'|Key items pocket|', q'|Sun, Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 741, '0x02E5', q'|Magma Suit|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 503, '0x01F7', q'|Tidal Bell|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 137, '0x0089', q'|Aspear Berry|', q'|Berries pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 20, '0x0014', q'|Ice Heal|', q'|Medicine pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 210, '0x00D2', q'|Sharp Beak|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 532, '0x0214', q'|Jade Orb|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 158, '0x009E', q'|Tamato Berry|', q'|Berries pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 390, '0x0186', q'|TM63|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 203, '0x00CB', q'|Salac Berry|', q'|Berries pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 773, '0x0305', q'|Key Stone|', q'|Key items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 442, '0x01BA', q'|Town Map|', q'|Key items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 22, '0x0016', q'|Super Potion|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 795, '0x031B', q'|Bottle Cap|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 344, '0x0158', q'|TM17|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 805, '0x0325', q'|Eevium Z|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 57, '0x39', q'|Exp.Share|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 533, '0x0215', q'|Lock Capsule|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 737, '0x02E1', q'|HM07|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 221, '0x00DD', q'|King's Rock|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 456, '0x01C8', q'|S.S. Ticket|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 979, '0x03D3', q'|Charmander Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 23, '0x0017', q'|Full Restore|', q'|Medicine pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 3, '0x0003', q'|Great Ball|', q'|Pok� Balls pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 855, '0x0357', q'|Pink Nectar|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 46, '0x002E', q'|Protein|', q'|Medicine pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 282, '0x011A', q'|Icy Rock|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 763, '0x02FB', q'|Glalitite|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 767, '0x02FF', q'|Cameruptite|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 434, '0x01B2', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 414, '0x019E', q'|TM87|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 751, '0x02EF', q'|Meteorite|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 239, '0x00EF', q'|Miracle Seed|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 75, '0x004B', q'|X Attack|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 674, '0x02A2', q'|Abomasite|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 91, '0x005B', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 130, '0x0082', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 349, '0x015D', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 251, '0x00FB', q'|Silk Scarf|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 252, '0x00FC', q'|Up-Grade|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 372, '0x0174', q'|TM45|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 588, '0x024C', q'|Relic Band|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 208, '0xD0', q'|TM17|', q'|TMs and HMs pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 245, '0x00F5', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 45, '0x002D', q'|HP Up|', q'|Medicine pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 375, '0x0177', q'|TM48|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 52, '0x0034', q'|Zinc|', q'|Medicine pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 19, '0x13', q'|Escape Rope|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 307, '0x0133', q'|TM19|', q'|TMs and HMs pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 250, '0x00FA', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 532, '0x0214', q'|Jade Orb|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 593, '0x0251', q'|X Speed 2|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 54, '0x0036', q'|Old Gateau|', q'|Medicine pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 716, '0x02CC', q'|Mega Charm|', q'|Key items pocket|', q'|X, Y|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 390, '0x0186', q'|TM63|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 427, '0x01AB', q'|unknown|', q'|Unknown pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 71, '0x0047', q'|PP Max|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 203, '0x00CB', q'|Salac Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 418, '0x01A2', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 181, '0x00B5', q'|Watmel Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 651, '0x028B', q'|Pok� Flute|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 17, '0x0011', q'|Awakening|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 20, '0x14', q'|Potion|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 401, '0x0191', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 3, '0x0003', q'|Great Ball|', q'|Pok� Balls pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 425, '0x01A9', q'|HM06|', q'|TMs and HMs pocket|', q'|X, Y|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 733, '0x02DD', q'|Key to Room 6|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 406, '0x0196', q'|TM79|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 68, '0x0044', q'|Rare Candy|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 533, '0x0215', q'|Lock Capsule|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 401, '0x0191', q'|TM74|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 510, '0x01FE', q'|Data Card 06|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 619, '0x026B', q'|TM94|', q'|TMs and HMs pocket|', q'|X, Y|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 507, '0x01FB', q'|U-Disk|', q'|Key items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 265, '0x0109', q'|Wide Lens|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 97, '0x0061', q'|Stable Mulch|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 1015, '0x03F7', q'|Grimer Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 888, '0x0378', q'|Lone Earring|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 445, '0x01BD', q'|Old Rod|', q'|Key items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 274, '0x0112', q'|Quick Powder|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 471, '0x01D7', q'|Dowsing Machine|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 493, '0x01ED', q'|Level Ball|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 251, '0xFB', q'|HM09|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 759, '0x02F7', q'|Sharpedonite|', q'|Items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 523, '0x020B', q'|Krane Memo 1|', q'|Key items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 372, '0x0174', q'|TM45|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 401, '0x0191', q'|TM74|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 691, '0x02B3', q'|TM97|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 252, '0x00FC', q'|Up-Grade|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 84, '0x0054', q'|Max Repel|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 122, '0x007A', q'|Harbor Mail|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 739, '0x02E3', q'|Contest Costume|', q'|Key items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 45, '0x002D', q'|HP Up|', q'|Medicine pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 557, '0x022D', q'|Psychic Gem|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 224, '0x00E0', q'|Thick Club|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 331, '0x014B', q'|TM04|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 597, '0x0255', q'|X Attack 2|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 521, '0x0209', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 532, '0x0214', q'|Jade Orb|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 88, '0x0058', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 697, '0x02B9', q'|Intriguing Stone|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 213, '0x00D5', q'|Spell Tag|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 52, '0x0034', q'|Zinc|', q'|Medicine pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 490, '0x01EA', q'|White Apricorn|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 54, '0x0036', q'|Old Gateau|', q'|Medicine pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 706, '0x02C2', q'|Makeup Bag|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 482, '0x01E2', q'|Silver Wing|', q'|Key items pocket|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 277, '0x0115', q'|Metronome|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 754, '0x02F2', q'|Sablenite|', q'|Items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 651, '0x028B', q'|Pok� Flute|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 252, '0xFC', q'|TM52|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 106, '0x006A', q'|Pearl|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 935, '0x03A7', q'|Orange Petal|', q'|Key items pocket|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 165, '0x00A5', q'|Bluk Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 72, '0x0048', q'|Red Shard|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 558, '0x022E', q'|Bug Gem|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 461, '0x01CD', q'|Coupon 2|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 123, '0x007B', q'|TM Case|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 406, '0x0196', q'|TM79|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 449, '0x01C1', q'|Poffin Case|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 316, '0x013C', q'|TM28|', q'|TMs and HMs pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 238, '0x00EE', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 138, '0x008A', q'|Leppa Berry|', q'|Berries pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 682, '0x02AA', q'|Manectite|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 410, '0x019A', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 201, '0x00C9', q'|Dragon Scale|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 218, '0x00DA', q'|Soothe Bell|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 259, '0x0103', q'|Stick|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 607, '0x025F', q'|X Sp. Def 6|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 78, '0x4E', q'|PRZCureBerry|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 405, '0x0195', q'|TM78|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 97, '0x0061', q'|Stable Mulch|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 265, '0x0109', q'|Wide Lens|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 687, '0x02AF', q'|Kee Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 39, '0x0027', q'|Max Ether|', q'|Medicine pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 274, '0x0112', q'|Quick Powder|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 78, '0x004E', q'|Escape Rope|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 155, '0x009B', q'|Qualot Berry|', q'|Berries pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 340, '0x0154', q'|TM13|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 506, '0x01FA', q'|D-Disk|', q'|Key items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 895, '0x037F', q'|Leaf Letter|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 176, '0x00B0', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 770, '0x0302', q'|Beedrillite|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 464, '0x01D0', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 697, '0x02B9', q'|Intriguing Stone|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 500, '0x01F4', q'|Park Ball|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 273, '0x0111', q'|Flame Orb|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 593, '0x0251', q'|X Speed 2|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 786, '0x0312', q'|Psychium Z|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 958, '0x03BE', q'|Roto Boost|', q'|Unknown pocket|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 421, '0x01A5', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 1009, '0x03F1', q'|Ponyta Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 236, '0x00EC', q'|Light Ball|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 471, '0x01D7', q'|Dowsing MCHN|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 374, '0x0176', q'|TM47|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 84, '0x0054', q'|Water Stone|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 948, '0x03B4', q'|Left Pok� Ball|', q'|Key items pocket|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 886, '0x0376', q'|Chalky Stone|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 27, '0x001B', q'|Soda Pop|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 165, '0x00A5', q'|Bluk Berry|', q'|Berries pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 319, '0x013F', q'|Luck Incense|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 539, '0x021B', q'|Battle CD 06|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 558, '0x022E', q'|Bug Gem|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 369, '0x0171', q'|TM42|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 308, '0x0134', q'|Insect Plate|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 462, '0x01CE', q'|Coupon 3|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 383, '0x017F', q'|TM56|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 307, '0x0133', q'|Mind Plate|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 449, '0x01C1', q'|Poffin Case|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 79, '0x004F', q'|Repel|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 67, '0x0043', q'|Calcium|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 179, '0x00B3', q'|BrightPowder|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 61, '0x003D', q'|X Special|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 982, '0x03D6', q'|Weedle Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 259, '0x0103', q'|Stick|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 636, '0x027C', q'|Dropped Item|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 97, '0x0061', q'|Stable Mulch|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 90, '0x005A', q'|Stardust|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 173, '0x00AD', q'|Lansat Berry|', q'|Berries pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 510, '0x01FE', q'|Data Card 06|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 137, '0x89', q'|Teru-sama|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 241, '0xF1', q'|TM41|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 363, '0x016B', q'|TM36|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 45, '0x002D', q'|HP Up|', q'|Medicine pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 766, '0x02FE', q'|Mega Cuff|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 297, '0x0129', q'|Choice Specs|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 507, '0x01FB', q'|Data Card 03|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 52, '0x0034', q'|Zinc|', q'|Medicine pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 593, '0x0251', q'|X Speed 2|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 688, '0x02B0', q'|Maranga Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 427, '0x01AB', q'|unknown|', q'|Unknown pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 496, '0x01F0', q'|Love Ball|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 859, '0x035B', q'|???|', q'|Unknown pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 585, '0x0249', q'|Battle CD 52|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 236, '0x00EC', q'|Light Ball|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 367, '0x016F', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 360, '0x0168', q'|TM33|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 561, '0x0231', q'|Dragon Gem|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 319, '0x013F', q'|Luck Incense|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 165, '0x00A5', q'|Bluk Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 35, '0x0023', q'|Max Ether|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 342, '0x0156', q'|TM15|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 307, '0x0133', q'|Mind Plate|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 449, '0x01C1', q'|Poffin Case|', q'|Key items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 474, '0x01DA', q'|Clear Bell|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 925, '0x039D', q'|Lycanium Z|', q'|Z-Crystals pocket|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 196, '0x00C4', q'|Focus Band|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 446, '0x01BE', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 752, '0x02F0', q'|Swampertite|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 293, '0x0125', q'|TM05|', q'|TMs and HMs pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 501, '0x01F5', q'|Photo Album|', q'|Key items pocket|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 919, '0x0397', q'|Dark Memory|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 484, '0x01E4', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 167, '0x00A7', q'|Wepear Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 186, '0x00BA', q'|Wacan Berry|', q'|Berries pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 392, '0x0188', q'|TM65|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 421, '0x01A5', q'|HM02|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 607, '0x025F', q'|X Sp. Def 6|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 879, '0x036F', q'|Terrain Extender|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 224, '0x00E0', q'|Cleanse Tag|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 583, '0x0247', q'|Comet Shard|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 363, '0x016B', q'|TM36|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 842, '0x034A', q'|Fishing Rod|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 512, '0x0200', q'|DNA Sample|', q'|Key items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 277, '0x0115', q'|Metronome|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 229, '0x00E5', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 536, '0x0218', q'|Enigma Stone|', q'|Key items pocket|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 688, '0x02B0', q'|Maranga Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 179, '0xB3', q'|Teru-sama|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 425, '0x01A9', q'|HM06|', q'|TMs and HMs pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 244, '0x00F4', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 393, '0x0189', q'|TM66|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 172, '0xAC', q'|Up-Grade|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 358, '0x0166', q'|TM31|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 319, '0x013F', q'|Luck Incense|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 307, '0x0133', q'|Mind Plate|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 462, '0x01CE', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 106, '0x006A', q'|Pearl|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 693, '0x02B5', q'|TM99|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 66, '0x0042', q'|Yellow Flute|', q'|Medicine pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 102, '0x0066', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 70, '0x0046', q'|Zinc|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 452, '0x01C4', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 729, '0x02D9', q'|Meteorite|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 405, '0x0195', q'|TM78|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 802, '0x0322', q'|Marshadium Z|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 89, '0x0059', q'|Big Pearl|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 186, '0x00BA', q'|Wacan Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 904, '0x0388', q'|Fighting Memory|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 782, '0x030E', q'|Fightinium Z|', q'|Z-Crystals pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 245, '0xF5', q'|HM03|', q'|TMs and HMs pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 809, '0x0329', q'|Waterium Z|', q'|Z-Crystals pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 502, '0x01F6', q'|GB Sounds|', q'|Key items pocket|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 31, '0x1F', q'|Old Amber|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 334, '0x014E', q'|TM46|', q'|TMs and HMs pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 448, '0x01C0', q'|Sprayduck|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 99, '0x63', q'|??????? (ShellBadge - D)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 358, '0x0166', q'|Dome Fossil|', q'|Key items pocket|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 277, '0x0115', q'|Metronome|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 183, '0x00B7', q'|Quick Claw|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 33, '0x0021', q'|Moomoo Milk|', q'|Medicine pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 340, '0x0154', q'|TM13|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 885, '0x0375', q'|Stretchy Spring|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 471, '0x01D7', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 200, '0x00C8', q'|Leftovers|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 461, '0x01CD', q'|Coupon 2|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 600, '0x0258', q'|X Sp. Atk 3|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 3, '0x0003', q'|Great Ball|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 181, '0x00B5', q'|Watmel Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 453, '0x01C5', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 114, '0x0072', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 505, '0x01F9', q'|Data ROM|', q'|Key items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 358, '0x0166', q'|TM31|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 544, '0x0220', q'|Binding Band|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 307, '0x0133', q'|Mind Plate|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 808, '0x0328', q'|Firium Z|', q'|Z-Crystals pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 456, '0x01C8', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 159, '0x9F', q'|Level Ball|', q'|Pok� Balls pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 438, '0x01B6', q'|Works Key|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 116, '0x0074', q'|Douse Drive|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 202, '0x00CA', q'|Light Ball|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 474, '0x01DA', q'|Clear Bell|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 538, '0x021A', q'|Eviolite|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 209, '0xD1', q'|TM09|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 636, '0x027C', q'|Dropped Item|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 186, '0x00BA', q'|Wacan Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 89, '0x0059', q'|Big Pearl|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 455, '0x01C7', q'|Azure Flute|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 19, '0x0013', q'|Burn Heal|', q'|Medicine pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 118, '0x0076', q'|unknown|', q'|Unknown pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 332, '0x014C', q'|TM05|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 30, '0x1E', q'|Repel|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 147, '0x0093', q'|Iapapa Berry|', q'|Berries pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 787, '0x0313', q'|Buginium Z|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 562, '0x0232', q'|Dark Gem|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 112, '0x70', q'|??????? (Petit Captain - D)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 156, '0x009C', q'|Persim Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 178, '0x00B2', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 52, '0x0034', q'|Zinc|', q'|Medicine pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 450, '0x01C2', q'|Bike|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 712, '0x02C8', q'|Looker Ticket|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 924, '0x039C', q'|Mimikium Z|', q'|Z-Crystals pocket|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 485, '0x01E5', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 176, '0x00B0', q'|Magost Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 243, '0x00F3', q'|Mystic Water|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 327, '0x0147', q'|Razor Fang|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 374, '0x0176', q'|TM47|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 353, '0x0161', q'|TM26|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 571, '0x023B', q'|Pretty Wing|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 10, '0x000A', q'|Timer Ball|', q'|Pok� Balls pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 538, '0x021A', q'|Eviolite|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 928, '0x03A0', q'|Lunalium Z|', q'|Z-Crystals pocket|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 346, '0x015A', q'|TM19|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 34, '0x0022', q'|Energy Powder|', q'|Medicine pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 198, '0x00C6', q'|Colbur Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 866, '0x0362', q'|Golden Pinap Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 607, '0x025F', q'|X Sp. Def 6|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 54, '0x0036', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 186, '0x00BA', q'|Wacan Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 1048, '0x0418', q'|Aerodactyl Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 215, '0x00D7', q'|Charcoal|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 497, '0x01F1', q'|Friend Ball|', q'|Pok� Balls pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 118, '0x0076', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 332, '0x014C', q'|TM05|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 521, '0x0209', q'|Data Card 17|', q'|Items pocket|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 524, '0x020C', q'|Data Card 20|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 644, '0x0284', q'|Pixie Plate|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 15, '0x000F', q'|Quick Ball|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 447, '0x01BF', q'|Super Rod|', q'|Key items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 66, '0x0042', q'|Carbos|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 340, '0x0154', q'|TM13|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 717, '0x02CD', q'|Mega Glove|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 550, '0x0226', q'|Battle CD 17|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 276, '0x0114', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 176, '0x00B0', q'|Magost Berry|', q'|Berries pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 97, '0x61', q'|Wht Apricorn|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 243, '0x00F3', q'|Mystic Water|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 449, '0x01C1', q'|Poffin Case|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 327, '0x0147', q'|Razor Fang|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 349, '0x015D', q'|TM22|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 67, '0x43', q'|SecretPotion|', q'|Key items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 358, '0x0166', q'|TM31|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 545, '0x0221', q'|Absorb Bulb|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 11, '0x000B', q'|Luxury Ball|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 438, '0x01B6', q'|Works Key|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 251, '0x00FB', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 640, '0x0280', q'|Assault Vest|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 391, '0x0187', q'|TM64|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 566, '0x0236', q'|Battle CD 33|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 73, '0x0049', q'|Guard Spec.|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 720, '0x02D0', q'|Wailmer Pail|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 510, '0x01FE', q'|Data Card 06|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 336, '0x0150', q'|TM48|', q'|TMs and HMs pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 374, '0x0176', q'|TM47|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 511, '0x01FF', q'|Data Card 07|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 54, '0x0036', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 455, '0x01C7', q'|Azure Flute|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 837, '0x0345', q'|???|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 89, '0x0059', q'|Big Pearl|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 366, '0x016E', q'|Teachy TV|', q'|Key items pocket|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 260, '0x0104', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 134, '0x0086', q'|unknown|', q'|Unknown pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 273, '0x0111', q'|Pok�block Case|', q'|Key items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 425, '0x01A9', q'|HM06|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 396, '0x018C', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 20, '0x0014', q'|Ice Heal|', q'|Medicine pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 693, '0x02B5', q'|TM99|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 629, '0x0275', q'|DNA Splicers|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 490, '0x01EA', q'|White Apricorn|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 340, '0x0154', q'|TM13|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 775, '0x0307', q'|Eon Flute|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 109, '0x6D', q'|MiracleBerry|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 15, '0x000F', q'|Quick Ball|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 418, '0x01A2', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 589, '0x024D', q'|Relic Statue|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 277, '0x0115', q'|Metronome|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 176, '0x00B0', q'|Magost Berry|', q'|Berries pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 479, '0x01DF', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 951, '0x03B7', q'|Roto Prize Money|', q'|Unknown pocket|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 112, '0x0070', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 136, '0x0088', q'|Lustrous Orb|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 43, '0x002B', q'|White Flute|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 223, '0x00DF', q'|Amulet Coin|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 680, '0x02A8', q'|Heracronite|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 23, '0x0017', q'|Full Restore|', q'|Medicine pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 218, '0x00DA', q'|Up-Grade|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 472, '0x01D8', q'|Blue Card|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 181, '0x00B5', q'|Macho Brace|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 94, '0x005E', q'|Honey|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 168, '0x00A8', q'|Liechi Berry|', q'|Berries pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 185, '0x00B9', q'|Passho Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 403, '0x0193', q'|TM76|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 112, '0x0070', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 538, '0x021A', q'|Eviolite|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 391, '0x0187', q'|TM64|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 785, '0x0311', q'|Flyinium Z|', q'|Z-Crystals pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 426, '0x01AA', q'|HM07|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 374, '0x0176', q'|TM47|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 70, '0x0046', q'|Shoal Salt|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 455, '0x01C7', q'|Azure Flute|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 781, '0x030D', q'|Icium Z|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 415, '0x019F', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 322, '0x0142', q'|TM34|', q'|TMs and HMs pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 621, '0x026D', q'|Xtransceiver|', q'|Key items pocket|', q'|Black 2, White 2|', 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 212, '0x00D4', q'|Rowap Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 569, '0x0239', q'|Clever Wing|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 20, '0x0014', q'|Ice Heal|', q'|Medicine pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 302, '0x012E', q'|Icicle Plate|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 268, '0x010C', q'|Expert Belt|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 544, '0x0220', q'|Binding Band|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 346, '0x015A', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 75, '0x004B', q'|X Attack|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 589, '0x024D', q'|Relic Statue|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 276, '0x0114', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 176, '0x00B0', q'|Magost Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 327, '0x0147', q'|Razor Fang|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 4, '0x04', q'|Pok� Ball|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 223, '0x00DF', q'|Amulet Coin|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 319, '0x013F', q'|Luck Incense|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 504, '0x01F8', q'|RageCandyBar|', q'|Medicine pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 23, '0x0017', q'|Full Restore|', q'|Medicine pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 1046, '0x0416', q'|Omanyte Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 353, '0x0161', q'|TM26|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 619, '0x026B', q'|TM94|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 91, '0x005B', q'|Star Piece|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 368, '0x0170', q'|TM41|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 400, '0x0190', q'|TM73|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 354, '0x0162', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 236, '0x00EC', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 938, '0x03AA', q'|Green Petal|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 401, '0x0191', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 530, '0x0212', q'|Data Card 26|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 192, '0x00C0', q'|Coba Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 116, '0x0074', q'|unknown|', q'|Unknown pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 447, '0x01BF', q'|Super Rod|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 730, '0x02DA', q'|Key to Room 1|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 333, '0x014D', q'|TM45|', q'|TMs and HMs pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 147, '0x0093', q'|Bridge Mail V|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 18, '0x0012', q'|Antidote|', q'|Medicine pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 20, '0x0014', q'|Ice Heal|', q'|Medicine pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 557, '0x022D', q'|Psychic Gem|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 560, '0x0230', q'|Ghost Gem|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 268, '0x010C', q'|Expert Belt|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 117, '0x0075', q'|Shock Drive|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 565, '0x0235', q'|Health Wing|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 33, '0x0021', q'|Moomoo Milk|', q'|Medicine pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 589, '0x024D', q'|Relic Statue|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 252, '0x00FC', q'|Up-Grade|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 480, '0x01E0', q'|Pass|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 544, '0x0220', q'|Binding Band|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 458, '0x01CA', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 347, '0x015B', q'|TM20|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 925, '0x039D', q'|Lycanium Z|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 94, '0x005E', q'|Honey|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 23, '0x0017', q'|Full Restore|', q'|Medicine pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 368, '0x0170', q'|TM41|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 1, '0x01', q'|Master Ball|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 438, '0x01B6', q'|Works Key|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 178, '0x00B2', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 495, '0x01EF', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 108, '0x006C', q'|Dusk Stone|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 902, '0x0386', q'|Max Lure|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 665, '0x0299', q'|Medichamite|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 333, '0x014D', q'|TM06|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 530, '0x0212', q'|Data Card 26|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 197, '0x00C5', q'|Haban Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 407, '0x0197', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 455, '0x01C7', q'|Azure Flute|', q'|Key items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 472, '0x01D8', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 5, '0x0005', q'|Safari Ball|', q'|Pok� Balls pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 446, '0x01BE', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 861, '0x035D', q'|Silver Razz Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 147, '0x0093', q'|BridgeMail V|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 263, '0x0107', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 236, '0x00EC', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 550, '0x0226', q'|Electric Gem|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 357, '0x0165', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 54, '0x0036', q'|Old Gateau|', q'|Medicine pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 13, '0x000D', q'|Potion|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 140, '0x008C', q'|Bloom Mail|', q'|Mail pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 273, '0x0111', q'|Flame Orb|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 33, '0x0021', q'|Moomoo Milk|', q'|Medicine pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 708, '0x02C4', q'|Lumiose Galette|', q'|Medicine pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 1, '0x01', q'|Master Ball|', q'|Pok� Balls pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 398, '0x018E', q'|TM71|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 461, '0x01CD', q'|Coupon 2|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 480, '0x01E0', q'|Pass|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 622, '0x026E', q'|???|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 15, '0x000F', q'|Burn Heal|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 377, '0x0179', q'|TM50|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 382, '0x017E', q'|TM55|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 319, '0x013F', q'|Luck Incense|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 153, '0x0099', q'|Pomeg Berry|', q'|Berries pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 499, '0x01F3', q'|Sport Ball|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 348, '0x15C', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 270, '0x010E', q'|Soot Sack|', q'|Key items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 94, '0x005E', q'|Honey|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 304, '0x0130', q'|Toxic Plate|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 325, '0x0145', q'|TM37|', q'|TMs and HMs pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 369, '0x0171', q'|TM42|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 195, '0x00C3', q'|Charti Berry|', q'|Berries pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 368, '0x0170', q'|TM41|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 116, '0x0074', q'|Douse Drive|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 705, '0x02C1', q'|Lens Case|', q'|Key items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 78, '0x4E', q'|Super Rod|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 240, '0x00F0', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 91, '0x005B', q'|Star Piece|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 14, '0x0E', q'|Awakening|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 153, '0x0099', q'|Pomeg Berry|', q'|Berries pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 733, '0x02DD', q'|Key to Room 6|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 336, '0x0150', q'|TM48|', q'|TMs and HMs pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 760, '0x02F8', q'|Slowbronite|', q'|Items pocket|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 316, '0x013C', q'|Full Incense|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 665, '0x0299', q'|Medichamite|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 192, '0x00C0', q'|Coba Berry|', q'|Berries pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 530, '0x0212', q'|Data Card 26|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 12, '0x000C', q'|Premier Ball|', q'|Pok� Balls pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 460, '0x01CC', q'|Coupon 1|', q'|Key items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 7, '0x0007', q'|Dive Ball|', q'|Pok� Balls pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 447, '0x01BF', q'|Super Rod|', q'|Key items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 120, '0x0078', q'|unknown|', q'|Unknown pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 348, '0x015C', q'|TM21|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 190, '0x00BE', q'|Cleanse Tag|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 121, '0x0079', q'|Pok�mon Box|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 550, '0x0226', q'|Electric Gem|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 477, '0x01DD', q'|Squirt Bottle|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 257, '0x0101', q'|Metal Powder|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 557, '0x022D', q'|Psychic Gem|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 325, '0x0145', q'|TM37|', q'|TMs and HMs pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 130, '0x0082', q'|Dream Mail|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 1035, '0x040B', q'|Mr. Mime Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 100, '0x64', q'|??????? (JizoBadge - D)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 25, '0x0019', q'|Max Revive|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 427, '0x01AB', q'|HM08|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 33, '0x0021', q'|Moomoo Milk|', q'|Medicine pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 120, '0x78', q'|Teru-sama|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 522, '0x020A', q'|Data Card 18|', q'|Items pocket|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 412, '0x019C', q'|TM85|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 697, '0x02B9', q'|Intriguing Stone|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 297, '0x0129', q'|Choice Specs|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 111, '0x006F', q'|Heart Scale|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 708, '0x02C4', q'|Lumiose Galette|', q'|Medicine pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 347, '0x015B', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 461, '0x01CD', q'|Coupon 2|', q'|Key items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 254, '0xFE', q'|HM12|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 3, '0x0003', q'|Great Ball|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 850, '0x0352', q'|Ride Pager|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 396, '0x018C', q'|TM69|', q'|TMs pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 241, '0x00F1', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 438, '0x01B6', q'|Works Key|', q'|Key items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 240, '0x00F0', q'|BlackGlasses|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 327, '0x0147', q'|Razor Fang|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 708, '0x02C4', q'|Lumiose Galette|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 243, '0x00F3', q'|Mystic Water|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 158, '0x9E', q'|Flower Mail|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 341, '0x0155', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 705, '0x02C1', q'|Lens Case|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 232, '0x00E8', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 52, '0x0034', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 149, '0x0095', q'|Bluk Berry|', q'|Berries pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 595, '0x0253', q'|X Sp. Def 2|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 116, '0x0074', q'|Douse Drive|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 91, '0x005B', q'|Star Piece|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 400, '0x0190', q'|TM73|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 391, '0x0187', q'|TM64|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 614, '0x0266', q'|Reset Urge|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 699, '0x02BB', q'|Discount Coupon|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 11, '0x000B', q'|Luxury Ball|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 125, '0x007D', q'|unknown|', q'|Unknown pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 940, '0x03AC', q'|Purple Petal|', q'|Key items pocket|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 116, '0x0074', q'|unknown|', q'|Unknown pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 25, '0x0019', q'|Max Revive|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 722, '0x02D2', q'|Soot Sack|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 12, '0x000C', q'|Premier Ball|', q'|Pok� Balls pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 7, '0x0007', q'|Dive Ball|', q'|Pok� Balls pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 447, '0x01BF', q'|Super Rod|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 490, '0x01EA', q'|White Apricorn|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 228, '0xE4', q'|TM36|', q'|TMs and HMs pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 347, '0x015B', q'|TM20|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 150, '0x96', q'|MysteryBerry|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 466, '0x01D2', q'|Gracidea|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 527, '0x020F', q'|Data Card 23|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 301, '0x012D', q'|Meadow Plate|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 15, '0x000F', q'|Quick Ball|', q'|Pok� Balls pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 758, '0x02F6', q'|Metagrossite|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 103, '0x0067', q'|Old Amber|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 273, '0x0111', q'|Flame Orb|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 284, '0x011C', q'|Rm. 6 Key|', q'|Key items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 608, '0x0260', q'|X Defend 6|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 959, '0x03BF', q'|Roto Catch|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 877, '0x036D', q'|???|', q'|Unknown pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 584, '0x0248', q'|Battle CD 51|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 297, '0x0129', q'|Choice Specs|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 700, '0x02BC', q'|Elevator Key|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 620, '0x026C', q'|TM95|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 231, '0xE7', q'|TM39|', q'|TMs and HMs pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 358, '0x0166', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 485, '0x01E5', q'|Red Apricorn|', q'|Items pocket|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 417, '0x01A1', q'|TM90|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 1045, '0x0415', q'|Porygon Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 474, '0x01DA', q'|Clear Bell|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 545, '0x0221', q'|Battle CD 12|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 243, '0x00F3', q'|Mystic Water|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 903, '0x0387', q'|Pewter Crunchies|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 299, '0x012B', q'|Splash Plate|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 125, '0x007D', q'|unknown|', q'|Unknown pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 545, '0x0221', q'|Absorb Bulb|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 145, '0x0091', q'|Bridge Mail D|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 995, '0x03E3', q'|Oddish Candy|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 292, '0x0124', q'|TM04|', q'|TMs and HMs pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 26, '0x001A', q'|Super Potion|', q'|Medicine pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 225, '0xE1', q'|TM25|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 258, '0x0102', q'|Yellow Scarf|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 179, '0x00B3', q'|BrightPowder|', q'|Items pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 203, '0x00CB', q'|Soft Sand|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 347, '0x015B', q'|TM20|', q'|TMs and HMs pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 157, '0x009D', q'|Grepa Berry|', q'|Berries pocket|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 61, '0x003D', q'|X Sp. Atk|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 120, '0x0078', q'|unknown|', q'|Unknown pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 559, '0x022F', q'|Rock Gem|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 2, '0x02', q'|Ultra Ball|', q'|Pok� Balls pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 512, '0x0200', q'|Cologne Case|', q'|Key items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 644, '0x0284', q'|Pixie Plate|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 242, '0x00F2', q'|Magnet|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 257, '0x0101', q'|Metal Powder|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 585, '0x0249', q'|Relic Silver|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 540, '0x021C', q'|Ein File C|', q'|Key items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 15, '0x000F', q'|Quick Ball|', q'|Pok� Balls pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 496, '0x01F0', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 155, '0x009B', q'|Oran Berry|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 396, '0x018C', q'|TM69|', q'|TMs and HMs pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 134, '0x0086', q'|Sweet Heart|', q'|Medicine pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 48, '0x30', q'|Card Key|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 529, '0x0211', q'|Data Card 25|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 305, '0x0131', q'|Earth Plate|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 520, '0x0208', q'|Data Card 16|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 100, '0x0064', q'|Claw Fossil|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 23, '0x17', q'|Thunderstone|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 61, '0x3D', q'|Soda Pop|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 853, '0x0355', q'|Red Nectar|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 297, '0x0129', q'|Choice Specs|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 399, '0x018F', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 461, '0x01CD', q'|Coupon 2|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 816, '0x0330', q'|Flyinium Z|', q'|Z-Crystals pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 59, '0x3B', q'|Coin|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 253, '0x00FD', q'|Shell Bell|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 352, '0x0160', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 6, '0x0006', q'|Net Ball|', q'|Pok� Balls pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 115, '0x0073', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 208, '0x00D0', q'|Magnet|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 517, '0x0205', q'|Data Card 13|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 87, '0x57', q'|2F (G)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 223, '0x00DF', q'|Amulet Coin|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 328, '0x0148', q'|TM01|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 92, '0x005C', q'|unknown|', q'|Unknown pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 93, '0x5D', q'|Grn Apricorn|', q'|Items pocket|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 190, '0x00BE', q'|Cleanse Tag|', q'|Items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 448, '0x01C0', q'|Sprayduck|', q'|Key items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 129, '0x0081', q'|unknown|', q'|Unknown pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 303, '0x012F', q'|Fist Plate|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 513, '0x0201', q'|DNA Sample|', q'|Key items pocket|', q'|Colo|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 492, '0x01EC', q'|Fast Ball|', q'|Pok� Balls pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 769, '0x0301', q'|Salamencite|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 101, '0x0065', q'|Helix Fossil|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 545, '0x0221', q'|Absorb Bulb|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 460, '0x01CC', q'|Coupon 1|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 26, '0x001A', q'|Super Potion|', q'|Medicine pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 274, '0x0112', q'|Quick Powder|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 347, '0x015B', q'|TM20|', q'|TMs and HMs pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 458, '0x01CA', q'|Magma Stone|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 907, '0x038B', q'|Ground Memory|', q'|Items pocket|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 509, '0x01FD', q'|Data Card 05|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 493, '0x01ED', q'|Level Ball|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 559, '0x022F', q'|Rock Gem|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 50, '0x0032', q'|Yellow Shard|', q'|Items pocket|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 138, '0x008A', q'|Favored Mail|', q'|Unknown pocket|', q'|LG|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 594, '0x0252', q'|X Special 2|', q'|Items pocket|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 585, '0x0249', q'|Relic Silver|', q'|Items pocket|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 257, '0x0101', q'|Metal Powder|', q'|Items pocket|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 242, '0xF2', q'|TM42|' , 1 );