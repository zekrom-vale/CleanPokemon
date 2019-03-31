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
KEY varchar2(6) default on null 'ph' primary key, --The auto generated key to refference the ratio
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
for each row when(new.key='ph')
begin
:new.KEY:= :new.MALE||':'||:new.FEMALE||
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
insert into GENDER_RATIO( KEY )
values( 'G' );
insert into GENDER_RATIO( KEY , UNBREEDABLE )
values( 'GU' , 'T' );
insert into GENDER_RATIO( KEY , UNBREEDABLE )
values( 'G*' , '*' );
begin
TYPE_FINAL();
end;
/

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
