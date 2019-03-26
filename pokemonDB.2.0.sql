create table Types(
TYPE varchar2(15 byte) primary key, --The name of the type
DISCRIPTION clob check(DISCRIPTION is JSON), --The discription of the type
ATK_SE varchar2(300) check(ATK_SE is JSON), --Supper effective when atacking the folowing types
ATK_NVE varchar2(300) check(ATK_NVE is JSON), --Not very effective when atacking the folowing types
ATK_NE varchar2(300) check(ATK_NE is JSON), --Not effective when atacking the folowing types
DEF_SE varchar2(300) check(DEF_SE is JSON), --Supper effective when defending with the folowing types
DEF_NVE varchar2(300) check(DEF_NVE is JSON), --Not very effective when defending with the folowing types
DEF_NE varchar2(300) check(DEF_NE is JSON), --Not effective when defending with the folowing types
URL varchar2(200 byte) --The link to see more about the type
);
create table eggGroups(
NAME varchar2(30 byte) primary key, --The name of the group
TYPE_ALIAS varchar2(15 byte) references TYPES(TYPE), --The type the group belongs to if any
URL varchar2(200 byte) --The link to see more about the group
);
create table BODY(
BODY varchar2(100 byte) primary key, --The name of the body
PARENT varchar2(100 byte) references BODY(BODY), --The parent of the body type
DISCRIPTION clob , --An expanded explination of the form
ID number(2,0) unique --The ID of the body type according to the images used
);
create table GENERATION(
GEN number(3,1) primary key, --The generation number
REGION varchar2(100) , --The main region that the generation belongs to
DEX_MIN number(4,0) , --The lowest DEX value in the generation
DEX_MAX number(4,0) , --The highest DEX value in the generation
LDEX_MIN number(3,0) , --The lowest Local DEX value in the generation
LDEX_MAX number(3,0) , --The highest Local DEX value in the generation
CONSTRAINT ck_DEX_RANGE check(DEX_MIN<DEX_MAX), --Ensure the range is valid
CONSTRAINT ck_LDEX_RANGE check(LDEX_MIN<LDEX_MAX) --Ensure the range is valid
);
create table GENDER_RATIO(
KEY varchar2(6) primary key, --The auto generated key to refference the ratio
MALE number(2,0) , --The male part of the ratio
FEMALE number(2,0) , --The female part of the ratio
UNBREEDABLE char(1) default on null 'F' check(unbreedable in('T', 'F', '*')), --Indicates if they are unbreeadable
CONSTRAINT un_KEY unique(MALE, FEMALE, UNBREEDABLE) --Ensure Key will produce a valid primary key
);



-- BEGIN TYPE PL/SQL
create or replace trigger TYPE_URL_TRG
before insert or update on TYPES
for each row when(new.URL is null)
begin --Create the URL
:new.URL:='https://bulbapedia.bulbagarden.net/wiki/'||  REGEXP_REPLACE(:new.TYPE, '\s', '_')  ||'_(type)';
end;
/

create TYPE arr_type is varray(3) of varchar2(300);
/

create or replace FUNCTION GET_DEF(
GET_TYPE in varchar2
) RETURN arr_type
is
JSON arr_type:=arr_type(null, null, null);
begin
select JSON_ARRAYAGG(t.type RETURNING VARCHAR2(300))
into JSON(1)
from types t,
json_table(t.ATK_SE, '$[*]' COLUMNS(COL PATH '$')) as JT
where JT.COL=GET_TYPE;

select JSON_ARRAYAGG(t.type RETURNING VARCHAR2(300))
into JSON(2)
from types t,
json_table(t.ATK_NVE, '$[*]' COLUMNS(COL PATH '$')) as JT
where JT.COL=GET_TYPE;

select JSON_ARRAYAGG(t.type RETURNING VARCHAR2(300))
into JSON(3)
from types t,
json_table(t.ATK_NE, '$[*]' COLUMNS(COL PATH '$')) as JT
where JT.COL=GET_TYPE;

RETURN JSON;
END GET_DEF;
/

create or replace FUNCTION GET_ATK(
GET_TYPE in varchar2
) RETURN arr_type
is
JSON arr_type:=arr_type(null, null, null);
begin
select JSON_ARRAYAGG(t.type RETURNING VARCHAR2(300))
into JSON(1)
from types t,
json_table(t.DEF_SE, '$[*]' COLUMNS(COL PATH '$')) as JT
where JT.COL=GET_TYPE;

select JSON_ARRAYAGG(t.type RETURNING VARCHAR2(300))
into JSON(2)
from types t,
json_table(t.DEF_NVE, '$[*]' COLUMNS(COL PATH '$')) as JT
where JT.COL=GET_TYPE;

select JSON_ARRAYAGG(t.type RETURNING VARCHAR2(300))
into JSON(3)
from types t,
json_table(t.DEF_NE, '$[*]' COLUMNS(COL PATH '$')) as JT
where JT.COL=GET_TYPE;

RETURN JSON;
END GET_ATK;
/


create or replace PROCEDURE TYPE_FINAL as
JSON arr_type;
begin
for cTYPE in (select TYPE from TYPES) loop
DBMS_OUTPUT.PUT_LINE(cTYPE.TYPE);
JSON:=GET_DEF(cTYPE.TYPE);
update TYPES
set DEF_SE=JSON(1), DEF_NVE=JSON(2), DEF_NE=JSON(3)
where TYPE=cTYPE.TYPE;
end loop;
end;
/
-- BEGIN EGGGROUP PL/SQL
create or replace trigger EGGGROUP_URL_TRG
before insert or update on eggGroups
for each row when(new.URL is null)
begin --Create the URL
:new.URL:='https://bulbapedia.bulbagarden.net/wiki/'|| REGEXP_REPLACE(:new.NAME, '\s', '_') ||'_(Egg_Group)';
end;
/

-- BEGIN GENDER_RATIO PL/SQL
create or replace trigger GENDER_RATIO_U_TRG
before insert or update on GENDER_RATIO
for each row when(new.UNBREEDABLE='U')
begin
:new.UNBREEDABLE:='T';
end;
/

create or replace trigger GENDER_RATIO_KEY_TRG
before insert or update on GENDER_RATIO
for each row
begin
:new.key:= :new.MALE||':'||:new.FEMALE||
case :new.UNBREEDABLE
when 'T' then 'U'
when '*' then '*'
else ''
end;
end;
/














insert into Types( TYPE , ATK_NVE, ATK_NE )
values( 'Normal' , q'|["Rock", "Steel"]|', q'|["Ghost"]|' );
insert into Types( TYPE , ATK_SE, ATK_NVE, ATK_NE )
values( 'Fighting' , q'|["Dark", "Ice", "Normal", "Rock", "Steel"]|', q'|["Bug", "Fairy", "Flying", "Poison", "Psychic"]|', q'|["Ghost"]|' );
insert into Types( TYPE , ATK_SE, ATK_NVE )
values( 'Flying' , q'|["Bug", "Fighting", "Grass"]|', q'|["Electric", "Rock", "Steel"]|' );
insert into Types( TYPE , ATK_SE, ATK_NVE, ATK_NE )
values( 'Poison' , q'|["Fairy", "Grass"]|', q'|["Poison", "Ground", "Rock", "Ghost"]|', q'|["Steel"]|' );
insert into Types( TYPE , ATK_SE, ATK_NVE, ATK_NE )
values( 'Ground' , q'|["Electric", "Fire", "Poison", "Rock", "Steel"]|', q'|["Bug", "Grass"]|', q'|["Flying"]|' );
insert into Types( TYPE , ATK_SE, ATK_NVE )
values( 'Rock' , q'|["Bug", "Fire", "Flying", "Ice"]|', q'|["Fighting", "Ground"]|' );
insert into Types( TYPE , ATK_SE, ATK_NVE )
values( 'Bug' , q'|["Dark", "Grass", "Psychic"]|', q'|["Fairy", "Fighting", "Fire", "Flying", "Ghost", "Poison", "Steel"]|' );
insert into Types( TYPE , ATK_SE, ATK_NVE, ATK_NE )
values( 'Ghost' , q'|["Ghost", "Psychic"]|', q'|["Dark"]|', q'|["Normal"]|' );
insert into Types( TYPE , ATK_SE, ATK_NVE )
values( 'Steel' , q'|["Fairy", "Ice", "Rock"]|', q'|["Electric", "Fire", "Steel", "Rock"]|' );
insert into Types( TYPE , ATK_SE, ATK_NVE )
values( 'Fire' , q'|["Bug", "Grass", "Ice", "Steel"]|', q'|["Dragon", "Fire", "Rock", "Water"]|' );
insert into Types( TYPE , ATK_SE, ATK_NVE )
values( 'Water' , q'|["Fire", "Ground", "Rock"]|', q'|["Dragon", "Grass", "Water"]|' );
insert into Types( TYPE , ATK_SE, ATK_NVE )
values( 'Grass' , q'|["Ground", "Rock", "Water"]|', q'|["Bug", "Dragon", "Fire", "Flying", "Grass", "Poison", "Steel"]|' );
insert into Types( TYPE , ATK_SE, ATK_NVE, ATK_NE )
values( 'Electric' , q'|["Flying", "Water"]|', q'|["Dragon", "Electric", "Grass"]|', q'|["Ground"]|' );
insert into Types( TYPE , ATK_SE, ATK_NVE, ATK_NE )
values( 'Psychic' , q'|["Fighting", "Poison"]|', q'|["Psychic", "Steel"]|', q'|["Dark"]|' );
insert into Types( TYPE , ATK_SE, ATK_NVE )
values( 'Ice' , q'|["Dragon", "Flying", "Grass", "Ground"]|', q'|["Fire", "Ice", "Steel", "Water"]|' );
insert into Types( TYPE , ATK_SE, ATK_NVE, ATK_NE )
values( 'Dragon' , q'|["Dragon"]|', q'|["Steel"]|', q'|["Fairy"]|' );
insert into Types( TYPE , ATK_SE, ATK_NVE )
values( 'Dark' , q'|["Ghost", "Psychic"]|', q'|["Dark", "Fairy", "Fighting"]|' );
insert into Types( TYPE , ATK_SE, ATK_NVE )
values( 'Fairy' , q'|["Dark", "Dragon", "Fighting"]|', q'|["Fire", "Poison", "Steel"]|' );

insert into eggGroups( NAME )
values( 'Monster' );
insert into eggGroups( NAME, TYPE_ALIAS )
values( 'Water 1', 'Water' );
insert into eggGroups( NAME, TYPE_ALIAS )
values( 'Bug', 'Bug' );
insert into eggGroups( NAME, TYPE_ALIAS )
values( 'Flying', 'Flying' );
insert into eggGroups( NAME )
values( 'Field' );
insert into eggGroups( NAME, TYPE_ALIAS )
values( 'Fairy', 'Fairy' );
insert into eggGroups( NAME, TYPE_ALIAS )
values( 'Grass', 'Grass' );
insert into eggGroups( NAME )
values( 'Undiscovered' );
insert into eggGroups( NAME )
values( 'Gender unknown' );
insert into eggGroups( NAME )
values( 'Human-Like' );
insert into eggGroups( NAME, TYPE_ALIAS )
values( 'Water 3', 'Water' );
insert into eggGroups( NAME )
values( 'Mineral' );
insert into eggGroups( NAME )
values( 'Amorphous' );
insert into eggGroups( NAME, TYPE_ALIAS )
values( 'Water 2', 'Water' );
insert into eggGroups( NAME, TYPE_ALIAS )
values( 'Ditto', 'Normal' );
insert into eggGroups( NAME, TYPE_ALIAS )
values( 'Dragon', 'Dragon' );

insert into BODY( BODY , DISCRIPTION, ID )
values( 'Bipedal, tailless form' , q'|With a bipedal, tailless form|', 12 );
insert into BODY( BODY, PARENT, DISCRIPTION, ID )
values( 'Bipedal, tailed form', 'Bipedal, tailless form', q'|With a bipedal, tailed form|', 6 );
insert into BODY( BODY , DISCRIPTION, ID )
values( 'Fins' , q'|With fins|', 3 );
insert into BODY( BODY , DISCRIPTION, ID )
values( 'Head' , q'|Consisting of only a head|', 1 );
insert into BODY( BODY, PARENT, DISCRIPTION, ID )
values( 'Head and a base', 'Head', q'|Consisting of a head and a base|', 5 );
insert into BODY( BODY, PARENT, DISCRIPTION, ID )
values( 'Head and arms', 'Head and a base', q'|Consisting of a head and arms|', 4 );
insert into BODY( BODY, PARENT, DISCRIPTION, ID )
values( 'Head and legs', 'Head and a base', q'|Consisting of a head and legs|', 7 );
insert into BODY( BODY , DISCRIPTION, ID )
values( 'Insectoid body' , q'|With an insectoid body|', 14 );
insert into BODY( BODY , DISCRIPTION, ID )
values( 'Multiple bodies' , q'|Consisting of multiple bodies|', 11 );
insert into BODY( BODY , DISCRIPTION, ID )
values( 'Quadruped body' , q'|With a quadruped body|', 8 );
insert into BODY( BODY , DISCRIPTION, ID )
values( 'Serpentine bodies' , q'|With serpentine bodies|', 2 );
insert into BODY( BODY , DISCRIPTION, ID )
values( 'Single pair of wings' , q'|With a single pair of wings|', 9 );
insert into BODY( BODY, PARENT, DISCRIPTION, ID )
values( 'Two or more pairs of wings', 'Single pair of wings', q'|With two or more pairs of wings|', 13 );
insert into BODY( BODY , DISCRIPTION, ID )
values( 'Tentacles or a multiped body' , q'|With tentacles or a multiped body|', 10 );

insert into GENERATION( GEN, REGION, DEX_MIN, DEX_MAX, LDEX_MIN, LDEX_MAX )
values( 1, 'Kanto', 1, 151, 1, 151 );
insert into GENERATION( GEN, REGION, DEX_MIN, DEX_MAX, LDEX_MIN, LDEX_MAX )
values( 2, 'Johto', 152, 251, 1, 256 );
insert into GENERATION( GEN, REGION, DEX_MIN, DEX_MAX, LDEX_MIN, LDEX_MAX )
values( 3, 'Hoenn', 252, 386, 1, 386 );
insert into GENERATION( GEN, REGION, DEX_MIN, DEX_MAX, LDEX_MIN, LDEX_MAX )
values( 4, 'Sinnoh', 387, 487, 1, 210 );
insert into GENERATION( GEN, REGION, DEX_MIN, DEX_MAX, LDEX_MIN, LDEX_MAX )
values( 5, 'Unova', 494, 649, 0, 155 );
insert into GENERATION( GEN, REGION, DEX_MIN, DEX_MAX, LDEX_MIN, LDEX_MAX )
values( 5.1, 'New Unova', 494, 649, 0, 300 );
insert into GENERATION( GEN, REGION, DEX_MIN, DEX_MAX, LDEX_MIN, LDEX_MAX )
values( 6, 'Kalos', 650, 718, 1, 151 );
insert into GENERATION( GEN, REGION, DEX_MIN, DEX_MAX, LDEX_MIN, LDEX_MAX )
values( 7, 'Alola', 722, 802, 1, 302 );
insert into GENERATION( GEN, REGION, DEX_MIN, DEX_MAX, LDEX_MIN, LDEX_MAX )
values( 7.1, 'AlolaUSUM', 722, 807, 1, 403 );

insert into GENDER_RATIO( MALE, FEMALE )
values( 1, 0 );
insert into GENDER_RATIO( MALE, FEMALE, UNBREEDABLE )
values( 1, 0, 'T' );
insert into GENDER_RATIO( MALE, FEMALE )
values( 7, 1 );
insert into GENDER_RATIO( MALE, FEMALE, UNBREEDABLE )
values( 7, 1, 'T' );
insert into GENDER_RATIO( MALE, FEMALE )
values( 3, 1 );
insert into GENDER_RATIO( MALE, FEMALE, UNBREEDABLE )
values( 3, 1, 'T' );
insert into GENDER_RATIO( MALE, FEMALE )
values( 1, 1 );
insert into GENDER_RATIO( MALE, FEMALE, UNBREEDABLE )
values( 1, 1, 'T' );
insert into GENDER_RATIO( MALE, FEMALE )
values( 1, 3 );
insert into GENDER_RATIO( MALE, FEMALE, UNBREEDABLE )
values( 1, 3, 'T' );
insert into GENDER_RATIO( MALE, FEMALE )
values( 1, 7 );
insert into GENDER_RATIO( MALE, FEMALE, UNBREEDABLE )
values( 1, 7, 'T' );
insert into GENDER_RATIO( MALE, FEMALE )
values( 0, 1 );
insert into GENDER_RATIO( MALE, FEMALE, UNBREEDABLE )
values( 0, 1, 'T' );
insert into GENDER_RATIO( UNBREEDABLE )
values( 'T' );
insert into GENDER_RATIO( UNBREEDABLE )
values( '*' );

----------------------------------------------------------

create table ABILITY(
ID number(3,0) unique, --The identification number of the ability
NAME varchar2(30) primary key, --The name of the ability
EFFECT varchar2(1000) , --The effect of the ability
GENERATION number(2,0) references GENERATION(GEN), --The generation of the ability
SINGLE number(2,0) , --???
DUAL number(2,0) , --???
HIDDEN number(2,0) , --???
JAPANESE_KANA nvarchar2(100) , --The name of the ability in JAPANESE_KANA
JAPANESE_ROMAJI nvarchar2(100) , --The name of the ability in JAPANESE_ROMAJI
FRENCH nvarchar2(100) , --The name of the ability in FRENCH
GERMAN nvarchar2(100) , --The name of the ability in GERMAN
ITALIAN nvarchar2(100) , --The name of the ability in ITALIAN
SPANISH nvarchar2(100) , --The name of the ability in SPANISH
KOREAN_HANGUL nvarchar2(100) , --The name of the ability in KOREAN_HANGUL
KOREAN_ROMANIZED nvarchar2(100) , --The name of the ability in KOREAN_ROMANIZED
CHINESE_HANZI nvarchar2(100) , --The name of the ability in CHINESE_HANZI
CHINESE_ROMANIZED nvarchar2(100) --The name of the ability in CHINESE_ROMANIZED
);

insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH )
values( 0, 'Cacophony', q'|Avoids sound-based moves.|', 3, 0, 0, 0, nq'|そうおん|', nq'|Sō On|', nq'|Cacophonie|', nq'|Energieaufladung|', nq'|Cacofonia|', nq'|Cacofonía|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 1, 'Stench', q'|By releasing stench when attacking, this Pokémon may cause the target to flinch.|', 3, 0, 6, 1, nq'|あくしゅう|', nq'|Akushū|', nq'|Puanteur|', nq'|Duftnote|', nq'|Tanfo|', nq'|Hedor|', nq'|악취|', nq'|Akchwi|', nq'|惡臭 / 恶臭|', nq'|Èchòu / Okchau|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 2, 'Drizzle', q'|The Pokémon makes it rain when it enters a battle.|', 3, 1, 1, 1, nq'|あめふらし|', nq'|Amefurashi|', nq'|Crachin|', nq'|Niesel|', nq'|Piovischio|', nq'|Llovizna|', nq'|잔비|', nq'|Janbi|', nq'|降雨|', nq'|Jiàngyǔ / Gongyúh|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 3, 'Speed Boost', q'|Its Speed stat is boosted every turn.|', 3, 2, 2, 8, nq'|かそく|', nq'|Kasoku|', nq'|Turbo|', nq'|Temposchub|', nq'|Acceleratore|', nq'|Impulso|', nq'|가속|', nq'|Gasok|', nq'|加速|', nq'|Jiāsù / Gāchūk|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 4, 'Battle Armor', q'|Hard armor protects the Pokémon from critical hits.|', 3, 3, 4, 2, nq'|カブトアーマー|', nq'|Kabuto Armor|', nq'|Armurbaston|', nq'|Kampfpanzer|', nq'|Lottascudo|', nq'|Armadura Batalla*|', nq'|전투 무장|', nq'|Jeontu Mujang|', nq'|戰鬥盔甲 / 战斗盔甲|', nq'|Zhàndòu Kuījiǎ / Jindau Kwāigaap|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 5, 'Sturdy', q'|It cannot be knocked out with one hit. One-hit KO moves cannot knock it out, either.|', 3, 6, 28, 7, nq'|がんじょう|', nq'|Ganjō|', nq'|Fermeté|', nq'|Robustheit|', nq'|Vigore|', nq'|Robustez|', nq'|옹골참|', nq'|Onggolcham|', nq'|結實 / 结实|', nq'|Jiēshi / Gitsaht|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 6, 'Damp', q'|Prevents the use of explosive moves such as Self-Destruct by dampening its surroundings.|', 3, 0, 8, 10, nq'|しめりけ|', nq'|Shimerike|', nq'|Moiteur|', nq'|Feuchtigkeit|', nq'|Umidità|', nq'|Humedad|', nq'|습기|', nq'|Seupgi|', nq'|濕氣 / 湿气|', nq'|Shīqì / Sāphei|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 7, 'Limber', q'|Its limber body protects the Pokémon from paralysis.|', 3, 1, 9, 2, nq'|じゅうなん|', nq'|Jūnan|', nq'|Échauffement|', nq'|Flexibilität|', nq'|Scioltezza|', nq'|Flexibilidad|', nq'|유연|', nq'|Yuyeon|', nq'|柔軟 / 柔软|', nq'|Róuruǎn / Yàuhyúhn|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 8, 'Sand Veil', q'|Boosts the Pokémon's evasion in a sandstorm.|', 3, 7, 8, 9, nq'|すながくれ|', nq'|Sunagakure|', nq'|Voile Sable|', nq'|Sandschleier|', nq'|Sabbiavelo|', nq'|Velo Arena|', nq'|모래숨기|', nq'|Morae Sumgi|', nq'|沙隱 / 沙隐|', nq'|Shā Yǐn / Sā Yán|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 9, 'Static', q'|The Pokémon is charged with static electricity, so contact with it may cause paralysis.|', 3, 9, 5, 1, nq'|せいでんき|', nq'|Seidenki|', nq'|Statik|', nq'|Statik|', nq'|Statico|', nq'|Elec. Estática*|', nq'|정전기|', nq'|Jeongjeon'gi|', nq'|靜電 / 静电|', nq'|Jìngdiàn / Jihngdihn|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 10, 'Volt Absorb', q'|Restores HP if hit by an Electric-type move, instead of taking damage.|', 3, 3, 2, 2, nq'|ちくでん|', nq'|Chikuden|', nq'|Absorb Volt|', nq'|Voltabsorber|', nq'|Assorbivolt|', nq'|Absorbe Elec*|', nq'|축전|', nq'|Chukjeon|', nq'|蓄電 / 蓄电|', nq'|Xùdiàn / Chūkdihn|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 11, 'Water Absorb', q'|Restores HP if hit by a Water-type move, instead of taking damage.|', 3, 2, 12, 9, nq'|ちょすい|', nq'|Chosui|', nq'|Absorb Eau|', nq'|H2O-Absorber|', nq'|Assorbacqua|', nq'|Absorbe Agua*|', nq'|저수|', nq'|Jeosu|', nq'|儲水 / 储水|', nq'|Chúshuǐ / Chyúhséui|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 12, 'Oblivious', q'|The Pokémon is oblivious, and that keeps it from being infatuated or falling for taunts.|', 3, 0, 19, 5, nq'|どんかん|', nq'|Donkan|', nq'|Benêt|', nq'|Dösigkeit|', nq'|Indifferenza|', nq'|Despiste|', nq'|둔감|', nq'|Dungam|', nq'|遲鈍 / 迟钝|', nq'|Chídùn / Chìhdeuhn|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 13, 'Cloud Nine', q'|Eliminates the effects of weather.|', 3, 0, 2, 5, nq'|ノーてんき|', nq'|Nō Tenki|', nq'|Ciel Gris|', nq'|Wolke Sieben|', nq'|Antimeteo|', nq'|Aclimatación|', nq'|날씨 부정|', nq'|Nalssi Bujeong|', nq'|無關天氣 / 无关天气|', nq'|Wúguān Tiānqì / Mòuhgwāan Tīnhei|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 14, 'Compound Eyes', q'|The Pokémon's compound eyes boost its accuracy.|', 3, 2, 6, 1, nq'|ふくがん|', nq'|Fukugan|', nq'|Œil Composé|', nq'|Facettenauge|', nq'|Insettocchi|', nq'|Ojo Compuesto*|', nq'|복안|', nq'|Bok'an|', nq'|複眼 / 复眼|', nq'|Fùyǎn / Fūkngáahn|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 15, 'Insomnia', q'|The Pokémon is suffering from insomnia and cannot fall asleep.|', 3, 1, 10, 3, nq'|ふみん|', nq'|Fumin|', nq'|Insomnia|', nq'|Insomnia|', nq'|Insonnia|', nq'|Insomnio|', nq'|불면|', nq'|Bulmyeon|', nq'|不眠|', nq'|Bùmián / Bātmìhn|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 16, 'Color Change', q'|The Pokémon's type becomes the type of the move used on it.|', 3, 1, 0, 0, nq'|へんしょく|', nq'|Henshoku|', nq'|Déguisement|', nq'|Farbwechsel|', nq'|Cambiacolore|', nq'|Cambio Color|', nq'|변색|', nq'|Byeonsaek|', nq'|變色 / 变色|', nq'|Biànsè / Binsīk|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 17, 'Immunity', q'|The immune system of the Pokémon prevents it from getting poisoned.|', 3, 1, 1, 1, nq'|めんえき|', nq'|Men'eki|', nq'|Vaccin|', nq'|Immunität|', nq'|Immunità|', nq'|Inmunidad|', nq'|면역|', nq'|Myeon'yeok|', nq'|免疫|', nq'|Miǎnyì / Míhnyihk|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 18, 'Flash Fire', q'|Powers up the Pokémon's Fire-type moves if it's hit by one.|', 3, 4, 10, 3, nq'|もらいび|', nq'|Moraibi|', nq'|Torche|', nq'|Feuerfänger|', nq'|Fuocardore|', nq'|Absorbe Fuego*|', nq'|타오르는 불꽃|', nq'|Taoreuneun Bulkkot|', nq'|引火|', nq'|Yǐnhuǒ / Yáhnfó|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 19, 'Shield Dust', q'|This Pokémon's dust blocks the additional effects of attacks taken.|', 3, 4, 5, 0, nq'|りんぷん|', nq'|Rinpun|', nq'|Écran Poudre|', nq'|Puderabwehr|', nq'|Polvoscudo|', nq'|Polvo Escudo|', nq'|인분|', nq'|Inbun|', nq'|鱗粉 / 鳞粉|', nq'|Línfěn / Lèuhnfán|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 20, 'Own Tempo', q'|This Pokémon has its own tempo, and that prevents it from becoming confused.|', 3, 0, 18, 5, nq'|マイペース|', nq'|My Pace|', nq'|Tempo Perso|', nq'|Tempomacher|', nq'|Mente Locale|', nq'|Ritmo Propio|', nq'|마이페이스|', nq'|My Pace|', nq'|我行我素|', nq'|Wǒxíngwǒsù / Ngóhhàhngngóhsou|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 21, 'Suction Cups', q'|This Pokémon uses suction cups to stay in one spot to negate all moves and items that force switching out.|', 3, 2, 3, 0, nq'|きゅうばん|', nq'|Kyūban|', nq'|Ventouse|', nq'|Saugnapf|', nq'|Ventose|', nq'|Ventosas|', nq'|흡반|', nq'|Heupban|', nq'|吸盤 / 吸盘|', nq'|Xīpán / Kāppún|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 22, 'Intimidate', q'|The Pokémon intimidates opposing Pokémon upon entering battle, lowering their Attack stat.|', 3, 7, 19, 6, nq'|いかく|', nq'|Ikaku|', nq'|Intimidation|', nq'|Bedroher|', nq'|Prepotenza|', nq'|Intimidación|', nq'|위협|', nq'|Wihyeop|', nq'|威嚇 / 威吓|', nq'|Wēihè / Wāihaak|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 23, 'Shadow Tag', q'|This Pokémon steps on the opposing Pokémon's shadow to prevent it from escaping.|', 3, 3, 0, 3, nq'|かげふみ|', nq'|Kage Fumi|', nq'|Marque Ombre|', nq'|Wegsperre|', nq'|Pedinombra|', nq'|Sombra Trampa*|', nq'|그림자 밟기|', nq'|Geurimja Balgi|', nq'|踩影|', nq'|Cǎi Yǐng / Cháai Yíng|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 24, 'Rough Skin', q'|This Pokémon inflicts damage with its rough skin to the attacker on contact.|', 3, 2, 1, 3, nq'|さめはだ|', nq'|Samehada|', nq'|Peau Dure|', nq'|Rauhaut|', nq'|Cartavetro|', nq'|Piel Tosca|', nq'|까칠한 피부|', nq'|Kkachilhan Pibu|', nq'|粗糙皮膚 / 粗糙皮肤|', nq'|Cūcào Pífū / Chōuchou Pèihfū|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 25, 'Wonder Guard', q'|Its mysterious power only lets supereffective moves hit the Pokémon.|', 3, 1, 0, 0, nq'|ふしぎなまもり|', nq'|Fushigina Mamori|', nq'|Garde Mystik|', nq'|Wunderwache|', nq'|Magidifesa|', nq'|Superguarda|', nq'|불가사의 부적|', nq'|Bulgasayi Bujeok|', nq'|神奇守護 / 神奇守护|', nq'|Shénqí Shǒuhù / Sàhnkèih Sáuwuh|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 26, 'Levitate', q'|By floating in the air, the Pokémon receives full immunity to all Ground-type moves.|', 3, 31, 2, 0, nq'|ふゆう|', nq'|Fuyū|', nq'|Lévitation|', nq'|Schwebe|', nq'|Levitazione|', nq'|Levitación|', nq'|부유|', nq'|Buyu|', nq'|飄浮 / 飘浮|', nq'|Piāofú / Pīufàuh|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 27, 'Effect Spore', q'|Contact with the Pokémon may inflict poison, sleep, or paralysis on its attacker.|', 3, 2, 6, 1, nq'|ほうし|', nq'|Hōshi|', nq'|Pose Spore|', nq'|Sporenwirt|', nq'|Spargispora|', nq'|Efecto Espora*|', nq'|포자|', nq'|Poja|', nq'|孢子|', nq'|Bāozǐ / Bāaují|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 28, 'Synchronize', q'|The attacker will receive the same status condition if it inflicts a burn, poison, or paralysis to the Pokémon.|', 3, 3, 12, 0, nq'|シンクロ|', nq'|Shinkuro|', nq'|Synchro|', nq'|Synchro|', nq'|Sincronismo|', nq'|Sincronía|', nq'|싱크로|', nq'|Synchro|', nq'|同步|', nq'|Tóngbù / Tùhngbouh|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 29, 'Clear Body', q'|Prevents other Pokémon's moves or Abilities from lowering the Pokémon's stats.|', 3, 8, 2, 3, nq'|クリアボディ|', nq'|Kuria Bodi|', nq'|Corps Sain|', nq'|Neutraltorso|', nq'|Corpochiaro|', nq'|Cuerpo Puro|', nq'|클리어 바디|', nq'|Clear Body|', nq'|恆淨之軀 / 恒净之躯|', nq'|Héngjìng-zhī Qū / Hàhngjihng-jī Kēui|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 30, 'Natural Cure', q'|All status conditions heal when the Pokémon switches out.|', 3, 4, 11, 1, nq'|しぜんかいふく|', nq'|Shizen Kaifuku|', nq'|Médic Nature|', nq'|Innere Kraft|', nq'|Alternacura|', nq'|Cura Natural|', nq'|자연회복|', nq'|Jayeon Hoebok|', nq'|自然回復 / 自然回复|', nq'|Zìrán Huífù / Jihyìhn Wùihfuhk|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 31, 'Lightning Rod', q'|The Pokémon draws in all Electric-type moves. Instead of being hit by Electric-type moves, it boosts its Sp. Atk.|', 3, 1, 11, 6, nq'|ひらいしん|', nq'|Hiraishin|', nq'|Paratonnerre|', nq'|Blitzfänger|', nq'|Parafulmine|', nq'|Pararrayos|', nq'|피뢰침|', nq'|Piroechim|', nq'|避雷針 / 避雷针|', nq'|Bìléizhēn / Beihlèuihjām|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 32, 'Serene Grace', q'|Boosts the likelihood of additional effects occurring when attacking.|', 3, 3, 7, 2, nq'|てんのめぐみ|', nq'|Ten no Megumi|', nq'|Sérénité|', nq'|Edelmut|', nq'|Leggiadro|', nq'|Dicha|', nq'|하늘의 은총|', nq'|Haneul-yi Eunchong|', nq'|天恩|', nq'|Tiān'ēn / Tīnyān|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 33, 'Swift Swim', q'|Boosts the Pokémon's Speed stat in rain.|', 3, 8, 21, 10, nq'|すいすい|', nq'|Suisui|', nq'|Glissade|', nq'|Wassertempo|', nq'|Nuotovelox|', nq'|Nado Rápido|', nq'|쓱쓱|', nq'|Sseuksseuk|', nq'|悠游自如|', nq'|Yōuyóu Zìrú / Yàuhyàuh Jihyùh|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 34, 'Chlorophyll', q'|Boosts the Pokémon's Speed stat in sunshine.|', 3, 10, 19, 6, nq'|ようりょくそ|', nq'|Yōryokuso|', nq'|Chlorophylle*|', nq'|Chlorophyll|', nq'|Clorofilla|', nq'|Clorofila|', nq'|엽록소|', nq'|Yeoprokso|', nq'|葉綠素 / 叶绿素|', nq'|Yèlǜsù / Yihpluhksou|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 35, 'Illuminate', q'|Raises the likelihood of meeting wild Pokémon by illuminating the surroundings.|', 3, 0, 8, 0, nq'|はっこう|', nq'|Hakkō|', nq'|Lumiattirance|', nq'|Erleuchtung|', nq'|Risplendi|', nq'|Iluminación|', nq'|발광|', nq'|Balgwang|', nq'|發光 / 发光|', nq'|Fāguāng / Faatgwōng|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 36, 'Trace', q'|When it enters a battle, the Pokémon copies an opposing Pokémon's Ability.|', 3, 1, 5, 0, nq'|トレース|', nq'|Torēsu|', nq'|Calque|', nq'|Fährte|', nq'|Traccia|', nq'|Rastro|', nq'|트레이스|', nq'|Trace|', nq'|複製 / 复制|', nq'|Fùzhì / Fūkjai|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 37, 'Huge Power', q'|Doubles the Pokémon's Attack stat.|', 3, 1, 3, 2, nq'|ちからもち|', nq'|Chikara Mochi|', nq'|Coloforce|', nq'|Kraftkoloss|', nq'|Macroforza|', nq'|Potencia|', nq'|천하장사|', nq'|Cheonhajangsa|', nq'|大力士|', nq'|Dà Lìshì / Daaih Lihksih|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 38, 'Poison Point', q'|Contact with the Pokémon may poison the attacker.|', 3, 0, 16, 0, nq'|どくのトゲ|', nq'|Doku no Toge|', nq'|Point Poison|', nq'|Giftdorn|', nq'|Velenopunto|', nq'|Punto Tóxico|', nq'|독가시|', nq'|Dokgasi|', nq'|毒刺|', nq'|Dúcì / Duhkchi|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 39, 'Inner Focus', q'|The Pokémon's intensely focused, and that protects the Pokémon from flinching.|', 3, 5, 17, 11, nq'|せいしんりょく|', nq'|Seishinryoku|', nq'|Attention|', nq'|Konzentrator|', nq'|Forza Interiore*|', nq'|Foco Interno|', nq'|정신력|', nq'|Jeongsinryeok|', nq'|精神力|', nq'|Jīngshén Lì / Jīngsàhn Lihk|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 40, 'Magma Armor', q'|The Pokémon is covered with hot magma, which prevents the Pokémon from becoming frozen.|', 3, 0, 3, 0, nq'|マグマのよろい|', nq'|Magma no Yoroi|', nq'|Armumagma|', nq'|Magmapanzer|', nq'|Magmascudo|', nq'|Escudo Magma|', nq'|마그마의 무장|', nq'|Magma-yi Mujang|', nq'|熔岩鎧甲 / 熔岩铠甲|', nq'|Róngyán Kǎijiǎ / Yùhngngàahm Hóigaap|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 41, 'Water Veil', q'|The Pokémon is covered with a water veil, which prevents the Pokémon from getting a burn.|', 3, 0, 4, 7, nq'|みずのベール|', nq'|Mizu no Bēru|', nq'|Ignifu-Voile|', nq'|Aquahülle|', nq'|Idrovelo|', nq'|Velo Agua|', nq'|수의 베일|', nq'|Su-yi Veil|', nq'|水幕|', nq'|Shuǐ Mù / Séui Mohk|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 42, 'Magnet Pull', q'|Prevents Steel-type Pokémon from escaping using its magnetic force.|', 3, 0, 8, 0, nq'|じりょく|', nq'|Jiryoku|', nq'|Magnépiège|', nq'|Magnetfalle|', nq'|Magnetismo|', nq'|Imán|', nq'|자력|', nq'|Jiryeok|', nq'|磁力|', nq'|Cílì / Chìhlihk|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 43, 'Soundproof', q'|Soundproofing of the Pokémon itself gives full immunity to all sound-based moves.|', 3, 3, 7, 5, nq'|ぼうおん|', nq'|Bō'on|', nq'|Anti-Bruit|', nq'|Lärmschutz|', nq'|Antisuono|', nq'|Insonorizar|', nq'|방음|', nq'|Bang'eum|', nq'|隔音|', nq'|Géyīn / Gaakyām|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 44, 'Rain Dish', q'|The Pokémon gradually regains HP in rain.|', 3, 0, 3, 10, nq'|あめうけざら|', nq'|Ame Ukezara|', nq'|Cuvette|', nq'|Regengenuss|', nq'|Copripioggia|', nq'|Cura Lluvia|', nq'|젖은접시|', nq'|Jeoj'eun Jeopsi|', nq'|雨盤 / 雨盘|', nq'|Yǔ Pán / Yúh Pùhn|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 45, 'Sand Stream', q'|The Pokémon summons a sandstorm when it enters a battle.|', 3, 4, 1, 0, nq'|すなおこし|', nq'|Suna Okoshi|', nq'|Sable Volant|', nq'|Sandsturm|', nq'|Sabbiafiume|', nq'|Chorro Arena|', nq'|모래날림|', nq'|Morae Nallim|', nq'|揚沙 / 扬沙|', nq'|Yáng Shā / Yèuhng Sā|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 46, 'Pressure', q'|By putting pressure on the opposing Pokémon, it raises their PP usage.|', 3, 19, 2, 4, nq'|プレッシャー|', nq'|Puresshā|', nq'|Pression|', nq'|Erzwinger|', nq'|Pressione|', nq'|Presión|', nq'|프레셔|', nq'|Pressure|', nq'|壓迫感 / 压迫感|', nq'|Yāpò Gǎn / Aatbīk Gám|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 47, 'Thick Fat', q'|The Pokémon is protected by a layer of thick fat, which halves the damage taken from Fire- and Ice-type moves.|', 3, 1, 16, 7, nq'|あついしぼう|', nq'|Atsui Shibō|', nq'|Isograisse|', nq'|Speckschicht|', nq'|Grassospesso|', nq'|Sebo|', nq'|두꺼운 지방|', nq'|Dukkeoun Jibang|', nq'|厚脂肪|', nq'|Hòu Zhīfáng / Háuh Jīfōng|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 48, 'Early Bird', q'|The Pokémon awakens twice as fast as other Pokémon from sleep.|', 3, 0, 13, 2, nq'|はやおき|', nq'|Hayaoki|', nq'|Matinal|', nq'|Frühwecker|', nq'|Sveglialampo|', nq'|Madrugar|', nq'|일찍 기상|', nq'|Iljjik Gisang|', nq'|早起|', nq'|Zǎoqǐ / Jóuhéi|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 49, 'Flame Body', q'|Contact with the Pokémon may burn the attacker.|', 3, 7, 5, 4, nq'|ほのおのからだ|', nq'|Honō no Karada|', nq'|Corps Ardent|', nq'|Flammkörper|', nq'|Corpodifuoco|', nq'|Cuerpo Llama|', nq'|불꽃몸|', nq'|Bulkkot Mom|', nq'|火焰之軀 / 火焰之躯|', nq'|Huǒyàn-zhī Qū / Fóyihm-jī Kēui|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 50, 'Run Away', q'|Enables a sure getaway from wild Pokémon.|', 3, 0, 16, 8, nq'|にげあし|', nq'|Nige Ashi|', nq'|Fuite|', nq'|Angsthase|', nq'|Fugafacile|', nq'|Fuga|', nq'|도주|', nq'|Doju|', nq'|逃跑|', nq'|Táopǎo / Tòuhpáau|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 51, 'Keen Eye', q'|Keen eyes prevent other Pokémon from lowering this Pokémon's accuracy.|', 3, 3, 30, 5, nq'|するどいめ|', nq'|Surudoi Me|', nq'|Regard Vif|', nq'|Adlerauge|', nq'|Sguardofermo|', nq'|Vista Lince|', nq'|날카로운 눈|', nq'|Nalkaroun Nun|', nq'|銳利目光 / 锐利目光|', nq'|Ruìlì Mùguāng / Yeuihleih Muhkgwōng|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 52, 'Hyper Cutter', q'|The Pokémon's proud of its powerful pincers. They prevent other Pokémon from lowering its Attack stat.|', 3, 0, 11, 0, nq'|かいりきバサミ|', nq'|Kairiki Basami|', nq'|Hyper Cutter|', nq'|Scherenmacht|', nq'|Ipertaglio|', nq'|Corte Fuerte|', nq'|괴력집게|', nq'|Goeryeok Jipge|', nq'|怪力鉗 / 怪力钳|', nq'|Guàilì Qián / Gwaailihk Kìhm|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 53, 'Pickup', q'|The Pokémon may pick up the item an opposing Pokémon used during a battle. It may pick up items outside of battle, too.|', 3, 1, 15, 2, nq'|ものひろい|', nq'|Mono Hiroi|', nq'|Ramassage|', nq'|Mitnahme|', nq'|Raccolta|', nq'|Recogida|', nq'|픽업|', nq'|Pick-Up|', nq'|撿拾 / 捡拾|', nq'|Jiǎnshí / Gímsahp|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 54, 'Truant', q'|The Pokémon can't use a move the following turn if it uses one.|', 3, 2, 0, 1, nq'|なまけ|', nq'|Namake|', nq'|Absentéisme|', nq'|Schnarchnase|', nq'|Pigrone|', nq'|Ausente|', nq'|게으름|', nq'|Geeureum|', nq'|懶惰 / 懒惰|', nq'|Lǎnduò / Láahndoh|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 55, 'Hustle', q'|Boosts the Attack stat, but lowers accuracy.|', 3, 3, 9, 8, nq'|はりきり|', nq'|Harikiri|', nq'|Agitation|', nq'|Übereifer|', nq'|Tuttafretta|', nq'|Entusiasmo|', nq'|의욕|', nq'|Yiyok|', nq'|活力|', nq'|Huólì / Wuhtlihk|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 56, 'Cute Charm', q'|Contact with the Pokémon may cause infatuation.|', 3, 1, 11, 2, nq'|メロメロボディ|', nq'|Meromero Bodi|', nq'|Joli Sourire|', nq'|Charmebolzen|', nq'|Incantevole|', nq'|Gran Encanto|', nq'|헤롱헤롱 바디|', nq'|Herongherong Body|', nq'|迷人之軀 / 迷人之躯|', nq'|Mírén-zhī Qū / Màihyàhn-jī Kēui|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 57, 'Plus', q'|Boosts the Sp. Atk stat of the Pokémon if an ally with the Plus or Minus Ability is also in battle.|', 3, 1, 3, 4, nq'|プラス|', nq'|Purasu|', nq'|Plus|', nq'|Plus|', nq'|Più|', nq'|Más|', nq'|플러스|', nq'|Plus|', nq'|正電 / 正电|', nq'|Zhèngdiàn / Jingdihn|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 58, 'Minus', q'|Boosts the Sp. Atk stat of the Pokémon if an ally with the Plus or Minus Ability is also in battle.|', 3, 1, 3, 2, nq'|マイナス|', nq'|Mainasu|', nq'|Minus|', nq'|Minus|', nq'|Meno|', nq'|Menos|', nq'|마이너스|', nq'|Minus|', nq'|負電 / 负电|', nq'|Fùdiàn / Fuhdihn|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 59, 'Forecast', q'|The Pokémon transforms with the weather to change its type to Water, Fire, or Ice.|', 3, 1, 0, 0, nq'|てんきや|', nq'|Tenkiya|', nq'|Météo|', nq'|Prognose|', nq'|Previsioni|', nq'|Predicción|', nq'|기분파|', nq'|Gibunpa|', nq'|陰晴不定 / 阴晴不定|', nq'|Yīnqíng Bùdìng / Yāmchìhng Bātdihng|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 60, 'Sticky Hold', q'|Items held by the Pokémon are stuck fast and cannot be removed by other Pokémon.|', 3, 0, 8, 0, nq'|ねんちゃく|', nq'|Nenchaku|', nq'|Glue|', nq'|Wertehalter|', nq'|Antifurto|', nq'|Viscosidad|', nq'|점착|', nq'|Jeomchak|', nq'|黏著 / 黏着|', nq'|Niánzhuó / Nìhmjeuhk|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 61, 'Shed Skin', q'|The Pokémon may heal its own status conditions by shedding its skin.|', 3, 11, 5, 0, nq'|だっぴ|', nq'|Dappi|', nq'|Mue|', nq'|Expidermis|', nq'|Muta|', nq'|Mudar|', nq'|탈피|', nq'|Talpi|', nq'|蛻皮 / 蜕皮|', nq'|Tuìpí / Teuipèih|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 62, 'Guts', q'|It's so gutsy that having a status condition boosts the Pokémon's Attack stat.|', 3, 3, 14, 4, nq'|こんじょう|', nq'|Konjō|', nq'|Cran|', nq'|Adrenalin|', nq'|Dentistretti|', nq'|Agallas|', nq'|근성|', nq'|Geunseong|', nq'|毅力|', nq'|Yìlì / Ngaihlihk|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 63, 'Marvel Scale', q'|The Pokémon's marvelous scales boost the Defense stat if it has a status condition.|', 3, 0, 1, 2, nq'|ふしぎなうろこ|', nq'|Fushigi na Uroko|', nq'|Écaille Spéciale*|', nq'|Notschutz|', nq'|Pelledura|', nq'|Escama Especial*|', nq'|이상한 비늘|', nq'|Isanghan Bineul|', nq'|神奇鱗片 / 神奇鳞片|', nq'|Shénqí Línpiàn / Sàhnkèih Lèuhnpin|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 64, 'Liquid Ooze', q'|Oozed liquid has strong stench, which damages attackers using any draining move.|', 3, 0, 4, 0, nq'|ヘドロえき|', nq'|Hedoro Eki|', nq'|Suintement|', nq'|Kloakensoße|', nq'|Melma|', nq'|Lodo Líquido|', nq'|해감액|', nq'|Haegam Aek|', nq'|污泥漿 / 污泥浆|', nq'|Wūní Jiāng / Wūnàih Jēung|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 65, 'Overgrow', q'|Powers up Grass-type moves when the Pokémon's HP is low.|', 3, 21, 0, 2, nq'|しんりょく|', nq'|Shinryoku|', nq'|Engrais|', nq'|Notdünger|', nq'|Erbaiuto|', nq'|Espesura|', nq'|심록|', nq'|Simrok|', nq'|茂盛|', nq'|Màoshèng / Mauhsihng|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 66, 'Blaze', q'|Powers up Fire-type moves when the Pokémon's HP is low.|', 3, 21, 0, 2, nq'|もうか|', nq'|Mōka|', nq'|Brasier|', nq'|Großbrand|', nq'|Aiutofuoco|', nq'|Mar Llamas|', nq'|맹화|', nq'|Menghwa|', nq'|猛火|', nq'|Měnghuǒ / Máahngfó|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 67, 'Torrent', q'|Powers up Water-type moves when the Pokémon's HP is low.|', 3, 21, 0, 2, nq'|げきりゅう|', nq'|Gekiryū|', nq'|Torrent|', nq'|Sturzbach|', nq'|Acquaiuto|', nq'|Torrente|', nq'|급류|', nq'|Geupryu|', nq'|激流|', nq'|Jīliú / Gīklàuh|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 68, 'Swarm', q'|Powers up Bug-type moves when the Pokémon's HP is low.|', 3, 5, 16, 4, nq'|むしのしらせ|', nq'|Mushi no Shirase|', nq'|Essaim|', nq'|Hexaplaga|', nq'|Aiutinsetto|', nq'|Enjambre|', nq'|벌레의 알림|', nq'|Beolle-yi Allim|', nq'|蟲之預感 / 虫之预感|', nq'|Chóng-zhī Yùgǎn / Chùhng-jī Yuhgám|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 69, 'Rock Head', q'|Protects the Pokémon from recoil damage.|', 3, 2, 17, 2, nq'|いしあたま|', nq'|Ishi Atama|', nq'|Tête de Roc|', nq'|Steinhaupt|', nq'|Testadura|', nq'|Cabeza Roca|', nq'|돌머리|', nq'|Dol Meori|', nq'|堅硬腦袋 / 坚硬脑袋|', nq'|Jiānyìng Nǎodai / Gīnngaahng Nóuhdói|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 70, 'Drought', q'|Turns the sunlight harsh when the Pokémon enters a battle.|', 3, 2, 1, 2, nq'|ひでり|', nq'|Hideri|', nq'|Sécheresse|', nq'|Dürre|', nq'|Siccità|', nq'|Sequía|', nq'|가뭄|', nq'|Gamum|', nq'|日照|', nq'|Rìzhào / Yahtjiu|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 71, 'Arena Trap', q'|Prevents opposing Pokémon from fleeing.|', 3, 0, 3, 0, nq'|ありじごく|', nq'|Ariji Goku|', nq'|Piège Sable*|', nq'|Ausweglos|', nq'|Trappoarena|', nq'|Trampa Arena|', nq'|개미지옥|', nq'|Gaemi Jiok|', nq'|沙穴|', nq'|Shāxué / Sāyuht|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 72, 'Vital Spirit', q'|The Pokémon is full of vitality, and that prevents it from falling asleep.|', 3, 1, 6, 7, nq'|やるき|', nq'|Yaruki|', nq'|Esprit Vital|', nq'|Munterkeit|', nq'|Spiritovivo|', nq'|Espíritu Vital*|', nq'|의기양양|', nq'|Yigiyang'yang|', nq'|幹勁 / 干劲|', nq'|Gànjìng / Gongihng|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 73, 'White Smoke', q'|The Pokémon is protected by its white smoke, which prevents other Pokémon from lowering its stats.|', 3, 0, 1, 1, nq'|しろいけむり|', nq'|Shiroi Kemuri|', nq'|Écran Fumée|', nq'|Pulverrauch|', nq'|Fumochiaro|', nq'|Humo Blanco|', nq'|하얀연기|', nq'|Hayan Yeongi|', nq'|白色煙霧 / 白色烟雾|', nq'|Báisè Yānwù / Baahksīk Yīnmouh|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 74, 'Pure Power', q'|Using its pure power, the Pokémon doubles its Attack stat.|', 3, 2, 0, 0, nq'|ヨガパワー|', nq'|Yoga Pawā|', nq'|Force Pure|', nq'|Mentalkraft|', nq'|Forzapura|', nq'|Energía pura|', nq'|순수한힘|', nq'|Sunsuhan Him|', nq'|瑜伽之力|', nq'|Yújiā-zhī Lì / Yùhgā-jī Lihk|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 75, 'Shell Armor', q'|A hard shell protects the Pokémon from critical hits.|', 3, 3, 13, 7, nq'|シェルアーマー|', nq'|Sheru Āmā|', nq'|Coque Armure|', nq'|Panzerhaut|', nq'|Guscioscudo|', nq'|Caparazón|', nq'|조가비 갑옷|', nq'|Jogabi Gab'ot|', nq'|硬殼盔甲 / 硬壳盔甲|', nq'|Yìngké Kuījiǎ / Ngaahnghok Kwāigaap|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 76, 'Air Lock', q'|Eliminates the effects of weather.|', 3, 1, 0, 0, nq'|エアロック|', nq'|Ea Rokku|', nq'|Air Lock|', nq'|Klimaschutz|', nq'|Riparo|', nq'|Bucle Aire|', nq'|에어록|', nq'|Air-Lock|', nq'|氣閘 / 气闸|', nq'|Qì Zhá / Hei Jaahp|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 77, 'Tangled Feet', q'|Raises evasion if the Pokémon is confused.|', 4, 0, 5, 2, nq'|ちどりあし|', nq'|Chidori Ashi|', nq'|Pieds Confus|', nq'|Fußangel|', nq'|Intricopiedi|', nq'|Tumbos|', nq'|갈지자걸음|', nq'|Galjija Geor'eum|', nq'|蹣跚 / 蹒跚|', nq'|Pánshān / Pùhnsāan|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 78, 'Motor Drive', q'|Boosts its Speed stat if hit by an Electric-type move, instead of taking damage.|', 4, 1, 2, 1, nq'|でんきエンジン|', nq'|Denki Engine|', nq'|Motorisé|', nq'|Starthilfe|', nq'|Elettrorapid|', nq'|Electromotor|', nq'|전기엔진|', nq'|Jeongi Engine|', nq'|電氣引擎 / 电气引擎|', nq'|Diànqì Yǐnqíng / Dihnhei Yáhnkìhng|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 79, 'Rivalry', q'|Becomes competitive and deals more damage to Pokémon of the same gender, but deals less to Pokémon of the opposite gender.|', 4, 0, 14, 4, nq'|とうそうしん|', nq'|Tōsōshin|', nq'|Rivalité|', nq'|Rivalität|', nq'|Antagonismo|', nq'|Rivalidad|', nq'|투쟁심|', nq'|Tujaengsim|', nq'|鬥爭心 / 斗争心|', nq'|Dòuzhēng Xīn / Daujāng Sām|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 80, 'Steadfast', q'|The Pokémon's determination boosts the Speed stat each time the Pokémon flinches.|', 4, 2, 3, 7, nq'|ふくつのこころ|', nq'|Fukutsu no Kokoro|', nq'|Impassible|', nq'|Felsenfest|', nq'|Cuordeciso|', nq'|Impasible|', nq'|불굴의 마음|', nq'|Bulgul-yi Ma'eum|', nq'|不屈之心|', nq'|Bùqū-zhī Xīn / Bātwāt-jī Sām|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 81, 'Snow Cloak', q'|Boosts evasion in a hailstorm.|', 4, 6, 7, 1, nq'|ゆきがくれ|', nq'|Yukigakure|', nq'|Rideau Neige|', nq'|Schneemantel|', nq'|Mantelneve|', nq'|Manto Níveo|', nq'|눈숨기|', nq'|Nun Sumgi|', nq'|雪隱 / 雪隐|', nq'|Xuěyǐn / Syutyán|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 82, 'Gluttony', q'|Makes the Pokémon eat a held Berry when its HP drops to half or less, which is sooner than usual.|', 4, 6, 8, 9, nq'|くいしんぼう|', nq'|Kuishinbō|', nq'|Gloutonnerie|', nq'|Völlerei|', nq'|Voracità|', nq'|Gula|', nq'|먹보|', nq'|Meokbo|', nq'|貪吃鬼 / 贪吃鬼|', nq'|Tānchīguǐ / Tāamhekgwái|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 83, 'Anger Point', q'|The Pokémon is angered when it takes a critical hit, and that maxes its Attack stat.|', 4, 0, 3, 6, nq'|いかりのつぼ|', nq'|Ikari no Tsubo|', nq'|Colérique|', nq'|Kurzschluss|', nq'|Grancollera|', nq'|Irascible|', nq'|분노의 경혈|', nq'|Bunno-yi Gyeonghyeol|', nq'|憤怒穴位 / 愤怒穴位|', nq'|Fènnù Xuèwèi / Fáhnnouh Yuhtwái|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 84, 'Unburden', q'|Boosts the Speed stat if the Pokémon's held item is used or lost.|', 4, 0, 5, 7, nq'|かるわざ|', nq'|Karuwaza|', nq'|Délestage|', nq'|Entlastung|', nq'|Agiltecnica|', nq'|Liviano|', nq'|곡예|', nq'|Gok'ye|', nq'|輕裝 / 轻装|', nq'|Qīngzhuāng / Hīngjōng|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 85, 'Heatproof', q'|The heatproof body of the Pokémon halves the damage from Fire-type moves that hit it.|', 4, 0, 2, 0, nq'|たいねつ|', nq'|Tainetsu|', nq'|Ignifugé|', nq'|Hitzeschutz|', nq'|Antifuoco|', nq'|Ignífugo|', nq'|내열|', nq'|Naeyeol|', nq'|耐熱 / 耐热|', nq'|Nàirè / Noihyiht|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 86, 'Simple', q'|The stat changes the Pokémon receives are doubled.|', 4, 0, 3, 2, nq'|たんじゅん|', nq'|Tanjun|', nq'|Simple|', nq'|Wankelmut|', nq'|Disinvoltura|', nq'|Simple|', nq'|단순|', nq'|Dansun|', nq'|單純 / 单纯|', nq'|Dānchún / Dāansèuhn|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 87, 'Dry Skin', q'|Restores HP in rain or when hit by Water-type moves. Reduces HP in sunshine, and increases the damage received from Fire-type moves.|', 4, 0, 6, 1, nq'|かんそうはだ|', nq'|Kansō Hada|', nq'|Peau Sèche|', nq'|Trockenheit|', nq'|Pellearsa|', nq'|Piel Seca|', nq'|건조피부|', nq'|Geonjo Pibu|', nq'|乾燥皮膚 / 干燥皮肤|', nq'|Gānzào Pífū / Gōnchou Pèihfū|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 88, 'Download', q'|Compares an opposing Pokémon's Defense and Sp. Def stats before raising its own Attack or Sp. Atk stat—whichever will be more effective.|', 4, 1, 3, 0, nq'|ダウンロード|', nq'|Download|', nq'|Télécharge|', nq'|Download|', nq'|Download|', nq'|Descarga|', nq'|다운로드|', nq'|Download|', nq'|下載 / 下载|', nq'|Xiàzài / Hahjoi|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 89, 'Iron Fist', q'|Powers up punching moves.|', 4, 0, 7, 7, nq'|てつのこぶし|', nq'|Tetsu no Kobushi|', nq'|Poing de Fer|', nq'|Eisenfaust|', nq'|Ferropugno|', nq'|Puño Férreo|', nq'|철주먹|', nq'|Cheol Jumeok|', nq'|鐵拳 / 铁拳|', nq'|Tiěquán / Titkyùhn|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 90, 'Poison Heal', q'|Restores HP if the Pokémon is poisoned, instead of losing HP.|', 4, 0, 2, 1, nq'|ポイズンヒール|', nq'|Poison Heal|', nq'|Soin Poison|', nq'|Aufheber|', nq'|Velencura|', nq'|Antídoto|', nq'|포이즌힐|', nq'|Poison Heal|', nq'|毒療 / 毒疗|', nq'|Dúliáo / Duhklìuh|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 91, 'Adaptability', q'|Powers up moves of the same type as the Pokémon.|', 4, 2, 4, 7, nq'|てきおうりょく|', nq'|Tekiō Ryoku|', nq'|Adaptabilité|', nq'|Anpassung|', nq'|Adattabilità|', nq'|Adaptable|', nq'|적응력|', nq'|Jeok'eungryeok|', nq'|適應力 / 适应力|', nq'|Shìyìng Lì / Sīkying Lihk|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 92, 'Skill Link', q'|Maximizes the number of times multi-strike moves hit.|', 4, 1, 5, 4, nq'|スキルリンク|', nq'|Skill Link|', nq'|Multi-Coups|', nq'|Wertelink|', nq'|Abillegame|', nq'|Encadenado|', nq'|스킬링크|', nq'|Skill Link|', nq'|連續攻擊 / 连续攻击|', nq'|Liánxù Gōngjí / Lìhnjuhk Gūnggīk|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 93, 'Hydration', q'|Heals status conditions if it's raining.|', 4, 2, 11, 9, nq'|うるおいボディ|', nq'|Uruoi Body|', nq'|Hydratation|', nq'|Hydration|', nq'|Idratazione|', nq'|Hidratación|', nq'|촉촉바디|', nq'|Chokchok Body|', nq'|濕潤之軀 / 湿润之躯|', nq'|Shīrùn-zhī Qū / Sāpyeuhn-jī Kēui|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 94, 'Solar Power', q'|Boosts the Sp. Atk stat in sunny weather, but HP decreases every turn.|', 4, 1, 3, 5, nq'|サンパワー|', nq'|Sun Power|', nq'|Force Soleil|', nq'|Solarkraft|', nq'|Solarpotere|', nq'|Poder Solar|', nq'|선파워|', nq'|Sun Power|', nq'|太陽之力 / 太阳之力|', nq'|Tàiyáng-zhī Lì / Taaiyèuhng-jī Lihk|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 95, 'Quick Feet', q'|Boosts the Speed stat if the Pokémon has a status condition.|', 4, 0, 5, 4, nq'|はやあし|', nq'|Haya'ashi|', nq'|Pied Véloce|', nq'|Rasanz|', nq'|Piedisvelti|', nq'|Pies Rápidos|', nq'|속보|', nq'|Sokbo|', nq'|飛毛腿 / 飞毛腿|', nq'|Fēimáotuǐ / Fēimòuhtéui|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 96, 'Normalize', q'|All the Pokémon's moves become Normal type. The power of those moves is boosted a little.|', 4, 0, 2, 0, nq'|ノーマルスキン|', nq'|Normal Skin|', nq'|Normalise|', nq'|Regulierung|', nq'|Normalità|', nq'|Normalidad|', nq'|노말스킨|', nq'|Normal Skin|', nq'|一般皮膚 / 一般皮肤|', nq'|Yībān Pífū / Yātbūn Pèihfū|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 97, 'Sniper', q'|Powers up moves if they become critical hits when attacking.|', 4, 0, 9, 5, nq'|スナイパー|', nq'|Sniper|', nq'|Sniper|', nq'|Superschütze|', nq'|Cecchino|', nq'|Francotirador*|', nq'|스나이퍼|', nq'|Sniper|', nq'|狙擊手 / 狙击手|', nq'|Jūjíshǒu / Jēuigīksáu|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 98, 'Magic Guard', q'|The Pokémon only takes damage from attacks.|', 4, 0, 7, 3, nq'|マジックガード|', nq'|Magic Guard|', nq'|Garde Magik|', nq'|Magieschild|', nq'|Magicscudo|', nq'|Muro Mágico|', nq'|매직가드|', nq'|Magic Guard|', nq'|魔法防守|', nq'|Mófǎ Fángshǒu / Mōfaat Fòhngsáu|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 99, 'No Guard', q'|The Pokémon employs no-guard tactics to ensure incoming and outgoing attacks always land.|', 4, 3, 3, 4, nq'|ノーガード|', nq'|No Guard|', nq'|Annule Garde|', nq'|Schildlos|', nq'|Nullodifesa|', nq'|Indefenso|', nq'|노가드|', nq'|No Guard|', nq'|無防守 / 无防守|', nq'|Wú Fángshǒu / Mòuh Fòhngsáu|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 100, 'Stall', q'|The Pokémon moves after all other Pokémon do.|', 4, 0, 1, 0, nq'|あとだし|', nq'|Atodashi|', nq'|Frein|', nq'|Zeitspiel|', nq'|Rallentatore|', nq'|Rezagado|', nq'|시간벌기|', nq'|Sigan Beolgi|', nq'|慢出|', nq'|Mànchū / Maahnchēut|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 101, 'Technician', q'|Powers up the Pokémon's weaker moves.|', 4, 2, 11, 5, nq'|テクニシャン|', nq'|Technician|', nq'|Technicien|', nq'|Techniker|', nq'|Tecnico|', nq'|Experto|', nq'|테크니션|', nq'|Technician|', nq'|技術高手 / 技术高手|', nq'|Jìshù Gāoshǒu / Geihseuht Gōusáu|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 102, 'Leaf Guard', q'|Prevents status conditions in sunny weather.|', 4, 3, 9, 7, nq'|リーフガード|', nq'|Leaf Guard|', nq'|Feuille Garde*|', nq'|Floraschild|', nq'|Fogliamanto|', nq'|Defensa Hoja|', nq'|리프가드|', nq'|Leaf Guard|', nq'|葉子防守 / 叶子防守|', nq'|Yèzi Fángshǒu / Yihpjí Fòhngsáu|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 103, 'Klutz', q'|The Pokémon can't use any held items.|', 4, 0, 8, 1, nq'|ぶきよう|', nq'|Bukiyō|', nq'|Maladresse|', nq'|Tollpatsch|', nq'|Impaccio|', nq'|Zoquete|', nq'|서투름|', nq'|Seotureum|', nq'|笨拙|', nq'|Bènzhuó / Bahnjyut|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 104, 'Mold Breaker', q'|Moves can be used on the target regardless of its Abilities.|', 4, 4, 6, 8, nq'|かたやぶり|', nq'|Katayaburi|', nq'|Brise Moule|', nq'|Überbrückung|', nq'|Rompiforma|', nq'|Rompemoldes|', nq'|틀깨기|', nq'|Teulkkaegi|', nq'|破格|', nq'|Pògé / Pogaak|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 105, 'Super Luck', q'|The Pokémon is so lucky that the critical-hit ratios of its moves are boosted.|', 4, 0, 6, 3, nq'|きょううん|', nq'|Kyōun|', nq'|Chanceux|', nq'|Glückspilz|', nq'|Supersorte|', nq'|Afortunado|', nq'|대운|', nq'|Dae'un|', nq'|超幸運 / 超幸运|', nq'|Chāo Xìngyùn / Chīu Hahngwahn|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 106, 'Aftermath', q'|Damages the attacker if it contacts the Pokémon with a finishing hit.|', 4, 0, 4, 4, nq'|ゆうばく|', nq'|Yūbaku|', nq'|Boom Final|', nq'|Finalschlag|', nq'|Scoppio|', nq'|Resquicio|', nq'|유폭|', nq'|Yupok|', nq'|引爆|', nq'|Yǐnbào / Yáhnbaau|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 107, 'Anticipation', q'|The Pokémon can sense an opposing Pokémon's dangerous moves.|', 4, 1, 4, 2, nq'|きけんよち|', nq'|Kiken Yochi|', nq'|Anticipation|', nq'|Vorahnung|', nq'|Presagio|', nq'|Anticipación|', nq'|위험예지|', nq'|Wiheom Yeji|', nq'|危險預知 / 危险预知|', nq'|Wéixiǎn Yùzhī / Ngàihhím Yuhjī|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 108, 'Forewarn', q'|When it enters a battle, the Pokémon can tell one of the moves an opposing Pokémon has.|', 4, 0, 6, 0, nq'|よちむ|', nq'|Yochimu|', nq'|Prédiction|', nq'|Vorwarnung|', nq'|Premonizione|', nq'|Alerta|', nq'|예지몽|', nq'|Yejimong|', nq'|預知夢 / 预知梦|', nq'|Yùzhī Mèng / Yuhjī Muhng|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 109, 'Unaware', q'|When attacking, the Pokémon ignores the target Pokémon's stat changes.|', 4, 1, 4, 4, nq'|てんねん|', nq'|Tennen|', nq'|Inconscient|', nq'|Unkenntnis|', nq'|Imprudenza|', nq'|Ignorante|', nq'|천진|', nq'|Cheonjin|', nq'|純樸 / 纯朴|', nq'|Chúnpǔ / Sèuhnpok|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 110, 'Tinted Lens', q'|The Pokémon can use "not very effective" moves to deal regular damage.|', 4, 0, 4, 5, nq'|いろめがね|', nq'|Iromegane|', nq'|Lentiteintée|', nq'|Aufwertung|', nq'|Lentifumé|', nq'|Cromolente|', nq'|색안경|', nq'|Saek'angyeong|', nq'|有色眼鏡 / 有色眼镜|', nq'|Yǒusè Yǎnjìng / Yáuhsīk Ngáahngéng|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 111, 'Filter', q'|Reduces the power of supereffective attacks taken.|', 4, 1, 2, 0, nq'|フィルター|', nq'|Filter|', nq'|Filtre|', nq'|Filter|', nq'|Filtro|', nq'|Filtro|', nq'|필터|', nq'|Filter|', nq'|過濾 / 过滤|', nq'|Guòlǜ / Gwoleuih|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 112, 'Slow Start', q'|For five turns, the Pokémon's Attack and Speed stats are halved.|', 4, 1, 0, 0, nq'|スロースタート|', nq'|Slow Start|', nq'|Début Calme|', nq'|Saumselig|', nq'|Lentoinizio|', nq'|Inicio Lento|', nq'|슬로스타트|', nq'|Slow Start|', nq'|慢啟動 / 慢启动|', nq'|Màn Qǐdòng / Maahn Káiduhng|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 113, 'Scrappy', q'|The Pokémon can hit Ghost-type Pokémon with Normal- and Fighting-type moves.|', 4, 1, 2, 8, nq'|きもったま|', nq'|Kimottama|', nq'|Querelleur|', nq'|Rauflust|', nq'|Nervisaldi|', nq'|Intrépido|', nq'|배짱|', nq'|Baejjang|', nq'|膽量 / 胆量|', nq'|Dǎnliàng / Dáamleuhng|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 114, 'Storm Drain', q'|Draws in all Water-type moves. Instead of being hit by Water-type moves, it boosts its Sp. Atk.|', 4, 0, 4, 3, nq'|よびみず|', nq'|Yobimizu|', nq'|Lavabo|', nq'|Sturmsog|', nq'|Acquascolo|', nq'|Colector|', nq'|마중물|', nq'|Majungmul|', nq'|引水|', nq'|Yǐnshuǐ / Yáhnséui|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 115, 'Ice Body', q'|The Pokémon gradually regains HP in a hailstorm.|', 4, 0, 10, 4, nq'|アイスボディ|', nq'|Ice Body|', nq'|Corps Gel|', nq'|Eishaut|', nq'|Corpogelo|', nq'|Gélido|', nq'|아이스바디|', nq'|Ice Body|', nq'|冰凍之軀 / 冰冻之躯|', nq'|Bīngdòng-zhī Qū / Bīngdung-jī Kēui|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 116, 'Solid Rock', q'|Reduces the power of supereffective attacks taken.|', 4, 0, 4, 0, nq'|ハードロック|', nq'|Hard Rock|', nq'|Solide Roc|', nq'|Felskern|', nq'|Solidroccia|', nq'|Roca Sólida|', nq'|하드록|', nq'|Hard Rock|', nq'|堅硬岩石 / 坚硬岩石|', nq'|Jiānyìng Yánshí / Gīnngaahng Ngàahmsehk|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 117, 'Snow Warning', q'|The Pokémon summons a hailstorm when it enters a battle.|', 4, 2, 1, 4, nq'|ゆきふらし|', nq'|Yuki Furashi|', nq'|Alerte Neige|', nq'|Hagelalarm|', nq'|Scendineve|', nq'|Nevada|', nq'|눈퍼뜨리기|', nq'|Nun Peotteurigi|', nq'|降雪|', nq'|Jiàngxuě / Gongsyut|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 118, 'Honey Gather', q'|The Pokémon may gather Honey after a battle.|', 4, 1, 2, 1, nq'|みつあつめ|', nq'|Mitsu Atsume|', nq'|Cherche Miel|', nq'|Honigmaul|', nq'|Mielincetta|', nq'|Recogemiel|', nq'|꿀모으기|', nq'|Kkul Moeugi|', nq'|採蜜 / 采蜜|', nq'|Cǎimì / Chóimaht|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 119, 'Frisk', q'|When it enters a battle, the Pokémon can check an opposing Pokémon's held item.|', 4, 1, 12, 8, nq'|おみとおし|', nq'|Omitooshi|', nq'|Fouille|', nq'|Schnüffler|', nq'|Indagine|', nq'|Cacheo|', nq'|통찰|', nq'|Tongchal|', nq'|察覺 / 察觉|', nq'|Chájué / Chaatgok|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 120, 'Reckless', q'|Powers up moves that have recoil damage.|', 4, 0, 3, 9, nq'|すてみ|', nq'|Sutemi|', nq'|Téméraire|', nq'|Achtlos|', nq'|Temerarietà|', nq'|Audaz|', nq'|이판사판|', nq'|Ipansapan|', nq'|捨身 / 舍身|', nq'|Shěshēn / Sésān|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 121, 'Multitype', q'|Changes the Pokémon's type to match the Plate or Z-Crystal it holds.|', 4, 1, 0, 0, nq'|マルチタイプ|', nq'|Multitype|', nq'|Multitype|', nq'|Variabilität|', nq'|Multitipo|', nq'|Multitipo|', nq'|멀티타입|', nq'|Multi-Type|', nq'|多屬性 / 多属性|', nq'|Duō Shǔxìng / Dō Suhksing|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 122, 'Flower Gift', q'|Boosts the Attack and Sp. Def stats of itself and allies when it is sunny.|', 4, 1, 0, 0, nq'|フラワーギフト|', nq'|Flower Gift|', nq'|Don Floral|', nq'|Pflanzengabe|', nq'|Regalfiore|', nq'|Don Floral|', nq'|플라워기프트|', nq'|Flower Gift|', nq'|花之禮 / 花之礼|', nq'|Huā-zhī Lǐ / Fā-jī Láih|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 123, 'Bad Dreams', q'|Reduces the HP of sleeping opposing Pokémon.|', 4, 1, 0, 0, nq'|ナイトメア|', nq'|Nightmare|', nq'|Mauvais Rêve|', nq'|Alptraum|', nq'|Sogniamari|', nq'|Mal Sueño|', nq'|나이트메어|', nq'|Nightmare|', nq'|夢魘 / 梦魇|', nq'|Mèngyǎn / Muhngyím|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 124, 'Pickpocket', q'|Steals an item from an attacker that made direct contact.|', 5, 0, 0, 7, nq'|わるいてぐせ|', nq'|Waruite Guse|', nq'|Pickpocket|', nq'|Langfinger|', nq'|Arraffalesto|', nq'|Hurto|', nq'|나쁜손버릇|', nq'|Nappeun Sonbeoreut|', nq'|順手牽羊 / 顺手牵羊|', nq'|Shùnshǒuqiānyáng / Seuhnsáuhīnyèuhng|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 125, 'Sheer Force', q'|Removes additional effects to increase the power of moves when attacking.|', 5, 2, 6, 18, nq'|ちからずく|', nq'|Chikara Zuku|', nq'|Sans Limite|', nq'|Rohe Gewalt|', nq'|Forzabruta|', nq'|Potencia Bruta*|', nq'|우격다짐|', nq'|Ugyeokdajim|', nq'|強行 / 强行|', nq'|Qiángxíng / Kéuhnghàhng|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 126, 'Contrary', q'|Makes stat changes have an opposite effect.|', 5, 0, 2, 7, nq'|あまのじゃく|', nq'|Ama no Jaku|', nq'|Contestation|', nq'|Umkehrung|', nq'|Inversione|', nq'|Respondón|', nq'|심술꾸러기|', nq'|Simsul Kkureogi|', nq'|唱反調 / 唱反调|', nq'|Chàngfǎndiào / Cheungfáandiuh|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 127, 'Unnerve', q'|Unnerves opposing Pokémon and makes them unable to eat Berries.|', 5, 0, 4, 16, nq'|きんちょうかん|', nq'|Kinchōkan|', nq'|Tension|', nq'|Anspannung|', nq'|Agitazione|', nq'|Nerviosismo|', nq'|긴장감|', nq'|Ginjanggam|', nq'|緊張感 / 紧张感|', nq'|Jǐnzhāng Gǎn / Gánjēung Gám|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 128, 'Defiant', q'|Boosts the Pokémon's Attack stat sharply when its stats are lowered.|', 5, 0, 2, 11, nq'|まけんき|', nq'|Makenki|', nq'|Acharné|', nq'|Siegeswille|', nq'|Agonismo|', nq'|Competitivo|', nq'|오기|', nq'|Ogi|', nq'|不服輸 / 不服输|', nq'|Bù Fúshū / Bāt Fuhksyū|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 129, 'Defeatist', q'|Halves the Pokémon's Attack and Sp. Atk stats when its HP becomes half or less.|', 5, 2, 0, 0, nq'|よわき|', nq'|Yowaki|', nq'|Défaitiste|', nq'|Schwächling|', nq'|Sconforto|', nq'|Flaqueza|', nq'|무기력|', nq'|Mugiryeok|', nq'|軟弱 / 软弱|', nq'|Ruǎnruò / Yúhnyeuhk|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 130, 'Cursed Body', q'|May disable a move used on the Pokémon.|', 5, 1, 3, 3, nq'|のろわれボディ|', nq'|Noroware Body|', nq'|Corps Maudit|', nq'|Tastfluch|', nq'|Corpofunesto|', nq'|Cuerpo Maldito*|', nq'|저주받은바디|', nq'|Jeojubad-eun Body|', nq'|詛咒之軀 / 诅咒之躯|', nq'|Zǔzhòu-zhī Qū / Jojau-jī Kēui|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 131, 'Healer', q'|Sometimes heals an ally's status condition.|', 5, 3, 2, 3, nq'|いやしのこころ|', nq'|Iyashi no Kokoro|', nq'|Cœur Soin|', nq'|Heilherz|', nq'|Curacuore|', nq'|Alma Cura|', nq'|치유의마음|', nq'|Chiyu-yi Ma'eum|', nq'|治癒之心 / 治愈之心|', nq'|Zhìyù-zhī Xīn / Jihyuh-jī Sām|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 132, 'Friend Guard', q'|Reduces damage done to allies.|', 5, 0, 0, 8, nq'|フレンドガード|', nq'|Friend Guard|', nq'|Garde Amie|', nq'|Freundeshut|', nq'|Amicoscudo|', nq'|Compiescolta|', nq'|프렌드가드|', nq'|Friend Guard|', nq'|友情防守|', nq'|Yǒuqíng Fángshǒu / Yáuhchìhng Fòhngsáu|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 133, 'Weak Armor', q'|Physical attacks to the Pokémon lower its Defense stat but sharply raise its Speed stat.|', 5, 0, 3, 15, nq'|くだけるよろい|', nq'|Kudakeru Yoroi|', nq'|Armurouillée|', nq'|Bruchrüstung|', nq'|Sottilguscio|', nq'|Armadura Frágil*|', nq'|깨어진갑옷|', nq'|Kkaeeojin Gab'ot|', nq'|碎裂鎧甲 / 碎裂铠甲|', nq'|Suìliè Kǎijiǎ / Seuiliht Hóigaap|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 134, 'Heavy Metal', q'|Doubles the Pokémon's weight.|', 5, 0, 0, 5, nq'|ヘヴィメタル|', nq'|Heavy Metal|', nq'|Heavy Metal|', nq'|Schwermetall|', nq'|Metalpesante|', nq'|Metal Pesado*|', nq'|헤비메탈|', nq'|Heavy Metal|', nq'|重金屬 / 重金属|', nq'|Zhòngjīnshǔ / Chúhnggāmsuhk|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 135, 'Light Metal', q'|Halves the Pokémon's weight.|', 5, 0, 0, 5, nq'|ライトメタル|', nq'|Light Metal|', nq'|Light Metal|', nq'|Leichtmetall|', nq'|Metalleggero|', nq'|Metal Liviano*|', nq'|라이트메탈|', nq'|Light Metal|', nq'|輕金屬 / 轻金属|', nq'|Qīngjīnshǔ / Hīnggāmsuhk|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 136, 'Multiscale', q'|Reduces the amount of damage the Pokémon takes when its HP is full.|', 5, 0, 0, 2, nq'|マルチスケイル|', nq'|Multiscale|', nq'|Multiécaille|', nq'|Multischuppe|', nq'|Multisquame|', nq'|Compensación|', nq'|멀티스케일|', nq'|Multiscale|', nq'|多重鱗片 / 多重鳞片|', nq'|Duōchóng Línpiàn / Dōchùhng Lèuhnpin|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 137, 'Toxic Boost', q'|Powers up physical attacks when the Pokémon is poisoned.|', 5, 0, 0, 1, nq'|どくぼうそう|', nq'|Doku Bōsō|', nq'|Rage Poison|', nq'|Giftwahn|', nq'|Velenimpeto|', nq'|Ímpetu Tóxico*|', nq'|독폭주|', nq'|Dok Pokju|', nq'|中毒激升|', nq'|Zhòngdú Jīshēng / Jungduhk Gīksīng|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 138, 'Flare Boost', q'|Powers up special attacks when the Pokémon is burned.|', 5, 0, 0, 2, nq'|ねつぼうそう|', nq'|Netsu Bōsō|', nq'|Rage Brûlure|', nq'|Hitzewahn|', nq'|Bruciaimpeto|', nq'|Ímpetu Ardiente*|', nq'|열폭주|', nq'|Yeol Pokju|', nq'|受熱激升 / 受热激升|', nq'|Shòurè Jīshēng / Sauhyiht Gīksīng|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 139, 'Harvest', q'|May create another Berry after one is used.|', 5, 0, 0, 6, nq'|しゅうかく|', nq'|Shūkaku|', nq'|Récolte|', nq'|Reiche Ernte|', nq'|Coglibacche|', nq'|Cosecha|', nq'|수확|', nq'|Suhwak|', nq'|收穫 / 收获|', nq'|Shōuhuò / Sāuwohk|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 140, 'Telepathy', q'|Anticipates an ally's attack and dodges it.|', 5, 0, 3, 18, nq'|テレパシー|', nq'|Telepathy|', nq'|Télépathe|', nq'|Telepathie|', nq'|Telepatia|', nq'|Telepatía|', nq'|텔레파시|', nq'|Telepathy|', nq'|心靈感應 / 心灵感应|', nq'|Xīnlínggǎnyìng / Sāmlìhnggámying|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 141, 'Moody', q'|Raises one stat sharply and lowers another every turn.|', 5, 0, 0, 7, nq'|ムラっけ|', nq'|Murakke|', nq'|Lunatique|', nq'|Gefühlswippe|', nq'|Altalena|', nq'|Veleta|', nq'|변덕쟁이|', nq'|Byeondeokjaeng-i|', nq'|心情不定|', nq'|Xīnqíng Bùdìng / Sāmchìhng Bātdihng|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 142, 'Overcoat', q'|Protects the Pokémon from things like sand, hail, and powder.|', 5, 0, 5, 15, nq'|ぼうじん|', nq'|Bōjin|', nq'|Envelocape|', nq'|Wetterfest|', nq'|Copricapo|', nq'|Funda|', nq'|방진|', nq'|Bangjin|', nq'|防塵 / 防尘|', nq'|Fángchén / Fòhngchàhn|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 143, 'Poison Touch', q'|May poison a target when the Pokémon makes contact.|', 5, 0, 5, 4, nq'|どくしゅ|', nq'|Dokushu|', nq'|Toxitouche|', nq'|Giftgriff|', nq'|Velentocco|', nq'|Toque Tóxico|', nq'|독수|', nq'|Doksu|', nq'|毒手|', nq'|Dúshǒu / Duhksáu|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 144, 'Regenerator', q'|Restores a little HP when withdrawn from battle.|', 5, 1, 3, 15, nq'|さいせいりょく|', nq'|Saiseiryoku|', nq'|Régé-Force|', nq'|Belebekraft|', nq'|Rigenergia|', nq'|Regeneración|', nq'|재생력|', nq'|Jaesaengnyeok|', nq'|再生力|', nq'|Zàishēng Lì / Joisāng Lihk|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 145, 'Big Pecks', q'|Protects the Pokémon from Defense-lowering effects.|', 5, 1, 7, 4, nq'|はとむね|', nq'|Hato Mune|', nq'|Cœur de Coq|', nq'|Brustbieter|', nq'|Pettinfuori|', nq'|Sacapecho|', nq'|부풀린가슴|', nq'|Bupullin Gaseum|', nq'|健壯胸肌 / 健壮胸肌|', nq'|Jiànzhuàng Xiōngjī / Gihnjong Hūnggēi|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 146, 'Sand Rush', q'|Boosts the Pokémon's Speed stat in a sandstorm.|', 5, 0, 5, 2, nq'|すなかき|', nq'|Sunakaki|', nq'|Baigne Sable|', nq'|Sandscharrer|', nq'|Remasabbia|', nq'|Ímpetu Arena|', nq'|모래헤치기|', nq'|Morae Hechigi|', nq'|撥沙 / 拨沙|', nq'|Bōshā / Buhtsā|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 147, 'Wonder Skin', q'|Makes status moves more likely to miss.|', 5, 0, 1, 4, nq'|ミラクルスキン|', nq'|Miracle Skin|', nq'|Peau Miracle|', nq'|Wunderhaut|', nq'|Splendicute|', nq'|Piel Milagro|', nq'|미라클스킨|', nq'|Miracle Skin|', nq'|奇跡皮膚 / 奇迹皮肤|', nq'|Qíjī Pífū / Kèihjīk Pèihfū|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 148, 'Analytic', q'|Boosts move power when the Pokémon moves last.|', 5, 0, 0, 12, nq'|アナライズ|', nq'|Analyze|', nq'|Analyste|', nq'|Analyse|', nq'|Ponderazione|', nq'|Cálculo Final*|', nq'|애널라이즈|', nq'|Analyze|', nq'|分析|', nq'|Fēnxī / Fānsīk|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 149, 'Illusion', q'|Comes out disguised as the Pokémon in the party's last spot.|', 5, 2, 0, 0, nq'|イリュージョン|', nq'|Illusion|', nq'|Illusion|', nq'|Trugbild|', nq'|Illusione|', nq'|Ilusión|', nq'|일루전|', nq'|Illusion|', nq'|幻覺 / 幻觉|', nq'|Huànjué / Waahngok|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 150, 'Imposter', q'|The Pokémon transforms itself into the Pokémon it's facing.|', 5, 0, 0, 1, nq'|かわりもの|', nq'|Kawari Mono|', nq'|Imposteur|', nq'|Doppelgänger|', nq'|Sosia|', nq'|Impostor|', nq'|괴짜|', nq'|Goejja|', nq'|變身者 / 变身者|', nq'|Biànshēn Zhě / Binsān Jé|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 151, 'Infiltrator', q'|Passes through the opposing Pokémon's barrier, substitute, and the like and strikes.|', 5, 0, 7, 14, nq'|すりぬけ|', nq'|Surinuke|', nq'|Infiltration|', nq'|Schwebedurch|', nq'|Intrapasso|', nq'|Allanamiento|', nq'|틈새포착|', nq'|Tuemsae Pochag|', nq'|穿透|', nq'|Chuāntòu / Chyūntau|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 152, 'Mummy', q'|Contact with the Pokémon changes the attacker's Ability to Mummy.|', 5, 2, 0, 0, nq'|ミイラ|', nq'|Mīra|', nq'|Momie|', nq'|Mumie|', nq'|Mummia|', nq'|Momia|', nq'|미라|', nq'|Mira|', nq'|木乃伊|', nq'|Mùnǎiyī / Muhknáaihyī|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 153, 'Moxie', q'|The Pokémon shows moxie, and that boosts the Attack stat after knocking out any Pokémon.|', 5, 0, 5, 8, nq'|じしんかじょう|', nq'|Jishin Kajō|', nq'|Impudence|', nq'|Hochmut|', nq'|Arroganza|', nq'|Autoestima|', nq'|자기과신|', nq'|Jagigwashin|', nq'|自信過度 / 自信过度|', nq'|Zìxìn Guòdù / Jihseun Gwodouh|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 154, 'Justified', q'|Being hit by a Dark-type move boosts the Attack stat of the Pokémon, for justice.|', 5, 4, 0, 5, nq'|せいぎのこころ|', nq'|Seigi no Kokoro|', nq'|Cœur Noble|', nq'|Redlichkeit|', nq'|Giustizia|', nq'|Justiciero|', nq'|정의의마음|', nq'|Jeong'ui-yi Ma'eum|', nq'|正義之心 / 正义之心|', nq'|Zhèngyì-zhī Xīn / Jingyih-jī Sām|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 155, 'Rattled', q'|Dark-, Ghost-, and Bug-type moves scare the Pokémon and boost its Speed stat.|', 5, 0, 0, 13, nq'|びびり|', nq'|Bibiri|', nq'|Phobique|', nq'|Hasenfuß|', nq'|Paura|', nq'|Cobardía|', nq'|주눅|', nq'|Junuk|', nq'|膽怯 / 胆怯|', nq'|Dǎnqiè / Dáamhip|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 156, 'Magic Bounce', q'|Reflects status moves, instead of getting hit by them.|', 5, 3, 0, 3, nq'|マジックミラー|', nq'|Magic Mirror|', nq'|Miroir Magik|', nq'|Magiespiegel|', nq'|Magispecchio|', nq'|Espejo Mágico*|', nq'|매직미러|', nq'|Magic Mirror|', nq'|魔法鏡 / 魔法镜|', nq'|Mófǎ Jìng / Mōfaat Geng|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 157, 'Sap Sipper', q'|Boosts the Attack stat if hit by a Grass-type move, instead of taking damage.|', 5, 2, 7, 8, nq'|そうしょく|', nq'|Sōshoku|', nq'|Herbivore|', nq'|Vegetarier|', nq'|Mangiaerba|', nq'|Herbívoro|', nq'|초식|', nq'|Chosik|', nq'|食草|', nq'|Shícǎo / Sihkchóu|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 158, 'Prankster', q'|Gives priority to a status move.|', 5, 4, 2, 8, nq'|いたずらごころ|', nq'|Itazura-gokoro|', nq'|Farceur|', nq'|Strolch|', nq'|Burla|', nq'|Bromista|', nq'|짓궂은마음|', nq'|Jitguch-eun Ma'eum|', nq'|惡作劇之心 / 恶作剧之心|', nq'|Èzuòjù-zhī Xīn / Okjokkehk-jī Sām|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 159, 'Sand Force', q'|Boosts the power of Rock-, Ground-, and Steel-type moves in a sandstorm.|', 5, 3, 2, 13, nq'|すなのちから|', nq'|Suna no Chikara|', nq'|Force Sable|', nq'|Sandgewalt|', nq'|Silicoforza|', nq'|Poder Arena|', nq'|모래의힘|', nq'|Morae-yi Him|', nq'|沙之力|', nq'|Shā-zhī Lì / Sā-jī Lihk|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 160, 'Iron Barbs', q'|Inflicts damage to the attacker on contact with iron barbs.|', 5, 2, 1, 0, nq'|てつのトゲ|', nq'|Tetsu no Toge|', nq'|Épine de Fer|', nq'|Eisenstachel|', nq'|Spineferrate|', nq'|Punta Acero|', nq'|철가시|', nq'|Cheol Gasi|', nq'|鐵刺 / 铁刺|', nq'|Tiěcì / Titchi|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 161, 'Zen Mode', q'|Changes the Pokémon's shape when HP is half or less.|', 5, 0, 0, 1, nq'|ダルマモード|', nq'|Daruma Mode|', nq'|Mode Transe|', nq'|Trance-Modus|', nq'|Stato Zen|', nq'|Modo Daruma|', nq'|달마모드|', nq'|Dalma Mode|', nq'|達摩模式 / 达摩模式|', nq'|Dámó Móshì / Daahtmō Mòuhsīk|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 162, 'Victory Star', q'|Boosts the accuracy of its allies and itself.|', 5, 1, 0, 0, nq'|しょうりのほし|', nq'|Shōri no Hoshi|', nq'|Victorieux|', nq'|Triumphstern|', nq'|Vittorstella|', nq'|Tinovictoria|', nq'|승리의별|', nq'|Seungni-yi Beol|', nq'|勝利之星 / 胜利之星|', nq'|Shènglì-zhī Xīng / Singleih-jī Sīng|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 163, 'Turboblaze', q'|Moves can be used on the target regardless of its Abilities.|', 5, 2, 0, 0, nq'|ターボブレイズ|', nq'|Turboblaze|', nq'|TurboBrasier|', nq'|Turbobrand|', nq'|Piroturbina|', nq'|Turbollama|', nq'|터보블레이즈|', nq'|Turboblaze|', nq'|渦輪火焰 / 涡轮火焰|', nq'|Wōlún Huǒyàn / Wōlèuhn Fóyihm|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 164, 'Teravolt', q'|Moves can be used on the target regardless of its Abilities.|', 5, 2, 0, 0, nq'|テラボルテージ|', nq'|Teravoltage|', nq'|Téra-Voltage|', nq'|Teravolt|', nq'|Teravolt|', nq'|Terravoltaje|', nq'|테라볼티지|', nq'|Teravoltage|', nq'|兆級電壓 / 兆级电压|', nq'|Zhàojí Diànyā / Siuhkāp Dihnaat|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 165, 'Aroma Veil', q'|Protects itself and its allies from attacks that limit their move choices.|', 6, 0, 0, 2, nq'|アロマベール|', nq'|Aroma Veil|', nq'|Aroma-Voile|', nq'|Dufthülle|', nq'|Aromavelo|', nq'|Velo Aroma|', nq'|아로마베일|', nq'|Aroma Veil|', nq'|芳香幕|', nq'|Fāngxiāng Mù / Fōnghēung Mohk|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 166, 'Flower Veil', q'|Ally Grass-type Pokémon are protected from status conditions and the lowering of their stats.|', 6, 3, 1, 0, nq'|フラワーベール|', nq'|Flower Veil|', nq'|Flora-Voile|', nq'|Blütenhülle|', nq'|Fiorvelo|', nq'|Velo Flor|', nq'|플라워베일|', nq'|Flower Veil|', nq'|花幕|', nq'|Huāmù / Fāmohk|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 167, 'Cheek Pouch', q'|Restores HP as well when the Pokémon eats a Berry.|', 6, 0, 3, 0, nq'|ほおぶくろ|', nq'|Hō Bukuro|', nq'|Bajoues|', nq'|Backentaschen|', nq'|Guancegonfie|', nq'|Carrillo|', nq'|볼주머니|', nq'|Boljumeoni|', nq'|頰囊 / 颊囊|', nq'|Jiánáng / Gaapnòhng|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 168, 'Protean', q'|Changes the Pokémon's type to the type of the move it's about to use.|', 6, 0, 0, 4, nq'|へんげんじざい|', nq'|Hengen Jizai|', nq'|Protéen|', nq'|Wandlungskunst|', nq'|Mutatipo|', nq'|Mutatipo|', nq'|변환자재|', nq'|Byeonhwan Jajae|', nq'|變幻自如 / 变幻自如|', nq'|Biànhuàn Zìrú / Binwaahn Jihyùh|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 169, 'Fur Coat', q'|Halves the damage from physical moves.|', 6, 1, 1, 0, nq'|ファーコート|', nq'|Fur Coat|', nq'|Toison Épaisse|', nq'|Fellkleid|', nq'|Foltopelo|', nq'|Pelaje Recio|', nq'|퍼코트|', nq'|Fur Coat|', nq'|毛皮大衣|', nq'|Máopí Dàyī / Mòuhpèih Daaihyī|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 170, 'Magician', q'|The Pokémon steals the held item of a Pokémon it hits with a move.|', 6, 1, 0, 4, nq'|マジシャン|', nq'|Magician|', nq'|Magicien|', nq'|Zauberer|', nq'|Prestigiatore|', nq'|Prestidigitador|', nq'|매지션|', nq'|Magician|', nq'|魔術師 / 魔术师|', nq'|Móshùshī / Mōseuhtsī|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 171, 'Bulletproof', q'|Protects the Pokémon from some ball and bomb moves.|', 6, 0, 3, 3, nq'|ぼうだん|', nq'|Bōdan|', nq'|Pare-Balles|', nq'|Kugelsicher|', nq'|Antiproiettile|', nq'|Antibalas|', nq'|방탄|', nq'|Bangtan|', nq'|防彈 / 防弹|', nq'|Fángdàn / Fòhngdáan|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 172, 'Competitive', q'|Boosts the Sp. Atk stat sharply when a stat is lowered.|', 6, 0, 7, 1, nq'|かちき|', nq'|Kachiki|', nq'|Battant|', nq'|Unbeugsamkeit|', nq'|Tenacia|', nq'|Tenacidad|', nq'|승기|', nq'|Seunggi|', nq'|好勝 / 好胜|', nq'|Hàoshèng / Housing|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 173, 'Strong Jaw', q'|The Pokémon's strong jaw boosts the power of its biting moves.|', 6, 3, 3, 0, nq'|がんじょうあご|', nq'|Ganjō Ago|', nq'|Prognathe|', nq'|Titankiefer|', nq'|Ferromascella|', nq'|Mandíbula Fuerte|', nq'|옹골찬턱|', nq'|Onggolchanteok|', nq'|強壯之顎 / 强壮之颚|', nq'|Qiángzhuàng-zhī È / Kèuhngjong-jī Ngohk|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 174, 'Refrigerate', q'|Normal-type moves become Ice-type moves. The power of those moves is boosted a little.|', 6, 3, 0, 0, nq'|フリーズスキン|', nq'|Freeze Skin|', nq'|Peau Gelée|', nq'|Frostschicht|', nq'|Pellegelo|', nq'|Piel Helada|', nq'|프리즈스킨|', nq'|Freeze Skin|', nq'|冰凍皮膚 / 冰冻皮肤|', nq'|Bīngdòng Pífū / Bīngdung Pèihfū|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 175, 'Sweet Veil', q'|Prevents itself and ally Pokémon from falling asleep.|', 6, 2, 0, 5, nq'|スイートベール|', nq'|Sweet Veil|', nq'|Gluco-Voile|', nq'|Zuckerhülle|', nq'|Dolcevelo|', nq'|Velo Dulce|', nq'|스위트베일|', nq'|Sweet Veil|', nq'|甜幕|', nq'|Tiánmù / Tìhmmohk|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 176, 'Stance Change', q'|The Pokémon changes its form to Blade Forme when it uses an attack move, and changes to Shield Forme when it uses King's Shield.|', 6, 1, 0, 0, nq'|バトルスイッチ|', nq'|Battle Switch|', nq'|Déclic Tactique|', nq'|Taktikwechsel|', nq'|Accendilotta|', nq'|Cambio Táctico|', nq'|배틀스위치|', nq'|Battle Switch|', nq'|戰鬥切換 / 战斗切换|', nq'|Zhàndòu Qiēhuàn / Jindau Chitwuhn|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 177, 'Gale Wings', q'|Gives priority to Flying-type moves when the Pokémon's HP is full.|', 6, 0, 0, 3, nq'|はやてのつばさ|', nq'|Hayate no Tsubasa|', nq'|Ailes Bourrasque|', nq'|Orkanschwingen|', nq'|Aliraffica|', nq'|Alas Vendaval|', nq'|질풍날개|', nq'|Jilpung Nalgae|', nq'|疾風之翼 / 疾风之翼|', nq'|Jífēng-zhī Yì / Jahtfūng-jī Yihk|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 178, 'Mega Launcher', q'|Powers up aura and pulse moves.|', 6, 3, 0, 0, nq'|メガランチャー|', nq'|Mega Launcher|', nq'|Méga Blaster|', nq'|Megawumme|', nq'|Megalancio|', nq'|Megadisparador|', nq'|메가런처|', nq'|Mega Launcher|', nq'|超級發射器 / 超级发射器|', nq'|Chāojí Fāshèqì / Chīukāp Faatsehhei|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 179, 'Grass Pelt', q'|Boosts the Pokémon's Defense stat in Grassy Terrain.|', 6, 0, 0, 2, nq'|くさのけがわ|', nq'|Grass Pelt|', nq'|Toison Herbue|', nq'|Pflanzenpelz|', nq'|Peloderba|', nq'|Manto Frondoso|', nq'|풀모피|', nq'|Pulmopi|', nq'|草之毛皮|', nq'|Cǎo-zhī Máopí / Chóu-jī Mòuhpèih|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 180, 'Symbiosis', q'|The Pokémon passes its item to an ally that has used up an item.|', 6, 0, 0, 4, nq'|きょうせい|', nq'|Kyōsei|', nq'|Symbiose|', nq'|Nutznießer|', nq'|Simbiosi|', nq'|Simbiosis|', nq'|공생|', nq'|Gongsaeng|', nq'|共生|', nq'|Gòngshēng / Guhngsāng|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 181, 'Tough Claws', q'|Powers up moves that make direct contact.|', 6, 3, 2, 0, nq'|かたいツメ|', nq'|Katai Tsume|', nq'|Griffe Dure|', nq'|Krallenwucht|', nq'|Unghiedure|', nq'|Garra Dura|', nq'|단단한 발톱|', nq'|Dandanhan Baltop|', nq'|硬爪|', nq'|Yìngzhuǎ / Ngaahngjáau|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 182, 'Pixilate', q'|Normal-type moves become Fairy-type moves. The power of those moves is boosted a little.|', 6, 2, 0, 1, nq'|フェアリースキン|', nq'|Fairy Skin|', nq'|Peau Féérique|', nq'|Feenschicht|', nq'|Pellefolletto|', nq'|Piel Feérica|', nq'|페어리스킨|', nq'|Fairy Skin|', nq'|妖精皮膚 / 妖精皮肤|', nq'|Yāojing Pífū / Yīujīng Pèihfū|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 183, 'Gooey', q'|Contact with the Pokémon lowers the attacker's Speed stat.|', 6, 0, 0, 3, nq'|ぬめぬめ|', nq'|Numenume|', nq'|Poisseux|', nq'|Viskosität|', nq'|Viscosità|', nq'|Baba|', nq'|미끈미끈|', nq'|Mikkeunmikkeun|', nq'|黏滑|', nq'|Niánhuá / Nìhmwaaht|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 184, 'Aerilate', q'|Normal-type moves become Flying-type moves. The power of those moves is boosted a little.|', 6, 2, 0, 0, nq'|スカイスキン|', nq'|Sky Skin|', nq'|Peau Céleste|', nq'|Zenithaut|', nq'|Pellecielo|', nq'|Piel Celeste|', nq'|스카이스킨|', nq'|Sky Skin|', nq'|飛行皮膚 / 飞行皮肤|', nq'|Fēixíng Pífū / Fēihàhng Pèihfū|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 185, 'Parental Bond', q'|Parent and child each attacks.|', 6, 1, 0, 0, nq'|おやこあい|', nq'|Oyako Ai|', nq'|Amour Filial|', nq'|Familienbande|', nq'|Amorefiliale|', nq'|Amor Filial|', nq'|부자유친|', nq'|Bujayuchin|', nq'|親子愛 / 亲子爱|', nq'|Qīnzǐ Ài / Chānjí Oi|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 186, 'Dark Aura', q'|Powers up each Pokémon's Dark-type moves.|', 6, 1, 0, 0, nq'|ダークオーラ|', nq'|Dark Aura|', nq'|Aura Ténébreuse|', nq'|Dunkelaura|', nq'|Auratetra|', nq'|Aura Oscura|', nq'|다크오라|', nq'|Dark Aura|', nq'|暗黑氣場 / 暗黑气场|', nq'|Ànhēi Qìchǎng / Amhāk Heichèuhng|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 187, 'Fairy Aura', q'|Powers up each Pokémon's Fairy-type moves.|', 6, 1, 0, 0, nq'|フェアリーオーラ|', nq'|Fairy Aura|', nq'|Aura Féérique|', nq'|Feenaura|', nq'|Aurafolletto|', nq'|Aura Feérica|', nq'|페어리오라|', nq'|Fairy Aura|', nq'|妖精氣場 / 妖精气场|', nq'|Yāojing Qìchǎng / Yīujīng Heichèuhng|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 188, 'Aura Break', q'|The effects of "Aura" Abilities are reversed to lower the power of affected moves.|', 6, 0, 1, 0, nq'|オーラブレイク|', nq'|Aura Break|', nq'|Aura Inversée|', nq'|Aura-Umkehr|', nq'|Frangiaura|', nq'|Rompeaura|', nq'|오라브레이크|', nq'|Aura Break|', nq'|氣場破壞 / 气场破坏|', nq'|Qìchǎng Pòhuài / Heichèuhng Powaaih|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 189, 'Primordial Sea', q'|The Pokémon changes the weather to nullify Fire-type attacks.|', 6, 1, 0, 0, nq'|はじまりのうみ|', nq'|Hajimari no Umi|', nq'|Mer Primaire|', nq'|Urmeer|', nq'|Mare Primordiale|', nq'|Mar del Albor|', nq'|시작의바다|', nq'|Sijak-ui Bada|', nq'|始源之海|', nq'|Shǐyuán-zhī Hǎi / Chíyùhn-jī Hói|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 190, 'Desolate Land', q'|The Pokémon changes the weather to nullify Water-type attacks.|', 6, 1, 0, 0, nq'|おわりのだいち|', nq'|Owari no Daichi|', nq'|Terre Finale|', nq'|Endland|', nq'|Terra Estrema|', nq'|Tierra del Ocaso|', nq'|끝의대지|', nq'|Kkeut-ui Daeji|', nq'|終結之地 / 终结之地|', nq'|Zhōngjié-zhī Dì / Jūnggit-jī Deih|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 191, 'Delta Stream', q'|The Pokémon changes the weather to eliminate all of the Flying type's weaknesses.|', 6, 1, 0, 0, nq'|デルタストリーム|', nq'|Delta Stream|', nq'|Souffle Delta|', nq'|Delta-Wind|', nq'|Flusso Delta|', nq'|Ráfaga Delta|', nq'|델타스트림|', nq'|Delta Stream|', nq'|德爾塔氣流 / 德尔塔气流|', nq'|Dé'ěrtǎ Qìliú / Dākyíhtaap Heilàuh|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 192, 'Stamina', q'|Boosts the Defense stat when hit by an attack.|', 7, 0, 2, 0, nq'|じきゅうりょく|', nq'|Jikyūryoku|', nq'|Endurance|', nq'|Zähigkeit|', nq'|Sopportazione|', nq'|Firmeza|', nq'|지구력|', nq'|Jiguryeok|', nq'|持久力|', nq'|Chíjiǔlì / Chìhgáulihk|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 193, 'Wimp Out', q'|The Pokémon cowardly switches out when its HP becomes half or less.|', 7, 1, 0, 0, nq'|にげごし|', nq'|Nigegoshi|', nq'|Escampette|', nq'|Reißaus|', nq'|Fuggifuggi|', nq'|Huida|', nq'|도망태세|', nq'|Domang Taese|', nq'|躍躍欲逃 / 跃跃欲逃|', nq'|Yuèyuèyùtáo / Yeuhkyeuhkyuhktòuh|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 194, 'Emergency Exit', q'|The Pokémon, sensing danger, switches out when its HP becomes half or less.|', 7, 1, 0, 0, nq'|ききかいひ|', nq'|Kiki Kaihi|', nq'|Repli Tactique|', nq'|Rückzug|', nq'|Passoindietro|', nq'|Retirada|', nq'|위기회피|', nq'|Wigi Hoepi|', nq'|危險迴避 / 危险回避|', nq'|Wéixiǎn Huíbì / Ngàihhím Wùihbeih|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 195, 'Water Compaction', q'|Boosts the Pokémon's Defense stat sharply when hit by a Water-type move.|', 7, 2, 0, 0, nq'|みずがため|', nq'|Mizu Gatame|', nq'|Sable Humide|', nq'|Verklumpen|', nq'|Idrorinforzo|', nq'|Hidrorrefuerzo|', nq'|꾸덕꾸덕굳기|', nq'|Kkudeok-kkudeok Gutgi|', nq'|遇水凝固|', nq'|Yù Shuǐ Nínggù / Yuh Séui Yìhnggu|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 196, 'Merciless', q'|The Pokémon's attacks become critical hits if the target is poisoned.|', 7, 0, 2, 0, nq'|ひとでなし|', nq'|Hitodenashi|', nq'|Cruauté|', nq'|Quälerei|', nq'|Spietatezza|', nq'|Ensañamiento|', nq'|무도한행동|', nq'|Mudohan Haengdong|', nq'|不仁不義 / 不仁不义|', nq'|Bùrén Bùyì / Bātyàhn Bātyih|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 197, 'Shields Down', q'|When its HP becomes half or less, the Pokémon's shell breaks and it becomes aggressive.|', 7, 1, 0, 0, nq'|リミットシールド|', nq'|Limit Shield|', nq'|Bouclier-Carcan|', nq'|Limitschild|', nq'|Scudosoglia|', nq'|Escudo Limitado|', nq'|리밋실드|', nq'|Limit Shield|', nq'|界限盾殼 / 界限盾壳|', nq'|Jièxiàn Dùnké / Gaaihaahn Téuhnhok|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 198, 'Stakeout', q'|Doubles the damage dealt to the target's replacement if the target switches out.|', 7, 0, 2, 0, nq'|はりこみ|', nq'|Harikomi|', nq'|Filature|', nq'|Beschattung|', nq'|Sorveglianza|', nq'|Vigilante|', nq'|잠복|', nq'|Chambok|', nq'|監視*|'||chr(10)||nq'|蹲守*|', nq'|Jiānshì / Gāamsih*|'||chr(10)||nq'|Dūnshǒu*|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 199, 'Water Bubble', q'|Lowers the power of Fire-type moves done to the Pokémon and prevents the Pokémon from getting a burn.|', 7, 2, 0, 0, nq'|すいほう|', nq'|Suihō|', nq'|Aquabulle|', nq'|Wasserblase|', nq'|Bolladacqua|', nq'|Pompa|', nq'|수포|', nq'|Supo|', nq'|水泡|', nq'|Shuǐpào / Séuipóuh|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 200, 'Steelworker', q'|Powers up Steel-type moves.|', 7, 1, 0, 0, nq'|はがねつかい|', nq'|Hagane Tsukai|', nq'|Expert Acier|', nq'|Stahlprofi|', nq'|Tempracciaio|', nq'|Acero Templado|', nq'|강철술사|', nq'|Gangcheolsulsa|', nq'|鋼能力者 / 钢能力者|', nq'|Gāng Nénglì Zhě / Gōng Nàhnglihk Jé|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 201, 'Berserk', q'|Boosts the Pokémon's Sp. Atk stat when it takes a hit that causes its HP to become half or less.|', 7, 0, 1, 0, nq'|ぎゃくじょう|', nq'|Gyakujō|', nq'|Dracolère|', nq'|Wutausbruch|', nq'|Furore|', nq'|Cólera|', nq'|발끈|', nq'|Balkkeun|', nq'|怒火沖天 / 怒火冲天|', nq'|Nùhuǒ Chōngtiān / Nouhfó Chūngtīn|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 202, 'Slush Rush', q'|Boosts the Pokémon's Speed stat in a hailstorm.|', 7, 0, 2, 2, nq'|ゆきかき|', nq'|Yuki Kaki|', nq'|Chasse-Neige|', nq'|Schneescharrer|', nq'|Spalaneve|', nq'|Quitanieves|', nq'|눈치우기|', nq'|Nun Chiugi|', nq'|撥雪 / 拨雪|', nq'|Bōxuě / Buhtsyut|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 203, 'Long Reach', q'|The Pokémon uses its moves without making contact with the target.|', 7, 0, 0, 3, nq'|えんかく|', nq'|Enkaku|', nq'|Longue Portée|', nq'|Langstrecke|', nq'|Distacco|', nq'|Remoto|', nq'|원격|', nq'|Wongyeok|', nq'|遠隔 / 远隔|', nq'|Yuǎngé / Yúhngaak|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 204, 'Liquid Voice', q'|All sound-based moves become Water-type moves.|', 7, 0, 0, 3, nq'|うるおいボイス|', nq'|Uruoi Voice|', nq'|Hydrata-Son|', nq'|Plätscherstimme|', nq'|Idrovoce|', nq'|Voz Fluida|', nq'|촉촉보이스|', nq'|Chokchok Voice|', nq'|濕潤之聲 / 湿润之声|', nq'|Shīrùn-zhī Shēng / Sāpyeuhn-jī Sīng|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 205, 'Triage', q'|Gives priority to a healing move.|', 7, 0, 1, 0, nq'|ヒーリングシフト|', nq'|Healing Shift|', nq'|Prioguérison|', nq'|Heilwandel|', nq'|Primacura|', nq'|Primer Auxilio|', nq'|힐링시프트|', nq'|Healing Shift|', nq'|先行治療 / 先行治疗|', nq'|Xiānxíng Zhìliáo / Sīnhàahng Jihlìuh|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 206, 'Galvanize', q'|Normal-type moves become Electric-type moves. The power of those moves is boosted a little.|', 7, 0, 0, 3, nq'|エレキスキン|', nq'|Electric Skin|', nq'|Peau Électrique|', nq'|Elektrohaut|', nq'|Pellelettro|', nq'|Piel Eléctrica|', nq'|일렉트릭스킨|', nq'|Electric Skin|', nq'|電氣皮膚 / 电气皮肤|', nq'|Diànqì Pífū / Dihnhei Pèihfū|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 207, 'Surge Surfer', q'|Doubles the Pokémon's Speed stat on Electric Terrain.|', 7, 1, 0, 0, nq'|サーフテール|', nq'|Surf Tail|', nq'|Surf Caudal|', nq'|Surf-Schweif|', nq'|Codasurf|', nq'|Cola Surf|', nq'|서핑테일|', nq'|Surfing Tail|', nq'|衝浪之尾 / 冲浪之尾|', nq'|Chōnglàng-zhī Wěi / Chūnglohng-jī Méih|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 208, 'Schooling', q'|When it has a lot of HP, the Pokémon forms a powerful school. It stops schooling when its HP is low.|', 7, 1, 0, 0, nq'|ぎょぐん|', nq'|Gyogun|', nq'|Banc|', nq'|Fischschwarm|', nq'|Banco|', nq'|Banco|', nq'|어군|', nq'|Eogun|', nq'|魚群 / 鱼群|', nq'|Yúqún / Yùhkwàhn|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 209, 'Disguise', q'|Once per battle, the shroud that covers the Pokémon can protect it from an attack.|', 7, 1, 0, 0, nq'|ばけのかわ|', nq'|Bake no Kawa|', nq'|Fantômasque|', nq'|Kostümspuk|', nq'|Fantasmanto|', nq'|Disfraz|', nq'|탈|', nq'|Tal|', nq'|畫皮 / 画皮|', nq'|Huàpí / Wahpèih|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 210, 'Battle Bond', q'|Defeating an opposing Pokémon strengthens the Pokémon's bond with its Trainer, and it becomes Ash-Greninja. Water Shuriken gets more powerful.|', 7, 1, 0, 0, nq'|きずなへんげ|', nq'|Kizuna Henge|', nq'|Synergie|', nq'|Freundschaftsakt|', nq'|Morfosintonia|', nq'|Fuerte Afecto|', nq'|유대변화|', nq'|Yudae Byeonhwa|', nq'|牽絆變身 / 牵绊变身|', nq'|Qiānbàn Biànshēn / Hīnbuhn Binsān|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 211, 'Power Construct', q'|Other Cells gather to aid when its HP becomes half or less. Then the Pokémon changes its form to Complete Forme.|', 7, 0, 1, 0, nq'|スワームチェンジ|', nq'|Swarm Change|', nq'|Rassemblement|', nq'|Scharwandel|', nq'|Sciamefusione|', nq'|Agrupamiento|', nq'|스웜체인지|', nq'|Swarm Change|', nq'|群聚變形 / 群聚变形|', nq'|Qúnjù Biànxíng / Kwàhnjeuih Binyìhng|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 212, 'Corrosion', q'|The Pokémon can poison the target even if it's a Steel or Poison type.|', 7, 2, 0, 0, nq'|ふしょく|', nq'|Fushoku|', nq'|Corrosion|', nq'|Korrosion|', nq'|Corrosione|', nq'|Corrosión|', nq'|부식|', nq'|Busig|', nq'|腐蝕 / 腐蚀|', nq'|Fǔshí / Fuhsihk|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 213, 'Comatose', q'|It's always drowsing and will never wake up. It can attack without waking up.|', 7, 1, 0, 0, nq'|ぜったいねむり|', nq'|Zettai Nemuri|', nq'|Hypersommeil|', nq'|Dauerschlaf|', nq'|Sonno Assoluto|', nq'|Letargo Perenne|', nq'|절대안깸|', nq'|Jeoldae Ankkaem|', nq'|絕對睡眠 / 绝对睡眠|', nq'|Juéduì Shuìmián / Jyuhtdeui Seuihmìhn|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 214, 'Queenly Majesty', q'|Its majesty pressures the opposing Pokémon, making it unable to attack using priority moves.|', 7, 0, 1, 0, nq'|じょおうのいげん|', nq'|Joō no Igen|', nq'|Prestance Royale|', nq'|Majestät|', nq'|Regalità|', nq'|Regia Presencia|', nq'|여왕의위엄|', nq'|Yeowang-ui Wieom|', nq'|女王的威嚴 / 女王的威严|', nq'|Nǚwáng-de Wēiyán / Néuihwòhng-dīk Wāiyìhm|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 215, 'Innards Out', q'|Damages the attacker landing the finishing hit by the amount equal to its last HP.|', 7, 1, 0, 0, nq'|とびだすなかみ|', nq'|Tobidasu Nakami|', nq'|Expuls'Organes|', nq'|Magenkrempler|', nq'|Espellinterno|', nq'|Revés|', nq'|내용물분출|', nq'|Naeyongmul Bunchul|', nq'|飛出的內在物 / 飞出的内在物|', nq'|Fēichū-de Nèizài Wù / Fēichēut-dīk Noihjoih Maht|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 216, 'Dancer', q'|When another Pokémon uses a dance move, it can use a dance move following it regardless of its Speed.|', 7, 1, 0, 0, nq'|おどりこ|', nq'|Odoriko|', nq'|Danseuse|', nq'|Tänzer|', nq'|Sincrodanza|', nq'|Pareja de Baile|', nq'|무희|', nq'|Muhui|', nq'|舞者|', nq'|Wǔzhě / Móuhjé|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 217, 'Battery', q'|Powers up ally Pokémon's special moves.|', 7, 1, 0, 0, nq'|バッテリー|', nq'|Battery|', nq'|Batterie|', nq'|Batterie|', nq'|Batteria|', nq'|Batería|', nq'|배터리|', nq'|Battery|', nq'|蓄電池 / 蓄电池|', nq'|Xùdiànchí / Chūkdihnchìh|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 218, 'Fluffy', q'|Halves the damage taken from moves that make direct contact, but doubles that of Fire-type moves.|', 7, 0, 2, 0, nq'|もふもふ|', nq'|Mofumofu|', nq'|Boule de Poils|', nq'|Flauschigkeit|', nq'|Morbidone|', nq'|Peluche|', nq'|복슬복슬|', nq'|Bokseulbokseul|', nq'|毛茸茸|', nq'|Máoróngrōng / Mòuhyùhngyùhng|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 219, 'Dazzling', q'|Surprises the opposing Pokémon, making it unable to attack using priority moves.|', 7, 0, 1, 0, nq'|ビビッドボディ|', nq'|Vivid Body|', nq'|Corps Coloré|', nq'|Buntkörper|', nq'|Corposgargiante|', nq'|Cuerpo Vívido|', nq'|비비드바디|', nq'|Vivid Body|', nq'|鮮艷之軀 / 鲜艳之躯|', nq'|Xiānyàn-zhī Qū / Sīnyihm-jī Kēui|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 220, 'Soul-Heart', q'|Boosts its Sp. Atk stat every time a Pokémon faints.|', 7, 1, 0, 0, nq'|ソウルハート|', nq'|Soul-Heart|', nq'|Animacœur|', nq'|Seelenherz|', nq'|Cuoreanima|', nq'|Coránima|', nq'|소울하트|', nq'|Soul-Heart|', nq'|魂心|', nq'|Húnxīn / Wàhnsām|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 221, 'Tangling Hair', q'|Contact with the Pokémon lowers the attacker's Speed stat.|', 7, 0, 2, 0, nq'|カーリーヘアー|', nq'|Curly Hair|', nq'|Mèche Rebelle|', nq'|Lockenkopf|', nq'|Boccolidoro|', nq'|Rizos Rebeldes|', nq'|컬리헤어|', nq'|Curly Hair|', nq'|捲髮 / 卷发|', nq'|Juǎnfà / Gyúnfaat|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 222, 'Receiver', q'|The Pokémon copies the Ability of a defeated ally.|', 7, 1, 0, 0, nq'|レシーバー|', nq'|Receiver|', nq'|Receveur|', nq'|Receiver|', nq'|Ricezione|', nq'|Receptor|', nq'|리시버|', nq'|Receiver|', nq'|接球手|', nq'|Jiēqiúshǒu / Jipkàuhsáu|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 223, 'Power of Alchemy', q'|The Pokémon copies the Ability of a defeated ally.|', 7, 0, 0, 2, nq'|かがくのちから|', nq'|Kagaku no Chikara|', nq'|Osmose|', nq'|Chemiekraft|', nq'|Forza Chimica|', nq'|Reacción Química|', nq'|과학의힘|', nq'|Gwahak-ui Him|', nq'|化學之力 / 化学之力|', nq'|Huàxué-zhī Lì / Fahohk-jī Lihk|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 224, 'Beast Boost', q'|The Pokémon boosts its most proficient stat each time it knocks out a Pokémon.|', 7, 11, 0, 0, nq'|ビーストブースト|', nq'|Beast Boost|', nq'|Boost Chimère|', nq'|Bestien-Boost|', nq'|Ultraboost|', nq'|Ultraimpulso|', nq'|비스트부스트|', nq'|Beast Boost|', nq'|異獸提升 / 异兽提升|', nq'|Yìshòu Tíshēng / Yihsau Tàihsīng|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 225, 'RKS System', q'|Changes the Pokémon's type to match the memory disc it holds.|', 7, 1, 0, 0, nq'|ＡＲシステム|', nq'|AR System|', nq'|Système Alpha|', nq'|Alpha-System|', nq'|Sistema Primevo|', nq'|Sistema Alfa|', nq'|AR시스템|', nq'|AR System|', nq'|ＡＲ系統 / ＡＲ系统|', nq'|AR Xìtǒng / AR Haihtúng|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 226, 'Electric Surge', q'|Turns the ground into Electric Terrain when the Pokémon enters a battle.|', 7, 1, 0, 0, nq'|エレキメイカー|', nq'|Electric Maker|', nq'|Créa-Élec|', nq'|Elektro-Erzeuger|', nq'|Elettrogenesi|', nq'|Electrogénesis|', nq'|일렉트릭메이커|', nq'|Electric Maker|', nq'|電氣製造者 / 电气制造者|', nq'|Diànqì Zhìzàozhě / Dihnhei Jaijouhjé|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 227, 'Psychic Surge', q'|Turns the ground into Psychic Terrain when the Pokémon enters a battle.|', 7, 1, 0, 0, nq'|サイコメイカー|', nq'|Psycho Maker|', nq'|Créa-Psy|', nq'|Psycho-Erzeuger|', nq'|Psicogenesi|', nq'|Psicogénesis|', nq'|사이코메이커|', nq'|Psycho Maker|', nq'|精神製造者 / 精神制造者|', nq'|Jīngshén Zhìzàozhě / Jīngsàhn Jaijouhjé|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 228, 'Misty Surge', q'|Turns the ground into Misty Terrain when the Pokémon enters a battle.|', 7, 1, 0, 0, nq'|ミストメイカー|', nq'|Mist Maker|', nq'|Créa-Brume|', nq'|Nebel-Erzeuger|', nq'|Nebbiogenesi|', nq'|Nebulogénesis|', nq'|미스트메이커|', nq'|Mist Maker|', nq'|薄霧製造者 / 薄雾制造者|', nq'|Bówù Zhìzàozhě / Bohkmouh Jaijouhjé|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 229, 'Grassy Surge', q'|Turns the ground into Grassy Terrain when the Pokémon enters a battle.|', 7, 1, 0, 0, nq'|グラスメイカー|', nq'|Grass Maker|', nq'|Créa-Herbe|', nq'|Gras-Erzeuger|', nq'|Erbogenesi|', nq'|Herbogénesis|', nq'|그래스메이커|', nq'|Grass Maker|', nq'|青草製造者 / 青草制造者|', nq'|Qīngcǎo Zhìzàozhě / Chēngchóu Jaijouhjé|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 230, 'Full Metal Body', q'|Prevents other Pokémon's moves or Abilities from lowering the Pokémon's stats.|', 7, 1, 0, 0, nq'|メタルプロテクト|', nq'|Metal Protect|', nq'|Métallo-Garde|', nq'|Metallprotektor|', nq'|Metalprotezione|', nq'|Guardia Metálica|', nq'|메탈프로텍트|', nq'|Metal Protect|', nq'|金屬防護 / 金属防护|', nq'|Jīnshǔ Fánghù / Gāmsuhk Fòhngwuh|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 231, 'Shadow Shield', q'|Reduces the amount of damage the Pokémon takes while its HP is full.|', 7, 1, 0, 0, nq'|ファントムガード|', nq'|Phantom Guard|', nq'|Spectro-Bouclier|', nq'|Phantomschutz|', nq'|Spettroguardia|', nq'|Guardia Espectro|', nq'|스펙터가드|', nq'|Specter Guard|', nq'|幻影防守|', nq'|Huànyǐng Fángshǒu / Waahnyíng Fòhngsáu|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 232, 'Prism Armor', q'|Reduces the power of supereffective attacks taken.|', 7, 1, 0, 0, nq'|プリズムアーマー|', nq'|Prism Armor|', nq'|Prisme-Armure|', nq'|Prismarüstung|', nq'|Scudoprisma|', nq'|Armadura Prisma|', nq'|프리즘아머|', nq'|Prism Armor|', nq'|稜鏡裝甲 / 棱镜装甲|', nq'|Léngjìng Zhuāngjiǎ / Lìhnggeng Jōnggaap|' );
insert into ABILITY( ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED )
values( 233, 'Neuroforce', q'|Powers up moves that are super effective.|', 7, 1, 0, 0, nq'|ブレインフォース|', nq'|Brain Force|', nq'|Cérébro-Force|', nq'|Zerebralmacht|', nq'|Cerebroforza|', nq'|Fuerza Cerebral|', nq'|브레인포스|', nq'|Brain Force|', nq'|腦核之力 / 脑核之力|', nq'|Nǎohé-zhī Lì / Nóuhhaht-jī Lihk|' );

----------------------------------------------------------

create table Pokemon(
NAME nvarchar2(100) not null, --Name of the Pokemon
DEX number(4,0) default on null 0 CONSTRAINT ck_DEX_PosZero check(DEX>=0), --Pokedex number of the Pokemon
DEX_SUFFIX varchar2(2 byte) CONSTRAINT ck_DEX_SUFFIX_Cap check(regexp_like(DEX_SUFFIX, '[A-Z][a-zA-Z]?')), --Dex Suffix of the Pokemon to distinguish between types
ITEM nvarchar2(100) , --The item used to get the form
CLASS varchar2(100 char) , --Discribing the form or type diffirence
LDEX number(3,0) CONSTRAINT ck_LDEX_PosZero check(LDEX>=0), --The local Pokedex number of the Pokemon
LDEX_SUFFIX varchar2(2 byte) CONSTRAINT ck_LDEX_SUFFIX_Cap check(regexp_like(ldex_suffix, '[A-Z][a-zA-Z]?')), --Local Pokedex Suffix
TYPE varchar2(30) default on null 'Normal' references TYPES(TYPE), --The first type of the Pokemon
TYPE2 varchar2(30) references TYPES(TYPE), --The second type of the Pokemon
GENDER_RATIO varchar2(7) references GENDER_RATIO(KEY), --The ratio between male and female
EGGGROUP1 varchar2(30) default on null 'Undiscovered' references eggGroups(NAME), --The first Egg Group the Pokemon Falls in
EGGGROUP2 varchar2(30) references eggGroups(NAME), --The second Egg Group the Pokemon Falls in
CYCLES number(3,0) CONSTRAINT ck_CYCLES_Pos check(CYCLES>0), --A stat that help determines egg hatching
STEPS_GEN2 number(6,0) CONSTRAINT ck_STEPS_GEN2_Pos check(STEPS_GEN2>0), --The steps to hatch the Pokemon in Gen 2
STEPS_GEN3 number(6,0) CONSTRAINT ck_STEPS_GEN3_Pos check(STEPS_GEN3>0), --The steps to hatch the Pokemon in Gen 3
STEPS_GEN4 number(6,0) CONSTRAINT ck_STEPS_GEN4_Pos check(STEPS_GEN4>0), --The steps to hatch the Pokemon in Gen 4
STEPS_GEN5 number(6,0) CONSTRAINT ck_STEPS_GEN5_Pos check(STEPS_GEN5>0), --The steps to hatch the Pokemon in Gen 5
STEPS_GEN7 number(6,0) CONSTRAINT ck_STEPS_GEN7_Pos check(STEPS_GEN7>0), --The steps to hatch the Pokemon in Gen 6
WEIGHTLBS number(6,2) CONSTRAINT ck_WEIGHTLBS_PosZero check(WEIGHTLBS>=0), --The weight of the Pokemon in pounds
WEIGHTKG number(6,2) CONSTRAINT ck_WEIGHTKG_PosZero check(WEIGHTKG>=0), --The weight of the Pokemon in kilograms
EXPERIENCE_TYPE varchar2(20) , --The rate the Pokemon earns expereence
BODY varchar2(50) references BODY(BODY), --The body classification of the Pokemon
GEN number(1,0) references GENERATION(GEN) check(gen>0), --The generation of the pokemon
CONSTRAINT un_Pokemon unique(Name, Dex, Dex_Suffix, Class), --Enforce that Name, Dex and Class are unique
CONSTRAINT ck_Type check(Type!=Type2), --Make sure that type cannot be the same
CONSTRAINT ck_Egg check(EggGroup1!=EggGroup2), --Make sure that egg groups don't duplicate
CONSTRAINT ck_Weight check(WeightKg/WeightLbs between .35 and .55), --Ensure there is no typo in weight (Soft checking)
CONSTRAINT un_Dex_Class unique(Dex, Class), --Ensure that no class has duplicates
CONSTRAINT ck_Gen2 check(Gen>2 and Steps_Gen2 is null or Gen<=2), --Ensure the Pokemon exists in the Generation
CONSTRAINT ck_Gen3 check(Gen>3 and Steps_Gen3 is null or Gen<=3), --Ensure the Pokemon exists in the Generation
CONSTRAINT ck_Gen4 check(Gen>4 and Steps_Gen4 is null or Gen<=4), --Ensure the Pokemon exists in the Generation
CONSTRAINT ck_Gen5 check(Gen>6 and Steps_Gen5 is null or Gen<=6), --Ensure the Pokemon exists in the Generation, includes Gen 5 and 6
CONSTRAINT ck_Gen7 check(Gen>7 and Steps_Gen7 is null or Gen<=7) --Ensure the Pokemon exists in the Generation
);











create or replace trigger weight_trg
before insert or update on Pokemon
for each row
begin --Ensure weight is compleat if it exists
if :new.WeightKg is null and :new.WeightLbs is not null then
:new.WeightKg:= trunc(0.45359237*:new.WeightLbs,1);
elsif :new.WeightLbs is null and :new.WeightKg is not null then
:new.WeightLbs:= trunc(2.20462262185*:new.WeightKg,1);
end if;
end;
/
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Blissey]', 242 , 223 , 'Normal' , '1:0', 'Fairy' , 40, 10240, 10496, 10455, 10280, 10240, 103.2, 46.8, 'Fast', q'{Bipedal, tailless form}', 2 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Groudon]', 383, 'P', nq'|Red Orb|', q'|Primal|', 199 , 'Ground', 'Fire', ':U', 'Undiscovered' , 120 , 30976, 30855, 30840, 30720, 2094.4, 950, 'Slow', q'{Bipedal, tailed form}', 3 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Noivern]', 715 , 114, 'Mo', 'Flying', 'Dragon', '1:1', 'Flying' , 20 , 5140, 5120, 187.4, 85, 'Medium Fast', q'{Single pair of wings}', 6 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Gogoat]', 673 , 90, 'Ce', 'Grass' , '1:1', 'Field' , 20 , 5140, 5120, 200.6, 91, 'Medium Fast', q'{Quadruped body}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Lunatone]', 337 , 125 , 'Rock', 'Psychic', ':', 'Mineral' , 25 , 6656, 6630, 6425, 6400, 370.4, 168, 'Fast', q'{Head}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Huntail]', 367 , 177 , 'Water' , '1:1', 'Water 1' , 20 , 5376, 5355, 5140, 5120, 59.5, 27, 'Erratic', q'{Serpentine bodies}', 3 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Silvally]', 773 , q'|Type: Ice|', 204 , 'Normal' , ':U', 'Undiscovered' , 120 , 30720, 221.6, 100.5, 'Slow', q'{Quadruped body}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Eelektrik]', 603 , 109 , 'Electric' , '1:1', 'Amorphous' , 20 , 5140, 5120, 48.5, 22, 'Slow', q'{Fins}', 5 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Talonflame]', 663 , 16, 'Ce', 'Fire', 'Flying', '1:1', 'Flying' , 15 , 3855, 3840, 54, 24.5, 'Medium Slow', q'{Single pair of wings}', 6 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Flabébé]', 669 , q'|Red Flower|', 68, 'Ce', 'Fairy' , '1:0', 'Fairy' , 20 , 5140, 5120, 0.2, 0.1, 'Medium Fast', q'{Head and arms}', 6 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Scatterbug]', 664 , 20, 'Ce', 'Bug' , '1:1', 'Bug' , 15 , 3855, 3840, 5.5, 2.5, 'Medium Fast', q'{Insectoid body}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Petilil]', 548 , 54 , 'Grass' , '1:0', 'Grass' , 20 , 5140, 5120, 14.6, 6.6, 'Medium Fast', q'{Head and a base}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Umbreon]', 197 , 189 , 'Dark' , '1:7', 'Field' , 35, 8960, 9216, 9180, 8995, 8960, 59.5, 27, 'Medium Fast', q'{Quadruped body}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Tynamo]', 602 , 108 , 'Electric' , '1:1', 'Amorphous' , 20 , 5140, 5120, 0.7, 0.3, 'Slow', q'{Fins}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Shiftry]', 275 , 24 , 'Grass', 'Dark', '1:1', 'Field', 'Grass', 15 , 4096, 4080, 3855, 3840, 131.4, 59.6, 'Medium Slow', q'{Bipedal, tailless form}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Shiinotic]', 756 , 146 , 'Grass', 'Fairy', '1:1', 'Grass' , 20 , 5120, 25.4, 11.5, 'Medium Fast', q'{Bipedal, tailless form}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Simisage]', 512 , 18 , 'Grass' , '1:7', 'Field' , 20 , 5140, 5120, 67.2, 30.5, 'Medium Fast', q'{Bipedal, tailed form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Cacturne]', 332 , 120 , 'Grass', 'Dark', '1:1', 'Grass', 'Human-Like', 20 , 5376, 5355, 5140, 5120, 170.6, 77.4, 'Medium Slow', q'{Bipedal, tailless form}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Slowbro]', 80 , 80 , 'Water', 'Psychic', '1:1', 'Monster', 'Water 1', 20, 5120, 5376, 5355, 5140, 5120, 173.1, 78.5, 'Medium Fast', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Froslass]', 478 , 208 , 'Ice', 'Ghost', '1:0', 'Fairy', 'Mineral', 20 , 5355, 5140, 5120, 58.6, 26.6, 'Medium Fast', q'{Head and arms}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Krookodile]', 553 , 59 , 'Ground', 'Dark', '1:1', 'Field' , 20 , 5140, 5120, 212.3, 96.3, 'Medium Slow', q'{Bipedal, tailed form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Buizel]', 418 , 56 , 'Water' , '1:1', 'Water 1', 'Field', 20 , 5355, 5140, 5120, 65, 29.5, 'Medium Fast', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Cherrim]', 421 , q'|Sunshine Form|', 59 , 'Grass' , '1:1', 'Fairy', 'Grass', 20 , 5355, 5140, 5120, 20.5, 9.3, 'Medium Fast', q'{Head and legs}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Sandile]', 551 , 57 , 'Ground', 'Dark', '1:1', 'Field' , 20 , 5140, 5120, 33.5, 15.2, 'Medium Slow', q'{Quadruped body}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Axew]', 610 , 116 , 'Dragon' , '1:1', 'Monster', 'Dragon', 40 , 10280, 10240, 39.7, 18, 'Slow', q'{Bipedal, tailed form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Archen]', 566 , 72 , 'Rock', 'Flying', '1:7', 'Flying', 'Water 3', 30 , 7710, 7680, 20.9, 9.5, 'Medium Fast', q'{Single pair of wings}', 5 );
insert into Pokemon( NAME, DEX , CLASS , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Shaymin]', 492 , q'|Land Forme|' , 'Grass' , ':U', 'Undiscovered' , 120 , 30855, 30840, 30720, 4.6, 2.1, 'Medium Slow', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Claydol]', 344 , 132 , 'Ground', 'Psychic', ':', 'Mineral' , 20 , 5376, 5355, 5140, 5120, 238, 107.9, 'Medium Fast', q'{Head and arms}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Gothorita]', 575 , 81 , 'Psychic' , '3:1', 'Human-Like' , 20 , 5140, 5120, 39.7, 18, 'Medium Slow', q'{Bipedal, tailless form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Staryu]', 120 , 120 , 'Water' , ':', 'Water 3' , 20, 5120, 5376, 5355, 5140, 5120, 76.1, 34.5, 'Slow', q'{Head and a base}', 1 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Gallade]', 475, 'M', nq'|Galladite|', q'|Mega|', 160 , 'Psychic', 'Fighting', '0:1', 'Amorphous' , 20 , 5355, 5140, 5120, 114.6, 52, 'Slow', q'{Bipedal, tailless form}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Kirlia]', 281 , 30 , 'Psychic', 'Fairy', '1:1', 'Amorphous' , 20 , 5376, 5355, 5140, 5120, 44.5, 20.2, 'Slow', q'{Bipedal, tailless form}', 3 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pangoro]', 675 , 92, 'Ce', 'Fighting', 'Dark', '1:1', 'Field', 'Human-Like', 25 , 6425, 6400, 299.8, 136, 'Medium Fast', q'{Bipedal, tailless form}', 6 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Oricorio]', 741 , q'|Pom-Pom Style|', 82 , 'Fire', 'Flying', '3:1', 'Flying' , 20 , 5120, 7.5, 3.4, 'Medium Fast', q'{Single pair of wings}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pignite]', 499 , 5 , 'Fire', 'Fighting', '1:7', 'Field' , 20 , 5140, 5120, 122.4, 55.5, 'Medium Slow', q'{Bipedal, tailed form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Aron]', 304 , 70 , 'Steel', 'Rock', '1:1', 'Monster' , 35 , 9216, 9180, 8995, 8960, 132.3, 60, 'Slow', q'{Quadruped body}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Dewgong]', 87 , 87 , 'Water', 'Ice', '1:1', 'Water 1', 'Field', 20, 5120, 5376, 5355, 5140, 5120, 264.6, 120, 'Medium Fast', q'{Fins}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Hakamo-o]', 783 , 272 , 'Dragon', 'Fighting', '1:1', 'Dragon' , 40 , 10240, 103.6, 47, 'Slow', q'{Bipedal, tailed form}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Mr. Mime]', 122 , 122 , 'Psychic', 'Fairy', '1:1', 'Human-Like' , 25, 6400, 6656, 6630, 6425, 6400, 120.1, 54.5, 'Medium Fast', q'{Bipedal, tailless form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Passimian]', 766 , 177 , 'Fighting' , '1:1', 'Field' , 20 , 5120, 182.5, 82.8, 'Slow', q'{Bipedal, tailed form}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Happiny]', 440 , 96 , 'Normal' , '1:0U', 'Undiscovered' , 40 , 10455, 10280, 10240, 53.8, 24.4, 'Fast', q'{Bipedal, tailless form}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Spinarak]', 167 , 32 , 'Bug', 'Poison', '1:1', 'Bug' , 15, 3840, 4096, 4080, 3855, 3840, 18.7, 8.5, 'Fast', q'{Insectoid body}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Regirock]', 377 , 193 , 'Rock' , ':U', 'Undiscovered' , 80 , 20736, 20655, 20560, 20480, 507.1, 230, 'Slow', q'{Bipedal, tailless form}', 3 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pikachu]', 25 , q'|Alola Cap|', 25 , 'Electric' , '1:1', 'Field', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 13.2, 6, 'Medium Fast', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , CLASS , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Arceus]', 493 , q'|Type: Dragon|' , 'Normal' , ':U', 'Undiscovered' , 120 , 30855, 30840, 30720, 705.5, 320, 'Slow', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Hypno]', 97 , 97 , 'Psychic' , '1:1', 'Human-Like' , 20, 5120, 5376, 5355, 5140, 5120, 166.7, 75.6, 'Medium Fast', q'{Bipedal, tailless form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Durant]', 632 , 138 , 'Bug', 'Steel', '1:1', 'Bug' , 20 , 5140, 5120, 72.8, 33, 'Medium Fast', q'{Insectoid body}', 5 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Meloetta]', 648, 'P' , q'|Pirouette Forme|', 154 , 'Normal', 'Fighting', ':U', 'Undiscovered' , 120 , 30840, 30720, 14.3, 6.5, 'Slow', q'{Bipedal, tailless form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Raticate]', 20 , 20 , 'Normal' , '1:1', 'Field' , 15, 3840, 4096, 4080, 3855, 3840, 40.8, 18.5, 'Medium Fast', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Hawlucha]', 701 , 89, 'Co', 'Fighting', 'Flying', '1:1', 'Human-Like' , 20 , 5140, 5120, 47.4, 21.5, 'Medium Fast', q'{Bipedal, tailless form}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Gallade]', 475 , 160 , 'Psychic', 'Fighting', '0:1', 'Amorphous' , 20 , 5355, 5140, 5120, 114.6, 52, 'Slow', q'{Bipedal, tailless form}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Throh]', 538 , 44 , 'Fighting' , '0:1', 'Human-Like' , 20 , 5140, 5120, 122.4, 55.5, 'Medium Fast', q'{Bipedal, tailless form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Togepi]', 175 , 46 , 'Fairy' , '1:7U', 'Undiscovered' , 10, 2560, 2816, 2805, 2570, 2560, 3.3, 1.5, 'Fast', q'{Bipedal, tailless form}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Piloswine]', 221 , 196 , 'Ice', 'Ground', '1:1', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 123, 55.8, 'Slow', q'{Quadruped body}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Shuppet]', 353 , 146 , 'Ghost' , '1:1', 'Amorphous' , 25 , 6656, 6630, 6425, 6400, 5.1, 2.3, 'Fast', q'{Head}', 3 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Silvally]', 773 , q'|Type: Dragon|', 204 , 'Normal' , ':U', 'Undiscovered' , 120 , 30720, 221.6, 100.5, 'Slow', q'{Quadruped body}', 7 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pumpkaboo]', 710 , q'|Super Size|', 63, 'Mo', 'Ghost', 'Grass', '1:1', 'Amorphous' , 20 , 5140, 5120, 33.1, 15, 'Medium Fast', q'{Head}', 6 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Slowbro]', 80, 'M', nq'|Slowbronite|', q'|Mega|', 80 , 'Water', 'Psychic', '1:1', 'Monster', 'Water 1', 20, 5120, 5376, 5355, 5140, 5120, 173.1, 78.5, 'Medium Fast', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Ponyta]', 77 , 77 , 'Fire' , '1:1', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 66.1, 30, 'Medium Fast', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Probopass]', 476 , 156 , 'Rock', 'Steel', '1:1', 'Mineral' , 20 , 5355, 5140, 5120, 749.6, 340, 'Medium Fast', q'{Multiple bodies}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Marowak]', 105 , 105 , 'Ground' , '1:1', 'Monster' , 20, 5120, 5376, 5355, 5140, 5120, 99.2, 45, 'Medium Fast', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Kyogre]', 382 , 198 , 'Water' , ':U', 'Undiscovered' , 120 , 30976, 30855, 30840, 30720, 776, 352, 'Slow', q'{Fins}', 3 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Honedge]', 679 , 117, 'Ce', 'Steel', 'Ghost', '1:1', 'Mineral' , 20 , 5140, 5120, 4.4, 2, 'Medium Fast', q'{Head and a base}', 6 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Flabébé]', 669 , q'|Orange Flower|', 68, 'Ce', 'Fairy' , '1:0', 'Fairy' , 20 , 5140, 5120, 0.2, 0.1, 'Medium Fast', q'{Head and arms}', 6 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Salamence]', 373, 'M', nq'|Salamencite|', q'|Mega|', 189 , 'Dragon', 'Flying', '1:1', 'Dragon' , 40 , 10496, 10455, 10280, 10240, 226.2, 102.6, 'Slow', q'{Quadruped body}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Cinccino]', 573 , 79 , 'Normal' , '3:1', 'Field' , 15 , 3855, 3840, 16.5, 7.5, 'Fast', q'{Quadruped body}', 5 );
insert into Pokemon( NAME, DEX , CLASS , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Arceus]', 493 , q'|Type: Dark|' , 'Normal' , ':U', 'Undiscovered' , 120 , 30855, 30840, 30720, 705.5, 320, 'Slow', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Silvally]', 773 , q'|Type: Grass|', 204 , 'Normal' , ':U', 'Undiscovered' , 120 , 30720, 221.6, 100.5, 'Slow', q'{Quadruped body}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Registeel]', 379 , 195 , 'Steel' , ':U', 'Undiscovered' , 80 , 20736, 20655, 20560, 20480, 451.9, 205, 'Slow', q'{Bipedal, tailless form}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Dewott]', 502 , 8 , 'Water' , '1:7', 'Field' , 20 , 5140, 5120, 54, 24.5, 'Medium Slow', q'{Bipedal, tailed form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Furret]', 162 , 20 , 'Normal' , '1:1', 'Field' , 15, 3840, 4096, 4080, 3855, 3840, 71.6, 32.5, 'Medium Fast', q'{Quadruped body}', 2 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pikachu]', 25 , q'|Libre|', 25 , 'Electric' , '1:1', 'Field', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 13.2, 6, 'Medium Fast', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Drowzee]', 96 , 96 , 'Psychic' , '1:1', 'Human-Like' , 20, 5120, 5376, 5355, 5140, 5120, 71.4, 32.4, 'Medium Fast', q'{Bipedal, tailless form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Slowking]', 199 , 82 , 'Water', 'Psychic', '1:1', 'Monster', 'Water 1', 20, 5120, 5376, 5355, 5140, 5120, 175.3, 79.5, 'Medium Fast', q'{Bipedal, tailed form}', 2 );
insert into Pokemon( NAME, DEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Cresselia]', 488 , 'Psychic' , '1:0U', 'Undiscovered' , 120 , 30855, 30840, 30720, 188.7, 85.6, 'Slow', q'{Serpentine bodies}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Drapion]', 452 , 128 , 'Poison', 'Dark', '1:1', 'Bug', 'Water 3', 20 , 5355, 5140, 5120, 135.6, 61.5, 'Slow', q'{Insectoid body}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Eevee]', 133 , 133 , 'Normal' , '1:7', 'Field' , 35, 8960, 9216, 9180, 8995, 8960, 14.3, 6.5, 'Medium Fast', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Vigoroth]', 288 , 37 , 'Normal' , '1:1', 'Field' , 15 , 4096, 4080, 3855, 3840, 102.5, 46.5, 'Slow', q'{Bipedal, tailed form}', 3 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Silvally]', 773 , q'|Type: Ground|', 204 , 'Normal' , ':U', 'Undiscovered' , 120 , 30720, 221.6, 100.5, 'Slow', q'{Quadruped body}', 7 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Absol]', 359, 'M', nq'|Absolite|', q'|Mega|', 152 , 'Dark' , '1:1', 'Field' , 25 , 6656, 6630, 6425, 6400, 103.6, 47, 'Medium Slow', q'{Quadruped body}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Gigalith]', 526 , 32 , 'Rock' , '1:1', 'Mineral' , 15 , 3855, 3840, 573.2, 260, 'Medium Slow', q'{Tentacles or a multiped body}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Scraggy]', 559 , 65 , 'Dark', 'Fighting', '1:1', 'Field', 'Dragon', 15 , 3855, 3840, 26, 11.8, 'Medium Fast', q'{Bipedal, tailed form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Tentacool]', 72 , 72 , 'Water', 'Poison', '1:1', 'Water 3' , 20, 5120, 5376, 5355, 5140, 5120, 100.3, 45.5, 'Slow', q'{Tentacles or a multiped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Charjabug]', 737 , 28 , 'Bug', 'Electric', '1:1', 'Bug' , 15 , 3840, 23.1, 10.5, 'Medium Fast', q'{Serpentine bodies}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Dunsparce]', 206 , 52 , 'Normal' , '1:1', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 30.9, 14, 'Medium Fast', q'{Serpentine bodies}', 2 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Gourgeist]', 711 , q'|Small Size|', 64, 'Mo', 'Ghost', 'Grass', '1:1', 'Amorphous' , 20 , 5140, 5120, 20.9, 9.5, 'Medium Fast', q'{Head and a base}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Deino]', 633 , 139 , 'Dark', 'Dragon', '1:1', 'Dragon' , 40 , 10280, 10240, 38.1, 17.3, 'Slow', q'{Quadruped body}', 5 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Vivillon]', 666 , q'|Meadow Pattern|', 22, 'Ce', 'Bug', 'Flying', '1:1', 'Bug' , 15 , 3855, 3840, 37.5, 17, 'Medium Fast', q'{Two or more pairs of wings}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Trumbeak]', 732 , 11 , 'Normal', 'Flying', '1:1', 'Flying' , 15 , 3840, 32.6, 14.8, 'Medium Fast', q'{Single pair of wings}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Doduo]', 84 , 84 , 'Normal', 'Flying', '1:1', 'Flying' , 20, 5120, 5376, 5355, 5140, 5120, 86.4, 39.2, 'Medium Fast', q'{Head and legs}', 1 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Ampharos]', 181, 'M', nq'|Ampharosite|', q'|Mega|', 55 , 'Electric', 'Dragon', '1:1', 'Monster', 'Field', 20, 5120, 5376, 5355, 5140, 5120, 135.6, 61.5, 'Medium Slow', q'{Bipedal, tailed form}', 2 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Hoopa]', 720 , q'|Confined|', 152, 'Ce', 'Psychic', 'Ghost', ':U', 'Undiscovered' , 120 , 30840, 30720, 19.8, 9, 'Slow', q'{Head and arms}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Vibrava]', 329 , 117 , 'Ground', 'Dragon', '1:1', 'Bug' , 20 , 5376, 5355, 5140, 5120, 33.7, 15.3, 'Medium Slow', q'{Two or more pairs of wings}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Mamoswine]', 473 , 205 , 'Ice', 'Ground', '1:1', 'Field' , 20 , 5355, 5140, 5120, 641.5, 291, 'Slow', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Tropius]', 357 , 150 , 'Grass', 'Flying', '1:1', 'Monster', 'Grass', 25 , 6656, 6630, 6425, 6400, 220.5, 100, 'Slow', q'{Quadruped body}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Palossand]', 770 , 187 , 'Ghost', 'Ground', '1:1', 'Amorphous' , 15 , 3840, 551.2, 250, 'Medium Fast', q'{Serpentine bodies}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Groudon]', 383 , 199 , 'Ground' , ':U', 'Undiscovered' , 120 , 30976, 30855, 30840, 30720, 2094.4, 950, 'Slow', q'{Bipedal, tailed form}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Aipom]', 190 , 123 , 'Normal' , '1:1', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 25.4, 11.5, 'Fast', q'{Bipedal, tailed form}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Nuzleaf]', 274 , 23 , 'Grass', 'Dark', '1:1', 'Field', 'Grass', 15 , 4096, 4080, 3855, 3840, 61.7, 28, 'Medium Slow', q'{Bipedal, tailless form}', 3 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Deerling]', 585 , q'|Summer Form|', 91 , 'Normal', 'Grass', '1:1', 'Field' , 20 , 5140, 5120, 43, 19.5, 'Medium Fast', q'{Quadruped body}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Lugia]', 249 , 252 , 'Psychic', 'Flying', ':U', 'Undiscovered' , 120, 30720, 30976, 30855, 30840, 30720, 476.2, 216, 'Slow', q'{Single pair of wings}', 2 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Sylveon]', 700 , 85, 'Co', 'Fairy' , '1:7', 'Field' , 35 , 8995, 8960, 51.8, 23.5, 'Medium Fast', q'{Quadruped body}', 6 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Eevee]', 133, 'Pa' , q'|Partner|', 133 , 'Normal' , '1:7', 'Field' , 35, 8960, 9216, 9180, 8995, 8960, 14.3, 6.5, 'Medium Fast', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Tyranitar]', 248 , 251 , 'Rock', 'Dark', '1:1', 'Monster' , 40, 10240, 10496, 10455, 10280, 10240, 445.3, 202, 'Slow', q'{Bipedal, tailed form}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Hoothoot]', 163 , 15 , 'Normal', 'Flying', '1:1', 'Flying' , 15, 3840, 4096, 4080, 3855, 3840, 46.7, 21.2, 'Medium Fast', q'{Single pair of wings}', 2 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Deerling]', 585 , q'|Autumn Form|', 91 , 'Normal', 'Grass', '1:1', 'Field' , 20 , 5140, 5120, 43, 19.5, 'Medium Fast', q'{Quadruped body}', 5 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Castform]', 351, 'H' , q'|Snowy Form|', 142 , 'Ice' , '1:1', 'Fairy', 'Amorphous', 25 , 6656, 6630, 6425, 6400, 1.8, 0.8, 'Medium Fast', q'{Head}', 3 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Silvally]', 773 , q'|Type: Fighting|', 204 , 'Normal' , ':U', 'Undiscovered' , 120 , 30720, 221.6, 100.5, 'Slow', q'{Quadruped body}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Smeargle]', 235 , 159 , 'Normal' , '1:1', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 127.9, 58, 'Fast', q'{Bipedal, tailed form}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Lunala]', 792 , 292 , 'Psychic', 'Ghost', ':U', 'Undiscovered' , 120 , 30720, 264.6, 120, 'Slow', q'{Single pair of wings}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Milotic]', 350 , 141 , 'Water' , '1:1', 'Water 1', 'Dragon', 20 , 5376, 5355, 5140, 5120, 357.1, 162, 'Erratic', q'{Serpentine bodies}', 3 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Mewtwo]', 150, 'MY' , q'|Mega  Y|', 150 , 'Psychic' , ':U', 'Undiscovered' , 120, 30720, 30976, 30855, 30840, 30720, 269, 122, 'Slow', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pidgeot]', 18 , 18 , 'Normal', 'Flying', '1:1', 'Flying' , 15, 3840, 4096, 4080, 3855, 3840, 87.1, 39.5, 'Medium Slow', q'{Single pair of wings}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Komala]', 775 , 222 , 'Normal' , '1:1', 'Field' , 20 , 5120, 43.9, 19.9, 'Slow', q'{Bipedal, tailless form}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Vanilluxe]', 584 , 90 , 'Ice' , '1:1', 'Mineral' , 20 , 5140, 5120, 126.8, 57.5, 'Slow', q'{Multiple bodies}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Druddigon]', 621 , 127 , 'Dragon' , '1:1', 'Dragon', 'Monster', 30 , 7710, 7680, 306.4, 139, 'Medium Fast', q'{Bipedal, tailed form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Linoone]', 264 , 13 , 'Normal' , '1:1', 'Field' , 15 , 4096, 4080, 3855, 3840, 71.6, 32.5, 'Medium Fast', q'{Quadruped body}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Totodile]', 158 , 7 , 'Water' , '1:7', 'Monster', 'Water 1', 20, 5120, 5376, 5355, 5140, 5120, 20.9, 9.5, 'Medium Slow', q'{Bipedal, tailed form}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Zekrom]', 644 , 150 , 'Dragon', 'Electric', ':U', 'Undiscovered' , 120 , 30840, 30720, 760.6, 345, 'Slow', q'{Bipedal, tailed form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Electrode]', 101 , 101 , 'Electric' , ':', 'Mineral' , 20, 5120, 5376, 5355, 5140, 5120, 146.8, 66.6, 'Medium Fast', q'{Head}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Regice]', 378 , 194 , 'Ice' , ':U', 'Undiscovered' , 80 , 20736, 20655, 20560, 20480, 385.8, 175, 'Slow', q'{Bipedal, tailless form}', 3 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Meloetta]', 648 , q'|Aria Forme|', 154 , 'Normal', 'Psychic', ':U', 'Undiscovered' , 120 , 30840, 30720, 14.3, 6.5, 'Slow', q'{Bipedal, tailless form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Purrloin]', 509 , 15 , 'Dark' , '1:1', 'Field' , 20 , 5140, 5120, 22.3, 10.1, 'Medium Fast', q'{Quadruped body}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Cradily]', 346 , 134 , 'Rock', 'Grass', '1:7', 'Water 3' , 30 , 7936, 7905, 7710, 7680, 133.2, 60.4, 'Erratic', q'{Head and a base}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Entei]', 244 , 244 , 'Fire' , ':U', 'Undiscovered' , 80, 20480, 20736, 20655, 20560, 20480, 436.5, 198, 'Slow', q'{Quadruped body}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Bayleef]', 153 , 2 , 'Grass' , '1:7', 'Monster', 'Grass', 20, 5120, 5376, 5355, 5140, 5120, 34.8, 15.8, 'Medium Slow', q'{Quadruped body}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Slugma]', 218 , 216 , 'Fire' , '1:1', 'Amorphous' , 20, 5120, 5376, 5355, 5140, 5120, 77.2, 35, 'Medium Fast', q'{Serpentine bodies}', 2 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Raichu]', 26, 'A' , q'|Alolan|' , 'Electric', 'Psychic', '1:1', 'Field', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 66.1, 30, 'Medium Fast', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Volcanion]', 721 , 153, 'Ce', 'Fire', 'Water', ':U', 'Undiscovered' , 120 , 30840, 30720, 429.9, 195, 'Slow', q'{Quadruped body}', 6 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Vivillon]', 666 , q'|Poké Ball Pattern|', 22, 'Ce', 'Bug', 'Flying', '1:1', 'Bug' , 15 , 3855, 3840, 37.5, 17, 'Medium Fast', q'{Two or more pairs of wings}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Nosepass]', 299 , 60 , 'Rock' , '1:1', 'Mineral' , 20 , 5376, 5355, 5140, 5120, 213.8, 97, 'Medium Fast', q'{Bipedal, tailless form}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Mankey]', 56 , 56 , 'Fighting' , '1:1', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 61.7, 28, 'Medium Fast', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Reshiram]', 643 , q'|Overdrive mode|', 149 , 'Dragon', 'Fire', ':U', 'Undiscovered' , 120 , 30840, 30720, 727.5, 330, 'Slow', q'{Single pair of wings}', 5 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Furfrou]', 676 , q'|Heart Trim|', 93, 'Ce', 'Normal' , '1:1', 'Field' , 20 , 5140, 5120, 61.7, 28, 'Medium Fast', q'{Quadruped body}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Toucannon]', 733 , 12 , 'Normal', 'Flying', '1:1', 'Flying' , 15 , 3840, 57.3, 26, 'Medium Fast', q'{Single pair of wings}', 7 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Gastrodon]', 423 , q'|West Sea|', 61 , 'Water', 'Ground', '1:1', 'Water 1', 'Amorphous', 20 , 5355, 5140, 5120, 65.9, 29.9, 'Medium Fast', q'{Serpentine bodies}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Lilligant]', 549 , 55 , 'Grass' , '1:0', 'Grass' , 20 , 5140, 5120, 35.9, 16.3, 'Medium Fast', q'{Head and a base}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Munna]', 517 , 23 , 'Psychic' , '1:1', 'Field' , 10 , 2570, 2560, 51.4, 23.3, 'Fast', q'{Quadruped body}', 5 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Ninetales]', 38, 'A' , q'|Alolan|' , 'Ice', 'Fairy', '3:1', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 43.9, 19.9, 'Medium Fast', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Electivire]', 466 , 199 , 'Electric' , '1:3', 'Human-Like' , 25 , 6630, 6425, 6400, 305.6, 138.6, 'Medium Fast', q'{Bipedal, tailed form}', 4 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Giratina]', 487, 'O' , q'|Origin Forme|', 210 , 'Ghost', 'Dragon', ':U', 'Undiscovered' , 120 , 30855, 30840, 30720, 1433, 650, 'Slow', q'{Tentacles or a multiped body}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Sharpedo]', 319 , 98 , 'Water', 'Dark', '1:1', 'Water 2' , 20 , 5376, 5355, 5140, 5120, 195.8, 88.8, 'Slow', q'{Fins}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Jumpluff]', 189 , 69 , 'Grass', 'Flying', '1:1', 'Fairy', 'Grass', 20, 5120, 5376, 5355, 5140, 5120, 6.6, 3, 'Medium Slow', q'{Bipedal, tailed form}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Palkia]', 484 , 150 , 'Water', 'Dragon', ':U', 'Undiscovered' , 120 , 30855, 30840, 30720, 740.8, 336, 'Slow', q'{Bipedal, tailed form}', 4 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Sandshrew]', 27, 'A' , q'|Alolan|' , 'Ice', 'Steel', '1:1', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 26.5, 12, 'Medium Fast', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Mawile]', 303 , 69 , 'Steel', 'Fairy', '1:1', 'Field', 'Fairy', 20 , 5376, 5355, 5140, 5120, 25.4, 11.5, 'Fast', q'{Bipedal, tailless form}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Kakuna]', 14 , 14 , 'Bug', 'Poison', '1:1', 'Bug' , 15, 3840, 4096, 4080, 3855, 3840, 22, 10, 'Medium Fast', q'{Serpentine bodies}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Porygon2]', 233 , 221 , 'Normal' , ':', 'Mineral' , 20, 5120, 5376, 5355, 5140, 5120, 71.6, 32.5, 'Medium Fast', q'{Head and legs}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Farfetch'd]', 83 , 83 , 'Normal', 'Flying', '1:1', 'Flying', 'Field', 20, 5120, 5376, 5355, 5140, 5120, 33.1, 15, 'Medium Fast', q'{Single pair of wings}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Rowlet]', 722 , 1 , 'Grass', 'Flying', '1:7', 'Flying' , 15 , 3840, 3.3, 1.5, 'Medium Slow', q'{Single pair of wings}', 7 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Burmy]', 412 , q'|Plant Cloak|', 45 , 'Bug' , '1:1', 'Bug' , 15 , 4080, 3855, 3840, 7.5, 3.4, 'Medium Fast', q'{Head and a base}', 4 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Amaura]', 698 , 66, 'Co', 'Rock', 'Ice', '1:7', 'Monster' , 30 , 7710, 7680, 55.6, 25.2, 'Medium Fast', q'{Quadruped body}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Onix]', 95 , 95 , 'Rock', 'Ground', '1:1', 'Mineral' , 25, 6400, 6656, 6630, 6425, 6400, 463, 210, 'Medium Fast', q'{Serpentine bodies}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Machop]', 66 , 66 , 'Fighting' , '1:3', 'Human-Like' , 20, 5120, 5376, 5355, 5140, 5120, 43, 19.5, 'Medium Slow', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Tapu Koko]', 785 , 285 , 'Electric', 'Fairy', ':U', 'Undiscovered' , 15 , 3840, 45.2, 20.5, 'Slow', q'{Head and arms}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Squirtle]', 7 , 7 , 'Water' , '1:7', 'Monster', 'Water 1', 20, 5120, 5376, 5355, 5140, 5120, 19.8, 9, 'Medium Slow', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Gourgeist]', 711 , q'|Super Size|', 64, 'Mo', 'Ghost', 'Grass', '1:1', 'Amorphous' , 20 , 5140, 5120, 86, 39, 'Medium Fast', q'{Head and a base}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Elekid]', 239 , 156 , 'Electric' , '1:3U', 'Undiscovered' , 25, 6400, 6656, 6630, 6425, 6400, 51.8, 23.5, 'Medium Fast', q'{Bipedal, tailless form}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Weavile]', 461 , 145 , 'Dark', 'Ice', '1:1', 'Field' , 20 , 5355, 5140, 5120, 75, 34, 'Medium Slow', q'{Bipedal, tailed form}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Vanillite]', 582 , 88 , 'Ice' , '1:1', 'Mineral' , 20 , 5140, 5120, 12.6, 5.7, 'Slow', q'{Head and a base}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Togedemaru]', 777 , 225 , 'Electric', 'Steel', '1:1', 'Field', 'Fairy', 10 , 2560, 7.3, 3.3, 'Medium Fast', q'{Bipedal, tailed form}', 7 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Flabébé]', 669 , q'|White Flower|', 68, 'Ce', 'Fairy' , '1:0', 'Fairy' , 20 , 5140, 5120, 0.2, 0.1, 'Medium Fast', q'{Head and arms}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Cranidos]', 408 , 36 , 'Rock' , '1:7', 'Monster' , 30 , 7905, 7710, 7680, 69.4, 31.5, 'Erratic', q'{Bipedal, tailed form}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Quagsire]', 195 , 57 , 'Water', 'Ground', '1:1', 'Water 1', 'Field', 20, 5120, 5376, 5355, 5140, 5120, 165.3, 75, 'Medium Fast', q'{Bipedal, tailed form}', 2 );
insert into Pokemon( NAME, DEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Regigigas]', 486 , 'Normal' , ':U', 'Undiscovered' , 120 , 30855, 30840, 30720, 925.9, 420, 'Slow', q'{Bipedal, tailless form}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Spearow]', 21 , 21 , 'Normal', 'Flying', '1:1', 'Flying' , 15, 3840, 4096, 4080, 3855, 3840, 4.4, 2, 'Medium Fast', q'{Single pair of wings}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Combusken]', 256 , 5 , 'Fire', 'Fighting', '1:7', 'Field' , 20 , 5376, 5355, 5140, 5120, 43, 19.5, 'Medium Slow', q'{Bipedal, tailed form}', 3 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Xerneas]', 716 , q'|Active Mode|', 148, 'Mo', 'Fairy' , ':U', 'Undiscovered' , 120 , 30840, 30720, 474, 215, 'Slow', q'{Quadruped body}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Blitzle]', 522 , 28 , 'Electric' , '1:1', 'Field' , 20 , 5140, 5120, 65.7, 29.8, 'Medium Fast', q'{Quadruped body}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Beedrill]', 15 , 15 , 'Bug', 'Poison', '1:1', 'Bug' , 15, 3840, 4096, 4080, 3855, 3840, 65, 29.5, 'Medium Fast', q'{Two or more pairs of wings}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Surskit]', 283 , 32 , 'Bug', 'Water', '1:1', 'Water 1', 'Bug', 15 , 4096, 4080, 3855, 3840, 3.7, 1.7, 'Medium Fast', q'{Insectoid body}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Geodude]', 74 , 74 , 'Rock', 'Ground', '1:1', 'Mineral' , 15, 3840, 4096, 4080, 3855, 3840, 44.1, 20, 'Medium Slow', q'{Head and arms}', 1 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Lycanroc]', 745, 'Mn' , q'|Midnight Form|', 104 , 'Rock' , '1:1', 'Field' , 15 , 3840, 55.1, 25, 'Medium Fast', q'{Quadruped body}', 7 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Kyurem]', 646, 'B' , q'|Black|', 152 , 'Dragon', 'Ice', ':U', 'Undiscovered' , 120 , 30840, 30720, 716.5, 325, 'Slow', q'{Bipedal, tailed form}', 5 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS, LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Zygarde]', 718, 'C' , q'|Complete Forme|', 150, 'Mo', 'Dragon', 'Ground', ':U', 'Undiscovered' , 120 , 30840, 30720, 1344.8, 610, 'Slow', q'{Bipedal, tailed form}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Zangoose]', 335 , 123 , 'Normal' , '1:1', 'Field' , 20 , 5376, 5355, 5140, 5120, 88.8, 40.3, 'Erratic', q'{Bipedal, tailed form}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Noctowl]', 164 , 16 , 'Normal', 'Flying', '1:1', 'Flying' , 15, 3840, 4096, 4080, 3855, 3840, 89.9, 40.8, 'Medium Fast', q'{Single pair of wings}', 2 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Silvally]', 773 , q'|Type: Normal|', 204 , 'Normal' , ':U', 'Undiscovered' , 120 , 30720, 221.6, 100.5, 'Slow', q'{Quadruped body}', 7 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Geodude]', 74, 'A' , q'|Alolan|' , 'Rock', 'Electric', '1:1', 'Mineral' , 15, 3840, 4096, 4080, 3855, 3840, 44.1, 20, 'Medium Slow', q'{Head and arms}', 1 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Landorus]', 645 , q'|Incarnate Forme|', 151 , 'Ground', 'Flying', '0:1U', 'Undiscovered' , 120 , 30840, 30720, 149.9, 68, 'Slow', q'{Head and arms}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Golbat]', 42 , 42 , 'Poison', 'Flying', '1:1', 'Flying' , 15, 3840, 4096, 4080, 3855, 3840, 121.3, 55, 'Medium Fast', q'{Single pair of wings}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Shelmet]', 616 , 122 , 'Bug' , '1:1', 'Bug' , 15 , 3855, 3840, 17, 7.7, 'Medium Fast', q'{Head}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Cyndaquil]', 155 , 4 , 'Fire' , '1:7', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 17.4, 7.9, 'Medium Slow', q'{Bipedal, tailless form}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Azelf]', 482 , 148 , 'Psychic' , ':U', 'Undiscovered' , 80 , 20655, 20560, 20480, 0.7, 0.3, 'Slow', q'{Bipedal, tailed form}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Decidueye]', 724 , 3 , 'Grass', 'Ghost', '1:7', 'Flying' , 15 , 3840, 80.7, 36.6, 'Medium Slow', q'{Single pair of wings}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Uxie]', 480 , 146 , 'Psychic' , ':U', 'Undiscovered' , 80 , 20655, 20560, 20480, 0.7, 0.3, 'Slow', q'{Bipedal, tailed form}', 4 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Sawsbuck]', 586 , q'|Summer Form|', 92 , 'Normal', 'Grass', '1:1', 'Field' , 20 , 5140, 5120, 203.9, 92.5, 'Medium Fast', q'{Quadruped body}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Drifloon]', 425 , 65 , 'Ghost', 'Flying', '1:1', 'Amorphous' , 30 , 7905, 7710, 7680, 2.6, 1.2, 'Fluctuating', q'{Head and arms}', 4 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Aerodactyl]', 142, 'M', nq'|Aerodactylite|', q'|Mega|', 142 , 'Rock', 'Flying', '1:7', 'Flying' , 35, 8960, 9216, 9180, 8995, 8960, 130.1, 59, 'Slow', q'{Single pair of wings}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Trapinch]', 328 , 116 , 'Ground' , '1:1', 'Bug' , 20 , 5376, 5355, 5140, 5120, 33.1, 15, 'Medium Slow', q'{Insectoid body}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Gorebyss]', 368 , 178 , 'Water' , '1:1', 'Water 1' , 20 , 5376, 5355, 5140, 5120, 49.8, 22.6, 'Erratic', q'{Serpentine bodies}', 3 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pikachu]', 25 , q'|Sinnoh Cap|', 25 , 'Electric' , '1:1', 'Field', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 13.2, 6, 'Medium Fast', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Sliggoo]', 705 , 20, 'Mo', 'Dragon' , '1:1', 'Dragon' , 40 , 10280, 10240, 38.6, 17.5, 'Slow', q'{Serpentine bodies}', 6 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Marowak]', 105, 'A' , q'|Alolan|' , 'Fire', 'Ghost', '1:1', 'Monster' , 20, 5120, 5376, 5355, 5140, 5120, 99.2, 45, 'Medium Fast', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Minior]', 774 , q'|Meteor Form|', 213 , 'Rock', 'Flying', ':', 'Mineral' , 25 , 6400, 88.2, 40, 'Medium Slow', q'{Head}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Staravia]', 397 , 11 , 'Normal', 'Flying', '1:1', 'Flying' , 15 , 4080, 3855, 3840, 34.2, 15.5, 'Medium Slow', q'{Single pair of wings}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Cherubi]', 420 , 58 , 'Grass' , '1:1', 'Fairy', 'Grass', 20 , 5355, 5140, 5120, 7.3, 3.3, 'Medium Fast', q'{Multiple bodies}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Lumineon]', 457 , 135 , 'Water' , '1:1', 'Water 2' , 20 , 5355, 5140, 5120, 52.9, 24, 'Erratic', q'{Fins}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Slowpoke]', 79 , 79 , 'Water', 'Psychic', '1:1', 'Monster', 'Water 1', 20, 5120, 5376, 5355, 5140, 5120, 79.4, 36, 'Medium Fast', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Swampert]', 260 , 9 , 'Water', 'Ground', '1:7', 'Monster', 'Water 1', 20 , 5376, 5355, 5140, 5120, 180.6, 81.9, 'Medium Slow', q'{Bipedal, tailed form}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Karrablast]', 588 , 94 , 'Bug' , '1:1', 'Bug' , 15 , 3855, 3840, 13, 5.9, 'Medium Fast', q'{Bipedal, tailless form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Nincada]', 290 , 42 , 'Bug', 'Ground', '1:1', 'Bug' , 15 , 4096, 4080, 3855, 3840, 12.1, 5.5, 'Erratic', q'{Insectoid body}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Chinchou]', 170 , 176 , 'Water', 'Electric', '1:1', 'Water 2' , 20, 5120, 5376, 5355, 5140, 5120, 26.5, 12, 'Slow', q'{Fins}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Bellossom]', 182 , 86 , 'Grass' , '1:1', 'Grass' , 20, 5120, 5376, 5355, 5140, 5120, 12.8, 5.8, 'Medium Slow', q'{Bipedal, tailless form}', 2 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Vivillon]', 666 , q'|Sun Pattern|', 22, 'Ce', 'Bug', 'Flying', '1:1', 'Bug' , 15 , 3855, 3840, 37.5, 17, 'Medium Fast', q'{Two or more pairs of wings}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Exeggutor]', 103 , 103 , 'Grass', 'Psychic', '1:1', 'Grass' , 20, 5120, 5376, 5355, 5140, 5120, 264.6, 120, 'Slow', q'{Head and legs}', 1 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Audino]', 531, 'M', nq'|Audinite|', q'|Mega|', 37 , 'Normal', 'Fairy', '1:1', 'Fairy' , 20 , 5140, 5120, 68.3, 31, 'Fast', q'{Bipedal, tailed form}', 5 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Gastrodon]', 423, 'E' , q'|East Sea|', 61 , 'Water', 'Ground', '1:1', 'Water 1', 'Amorphous', 20 , 5355, 5140, 5120, 65.9, 29.9, 'Medium Fast', q'{Serpentine bodies}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Simisear]', 514 , 20 , 'Fire' , '1:7', 'Field' , 20 , 5140, 5120, 61.7, 28, 'Medium Fast', q'{Bipedal, tailed form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Primeape]', 57 , 57 , 'Fighting' , '1:1', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 70.5, 32, 'Medium Fast', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Mareep]', 179 , 53 , 'Electric' , '1:1', 'Monster', 'Field', 20, 5120, 5376, 5355, 5140, 5120, 17.2, 7.8, 'Medium Slow', q'{Quadruped body}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Teddiursa]', 216 , 198 , 'Normal' , '1:1', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 19.4, 8.8, 'Medium Fast', q'{Bipedal, tailed form}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Tranquill]', 520 , 26 , 'Normal', 'Flying', '1:1', 'Flying' , 15 , 3855, 3840, 33.1, 15, 'Medium Slow', q'{Single pair of wings}', 5 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Florges]', 671 , q'|Yellow Flower|', 70, 'Ce', 'Fairy' , '1:0', 'Fairy' , 20 , 5140, 5120, 22, 10, 'Medium Fast', q'{Head and arms}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Timburr]', 532 , 38 , 'Fighting' , '1:3', 'Human-Like' , 20 , 5140, 5120, 27.6, 12.5, 'Medium Slow', q'{Bipedal, tailless form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Chimecho]', 358 , 151 , 'Psychic' , '1:1', 'Amorphous' , 25 , 6656, 6630, 6425, 6400, 2.2, 1, 'Fast', q'{Head and arms}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Blastoise]', 9 , 9 , 'Water' , '1:7', 'Monster', 'Water 1', 20, 5120, 5376, 5355, 5140, 5120, 188.5, 85.5, 'Medium Slow', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Machamp]', 68 , 68 , 'Fighting' , '1:3', 'Human-Like' , 20, 5120, 5376, 5355, 5140, 5120, 286.6, 130, 'Medium Slow', q'{Bipedal, tailless form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Blaziken]', 257 , 6 , 'Fire', 'Fighting', '1:7', 'Field' , 20 , 5376, 5355, 5140, 5120, 114.6, 52, 'Medium Slow', q'{Bipedal, tailed form}', 3 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Keldeo]', 647 , q'|Resolute Form|', 153 , 'Water', 'Fighting', ':U', 'Undiscovered' , 80 , 20560, 20480, 106.9, 48.5, 'Slow', q'{Quadruped body}', 5 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Garchomp]', 445, 'M', nq'|Garchompite|', q'|Mega|', 111 , 'Dragon', 'Ground', '1:1', 'Monster', 'Dragon', 40 , 10455, 10280, 10240, 209.4, 95, 'Slow', q'{Bipedal, tailed form}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Manaphy]', 490 , 151 , 'Water' , ':', 'Water 1', 'Fairy', 10 , 2805, 2570, 2560, 3.1, 1.4, 'Slow', q'{Bipedal, tailless form}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Bellsprout]', 69 , 69 , 'Grass', 'Poison', '1:1', 'Grass' , 20, 5120, 5376, 5355, 5140, 5120, 8.8, 4, 'Medium Slow', q'{Bipedal, tailless form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Togetic]', 176 , 47 , 'Fairy', 'Flying', '1:7', 'Flying', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 7.1, 3.2, 'Fast', q'{Bipedal, tailless form}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Rhyhorn]', 111 , 111 , 'Ground', 'Rock', '1:1', 'Monster', 'Field', 20, 5120, 5376, 5355, 5140, 5120, 253.5, 115, 'Slow', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Tentacruel]', 73 , 73 , 'Water', 'Poison', '1:1', 'Water 3' , 20, 5120, 5376, 5355, 5140, 5120, 121.3, 55, 'Slow', q'{Tentacles or a multiped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Minccino]', 572 , 78 , 'Normal' , '3:1', 'Field' , 15 , 3855, 3840, 12.8, 5.8, 'Fast', q'{Quadruped body}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Meditite]', 307 , 76 , 'Fighting', 'Psychic', '1:1', 'Human-Like' , 20 , 5376, 5355, 5140, 5120, 24.7, 11.2, 'Medium Fast', q'{Bipedal, tailless form}', 3 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Manectric]', 310, 'M', nq'|Manectite|', q'|Mega|', 79 , 'Electric' , '1:1', 'Field' , 20 , 5376, 5355, 5140, 5120, 88.6, 40.2, 'Slow', q'{Quadruped body}', 3 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Vivillon]', 666 , q'|Ocean Pattern|', 22, 'Ce', 'Bug', 'Flying', '1:1', 'Bug' , 15 , 3855, 3840, 37.5, 17, 'Medium Fast', q'{Two or more pairs of wings}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Absol]', 359 , 152 , 'Dark' , '1:1', 'Field' , 25 , 6656, 6630, 6425, 6400, 103.6, 47, 'Medium Slow', q'{Quadruped body}', 3 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Sawsbuck]', 586 , q'|Winter Form|', 92 , 'Normal', 'Grass', '1:1', 'Field' , 20 , 5140, 5120, 203.9, 92.5, 'Medium Fast', q'{Quadruped body}', 5 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Gardevoir]', 282, 'M', nq'|Gardevoirite|', q'|Mega|', 31 , 'Psychic', 'Fairy', '1:1', 'Amorphous' , 20 , 5376, 5355, 5140, 5120, 106.7, 48.4, 'Slow', q'{Bipedal, tailless form}', 3 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Silvally]', 773 , q'|Type: Flying|', 204 , 'Normal' , ':U', 'Undiscovered' , 120 , 30720, 221.6, 100.5, 'Slow', q'{Quadruped body}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Seadra]', 117 , 117 , 'Water' , '1:1', 'Water 1', 'Dragon', 20, 5120, 5376, 5355, 5140, 5120, 55.1, 25, 'Medium Fast', q'{Head and a base}', 1 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Barbaracle]', 689 , 22, 'Co', 'Rock', 'Water', '1:1', 'Water 3' , 20 , 5140, 5120, 211.6, 96, 'Medium Fast', q'{Multiple bodies}', 6 );
insert into Pokemon( NAME, DEX , CLASS , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Arceus]', 493 , q'|Type: Fighting|' , 'Normal' , ':U', 'Undiscovered' , 120 , 30855, 30840, 30720, 705.5, 320, 'Slow', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Grubbin]', 736 , 27 , 'Bug' , '1:1', 'Bug' , 15 , 3840, 9.7, 4.4, 'Medium Fast', q'{Insectoid body}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Starmie]', 121 , 121 , 'Water', 'Psychic', ':', 'Water 3' , 20, 5120, 5376, 5355, 5140, 5120, 176.4, 80, 'Slow', q'{Head and a base}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Meowth]', 52 , 52 , 'Normal' , '1:1', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 9.3, 4.2, 'Medium Fast', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Jirachi]', 385 , 201 , 'Steel', 'Psychic', ':U', 'Undiscovered' , 120 , 30976, 30855, 30840, 30720, 2.4, 1.1, 'Slow', q'{Bipedal, tailless form}', 3 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Tornadus]', 641 , q'|Incarnate Forme|', 147 , 'Flying' , '0:1U', 'Undiscovered' , 120 , 30840, 30720, 138.9, 63, 'Slow', q'{Head and arms}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Metang]', 375 , 191 , 'Steel', 'Psychic', ':', 'Mineral' , 40 , 10496, 10455, 10280, 10240, 446.4, 202.5, 'Slow', q'{Head and arms}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Whismur]', 293 , 45 , 'Normal' , '1:1', 'Monster', 'Field', 20 , 5376, 5355, 5140, 5120, 35.9, 16.3, 'Medium Slow', q'{Bipedal, tailed form}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Jynx]', 124 , 124 , 'Ice', 'Psychic', '1:0', 'Human-Like' , 25, 6400, 6656, 6630, 6425, 6400, 89.5, 40.6, 'Medium Fast', q'{Bipedal, tailless form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Spoink]', 325 , 110 , 'Psychic' , '1:1', 'Field' , 20 , 5376, 5355, 5140, 5120, 67.5, 30.6, 'Fast', q'{Head and arms}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Marill]', 183 , 132 , 'Water', 'Fairy', '1:1', 'Water 1', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 18.7, 8.5, 'Fast', q'{Bipedal, tailed form}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Arbok]', 24 , 24 , 'Poison' , '1:1', 'Field', 'Dragon', 20, 5120, 5376, 5355, 5140, 5120, 143.3, 65, 'Medium Fast', q'{Serpentine bodies}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Cloyster]', 91 , 91 , 'Water', 'Ice', '1:1', 'Water 3' , 20, 5120, 5376, 5355, 5140, 5120, 292.1, 132.5, 'Slow', q'{Head}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Mudbray]', 749 , 132 , 'Ground' , '1:1', 'Field' , 20 , 5120, 242.5, 110, 'Medium Fast', q'{Quadruped body}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Croconaw]', 159 , 8 , 'Water' , '1:7', 'Monster', 'Water 1', 20, 5120, 5376, 5355, 5140, 5120, 55.1, 25, 'Medium Slow', q'{Bipedal, tailed form}', 2 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Yveltal]', 717 , 149, 'Mo', 'Dark', 'Flying', ':U', 'Undiscovered' , 120 , 30840, 30720, 447.5, 203, 'Slow', q'{Single pair of wings}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Hydreigon]', 635 , 141 , 'Dark', 'Dragon', '1:1', 'Dragon' , 40 , 10280, 10240, 352.7, 160, 'Slow', q'{Bipedal, tailed form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Rayquaza]', 384 , 200 , 'Dragon', 'Flying', ':U', 'Undiscovered' , 120 , 30976, 30855, 30840, 30720, 455.2, 206.5, 'Slow', q'{Serpentine bodies}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Scrafty]', 560 , 66 , 'Dark', 'Fighting', '1:1', 'Field', 'Dragon', 15 , 3855, 3840, 66.1, 30, 'Medium Fast', q'{Bipedal, tailed form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Brionne]', 729 , 8 , 'Water' , '1:7', 'Water 1', 'Field', 15 , 3840, 38.6, 17.5, 'Medium Slow', q'{Fins}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Snorunt]', 361 , 171 , 'Ice' , '1:1', 'Fairy', 'Mineral', 20 , 5376, 5355, 5140, 5120, 37, 16.8, 'Medium Fast', q'{Bipedal, tailless form}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Snubbull]', 209 , 125 , 'Fairy' , '3:1', 'Field', 'Fairy', 20, 5120, 5376, 5355, 5140, 5120, 17.2, 7.8, 'Fast', q'{Bipedal, tailless form}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Snover]', 459 , 142 , 'Grass', 'Ice', '1:1', 'Monster', 'Grass', 20 , 5355, 5140, 5120, 111.3, 50.5, 'Slow', q'{Bipedal, tailed form}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Swellow]', 277 , 26 , 'Normal', 'Flying', '1:1', 'Flying' , 15 , 4096, 4080, 3855, 3840, 43.7, 19.8, 'Medium Slow', q'{Single pair of wings}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Kingler]', 99 , 99 , 'Water' , '1:1', 'Water 3' , 20, 5120, 5376, 5355, 5140, 5120, 132.3, 60, 'Medium Fast', q'{Insectoid body}', 1 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Abomasnow]', 460, 'M', nq'|Abomasite|', q'|Mega|', 143 , 'Grass', 'Ice', '1:1', 'Monster', 'Grass', 20 , 5355, 5140, 5120, 298.7, 135.5, 'Slow', q'{Bipedal, tailed form}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Ampharos]', 181 , 55 , 'Electric' , '1:1', 'Monster', 'Field', 20, 5120, 5376, 5355, 5140, 5120, 135.6, 61.5, 'Medium Slow', q'{Bipedal, tailed form}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Seaking]', 119 , 119 , 'Water' , '1:1', 'Water 2' , 20, 5120, 5376, 5355, 5140, 5120, 86, 39, 'Medium Fast', q'{Fins}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Wooper]', 194 , 56 , 'Water', 'Ground', '1:1', 'Water 1', 'Field', 20, 5120, 5376, 5355, 5140, 5120, 18.7, 8.5, 'Medium Fast', q'{Head and legs}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Shuckle]', 213 , 168 , 'Bug', 'Rock', '1:1', 'Bug' , 20, 5120, 5376, 5355, 5140, 5120, 45.2, 20.5, 'Medium Slow', q'{Insectoid body}', 2 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Rotom]', 479 , q'|Frost|', 152 , 'Electric', 'Ghost', ':', 'Amorphous' , 20 , 5355, 5140, 5120, 0.7, 0.3, 'Medium Fast', q'{Head}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Baltoy]', 343 , 131 , 'Ground', 'Psychic', ':', 'Mineral' , 20 , 5376, 5355, 5140, 5120, 47.4, 21.5, 'Medium Fast', q'{Head and arms}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Woobat]', 527 , 33 , 'Psychic', 'Flying', '1:1', 'Field', 'Flying', 15 , 3855, 3840, 4.6, 2.1, 'Medium Fast', q'{Single pair of wings}', 5 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Mewtwo]', 150, 'MX' , q'|Mega  X|', 150 , 'Psychic' , ':U', 'Undiscovered' , 120, 30720, 30976, 30855, 30840, 30720, 269, 122, 'Slow', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Heracross]', 214 , 114 , 'Bug', 'Fighting', '1:1', 'Bug' , 25, 6400, 6656, 6630, 6425, 6400, 119, 54, 'Slow', q'{Bipedal, tailless form}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Piplup]', 393 , 7 , 'Water' , '1:7', 'Water 1', 'Field', 20 , 5355, 5140, 5120, 11.5, 5.2, 'Medium Slow', q'{Bipedal, tailless form}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Vulpix]', 37 , 37 , 'Fire' , '3:1', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 21.8, 9.9, 'Medium Fast', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Feraligatr]', 160 , 9 , 'Water' , '1:7', 'Monster', 'Water 1', 20, 5120, 5376, 5355, 5140, 5120, 195.8, 88.8, 'Medium Slow', q'{Bipedal, tailed form}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Murkrow]', 198 , 213 , 'Dark', 'Flying', '1:1', 'Flying' , 20, 5120, 5376, 5355, 5140, 5120, 4.6, 2.1, 'Medium Slow', q'{Single pair of wings}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Audino]', 531 , 37 , 'Normal' , '1:1', 'Fairy' , 20 , 5140, 5120, 68.3, 31, 'Fast', q'{Bipedal, tailed form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Wynaut]', 360 , 160 , 'Psychic' , '1:1U', 'Undiscovered' , 20 , 5376, 5355, 5140, 5120, 30.9, 14, 'Medium Fast', q'{Bipedal, tailed form}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Carnivine]', 455 , 131 , 'Grass' , '1:1', 'Grass' , 25 , 6630, 6425, 6400, 59.5, 27, 'Slow', q'{Tentacles or a multiped body}', 4 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Florges]', 671 , q'|Blue Flower|', 70, 'Ce', 'Fairy' , '1:0', 'Fairy' , 20 , 5140, 5120, 22, 10, 'Medium Fast', q'{Head and arms}', 6 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Zekrom]', 644 , q'|Overdrive mode|', 150 , 'Dragon', 'Electric', ':U', 'Undiscovered' , 120 , 30840, 30720, 760.6, 345, 'Slow', q'{Bipedal, tailed form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Prinplup]', 394 , 8 , 'Water' , '1:7', 'Water 1', 'Field', 20 , 5355, 5140, 5120, 50.7, 23, 'Medium Slow', q'{Bipedal, tailed form}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Camerupt]', 323 , 102 , 'Fire', 'Ground', '1:1', 'Field' , 20 , 5376, 5355, 5140, 5120, 485, 220, 'Medium Fast', q'{Quadruped body}', 3 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Deoxys]', 386, 'A' , q'|Attack Forme|', 202 , 'Psychic' , ':U', 'Undiscovered' , 120 , 30976, 30855, 30840, 30720, 134, 60.8, 'Slow', q'{Bipedal, tailless form}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Chingling]', 433 , 82 , 'Psychic' , '1:1U', 'Undiscovered' , 25 , 6630, 6425, 6400, 1.3, 0.6, 'Fast', q'{Bipedal, tailless form}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Crawdaunt]', 342 , 130 , 'Water', 'Dark', '1:1', 'Water 1', 'Water 3', 15 , 4096, 4080, 3855, 3840, 72.3, 32.8, 'Fluctuating', q'{Insectoid body}', 3 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Diancie]', 719, 'M', nq'|Diancite|', q'|Mega|', 151, 'Ce', 'Rock', 'Fairy', ':U', 'Undiscovered' , 25 , 6425, 6400, 19.4, 8.8, 'Slow', q'{Head and arms}', 6 );
insert into Pokemon( NAME, DEX , CLASS , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Arceus]', 493 , q'|Type: Ice|' , 'Normal' , ':U', 'Undiscovered' , 120 , 30855, 30840, 30720, 705.5, 320, 'Slow', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Sceptile]', 254, 'M', nq'|Sceptilite|', q'|Mega|', 3 , 'Grass', 'Dragon', '1:7', 'Monster', 'Dragon', 20 , 5376, 5355, 5140, 5120, 115.1, 52.2, 'Medium Slow', q'{Bipedal, tailed form}', 3 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pikachu]', 25 , q'|Partner Cap|', 25 , 'Electric' , '1:1', 'Field', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 13.2, 6, 'Medium Fast', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Steelix]', 208 , 63 , 'Steel', 'Ground', '1:1', 'Mineral' , 25, 6400, 6656, 6630, 6425, 6400, 881.8, 400, 'Medium Fast', q'{Serpentine bodies}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Victini]', 494 , 0 , 'Psychic', 'Fire', ':U', 'Undiscovered' , 120 , 30840, 30720, 8.8, 4, 'Slow', q'{Bipedal, tailless form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Porygon]', 137 , 137 , 'Normal' , ':', 'Mineral' , 20, 5120, 5376, 5355, 5140, 5120, 80.5, 36.5, 'Medium Fast', q'{Head and legs}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Lairon]', 305 , 71 , 'Steel', 'Rock', '1:1', 'Monster' , 35 , 9216, 9180, 8995, 8960, 264.6, 120, 'Slow', q'{Quadruped body}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Staraptor]', 398 , 12 , 'Normal', 'Flying', '1:1', 'Flying' , 15 , 4080, 3855, 3840, 54.9, 24.9, 'Medium Slow', q'{Single pair of wings}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Crabominable]', 740 , 60 , 'Fighting', 'Ice', '1:1', 'Water 3' , 20 , 5120, 396.8, 180, 'Medium Fast', q'{Insectoid body}', 7 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Vivillon]', 666 , q'|Marine Pattern|', 22, 'Ce', 'Bug', 'Flying', '1:1', 'Bug' , 15 , 3855, 3840, 37.5, 17, 'Medium Fast', q'{Two or more pairs of wings}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Yanmega]', 469 , 184 , 'Bug', 'Flying', '1:1', 'Bug' , 20 , 5355, 5140, 5120, 113.5, 51.5, 'Medium Fast', q'{Two or more pairs of wings}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Parasect]', 47 , 47 , 'Bug', 'Grass', '1:1', 'Bug', 'Grass', 20, 5120, 5376, 5355, 5140, 5120, 65, 29.5, 'Medium Fast', q'{Insectoid body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Blacephalon]', 806 , 393 , 'Fire', 'Ghost', ':U', 'Undiscovered' , 120 , 30720, 28.7, 13, 'Slow', q'{Bipedal, tailless form}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Marshtomp]', 259 , 8 , 'Water', 'Ground', '1:7', 'Monster', 'Water 1', 20 , 5376, 5355, 5140, 5120, 61.7, 28, 'Medium Slow', q'{Bipedal, tailed form}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Lurantis]', 754 , 144 , 'Grass' , '1:1', 'Grass' , 20 , 5120, 40.8, 18.5, 'Medium Fast', q'{Bipedal, tailless form}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Duskull]', 355 , 148 , 'Ghost' , '1:1', 'Amorphous' , 25 , 6656, 6630, 6425, 6400, 33.1, 15, 'Fast', q'{Head and arms}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Victreebel]', 71 , 71 , 'Grass', 'Poison', '1:1', 'Grass' , 20, 5120, 5376, 5355, 5140, 5120, 34.2, 15.5, 'Medium Slow', q'{Head and a base}', 1 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Lunala]', 792 , q'|Full Moon phase|', 292 , 'Psychic', 'Ghost', ':U', 'Undiscovered' , 120 , 30720, 264.6, 120, 'Slow', q'{Single pair of wings}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Tirtouga]', 564 , 70 , 'Water', 'Rock', '1:7', 'Water 1', 'Water 3', 30 , 7710, 7680, 36.4, 16.5, 'Medium Fast', q'{Quadruped body}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Cottonee]', 546 , 52 , 'Grass', 'Fairy', '1:1', 'Grass', 'Fairy', 20 , 5140, 5120, 1.3, 0.6, 'Medium Fast', q'{Head}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Gloom]', 44 , 44 , 'Grass', 'Poison', '1:1', 'Grass' , 20, 5120, 5376, 5355, 5140, 5120, 19, 8.6, 'Medium Slow', q'{Bipedal, tailless form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Bouffalant]', 626 , 132 , 'Normal' , '1:1', 'Field' , 20 , 5140, 5120, 208.3, 94.5, 'Medium Fast', q'{Quadruped body}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pheromosa]', 795 , 295 , 'Bug', 'Fighting', ':U', 'Undiscovered' , 120 , 30720, 55.1, 25, 'Slow', q'{Bipedal, tailless form}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Klinklang]', 601 , 107 , 'Steel' , ':', 'Mineral' , 20 , 5140, 5120, 178.6, 81, 'Medium Slow', q'{Multiple bodies}', 5 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Camerupt]', 323, 'M', nq'|Cameruptite|', q'|Mega|', 102 , 'Fire', 'Ground', '1:1', 'Field' , 20 , 5376, 5355, 5140, 5120, 485, 220, 'Medium Fast', q'{Quadruped body}', 3 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Silvally]', 773 , q'|Type: Bug|', 204 , 'Normal' , ':U', 'Undiscovered' , 120 , 30720, 221.6, 100.5, 'Slow', q'{Quadruped body}', 7 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Vivillon]', 666 , q'|Icy Snow Pattern|', 22, 'Ce', 'Bug', 'Flying', '1:1', 'Bug' , 15 , 3855, 3840, 37.5, 17, 'Medium Fast', q'{Two or more pairs of wings}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Budew]', 406 , 25 , 'Grass', 'Poison', '1:1U', 'Undiscovered' , 20 , 5355, 5140, 5120, 2.6, 1.2, 'Medium Slow', q'{Bipedal, tailless form}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Growlithe]', 58 , 58 , 'Fire' , '1:3', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 41.9, 19, 'Slow', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Oshawott]', 501 , 7 , 'Water' , '1:7', 'Field' , 20 , 5140, 5120, 13, 5.9, 'Medium Slow', q'{Bipedal, tailed form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Glaceon]', 471 , 170 , 'Ice' , '1:7', 'Field' , 35 , 9180, 8995, 8960, 57.1, 25.9, 'Medium Fast', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Nidoking]', 34 , 34 , 'Poison', 'Ground', '0:1', 'Monster', 'Field', 20, 5120, 5376, 5355, 5140, 5120, 136.7, 62, 'Medium Slow', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Cofagrigus]', 563 , 69 , 'Ghost' , '1:1', 'Mineral', 'Amorphous', 25 , 6425, 6400, 168.7, 76.5, 'Medium Fast', q'{Head and a base}', 5 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Vivillon]', 666 , q'|High Plains Pattern|', 22, 'Ce', 'Bug', 'Flying', '1:1', 'Bug' , 15 , 3855, 3840, 37.5, 17, 'Medium Fast', q'{Two or more pairs of wings}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Whimsicott]', 547 , 53 , 'Grass', 'Fairy', '1:1', 'Grass', 'Fairy', 20 , 5140, 5120, 14.6, 6.6, 'Medium Fast', q'{Bipedal, tailless form}', 5 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Rotom]', 479 , q'|Wash|', 152 , 'Electric', 'Ghost', ':', 'Amorphous' , 20 , 5355, 5140, 5120, 0.7, 0.3, 'Medium Fast', q'{Head}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Sigilyph]', 561 , 67 , 'Psychic', 'Flying', '1:1', 'Flying' , 20 , 5140, 5120, 30.9, 14, 'Medium Fast', q'{Single pair of wings}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Butterfree]', 12 , 12 , 'Bug', 'Flying', '1:1', 'Bug' , 15, 3840, 4096, 4080, 3855, 3840, 70.5, 32, 'Medium Fast', q'{Two or more pairs of wings}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pyukumuku]', 771 , 200 , 'Water' , '1:1', 'Water 1' , 15 , 3840, 2.6, 1.2, 'Fast', q'{Serpentine bodies}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Hitmontop]', 237 , 148 , 'Fighting' , '0:1', 'Human-Like' , 25, 6400, 6656, 6630, 6425, 6400, 105.8, 48, 'Medium Fast', q'{Bipedal, tailed form}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Scizor]', 212 , 112 , 'Bug', 'Steel', '1:1', 'Bug' , 25, 6400, 6656, 6630, 6425, 6400, 260.1, 118, 'Medium Fast', q'{Two or more pairs of wings}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Celebi]', 251 , 256 , 'Psychic', 'Grass', ':U', 'Undiscovered' , 120, 30720, 30976, 30855, 30840, 30720, 11, 5, 'Medium Slow', q'{Bipedal, tailless form}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Lopunny]', 428 , 68 , 'Normal' , '1:1', 'Field', 'Human-Like', 20 , 5355, 5140, 5120, 73.4, 33.3, 'Medium Fast', q'{Bipedal, tailed form}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Igglybuff]', 174 , 44 , 'Normal', 'Fairy', '3:1U', 'Undiscovered' , 10, 2560, 2816, 2805, 2570, 2560, 2.2, 1, 'Fast', q'{Bipedal, tailless form}', 2 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Quilladin]', 651 , 2, 'Ce', 'Grass' , '1:7', 'Field' , 20 , 5140, 5120, 63.9, 29, 'Medium Slow', q'{Bipedal, tailed form}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Metagross]', 376 , 192 , 'Steel', 'Psychic', ':', 'Mineral' , 40 , 10496, 10455, 10280, 10240, 1212.5, 550, 'Slow', q'{Multiple bodies}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Charmander]', 4 , 4 , 'Fire' , '1:7', 'Monster', 'Dragon', 20, 5120, 5376, 5355, 5140, 5120, 18.7, 8.5, 'Medium Slow', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Shellos]', 422 , q'|West Sea|', 60 , 'Water' , '1:1', 'Water 1', 'Amorphous', 20 , 5355, 5140, 5120, 13.9, 6.3, 'Medium Fast', q'{Serpentine bodies}', 4 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Rotom]', 479 , q'|Heat|', 152 , 'Electric', 'Ghost', ':', 'Amorphous' , 20 , 5355, 5140, 5120, 0.7, 0.3, 'Medium Fast', q'{Head}', 4 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Aggron]', 306, 'M', nq'|Aggronite|', q'|Mega|', 72 , 'Steel' , '1:1', 'Monster' , 35 , 9216, 9180, 8995, 8960, 793.7, 360, 'Slow', q'{Bipedal, tailed form}', 3 );
insert into Pokemon( NAME, DEX , CLASS , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Arceus]', 493 , q'|Type: Steel|' , 'Normal' , ':U', 'Undiscovered' , 120 , 30855, 30840, 30720, 705.5, 320, 'Slow', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Gulpin]', 316 , 95 , 'Poison' , '1:1', 'Amorphous' , 20 , 5376, 5355, 5140, 5120, 22.7, 10.3, 'Fluctuating', q'{Head and arms}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Persian]', 53 , 53 , 'Normal' , '1:1', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 70.5, 32, 'Medium Fast', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Litten]', 725 , 4 , 'Fire' , '1:7', 'Field' , 15 , 3840, 9.5, 4.3, 'Medium Slow', q'{Quadruped body}', 7 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pikachu]', 25 , q'|Kalos Cap|', 25 , 'Electric' , '1:1', 'Field', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 13.2, 6, 'Medium Fast', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Aegislash]', 681 , q'|Shield Forme|', 119, 'Ce', 'Steel', 'Ghost', '1:1', 'Mineral' , 20 , 5140, 5120, 116.8, 53, 'Medium Fast', q'{Head and a base}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Conkeldurr]', 534 , 40 , 'Fighting' , '1:3U', 'Human-Like' , 20 , 5140, 5120, 191.8, 87, 'Medium Slow', q'{Bipedal, tailless form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Riolu]', 447 , 115 , 'Fighting' , '1:7U', 'Undiscovered' , 25 , 6630, 6425, 6400, 44.5, 20.2, 'Medium Slow', q'{Bipedal, tailed form}', 4 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Metagross]', 376, 'M', nq'|Metagrossite|', q'|Mega|', 192 , 'Steel', 'Psychic', ':', 'Mineral' , 40 , 10496, 10455, 10280, 10240, 1212.5, 550, 'Slow', q'{Multiple bodies}', 3 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Lopunny]', 428, 'M', nq'|Lopunnite|', q'|Mega|', 68 , 'Normal', 'Fighting', '1:1', 'Field', 'Human-Like', 20 , 5355, 5140, 5120, 73.4, 33.3, 'Medium Fast', q'{Bipedal, tailed form}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Clefable]', 36 , 36 , 'Fairy' , '3:1', 'Fairy' , 10, 2560, 2816, 2805, 2570, 2560, 88.2, 40, 'Fast', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Vileplume]', 45 , 45 , 'Grass', 'Poison', '1:1', 'Grass' , 20, 5120, 5376, 5355, 5140, 5120, 41, 18.6, 'Medium Slow', q'{Bipedal, tailless form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Kabutops]', 141 , 141 , 'Rock', 'Water', '1:7', 'Water 1', 'Water 3', 30, 7680, 7936, 7905, 7710, 7680, 89.3, 40.5, 'Medium Fast', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Basculin]', 550, 'B' , q'|Blue-Striped Form|', 56 , 'Water' , '1:1', 'Water 2' , 40 , 10280, 10240, 39.7, 18, 'Medium Fast', q'{Fins}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Crustle]', 558 , 64 , 'Bug', 'Rock', '1:1', 'Bug', 'Mineral', 20 , 5140, 5120, 440.9, 200, 'Medium Fast', q'{Insectoid body}', 5 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Necrozma]', 800, 'U' , q'|Ultra|', 300 , 'Psychic' , ':U', 'Undiscovered' , 120 , 30720, 507.1, 230, 'Slow', q'{Two or more pairs of wings}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Bidoof]', 399 , 13 , 'Normal' , '1:1', 'Water 1', 'Field', 15 , 4080, 3855, 3840, 44.1, 20, 'Medium Fast', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Glalie]', 362 , 172 , 'Ice' , '1:1', 'Fairy', 'Mineral', 20 , 5376, 5355, 5140, 5120, 565.5, 256.5, 'Medium Fast', q'{Head}', 3 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Lucario]', 448, 'M', nq'|Lucarionite|', q'|Mega|', 116 , 'Fighting', 'Steel', '1:7', 'Field', 'Human-Like', 25 , 6630, 6425, 6400, 119, 54, 'Medium Slow', q'{Bipedal, tailed form}', 4 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Oricorio]', 741 , q'|Pa'u Style|', 82 , 'Fire', 'Flying', '3:1', 'Flying' , 20 , 5120, 7.5, 3.4, 'Medium Fast', q'{Single pair of wings}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Salamence]', 373 , 189 , 'Dragon', 'Flying', '1:1', 'Dragon' , 40 , 10496, 10455, 10280, 10240, 226.2, 102.6, 'Slow', q'{Quadruped body}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Armaldo]', 348 , 136 , 'Rock', 'Bug', '1:7', 'Water 3' , 30 , 7936, 7905, 7710, 7680, 150.4, 68.2, 'Erratic', q'{Bipedal, tailed form}', 3 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Floette]', 670 , q'|Orange Flower|', 69, 'Ce', 'Fairy' , '1:0', 'Fairy' , 20 , 5140, 5120, 2, 0.9, 'Medium Fast', q'{Head and arms}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Steenee]', 762 , 172 , 'Grass' , '1:0', 'Grass' , 20 , 5120, 18.1, 8.2, 'Medium Slow', q'{Bipedal, tailless form}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Aggron]', 306 , 72 , 'Steel', 'Rock', '1:1', 'Monster' , 35 , 9216, 9180, 8995, 8960, 793.7, 360, 'Slow', q'{Bipedal, tailed form}', 3 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Furfrou]', 676 , q'|Kabuki Trim|', 93, 'Ce', 'Normal' , '1:1', 'Field' , 20 , 5140, 5120, 61.7, 28, 'Medium Fast', q'{Quadruped body}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Swalot]', 317 , 96 , 'Poison' , '1:1', 'Amorphous' , 20 , 5376, 5355, 5140, 5120, 176.4, 80, 'Fluctuating', q'{Head and arms}', 3 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Basculin]', 550 , q'|Red-Striped Form|', 56 , 'Water' , '1:1', 'Water 2' , 40 , 10280, 10240, 39.7, 18, 'Medium Fast', q'{Fins}', 5 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pancham]', 674 , 91, 'Ce', 'Fighting' , '1:1', 'Field', 'Human-Like', 25 , 6425, 6400, 17.6, 8, 'Medium Fast', q'{Bipedal, tailed form}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Gligar]', 207 , 193 , 'Ground', 'Flying', '1:1', 'Bug' , 20, 5120, 5376, 5355, 5140, 5120, 142.9, 64.8, 'Medium Slow', q'{Single pair of wings}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Articuno]', 144 , 144 , 'Ice', 'Flying', ':U', 'Undiscovered' , 80, 20480, 20736, 20655, 20560, 20480, 122.1, 55.4, 'Slow', q'{Single pair of wings}', 1 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Clauncher]', 692 , 32, 'Co', 'Water' , '1:1', 'Water 1', 'Water 3', 15 , 3855, 3840, 18.3, 8.3, 'Slow', q'{Insectoid body}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Excadrill]', 530 , 36 , 'Ground', 'Steel', '1:1', 'Field' , 20 , 5140, 5120, 89.1, 40.4, 'Medium Fast', q'{Bipedal, tailless form}', 5 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pikachu]', 25 , q'|Hoenn Cap|', 25 , 'Electric' , '1:1', 'Field', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 13.2, 6, 'Medium Fast', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Tornadus]', 641, 'T' , q'|Therian Forme|', 147 , 'Flying' , '0:1U', 'Undiscovered' , 120 , 30840, 30720, 138.9, 63, 'Slow', q'{Single pair of wings}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Loudred]', 294 , 46 , 'Normal' , '1:1', 'Monster', 'Field', 20 , 5376, 5355, 5140, 5120, 89.3, 40.5, 'Medium Slow', q'{Bipedal, tailed form}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Kangaskhan]', 115 , 115 , 'Normal' , '1:0', 'Monster' , 20, 5120, 5376, 5355, 5140, 5120, 176.4, 80, 'Medium Fast', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Vullaby]', 629 , 135 , 'Dark', 'Flying', '1:0', 'Flying' , 20 , 5140, 5120, 19.8, 9, 'Slow', q'{Single pair of wings}', 5 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Delphox]', 655 , 6, 'Ce', 'Fire', 'Psychic', '1:7', 'Field' , 20 , 5140, 5120, 86, 39, 'Medium Slow', q'{Bipedal, tailed form}', 6 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Charizard]', 6, 'MY' , q'|Mega  Y|', 6 , 'Fire', 'Flying', '1:7', 'Monster', 'Dragon', 20, 5120, 5376, 5355, 5140, 5120, 199.5, 90.5, 'Medium Slow', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Virizion]', 640 , 146 , 'Grass', 'Fighting', ':U', 'Undiscovered' , 80 , 20560, 20480, 440.9, 200, 'Slow', q'{Quadruped body}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Mienfoo]', 619 , 125 , 'Fighting' , '1:1', 'Field', 'Human-Like', 25 , 6425, 6400, 44.1, 20, 'Medium Slow', q'{Bipedal, tailed form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Dialga]', 483 , 149 , 'Steel', 'Dragon', ':U', 'Undiscovered' , 120 , 30855, 30840, 30720, 1505.8, 683, 'Slow', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Croagunk]', 453 , 129 , 'Poison', 'Fighting', '1:1', 'Human-Like' , 10 , 2805, 2570, 2560, 50.7, 23, 'Medium Fast', q'{Bipedal, tailless form}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Meganium]', 154 , 3 , 'Grass' , '1:7', 'Monster', 'Grass', 20, 5120, 5376, 5355, 5140, 5120, 221.6, 100.5, 'Medium Slow', q'{Quadruped body}', 2 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Furfrou]', 676 , q'|Debutante Trim|', 93, 'Ce', 'Normal' , '1:1', 'Field' , 20 , 5140, 5120, 61.7, 28, 'Medium Fast', q'{Quadruped body}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Dragonite]', 149 , 149 , 'Dragon', 'Flying', '1:1', 'Water 1', 'Dragon', 40, 10240, 10496, 10455, 10280, 10240, 463, 210, 'Slow', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pidgeotto]', 17 , 17 , 'Normal', 'Flying', '1:1', 'Flying' , 15, 3840, 4096, 4080, 3855, 3840, 66.1, 30, 'Medium Slow', q'{Single pair of wings}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Ambipom]', 424 , 64 , 'Normal' , '1:1', 'Field' , 20 , 5355, 5140, 5120, 44.8, 20.3, 'Fast', q'{Bipedal, tailed form}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Tepig]', 498 , 4 , 'Fire' , '1:7', 'Field' , 20 , 5140, 5120, 21.8, 9.9, 'Medium Slow', q'{Quadruped body}', 5 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Castform]', 351, 'S' , q'|Sunny Form|', 142 , 'Fire' , '1:1', 'Fairy', 'Amorphous', 25 , 6656, 6630, 6425, 6400, 1.8, 0.8, 'Medium Fast', q'{Head}', 3 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Floette]', 670 , q'|Yellow Flower|', 69, 'Ce', 'Fairy' , '1:0', 'Fairy' , 20 , 5140, 5120, 2, 0.9, 'Medium Fast', q'{Head and arms}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Omanyte]', 138 , 138 , 'Rock', 'Water', '1:7', 'Water 1', 'Water 3', 30, 7680, 7936, 7905, 7710, 7680, 16.5, 7.5, 'Medium Fast', q'{Tentacles or a multiped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Aurorus]', 699 , 67, 'Co', 'Rock', 'Ice', '1:7', 'Monster' , 30 , 7710, 7680, 496, 225, 'Medium Fast', q'{Quadruped body}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Toxicroak]', 454 , 130 , 'Poison', 'Fighting', '1:1', 'Human-Like' , 20 , 5355, 5140, 5120, 97.9, 44.4, 'Medium Fast', q'{Bipedal, tailless form}', 4 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pikachu]', 25 , q'|Rock Star|', 25 , 'Electric' , '1:1', 'Field', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 13.2, 6, 'Medium Fast', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Lapras]', 131 , 131 , 'Water', 'Ice', '1:1', 'Monster', 'Water 1', 40, 10240, 10496, 10455, 10280, 10240, 485, 220, 'Slow', q'{Fins}', 1 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Meowth]', 52, 'A' , q'|Alolan|' , 'Dark' , '1:1', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 9.3, 4.2, 'Medium Fast', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Stakataka]', 805 , 392 , 'Rock', 'Steel', ':U', 'Undiscovered' , 120 , 30720, 1807.8, 820, 'Slow', q'{Quadruped body}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Wurmple]', 265 , 14 , 'Bug' , '1:1', 'Bug' , 15 , 4096, 4080, 3855, 3840, 7.9, 3.6, 'Medium Fast', q'{Insectoid body}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Shedinja]', 292 , 44 , 'Bug', 'Ghost', ':', 'Mineral' , 15 , 4096, 4080, 3855, 3840, 2.6, 1.2, 'Erratic', q'{Head and a base}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pikipek]', 731 , 10 , 'Normal', 'Flying', '1:1', 'Flying' , 15 , 3840, 2.6, 1.2, 'Medium Fast', q'{Single pair of wings}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Lickitung]', 108 , 108 , 'Normal' , '1:1', 'Monster' , 20, 5120, 5376, 5355, 5140, 5120, 144.4, 65.5, 'Medium Fast', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Furfrou]', 676 , q'|Dandy Trim|', 93, 'Ce', 'Normal' , '1:1', 'Field' , 20 , 5140, 5120, 61.7, 28, 'Medium Fast', q'{Quadruped body}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Weedle]', 13 , 13 , 'Bug', 'Poison', '1:1', 'Bug' , 15, 3840, 4096, 4080, 3855, 3840, 7.1, 3.2, 'Medium Fast', q'{Insectoid body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Houndour]', 228 , 214 , 'Dark', 'Fire', '1:1', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 23.8, 10.8, 'Slow', q'{Quadruped body}', 2 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Froakie]', 656 , 7, 'Ce', 'Water' , '1:7', 'Water 1' , 20 , 5140, 5120, 15.4, 7, 'Medium Slow', q'{Quadruped body}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Fomantis]', 753 , 143 , 'Grass' , '1:1', 'Grass' , 20 , 5120, 3.3, 1.5, 'Medium Fast', q'{Bipedal, tailed form}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Togekiss]', 468 , 175 , 'Fairy', 'Flying', '1:7', 'Flying', 'Fairy', 10 , 2805, 2570, 2560, 83.8, 38, 'Fast', q'{Single pair of wings}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Exploud]', 295 , 47 , 'Normal' , '1:1', 'Monster', 'Field', 20 , 5376, 5355, 5140, 5120, 185.2, 84, 'Medium Slow', q'{Bipedal, tailed form}', 3 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Avalugg]', 713 , 80, 'Mo', 'Ice' , '1:1', 'Monster' , 20 , 5140, 5120, 1113.3, 505, 'Medium Fast', q'{Quadruped body}', 6 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pikachu]', 25 , q'|Cosplay|', 25 , 'Electric' , '1:1', 'Field', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 13.2, 6, 'Medium Fast', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Skitty]', 300 , 61 , 'Normal' , '3:1', 'Field', 'Fairy', 15 , 4096, 4080, 3855, 3840, 24.3, 11, 'Fast', q'{Quadruped body}', 3 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Wishiwashi]', 746, 'Sc' , q'|School Form|', 110 , 'Water' , '1:1', 'Water 2' , 15 , 3840, 173.3, 78.6, 'Fast', q'{Fins}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Forretress]', 205 , 94 , 'Bug', 'Steel', '1:1', 'Bug' , 20, 5120, 5376, 5355, 5140, 5120, 277.3, 125.8, 'Medium Fast', q'{Head}', 2 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Phantump]', 708 , 61, 'Mo', 'Ghost', 'Grass', '1:1', 'Grass', 'Amorphous', 20 , 5140, 5120, 15.4, 7, 'Medium Fast', q'{Head and arms}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Illumise]', 314 , 87 , 'Bug' , '1:0', 'Bug', 'Human-Like', 15 , 4096, 4080, 3855, 3840, 39, 17.7, 'Fluctuating', q'{Bipedal, tailless form}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Mew]', 151 , 151 , 'Psychic' , ':U', 'Undiscovered' , 120, 30720, 30976, 30855, 30840, 30720, 8.8, 4, 'Medium Slow', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Muk]', 89, 'A' , q'|Alolan|' , 'Poison', 'Dark', '1:1', 'Amorphous' , 20, 5120, 5376, 5355, 5140, 5120, 66.1, 30, 'Medium Fast', q'{Head and arms}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Houndoom]', 229 , 215 , 'Dark', 'Fire', '1:1', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 77.2, 35, 'Slow', q'{Quadruped body}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Seviper]', 336 , 124 , 'Poison' , '1:1', 'Field', 'Dragon', 20 , 5376, 5355, 5140, 5120, 115.7, 52.5, 'Fluctuating', q'{Serpentine bodies}', 3 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Thundurus]', 642, 'T' , q'|Therian Forme|', 148 , 'Electric', 'Flying', '0:1U', 'Undiscovered' , 120 , 30840, 30720, 134.5, 61, 'Slow', q'{Bipedal, tailed form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Psyduck]', 54 , 54 , 'Water' , '1:1', 'Water 1', 'Field', 20, 5120, 5376, 5355, 5140, 5120, 43.2, 19.6, 'Medium Fast', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Alomomola]', 594 , 100 , 'Water' , '1:1', 'Water 1', 'Water 2', 40 , 10280, 10240, 69.7, 31.6, 'Fast', q'{Fins}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Rotom]', 479 , 152 , 'Electric', 'Ghost', ':', 'Amorphous' , 20 , 5355, 5140, 5120, 0.7, 0.3, 'Medium Fast', q'{Head}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Maractus]', 556 , 62 , 'Grass' , '1:1', 'Grass' , 20 , 5140, 5120, 61.7, 28, 'Medium Fast', q'{Head and a base}', 5 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Xerneas]', 716 , q'|Neutral Mode|', 148, 'Mo', 'Fairy' , ':U', 'Undiscovered' , 120 , 30840, 30720, 474, 215, 'Slow', q'{Quadruped body}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Sealeo]', 364 , 174 , 'Ice', 'Water', '1:1', 'Water 1', 'Field', 20 , 5376, 5355, 5140, 5120, 193.1, 87.6, 'Medium Slow', q'{Fins}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Reshiram]', 643 , 149 , 'Dragon', 'Fire', ':U', 'Undiscovered' , 120 , 30840, 30720, 727.5, 330, 'Slow', q'{Single pair of wings}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Unown]', 201 , 61 , 'Psychic' , ':U', 'Undiscovered' , 40, 10240, 10496, 10455, 10280, 10240, 11, 5, 'Medium Fast', q'{Head}', 2 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Grimer]', 88, 'A' , q'|Alolan|' , 'Poison', 'Dark', '1:1', 'Amorphous' , 20, 5120, 5376, 5355, 5140, 5120, 66.1, 30, 'Medium Fast', q'{Head and arms}', 1 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Unfezant]', 521, 'F' , 27 , 'Normal', 'Flying', '1:1', 'Flying' , 15 , 3855, 3840, 63.9, 29, 'Medium Slow', q'{Single pair of wings}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Wigglytuff]', 40 , 40 , 'Normal', 'Fairy', '3:1', 'Fairy' , 10, 2560, 2816, 2805, 2570, 2560, 26.5, 12, 'Fast', q'{Bipedal, tailless form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Mightyena]', 262 , 11 , 'Dark' , '1:1', 'Field' , 15 , 4096, 4080, 3855, 3840, 81.6, 37, 'Medium Fast', q'{Quadruped body}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Archeops]', 567 , 73 , 'Rock', 'Flying', '1:7', 'Flying', 'Water 3', 30 , 7710, 7680, 70.5, 32, 'Medium Fast', q'{Single pair of wings}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Barboach]', 339 , 127 , 'Water', 'Ground', '1:1', 'Water 2' , 20 , 5376, 5355, 5140, 5120, 4.2, 1.9, 'Medium Fast', q'{Fins}', 3 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Noibat]', 714 , 113, 'Mo', 'Flying', 'Dragon', '1:1', 'Flying' , 20 , 5140, 5120, 17.6, 8, 'Medium Fast', q'{Single pair of wings}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Turtwig]', 387 , 1 , 'Grass' , '1:7', 'Monster', 'Grass', 20 , 5355, 5140, 5120, 22.5, 10.2, 'Medium Slow', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Mudkip]', 258 , 7 , 'Water' , '1:7', 'Monster', 'Water 1', 20 , 5376, 5355, 5140, 5120, 16.8, 7.6, 'Medium Slow', q'{Quadruped body}', 3 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Binacle]', 688 , 21, 'Co', 'Rock', 'Water', '1:1', 'Water 3' , 20 , 5140, 5120, 68.3, 31, 'Medium Fast', q'{Multiple bodies}', 6 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Gourgeist]', 711 , q'|Average Size|', 64, 'Mo', 'Ghost', 'Grass', '1:1', 'Amorphous' , 20 , 5140, 5120, 27.6, 12.5, 'Medium Fast', q'{Head and a base}', 6 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Bunnelby]', 659 , 10, 'Ce', 'Normal' , '1:1', 'Field' , 15 , 3855, 3840, 11, 5, 'Medium Fast', q'{Bipedal, tailed form}', 6 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Jellicent]', 593, 'F' , 99 , 'Water', 'Ghost', '1:1', 'Amorphous' , 20 , 5140, 5120, 297.6, 135, 'Medium Fast', q'{Tentacles or a multiped body}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Spinda]', 327 , 114 , 'Normal' , '1:1', 'Field', 'Human-Like', 15 , 4096, 4080, 3855, 3840, 11, 5, 'Fast', q'{Bipedal, tailed form}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Gastly]', 92 , 92 , 'Ghost', 'Poison', '1:1', 'Amorphous' , 20, 5120, 5376, 5355, 5140, 5120, 0.2, 0.1, 'Medium Slow', q'{Head}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Stoutland]', 508 , 14 , 'Normal' , '1:1', 'Field' , 15 , 3855, 3840, 134.5, 61, 'Medium Slow', q'{Quadruped body}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Dusknoir]', 477 , 191 , 'Ghost' , '1:1', 'Amorphous' , 25 , 6630, 6425, 6400, 235, 106.6, 'Fast', q'{Head and arms}', 4 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Blastoise]', 9, 'M', nq'|Blastoisinite|', q'|Mega|', 9 , 'Water' , '1:7', 'Monster', 'Water 1', 20, 5120, 5376, 5355, 5140, 5120, 188.5, 85.5, 'Medium Slow', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Kangaskhan]', 115, 'M', nq'|Kangaskhanite|', q'|Mega|', 115 , 'Normal' , '1:0', 'Monster' , 20, 5120, 5376, 5355, 5140, 5120, 176.4, 80, 'Medium Fast', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS, LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Zygarde]', 718, 'T' , q'|10% Forme|', 150, 'Mo', 'Dragon', 'Ground', ':U', 'Undiscovered' , 120 , 30840, 30720, 73.9, 33.5, 'Slow', q'{Quadruped body}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Cleffa]', 173 , 40 , 'Fairy' , '3:1U', 'Undiscovered' , 10, 2560, 2816, 2805, 2570, 2560, 6.6, 3, 'Fast', q'{Bipedal, tailed form}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Torkoal]', 324 , 105 , 'Fire' , '1:1', 'Field' , 20 , 5376, 5355, 5140, 5120, 177.2, 80.4, 'Medium Fast', q'{Quadruped body}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pupitar]', 247 , 250 , 'Rock', 'Ground', '1:1', 'Monster' , 40, 10240, 10496, 10455, 10280, 10240, 335.1, 152, 'Slow', q'{Serpentine bodies}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pidove]', 519 , 25 , 'Normal', 'Flying', '1:1', 'Flying' , 15 , 3855, 3840, 4.6, 2.1, 'Medium Slow', q'{Single pair of wings}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Tapu Fini]', 788 , 288 , 'Water', 'Fairy', ':U', 'Undiscovered' , 15 , 3840, 46.7, 21.2, 'Slow', q'{Head and arms}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Glameow]', 431 , 76 , 'Normal' , '3:1', 'Field' , 20 , 5355, 5140, 5120, 8.6, 3.9, 'Fast', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Wailord]', 321 , 100 , 'Water' , '1:1', 'Field', 'Water 2', 40 , 10496, 10455, 10280, 10240, 877.4, 398, 'Fluctuating', q'{Fins}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Comfey]', 764 , 174 , 'Fairy' , '3:1', 'Grass' , 20 , 5120, 0.7, 0.3, 'Fast', q'{Head}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Golisopod]', 768 , 183 , 'Bug', 'Water', '1:1', 'Bug', 'Water 3', 20 , 5120, 238.1, 108, 'Medium Fast', q'{Bipedal, tailless form}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Panpour]', 515 , 21 , 'Water' , '1:7', 'Field' , 20 , 5140, 5120, 29.8, 13.5, 'Medium Fast', q'{Bipedal, tailed form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Naganadel]', 804 , 262 , 'Poison', 'Dragon', ':U', 'Undiscovered' , 120 , 30720, 330.7, 150, 'Slow', q'{Single pair of wings}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Relicanth]', 369 , 179 , 'Water', 'Rock', '1:7', 'Water 1', 'Water 2', 40 , 10496, 10455, 10280, 10240, 51.6, 23.4, 'Slow', q'{Fins}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Sandshrew]', 27 , 27 , 'Ground' , '1:1', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 26.5, 12, 'Medium Fast', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Flabébé]', 669 , q'|Yellow Flower|', 68, 'Ce', 'Fairy' , '1:0', 'Fairy' , 20 , 5140, 5120, 0.2, 0.1, 'Medium Fast', q'{Head and arms}', 6 );
insert into Pokemon( NAME, DEX , CLASS , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Arceus]', 493 , q'|Type: Electric|' , 'Normal' , ':U', 'Undiscovered' , 120 , 30855, 30840, 30720, 705.5, 320, 'Slow', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Sableye]', 302, 'M', nq'|Sablenite|', q'|Mega|', 68 , 'Dark', 'Ghost', '1:1', 'Human-Like' , 25 , 6656, 6630, 6425, 6400, 24.3, 11, 'Medium Slow', q'{Bipedal, tailless form}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Grovyle]', 253 , 2 , 'Grass' , '1:7', 'Monster', 'Dragon', 20 , 5376, 5355, 5140, 5120, 47.6, 21.6, 'Medium Slow', q'{Bipedal, tailed form}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Nidorino]', 33 , 33 , 'Poison' , '0:1', 'Monster', 'Field', 20, 5120, 5376, 5355, 5140, 5120, 43, 19.5, 'Medium Slow', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Hippopotas]', 449 , 122 , 'Ground' , '1:1', 'Field' , 30 , 7905, 7710, 7680, 109.1, 49.5, 'Slow', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Simipour]', 516 , 22 , 'Water' , '1:7', 'Field' , 20 , 5140, 5120, 63.9, 29, 'Medium Fast', q'{Bipedal, tailed form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Omastar]', 139 , 139 , 'Rock', 'Water', '1:7', 'Water 1', 'Water 3', 30, 7680, 7936, 7905, 7710, 7680, 77.2, 35, 'Medium Fast', q'{Tentacles or a multiped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Stunfisk]', 618 , 124 , 'Ground', 'Electric', '1:1', 'Water 1', 'Amorphous', 20 , 5140, 5120, 24.3, 11, 'Medium Fast', q'{Fins}', 5 );
insert into Pokemon( NAME, DEX , CLASS , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Arceus]', 493 , q'|Type: Poison|' , 'Normal' , ':U', 'Undiscovered' , 120 , 30855, 30840, 30720, 705.5, 320, 'Slow', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Muk]', 89 , 89 , 'Poison' , '1:1', 'Amorphous' , 20, 5120, 5376, 5355, 5140, 5120, 66.1, 30, 'Medium Fast', q'{Head and arms}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Krokorok]', 552 , 58 , 'Ground', 'Dark', '1:1', 'Field' , 20 , 5140, 5120, 73.6, 33.4, 'Medium Slow', q'{Quadruped body}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Slaking]', 289 , 38 , 'Normal' , '1:1', 'Field' , 15 , 4096, 4080, 3855, 3840, 287.7, 130.5, 'Slow', q'{Bipedal, tailless form}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Caterpie]', 10 , 10 , 'Bug' , '1:1', 'Bug' , 15, 3840, 4096, 4080, 3855, 3840, 6.4, 2.9, 'Medium Fast', q'{Insectoid body}', 1 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Castform]', 351 , q'|Normal|', 142 , 'Normal' , '1:1', 'Fairy', 'Amorphous', 25 , 6656, 6630, 6425, 6400, 1.8, 0.8, 'Medium Fast', q'{Head}', 3 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS, LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Hoopa]', 720, 'U' , q'|Unbound|', 152, 'Ce', 'Psychic', 'Dark', ':U', 'Undiscovered' , 120 , 30840, 30720, 1080.3, 490, 'Slow', q'{Bipedal, tailed form}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Magneton]', 82 , 82 , 'Electric', 'Steel', ':', 'Mineral' , 20, 5120, 5376, 5355, 5140, 5120, 132.3, 60, 'Medium Fast', q'{Multiple bodies}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Kingdra]', 230 , 192 , 'Water', 'Dragon', '1:1', 'Water 1', 'Dragon', 20, 5120, 5376, 5355, 5140, 5120, 335.1, 152, 'Medium Fast', q'{Head and a base}', 2 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Golem]', 76, 'A' , q'|Alolan|' , 'Rock', 'Electric', '1:1', 'Mineral' , 15, 3840, 4096, 4080, 3855, 3840, 661.4, 300, 'Medium Slow', q'{Bipedal, tailless form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Azumarill]', 184 , 133 , 'Water', 'Fairy', '1:1', 'Water 1', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 62.8, 28.5, 'Fast', q'{Bipedal, tailed form}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Vaporeon]', 134 , 134 , 'Water' , '1:7', 'Field' , 35, 8960, 9216, 9180, 8995, 8960, 63.9, 29, 'Medium Fast', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pyroar]', 668 , 58, 'Ce', 'Fire', 'Normal', '7:1', 'Field' , 20 , 5140, 5120, 179.7, 81.5, 'Medium Slow', q'{Quadruped body}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Delibird]', 225 , 194 , 'Ice', 'Flying', '1:1', 'Water 1', 'Field', 20, 5120, 5376, 5355, 5140, 5120, 35.3, 16, 'Fast', q'{Single pair of wings}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Ditto]', 132 , 132 , 'Normal' , ':*', 'Ditto' , 20, 5120, 5376, 5355, 5140, 5120, 8.8, 4, 'Medium Fast', q'{Head}', 1 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Wishiwashi]', 746 , q'|Solo Form|', 110 , 'Water' , '1:1', 'Water 2' , 15 , 3840, 0.7, 0.3, 'Fast', q'{Fins}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Poipole]', 803 , 261 , 'Poison' , ':U', 'Undiscovered' , 120 , 30720, 4, 1.8, 'Slow', q'{Bipedal, tailed form}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Plusle]', 311 , 80 , 'Electric' , '1:1', 'Fairy' , 20 , 5376, 5355, 5140, 5120, 9.3, 4.2, 'Medium Fast', q'{Bipedal, tailed form}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Latias]', 380 , 196 , 'Dragon', 'Psychic', '1:0U', 'Undiscovered' , 120 , 30976, 30855, 30840, 30720, 88.2, 40, 'Slow', q'{Single pair of wings}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Weezing]', 110 , 110 , 'Poison' , '1:1', 'Amorphous' , 20, 5120, 5376, 5355, 5140, 5120, 20.9, 9.5, 'Medium Fast', q'{Multiple bodies}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Sewaddle]', 540 , 46 , 'Bug', 'Grass', '1:1', 'Bug' , 15 , 3855, 3840, 5.5, 2.5, 'Medium Slow', q'{Insectoid body}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Krabby]', 98 , 98 , 'Water' , '1:1', 'Water 3' , 20, 5120, 5376, 5355, 5140, 5120, 14.3, 6.5, 'Medium Fast', q'{Insectoid body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Altaria]', 334 , 122 , 'Dragon', 'Flying', '1:1', 'Flying', 'Dragon', 20 , 5376, 5355, 5140, 5120, 45.4, 20.6, 'Erratic', q'{Single pair of wings}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Terrakion]', 639 , 145 , 'Rock', 'Fighting', ':U', 'Undiscovered' , 80 , 20560, 20480, 573.2, 260, 'Slow', q'{Quadruped body}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Bounsweet]', 761 , 171 , 'Grass' , '1:0', 'Grass' , 20 , 5120, 7.1, 3.2, 'Medium Slow', q'{Head and legs}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Magmar]', 126 , 126 , 'Fire' , '1:3', 'Human-Like' , 25, 6400, 6656, 6630, 6425, 6400, 98.1, 44.5, 'Medium Fast', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Mewtwo]', 150 , 150 , 'Psychic' , ':U', 'Undiscovered' , 120, 30720, 30976, 30855, 30840, 30720, 269, 122, 'Slow', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pidgey]', 16 , 16 , 'Normal', 'Flying', '1:1', 'Flying' , 15, 3840, 4096, 4080, 3855, 3840, 4, 1.8, 'Medium Slow', q'{Single pair of wings}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Seel]', 86 , 86 , 'Water' , '1:1', 'Water 1', 'Field', 20, 5120, 5376, 5355, 5140, 5120, 198.4, 90, 'Medium Fast', q'{Fins}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Bewear]', 760 , 170 , 'Normal', 'Fighting', '1:1', 'Field' , 15 , 3840, 297.6, 135, 'Medium Fast', q'{Bipedal, tailed form}', 7 );
insert into Pokemon( NAME, DEX , CLASS , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Arceus]', 493 , q'|Type: Flying|' , 'Normal' , ':U', 'Undiscovered' , 120 , 30855, 30840, 30720, 705.5, 320, 'Slow', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Clawitzer]', 693 , 33, 'Co', 'Water' , '1:1', 'Water 1', 'Water 3', 15 , 3855, 3840, 77.8, 35.3, 'Slow', q'{Serpentine bodies}', 6 );
insert into Pokemon( NAME, DEX , CLASS , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Arceus]', 493 , q'|Type: Psychic|' , 'Normal' , ':U', 'Undiscovered' , 120 , 30855, 30840, 30720, 705.5, 320, 'Slow', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Dustox]', 269 , 18 , 'Bug', 'Poison', '1:1', 'Bug' , 15 , 4096, 4080, 3855, 3840, 69.7, 31.6, 'Medium Fast', q'{Two or more pairs of wings}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Ribombee]', 743 , 84 , 'Bug', 'Fairy', '1:1', 'Bug', 'Fairy', 20 , 5120, 1.1, 0.5, 'Medium Fast', q'{Two or more pairs of wings}', 7 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Vivillon]', 666 , q'|Elegant Pattern|', 22, 'Ce', 'Bug', 'Flying', '1:1', 'Bug' , 15 , 3855, 3840, 37.5, 17, 'Medium Fast', q'{Two or more pairs of wings}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Xatu]', 178 , 162 , 'Psychic', 'Flying', '1:1', 'Flying' , 20, 5120, 5376, 5355, 5140, 5120, 33.1, 15, 'Medium Fast', q'{Single pair of wings}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Magnemite]', 81 , 81 , 'Electric', 'Steel', ':', 'Mineral' , 20, 5120, 5376, 5355, 5140, 5120, 13.2, 6, 'Medium Fast', q'{Head and arms}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Rampardos]', 409 , 37 , 'Rock' , '1:7', 'Monster' , 30 , 7905, 7710, 7680, 226, 102.5, 'Erratic', q'{Bipedal, tailed form}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Venonat]', 48 , 48 , 'Bug', 'Poison', '1:1', 'Bug' , 20, 5120, 5376, 5355, 5140, 5120, 66.1, 30, 'Medium Fast', q'{Bipedal, tailless form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Whirlipede]', 544 , 50 , 'Bug', 'Poison', '1:1', 'Bug' , 15 , 3855, 3840, 129, 58.5, 'Medium Slow', q'{Head}', 5 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Rattata]', 19, 'A' , q'|Alolan|' , 'Dark', 'Normal', '1:1', 'Field' , 15, 3840, 4096, 4080, 3855, 3840, 7.7, 3.5, 'Medium Fast', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Nidoqueen]', 31 , 31 , 'Poison', 'Ground', '1:0U', 'Undiscovered' , 20, 5120, 5376, 5355, 5140, 5120, 132.3, 60, 'Medium Slow', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Zweilous]', 634 , 140 , 'Dark', 'Dragon', '1:1', 'Dragon' , 40 , 10280, 10240, 110.2, 50, 'Slow', q'{Quadruped body}', 5 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Klefki]', 707 , 50, 'Mo', 'Steel', 'Fairy', '1:1', 'Mineral' , 20 , 5140, 5120, 6.6, 3, 'Fast', q'{Head}', 6 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Gyarados]', 130, 'M', nq'|Gyaradosite|', q'|Mega|', 130 , 'Water', 'Dark', '1:1', 'Water 2', 'Dragon', 5, 1280, 1536, 1530, 1285, 1280, 518.1, 235, 'Slow', q'{Serpentine bodies}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Qwilfish]', 211 , 163 , 'Water', 'Poison', '1:1', 'Water 2' , 20, 5120, 5376, 5355, 5140, 5120, 8.6, 3.9, 'Medium Fast', q'{Fins}', 2 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Glalie]', 362, 'M', nq'|Glalitite|', q'|Mega|', 172 , 'Ice' , '1:1', 'Fairy', 'Mineral', 20 , 5376, 5355, 5140, 5120, 565.5, 256.5, 'Medium Fast', q'{Head}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Smoochum]', 238 , 154 , 'Ice', 'Psychic', '1:0U', 'Undiscovered' , 25, 6400, 6656, 6630, 6425, 6400, 13.2, 6, 'Medium Fast', q'{Bipedal, tailless form}', 2 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Wormadam]', 413, 'S' , q'|Trash Cloak|', 46 , 'Bug', 'Steel', '1:0', 'Bug' , 15 , 4080, 3855, 3840, 14.3, 6.5, 'Medium Fast', q'{Head and a base}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Honchkrow]', 430 , 75 , 'Dark', 'Flying', '1:1', 'Flying' , 20 , 5355, 5140, 5120, 60.2, 27.3, 'Medium Slow', q'{Single pair of wings}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Larvitar]', 246 , 249 , 'Rock', 'Ground', '1:1', 'Monster' , 40, 10240, 10496, 10455, 10280, 10240, 158.7, 72, 'Slow', q'{Bipedal, tailed form}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Emolga]', 587 , 93 , 'Electric', 'Flying', '1:1', 'Field' , 20 , 5140, 5120, 11, 5, 'Medium Fast', q'{Quadruped body}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Hippowdon]', 450 , 123 , 'Ground' , '1:1', 'Field' , 30 , 7905, 7710, 7680, 661.4, 300, 'Slow', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Goodra]', 706 , 21, 'Mo', 'Dragon' , '1:1', 'Dragon' , 40 , 10280, 10240, 331.8, 150.5, 'Slow', q'{Bipedal, tailed form}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Empoleon]', 395 , 9 , 'Water', 'Steel', '1:7', 'Water 1', 'Field', 20 , 5355, 5140, 5120, 186.3, 84.5, 'Medium Slow', q'{Bipedal, tailed form}', 4 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Kyurem]', 646, 'W' , q'|White|', 152 , 'Dragon', 'Ice', ':U', 'Undiscovered' , 120 , 30840, 30720, 716.5, 325, 'Slow', q'{Bipedal, tailed form}', 5 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Deerling]', 585 , q'|Spring Form|', 91 , 'Normal', 'Grass', '1:1', 'Field' , 20 , 5140, 5120, 43, 19.5, 'Medium Fast', q'{Quadruped body}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Dratini]', 147 , 147 , 'Dragon' , '1:1', 'Water 1', 'Dragon', 40, 10240, 10496, 10455, 10280, 10240, 7.3, 3.3, 'Slow', q'{Serpentine bodies}', 1 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Diglett]', 50, 'A' , q'|Alolan|' , 'Ground', 'Steel', '1:1', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 1.8, 0.8, 'Medium Fast', q'{Head and a base}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Tapu Lele]', 786 , 286 , 'Psychic', 'Fairy', ':U', 'Undiscovered' , 15 , 3840, 41, 18.6, 'Slow', q'{Head and arms}', 7 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Furfrou]', 676 , q'|Natural Form|', 93, 'Ce', 'Normal' , '1:1', 'Field' , 20 , 5140, 5120, 61.7, 28, 'Medium Fast', q'{Quadruped body}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Vespiquen]', 416 , 54 , 'Bug', 'Flying', '1:0', 'Bug' , 15 , 4080, 3855, 3840, 84.9, 38.5, 'Medium Slow', q'{Two or more pairs of wings}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Cubone]', 104 , 104 , 'Ground' , '1:1', 'Monster' , 20, 5120, 5376, 5355, 5140, 5120, 14.3, 6.5, 'Medium Fast', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Dhelmise]', 781 , 263 , 'Ghost', 'Grass', ':', 'Mineral' , 25 , 6400, 463, 210, 'Medium Fast', q'{Head and a base}', 7 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pumpkaboo]', 710 , q'|Large Size|', 63, 'Mo', 'Ghost', 'Grass', '1:1', 'Amorphous' , 20 , 5140, 5120, 16.5, 7.5, 'Medium Fast', q'{Head}', 6 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Mimikyu]', 778 , q'|Busted Form|', 242 , 'Ghost', 'Fairy', '1:1', 'Amorphous' , 20 , 5120, 1.5, 0.7, 'Medium Fast', q'{Serpentine bodies}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pichu]', 172 , 21 , 'Electric' , '1:1U', 'Undiscovered' , 10, 2560, 2816, 2805, 2570, 2560, 4.4, 2, 'Medium Fast', q'{Quadruped body}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Sawk]', 539 , 45 , 'Fighting' , '0:1', 'Human-Like' , 20 , 5140, 5120, 112.4, 51, 'Medium Fast', q'{Bipedal, tailless form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Buzzwole]', 794 , 294 , 'Bug', 'Fighting', ':U', 'Undiscovered' , 120 , 30720, 735.5, 333.6, 'Slow', q'{Tentacles or a multiped body}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Seismitoad]', 537 , 43 , 'Water', 'Ground', '1:1', 'Water 1' , 20 , 5140, 5120, 136.7, 62, 'Medium Slow', q'{Bipedal, tailless form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Sudowoodo]', 185 , 107 , 'Rock' , '1:1', 'Mineral' , 20, 5120, 5376, 5355, 5140, 5120, 83.8, 38, 'Medium Fast', q'{Bipedal, tailless form}', 2 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Litleo]', 667 , 57, 'Ce', 'Fire', 'Normal', '7:1', 'Field' , 20 , 5140, 5120, 29.8, 13.5, 'Medium Slow', q'{Quadruped body}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Cosmoem]', 790 , 290 , 'Psychic' , ':U', 'Undiscovered' , 120 , 30720, 2204.4, 999.9, 'Slow', q'{Head}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Zoroark]', 571 , 77 , 'Dark' , '1:7', 'Field' , 20 , 5140, 5120, 178.8, 81.1, 'Medium Slow', q'{Bipedal, tailed form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Poliwag]', 60 , 60 , 'Water' , '1:1', 'Water 1' , 20, 5120, 5376, 5355, 5140, 5120, 27.3, 12.4, 'Medium Slow', q'{Head and legs}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Genesect]', 649 , 155 , 'Bug', 'Steel', ':U', 'Undiscovered' , 120 , 30840, 30720, 181.9, 82.5, 'Slow', q'{Bipedal, tailless form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Metapod]', 11 , 11 , 'Bug' , '1:1', 'Bug' , 15, 3840, 4096, 4080, 3855, 3840, 21.8, 9.9, 'Medium Fast', q'{Serpentine bodies}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Lotad]', 270 , 19 , 'Water', 'Grass', '1:1', 'Water 1', 'Grass', 15 , 4096, 4080, 3855, 3840, 5.7, 2.6, 'Medium Slow', q'{Insectoid body}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Combee]', 415 , 53 , 'Bug', 'Flying', '1:7', 'Bug' , 15 , 4080, 3855, 3840, 12.1, 5.5, 'Medium Slow', q'{Multiple bodies}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Slakoth]', 287 , 36 , 'Normal' , '1:1', 'Field' , 15 , 4096, 4080, 3855, 3840, 52.9, 24, 'Slow', q'{Quadruped body}', 3 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Magearna]', 801 , q'|Original Color|', 301 , 'Steel', 'Fairy', ':U', 'Undiscovered' , 120 , 30720, 177.5, 80.5, 'Slow', q'{Bipedal, tailless form}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Sceptile]', 254 , 3 , 'Grass' , '1:7', 'Monster', 'Dragon', 20 , 5376, 5355, 5140, 5120, 115.1, 52.2, 'Medium Slow', q'{Bipedal, tailed form}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Lanturn]', 171 , 177 , 'Water', 'Electric', '1:1', 'Water 2' , 20, 5120, 5376, 5355, 5140, 5120, 49.6, 22.5, 'Slow', q'{Fins}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Incineroar]', 727 , 6 , 'Fire', 'Dark', '1:7', 'Field' , 15 , 3840, 183, 83, 'Medium Slow', q'{Bipedal, tailed form}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Oddish]', 43 , 43 , 'Grass', 'Poison', '1:1', 'Grass' , 20, 5120, 5376, 5355, 5140, 5120, 11.9, 5.4, 'Medium Slow', q'{Head and legs}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Magearna]', 801 , 301 , 'Steel', 'Fairy', ':U', 'Undiscovered' , 120 , 30720, 177.5, 80.5, 'Slow', q'{Bipedal, tailless form}', 7 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Oricorio]', 741 , q'|Baile Style|', 82 , 'Fire', 'Flying', '3:1', 'Flying' , 20 , 5120, 7.5, 3.4, 'Medium Fast', q'{Single pair of wings}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Ursaring]', 217 , 199 , 'Normal' , '1:1', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 277.3, 125.8, 'Medium Fast', q'{Bipedal, tailed form}', 2 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Shellos]', 422, 'E' , q'|East Sea|', 60 , 'Water' , '1:1', 'Water 1', 'Amorphous', 20 , 5355, 5140, 5120, 13.9, 6.3, 'Medium Fast', q'{Serpentine bodies}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Jangmo-o]', 782 , 271 , 'Dragon' , '1:1', 'Dragon' , 40 , 10240, 65.5, 29.7, 'Slow', q'{Quadruped body}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Nidoran♂]', 32 , 32 , 'Poison' , '0:1', 'Monster', 'Field', 20, 5120, 5376, 5355, 5140, 5120, 19.8, 9, 'Medium Slow', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Inkay]', 686 , 10, 'Co', 'Dark', 'Psychic', '1:1', 'Water 1', 'Water 2', 20 , 5140, 5120, 7.7, 3.5, 'Medium Fast', q'{Tentacles or a multiped body}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Silcoon]', 266 , 15 , 'Bug' , '1:1', 'Bug' , 15 , 4096, 4080, 3855, 3840, 22, 10, 'Medium Fast', q'{Head}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Shelgon]', 372 , 188 , 'Dragon' , '1:1', 'Dragon' , 40 , 10496, 10455, 10280, 10240, 243.6, 110.5, 'Slow', q'{Quadruped body}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Abomasnow]', 460 , 143 , 'Grass', 'Ice', '1:1', 'Monster', 'Grass', 20 , 5355, 5140, 5120, 298.7, 135.5, 'Slow', q'{Bipedal, tailed form}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Spiritomb]', 442 , 108 , 'Ghost', 'Dark', '1:1', 'Amorphous' , 30 , 7905, 7710, 7680, 238.1, 108, 'Medium Fast', q'{Head and a base}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Xurkitree]', 796 , 296 , 'Electric' , ':U', 'Undiscovered' , 120 , 30720, 220.5, 100, 'Slow', q'{Bipedal, tailed form}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Chandelure]', 609 , 115 , 'Ghost', 'Fire', '1:1', 'Amorphous' , 20 , 5140, 5120, 75.6, 34.3, 'Medium Slow', q'{Head and arms}', 5 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Kyogre]', 382, 'P', nq'|Blue Orb|', q'|Primal|', 198 , 'Water' , ':U', 'Undiscovered' , 120 , 30976, 30855, 30840, 30720, 776, 352, 'Slow', q'{Fins}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Herdier]', 507 , 13 , 'Normal' , '1:1', 'Field' , 15 , 3855, 3840, 32.4, 14.7, 'Medium Slow', q'{Quadruped body}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Sunkern]', 191 , 103 , 'Grass' , '1:1', 'Grass' , 20, 5120, 5376, 5355, 5140, 5120, 4, 1.8, 'Medium Slow', q'{Head}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Tapu Bulu]', 787 , 287 , 'Grass', 'Fairy', ':U', 'Undiscovered' , 15 , 3840, 100.3, 45.5, 'Slow', q'{Head and arms}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Solosis]', 577 , 83 , 'Psychic' , '1:1', 'Amorphous' , 20 , 5140, 5120, 2.2, 1, 'Medium Slow', q'{Head}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Joltik]', 595 , 101 , 'Bug', 'Electric', '1:1', 'Bug' , 20 , 5140, 5120, 1.3, 0.6, 'Medium Fast', q'{Insectoid body}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Guzzlord]', 799 , 299 , 'Dark', 'Dragon', ':U', 'Undiscovered' , 120 , 30720, 1957.7, 888, 'Slow', q'{Bipedal, tailed form}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Bulbasaur]', 1 , 1 , 'Grass', 'Poison', '1:7', 'Monster', 'Grass', 20, 5120, 5376, 5355, 5140, 5120, 15.2, 6.9, 'Medium Slow', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Klink]', 599 , 105 , 'Steel' , ':', 'Mineral' , 20 , 5140, 5120, 46.3, 21, 'Medium Slow', q'{Multiple bodies}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Skuntank]', 435 , 85 , 'Poison', 'Dark', '1:1', 'Field' , 20 , 5355, 5140, 5120, 83.8, 38, 'Medium Fast', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Floette]', 670 , q'|White Flower|', 69, 'Ce', 'Fairy' , '1:0', 'Fairy' , 20 , 5140, 5120, 2, 0.9, 'Medium Fast', q'{Head and arms}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Cutiefly]', 742 , 83 , 'Bug', 'Fairy', '1:1', 'Bug', 'Fairy', 20 , 5120, 0.4, 0.2, 'Medium Fast', q'{Insectoid body}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pansear]', 513 , 19 , 'Fire' , '1:7', 'Field' , 20 , 5140, 5120, 24.3, 11, 'Medium Fast', q'{Bipedal, tailed form}', 5 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Meowstic]', 678 , 115, 'Ce', 'Psychic' , '1:1', 'Field' , 20 , 5140, 5120, 18.7, 8.5, 'Medium Fast', q'{Bipedal, tailed form}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Leafeon]', 470 , 169 , 'Grass' , '1:7', 'Field' , 35 , 9180, 8995, 8960, 56.2, 25.5, 'Medium Fast', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Granbull]', 210 , 126 , 'Fairy' , '3:1', 'Field', 'Fairy', 20, 5120, 5376, 5355, 5140, 5120, 107.4, 48.7, 'Fast', q'{Bipedal, tailed form}', 2 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Scizor]', 212, 'M', nq'|Scizorite|', q'|Mega|', 112 , 'Bug', 'Steel', '1:1', 'Bug' , 25, 6400, 6656, 6630, 6425, 6400, 260.1, 118, 'Medium Fast', q'{Two or more pairs of wings}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Poochyena]', 261 , 10 , 'Dark' , '1:1', 'Field' , 15 , 4096, 4080, 3855, 3840, 30, 13.6, 'Medium Fast', q'{Quadruped body}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Kricketune]', 402 , 16 , 'Bug' , '1:1', 'Bug' , 15 , 4080, 3855, 3840, 56.2, 25.5, 'Medium Slow', q'{Two or more pairs of wings}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Electrike]', 309 , 78 , 'Electric' , '1:1', 'Field' , 20 , 5376, 5355, 5140, 5120, 33.5, 15.2, 'Slow', q'{Quadruped body}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Vikavolt]', 738 , 29 , 'Bug', 'Electric', '1:1', 'Bug' , 15 , 3840, 99.2, 45, 'Medium Fast', q'{Insectoid body}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Toxapex]', 748 , 114 , 'Poison', 'Water', '1:1', 'Water 1' , 20 , 5120, 32, 14.5, 'Medium Fast', q'{Tentacles or a multiped body}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Flareon]', 136 , 136 , 'Fire' , '1:7', 'Field' , 35, 8960, 9216, 9180, 8995, 8960, 55.1, 25, 'Medium Fast', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Sandslash]', 28 , 28 , 'Ground' , '1:1', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 65, 29.5, 'Medium Fast', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Reuniclus]', 579 , 85 , 'Psychic' , '1:1', 'Amorphous' , 20 , 5140, 5120, 44.3, 20.1, 'Medium Slow', q'{Head and arms}', 5 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pikachu]', 25 , q'|Pikachu, Ph. D|', 25 , 'Electric' , '1:1', 'Field', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 13.2, 6, 'Medium Fast', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Corsola]', 222 , 173 , 'Water', 'Rock', '3:1', 'Water 1', 'Water 3', 20, 5120, 5376, 5355, 5140, 5120, 11, 5, 'Fast', q'{Insectoid body}', 2 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Steelix]', 208, 'M', nq'|Steelixite|', q'|Mega|', 63 , 'Steel', 'Ground', '1:1', 'Mineral' , 25, 6400, 6656, 6630, 6425, 6400, 881.8, 400, 'Medium Fast', q'{Serpentine bodies}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Crobat]', 169 , 39 , 'Poison', 'Flying', '1:1', 'Flying' , 15, 3840, 4096, 4080, 3855, 3840, 165.3, 75, 'Medium Fast', q'{Two or more pairs of wings}', 2 );
insert into Pokemon( NAME, DEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Heatran]', 485 , 'Fire', 'Steel', '1:1U', 'Undiscovered' , 10 , 2805, 2570, 2560, 948, 430, 'Slow', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Gible]', 443 , 109 , 'Dragon', 'Ground', '1:1', 'Monster', 'Dragon', 40 , 10455, 10280, 10240, 45.2, 20.5, 'Slow', q'{Bipedal, tailed form}', 4 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Vulpix]', 37, 'A' , q'|Alolan|' , 'Ice' , '3:1', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 21.8, 9.9, 'Medium Fast', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Nidorina]', 30 , 30 , 'Poison' , '1:0U', 'Undiscovered' , 20, 5120, 5376, 5355, 5140, 5120, 44.1, 20, 'Medium Slow', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Graveler]', 75 , 75 , 'Rock', 'Ground', '1:1', 'Mineral' , 15, 3840, 4096, 4080, 3855, 3840, 231.5, 105, 'Medium Slow', q'{Bipedal, tailless form}', 1 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Greninja]', 658 , 9, 'Ce', 'Water', 'Dark', '1:7', 'Water 1' , 20 , 5140, 5120, 88.2, 40, 'Medium Slow', q'{Bipedal, tailless form}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Monferno]', 391 , 5 , 'Fire', 'Fighting', '1:7', 'Field', 'Human-Like', 20 , 5355, 5140, 5120, 48.5, 22, 'Medium Slow', q'{Bipedal, tailed form}', 4 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Zygarde]', 718 , q'|50% Forme|', 150, 'Mo', 'Dragon', 'Ground', ':U', 'Undiscovered' , 120 , 30840, 30720, 672.4, 305, 'Slow', q'{Serpentine bodies}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Feebas]', 349 , 140 , 'Water' , '1:1', 'Water 1', 'Dragon', 20 , 5376, 5355, 5140, 5120, 16.3, 7.4, 'Erratic', q'{Fins}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Foongus]', 590 , 96 , 'Grass', 'Poison', '1:1', 'Grass' , 20 , 5140, 5120, 2.2, 1, 'Medium Fast', q'{Head and arms}', 5 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Sawsbuck]', 586 , q'|Spring Form|', 92 , 'Normal', 'Grass', '1:1', 'Field' , 20 , 5140, 5120, 203.9, 92.5, 'Medium Fast', q'{Quadruped body}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Accelgor]', 617 , 123 , 'Bug' , '1:1', 'Bug' , 15 , 3855, 3840, 55.8, 25.3, 'Medium Fast', q'{Head and arms}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Kabuto]', 140 , 140 , 'Rock', 'Water', '1:7', 'Water 1', 'Water 3', 30, 7680, 7936, 7905, 7710, 7680, 25.4, 11.5, 'Medium Fast', q'{Insectoid body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Mantine]', 226 , 202 , 'Water', 'Flying', '1:1', 'Water 1' , 25, 6400, 6656, 6630, 6425, 6400, 485, 220, 'Slow', q'{Single pair of wings}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Weepinbell]', 70 , 70 , 'Grass', 'Poison', '1:1', 'Grass' , 20, 5120, 5376, 5355, 5140, 5120, 14.1, 6.4, 'Medium Slow', q'{Head and a base}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Wimpod]', 767 , 182 , 'Bug', 'Water', '1:1', 'Bug', 'Water 3', 20 , 5120, 26.5, 12, 'Medium Fast', q'{Tentacles or a multiped body}', 7 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS, LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Aegislash]', 681, 'B' , q'|Blade Forme|', 119, 'Ce', 'Steel', 'Ghost', '1:1', 'Mineral' , 20 , 5140, 5120, 116.8, 53, 'Medium Fast', q'{Head and a base}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Clefairy]', 35 , 35 , 'Fairy' , '3:1', 'Fairy' , 10, 2560, 2816, 2805, 2570, 2560, 16.5, 7.5, 'Fast', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Silvally]', 773 , q'|Type: Fairy|', 204 , 'Normal' , ':U', 'Undiscovered' , 120 , 30720, 221.6, 100.5, 'Slow', q'{Quadruped body}', 7 );
insert into Pokemon( NAME, DEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Phione]', 489 , 'Water' , ':', 'Water 1', 'Fairy', 40 , 10455, 10280, 10240, 6.8, 3.1, 'Slow', q'{Head and arms}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Haunter]', 93 , 93 , 'Ghost', 'Poison', '1:1', 'Amorphous' , 20, 5120, 5376, 5355, 5140, 5120, 0.2, 0.1, 'Medium Slow', q'{Head and arms}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Magmortar]', 467 , 202 , 'Fire' , '1:3', 'Human-Like' , 25 , 6630, 6425, 6400, 149.9, 68, 'Medium Fast', q'{Bipedal, tailed form}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Carvanha]', 318 , 97 , 'Water', 'Dark', '1:1', 'Water 2' , 20 , 5376, 5355, 5140, 5120, 45.9, 20.8, 'Slow', q'{Fins}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Wobbuffet]', 202 , 108 , 'Psychic' , '1:1', 'Amorphous' , 20, 5120, 5376, 5355, 5140, 5120, 62.8, 28.5, 'Medium Fast', q'{Head and a base}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Garchomp]', 445 , 111 , 'Dragon', 'Ground', '1:1', 'Monster', 'Dragon', 40 , 10455, 10280, 10240, 209.4, 95, 'Slow', q'{Bipedal, tailed form}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Type: Null]', 772 , 203 , 'Normal' , ':U', 'Undiscovered' , 120 , 30720, 265.7, 120.5, 'Slow', q'{Quadruped body}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Cubchoo]', 613 , 119 , 'Ice' , '1:1', 'Field' , 20 , 5140, 5120, 18.7, 8.5, 'Medium Fast', q'{Bipedal, tailed form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Beautifly]', 267 , 16 , 'Bug', 'Flying', '1:1', 'Bug' , 15 , 4096, 4080, 3855, 3840, 62.6, 28.4, 'Medium Fast', q'{Two or more pairs of wings}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Musharna]', 518 , 24 , 'Psychic' , '1:1', 'Field' , 10 , 2570, 2560, 133.4, 60.5, 'Fast', q'{Bipedal, tailless form}', 5 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Swirlix]', 684 , 131, 'Ce', 'Fairy' , '1:1', 'Fairy' , 20 , 5140, 5120, 7.7, 3.5, 'Medium Fast', q'{Head and legs}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Tsareena]', 763 , 173 , 'Grass' , '1:0', 'Grass' , 20 , 5120, 47.2, 21.4, 'Medium Slow', q'{Bipedal, tailless form}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Lampent]', 608 , 114 , 'Ghost', 'Fire', '1:1', 'Amorphous' , 20 , 5140, 5120, 28.7, 13, 'Medium Slow', q'{Head and arms}', 5 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Helioptile]', 694 , 46, 'Co', 'Electric', 'Normal', '1:1', 'Monster', 'Dragon', 20 , 5140, 5120, 13.2, 6, 'Medium Fast', q'{Bipedal, tailed form}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Ledyba]', 165 , 30 , 'Bug', 'Flying', '1:1', 'Bug' , 15, 3840, 4096, 4080, 3855, 3840, 23.8, 10.8, 'Fast', q'{Single pair of wings}', 2 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Deoxys]', 386, 'S' , q'|Speed Forme|', 202 , 'Psychic' , ':U', 'Undiscovered' , 120 , 30976, 30855, 30840, 30720, 134, 60.8, 'Slow', q'{Bipedal, tailless form}', 3 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Diggersby]', 660 , 11, 'Ce', 'Normal', 'Ground', '1:1', 'Field' , 15 , 3855, 3840, 93.5, 42.4, 'Medium Fast', q'{Bipedal, tailed form}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Kecleon]', 352 , 145 , 'Normal' , '1:1', 'Field' , 20 , 5376, 5355, 5140, 5120, 48.5, 22, 'Medium Slow', q'{Bipedal, tailed form}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Vanillish]', 583 , 89 , 'Ice' , '1:1', 'Mineral' , 20 , 5140, 5120, 90.4, 41, 'Slow', q'{Head and a base}', 5 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Espurr]', 677 , 114, 'Ce', 'Psychic' , '1:1', 'Field' , 20 , 5140, 5120, 7.7, 3.5, 'Medium Fast', q'{Bipedal, tailed form}', 6 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Rotom]', 479 , q'|Mow|', 152 , 'Electric', 'Ghost', ':', 'Amorphous' , 20 , 5355, 5140, 5120, 0.7, 0.3, 'Medium Fast', q'{Head}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Goldeen]', 118 , 118 , 'Water' , '1:1', 'Water 2' , 20, 5120, 5376, 5355, 5140, 5120, 33.1, 15, 'Medium Fast', q'{Fins}', 1 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Burmy]', 412, 'G' , q'|Sandy Cloak|', 45 , 'Bug' , '1:1', 'Bug' , 15 , 4080, 3855, 3840, 7.5, 3.4, 'Medium Fast', q'{Head and a base}', 4 );
insert into Pokemon( NAME, DEX , CLASS , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Arceus]', 493 , q'|Type: Fire|' , 'Normal' , ':U', 'Undiscovered' , 120 , 30855, 30840, 30720, 705.5, 320, 'Slow', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Medicham]', 308, 'M', nq'|Medichamite|', q'|Mega|', 77 , 'Fighting', 'Psychic', '1:1', 'Human-Like' , 20 , 5376, 5355, 5140, 5120, 69.4, 31.5, 'Medium Fast', q'{Bipedal, tailless form}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Nidoran♀]', 29 , 29 , 'Poison' , '1:0', 'Monster', 'Field', 20, 5120, 5376, 5355, 5140, 5120, 15.4, 7, 'Medium Slow', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Heracross]', 214, 'M', nq'|Heracronite|', q'|Mega|', 114 , 'Bug', 'Fighting', '1:1', 'Bug' , 25, 6400, 6656, 6630, 6425, 6400, 119, 54, 'Slow', q'{Bipedal, tailless form}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Chansey]', 113 , 113 , 'Normal' , '1:0', 'Fairy' , 40, 10240, 10496, 10455, 10280, 10240, 76.3, 34.6, 'Fast', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Golurk]', 623 , 129 , 'Ground', 'Ghost', ':', 'Mineral' , 25 , 6425, 6400, 727.5, 330, 'Medium Fast', q'{Bipedal, tailless form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Wailmer]', 320 , 99 , 'Water' , '1:1', 'Field', 'Water 2', 40 , 10496, 10455, 10280, 10240, 286.6, 130, 'Fluctuating', q'{Fins}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Gabite]', 444 , 110 , 'Dragon', 'Ground', '1:1', 'Monster', 'Dragon', 40 , 10455, 10280, 10240, 123.5, 56, 'Slow', q'{Bipedal, tailed form}', 4 );
insert into Pokemon( NAME, DEX , CLASS , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Arceus]', 493 , q'|Type: Ground|' , 'Normal' , ':U', 'Undiscovered' , 120 , 30855, 30840, 30720, 705.5, 320, 'Slow', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Hoppip]', 187 , 67 , 'Grass', 'Flying', '1:1', 'Fairy', 'Grass', 20, 5120, 5376, 5355, 5140, 5120, 1.1, 0.5, 'Medium Slow', q'{Bipedal, tailed form}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Magnezone]', 462 , 180 , 'Electric', 'Steel', ':', 'Mineral' , 20 , 5355, 5140, 5120, 396.8, 180, 'Medium Fast', q'{Head and arms}', 4 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Swampert]', 260, 'M', nq'|Swampertite|', q'|Mega|', 9 , 'Water', 'Ground', '1:7', 'Monster', 'Water 1', 20 , 5376, 5355, 5140, 5120, 180.6, 81.9, 'Medium Slow', q'{Bipedal, tailed form}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Drifblim]', 426 , 66 , 'Ghost', 'Flying', '1:1', 'Amorphous' , 30 , 7905, 7710, 7680, 33.1, 15, 'Fluctuating', q'{Head and arms}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Magcargo]', 219 , 217 , 'Fire', 'Rock', '1:1', 'Amorphous' , 20, 5120, 5376, 5355, 5140, 5120, 121.3, 55, 'Medium Fast', q'{Serpentine bodies}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Ferroseed]', 597 , 103 , 'Grass', 'Steel', '1:1', 'Grass', 'Mineral', 20 , 5140, 5120, 41.5, 18.8, 'Medium Fast', q'{Head}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Espeon]', 196 , 188 , 'Psychic' , '1:7', 'Field' , 35, 8960, 9216, 9180, 8995, 8960, 58.4, 26.5, 'Medium Fast', q'{Quadruped body}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Araquanid]', 752 , 142 , 'Water', 'Bug', '1:1', 'Water 1', 'Bug', 15 , 3840, 180.8, 82, 'Medium Fast', q'{Insectoid body}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Starly]', 396 , 10 , 'Normal', 'Flying', '1:1', 'Flying' , 15 , 4080, 3855, 3840, 4.4, 2, 'Medium Slow', q'{Single pair of wings}', 4 );
insert into Pokemon( NAME, DEX , CLASS , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Arceus]', 493 , q'|Type: Water|' , 'Normal' , ':U', 'Undiscovered' , 120 , 30855, 30840, 30720, 705.5, 320, 'Slow', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Litwick]', 607 , 113 , 'Ghost', 'Fire', '1:1', 'Amorphous' , 20 , 5140, 5120, 6.8, 3.1, 'Medium Slow', q'{Head and a base}', 5 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Bergmite]', 712 , 79, 'Mo', 'Ice' , '1:1', 'Monster' , 20 , 5140, 5120, 219.4, 99.5, 'Medium Fast', q'{Quadruped body}', 6 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Vivillon]', 666 , q'|Modern Pattern|', 22, 'Ce', 'Bug', 'Flying', '1:1', 'Bug' , 15 , 3855, 3840, 37.5, 17, 'Medium Fast', q'{Two or more pairs of wings}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Lombre]', 271 , 20 , 'Water', 'Grass', '1:1', 'Water 1', 'Grass', 15 , 4096, 4080, 3855, 3840, 71.6, 32.5, 'Medium Slow', q'{Bipedal, tailless form}', 3 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Sandslash]', 28, 'A' , q'|Alolan|' , 'Ice', 'Steel', '1:1', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 65, 29.5, 'Medium Fast', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Floette]', 670 , q'|Eternal Flower|', 69, 'Ce', 'Fairy' , '1:0', 'Fairy' , 20 , 5140, 5120, 2, 0.9, 'Medium Fast', q'{Head and arms}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Stunky]', 434 , 84 , 'Poison', 'Dark', '1:1', 'Field' , 20 , 5355, 5140, 5120, 42.3, 19.2, 'Medium Fast', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Dartrix]', 723 , 2 , 'Grass', 'Flying', '1:7', 'Flying' , 15 , 3840, 35.3, 16, 'Medium Slow', q'{Single pair of wings}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Whiscash]', 340 , 128 , 'Water', 'Ground', '1:1', 'Water 2' , 20 , 5376, 5355, 5140, 5120, 52, 23.6, 'Medium Fast', q'{Fins}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Machoke]', 67 , 67 , 'Fighting' , '1:3', 'Human-Like' , 20, 5120, 5376, 5355, 5140, 5120, 155.4, 70.5, 'Medium Slow', q'{Bipedal, tailless form}', 1 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Castform]', 351, 'R' , q'|Rainy Form|', 142 , 'Water' , '1:1', 'Fairy', 'Amorphous', 25 , 6656, 6630, 6425, 6400, 1.8, 0.8, 'Medium Fast', q'{Head}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Finneon]', 456 , 134 , 'Water' , '1:1', 'Water 2' , 20 , 5355, 5140, 5120, 15.4, 7, 'Erratic', q'{Fins}', 4 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Floette]', 670 , q'|Red Flower|', 69, 'Ce', 'Fairy' , '1:0', 'Fairy' , 20 , 5140, 5120, 2, 0.9, 'Medium Fast', q'{Head and arms}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Miltank]', 241 , 151 , 'Normal' , '1:0', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 166.4, 75.5, 'Slow', q'{Bipedal, tailed form}', 2 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Latios]', 381, 'M', nq'|Latiosite|', q'|Mega|', 197 , 'Dragon', 'Psychic', '0:1U', 'Undiscovered' , 120 , 30976, 30855, 30840, 30720, 132.3, 60, 'Slow', q'{Single pair of wings}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Drampa]', 780 , 244 , 'Normal', 'Dragon', '1:1', 'Monster', 'Dragon', 20 , 5120, 407.9, 185, 'Medium Fast', q'{Serpentine bodies}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Yamask]', 562 , 68 , 'Ghost' , '1:1', 'Mineral', 'Amorphous', 25 , 6425, 6400, 3.3, 1.5, 'Medium Fast', q'{Head and arms}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pinsir]', 127 , 127 , 'Bug' , '1:1', 'Bug' , 25, 6400, 6656, 6630, 6425, 6400, 121.3, 55, 'Slow', q'{Bipedal, tailless form}', 1 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Vivillon]', 666 , q'|Tundra Pattern|', 22, 'Ce', 'Bug', 'Flying', '1:1', 'Bug' , 15 , 3855, 3840, 37.5, 17, 'Medium Fast', q'{Two or more pairs of wings}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Manectric]', 310 , 79 , 'Electric' , '1:1', 'Field' , 20 , 5376, 5355, 5140, 5120, 88.6, 40.2, 'Slow', q'{Quadruped body}', 3 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Altaria]', 334, 'M', nq'|Altarianite|', q'|Mega|', 122 , 'Dragon', 'Fairy', '1:1', 'Flying', 'Dragon', 20 , 5376, 5355, 5140, 5120, 45.4, 20.6, 'Erratic', q'{Single pair of wings}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Yanma]', 193 , 101 , 'Bug', 'Flying', '1:1', 'Bug' , 20, 5120, 5376, 5355, 5140, 5120, 83.8, 38, 'Medium Fast', q'{Two or more pairs of wings}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Skiploom]', 188 , 68 , 'Grass', 'Flying', '1:1', 'Fairy', 'Grass', 20, 5120, 5376, 5355, 5140, 5120, 2.2, 1, 'Medium Slow', q'{Bipedal, tailed form}', 2 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Spewpa]', 665 , 21, 'Ce', 'Bug' , '1:1', 'Bug' , 15 , 3855, 3840, 18.5, 8.4, 'Medium Fast', q'{Head and a base}', 6 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Giratina]', 487 , q'|Altered Forme|', 210 , 'Ghost', 'Dragon', ':U', 'Undiscovered' , 120 , 30855, 30840, 30720, 1653.5, 750, 'Slow', q'{Tentacles or a multiped body}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Shellder]', 90 , 90 , 'Water' , '1:1', 'Water 3' , 20, 5120, 5376, 5355, 5140, 5120, 8.8, 4, 'Slow', q'{Head}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Poliwhirl]', 61 , 61 , 'Water' , '1:1', 'Water 1' , 20, 5120, 5376, 5355, 5140, 5120, 44.1, 20, 'Medium Slow', q'{Bipedal, tailless form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Corphish]', 341 , 129 , 'Water' , '1:1', 'Water 1', 'Water 3', 15 , 4096, 4080, 3855, 3840, 25.4, 11.5, 'Fluctuating', q'{Insectoid body}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Gurdurr]', 533 , 39 , 'Fighting' , '1:3', 'Human-Like' , 20 , 5140, 5120, 88.2, 40, 'Medium Slow', q'{Bipedal, tailless form}', 5 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Dedenne]', 702 , 110, 'Co', 'Electric', 'Fairy', '1:1', 'Field', 'Fairy', 20 , 5140, 5120, 4.9, 2.2, 'Medium Fast', q'{Bipedal, tailed form}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Lickilicky]', 463 , 162 , 'Normal' , '1:1', 'Monster' , 20 , 5355, 5140, 5120, 308.6, 140, 'Medium Fast', q'{Bipedal, tailless form}', 4 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Fennekin]', 653 , 4, 'Ce', 'Fire' , '1:7', 'Field' , 20 , 5140, 5120, 20.7, 9.4, 'Medium Slow', q'{Quadruped body}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Mismagius]', 429 , 73 , 'Ghost' , '1:1', 'Amorphous' , 25 , 6630, 6425, 6400, 9.7, 4.4, 'Fast', q'{Head}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Emboar]', 500 , 6 , 'Fire', 'Fighting', '1:7', 'Field' , 20 , 5140, 5120, 330.7, 150, 'Medium Slow', q'{Bipedal, tailed form}', 5 );
insert into Pokemon( NAME, DEX , CLASS , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Arceus]', 493 , q'|Type: Normal|' , 'Normal' , ':U', 'Undiscovered' , 120 , 30855, 30840, 30720, 705.5, 320, 'Slow', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Spritzee]', 682 , 129, 'Ce', 'Fairy' , '1:1', 'Fairy' , 20 , 5140, 5120, 1.1, 0.5, 'Medium Fast', q'{Head and arms}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Hariyama]', 297 , 49 , 'Fighting' , '1:3', 'Human-Like' , 20 , 5376, 5355, 5140, 5120, 559.5, 253.8, 'Fluctuating', q'{Bipedal, tailless form}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Yungoos]', 734 , 13 , 'Normal' , '1:1', 'Field' , 15 , 3840, 13.2, 6, 'Medium Fast', q'{Quadruped body}', 7 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Sharpedo]', 319, 'M', nq'|Sharpedonite|', q'|Mega|', 98 , 'Water', 'Dark', '1:1', 'Water 2' , 20 , 5376, 5355, 5140, 5120, 195.8, 88.8, 'Slow', q'{Fins}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Numel]', 322 , 101 , 'Fire', 'Ground', '1:1', 'Field' , 20 , 5376, 5355, 5140, 5120, 52.9, 24, 'Medium Fast', q'{Quadruped body}', 3 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Furfrou]', 676 , q'|Diamond Trim|', 93, 'Ce', 'Normal' , '1:1', 'Field' , 20 , 5140, 5120, 61.7, 28, 'Medium Fast', q'{Quadruped body}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Garbodor]', 569 , 75 , 'Poison' , '1:1', 'Mineral' , 20 , 5140, 5120, 236.6, 107.3, 'Medium Fast', q'{Bipedal, tailless form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Rapidash]', 78 , 78 , 'Fire' , '1:1', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 209.4, 95, 'Medium Fast', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Tangela]', 114 , 114 , 'Grass' , '1:1', 'Grass' , 20, 5120, 5376, 5355, 5140, 5120, 77.2, 35, 'Medium Fast', q'{Head and legs}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Remoraid]', 223 , 174 , 'Water' , '1:1', 'Water 1', 'Water 2', 20, 5120, 5376, 5355, 5140, 5120, 26.5, 12, 'Medium Fast', q'{Fins}', 2 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Banette]', 354, 'M', nq'|Banettite|', q'|Mega|', 147 , 'Ghost' , '1:1', 'Amorphous' , 25 , 6656, 6630, 6425, 6400, 27.6, 12.5, 'Fast', q'{Bipedal, tailed form}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Infernape]', 392 , 6 , 'Fire', 'Fighting', '1:7', 'Field', 'Human-Like', 20 , 5355, 5140, 5120, 121.3, 55, 'Medium Slow', q'{Bipedal, tailed form}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Lileep]', 345 , 133 , 'Rock', 'Grass', '1:7', 'Water 3' , 30 , 7936, 7905, 7710, 7680, 52.5, 23.8, 'Erratic', q'{Head and a base}', 3 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pumpkaboo]', 710 , q'|Small Size|', 63, 'Mo', 'Ghost', 'Grass', '1:1', 'Amorphous' , 20 , 5140, 5120, 7.7, 3.5, 'Medium Fast', q'{Head}', 6 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Lycanroc]', 745, 'D' , q'|Dusk Form|', 104 , 'Rock' , '1:1', 'Field' , 15 , 3840, 55.1, 25, 'Medium Fast', q'{Quadruped body}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Tauros]', 128 , 128 , 'Normal' , '0:1', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 194.9, 88.4, 'Slow', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pidgeot]', 18, 'M', nq'|Pidgeotite|', q'|Mega|', 18 , 'Normal', 'Flying', '1:1', 'Flying' , 15, 3840, 4096, 4080, 3855, 3840, 87.1, 39.5, 'Medium Slow', q'{Single pair of wings}', 1 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pikachu]', 25 , q'|Unova Cap|', 25 , 'Electric' , '1:1', 'Field', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 13.2, 6, 'Medium Fast', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Diancie]', 719 , 151, 'Ce', 'Rock', 'Fairy', ':U', 'Undiscovered' , 25 , 6425, 6400, 19.4, 8.8, 'Slow', q'{Head and arms}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Kommo-o]', 784 , 273 , 'Dragon', 'Fighting', '1:1', 'Dragon' , 40 , 10240, 172.4, 78.2, 'Slow', q'{Bipedal, tailed form}', 7 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Furfrou]', 676 , q'|Star Trim|', 93, 'Ce', 'Normal' , '1:1', 'Field' , 20 , 5140, 5120, 61.7, 28, 'Medium Fast', q'{Quadruped body}', 6 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Malamar]', 687 , 11, 'Co', 'Dark', 'Psychic', '1:1', 'Water 1', 'Water 2', 20 , 5140, 5120, 103.6, 47, 'Medium Fast', q'{Head and a base}', 6 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Floette]', 670 , q'|Blue Flower|', 69, 'Ce', 'Fairy' , '1:0', 'Fairy' , 20 , 5140, 5120, 2, 0.9, 'Medium Fast', q'{Head and arms}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Scyther]', 123 , 123 , 'Bug', 'Flying', '1:1', 'Bug' , 25, 6400, 6656, 6630, 6425, 6400, 123.5, 56, 'Medium Fast', q'{Two or more pairs of wings}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Beldum]', 374 , 190 , 'Steel', 'Psychic', ':', 'Mineral' , 40 , 10496, 10455, 10280, 10240, 209.9, 95.2, 'Slow', q'{Head and a base}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Roselia]', 315 , 94 , 'Grass', 'Poison', '1:1', 'Fairy', 'Grass', 20 , 5376, 5355, 5140, 5120, 4.4, 2, 'Medium Slow', q'{Bipedal, tailless form}', 3 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Oricorio]', 741 , q'|Sensu Style|', 82 , 'Fire', 'Flying', '3:1', 'Flying' , 20 , 5120, 7.5, 3.4, 'Medium Fast', q'{Single pair of wings}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Treecko]', 252 , 1 , 'Grass' , '1:7', 'Monster', 'Dragon', 20 , 5376, 5355, 5140, 5120, 11, 5, 'Medium Slow', q'{Bipedal, tailed form}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Tyrogue]', 236 , 145 , 'Fighting' , '0:1U', 'Undiscovered' , 25, 6400, 6656, 6630, 6425, 6400, 46.3, 21, 'Medium Fast', q'{Bipedal, tailless form}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Horsea]', 116 , 116 , 'Water' , '1:1', 'Water 1', 'Dragon', 20, 5120, 5376, 5355, 5140, 5120, 17.6, 8, 'Medium Fast', q'{Head and a base}', 1 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Deoxys]', 386, 'D' , q'|Defense Forme|', 202 , 'Psychic' , ':U', 'Undiscovered' , 120 , 30976, 30855, 30840, 30720, 134, 60.8, 'Slow', q'{Bipedal, tailless form}', 3 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Alakazam]', 65, 'M', nq'|Alakazite|', q'|Mega|', 65 , 'Psychic' , '1:3', 'Human-Like' , 20, 5120, 5376, 5355, 5140, 5120, 105.8, 48, 'Medium Slow', q'{Bipedal, tailless form}', 1 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Raticate]', 20, 'A' , q'|Alolan|' , 'Dark', 'Normal', '1:1', 'Field' , 15, 3840, 4096, 4080, 3855, 3840, 40.8, 18.5, 'Medium Fast', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Bisharp]', 625 , 131 , 'Dark', 'Steel', '1:1', 'Human-Like' , 20 , 5140, 5120, 154.3, 70, 'Medium Fast', q'{Bipedal, tailless form}', 5 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Dragalge]', 691 , 31, 'Co', 'Poison', 'Dragon', '1:1', 'Water 1', 'Dragon', 20 , 5140, 5120, 179.7, 81.5, 'Medium Fast', q'{Head and a base}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Fearow]', 22 , 22 , 'Normal', 'Flying', '1:1', 'Flying' , 15, 3840, 4096, 4080, 3855, 3840, 83.8, 38, 'Medium Fast', q'{Single pair of wings}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Wartortle]', 8 , 8 , 'Water' , '1:7', 'Monster', 'Water 1', 20, 5120, 5376, 5355, 5140, 5120, 49.6, 22.5, 'Medium Slow', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Deerling]', 585 , q'|Winter Form|', 91 , 'Normal', 'Grass', '1:1', 'Field' , 20 , 5140, 5120, 43, 19.5, 'Medium Fast', q'{Quadruped body}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Makuhita]', 296 , 48 , 'Fighting' , '1:3', 'Human-Like' , 20 , 5376, 5355, 5140, 5120, 190.5, 86.4, 'Fluctuating', q'{Bipedal, tailless form}', 3 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Carbink]', 703 , 124, 'Co', 'Rock', 'Fairy', ':', 'Fairy', 'Mineral', 25 , 6425, 6400, 12.6, 5.7, 'Slow', q'{Head}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Suicune]', 245 , 245 , 'Water' , ':U', 'Undiscovered' , 80, 20480, 20736, 20655, 20560, 20480, 412.3, 187, 'Slow', q'{Quadruped body}', 2 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Mimikyu]', 778 , q'|Disguised Form|', 242 , 'Ghost', 'Fairy', '1:1', 'Amorphous' , 20 , 5120, 1.5, 0.7, 'Medium Fast', q'{Serpentine bodies}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Bronzor]', 436 , 88 , 'Steel', 'Psychic', ':', 'Mineral' , 20 , 5355, 5140, 5120, 133.4, 60.5, 'Medium Fast', q'{Head}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Shinx]', 403 , 17 , 'Electric' , '1:1', 'Field' , 20 , 5355, 5140, 5120, 20.9, 9.5, 'Medium Slow', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Floatzel]', 419 , 57 , 'Water' , '1:1', 'Water 1', 'Field', 20 , 5355, 5140, 5120, 73.9, 33.5, 'Medium Fast', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Crabrawler]', 739 , 59 , 'Fighting' , '1:1', 'Water 3' , 20 , 5120, 15.4, 7, 'Medium Fast', q'{Insectoid body}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Dwebble]', 557 , 63 , 'Bug', 'Rock', '1:1', 'Bug', 'Mineral', 20 , 5140, 5120, 32, 14.5, 'Medium Fast', q'{Insectoid body}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Moltres]', 146 , 146 , 'Fire', 'Flying', ':U', 'Undiscovered' , 80, 20480, 20736, 20655, 20560, 20480, 132.3, 60, 'Slow', q'{Single pair of wings}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Salandit]', 757 , 161 , 'Poison', 'Fire', '1:7', 'Monster', 'Dragon', 20 , 5120, 10.6, 4.8, 'Medium Fast', q'{Quadruped body}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Swinub]', 220 , 195 , 'Ice', 'Ground', '1:1', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 14.3, 6.5, 'Slow', q'{Quadruped body}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Haxorus]', 612 , 118 , 'Dragon' , '1:1', 'Monster', 'Dragon', 40 , 10280, 10240, 232.6, 105.5, 'Slow', q'{Bipedal, tailed form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Zigzagoon]', 263 , 12 , 'Normal' , '1:1', 'Field' , 15 , 4096, 4080, 3855, 3840, 38.6, 17.5, 'Medium Fast', q'{Quadruped body}', 3 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Flabébé]', 669 , q'|Blue Flower|', 68, 'Ce', 'Fairy' , '1:0', 'Fairy' , 20 , 5140, 5120, 0.2, 0.1, 'Medium Fast', q'{Head and arms}', 6 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Burmy]', 412, 'S' , q'|Trash Cloak|', 45 , 'Bug' , '1:1', 'Bug' , 15 , 4080, 3855, 3840, 7.5, 3.4, 'Medium Fast', q'{Head and a base}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Charmeleon]', 5 , 5 , 'Fire' , '1:7', 'Monster', 'Dragon', 20, 5120, 5376, 5355, 5140, 5120, 41.9, 19, 'Medium Slow', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Sandygast]', 769 , 186 , 'Ghost', 'Ground', '1:1', 'Amorphous' , 15 , 3840, 154.3, 70, 'Medium Fast', q'{Serpentine bodies}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Medicham]', 308 , 77 , 'Fighting', 'Psychic', '1:1', 'Human-Like' , 20 , 5376, 5355, 5140, 5120, 69.4, 31.5, 'Medium Fast', q'{Bipedal, tailless form}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Koffing]', 109 , 109 , 'Poison' , '1:1', 'Amorphous' , 20, 5120, 5376, 5355, 5140, 5120, 2.2, 1, 'Medium Fast', q'{Head}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Bibarel]', 400 , 14 , 'Normal', 'Water', '1:1', 'Water 1', 'Field', 15 , 4080, 3855, 3840, 69.4, 31.5, 'Medium Fast', q'{Bipedal, tailed form}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Buneary]', 427 , 67 , 'Normal' , '1:1', 'Field', 'Human-Like', 20 , 5355, 5140, 5120, 12.1, 5.5, 'Medium Fast', q'{Bipedal, tailed form}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Kricketot]', 401 , 15 , 'Bug' , '1:1', 'Bug' , 15 , 4080, 3855, 3840, 4.9, 2.2, 'Medium Slow', q'{Bipedal, tailless form}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Turtonator]', 776 , 224 , 'Fire', 'Dragon', '1:1', 'Monster', 'Dragon', 20 , 5120, 467.4, 212, 'Medium Fast', q'{Bipedal, tailed form}', 7 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Furfrou]', 676 , q'|Matron Trim|', 93, 'Ce', 'Normal' , '1:1', 'Field' , 20 , 5140, 5120, 61.7, 28, 'Medium Fast', q'{Quadruped body}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Gardevoir]', 282 , 31 , 'Psychic', 'Fairy', '1:1', 'Amorphous' , 20 , 5376, 5355, 5140, 5120, 106.7, 48.4, 'Slow', q'{Bipedal, tailless form}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Torracat]', 726 , 5 , 'Fire' , '1:7', 'Field' , 15 , 3840, 55.1, 25, 'Medium Slow', q'{Quadruped body}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Swadloon]', 541 , 47 , 'Bug', 'Grass', '1:1', 'Bug' , 15 , 3855, 3840, 16.1, 7.3, 'Medium Slow', q'{Head and arms}', 5 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pinsir]', 127, 'M', nq'|Pinsirite|', q'|Mega|', 127 , 'Bug', 'Flying', '1:1', 'Bug' , 25, 6400, 6656, 6630, 6425, 6400, 121.3, 55, 'Slow', q'{Two or more pairs of wings}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Purugly]', 432 , 77 , 'Normal' , '3:1', 'Field' , 20 , 5355, 5140, 5120, 96.6, 43.8, 'Fast', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Delcatty]', 301 , 62 , 'Normal' , '3:1', 'Field', 'Fairy', 15 , 4096, 4080, 3855, 3840, 71.9, 32.6, 'Fast', q'{Quadruped body}', 3 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Blaziken]', 257, 'M', nq'|Blazikenite|', q'|Mega|', 6 , 'Fire', 'Fighting', '1:7', 'Field' , 20 , 5376, 5355, 5140, 5120, 114.6, 52, 'Medium Slow', q'{Bipedal, tailed form}', 3 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Keldeo]', 647 , q'|Ordinary Form|', 153 , 'Water', 'Fighting', ':U', 'Undiscovered' , 80 , 20560, 20480, 106.9, 48.5, 'Slow', q'{Quadruped body}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Rhyperior]', 464 , 188 , 'Ground', 'Rock', '1:1', 'Monster', 'Field', 20 , 5355, 5140, 5120, 623.5, 282.8, 'Slow', q'{Bipedal, tailed form}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Cryogonal]', 615 , 121 , 'Ice' , ':', 'Mineral' , 25 , 6425, 6400, 326.3, 148, 'Medium Fast', q'{Head}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Swablu]', 333 , 121 , 'Normal', 'Flying', '1:1', 'Flying', 'Dragon', 20 , 5376, 5355, 5140, 5120, 2.6, 1.2, 'Erratic', q'{Single pair of wings}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Solgaleo]', 791 , 291 , 'Psychic', 'Steel', ':U', 'Undiscovered' , 120 , 30720, 507.1, 230, 'Slow', q'{Quadruped body}', 7 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Goomy]', 704 , 19, 'Mo', 'Dragon' , '1:1', 'Dragon' , 40 , 10280, 10240, 6.2, 2.8, 'Slow', q'{Serpentine bodies}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Volbeat]', 313 , 86 , 'Bug' , '0:1', 'Bug', 'Human-Like', 15 , 4096, 4080, 3855, 3840, 39, 17.7, 'Erratic', q'{Bipedal, tailed form}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Quilava]', 156 , 5 , 'Fire' , '1:7', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 41.9, 19, 'Medium Slow', q'{Quadruped body}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Snivy]', 495 , 1 , 'Grass' , '1:7', 'Field', 'Grass', 20 , 5140, 5120, 17.9, 8.1, 'Medium Slow', q'{Bipedal, tailed form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Zeraora]', 807 , 403 , 'Electric' , ':U', 'Undiscovered' , 120 , 30720, 98.1, 44.5, 'Slow', q'{Bipedal, tailless form}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Voltorb]', 100 , 100 , 'Electric' , ':', 'Mineral' , 20, 5120, 5376, 5355, 5140, 5120, 22.9, 10.4, 'Medium Fast', q'{Head}', 1 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Vivillon]', 666 , q'|Continental Pattern|', 22, 'Ce', 'Bug', 'Flying', '1:1', 'Bug' , 15 , 3855, 3840, 37.5, 17, 'Medium Fast', q'{Two or more pairs of wings}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Heatmor]', 631 , 137 , 'Fire' , '1:1', 'Field' , 20 , 5140, 5120, 127.9, 58, 'Medium Fast', q'{Bipedal, tailed form}', 5 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Furfrou]', 676 , q'|Pharaoh Trim|', 93, 'Ce', 'Normal' , '1:1', 'Field' , 20 , 5140, 5120, 61.7, 28, 'Medium Fast', q'{Quadruped body}', 6 );
insert into Pokemon( NAME, DEX , CLASS , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Arceus]', 493 , q'|Type: Ghost|' , 'Normal' , ':U', 'Undiscovered' , 120 , 30855, 30840, 30720, 705.5, 320, 'Slow', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Swanna]', 581 , 87 , 'Water', 'Flying', '1:1', 'Water 1', 'Flying', 20 , 5140, 5120, 53.4, 24.2, 'Medium Fast', q'{Single pair of wings}', 5 );
insert into Pokemon( NAME, DEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Darkrai]', 491 , 'Dark' , ':U', 'Undiscovered' , 120 , 30855, 30840, 30720, 111.3, 50.5, 'Slow', q'{Bipedal, tailless form}', 4 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Unown]', 201 , q'|One form|', 61 , 'Psychic' , ':U', 'Undiscovered' , 40, 10240, 10496, 10455, 10280, 10240, 11, 5, 'Medium Fast', q'{Head}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Shroomish]', 285 , 34 , 'Grass' , '1:1', 'Fairy', 'Grass', 15 , 4096, 4080, 3855, 3840, 9.9, 4.5, 'Fluctuating', q'{Head and legs}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Gothitelle]', 576 , 82 , 'Psychic' , '3:1', 'Human-Like' , 20 , 5140, 5120, 97, 44, 'Medium Slow', q'{Bipedal, tailless form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Torterra]', 389 , 3 , 'Grass', 'Ground', '1:7', 'Monster', 'Grass', 20 , 5355, 5140, 5120, 683.4, 310, 'Medium Slow', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Escavalier]', 589 , 95 , 'Bug', 'Steel', '1:1', 'Bug' , 15 , 3855, 3840, 72.8, 33, 'Medium Fast', q'{Head and arms}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pachirisu]', 417 , 55 , 'Electric' , '1:1', 'Field', 'Fairy', 10 , 2805, 2570, 2560, 8.6, 3.9, 'Medium Fast', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Bronzong]', 437 , 89 , 'Steel', 'Psychic', ':', 'Mineral' , 20 , 5355, 5140, 5120, 412.3, 187, 'Medium Fast', q'{Head and arms}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Magby]', 240 , 152 , 'Fire' , '1:3U', 'Undiscovered' , 25, 6400, 6656, 6630, 6425, 6400, 47.2, 21.4, 'Medium Fast', q'{Bipedal, tailed form}', 2 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Heliolisk]', 695 , 47, 'Co', 'Electric', 'Normal', '1:1', 'Monster', 'Dragon', 20 , 5140, 5120, 46.3, 21, 'Medium Fast', q'{Bipedal, tailed form}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Morelull]', 755 , 145 , 'Grass', 'Fairy', '1:1', 'Grass' , 20 , 5120, 3.3, 1.5, 'Medium Fast', q'{Head and a base}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Diglett]', 50 , 50 , 'Ground' , '1:1', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 1.8, 0.8, 'Medium Fast', q'{Head and a base}', 1 );
insert into Pokemon( NAME, DEX , CLASS , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Arceus]', 493 , q'|Type: Fairy|' , 'Normal' , ':U', 'Undiscovered' , 120 , 30855, 30840, 30720, 705.5, 320, 'Slow', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pichu]', 172 , q'|Spiky-eared|', 21 , 'Electric' , '1:1U', 'Undiscovered' , 10, 2560, 2816, 2805, 2570, 2560, 4.4, 2, 'Medium Fast', q'{Quadruped body}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Primarina]', 730 , 9 , 'Water', 'Fairy', '1:7', 'Water 1', 'Field', 15 , 3840, 97, 44, 'Medium Slow', q'{Fins}', 7 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Skrelp]', 690 , 30, 'Co', 'Poison', 'Water', '1:1', 'Water 1', 'Dragon', 20 , 5140, 5120, 16.1, 7.3, 'Medium Fast', q'{Head and a base}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Luxio]', 404 , 18 , 'Electric' , '1:1', 'Field' , 20 , 5355, 5140, 5120, 67.2, 30.5, 'Medium Slow', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Stufful]', 759 , 169 , 'Normal', 'Fighting', '1:1', 'Field' , 15 , 3840, 15, 6.8, 'Medium Fast', q'{Quadruped body}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Grotle]', 388 , 2 , 'Grass' , '1:7', 'Monster', 'Grass', 20 , 5355, 5140, 5120, 213.8, 97, 'Medium Slow', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Carracosta]', 565 , 71 , 'Water', 'Rock', '1:7', 'Water 1', 'Water 3', 30 , 7710, 7680, 178.6, 81, 'Medium Fast', q'{Bipedal, tailed form}', 5 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Doublade]', 680 , 118, 'Ce', 'Steel', 'Ghost', '1:1', 'Mineral' , 20 , 5140, 5120, 9.9, 4.5, 'Medium Fast', q'{Multiple bodies}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Skorupi]', 451 , 127 , 'Poison', 'Bug', '1:1', 'Bug', 'Water 3', 20 , 5355, 5140, 5120, 26.5, 12, 'Slow', q'{Insectoid body}', 4 );
insert into Pokemon( NAME, DEX , CLASS , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Arceus]', 493 , q'|Type: Bug|' , 'Normal' , ':U', 'Undiscovered' , 120 , 30855, 30840, 30720, 705.5, 320, 'Slow', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Klang]', 600 , 106 , 'Steel' , ':', 'Mineral' , 20 , 5140, 5120, 112.4, 51, 'Medium Slow', q'{Multiple bodies}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Golduck]', 55 , 55 , 'Water' , '1:1', 'Water 1', 'Field', 20, 5120, 5376, 5355, 5140, 5120, 168.9, 76.6, 'Medium Fast', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Sentret]', 161 , 19 , 'Normal' , '1:1', 'Field' , 15, 3840, 4096, 4080, 3855, 3840, 13.2, 6, 'Medium Fast', q'{Quadruped body}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Jolteon]', 135 , 135 , 'Electric' , '1:7', 'Field' , 35, 8960, 9216, 9180, 8995, 8960, 54, 24.5, 'Medium Fast', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Charizard]', 6 , 6 , 'Fire', 'Flying', '1:7', 'Monster', 'Dragon', 20, 5120, 5376, 5355, 5140, 5120, 199.5, 90.5, 'Medium Slow', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Volcarona]', 637 , 143 , 'Bug', 'Fire', '1:1', 'Bug' , 40 , 10280, 10240, 101.4, 46, 'Slow', q'{Two or more pairs of wings}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Galvantula]', 596 , 102 , 'Bug', 'Electric', '1:1', 'Bug' , 20 , 5140, 5120, 31.5, 14.3, 'Medium Fast', q'{Insectoid body}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Beheeyem]', 606 , 112 , 'Psychic' , '1:1', 'Human-Like' , 20 , 5140, 5120, 76.1, 34.5, 'Medium Fast', q'{Bipedal, tailless form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Chimchar]', 390 , 4 , 'Fire' , '1:7', 'Field', 'Human-Like', 20 , 5355, 5140, 5120, 13.7, 6.2, 'Medium Slow', q'{Bipedal, tailed form}', 4 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Vivillon]', 666 , q'|Garden Pattern|', 22, 'Ce', 'Bug', 'Flying', '1:1', 'Bug' , 15 , 3855, 3840, 37.5, 17, 'Medium Fast', q'{Two or more pairs of wings}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Nihilego]', 793 , 293 , 'Rock', 'Poison', ':U', 'Undiscovered' , 120 , 30720, 122.4, 55.5, 'Slow', q'{Tentacles or a multiped body}', 7 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Lycanroc]', 745 , q'|Midday Form|', 104 , 'Rock' , '1:1', 'Field' , 15 , 3840, 55.1, 25, 'Medium Fast', q'{Quadruped body}', 7 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Tyrantrum]', 697 , 65, 'Co', 'Rock', 'Dragon', '1:7', 'Monster', 'Dragon', 30 , 7710, 7680, 595.2, 270, 'Medium Fast', q'{Bipedal, tailed form}', 6 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Wormadam]', 413 , q'|Plant Cloak|', 46 , 'Bug', 'Grass', '1:0', 'Bug' , 15 , 4080, 3855, 3840, 14.3, 6.5, 'Medium Fast', q'{Head and a base}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Dugtrio]', 51 , 51 , 'Ground' , '1:1', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 73.4, 33.3, 'Medium Fast', q'{Multiple bodies}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Ducklett]', 580 , 86 , 'Water', 'Flying', '1:1', 'Water 1', 'Flying', 20 , 5140, 5120, 12.1, 5.5, 'Medium Fast', q'{Single pair of wings}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Dodrio]', 85 , 85 , 'Normal', 'Flying', '1:1', 'Flying' , 20, 5120, 5376, 5355, 5140, 5120, 187.8, 85.2, 'Medium Fast', q'{Head and legs}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Zebstrika]', 523 , 29 , 'Electric' , '1:1', 'Field' , 20 , 5140, 5120, 175.3, 79.5, 'Medium Fast', q'{Quadruped body}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Politoed]', 186 , 75 , 'Water' , '1:1', 'Water 1' , 20, 5120, 5376, 5355, 5140, 5120, 74.7, 33.9, 'Medium Slow', q'{Bipedal, tailless form}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Azurill]', 298 , 54 , 'Normal', 'Fairy', '3:1U', 'Undiscovered' , 10 , 2816, 2805, 2570, 2560, 4.4, 2, 'Fast', q'{Head and legs}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Hitmonlee]', 106 , 106 , 'Fighting' , '0:1', 'Human-Like' , 25, 6400, 6656, 6630, 6425, 6400, 109.8, 49.8, 'Medium Fast', q'{Bipedal, tailless form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Anorith]', 347 , 135 , 'Rock', 'Bug', '1:7', 'Water 3' , 30 , 7936, 7905, 7710, 7680, 27.6, 12.5, 'Erratic', q'{Insectoid body}', 3 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Silvally]', 773 , q'|Type: Water|', 204 , 'Normal' , ':U', 'Undiscovered' , 120 , 30720, 221.6, 100.5, 'Slow', q'{Quadruped body}', 7 );
insert into Pokemon( NAME, DEX , CLASS , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Arceus]', 493 , q'|Type: Rock|' , 'Normal' , ':U', 'Undiscovered' , 120 , 30855, 30840, 30720, 705.5, 320, 'Slow', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Aromatisse]', 683 , 130, 'Ce', 'Fairy' , '1:1', 'Fairy' , 20 , 5140, 5120, 34.2, 15.5, 'Medium Fast', q'{Bipedal, tailless form}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Mudsdale]', 750 , 133 , 'Ground' , '1:1', 'Field' , 20 , 5120, 2028.3, 920, 'Medium Fast', q'{Quadruped body}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Swoobat]', 528 , 34 , 'Psychic', 'Flying', '1:1', 'Field', 'Flying', 15 , 3855, 3840, 23.1, 10.5, 'Medium Fast', q'{Single pair of wings}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Bonsly]', 438 , 92 , 'Rock' , '1:1U', 'Undiscovered' , 20 , 5355, 5140, 5120, 33.1, 15, 'Medium Fast', q'{Head and legs}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Porygon-Z]', 474 , 194 , 'Normal' , ':', 'Mineral' , 20 , 5355, 5140, 5120, 75, 34, 'Medium Fast', q'{Head and arms}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Raikou]', 243 , 243 , 'Electric' , ':U', 'Undiscovered' , 80, 20480, 20736, 20655, 20560, 20480, 392.4, 178, 'Slow', q'{Quadruped body}', 2 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Darmanitan]', 555, 'Z' , q'|Zen Mode|', 61 , 'Fire', 'Psychic', '1:1', 'Field' , 20 , 5140, 5120, 204.8, 92.9, 'Medium Slow', q'{Quadruped body}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Clamperl]', 366 , 176 , 'Water' , '1:1', 'Water 1' , 20 , 5376, 5355, 5140, 5120, 115.7, 52.5, 'Erratic', q'{Head}', 3 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Chespin]', 650 , 1, 'Ce', 'Grass' , '1:7', 'Field' , 20 , 5140, 5120, 19.8, 9, 'Medium Slow', q'{Bipedal, tailed form}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Ekans]', 23 , 23 , 'Poison' , '1:1', 'Field', 'Dragon', 20, 5120, 5376, 5355, 5140, 5120, 15.2, 6.9, 'Medium Fast', q'{Serpentine bodies}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Marshadow]', 802 , 302 , 'Fighting', 'Ghost', ':U', 'Undiscovered' , 120 , 30720, 48.9, 22.2, 'Slow', q'{Bipedal, tailless form}', 7 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Tyrunt]', 696 , 64, 'Co', 'Rock', 'Dragon', '1:7', 'Monster', 'Dragon', 30 , 7710, 7680, 57.3, 26, 'Medium Fast', q'{Bipedal, tailed form}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Luvdisc]', 370 , 183 , 'Water' , '3:1', 'Water 2' , 20 , 5376, 5355, 5140, 5120, 19.2, 8.7, 'Fast', q'{Fins}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Darumaka]', 554 , 60 , 'Fire' , '1:1', 'Field' , 20 , 5140, 5120, 82.7, 37.5, 'Medium Slow', q'{Bipedal, tailless form}', 5 );
insert into Pokemon( NAME, DEX , CLASS , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Arceus]', 493 , q'|Type: Grass|' , 'Normal' , ':U', 'Undiscovered' , 120 , 30855, 30840, 30720, 705.5, 320, 'Slow', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS, LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Greninja]', 658, 'A' , q'|Ash-Greninja|', 9, 'Ce', 'Water', 'Dark', '1:7', 'Water 1' , 20 , 5140, 5120, 88.2, 40, 'Medium Slow', q'{Bipedal, tailless form}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Ludicolo]', 272 , 21 , 'Water', 'Grass', '1:1', 'Water 1', 'Grass', 15 , 4096, 4080, 3855, 3840, 121.3, 55, 'Medium Slow', q'{Bipedal, tailless form}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Zapdos]', 145 , 145 , 'Electric', 'Flying', ':U', 'Undiscovered' , 80, 20480, 20736, 20655, 20560, 20480, 116, 52.6, 'Slow', q'{Single pair of wings}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Natu]', 177 , 161 , 'Psychic', 'Flying', '1:1', 'Flying' , 20, 5120, 5376, 5355, 5140, 5120, 4.4, 2, 'Medium Fast', q'{Single pair of wings}', 2 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Gengar]', 94, 'M', nq'|Gengarite|', q'|Mega|', 94 , 'Ghost', 'Poison', '1:1', 'Amorphous' , 20, 5120, 5376, 5355, 5140, 5120, 89.3, 40.5, 'Medium Slow', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Magikarp]', 129 , 129 , 'Water' , '1:1', 'Water 2', 'Dragon', 5, 1280, 1536, 1530, 1285, 1280, 22, 10, 'Slow', q'{Fins}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Golett]', 622 , 128 , 'Ground', 'Ghost', ':', 'Mineral' , 25 , 6425, 6400, 202.8, 92, 'Medium Fast', q'{Bipedal, tailless form}', 5 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Exeggutor]', 103, 'A' , q'|Alolan|' , 'Grass', 'Dragon', '1:1', 'Grass' , 20, 5120, 5376, 5355, 5140, 5120, 264.6, 120, 'Slow', q'{Head and legs}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Cosmog]', 789 , 289 , 'Psychic' , ':U', 'Undiscovered' , 120 , 30720, 0.2, 0.1, 'Slow', q'{Head}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Chikorita]', 152 , 1 , 'Grass' , '1:7', 'Monster', 'Grass', 20, 5120, 5376, 5355, 5140, 5120, 14.1, 6.4, 'Medium Slow', q'{Quadruped body}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Spheal]', 363 , 173 , 'Ice', 'Water', '1:1', 'Water 1', 'Field', 20 , 5376, 5355, 5140, 5120, 87.1, 39.5, 'Medium Slow', q'{Fins}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Lillipup]', 506 , 12 , 'Normal' , '1:1', 'Field' , 15 , 3855, 3840, 9, 4.1, 'Medium Slow', q'{Quadruped body}', 5 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Silvally]', 773 , q'|Type: Ghost|', 204 , 'Normal' , ':U', 'Undiscovered' , 120 , 30720, 221.6, 100.5, 'Slow', q'{Quadruped body}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pansage]', 511 , 17 , 'Grass' , '1:7', 'Field' , 20 , 5140, 5120, 23.1, 10.5, 'Medium Fast', q'{Bipedal, tailed form}', 5 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Vivillon]', 666 , q'|Jungle Pattern|', 22, 'Ce', 'Bug', 'Flying', '1:1', 'Bug' , 15 , 3855, 3840, 37.5, 17, 'Medium Fast', q'{Two or more pairs of wings}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Ninjask]', 291 , 43 , 'Bug', 'Flying', '1:1', 'Bug' , 15 , 4096, 4080, 3855, 3840, 26.5, 12, 'Erratic', q'{Two or more pairs of wings}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Dragonair]', 148 , 148 , 'Dragon' , '1:1', 'Water 1', 'Dragon', 40, 10240, 10496, 10455, 10280, 10240, 36.4, 16.5, 'Slow', q'{Serpentine bodies}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Zubat]', 41 , 41 , 'Poison', 'Flying', '1:1', 'Flying' , 15, 3840, 4096, 4080, 3855, 3840, 16.5, 7.5, 'Medium Fast', q'{Single pair of wings}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Sneasel]', 215 , 218 , 'Dark', 'Ice', '1:1', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 61.7, 28, 'Medium Slow', q'{Bipedal, tailed form}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Stantler]', 234 , 131 , 'Normal' , '1:1', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 157, 71.2, 'Slow', q'{Quadruped body}', 2 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Mawile]', 303, 'M', nq'|Mawilite|', q'|Mega|', 69 , 'Steel', 'Fairy', '1:1', 'Field', 'Fairy', 20 , 5376, 5355, 5140, 5120, 25.4, 11.5, 'Fast', q'{Bipedal, tailless form}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Amoonguss]', 591 , 97 , 'Grass', 'Poison', '1:1', 'Grass' , 20 , 5140, 5120, 23.1, 10.5, 'Medium Fast', q'{Head and arms}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Ralts]', 280 , 29 , 'Psychic', 'Fairy', '1:1', 'Amorphous' , 20 , 5376, 5355, 5140, 5120, 14.6, 6.6, 'Slow', q'{Bipedal, tailless form}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Duosion]', 578 , 84 , 'Psychic' , '1:1', 'Amorphous' , 20 , 5140, 5120, 17.6, 8, 'Medium Slow', q'{Head}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Gothita]', 574 , 80 , 'Psychic' , '3:1', 'Human-Like' , 20 , 5140, 5120, 12.8, 5.8, 'Medium Slow', q'{Bipedal, tailless form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Grumpig]', 326 , 111 , 'Psychic' , '1:1', 'Field' , 20 , 5376, 5355, 5140, 5120, 157.6, 71.5, 'Fast', q'{Bipedal, tailed form}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Popplio]', 728 , 7 , 'Water' , '1:7', 'Water 1', 'Field', 15 , 3840, 16.5, 7.5, 'Medium Slow', q'{Fins}', 7 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Fletchling]', 661 , 14, 'Ce', 'Normal', 'Flying', '1:1', 'Flying' , 15 , 3855, 3840, 3.7, 1.7, 'Medium Slow', q'{Single pair of wings}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Roserade]', 407 , 27 , 'Grass', 'Poison', '1:1', 'Fairy', 'Grass', 20 , 5355, 5140, 5120, 32, 14.5, 'Medium Slow', q'{Bipedal, tailless form}', 4 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Vivillon]', 666 , q'|Sandstorm Pattern|', 22, 'Ce', 'Bug', 'Flying', '1:1', 'Bug' , 15 , 3855, 3840, 37.5, 17, 'Medium Fast', q'{Two or more pairs of wings}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Venusaur]', 3 , 3 , 'Grass', 'Poison', '1:7', 'Monster', 'Grass', 20, 5120, 5376, 5355, 5140, 5120, 220.5, 100, 'Medium Slow', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Samurott]', 503 , 9 , 'Water' , '1:7', 'Field' , 20 , 5140, 5120, 208.6, 94.6, 'Medium Slow', q'{Quadruped body}', 5 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Vivillon]', 666 , q'|Polar Pattern|', 22, 'Ce', 'Bug', 'Flying', '1:1', 'Bug' , 15 , 3855, 3840, 37.5, 17, 'Medium Fast', q'{Two or more pairs of wings}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Wingull]', 278 , 27 , 'Water', 'Flying', '1:1', 'Water 1', 'Flying', 20 , 5376, 5355, 5140, 5120, 20.9, 9.5, 'Medium Fast', q'{Single pair of wings}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Zorua]', 570 , 76 , 'Dark' , '1:7', 'Field' , 25 , 6425, 6400, 27.6, 12.5, 'Medium Slow', q'{Quadruped body}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Misdreavus]', 200 , 219 , 'Ghost' , '1:1', 'Amorphous' , 25, 6400, 6656, 6630, 6425, 6400, 2.2, 1, 'Fast', q'{Head}', 2 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Necrozma]', 800, 'DW' , q'|Dawn Wings|', 300 , 'Psychic' , ':U', 'Undiscovered' , 120 , 30720, 771.6, 350, 'Slow', q'{Single pair of wings}', 7 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Chesnaught]', 652 , 3, 'Ce', 'Grass', 'Fighting', '1:7', 'Field' , 20 , 5140, 5120, 198.4, 90, 'Medium Slow', q'{Bipedal, tailed form}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Poliwrath]', 62 , 62 , 'Water', 'Fighting', '1:1', 'Water 1' , 20, 5120, 5376, 5355, 5140, 5120, 119, 54, 'Medium Slow', q'{Bipedal, tailless form}', 1 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Vivillon]', 666 , q'|Monsoon Pattern|', 22, 'Ce', 'Bug', 'Flying', '1:1', 'Bug' , 15 , 3855, 3840, 37.5, 17, 'Medium Fast', q'{Two or more pairs of wings}', 6 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pikachu]', 25 , q'|Pop Star|', 25 , 'Electric' , '1:1', 'Field', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 13.2, 6, 'Medium Fast', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Larvesta]', 636 , 142 , 'Bug', 'Fire', '1:1', 'Bug' , 40 , 10280, 10240, 63.5, 28.8, 'Slow', q'{Insectoid body}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Grimer]', 88 , 88 , 'Poison' , '1:1', 'Amorphous' , 20, 5120, 5376, 5355, 5140, 5120, 66.1, 30, 'Medium Fast', q'{Head and arms}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Aerodactyl]', 142 , 142 , 'Rock', 'Flying', '1:7', 'Flying' , 35, 8960, 9216, 9180, 8995, 8960, 130.1, 59, 'Slow', q'{Single pair of wings}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Bagon]', 371 , 187 , 'Dragon' , '1:1', 'Dragon' , 40 , 10496, 10455, 10280, 10240, 92.8, 42.1, 'Slow', q'{Bipedal, tailless form}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Munchlax]', 446 , 112 , 'Normal' , '1:7U', 'Undiscovered' , 40 , 10455, 10280, 10240, 231.5, 105, 'Slow', q'{Bipedal, tailless form}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Raichu]', 26 , 26 , 'Electric' , '1:1', 'Field', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 66.1, 30, 'Medium Fast', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Oranguru]', 765 , 176 , 'Normal', 'Psychic', '1:1', 'Field' , 20 , 5120, 167.6, 76, 'Slow', q'{Bipedal, tailless form}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Watchog]', 505 , 11 , 'Normal' , '1:1', 'Field' , 20 , 5140, 5120, 59.5, 27, 'Medium Fast', q'{Bipedal, tailed form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Breloom]', 286 , 35 , 'Grass', 'Fighting', '1:1', 'Fairy', 'Grass', 15 , 4096, 4080, 3855, 3840, 86.4, 39.2, 'Fluctuating', q'{Bipedal, tailed form}', 3 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Cherrim]', 421 , q'|Overcast Form|', 59 , 'Grass' , '1:1', 'Fairy', 'Grass', 20 , 5355, 5140, 5120, 20.5, 9.3, 'Medium Fast', q'{Head and legs}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Mandibuzz]', 630 , 136 , 'Dark', 'Flying', '1:0', 'Flying' , 20 , 5140, 5120, 87.1, 39.5, 'Slow', q'{Single pair of wings}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Gumshoos]', 735 , 14 , 'Normal' , '1:1', 'Field' , 15 , 3840, 31.3, 14.2, 'Medium Fast', q'{Quadruped body}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Venipede]', 543 , 49 , 'Bug', 'Poison', '1:1', 'Bug' , 15 , 3855, 3840, 11.7, 5.3, 'Medium Slow', q'{Insectoid body}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Ninetales]', 38 , 38 , 'Fire' , '3:1', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 43.9, 19.9, 'Medium Fast', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Landorus]', 645, 'T' , q'|Therian Forme|', 151 , 'Ground', 'Flying', '0:1U', 'Undiscovered' , 120 , 30840, 30720, 149.9, 68, 'Slow', q'{Quadruped body}', 5 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Beedrill]', 15, 'M', nq'|Beedrillite|', q'|Mega|', 15 , 'Bug', 'Poison', '1:1', 'Bug' , 15, 3840, 4096, 4080, 3855, 3840, 65, 29.5, 'Medium Fast', q'{Two or more pairs of wings}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Venomoth]', 49 , 49 , 'Bug', 'Poison', '1:1', 'Bug' , 20, 5120, 5376, 5355, 5140, 5120, 27.6, 12.5, 'Medium Fast', q'{Two or more pairs of wings}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Mantyke]', 458 , 140 , 'Water', 'Flying', '1:1U', 'Undiscovered' , 25 , 6630, 6425, 6400, 143.3, 65, 'Slow', q'{Single pair of wings}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Flygon]', 330 , 118 , 'Ground', 'Dragon', '1:1', 'Bug' , 20 , 5376, 5355, 5140, 5120, 180.8, 82, 'Medium Slow', q'{Single pair of wings}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Serperior]', 497 , 3 , 'Grass' , '1:7', 'Field', 'Grass', 20 , 5140, 5120, 138.9, 63, 'Medium Slow', q'{Serpentine bodies}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Luxray]', 405 , 19 , 'Electric' , '1:1', 'Field' , 20 , 5355, 5140, 5120, 92.6, 42, 'Medium Slow', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Silvally]', 773 , q'|Type: Poison|', 204 , 'Normal' , ':U', 'Undiscovered' , 120 , 30720, 221.6, 100.5, 'Slow', q'{Quadruped body}', 7 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Frillish]', 592, 'F' , 98 , 'Water', 'Ghost', '1:1', 'Amorphous' , 20 , 5140, 5120, 72.8, 33, 'Medium Fast', q'{Tentacles or a multiped body}', 5 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Vivillon]', 666 , q'|River Pattern|', 22, 'Ce', 'Bug', 'Flying', '1:1', 'Bug' , 15 , 3855, 3840, 37.5, 17, 'Medium Fast', q'{Two or more pairs of wings}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Typhlosion]', 157 , 6 , 'Fire' , '1:7', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 175.3, 79.5, 'Medium Slow', q'{Quadruped body}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Trubbish]', 568 , 74 , 'Poison' , '1:1', 'Mineral' , 20 , 5140, 5120, 68.3, 31, 'Medium Fast', q'{Bipedal, tailless form}', 5 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Sawsbuck]', 586 , q'|Autumn Form|', 92 , 'Normal', 'Grass', '1:1', 'Field' , 20 , 5140, 5120, 203.9, 92.5, 'Medium Fast', q'{Quadruped body}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Rufflet]', 627 , 133 , 'Normal', 'Flying', '0:1', 'Flying' , 20 , 5140, 5120, 23.1, 10.5, 'Slow', q'{Single pair of wings}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Ivysaur]', 2 , 2 , 'Grass', 'Poison', '1:7', 'Monster', 'Grass', 20, 5120, 5376, 5355, 5140, 5120, 28.7, 13, 'Medium Slow', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Leavanny]', 542 , 48 , 'Bug', 'Grass', '1:1', 'Bug' , 15 , 3855, 3840, 45.2, 20.5, 'Medium Slow', q'{Bipedal, tailless form}', 5 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Houndoom]', 229, 'M', nq'|Houndoominite|', q'|Mega|', 215 , 'Dark', 'Fire', '1:1', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 77.2, 35, 'Slow', q'{Quadruped body}', 2 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Silvally]', 773 , q'|Type: Psychic|', 204 , 'Normal' , ':U', 'Undiscovered' , 120 , 30720, 221.6, 100.5, 'Slow', q'{Quadruped body}', 7 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Florges]', 671 , q'|Red Flower|', 70, 'Ce', 'Fairy' , '1:0', 'Fairy' , 20 , 5140, 5120, 22, 10, 'Medium Fast', q'{Head and arms}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Minun]', 312 , 81 , 'Electric' , '1:1', 'Fairy' , 20 , 5376, 5355, 5140, 5120, 9.3, 4.2, 'Medium Fast', q'{Bipedal, tailed form}', 3 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Deoxys]', 386 , q'|Normal Forme|', 202 , 'Psychic' , ':U', 'Undiscovered' , 120 , 30976, 30855, 30840, 30720, 134, 60.8, 'Slow', q'{Bipedal, tailless form}', 3 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Thundurus]', 642 , q'|Incarnate Forme|', 148 , 'Electric', 'Flying', '0:1U', 'Undiscovered' , 120 , 30840, 30720, 134.5, 61, 'Slow', q'{Head and arms}', 5 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Darmanitan]', 555 , q'|Standard Mode|', 61 , 'Fire' , '1:1', 'Field' , 20 , 5140, 5120, 204.8, 92.9, 'Medium Slow', q'{Quadruped body}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Liepard]', 510 , 16 , 'Dark' , '1:1', 'Field' , 20 , 5140, 5120, 82.7, 37.5, 'Medium Fast', q'{Quadruped body}', 5 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Furfrou]', 676 , q'|La Reine Trim|', 93, 'Ce', 'Normal' , '1:1', 'Field' , 20 , 5140, 5120, 61.7, 28, 'Medium Fast', q'{Quadruped body}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pawniard]', 624 , 130 , 'Dark', 'Steel', '1:1', 'Human-Like' , 20 , 5140, 5120, 22.5, 10.2, 'Medium Fast', q'{Bipedal, tailless form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Electabuzz]', 125 , 125 , 'Electric' , '1:3', 'Human-Like' , 25, 6400, 6656, 6630, 6425, 6400, 66.1, 30, 'Medium Fast', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Arcanine]', 59 , 59 , 'Fire' , '1:3', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 341.7, 155, 'Slow', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Boldore]', 525 , 31 , 'Rock' , '1:1', 'Mineral' , 15 , 3855, 3840, 224.9, 102, 'Medium Slow', q'{Tentacles or a multiped body}', 5 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Silvally]', 773 , q'|Type: Electric|', 204 , 'Normal' , ':U', 'Undiscovered' , 120 , 30720, 221.6, 100.5, 'Slow', q'{Quadruped body}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Octillery]', 224 , 175 , 'Water' , '1:1', 'Water 1', 'Water 2', 20, 5120, 5376, 5355, 5140, 5120, 62.8, 28.5, 'Medium Fast', q'{Tentacles or a multiped body}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Lucario]', 448 , 116 , 'Fighting', 'Steel', '1:7', 'Field', 'Human-Like', 25 , 6630, 6425, 6400, 119, 54, 'Medium Slow', q'{Bipedal, tailed form}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Rockruff]', 744 , 103 , 'Rock' , '1:1', 'Field' , 15 , 3840, 20.3, 9.2, 'Medium Fast', q'{Quadruped body}', 7 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Silvally]', 773 , q'|Type: Steel|', 204 , 'Normal' , ':U', 'Undiscovered' , 120 , 30720, 221.6, 100.5, 'Slow', q'{Quadruped body}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Cascoon]', 268 , 17 , 'Bug' , '1:1', 'Bug' , 15 , 4096, 4080, 3855, 3840, 25.4, 11.5, 'Medium Fast', q'{Head}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Dusclops]', 356 , 149 , 'Ghost' , '1:1', 'Amorphous' , 25 , 6656, 6630, 6425, 6400, 67.5, 30.6, 'Fast', q'{Bipedal, tailless form}', 3 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Florges]', 671 , q'|Orange Flower|', 70, 'Ce', 'Fairy' , '1:0', 'Fairy' , 20 , 5140, 5120, 22, 10, 'Medium Fast', q'{Head and arms}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Servine]', 496 , 2 , 'Grass' , '1:7', 'Field', 'Grass', 20 , 5140, 5120, 35.3, 16, 'Medium Slow', q'{Bipedal, tailed form}', 5 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Solgaleo]', 791 , q'|Radiant Sun phase|', 291 , 'Psychic', 'Steel', ':U', 'Undiscovered' , 120 , 30720, 507.1, 230, 'Slow', q'{Quadruped body}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Golem]', 76 , 76 , 'Rock', 'Ground', '1:1', 'Mineral' , 15, 3840, 4096, 4080, 3855, 3840, 661.4, 300, 'Medium Slow', q'{Bipedal, tailless form}', 1 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Fletchinder]', 662 , 15, 'Ce', 'Fire', 'Flying', '1:1', 'Flying' , 15 , 3855, 3840, 35.3, 16, 'Medium Slow', q'{Single pair of wings}', 6 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pikachu]', 25 , q'|Original Cap|', 25 , 'Electric' , '1:1', 'Field', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 13.2, 6, 'Medium Fast', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Wormadam]', 413, 'G' , q'|Sandy Cloak|', 46 , 'Bug', 'Ground', '1:0', 'Bug' , 15 , 4080, 3855, 3840, 14.3, 6.5, 'Medium Fast', q'{Head and a base}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Roggenrola]', 524 , 30 , 'Rock' , '1:1', 'Mineral' , 15 , 3855, 3840, 39.7, 18, 'Medium Slow', q'{Head and legs}', 5 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Vivillon]', 666 , q'|Fancy Pattern|', 22, 'Ce', 'Bug', 'Flying', '1:1', 'Bug' , 15 , 3855, 3840, 37.5, 17, 'Medium Fast', q'{Two or more pairs of wings}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Alakazam]', 65 , 65 , 'Psychic' , '1:3', 'Human-Like' , 20, 5120, 5376, 5355, 5140, 5120, 105.8, 48, 'Medium Slow', q'{Bipedal, tailless form}', 1 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Marshadow]', 802 , q'|Zenith|', 302 , 'Fighting', 'Ghost', ':U', 'Undiscovered' , 120 , 30720, 48.9, 22.2, 'Slow', q'{Bipedal, tailless form}', 7 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Florges]', 671 , q'|White Flower|', 70, 'Ce', 'Fairy' , '1:0', 'Fairy' , 20 , 5140, 5120, 22, 10, 'Medium Fast', q'{Head and arms}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Cobalion]', 638 , 144 , 'Steel', 'Fighting', ':U', 'Undiscovered' , 80 , 20560, 20480, 551.2, 250, 'Slow', q'{Quadruped body}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Necrozma]', 800 , 300 , 'Psychic' , ':U', 'Undiscovered' , 120 , 30720, 507.1, 230, 'Slow', q'{Head and arms}', 7 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Rayquaza]', 384, 'M', nq'|None*|', q'|Mega|', 200 , 'Dragon', 'Flying', ':U', 'Undiscovered' , 120 , 30976, 30855, 30840, 30720, 455.2, 206.5, 'Slow', q'{Serpentine bodies}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Rattata]', 19 , 19 , 'Normal' , '1:1', 'Field' , 15, 3840, 4096, 4080, 3855, 3840, 7.7, 3.5, 'Medium Fast', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Skarmory]', 227 , 203 , 'Steel', 'Flying', '1:1', 'Flying' , 25, 6400, 6656, 6630, 6425, 6400, 111.3, 50.5, 'Slow', q'{Single pair of wings}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Bastiodon]', 411 , 39 , 'Rock', 'Steel', '1:7', 'Monster' , 30 , 7905, 7710, 7680, 329.6, 149.5, 'Erratic', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Gourgeist]', 711 , q'|Large Size|', 64, 'Mo', 'Ghost', 'Grass', '1:1', 'Amorphous' , 20 , 5140, 5120, 30.9, 14, 'Medium Fast', q'{Head and a base}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Tangrowth]', 465 , 182 , 'Grass' , '1:1', 'Grass' , 20 , 5355, 5140, 5120, 283.5, 128.6, 'Medium Fast', q'{Bipedal, tailless form}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Snorlax]', 143 , 143 , 'Normal' , '1:7', 'Monster' , 40, 10240, 10496, 10455, 10280, 10240, 1014.1, 460, 'Slow', q'{Bipedal, tailless form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Latios]', 381 , 197 , 'Dragon', 'Psychic', '0:1U', 'Undiscovered' , 120 , 30976, 30855, 30840, 30720, 132.3, 60, 'Slow', q'{Single pair of wings}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Mienshao]', 620 , 126 , 'Fighting' , '1:1', 'Field', 'Human-Like', 25 , 6425, 6400, 78.3, 35.5, 'Medium Slow', q'{Bipedal, tailed form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Walrein]', 365 , 175 , 'Ice', 'Water', '1:1', 'Water 1', 'Field', 20 , 5376, 5355, 5140, 5120, 332, 150.6, 'Medium Slow', q'{Quadruped body}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Seedot]', 273 , 22 , 'Grass' , '1:1', 'Field', 'Grass', 15 , 4096, 4080, 3855, 3840, 8.8, 4, 'Medium Slow', q'{Head and legs}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Kartana]', 798 , 298 , 'Grass', 'Steel', ':U', 'Undiscovered' , 120 , 30720, 0.2, 0.1, 'Slow', q'{Bipedal, tailless form}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Celesteela]', 797 , 297 , 'Steel', 'Flying', ':U', 'Undiscovered' , 120 , 30720, 2204.4, 999.9, 'Slow', q'{Bipedal, tailless form}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Paras]', 46 , 46 , 'Bug', 'Grass', '1:1', 'Bug', 'Grass', 20, 5120, 5376, 5355, 5140, 5120, 11.9, 5.4, 'Medium Fast', q'{Insectoid body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Masquerain]', 284 , 33 , 'Bug', 'Flying', '1:1', 'Water 1', 'Bug', 15 , 4096, 4080, 3855, 3840, 7.9, 3.6, 'Medium Fast', q'{Two or more pairs of wings}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Salazzle]', 758 , 162 , 'Poison', 'Fire', '1:0', 'Monster', 'Dragon', 20 , 5120, 48.9, 22.2, 'Medium Fast', q'{Quadruped body}', 7 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Rotom]', 479 , q'|Fan|', 152 , 'Electric', 'Ghost', ':', 'Amorphous' , 20 , 5355, 5140, 5120, 0.7, 0.3, 'Medium Fast', q'{Head}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Ariados]', 168 , 33 , 'Bug', 'Poison', '1:1', 'Bug' , 15, 3840, 4096, 4080, 3855, 3840, 73.9, 33.5, 'Fast', q'{Insectoid body}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Mesprit]', 481 , 147 , 'Psychic' , ':U', 'Undiscovered' , 80 , 20655, 20560, 20480, 0.7, 0.3, 'Slow', q'{Bipedal, tailed form}', 4 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pikachu]', 25, 'Pa' , q'|Partner|', 25 , 'Electric' , '1:1', 'Field', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 13.2, 6, 'Medium Fast', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pelipper]', 279 , 28 , 'Water', 'Flying', '1:1', 'Water 1', 'Flying', 20 , 5376, 5355, 5140, 5120, 61.7, 28, 'Medium Fast', q'{Single pair of wings}', 3 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Trevenant]', 709 , 62, 'Mo', 'Ghost', 'Grass', '1:1', 'Grass', 'Amorphous', 20 , 5140, 5120, 156.5, 71, 'Medium Fast', q'{Tentacles or a multiped body}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Kadabra]', 64 , 64 , 'Psychic' , '1:3', 'Human-Like' , 20, 5120, 5376, 5355, 5140, 5120, 124.6, 56.5, 'Medium Slow', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pineco]', 204 , 93 , 'Bug' , '1:1', 'Bug' , 20, 5120, 5376, 5355, 5140, 5120, 15.9, 7.2, 'Medium Fast', q'{Head}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Scolipede]', 545 , 51 , 'Bug', 'Poison', '1:1', 'Bug' , 20 , 5140, 5120, 442, 200.5, 'Medium Slow', q'{Insectoid body}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Beartic]', 614 , 120 , 'Ice' , '1:1', 'Field' , 20 , 5140, 5120, 573.2, 260, 'Medium Fast', q'{Quadruped body}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Exeggcute]', 102 , 102 , 'Grass', 'Psychic', '1:1', 'Grass' , 20, 5120, 5376, 5355, 5140, 5120, 5.5, 2.5, 'Slow', q'{Multiple bodies}', 1 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Venusaur]', 3, 'M', nq'|Venusaurite|', q'|Mega|', 3 , 'Grass', 'Poison', '1:7', 'Monster', 'Grass', 20, 5120, 5376, 5355, 5140, 5120, 220.5, 100, 'Medium Slow', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Solrock]', 338 , 126 , 'Rock', 'Psychic', ':', 'Mineral' , 25 , 6656, 6630, 6425, 6400, 339.5, 154, 'Fast', q'{Head}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Taillow]', 276 , 25 , 'Normal', 'Flying', '1:1', 'Flying' , 15 , 4096, 4080, 3855, 3840, 5.1, 2.3, 'Medium Slow', q'{Single pair of wings}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pikachu]', 25 , 25 , 'Electric' , '1:1', 'Field', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 13.2, 6, 'Medium Fast', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Chatot]', 441 , 102 , 'Normal', 'Flying', '1:1', 'Flying' , 20 , 5355, 5140, 5120, 4.2, 1.9, 'Medium Slow', q'{Single pair of wings}', 4 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Slurpuff]', 685 , 132, 'Ce', 'Fairy' , '1:1', 'Fairy' , 20 , 5140, 5120, 11, 5, 'Medium Fast', q'{Bipedal, tailless form}', 6 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Braixen]', 654 , 5, 'Ce', 'Fire' , '1:7', 'Field' , 20 , 5140, 5120, 32, 14.5, 'Medium Slow', q'{Bipedal, tailed form}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Donphan]', 232 , 201 , 'Ground' , '1:1', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 264.6, 120, 'Medium Fast', q'{Quadruped body}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Girafarig]', 203 , 149 , 'Normal', 'Psychic', '1:1', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 91.5, 41.5, 'Medium Fast', q'{Quadruped body}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Hitmonchan]', 107 , 107 , 'Fighting' , '0:1', 'Human-Like' , 25, 6400, 6656, 6630, 6425, 6400, 110.7, 50.2, 'Medium Fast', q'{Bipedal, tailless form}', 1 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pikachu]', 25 , q'|Belle|', 25 , 'Electric' , '1:1', 'Field', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 13.2, 6, 'Medium Fast', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Vivillon]', 666 , q'|Savanna Pattern|', 22, 'Ce', 'Bug', 'Flying', '1:1', 'Bug' , 15 , 3855, 3840, 37.5, 17, 'Medium Fast', q'{Two or more pairs of wings}', 6 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Vivillon]', 666 , q'|Archipelago Pattern|', 22, 'Ce', 'Bug', 'Flying', '1:1', 'Bug' , 15 , 3855, 3840, 37.5, 17, 'Medium Fast', q'{Two or more pairs of wings}', 6 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Silvally]', 773 , q'|Type: Dark|', 204 , 'Normal' , ':U', 'Undiscovered' , 120 , 30720, 221.6, 100.5, 'Slow', q'{Quadruped body}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Fraxure]', 611 , 117 , 'Dragon' , '1:1', 'Monster', 'Dragon', 40 , 10280, 10240, 79.4, 36, 'Slow', q'{Bipedal, tailed form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Drilbur]', 529 , 35 , 'Ground' , '1:1', 'Field' , 20 , 5140, 5120, 18.7, 8.5, 'Medium Fast', q'{Bipedal, tailed form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Eelektross]', 604 , 110 , 'Electric' , '1:1', 'Amorphous' , 20 , 5140, 5120, 177.5, 80.5, 'Slow', q'{Fins}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Mareanie]', 747 , 113 , 'Poison', 'Water', '1:1', 'Water 1' , 20 , 5120, 17.6, 8, 'Medium Fast', q'{Head and a base}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Tympole]', 535 , 41 , 'Water' , '1:1', 'Water 1' , 20 , 5140, 5120, 9.9, 4.5, 'Medium Slow', q'{Fins}', 5 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Necrozma]', 800, 'DM' , q'|Dusk Mane|', 300 , 'Psychic' , ':U', 'Undiscovered' , 120 , 30720, 1014.1, 460, 'Slow', q'{Quadruped body}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Dewpider]', 751 , 141 , 'Water', 'Bug', '1:1', 'Water 1', 'Bug', 15 , 3840, 8.8, 4, 'Medium Fast', q'{Head and legs}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Flaaffy]', 180 , 54 , 'Electric' , '1:1', 'Monster', 'Field', 20, 5120, 5376, 5355, 5140, 5120, 29.3, 13.3, 'Medium Slow', q'{Bipedal, tailed form}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Phanpy]', 231 , 200 , 'Ground' , '1:1', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 73.9, 33.5, 'Medium Fast', q'{Quadruped body}', 2 );
insert into Pokemon( NAME, DEX , CLASS, LDEX, LDEX_SUFFIX, TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Pumpkaboo]', 710 , q'|Average Size|', 63, 'Mo', 'Ghost', 'Grass', '1:1', 'Amorphous' , 20 , 5140, 5120, 11, 5, 'Medium Fast', q'{Head}', 6 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Persian]', 53, 'A' , q'|Alolan|' , 'Dark' , '1:1', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 70.5, 32, 'Medium Fast', q'{Quadruped body}', 1 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Silvally]', 773 , q'|Type: Rock|', 204 , 'Normal' , ':U', 'Undiscovered' , 120 , 30720, 221.6, 100.5, 'Slow', q'{Quadruped body}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Gyarados]', 130 , 130 , 'Water', 'Flying', '1:1', 'Water 2', 'Dragon', 5, 1280, 1536, 1530, 1285, 1280, 518.1, 235, 'Slow', q'{Serpentine bodies}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Rhydon]', 112 , 112 , 'Ground', 'Rock', '1:1', 'Monster', 'Field', 20, 5120, 5376, 5355, 5140, 5120, 264.6, 120, 'Slow', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Sunflora]', 192 , 104 , 'Grass' , '1:1', 'Grass' , 20, 5120, 5376, 5355, 5140, 5120, 18.7, 8.5, 'Medium Slow', q'{Bipedal, tailless form}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Bruxish]', 779 , 243 , 'Water', 'Psychic', '1:1', 'Water 2' , 15 , 3840, 41.9, 19, 'Medium Fast', q'{Fins}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Elgyem]', 605 , 111 , 'Psychic' , '1:1', 'Human-Like' , 20 , 5140, 5120, 19.8, 9, 'Medium Fast', q'{Bipedal, tailed form}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Patrat]', 504 , 10 , 'Normal' , '1:1', 'Field' , 15 , 3855, 3840, 25.6, 11.6, 'Medium Fast', q'{Quadruped body}', 5 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Palpitoad]', 536 , 42 , 'Water', 'Ground', '1:1', 'Water 1' , 20 , 5140, 5120, 37.5, 17, 'Medium Slow', q'{Bipedal, tailed form}', 5 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Charizard]', 6, 'MX' , q'|Mega  X|', 6 , 'Fire', 'Flying', '1:7', 'Monster', 'Dragon', 20, 5120, 5376, 5355, 5140, 5120, 199.5, 90.5, 'Medium Slow', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Latias]', 380, 'M', nq'|Latiasite|', q'|Mega|', 196 , 'Dragon', 'Psychic', '1:0U', 'Undiscovered' , 120 , 30976, 30855, 30840, 30720, 88.2, 40, 'Slow', q'{Single pair of wings}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Gliscor]', 472 , 154 , 'Ground', 'Flying', '1:1', 'Bug' , 20 , 5355, 5140, 5120, 93.7, 42.5, 'Medium Slow', q'{Single pair of wings}', 4 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Kyurem]', 646 , q'|Normal|', 152 , 'Dragon', 'Ice', ':U', 'Undiscovered' , 120 , 30840, 30720, 716.5, 325, 'Slow', q'{Bipedal, tailed form}', 5 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Dugtrio]', 51, 'A' , q'|Alolan|' , 'Ground', 'Steel', '1:1', 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 73.4, 33.3, 'Medium Fast', q'{Multiple bodies}', 1 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX, ITEM, CLASS, LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Tyranitar]', 248, 'M', nq'|Tyranitarite|', q'|Mega|', 251 , 'Rock', 'Dark', '1:1', 'Monster' , 40, 10240, 10496, 10455, 10280, 10240, 445.3, 202, 'Slow', q'{Bipedal, tailed form}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Abra]', 63 , 63 , 'Psychic' , '1:3', 'Human-Like' , 20, 5120, 5376, 5355, 5140, 5120, 43, 19.5, 'Medium Slow', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Shieldon]', 410 , 38 , 'Rock', 'Steel', '1:7', 'Monster' , 30 , 7905, 7710, 7680, 125.7, 57, 'Erratic', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Mime Jr.]', 439 , 94 , 'Psychic', 'Fairy', '1:1U', 'Undiscovered' , 25 , 6630, 6425, 6400, 28.7, 13, 'Medium Fast', q'{Bipedal, tailless form}', 4 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Skiddo]', 672 , 89, 'Ce', 'Grass' , '1:1', 'Field' , 20 , 5140, 5120, 68.3, 31, 'Medium Fast', q'{Quadruped body}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Cacnea]', 331 , 119 , 'Grass' , '1:1', 'Grass', 'Human-Like', 20 , 5376, 5355, 5140, 5120, 113.1, 51.3, 'Medium Slow', q'{Bipedal, tailless form}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Torchic]', 255 , 4 , 'Fire' , '1:7', 'Field' , 20 , 5376, 5355, 5140, 5120, 5.5, 2.5, 'Medium Slow', q'{Head and legs}', 3 );
insert into Pokemon( NAME, DEX , CLASS, LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Silvally]', 773 , q'|Type: Fire|', 204 , 'Normal' , ':U', 'Undiscovered' , 120 , 30720, 221.6, 100.5, 'Slow', q'{Quadruped body}', 7 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Mothim]', 414 , 47 , 'Bug', 'Flying', '0:1', 'Bug' , 15 , 4080, 3855, 3840, 51.4, 23.3, 'Medium Fast', q'{Two or more pairs of wings}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Banette]', 354 , 147 , 'Ghost' , '1:1', 'Amorphous' , 25 , 6656, 6630, 6425, 6400, 27.6, 12.5, 'Fast', q'{Bipedal, tailed form}', 3 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Jigglypuff]', 39 , 39 , 'Normal', 'Fairy', '3:1', 'Fairy' , 10, 2560, 2816, 2805, 2570, 2560, 12.1, 5.5, 'Fast', q'{Bipedal, tailless form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Sableye]', 302 , 68 , 'Dark', 'Ghost', '1:1', 'Human-Like' , 25 , 6656, 6630, 6425, 6400, 24.3, 11, 'Medium Slow', q'{Bipedal, tailless form}', 3 );
insert into Pokemon( NAME, DEX , LDEX, LDEX_SUFFIX, TYPE , GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Frogadier]', 657 , 8, 'Ce', 'Water' , '1:7', 'Water 1' , 20 , 5140, 5120, 24, 10.9, 'Medium Slow', q'{Bipedal, tailless form}', 6 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Ledian]', 166 , 31 , 'Bug', 'Flying', '1:1', 'Bug' , 15, 3840, 4096, 4080, 3855, 3840, 78.5, 35.6, 'Fast', q'{Single pair of wings}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Gengar]', 94 , 94 , 'Ghost', 'Poison', '1:1', 'Amorphous' , 20, 5120, 5376, 5355, 5140, 5120, 89.3, 40.5, 'Medium Slow', q'{Bipedal, tailed form}', 1 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Ho-Oh]', 250 , 253 , 'Fire', 'Flying', ':U', 'Undiscovered' , 120, 30720, 30976, 30855, 30840, 30720, 438.7, 199, 'Slow', q'{Single pair of wings}', 2 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1, EGGGROUP2, CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Ferrothorn]', 598 , 104 , 'Grass', 'Steel', '1:1', 'Grass', 'Mineral', 20 , 5140, 5120, 242.5, 110, 'Medium Fast', q'{Tentacles or a multiped body}', 5 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Shaymin]', 492, 'S' , q'|Sky Forme|' , 'Grass', 'Flying', ':U', 'Undiscovered' , 120 , 30855, 30840, 30720, 11.5, 5.2, 'Medium Slow', q'{Quadruped body}', 4 );
insert into Pokemon( NAME, DEX , LDEX , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES , STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Braviary]', 628 , 134 , 'Normal', 'Flying', '0:1', 'Flying' , 20 , 5140, 5120, 90.4, 41, 'Slow', q'{Single pair of wings}', 5 );
insert into Pokemon( NAME, DEX, DEX_SUFFIX , CLASS , TYPE, TYPE2, GENDER_RATIO, EGGGROUP1 , CYCLES, STEPS_GEN2, STEPS_GEN3, STEPS_GEN4, STEPS_GEN5, STEPS_GEN7, WEIGHTLBS, WEIGHTKG, EXPERIENCE_TYPE, BODY, GEN )
values( nq'[Graveler]', 75, 'A' , q'|Alolan|' , 'Rock', 'Electric', '1:1', 'Mineral' , 15, 3840, 4096, 4080, 3855, 3840, 231.5, 105, 'Medium Slow', q'{Bipedal, tailless form}', 1 );