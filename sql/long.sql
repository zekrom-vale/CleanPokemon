create table Types(
TYPE varchar2(15 byte) primary key, --The name of the type
DESCRIPTION clob check(DESCRIPTION is JSON), --The description of the type
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
DESCRIPTION clob , --An expanded explination of the form
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

insert into BODY( BODY , DESCRIPTION, ID )
values( 'Bipedal, tailless form' , q'|With a bipedal, tailless form|', 12 );
insert into BODY( BODY, PARENT, DESCRIPTION, ID )
values( 'Bipedal, tailed form', 'Bipedal, tailless form', q'|With a bipedal, tailed form|', 6 );
insert into BODY( BODY , DESCRIPTION, ID )
values( 'Fins' , q'|With fins|', 3 );
insert into BODY( BODY , DESCRIPTION, ID )
values( 'Head' , q'|Consisting of only a head|', 1 );
insert into BODY( BODY, PARENT, DESCRIPTION, ID )
values( 'Head and a base', 'Head', q'|Consisting of a head and a base|', 5 );
insert into BODY( BODY, PARENT, DESCRIPTION, ID )
values( 'Head and arms', 'Head and a base', q'|Consisting of a head and arms|', 4 );
insert into BODY( BODY, PARENT, DESCRIPTION, ID )
values( 'Head and legs', 'Head and a base', q'|Consisting of a head and legs|', 7 );
insert into BODY( BODY , DESCRIPTION, ID )
values( 'Insectoid body' , q'|With an insectoid body|', 14 );
insert into BODY( BODY , DESCRIPTION, ID )
values( 'Multiple bodies' , q'|Consisting of multiple bodies|', 11 );
insert into BODY( BODY , DESCRIPTION, ID )
values( 'Quadruped body' , q'|With a quadruped body|', 8 );
insert into BODY( BODY , DESCRIPTION, ID )
values( 'Serpentine bodies' , q'|With serpentine bodies|', 2 );
insert into BODY( BODY , DESCRIPTION, ID )
values( 'Single pair of wings' , q'|With a single pair of wings|', 9 );
insert into BODY( BODY, PARENT, DESCRIPTION, ID )
values( 'Two or more pairs of wings', 'Single pair of wings', q'|With two or more pairs of wings|', 13 );
insert into BODY( BODY , DESCRIPTION, ID )
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

insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lock Capsule|', 5 , q'|Not available without cheating. Can be relocated from HeartGold or Soul Silver to obtain TM95 (Snarl).|' , nq'|ロックカプセル|', nq'|Lock Capsule|', nq'|Capsule Anti-vol|', nq'|Tresorkapsel|', nq'|Cap. Scrigno|', nq'|Cáp. Candado|', nq'|록캡슐|', nq'|Lock Capsule|', nq'|上鎖的容器 / 上锁的容器|', nq'|Shàngsuǒ-de Róngqì / Séuhngsó-dīk Yùhnghei|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Razor Claw|', 4 , q'|Raises the chance of getting a critical hit. Allows Sneasel to evolve at night.|' , nq'|するどいツメ|', nq'|Surudoi Tsume|', nq'|Griffe Rasoir|', nq'|Scharfklaue|', nq'|Affilartigli|', nq'|Garra Afilada|', nq'|예리한손톱|', nq'|Yerihan Sontop|', nq'|銳利之爪 / 锐利之爪|', nq'|Ruìlì-zhī Zhuǎ / Yeuihleih-jī Jáau|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Black Flute|', 3 , q'|Repels wild Pokémon.RSEFRLGDPPtHGSS Can be sold for 8000.BWB2W2 Increases the level of wild Pokémon by one to three levels.ORAS|' , nq'|くろいビードロ|', nq'|Kuroi Vidro|', nq'|Flûte Noire|', nq'|Schw. Flöte|', nq'|Flauto Nero|', nq'|Flauta Negra|', nq'|검정비드로|', nq'|Geomjeong Vidro|', nq'|黑色玻璃哨|', nq'|Hēi-sè Bōlí Shào / Hāak-sīk Bōlèih Saau|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Coupon 2|', 4 , q'|Used to obtain the Pokétch in Jubilife City.|' , nq'|ひきかえけん２|', nq'|Hikikaeken 2|', nq'|Bon 2|', nq'|Kupon 2|', nq'|Coupon 2|', nq'|Cupón 2|', nq'|교환권 2|', nq'|Gyohwangwon 2|', nq'|兌換券２ / 兑换券２|', nq'|Duìhuàn Quàn 2 / Deuiwuhn Hyun 2|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Douse Drive|', 5 , q'|Makes Techno Blast a Water-type move when held by Genesect.|' , nq'|アクアカセット|', nq'|Aqua Cassette|', nq'|Module Aqua|', nq'|Aquamodul|', nq'|Idromodulo|', nq'|HidroROM|', nq'|아쿠아카세트|', nq'|Aqua Cassette|', nq'|水流卡帶 / 水流卡带|', nq'|Shuǐliú Kǎdài / Séuilàuh Kāatdáai|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Shock Drive|', 5 , q'|Makes Techno Blast an Electric-type move when held by Genesect.|' , nq'|イナズマカセット|', nq'|Inazuma Cassette|', nq'|Module Choc|', nq'|Blitzmodul|', nq'|Voltmodulo|', nq'|FulgoROM|', nq'|번개카세트|', nq'|Beongae Cassette|', nq'|閃電卡帶 / 闪电卡带|', nq'|Shǎndiàn Kǎdài / Símdihn Kāatdáai|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Charizardite Y|', 6 , q'|Allows Charizard to Mega Evolve into Mega Charizard Y.|' , nq'|リザードナイトY|', nq'|Lizardonite Y|', nq'|Dracaufite Y|', nq'|Gluraknit Y|', nq'|Charizardite Y|', nq'|Charizardita Y|', nq'|리자몽나이트Y|', nq'|Rizamonnite Y|', nq'|噴火龍進化石Y / 喷火龙进化石Y|', nq'|Pēnhuǒlóng Jìnhuà Shí Y / Panfólùhng Jeunfa Sehk Y|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|Drash Berry|', 3 , q'|Cures Poison status. Will turn into an Enigma Berry if transferred to Generation IV via Pal Park.|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Relic Band|', 5 , q'|Can be sold for 100000 to the villa owner in Undella Town.|' , nq'|こだいのうでわ|', nq'|Kodai no Udewa|', nq'|Vieux Bijou|', nq'|Alter Reif|', nq'|Bracciantico|', nq'|Brazal|', nq'|고대의팔찌|', nq'|Godae-yi Paljji|', nq'|古代手鐲 / 古代手镯|', nq'|Gǔdài Shǒuzhuó / Gúdoih Sáujuhk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Sticky Barb|', 4 , q'|Damages the holder. May latch onto the foe if a physical move is used and the foe is not already holding an item.|' , nq'|くっつきバリ|', nq'|Kuttsuki Bari|', nq'|Piquants|', nq'|Klettdorn|', nq'|Vischiopunta|', nq'|Toxiestrella|', nq'|끈적끈적바늘|', nq'|Kkeunjeokkkeunjeok Baneul|', nq'|附著針 / 附着针|', nq'|Fùzhuó Zhēn / Fuhjeuhk Jām|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Fame Checker|', 3 , q'|Records information on famous people, such as Gym Leaders.|' , nq'|ボイスチェッカー|', nq'|Voice Checker|', nq'|Memorydex|', nq'|Ruhmesdatei|', nq'|PokéVIP|', nq'|Memorín|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Subway Key|', 3 , q'|Operates the subway between The Under and the Shadow PKMN Lab.|' , nq'|ちかてつのカギ|', nq'|Chikatetsu no Kagi|', nq'|Cle de Contact|', nq'|Zugschlüssel|', nq'|Chiave Metro|', nq'|Llave Metro|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Swift Wing|', 5 , q'|Raises the Speed of a Pokémon.|' , nq'|しゅんぱつのハネ|', nq'|Shunpatsu no Hane|', nq'|Aile Sprint|', nq'|Flinkfeder|', nq'|Piumreazione|', nq'|Pluma Ímpetu|', nq'|순발력날개|', nq'|Sunballyeok Nalgae|', nq'|瞬發之羽 / 瞬发之羽|', nq'|Shùnfā-zhī Yǔ / Seunfaat-jī Yúh|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Mewnium Z|', 7 , q'|Allows Mew to upgrade Psychic to the special Z-Move Genesis Supernova.|' , nq'|ミュウＺ|', nq'|Mew-Z|', nq'|Mewzélite|', nq'|Mewnium Z|', nq'|Mewnium Z|', nq'|Mewstal Z|', nq'|뮤Z|', nq'|Mew-Z|', nq'|夢幻Ｚ / 梦幻Ｚ|', nq'|Mènghuàn-Z / Muhngwaahn-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dire Hit|', 1 , q'|Raises critical hit ratio in battle.|' , nq'|クリティカット|', nq'|Criticut|', nq'|Muscle +|', nq'|Angriffplus|', nq'|Supercolpo|', nq'|Directo|', nq'|크리티컬커터|', nq'|Critical Cutter|', nq'|要害攻擊 / 要害攻击|', nq'|Yàohài Gōngjí / Yiuhoih Gūnggīk|', 768 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Soda Pop|', 1 , q'|Restores 50 HP. (60HP before Gen. VII).|' , nq'|サイコソーダ|', nq'|Saiko Soda|', nq'|Soda Cool|', nq'|Sprudel|', nq'|Gassosa|', nq'|Refresco|', nq'|미네랄사이다|', nq'|Mineral Cider|', nq'|勁爽汽水 / 劲爽汽水|', nq'|Jìnshuǎng Qìshuǐ / Gihngsóng Heiséui|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pass Orb|', 5 , q'|Used for purchasing Pass Powers at the Entralink.|' , nq'|デルダマ|', nq'|Derudama|', nq'|Offrisphère|', nq'|Transferorb|', nq'|Passabilia|', nq'|Regalosfera|', nq'|딜구슬|', nq'|Dil Guseul|', nq'|釋出之玉 / 释出之玉|', nq'|Shìchū-zhī Yù / Sīkchēut-jī Yúk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Fist Plate|', 4 , q'|Raises the power of Fighting-type moves.|' , nq'|こぶしのプレート|', nq'|Kobushi no Purēto|', nq'|Plaque Poing|', nq'|Fausttafel|', nq'|Lastrapugno|', nq'|Tabla Fuerte|', nq'|주먹플레이트|', nq'|Jumeok Plate|', nq'|拳頭石板 / 拳头石板|', nq'|Quántóu Shíbǎn / Kyùhntàuh Sehkbáan|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Mosaic Mail|', 4 , q'|Mail with a rainbow pattern. To be held by a Pokémon for delivery.|' , nq'|モザイクメール|', nq'|Mosaic Mail|', nq'|Lettremosaik|', nq'|Mosaikbrief|', nq'|Mess. Iride|', nq'|Car. Mosaico|', nq'|모자이크메일|', nq'|Mosaic Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Sea Incense|', 3 , q'|Raises the power of Water-type moves. A Marill or Azumarill holding this can breed to produce Azurill Eggs.|' , nq'|うしおのおこう|', nq'|Ushio no Okou|', nq'|Encens Mer|', nq'|Seerauch|', nq'|Marearoma|', nq'|Incienso marino|', nq'|바닷물향로|', nq'|Badasmul Hyangno|', nq'|海潮薰香|', nq'|Hǎicháo Xūnxiāng / Hóichìuh Fānhēung|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Eon Flute|', 6 , q'|Summons LatiasAS or LatiosOR to soar in the sky above Hoenn, and fly to any city, route, or island.|' , nq'|むげんのふえ|', nq'|Mugen no Fue|', nq'|Flûte Éon|', nq'|Äon-Flöte|', nq'|Flauto Eone|', nq'|Flauta Eón|', nq'|무한의피리|', nq'|Muhan Uipili|', nq'|無限之笛 / 无限之笛|', nq'|Wúxiàn-zhī Dí / Mòuhhaahn-jī Dehk|', 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|TM|' , nq'|わざマシン|', nq'|Waza Machine|', nq'|CT|', nq'|TM|', nq'|MT|', nq'|MT|', nq'|기술머신|', nq'|Gisul Machine|', nq'|招式學習器 / 招式学习器|', nq'|Zhāoshì Xuéxíqì / Jīusīk Hohkjaahphei|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Rindo Berry|', 4 , q'|Reduces damage from a super effective Grass-type move.|' , nq'|リンドのみ|', nq'|Rindo no Mi|', nq'|Baie Ratam|', nq'|Grindobeere|', nq'|Baccarindo|', nq'|Baya Tamar|', nq'|린드열매|', nq'|Rind Yeolmae|', nq'|羅子果 / 罗子果|', nq'|Luózi Guǒ / Lòhjí Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Odd Keystone|', 4 , q'|A stone that can trap Spiritomb.|' , nq'|かなめいし|', nq'|Kaname Ishi|', nq'|Clé de Voûte|', nq'|Spiritkern|', nq'|Roccianima|', nq'|Piedra Espíritu|', nq'|쐐기돌|', nq'|Sswaegi Dol|', nq'|楔石|', nq'|Xiē Shí / Sit Sehk|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Grassy Seed|', 7 , q'|A one-time use item that raises the holder's Defense by one stage upon activation of Grassy Terrain.|' , nq'|グラスシード|', nq'|Grass Seed|', nq'|Graine Herbe|', nq'|Gras-Samen|', nq'|Erbaseme|', nq'|Semilla Hierba|', nq'|그래스시드|', nq'|Grass Seed|', nq'|青草種子 / 青草种子|', nq'|Qīngcǎo Zhǒngzi / Chēngchóu Júngjí|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Zoom Lens|', 4 , q'|A held item that boosts the critical hit ratio if the holder moves after the foe.|' , nq'|フォーカスレンズ|', nq'|Focus Lens|', nq'|Lentille Zoom|', nq'|Zoomlinse|', nq'|Zoomlente|', nq'|Telescopio|', nq'|포커스렌즈|', nq'|Focus Lens|', nq'|對焦鏡 / 对焦镜|', nq'|Duìjiāo Jìng / Deuijīu Geng|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Groundium Z|', 7 , q'|Allows a Pokémon to upgrade their Ground-type damaging moves to the Z-Move Tectonic Rage or upgrade their Ground-type status moves into Z-Moves. Makes Arceus a Ground-type Pokémon.|' , nq'|ジメンＺ|', nq'|Ground-Z|', nq'|Terrazélite|', nq'|Terrium Z|', nq'|Terrium Z|', nq'|Geostal Z|', nq'|땅Z|', nq'|Ttang-Z|', nq'|地面Ｚ|', nq'|Dìmiàn-Z / Deihmín-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|White Apricorn|', 2 , q'|If taken to Kurt, he will make the player a Fast Ball. Also, Apricorn Drink ingredient.|', q'|Formatted as Wht Apricorn prior to Generation VI.|', nq'|しろぼんぐり|', nq'|Shiro Bonguri|', nq'|Noigrume Blc|', nq'|Aprikoko Wss|', nq'|Ghicocca Bianca|', nq'|Bonguri Blanco|', nq'|하얀규토리|', nq'|Hayan Gyutori|', nq'|白球果|', nq'|Bái Qiúguǒ / Baahk Kàuhgwó|', 1072 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Luxury Ball|', 3 , q'|A Pokémon caught in a Luxury Ball will gain friendship more quickly.|' , nq'|ゴージャスボール|', nq'|Gorgeous Ball|', nq'|Luxe Ball|', nq'|Luxusball|', nq'|Chich Ball|', nq'|Lujo Ball|', nq'|럭셔리볼|', nq'|Luxury Ball|', nq'|豪華球 / 豪华球|', nq'|Háohuá Qiú / Hòuhwàh Kàuh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|RageCandyBar|', 2 , q'|In Johto, can be exchanged for TM64.|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|HMs|', 1 , q'|Can be used to teach a field move to a Pokémon. HMs will not break up after use and as such can be used over and over again.|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Antidote|', 1 , q'|Heals the poisoning of a Pokémon.|' , nq'|どくけし|', nq'|Dokukeshi|', nq'|Antidote|', nq'|Gegengift|', nq'|Antidoto|', nq'|Antídoto|', nq'|해독제|', nq'|Haedokje|', nq'|解毒藥 / 解毒药|', nq'|Jiědúyào / Gáaiduhkyeuhk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Normal Gem|', 5 , q'|Increases the power of the holder's first Normal-type move by 50%, and is consumed after use.|' , nq'|ノーマルジュエル|', nq'|Normal Jewel|', nq'|Joyau Normal|', nq'|Normaljuwel|', nq'|Bijounormale|', nq'|Gema Normal|', nq'|노말주얼|', nq'|Normal Jewel|', nq'|一般寶石 / 一般宝石|', nq'|Yībān Bǎoshí / Yātbūn Bóusehk|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|Topo Berry|', 3 , q'|Pokéblock ingredient. If transferred to Generation IV via Pal Park, it will turn into an Enigma Berry.|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Choice Band|', 3 , q'|Raises user's Attack, but they can only use one move.|' , nq'|こだわりハチマキ|', nq'|Kodawari Hachimaki|', nq'|Bandeau Choix|', nq'|Wahlband|', nq'|Bendascelta|', nq'|Cinta Elegida|', nq'|구애머리띠|', nq'|Guae Meoritti|', nq'|講究頭帶 / 讲究头带|', nq'|Jiǎngjiù Tóudài / Gónggau Tàuhdaai|', 144 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Bloom Mail|', 4 , q'|A flower-printed stationery. To be held by a Pokémon for delivery.|' , nq'|ブルームメール|', nq'|Bloom Mail|', nq'|Lett. Pétale|', nq'|Blütenbrief|', nq'|Mess. Petalo|', nq'|Carta Flores|', nq'|블룸메일|', nq'|Bloom Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Cornn Berry|', 3 , q'|Poffin and Pokéblock ingredient.|' , nq'|モコシのみ|', nq'|Mokoshi no Mi|', nq'|Baie Siam|', nq'|Saimbeere|', nq'|Baccavena|', nq'|Baya Mais|', nq'|수숙열매|', nq'|Susuk Yeolmae|', nq'|玉黍果|', nq'|Yùshǔ Guǒ / Yuhksyú Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|X Special 6|', 5 , q'|Immensely raises a Pokémon's Special Attack. Wonder Launcher only.|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Gonzap's Key|', 3 , q'|Opens an item box containing TM30 (Shadow Ball).|' , nq'|ゴンザのカギ|', nq'|Gonza no Key|', nq'|Cle Helgonza|', nq'|Schlüssel|', nq'|Chiave Helg.|', nq'|Llave Golka|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Power Weight|', 4 , q'|Promotes HP EVs, but lowers Speed in battle.|' , nq'|パワーウエイト|', nq'|Power Weight|', nq'|Poids Pouvoir|', nq'|Machtgewicht|', nq'|Vigorpeso|', nq'|Pesa Recia|', nq'|파워웨이트|', nq'|Power Weight|', nq'|力量負重 / 力量负重|', nq'|Lìliàng Fùzhòng / Lihkleuhng Fuhchúhng|', 128 );
insert into ITEMS( NAME, GEN, GEN2, DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Good Rod|', 1, 4, q'|Allows the player to fish for medium-level aquatic Pokémon.|' , nq'|いいつりざお|', nq'|Ii Tsurizao|', nq'|Super Canne|', nq'|Profiangel|', nq'|Amo Buono|', nq'|Caña Buena|', nq'|좋은낚싯대|', nq'|Jo-eun Naksitdae|', nq'|好釣竿 / 好钓竿|', nq'|Hǎo Diàogān / Hóu Diugōn|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Big Pearl|', 2 , q'|Can be sold for 3750.|' , nq'|おおきなしんじゅ|', nq'|Ōkina Shinju|', nq'|Grande Perle|', nq'|Riesenperle|', nq'|Grande Perla|', nq'|Perla Grande|', nq'|큰진주|', nq'|Keun Jinju|', nq'|大珍珠|', nq'|Dà Zhēnzhū / Daaih Jānjyū|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Jade Orb|', 4 , q'|Allows the player to encounter Rayquaza in the Embedded Tower.|' , nq'|もえぎいろのたま|', nq'|Moegiiro no Tama|', nq'|Orbe Vert|', nq'|Grüne Kugel|', nq'|Sfera Verde|', nq'|Esfera Verde|', nq'|연둣빛구슬|', nq'|Yeondutbit Guseul|', nq'|草綠色寶珠 / 草绿色宝珠|', nq'|Cǎolǜ-sè Bǎo Zhū / Chóuluhk-sīk Bóujyū|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Mystery Egg|', 2 , q'|Hatches into Togepi.|' , nq'|ふしぎなタマゴ|', nq'|Fushigina Tamago|', nq'|Œuf Mystère|', nq'|Rätsel-Ei|', nq'|Uovo Mistero|', nq'|Huevo Mist|', nq'|이상한알|', nq'|Isanghan Al|', nq'|神奇蛋|', nq'|Shénqí Dàn / Sàhnkèih Dáan|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|Pokédex|', 1 , q'|Stores info about Pokémon that have been seen/caught.|' , 2048 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Aspear Berry|', 3 , q'|Removes the frozen condition from a Pokémon.|' , nq'|ナナシのみ|', nq'|Nanashi no Mi|', nq'|Baie Willia|', nq'|Wilbirbeere|', nq'|Baccaperina|', nq'|Baya Perasi|', nq'|배리열매|', nq'|Baeri Yeolmae|', nq'|利木果|', nq'|Lìmù Guǒ / Leihmuhk Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Zygarde Cube|', 7 , q'|Holds collected Zygarde Cores and Cells and teaches Zygarde moves.|' , nq'|ジガルデキューブ|', nq'|Zygarde Cube|', nq'|Boîte Zygarde|', nq'|Zygarde-Würfel|', nq'|Teca Zygarde|', nq'|Arca de Zygarde|', nq'|지가르데큐브|', nq'|Zygarde Cube|', nq'|基格爾德多面體 / 基格尔德多面体|', nq'|Jīgé'ěrdé Duōmiàntǐ / Gēigaakyíhdāk Dōmihntái|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Excite Scent|', 3 , q'|Reduces heart gauge, increases friendship.|' , nq'|ワクワクのかおり|', nq'|Wakuwaku no Kaori|', nq'|P. Tonifiant|', nq'|Glücks-E.|', nq'|Olio di Rosa|', nq'|Ar. Emoción|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Poison Gem|', 5 , q'|Increases the power of the holder's first Poison-type move by 50%, and is consumed after use.|' , nq'|どくのジュエル|', nq'|Doku no Jewel|', nq'|Joyau Poison|', nq'|Giftjuwel|', nq'|Bijouveleno|', nq'|Gema Veneno|', nq'|독주얼|', nq'|Dok Jewel|', nq'|毒之寶石 / 毒之宝石|', nq'|Dú-zhī Bǎoshí / Duhk-jī Bóusehk|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Smoke Ball|', 3 , q'|A held item that allows the user to flee from any wild Pokémon battle. Can be used an unlimited number of times.|' , nq'|けむりだま|', nq'|Kemuri Dama|', nq'|Boule Fumée|', nq'|Rauchball|', nq'|Palla Fumo|', nq'|Bola Humo|', nq'|연막탄|', nq'|Yeonmaktan|', nq'|煙霧球 / 烟雾球|', nq'|Yānwù Qiú / Yīnmouh Kàuh|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Energy Root|', 2 , q'|Restores 200 HP, but lowers friendship.|' , nq'|ちからのねっこ|', nq'|Chikara no Nekko|', nq'|Racine Énergie|', nq'|Kraftwurzel|', nq'|Radicenergia|', nq'|Raíz Energía|', nq'|힘의뿌리|', nq'|Himui Ppuri|', nq'|元氣根 / 元气根|', nq'|Yuánqì Gēn / Yùhnhei Gān|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Sprinklotad|', 6 , q'|Used to water Berry plants.|' , nq'|ハスボーじょうろ|', nq'|Hassboh Jōro|', nq'|Nénurrosoir|', nq'|Loturzelkanne|', nq'|Irrigalotad|', nq'|Lotadgadera|', nq'|연꽃몬물뿌리개|', nq'|Yeonkkotmon Mulppurigae|', nq'|蓮葉童子噴壺 / 莲叶童子喷壶|', nq'|Liányètóngzǐ Pēnhú / Lìhnyihptùhngjí Panwùh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|System Lever|', 3 , q'|Shuts down the Cipher Key Lair.|' , nq'|かいじょレバー|', nq'|Kaijo Lever|', nq'|Levier|', nq'|Systemhebel|', nq'|Leva|', nq'|Palanca|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Colress Machine|', 5 , q'|A special device that wrings out the potential of Pokémon. It is an imperfect prototype.|', q'|Formatted as Colress MCHN prior to Generation VI.|', nq'|アクロママシーン|', nq'|Achroma Machine|', nq'|Nikodule|', nq'|Achromat|', nq'|Acrocongegno|', nq'|Acromáquina|', nq'|아크로마머신|', nq'|Achroma Machine|', nq'|阿克羅瑪機器 / 阿克罗玛机器|', nq'|Ākèluómǎ Jīqì / Ahāklòhmáh Gēihei|', 1024 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Max Elixir|', 1 , q'|Restores all of a Pokémon's PP.|' , nq'|ピーピーマックス|', nq'|PP Max|', nq'|Max Elixir|', nq'|Top-Elixier|', nq'|Elisir Max|', nq'|Elixir Máximo|', nq'|PP맥스|', nq'|PP Max|', nq'|ＰＰ多項全補劑 / ＰＰ多项全补剂|', nq'|PP Duōxiàng Quánbǔjì / PP Dōhohng Chyùhnbóujaih|', 1024 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Eevium Z|', 7 , q'|Allows Eevee to upgrade Last Resort to the special Z-Move Extreme Evoboost.|' , nq'|イーブイＺ|', nq'|Eievui-Z|', nq'|Évolizélite|', nq'|Evolium Z|', nq'|Eevium Z|', nq'|Eeveestal Z|', nq'|이브이Z|', nq'|Eevee-Z|', nq'|伊布Ｚ|', nq'|Yībù-Z / Yībou-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lagging Tail|', 4 , q'|Causes the holder to move after the opponent.|' , nq'|こうこうのしっぽ|', nq'|Kōkō no Shippo|', nq'|Ralentiqueue|', nq'|Schwerschwf.|', nq'|Rallentocoda|', nq'|Cola Plúmbea|', nq'|느림보꼬리|', nq'|Neurimbo Kkori|', nq'|後攻之尾 / 后攻之尾|', nq'|Hòugōng-zhī Wěi/Hòugōng-zhī Yǐ/ Hauhgūng-jī Méih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Charizardite X|', 6 , q'|Allows Charizard to Mega Evolve into Mega Charizard X.|' , nq'|リザードナイトX|', nq'|Lizardonite X|', nq'|Dracaufite X|', nq'|Gluraknit X|', nq'|Charizardite X|', nq'|Charizardita X|', nq'|리자몽나이트X|', nq'|Rizamonnite X|', nq'|噴火龍進化石X / 喷火龙进化石X|', nq'|Pēnhuǒlóng Jìnhuà Shí X / Panfólùhng Jeunfa Sehk X|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Ultra Ball|', 1 , q'|A Poké Ball with a high capture rate.|' , nq'|ハイパーボール|', nq'|Hyper Ball|', nq'|Hyper Ball|', nq'|Hyperball|', nq'|Ultra Ball|', nq'|Ultraball|', nq'|하이퍼볼|', nq'|Hyper Ball|', nq'|高級球 / 高级球|', nq'|Gāojí Qiú / Gōukāp Kàuh|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Damp Mulch|', 4 , q'|Causes the soil to dry out more slowly, but also causes the Berry plant to grow more slowly.|' , nq'|じめじめこやし|', nq'|Jimejime Koyashi|', nq'|Fertihumide|', nq'|Feuchtmulch|', nq'|Fertilidro|', nq'|Abono Lento|', nq'|축축이비료|', nq'|Chukchug'i Biryo|', nq'|濕濕肥 / 湿湿肥|', nq'|Shīshī Féi / Sāpsāp Fèih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Key to Room 2|', 6 , q'|Opens Room 2 of the Abandoned ShipRSE/Sea MauvilleORAS.|', q'|Called Rm. 2 Key in Generation III.|', nq'|にごうしつのカギ|', nq'|Ni-gō Shitsu no Kagi|', nq'|Clé Salle 2|', nq'|R2-Schlüssel|', nq'|Chiave stanza 2|', nq'|Ll. Habitación 2|', nq'|이호실열쇠|', nq'|I-hosil Yeolsoe|', nq'|２號客房的鑰匙 /|'||chr(10)||nq'|２号客房的钥匙|', nq'|2 Hào Kèfáng-de Yàoshi / 2 Houh Haakfóng-dīk Yeuhksìh|', 1616 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lift Key|', 1 , q'|Allows operation of the elevator (lift) in the Team Rocket Hideout.|' , nq'|エレベータのカギ|', nq'|Elevator no Kagi|', nq'|Cle Asc.|', nq'|Liftöffner|', nq'|Chiave Ascensore|', nq'|Llave Ascensor|', nq'|엘리베이터열쇠|', nq'|Elevator Yeolsoe|', nq'|電梯鑰匙 / 电梯钥匙|', nq'|Dìantī Yàoshi / Dihntāi Yeuhksìh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Steelixite|', 6 , q'|Allows Steelix to Mega Evolve into Mega Steelix.|' , nq'|ハガネールナイト|', nq'|Haganeilnite|', nq'|Steelixite|', nq'|Stahlosnit|', nq'|Steelixite|', nq'|Steelixita|', nq'|강철톤나이트|', nq'|Gangcheoltonnite|', nq'|大鋼蛇進化石 / 大钢蛇进化石|', nq'|Dàgāngshé Jìnhuà Shí / Daaihgongsèh Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Protector|', 4 , q'|A held item that allows Rhydon to evolve when traded.|' , nq'|プロテクター|', nq'|Protector|', nq'|Protecteur|', nq'|Schützer|', nq'|Copertura|', nq'|Protector|', nq'|프로텍터|', nq'|Protector|', nq'|護具 / 护具|', nq'|Hùjù / Wuhgeuih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Ability Capsule|', 6 , q'|Allows a Pokémon with two Abilities to switch between these Abilities.|' , nq'|とくせいカプセル|', nq'|Tokusei Capsule|', nq'|Pilule Talent|', nq'|Fähigk.-Kapsel|', nq'|Capsula Abilità|', nq'|Cáps. Habilidad|', nq'|특성캡슐|', nq'|Teukseong Capsule|', nq'|特性膠囊 / 特性胶囊|', nq'|Tèxìng Jiāonáng / Dahksing Gāaunòhng|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Relic Vase|', 5 , q'|Can be sold for 50000 to the villa owner in Undella Town.|' , nq'|こだいのツボ|', nq'|Kodai no Tsubo|', nq'|Vieux Vase|', nq'|Alte Vase|', nq'|Vasantico|', nq'|Ánfora|', nq'|고대의항아리|', nq'|Godae-yi Hang'ari|', nq'|古代之壺 / 古代之壶|', nq'|Gǔdài-zhī Hú / Gúdoih-jī Wùh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pixie Plate|', 6 , q'|Raises the power of Fairy-type moves.|' , nq'|せいれいプレート|', nq'|Seirei Purēto|', nq'|Plaque Pixie|', nq'|Feentafel|', nq'|Lastraspiritello|', nq'|Tabla Duende|', nq'|정령플레이트|', nq'|Jeonglyeong Plate|', nq'|妖精石板|', nq'|Yāojīng Shíbǎn / Yīujīng Sehkbáan|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Teachy TV|', 3 , q'|Gives tutorials of game functions.|' , nq'|おしえテレビ|', nq'|Oshie Televi|', nq'|TV ABC|', nq'|Lehrkanal|', nq'|Poké TV|', nq'|Poké Tele|', nq'|가르침TV|', nq'|Gareuchim TV|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Chill Drive|', 5 , q'|Makes Techno Blast an Ice-type move when held by Genesect.|' , nq'|フリーズカセット|', nq'|Freeze Cassette|', nq'|Module Cryo|', nq'|Gefriermodul|', nq'|Gelomodulo|', nq'|CrioROM|', nq'|프리즈카세트|', nq'|Freeze Cassette|', nq'|冰凍卡帶 / 冰冻卡带|', nq'|Bīngdòng Kǎdài / Bīngdung Kāatdáai|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Member Card|', 4 , q'|Allows access to the Canalave City hotel to face Darkrai.|' , nq'|メンバーズカード|', nq'|Member's Card|', nq'|Carte Membre|', nq'|Mitgl.Karte|', nq'|Scheda Soci|', nq'|Carné Socio|', nq'|멤버스카드|', nq'|Membership Card|', nq'|會員卡 / 会员卡|', nq'|Huìyuán Kǎ / Wúiyùhn Kāat|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Love Ball|', 2 , q'|A type of Poké Ball that works better on Pokémon of the opposite gender.|' , nq'|ラブラブボール|', nq'|Love-Love Ball|', nq'|Love Ball|', nq'|Sympaball|', nq'|Love Ball|', nq'|Amor Ball|', nq'|러브러브볼|', nq'|Love-Love Ball|', nq'|甜蜜球|', nq'|Tiánmì Qiú / Tìhmmaht Kàuh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Steelium Z|', 7 , q'|Allows a Pokémon to upgrade their Steel-type damaging moves to the Z-Move Corkscrew Crash or upgrade their Steel-type status moves into Z-Moves. Makes Arceus a Steel-type Pokémon.|' , nq'|ハガネＺ|', nq'|Steel-Z|', nq'|Métallozélite|', nq'|Metallium Z|', nq'|Metallium Z|', nq'|Metalostal Z|', nq'|강철Z|', nq'|Gangcheol-Z|', nq'|鋼Ｚ / 钢Ｚ|', nq'|Gāng-Z / Gong-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Contest Pass|', 3 , q'|Allows the player to enter Contests.|' , nq'|コンテストパス|', nq'|Contest Pass|', nq'|Passe Concours|', nq'|Wettb.-Karte|', nq'|Tessera Gare|', nq'|Pase Concurso|', nq'|콘테스트패스|', nq'|Contest Pass|', nq'|華麗大賽參加證 / 华丽大赛参加证|', nq'|Huálì Dàsài Cānjiā Zhèng / Wàhlaih Daaihchoi Chāamgā Jing|', 160 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Galactic Key|', 4 , q'|Allows player to access the Galactic HQ in Veilstone City.|' , nq'|ギンガだんのカギ|', nq'|Ginga-dan no Kagi|', nq'|Clé Galaxie|', nq'|G-Schlüssel|', nq'|Galachiave|', nq'|Ll. Galaxia|', nq'|갤럭시단의 열쇠|', nq'|Galaxy Dan-ui Yeolsoe|', nq'|銀河隊鑰匙 / 银河队钥匙|', nq'|Yínhé Duì Yàoshi / Ngàhnhòh Déui Yeuhksìh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Magost Berry|', 3 , q'|Pokéblock and Poffin ingredient.|' , nq'|ゴスのみ|', nq'|Gosu no Mi|', nq'|Baie Mangou|', nq'|Magostbeere|', nq'|Baccagostan|', nq'|Baya Aostan|', nq'|고스티열매|', nq'|Gostee Yeolmae|', nq'|岳竹果|', nq'|Yuèzhú Guǒ / Ngohkjūk Gwó|', 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Surge Badge|' , nq'|だいだいバッジ|', nq'|Daidai Badge|', nq'|Fulguro-Badge|', nq'|Gewitterorden|', nq'|Medaglia Tonante|', nq'|Medalla Fulgor|', nq'|주황배지|', nq'|Juhwang Badge|', nq'|橘色徽章 / 桔色徽章|', nq'|Jú-sè Huīzhāng / Gwāt-sīk Fāijēung|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|AuroraTicket|', 3 , q'|Event item that allows player to catch Deoxys.|' , nq'|オーロラチケット|', nq'|Aurora Ticket|', nq'|Ticketaurora|', nq'|Auroraticket|', nq'|Biglietto Aurora|', nq'|Ori-Ticket|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Life Orb|', 4 , q'|Raises the power of moves, but causes recoil damage.|' , nq'|いのちのたま|', nq'|Inochi no Tama|', nq'|Orbe Vie|', nq'|Leben-Orb|', nq'|Assorbisfera|', nq'|Vidasfera|', nq'|생명의구슬|', nq'|Saengmyeong-ui Guseul|', nq'|生命寶珠 / 生命宝珠|', nq'|Shēngmìng Bǎozhū / Sāngmihng Bóujyū|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Yellow Petal|', 7 , q'|A yellow petal required to complete Mina's Trial.|' , nq'|きいろのはなびら|', nq'|Kiiro no Hanabira|', nq'|Pétale Jaune|', nq'|Gelbes Blatt|', nq'|Petalo giallo|', nq'|Pétalo Amarillo|', nq'|노랑꽃잎|', nq'|Norang Kkochip|', nq'|黃色花瓣 / 黄色花瓣|', nq'|Huáng-sè Huābàn / Wòhng-sīk Fāfáan|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Seal Case|', 4 , q'|Holds Seals.|' , nq'|シールいれ|', nq'|Seal Ire|', nq'|Boîte Sceaux|', nq'|Stick.Koffer|', nq'|Portabolli|', nq'|Caja Sellos|', nq'|실상자|', nq'|Seal Sangja|', nq'|貼紙盒 / 贴纸盒|', nq'|Tiēzhǐ Hé / Tipjí Hahp|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Alakazite|', 6 , q'|Allows Alakazam to Mega Evolve into Mega Alakazam.|' , nq'|フーディナイト|', nq'|Foodinite|', nq'|Alakazamite|', nq'|Simsalanit|', nq'|Alakazamite|', nq'|Alakazamita|', nq'|후디나이트|', nq'|Fudinnite|', nq'|胡地進化石 / 胡地进化石|', nq'|Húdì Jìnhuà Shí / Wùhdeih Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Bluk Berry|', 3 , q'|Poffin and Pokéblock ingredient.|' , nq'|ブリーのみ|', nq'|Burī no Mi|', nq'|Baie Remu|', nq'|Morbbeere|', nq'|Baccamora|', nq'|Baya Oram|', nq'|블리열매|', nq'|Beulli Yeolmae|', nq'|墨莓果|', nq'|Mòméi Guǒ / Mahkmùih Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Orange Mail|', 3 , q'|Mail with a Zigzagoon print. To be held by a Pokémon for delivery.|' , nq'|オレンジメール|', nq'|Orange Mail|', nq'|Lettre Oranj|', nq'|Zigzagbrief|', nq'|Mess. Agrume|', nq'|Carta Naranja|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Honey|', 4 , q'|Can be slathered on orange trees to attract rare Pokémon; or used in grass to attract wild Pokémon the same way Sweet Scent does.|' , nq'|あまいミツ|', nq'|Amai Mitsu|', nq'|Miel|', nq'|Honig|', nq'|Miele|', nq'|Miel|', nq'|달콤한꿀|', nq'|Dalkomhan Kkul|', nq'|甜甜蜜|', nq'|Tiántián Mì / Tìhmtìhm Maht|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Amaze Mulch|', 6 , q'|Combines the effects of Boost Mulch, Rich Mulch, and Surprise Mulch: Causes an applied Berry patch's soil to dry quicker, increases final Berry harvest by 2 Berries, and makes Berry mutations more likely.|' , nq'|とんでもこやし|', nq'|Tondemo Koyashi|', nq'|Fertiprodige|', nq'|Ultramulch|', nq'|Fertilprodigio|', nq'|Abono Insólito|', nq'|기절초풍비료|', nq'|Gijeolchopung Biryo|', nq'|超效肥|', nq'|Chāoxiào Féi / Chīuhaauh Fèih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Waterium Z|', 7 , q'|Allows a Pokémon to upgrade their Water-type damaging moves to the Z-Move Hydro Vortex or upgrade their Water-type status moves into Z-Moves. Makes Arceus a Water-type Pokémon.|' , nq'|ミズＺ|', nq'|Water-Z|', nq'|Aquazélite|', nq'|Aquium Z|', nq'|Idrium Z|', nq'|Hidrostal Z|', nq'|물Z|', nq'|Mul-Z|', nq'|水Ｚ|', nq'|Shuǐ-Z / Séui-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Roseli Berry|', 6 , q'|Reduces damage from a super effective Fairy-type move.|' , nq'|ロゼルのみ|', nq'|Rozelle no Mi|', nq'|Baie Selro|', nq'|Hibisbeere|', nq'|Baccarcadè|', nq'|Baya Hibis|', nq'|로셀열매|', nq'|Rosel Yeolmae|', nq'|洛玫果|', nq'|Luòméi Guǒ / Lokmùih Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Babiri Berry|', 4 , q'|Reduces damage from a super effective Steel-type move by 50%.|' , nq'|リリバのみ|', nq'|Ririba no Mi|', nq'|Baie Babiri|', nq'|Babiribeere|', nq'|Baccababiri|', nq'|Baya Baribá|', nq'|바리비열매|', nq'|Baribi Yeolmae|', nq'|霹霹果|', nq'|Pīpī Guǒ / Pīkpīk Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Ghost Memory|', 7 , q'|Makes Silvally a Ghost-type Pokémon and makes Multi-Attack a Ghost-type move.|' , nq'|ゴーストメモリ|', nq'|Ghost Memory|', nq'|ROM Spectre|', nq'|Geister-Disc|', nq'|ROM Spettro|', nq'|Disco Fantasma|', nq'|고스트메모리|', nq'|Ghost Memory|', nq'|幽靈記憶碟*|'||chr(10)||nq'|幽灵存储碟|', nq'|Yōulíng Jìyìdié / Yāulìhng Geiyīkdihp*|'||chr(10)||nq'|Yōulíng Cúnchǔdié|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|TM Case|', 3 , q'|Holds TMs.|' , nq'|わざマシンケース|', nq'|Waza Machine Case|', nq'|Boite CT|', nq'|VM/TM Box|', nq'|Porta MT-MN|', nq'|Tubo MT-MO|', nq'|기술머신케이스|', nq'|Gisul Machine Case|', nq'|招式學習器盒 / 招式学习器盒|', nq'|Zhāoshì Xuéxíqì Hé / Jīusīk Hohkjaahphei Hahp|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Quick Powder|', 4 , q'|Raises Ditto's speed.|' , nq'|スピードパウダー|', nq'|Speed Powder|', nq'|Poudre Vite|', nq'|Flottstaub|', nq'|Velopolvere|', nq'|Polvo Veloz|', nq'|스피드파우더|', nq'|Speed Powder|', nq'|速度粉|', nq'|Sùdù Fěn / Chūkdouh Fán|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Fairy Gem|', 6 , q'|Increases the power of the holder's first Fairy-type move by 50%, and is consumed after use.|' , nq'|フェアリージュエル|', nq'|Fairy Jewel|', nq'|Joyau Fée|', nq'|Feenjuwel|', nq'|Bijoufolletto|', nq'|Gema Hada|', nq'|페어리주얼|', nq'|Fairy Jewel|', nq'|妖精寶石 / 妖精宝石|', nq'|Yāojing Bǎoshí / Yīujīng Bóusehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Enigma Berry|', 3 , q'|Restores ¼ of a Pokémon's HP after being hit by a super effective.|' , nq'|ナゾのみ|', nq'|Nazo no Mi|', nq'|Baie Enigma|', nq'|Enigmabeere|', nq'|Baccaenigma|', nq'|Baya Enigma|', nq'|의문열매|', nq'|Uimun Yeolmae|', nq'|謎芝果 / 谜芝果|', nq'|Mízhī Guǒ / Màihjī Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Banettite|', 6 , q'|Allows Banette to Mega Evolve into Mega Banette.|' , nq'|ジュペッタナイト|', nq'|Juppetanite|', nq'|Branettite|', nq'|Banetteonit|', nq'|Banettite|', nq'|Banettita|', nq'|다크펫나이트|', nq'|Darkpetnite|', nq'|詛咒娃娃進化石 / 诅咒娃娃进化石|', nq'|Zǔzhòuwáwá Jìnhuà Shí / Jojauwāwā Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Flying Memory|', 7 , q'|Makes Silvally a Flying-type Pokémon and makes Multi-Attack a Flying-type move.|' , nq'|フライングメモリ|', nq'|Flying Memory|', nq'|ROM Vol|', nq'|Flug-Disc|', nq'|ROM Volante|', nq'|Disco Volador|', nq'|플라잉메모리|', nq'|Flying Memory|', nq'|飛翔記憶碟*|'||chr(10)||nq'|飞翔存储碟|', nq'|Fēixiáng Jìyìdié / Fēichèuhng Geiyīkdihp*|'||chr(10)||nq'|Fēixiáng Cúnchǔdié|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Safari Ball|', 1 , q'|A type of Poké Ball to be used in the Safari Zone.|' , nq'|サファリボール|', nq'|Safari Ball|', nq'|Safari Ball|', nq'|Safariball|', nq'|Safari Ball|', nq'|Safari Ball|', nq'|사파리볼|', nq'|Safari Ball|', nq'|狩獵球 / 狩猎球|', nq'|Shòuliè Qiú / Sáulihp Kàuh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Oval Stone|', 4 , q'|When held, allows Happiny to evolve.|' , nq'|まんまるいし|', nq'|Manmaru Ishi|', nq'|Pierre Ovale|', nq'|Ovaler Stein|', nq'|Pietraovale|', nq'|Piedra Oval|', nq'|동글동글돌|', nq'|Donggeuldonggeul Dol|', nq'|渾圓之石 / 浑圆之石|', nq'|Húnyuán-zhī Shí / Wahnyùhn-jī Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Gram 2|', 5 , q'|An important letter which Wingull delivers.|' , nq'|はいたつぶつ２|', nq'|Haitatsubutsu 2|', nq'|Courrier 2|', nq'|Briefpost 2|', nq'|Missiva 2|', nq'|Envío 2|', nq'|배달물2|', nq'|Baedalmul 2|', nq'|配送物品２|', nq'|Pèisòng Wùpǐn 2 / Puisung Mahtbán 2|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Greet Mail|', 5 , q'|Stationary for introductory greetings. To be held by a Pokémon for delivery.|' , nq'|はじめてメール|', nq'|Hajimete Mail|', nq'|Lettre Salut|', nq'|Grußbrief|', nq'|Mess. Inizio|', nq'|C. Inicial|', nq'|첫메일|', nq'|Cheot Mail|', nq'|初次郵件 / 初次邮件|', nq'|Chūcì Yóujiàn / Chōchi Yàuhgín|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Prof's Letter|', 6 , q'|Given to the player's mother in exchange for a Town Map and a Potion.|' , nq'|はかせのてがみ|', nq'|Hakase no Tegami|', nq'|Lettre du Prof|', nq'|Brief vom Prof|', nq'|Lettera del Prof|', nq'|Carta Profesor|', nq'|박사의편지|', nq'|Baksa-ui Pyeonji|', nq'|博士的信|', nq'|Bóshì-de Xìn / Boksih-dīk Seun|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|X Attack 6|', 5 , q'|Immensely raises a Pokémon's Attack. Wonder Launcher only.|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|X Accuracy 3|', 5 , q'|Drastically raises a Pokémon's accuracy. Wonder Launcher only.|' , 0 );
insert into ITEMS( NAME, GEN, GEN2, DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Secret Key|', 1, 4, q'|Allows access to the Cinnabar Gym (1) and the secret room within the Galactic Veilstone Building (4)|' , nq'|ひみつのカギ|', nq'|Himitsu no Kagi|', nq'|Clé Secrète|', nq'| ?-Öffner|', nq'|Chiave Segreta|', nq'|Ll. Secreta|', nq'|비밀의열쇠|', nq'|Bimirui Yeolsoe|', nq'|秘密鑰匙 / 秘密钥匙|', nq'|Mìmì Yàoshi / Beimaht Yeuhksìh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Repel|', 1 , q'|Prevents wild Pokémon with a lower level than the first member of the party from appearing for 100 steps|' , nq'|むしよけスプレー|', nq'|Mushi Yoke Spray|', nq'|Repousse|', nq'|Schutz|', nq'|Repellente|', nq'|Repelente|', nq'|벌레회피스프레이|', nq'|Beolle Hoepi Spray|', nq'|除蟲噴霧 / 除虫喷雾|', nq'|Chúchóng Pēnwù / Chèuihchùhng Panmouh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Splash Plate|', 4 , q'|Raises the power of Water-type moves.|' , nq'|しずくプレート|', nq'|Shizuku Purēto|', nq'|Plaque Hydro|', nq'|Wassertafel|', nq'|Lastraidro|', nq'|Tabla Linfa|', nq'|물방울플레이트|', nq'|Mulbang-ul Plate|', nq'|水滴石板|', nq'|Shuǐdī Shíbǎn / Séuidihk Sehkbáan|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Enigma Stone|', 4 , q'|Allows for the capture of either Latias or Latios.|' , nq'|なぞのすいしょう|', nq'|Nazo no Suishō|', nq'|Mystécristal|', nq'|Mytokristall|', nq'|Misticristal|', nq'|Misticristal|', nq'|수수께끼의수정|', nq'|Susukkekki-ui Sujeong|', nq'|謎之水晶 / 谜之水晶|', nq'|Mí-zhī Shuǐjīng / Màih-jī Séuijīng|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Root Fossil|', 3 , q'|A Fossil from which a Lileep can be resurrected.|' , nq'|ねっこのカセキ|', nq'|Nekko no Kaseki|', nq'|Fossile Racine|', nq'|Wurzelfossil|', nq'|Radifossile|', nq'|Fósil Raíz|', nq'|뿌리화석|', nq'|Ppuri Hwaseok|', nq'|根狀化石 / 根状化石|', nq'|Gēnzhuàng Huàshí / Gānjohng Fasehk|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Mawilite|', 6 , q'|Allows Mawile to Mega Evolve into Mega Mawile.|' , nq'|クチートナイト|', nq'|Kucheatnite|', nq'|Mysdibulite|', nq'|Flunkifernit|', nq'|Mawilite|', nq'|Mawilita|', nq'|입치트나이트|', nq'|Ipchittnite|', nq'|大嘴娃進化石 / 大嘴娃进化石|', nq'|Dàzuǐwá Jìnhuà Shí / Daaihjéuiwā Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Ice Heal|', 1 , q'|Thaws out a frozen Pokémon.|' , nq'|こおりなおし|', nq'|Kōri Naoshi|', nq'|Antigel|', nq'|Eisheiler|', nq'|Antigelo|', nq'|Antihielo|', nq'|얼음상태치료제|', nq'|Eoreum Sangtae Chiryoje|', nq'|解凍藥 / 解冻药|', nq'|Jiědòngyào / Gáaidungyeuhk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Fast Ball|', 2 , q'|A type of Poké Ball that works better on Pokémon that try to flee.|' , nq'|スピードボール|', nq'|Speed Ball|', nq'|Speed Ball|', nq'|Turboball|', nq'|Rapid Ball|', nq'|Rapid Ball|', nq'|스피드볼|', nq'|Speed Ball|', nq'|速度球|', nq'|Sùdù Qiú / Chūkdouh Kàuh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|Running Shoes|', 3 , q'|Allows the player to run faster.|' , 2048 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|N-Solarizer|' , nq'|ネクロプラスソル|', nq'|Necro Plus Sol|', nq'|Necrosol|', nq'|Necrosol|', nq'|Necrosolix|', nq'|Necrosol|', nq'|네크로플러스솔|', nq'|Necro Plus Sol|', nq'|奈克洛索爾合體器 / 奈克洛索尔合体器|', nq'|Nàikèluò Suǒěr Hétǐqì / Noihhāklok Sokyíh Hahptáihei|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Electric Memory|', 7 , q'|Makes Silvally a Electric-type Pokémon and makes Multi-Attack a Electric-type move.|' , nq'|エレクトロメモリ|', nq'|Electro Memory|', nq'|ROM Électrik|', nq'|Elektro-Disc|', nq'|ROM Elettro|', nq'|Disco Eléctrico|', nq'|일렉트릭메모리|', nq'|Electric Memory|', nq'|電子記憶碟*|'||chr(10)||nq'|电子存储碟|', nq'|Diànzǐ Jìyìdié / Dihnjí Geiyīkdihp*|'||chr(10)||nq'|Diànzǐ Cúnchǔdié|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Berserk Gene|', 2 , q'|Confuses the holder and raises Attack.|' , nq'|はかいのいでんし|', nq'|Hakai no Idenshi|', nq'|ADN Berzerk|', nq'|Berserk-Gen|', nq'|Gene Furioso|', nq'|Gen Loco|', nq'|파괴의유전자|', nq'|Pagoe-ui Yujeonja|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Rock Gem|', 5 , q'|Increases the power of the holder's first Rock-type move by 50%, and is consumed after use.|' , nq'|いわのジュエル|', nq'|Iwa no Jewel|', nq'|Joyau Roche|', nq'|Gesteinsjuwel|', nq'|Bijouroccia|', nq'|Gema Roca|', nq'|바위주얼|', nq'|Bawi Jewel|', nq'|岩石寶石 / 岩石宝石|', nq'|Yánshí Bǎoshí / Ngàahmsehk Bóusehk|', 80 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Contest Costume|', 6 , q'|Worn during Pokémon Contest Spectacular performances.|' , nq'|ライブスーツ|'||chr(10)||nq'|ライブドレス|', nq'|Live Suit|'||chr(10)||nq'|Live Dress|', nq'|Costume Live|'||chr(10)||nq'|Robe Live|', nq'|Live-Anzug|'||chr(10)||nq'|Live-Kleid|', nq'|Costume Live|'||chr(10)||nq'|Vestito Live|', nq'|Traje de Gala|'||chr(10)||nq'|Vestido de Gala|', nq'|라이브슈트|'||chr(10)||nq'|라이브드레스|', nq'|Live Suit|'||chr(10)||nq'|Live Dress|', nq'|演出禮服 / 演出礼服|'||chr(10)||nq'|演出禮裙 / 演出礼裙|', nq'|Yǎnchū Lǐfú / Yínchēut Láihfuhk|'||chr(10)||nq'|Yǎnchū Lǐqún / Yínchēut Láihkwàhn|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|Dire Hit 2|', 5 , q'|Raises critical hit ratio by 2 levels in battle. Wonder Launcher only.|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Leppa Berry|', 3 , q'|Restores 10 PP.|' , nq'|ヒメリのみ|', nq'|Himeri no Mi|', nq'|Baie Mepo|', nq'|Jonagobeere|', nq'|Baccamela|', nq'|Baya Zanama|', nq'|과사열매|', nq'|Gwasa Yeolmae|', nq'|蘋野果 / 苹野果|', nq'|Píngyě Guǒ / Pìhngyéh Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Poké Flute|', 1 , q'|Awakens sleeping Pokémon.|' , nq'|ポケモンのふえ|', nq'|Pokémon no Fue|', nq'|Pokéflute|', nq'|Pokéflöte|', nq'|Pokéflauto|', nq'|Poké Flauta|', nq'|포켓몬피리|', nq'|Pocketmon Piri|', nq'|寶可夢之笛 / 宝可梦之笛|', nq'|Bǎokěmèng-zhī Dí / Bóuhómuhng-jī Dehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Water Memory|', 7 , q'|Makes Silvally a Water-type Pokémon and makes Multi-Attack a Water-type move.|' , nq'|ウオーターメモリ|', nq'|Water Memory|', nq'|ROM Eau|', nq'|Wasser-Disc|', nq'|ROM Acqua|', nq'|Disco Agua|', nq'|워터메모리|', nq'|Water Memory|', nq'|清水記憶碟*|'||chr(10)||nq'|清水存储碟|', nq'|Qīngshuǐ Jìyìdié / Chīngséui Geiyīkdihp*|'||chr(10)||nq'|Qīngshuǐ Cúnchǔdié|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Ylw ID Badge|', 3 , q'|One of four keys needed to unlock the north door of Realgam Tower.|' , nq'|ＩＤバッジきいろ|', nq'|ID Badge Kīro|', nq'|Passe Jaune|', nq'|Gelbe ID-Marke|', nq'|Pass Giallo|', nq'|P. Amarillo|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Psychic Memory|', 7 , q'|Makes Silvally a Psychic-type Pokémon and makes Multi-Attack a Psychic-type move.|' , nq'|サイキックメモリ|', nq'|Psychic Memory|', nq'|ROM Psy|', nq'|Psycho-Disc|', nq'|ROM Psico|', nq'|Disco Psíquico|', nq'|사이킥메모리|', nq'|Psychic Memory|', nq'|精神記憶碟*|'||chr(10)||nq'|精神存储碟|', nq'|Jīngshén Jìyìdié / Jīngsàhn Geiyīkdihp*|'||chr(10)||nq'|Jīngshén Cúnchǔdié|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Mind Plate|', 4 , q'|Raises the power of Psychic-type moves.|' , nq'|ふしぎのプレート|', nq'|Fushigi no Purēto|', nq'|Plaque Esprit|', nq'|Hirntafel|', nq'|Lastramente|', nq'|Tabla Mental|', nq'|이상한플레이트|', nq'|Isanghan Plate|', nq'|神奇石板|', nq'|Shénqí Shíbǎn / Sàhnkèih Sehkbáan|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Normalium Z|', 7 , q'|Allows a Pokémon to upgrade their Normal-type damaging moves to the Z-Move Breakneck Blitz or upgrade their Normal-type status moves into Z-Moves.|' , nq'|ノーマルＺ|', nq'|Normal-Z|', nq'|Normazélite|', nq'|Normium Z|', nq'|Normium Z|', nq'|Normastal Z|', nq'|노말Z|', nq'|Normal-Z|', nq'|一般Ｚ|', nq'|Yī​bān-Z / Yātbūn-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Burn Drive|', 5 , q'|Makes Techno Blast a Fire-type move when held by Genesect.|' , nq'|ブレイズカセット|', nq'|Blaze Cassette|', nq'|Module Pyro|', nq'|Flammenmodul|', nq'|Piromodulo|', nq'|PiroROM|', nq'|블레이즈카세트|', nq'|Blaze Cassette|', nq'|火焰卡帶 / 火焰卡带|', nq'|Huǒyàn Kǎdài / Fóyihm Kāatdáai|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Fashion Case|', 4 , q'|Stores Accessories.|' , nq'|アクセサリーいれ|', nq'|Accessory Ire|', nq'|Coffret Mode|', nq'|Modekoffer|', nq'|Scatola Chic|', nq'|Caja Corazón|', nq'|액세서리상자|', nq'|Accessory Sangja|', nq'|飾品盒 / 饰品盒|', nq'|Shìpǐn Hé / Sīkbán Hahp|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Ice Stone|', 7 , q'|Can be used to evolve Alolan Sandshrew and Alolan Vulpix.|' , nq'|こおりのいし|', nq'|Kōri no Ishi|', nq'|Pierre Glace|', nq'|Eisstein|', nq'|Pietragelo|', nq'|Piedra Hielo|', nq'|얼음의돌|', nq'|Eoreum-ui Dol|', nq'|冰之石|', nq'|Bīng-zhī Shí / Bīng-jī Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Ice Gem|', 5 , q'|Increases the power of the holder's first Ice-type move by 50%, and is consumed after use.|' , nq'|こおりのジュエル|', nq'|Kōri no Jewel|', nq'|Joyau Glace|', nq'|Eisjuwel|', nq'|Bijoughiaccio|', nq'|Gema Hielo|', nq'|얼음주얼|', nq'|Eol'eum Jewel|', nq'|冰之寶石 / 冰之宝石|', nq'|Bīng-zhī Bǎoshí / Bīng-jī Bóusehk|', 48 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Stardust|', 2 , q'|Can be sold for 1000.|' , nq'|ほしのすな|', nq'|Hoshi no Suna|', nq'|Poussière Étoile|', nq'|Sternenstaub|', nq'|Polvostella|', nq'|Polvoestelar|', nq'|별의모래|', nq'|Byeorui Morae|', nq'|星星沙子|', nq'|Xīngxīng Shāzi / Sīngsīng Sājí|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|BridgeMail M|', 5 , q'|Stationary with an arched bridge print. To be held by a Pokémon for delivery.|' , nq'|ブリッジメールＷ|', nq'|Bridge Mail W|', nq'|Lettre PontI|', nq'|Brückbrief W|', nq'|Mess. Merav.|', nq'|C. Puente P|', nq'|브리지메일W|', nq'|Bridge Mail W|', nq'|橋梁郵件Ｗ / 桥梁邮件Ｗ|', nq'|Qiáoliáng Yóujiàn W / Kìuhlèuhng Yàuhgín W|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Payapa Berry|', 4 , q'|Reduces damage from a super effective Psychic-type move.|' , nq'|ウタンのみ|', nq'|Utan no Mi|', nq'|Baie Yapap|', nq'|Pyapabeere|', nq'|Baccapayapa|', nq'|Baya Payapa|', nq'|야파열매|', nq'|Yapa Yeolmae|', nq'|福祿果 / 福禄果|', nq'|Fúlù Guǒ / Fūkluhk Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Full Restore|', 1 , q'|Fully restores all HP and cures all status problems of a Pokémon.|' , nq'|かいふくのくすり|', nq'|Kaifuku no Kusuri|', nq'|Guerison|', nq'|Top-Genesung|', nq'|Ricarica Totale|', nq'|Restaurar Todo|', nq'|회복약|', nq'|Hoebok Yak|', nq'|全復藥 / 全复药|', nq'|Quánfùyào / Chyùhnfuhkyeuhk|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Fishing Rod|', 7 , q'|Allows the player to fish near underwater piles of rock.|' , nq'|つりざお|', nq'|Tsurizao|', nq'|Canne à Pêche|', nq'|Angel|', nq'|Amo|', nq'|Caña|', nq'|낚싯대|', nq'|Nakksisdae|', nq'|釣竿 / 钓竿|', nq'|Diàogān / Diugōn|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Stable Mulch|', 4 , q'|Extends the time ripened Berries will stay on the plant before falling.|' , nq'|ながながこやし|', nq'|Naganaga Koyashi|', nq'|Fertistable|', nq'|Stabilmulch|', nq'|Fertilsaldo|', nq'|Abono Fijador|', nq'|오래오래비료|', nq'|Orae-orae Biryo|', nq'|久久肥|', nq'|Jiǔjiǔ Féi / Gáugáu Fèih|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|BridgeMail V|', 5 , q'|Stationary with a brick bridge print. To be held by a Pokémon for delivery.|' , nq'|ブリッジメールＶ|', nq'|Bridge Mail V|', nq'|Lettre PontH|', nq'|Brückbrief D|', nq'|Mess. Vill.|', nq'|C. Puente V|', nq'|브리지메일V|', nq'|Bridge Mail V|', nq'|橋梁郵件Ｖ / 桥梁邮件Ｖ|', nq'|Qiáoliáng Yóujiàn V / Kìuhlèuhng Yàuhgín V|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Rawst Berry|', 3 , q'|Cures a burn.|' , nq'|チーゴのみ|', nq'|Chīgo no Mi|', nq'|Baie Fraive|', nq'|Fragiabeere|', nq'|Baccafrago|', nq'|Baya Safre|', nq'|복분열매|', nq'|Bokbun Yeolmae|', nq'|莓莓果|', nq'|Méiméi Guǒ / Mùihmùih Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Mystic Water|', 2 , q'|Raises the power of Water-type moves.|' , nq'|しんぴのしずく|', nq'|Shinpi no Shizuku|', nq'|Eau Mystique|', nq'|Zauberwasser|', nq'|Acqua Magica|', nq'|Agua Mística|', nq'|신비의물방울|', nq'|Sinbiui Mulbang-ul|', nq'|神秘水滴|', nq'|Shénmì shuǐdī / Sàhnbei Séuidihk|', 32 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Psychic Gem|', 5 , q'|Increases the power of the holder's first Psychic-type move by 50%, and is consumed after use.|' , nq'|エスパージュエル|', nq'|Esper Jewel|', nq'|Joyau Psy|', nq'|Psychojuwel|', nq'|Bijoupsico|', nq'|Gema Psíquica|', nq'|에스퍼주얼|', nq'|Esper Jewel|', nq'|超能力寶石 / 超能力宝石|', nq'|Chāonénglì Bǎoshí / Chīunàhnglihk Bóusehk|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|Common Stone|', 6 , q'|Not available without cheating. Currently has no use.|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Burnt Berry|', 2 , q'|Thaws out a frozen Pokémon.|' , nq'|やけたきのみ|', nq'|Yaketa Kino Mi|', nq'|Baie Brulure|', nq'|Brandbeere|', nq'|Bacca Bruc.|', nq'|Antiquembaya|', nq'|불탄나무열매|', nq'|Bultan Namu Yeolmae|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Grubby Hanky|', 5 , q'|Can be exchanged for a Fluffy Tail at Café Warehouse.|' , nq'|よごれたハンカチ|', nq'|Dirty Handkerchief|', nq'|MouchoirSale|', nq'|Schnäuztuch|', nq'|Pezza Sporca|', nq'|Pan. Sucio|', nq'|더러손수건|', nq'|Deoreo Sonsugeon|', nq'|髒手帕 / 脏手帕|', nq'|Zāng Shǒupà / Jōng Sáupaak|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|Nutpea Berry|', 3 , q'|Pokéblock ingredient. It will become an Enigma Berry if transferred to Generation IV via Pal Park.|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Bluesky Mail|', 4 , q'|A sky-print mail. To be held by a Pokémon for delivery.|' , nq'|あおぞらメール|', nq'|Aozora Mail|', nq'|LetrCielBleu|', nq'|Kobaltbrief|', nq'|Mess. Cielo|', nq'|Cartaceleste|', nq'|푸른하늘메일|', nq'|Pureun Haneul Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|Niniku Berry|', 3 , q'|Pokéblock ingredient. Will become an Enigma Berry if transferred to Generation IV via Pal Park.|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Eon Mail|', 2 , q'|Eevee-printed mail. To be held by a Pokémon for delivery.|' , nq'|ブイブイメール|', nq'|Vui-Vui Mail|', nq'|Lettre Evoli|', nq'|Anara-Brief|', nq'|Mess. Eon|', nq'|Carta Eón|', nq'|브이브이메일|', nq'|Beuibeui Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Wepear Berry|', 3 , q'|Pokéblock and Poffin ingredient.|' , nq'|セシナのみ|', nq'|Seshina no Mi|', nq'|Baie Repoi|', nq'|Nirbebeere|', nq'|Baccapera|', nq'|Baya Peragu|', nq'|서배열매|', nq'|Seobae Yeolmae|', nq'|西梨果|', nq'|Xīlí Guǒ / Sāilèih Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lure Ball|', 2 , q'|A type of Poké Ball that works best on Pokémon caught using a rod.|' , nq'|ルアーボール|', nq'|Lure Ball|', nq'|Appat Ball|', nq'|Köderball|', nq'|Esca Ball|', nq'|Cebo Ball|', nq'|루어볼|', nq'|Lure Ball|', nq'|誘餌球 / 诱饵球|', nq'|Yòu'ěr Qiú / Yáuhneih Kàuh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Krane Memo 4|', 3 , q'|Contains information about purification.|' , nq'|クレインメモ４|', nq'|Krane Memo 4|', nq'|Memo Syrus 4|', nq'|Klein-Memo 4|', nq'|Appunti 4|', nq'|Parte Cío 4|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Meteorite|', 3 , q'|Deliver to Professor CozmoRSE or Lostelle's fatherFRLG. Enables the Rayquaza featured in the Delta Episode to Mega Evolve.ORAS|' , nq'|いんせき|', nq'|Inseki|', nq'|Météorite|', nq'|Meteorit|', nq'|Meteorite|', nq'|Meteorito|', nq'|운석|', nq'|Unseok|', nq'|隕石 / 陨石|', nq'|Yǔnshí / Wáhnsehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Kangaskhanite|', 6 , q'|Allows Kangaskhan to Mega Evolve into Mega Kangaskhan.|' , nq'|ガルーラナイト|', nq'|Garuranite|', nq'|Kangourexite|', nq'|Kangamanit|', nq'|Kangaskhanite|', nq'|Kangaskhanita|', nq'|캥카나이트|', nq'|Kengkanite|', nq'|袋獸進化石 / 袋兽进化石|', nq'|Dàishòu Jìnhuà Shí / Doihsau Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Charti Berry|', 4 , q'|Reduces damage from a super effective Rock-type move by 50%.|' , nq'|ヨロギのみ|', nq'|Yorogi no Mi|', nq'|Baie Charti|', nq'|Chiaribeere|', nq'|Baccaciofo|', nq'|Baya Alcho|', nq'|루미열매|', nq'|Rumi Yeolmae|', nq'|草蠶果 / 草蚕果|', nq'|Cǎocán Guǒ / Chóuchàahm Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Poison Memory|', 7 , q'|Makes Silvally a Poison-type Pokémon and makes Multi-Attack a Poison-type move.|' , nq'|ポイズンメモリ|', nq'|Poison Memory|', nq'|ROM Poison|', nq'|Gift-Disc|', nq'|ROM Veleno|', nq'|Disco Veneno|', nq'|포이즌메모리|', nq'|Poison Memory|', nq'|毒記憶碟*|'||chr(10)||nq'|毒存储碟|', nq'|Dú Jìyìdié / Duhk Geiyīkdihp*|'||chr(10)||nq'|Dú Cúnchǔdié|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Yache Berry|', 4 , q'|Reduces damage taken from a super effective Ice-type move.|' , nq'|ヤチェのみ|', nq'|Yache no Mi|', nq'|Baie Nanone|', nq'|Kiroyabeere|', nq'|Baccamoya|', nq'|Baya Rimoya|', nq'|플카열매|', nq'|Peulka Yeolmae|', nq'|番荔果|', nq'|Fānlì Guǒ / Fāanlaih Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Old Rod|', 1 , q'|Can be used in or next to water to initiate a battle with a low-level aquatic Pokémon.|' , nq'|ボロのつりざお|', nq'|Boro no Tsurizao|', nq'|Canne|', nq'|Angel|', nq'|Amo Vecchio|', nq'|Caña Vieja|', nq'|낡은낚싯대|', nq'|Nalgeun Naksitdae|', nq'|破舊釣竿 / 破旧钓竿|', nq'|Pòjiù Diàogān / Pogauh Diugōn|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Ruby|', 3 , q'|Give to Celio along with Sapphire to set up the Network Machine of the Pokémon Network Center. It allows the player to trade with Ruby, Sapphire, and Emerald.|' , nq'|ルビー|', nq'|Ruby|', nq'|Rubis|', nq'|Rubin|', nq'|Rubino|', nq'|Rubí|' , 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Key Stone|' , nq'|キーストーン|', nq'|Key Stone|', nq'|Gemme Sésame|', nq'|Schlüssel-Stein|', nq'|Pietrachiave|', nq'|Piedra Activadora|', nq'|키스톤|', nq'|Key Stone|', nq'|鑰石 / 钥石|', nq'|Yàoshí / Yeuhksehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Heart Mail|', 4 , q'|Mail with a heart pattern. To be held by a Pokémon for delivery.|' , nq'|ラブラブメール|', nq'|Love-Love Mail|', nq'|Lettre Coeur|', nq'|Rosabrief|', nq'|Mess. Cuore|', nq'|Car. Corazón|', nq'|러브러브메일|', nq'|Love-Love Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Red Chain|', 4 , q'|A mythical chain linked to the legendary Pokémon of the Sinnoh region. Unobtainable without cheating.|' , nq'|あかいくさり|', nq'|Akai Kusari|', nq'|Chaîne Rouge|', nq'|Rote Kette|', nq'|Rossocatena|', nq'|Cadena Roja|', nq'|빨강쇠사슬|', nq'|Ppalgang Soesaseul|', nq'|紅色鎖鏈 / 红色锁链|', nq'|Hóng-sè Suǒliàn / Hùhng-sīk Sólín|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|Eggant Berry|', 3 , q'|Cures infatuation status. Will turn into an Enigma Berry if transferred to Generation IV via Pal Park.|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Reply Mail|', 5 , q'|Stationary for writing a reply. To be held by a Pokémon for delivery.|' , nq'|おかえしメール|', nq'|Okaeshi Mail|', nq'|Let. Réponse|', nq'|Rückbrief|', nq'|Mess. Risp.|', nq'|C. Respuesta|', nq'|답장메일|', nq'|Dapjang Mail|', nq'|回覆郵件 / 回复邮件|', nq'|Huífù Yóujiàn / Wùihfūk Yàuhgín|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Mirage Mail|', 2 , q'|Mail with a Mew pattern. Available only through Mystery Gift. To be held by a Pokémon for delivery.|' , nq'|まぼろしメール|', nq'|Maboroshi Mail|', nq'|Lettre Mirage|', nq'|Trugbrief|', nq'|Mess. Visione|', nq'|C.Espejismo|', nq'|환상의메일|', nq'|Hwansang-ui Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Berry Pouch|', 3 , q'|Holds Berries.|' , nq'|きのみぶくろ|', nq'|Kinomi Bukuro|', nq'|Sac A Baies|', nq'|Beerentüte|', nq'|Porta Bacche|', nq'|Saco Bayas|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Secret Potion|', 2 , q'|Used to cure Amphy's sicknessGSCHGSS or the Psyduck's headachesDPPt. Is produced by the Cianwood City Pharmacy.|', q'|Formatted as SecretPotion prior to Generation VI.|', nq'|ひでんのくすり|', nq'|Hiden no Kusuri|', nq'|Potionsecret|', nq'|Geheimtrank|', nq'|Poz. Segreta|', nq'|Poc. Secreta|', nq'|비전신약|', nq'|Bijeon Sin-yak|', nq'|秘傳之藥 / 秘传之药|', nq'|Mìchuán-zhī Yào / Beichyùhn-jī Yeuhk|', 1024 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Gram 1|', 5 , q'|An important letter which Wingull delivers.|' , nq'|はいたつぶつ１|', nq'|Haitatsubutsu 1|', nq'|Courrier 1|', nq'|Briefpost 1|', nq'|Missiva 1|', nq'|Envío 1|', nq'|배달물1|', nq'|Baedalmul 1|', nq'|配送物品１|', nq'|Pèisòng Wùpǐn 1 / Puisung Mahtbán 1|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Moomoo Milk|', 2 , q'|Restores 100 HP.|' , nq'|モーモーミルク|', nq'|Mō Mō Milk|', nq'|Lait Meumeu|', nq'|Kuhmuh-Milch|', nq'|Latte Mumu|', nq'|Leche Mu-Mu|', nq'|튼튼밀크|', nq'|Teunteun Milk|', nq'|哞哞鮮奶 / 哞哞鲜奶|', nq'|Mōumōu Xiānnǎi / Māumāu Sīnnáaih|', 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Ilima's Normalium Z|' , nq'|イリマのノーマルＺ|', nq'|Irima no Normal Z|', nq'|Cristal Z Althéo|', nq'|Elimas Normium Z|', nq'|Normium Z Liam|', nq'|Cristal Z (Liam)|', nq'|일리마의 노말Z|', nq'|Illima-ui Normal-Z|', nq'|伊利馬的一般Ｚ / 伊利马的一般Ｚ|', nq'|Yīlìmǎ-de Yībān-Z / Yīleihmáh-dīk Yātbūn-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Gengarite|', 6 , q'|Allows Gengar to Mega Evolve into Mega Gengar.|' , nq'|ゲンガナイト|', nq'|Ganganite|', nq'|Ectoplasmite|', nq'|Gengarnit|', nq'|Gengarite|', nq'|Gengarita|', nq'|팬텀나이트|', nq'|Penteomnite|', nq'|耿鬼進化石 / 耿鬼进化石|', nq'|Gěngguǐ Jìnhuà Shí / Gánggwái Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Super Potion|', 1 , q'|Restores 60 HP. (50HP before Gen. VII).|' , nq'|いいキズぐすり|', nq'|Ii Kizu Gusuri|', nq'|Super Potion|', nq'|Supertrank|', nq'|Super Pozione|', nq'|Superpoción|', nq'|좋은상처약|', nq'|Jo-eun Sangcheo Yak|', nq'|好傷藥 / 好伤药|', nq'|Hǎo Shāngyào / Hóu Sēungyeuhk|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dowsing Machine|', 1 , q'|A Key Item that can be used to detect hidden items.|', q'|Referred to as the Itemfinder prior to Generation IV and as the Dowsing MCHN in Pokémon HeartGold and SoulSilver and the Generation V games.|', nq'|ダウジングマシン|', nq'|Dowsing Machine|', nq'|Cherch'Objet|', nq'|Itemradar|', nq'|Ricerca Strumenti|', nq'|Zahorí|', nq'|다우징머신|', nq'|Dowsing Machine|', nq'|探寶器 / 探宝器|', nq'|Tànbǎo Qì / Taambóu Hei|', 1136 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Macho Brace|', 2 , q'|Raises Effort values but lowers Speed.|' , nq'|きょうせいギプス|', nq'|Kyōsei Gips|', nq'|Bracelet Macho|', nq'|Machoband|', nq'|Crescicappa|', nq'|Brazal Firme|', nq'|교정깁스|', nq'|Gyojeong Gips|', nq'|強制鍛鍊器 / 强制锻炼器|', nq'|Qiángzhì Duànliànqì / Kèuhngjai Dyunlihnhei|', 144 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Micle Berry|', 4 , q'|Raises a move's accuracy just once when HP is below ⅓ of maximum.|' , nq'|ミクルのみ|', nq'|Micle no Mi|', nq'|Baie Micle|', nq'|Wunfrubeere|', nq'|Baccaracolo|', nq'|Baya Lagro|', nq'|미클열매|', nq'|Micle Yeolmae|', nq'|奇秘果|', nq'|Qímì Guǒ / Kèihbīt Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Acro Bike|', 3 , q'|A bicycle with which the player can do tricks such as jump sideways.|' , nq'|ダートじてんしゃ|', nq'|Dirt Jitensha|', nq'|Vélo Cross|', nq'|Kunstrad|', nq'|Bici da cross|', nq'|Bici Acrobática|', nq'|더트자전거|', nq'|Dirt Jajeongeo|', nq'|越野自行車 / 越野自行车|', nq'|Yuèyě Zìxíngchē / Yuhtyéh Jihhàhngchē|', 32 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Gorgeous Box|', 2 , q'|Sometimes held by a reward Pokémon from Pokémon Stadium if traded to Generation II.|' , nq'|きりのはこ|', nq'|Kiri no Hako|', nq'|Coffre Luxe|', nq'|Schatulle|', nq'|Scat. Lusso|', nq'|Caja Grande|', nq'|오동나무상자|', nq'|Odongnamu Sangja|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|X Sp. Def 3|', 5 , q'|Drastically raises a Pokémon's Special Defense. Wonder Launcher only.|' , 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|N-Lunarizer|' , nq'|ネクロプラスルナ|', nq'|Necro Plus Luna|', nq'|Necroluna|', nq'|Necrolun|', nq'|Necrolunix|', nq'|Necroluna|', nq'|네크로플러스루나|', nq'|Necro Plus Luna|', nq'|奈克洛露奈合體器 / 奈克洛露奈合体器|', nq'|Nàikèluò Lùnài Hétǐqì / Noihhāklok Louhnoih Hahptáihei|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|TMs (50-100 different)|', 1 , q'|One-time use items that can teach moves to Pokémon.|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|MiracleBerry|', 2 , q'|Cures any status condition.|' , nq'|きせきのみ|', nq'|Kiseki no Mi|', nq'|Baie Miracle|', nq'|Wunderbeere|', nq'|Bacca Mirac.|', nq'|Baya Milagro|', nq'|기적의열매|', nq'|Gijeogui Yeolmae|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Manectite|', 6 , q'|Allows Manectric to Mega Evolve into Mega Manectric.|' , nq'|ライボルトナイト|', nq'|Livoltnite|', nq'|Élecsprintite|', nq'|Voltensonit|', nq'|Manectricite|', nq'|Manectricita|', nq'|썬더볼트나이트|', nq'|Thundervoltnite|', nq'|雷電獸進化石 / 雷电兽进化石|', nq'|Léidiànshòu Jìnhuà Shí / Lèuihdihnsau Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Poké Toy|', 5 , q'|Allows the player to flee from any battle with a wild Pokémon.|' , nq'|ポケじゃらし|', nq'|Poké Jarashi|', nq'|Poképlumet|', nq'|Pokéwedel|', nq'|Pokégingillo|', nq'|Pokéseñuelo|', nq'|포켓풀|', nq'|Pocket Pul|', nq'|寶可尾草 / 宝可尾草|', nq'|Bǎokě Wěicǎo / Bóuhó Méihchóu|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Rainbow Pass|', 3 , q'|Allows the player access to all of the Sevii Islands.|' , nq'|レインボーパス|', nq'|Rainbow Pass|', nq'|Passe Prisme|', nq'|Bunt-Pass|', nq'|Sette Pass|', nq'|Iris-Ticket|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Red Scale|', 2 , q'|Give to Mr. Pokémon for an Exp. Share.|' , nq'|あかいウロコ|', nq'|Akai Uroko|', nq'|Écaillerouge|', nq'|Rote Haut|', nq'|Squama Rossa|', nq'|Escama Roja|', nq'|빨간비늘|', nq'|Ppalgan Bineul|', nq'|紅色鱗片 / 红色鳞片|', nq'|Hóng-sè Línpiàn / Hùhng-sīk Lèuhnpin|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Adamant Orb|', 4 , q'|Boosts Dialga's Steel- and Dragon-type attacks.|' , nq'|こんごうだま|', nq'|Kongō Dama|', nq'|Orbe Adamant|', nq'|Adamant-Orb|', nq'|Adamasfera|', nq'|Diamansfera|', nq'|금강옥|', nq'|Geumgang Ok|', nq'|金剛寶珠 / 金刚宝珠|', nq'|Jīngāng Bǎozhū / Gāmgōng Bóujyū|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Up-Grade|', 2 , q'|A held item which allows Porygon to evolve when traded.|' , nq'|アップグレード|', nq'|Upgrade|', nq'|Améliorator|', nq'|Up-Grade|', nq'|Upgrade|', nq'|Mejora|', nq'|업그레이드|', nq'|Upgrade|', nq'|升級資料*|'||chr(10)||nq'|升级数据|', nq'|Shēngjí Zīliào / Sīngkāp Jīlíu*|'||chr(10)||nq'|Shēngjí Shùjù|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Professor's Mask|', 7 , q'|Returned to Professor Kukui at Malie Garden.|' , nq'|はかせのふくめん|', nq'|Hakase no Fukumen|', nq'|Masque du Prof|', nq'|Maske des Profs|', nq'|Maschera Prof.|', nq'|Máscara Profesor|', nq'|박사의복면|', nq'|Bagsaui Bogmyeon|', nq'|博士的面罩|', nq'|Bóshì-de Miànzhào / Boksih-dīk Mihnjaau|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lunalium Z|', 7 , q'|Allows Lunala and Dawn Wings Necrozma to upgrade Moongeist Beam to the special Z-Move Menacing Moonraze Maelstrom.|' , nq'|ルナアーラＺ|', nq'|Lunala-Z|', nq'|Lunazélite|', nq'|Lunalium Z|', nq'|Lunalium Z|', nq'|Lunalastal Z|', nq'|루나아라Z|', nq'|Lunala-Z|', nq'|露奈雅拉Ｚ|', nq'|Lùnàiyǎlā-Z / Louhnoihngáhlāai-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dropped Item|', 5 , q'|The Xtransceiver found at the Nimbasa City amusement park. It seems it belongs to a boy/girl.|' , nq'|わすれもの|', nq'|Forgotten Item|', nq'|Objet Trouvé|', nq'|Fundsache|', nq'|Oggetto Perso|', nq'|Obj. Perdido|', nq'|잊은물건|', nq'|Ijeun Mulgeon|', nq'|遺忘物 / 遗忘物|', nq'|Yíwàng Wù / Wàihmòhng Maht|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Moon Shard|', 3 , q'|Allows Eevee to evolve into Umbreon in Pokémon XD: Gale of Darkness.|' , nq'|つきのかけら|', nq'|Tsuki no Kakera|', nq'|Eclat Lune|', nq'|Mondsplitter|', nq'|Coccio Lunare|', nq'|Ápice Luna|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pokéblock Kit|', 6 , q'|Allows the player to make and store Pokéblocks.|' , nq'|ポロックキット|', nq'|Polock Kit|', nq'|Kit Pokébloc|', nq'|Pokériegel-Set|', nq'|Kit Pokémelle|', nq'|Kit de Pokécubos|', nq'|포켓몬스넥키트|', nq'|Pokémon Snack Kit|', nq'|寶可方塊組合*|'||chr(10)||nq'|宝可方块套装|', nq'|Bǎokě Fāngkuài Zǔhé / Bóuhó Fōngfaai Jóuhahp*|'||chr(10)||nq'|Bǎokě Fāngkuài Tàozhuāng|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pokéblock Case|', 3 , q'|Stores Pokéblocks.|' , nq'|ポロックケース|', nq'|Polock Case|', nq'|Boite Pokéblocs|', nq'|Pokériegel Box|', nq'|Porta Pokémelle|', nq'|Tubo PokéCubos|', nq'|포켓몬스넥케이스|', nq'|Pokémon Snack Case|', nq'|寶可方塊盒 / 宝可方块盒|', nq'|Bǎokě Fāngkuài Hé / Bóuhó Fōngfaai Hahp|', 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Roto PP Restore|' , nq'|ＰＰかいふくポン|', nq'|PP Kaifuku Pon|', nq'|Moti-Récup' PP|', nq'|AP-Bon|', nq'|PP'n'roll|', nq'|Cupón PP|', nq'| ???|', nq'| ???|', nq'|ＰＰ回復碰碰 /|'||chr(10)||nq'|ＰＰ回复碰碰|', nq'|PP Huífù Pèngpèng / PP Wùihfuhk Pungpung|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Disc Case|', 3 , q'|Holds Battle CDs.|' , nq'|ディスクケース|', nq'|Disc Case|', nq'|Boite Holog.|', nq'|CD-Box|', nq'|Porta-CD|', nq'|Caja Discos|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Grip Claw|', 4 , q'|Causes trapping moves (e.g. Bind, Wrap) to last for five turns.|' , nq'|ねばりのかぎづめ|', nq'|Nebari no Kagidzume|', nq'|Accro Griffe|', nq'|Griffklaue|', nq'|Presartigli|', nq'|Garra Garfio|', nq'|끈기갈고리손톱|', nq'|Kkeun-gi Galgori Sontop|', nq'|緊纏鈎爪 / 紧缠钩爪|', nq'|Jǐnchán Gōuzhuǎ / Gánchìhn Ngāujáau|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Dream Mail|', 3 , q'|To be held by a Pokémon for delivery.|' , nq'|ドリームメール|', nq'|Dream Mail|', nq'|Lettre Songe|', nq'|Traumbrief|', nq'|Mess. Sogno|', nq'|Carta Sueño|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Float Stone|', 5 , q'|Halves the weight of the holder.|' , nq'|かるいし|', nq'|Karuishi|', nq'|Pierrallégée|', nq'|Leichtstein|', nq'|Pietralieve|', nq'|Piedra Pómez|', nq'|가벼운돌|', nq'|Gabyeoun Dol|', nq'|輕石 / 轻石|', nq'|Qīngshí / Hīngsehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Ring Target|', 5 , q'|The holder loses its type immunities.|' , nq'|ねらいのまと|', nq'|Nerai no Mato|', nq'|Point de Mire|', nq'|Zielscheibe|', nq'|Facilsaglio|', nq'|Blanco|', nq'|겨냥표적|', nq'|Gyeonyang Pyojeok|', nq'|標靶 / 标靶|', nq'|Biāobǎ / Bīubá|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Protective Pads|', 7 , q'|Protects the holder from effects caused by using moves that make contact with the target.|' , nq'|ぼうごパット|', nq'|Bōgo Pad|', nq'|Pare-Effet|', nq'|Schutzpolster|', nq'|Smorzaurti|', nq'|Paracontacto|', nq'|방호패드|', nq'|Bangho Pad|', nq'|部位護具 / 部位护具|', nq'|Bùwèi Hùjù / Bouhwaih Wuhgeuih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Z-Power Ring|', 7 , q'|Allows the player to use Z-Moves when a Pokémon is holding an appropriate Z-Crystal. Allows the player to use Mega Evolution after obtaining a Key Stone when a Pokémon is holding the appropriate Mega Stone.|' , nq'|Ｚパワーリング|', nq'|Z Power Ring|', nq'|Super Bracelet Z|', nq'|Z-Kraftring|', nq'|Supercerchio Z|', nq'|Superpulsera Z|', nq'|Z파워링|', nq'|Z-Power Ring|', nq'|Ｚ強力手環 / Ｚ强力手环|', nq'|Z Qiánglì Shǒuhuán / Z Kèuhnglihk Sáuwàahn|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lunar Wing|', 4 , q'|Cures an endless nightmare.|' , nq'|みかづきのはね|', nq'|Mikadzuki no Hane|', nq'|Lun'Aile|', nq'|Lunarfeder|', nq'|Ala Lunare|', nq'|Pluma Lunar|', nq'|초승달날개|', nq'|Choseungdal Nalgae|', nq'|新月之羽|', nq'|Xīnyuè-zhī Yǔ / Sānyuht-jī Yúh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Kasib Berry|', 4 , q'|Lowers effectiveness of a super effective Ghost-type move.|' , nq'|カシブのみ|', nq'|Kasib no Mi|', nq'|Baie Sédra|', nq'|Zitarzbeere|', nq'|Baccacitrus|', nq'|Baya Drasi|', nq'|수불열매|', nq'|Subul Yeolmae|', nq'|佛柑果|', nq'|Fógān Guǒ / Fahtgām Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Icium Z|', 7 , q'|Allows a Pokémon to upgrade their Ice-type damaging moves to the Z-Move Subzero Slammer or upgrade their Ice-type status moves into Z-Moves. Makes Arceus an Ice-type Pokémon.|' , nq'|コオリＺ|', nq'|Ice-Z|', nq'|Cryozélite|', nq'|Glacium Z|', nq'|Glacium Z|', nq'|Criostal Z|', nq'|얼음Z|', nq'|Eol-eum-Z|', nq'|冰Ｚ|', nq'|Bīng-Z / Bīng-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Rare Bone|', 4 , q'|Can be sold for 5000.|' , nq'|きちょうなホネ|', nq'|Kichōna Hone|', nq'|Os Rare|', nq'|Steinknochen|', nq'|Osso Raro|', nq'|Hueso Raro|', nq'|귀중한뼈|', nq'|Gwijunghan Ppyeo|', nq'|貴重骨頭 / 贵重骨头|', nq'|Guìzhòng Gǔtou / Gwaijuhng Gwāttàuh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Metal Coat|', 2 , q'|Raises the power of Steel-type moves. Allows Onix and Scyther to evolve when traded.|' , nq'|メタルコート|', nq'|Metal Coat|', nq'|Peau Metal|', nq'|Metallmantel|', nq'|Metalcoperta|', nq'|Revest. Metálico|', nq'|금속코트|', nq'|Geumsok Coat|', nq'|金屬膜 / 金属膜|', nq'|Jīnshǔ Mó / Gāmsuhk Mohk|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Adventure Rules|', 6 , q'|Contains information new Trainers should know.|' , nq'|たんけんこころえ|', nq'|Tanken Kokoroe|', nq'|ABC Aventure|', nq'|Abenteuerfibel|', nq'|Guida Avventura|', nq'|Guía de Máximas|', nq'|탐험수칙|', nq'|Tamheom Suchig|', nq'|探險心得 / 探险心得|', nq'|Tànxiǎn Xīndé / Taamhím Sāmdāk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Magmarizer|', 4 , q'|A held item that allows Magmar to evolve when traded.|' , nq'|マグマブースター|', nq'|Magma Booster|', nq'|Magmariseur|', nq'|Magmaisierer|', nq'|Magmatore|', nq'|Magmatizador|', nq'|마그마부스터|', nq'|Magma Booster|', nq'|熔岩增幅器|', nq'|Róngyán Zēngfú Qì / Yùhngngàahm Jāngfūk Hei|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Soft Sand|', 2 , q'|Raises the power of Ground-type moves.|' , nq'|やわらかいすな|', nq'|Yawarakai Suna|', nq'|Sable Doux|', nq'|Pudersand|', nq'|Sabbia Soffice|', nq'|Arena Fina|', nq'|부드러운모래|', nq'|Budeureoun Morae|', nq'|柔軟沙子 / 柔软沙子|', nq'|Róuruǎn Shāzi / Yàuhyúhn Sājí|', 32 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dark Stone|', 5 , q'|Stone used to summon Zekrom.|' , nq'|ダークストーン|', nq'|Dark Stone|', nq'|Galet Noir|', nq'|Dunkelstein|', nq'|Scurolite|', nq'|Orbe Oscuro|', nq'|다크스톤|', nq'|Dark Stone|', nq'|黑闇石 / 黑暗石|', nq'|Hēi'àn Shí / Hākam Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Nest Ball|', 3 , q'|A type of Poké Ball that works better on low-level Pokémon.|' , nq'|ネストボール|', nq'|Nest Ball|', nq'|Faiblo Ball|', nq'|Nestball|', nq'|Minor Ball|', nq'|Nido Ball|', nq'|네스트볼|', nq'|Nest Ball|', nq'|巢穴球|', nq'|Cháoxuè Qiú / Chàauhyuht Kàuh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Unown Report|', 4 , q'|Lists the caught Unown forms. Replaces the Unown Mode of Generation II.|' , nq'|アンノーンノート|', nq'|Unknown Note|', nq'|Carnet Zarbi|', nq'|Icognitoheft|', nq'|UnownBloc|', nq'|Bloc Unown|', nq'|안농노트|', nq'|Annong Note|', nq'|未知圖騰筆記 / 未知图腾笔记|', nq'|Wèizhītúténg Bǐjì / Meihjītòuhtàhng Bātgei|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Apricorn Box|', 4 , q'|Contains Apricorns.|' , nq'|ぼんぐりケース|', nq'|Bonguri Case|', nq'|Bte Noigrume|', nq'|Aprikokobox|', nq'|Ghicobox|', nq'|Caja Bonguri|', nq'|규토리케이스|', nq'|Gyutori Case|', nq'|球果盒|', nq'|Qiúguǒ Hé / Kàuhgwó Hahp|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Red Nectar|', 7 , q'|Changes Oricorio to its Baile Style.|' , nq'|くれないのミツ|', nq'|Kurenai no Mitsu|', nq'|Nectar Rouge|', nq'|Roter Nektar|', nq'|Nettare rosso|', nq'|Néctar Rojo|', nq'|다홍꿀|', nq'|Dahong Kkul|', nq'|朱紅色花蜜|', nq'|Zhūhóng-sè Huāmì / Jyūhùhng-sīk Fāmaht|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Pink Bow|', 2 , q'|Raises the power of Normal-type moves.|' , nq'|ピンクのリボン|', nq'|Pink no Ribbon|', nq'|Ruban Rose|', nq'|Rosa Band|', nq'|Fiocco Rosa|', nq'|Lazo Rosa|', nq'|핑크빛리본|', nq'|Pink-bit Ribon|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Awakening|', 1 , q'|Awakens a sleeping Pokémon.|' , nq'|ねむけざまし|', nq'|Nemuke Zamashi|', nq'|Reveil|', nq'|Aufwecker|', nq'|Sveglia|', nq'|Despertar|', nq'|잠깨는약|', nq'|Jam Kkaeneun Yak|', nq'|解眠藥 / 解眠药|', nq'|Jiěmiányào / Gáaimìhnyeuhk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Red Card|', 5 , q'|Forces the opponent to switch to a random Pokémon when the holder is hit by a contact move. Consumed after use.|' , nq'|レッドカード|', nq'|Red Card|', nq'|Carton Rouge|', nq'|Rote Karte|', nq'|Cartelrosso|', nq'|Tarjeta Roja|', nq'|레드카드|', nq'|Red Card|', nq'|紅牌 / 红牌|', nq'|Hóngpái / Hùhngpáai|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Key to Room 6|', 6 , q'|Opens Room 6 of the Abandoned ShipRSE/Sea MauvilleORAS.|', q'|Called Rm. 6 Key in Generation III.|', nq'|ろくごうしつのカギ|', nq'|Roku-gō Shitsu no Kagi|', nq'|Clé Salle 6|', nq'|R6-Schlüssel|', nq'|Chiave stanza 6|', nq'|Ll. Habitación 6|', nq'|육호실열쇠|', nq'|Yuk-hosil Yeolsoe|', nq'|６號客房的鑰匙 /|'||chr(10)||nq'|６号客房的钥匙|', nq'|6 Hào Kèfáng-de Yàoshi / 6 Houh Haakfóng-dīk Yeuhksìh|', 1616 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dark Memory|', 7 , q'|Makes Silvally a Dark-type Pokémon and makes Multi-Attack a Dark-type move.|' , nq'|ダークメモリ|', nq'|Dark Memory|', nq'|ROM Ténèbres|', nq'|Unlicht-Disc|', nq'|ROM Buio|', nq'|Disco Siniestro|', nq'|다크메모리|', nq'|Dark Memory|', nq'|黑暗記憶碟*|'||chr(10)||nq'|黑暗存储碟|', nq'|Hēi'àn Jìyìdié / Hāk'am Geiyīkdihp*|'||chr(10)||nq'|Hēi'àn Cúnchǔdié|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Grepa Berry|', 3 , q'|Raises friendship, but lowers Special Defense EVs.|' , nq'|ウブのみ|', nq'|Ubu no Mi|', nq'|Baie Resin|', nq'|Labrusbeere|', nq'|Baccauva|', nq'|Baya Uvav|', nq'|또뽀열매|', nq'|Ttoppo Yeolmae|', nq'|萄葡果|', nq'|Táopú Guǒ / Tòuhpòuh Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|King's Rock|', 2 , q'|Slightly increases the chances of inflicting the Flinch condition on the opponent. Allows Slowpoke and Poliwhirl to evolve when traded.|' , nq'|おうじゃのしるし|', nq'|Ōja no Shirushi|', nq'|Roche Royale|', nq'|King-Stein|', nq'|Roccia Di Re|', nq'|Roca del Rey|', nq'|왕의징표석|', nq'|Wang-ui Jingpyoseok|', nq'|王者之證 / 王者之证|', nq'|Wángzhě-zhī Zhèng / Wòhngjé-jī Jing|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Krane Memo 3|', 3 , q'|Contains information about the Snag Machine.|' , nq'|クレインメモ３|', nq'|Krane Memo 3|', nq'|Memo Syrus 3|', nq'|Klein-Memo 3|', nq'|Appunti 3|', nq'|Parte Cío 3|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Absorb Bulb|', 5 , q'|Raises the holder's Special Attack after being hit by a Water-type attack. Consumed after use.|' , nq'|きゅうこん|', nq'|Kyūkon|', nq'|Bulbe|', nq'|Knolle|', nq'|Bulbo|', nq'|Tubérculo|', nq'|구근|', nq'|Gugeun|', nq'|球根|', nq'|Qiúgēn / Kàuhgān|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Deep Sea Tooth|', 3 , q'|A hold item that allows Clamperl to evolve into Huntail when traded.|', q'|Formatted as DeepSeaTooth prior to Generation VI.|', nq'|しんかいのキバ|', nq'|Shinkai no Kiba|', nq'|Dent Océan|', nq'|Abysszahn|', nq'|Dente Abissi|', nq'|Diente Marino|', nq'|심해의이빨|', nq'|Simhae-ui Ippal|', nq'|深海之牙|', nq'|Shēnhǎi-zhī Yá / Sāmhói-jī Ngàh|', 1056 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Reveal Glass|', 5 , q'|A glass that tells the truth. It is a mysterious glass that returns a Pokémon back to its original shape.|' , nq'|うつしかがみ|', nq'|Reflecting Mirror|', nq'|Miroir Sacré|', nq'|Wahrspiegel|', nq'|Verispecchio|', nq'|Espejo Veraz|', nq'|비추는거울|', nq'|Bichu-neun Geoul|', nq'|現形鏡 / 现形镜|', nq'|Xiànxíng Jìng / Yihnyìhng Geng|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Polkadot Bow|', 2 , q'|Raises the power of Normal-type moves.|' , nq'|みずたまりボン|', nq'|Mizutama Ribbon|', nq'|Ruban à Pois|', nq'|Punkt-Band|', nq'|Fiocco Pois|', nq'|Cintalunares|', nq'|물방울리본|', nq'|Mulbang-ul Ribon|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Fresh Water|', 1 , q'|Restores 30 HP. (50HP before Gen. VII).|' , nq'|おいしいみず|', nq'|Oishii Mizu|', nq'|Eau Fraiche|', nq'|Tafelwasser|', nq'|Acqua Fresca|', nq'|Agua Fresca|', nq'|맛있는물|', nq'|Masinneun Mul|', nq'|美味之水|', nq'|Měiwèi-zhī Shuǐ / Méihmeih-jī Séui|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Swampertite|', 6 , q'|Allows Swampert to Mega Evolve into Mega Swampert.|' , nq'|ラグラージナイト|', nq'|Laglargenite|', nq'|Laggronite|', nq'|Sumpexnit|', nq'|Swampertite|', nq'|Swampertita|', nq'|대짱이나이트|', nq'|Daejjanginite|', nq'|巨沼怪進化石 / 巨沼怪进化石|', nq'|Jùzhǎoguài Jìnhuà Shí / Geuihjíugwaai Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Max Ether|', 1 , q'|Restores all the PP of a single move.|' , nq'|ピーピーリカバー|', nq'|PP Recover|', nq'|Huile Max|', nq'|Top-Äther|', nq'|Etere Max|', nq'|Éter Máximo|', nq'|PP회복|', nq'|PP Hoebok|', nq'|ＰＰ單項全補劑 / ＰＰ单项全补剂|', nq'|PP Dānxiàng Quánbǔjì / PP Dāanhohng Chyùhnbóujaih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Sun Shard|', 3 , q'|Allows Eevee to evolve into Espeon.|' , nq'|たいようのかけら|', nq'|Taiyō no Kakera|', nq'|Eclat Soleil|', nq'|Sonnsplitter|', nq'|Coccio Solare|', nq'|Ápice Sol|' , 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Rule Book|' , nq'|ルールブック|', nq'|Rule Book|', nq'|Livre Règles|', nq'|Regelbuch|', nq'|Libro Regole|', nq'|Reglamento|', nq'|룰북|', nq'|Rule Book|', nq'|規則書 / 规则书|', nq'|Guīzé Shū / Kwāijāk Syū|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Shoal Shell|', 3 , q'|Can be used to make a Shell Bell. Does not have any use in Generation IV. Can be sold to an item maniac in Route 5 for 7000 in Generation V.|' , nq'|あさせのかいがら|', nq'|Asase no Kaigara|', nq'|CoquilleTréfonds|', nq'|Küstenschale|', nq'|Gusciondoso|', nq'|Concha Cardumen|', nq'|여울조개껍질|', nq'|Yeoul Jogaekkeopjil|', nq'|淺灘貝殼 / 浅滩贝壳|', nq'|Qiǎntān Bèiké / Chíntāan Buihok|', 144 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|X Special 3|', 5 , q'|Drastically raises a Pokémon's Special Attack. Wonder Launcher only.|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Surprise Mulch|', 6 , q'|When applied to a Berry patch, increases the chance of Berry mutation.|' , nq'|びっくりこやし|', nq'|Bikkuri Koyashi|', nq'|Fertistantané|', nq'|Wundermulch|', nq'|Fertilsorpresa|', nq'|Abono Sorpresa|', nq'|깜놀비료|', nq'|Kkamnol Biryo|', nq'|吃驚肥 / 吃惊肥|', nq'|Chījīng Féi / Hekgīng Fèih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Buginium Z|', 7 , q'|Allows a Pokémon to upgrade their Bug-type damaging moves to the Z-Move Savage Spin-Out or upgrade their Bug-type status moves into Z-Moves. Makes Arceus a Bug-type Pokémon.|' , nq'|ムシＺ|', nq'|Bug-Z|', nq'|Insectozélite|', nq'|Insectium Z|', nq'|Insectium Z|', nq'|Insectostal Z|', nq'|벌레Z|', nq'|Beolle-Z|', nq'|蟲Ｚ / 虫Ｚ|', nq'|Chóng-Z / Chùhng-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Voice Case 2|', 3 , q'|Heals a Poochyena in Agate Village.|' , nq'|こえカプセル２|', nq'|Koe Capsule 2|', nq'|Boite Cri 2|', nq'|Stimmbox 2|', nq'|Disco Verso 2|', nq'|Grabación 2|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|X Defense|', 1 , q'|Raises a Pokémon's Defense by 2 stages (1 stage before Gen. VII).|', q'|Called X Defend prior to Generation VI.|', nq'|ディフェンダー|', nq'|Defender|', nq'|Defense +|', nq'|X-Abwehr|', nq'|Difesa X|', nq'|Defensa X|', nq'|디펜드업|', nq'|Defend-Up|', nq'|防禦強化 / 防御强化|', nq'|Fángyù Qiánghuà / Fòhngyuh Kèuhngfa|', 1024 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Mega Bracelet|' , nq'|メガバングル|', nq'|Mega Bangle|', nq'|Méga-Bracelet|', nq'|Mega-Armreife|', nq'|Megabracciale|', nq'|Megapulsera|', nq'|메가뱅글|', nq'|Mega Bangle|', nq'|超級手鐲 / 超级手镯|', nq'|Chāojí Shǒuzhuó / Chīukāp Sáujuhk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|TMV Pass|', 6 , q'|Allows the player to ride the TMV and access Kiloude City.|' , nq'|TMVパス|', nq'|TMV Pass|', nq'|Passe TMV|', nq'|TMV-Pass|', nq'|Pass TMV|', nq'|Abono del TMV|', nq'|TMV패스|', nq'|TMV Pass|', nq'|ＴＭＶ自由票|', nq'|TMV Zìyóu Piào / TMV Jihyàuh Piu|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Hard Stone|', 2 , q'|Raises the power of Rock-type moves.|' , nq'|かたいいし|', nq'|Katai Ishi|', nq'|Pierre Dure|', nq'|Granitstein|', nq'|Pietradura|', nq'|Piedra Dura|', nq'|딱딱한돌|', nq'|Ttakttakhan Dol|', nq'|硬石頭 / 硬石头|', nq'|Yìng Shítou / Ngaahng Sehktàuh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Metronome|', 4 , q'|Raises power of moves used in a row.|' , nq'|メトロノーム|', nq'|Metronome|', nq'|Métronome|', nq'|Metronom|', nq'|Plessimetro|', nq'|Metrónomo|', nq'|메트로놈|', nq'|Metronome|', nq'|節拍器 / 节拍器|', nq'|Jiépāiqì / Jitpaakhei|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Mental Herb|', 3 , q'|Prevents attraction. Consumed after use.|' , nq'|メンタルハーブ|', nq'|Mental Herb|', nq'|Herbe Mental|', nq'|Mentalkraut|', nq'|Mentalerba|', nq'|Hierba Mental|', nq'|멘탈허브|', nq'|Mental Herb|', nq'|心靈香草 / 心灵香草|', nq'|Xīnlíng Xiāngcǎo / Sāmlìhng Hēungchóu|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|Oak's Parcel|', 1 , q'|Deliver to Professor Oak to receive a Pokédex.|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Gold Teeth|', 1 , q'|Safari Zone Warden's false teeth. Return for HM04 (Strength)|' , nq'|きんのいれば|', nq'|Kin no Ireba|', nq'|Dent D'or|', nq'|Goldzähne|', nq'|Denti d’Oro|', nq'|Dientes Oro|', nq'|금틀니|', nq'|Geum Teulli|', nq'|金假牙|', nq'|Jīn Jǐayá / Gām Gángàh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Jaboca Berry|', 4 , q'|If the foe's physical move hits, then the foe will also take damage.|' , nq'|ジャポのみ|', nq'|Japo no Mi|', nq'|Baie Jacoba|', nq'|Jabocabeere|', nq'|Baccajaba|', nq'|Baya Jaboca|', nq'|자보열매|', nq'|Jabo Yeolmae|', nq'|嘉珍果|', nq'|Jiāzhēn Guǒ / Gājān Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Super Repel|', 1 , q'|Prevents wild Pokémon with a lower level than the first member of the party from appearing for 200 steps|' , nq'|シルバースプレー|', nq'|Silver Spray|', nq'|Superepousse|', nq'|Superschutz|', nq'|Superrepellente|', nq'|Superrepelente|', nq'|실버스프레이|', nq'|Silver Spray|', nq'|白銀噴霧 / 白银喷雾|', nq'|Báiyín Pēnwù / Baahkngàhn Panmouh|', 48 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Health Wing|', 5 , q'|Raises the HP of a Pokémon.|' , nq'|たいりょくのハネ|', nq'|Tairyoku no Hane|', nq'|Aile Santé|', nq'|Heilfeder|', nq'|Piumsalute|', nq'|Pluma Vigor|', nq'|체력날개|', nq'|Cheryeok Nalgae|', nq'|體力之羽 / 体力之羽|', nq'|Tǐlì-zhī Yǔ / Táilihk-jī Yúh|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Durin Berry|', 3 , q'|Poffin and Pokéblock ingredient.|' , nq'|ドリのみ|', nq'|Dori no Mi|', nq'|Baie Durin|', nq'|Durinbeere|', nq'|Baccadurian|', nq'|Baya Rudion|', nq'|두리열매|', nq'|Duri Yeolmae|', nq'|金枕果|', nq'|Jīnzhěn Guǒ / Gāmjám Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Belue Berry|', 3 , q'|Poffin and Pokéblock ingredient.|' , nq'|ベリブのみ|', nq'|Beribu no Mi|', nq'|Baie Myrte|', nq'|Myrtilbeere|', nq'|Baccartillo|', nq'|Baya Andano|', nq'|루베열매|', nq'|Luebe Yeolmae|', nq'|靛莓果|', nq'|Diànméi Guǒ / Dihnmùih Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Beast Ball|', 7 , q'|Allows the player to catch wild Pokémon; works better on Ultra Beasts.|' , nq'|ウルトラボール|', nq'|Ultra Ball|', nq'|Ultra Ball|', nq'|Ultraball|', nq'|UC Ball|', nq'|Ente Ball|', nq'|울트라볼|', nq'|Ultra Ball|', nq'|究極球 / 究极球|', nq'|Jiūjí Qiú / Gaugihk Kàuh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Sachet|', 6 , q'|Allows Spritzee to evolve when traded.|' , nq'|においぶくろ|', nq'|Nioi Bukuro|', nq'|Sachet Senteur|', nq'|Duftbeutel|', nq'|Bustina Aromi|', nq'|Saquito Fragante|', nq'|향기주머니|', nq'|Hyang-gi Jumeoni|', nq'|香袋|', nq'|Xiāngdài / Hēungdoih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Reset Urge|', 5 , q'|Eliminates stat changes from an ally Pokémon. Wonder Launcher only.|' , nq'|フラットコール|', nq'|Flat Call|', nq'|Réamorçage|', nq'|Umkehrappell|', nq'|Ripristino|', nq'|Quitaestado|', nq'|플랫콜|', nq'|Flat Call|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Spelon Berry|', 3 , q'|Pokéblock and Poffin ingredient.|' , nq'|ノワキのみ|', nq'|Nowaki no Mi|', nq'|Baie Kiwan|', nq'|Kiwanbeere|', nq'|Baccamelos|', nq'|Baya Wikano|', nq'|메호키열매|', nq'|Mehoki Yeolmae|', nq'|刺角果|', nq'|Cìjiǎo Guǒ / Chigok Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Salac Berry|', 3 , q'|Raises Speed when HP is below ⅓ of maximum.|' , nq'|カムラのみ|', nq'|Camula no Mi|', nq'|Baie Sailak|', nq'|Salkabeere|', nq'|Baccasalak|', nq'|Baya Aslac|', nq'|캄라열매|', nq'|Kamra Yeolmae|', nq'|沙鱗果 / 沙鳞果|', nq'|Shālín Guǒ / Sālèuhn Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Guard Spec.|', 1 , q'|Temporarily prevents stat reduction.|' , nq'|エフェクトガード|', nq'|Effect Guard|', nq'|Defense Spec|', nq'|Megablock|', nq'|Superguardia|', nq'|Protec. Esp.|', nq'|이펙트가드|', nq'|Effect Guard|', nq'|能力防守|', nq'|Nénglì Fángshǒu / Nàhnglihk Fòhngsáu|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Max Revive|', 1 , q'|Revives a Pokémon to full health.|' , nq'|げんきのかたまり|', nq'|Genki no Katamari|', nq'|Rappel Max|', nq'|Top-Beleber|', nq'|Revitalizz. Max|', nq'|Revivir Máximo|', nq'|기력의덩어리|', nq'|Giryeog-ui Deong-eori|', nq'|活力塊 / 活力块|', nq'|Huólì Kuài / Wuhtlihk Faai|', 48 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|X Special 2|', 5 , q'|Sharply raises a Pokémon's Special Attack. Wonder Launcher only.|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Bonsly Card|', 3 , q'|Allows play of the card in Battle Bingo.|' , nq'|ウソハチシート|', nq'|Usohachi Sheet|', nq'|Carte Manzai|', nq'|Mobai-Karte|', nq'|Scheda Bonsly|', nq'|Cart. Bonsly|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Gooey Mulch|', 4 , q'|Increases the number of times new Berry plants can grow where old ones withered.|' , nq'|ねばねばこやし|', nq'|Nebaneba Koyashi|', nq'|Fertiglu|', nq'|Neumulch|', nq'|Fertilcolla|', nq'|Abono Brote|', nq'|끈적끈적비료|', nq'|Kkeunjeok-kkeunjeok Biryo|', nq'|黏黏肥 / 粘粘肥|', nq'|Niánnián Féi / Nīmnīm Fèih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Earth Plate|', 4 , q'|Raises the power of Ground-type moves.|' , nq'|だいちのプレート|', nq'|Daichi no Purēto|', nq'|Plaque Terre|', nq'|Erdtafel|', nq'|Lastrageo|', nq'|Tabla Terrax|', nq'|대지플레이트|', nq'|Daeji Plate|', nq'|大地石板|', nq'|Dàdì Shíbǎn / Daaihdeih Sehkbáan|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Never-Melt Ice|', 2 , q'|Raises the power of Ice-type moves.|', q'|Formatted as NeverMeltIce prior to Generation VI.|', nq'|とけないこおり|', nq'|Tokenai Kōri|', nq'|Glace Éternelle|', nq'|Ewiges Eis|', nq'|Gelomai|', nq'|Antiderretir|', nq'|녹지않는얼음|', nq'|Nokji Anneun Eoreum|', nq'|不融冰|', nq'|Bù Róng Bīng / Bāt Yùhng Bīng|', 1152 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|Shiny Leaf|', 4 , q'|Note: Can only be held by Pokémon and found on certain tiles in certain areas by checking the Pokémon that follows the player. No guarantee that the player can find it even in the right place.|' , 2048 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Strange Souvenir|', 6 , q'|Currently has no use.|' , nq'|ふしぎなおきもの|', nq'|Fushigina Okimono|', nq'|Bibelot Bizarre|', nq'|Skurriloskulptur|', nq'|Strano ninnolo|', nq'|Estatuilla Rara|', nq'|이상한장식품|', nq'|Isanghae Jangsikpum|', nq'|神秘擺設 / 神秘摆设|', nq'|Shénmì Bǎishè / Sàhnbei Báaichit|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|DNA Splicers|', 5 , q'|Combines and separates Kyurem with Reshiram or Zekrom, transforming them into White Kyurem or Black Kyurem, respectively.|' , nq'|いでんしのくさび|', nq'|Gene Wedge|', nq'|Pointeau ADN|', nq'|DNS-Keil|', nq'|Cuneo DNA|', nq'|Punta ADN|', nq'|유전자쐐기|', nq'|Yujeonja Swae-gi|', nq'|基因之楔|', nq'|Jīyīn-zhī Xiē / Gēiyān-jī Sit|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Bug Gem|', 5 , q'|Increases the power of the holder's first Bug-type move by 50%, and is consumed after use.|' , nq'|むしのジュエル|', nq'|Mushi no Jewel|', nq'|Joyau Insecte|', nq'|Käferjuwel|', nq'|Bijoucoleottero|', nq'|Gema Bicho|', nq'|벌레주얼|', nq'|Beolle Jewel|', nq'|蟲之寶石 / 虫之宝石|', nq'|Chóng-zhī Bǎoshí / Chùhng-jī Bóusehk|', 176 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Coba Berry|', 4 , q'|Reduces damage from a super effective Flying-type move by 50%.|' , nq'|バコウのみ|', nq'|Baco no Mi|', nq'|Baie Cobaba|', nq'|Kobabeere|', nq'|Baccababa|', nq'|Baya Kouba|', nq'|바코열매|', nq'|Baco Yeolmae|', nq'|棱瓜果|', nq'|Léngguā Guǒ / Lìhnggwā Gwó|', 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Roto Boost|' , nq'|おうえんポン|', nq'|Ōen Pon|', nq'|Moti-Soutien|', nq'|Statuswertebon|', nq'|Stat'n'roll|', nq'|Cupón Refuerzo|', nq'| ???|', nq'| ???|', nq'|加油碰碰|', nq'|Jiāyóu Pèngpèng / Gāyáu Pungpung|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Devon Parts|', 3 , q'|To be delivered to Captain Stern.|', q'|Called Devon Goods in Generation III.|', nq'|デボンのにもつ|', nq'|Devon no Nimotsu|', nq'|Pack Devon|', nq'|Devon-Waren|', nq'|Merce Devon|', nq'|Piezas Devon|', nq'|데봉화물|', nq'|Devon Hwamul|', nq'|得文的物品|', nq'|Déwén-de Wùpǐn / Dākmàhn-dīk Mahtbán|', 1024 );
insert into ITEMS( NAME, GEN, GEN2, DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Elevator Key|', 3, 6, q'|Unlocks the elevator in Pyrite Bldg giving the player access to The Under and Prestige Precept Center's elevator (3) and activates the elevator in Lysandre Labs (6).|' , nq'|エレベーターキー|'||chr(10)||nq'|エレベーターのキー|', nq'|Elevator Key|'||chr(10)||nq'|Elevator no Key|', nq'|Cle Ascens.*|'||chr(10)||nq'|Clé Ascenseur|', nq'|Liftkarte*|'||chr(10)||nq'|Liftschlüssel|', nq'|Chiave Asc.|'||chr(10)||nq'|Chiave ascensore|', nq'|Ll. Ascensor|'||chr(10)||nq'|Llave Ascensor|', nq'|엘리베이터키|', nq'|Elevator Key|', nq'|電梯鑰匙 / 电梯钥匙|', nq'|Diàntī Yàoshi / Dihntāi Yeuhksìh|', 192 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Brick Piece|', 2 , q'|Can be sold for 50.|' , nq'|かわらのかけら|', nq'|Kawara no Kakera|', nq'|Morc. Brique|', nq'|Ziegelstein|', nq'|Mattoncino|', nq'|Ladrillo|', nq'|기와조각|', nq'|Giwa Jogak|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Ghost Gem|', 5 , q'|Increases the power of the holder's first Ghost-type move by 50%, and is consumed after use.|' , nq'|ゴーストジュエル|', nq'|Ghost Jewel|', nq'|Joyau Spectre|', nq'|Geisterjuwel|', nq'|Bijouspettro|', nq'|Gema Fantasma|', nq'|고스트주얼|', nq'|Ghost Jewel|', nq'|幽靈寶石 / 幽灵宝石|', nq'|Yōulíng Bǎoshí / Yāulìhng Bóusehk|', 208 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Thanks Mail|', 5 , q'|Stationary designed for a thank you note. To be held by a Pokémon for delivery.|' , nq'|かんしゃメール|', nq'|Kansha Mail|', nq'|Lettre Merci|', nq'|Dankesbrief|', nq'|Mess. Grazie|', nq'|C. Gracias|', nq'|감사메일|', nq'|Gamsa Mail|', nq'|感謝郵件 / 感谢邮件|', nq'|Gǎnxiè Yóujiàn / Gámjeh Yàuhgín|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Aggronite|', 6 , q'|Allows Aggron to Mega Evolve into Mega Aggron.|' , nq'|ボスゴドラナイト|', nq'|Bossgodoranite|', nq'|Galekingite|', nq'|Stollossnit|', nq'|Aggronite|', nq'|Aggronita|', nq'|보스로라나이트|', nq'|Bosroranite|', nq'|波士可多拉進化石 / 波士可多拉进化石|', nq'|Bōshìkěduōlā Jìnhuà Shí / Bōsihhódōlāai Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Whipped Dream|', 6 , q'|Allows Swirlix to evolve when traded.|' , nq'|ホイップポップ|', nq'|Whip Pop|', nq'|Chantibonbon|', nq'|Sahnehäubchen|', nq'|Dolcespuma|', nq'|Dulce de Nata|', nq'|휘핑팝|', nq'|Whipping Pop|', nq'|泡沫奶油|', nq'|Pàomò nǎiyóu / Póuhmuht Náaihyàuh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|X Sp. Def|', 2 , q'|Raises a Pokémon's Special Defense by 2 stages (1 stage before Gen. VII).|' , nq'|スペシャルガード|', nq'|Special Guard|', nq'|Def. Spé. +|', nq'|X-Spezial-Vert.|', nq'|Dif. Sp. X|', nq'|Def. Esp. X|', nq'|스페셜가드|', nq'|Special Guard|', nq'|特防強化 / 特防强化|', nq'|Tèfáng Qiánghuà / Dahkfòhng Kèuhngfa|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Mach Bike|', 3 , q'|A speedy bike that can even go up muddy slopes. It is harder to control than the Acro Bike, and cannot do tricks.|' , nq'|マッハじてんしゃ|', nq'|Mach Jitensha|', nq'|Vélo de Course|', nq'|Eilrad|', nq'|Bici da corsa|', nq'|Bici de Carreras|', nq'|마하자전거|', nq'|Mach Jajeongeo|', nq'|音速自行車 / 音速自行车|', nq'|Yīnsù Zìxíngchē / Yāmchūk Jihhàhngchē|', 176 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Poké Ball|', 1 , q'|A ball used to catch Pokémon.|' , nq'|モンスターボール|', nq'|Monster Ball|', nq'|Poké Ball|', nq'|Pokéball|', nq'|Poké Ball|', nq'|Poké Ball|', nq'|몬스터볼|', nq'|Monster Ball|', nq'|精靈球 / 精灵球|', nq'|Jīnglíng Qiú / Jīnglìhng Kàuh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Repeat Ball|', 3 , q'|A type of Poké Ball that works better on Pokémon already caught before.|' , nq'|リピートボール|', nq'|Repeat Ball|', nq'|Bis Ball|', nq'|Wiederball|', nq'|Bis Ball|', nq'|Acopio Ball|', nq'|리피드볼|', nq'|Ripideu Ball|', nq'|重複球 / 重复球|', nq'|Chóngfù Qiú / Chùhngfūk Kàuh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Expert Belt|', 4 , q'|Increases the power of super effective moves.|' , nq'|たつじんのおび|', nq'|Tatsujin no Obi|', nq'|Ceinture Pro|', nq'|Expertengurt|', nq'|Abilcintura|', nq'|Cinta Experto|', nq'|달인의띠|', nq'|Darinui Tti|', nq'|達人帶 / 达人带|', nq'|Dárén Dài / Daahtyàhn Daai|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dread Plate|', 4 , q'|Raises the power of Dark-type moves.|' , nq'|こわもてプレート|', nq'|Kowamote Purēto|', nq'|Plaque Ombre|', nq'|Furchttafel|', nq'|Lastratimore|', nq'|Tabla Oscura|', nq'|공포플레이트|', nq'|Gongpo Plate|', nq'|惡顏石板 / 恶颜石板|', nq'|È'yán Shíbǎn / Okngàahn Sehkbáan|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pink Nectar|', 7 , q'|Changes Oricorio to its Pa'u Style.|' , nq'|うすもものミツ|', nq'|Usumomo no Mitsu|', nq'|Nectar Rose|', nq'|Rosa Nektar|', nq'|Nettare rosa|', nq'|Néctar Rosa|', nq'|연분홍꿀|', nq'|Yeonbunhong Kkul|', nq'|桃粉色花蜜|', nq'|Táofěn-sè Huāmì / Tòuhfán-sīk Fāmaht|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Tyranitarite|', 6 , q'|Allows Tyranitar to Mega Evolve into Mega Tyranitar.|' , nq'|バンギラスナイト|', nq'|Bangirasnite|', nq'|Tyranocivite|', nq'|Despotarnit|', nq'|Tyranitarite|', nq'|Tyranitarita|', nq'|마기라스나이트|', nq'|Magirasnite|', nq'|班基拉斯進化石 / 班基拉斯进化石|', nq'|Bānjīlāsī Jìnhuà Shí / Bāangēilāaisī Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Rose Incense|', 4 , q'|Raises the power of Grass-type moves. Roselia and Roserade holding this can breed Budew.|' , nq'|おはなのおこう|', nq'|Ohana no Okō|', nq'|Encens Fleur|', nq'|Rosenrauch|', nq'|Rosaroma|', nq'|Incienso floral|', nq'|꽃향로|', nq'|Kkoch Hyangno|', nq'|花朵薰香|', nq'|Huāduǒ Xūnxiāng / Fādó Fānhēung|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Latiasite|', 6 , q'|Allows Latias to Mega Evolve into Mega Latias.|' , nq'|ラティアスナイト|', nq'|Latiasnite|', nq'|Latiasite|', nq'|Latiasnit|', nq'|Latiasite|', nq'|Latiasita|', nq'|라티아스나이트|', nq'|Latiasnite|', nq'|拉帝亞斯進化石 / 拉帝亚斯进化石|', nq'|Lādìyāsī Jìnhuà Shí / Lāaidai'asī Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Rockium Z|', 7 , q'|Allows a Pokémon to upgrade their Rock-type damaging moves to the Z-Move Continental Crush or upgrade their Rock-type status moves into Z-Moves. Makes Arceus a Rock-type Pokémon.|' , nq'|イワＺ|', nq'|Rock-Z|', nq'|Rocazélite|', nq'|Petrium Z|', nq'|Petrium Z|', nq'|Litostal Z|', nq'|바위Z|', nq'|Bawi-Z|', nq'|岩石Ｚ|', nq'|Yánshí-Z / Ngàahmsehk-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Black Glasses|', 2 , q'|Raises the power of Dark-type moves.|', q'|Formatted as BlackGlasses prior to Generation VI.|', nq'|くろいメガネ|', nq'|Kuroi Megane|', nq'|Lunettes Noires|', nq'|Schattenglas|', nq'|Occhialineri|', nq'|Gafas de Sol|', nq'|검은안경|', nq'|Geomeun An-gyeong|', nq'|黑色眼鏡 / 黑色眼镜|', nq'|Hēi-sè Yǎnjìng / Hāak-sīk Ngáahngeng|', 1152 );
insert into ITEMS( NAME, GEN, GEN2, DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Coin Case|', 1, 4, q'|A Key Item that stores the coins collected at the local Game Corner.|' , nq'|コインケース|', nq'|Coin Case|', nq'|Boite Jetons|', nq'|Münzkorb|', nq'|Salvadanaio|', nq'|Monedero|', nq'|동전케이스|', nq'|Dongjeon Case|', nq'|代幣盒 / 代币盒|', nq'|Dàibì Hé / Doihbaih Hahp|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dawn Stone|', 4 , q'|Allows Kirlia (♂) and Snorunt (♀) to evolve.|' , nq'|めざめいし|', nq'|Mezame Ishi|', nq'|Pierre Aube|', nq'|Funkelstein|', nq'|Pietralbore|', nq'|Piedra Alba|', nq'|각성의돌|', nq'|Gakseong-ui Dol|', nq'|覺醒之石 / 觉醒之石|', nq'|Juéxǐng-zhī Shí / Gokséng-jī Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Sablenite|', 6 , q'|Allows Sableye to Mega Evolve into Mega Sableye.|' , nq'|ヤミラミナイト|', nq'|Yamiraminite|', nq'|Ténéfixite|', nq'|Zobirisnit|', nq'|Sableyeite|', nq'|Sableynita|', nq'|깜까미나이트|', nq'|Kamkaminite|', nq'|勾魂眼進化石 / 勾魂眼进化石|', nq'|Gōuhúnyǎn Jìnhuà Shí / Ngāuwàhnngáahn Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Letter|', 3 , q'|To be delivered to Steven Stone.|' , nq'|ダイゴへのてがみ|', nq'|Daigo e no Tsugami|', nq'|Lettre à Pierre|', nq'|Brief an Troy|', nq'|Lettera|', nq'|Carta a Máximo|', nq'|성호에게줄편지|', nq'|Seongho-e Gejul Pyeonji|', nq'|給大吾的信 / 给大吾的信|', nq'|Gěi Dàwú-de Xìn / Kāp Daaihǹgh-dīk Seun|', 208 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Berry Juice|', 2 , q'|Restores 20 HP.|' , nq'|きのみジュース|', nq'|Kinomi Juice|', nq'|Jus De Baie|', nq'|Beerensaft|', nq'|Succo di Bacca|', nq'|Zumo de Baya|', nq'|나무열매쥬스|', nq'|Namu Yeolmae Juice|', nq'|樹果汁 / 树果汁|', nq'|Shù Guǒzhī / Syuh Gwójāp|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Fairium Z|', 7 , q'|Allows a Pokémon to upgrade their Fairy-type damaging moves to the Z-Move Twinkle Tackle or upgrade their Fairy-type status moves into Z-Moves. Makes Arceus a Fairy-type Pokémon.|' , nq'|フェアリーＺ|', nq'|Fairy-Z|', nq'|Nymphézélite|', nq'|Sylphium Z|', nq'|Follectium Z|', nq'|Feeristal Z|', nq'|페어리Z|', nq'|Fairy-Z|', nq'|妖精Ｚ|', nq'|Yāojing-Z / Yíujīng-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|X Defend 3|', 5 , q'|Drastically raises a Pokémon's Defense. Wonder Launcher only.|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Nanab Berry|', 3 , q'|Pokéblock and Poffin ingredient.|' , nq'|ナナのみ|', nq'|Nana no Mi|', nq'|Baie Nanab|', nq'|Nanabbeere|', nq'|Baccabana|', nq'|Baya Latano|', nq'|나나열매|', nq'|Nana Yeolmae|', nq'|蕉香果|', nq'|Jiāoxiāng Guǒ / Jīuhēung Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Ice Memory|', 7 , q'|Makes Silvally a Ice-type Pokémon and makes Multi-Attack a Ice-type move.|' , nq'|アイスメモリ|', nq'|Ice Memory|', nq'|ROM Glace|', nq'|Eis-Disc|', nq'|ROM Ghiaccio|', nq'|Disco Hielo|', nq'|아이스메모리|', nq'|Ice Memory|', nq'|冰雪記憶碟*|'||chr(10)||nq'|冰雪存储碟|', nq'|Bīngxuě Jìyìdié / Bīngsyut Geiyīkdihp*|'||chr(10)||nq'|Bīngxuě Cúnchǔdié|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Ampharosite|', 6 , q'|Allows Ampharos to Mega Evolve into Mega Ampharos.|' , nq'|デンリュウナイト|', nq'|Denryunite|', nq'|Pharampite|', nq'|Ampharosnit|', nq'|Ampharosite|', nq'|Ampharosita|', nq'|전룡나이트|', nq'|Jeonryongnite|', nq'|電龍進化石 / 电龙进化石|', nq'|Diànlóng Jìnhuà Shí / Dihnlùhng Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN, GEN2, DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Storage Key|', 3, 4, q'|Allows a door to be opened on the Abandoned ShipRSE or the storage hold on the Sea MauvilleORAS (3) and Gives the player access to the Galactic Warehouse in Veilstone City (4).|' , nq'|そうこのカギ|', nq'|Sōko no Kagi|', nq'|Clé Stockage|', nq'|Lagerschlüssel|', nq'|Chiave magazzino|', nq'|Llave Almacén|', nq'|창고열쇠|', nq'|Changgo Yeolsoe|', nq'|倉庫鑰匙 / 仓库钥匙|', nq'|Cāngkù Yàoshi / Chōngfu Yeuhksìh|', 32 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Absolite|', 6 , q'|Allows Absol to Mega Evolve into Mega Absol.|' , nq'|アブソルナイト|', nq'|Absolnite|', nq'|Absolite|', nq'|Absolnit|', nq'|Absolite|', nq'|Absolita|', nq'|앱솔나이트|', nq'|Absolnite|', nq'|阿勃梭魯進化石 / 阿勃梭鲁进化石|', nq'|Ābósuōlǔ Jìnhuà Shí / Abuhtsōlóuh Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Poké Doll|', 1 , q'|Allows the player to flee from any battle with a wild Pokémon.|' , nq'|ピッピにんぎょう|', nq'|Pippi Ningyō|', nq'|Poképoupée|', nq'|Poképuppe|', nq'|Poké Bambola|', nq'|Poké Muñeco|', nq'|삐삐인형|', nq'|Ppippi Inhyeong|', nq'|皮皮玩偶|', nq'|Pípí Wán'ǒu / Pèihpèih Wuhnngáuh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Soothe Bell|', 2 , q'|Causes the holder to gain friendship more quickly.|' , nq'|やすらぎのすず|', nq'|Yasuragi no Suzu|', nq'|Grelot Zen|', nq'|Sanftglocke|', nq'|Calmanella|', nq'|Campana Alivio|', nq'|평온의방울|', nq'|Pyeong'on-ui Bang-ul|', nq'|安撫之鈴 / 安抚之铃|', nq'|Ānfǔ-zhī Líng / Ōnfú-jī Lìhng|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Rowap Berry|', 4 , q'|If a foe's special move lands, then the foe also takes damage.|' , nq'|レンブのみ|', nq'|Renbu no Mi|', nq'|Baie Pommo|', nq'|Roselbeere|', nq'|Baccaroam|', nq'|Baya Magua|', nq'|애터열매|', nq'|Aeteo Yeolmae|', nq'|霧蓮果 / 雾莲果|', nq'|Wùlián Guǒ / Mouhlìhn Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Tri-Pass|', 3 , q'|Allows the player to travel to the first three Sevii Islands.|' , nq'|トライパス|', nq'|Tri Pass|', nq'|Tri-Pass|', nq'|Tri-Pass|', nq'|Tri-Pass|', nq'|Tri-Ticket|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Passho Berry|', 4 , q'|Reduces damage from a super effective Water-type move.|' , nq'|イトケのみ|', nq'|Itoke no Mi|', nq'|Baie Pocpoc|', nq'|Foepasbeere|', nq'|Baccapasflo|', nq'|Baya Pasio|', nq'|꼬시개열매|', nq'|Kkosigae Yeolmae|', nq'|千香果|', nq'|Qiānxiāng Guǒ / Chīnhēung Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Green Scarf|', 3 , q'|Raises the Clever condition.|' , nq'|みどりのバンダナ|', nq'|Midori no Bandana|', nq'|Foul. Vert|', nq'|Grüner Schal|', nq'|Fascia Verde|', nq'|Pañuelo Verde|', nq'|초록밴드|', nq'|Chorok Band|', nq'|綠色頭巾 / 绿色头巾|', nq'|Lǜ-sè Tóujīn / Luhk-sīk Tàuhgān|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|X Sp. Def 6|', 5 , q'|Immensely raises a Pokémon's Special Defense. Wonder Launcher only.|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Down St. Key|', 3 , q'|Allows the player to access the basement floor of the Shadow PKMN Lab.|' , nq'|ちかつうろのカギ|', nq'|Chikatsūro no Kagi|', nq'|Cle du Sous-Sol|', nq'|Ug-Schlüssel|', nq'|Chiave Sott.|', nq'|Llave Sótano|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Shuca Berry|', 4 , q'|Reduces damage taken from a super effective Ground-type move.|' , nq'|シュカのみ|', nq'|Shuca no Mi|', nq'|Baie Jouca|', nq'|Schukebeere|', nq'|Baccanaca|', nq'|Baya Acardo|', nq'|슈캐열매|', nq'|Shewca Yeolmae|', nq'|腰木果|', nq'|Yāomù Guǒ / Yīumuhk Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Misty Seed|', 7 , q'|A one-time use item that raises the holder's Sp. Defense by one stage upon activation of Misty Terrain.|' , nq'|ミストシード|', nq'|Mist Seed|', nq'|Graine Brume|', nq'|Nebel-Samen|', nq'|Nebbiaseme|', nq'|Semilla Bruma|', nq'|미스트시드|', nq'|Mist Seed|', nq'|薄霧種子 / 薄雾种子|', nq'|Bówù Zhǒngzi / Báowù Zhǒngzi / Bohkmouh Júngjí|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Magnet|', 2 , q'|Raises the power of Electric-type moves.|' , nq'|じしゃく|', nq'|Jishaku|', nq'|Aimant|', nq'|Magnet|', nq'|Calamita|', nq'|Imán|', nq'|자석|', nq'|Jaseok|', nq'|磁鐵 / 磁铁|', nq'|Cítiě / Chìhtit|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|X Accuracy|', 1 , q'|Raises a Pokémon's Accuracy by 2 stages (1 stage before Gen. VII).|' , nq'|ヨクアタール|', nq'|Yokuatāru|', nq'|Precision +|', nq'|X-Treffer|', nq'|Precisione X|', nq'|Precisión X|', nq'|잘-맞히기|', nq'|Jal-Machigi|', nq'|命中強化 / 命中强化|', nq'|Mìngzhòng Qiánghuà / Mihngjung Kèuhngfa|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Steel Memory|', 7 , q'|Makes Silvally a Steel-type Pokémon and makes Multi-Attack a Steel-type move.|' , nq'|スチールメモリ|', nq'|Steel Memory|', nq'|ROM Acier|', nq'|Stahl-Disc|', nq'|ROM Acciaio|', nq'|Disco Acero|', nq'|스틸메모리|', nq'|Steel Memory|', nq'|鋼鐵記憶碟*|'||chr(10)||nq'|钢铁存储碟|', nq'|Gāngtiě Jìyìdié / Gōngtit Geiyīkdihp*|'||chr(10)||nq'|Gāngtiě Cúnchǔdié|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Red Flute|', 3 , q'|Snaps a Pokémon out of attraction.RSEFRLGColoXDDPPtHGSS Can be sold for 7500.BWB2W2|' , nq'|あかいビードロ|', nq'|Akai Vidro|', nq'|Flûte Rouge|', nq'|Rote Flöte|', nq'|Flauto Rosso|', nq'|Flauta Roja|', nq'|빨강비드로|', nq'|Ppalgang Vidro|', nq'|紅色玻璃哨 / 红色玻璃哨|', nq'|Hóngsè Bōlí Shào / Hùhng-sīk Bōlèih Saau|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Mimikium Z|', 7 , q'|Allows Mimikyu to upgrade Play Rough to the special Z-Move Let's Snuggle Forever.|' , nq'|ミミッキュＺ|', nq'|Mimikkyu-Z|', nq'|Mimiquizélite|', nq'|Mimigmium Z|', nq'|Mimikyum Z|', nq'|Mimikyustal Z|', nq'|따라큐Z|', nq'|Ttarakyu-Z|', nq'|謎擬ＱＺ / 谜拟ＱＺ|', nq'|Mínǐ-Q-Z / Màihyìh-Q-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Clear Bell|', 2 , q'|Summons SuicuneC or Ho-OhHGOR.|' , nq'|とうめいなスズ|', nq'|Tōmei-na Suzu|', nq'|Glas Transparent|', nq'|Klarglocke|', nq'|Campana Chiara|', nq'|Campana Clara|', nq'|크리스탈방울|', nq'|Crystal Bang-ul|', nq'|透明鈴鐺 / 透明铃铛|', nq'|Tòumíng Língdāng / Taumìhng Lìhngdōng|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Key to Room 4|', 6 , q'|Opens Room 4 of the Abandoned ShipRSE/Sea MauvilleORAS.|', q'|Called Rm. 4 Key in Generation III.|', nq'|よんごうしつのカギ|', nq'|Yon-gō Shitsu no Kagi|', nq'|Clé Salle 4|', nq'|R4-Schlüssel|', nq'|Chiave stanza 4|', nq'|Ll. Habitación 4|', nq'|사호실열쇠|', nq'|Sa-hosil Yeolsoe|', nq'|４號客房的鑰匙 /|'||chr(10)||nq'|４号客房的钥匙|', nq'|4 Hào Kèfáng-de Yàoshi / 4 Houh Haakfóng-dīk Yeuhksìh|', 1616 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Toxic Plate|', 4 , q'|Raises the power of Poison-type moves.|' , nq'|もうどくプレート|', nq'|Moudoku Purēto|', nq'|Plaque Toxic|', nq'|Gifttafel|', nq'|Lastrafiele|', nq'|Tabla Tóxica|', nq'|맹독플레이트|', nq'|Maengdok Plate|', nq'|劇毒石板 / 剧毒石板|', nq'|Jùdú Shíbǎn / Kehkduhk Sehkbáan|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Decidium Z|', 7 , q'|Allows Decidueye to upgrade Spirit Shackle to the special Z-Move Sinister Arrow Raid.|' , nq'|ジュナイパーＺ|', nq'|Junaiper-Z|', nq'|Archézélite|', nq'|Silvarronium Z|', nq'|Deciduenium Z|', nq'|Dueyestal Z|', nq'|모크나이퍼Z|', nq'|Mokeunaipeo-Z|', nq'|狙射樹梟Ｚ / 狙射树枭Ｚ|', nq'|Jūshèshùxiāo-Z / Jēuisehsyuhhīu-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Permit|', 5 , q'|A permit needed to enter the Nature Preserve. Only a few know about this place.|' , nq'|きょかしょう|', nq'|License|', nq'|Permis|', nq'|Genehmigung|', nq'|Permesso|', nq'|Pase|', nq'|허가증|', nq'|Heogajeung|', nq'|許可證 / 许可证|', nq'|Xǔkě Zhèng / Héuihó Jing|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Haban Berry|', 4 , q'|Halves the power of super effective Dragon-type moves.|' , nq'|ハバンのみ|', nq'|Haban no Mi|', nq'|Baie Fraigo|', nq'|Terirobeere|', nq'|Baccahaban|', nq'|Baya Anjiro|', nq'|하반열매|', nq'|Haban Yeolmae|', nq'|莓榴果|', nq'|Méiliú Guǒ / Mùihlàuh Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Berry|', 2 , q'|Restores 10 HP. A Pokémon can use it automatically if it is holding it.|' , nq'|きのみ|', nq'|Kino Mi|', nq'|Baie|', nq'|Beere|', nq'|Bacca|', nq'|Baya|', nq'|나무열매|', nq'|Namu Yeolmae|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Focus Sash|', 4 , q'|Prevents a one-hit knockout.|' , nq'|きあいのタスキ|', nq'|Kiai no Tasuki|', nq'|Ceinture Force|', nq'|Fokusgurt|', nq'|Focalnastro|', nq'|Banda Focus|', nq'|기합의띠|', nq'|Gihabui Tti|', nq'|氣勢披帶 / 气势披带|', nq'|Qìshì Pīdài / Heisai Pēidaai|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Flyinium Z|', 7 , q'|Allows a Pokémon to upgrade their Flying-type damaging moves to the Z-Move Supersonic Skystrike or upgrade their Flying-type status moves into Z-Moves. Makes Arceus a Flying-type Pokémon.|' , nq'|ヒコウＺ|', nq'|Flying-Z|', nq'|Aérozélite|', nq'|Aerium Z|', nq'|Volantium Z|', nq'|Aerostal Z|', nq'|비행Z|', nq'|Bihaeng-Z|', nq'|飛行Ｚ / 飞行Ｚ|', nq'|Fēixíng-Z / Fēihàhng-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Sail Fossil|', 6 , q'|A Fossil from which an Amaura can be resurrected.|' , nq'|ヒレのカセキ|', nq'|Hire no Kaseki|', nq'|Fossile Nageoire|', nq'|Flossenfossil|', nq'|Fossilpinna|', nq'|Fósil Aleta|', nq'|지느러미화석|', nq'|Jineuleomi Hwaseok|', nq'|鰭之化石 / 鳍之化石|', nq'|Qí-zhī Huàshí / Kèih-jī Fasehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Ether|', 1 , q'|Restores 10 PP of one move of a Pokémon.|' , nq'|ピーピーエイド|', nq'|PP Aid|', nq'|Huile|', nq'|Äther|', nq'|Etere|', nq'|Éter|', nq'|PP에이드|', nq'|PP Aid|', nq'|ＰＰ單項小補劑 / ＰＰ单项小补剂|', nq'|PP Dānxiàng Xiǎobǔjì / PP Dāanhohng Síubóujaih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Item Drop|', 5 , q'|Causes an ally to drop its held item. Wonder Launcher only.|' , nq'|アイテムドロップ|', nq'|Item Drop|', nq'|Jette Objet|', nq'|Itemabwurf|', nq'|Lascioggetto|', nq'|Tiraobjeto|', nq'|아이템드롭|', nq'|Item Drop|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Gold Berry|', 2 , q'|Restores 30 HP.|' , nq'|おうごんのみ|', nq'|Ōgon no Mi|', nq'|Baie Doree|', nq'|Goldbeere|', nq'|Bacca Oro|', nq'|Baya Dorada|', nq'|황금열매|', nq'|Hwanggeum Yeolmae|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Ein File H|', 3 , q'|Describes Hyper Mode.|' , nq'|ボルグファイルＨ|', nq'|Borg File H|', nq'|Dossier Teck H|', nq'|Culpa-Akte F-M|', nq'|Genus.File I|', nq'|Parte Ein: H|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Paralyze Heal|', 1 , q'|Heals paralysis.|', q'|Called Parlyz Heal prior to Generation VI.|', nq'|まひなおし|', nq'|Mahi Naoshi|', nq'|Anti-Para|', nq'|Para-Heiler|', nq'|Antiparalisi|', nq'|Antiparalizador|', nq'|마비치료제|', nq'|Mabi Chiryoje|', nq'|解麻藥 / 解麻药|', nq'|Jiěmáyào / Gáaimàhyeuhk|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dragon Skull|', 5 , q'|Stolen from the Nacrene Museum by a Team Plasma Grunt.|' , nq'|ドラゴンのホネ|', nq'|Dragon no Hone|', nq'|Crâne Dragon|', nq'|Drakoschädel|', nq'|Teschio|', nq'|Crán. Dragón|', nq'|드래곤의뼈|', nq'|Dragon-yi Ppyeo|', nq'|龍之骨 / 龙之骨|', nq'|Lóng-zhī Gǔ / Lùhng-jī Gwāt|', 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Rage Candy Bar|' , nq'|いかりまんじゅう|', nq'|Ikari Manjū|', nq'|Bonbon Rage|', nq'|Wutkeks|', nq'|Iramella|', nq'|Caram. Furia|', nq'|분노의호두과자|', nq'|Bunno-ui Hodugwaja|', nq'|憤怒饅頭 / 愤怒馒头|', nq'|Fènnù Mántou / Fáhnnouh Màahntàuh|', 1024 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Primarium Z|', 7 , q'|Allows Primarina to upgrade Sparkling Aria to the special Z-Move Oceanic Operetta.|' , nq'|アシレーヌＺ|', nq'|Ashirene-Z|', nq'|Oratozélite|', nq'|Primarenium Z|', nq'|Primarinium Z|', nq'|Primastal Z|', nq'|누리레느Z|', nq'|Nurireneu-Z|', nq'|西獅海壬Ｚ / 西狮海壬Ｚ|', nq'|Xīshīhǎirén-Z / Sāisīhóiyàhm-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Berry Pots|', 4 , q'|Allows Berry growth while traveling.|' , nq'|きのみプランター|', nq'|Kinomi Planter|', nq'|Plante Baies|', nq'|Pflanzset|', nq'|Piantabacche|', nq'|Plantabayas|', nq'|나무열매플랜터|', nq'|Namu Yeolmae Planter|', nq'|樹果種植盆 / 树果种植盆|', nq'|Shùguǒ Zhòngzhí Pén / Syuhgwó Júngjihk Pùhn|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Darkinium Z|', 7 , q'|Allows a Pokémon to upgrade their Dark-type damaging moves to the Z-Move Black Hole Eclipse or upgrade their Dark-type status moves into Z-Moves. Makes Arceus a Dark-type Pokémon.|' , nq'|アクＺ|', nq'|Evil-Z|', nq'|Ténébrozélite|', nq'|Noctium Z|', nq'|Obscurium Z|', nq'|Nictostal Z|', nq'|악Z|', nq'|Ak-Z|', nq'|惡Ｚ / 恶Ｚ|', nq'|È-Z / Ok-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pikanium Z|', 7 , q'|Allows Pikachu to upgrade Volt Tackle to the special Z-Move Catastropika.|' , nq'|ピカチュウＺ|', nq'|Pikachu-Z|', nq'|Pikazélite|', nq'|Pikachium Z|', nq'|Pikacium Z|', nq'|Pikastal Z|', nq'|피카츄Z|', nq'|Pikachu-Z|', nq'|皮卡丘Ｚ|', nq'|Píkǎqiū-Z / Pèihkāyāu-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|Travel Trunk|', 6 , q'|Not available without cheating. Allows the player to switch their clothes, just like in a Pokémon Center.|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|X Attack 3|', 5 , q'|Drastically raises a Pokémon's Attack. Wonder Launcher only.|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Snow Mail|', 4 , q'|Mail with a snow print. To be held by a Pokémon for delivery.|' , nq'|ブリザードメール|', nq'|Blizzard Mail|', nq'|Lettre Neige|', nq'|Schneebrief|', nq'|Mess. Neve|', nq'|Carta Nieve|', nq'|블리자드메일|', nq'|Blizzard Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Sharp Beak|', 2 , q'|Raises the power of Flying-type moves.|' , nq'|するどいくちばし|', nq'|Surudoi Kuchibashi|', nq'|Bec Pointu|', nq'|Hackattack|', nq'|Beccaffilato|', nq'|Pico Afilado|', nq'|예리한부리|', nq'|Yerihan Buri|', nq'|銳利鳥嘴 / 锐利鸟嘴|', nq'|Ruìlì Niǎozuǐ / Yeuihleih Níuhjéui|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Power Plant Pass|', 6 , q'|Allows access to the Kalos Power Plant.|' , nq'|はつでんしょパス|', nq'|Hatsudensho Pass|', nq'|Passe Centrale|', nq'|Kraftwerks-Pass|', nq'|Pass Centrale|', nq'|Pase Central|', nq'|발전소패스|', nq'|Baljeonso Pass|', nq'|發電廠通行證 / 发电厂通行证|', nq'|Fādiànchǎng Tōngxíngzhèng / Faatdihnchóng Tūnghàhngjing|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Custap Berry|', 4 , q'|Allows holder to move first just once when HP is below ⅓.|' , nq'|イバンのみ|', nq'|Iban no Mi|', nq'|Baie Chérim|', nq'|Eipfelbeere|', nq'|Baccacrela|', nq'|Baya Chiri|', nq'|애슈열매|', nq'|Aesyu Yeolmae|', nq'|釋陀果 / 释陀果|', nq'|Shìtuó Guǒ / Sīktòh Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Assault Vest|', 6 , q'|Raises Sp. Def but prevents the use of status moves.|' , nq'|とつげきチョッキ|', nq'|Totsugeki Chokki|', nq'|Veste de Combat|', nq'|Offensivweste|', nq'|Corpetto Assalto|', nq'|Chaleco Asalto|', nq'|돌격조끼|', nq'|Dolgyeok Jokki|', nq'|突擊背心 / 突击背心|', nq'|Tújí Bèixīn / Dahtgīk Buisām|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Silk Scarf|', 3 , q'|Raises the power of Normal-type moves.|' , nq'|シルクのスカーフ|', nq'|Silk no Scarf|', nq'|Mouchoir Soie|', nq'|Seidenschal|', nq'|Sciarpa Seta|', nq'|Pañuelo Seda|', nq'|실크스카프|', nq'|Silk Scarf|', nq'|絲綢圍巾 / 丝绸围巾|', nq'|Sīchóu Wéijīn / Sīchàuh Wàihgān|', 160 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Looker Ticket|', 6 , q'|Must find five to advance the plot of the Looker post-game quest.|' , nq'|ハンサムチケット|', nq'|Handsome Ticket|', nq'|Ticket Beladonis|', nq'|LeBelle-Ticket|', nq'|Carta Bellocchio|', nq'|Boleto Handsome|', nq'|핸섬티켓|', nq'|Handsome Ticket|', nq'|帥哥券 / 帅哥券|', nq'|Shuàigē Quàn / Seuigō Hyun|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Mago Berry|', 3 , q'|When HP falls below 25%, restores 50% HP, but confuses Pokémon that dislike spicy food (12.5% when below 50% before Gen. VII).|' , nq'|マゴのみ|', nq'|Mago no Mi|', nq'|Baie Mago|', nq'|Magobeere|', nq'|Baccamango|', nq'|Baya Ango|', nq'|마고열매|', nq'|Mago Yeolmae|', nq'|芒芒果|', nq'|Mángmáng Guǒ / Mòhngmòhng Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Twisted Spoon|', 2 , q'|Raises the power of Psychic-type moves.|', q'|Formatted as TwistedSpoon prior to Generation VI.|', nq'|まがったスプーン|', nq'|Magatta Spoon|', nq'|Cuiller Tordue|', nq'|Krümmlöffel|', nq'|Cucchiaio Torto|', nq'|Cuchara Torcida|', nq'|휘어진스푼|', nq'|Hwieojin Spoon|', nq'|彎曲的湯匙 / 弯曲的汤匙|', nq'|Wānqū-de Tāngchí / Wāankūk-dīk Tōngchìh|', 1184 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Bead Mail|', 3 , q'|A bead-printed stationery. To be held by a Pokémon for delivery.|' , nq'|トレジャーメール|', nq'|Treasure Mail|', nq'|Lettre Bulle|', nq'|Perlenbrief|', nq'|Mess. Perle|', nq'|Carta Imagen|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Nugget|', 1 , q'|Can be sold for 5000.|' , nq'|きんのたま|', nq'|Kin no Tama|', nq'|Pepite|', nq'|Nugget|', nq'|Pepita|', nq'|Pepita|', nq'|금구슬|', nq'|Geum Guseul|', nq'|金珠|', nq'|Jīnzhū / Gāmjyū|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Glitter Mail|', 3 , q'|Mail with a Pikachu pattern.|' , nq'|キラキラメール|', nq'|Kira Kira Mail|', nq'|Lettre Brill|', nq'|Glitzerbrief|', nq'|Mess. Luci|', nq'|Carta Brillo|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|White Flute|', 3 , q'|Attracts wild Pokémon to the player.RSEFRLGDPPtHGSS Can be sold for 8000.BWB2W2 Decreases the level of wild Pokémon by one to three levels.ORAS|' , nq'|しろいビードロ|', nq'|Shiroi Vidro|', nq'|Flûte Blanche|', nq'|Weisse Flöte|', nq'|Flauto Bianco|', nq'|Flauta Blanca|', nq'|하양비드로|', nq'|Hayang Vidro|', nq'|白色玻璃哨|', nq'|Bái-sè Bōlí Shào / Baahk-sīk Bōlèih Saau|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Psychic Seed|', 7 , q'|A one-time use item that raises the holder's Sp. Defense by one stage upon activation of Psychic Terrain.|' , nq'|サイコシード|', nq'|Psycho Seed|', nq'|Graine Psychique|', nq'|Psycho-Samen|', nq'|Psicoseme|', nq'|Semilla Psique|', nq'|사이코시드|', nq'|Psycho Seed|', nq'|精神種子 / 精神种子|', nq'|Jīngshén Zhǒngzi / Jīngsàhn Júngjí|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Timer Ball|', 3 , q'|A type of Poké Ball that works better the longer the battle has lasted.|' , nq'|タイマーボール|', nq'|Timer Ball|', nq'|Chrono Ball|', nq'|Timerball|', nq'|Timer Ball|', nq'|Turno Ball|', nq'|타이마볼|', nq'|Timer Ball|', nq'|計時球 / 计时球|', nq'|Jìshí Qiú / Gaisìh Kàuh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Ghostium Z|', 7 , q'|Allows a Pokémon to upgrade their Ghost-type damaging moves to the Z-Move Never-Ending Nightmare or upgrade their Ghost-type status moves into Z-Moves. Makes Arceus a Ghost-type Pokémon.|' , nq'|ゴーストＺ|', nq'|Ghost-Z|', nq'|Spectrozélite|', nq'|Phantomium Z|', nq'|Spectrium Z|', nq'|Espectrostal Z|', nq'|고스트Z|', nq'|Ghost-Z|', nq'|幽靈Ｚ / 幽灵Ｚ|', nq'|Yōulíng-Z / Yāulìhng-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Friend Ball|', 2 , q'|A type of Poké Ball that causes the Pokémon to become friendly.|' , nq'|フレンドボール|', nq'|Friend Ball|', nq'|Copain Ball|', nq'|Freundesball|', nq'|Friend Ball|', nq'|Amigo Ball|', nq'|프랜드볼|', nq'|Friend Ball|', nq'|友友球|', nq'|Yǒuyǒu Qiú / Yáuhyáuh Kàuh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Soot Sack|', 3 , q'|Allows player to gather soot from Mt. Chimney and exchange for Flutes.|' , nq'|はいぶくろ|', nq'|Hai Bukuro|', nq'|Sac à Suie|', nq'|Aschetasche|', nq'|Sacco Cenere|', nq'|Saco hollín|', nq'|검댕자루|', nq'|Geomdaeng Jaru|', nq'|集灰袋|', nq'|Jíhuī Dài / Jaahpfūi Doih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Old Sea Map|', 3 , q'|Event item that gives player access to Faraway Island, where Mew can be caught.|' , nq'|ふるびたかいず|', nq'|Furubita Kaizu|', nq'|Vieille Carte|', nq'|Alte Karte|', nq'|Mappa Stinta|', nq'|Mapa Viejo|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Ground Gem|', 5 , q'|Increases the power of the holder's first Ground-type move by 50%, and is consumed after use.|' , nq'|じめんのジュエル|', nq'|Jimen no Jewel|', nq'|Joyau Sol|', nq'|Bodenjuwel|', nq'|Bijouterra|', nq'|Gema Tierra|', nq'|땅주얼|', nq'|Ttang Jewel|', nq'|地面寶石 / 地面宝石|', nq'|Dìmiàn Bǎoshí / Deihmín Bóusehk|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Jaw Fossil|', 6 , q'|A Fossil from which a Tyrunt can be resurrected.|' , nq'|アゴのカセキ|', nq'|Ago no Kaseki|', nq'|Fossile Mâchoire|', nq'|Kieferfossil|', nq'|Fossilmascella|', nq'|Fósil Mandíbula|', nq'|턱화석|', nq'|Teok Hwaseok|', nq'|顎之化石 / 颚之化石|', nq'|È-zhī Huàshí / Ngohk-jī Fasehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Like Mail|', 5 , q'|Stationary designed for writing recommendations. To be held by a Pokémon for delivery.|' , nq'|おすすめメール|', nq'|Osusume Mail|', nq'|Lettre Avis|', nq'|Insiderbrief|', nq'|Mess. Sugg.|', nq'|C. Gustos|', nq'|추천메일|', nq'|Chucheon Mail|', nq'|推薦郵件 / 推荐邮件|', nq'|Tuījiàn Yóujiàn / Tēuijin Yàuhgín|', 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Poké Snack|' , nq'|ポケまんま|', nq'|Poké Manma|', nq'|Poké Snack|', nq'|Pokésnack|', nq'|Poké Snack|', nq'|Poké Dulce|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|MysteryBerry|', 2 , q'|Restores 5 PP.|' , nq'|ふしぎなきのみ|', nq'|Fushigina Kino Mi|', nq'|Baie Mystere|', nq'|Rätselbeere|', nq'|Bacca Mist.|', nq'|Bayamisterio|', nq'|이상한나무열매|', nq'|Isanghan Namu Yeolmae|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Blue Scarf|', 3 , q'|Raises the Beautiful condition.|' , nq'|あおいバンダナ|', nq'|Aoi Bandanna|', nq'|Foul. Bleu|', nq'|Blauer Schal|', nq'|Fascia Blu|', nq'|Pañuelo Azul|', nq'|파랑밴드|', nq'|Parang Band|', nq'|藍色頭巾 / 蓝色头巾|', nq'|Lán-sè Tóujīn / Làahm-sīk Tàuhgān|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Power Band|', 4 , q'|Promotes Special Defense EVs, but lowers Speed in battle.|' , nq'|パワーバンド|', nq'|Power Band|', nq'|Bandeau Pouvoir|', nq'|Machtband|', nq'|Vigorbanda|', nq'|Banda Recia|', nq'|파워밴드|', nq'|Power Band|', nq'|力量束帶 / 力量束带|', nq'|Lìliàng Shùdài / Lihkleuhng Chūkdaai|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|X Defend 6|', 5 , q'|Immensely raises a Pokémon's Defense. Wonder Launcher only.|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Eon Ticket|', 3 , q'|Allows player to access Southern Island.|' , nq'|むげんのチケット|', nq'|Mugen no Ticket|', nq'|Passe Éon|', nq'|Äon-Ticket|', nq'|Biglietto Eone|', nq'|Ticket Eón|', nq'|무한티켓|', nq'|Muhan Ticket|', nq'|無限船票 / 无限船票|', nq'|Wúxiàn Chuánpiào / Mòuhhaahn Syùhnpiu|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Inquiry Mail|', 5 , q'|Stationary for writing questions. To be held by a Pokémon for delivery.|' , nq'|しつもんメール|', nq'|Shitsumon Mail|', nq'|Let. Demande|', nq'|Fragebrief|', nq'|Mess. Chiedi|', nq'|C. Pregunta|', nq'|질문메일|', nq'|Jilmun Mail|', nq'|詢問郵件 / 询问邮件|', nq'|Xúnwèn Yóujiàn / Sēunmahn Yàuhgín|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Kommonium Z|', 7 , q'|Allows Kommo-o to upgrade Clanging Scales to the special Z-Move Clangorous Soulblaze.|' , nq'|ジャラランガＺ|', nq'|Jararanga-Z|', nq'|Ékaïzélite|', nq'|Grandirasium Z|', nq'|Kommonium Z|', nq'|Kommostal Z|', nq'|짜랑고우거Z|', nq'|Jjaranggougeo-Z|', nq'|杖尾鱗甲龍Ｚ / 杖尾鳞甲龙Ｚ|', nq'|Zhàngwěilínjiǎlóng-Z / Jeuhngméihlèuhngaaplùhng-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Ein File F|', 3 , q'|Describes additional details on purification.|' , nq'|ボルグファイルＦ|', nq'|Borg File F|', nq'|Dossier Teck F|', nq'|Culpa-Akte A-B|', nq'|Genus.File F|', nq'|Parte Ein: F|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Balm Mushroom|', 5 , q'|Can be sold for 25000.|', q'|Formatted as BalmMushroom in Generation V.|', nq'|かおるキノコ|', nq'|Kaoru Kinoko|', nq'|Champi Suave|', nq'|Duftpilz|', nq'|Profumfungo|', nq'|Seta Aroma|', nq'|향기버섯|', nq'|Hyanggi Beoseot|', nq'|芳香蘑菇|', nq'|Fāngxiāng Mógū / Fōnghēung Mòhgū|', 1024 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Maingate Key|', 3 , q'|Opens the front gate to the Shadow PKMN Lab.|' , nq'|メインゲートキー|', nq'|Main Gate Key|', nq'|Cle Labo|', nq'|Torschlüssel|', nq'|Chiave Canc.|', nq'|Ll. Entrada|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lens Case|', 6 , q'|Stores colored contact lenses that allow the player to change their eye color.|' , nq'|レンズケース|', nq'|Lens Case|', nq'|Boîte Lentilles|', nq'|Linsenetui|', nq'|Portalenti|', nq'|Portalentillas|', nq'|렌즈케이스|', nq'|Lens Case|', nq'|隱形眼鏡盒 / 隐形眼镜盒|', nq'|Yǐnxíng Yǎnjìng Hé / Yányìhng Ngáahngeng Hahp|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Works Key|', 4 , q'|Allows player access to the Valley Windworks near Floaroma Town.|' , nq'|はつでんしょキー|', nq'|Hatsudensho Key|', nq'|Clé Centrale|', nq'|K-Schlüssel|', nq'|Turbinchiave|', nq'|Ll. Central|', nq'|발전소키|', nq'|Baljeonso Key|', nq'|發電廠鑰匙 / 发电厂钥匙|', nq'|Fādiànchǎng Yàoshi / Faatdihnchóng Yeuhksìh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Heat Rock|', 4 , q'|Extends the duration of harsh sunlight.|' , nq'|あついいわ|', nq'|Atsui Iwa|', nq'|Roche Chaude|', nq'|Heißbrocken|', nq'|Rocciacalda|', nq'|Roca Calor|', nq'|뜨거운바위|', nq'|Tteugeoun Bawi|', nq'|熾熱岩石 / 炽热岩石|', nq'|Chìrè Yánshí / Chiyiht Ngàahmsehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Aqua Suit|', 6 , q'|Allows the player to ride Kyogre in the Cave of Origin and fly into space on Rayquaza.|' , nq'|アクアスーツ|', nq'|Aqua Suit|', nq'|Scaphandre Aqua|', nq'|Aqua-Anzug|', nq'|Tuta Idro|', nq'|Traje Aqua|', nq'|아쿠아슈트|', nq'|Aqua Suit|', nq'|海洋裝 / 海洋装|', nq'|Hǎiyáng Zhuāng / Hóiyèuhng Jōng|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Max Repel|', 1 , q'|Prevents wild Pokémon with a lower level than the first member of the party from appearing for 250 steps|' , nq'|ゴールドスプレー|', nq'|Gold Spray|', nq'|Max Repousse|', nq'|Top-Schutz|', nq'|Repellente Max|', nq'|Repelente Maximo|', nq'|골드스프레이|', nq'|Gold Spray|', nq'|黃金噴霧 / 黄金喷雾|', nq'|Huángjīn Pēnwù / Wòhnggām Panmouh|', 48 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Oval Charm|', 5 , q'|An oval charm said to increase the chance of Eggs being found at the Day Care.|' , nq'|まるいおまもり|', nq'|Round Charm|', nq'|Charme Ovale|', nq'|Ovalpin|', nq'|Ovamuleto|', nq'|Amuleto Oval|', nq'|둥근부적|', nq'|Dunggeun Bujeok|', nq'|圓形護符 / 圆形护符|', nq'|Yuánxíng Hùfú / Yùhnyìhng Wuhfùh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Tamato Berry|', 3 , q'|Raises friendship, but lowers Speed EVs.|' , nq'|マトマのみ|', nq'|Matoma no Mi|', nq'|Baie Tamato|', nq'|Tamotbeere|', nq'|Baccamodoro|', nq'|Baya Tamate|', nq'|토망열매|', nq'|Tomang Yeolmae|', nq'|茄番果|', nq'|Qiéfān Guǒ / Kéfāan Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Relic Crown|', 5 , q'|Can be sold for 300000 to the villa owner in Undella Town.|' , nq'|こだいのおうかん|', nq'|Kodai no Ōkan|', nq'|Vieux Tortil|', nq'|Alte Krone|', nq'|Coronantica|', nq'|Corona Antigua|', nq'|고대의왕관|', nq'|Godae-yi Wanggwan|', nq'|古代王冠|', nq'|Gǔdài Wángguàn / Gúdoih Wòhnggūn|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Lovely Mail|', 2 , q'|Mail with a heart design. To be held by a Pokémon for delivery.|' , nq'|ラブリーメール|', nq'|Lovely Mail|', nq'|LetrCharm.|', nq'|Herzbrief|', nq'|Mess. Dolce|', nq'|Carta Amor|', nq'|러브리메일|', nq'|Lovely Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Growth Mulch|', 4 , q'|Causes Berries to grow faster, but makes the soil dry faster.|' , nq'|すくすくこやし|', nq'|Sukusuku Koyashi|', nq'|Fertipousse|', nq'|Wachsmulch|', nq'|Fertilrapido|', nq'|Abono Rápido|', nq'|무럭무럭비료|', nq'|Mureokmureok Biryo|', nq'|速速肥|', nq'|Sùsù Féi / Chūkchūk Fèih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Devon Scope|', 3 , q'|Reveals hidden Pokémon.|' , nq'|デボンスコープ|', nq'|Devon Scope|', nq'|Devon Scope|', nq'|Devon-Scope|', nq'|Devonscopio|', nq'|Detector Devon|', nq'|데봉스코프|', nq'|Devon Scope|', nq'|得文偵測鏡 / 得文侦测镜|', nq'|Déwén Zhēncèjìng / Dākmàhn Jīngchākgeng|', 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Roto Friendship|' , nq'|なつきポン|', nq'|Natsuki Pon|', nq'|Moti-Cœur|', nq'|Freundschaftsbon|', nq'|Affetto'n'roll|', nq'|Cupón Amistad|', nq'| ???|', nq'| ???|', nq'|親密碰碰 / 亲密碰碰|', nq'|Qīnmì Pèngpèng / Chānmaht Pungpung|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Moon Flute|', 7 , q'|Used to evolve Nebby into Lunala at the Altar of the Moone.|' , nq'|つきのふえ|', nq'|Tsuki no Fue|', nq'|Flûte de la Lune|', nq'|Mondflöte|', nq'|Flauto lunare|', nq'|Flauta Lunar|', nq'|달의피리|', nq'|Dal Uipili|', nq'|月亮之笛|', nq'|Yuèliàng-zhī Dí / Yuhtleuhng-jī Dehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Quick Claw|', 2 , q'|May allow the user to move first.|' , nq'|せんせいのツメ|', nq'|Sensei no Tsume|', nq'|Vive Griffe|', nq'|Flinkklaue|', nq'|Rapidartigli|', nq'|Garra Rápida|', nq'|선제공격손톱|', nq'|Seonjegonggyeok Sontop|', nq'|先制之爪|', nq'|Xiānzhì-zhī Zhuǎ / Sīnjai-jī Jáau|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pinsirite|', 6 , q'|Allows Pinsir to Mega Evolve into Mega Pinsir.|' , nq'|カイロスナイト|', nq'|Kailiosnite|', nq'|Scarabruite|', nq'|Pinsirnit|', nq'|Pinsirite|', nq'|Pinsirita|', nq'|쁘사이저나이트|', nq'|Ppeusaizeonite|', nq'|凱羅斯進化石 / 凯罗斯进化石|', nq'|Kǎiluósī Jìnhuà Shí / Hóilòhsī Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|X Sp. Def 2|', 5 , q'|Sharply raises a Pokémon's Special Defense. Wonder Launcher only.|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Full Heal|', 1 , q'|Cures any status condition.|' , nq'|なんでもなおし|', nq'|Nandemo Naoshi|', nq'|Total Soin|', nq'|Hyperheiler|', nq'|Cura Totale|', nq'|Cura Total|', nq'|만병통치약|', nq'|Manbyeongtongchiyak|', nq'|萬靈藥 / 万灵药|', nq'|Wànlíngyào / Maahnlìhngyeuhk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Heart Scale|', 3 , q'|Exchangeable for a variety of services.|' , nq'|ハートのウロコ|', nq'|Heart no Uroko|', nq'|Écaille Cœur|', nq'|Herzschuppe|', nq'|Squama Cuore|', nq'|Escama Corazón|', nq'|하트비늘|', nq'|Heart Bineul|', nq'|心之鱗片 / 心之鳞片|', nq'|Xīn-zhī Línpiàn / Sām-jī Lèuhnpin|', 144 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Amulet Coin|', 2 , q'|Doubles the earned money after a battle against a Trainer.|' , nq'|おまもりこばん|', nq'|Omamori Koban|', nq'|Piece Rune|', nq'|Münzamulett|', nq'|Monetamuleto|', nq'|Moneda Amuleto|', nq'|부적금화|', nq'|Bujeok Geumhwa|', nq'|護符金幣 / 护符金币|', nq'|Hùfú Jīnbì / Wuhfùh Gāmbaih|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Star Piece|', 2 , q'|Can be sold for 4900.|' , nq'|ほしのかけら|', nq'|Hoshi no Kakera|', nq'|Morceau d'Étoile|', nq'|Sternenstück|', nq'|Pezzo Stella|', nq'|Trozo Estrella|', nq'|별의조각|', nq'|Byeorui Jogak|', nq'|星星碎片|', nq'|Xīngxīng Suìpiàn / Sīngsīng Seuipín|', 144 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Orange Petal|', 7 , q'|An orange petal required to complete Mina's Trial.|' , nq'|だいだいはなびら|', nq'|Daidai Hanabira|', nq'|Pétale Orange|', nq'|Oranges Blatt|', nq'|Petalo arancione|', nq'|Pétalo Naranja|', nq'|주황꽃잎|', nq'|Juhwang Kkochip|', nq'|橙色花瓣|', nq'|Chéng-sè Huābàn / Chàahng-sīk Fāfáan|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Poison Barb|', 2 , q'|Raises the power of Poison-type moves.|' , nq'|どくバリ|', nq'|Doku Bari|', nq'|Pic Venin|', nq'|Giftstich|', nq'|Velenaculeo|', nq'|Flecha Venenosa|', nq'|독바늘|', nq'|Dokbaneul|', nq'|毒針 / 毒针|', nq'|Dúzhēn / Duhkjām|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Rabuta Berry|', 3 , q'|Pokéblock and Poffin ingredient.|' , nq'|ラブタのみ|', nq'|Rabuta no Mi|', nq'|Baie Rabuta|', nq'|Rabutabeere|', nq'|Baccambutan|', nq'|Baya Rautan|', nq'|라부탐열매|', nq'|Rabutam Yeolmae|', nq'|茸丹果|', nq'|Rōngdān Guǒ / Yùhngdāan Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Yellow Flute|', 3 , q'|Snaps a Pokémon out of Confusion.RSEFRLGColoXDDPPtHGSSORAS Can be sold for 7500.BWB2W2|' , nq'|きいろビードロ|', nq'|Kiiro Vidro|', nq'|Flûte Jaune|', nq'|Gelbe Flöte|', nq'|Flauto Giallo|', nq'|Flauta Amarilla|', nq'|노랑비드로|', nq'|Norang Vidro|', nq'|黃色玻璃哨 / 黄色玻璃哨|', nq'|Huáng-sè Bōlí Shào / Wòhng-sīk Bōlèih Saau|', 176 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|L-Disk|', 3 , q'|Moves the UFO in The Under to the Amulet Coin.|' , nq'|Ｌ－ディスク|', nq'|L-Disk|', nq'|Disque-G|', nq'|L-Disc|', nq'|Disco Sx|', nq'|Disco I|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Discount Coupon|', 6 , q'|Used at any boutique for a one-time 50% discount.|' , nq'|バーゲンチケット|', nq'|Bargain Ticket|', nq'|Bon Réduction|', nq'|Rabattmarke|', nq'|Buono sconto|', nq'|Vale Descuento|', nq'|바겐세일티켓|', nq'|Bargain Ticket|', nq'|折價券 / 折价券|', nq'|Zhéjià Quàn / Jitga Gyun|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Muscle Band|', 4 , q'|Raises the power of physical moves.|' , nq'|ちからのハチマキ|', nq'|Chikara no Hachimaki|', nq'|Bandeau Muscle|', nq'|Muskelband|', nq'|Muscolbanda|', nq'|Cinta Fuerte|', nq'|힘의머리띠|', nq'|Himui Meoritti|', nq'|力量頭帶 / 力量头带|', nq'|Lìliàng Tóudài / Lihkleuhng Tàuhdaai|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Brick Mail|', 4 , q'|A brick pattern stationery. To be held by a Pokémon for delivery.|' , nq'|ブリックメール|', nq'|Brick Mail|', nq'|Lettre Brik|', nq'|Ziegelbrief|', nq'|Mess. Muro|', nq'|Carta Pared|', nq'|브릭메일|', nq'|Brick Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Grn ID Badge|', 3 , q'|One of four keys needed to unlock the north door of Realgam Tower.|' , nq'|ＩＤバッジみどり|', nq'|ID Badge Midori|', nq'|Passe Vert|', nq'|Grüne ID-Marke|', nq'|Pass Verde|', nq'|Pase Verde|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dome Fossil|', 3 , q'|A Fossil from which a Kabuto can be resurrected.|' , nq'|こうらのカセキ|', nq'|Kōra no Kaseki|', nq'|Fossile Dôme|', nq'|Domfossil|', nq'|Domofossile|', nq'|Fósil Domo|', nq'|껍질화석|', nq'|Kkeopjil Hwaseok|', nq'|甲殼化石 / 甲壳化石|', nq'|Jiǎké Huàshí / Gaaphok Fasehk|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Reaper Cloth|', 4 , q'|A held item that allows Dusclops to evolve into Dusknoir when traded.|' , nq'|れいかいのぬの|', nq'|Reikai no Nuno|', nq'|Tissu Fauche|', nq'|Düsterumhang|', nq'|Terrorpanno|', nq'|Tela Terrible|', nq'|영계의천|', nq'|Yeonggye-ui Cheon|', nq'|靈界之布 / 灵界之布|', nq'|Língjiè-zhī Bù / Lìhnggaai-jī Bou|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Suite Key|', 4 , q'|Give to NPC in exchange for Lava Cookie.|' , nq'|ルームキー|', nq'|Room Key|', nq'|Clé Chambre|', nq'|B-Schlüssel|', nq'|Chiave Suite|', nq'|Llave Suite|', nq'|룸키|', nq'|Room Key|', nq'|房間鑰匙 / 房间钥匙|', nq'|Fángjiān Yàoshi / Fòhnggāan Yeuhksìh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Rainbow Flower|', 7 , q'|A rainbow flower created from the Seven Petals obtained from Mina's trial, and required to finish Mina's Trial.|' , nq'|にじいろのはな|', nq'|Nijiiro no Hana|', nq'|Fleur 7 Couleurs|', nq'|Regenbogenblüte|', nq'|Fiore arcobaleno|', nq'|Flor Irisada|', nq'|무지개꽃|', nq'|Mujigae Kkot|', nq'|虹色之花|', nq'|Hóng-sè-zhī Huā / Hùhng-sīk-jī Fā|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Clever Wing|', 5 , q'|Raises the Special Defense of a Pokémon.|' , nq'|せいしんのハネ|', nq'|Seishin no Hane|', nq'|Aile Mental|', nq'|Espritfeder|', nq'|Piumintuito|', nq'|Pluma Mente|', nq'|정신력날개|', nq'|Jeongsinryeok Nalgae|', nq'|精神之羽|', nq'|Jīngshén-zhī Yǔ / Jīngsàhn-jī Yúh|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lumiose Galette|', 6 , q'|Cures any status condition.|' , nq'|ミアレガレット|', nq'|Miare Galette|', nq'|Galette Illumis|', nq'|Illumina-Galette|', nq'|Pan di Lumi|', nq'|Crêpe Luminalia|', nq'|미르갈레트|', nq'|Mireu Galette|', nq'|密阿雷格雷派餅 / 密阿雷格雷派饼|', nq'|Mì'āléi Géléi Pàibǐng / Maht'alèuih Gaaklèuih Paaibéng|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Zap Plate|', 4 , q'|Raises the power of Electric-type moves.|' , nq'|いかずちプレート|', nq'|Ikazuchi Purēto|', nq'|Plaque Volt|', nq'|Blitztafel|', nq'|Lastrasaetta|', nq'|Tabla Trueno|', nq'|우뢰플레이트|', nq'|Uroe Plate|', nq'|雷電石板 / 雷电石板|', nq'|Léidiàn Shíbǎn / Lèuihdihn Sehkbáan|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Binding Band|', 5 , q'|Increases the end of turn damage of partially trapping moves from 1/16 to ⅛ of the target's maximum HP.|' , nq'|しめつけバンド|', nq'|Shimetsuke Band|', nq'|Bande Étreinte|', nq'|Klammerband|', nq'|Legafascia|', nq'|Banda Atadura|', nq'|조임밴드|', nq'|Joim Band|', nq'|緊綁束帶 / 紧绑束带|', nq'|Jǐnbǎng Shùdài / Gánbóng Chūkdáai|', 144 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Snowball|', 6 , q'|Raises the holder's Attack by one stage after being hit by an Ice-type attack. Consumed after use.|' , nq'|ゆきだま|', nq'|Yukidama|', nq'|Boule de Neige|', nq'|Schneeball|', nq'|Palla di Neve|', nq'|Bola de Nieve|', nq'|눈덩이|', nq'|Nundeong-i|', nq'|雪球|', nq'|Xuěqiú / Syutkàuh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Harbor Mail|', 3 , q'|Mail with a nautical design. To be held by a Pokémon for delivery.|' , nq'|ハーバーメール|', nq'|Harbor Mail|', nq'|Lettre Port|', nq'|Hafenbrief|', nq'|Mess. Porto|', nq'|Carta Puerto|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Go-Goggles|', 3 , q'|A Key Item that allows the player to travel in sandstorm conditions. Unnecessary in Generations IV and V, as the player may enter sandstorm conditions without protection.|' , nq'|ゴーゴーゴーグル|', nq'|Go Go Goggle|', nq'|Lunettes Sable|', nq'|Wüstenglas|', nq'|Occhialoni|', nq'|Gafas Aislantes|', nq'|고고고글|', nq'|Go-Go Goggle|', nq'|ＧＯＧＯ護目鏡 / ＧＯＧＯ护目镜|', nq'|GOGO Hù Mùjìng / GOGO Wuh Muhkgeng|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Sun Stone|', 2 , q'|Can be used to evolve Sunkern, Gloom, Cottonee, Petilil, and Helioptile.|' , nq'|たいようのいし|', nq'|Taiyō no Ishi|', nq'|Pierre Soleil|', nq'|Sonnenstein|', nq'|Pietrasolare|', nq'|Piedra Solar|', nq'|태양의돌|', nq'|Taeyang-ui Dol|', nq'|日之石|', nq'|Rì-zhī Shí / Yaht-jī Sehk|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Parcel|', 4 , q'|To be delivered to rival. Contains two Town Maps.|' , nq'|おとどけもの|', nq'|Otodoke Mono|', nq'|Colis|', nq'|Paket|', nq'|Pacco|', nq'|Paquete|', nq'|전해줄물건|', nq'|Jeonhaejul Mulgeon|', nq'|包裹|', nq'|Bāoguǒ / Bāaugwó|', 1264 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Powder Jar|', 3 , q'|Stores Berry Powder made from Berry Crush.|' , nq'|こないれ|', nq'|Konaire|', nq'|Pot Poudre|', nq'|Puderdöschen|', nq'|Portafarina|', nq'|Bote Polvos|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Holo Caster|', 6 , q'|Allows the player to view hologram clips and communicate with others.|' , nq'|ホロキャスター|', nq'|Holo Caster|', nq'|Holokit|', nq'|Holo-Log|', nq'|Holovox|', nq'|Holomisor|', nq'|홀로캐시터|', nq'|Holo Caster|', nq'|全像投影通訊器*|'||chr(10)||nq'|全息影像通讯器|', nq'|Quánxiàng Tóuyǐng Tōngxùn Qì / Chyùhnjeuhng Tàuhyíng Tūngseun Hei*|'||chr(10)||nq'|Quánxī Yǐngxiàng Tōngxùn Qì|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dragon Fang|', 2 , q'|Raises the power of Dragon-type moves.|' , nq'|りゅうのキバ|', nq'|Ryū no Kiba|', nq'|Croc Dragon|', nq'|Drachenzahn|', nq'|Dentedidrago|', nq'|Colmillo Dragón|', nq'|용의이빨|', nq'|Yong-ui Ippal|', nq'|龍之牙 / 龙之牙|', nq'|Lóng-zhī Yá / Lùhng-jī Ngàh|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Premier Ball|', 3 , q'|A Poké Ball with special coloring. The Poké Mart cashier will give one to the player for free if ten or more standard Poké Balls are purchased.|' , nq'|プレミアボール|', nq'|Premier Ball|', nq'|Honor Ball|', nq'|Premierball|', nq'|Premier Ball|', nq'|Honor Ball|', nq'|프레미어볼|', nq'|Premier Ball|', nq'|紀念球 / 纪念球|', nq'|Jìniàn Qiú / Géinihm Kàuh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lycanium Z|', 7 , q'|Allows Lycanroc to upgrade Stone Edge to the special Z-Move Splintered Stormshards.|' , nq'|ルガルガンＺ|', nq'|Lugarugan-Z|', nq'|Lougarozélite|', nq'|Wolwerockium Z|', nq'|Lycanrochium Z|', nq'|Lycanrostal Z|', nq'|루가루암Z|', nq'|Rugaruam-Z|', nq'|鬃岩狼人Ｚ|', nq'|Zōngyánlángrén-Z / Jūngngàahmlòhngyàhn-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Tiny Mushroom|', 2 , q'|Exchangeable in return for services.|', q'|Formatted as TinyMushroom prior to Generation VI.|', nq'|ちいさなキノコ|', nq'|Chiisana Kinoko|', nq'|Petit Champi|', nq'|Minipilz|', nq'|Piccolo Fungo|', nq'|Mini Seta|', nq'|작은버섯|', nq'|Jageun Beoseot|', nq'|小蘑菇|', nq'|Xiǎo Mógū / Síu Mòhgū|', 1024 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Grass Gem|', 5 , q'|Increases the power of the holder's first Grass-type move by 50%, and is consumed after use.|' , nq'|くさのジュエル|', nq'|Kusa no Jewel|', nq'|Joyau Plante|', nq'|Pflanzenjuwel|', nq'|Bijouerba|', nq'|Gema Planta|', nq'|풀주얼|', nq'|Pul Jewel|', nq'|草之寶石 / 草之宝石|', nq'|Cǎo-zhī Bǎoshí / Chóu-jī Bóusehk|', 80 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Charcoal|', 2 , q'|Raises the power of Fire-type moves.|' , nq'|もくたん|', nq'|Mokutan|', nq'|Charbon|', nq'|Holzkohle|', nq'|Carbonella|', nq'|Carbón|', nq'|목탄|', nq'|Moktan|', nq'|木炭|', nq'|Mùtàn / Muhktaan|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dream Ball|', 5 , q'|Used to catch Pokémon in Entralink.|' , nq'|ドリームボール|', nq'|Dream Ball|', nq'|Rêve Ball|', nq'|Traumball|', nq'|Dream Ball|', nq'|Ensueño Ball|', nq'|드림볼|', nq'|Dream Ball|', nq'|夢境球 / 梦境球|', nq'|Mèngjìng Qiú / Muhnggíng Kàuh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Abomasite|', 6 , q'|Allows Abomasnow to Mega Evolve into Mega Abomasnow.|' , nq'|ユキノオナイト|', nq'|Yukinoonite|', nq'|Blizzarite|', nq'|Rexblisarnit|', nq'|Abomasnowite|', nq'|Abomasnowita|', nq'|눈설왕나이트|', nq'|Nunseolwangnite|', nq'|暴雪王進化石 / 暴雪王进化石|', nq'|Bàoxuěwáng Jìnhuà Shí / Bouhsyutwòhng Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Bug Memory|', 7 , q'|Makes Silvally a Bug-type Pokémon and makes Multi-Attack a Bug-type move.|' , nq'|バグメモリ|', nq'|Bug Memory|', nq'|ROM Insecte|', nq'|Käfer-Disc|', nq'|ROM Coleottero|', nq'|Disco Bicho|', nq'|버그메모리|', nq'|Bug Memory|', nq'|蟲子記憶碟*|'||chr(10)||nq'|虫子存储碟|', nq'|Chóngzǐ Jìyìdié / Chùhngjí Geiyīkdihp*|'||chr(10)||nq'|Chóngzǐ Cúnchúdié|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Eviolite|', 5 , q'|Raises the holder's Defense and Special Defense by 50% if the holder is capable of evolving.|' , nq'|しんかのきせき|', nq'|Shinka no Kiseki|', nq'|Évoluroc|', nq'|Evolith|', nq'|Evolcondensa|', nq'|Mineral Evol|', nq'|진화의 휘석|', nq'|Jinhwa-yi Hwiseok|', nq'|進化奇石 / 进化奇石|', nq'|Jìnhuà Qíshí / Jeunfa Kèihsehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Exp. Share|', 1 , q'|A held item that allows Pokémon to gain experience without battling.|', q'|Named Exp.All prior to Generation II.|', nq'|がくしゅうそうち|', nq'|Gakushū Sōchi|', nq'|Multi Exp|', nq'|EP-Teiler|', nq'|Condividi Esp.|', nq'|Repartir Exp|', nq'|학습장치|', nq'|Hakseup Jangchi|', nq'|學習裝置 / 学习装置|', nq'|Xuéxí Zhuāngzhì / Hohkjaahp Jōngji|', 1056 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Yellow Apricorn|', 2 , q'|If taken to Kurt, he will make the player a Moon Ball out of it.|', q'|Formatted as Ylw Apricorn prior to Generation VI.|', nq'|きぼんぐり|', nq'|Ki Bonguri|', nq'|Noigrume Jne|', nq'|Aprikoko Glb|', nq'|Ghicocca Gialla|', nq'|Bonguri Amarillo|', nq'|노랑규토리|', nq'|Norang Gyutori|', nq'|黃球果 / 黄球果|', nq'|Huáng Qiúguǒ / Wòhng Kàuhgwó|', 1072 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Normal Box|', 2 , q'|Sometimes held by reward Pokémon from clearing Gym Leader Castle in Pokémon Stadium when traded to Generation II or Pokémon Stadium 2.|' , nq'|きのはこ|', nq'|Ki no Hako|', nq'|Coffre Normal|', nq'|Schachtel|', nq'|Scat. Normale|', nq'|Caja Normal|', nq'|나무상자|', nq'|Namu Sangja|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Electrium Z|', 7 , q'|Allows a Pokémon to upgrade their Electric-type damaging moves to the Z-Move Gigavolt Havoc or upgrade their Electric-type status moves into Z-Moves. Makes Arceus an Electric-type Pokémon.|' , nq'|デンキＺ|', nq'|Electric-Z|', nq'|Voltazélite|', nq'|Voltium Z|', nq'|Electrium Z|', nq'|Electrostal Z|', nq'|전기Z|', nq'|Jeon-gi-Z|', nq'|電Ｚ / 电Ｚ|', nq'|Diàn-Z / Dihn-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dusk Ball|', 4 , q'|A type of Poké Ball that works especially well in dark places such as caves or at night.|' , nq'|ダークボール|', nq'|Dark Ball|', nq'|Sombre Ball|', nq'|Finsterball|', nq'|Scuro Ball|', nq'|Ocaso Ball|', nq'|다크볼|', nq'|Dark Ball|', nq'|黑暗球|', nq'|Hēi'àn Qiú / Hākam Kàuh|', 0 );
insert into ITEMS( NAME, GEN, GEN2, DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Machine Part|', 2, 3, q'|The missing part from the Power Plant (2) and take to the Power Plant to restore power to the Magnet Train (3)|' , nq'|きかいのぶひん|'||chr(10)||nq'|マシンパーツ|', nq'|Kikai no Buhin|'||chr(10)||nq'|Machine Part|', nq'|Partie de Machine|'||chr(10)||nq'|Piece Meca.|', nq'|Spule|'||chr(10)||nq'|Ersatzteil|', nq'|Pezzo macch.|'||chr(10)||nq'|Meccanismo|', nq'|Maquinaria|'||chr(10)||nq'|Pieza Esp.|', nq'|기계부품|', nq'|Gigye Bupum|', nq'|機械零件 / 机械零件|', nq'|Jīxiè Língjiàn / Gēihaaih Lìhnggín|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lucky Egg|', 2 , q'|Doubles the experience gained during battle.|' , nq'|しあわせタマゴ|', nq'|Shiawase Tamago|', nq'|Œuf Chance|', nq'|Glücks-Ei|', nq'|Fortunuovo|', nq'|Huevo Suerte|', nq'|행복의알|', nq'|Haengbogui Al|', nq'|幸運蛋 / 幸运蛋|', nq'|Xìngyùn Dàn / Hahngwahn Daahn|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Red Petal|', 7 , q'|A red petal required to complete Mina's Trial.|' , nq'|あかのはなびら|', nq'|Aka no Hanabira|', nq'|Pétale Rouge|', nq'|Rotes Blatt|', nq'|Petalo rosso|', nq'|Pétalo Rojo|', nq'|빨강꽃잎|', nq'|Ppalgang Kkochip|', nq'|紅色花瓣 / 红色花瓣|', nq'|Hóng-sè Huābàn / Hùhng-sīk Fāfáan|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Prison Bottle|', 6 , q'|Used to transform Hoopa Confined to Hoopa Unbound.|' , nq'|いましめのつぼ|', nq'|Imashime no Tsubo|', nq'|Vase Scellé|', nq'|Banngefäß|', nq'|Vaso del vincolo|', nq'|Vasija Castigo|', nq'|굴레의항아리|', nq'|Gulle-yi Hang-ari|', nq'|懲戒之壺 / 惩戒之壶|', nq'|Chéngjiè-zhī Hú / Chìhnggaai-jī Wùh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Destiny Knot|', 4 , q'|Infatuates the foe if the holder becomes infatuated.|' , nq'|あかいいと|', nq'|Akai Ito|', nq'|Nœud Destin|', nq'|Fatumknoten|', nq'|Destincomune|', nq'|Lazo Destino|', nq'|빨간실|', nq'|Ppalgan Sil|', nq'|紅線 / 红线|', nq'|Hóngxiàn / Hùhngsin|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|BridgeMail S|', 5 , q'|Stationary with a sky-piercing bridge print. To be held by a Pokémon for delivery.|' , nq'|ブリッジメールＳ|', nq'|Bridge Mail S|', nq'|Lettre PontS|', nq'|Brückbrief H|', nq'|Mess. Frec.|', nq'|C. Puente S|', nq'|브리지메일S|', nq'|Bridge Mail S|', nq'|橋梁郵件Ｓ / 桥梁邮件Ｓ|', nq'|Qiáoliáng Yóujiàn S / Kìuhlèuhng Yàuhgín S|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Escape Rope|', 1 , q'|Teleports the player out of a cave or dungeon if the player cannot find the way out.|' , nq'|あなぬけのヒモ|', nq'|Ananuke no Himo|', nq'|Corde Sortie|', nq'|Fluchtseil|', nq'|Fune di Fuga|', nq'|Cuerda Huida|', nq'|동굴탈출로프|', nq'|Donggul Talchul Rope|', nq'|離洞繩 / 离洞绳|', nq'|Lídòng Shéng / Lèihduhng Sìhng|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pecha Berry|', 3 , q'|Cures poison.|' , nq'|モモンのみ|', nq'|Momon no Mi|', nq'|Baie Pecha|', nq'|Pirsifbeere|', nq'|Baccapesca|', nq'|Baya Meloc|', nq'|복슝열매|', nq'|Boksyung Yeolmae|', nq'|桃桃果|', nq'|Táotáo Guǒ / Tòuhtòuh Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Medichamite|', 6 , q'|Allows Medicham to Mega Evolve into Mega Medicham.|' , nq'|チャーレムナイト|', nq'|Charemnite|', nq'|Charminite|', nq'|Meditalisnit|', nq'|Medichamite|', nq'|Medichamita|', nq'|요가램나이트|', nq'|Yogaramnite|', nq'|恰雷姆進化石 / 恰雷姆进化石|', nq'|Qiàléimǔ Jìnhuà Shí / Hāplèuihmóuh Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pink Apricorn|', 2 , q'|Kurt will make a Love Ball out of it.|', q'|Formatted as Pnk Apricorn prior to Generation VI.|', nq'|ももぼんぐり|', nq'|Momo Bonguri|', nq'|Noigrume Ros|', nq'|Aprikoko Pnk|', nq'|Ghicocca Rosa|', nq'|Bonguri Rosa|', nq'|담홍규토리|', nq'|Damhong Gyutori|', nq'|粉球果|', nq'|Fěn Qiúguǒ / Fán Kàuhgwó|', 1072 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Beedrillite|', 6 , q'|Allows Beedrill to Mega Evolve into Mega Beedrill.|' , nq'|スピアナイト|', nq'|Speanite|', nq'|Dardargnite|', nq'|Bibornit|', nq'|Beedrillite|', nq'|Beedrillita|', nq'|독침붕나이트|', nq'|Tokchimbungnite|', nq'|大針蜂進化石 / 大针蜂进化石|', nq'|Dàzhēnfēng Jìnhuà Shí / Daaihjāmfūng Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Plume Fossil|', 5 , q'|A Fossil from which an Archen can be resurrected.|' , nq'|はねのカセキ|', nq'|Hane no Kaseki|', nq'|Fossile Plume|', nq'|Federfossil|', nq'|Fossilpiuma|', nq'|Fósil Pluma|', nq'|날개화석|', nq'|Nalgae Hwaseok|', nq'|羽毛化石|', nq'|Yǔmáo Huàshí / Yúhmòuh Fasehk|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Power Herb|', 4 , q'|Allows user to skip first turn of moves that require charging.|' , nq'|パワフルハーブ|', nq'|Powerful Herb|', nq'|Herbe Pouvoir|', nq'|Energiekraut|', nq'|Vigorerba|', nq'|Hierba Única|', nq'|파워풀허브|', nq'|Powerful Herb|', nq'|強力香草 / 强力香草|', nq'|Qiánglì Xiāngcǎo / Kèuhnglihk Hēungchóu|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Park Ball|', 4 , q'|A type of Poké Ball that is used to recapture Generation III Pokémon in the Pal Park.|' , nq'|パークボール|', nq'|Park Ball|', nq'|Parc Ball|', nq'|Parkball|', nq'|Parco Ball|', nq'|Parque Ball|', nq'|파크볼|', nq'|Park Ball|', nq'|公園球 / 公园球|', nq'|Gōngyuán Qiú / Gūngyún Kàuh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Gardevoirite|', 6 , q'|Allows Gardevoir to Mega Evolve into Mega Gardevoir.|' , nq'|サーナイトナイト|', nq'|Sirknightnite|', nq'|Gardevoirite|', nq'|Guardevoirnit|', nq'|Gardevoirite|', nq'|Gardevoirita|', nq'|가디안나이트|', nq'|Gadiannite|', nq'|沙奈朵進化石 / 沙奈朵进化石|', nq'|Shānàiduǒ Jìnhuà Shí / Sānoihdó Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Energy Powder|', 2 , q'|Restores 50 HP, but lowers friendship.|', q'|Formatted as EnergyPowder prior to Generation VI.|', nq'|ちからのこな|', nq'|Chikara no Kona|', nq'|Poudre Énergie|', nq'|Energiestaub|', nq'|Polvenergia|', nq'|Polvo Energía|', nq'|힘의가루|', nq'|Himui Garu|', nq'|元氣粉 / 元气粉|', nq'|Yuánqì Fěn / Yùhnhei Fán|', 1168 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Magma Emblem|', 3 , q'|Allows entrance into the Team Magma Hideout.|' , nq'|マグマのしるし|', nq'|Magma no Shirushi|', nq'|Emblème Magma|', nq'|Magmaemblem|', nq'|Stemma Magma|', nq'|Signo Magma|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Red Scarf|', 3 , q'|Raises the Cool condition.|' , nq'|あかいバンダナ|', nq'|Akai Bandana|', nq'|Foul. Rouge|', nq'|Roter Schal|', nq'|Fascia Rossa|', nq'|Pañuelo Rojo|', nq'|빨강밴드|', nq'|Ppalgang Band|', nq'|紅色頭巾 / 红色头巾|', nq'|Hóng-sè Tóujīn / Hùhng-sīk Tàuhgān|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Gracidea|', 4 , q'|Allows Shaymin to change form.|' , nq'|グラシデアのはな|', nq'|Gracidea no Hana|', nq'|Gracidée|', nq'|Gracidea|', nq'|Gracidea|', nq'|Gracídea|', nq'|그라시데아꽃|', nq'|Gracidea Kkot|', nq'|葛拉西蒂亞花 / 葛拉西蒂亚花|', nq'|Gélāxīdìyǎ Huā / Gotlāaisāidaia Fā|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Nomel Berry|', 3 , q'|Pokéblock and Poffin ingredient.|' , nq'|ノメルのみ|', nq'|Nomel no Mi|', nq'|Baie Tronci|', nq'|Tronzibeere|', nq'|Baccalemon|', nq'|Baya Monli|', nq'|노멜열매|', nq'|Nomel Yeolmae|', nq'|檬檸果 / 檬柠果|', nq'|Méngníng Guǒ / Mūngnìhng Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Gold Bottle Cap|', 7 , q'|Can be traded to Mr. Hyper to maximize all of a Pokémon's IVs in Hyper Training.|' , nq'|きんのおうかん|', nq'|Kin no Ōkan|', nq'|Capsule d'Or|', nq'|Goldkronkorken|', nq'|Tappo d'oro|', nq'|Chapa Dorada|', nq'|금왕관|', nq'|Geum Wanggwan|', nq'|金色王冠|', nq'|Jīnsè Wángguān / Gāmsīk Wòhnggūn|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dragonium Z|', 7 , q'|Allows a Pokémon to upgrade their Dragon-type damaging moves to the Z-Move Devastating Drake or upgrade their Dragon-type status moves into Z-Moves. Makes Arceus a Dragon-type Pokémon.|' , nq'|ドラゴンＺ|', nq'|Dragon-Z|', nq'|Dracozélite|', nq'|Dracium Z|', nq'|Draconium Z|', nq'|Dracostal Z|', nq'|드개곤Z|', nq'|Dragon-Z|', nq'|龍Ｚ / 龙Ｚ|', nq'|Lóng-Z / Lùhng-Z|', 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Roto Bargain|' , nq'|やすうりポン|', nq'|Yasu'uri Pon|', nq'|Moti-Promo|', nq'|Schnäppchenbon|', nq'|Sconto'n'roll|', nq'|Cupón Rebaja|', nq'| ???|', nq'| ???|', nq'|優惠碰碰 / 优惠碰碰|', nq'|Yōuhuì Pèngpèng / Yāuwaih Pungpung|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Revive|', 1 , q'|Revives a Pokémon to half of maximum HP.|' , nq'|げんきのかけら|', nq'|Genki no Kakera|', nq'|Rappel|', nq'|Beleber|', nq'|Revitalizzante|', nq'|Revivir|', nq'|기력의조각|', nq'|Giryeog-ui Jogak|', nq'|活力碎片|', nq'|Huólì Suìpiàn / Wuhtlihk Seuipín|', 32 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Audinite|', 6 , q'|Allows Audino to Mega Evolve into Mega Audino.|' , nq'|タブンネナイト|', nq'|Tabunnenite|', nq'|Nanméouïte|', nq'|Ohrdochnit|', nq'|Audinite|', nq'|Audinita|', nq'|다부니나이트|', nq'|Dabunienite|', nq'|差不多娃娃進化石 / 差不多娃娃进化石|', nq'|Chàbùduōwáwá Jìnhuà Shí / Chābātdōwāwā Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pikashunium Z|', 7 , q'|Allows Pikachu in a cap to upgrade Thunderbolt to the special Z-Move 10,000,000 Volt Thunderbolt.|' , nq'|サトピカＺ|', nq'|Satopika-Z|', nq'|Pikachazélite|', nq'|Ash-Pikachium Z|', nq'|Ashpikacium Z|', nq'|Ash-Pikastal Z|', nq'|지우피카Z|', nq'|Jiupika-Z|', nq'|智皮卡Ｚ|', nq'|Zhìpíkǎ-Z / Jipèihkā-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Houndoominite|', 6 , q'|Allows Houndoom to Mega Evolve into Mega Houndoom.|' , nq'|ヘルガナイト|', nq'|Hellganite|', nq'|Démolossite|', nq'|Hundemonit|', nq'|Houndoomite|', nq'|Houndoomita|', nq'|헬가나이트|', nq'|Helganite|', nq'|黑魯加進化石 / 黑鲁加进化石|', nq'|Hēilǔjiā Jìnhuà Shí / Hāklóuhgā Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Rich Mulch|', 6 , q'|When applied to a Berry patch, increases the final Berry harvest by 2 Berries.|' , nq'|たわわこやし|', nq'|Tawawa Koyashi|', nq'|Fertibondance|', nq'|Sprießmulch|', nq'|Fertilflorido|', nq'|Abono Fértil|', nq'|주렁주렁비료|', nq'|Jureong-jureong Biryo|', nq'|碩果肥 / 硕果肥|', nq'|Shuòguǒ Féi / Sehkgwó Fèih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Persim Berry|', 3 , q'|Cures confusion.|' , nq'|キーのみ|', nq'|Kī no Mi|', nq'|Baie Kika|', nq'|Persimbeere|', nq'|Baccaki|', nq'|Baya Caquic|', nq'|시몬열매|', nq'|Simmon Yeolmae|', nq'|柿仔果|', nq'|Shìzǐ Guǒ / Chíhjái Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Silver Leaf|', 2 , q'|May be held by a Pokémon transferred from Generation I.|' , nq'|ぎんのはっぱ|', nq'|Gin no Happa|', nq'|Feuille Arg.|', nq'|Silberblatt|', nq'|Fogliargento|', nq'|Hoja Plata|', nq'|은빛나뭇잎|', nq'|Eunbit Namunnip|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Occa Berry|', 4 , q'|Reduces damage taken from a super effective Fire-type move.|' , nq'|オッカのみ|', nq'|Occa no Mi|', nq'|Baie Chocco|', nq'|Koakobeere|', nq'|Baccacao|', nq'|Baya Caoca|', nq'|오카열매|', nq'|Oca Yeolmae|', nq'|巧可果|', nq'|Qiǎokě Guǒ / HáauhóGwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Cry Analyzer|', 3 , q'|Detaches certain translators.|' , nq'|かいどくそうち|', nq'|Kaidoku Sōchi|', nq'|Decodeur Cri|', nq'|Stimmkenner|', nq'|Analiz.Verso|', nq'|Gritolector|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Explorer Kit|', 4 , q'|A Key Item which can be used to go to Sinnoh Underground.|' , nq'|たんけんセット|', nq'|Tanken Set|', nq'|Explorakit|', nq'|Forschersack|', nq'|Esplorokit|', nq'|Kit Explor.|', nq'|탐험세트|', nq'|Tamheom Set|', nq'|探險組合*|'||chr(10)||nq'|探险套装|', nq'|Tànxiǎn Zǔhé / Taamhím Jóuhahp*|'||chr(10)||nq'|Tànxiǎn Tàozhuāng|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Hyper Potion|', 1 , q'|Restores 120 HP. (200HP before Gen. VII).|' , nq'|すごいキズぐすり|', nq'|Sugoi Kizugusuri|', nq'|Hyper Potion|', nq'|Hypertrank|', nq'|Iperpozione|', nq'|Hiperpoción|', nq'|고급상처약|', nq'|Gogeup Sangcheo Yak|', nq'|厲害傷藥 / 厉害伤药|', nq'|Lìhài Shāngyào / Leihhhoih Sēungyeuhk|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Metal Powder|', 2 , q'|Raises Ditto's Defense.|' , nq'|メタルパウダー|', nq'|Metal Powder|', nq'|Poudre Metal|', nq'|Metallstaub|', nq'|Metalpolvere|', nq'|Polvo Metálico|', nq'|금속파우더|', nq'|Geumsok Powder|', nq'|金屬粉 / 金属粉|', nq'|Jīnshǔ Fěn / Gāmsuhk Fán|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Skull Fossil|', 4 , q'|A Fossil from which a Cranidos can be resurrected.|' , nq'|ずがいのカセキ|', nq'|Zugai no Kaseki|', nq'|Fossile Crâne|', nq'|Kopffossil|', nq'|Fossilcranio|', nq'|Fósil Cráneo|', nq'|두개의화석|', nq'|Dugae-ui Hwaseok|', nq'|頭蓋化石 / 头盖化石|', nq'|Tóugài Huàshí / Tàuhgoi Fasehk|', 128 );
insert into ITEMS( NAME, GEN, GEN2, DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Card Key|', 2, 3, q'|Allows the player to access more rooms in the Silph Co. headquarters (1), the third floor of Radio Tower while it is under siege by Team Rocket (2), and east wing of the Shadow PKMN Lab (3).|' , nq'|カードキー|', nq'|Card Key|', nq'|Carte Magn.|'||chr(10)||nq'|Cle Magnetique|', nq'|Türöffner|'||chr(10)||nq'|Schlüsselkarte|', nq'|Apriporta|', nq'|Llave Magnética|'||chr(10)||nq'|T. Magnética|', nq'|카드키|', nq'|Card Key|', nq'|鑰匙卡 / 钥匙卡|', nq'|Yàoshi Kǎ / Yeuhksìh Kāat|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Electirizer|', 4 , q'|A hold item that allows Electabuzz to evolve when traded.|' , nq'|エレキブースター|', nq'|Elec Booster|', nq'|Électiriseur|', nq'|Stromisierer|', nq'|Elettritore|', nq'|Electrizador|', nq'|에레키부스터|', nq'|Elec Booster|', nq'|電力增幅器 / 电力增幅器|', nq'|Diànlì Zēngfú Qì / Dihnlihk Jāngfūk Hei|', 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Roto Exp. Points|' , nq'|けいけんポン|', nq'|Keiken Pon|', nq'|Molti-Exp|', nq'|EP-Bon|', nq'|Esp'n'roll|', nq'|Cupón Exp|', nq'| ???|', nq'| ???|', nq'|經驗碰碰 / 经验碰碰|', nq'|Jīngyàn Pèngpèng / Gīngyihm Pungpung|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Slowbronite|', 6 , q'|Allows Slowbro to Mega Evolve into Mega Slowbro.|' , nq'|ヤドランナイト|', nq'|Yadorannite|', nq'|Flagadossite|', nq'|Lahmusnit|', nq'|Slowbroite|', nq'|Slowbronita|', nq'|야도란나이트|', nq'|Yadonrannite|', nq'|呆殼獸進化石 / 呆壳兽进化石|', nq'|Dāikéshòu Jìnhuà Shí / Ngòihhoksau Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Relic Gold|', 5 , q'|Can be sold for 10000 to the villa owner in Undella Town.|' , nq'|こだいのきんか|', nq'|Kodai no Kinka|', nq'|Vieux Ducat|', nq'|Alter Dukat|', nq'|Doblonantico|', nq'|Real Oro|', nq'|고대의금화|', nq'|Godae-yi Geumhwa|', nq'|古代金幣 / 古代金币|', nq'|Gǔdài Jīnbì / Gúdoih Gāmbaih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Azure Flute|', 4 , q'|Key Item used to access the Hall of Origin and face Arceus.|' , nq'|てんかいのふえ|', nq'|Tenkai no Fue|', nq'|Flûte Azur|', nq'|Azurflöte|', nq'|Flauto Cielo|', nq'|Flauta Azur|', nq'|천계의 피리|', nq'|Cheongye-ui Piri|', nq'|天界之笛|', nq'|Tiānjiè-zhī Dí / Tīngaai-jī Dehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Latiosite|', 6 , q'|Allows Latios to Mega Evolve into Mega Latios.|' , nq'|ラティオスナイト|', nq'|Latiosnite|', nq'|Latiosite|', nq'|Latiosnit|', nq'|Latiosite|', nq'|Latiosita|', nq'|라티오스나이트|', nq'|Latiosnite|', nq'|拉帝歐斯進化石 / 拉帝欧斯进化石|', nq'|Lādì'ōusī Jìnhuà Shí / Lāaidai'āusī Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Calcium|', 1 , q'|Raises the Special Attack of a Pokémon.|' , nq'|リゾチウム|', nq'|Lysozyme|', nq'|Calcium|', nq'|Kalzium|', nq'|Calcio|', nq'|Calcio|', nq'|리보플라빈|', nq'|Riboflavin|', nq'|特攻增強劑 / 特攻增强剂|', nq'|Tègōng Zēngqiángjì / Dahkgūng Jāngkèuhngjaih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Grass Mail|', 4 , q'|Mail with a grass pattern. To be held by a Pokémon for delivery.|' , nq'|グラスメール|', nq'|Grass Mail|', nq'|Lettre Herbe|', nq'|Wiesenbrief|', nq'|Mess. Erba|', nq'|Carta Hierba|', nq'|잔디메일|', nq'|Jandi Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Wise Glasses|', 4 , q'|Raises the power of special moves.|' , nq'|ものしりメガネ|', nq'|Monoshiri Megane|', nq'|Lunettes Sages|', nq'|Schlauglas|', nq'|Saviocchiali|', nq'|Gafas Especiales|', nq'|박식안경|', nq'|Baksik An-gyeong|', nq'|博識眼鏡 / 博识眼镜|', nq'|Bóshì Yǎnjìng / Boksīk Ngáahngeng|', 144 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Shell Bell|', 3 , q'|Restores HP to the holder based on damage inflicted to the opponent.|' , nq'|かいがらのすず|', nq'|Kaigara no Suzu|', nq'|Grelot Coque|', nq'|Seegesang|', nq'|Conchinella|', nq'|Campana Concha|', nq'|조개껍질방울|', nq'|Jogaekkeopjil Bang-ul|', nq'|貝殼之鈴 / 贝壳之铃|', nq'|Bèiké-zhī Líng / Buihok-jī Lìhng|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Damp Rock|', 4 , q'|Increases the duration of heavy rain.|' , nq'|しめったいわ|', nq'|Shimetta Iwa|', nq'|Roche Humide|', nq'|Nassbrocken|', nq'|Rocciaumida|', nq'|Roca Lluvia|', nq'|축축한바위|', nq'|Chukchukhan Bawi|', nq'|潮濕岩石 / 潮湿岩石|', nq'|Cháoshī Yánshí / Chìuhsāp Ngàahmsehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Grassium Z|', 7 , q'|Allows a Pokémon to upgrade their Grass-type damaging moves to the Z-Move Bloom Doom or upgrade their Grass-type status moves into Z-Moves. Makes Arceus a Grass-type Pokémon.|' , nq'|クサＺ|', nq'|Grass-Z|', nq'|Florazélite|', nq'|Botanium Z|', nq'|Herbium Z|', nq'|Fitostal Z|', nq'|풀Z|', nq'|Pul-Z|', nq'|草Ｚ|', nq'|Cǎo-Z / Chóu-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|PRZCureBerry|', 2 , q'|Cures paralysis.|' , nq'|まひなおしのみ|', nq'|Mahinaoshi no Mi|', nq'|Baie AntiPAR|', nq'|AntiPARBeere|', nq'|Baccantipar.|', nq'|Antiparabaya|', nq'|마비치료열매|', nq'|Mabi Chiryo Yeolmae|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Muscle Wing|', 5 , q'|Raises the Attack of a Pokémon.|' , nq'|きんりょくのハネ|', nq'|Kinryoku no Hane|', nq'|Aile Force|', nq'|Kraftfeder|', nq'|Piumpotenza|', nq'|Pluma Músculo|', nq'|근력날개|', nq'|Geunryeok Nalgae|', nq'|肌力之羽|', nq'|Jīlì-zhī Yǔ / Gēilihk-jī Yúh|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Watmel Berry|', 3 , q'|Pokéblock and Poffin ingredient.|' , nq'|カイスのみ|', nq'|Kaisu no Mi|', nq'|Baie Stekpa|', nq'|Wasmelbeere|', nq'|Baccacomero|', nq'|Baya Sambia|', nq'|슈박열매|', nq'|Syubak Yeolmae|', nq'|瓜西果|', nq'|Guāxī Guǒ / Gwāsāi Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Max Potion|', 1 , q'|Restores all of a Pokémon's HP.|' , nq'|まんたんのくすり|', nq'|Mantan no Kusuri|', nq'|Potion Max|', nq'|Top-Trank|', nq'|Pozione Max|', nq'|Máxima Poción|', nq'|풀회복약|', nq'|Full Hoebok Yak|', nq'|全滿藥 / 全满药|', nq'|Quánmǎn Yào / Chyùhnmúhn Yeuhk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Psychium Z|', 7 , q'|Allows a Pokémon to upgrade their Psychic-type damaging moves to the Z-Move Shattered Psyche or upgrade their Psychic-type status moves into Z-Moves. Makes Arceus a Psychic-type Pokémon.|' , nq'|エスパーＺ|', nq'|Esper-Z|', nq'|Psychézélite|', nq'|Psium Z|', nq'|Psichium Z|', nq'|Psicostal Z|', nq'|에스퍼Z|', nq'|Esper-Z|', nq'|超能力Ｚ|', nq'|Chāonénglì-Z / Chīunàhnglihk-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dragon Scale|', 2 , q'|A hold item that allows Seadra to evolve when traded.|' , nq'|りゅうのウロコ|', nq'|Ryū no Uroko|', nq'|Écaille Draco|', nq'|Drachenhaut|', nq'|Squama Drago|', nq'|Escamadragón|', nq'|용의비늘|', nq'|Yong-ui Bineul|', nq'|龍之鱗片 / 龙之鳞片|', nq'|Lóng zhī línpiàn / Lùhng-jī Lèuhnpin|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pair of Tickets|', 6 , q'|Allows entry for two to the Mossdeep Space Center for the Litleonid star show.|' , nq'|ペアチケット|', nq'|Pair Ticket|', nq'|Ticket Duo|', nq'|Zweierticket|', nq'|Biglietto doppio|', nq'|Entrada para dos|', nq'|페어티켓|', nq'|Pair of Tickets|', nq'|雙人票 / 双人票|', nq'|Shuāngrén Piào / Sēungyàhn Piu|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Favored Mail|', 5 , q'|Stationary designed for writing about your favorite things. To be held by a Pokémon for delivery.|' , nq'|だいすきメール|', nq'|Daisuki Mail|', nq'|Lettre Fan|', nq'|Faiblebrief|', nq'|Mess. TVB|', nq'|C. Favoritos|', nq'|애호메일|', nq'|Aeho Mail|', nq'|喜愛郵件 / 喜爱邮件|', nq'|Xǐ'ài Yóujiàn / Héi'oi Yàuhgín|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Music Mail|', 2 , q'|Mail with a Natu design. Only available through Mystery Gift. To be held by a Pokémon for delivery.|' , nq'|おんぷメール|', nq'|Onpu Mail|', nq'|Lettre Musique|', nq'|Melodiebrief|', nq'|Mess. Musica|', nq'|Carta Música|', nq'|음표메일|', nq'|Eumpyo Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|U-Disk|', 3 , q'|Moves the UFO in The Under to Pyrite Town's windmill.|' , nq'|Ｕ－ディスク|', nq'|U-Disk|', nq'|Disque-H|', nq'|O-Disc|', nq'|Disco Su|', nq'|Disco S|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Mewtwonite Y|', 6 , q'|Allows Mewtwo to Mega Evolve into Mega Mewtwo Y.|' , nq'|ミュウツナイトY|', nq'|Mewtwonite Y|', nq'|Mewtwoïte Y|', nq'|Mewtunit Y|', nq'|Mewtwoite Y|', nq'|Mewtwoita Y|', nq'|뮤츠나이트Y|', nq'|Mewtwonite Y|', nq'|超夢進化石Y / 超梦进化石Y|', nq'|Chāomèng Jìnhuà Shí Y / Chīumuhng Jeunfa Sehk Y|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Relic Statue|', 5 , q'|Can be sold for 200000 to the villa owner in Undella Town.|' , nq'|こだいのせきぞう|', nq'|Kodai no Sekizō|', nq'|Vieux Santon|', nq'|Alte Statue|', nq'|Statuantica|', nq'|Efigie Antigua|', nq'|고대의석상|', nq'|Godae-yi Seoksang|', nq'|古代石像|', nq'|Gǔdài Shíxiàng / Gúdoih Sehkjeuhng|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Full Incense|', 4 , q'|Causes holder to move slower than the opponent. A Snorlax holding it can breed to produce Munchlax.|' , nq'|まんぷくおこう|', nq'|Manpuku Okō|', nq'|Encens Plein|', nq'|Lahmrauch|', nq'|Gonfioaroma|', nq'|Incienso lento|', nq'|만복향로|', nq'|Manbok Hyangno|', nq'|飽腹薰香 / 饱腹薰香|', nq'|Bǎofù Xūnxiāng / Báaufūk Fānhēung|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Prism Scale|', 5 , q'|A hold item that allows Feebas to evolve when traded.|' , nq'|きれいなウロコ|', nq'|Kireina Uroko|', nq'|Bel'Écaille|', nq'|Schönschuppe|', nq'|Squama Bella|', nq'|Escama Bella|', nq'|고운비늘|', nq'|Goun Bineul|', nq'|美麗鱗片 / 美丽鳞片|', nq'|Měilì Línpiàn / Méihlaih Lèuhnpin|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lax Incense|', 3 , q'|Lowers the foe's accuracy. A Wobbuffet holding it can breed to produce a Wynaut.|' , nq'|のんきのおこう|', nq'|Nonki no Okou|', nq'|Encens Doux|', nq'|Laxrauch|', nq'|Distraroma|', nq'|Incienso suave|', nq'|무사태평향로|', nq'|Musataepyeong Hyangno|', nq'|悠閒薰香 / 悠闲薰香|', nq'|Yōuxián Xūnxiāng / Yàuhhàahn Fānhēung|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Heracronite|', 6 , q'|Allows Heracross to Mega Evolve into Mega Heracross.|' , nq'|ヘラクロスナイト|', nq'|Heracrosnite|', nq'|Scarhinoïte|', nq'|Skarabornit|', nq'|Heracrossite|', nq'|Heracrossita|', nq'|헤라크로스나이트|', nq'|Heracrossnite|', nq'|赫拉剋羅斯進化石 / 赫拉克罗斯进化石|', nq'|Hèlākèluósī Jìnhuà Shí / Hāklāaihāklòhsī Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Red Apricorn|', 2 , q'|Kurt will make a Level Ball out of it.|' , nq'|あかぼんぐり|', nq'|Aka Bonguri|', nq'|Noigrume Rge|', nq'|Aprikoko Rot|', nq'|Ghicocca Rossa|', nq'|Bonguri Rojo|', nq'|빨간규토리|', nq'|Ppalgan Gyutori|', nq'|紅球果 / 红球果|', nq'|Hóng Qiúguǒ / Hùhng Kàuhgwó|', 48 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Liechi Berry|', 3 , q'|Raises Attack when HP is below ⅓ of maximum.|' , nq'|チイラのみ|', nq'|Chyla no Mi|', nq'|Baie Lichii|', nq'|Lydzibeere|', nq'|Baccalici|', nq'|Baya Lichi|', nq'|치리열매|', nq'|Cheely Yeolmae|', nq'|枝荔果|', nq'|Zhīlì Guǒ / Jīlaih Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Retro Mail|', 3 , q'|Mail with a picture of the three Kanto Starter Pokémon.|' , nq'|レトロメール|', nq'|Retro Mail|', nq'|Lettre Retro|', nq'|Retrobrief|', nq'|Mess. Retro|', nq'|Carta Retro|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Portraitmail|', 2 , q'|Mail that contains a silhouette of the Pokémon holding it. To be held by a Pokémon for delivery.|' , nq'|にがおえメール|', nq'|Nigaoe Mail|', nq'|LetrPortrait|', nq'|Portraitbrief|', nq'|Mess. Ritratto|', nq'|Cart-Retrato|', nq'|초상화메일|', nq'|Chosanghwa Mail|' , 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Left Poké Ball|' , nq'|のこされたボール|', nq'|Nokosareta Ball|', nq'|Poké Ball donnée|', nq'|Nachlassball|', nq'|Poké Ball altrui|', nq'|Poké Ball Ajena|', nq'|남겨진 볼|', nq'|Namgyeojin Ball|', nq'|留下的精靈球 / 留下的精灵球|', nq'|Liúxià-de Jīnglíngqiú / Làuhhah-dīk Jīnglìhng Kàuh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pidgeotite|', 6 , q'|Allows Pidgeot to Mega Evolve into Mega Pidgeot.|' , nq'|ピジョットナイト|', nq'|Pigeotnite|', nq'|Roucarnagite|', nq'|Taubossnit|', nq'|Pidgeotite|', nq'|Pidgeotita|', nq'|피죤투나이트|', nq'|Pijontoonite|', nq'|大比鳥進化石 / 大比鸟进化石|', nq'|Dàbǐniǎo Jìnhuà Shí / Daaihbéiníuh Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Bicycle|', 1 , q'|Can be used to travel quickly. Cannot be ridden in swamps, or in very tall grass.|' , nq'|じてんしゃ|', nq'|Jitensha|', nq'|Bicyclette|', nq'|Fahrrad|', nq'|Bicicletta|', nq'|Bici|', nq'|자전거|', nq'|Jajeon-geo|', nq'|自行車 / 自行车|', nq'|Zìxíngchē / Jihhàhngchē|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Protein|', 1 , q'|Raises the Attack of a Pokémon.|' , nq'|タウリン|', nq'|Taurine|', nq'|Proteine|', nq'|Protein|', nq'|Proteina|', nq'|Proteína|', nq'|타우린|', nq'|Taurine|', nq'|攻擊增強劑 / 攻击增强剂|', nq'|Gōngjí Zēngqiángjì / Gūnggīk Jāngkèuhngjaih|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Purple Petal|', 7 , q'|A purple petal required to complete Mina's Trial.|' , nq'|むらさきはなびら|', nq'|Murasaki Hanabira|', nq'|Pétale Violet|', nq'|Violettes Blatt|', nq'|Petalo violetto|', nq'|Pétalo Violeta|', nq'|보라꽃잎|', nq'|Bora Kkochip|', nq'|紫色花瓣|', nq'|Zǐ-sè Huābàn / Jí-sīk Fāfáan|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pal Pad|', 4 , q'|Used to record friends on Nintendo Wi-Fi Connection and register Friend Codes.|' , nq'|ともだちてちょう|', nq'|Tomodachi Techō|', nq'|Registre Ami|', nq'|Adressbuch|', nq'|Blocco Amici|', nq'|Bloc amigos|', nq'|친구수첩|', nq'|Chingu Sucheop|', nq'|朋友手冊 / 朋友手册|', nq'|Péngyǒu Shǒucè / Pàhngyáuh Sáuchaak|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Ganlon Berry|', 3 , q'|Raises Defense if HP is below ⅓ of maximum.|' , nq'|リュガのみ|', nq'|Ryuga no Mi|', nq'|Baie Lingan|', nq'|Linganbeere|', nq'|Baccalongan|', nq'|Baya Gonlan|', nq'|용아열매|', nq'|Yong'a Yeolmae|', nq'|龍睛果 / 龙睛果|', nq'|Lóngjīng Guǒ / Lùhngjīng Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Cell Battery|', 5 , q'|Raises the holder's Attack one stage when hit with an Electric-type attack. Consumed after use.|' , nq'|じゅうでんち|', nq'|Jūdenchi|', nq'|Pile|', nq'|Akku|', nq'|Ricaripila|', nq'|Pila|', nq'|충전지|', nq'|Chungjeonji|', nq'|充電電池 / 充电电池|', nq'|Chōngdiàn Diànchí / Chūngdihn Dihnchìh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Water Gem|', 5 , q'|Increases the power of the holder's first Water-type move by 50%, and is consumed after use.|' , nq'|みずのジュエル|', nq'|Mizu no Jewel|', nq'|Joyau Eau|', nq'|Wasserjuwel|', nq'|Bijouacqua|', nq'|Gema Agua|', nq'|물주얼|', nq'|Mul Jewel|', nq'|水之寶石 / 水之宝石|', nq'|Shuǐ-zhī Bǎoshí / Séui-jī Bóusehk|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Ein File S|', 3 , q'|Describes Shadow Pokémon.|' , nq'|ボルグファイルＤ|', nq'|Borg File D|', nq'|Dossier Teck O|', nq'|Culpa-Akte C-P|', nq'|Genus.File O|', nq'|Parte Ein: O|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Master Ball|', 1 , q'|A rare type of Poké Ball that catches any wild Pokémon without fail. Generally available only once in the game, though it may be obtained again in very unlikely situations (such as winning the lottery), cheating, or on the GTS in Generation IV.|' , nq'|マスターボール|', nq'|Master Ball|', nq'|Master Ball|', nq'|Meisterball|', nq'|Master Ball|', nq'|Master Ball|', nq'|마스터볼|', nq'|Master Ball|', nq'|大師球 / 大师球|', nq'|Dàshī Qiú / Daaihsī Kàuh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Miror Radar|', 3 , q'|Keeps track of Miror B.|' , nq'|ミラーボレーダー|', nq'|Mirorbo Radar|', nq'|Radar Disco|', nq'|Queen-Radar|', nq'|Discoradar|', nq'|Radar Discal|' , 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Roto Encounter|' , nq'|みっけポン|', nq'|Mikke Pon|', nq'|Moti-Appât|', nq'|Lockbon|', nq'|Incontra'n'roll|', nq'|Cupón Reclamo|', nq'| ???|', nq'| ???|', nq'|相遇碰碰|', nq'|Xiāngyù Pèngpèng / Sēungyuh Pungpung|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Rocky Helmet|', 5 , q'|Any contact moves against the holder will deal 1/6 damage to the attacker.|' , nq'|ゴツゴツメット|', nq'|Gotsugotsu Met|', nq'|Casque Brut|', nq'|Beulenhelm|', nq'|Bitorzolelmo|', nq'|Casco Dentado|', nq'|울퉁불퉁멧|', nq'|Ultungbultung-Met|', nq'|凸凸頭盔 / 凸凸头盔|', nq'|Tūtū Tóukuī / Dahtdaht Tàuhkwāi|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Jail Key|', 3 , q'|The key to jail cells in Pyrite Town.|' , nq'|ろうやのカギ|', nq'|Rōya no Kagi|', nq'|Cle de la Prison|', nq'|Zellenschlüssel|', nq'|Chiave Celle|', nq'|Llave Celdas|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Mint Berry|', 2 , q'|Awakens a sleeping Pokémon.|' , nq'|はっかのみ|', nq'|Hakka no Mi|', nq'|Baie Menthe|', nq'|Minzbeere|', nq'|Bacca Menta|', nq'|Baya Menta|', nq'|박하열매|', nq'|Bakha Yeolmae|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Power Lens|', 4 , q'|Promotes Special Attack EVs, but lowers Speed in battle.|' , nq'|パワーレンズ|', nq'|Power Lens|', nq'|Lentille Pouvoir|', nq'|Machtlinse|', nq'|Vigorlente|', nq'|Lente Recia|', nq'|파워렌즈|', nq'|Power Lens|', nq'|力量鏡 / 力量镜|', nq'|Lìliàng Jìng / Lihkleuhng Geng|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pass|', 2 , q'|Allows the player to ride the Magnet Train between Saffron City, Kanto; and Goldenrod City, Johto.|' , nq'|リニアパス|', nq'|Linear Pass|', nq'|Passe Train|', nq'|Fahrschein|', nq'|Superpass|', nq'|Magnetopase|', nq'|리니어패스|', nq'|Linear Pass|', nq'|定期月票|', nq'|Dìngqī Yuèpiào / Dihngkèih Yuhtpiu|', 956 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Point Card|', 4 , q'|Stores Battle Points (BP) earned at the Battle Tower or Battle Frontier.|' , nq'|ポイントカード|', nq'|Point Card|', nq'|Carte Points|', nq'|Punktekarte|', nq'|Scheda Punti|', nq'|Tarj. Puntos|', nq'|포인트카드|', nq'|Point Card|', nq'|點數卡 / 点数卡|', nq'|Diǎnshù Kǎ / Dímsou Kāat|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Vs. Recorder|', 4 , q'|Used to record and replay battles.|' , nq'|バトルレコーダー|', nq'|Battle Recorder|', nq'|Magnéto VS|', nq'|Kampfkamera|', nq'|Registradati|', nq'|Cámara Lucha|', nq'|배틀레코더|', nq'|Battle Recorder|', nq'|對戰記錄器 / 对战记录器|', nq'|Duìzhàn Jìlù Qì / Deuijin Geiluhk Hei|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|X Speed|', 1 , q'|Raises a Pokémon's Speed by 2 stages (1 stage before Gen. VII).|' , nq'|スピーダー|', nq'|Speeder|', nq'|Vitesse +|', nq'|X-Tempo|', nq'|Velocità X|', nq'|Velocidad X|', nq'|스피드업|', nq'|Speed-Up|', nq'|速度強化 / 速度强化|', nq'|Sùdù Qiánghuà / Chūkdouh Kèuhngfa|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Fluffy Tail|', 3 , q'|Allows the player to flee from any wild Pokémon battle.|' , nq'|エネコのシッポ|', nq'|Eneco no Shippo|', nq'|Queue Skitty|', nq'|Eneco-Rute|', nq'|Coda Skitty|', nq'|Cola Skitty|', nq'|에나비꼬리|', nq'|Enabi Kkori|', nq'|向尾喵的尾巴|', nq'|Xiàngwěimiāo-de Wěibā/Xiàngwěimiāo-de Yǐba / Heungméihmīu-dīk Méihbā|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Black Sludge|', 4 , q'|Restores 1/16 of the Pokémon's maximum HP each turn when held by Poison-type Pokémon; damages all other types by ⅛ of maximum HP each turn.|' , nq'|くろいヘドロ|', nq'|Kuroi Hedoro|', nq'|Boue Noire|', nq'|Giftschleim|', nq'|Fangopece|', nq'|Lodo Negro|', nq'|검은진흙|', nq'|Geomeun Jinheuk|', nq'|黑色污泥|', nq'|Hēi-sè Wūní / Hāak-sīk Wūnàih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Blue Shard|', 3 , q'|Exchangeable for a variety of services.|' , nq'|あおいかけら|', nq'|Aoi Kakera|', nq'|Tesson Bleu|', nq'|Indigostück|', nq'|Coccio Blu|', nq'|Parte Azul|', nq'|파랑조각|', nq'|Parang Jogak|', nq'|藍色碎片 / 蓝色碎片|', nq'|Lánsè Suìpiàn / Làahmsīk Seuipin|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|GS Ball|', 2 , q'|Allows Celebi to be caught in Pokémon Crystal.|' , nq'|ジーエスボール|', nq'|GS Ball|', nq'|GS Ball|', nq'|GS-Ball|', nq'|GS Ball|', nq'|GS Ball|', nq'|GS볼|', nq'|GS Ball|', nq'|ＧＳ球|', nq'|GS Qiú / GS Kàuh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lemonade|', 1 , q'|Restores 70 HP. (80HP before Gen. VII)|' , nq'|ミックスオレ|', nq'|Mix au Lait|', nq'|Limonade|', nq'|Limonade|', nq'|Lemonsucco|', nq'|Limonada|', nq'|후르츠밀크|', nq'|Fruits Milk|', nq'|果汁牛奶|', nq'|Guǒzhī Niúnǎi / Gwójāp Ngàuhnáaih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Blue Card|', 2 , q'|Allows player to answer daily question on Buena's show to get points exchangeable for items.|' , nq'|ブルーカード|', nq'|Blue Card|', nq'|Carte Bleue|', nq'|Blaue Karte|', nq'|Carta Blu|', nq'|Tarjeta Azul|', nq'|블루카드|', nq'|Blue Card|', nq'|藍卡 / 蓝卡|', nq'|Lán Kǎ / Làahm Kāat|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dubious Disc|', 4 , q'|A hold item that allows Porygon2 to evolve when traded.|' , nq'|あやしいパッチ|', nq'|Ayashii Patch|', nq'|CD Douteux|', nq'|Dubiosdisc|', nq'|Dubbiodisco|', nq'|Discoxtraño|', nq'|괴상한패치|', nq'|Goesanghan Patch|', nq'|可疑補丁 / 可疑补丁|', nq'|Kěyí Bǔdīng / Hóyìh Bóudīng|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Vs. Seeker|', 3 , q'|Used to prompt Trainers for a rematch.|' , nq'|バトルサーチャー|', nq'|Battle Searcher|', nq'|Cherche VS|', nq'|Kampffahnder|', nq'|Cercasfide|', nq'|Buscapelea|', nq'|배틀서처|', nq'|Battle Searcher|', nq'|對戰搜尋器 / 对战搜寻器|', nq'|Duìzhàn Sōuxún Qì / Deuijin Sāuchàhm Hei|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Electric Gem|', 5 , q'|Increases the power of the holder's first Electric-type move by 50%, and is consumed after use.|' , nq'|でんきのジュエル|', nq'|Denki no Jewel|', nq'|Joyau Électr|', nq'|Elektrojuwel|', nq'|Bijouelettro|', nq'|Gema Eléctrica|', nq'|전기주얼|', nq'|Jeongi Jewel|', nq'|電之寶石 / 电之宝石|', nq'|Diàn-zhī Bǎoshí / Dihn-jī Bóusehk|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Sport Ball|', 2 , q'|A type of Poké Ball that is used in the Bug-Catching Contest.|', q'|Called Park Ball in Generation II.|', nq'|コンペボール|', nq'|Compe Ball|', nq'|Compét'Ball|', nq'|Turnierball|', nq'|Gara Ball|', nq'|Competi Ball|', nq'|콤페볼|', nq'|Compe Ball|', nq'|競賽球 / 竞赛球|', nq'|Jìngsài Qiú / Gihngchoi Kàuh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|PP Up|', 1 , q'|Raises the PP of a move.|' , nq'|ポイントアップ|', nq'|Point Up|', nq'|PP Plus|', nq'|AP-Plus|', nq'|PP-Su|', nq'|Más PP|', nq'|포인트 업|', nq'|Point Up|', nq'|ＰＰ提升劑 / ＰＰ提升剂|', nq'|PP Tíshēngjì / PP Tàihsīngjaih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Meteorite Shard|', 6 , q'|To be delivered to Steven Stone and Professor Cozmo.|' , nq'|いんせきのかけら|', nq'|Inseki no Kakera|', nq'|Éclat Météorite|', nq'|Meteoritenstück|', nq'|Framm. meteorite|', nq'|Frag. Meteorito|', nq'|운석조각|', nq'|Unseok Jogag|', nq'|隕石碎片 / 陨石碎片|', nq'|Yǔnshí suìpiàn / Wáhnsehk Seuipín|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Iron|', 1 , q'|Raises the Defense of a Pokémon.|' , nq'|ブロムヘキシン|', nq'|Bromhexine|', nq'|Fer|', nq'|Eisen|', nq'|Ferro|', nq'|Hierro|', nq'|사포닌|', nq'|Saponin|', nq'|防禦增強劑 / 防御增强剂|', nq'|Fángyù Zēngqiángjì / Fòhngyuh Jāngkèuhngjaih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Rare Candy|', 1 , q'|Instantly raises a Pokémon's level by 1.|' , nq'|ふしぎなアメ|', nq'|Fushigina Ame|', nq'|Super Bonbon|', nq'|Sonderbonbon|', nq'|Caramella Rara|', nq'|Carameloraro|', nq'|이상한사탕|', nq'|Isanghan Satang|', nq'|神奇糖果|', nq'|Shénqí Tángguǒ / Sàhnkèih Tòhnggwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Snorlium Z|', 7 , q'|Allows Snorlax to upgrade Giga Impact to the special Z-Move Pulverizing Pancake.|' , nq'|カビゴンＺ|', nq'|Kabigon-Z|', nq'|Ronflézélite|', nq'|Relaxonium Z|', nq'|Snorlactium Z|', nq'|Snorlastal Z|', nq'|잠만보Z|', nq'|Jammanbo-Z|', nq'|卡比獸Ｚ / 卡比兽Ｚ|', nq'|Kǎbǐshòu-Z / Kábeihsau-Z|', 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Battle CD|' , nq'|バトルディスク|', nq'|Battle Disk|', nq'|Holodisk|', nq'|Kampf-CD|', nq'|CD Lotta|', nq'|Disco C.|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Power Bracer|', 4 , q'|Promotes Attack EVs, but lowers Speed in battle.|' , nq'|パワーリスト|', nq'|Power Wrist|', nq'|Poignée Pouvoir|', nq'|Machtreif|', nq'|Vigorcerchio|', nq'|Brazal Recio|', nq'|파워리스트|', nq'|Power Wrist|', nq'|力量護腕 / 力量护腕|', nq'|Lìliàng Hùwàn / Lihkleuhng Wuhwún|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Boost Mulch|', 6 , q'|When applied to a Berry patch, causes the soil to dry out in 4 hours.|' , nq'|ぐんぐんこやし|', nq'|Gungun Koyashi|', nq'|Fertibérance|', nq'|Wuchermulch|', nq'|Fertilcopioso|', nq'|Abono Fructífero|', nq'|부쩍부쩍비료|', nq'|Bujjeok-bujjeok Biryo|', nq'|勁勁肥 / 劲劲肥|', nq'|Jìnjìn Féi / Gihnggihng Fèih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|X Accuracy 6|', 5 , q'|Immensely raises a Pokémon's accuracy. Wonder Launcher only.|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Zinc|', 3 , q'|Raises the Special Defense of a Pokémon.|' , nq'|キトサン|', nq'|Chitosan|', nq'|Zinc|', nq'|Zink|', nq'|Zinco|', nq'|Zinc|', nq'|키토산|', nq'|Chitosan|', nq'|特防增強劑 / 特防增强剂|', nq'|PP Tíshēngjì / PP Tàihsīngjaih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Qualot Berry|', 3 , q'|Raises friendship, but lowers Defense EVs.|' , nq'|タポルのみ|', nq'|Tapol no Mi|', nq'|Baie Qualot|', nq'|Qualotbeere|', nq'|Baccaloquat|', nq'|Baya Ispero|', nq'|파비열매|', nq'|Pabi Yeolmae|', nq'|比巴果|', nq'|Bǐbā Guǒ / Béibā Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dive Ball|', 3 , q'|A type of Poké Ball that works better on Pokémon encountered underwaterRSEORAS or while Surfing or fishingFRLGDPPtHGSSBWB2W2XY.|' , nq'|ダイブボール|', nq'|Dive Ball|', nq'|Scuba Ball|', nq'|Tauchball|', nq'|Sub Ball|', nq'|Buceo Ball|', nq'|다이브볼|', nq'|Dive Ball|', nq'|潛水球 / 潜水球|', nq'|Qiánshuǐ Qiú / Chìhmséui Kàuh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Tunnel Mail|', 4 , q'|Mail with a picture of a dark tunnel/mine. To be held by a Pokémon for delivery.|' , nq'|トンネルメール|', nq'|Tunnel Mail|', nq'|Lettre Mine|', nq'|Minenbrief|', nq'|Mess. Tunnel|', nq'|Carta Mina|', nq'|터널메일|', nq'|Tunnel Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pomeg Berry|', 3 , q'|Makes a Pokémon more happy, but lowers EVs for HP.|' , nq'|ザロクのみ|', nq'|Zaroku no Mi|', nq'|Baie Grena|', nq'|Granabeere|', nq'|Baccagrana|', nq'|Baya Grana|', nq'|유석열매|', nq'|Yuseok Yeolmae|', nq'|榴石果|', nq'|Liúshí Guǒ / Làuhsehk Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Bonsly Photo|', 3 , q'|The Battle Bingo prize for winning/using the Bonsly Card.|' , nq'|ウソハチ・フォト|', nq'|Usohachi Photo|', nq'|Photo Manzai|', nq'|Mobai-Foto|', nq'|Foto Bonsly|', nq'|Foto Bonsly|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Aloraichium Z|', 7 , q'|Allows Alolan Raichu to upgrade Thunderbolt to the special Z-Move Stoked Sparksurfer.|' , nq'|アロライＺ|', nq'|Alorai-Z|', nq'|Aloraïzélite|', nq'|A-Raichunium Z|', nq'|Aloraicium Z|', nq'|Alo-Raistal Z|', nq'|알로라이Z|', nq'|Allorai-Z|', nq'|阿羅雷Ｚ / 阿罗雷Ｚ|', nq'|Āluóléi-Z / Alòhlèuih-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Sacred Ash|', 2 , q'|Revives all fainted Pokémon in the party to full HP.|' , nq'|せいなるはい|', nq'|Seinaru Hai|', nq'|Cendres Sacrées|', nq'|Zauberasche|', nq'|Magicenere|', nq'|Ceniza Sagrada|', nq'|성스러운분말|', nq'|Seongseureoun Bunmal|', nq'|聖灰 / 圣灰|', nq'|Shènghuī / Singfūi|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Silph Scope|', 1 , q'|Used to identify ghosts in Pokémon Tower.|' , nq'|シルフスコープ|', nq'|Silph Scope|', nq'|Scope Sylphe|', nq'|Silph Scope|', nq'|Spettrosonda|', nq'|Scope Silph|', nq'|실프스코프|', nq'|Silph Scope|', nq'|西爾佛檢視鏡 / 西尔佛检视镜|', nq'|Xīěrfu Jiǎnshìjìng / Sāiyíhfaht Gímsihgeng|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dragon Memory|', 7 , q'|Makes Silvally a Dragon-type Pokémon and makes Multi-Attack a Dragon-type move.|' , nq'|ドラゴンメモリ|', nq'|Dragon Memory|', nq'|ROM Dragon|', nq'|Drachen-Disc|', nq'|ROM Drago|', nq'|Disco Dragón|', nq'|드래곤메모리|', nq'|Dragon Memory|', nq'|龍記憶碟*|'||chr(10)||nq'|龙存储碟|', nq'|Lóng Jìyìdié / Lùhng Geiyīkdihp*|'||chr(10)||nq'|Lóng Cúnchǔdié|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Shed Shell|', 4 , q'|Allows the holder to escape from battle.|' , nq'|きれいなぬけがら|', nq'|Kirei-na Nukegara|', nq'|Carapace Mue|', nq'|Wechselhülle|', nq'|Disfoguscio|', nq'|Muda Concha|', nq'|아름다운허물|', nq'|Areumdaun Heomul|', nq'|美麗空殼 / 美丽空壳|', nq'|Měilì Kōngké / Méihlaih Hūnghok|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Bright Powder|', 2 , q'|Lowers the opponent's accuracy.|', q'|Formatted as BrightPowder prior to Generation VI.|', nq'|ひかりのこな|', nq'|Hikari no Kona|', nq'|Poudre Claire|', nq'|Blendpuder|', nq'|Luminpolvere|', nq'|Polvo Brillo|', nq'|반짝가루|', nq'|Banjjak Garu|', nq'|光粉|', nq'|Guāngfěn / Gwōngfán|', 1152 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Litebluemail|', 2 , q'|Mail with a Dratini pattern. To be held by a Pokémon for delivery.|' , nq'|みずいろメール|', nq'|Mizuiro Mail|', nq'|LetrBleuCiel|', nq'|Cyanbrief|', nq'|Mess. Azzurro|', nq'|Carta Azul|', nq'|옥빛메일|', nq'|Okbit Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Fire Gem|', 5 , q'|Increases the power of the holder's first Fire-type move by 50%, and is consumed after use.|' , nq'|ほのおのジュエル|', nq'|Honō no Jewel|', nq'|Joyau Feu|', nq'|Feuerjuwel|', nq'|Bijoufuoco|', nq'|Gema Fuego|', nq'|불꽃주얼|', nq'|Bulkkot Jewel|', nq'|火之寶石 / 火之宝石|', nq'|Huǒ-zhī Bǎoshí / Fó-jī Bóusehk|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Flame Mail|', 4 , q'|Mail with a fire design. To be held by a Pokémon for delivery.|' , nq'|フレイムメール|', nq'|Flame Mail|', nq'|Lettre Feu|', nq'|Feuerbrief|', nq'|Mess. Fiamma|', nq'|Carta Fuego|', nq'|플레임메일|', nq'|Flame Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Fab Mail|', 3 , q'|Mail with an extremely decorative design. To be held by a Pokémon for delivery.|' , nq'|ミラクルメール|', nq'|Miracle Mail|', nq'|Lettre Cool|', nq'|Edelbrief|', nq'|Mess. Fab|', nq'|Carta Fabulosa|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Yellow Nectar|', 7 , q'|Changes Oricorio to its Pom-Pom Style.|' , nq'|やまぶきのミツ|', nq'|Yamabuki no Mitsu|', nq'|Nectar Jaune|', nq'|Gelber Nektar|', nq'|Nettare giallo|', nq'|Néctar Amarillo|', nq'|진노랑꿀|', nq'|Jinnorang Kkul|', nq'|金黃色花蜜 / 金黄色花蜜|', nq'|Jīnhuáng-sè Huāmì / Gāmwòhng-sīk Fāmaht|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Thick Club|', 3 , q'|Doubles Cubone and Marowak's Attack.|' , nq'|ふといホネ|', nq'|Futoi Hone|', nq'|Masse Os|', nq'|Kampfknochen|', nq'|Ossospesso|', nq'|Hueso Grueso|', nq'|굵은뼈|', nq'|Gulgeun Ppyeo|', nq'|粗骨頭 / 粗骨头|', nq'|Cū Gǔtou / Chōu Gwāttàuh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Everstone|', 2 , q'|A hold item that prevents the holder from evolving.|' , nq'|かわらずのいし|', nq'|Kawarazu no Ishi|', nq'|Pierre Stase|', nq'|Ewigstein|', nq'|Pietrastante|', nq'|Piedra Eterna|', nq'|변함없는돌|', nq'|Byeonhameomneun Dol|', nq'|不變之石 / 不变之石|', nq'|Bùbiàn-zhī Shí / Bātbin-jī Sehk|', 16 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Seal Bag|' , nq'|シールぶくろ|', nq'|Seal Bukuro|', nq'|Sac Sceaux|', nq'|Stickertüte|', nq'|Bollosacca|', nq'|Bolsa Sellos|', nq'|실주머니|', nq'|Seal Jumeoni|', nq'|貼紙袋 / 贴纸袋|', nq'|Tiēzhǐ Dài / Tipjí Doih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pink Petal|', 7 , q'|A pink petal required to complete Mina's Trial.|' , nq'|ももいろはなびら|', nq'|Momoiro Hanabira|', nq'|Pétale Rose|', nq'|Rosa Blatt|', nq'|Petalo rosa|', nq'|Pétalo Rosa|', nq'|담홍꽃잎|', nq'|Damhong Kkochip|', nq'|粉紅花瓣 / 粉红花瓣|', nq'|Fěnhóng Huābàn / Fánhùhng Fāfáan|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Fighting Memory|', 7 , q'|Makes Silvally a Fighting-type Pokémon and makes Multi-Attack a Fighting-type move.|' , nq'|ファイトメモリ|', nq'|Fight Memory|', nq'|ROM Combat|', nq'|Kampf-Disc|', nq'|ROM Lotta|', nq'|Disco Lucha|', nq'|파이팅메모리|', nq'|Fighting Memory|', nq'|戰鬥記憶碟*|'||chr(10)||nq'|战斗存储碟|', nq'|Zhàndòu Jìyìdié / Jindau Geiyīkdihp*|'||chr(10)||nq'|Zhàndòu Cúnchǔdié|', 3 );
insert into ITEMS( NAME, GEN, GEN2, DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Chilan Berry|', 3, 4, q'|Pokéblock ingredient (3) and Reduces damage from a Normal-type move by 50% (4).|' , nq'|ホズのみ|', nq'|Hozu no Mi|', nq'|Baie Zalis|', nq'|Latchibeere|', nq'|Baccacinlan|', nq'|Baya Chilan|', nq'|카리열매|', nq'|Kari Yeolmae|', nq'|燈漿果 / 燈漿果|', nq'|Dēngjiāng Guǒ / Dāngjēung Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Blue Apricorn|', 2 , q'|If taken to Kurt, he will make the player a Lure Ball. Also, Apricorn Drink ingredient.|', q'|Formatted as Blu Apricorn prior to Generation VI.|', nq'|あおぼんぐり|', nq'|Ao Bonguri|', nq'|Noigrume Blu|', nq'|Aprikoko Blu|', nq'|Ghicocca Blu|', nq'|Bonguri Azul|', nq'|파란규토리|', nq'|Paran Gyutori|', nq'|藍球果 / 蓝球果|', nq'|Lán Qiúguǒ / Làahm Kàuhgwó|', 1072 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|BridgeMail D|', 5 , q'|Stationary with a red drawbridge print. To be held by a Pokémon for delivery.|' , nq'|ブリッジメールＨ|', nq'|Bridge Mail H|', nq'|Lettre PontY|', nq'|Brückbrief M|', nq'|Mess. Libec.|', nq'|C. Puente F|', nq'|브리지메일M|', nq'|Bridge Mail M|', nq'|橋梁郵件Ｈ / 桥梁邮件Ｈ|', nq'|Qiáoliáng Yóujiàn H / Kìuhlèuhng Yàuhgín H|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Metagrossite|', 6 , q'|Allows Metagross to Mega Evolve into Mega Metagross.|' , nq'|メタグロスナイト|', nq'|Metagrossnite|', nq'|Métalossite|', nq'|Metagrossnit|', nq'|Metagrossite|', nq'|Metagrossita|', nq'|메타그로스나이트|', nq'|Metagrossnite|', nq'|巨金怪進化石 / 巨金怪进化石|', nq'|Jùjīnguài Jìnhuà Shí / Geuihgāmgwaai Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|SquirtBottle|', 2 , q'|Used to bring Sudowoodo out of hiding.|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Ultranecrozium Z|', 7 , q'|Allows Necrozma to transform into Ultra Necrozma after fusing with Solgaleo or Lunala, also upgrades Photon Geyser to the special Z-Move Light That Burns the Sky as Ultra Necrozma.|' , nq'|ウルトラネクロＺ|', nq'|Ultranecro-Z|', nq'|Ultranécrozélite|', nq'|Ultranecrozium Z|', nq'|Ultranecrozium Z|', nq'|Ultranecrostal Z|', nq'|울트라네크로Z|', nq'|Ultranecro-Z|', nq'|究極奈克洛Ｚ / 究极奈克洛Ｚ|', nq'|Jiūjí Nàikèluò-Z / Gaugihk Noihhāklok-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Great Ball|', 1 , q'|A moderately good type of Poké Ball.|' , nq'|スーパーボール|', nq'|Super Ball|', nq'|Super Ball|', nq'|Superball|', nq'|Mega Ball|', nq'|Superball|', nq'|수퍼볼|', nq'|Super Ball|', nq'|超級球 / 超级球|', nq'|Chāojí Qiú / Chīukāp Kàuh|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Claw Fossil|', 3 , q'|A Fossil from which an Anorith can be resurrected.|' , nq'|ツメのカセキ|', nq'|Tsume no Kaseki|', nq'|Fossile Griffe|', nq'|Klauenfossil|', nq'|Fossilunghia|', nq'|Fósil Garra|', nq'|발톱화석|', nq'|Baltop Hwaseok|', nq'|爪子化石|', nq'|Zhuǎzi Huàshí / Jáaují Fasehk|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Coupon 1|', 4 , q'|Used to obtain the Pokétch in Jubilife City.|' , nq'|ひきかえけん１|', nq'|Hikikaeken 1|', nq'|Bon 1|', nq'|Kupon 1|', nq'|Coupon 1|', nq'|Cupón 1|', nq'|교환권 1|', nq'|Gyohwangwon 1|', nq'|兌換券１ / 兑换券１|', nq'|Duìhuàn Quàn 1 / Deuiwuhn Hyun 1|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Relic Copper|', 5 , q'|Can be sold for 1000 to the villa owner in Undella Town.|' , nq'|こだいのどうか|', nq'|Kodai no Dōka|', nq'|Vieux Sou|', nq'|Alter Heller|', nq'|Soldantico|', nq'|Real Cobre|', nq'|고대의동화|', nq'|Godae-yi Donghwa|', nq'|古代銅幣 / 古代铜币|', nq'|Gǔdài Tóngbì / Gúdoih Tùhngbaih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Razz Berry|', 3 , q'|Pokéblock and Poffin ingredient.|' , nq'|ズリのみ|', nq'|Zuri no Mi|', nq'|Baie Framby|', nq'|Himmihbeere|', nq'|Baccalampon|', nq'|Baya Frambu|', nq'|라즈열매|', nq'|Ras Yeolmae|', nq'|蔓莓果|', nq'|Mànméi Guǒ / Màahnmùih Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Prop Case|', 5 , q'|Used to hold Props for the Pokémon Musical.|' , nq'|グッズケース|', nq'|Goods Case|', nq'|Boîte Parure|', nq'|Deko-Box|', nq'|Portagadget|', nq'|Neceser|', nq'|굿즈케이스|', nq'|Goods Case|', nq'|物品箱|', nq'|Wùpǐn Xiāng / Mahtbán Sēung|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Venusaurite|', 6 , q'|Allows Venusaur to Mega Evolve into Mega Venusaur.|' , nq'|フシギバナイト|', nq'|Fushigibanite|', nq'|Florizarrite|', nq'|Bisaflornit|', nq'|Venusaurite|', nq'|Venusaurita|', nq'|이상해꽃나이트|', nq'|Isanghekkotnite|', nq'|妙蛙花進化石 / 妙蛙花进化石|', nq'|Miàowāhuā Jìnhuà Shí / Miuhwāfā Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Cleanse Tag|', 3 , q'|Repels Pokémon if the holder is first in the party.|' , nq'|きよめのおふだ|', nq'|Kiyome no Ofuda|', nq'|Rune Purifiante|', nq'|Schutzband|', nq'|Velopuro|', nq'|Amuleto|', nq'|순결의부적|', nq'|Sun-gyeorui Bujeok|', nq'|潔淨之符 / 洁净之符|', nq'|Jiéjìng-zhī Fú / Gitjihng-jī Fùh|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Bubble Mail|', 4 , q'|Stationery with a bubble print. To be held by a Pokémon for delivery.|' , nq'|ブルーメール|', nq'|Blue Mail|', nq'|Lettre Mer|', nq'|Wasserbrief|', nq'|Mess. Bolla|', nq'|Carta Pompas|', nq'|블루메일|', nq'|Blue Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Leftovers|', 2 , q'|Heals a little HP at the end of each turn.|' , nq'|たべのこし|', nq'|Tabe Nokoshi|', nq'|Restes|', nq'|Überreste|', nq'|Avanzi|', nq'|Restos|', nq'|먹다남은음식|', nq'|Meokda Nameun Eumsik|', nq'|吃剩的東西 / 吃剩的东西|', nq'|Chīshèng-de Dōngxī / Heksihng-dīk Dūngsāi|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Mayor's Note|', 3 , q'|A letter from the Mayor to Justy.|' , nq'|しちょうのてがみ|', nq'|Shichō no Tegami|', nq'|Lettre Maire|', nq'|Zettel|', nq'|Nota Sindaco|', nq'|Nota Alcalde|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Draco Plate|', 4 , q'|Raises the power of Dragon-type moves.|' , nq'|りゅうのプレート|', nq'|Ryuu no Purēto|', nq'|Plaque Draco|', nq'|Dracotafel|', nq'|Lastradrakon|', nq'|Tabla Draco|', nq'|용의플레이트|', nq'|Yong-ui Plate|', nq'|龍之石板 / 龙之石板|', nq'|Lóng-zhī Shíbǎn / Lùhng-jī Sehkbáan|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Sweet Heart|', 5 , q'|A very sugary chocolate. It restores one Pokémon's HP by 20.|' , nq'|ハートスイーツ|', nq'|Heart Sweets|', nq'|Chococœur|', nq'|Herzkonfekt|', nq'|Dolcecuore|', nq'|Corazón Dulce|', nq'|하트스위트|', nq'|Sweet Heart|', nq'|心形甜點 / 心形甜点|', nq'|Xīnxíng Tiándiǎn / Sāmyìhng Tìhmdím|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Liberty Pass|', 5 , q'|Gives access to Liberty Garden.|' , nq'|リバティチケット|', nq'|Liberty Ticket|', nq'|Passe Liberté|', nq'|Gartenpass|', nq'|Liberticket|', nq'|Ticket Libertad|', nq'|리버티티켓|', nq'|Liberty Ticket|', nq'|自由船票|', nq'|Zìyóu Chuánpiào / Jihyàuh Syùhnpiu|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|Kuo Berry|', 3 , q'|Cures Burn status. If transferred to Generation IV via Pal Park, it will turn into an Enigma Berry.|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Roller Skates|', 6 , q'|Allows the player to glide around and perform tricks.|' , nq'|ローラースケート|', nq'|Roller Skate|', nq'|Rollers|', nq'|Rollerskates|', nq'|Pattini|', nq'|Patines|', nq'|롤러스케이트|', nq'|Roller Skate|', nq'|溜冰鞋*|'||chr(10)||nq'|轮滑鞋|', nq'|Liūbīng Xié / Làuhbīng Hàaih*|'||chr(10)||nq'|Lúnhuá Xié|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Kelpsy Berry|', 3 , q'|Raises friendship, but lowers Attack EV.|' , nq'|ネコブのみ|', nq'|Nekobu no Mi|', nq'|Baie Alga|', nq'|Setangbeere|', nq'|Baccalga|', nq'|Baya Algama|', nq'|시마열매|', nq'|Sima Yeolmae|', nq'|藻根果|', nq'|Zǎogēn Guǒ / Jóugān Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Revival Herb|', 2 , q'|Revives a Pokémon to full HP, but lowers friendship.|' , nq'|ふっかつそう|', nq'|Fukkatsu Sō|', nq'|Herbe Rappel|', nq'|Vitalkraut|', nq'|Vitalerba|', nq'|Hierba Revivir|', nq'|부활 초|', nq'|Buhwal Cho|', nq'|復活草 / 复活草|', nq'|Fùhuó Cǎo / Fuhkwuht Chóu|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Gyaradosite|', 6 , q'|Allows Gyarados to Mega Evolve into Mega Gyarados.|' , nq'|ギャラドスナイト|', nq'|Gyaradosnite|', nq'|Léviatorite|', nq'|Garadosnit|', nq'|Gyaradosite|', nq'|Gyaradosita|', nq'|갸라도스나이트|', nq'|Gyaradosnite|', nq'|暴鯉龍進化石 / 暴鲤龙进化石|', nq'|Bàolǐlóng Jìnhuà Shí / Bouhléihlùhng Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Wide Lens|', 4 , q'|Boosts accuracy of holder by an 110%.|' , nq'|こうかくレンズ|', nq'|Kōkaku Lens|', nq'|Loupe|', nq'|Großlinse|', nq'|Grandelente|', nq'|Lupa|', nq'|광각렌즈|', nq'|Gwanggak-lens|', nq'|廣角鏡 / 广角镜|', nq'|Guǎngjiǎo Jìng / Gwónggok Geng|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lansat Berry|', 3 , q'|Raises critical-hit ratio if HP is below ⅓ of maximum.|' , nq'|サンのみ|', nq'|San no Mi|', nq'|Baie Lansat|', nq'|Lansatbeere|', nq'|Baccalangsa|', nq'|Baya Zonlan|', nq'|랑사열매|', nq'|Langsa Yeolmae|', nq'|蘭薩果 / 兰萨果|', nq'|Lánsà Guǒ / Làahnsaat Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Voice Case 3|', 3 , q'|Heals a Taillow in Agate Village.|' , nq'|こえカプセル３|', nq'|Koe Capsule 3|', nq'|Boite Cri 3|', nq'|Stimmbox 3|', nq'|Disco Verso 3|', nq'|Grabación 3|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Miracle Seed|', 2 , q'|Raises the power of Grass-type moves.|' , nq'|きせきのタネ|', nq'|Kiseki no Tane|', nq'|Grain Miracle|', nq'|Wundersaat|', nq'|Miracolseme|', nq'|Semilla Milagro|', nq'|기적의씨|', nq'|Gijeogui Ssi|', nq'|奇跡種子 / 奇迹种子|', nq'|Qíjī Zhǒngzǐ / Kèihjīk Júngjí|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Razor Fang|', 4 , q'|Raises the chance of causing an opponent to flinch. Allows Gligar to evolve at night.|' , nq'|するどいキバ|', nq'|Surudoi Kiba|', nq'|Croc Rasoir|', nq'|Scharfzahn|', nq'|Affilodente|', nq'|Colmillo Agudo|', nq'|예리한이빨|', nq'|Yerihan Ippal|', nq'|銳利之牙 / 锐利之牙|', nq'|Ruìlì-zhī Yá / Yeuihleih-jī Ngàh|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Mega Ring|', 6 , q'|Allows the player to Mega Evolve a Pokémon holding the appropriate Mega Stone.|' , nq'|メガリング|', nq'|Mega Ring|', nq'|Méga-Anneau|', nq'|Mega-Ring|', nq'|Megacerchio|', nq'|Mega-Aro|', nq'|메가링|', nq'|Mega Ring|', nq'|超級環 / 超级环|', nq'|Chāojí Huán / Chīukāp Wàahn|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|F-Disk|', 3 , q'|Moves the UFO in The Under to the Under Colosseum.|' , nq'|Ｆ－ディスク|', nq'|F-Disk|', nq'|Disque-A|', nq'|V-Disc|', nq'|Disco Avanti|', nq'|Disco A|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Fightinium Z|', 7 , q'|Allows a Pokémon to upgrade their Fighting-type damaging moves to the Z-Move All-Out Pummeling or upgrade their Fighting-type status moves into Z-Moves. Makes Arceus a Fighting-type Pokémon.|' , nq'|カクトウＺ|', nq'|Fighting-Z|', nq'|Combazélite|', nq'|Battalium Z|', nq'|Luctium Z|', nq'|Lizastal Z|', nq'|격투Z|', nq'|Gyeoktu-Z|', nq'|格鬥Ｚ / 格斗Ｚ|', nq'|Gédòu-Z / Gaakdau-Z|', 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|HM|' , nq'|ひでんマシン|', nq'|Hiden Machine|', nq'|CS|', nq'|VM|', nq'|MN|', nq'|MO|', nq'|비전머신|', nq'|Bijeon Machine|', nq'|秘傳學習器 / 秘传学习器|', nq'|Mìchuán Xuéxíqì / Beichyùhn Hohkjaahphei|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Sun Flute|', 7 , q'|Used to evolve Nebby into Solgaleo at the Altar of the Sunne.|' , nq'|たいようのふえ|', nq'|Taiyō no Fue|', nq'|Flûte du Soleil|', nq'|Sonnenflöte|', nq'|Flauto solare|', nq'|Flauta Solar|', nq'|태양의피리|', nq'|Taeyang Uipili|', nq'|太陽之笛 / 太阳之笛|', nq'|Tàiyáng-zhī Dí / Taaiyèuhng-jī Dehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|MysticTicket|', 3 , q'|Allows the player to access Navel Rock and catch Lugia and Ho-Oh.|' , nq'|しんぴのチケット|', nq'|Shinpi no Ticket|', nq'|Ticketmystik|', nq'|Geheimticket|', nq'|Biglietto Magico|', nq'|Misti-Ticket|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Enigmatic Card|', 7 , q'|Allows the player to enter Looker and Anabel's motel room on Route 8.|' , nq'|あやしいカード|', nq'|Ayashī Card|', nq'|Message Mystère|', nq'|Seltsame Karte|', nq'|Lettera segreta|', nq'|Nota Intrigante|', nq'|괴상한카드|', nq'|Goesanghan Card|', nq'|奇異卡片 / 奇异卡片|', nq'|Qíyì Kǎpiàn / Kèihyih Kāatpín|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Bitter Berry|', 2 , q'|Heals confusion.|' , nq'|にがいきのみ|', nq'|Nigai Kino Mi|', nq'|Baie Amere|', nq'|Bitterbeere|', nq'|Bacca Amara|', nq'|Bayamarga|', nq'|쓴맛나무열매|', nq'|Sseunmat Namu Yeolmae|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Iapapa Berry|', 3 , q'|When HP falls below 25%, restores 50% HP, but confuses Pokémon that dislike sour food (12.5% when below 50% before Gen. VII).|' , nq'|イアのみ|', nq'|Ia no Mi|', nq'|Baie Papaya|', nq'|Yapabeere|', nq'|Baccapaia|', nq'|Baya Pabaya|', nq'|파야열매|', nq'|Paya Yeolmae|', nq'|芭亞果 / 芭亚果|', nq'|Bāyà Guǒ / Bā'a Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Town Map|', 1 , q'|Contains an interactive map of the region and where the player is at the time.|' , nq'|タウンマップ|', nq'|Town Map|', nq'|Carte|', nq'|Karte|', nq'|Mappa|', nq'|Mapa|', nq'|타운맵|', nq'|Town Map|', nq'|城鎮地圖 / 城镇地图|', nq'|Chéngzhèn Dìtú / Sìhngjan Deihtòuh|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Egg Ticket|', 2 , q'|Can be exchanged for the Odd Egg.|' , nq'|タマゴけん|', nq'|Tamago Ken|', nq'|Ticket Oeuf|', nq'|Ei-Ticket|', nq'|Bigl.Uovo|', nq'|Ticket Huevo|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Salamencite|', 6 , q'|Allows Salamence to Mega Evolve into Mega Salamence.|' , nq'|ボーマンダナイト|', nq'|Bohmandanite|', nq'|Drattakite|', nq'|Brutalandanit|', nq'|Salamencite|', nq'|Salamencita|', nq'|보만다나이트|', nq'|Bomandanite|', nq'|暴飛龍進化石 / 暴飞龙进化石|', nq'|Bàofēilóng Jìnhuà Shí / Bouhfēilùhng Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Maranga Berry|', 6 , q'|Increases Special Defense when hit by a special move.|' , nq'|タラプのみ|', nq'|Tarapu no Mi|', nq'|Baie Rangma|', nq'|Tarabeere|', nq'|Baccapane|', nq'|Baya Maranga|', nq'|타라프열매|', nq'|Tarapeu Yeolmae|', nq'|香羅果 / 香罗果|', nq'|Xiāngluó Guǒ / Hēunglòh Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Icy Rock|', 4 , q'|Extends the duration of hail.|' , nq'|つめたいいわ|', nq'|Tsumetai Iwa|', nq'|Roche Glace|', nq'|Eisbrocken|', nq'|Rocciafredda|', nq'|Roca Helada|', nq'|차가운바위|', nq'|Chagaun Bawi|', nq'|冰冷岩石|', nq'|Bīnglěng Yánshí / Bīngláahng Ngàahmsehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|Teru-sama|', 2 , q'|A group of dummy items. Unobtainable during normal gameplay.|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Silver Wing|', 2 , q'|Summons Lugia.|' , nq'|ぎんいろのはね|', nq'|Gin'iro no Hane|', nq'|Argent'Aile|', nq'|Silberflügel|', nq'|Aladargento|', nq'|Ala Plateada|', nq'|은빛날개|', nq'|Eunbit Nalgae|', nq'|銀色之羽 / 银色之羽|', nq'|Yín-sè-zhī Yǔ / Ngàhn-sīk-jī Yúh|', 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Mega Charm|' , nq'|メガチャーム|', nq'|Mega Charm|', nq'|Méga-Charme|', nq'|Megaillon|', nq'|Megaciondolo|', nq'|Megacolgante|', nq'|메가참이|', nq'|Mega Charm|', nq'|超級墜飾 / 超级坠饰|', nq'|Chāojí Zhuìshì / Chīukāp Jeuihsīk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Insect Plate|', 4 , q'|Raises the power of Bug-type moves.|' , nq'|たまむしプレート|', nq'|Tamamushi Purēto|', nq'|Plaquinsect|', nq'|Käfertafel|', nq'|Lastrabaco|', nq'|Tabla Bicho|', nq'|비단벌레플레이트|', nq'|Bidanbeolle Plate|', nq'|玉蟲石板 / 玉虫石板|', nq'|Yùchóng Shíbǎn / Yuhkchùhng Sehkbáan|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Choice Scarf|', 4 , q'|Raises user's Speed, but they can only use one move.|' , nq'|こだわりスカーフ|', nq'|Kodawari Scarf|', nq'|Mouchoir Choix|', nq'|Wahlschal|', nq'|Stolascelta|', nq'|Pañuelo Elegido|', nq'|구애스카프|', nq'|Guae Scarf|', nq'|講究圍巾 / 讲究围巾|', nq'|Jiǎngjiù Wéijīn / Gónggau Wàihgān|', 144 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Starf Berry|', 3 , q'|Raises a random stat when HP is below ⅓.|' , nq'|スターのみ|', nq'|Star no Mi|', nq'|Baie Frista|', nq'|Krambobeere|', nq'|Baccambola|', nq'|Baya Arabol|', nq'|스타열매|', nq'|Star Yeolmae|', nq'|星桃果|', nq'|Xīngtáo Guǒ / Sīngtòuh Gwó|', 0 );
insert into ITEMS( NAME, GEN, GEN2, DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Basement Key|', 2, 3, q'|Allows the player to access the basement of the Goldenrod Tunnel (2) and New Mauville (3).|' , nq'|ちかのカギ|', nq'|Chika no Kagi|', nq'|Clé Sous-Sol|', nq'|Kelleröffner|', nq'|Chiave sotterr.|', nq'|Llave del Sótano|', nq'|지하열쇠|', nq'|Jiha Yeolsoe|', nq'|地下鑰匙 / 地下钥匙|', nq'|Dìxià Yàoshi / Deihhah Yeuhksìh|', 28 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Oak's Letter|', 4 , q'|Opens the Seabreak Path and allows the user to face Shaymin.|' , nq'|オーキドのてがみ|', nq'|Okido no Tegami|', nq'|Lettre Chen|', nq'|Eichs Brief|', nq'|Lettera di Oak|', nq'|Carta Pr Oak|', nq'|오박사의 편지|', nq'|O-baksa-ui Pyeonji|', nq'|大木的信|', nq'|Dàmù-de Xìn / Daaihmuhk-dīk Seun|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Icicle Plate|', 4 , q'|Raises the power of Ice-type moves.|' , nq'|つららのプレート|', nq'|Tsurara no Purēto|', nq'|Plaque Glace|', nq'|Frosttafel|', nq'|Lastragelo|', nq'|Tabla Helada|', nq'|고드름플레이트|', nq'|Godeureum Plate|', nq'|冰柱石板|', nq'|Bīngzhù Shíbǎn / Bīngchyúh Sehkbáan|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Vivid Scent|', 3 , q'|Reduces the heart gauge by a large amount and increases friendship.|' , nq'|ドキドキのかおり|', nq'|Dokidoki no Kaori|', nq'|P. Palpitant|', nq'|Paradies-E.|', nq'|Olio Sublime|', nq'|Ar. Energía|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Ein File P|', 3 , q'|Describes purification.|' , nq'|ボルグファイルＲ|', nq'|Borg File R|', nq'|Dossier Teck P|', nq'|Culpa-Akte C-E|', nq'|Genus.File P|', nq'|Parte Ein: P|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Poffin Case|', 4 , q'|Stores Poffins.|' , nq'|ポフィンケース|', nq'|Poffin Case|', nq'|Boîte Poffin|', nq'|Knurspbox|', nq'|Portapoffin|', nq'|Pokochera|', nq'|포핀케이스|', nq'|Poffin Case|', nq'|寶芬盒 / 宝芬盒|', nq'|Bǎofēn Hé / Bǎofēn Hahp|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Ground Memory|', 7 , q'|Makes Silvally a Ground-type Pokémon and makes Multi-Attack a Ground-type move.|' , nq'|グラウンドメモリ|', nq'|Ground Memory|', nq'|ROM Sol|', nq'|Boden-Disc|', nq'|ROM Terra|', nq'|Disco Tierra|', nq'|그라운드메모리|', nq'|Ground Memory|', nq'|大地記憶碟*|'||chr(10)||nq'|大地存储碟|', nq'|Dàdì Jìyìdié / Daaihdeih Geiyīkdihp*|'||chr(10)||nq'|Dàdì Cúnchǔdié|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Wave Mail|', 3 , q'|Mail with a Wailmer design. To be held by a Pokémon for delivery.|' , nq'|クロスメール|', nq'|Cross Mail|', nq'|Lettre Vague|', nq'|Wellenbrief|', nq'|Mess. Onda|', nq'|Carta Ola|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Green Petal|', 7 , q'|A green petal required to complete Mina's Trial.|' , nq'|みどりのはなびら|', nq'|Midori no Hanabira|', nq'|Pétale Vert|', nq'|Grünes Blatt|', nq'|Petalo verde|', nq'|Pétalo Verde|', nq'|초록꽃잎|', nq'|Chorok Kkochip|', nq'|綠色花瓣 / 绿色花瓣|', nq'|Lǜ-sè Huābàn / Luhk-sīk Fāfáan|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Luck Incense|', 4 , q'|Causes earnings to double in battles against other Trainers. A Chansey or Blissey holding it can breed to produce a Happiny.|' , nq'|こううんのおこう|', nq'|Kōun no Okō|', nq'|Encens Veine|', nq'|Glücksrauch|', nq'|Fortunaroma|', nq'|Incienso duplo|', nq'|행운의향로|', nq'|Haeng-unui Hyangno|', nq'|幸運薰香 / 幸运薰香|', nq'|Xìngyùn Xūnxiāng / Hahngwahn Fānhēung|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Krane Memo 1|', 3 , q'|Contains information about snagging.|' , nq'|クレインメモ１|', nq'|Krane Memo 1|', nq'|Memo Syrus 1|', nq'|Klein-Memo 1|', nq'|Appunti 1|', nq'|Parte Cío 1|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|BridgeMail T|', 5 , q'|Stationary with a steel suspension bridge print. To be held by a Pokémon for delivery.|' , nq'|ブリッジメールＣ|', nq'|Bridge Mail C|', nq'|Lettre PontF|', nq'|Brückbrief Z|', nq'|Mess. Prop.|', nq'|C. Puente A|', nq'|브리지메일C|', nq'|Bridge Mail C|', nq'|橋梁郵件Ｃ / 桥梁邮件Ｃ|', nq'|Qiáoliáng Yóujiàn C / Kìuhlèuhng Yàuhgín C|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Soul Dew|', 3 , q'|Increases the power of Psychic-type and Dragon-type moves used by Latias and Latios by 20%. (Raises the Special Attack and Special Defense of Latias and Latios before Gen. VII).|' , nq'|こころのしずく|', nq'|Kokoro no Shizuku|', nq'|Rosée Âme|', nq'|Seelentau|', nq'|Cuorugiada|', nq'|Rocío Bondad|', nq'|마음의물방울|', nq'|Ma-eumui Mulbang-ul|', nq'|心之水滴|', nq'|Xīn-zhī Shuǐdī / Sām-jī Séuidihk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Firium Z|', 7 , q'|Allows a Pokémon to upgrade their Fire-type damaging moves to the Z-Move Inferno Overdrive or upgrade their Fire-type status moves into Z-Moves. Makes Arceus a Fire-type Pokémon.|' , nq'|ホノオＺ|', nq'|Flame-Z|', nq'|Pyrozélite|', nq'|Pyrium Z|', nq'|Pirium Z|', nq'|Pirostal Z|', nq'|불꽃Z|', nq'|Bulkkot-Z|', nq'|火Ｚ|', nq'|Huǒ-Z / Fó-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Ability Urge|', 5 , q'|Activates the Ability of an ally Pokémon. Wonder Launcher only.|' , nq'|スキルコール|', nq'|Skill Call|', nq'|Appel CapSpé|', nq'|Fäh.-Appell|', nq'|Chiamabilità|', nq'|Habilitador|', nq'|스킬콜|', nq'|Skill Call|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Flower Mail|', 2 , q'|Mail with a flower pattern. To be held by a Pokémon for delivery.|' , nq'|はながらメール|', nq'|Hanagara Mail|', nq'|Lettre Fleur|', nq'|Blumenbrief|', nq'|Messaggio Fiore|', nq'|Carta Flor|', nq'|꽃무늬메일|', nq'|Kkonmunui Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|Dire Hit 3|', 5 , q'|Raises critical hit ratio by 3 levels in battle. Wonder Launcher only.|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Scizorite|', 6 , q'|Allows Scizor to Mega Evolve into Mega Scizor.|' , nq'|ハッサムナイト|', nq'|Hassamnite|', nq'|Cizayoxite|', nq'|Scheroxnit|', nq'|Scizorite|', nq'|Scizorita|', nq'|핫삼나이트|', nq'|Hatsamnite|', nq'|巨鉗螳螂進化石 / 巨钳螳螂进化石|', nq'|Jùqiántángláng Jìnhuà Shí / Geuihkìhmtòhnglòhng Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Oran Berry|', 3 , q'|Restores 10 HP.|' , nq'|オレンのみ|', nq'|Oren no Mi|', nq'|Baie Oran|', nq'|Sinelbeere|', nq'|Baccarancia|', nq'|Baya Aranja|', nq'|오랭열매|', nq'|Oraeng Yeolmae|', nq'|橙橙果|', nq'|Chéngchéng Guǒ / Chàahngchàahng Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Mewtwonite X|', 6 , q'|Allows Mewtwo to Mega Evolve into Mega Mewtwo X.|' , nq'|ミュウツナイトX|', nq'|Mewtwonite X|', nq'|Mewtwoïte X|', nq'|Mewtunit X|', nq'|Mewtwoite X|', nq'|Mewtwoita X|', nq'|뮤츠나이트X|', nq'|Mewtwonite X|', nq'|超夢進化石X / 超梦进化石X|', nq'|Chāomèng Jìnhuà Shí X / Chīumuhng Jeunfa Sehk X|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Sapphire|', 3 , q'|To be given to Celio along with Ruby to set up the Network Machine of the Pokémon Network Center, allowing the player to trade with Ruby, Sapphire, and Emerald.|' , nq'|サファイア|', nq'|Sapphire|', nq'|Saphir|', nq'|Saphir|', nq'|Zaffiro|', nq'|Zafiro|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Time Flute|', 3 , q'|Can be used to instantly purify a Shadow Pokémon.|' , nq'|ときのふえ|', nq'|Toki no Fue|', nq'|Flute du Temps|', nq'|Zeitflöte|', nq'|Flauto Tempo|', nq'|Fl. Tiempo|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Air Mail|', 4 , q'|A red- and blue-striped stationery. To be held by a Pokémon for delivery.|' , nq'|エアメール|', nq'|Air Mail|', nq'|Lettre Avion|', nq'|Luftbrief|', nq'|Mess. Aereo|', nq'|Carta Aérea|', nq'|에어메일|', nq'|Air Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Safety Goggles|', 6 , q'|Grants the holder immunity to weather-related damage and powder moves.|' , nq'|ぼうじんゴーグル|', nq'|Bōjin Goggle|', nq'|Lunettes Filtre|', nq'|Schutzbrille|', nq'|Visierantisabbia|', nq'|Gafa Protectora|', nq'|방진고글|', nq'|Bangjin Goggle|', nq'|防塵護目鏡 / 防尘护目镜|', nq'|Fángchén Hù Mùjìng / Fòhngchàhn Wuh Muhkgeng|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Scope Lens|', 3 , q'|Raises chances of getting a critical hit.|' , nq'|ピントレンズ|', nq'|Pint Lens|', nq'|Lentilscope|', nq'|Scope-Linse|', nq'|Mirino|', nq'|Periscopio|', nq'|초점렌즈|', nq'|Chojeom Lens|', nq'|焦點鏡 / 焦点镜|', nq'|Jiāodiǎn Jìng / Jīudím Geng|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Blue Petal|', 7 , q'|A blue petal required to complete Mina's Trial.|' , nq'|あおのはなびら|', nq'|Ao no Hanabira|', nq'|Pétale Bleu|', nq'|Blaues Blatt|', nq'|Petalo azzurro|', nq'|Pétalo Azul|', nq'|파랑꽃잎|', nq'|Parang Kkochip|', nq'|藍色花瓣 / 蓝色花瓣|', nq'|Lán-sè Huābàn / Làahm-sīk Fāfáan|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Wood Mail|', 3 , q'|Mail with picture of a Slakoth.|' , nq'|ウッディメール|', nq'|Woody Mail|', nq'|Lettre Bois|', nq'|Waldbrief|', nq'|Mess. Bosco|', nq'|Carta Madera|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Purple Nectar|', 7 , q'|Changes Oricorio to its Sensu Style.|' , nq'|むらさきのミツ|', nq'|Murasaki no Mitsu|', nq'|Nectar Mauve|', nq'|Purpurner Nektar|', nq'|Nettare viola|', nq'|Néctar Violeta|', nq'|보라꿀|', nq'|Bora Kkul|', nq'|蘭紫色花蜜 / 兰紫色花蜜|', nq'|Lánzǐ-sè Huāmì / Làahnjí-sīk Fāmaht|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lost Item|', 2 , q'|Return to Copycat for access to Magnet Train.|' , nq'|おとしもの|', nq'|Otoshi Mono|', nq'|Poupée perdue|', nq'|Fundsache|', nq'|Strumento Perso|', nq'|Obj. Perdido|', nq'|분실물|', nq'|Bunsilmul|', nq'|遺失物 / 遗失物|', nq'|Yíshī Wù / Wàihsāt Maht|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Heal Ball|', 4 , q'|A type of Poké Ball that heals the captured Pokémon before it is put in the player's party. If the player's party is full, it will be transferred to the Box, where it would have been healed anyway.|' , nq'|ヒールボール|', nq'|Heal Ball|', nq'|Soin Ball|', nq'|Heilball|', nq'|Cura Ball|', nq'|Sana Ball|', nq'|힐볼|', nq'|Heal Ball|', nq'|治癒球 / 治愈球|', nq'|Zhìyù Qiú / Jihyuh Kàuh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Mech Mail|', 3 , q'|Mail with a mechanical pattern. To be held by a Pokémon for delivery.|' , nq'|メカニカルメール|', nq'|Mechanical Mail|', nq'|Lettre Meca|', nq'|Eilbrief|', nq'|Mess. Tecno|', nq'|Carta Imán|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Krane Memo 5|', 3 , q'|Contains information about the Purify Chamber.|' , nq'|クレインメモ５|', nq'|Krane Memo 5|', nq'|Memo Syrus 5|', nq'|Klein-Memo 5|', nq'|Appunti 5|', nq'|Parte Cío 5|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Poké Radar|', 4 , q'|Allows player to encounter wild Pokémon not usually seen in the area. Obtained after receiving National Pokédex.|' , nq'|ポケトレ|', nq'|Poké-Tra|', nq'|Poké Radar|', nq'|Pokéradar|', nq'|Poké Radar|', nq'|Pokéradar|', nq'|포켓트레|', nq'|Poké-Tra|', nq'|寶可追蹤 / 宝可追踪|', nq'|Bǎokě Zhuīzōng / Bóuhó Jēuijūng|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Silver Powder|', 2 , q'|Raises the power of Bug-type moves.|', q'|Formatted as SilverPowder prior to Generation VI.|', nq'|ぎんのこな|', nq'|Gin no Kona|', nq'|Poudre Argentée|', nq'|Silberstaub|', nq'|Argenpolvere|', nq'|Polvo Plata|', nq'|은빛가루|', nq'|Eunbit Garu|', nq'|銀粉 / 银粉|', nq'|Yínfěn / Ngàhnfán|', 1152 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Festival Ticket|', 7 , q'|A ticket that allows you to host a mission in Festival Plaza.|' , nq'|フェスチケット|', nq'|Fest Ticket|', nq'|Festicket|', nq'|Festival-Ticket|', nq'|Festicket|', nq'|Festicupón|', nq'|페스티켓|', nq'|Fest Ticket|', nq'|圓慶票 / 圆庆票|', nq'|Yuánqìng Piào / Yùhnhing Piu|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|R-Disk|', 3 , q'|Moves the UFO in The Under to the Under TV Station.|' , nq'|Ｒ－ディスク|', nq'|R-Disk|', nq'|Disque-D|', nq'|R-Disc|', nq'|Disco Dx|', nq'|Disco D|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Meadow Plate|', 4 , q'|Raises the power of Grass-type moves.|' , nq'|みどりのプレート|', nq'|Midori no Purēto|', nq'|Plaque Herbe|', nq'|Wiesentafel|', nq'|Lastraprato|', nq'|Tabla Pradal|', nq'|초록플레이트|', nq'|Chorok Plate|', nq'|碧綠石板 / 碧绿石板|', nq'|Bìlǜ Shíbǎn / Bīkluhk Sehkbáan|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Spell Tag|', 2 , q'|Raises the power of Ghost-type moves.|' , nq'|のろいのおふだ|', nq'|Noroi no Ofuda|', nq'|Rune Sort|', nq'|Bannsticker|', nq'|Spettrotarga|', nq'|Hechizo|', nq'|저주의부적|', nq'|Jeojuui Bujeok|', nq'|詛咒之符 / 诅咒之符|', nq'|Zǔzhòu-zhī Fú / Jojau-jī Fùh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Toxic Orb|', 4 , q'|Inflicts the Badly poisoned status on the holder.|' , nq'|どくどくだま|', nq'|Dokudoku Dama|', nq'|Orbe Toxique|', nq'|Toxik-Orb|', nq'|Tossicsfera|', nq'|Toxisfera|', nq'|맹독구슬|', nq'|Maengdok Guseul|', nq'|劇毒寶珠 / 剧毒宝珠|', nq'|Jùdú Bǎozhū / Kehkduhk Bóujyū|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Gear|', 3 , q'|Keeps the Pyrite Town generators going.|' , nq'|はぐるま|', nq'|Haguruma|', nq'|Roue Dentee|', nq'|Zahnrad|', nq'|Ingranaggio|', nq'|Rueda|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Voice Case 4|', 3 , q'|Apparently heals a Wobbuffet in Agate Village.|' , nq'|こえカプセル４|', nq'|Koe Capsule 4|', nq'|Boite Cri 4|', nq'|Stimmbox 4|', nq'|Disco Verso 4|', nq'|Grabación 4|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|PSNCureBerry|', 2 , q'|Cures poison.|' , nq'|どくけしのみ|', nq'|Dokukeshi no Mi|', nq'|Baie Antidot|', nq'|Ggngiftbeere|', nq'|Baccantivel.|', nq'|Bayantídoto|', nq'|해독열매|', nq'|Haedok Yeolmae|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Fire Memory|', 7 , q'|Makes Silvally a Fire-type Pokémon and makes Multi-Attack a Fire-type move.|' , nq'|ファイヤーメモリ|', nq'|Fire Memory|', nq'|ROM Feu|', nq'|Feuer-Disc|', nq'|ROM Fuoco|', nq'|Disco Fuego|', nq'|파이어메모리|', nq'|Fire Memory|', nq'|火焰記憶碟*|'||chr(10)||nq'|火焰存储碟|', nq'|Huǒyàn Jìyìdié / Fóyihm Geiyīkdihp*|'||chr(10)||nq'|Huǒyàn Cúnchǔdié|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|GB Sounds|', 4 , q'|Allows player to listen to 8-bit background music in Johto.|' , nq'|ＧＢプレイヤー|', nq'|GB Player|', nq'|Lecteur GB|', nq'|GB-Player|', nq'|Lettore GB|', nq'|Lector GB|', nq'|GB플레이어|', nq'|GB Player|', nq'|ＧＢ播放器|', nq'|GB Bōfàng Qì / GB Bofong Hei|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Adrenaline Orb|', 7 , q'|When used, makes wild Pokémon more likely to call allies for help in an SOS Battle. Is not consumed if it fails. If the holder is affected by Intimidate, its Speed is increased by one stage.|' , nq'|ビビリだま|', nq'|Bibiri Dama|', nq'|Orbe Frousse|', nq'|Zitterorb|', nq'|Fifasfera|', nq'|Nerviosfera|', nq'|주눅구슬|', nq'|Junuk Guseul|', nq'|膽怯球 / 胆怯球|', nq'|Dǎnqiè Qiú / Dáamhip Kàuh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Apicot Berry|', 3 , q'|Raises Special Defense when HP is below ⅓.|' , nq'|ズアのみ|', nq'|Zua no Mi|', nq'|Baie Abriko|', nq'|Apikobeere|', nq'|Baccacocca|', nq'|Baya Aricoc|', nq'|규살열매|', nq'|Gyusal Yeolmae|', nq'|杏仔果|', nq'|Xìngzǐ Guǒ / Hahngjái Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Red Orb|', 3 , q'|Awakens Groudon. It also turns Groudon into Primal Groudon during battle when holding the item.ORAS|' , nq'|べにいろのたま|', nq'|Beniiro no Tama|', nq'|Gemme Rouge|', nq'|Roter Edelstein|', nq'|Gemma rossa|', nq'|Prisma Roja|', nq'|주홍구슬|', nq'|Juhong Guseul|', nq'|朱紅色寶珠 / 朱红色宝珠|', nq'|Zhūhóng-sè Bǎozhū / Jyūhùhng-sīk Bóujyū|', 240 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Figy Berry|', 3 , q'|When HP falls below 25%, restores 50% HP, but confuses Pokémon that dislike spicy food (12.5% when below 50% before Gen. VII).|' , nq'|フィラのみ|', nq'|Fira no Mi|', nq'|Baie Figuy|', nq'|Giefebeere|', nq'|Baccafico|', nq'|Baya Higog|', nq'|무화열매|', nq'|Muhwa Yeolmae|', nq'|勿花果|', nq'|Wùhuā Guǒ / Mahtfā Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Flying Gem|', 5 , q'|Increases the power of the holder's first Flying-type move by 50%, and is consumed after use.|' , nq'|ひこうのジュエル|', nq'|Hikō no Jewel|', nq'|Joyau Vol|', nq'|Flugjuwel|', nq'|Bijouvolante|', nq'|Gema Voladora|', nq'|비행주얼|', nq'|Bihaeng Jewel|', nq'|飛行寶石 / 飞行宝石|', nq'|Fēixíng Bǎoshí / Fēihàhng Bóusehk|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Casteliacone|', 5 , q'|Cures any status condition.|' , nq'|ヒウンアイス|', nq'|Hiun Ice|', nq'|Glace Volute|', nq'|Stratos-Eis|', nq'|Conostropoli|', nq'|Porcehelado|', nq'|구름아이스|', nq'|Gureum Ice|', nq'|飛雲冰淇淋 / 飞云冰淇淋|', nq'|Fēiyún Bīngqílín / Fēiwàhn Bīngkèihlàhm|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Voice Case 5|', 3 , q'|Heals a Shroomish at ONBS.|' , nq'|こえカプセル５|', nq'|Koe Capsule 5|', nq'|Boite Cri 5|', nq'|Stimmbox 5|', nq'|Disco Verso 5|', nq'|Grabación 5|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Elixir|', 1 , q'|Restores 10 PP of each move of a Pokémon.|' , nq'|ピーピーエイダー|', nq'|PP Aider|', nq'|Elixir|', nq'|Elixier|', nq'|Elisir|', nq'|Elixir|', nq'|PP에이더|', nq'|PP Aider|', nq'|ＰＰ多項小補劑 / ＰＰ多项小补剂|', nq'|PP Duōxiàng Xiǎobǔjì / PP Dōhohng Síubóujaih|', 1024 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Roto Hatch|' , nq'|タマゴふかポン|', nq'|Tamago fuka Pon|', nq'|Moti-Couveuse|', nq'|Brutbon|', nq'|Cova'n'roll|', nq'|Cupón Eclosión|', nq'| ???|', nq'| ???|', nq'|孵蛋碰碰|', nq'|Fūdàn Pèngpèng / Fūdaahn Pungpung|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Moon Ball|', 2 , q'|A type of Poké Ball that works better on Pokémon that evolve using the Moon Stone.|' , nq'|ムーンボール|', nq'|Moon Ball|', nq'|Lune Ball|', nq'|Mondball|', nq'|Luna Ball|', nq'|Luna Ball|', nq'|문볼|', nq'|Moon Ball|', nq'|月亮球|', nq'|Yuèliàng Qiú / Yuhtleuhng Kàuh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|HP Up|', 1 , q'|Raises the HP of a Pokémon.|' , nq'|マックスアップ|', nq'|Max Up|', nq'|PV Plus|', nq'|KP-Plus|', nq'|PS-Su|', nq'|Más PS|', nq'|맥스업|', nq'|Max Up|', nq'|ＨＰ增強劑 / ＨＰ增强剂|', nq'|HP Zēngqiángjì / HP Jāngkèuhngjaih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI , CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|God Stone|', 5 , q'|Not available without cheating. Currently has no use.|' , nq'|ゴッドストーン|', nq'|God Stone|' , nq'|神石|', nq'|Shénshí / Sàhnsehk|', 1024 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Petaya Berry|', 3 , q'|Raises Special Attack if HP is below ⅓ of maximum.|' , nq'|ヤタピのみ|', nq'|Yatapi no Mi|', nq'|Baie Pitaye|', nq'|Tahaybeere|', nq'|Baccapitaya|', nq'|Baya Yapati|', nq'|야타비열매|', nq'|Yatabi Yeolmae|', nq'|龍火果 / 龙火果|', nq'|Lónghuǒ Guǒ / Lùhngfó Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Moon Stone|', 1 , q'|Can be used to evolve Clefairy, Jigglypuff, Nidorino, Nidorina, and Skitty.|' , nq'|つきのいし|', nq'|Tsuki no Ishi|', nq'|Pierre Lune|', nq'|Mondstein|', nq'|Pietralunare|', nq'|Piedra Lunar|', nq'|달의돌|', nq'|Dar-ui Dol|', nq'|月之石|', nq'|Yuè-zhī Shí / Yuht-jī Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Potion|', 1 , q'|Restores 20 HP.|' , nq'|キズぐすり|', nq'|Kizu Gusuri|', nq'|Potion|', nq'|Trank|', nq'|Pozione|', nq'|Poción|', nq'|상처약|', nq'|Sangcheo Yak|', nq'|傷藥 / 伤药|', nq'|Shāngyào / Sēungyeuhk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Red ID Badge|', 3 , q'|One of four keys needed to open the front door of Realgam Tower.|' , nq'|ＩＤバッジあか|', nq'|ID Badge Aka|', nq'|Passe Rouge|', nq'|Rote ID-Marke|', nq'|Pass Rosso|', nq'|Pase Rojo|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Bottle Cap|', 7 , q'|Can be traded to Mr. Hyper to maximize one of a Pokémon's IVs in Hyper Training.|' , nq'|ぎんのおうかん|', nq'|Gin no Ōkan|', nq'|Capsule d'Argent|', nq'|Silberkronkorken|', nq'|Tappo d'argento|', nq'|Chapa Plateada|', nq'|은왕관|', nq'|Eun Wanggwan|', nq'|銀色王冠 / 银色王冠|', nq'|Yínsè Wángguān / Ngàhnsīk Wòhnggūn|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dusk Stone|', 4 , q'|Can be used to evolve Misdreavus, Murkrow, Lampent, and Doublade.|' , nq'|やみのいし|', nq'|Yami no Ishi|', nq'|Pierre Nuit|', nq'|Finsterstein|', nq'|Neropietra|', nq'|Piedra Noche|', nq'|어둠의돌|', nq'|Eodumui Dol|', nq'|暗之石|', nq'|Àn-zhī Shí / Am-jī Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pearl String|', 5 , q'|Can be sold for 25000 to the ore collector|' , nq'|おだんごしんじゅ|', nq'|Odango Shinju|', nq'|Perle Triple|', nq'|Triperle|', nq'|Trittiperla|', nq'|Sarta Perlas|', nq'|경단진주|', nq'|Gyeongdan Jinju|', nq'|丸子珍珠|', nq'|Wánzi Zhēnzhū / Yùhnjí Jānjyū|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Iron Ball|', 4 , q'|Cuts a Pokémon's Speed and makes it susceptible to Ground-type moves.|' , nq'|くろいてっきゅう|', nq'|Kuroi Tekkyū|', nq'|Balle Fer|', nq'|Eisenkugel|', nq'|Ferropalla|', nq'|Bola Férrea|', nq'|검은철구|', nq'|Geomeun Cheolgu|', nq'|黑色鐵球 / 黑色铁球|', nq'|Hēi-sè Tiěqiú / Hāak-sīk Titkàuh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|DNA Sample|', 3 , q'|Used to deduce the code to a lock in the Shadow PKMN Lab.|' , nq'|ＤＮＡサンプル|', nq'|DNA Sample|', nq'|Echantillon ADN|', nq'|DNS-Probe|', nq'|Campione DNA|', nq'|Muestra ADN|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Data ROM|', 3 , q'|Holds data on Shadow Pokémon.|' , nq'|データロム|', nq'|Data ROM|', nq'|Disque-ROM|', nq'|CD-ROM|', nq'|CD ROM|', nq'|Disquete|' , 32 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Smooth Rock|', 4 , q'|Extends the duration of sandstorms.|' , nq'|さらさらいわ|', nq'|Sarasara Iwa|', nq'|Roche Lisse|', nq'|Glattbrocken|', nq'|Roccialiscia|', nq'|Roca Suave|', nq'|보송보송바위|', nq'|Bosongbosong Bawi|', nq'|沙沙岩石|', nq'|Shāshā Yánshí / Sāsā Ngàahmsehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dark Gem|', 5 , q'|Increases the power of the holder's first Dark-type move by 50%, and is consumed after use.|' , nq'|あくのジュエル|', nq'|Aku no Jewel|', nq'|Joyau Ténèbres|', nq'|Unlichtjuwel|', nq'|Bijoubuio|', nq'|Gema Siniestra|', nq'|악주얼|', nq'|Ak Jewel|', nq'|惡之寶石 / 恶之宝石|', nq'|È-zhī Bǎoshí / Ok-jī Bóusehk|', 144 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Tanga Berry|', 3 , q'|Lowers effectiveness of a super effective Bug-type move.|' , nq'|タンガのみ|', nq'|Tanga no Mi|', nq'|Baie Panga|', nq'|Tanigabeere|', nq'|Baccaitan|', nq'|Baya Yecana|', nq'|리체열매|', nq'|Riche Yeolmae|', nq'|扁櫻果 / 扁樱果|', nq'|Biǎnyīng Guǒ / Bínyīng Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|Ginema Berry|', 3 , q'|Raises a lowered stat in battle. If transferred to Generation IV via Pal Park, it will turn into an Enigma Berry.|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Surf Mail|', 2 , q'|Mail with a Lapras pattern. To be held by a Pokémon for delivery.|' , nq'|なみのりメール|', nq'|Naminori Mail|', nq'|Lettre Surf|', nq'|Surferbrief|', nq'|Mess. Surf|', nq'|Carta Surf|', nq'|파도타기메일|', nq'|Padotagi Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Diancite|', 6 , q'|Allows Diancie to Mega Evolve into Mega Diancie.|' , nq'|ディアンシナイト|', nq'|Diancinite|', nq'|Diancite|', nq'|Diancienit|', nq'|Diancite|', nq'|Diancita|', nq'|디안시나이트|', nq'|Diancienite|', nq'|蒂安希進化石 / 蒂安希进化石|', nq'|Dì'ānxī Jìnhuà Shí / Dai'ōnhēi Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Powerup Part|', 3 , q'|Used to fix the Kids Grid system.|' , nq'|きょうかパーツ|', nq'|Kyōka Parts|', nq'|Amplificateur|', nq'|Ersatzteil|', nq'|Espansione|', nq'|Potenciador|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Intriguing Stone|', 6 , q'|Can be exchanged for a Sun StoneXY/PidgeotiteORAS.|' , nq'|すごそうないし|', nq'|Sugosōna Ishi|', nq'|Pierre Insolite|', nq'|Kurioser Stein|', nq'|Sasso suggestivo|', nq'|Piedra Insólita|', nq'|대단할듯한돌|', nq'|Daedanhaldeushan Dol|', nq'|似珍石|', nq'|Sì Zhēnshí / Chíh Jānsehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Iron Plate|', 4 , q'|Raises the power of Steel-type moves.|' , nq'|こうてつプレート|', nq'|Koutetsu Purēto|', nq'|Plaque Fer|', nq'|Eisentafel|', nq'|Lastraferro|', nq'|Tabla Acero|', nq'|강철플레이트|', nq'|Gangcheol Plate|', nq'|鋼鐵石板 / 钢铁石板|', nq'|Gāngtiě Shíbǎn / Gongtit Sehkbáan|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Super Rod|', 1 , q'|Can be used next to or while Surfing on water to encounter high-level wild aquatic Pokémon.|' , nq'|すごいつりざお|', nq'|Sugoi Tsurizao|', nq'|Mega Canne|', nq'|Superangel|', nq'|Super Amo|', nq'|Supercaña|', nq'|대단한낚싯대|', nq'|Daedanhan Naksitdae|', nq'|厲害釣竿 / 厉害钓竿|', nq'|Lìhài Diàogān / Laihhoih Diugōn|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Small Tablet|', 3 , q'|Used to activate the Relic Stone.|' , nq'|ちいさなせきばん|', nq'|Chīsa na Sekiban|', nq'|Ardoise|', nq'|Steintafel|', nq'|Tavola|', nq'|Tablilla|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Steel Teeth|', 3 , q'|Give to the old man in front of Under Colosseum to obtain the L-Disk.|' , nq'|はがねのいれば|', nq'|Hagane no Ireba|', nq'|Dentier d'Acier|', nq'|Zahnprothese|', nq'|Dentacciaio|', nq'|Dentadura|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Chople Berry|', 4 , q'|Reduces damage from a super effective Fighting-type move by 50%.|' , nq'|ヨプのみ|', nq'|Yop no Mi|', nq'|Baie Pomroz|', nq'|Rospelbeere|', nq'|Baccarosmel|', nq'|Baya Pomaro|', nq'|로플열매|', nq'|Ropeul Yeolmae|', nq'|蓮蒲果 / 莲蒲果|', nq'|Liánpú Guǒ / Lìhnpòuh Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Flame Plate|', 4 , q'|Raises the power of Fire-type moves.|' , nq'|ひのたまプレート|', nq'|Hi no Tama Purēto|', nq'|Plaque Flam|', nq'|Feuertafel|', nq'|Lastrarogo|', nq'|Tabla Llama|', nq'|불구슬플레이트|', nq'|Bulguseul Plate|', nq'|火球石板|', nq'|Huǒqiú Shíbǎn / Fókàuh Sehkbáan|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Green Apricorn|', 2 , q'|Kurt will make the player a Friend Ball out of it.|', q'|Formatted as Grn Apricorn prior to Generation VI.|', nq'|みどぼんぐり|', nq'|Mido Bonguri|', nq'|Noigrume Ver|', nq'|Aprikoko Grn|', nq'|Ghicocca Verde|', nq'|Bonguri Verde|', nq'|초록규토리|', nq'|Chorok Gyutori|', nq'|綠球果 / 绿球果|', nq'|Lǜ Qiúguǒ / Luhk Kàuhgwó|', 1072 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Cameruptite|', 6 , q'|Allows Camerupt to Mega Evolve into Mega Camerupt.|' , nq'|バクーダナイト|', nq'|Bakuudanite|', nq'|Caméruptite|', nq'|Cameruptnit|', nq'|Cameruptite|', nq'|Cameruptita|', nq'|폭타나이트|', nq'|Poktanite|', nq'|噴火駝進化石 / 喷火驼进化石|', nq'|Pēnhuǒtuó Jìnhuà Shí / Panfótòh Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Medal Box|', 5 , q'|A box-shaped machine that stores Medals and Medal information.|' , nq'|メダルボックス|', nq'|Medal Box|', nq'|B. Médailles|', nq'|Medaillenbox|', nq'|Box Premi|', nq'|C. Insignias|', nq'|메달박스|', nq'|Medal Box|', nq'|獎牌盒 / 奖牌盒|', nq'|Jiǎngpái Hé / Jéungpáai Hahp|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Power Anklet|', 4 , q'|Promotes Speed EVs, but lowers Speed in battle.|' , nq'|パワーアンクル|', nq'|Power Ankle|', nq'|Chaîne Pouvoir|', nq'|Machtkette|', nq'|Vigorgliera|', nq'|Franja Recia|', nq'|파워앵클릿|', nq'|Power Anklet|', nq'|力量護踝 / 力量护踝|', nq'|Lìliàng Hùhuái / Lihkleuhng Wuhwahng|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Shiny Charm|', 5 , q'|A shiny charm said to increase the chance of finding a Shiny Pokémon.|' , nq'|ひかるおまもり|', nq'|Shining Charm|', nq'|Charme Chroma|', nq'|Schillerpin|', nq'|Cromamuleto|', nq'|Amuleto Iris|', nq'|빚나는부적|', nq'|Bitna-neun Bujeok|', nq'|閃耀護符 / 闪耀护符|', nq'|Shǎnyào Hùfú / Símyiuh Wuhfùh|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Rock Memory|', 7 , q'|Makes Silvally a Rock-type Pokémon and makes Multi-Attack a Rock-type move.|' , nq'|ロックメモリ|', nq'|Rock Memory|', nq'|ROM Roche|', nq'|Gesteins-Disc|', nq'|ROM Roccia|', nq'|Disco Roca|', nq'|락메모리|', nq'|Rock Memory|', nq'|岩石記憶碟*|'||chr(10)||nq'|岩石存储碟|', nq'|Yánshí Jìyìdié / Ngàahmsehk Geiyīkdihp*|'||chr(10)||nq'|Yánshí Cúnchǔdié|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Incinium Z|', 7 , q'|Allows Incineroar to upgrade Darkest Lariat to the special Z-Move Malicious Moonsault.|' , nq'|ガオガエンＺ|', nq'|Gaogaen-Z|', nq'|Félinozélite|', nq'|Fuegronium Z|', nq'|Incineronium Z|', nq'|Incinostal Z|', nq'|어흥염Z|', nq'|Eoheungyeom-Z|', nq'|熾焰咆哮虎Ｚ / 炽焰咆哮虎Ｚ|', nq'|Chìyànpáoxiāohǔ-Z / Chiyihmpàauhhāaufú-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Old Gateau|', 4 , q'|Cures any status condition.|' , nq'|もりのヨウカン|', nq'|Mori no Yōkan|', nq'|Vieux Gâteau|', nq'|Spezialität|', nq'|Dolce Gateau|', nq'|Barrita Plus|', nq'|숲의양갱|', nq'|Sup-ui Yanggaeng|', nq'|森之羊羹|', nq'|Sēn-zhī Yánggēng / Sām-jī Yèuhnggāng|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|Yago Berry|', 3 , q'|Pokéblock ingredient. Will turn into an Enigma Berry if transferred to Generation IV via Pal Park.|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Garchompite|', 6 , q'|Allows Garchomp to Mega Evolve into Mega Garchomp.|' , nq'|ガブリアスナイト|', nq'|Gaburiasnite|', nq'|Carchacrokite|', nq'|Knakracknit|', nq'|Garchompite|', nq'|Garchompita|', nq'|한카리아스나이트|', nq'|Hankariasnite|', nq'|烈咬陸鯊進化石 / 烈咬陆鲨进化石|', nq'|Lièyǎolùshā Jìnhuà Shí / Lihtngáauhluhksā Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Terrain Extender|', 7 , q'|Lengthens duration of Electric Terrain, Psychic Terrain, Grassy Terrain, Misty Terrain, as well as Electric Surge, Psychic Surge, Grassy Surge, and Misty Surge from 5 turns to 8 turns when used by the holder.|' , nq'|グランドコート|', nq'|Ground Coat|', nq'|Champ'Duit|', nq'|Feldbeschichtung|', nq'|Fissacampo|', nq'|Cubresuelos|', nq'|그라운드코트|', nq'|Ground Coat|', nq'|大地膜|', nq'|Dàdì Mó / Daaihdeih Mohk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Key to Room 1|', 6 , q'|Opens Room 1 of the Abandoned ShipRSE/Sea MauvilleORAS.|', q'|Called Rm. 1 Key in Generation III.|', nq'|いちごうしつのカギ|', nq'|Ichi-gō Shitsu no Kagi|', nq'|Clé Salle 1|', nq'|R1-Schlüssel|', nq'|Chiave stanza 1|', nq'|Ll. Habitación 1|', nq'|일호실열쇠|', nq'|Il-hosil Yeolsoe|', nq'|１號客房的鑰匙 /|'||chr(10)||nq'|１号客房的钥匙|', nq'|1 Hào Kèfáng-de Yàoshi / 1 Houh Haakfóng-dīk Yeuhksìh|', 1616 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Magma Stone|', 5 , q'|Allows the player to battle Heatran.|' , nq'|かざんのおきいし|', nq'|Kazan no Okiishi|', nq'|Pierre Magma|', nq'|Magmastein|', nq'|Magmapietra|', nq'|Piedra Magma|', nq'|화산의 돌|', nq'|Hwasan-ui Dol|', nq'|火山鎮石 / 火山镇石|', nq'|Huǒshān Zhènshí / Fósāan Jansehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Big Mushroom|', 2 , q'|Can be sold for 2500.|' , nq'|おおきなキノコ|', nq'|Ōkina Kinoko|', nq'|Gros Champi|', nq'|Riesenpilz|', nq'|Grande Fungo|', nq'|Seta Grande|', nq'|큰버섯|', nq'|Keun Beoseot|', nq'|大蘑菇|', nq'|Dà Mógū / Daaih Mòhgū|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Devon Scuba Gear|', 6 , q'|Worn while underwater.|' , nq'|デボンボンベ|', nq'|Devon Bombe|', nq'|Plongeur Devon|', nq'|Devon-Atemgerät|', nq'|Maschera Devon|', nq'|Bombona Devon|', nq'|데봉봄베|', nq'|Devon Bombe|', nq'|得文潛水裝備 / 得文潜水装备|', nq'|Déwén Qiánshuǐ Zhuāngbèi / Dākmàhn Chìhmséui Jōngbeih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Relic Silver|', 5 , q'|Can be sold for 5000 to the villa owner in Undella Town.|' , nq'|こだいのぎんか|', nq'|Kodai no Ginka|', nq'|Vieil Écu|', nq'|Alter Taler|', nq'|Ducatantico|', nq'|Real Plata|', nq'|고대의은화|', nq'|Godae-yi Eunhwa|', nq'|古代銀幣 / 古代银币|', nq'|Gǔdài Yínbì / Gúdoih Ngàhnbaih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lum Berry|', 3 , q'|Cures any status condition.|' , nq'|ラムのみ|', nq'|Ramu no Mi|', nq'|Baie Prine|', nq'|Prunusbeere|', nq'|Baccaprugna|', nq'|Baya Ziuela|', nq'|리샘열매|', nq'|Risaem Yeolmae|', nq'|木子果|', nq'|Mùzi Guǒ / Muhkjí Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Odd Incense|', 4 , q'|Raises the power of Psychic-type moves. Mr. Mime holding this can breed Mime Jr.|' , nq'|あやしいおこう|', nq'|Oyashii Okō|', nq'|Encens Bizarre|', nq'|Schrägrauch|', nq'|Bizzoaroma|', nq'|Incienso raro|', nq'|괴상한향로|', nq'|Goesanghan Hyangno|', nq'|奇異薰香 / 奇异薰香|', nq'|Qíyì Xūnxiāng / Kèihyih Fānhēung|', 144 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Tidal Bell|', 4 , q'|Allows the Kimono Girls to summon Lugia.|' , nq'|うみなりのスズ|', nq'|Uminari no Suzu|', nq'|Glas tempête|', nq'|Gischtglocke|', nq'|Camp. Onda|', nq'|Camp. Oleaje|', nq'|해명의방울|', nq'|Haemyeong-ui Bang-ul|', nq'|海聲鈴鐺 / 海声铃铛|', nq'|Hǎishēng Língdāng / Hóisīng Lìhngdōng|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Dragon Gem|', 5 , q'|Increases the power of the holder's first Dragon-type move by 50%, and is consumed after use.|' , nq'|ドラゴンジュエル|', nq'|Dragon Jewel|', nq'|Joyau Dragon|', nq'|Drakojuwel|', nq'|Bijoudrago|', nq'|Gema Dragón|', nq'|드래곤주얼|', nq'|Dragon Jueol|', nq'|龍之寶石 / 龙之宝石|', nq'|Lóng-zhī Bǎoshí / Lùhng-jī Bóusehk|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Tapunium Z|', 7 , q'|Allows the guardian deities to upgrade Nature's Madness to the special Z-Move Guardian of Alola.|' , nq'|カプＺ|', nq'|Kapu-Z|', nq'|Tokozélite|', nq'|Kapium Z|', nq'|Tapium Z|', nq'|Tapistal Z|', nq'|카푸Z|', nq'|Kapu-Z|', nq'|卡璞Ｚ|', nq'|Kǎpú-Z / Kāpok-Z|', 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Loot Sack|' , nq'|たからぶくろ|', nq'|Takara Bukuro|', nq'|Sac Butin|', nq'|Beutesack|', nq'|Bottinosacca|', nq'|Saca Botín|', nq'|보물주머니|', nq'|Bomul Jumeoni|', nq'|寶物袋 / 宝物袋|', nq'|Bǎowù Dài / Bóumaht Doih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Yellow Scarf|', 3 , q'|Raises the Tough condition.|' , nq'|きいろのバンダナ|', nq'|Kiiro no Bandana|', nq'|Foul. Jaune|', nq'|Gelber Schal|', nq'|Fascia Gialla|', nq'|Pañuelo Amarillo|', nq'|노랑밴드|', nq'|Norang Band|', nq'|黃色頭巾 / 黄色头巾|', nq'|Huáng-sè Tóujīn / Wòhng-sīk Tàuhgān|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Coupon 3|', 4 , q'|Used to obtain the Pokétch in Jubilife City.|' , nq'|ひきかえけん３|', nq'|Hikikaeken 3|', nq'|Bon 3|', nq'|Kupon 3|', nq'|Coupon 3|', nq'|Cupón 3|', nq'|교환권 3|', nq'|Gyohwangwon 3|', nq'|兌換券３ / 兑换券３|', nq'|Duìhuàn Quàn 3 / Deuiwuhn Hyun 3|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Big Malasada|', 7 , q'|Used to heal poison, paralysis, sleep, burn, freeze, and confusion.|' , nq'|おおきいマラサダ|', nq'|Ōkī Malasada|', nq'|Malasada Maxi|', nq'|Maxi-Malasada|', nq'|Malasada maxi|', nq'|Malasada Maxi|', nq'|큰 말라사다|', nq'|Keun Malasada|', nq'|大馬拉薩達 / 大马拉萨达|', nq'|Dà Mǎlāsàdá / Daaih Máhlāaisaatdaaht|', 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Photo Album|' , nq'|フォトアルバム|', nq'|Photo Album|', nq'|Album Photo|', nq'|Fotoalbum|', nq'|Album|', nq'|Álbum|', nq'|포토앨범|', nq'|Photo Album|', nq'|相簿*|'||chr(10)||nq'|相册|', nq'|Xiàngbù / Séungbóu*|'||chr(10)||nq'|Xiàngcè|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Tea|', 3 , q'|To be given to the thirsty guards to gain entry to Saffron City.|' , nq'|おちゃ|', nq'|Ocha|', nq'|The|', nq'|Tee|', nq'|Tè|', nq'|Té|', nq'|차|', nq'|Cha|', nq'|茶|', nq'|Chá / Chàh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|S.S. Ticket|', 1 , q'|Allows the player to board the S.S. AnneRBYFRLG, S.S. AquaGSCHGSS, or S.S TidalRSEORAS|' , nq'|ふねのチケット|', nq'|Fune no Ticket|', nq'|Passe Bateau|', nq'|Bootsticket|', nq'|Biglietto Nave|', nq'|Ticket Barco|', nq'|승선티켓|', nq'|Seungseon Ticket|', nq'|船票|', nq'|Chuánpiào / Syùhnpiu|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Glalitite|', 6 , q'|Allows Glalie to Mega Evolve into Mega Glalie.|' , nq'|オニゴーリナイト|', nq'|Onigohrinite|', nq'|Oniglalite|', nq'|Firnontornit|', nq'|Glalite|', nq'|Glalita|', nq'|얼음귀신나이트|', nq'|Urumkisinnite|', nq'|冰鬼護進化石 / 冰鬼护进化石|', nq'|Bīngguǐhù Jìnhuà Shí / Bīnggwáiwuh Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|PP Max|', 3 , q'|Raises the PP of a move to the maximum.|' , nq'|ポイントマックス|', nq'|Point Max|', nq'|PP Max|', nq'|AP-Top|', nq'|PP-Max|', nq'|PP Máximos|', nq'|포인트 맥스|', nq'|Point Max|', nq'|ＰＰ極限提升劑 / ＰＰ极限提升剂|', nq'|PP Jíxiàn Tíshēngjì / PP Gihkhaahn Tàihsīngjaih|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|Strib Berry|', 3 , q'|Pokéblock ingredient. Will become an Enigma Berry if transferred to Generation IV via Pal Park.|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Music Disc|', 3 , q'|Allows a change of music in Trest's house.|' , nq'|おんがくソフト|', nq'|Ongaku Soft|', nq'|CD Musique|', nq'|Musik-CD|', nq'|CD Musicale|', nq'|Disco Música|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Stick|', 2 , q'|Raises Farfetch'd's critical hit ratio.|' , nq'|ながねぎ|', nq'|Naganegi|', nq'|Baton|', nq'|Lauchstange|', nq'|Gambo|', nq'|Palo|', nq'|대파|', nq'|Daepa|', nq'|大蔥 / 大葱|', nq'|Dàcōng / Daaihchūng|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Ice Berry|', 2 , q'|Heals a burn.|' , nq'|こおったきのみ|', nq'|Kōtta Kino Mi|', nq'|Baie Gel|', nq'|Eisbeere|', nq'|Bacca Ghiac.|', nq'|Baya Hielo|', nq'|얼은나무열매|', nq'|Eoreun Namu Yeolmae|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pinap Berry|', 3 , q'|Pokéblock and Poffin ingredient.|' , nq'|パイルのみ|', nq'|Pairu no Mi|', nq'|Baie Nanana|', nq'|Sananabeere|', nq'|Baccananas|', nq'|Baya Pinia|', nq'|파인열매|', nq'|Pine Yeolmae|', nq'|凰梨果|', nq'|Huánglí Guǒ / Wòhnglèih Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Luminous Moss|', 6 , q'|Raises the holder's Special Defense by one stage after being hit by a Water-type attack. Consumed after use.|' , nq'|ひかりごけ|', nq'|Hikari Goke|', nq'|Lichen Lumineux|', nq'|Leuchtmoos|', nq'|Muschioluce|', nq'|Musgo Brillante|', nq'|빛이끼|', nq'|Bit Ikki|', nq'|光苔|', nq'|Guāngtái / Gwōngtòih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Air Balloon|', 5 , q'|Gives the holder an immunity to Ground-type moves but is popped when the holder is hit by any non-Ground-type attacks.|' , nq'|ふうせん|', nq'|Fūsen|', nq'|Ballon|', nq'|Luftballon|', nq'|Palloncino|', nq'|Globo Helio|', nq'|풍선|', nq'|Pungseon|', nq'|氣球 / 气球|', nq'|Qìqiú / Heikàuh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Kee Berry|', 6 , q'|Increases Defense when hit with a physical move.|' , nq'|アッキのみ|', nq'|Akki no Mi|', nq'|Baie Éka|', nq'|Akibeere|', nq'|Baccalighia|', nq'|Baya Biglia|', nq'|악키열매|', nq'|Akki Yeolmae|', nq'|亞開果 / 亚开果|', nq'|Yàkāi Guǒ / Ahōi Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|X Defend 2|', 5 , q'|Sharply raises a Pokémon's Defense. Wonder Launcher only.|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Forage Bag|', 7 , q'|Holds ingredients found during Mallow's trial.|' , nq'|ざいりょうぶくろ|', nq'|Zairyō Bukuro|', nq'|Sac Ingrédients|', nq'|Zutatenbeutel|', nq'|Portaingredienti|', nq'|Zurrón|', nq'|재료주머니|', nq'|Jaelyo Jumeoni|', nq'|材料袋|', nq'|Cáiliào Dài / Chòihlíu Doih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Magma Suit|', 6 , q'|Allows the player to ride Groudon in the Cave of Origin and fly into space on Rayquaza.|' , nq'|マグマスーツ|', nq'|Magma Suit|', nq'|Scaph. Magma|', nq'|Magma-Anzug|', nq'|Tuta Magma|', nq'|Traje Magma|', nq'|마그마슈트|', nq'|Magma Suit|', nq'|熔岩裝 / 熔岩装|', nq'|Róngyán Zhuāng / Yùhngngàahm Jōng|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Heavy Ball|', 2 , q'|A type of Poké Ball that works better on heavier Pokémon.|' , nq'|ヘビーボール|', nq'|Heavy Ball|', nq'|Masse Ball|', nq'|Schwerball|', nq'|Peso Ball|', nq'|Peso Ball|', nq'|헤비볼|', nq'|Heavy Ball|', nq'|沉重球|', nq'|Chénzhòng Qiú / Chàhmchúhng Kàuh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Wave Incense|', 4 , q'|Raises the power of Water-type moves. A Mantine holding it can breed to produce Mantyke Eggs.|' , nq'|さざなみのおこう|', nq'|Sazanami no Okō|', nq'|Encens Vague|', nq'|Wellenrauch|', nq'|Ondaroma|', nq'|Incienso aqua|', nq'|잔물결향로|', nq'|Janmulgyeol Hyangno|', nq'|漣漪薰香 / 涟漪薰香|', nq'|Liányī Xūnxiāng / Lìhnyí Fānhēung|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Z-Ring|', 7 , q'|Allows the player to use Z-Moves when a Pokémon is holding an appropriate Z-Crystal. Allows the player to use Mega Evolution after obtaining a Key Stone when a Pokémon is holding the appropriate Mega Stone.|' , nq'|Ｚリング|', nq'|Z-Ring|', nq'|Bracelet Z|', nq'|Z-Ring|', nq'|Cerchio Z|', nq'|Pulsera Z|', nq'|Z링|', nq'|Z Ring|', nq'|Ｚ手環 / Ｚ手环|', nq'|Z Shǒuhuán / Z Sáuwàahn|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|X Accuracy 2|', 5 , q'|Sharply raises a Pokémon's accuracy. Wonder Launcher only.|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Light Ball|', 2 , q'|Raises the Attack and Special Attack of Pikachu.|' , nq'|でんきだま|', nq'|Denki Dama|', nq'|Ballelumiere|', nq'|Kugelblitz|', nq'|Elettropalla|', nq'|Bolaluminosa|', nq'|전기구슬|', nq'|Jeon-gi Guseul|', nq'|電氣球 / 电气球|', nq'|Diàn Qìqiú / Dihn Heikàuh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Poisonium Z|', 7 , q'|Allows a Pokémon to upgrade their Poison-type damaging moves to the Z-Move Acid Downpour or upgrade their Poison-type status moves into Z-Moves. Makes Arceus a Poison-type Pokémon.|' , nq'|ドクＺ|', nq'|Poison-Z|', nq'|Toxizélite|', nq'|Toxium Z|', nq'|Venenium Z|', nq'|Toxistal Z|', nq'|독Z|', nq'|Dok-Z|', nq'|毒Ｚ|', nq'|Dú-Z / Duhk-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Net Ball|', 3 , q'|A type of Poké Ball that works better on Water- and Bug-type Pokémon.|' , nq'|ネットボール|', nq'|Net Ball|', nq'|Filet Ball|', nq'|Netzball|', nq'|Rete Ball|', nq'|Malla Ball|', nq'|넷트볼|', nq'|Net Ball|', nq'|捕網球 / 捕网球|', nq'|Bǔwǎng Qiú / Bouhmóhng Kàuh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Morph Mail|', 2 , q'|Mail with a Ditto design. To be held by a Pokémon for delivery.|' , nq'|へんしんメール|', nq'|Henshin Mail|', nq'|Lettre Morph|', nq'|Morph-Brief|', nq'|Mess. Morph|', nq'|Cartmorfosis|', nq'|변신메일|', nq'|Byeonsin Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Genius Wing|', 5 , q'|Raises the Special Attack of a Pokémon.|' , nq'|ちりょくのハネ|', nq'|Chiryoku no Hane|', nq'|Aile Esprit|', nq'|Geniefeder|', nq'|Piumingegno|', nq'|Pluma Intelecto|', nq'|지력날개|', nq'|Jiryeok Nalgae|', nq'|智力之羽|', nq'|Zhìlì-zhī Yǔ / Jilihk-jī Yúh|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Light Stone|', 5 , q'|Stone used to revive Reshiram|' , nq'|ライトストーン|', nq'|Light Stone|', nq'|Galet Blanc|', nq'|Lichtstein|', nq'|Chiarolite|', nq'|Orbe Claro|', nq'|라이트스톤|', nq'|Light Stone|', nq'|光明石|', nq'|Guāngmíng Shí / Gwōngmìhng Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Marshadium Z|', 7 , q'|Allows Marshadow to upgrade Spectral Thief to the special Z-Move Soul-Stealing 7-Star Strike.|' , nq'|マーシャドーＺ|', nq'|Marshadow-Z|', nq'|Marshadozélite|', nq'|Marshadownium Z|', nq'|Marshadium Z|', nq'|Marshastal Z|', nq'|마샤도Z|', nq'|Masyado-Z|', nq'|瑪夏多Ｚ / 玛夏多Ｚ|', nq'|Mǎxiàduō-Z / Máhahdō-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Resist Wing|', 5 , q'|Raises the Defense of a Pokémon.|' , nq'|ていこうのハネ|', nq'|Teikō no Hane|', nq'|Aile Armure|', nq'|Abwehrfeder|', nq'|Piumtutela|', nq'|Pluma Aguante|', nq'|저항력날개|', nq'|Jeohangryeok Nalgae|', nq'|抵抗之羽|', nq'|Dǐkàng-zhī Yǔ / Dáikong-jī Yúh|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Journal|', 4 , q'|Keeps track of events and accomplishments of the player.|' , nq'|ぼうけんノート|', nq'|Bōken Note|', nq'|Journal|', nq'|Tagebuch|', nq'|Agenda|', nq'|Diario|', nq'|모험노트|', nq'|Moheom Note|', nq'|冒險筆記 / 冒险笔记|', nq'|Màoxiǎn Bǐjì / Mouhhím Bātgei|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Chesto Berry|', 3 , q'|Awakens a Pokémon from sleep.|' , nq'|カゴのみ|', nq'|Kago no Mi|', nq'|Baie Maron|', nq'|Maronbeere|', nq'|Baccastagna|', nq'|Baya Atania|', nq'|유루열매|', nq'|Yuru Yeolmae|', nq'|零餘果 / 零余果|', nq'|Língyú Guǒ / Lìhngyùh Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Fairy Memory|', 7 , q'|Makes Silvally a Fairy-type Pokémon and makes Multi-Attack a Fairy-type move.|' , nq'|フェアリーメモリ|', nq'|Fairy Memory|', nq'|ROM Fée|', nq'|Feen-Disc|', nq'|ROM Folletto|', nq'|Disco Hada|', nq'|페어리메모리|', nq'|Fairy Memory|', nq'|妖精記憶碟*|'||chr(10)||nq'|妖精存储碟|', nq'|Yāojing Jìyìdié / Yíujīng Geiyīkdihp*|'||chr(10)||nq'|Yāojīng Cúnchǔdié|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Comet Shard|', 5 , q'|Can be sold for 60000.|' , nq'|すいせいのかけら|', nq'|Suisei no Kakera|', nq'|Morceau Comète|', nq'|Kometstück|', nq'|Pezzo Cometa|', nq'|Fragmento Cometa|', nq'|혜성조각|', nq'|Hyeseong Jogak|', nq'|彗星碎片|', nq'|Huìxīng Suìpiàn / Seuihsīng Seuipín|', 144 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pretty Wing|', 5 , q'|An item that does absolutely nothing.|' , nq'|きれいなハネ|', nq'|Kireina Hane|', nq'|Jolie Aile|', nq'|Prachtfeder|', nq'|Piumabella|', nq'|Pluma Bella|', nq'|고운날개|', nq'|Goun Nalgae|', nq'|美麗之羽 / 美丽之羽|', nq'|Měilì-zhī Yǔ / Méihlaih-jī Yúh|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Aguav Berry|', 3 , q'|When HP falls below 25%, restores 50% HP, but confuses Pokémon that dislike bitter food (12.5% when below 50% before Gen. VII).|' , nq'|バンジのみ|', nq'|Banji no Mi|', nq'|Baie Gowav|', nq'|Gauvebeere|', nq'|Baccaguava|', nq'|Baya Guaya|', nq'|아바열매|', nq'|Ava Yeolmae|', nq'|樂芭果 / 乐芭果|', nq'|Lèbā Guǒ / Lohkbā Gwó|', 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Roto Prize Money|' , nq'|おこづかいポン|', nq'|Okozukai Pon|', nq'|Moti-Magot|', nq'|Preisgeldbon|', nq'|Soldi'n'roll|', nq'|Cupón Botín|', nq'| ???|', nq'| ???|', nq'|零花錢碰碰 / 零花钱碰碰|', nq'|Líng Huāqián Pèngpèng / Lìhng Fāchín Pungpung|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Wacan Berry|', 4 , q'|Reduces damage taken from a super effective Electric-type move.|' , nq'|ソクノのみ|', nq'|Sokuno no Mi|', nq'|Baie Parma|', nq'|Kerzalberre|', nq'|Baccaparmen|', nq'|Baya Gualot|', nq'|초나열매|', nq'|Chona Yeolmae|', nq'|獨木果 / 独木果|', nq'|Zhúmù Guǒ / Jūkmuhk Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Gram 3|', 5 , q'|An important letter which Wingull delivers.|' , nq'|はいたつぶつ３|', nq'|Haitatsubutsu 3|', nq'|Courrier 3|', nq'|Briefpost 3|', nq'|Missiva 3|', nq'|Envío 3|', nq'|배달물3|', nq'|Baedalmul 3|', nq'|配送物品３|', nq'|Pèisòng Wùpǐn 3 / Puisung Mahtbán 3|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Rock Incense|', 4 , q'|Raises the power of Rock-type moves. A Sudowoodo holding this can breed to produce Bonsly Eggs.|' , nq'|がんせきおこう|', nq'|Ganseki Okō|', nq'|Encens Roc|', nq'|Steinrauch|', nq'|Roccioaroma|', nq'|Incienso roca|', nq'|암석향로|', nq'|Amseog Hyangno|', nq'|岩石薰香|', nq'|Yánshí Xūnxiāng / Ngàahmsehk Fānhēung|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|X Speed 6|', 5 , q'|Immensely raises a Pokémon's Speed. Wonder Launcher only.|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Steel Mail|', 4 , q'|Mail with a metallic design. To be held by a Pokémon for delivery.|' , nq'|スチールメール|', nq'|Steel Mail|', nq'|Lettre Acier|', nq'|Stahlbrief|', nq'|Mess. Lega|', nq'|Carta Acero|', nq'|스틸메일|', nq'|Steel Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Blazikenite|', 6 , q'|Allows Blaziken to Mega Evolve into Mega Blaziken.|' , nq'|バシャーモナイト|', nq'|Bursyamonite|', nq'|Braségalite|', nq'|Lohgocknit|', nq'|Blazikenite|', nq'|Blazikenita|', nq'|번치코나이트|', nq'|Bunchikonite|', nq'|火焰雞進化石 / 火焰鸡进化石|', nq'|Huǒyànjī Jìnhuà Shí / Fóyihmgāi Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Gold Leaf|', 2 , q'|Can be sold for 1000.|' , nq'|きんのはっぱ|', nq'|Kin no Happa|', nq'|Feuille D'Or|', nq'|Goldblatt|', nq'|Fogliadoro|', nq'|Hoja Dorada|', nq'|금빛나뭇잎|', nq'|Geumbit Namunnip|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pink Scarf|', 3 , q'|Raises the Cute condition.|' , nq'|ピンクのバンダナ|', nq'|Pink no Bandana|', nq'|Foul. Rose|', nq'|Rosa Schal|', nq'|Fascia Rosa|', nq'|Pañuelo Rosa|', nq'|분홍밴드|', nq'|Bunhong Band|', nq'|粉紅頭巾 / 粉红头巾|', nq'|Fěnhóng Tóujīn / Fánhùhng Tàuhgān|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Altarianite|', 6 , q'|Allows Altaria to Mega Evolve into Mega Altaria.|' , nq'|チルタリスナイト|', nq'|Tyltalisnite|', nq'|Altarite|', nq'|Altarianit|', nq'|Altarite|', nq'|Altarianita|', nq'|파비코리나이트|', nq'|Pavicorinite|', nq'|七夕青鳥進化石 / 七夕青鸟进化石|', nq'|Qīxìqīngniǎo Jìnhuà Shí / Chātjihkchīngníuh Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Krane Memo 2|', 3 , q'|Contains information about the Aura Reader.|' , nq'|クレインメモ２|', nq'|Krane Memo 2|', nq'|Memo Syrus 2|', nq'|Klein-Memo 2|', nq'|Appunti 2|', nq'|Parte Cío 2|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Helix Fossil|', 1 , q'|A Fossil from which an Omanyte can be resurrected.|' , nq'|かいのカセキ|', nq'|Kai no Kaseki|', nq'|Fossile Nautile|', nq'|Helixfossil|', nq'|Helixfossile|', nq'|Fósil Helix|', nq'|조개화석|', nq'|Jogae Hwaseok|', nq'|貝殼化石 / 贝壳化石|', nq'|Bèiké Huàshí / Buihok Fasehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Makeup Bag|', 7 , q'|A case for carrying lipsticks.|' , nq'|コスメポーチ|', nq'|Cosmetics Pouch|', nq'|Trousse Beauté|', nq'|Kosmetiketui|', nq'|Trousse|', nq'|Kit Maquillaje|', nq'|코스메틱파우치|', nq'|Cosmetics Pouch|', nq'|化妝包 / 化妆包|', nq'|Huàzhuāng Bāo / Fajōng Bāau|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Black Belt|', 2 , q'|Raises the power of Fighting-type moves.|', q'|Formatted as Blackbelt in Generation II.|', nq'|くろおび|', nq'|Kuro Obi|', nq'|Ceinture Noire|', nq'|Schwarzgurt|', nq'|Cinturanera|', nq'|Cinturón Negro|', nq'|검은띠|', nq'|Geomeun Tti|', nq'|黑帶 / 黑带|', nq'|Hēidài / Hāakdaai|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|D-Disk|', 3 , q'|Moves the UFO in The Under downward into Deep Colosseum.|' , nq'|Ｄ－ディスク|', nq'|D-Disk|', nq'|Disque-B|', nq'|U-Disc|', nq'|Disco Giù|', nq'|Disco B|' , 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Squirt Bottle|' , nq'|ゼニガメじょうろ|', nq'|Zenigame Jōro|', nq'|Carapuce à O|', nq'|Schiggykanne|', nq'|Annaffiatoio|', nq'|Regadera|', nq'|꼬부기물뿌리개|', nq'|Kkobugi Mulppurigae|', nq'|傑尼龜噴壺 / 杰尼龟喷壶|', nq'|Jiéníguī Pēnhú / Gihtnèihgwāi Panwùh|', 1024 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Leaf Stone|', 1 , q'|Can be used to evolve Gloom into Vileplume, Weepinbell into Victreebel, Exeggcute into Exeggutor, Nuzleaf into Shiftry, and Pansage into Simisage.|' , nq'|リーフのいし|', nq'|Leaf no Ishi|', nq'|Pierre Plante|', nq'|Blattstein|', nq'|Pietrafoglia|', nq'|Piedra Hoja|', nq'|리프의돌|', nq'|Leaf-ui Dol|', nq'|葉之石 / 叶之石|', nq'|Yè-zhī Shí / Yihp-jī Sehk|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Light Clay|', 4 , q'|Extends the duration of the moves Reflect and Light Screen.|' , nq'|ひかりのねんど|', nq'|Hikari no Nendo|', nq'|Lumargile|', nq'|Lichtlehm|', nq'|Creta Luce|', nq'|Refleluz|', nq'|빛의점토|', nq'|Bichui Jeomto|', nq'|光之黏土|', nq'|Guāng-zhī Niántǔ / Gwōng-jī Nìhmtóu|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Heal Powder|', 2 , q'|Heals any status condition, but lowers friendship.|' , nq'|ばんのうごな|', nq'|Bannō Gona|', nq'|Poudre Soin|', nq'|Heilpuder|', nq'|Polvocura|', nq'|Polvo Curación|', nq'|만능가루|', nq'|Manneung Garu|', nq'|萬能粉 / 万能粉|', nq'|Wànnéng Fěn / Maahnnàhng Fán|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Old Charm|', 4 , q'|Cynthia asks the player to deliver to Celestic Town. Is made of Pokémon bones.|' , nq'|こだいのおまもり|', nq'|Kodai no Omamori|', nq'|Vieux Grigri|', nq'|Talisman|', nq'|Arcamuleto|', nq'|Talismán|', nq'|고대의부적|', nq'|Godae-ui Bujeok|', nq'|古代護符 / 古代护符|', nq'|Gǔdài Hùfú / Gúdoih Wuhfùh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Cheri Berry|', 3 , q'|Heals paralysis.|' , nq'|クラボのみ|', nq'|Kurabo no Mi|', nq'|Baie Ceriz|', nq'|Amrenabeere|', nq'|Baccaliegia|', nq'|Baya Zreza|', nq'|버치열매|', nq'|Beochi Yeolmae|', nq'|櫻子果 / 樱子果|', nq'|Yīngzi Guǒ / Yīngjí Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|X Attack|', 1 , q'|Raises a Pokémon's Attack by 2 stages (1 stage before Gen. VII).|' , nq'|プラスパワー|', nq'|Plus Power|', nq'|Attaque +|', nq'|X-Angriff|', nq'|Attacco X|', nq'|Ataque X|', nq'|플러스파워|', nq'|Plus Power|', nq'|力量強化 / 力量强化|', nq'|Lìliàng Qiánghuà / Lihkleuhng Kèuhngfa|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Tropic Mail|', 3 , q'|Mail with a picture of Bellossom. To be held by a Pokémon for delivery.|' , nq'|トロピカルメール|', nq'|Tropical Mail|', nq'|Lettre Tropi|', nq'|Tropenbrief|', nq'|Mess. Tropic|', nq'|Carta Tropical|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pamtre Berry|', 3 , q'|Pokéblock and Poffin ingredient.|' , nq'|シーヤのみ|', nq'|Shīya no Mi|', nq'|Baie Palma|', nq'|Pallmbeere|', nq'|Baccapalma|', nq'|Baya Plama|', nq'|자야열매|', nq'|Jaya Yeolmae|', nq'|椰木果|', nq'|Yēmù Guǒ / Yèhmuhk Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lopunnite|', 6 , q'|Allows Lopunny to Mega Evolve into Mega Lopunny.|' , nq'|ミミロップナイト|', nq'|Mimilopnite|', nq'|Lockpinite|', nq'|Schlapornit|', nq'|Lopunnite|', nq'|Lopunnita|', nq'|이어롭나이트|', nq'|Ieoropnite|', nq'|長耳兔進化石 / 长耳兔进化石|', nq'|Cháng'ěrtù Jìnhuà Shí / Chèuhngyíhtou Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pure Incense|', 4 , q'|Causes Chimecho to produce a Chingling Egg at the Pokémon Day Care. Also lowers wild Pokémon encounter rate.|' , nq'|きよめのおこう|', nq'|Kiyome no Okō|', nq'|Encens Pur|', nq'|Scheuchrauch|', nq'|Puroaroma|', nq'|Incienso puro|', nq'|순결의향로|', nq'|Sun-gyeorui Hyangno|', nq'|潔淨薰香 / 洁净薰香|', nq'|Jiéjìng Xūnxiāng / Gitjehng Fānhēung|', 16 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Mega Cuff|' , nq'|メガブレス|', nq'|Mega Brace|', nq'|Méga-Manchette|', nq'|Mega-Armbänder|', nq'|Megapolsiera|', nq'|Megabrazalete|', nq'|메가블레스|', nq'|Mega Brace|', nq'|超級護腕 / 超级护腕|', nq'|Chāojí Hùwàn / Chīukāp Wuhwún|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Cover Fossil|', 5 , q'|A Fossil from which a Tirtouga can be resurrected.|' , nq'|ふたのカセキ|', nq'|Futa no Kaseki|', nq'|Fossile Plaque|', nq'|Schildfossil|', nq'|Fossiltappo|', nq'|Fósil Tapa|', nq'|덮개화석|', nq'|Deopgae Hwaseok|', nq'|背蓋化石 / 背盖化石|', nq'|Bèigài Huàshí / Buihgoi Fasehk|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Sky Plate|', 4 , q'|Raises the power of Flying-type moves.|' , nq'|あおぞらプレート|', nq'|Aozora Purēto|', nq'|Plaque Ciel|', nq'|Wolkentafel|', nq'|Lastracielo|', nq'|Tabla Cielo|', nq'|푸른하늘플레이트|', nq'|Pureun Haneul Plate|', nq'|藍天石板 / 蓝天石板|', nq'|Lántiān Shíbǎn / Làahmtīn Sehkbáan|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Old Amber|', 1 , q'|A Fossil from which an Aerodactyl can be resurrected.|' , nq'|ひみつのコハク|', nq'|Himitsu no Kohaku|', nq'|Vieil Ambre|', nq'|Altbernstein|', nq'|Ambra Antica|', nq'|Ambar Viejo|', nq'|비밀의호박|', nq'|Bimirui Hobak|', nq'|秘密琥珀|', nq'|Mìmì Hǔpò / Beimaht Fúpaak|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Cologne Case|', 3 , q'|Holds Scents.|' , nq'|コロンケース|', nq'|Cologne Case|', nq'|Boite a Parfums|', nq'|Essenz-Kiste|', nq'|Portaolio|', nq'|Caja Aromas|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Steel Gem|', 5 , q'|Increases the power of the holder's first Steel-type move by 50%, and is consumed after use.|' , nq'|はがねのジュエル|', nq'|Hagane no Jewel|', nq'|Joyau Acier|', nq'|Stahljuwel|', nq'|Bijouacciaio|', nq'|Gema Acero|', nq'|강철주얼|', nq'|Gangcheol Jewel|', nq'|鋼之寶石 / 钢之宝石|', nq'|Gāng-zhī Bǎoshí / Gong-jī Bóusehk|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Scanner|', 3 , q'|To be exchanged for a Deep Sea Scale or Deep Sea Tooth.|' , nq'|たんちき|', nq'|Tanchiki|', nq'|Scanner|', nq'|Scanner|', nq'|Scanner|', nq'|Escáner|', nq'|탐지기|', nq'|Tamjigi|', nq'|探測器 / 探测器|', nq'|Tàncèqì / Taamchākhei|', 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Roto Catch|' , nq'|つかまえポン|', nq'|Tsukamae Pon|', nq'|Moti-Capture|', nq'|Fangbon|', nq'|Acchiappa'n'roll|', nq'|Cupón Captura|', nq'| ???|', nq'| ???|', nq'|捕捉碰碰|', nq'|Bǔzhuō Pèngpèng / Bouhjūk Pungpung|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|Surfboard|', 1 , q'|An item that can be used to travel on water, much like using the hidden move Surf. Unobtainable during normal gameplay.|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Space Mail|', 4 , q'|Mail with an outer space pattern. To be held by a Pokémon for delivery.|' , nq'|スペースメール|', nq'|Space Mail|', nq'|Lettre Cosmo|', nq'|Sternbrief|', nq'|Mess. Spazio|', nq'|Car. Sideral|', nq'|스페이스메일|', nq'|Space Mail|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Focus Band|', 2 , q'|May leave the holder with 1 HP when a move would normally cause them to faint.|' , nq'|きあいのハチマキ|', nq'|Kiai no Hachimaki|', nq'|Bandeau|', nq'|Fokus-Band|', nq'|Bandana|', nq'|Cinta Focus|', nq'|기합의머리띠|', nq'|Gihabui Meoritti|', nq'|氣勢頭帶 / 气势头带|', nq'|Qìshì Tóudài / Heisai Tàuhdaai|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lustrous Orb|', 4 , q'|Boosts Palkia's Water- and Dragon-type attacks.|' , nq'|しらたま|', nq'|Shiratama|', nq'|Orbe Perlé|', nq'|Weiß-Orb|', nq'|Splendisfera|', nq'|Lustresfera|', nq'|백옥|', nq'|Baegok|', nq'|白玉寶珠 / 白玉宝珠|', nq'|Báiyù Bǎozhū / Baahkyuhk Bóujyū|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Rainbow Wing|', 2 , q'|Summons Ho-Oh.|' , nq'|にじいろのはね|', nq'|Nijiiro no Hane|', nq'|Arcenci'Aile|', nq'|Buntschwinge|', nq'|Ala d'Iride|', nq'|Ala Arcoíris|', nq'|무지개빛날개|', nq'|Mujigaebit Nalgae|', nq'|虹色之羽|', nq'|Hóng-sè-zhī Yǔ / Hùhng-sīk-jī Yúh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|X Speed 3|', 5 , q'|Drastically raises a Pokémon's Speed. Wonder Launcher only.|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Stone Plate|', 4 , q'|Raises the power of Rock-type moves.|' , nq'|がんせきプレート|', nq'|Ganseki Purēto|', nq'|Plaque Roc|', nq'|Steintafel|', nq'|Lastrapietra|', nq'|Tabla Pétrea|', nq'|암석플레이트|', nq'|Amseok Plate|', nq'|岩石石板|', nq'|Yánshí Shíbǎn / Ngàahmsehk Sehkbáan|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Wiki Berry|', 3 , q'|When HP falls below 25%, restores 50% HP, but confuses Pokémon that dislike dry food (12.5% when below 50% before Gen. VII).|' , nq'|ウイのみ|', nq'|Wi no Mi|', nq'|Baie Wiki|', nq'|Wikibeere|', nq'|Baccakiwi|', nq'|Baya Wiki|', nq'|위키열매|', nq'|Wiki Yeolmae|', nq'|異奇果 / 异奇果|', nq'|Yìqí Guǒ / Yihkèih Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lava Cookie|', 3 , q'|Cures any status condition.|' , nq'|フエンせんべい|', nq'|Fuen Senbei|', nq'|Lava Cookie|', nq'|Lavakeks|', nq'|Lavottino|', nq'|Galleta Lava|', nq'|용암전병|', nq'|Yong-am Jeonbyeong|', nq'|釜炎仙貝 / 釜炎仙贝|', nq'|Fǔyán Xiānbèi / Fúyìhm Sīnbui|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Slowpoke Tail|', 2 , q'|Can be sold for 4900.|', q'|Formatted as SlowpokeTail prior to Generation VI.|', nq'|おいしいシッポ|', nq'|Oishii Shippo|', nq'|Queueramolos|', nq'|Flegmonrute|', nq'|Codaslowpoke|', nq'|Colaslowpoke|', nq'|맛있는꼬리|', nq'|Masinneun Kkori|', nq'|美味尾巴|', nq'|Měiwèi Wěiba/Měiwèi Yǐba / Méihmeih Méihbā|', 1024 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Joy Scent|', 3 , q'|Reduces heart gauge by a small amount, but increases friendship.|' , nq'|ルンルンのかおり|', nq'|Runrun no Kaori|', nq'|P. Doux|', nq'|Froh-E.|', nq'|Olio di Pino|', nq'|Ar. Alegría|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Carbos|', 1 , q'|Raises the Speed of a Pokémon.|' , nq'|インドメタシン|', nq'|Indometacin|', nq'|Carbone|', nq'|Carbon|', nq'|Carburante|', nq'|Carburante|', nq'|알칼로이드|', nq'|Alkaloid|', nq'|速度增強劑 / 速度增强剂|', nq'|Sùdù Zēngqiángjì / Chūkdouh Jāngkèuhngjaih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Blue Orb|', 3 , q'|Used to awaken Kyogre. It also turns Kyogre into Primal Kyogre during battle when holding the item.ORAS|' , nq'|あいいろのたま|', nq'|Aiiro no Tama|', nq'|Gemme Bleue|', nq'|Blauer Edelstein|', nq'|Gemma blu|', nq'|Prisma Azul|', nq'|쪽빛구슬|', nq'|Jjokbit Guseul|', nq'|靛藍色寶珠 / 靛蓝色宝珠|', nq'|Diànlán-sè Bǎozhū / Dihnlàahm-sīk Bóujyū|', 240 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Kebia Berry|', 4 , q'|Lowers effectiveness of a super effective Poison-type move.|' , nq'|ビアーのみ|', nq'|Biah no Mi|', nq'|Baie Kébia|', nq'|Grarzbeere|', nq'|Baccakebia|', nq'|Baya Kebia|', nq'|으름열매|', nq'|Eureum Yeolmae|', nq'|通通果|', nq'|Tōngtōng Guǒ / Tūngtūng Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Shadow Mail|', 3 , q'|Mail with a picture of Duskull. To be held by a Pokémon for delivery.|' , nq'|シャドーメール|', nq'|Shadow Mail|', nq'|Lettre Ombre|', nq'|Dunkelbrief|', nq'|Mess. Ombra|', nq'|Carta Sombra|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|ID Card|', 3 , q'|Permits access to a restricted elevator at the Cipher Lab.|' , nq'|ＩＤカード|', nq'|ID Card|', nq'|Badge|', nq'|ID-Karte|', nq'|Tessera|', nq'|Tarjeta ID|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Colbur Berry|', 4 , q'|Reduces damage from a super effective Dark-type move by 50%.|' , nq'|ナモのみ|', nq'|Namo no Mi|', nq'|Baie Lampou|', nq'|Burleobeere|', nq'|Baccaxan|', nq'|Baya Dillo|', nq'|마코열매|', nq'|Mako Yeolmae|', nq'|刺耳果|', nq'|Cì'ěr Guǒ / Chiyíh Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Fire Stone|', 1 , q'|Can be used to evolve Vulpix, Growlithe, Eevee, and Pansear.|' , nq'|ほのおのいし|', nq'|Honō no Ishi|', nq'|Pierre Feu|', nq'|Feuerstein|', nq'|Pietrafocaia|', nq'|Piedra Fuego|', nq'|불꽃의돌|', nq'|Bulkkoch-ui Dol|', nq'|火之石|', nq'|Huǒ-zhī Shí / Fó-jī Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Red Shard|', 3 , q'|Exchangeable for a variety of services.|' , nq'|あかいかけら|', nq'|Akai Kakera|', nq'|Tesson Rouge|', nq'|Purpurstück|', nq'|Coccio Rosso|', nq'|Parte Roja|', nq'|빨강조각|', nq'|Ppalgang Jogak|', nq'|紅色碎片 / 红色碎片|', nq'|Hóngsè Suìpiàn / Hùhngsīk Seuipin|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Blue Flute|', 3 , q'|Awakens sleeping Pokémon when used, can be used an unlimited number of times. May be used in battle or in the field.RSEFRLGColoXDDPPtHGSSORAS Can be sold for 7000.BWB2W2|' , nq'|あおいビードロ|', nq'|Aoi Vidro|', nq'|Flûte Bleue|', nq'|Blaue Flöte|', nq'|Flauto Blu|', nq'|Flauta Azul|', nq'|파랑비드로|', nq'|Parang Vidro|', nq'|藍色玻璃哨 / 蓝色玻璃哨|', nq'|Lán-sè Bōlí Shào / Làahm-sīk Bōlèih Saau|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Black Apricorn|', 2 , q'|If taken to Kurt, he will make the player a Fast Ball. Also, Apricorn Drink ingredient.|', q'|Formatted as Blk Apricorn prior to Generation VI.|', nq'|くろぼんぐり|', nq'|Kuro Bonguri|', nq'|Noigrume Noi|', nq'|Aprikoko Swz|', nq'|Ghicocca Nera|', nq'|Bonguri Negro|', nq'|검은규토리|', nq'|Geomeun Gyutori|', nq'|黑球果|', nq'|Hēi Qiúguǒ / Hāak Kàuhgwó|', 1072 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Roto Stealth|' , nq'|かくれポン|', nq'|Kakure Pon|', nq'|Moti-Camouflage|', nq'|Schutzbon|', nq'|Repelle'n'roll|', nq'|Cupón Sigilo|', nq'| ???|', nq'| ???|', nq'|隱身碰碰 / 隐身碰碰|', nq'|Yǐnshēn Pèngpèng / Yánsān Pungpung|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Shalour Sable|', 6 , q'|Cures any status condition.|' , nq'|シャラサブレ|', nq'|Shala Sable|', nq'|Sablé Yantreizh|', nq'|Yantara-Sablé|', nq'|Yantafrollino|', nq'|Galleta Yantra|', nq'|사라사블레|', nq'|Sara Sable|', nq'|娑羅沙布蕾 / 娑罗沙布蕾|', nq'|Suōluó Shābùlěi / Sōlòh Sāboulèuih|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Weakness Policy|', 6 , q'|Attack and Sp. Atk sharply increase if the holder is hit with a super effective move.|' , nq'|じゃくてんほけん|', nq'|Jakuten Hoken|', nq'|Vulné-Assurance|', nq'|Schwächenschutz|', nq'|Vulneropolizza|', nq'|Seguro Debilidad|', nq'|약점보험|', nq'|Yagjeom Boheom|', nq'|弱點保險 / 弱点保险|', nq'|Ruòdiǎn Bǎoxiǎn / Yeuhkdím Bóuhím|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Blu ID Badge|', 3 , q'|One of four keys needed to unlock the north door of Realgam Tower.|' , nq'|ＩＤバッジあお|', nq'|ID Badge Ao|', nq'|Passe Bleu|', nq'|Blaue ID-Marke|', nq'|Pass Blu|', nq'|Pase Azul|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Sprayduck|', 4 , q'|Used to water Berry plants.|' , nq'|コダックじょうろ|', nq'|Koduck Jōro|', nq'|Kwakarrosoir|', nq'|Entonkanne|', nq'|Sprayduck|', nq'|Psydugadera|', nq'|고라파덕물뿌리개|', nq'|Gorapaduck Mulppurigae|', nq'|可達鴨噴壺 / 可达鸭喷壶|', nq'|Kědáyā Pēnhú / Hódaahtáap Panwùh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Sparkling Stone|', 7 , q'|Given to Hala to make a Z-RingSM or Z-Power RingUSUM.|' , nq'|かがやくいし|', nq'|Kagayaku Ishi|', nq'|Gemme Lumière|', nq'|Glitzerstein|', nq'|Pietra lucente|', nq'|Piedra Brillante|', nq'|빛나는돌|', nq'|Bichnaneun Dol|', nq'|光輝石 / 光辉石|', nq'|Guānghuī Shí / Gwōngfāi Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Shoal Salt|', 3 , q'|Can be used to make a Shell Bell. Does not have any use in Generation IV. Can be sold to an item maniac in the Icirrus City Pokémon Center for 7000 in Generation V.|' , nq'|あさせのしお|', nq'|Asase no Shio|', nq'|Sel Trefonds|', nq'|Küstensalz|', nq'|Sale Ondoso|', nq'|Sal Cardumen|', nq'|여울소금|', nq'|Yeoul Sogeum|', nq'|淺灘海鹽 / 浅滩海盐|', nq'|Qiǎntān Hǎiyán / Chíntāan Hóiyìhm|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Hondew Berry|', 3 , q'|Lowers Special Attack EV, but raises friendship.|' , nq'|ロメのみ|', nq'|Rome no Mi|', nq'|Baie Lonme|', nq'|Honmelbeere|', nq'|Baccamelon|', nq'|Baya Meluce|', nq'|로매열매|', nq'|Lome Yeolmae|', nq'|哈密果|', nq'|Hāmì Guǒ / Hāmaht Gwó|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Pearl|', 2 , q'|Can be sold for 3750.|' , nq'|しんじゅ|', nq'|Shinju|', nq'|Perle|', nq'|Perle|', nq'|Perla|', nq'|Perla|', nq'|진주|', nq'|Jinju|', nq'|珍珠|', nq'|Zhēnzhū / Jānjyū|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Galladite|', 6 , q'|Allows Gallade to Mega Evolve into Mega Gallade.|' , nq'|エルレイドナイト|', nq'|Erureidonite|', nq'|Gallamite|', nq'|Galagladinit|', nq'|Galladite|', nq'|Galladita|', nq'|엘레이드나이트|', nq'|Elladenite|', nq'|艾路雷朵進化石 / 艾路雷朵进化石|', nq'|Àilùléiduǒ Jìnhuà Shí / Ngaaihlouhlèuidó Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lucarionite|', 6 , q'|Allows Lucario to Mega Evolve into Mega Lucario.|' , nq'|ルカリオナイト|', nq'|Lucarionite|', nq'|Lucarite|', nq'|Lucarionit|', nq'|Lucarite|', nq'|Lucarita|', nq'|루카리오나이트|', nq'|Lucarionite|', nq'|路卡利歐進化石 / 路卡利欧进化石|', nq'|Lùkǎlì'ōu Jìnhuà Shí / Louhkāleih'āu Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Sitrus Berry|', 3 , q'|Restores 30 HP in Generation III. Restores ¼ of maximum HP from Generation IV onwards.|' , nq'|オボンのみ|', nq'|Obon no Mi|', nq'|Baie Sitrus|', nq'|Tsitrubeere|', nq'|Baccacedro|', nq'|Baya Zidra|', nq'|자뭉열매|', nq'|Jamung Yeolmae|', nq'|文柚果|', nq'|Wényòu Guǒ / Màhnyauh Gwó|', 0 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Roto HP Restore|' , nq'|ＨＰかいふくポン|', nq'|HP Kaifuku Pon|', nq'|Moti-Récup' PV|', nq'|KP-Bon|', nq'|PS'n'roll|', nq'|Cupón PS|', nq'| ???|', nq'| ???|', nq'|ＨＰ回復碰碰 /|'||chr(10)||nq'|ＨＰ回复碰碰|', nq'|HP Huífù Pèngpèng / HP Wùihfuhk Pungpung|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Eject Button|', 5 , q'|Forces the holder to switch out when hit by an attack that makes contact. Consumed after use.|' , nq'|だっしゅつボタン|', nq'|Dasshutsu Button|', nq'|Bouton Fuite|', nq'|Fluchtknopf|', nq'|Pulsantefuga|', nq'|Botón Escape|', nq'|탈출버튼|', nq'|Talchul Button|', nq'|逃脫按鍵 / 逃脱按键|', nq'|Táotuō Ànjiàn / Tòuhtyut Ongihn|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Shiny Stone|', 4 , q'|Can be used to evolve Togetic, Roselia, Minccino, and Floette.|' , nq'|ひかりのいし|', nq'|Hikari no Ishi|', nq'|Pierre Éclat|', nq'|Leuchtstein|', nq'|Pietrabrillo|', nq'|Piedra Día|', nq'|빛의돌|', nq'|Bichui Dol|', nq'|光之石|', nq'|Guāng-zhī Shí / Gwōng-jī Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Cherish Ball|', 4 , q'|A special type of Poké Ball in which event Pokémon are usually distributed.|' , nq'|プレジャスボール|', nq'|Precious Ball|', nq'|Mémoire Ball|', nq'|Jubelball|', nq'|Pregio Ball|', nq'|Gloria Ball|', nq'|프레셔스볼|', nq'|Precious Ball|', nq'|貴重球 / 贵重球|', nq'|Guìzhòng Qiú / Gwaijuhng Kàuh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Sceptilite|', 6 , q'|Allows Sceptile to Mega Evolve into Mega Sceptile.|' , nq'|ジュカインナイト|', nq'|Jukainnite|', nq'|Jungkite|', nq'|Gewaldronit|', nq'|Sceptilite|', nq'|Sceptilita|', nq'|나무킹나이트|', nq'|Namukingnite|', nq'|蜥蜴王進化石 / 蜥蜴王进化石|', nq'|Xīyìwáng Jìnhuà Shí / Sīkyihkwòhng Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|RSVP Mail|', 5 , q'|Stationary designed for invitations. To be held by a Pokémon for delivery.|' , nq'|おさそいメール|', nq'|Osasoi Mail|', nq'|Lettre Invit|', nq'|Einladebrief|', nq'|Mess. Invito|', nq'|C. Invitar|', nq'|권유메일|', nq'|Gweon'yu Mail|', nq'|邀請郵件 / 邀请邮件|', nq'|Yāoqǐng Yóujiàn / Yīuchíng Yàuhgín|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Power Belt|', 4 , q'|Promotes Defense EVs, but lowers Speed in battle.|' , nq'|パワーベルト|', nq'|Power Belt|', nq'|Ceinture Pouvoir|', nq'|Machtgurt|', nq'|Vigorfascia|', nq'|Cinto Recio|', nq'|파워벨트|', nq'|Power Belt|', nq'|力量腰帶 / 力量腰带|', nq'|Lìliàng Yāodài / Lihkleuhng Yīudáai|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|X Attack 2|', 5 , q'|Sharply raises a Pokémon's Attack. Wonder Launcher only.|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Level Ball|', 2 , q'|A type of Poké Ball that works better on Pokémon with a lower level than the player's.|' , nq'|レベルボール|', nq'|Level Ball|', nq'|Niveau Ball|', nq'|Levelball|', nq'|Level Ball|', nq'|Nivel Ball|', nq'|레벨볼|', nq'|Level Ball|', nq'|等級球 / 等级球|', nq'|Děngjí Qiú / Dángkāp Kàuh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Griseous Orb|', 4 , q'|Raises the power of Giratina's Ghost- and Dragon-type moves, and causes it to take on its Origin Forme.|' , nq'|はっきんだま|', nq'|Hakkin Dama|', nq'|Orbe Platiné|', nq'|Platinum-Orb|', nq'|Grigiosfera|', nq'|Griseosfera|', nq'|백금옥|', nq'|Baekgeum Ok|', nq'|白金寶珠 / 白金宝珠|', nq'|Báijīn Bǎozhū / Baahkgām Bóujyū|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Choice Specs|', 4 , q'|Raises user's Special Attack, but they can only use one move.|' , nq'|こだわりメガネ|', nq'|Kodawari Megane|', nq'|Lunettes Choix|', nq'|Wahlglas|', nq'|Lentiscelta|', nq'|Gafas Elegid|', nq'|구애안경|', nq'|Guae An-gyeong|', nq'|講究眼鏡 / 讲究眼镜|', nq'|Jiǎngjiù Yǎnjìng / Gónggau Ngáahngeng|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Ride Pager|', 7 , q'|By entering certain numbers on this pager, you can summon Ride Pokémon in an instant.|' , nq'|ライドギア|', nq'|Ride Gear|', nq'|Appel-Monture|', nq'|PokéMobil-Funk|', nq'|Chiamapassaggio|', nq'|Buscamontura|', nq'|라이드기어|', nq'|Ride Gear|', nq'|騎行裝置 / 骑行装置|', nq'|Qíxíng Zhuāngzhì / Kèihhàahng Jōngji|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Water Stone|', 1 , q'|Can be used to evolve Poliwhirl into Poliwrath, Shellder into Cloyster, Staryu into Starmie, Eevee into Vaporeon, Lombre into Ludicolo, and Panpour into Simipour.|' , nq'|みずのいし|', nq'|Mizu no Ishi|', nq'|Pierre Eau|', nq'|Wasserstein|', nq'|Pietraidrica|', nq'|Piedra Agua|', nq'|물의돌|', nq'|Murui Dol|', nq'|水之石|', nq'|Shuǐ-zhī Shí / Séui-jī Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Aerodactylite|', 6 , q'|Allows Aerodactyl to Mega Evolve into Mega Aerodactyl.|' , nq'|プテラナイト|', nq'|Pteranite|', nq'|Ptéraïte|', nq'|Aerodactylonit|', nq'|Aerodactylite|', nq'|Aerodactylita|', nq'|프테라나이트|', nq'|Pteranite|', nq'|化石翼龍進化石 / 化石翼龙进化石|', nq'|Huàshíyìlóng Jìnhuà Shí / Fasehkyihklùhng Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Quick Ball|', 4 , q'|A type of Poké Ball that works better the earlier in battle it is used.|' , nq'|クイックボール|', nq'|Quick Ball|', nq'|Rapide Ball|', nq'|Flottball|', nq'|Velox Ball|', nq'|Veloz Ball|', nq'|퀵볼|', nq'|Quick Ball|', nq'|先機球 / 先机球|', nq'|Xiānjī Qiú / Sīngēi Kàuh|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Green Shard|', 3 , q'|Exchangeable for a variety of services.|' , nq'|みどりのかけら|', nq'|Midori no Kakera|', nq'|Tesson Vert|', nq'|Grünstück|', nq'|Coccio Verde|', nq'|Parte Verde|', nq'|초록조각|', nq'|Chorok Jogak|', nq'|綠色碎片 / 绿色碎片|', nq'|Lǜsè Suìpiàn / Luhksīk Seuipin|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Solganium Z|', 7 , q'|Allows Solgaleo and Dusk Mane Necrozma to upgrade Sunsteel Strike to the special Z-Move Searing Sunraze Smash.|' , nq'|ソルガレオＺ|', nq'|Solgaleo-Z|', nq'|Solgazélite|', nq'|Solgalium Z|', nq'|Solgaleium Z|', nq'|Solgaleostal Z|', nq'|솔가레오Z|', nq'|Solgaleo-Z|', nq'|索爾迦雷歐Ｚ / 索尔迦雷欧Ｚ|', nq'|Suǒ'ěrjiāléiōu-Z / Sokyíhgālèuihāu-Z|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Big Root|', 4 , q'|Increases the amount of HP restored when an HP-draining move is used by 30%.|' , nq'|おおきなねっこ|', nq'|Ōkina Nekko|', nq'|Grosse Racine|', nq'|Großwurzel|', nq'|Granradice|', nq'|Raíz Grande|', nq'|큰뿌리|', nq'|Keun Ppuri|', nq'|大根莖 / 大根茎|', nq'|Dà Gēnjīng / Daaih Gānging|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Armor Fossil|', 4 , q'|A Fossil from which a Shieldon can be resurrected.|' , nq'|たてのカセキ|', nq'|Tate no Kaseki|', nq'|Fossile Armure|', nq'|Panzerfossil|', nq'|Fossilscudo|', nq'|Fósil Coraza|', nq'|방패의화석|', nq'|Bangpae-ui Hwaseok|', nq'|盾甲化石|', nq'|Dùnjiǎ Huàshí / Téuhngaap Fasehk|', 128 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|Touga Berry|', 3 , q'|Cures Confusion. If transferred to Generation IV via Pal Park, it will turn into an Enigma Berry.|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Honor of Kalos|', 6 , q'|Proof of defeating Team Flare and becoming Champion of the Kalos Pokémon League.|' , nq'|カロスエンブレム|', nq'|Kalos Emblem|', nq'|Insigne de Kalos|', nq'|Kalos-Emblem|', nq'|Emblema di Kalos|', nq'|Emblema de Kalos|', nq'|칼로스엠블럼|', nq'|Kalos Emblem|', nq'|卡洛斯勳章 / 卡洛斯勋章|', nq'|Kǎluòsī Xūnzhāng / Kāloksī Fānjēung|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Voice Case 1|', 3 , q'|Heals a Combusken in Agate Village.|' , nq'|こえカプセル１|', nq'|Koe Capsule 1|', nq'|Boite Cri 1|', nq'|Stimmbox 1|', nq'|Disco Verso 1|', nq'|Grabación 1|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Sharpedonite|', 6 , q'|Allows Sharpedo to Mega Evolve into Mega Sharpedo.|' , nq'|サメハダナイト|', nq'|Samehadenite|', nq'|Sharpedite|', nq'|Tohaidonit|', nq'|Sharpedite|', nq'|Sharpedonita|', nq'|샤크니아나이트|', nq'|Sharknianite|', nq'|巨牙鯊進化石 / 巨牙鲨进化石|', nq'|Jùyáshā Jìnhuà Shí / Geuihngàhsā Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Deep Sea Scale|', 3 , q'|A hold item that allows Clamperl to evolve into Gorebyss when traded.|', q'|Formatted as DeepSeaScale prior to Generation VI.|', nq'|しんかいのウロコ|', nq'|Shinkai no Uroko|', nq'|Écaille Océan|', nq'|Abyssplatte|', nq'|Squamabissi|', nq'|Escama Marina|', nq'|심해의비늘|', nq'|Simhae-ui Bineul|', nq'|深海鱗片 / 深海鳞片|', nq'|Shēnhǎi Línpiàn / Sāmhói Lèuhnpin|', 1152 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Fighting Gem|', 5 , q'|Increases the power of the holder's first Fighting-type move by 50%, and is consumed after use.|' , nq'|かくとうジュエル|', nq'|Kakutō Jewel|', nq'|Joyau Combat|', nq'|Kampfjuwel|', nq'|Bijoulotta|', nq'|Gema Lucha|', nq'|격투주얼|', nq'|Gyeoktu Jewel|', nq'|格鬥寶石 / 格斗宝石|', nq'|Gédòu Bǎoshí / Gaakdau Bóusehk|', 16 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Electric Seed|', 7 , q'|A one-time use item that raises the holder's Defense by one stage upon activation of Electric Terrain.|' , nq'|エレキシード|', nq'|Electric Seed|', nq'|Graine Électrik|', nq'|Elektro-Samen|', nq'|Elettroseme|', nq'|Semilla Electro|', nq'|일렉트릭시드|', nq'|Electric Seed|', nq'|電氣種子 / 电气种子|', nq'|Diànqì Zhǒngzi / Dihnhei Júngjí|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Grass Memory|', 7 , q'|Makes Silvally a Grass-type Pokémon and makes Multi-Attack a Grass-type move.|' , nq'|グラスメモリ|', nq'|Grass Memory|', nq'|ROM Plante|', nq'|Pflanzen-Disc|', nq'|ROM Erba|', nq'|Disco Planta|', nq'|그래스메모리|', nq'|Grass Memory|', nq'|青草記憶碟*|'||chr(10)||nq'|青草存储碟|', nq'|Qīngcǎo Jìyìdié / Chīngchóu Geiyīkdihp*|'||chr(10)||nq'|Qīngcǎo Cúnchǔdié|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Xtransceiver|', 5 , q'|Used to make video calls to other players. Also used by in-game Trainers to advance the story.|' , nq'|ライブキャスター|', nq'|Live Caster|', nq'|Vokit|', nq'|Viso-Caster|', nq'|Interpoké|', nq'|Videomisor|', nq'|라이브캐스터|', nq'|Live Caster|', nq'|即時通訊器 / 即时通讯器|', nq'|Jíshí Tōngxùn Qì / Jīksìh Tūngseun Hei|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Ein File C|', 3 , q'|Describes Celebi.|' , nq'|ボルグファイルＣ|', nq'|Borg File C|', nq'|Dossier Teck C|', nq'|Culpa-Akte C|', nq'|Genus.File C|', nq'|Parte Ein: C|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|X Sp. Atk|', 1 , q'|Raises a Pokémon's Special Attack (Special in Generation I) by 2 stages (1 stage before Gen. VII).|', q'|Called X Special prior to Generation VI.|', nq'|スペシャルアップ|', nq'|Special Up|', nq'|Special +|', nq'|X-Spezial|', nq'|Att. Speciale X|', nq'|Especial X|', nq'|스페셜업|', nq'|Special-Up|', nq'|特攻強化 / 特攻强化|', nq'|Tègōng Qiánghuà / Dahkgūng Kèuhngfa|', 1056 );
insert into ITEMS( NAME , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Data Card|' , nq'|データカード|', nq'|Data Card|', nq'|Carte Mémo|', nq'|Datenkarte|', nq'|Scheda Dati|', nq'|Tarjeta Datos|', nq'|데이터카드|', nq'|Data Card|', nq'|資料卡*|'||chr(10)||nq'|数据卡|', nq'|Zīliào Kǎ / Jīlíu Kāat*|'||chr(10)||nq'|Shùjù Kǎ|', 3 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED , STAR )
values( q'|Item Urge|', 5 , q'|Causes an ally to use its held item. Wonder Launcher only.|' , nq'|アイテムコール|', nq'|Item Call|', nq'|Appel Objet|', nq'|Itemappell|', nq'|Chiamoggetto|', nq'|Activaobjeto|', nq'|아이템콜|', nq'|Item Call|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Lucky Punch|', 3 , q'|Raises Chansey's critical hit rate.|' , nq'|ラッキーパンチ|', nq'|Lucky Punch|', nq'|Poing Chance|', nq'|Lucky Punch|', nq'|Fortunpugno|', nq'|Puño Suerte|', nq'|럭키펀치|', nq'|Lucky Punch|', nq'|吉利拳|', nq'|Jílì Quán / Gātleih Kyùhn|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH , STAR )
values( q'|Bike Voucher|', 1 , q'|Used to pay for a Bicycle.|' , nq'|ひきかえけん|', nq'|Hikikaeken|', nq'|Bon Commande|', nq'|Rad Coupon|', nq'|Buono Bici|', nq'|Bono Bici|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Wailmer Pail|', 3 , q'|Used to water Berry plants.|' , nq'|ホエルコじょうろ|', nq'|Hoeruko Jōro|', nq'|Wailmerrosoir|', nq'|Wailmerkanne|', nq'|Vaso Wailmer|', nq'|Wailmegadera|', nq'|고래왕자물뿌리개|', nq'|Goraewangja Mulppurigae|', nq'|吼吼鯨噴壺 / 吼吼鲸喷壶|', nq'|Hǒuhǒujīng Pēnhú / Hāauhāaukìhng Panwùh|', 144 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|X Speed 2|', 5 , q'|Sharply raises a Pokémon's Speed. Wonder Launcher only.|' , 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Spooky Plate|', 4 , q'|Raises the power of Ghost-type moves.|' , nq'|もののけプレート|', nq'|Mononoke Purēto|', nq'|Plaque Fantô|', nq'|Spuktafel|', nq'|Lastratetra|', nq'|Tabla Terror|', nq'|원령플레이트|', nq'|Wollyeong Plate|', nq'|妖怪石板|', nq'|Yāoguài Shíbǎn / Yīugwaai Sehkbáan|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Big Nugget|', 5 , q'|Can be sold for 30000.|' , nq'|でかいきんのたま|', nq'|Dekai Kin no Tama|', nq'|Maxi Pépite|', nq'|Riesennugget|', nq'|Granpepita|', nq'|Maxipepita|', nq'|큰금구슬|', nq'|Keun Geum Guseul|', nq'|巨大金珠|', nq'|Jùdà Jīnzhū / Geuihdaaih Gāmjyū|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Burn Heal|', 1 , q'|Heals a burn.|' , nq'|やけどなおし|', nq'|Yakedo Naoshi|', nq'|Anti-Brûle|', nq'|Feuerheiler|', nq'|Antiscottatura|', nq'|Antiquemar|', nq'|화상치료제|', nq'|Hwasang Chiryoje|', nq'|灼傷藥 / 灼伤药|', nq'|Zhuóshāngyào / Cheuksēungyeuhk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|White Herb|', 3 , q'|Raises a lowered stat.|' , nq'|しろいハーブ|', nq'|Shiroi Herb|', nq'|Herbe Blanche|', nq'|Schlohkraut|', nq'|Erbachiara|', nq'|Hierba Blanca|', nq'|하양허브|', nq'|Hayang Herb|', nq'|白色香草|', nq'|Bái-sè Xiāngcǎo / Baahk-sīk Hēungchóu|', 144 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Plasma Card|', 5 , q'|A card key needed to enter the password inside the Plasma Frigate.|' , nq'|プラズマカード|', nq'|Plasma Card|', nq'|Carte Plasma|', nq'|Plasmakarte|', nq'|Carta Plasma|', nq'|Tarjeta Plasma|', nq'|플라스마카드|', nq'|Plasma Card|', nq'|等離子卡 / 等离子卡|', nq'|Děnglízǐ Kǎ / Dánglèihjí Kāat|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Blastoisinite|', 6 , q'|Allows Blastoise to Mega Evolve into Mega Blastoise.|' , nq'|カメックスナイト|', nq'|Kamexnite|', nq'|Tortankite|', nq'|Turtoknit|', nq'|Blastoisite|', nq'|Blastoisita|', nq'|거북왕나이트|', nq'|Geobugwangnite|', nq'|水箭龜進化石 / 水箭龟进化石|', nq'|Shuǐjiànguī Jìnhuà Shí / Séuijingwāi Jeunfa Sehk|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION, NOTE, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Thunder Stone|', 1 , q'|Can be used to evolve Pikachu into Raichu, Eevee into Jolteon, and Eelektrik to Eelektross.|', q'|Formatted as Thunderstone prior to Generation VI.|', nq'|かみなりのいし|', nq'|Kaminari no Ishi|', nq'|Pierre Foudre|', nq'|Donnerstein|', nq'|Pietratuono|', nq'|Piedra Trueno|', nq'|천둥의돌|', nq'|Cheondung-ui Dol|', nq'|雷之石|', nq'|Léi-zhī Shí / Lèuih-jī Sehk|', 1168 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Flame Orb|', 4 , q'|Inflicts a burn on the holder.|' , nq'|かえんだま|', nq'|Kaen Dama|', nq'|Orbe Flamme|', nq'|Heiß-Orb|', nq'|Fiammosfera|', nq'|Llamasfera|', nq'|화염구슬|', nq'|Hwayeom Guseul|', nq'|火焰寶珠 / 火焰宝珠|', nq'|Huǒyàn Bǎozhū / Fóyihm Bóujyū|', 0 );
insert into ITEMS( NAME, GEN , DESCRIPTION , JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED, STAR )
values( q'|Yellow Shard|', 3 , q'|Exchangeable for a variety of services.|' , nq'|きいろいかけら|', nq'|Kiiroi Kakera|', nq'|Tesson Jaune|', nq'|Gelbstück|', nq'|Coccio Giallo|', nq'|Parte Amarilla|', nq'|노랑조각|', nq'|Norang Jogak|', nq'|黃色碎片 / 黄色碎片|', nq'|Huángsè Suìpiàn / Wòhngsīk Seuipin|', 48 );
insert into ITEMS( NAME, GEN , DESCRIPTION , STAR )
values( q'|Pumkin Berry|', 3 , q'|Cures a frozen Pokémon. If transferred to Generation IV via Pal Park, it will turn into an Enigma Berry.|' , 0 );
create table POKEMON(
NAME nvarchar2(100) not null, --Name of the Pokemon
DEX number(4,0) default on null 0 primary key CONSTRAINT ck_DEX_PosZero check(DEX>=0), --Pokedex number of the Pokemon
PAGE number(2,0) check(PAGE>=0), --The page the Pokemon appers in it's habitat
HABITAT varchar2(40) , --The primary habitat of the species
LDEX number(3,0) CONSTRAINT ck_LDEX_PosZero check(LDEX>=0), --The local Pokedex number of the Pokemon
LDEX_SUFFIX varchar2(2 byte) CONSTRAINT ck_LDEX_SUFFIX_Cap check(regexp_like(ldex_suffix, '[A-Z][a-zA-Z]?')), --Local Pokedex Suffix
GEN number(1,0) references GENERATION(GEN) check(gen>0), --The generation of the pokemon
GROUP char(1) , --The IQ Group of the pokemon
CONSTRAINT un_POKEMON unique(Name, Dex) --Enforce that Name and Dex are unique
);
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Helioptile]', 694 , 46, 'Co', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Golett]', 622 , 128 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Ferroseed]', 597 , 103 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Gastly]', 92, 7, q'|Cave|', 92 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Masquerain]', 284, 5, q'|Water's-edge|', 33 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Walrein]', 365, 9, q'|Sea|', 175 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Tapu Koko]', 785 , 285 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Torchic]', 255, 26, q'|Grassland|', 4 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Timburr]', 532 , 38 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Kecleon]', 352, 20, q'|Forest|', 145 , 3 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Chespin]', 650 , 1, 'Ce', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Buneary]', 427 , 67 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Wailord]', 321, 10, q'|Sea|', 100 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Snorunt]', 361, 3, q'|Cave|', 171 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Mienshao]', 620 , 126 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Aggron]', 306, 11, q'|Mountain|', 72 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Butterfree]', 12, 1, q'|Forest|', 12 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Ekans]', 23, 9, q'|Grassland|', 23 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Beheeyem]', 606 , 112 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Guzzlord]', 799 , 299 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Vigoroth]', 288, 16, q'|Forest|', 37 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Mienfoo]', 619 , 125 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Zorua]', 570 , 76 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Cofagrigus]', 563 , 69 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Drifloon]', 425 , 65 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Surskit]', 283, 5, q'|Water's-edge|', 32 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Meditite]', 307, 7, q'|Mountain|', 76 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Smoochum]', 238, 6, q'|Urban|', 154 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Beldum]', 374, 10, q'|Rough-terrain|', 190 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Sigilyph]', 561 , 67 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Popplio]', 728 , 7 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Parasect]', 47, 9, q'|Forest|', 47 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Cinccino]', 573 , 79 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Marshtomp]', 259, 15, q'|Water's-edge|', 8 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Taillow]', 276, 5, q'|Grassland|', 25 , 3 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Fennekin]', 653 , 4, 'Ce', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Bouffalant]', 626 , 132 , 5 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Noivern]', 715 , 114, 'Mo', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Riolu]', 447 , 115 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Panpour]', 515 , 21 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Komala]', 775 , 222 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Nidoran♀]', 29, 3, q'|Grassland|', 29 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Swinub]', 220, 3, q'|Cave|', 195 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Miltank]', 241, 16, q'|Grassland|', 151 , 2 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Yungoos]', 734 , 13 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Probopass]', 476 , 156 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Cosmog]', 789 , 289 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Luxray]', 405 , 19 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Totodile]', 158, 14, q'|Water's-edge|', 7 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Trapinch]', 328, 6, q'|Rough-terrain|', 116 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Pelipper]', 279, 2, q'|Sea|', 28 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Wingull]', 278, 2, q'|Sea|', 27 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Cutiefly]', 742 , 83 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Pansear]', 513 , 19 , 5 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Xerneas]', 716 , 148, 'Mo', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Lugia]', 249, 3, q'|Rare|', 252 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Staryu]', 120, 3, q'|Sea|', 120 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Alakazam]', 65, 4, q'|Urban|', 65 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Groudon]', 383, 11, q'|Rough-terrain|', 199 , 3 );
insert into POKEMON( NAME, DEX , GEN )
values( nq'[Arceus]', 493 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Hypno]', 97, 14, q'|Grassland|', 97 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Virizion]', 640 , 146 , 5 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Dedenne]', 702 , 110, 'Co', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Morelull]', 755 , 145 , 7 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Fletchinder]', 662 , 15, 'Ce', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Corsola]', 222, 7, q'|Sea|', 173 , 2 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Thundurus]', 642 , 148 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Bronzor]', 436 , 88 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Sceptile]', 254, 25, q'|Forest|', 3 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Carvanha]', 318, 10, q'|Sea|', 97 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Cleffa]', 173, 4, q'|Mountain|', 40 , 2 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Gallade]', 475 , 160 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Regirock]', 377, 10, q'|Cave|', 193 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Solosis]', 577 , 83 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Exeggutor]', 103, 19, q'|Forest|', 103 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Incineroar]', 727 , 6 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Gumshoos]', 735 , 14 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Persian]', 53, 1, q'|Urban|', 53 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Delcatty]', 301, 17, q'|Forest|', 62 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Giratina]', 487 , 210 , 4 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Pyroar]', 668 , 58, 'Ce', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Budew]', 406 , 25 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Primeape]', 57, 2, q'|Mountain|', 57 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Prinplup]', 394 , 8 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Venipede]', 543 , 49 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Exeggcute]', 102, 19, q'|Forest|', 102 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Rhydon]', 112, 2, q'|Rough-terrain|', 112 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Solgaleo]', 791 , 291 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Oshawott]', 501 , 7 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Kirlia]', 281, 5, q'|Urban|', 30 , 3 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Tyrunt]', 696 , 64, 'Co', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Chatot]', 441 , 102 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Litten]', 725 , 4 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Dragonite]', 149, 12, q'|Water's-edge|', 149 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Zapdos]', 145, 2, q'|Rare|', 145 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Ralts]', 280, 5, q'|Urban|', 29 , 3 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Zygarde]', 718 , 150, 'Mo', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Bulbasaur]', 1, 23, q'|Grassland|', 1 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Kommo-o]', 784 , 273 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Tangrowth]', 465 , 182 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Purrloin]', 509 , 15 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Watchog]', 505 , 11 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Karrablast]', 588 , 94 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Blacephalon]', 806 , 393 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Rayquaza]', 384, 5, q'|Rare|', 200 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Unown]', 201, 1, q'|Rare|', 61 , 2 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Zoroark]', 571 , 77 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Yanma]', 193, 11, q'|Forest|', 101 , 2 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Tapu Bulu]', 787 , 287 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Azurill]', 298, 8, q'|Water's-edge|', 54 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Kricketot]', 401 , 15 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Vullaby]', 629 , 135 , 5 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Floette]', 670 , 69, 'Ce', 6 );
insert into POKEMON( NAME, DEX , GEN )
values( nq'[Shaymin]', 492 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Golduck]', 55, 6, q'|Water's-edge|', 55 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Cacturne]', 332, 5, q'|Rough-terrain|', 120 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Rufflet]', 627 , 133 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Meloetta]', 648 , 154 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Seaking]', 119, 1, q'|Water's-edge|', 119 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Mareanie]', 747 , 113 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Blissey]', 242, 8, q'|Urban|', 223 , 2 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Larvesta]', 636 , 142 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Gigalith]', 526 , 32 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Braviary]', 628 , 134 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Reuniclus]', 579 , 85 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Charjabug]', 737 , 28 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Weezing]', 110, 2, q'|Urban|', 110 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Sandslash]', 28, 2, q'|Rough-terrain|', 28 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Claydol]', 344, 8, q'|Rough-terrain|', 132 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Victreebel]', 71, 8, q'|Forest|', 71 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Ivysaur]', 2, 23, q'|Grassland|', 2 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Toxapex]', 748 , 114 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Flaaffy]', 180, 11, q'|Grassland|', 54 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Vulpix]', 37, 17, q'|Grassland|', 37 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Lilligant]', 549 , 55 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Spiritomb]', 442 , 108 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Torkoal]', 324, 10, q'|Mountain|', 105 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Gulpin]', 316, 14, q'|Grassland|', 95 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Milotic]', 350, 10, q'|Water's-edge|', 141 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Armaldo]', 348, 11, q'|Water's-edge|', 136 , 3 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Scatterbug]', 664 , 20, 'Ce', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Rattata]', 19, 1, q'|Grassland|', 19 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Seadra]', 117, 11, q'|Sea|', 117 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Sewaddle]', 540 , 46 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Carnivine]', 455 , 131 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Sentret]', 161, 1, q'|Grassland|', 19 , 2 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Scolipede]', 545 , 51 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Flygon]', 330, 6, q'|Rough-terrain|', 118 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Spearow]', 21, 1, q'|Rough-terrain|', 21 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Slowbro]', 80, 9, q'|Water's-edge|', 80 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Xurkitree]', 796 , 296 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Grotle]', 388 , 2 , 4 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Sylveon]', 700 , 85, 'Co', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Pidgeotto]', 17, 5, q'|Forest|', 17 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Toucannon]', 733 , 12 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Tyranitar]', 248, 12, q'|Mountain|', 251 , 2 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Axew]', 610 , 116 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Shroomish]', 285, 9, q'|Forest|', 34 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Graveler]', 75, 1, q'|Mountain|', 75 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Geodude]', 74, 1, q'|Mountain|', 74 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Togepi]', 175, 24, q'|Forest|', 46 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Sneasel]', 215, 18, q'|Forest|', 218 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Fearow]', 22, 1, q'|Rough-terrain|', 22 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Staravia]', 397 , 11 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Mew]', 151, 8, q'|Rare|', 151 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Cherubi]', 420 , 58 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Escavalier]', 589 , 95 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Minior]', 774 , 213 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Joltik]', 595 , 101 , 5 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Diancie]', 719 , 151, 'Ce', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Klang]', 600 , 106 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Magmar]', 126, 10, q'|Mountain|', 126 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Dwebble]', 557 , 63 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Cacnea]', 331, 5, q'|Rough-terrain|', 119 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Paras]', 46, 9, q'|Forest|', 46 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Azumarill]', 184, 8, q'|Water's-edge|', 133 , 2 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Golisopod]', 768 , 183 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Spinda]', 327, 9, q'|Mountain|', 114 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Jumpluff]', 189, 7, q'|Grassland|', 69 , 2 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Stunfisk]', 618 , 124 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Golem]', 76, 1, q'|Mountain|', 76 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Poliwhirl]', 61, 7, q'|Water's-edge|', 61 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Mudkip]', 258, 15, q'|Water's-edge|', 7 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Glalie]', 362, 3, q'|Cave|', 172 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Shuckle]', 213, 8, q'|Mountain|', 168 , 2 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Aegislash]', 681 , 119, 'Ce', 6 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Fletchling]', 661 , 14, 'Ce', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Magneton]', 82, 3, q'|Rough-terrain|', 82 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Arcanine]', 59, 21, q'|Grassland|', 59 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Golurk]', 623 , 129 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Munna]', 517 , 23 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Sawsbuck]', 586 , 92 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Sudowoodo]', 185, 19, q'|Forest|', 107 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Vaporeon]', 134, 11, q'|Urban|', 134 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Cherrim]', 421 , 59 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Xatu]', 178, 6, q'|Forest|', 162 , 2 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Scraggy]', 559 , 65 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Shelgon]', 372, 9, q'|Rough-terrain|', 188 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Azelf]', 482 , 148 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Chandelure]', 609 , 115 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Porygon]', 137, 9, q'|Urban|', 137 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Shellder]', 90, 5, q'|Sea|', 90 , 1 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Florges]', 671 , 70, 'Ce', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Zeraora]', 807 , 403 , 7 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Aromatisse]', 683 , 130, 'Ce', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Mankey]', 56, 2, q'|Mountain|', 56 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Klink]', 599 , 105 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Celesteela]', 797 , 297 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Meowth]', 52, 1, q'|Urban|', 52 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Victini]', 494 , 0 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Hitmonlee]', 106, 7, q'|Urban|', 106 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Nidorina]', 30, 3, q'|Grassland|', 30 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Drilbur]', 529 , 35 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Spoink]', 325, 2, q'|Mountain|', 110 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Baltoy]', 343, 8, q'|Rough-terrain|', 131 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Liepard]', 510 , 16 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Togedemaru]', 777 , 225 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Blastoise]', 9, 13, q'|Water's-edge|', 9 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Onix]', 95, 2, q'|Cave|', 95 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Tirtouga]', 564 , 70 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Woobat]', 527 , 33 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Dunsparce]', 206, 5, q'|Cave|', 52 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Houndour]', 228, 4, q'|Rough-terrain|', 214 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Dodrio]', 85, 5, q'|Grassland|', 85 , 1 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Doublade]', 680 , 118, 'Ce', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Cranidos]', 408 , 36 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Carracosta]', 565 , 71 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Altaria]', 334, 22, q'|Forest|', 122 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Lunala]', 792 , 292 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Cascoon]', 268, 4, q'|Forest|', 17 , 3 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Aurorus]', 699 , 67, 'Co', 6 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Bergmite]', 712 , 79, 'Mo', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Pupitar]', 247, 12, q'|Mountain|', 250 , 2 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Lopunny]', 428 , 68 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Plusle]', 311, 20, q'|Grassland|', 80 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Rapidash]', 78, 17, q'|Grassland|', 78 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Beartic]', 614 , 120 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Venomoth]', 49, 11, q'|Forest|', 49 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Toxicroak]', 454 , 130 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Latios]', 381, 16, q'|Water's-edge|', 197 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Gorebyss]', 368, 6, q'|Sea|', 178 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Girafarig]', 203, 15, q'|Grassland|', 149 , 2 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Bewear]', 760 , 170 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Buizel]', 418 , 56 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Leavanny]', 542 , 48 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Huntail]', 367, 6, q'|Sea|', 177 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Tentacruel]', 73, 1, q'|Sea|', 73 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Kangaskhan]', 115, 15, q'|Grassland|', 115 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Dhelmise]', 781 , 263 , 7 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Slurpuff]', 685 , 132, 'Ce', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Dialga]', 483 , 149 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Silcoon]', 266, 3, q'|Forest|', 15 , 3 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Chesnaught]', 652 , 3, 'Ce', 6 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Malamar]', 687 , 11, 'Co', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Omastar]', 139, 14, q'|Sea|', 139 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Necrozma]', 800 , 300 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Grovyle]', 253, 25, q'|Forest|', 2 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Croagunk]', 453 , 129 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Blaziken]', 257, 26, q'|Grassland|', 6 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Horsea]', 116, 11, q'|Sea|', 116 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Mudbray]', 749 , 132 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Wartortle]', 8, 13, q'|Water's-edge|', 8 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Mantine]', 226, 7, q'|Sea|', 202 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Zangoose]', 335, 19, q'|Grassland|', 123 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Froslass]', 478 , 208 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Roserade]', 407 , 27 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Diglett]', 50, 2, q'|Cave|', 50 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Makuhita]', 296, 7, q'|Mountain|', 48 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Nihilego]', 793 , 293 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Sawk]', 539 , 45 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Zekrom]', 644 , 150 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Pikachu]', 25, 7, q'|Forest|', 25 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Latias]', 380, 16, q'|Water's-edge|', 196 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Tsareena]', 763 , 173 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Magcargo]', 219, 6, q'|Mountain|', 217 , 2 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Finneon]', 456 , 134 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Bidoof]', 399 , 13 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Magnemite]', 81, 3, q'|Rough-terrain|', 81 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Kartana]', 798 , 298 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Swampert]', 260, 15, q'|Water's-edge|', 9 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Bagon]', 371, 9, q'|Rough-terrain|', 187 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Trubbish]', 568 , 74 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Articuno]', 144, 2, q'|Rare|', 144 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Qwilfish]', 211, 7, q'|Sea|', 163 , 2 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Flabébé]', 669 , 68, 'Ce', 6 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Bunnelby]', 659 , 10, 'Ce', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Growlithe]', 58, 21, q'|Grassland|', 58 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Starmie]', 121, 3, q'|Sea|', 121 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Oricorio]', 741 , 82 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Politoed]', 186, 7, q'|Water's-edge|', 75 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Snubbull]', 209, 1, q'|Urban|', 125 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Cyndaquil]', 155, 25, q'|Grassland|', 4 , 2 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Greninja]', 658 , 9, 'Ce', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Poliwrath]', 62, 7, q'|Water's-edge|', 62 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Palpitoad]', 536 , 42 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Ponyta]', 77, 17, q'|Grassland|', 77 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Seismitoad]', 537 , 43 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Minun]', 312, 20, q'|Grassland|', 81 , 3 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Spritzee]', 682 , 129, 'Ce', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Sharpedo]', 319, 10, q'|Sea|', 98 , 3 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Honedge]', 679 , 117, 'Ce', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Hoppip]', 187, 7, q'|Grassland|', 67 , 2 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Vikavolt]', 738 , 29 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Elekid]', 239, 18, q'|Grassland|', 156 , 2 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Rotom]', 479 , 152 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Zweilous]', 634 , 140 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Zebstrika]', 523 , 29 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Tynamo]', 602 , 108 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Nidoking]', 34, 4, q'|Grassland|', 34 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Jolteon]', 135, 11, q'|Urban|', 135 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Aerodactyl]', 142, 15, q'|Mountain|', 142 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Omanyte]', 138, 14, q'|Sea|', 138 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Gengar]', 94, 7, q'|Cave|', 94 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Abomasnow]', 460 , 143 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Mime Jr.]', 439 , 94 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Type: Null]', 772 , 203 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Patrat]', 504 , 10 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Gyarados]', 130, 2, q'|Water's-edge|', 130 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Haxorus]', 612 , 118 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Clefairy]', 35, 4, q'|Mountain|', 35 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Dewpider]', 751 , 141 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Silvally]', 773 , 204 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Wynaut]', 360, 8, q'|Cave|', 160 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Yamask]', 562 , 68 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Uxie]', 480 , 146 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Nidorino]', 33, 4, q'|Grassland|', 33 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Starly]', 396 , 10 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Torracat]', 726 , 5 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Kingler]', 99, 2, q'|Water's-edge|', 99 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Rampardos]', 409 , 37 , 4 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Noibat]', 714 , 113, 'Mo', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Phanpy]', 231, 4, q'|Rough-terrain|', 200 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Charmander]', 4, 16, q'|Mountain|', 4 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Blitzle]', 522 , 28 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Vespiquen]', 416 , 54 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Mamoswine]', 473 , 205 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Ninetales]', 38, 17, q'|Grassland|', 38 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Gible]', 443 , 109 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Mothim]', 414 , 47 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Gothorita]', 575 , 81 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Salamence]', 373, 9, q'|Rough-terrain|', 189 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Electrike]', 309, 18, q'|Grassland|', 78 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Gardevoir]', 282, 5, q'|Urban|', 31 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Spheal]', 363, 9, q'|Sea|', 173 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Combee]', 415 , 53 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Turtonator]', 776 , 224 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Hippowdon]', 450 , 123 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Larvitar]', 246, 12, q'|Mountain|', 249 , 2 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Chimchar]', 390 , 4 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Shedinja]', 292, 13, q'|Forest|', 44 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Serperior]', 497 , 3 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Relicanth]', 369, 12, q'|Sea|', 179 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Machop]', 66, 3, q'|Mountain|', 66 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Darumaka]', 554 , 60 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Togekiss]', 468 , 175 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Seviper]', 336, 19, q'|Grassland|', 124 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Keldeo]', 647 , 153 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Dewgong]', 87, 8, q'|Sea|', 87 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Poochyena]', 261, 2, q'|Grassland|', 10 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Eelektrik]', 603 , 109 , 5 );
insert into POKEMON( NAME, DEX , GEN )
values( nq'[Regigigas]', 486 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Leafeon]', 470 , 169 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Wooper]', 194, 6, q'|Water's-edge|', 56 , 2 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Trevenant]', 709 , 62, 'Mo', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Rhyperior]', 464 , 188 , 4 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Pumpkaboo]', 710 , 63, 'Mo', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Mimikyu]', 778 , 242 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Drifblim]', 426 , 66 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Tentacool]', 72, 1, q'|Sea|', 72 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Duosion]', 578 , 84 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Shiftry]', 275, 10, q'|Forest|', 24 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Swablu]', 333, 22, q'|Forest|', 121 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Pignite]', 499 , 5 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Ariados]', 168, 12, q'|Forest|', 33 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Gloom]', 44, 8, q'|Grassland|', 44 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Tranquill]', 520 , 26 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Shuppet]', 353, 3, q'|Urban|', 146 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Pansage]', 511 , 17 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Bastiodon]', 411 , 39 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Druddigon]', 621 , 127 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Remoraid]', 223, 4, q'|Sea|', 174 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Steelix]', 208, 2, q'|Cave|', 63 , 2 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Cubchoo]', 613 , 119 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Celebi]', 251, 26, q'|Forest|', 256 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Regice]', 378, 10, q'|Cave|', 194 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Haunter]', 93, 7, q'|Cave|', 93 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Roggenrola]', 524 , 30 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Beedrill]', 15, 2, q'|Forest|', 15 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Crabominable]', 740 , 60 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Corphish]', 341, 3, q'|Water's-edge|', 129 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Pikipek]', 731 , 10 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Pheromosa]', 795 , 295 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Gabite]', 444 , 110 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Metang]', 375, 10, q'|Rough-terrain|', 191 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Dragonair]', 148, 12, q'|Water's-edge|', 148 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Cryogonal]', 615 , 121 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Hariyama]', 297, 7, q'|Mountain|', 49 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Lurantis]', 754 , 144 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Tapu Fini]', 788 , 288 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Eelektross]', 604 , 110 , 5 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Tyrantrum]', 697 , 65, 'Co', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Purugly]', 432 , 77 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Shelmet]', 616 , 122 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Swadloon]', 541 , 47 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Tyrogue]', 236, 7, q'|Urban|', 145 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Smeargle]', 235, 6, q'|Urban|', 159 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Kabuto]', 140, 14, q'|Sea|', 140 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Lucario]', 448 , 116 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Linoone]', 264, 2, q'|Grassland|', 13 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Mantyke]', 458 , 140 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Basculin]', 550 , 56 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Trumbeak]', 732 , 11 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Primarina]', 730 , 9 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Tangela]', 114, 6, q'|Grassland|', 114 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Stufful]', 759 , 169 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Doduo]', 84, 5, q'|Grassland|', 84 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Weavile]', 461 , 145 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Alomomola]', 594 , 100 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Dartrix]', 723 , 2 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Wailmer]', 320, 10, q'|Sea|', 99 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Pawniard]', 624 , 130 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Terrakion]', 639 , 145 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Simipour]', 516 , 22 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Deerling]', 585 , 91 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Burmy]', 412 , 45 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Pinsir]', 127, 21, q'|Forest|', 127 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Garbodor]', 569 , 75 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Bellsprout]', 69, 8, q'|Forest|', 69 , 1 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Furfrou]', 676 , 93, 'Ce', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Weepinbell]', 70, 8, q'|Forest|', 70 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Stoutland]', 508 , 14 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Wimpod]', 767 , 182 , 7 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Volcanion]', 721 , 153, 'Ce', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Lombre]', 271, 4, q'|Water's-edge|', 20 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Wigglytuff]', 40, 10, q'|Grassland|', 40 , 1 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Clawitzer]', 693 , 33, 'Co', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Loudred]', 294, 4, q'|Cave|', 46 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Igglybuff]', 174, 10, q'|Grassland|', 44 , 2 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Gogoat]', 673 , 90, 'Ce', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Clefable]', 36, 4, q'|Mountain|', 36 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Slakoth]', 287, 16, q'|Forest|', 36 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Bruxish]', 779 , 243 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Sunkern]', 191, 6, q'|Grassland|', 103 , 2 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Ducklett]', 580 , 86 , 5 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Heliolisk]', 695 , 47, 'Co', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Ambipom]', 424 , 64 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Dratini]', 147, 12, q'|Water's-edge|', 147 , 1 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Vivillon]', 666 , 22, 'Ce', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Snivy]', 495 , 1 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Pyukumuku]', 771 , 200 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Illumise]', 314, 14, q'|Forest|', 87 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Zigzagoon]', 263, 2, q'|Grassland|', 12 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Magby]', 240, 10, q'|Mountain|', 152 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Nidoqueen]', 31, 3, q'|Grassland|', 31 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Numel]', 322, 6, q'|Mountain|', 101 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Ampharos]', 181, 11, q'|Grassland|', 55 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Roselia]', 315, 6, q'|Grassland|', 94 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Nosepass]', 299, 5, q'|Cave|', 60 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Exploud]', 295, 4, q'|Cave|', 47 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Durant]', 632 , 138 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Herdier]', 507 , 13 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Golbat]', 42, 1, q'|Cave|', 42 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Crabrawler]', 739 , 59 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Emboar]', 500 , 6 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Lairon]', 305, 11, q'|Mountain|', 71 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Beautifly]', 267, 3, q'|Forest|', 16 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Swoobat]', 528 , 34 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Infernape]', 392 , 6 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Honchkrow]', 430 , 75 , 4 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Froakie]', 656 , 7, 'Ce', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Camerupt]', 323, 6, q'|Mountain|', 102 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Squirtle]', 7, 13, q'|Water's-edge|', 7 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Lileep]', 345, 15, q'|Sea|', 133 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Darmanitan]', 555 , 61 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Deino]', 633 , 139 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Rhyhorn]', 111, 2, q'|Rough-terrain|', 111 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Chinchou]', 170, 4, q'|Sea|', 176 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Luvdisc]', 370, 7, q'|Sea|', 183 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Granbull]', 210, 1, q'|Urban|', 126 , 2 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Hippopotas]', 449 , 122 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Magearna]', 801 , 301 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Mewtwo]', 150, 7, q'|Rare|', 150 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Minccino]', 572 , 78 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Hitmonchan]', 107, 7, q'|Urban|', 107 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Lampent]', 608 , 114 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Lotad]', 270, 4, q'|Water's-edge|', 19 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Poipole]', 803 , 261 , 7 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Klefki]', 707 , 50, 'Mo', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Whismur]', 293, 4, q'|Cave|', 45 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Absol]', 359, 14, q'|Mountain|', 152 , 3 );
insert into POKEMON( NAME, DEX , GEN )
values( nq'[Cresselia]', 488 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Krabby]', 98, 2, q'|Water's-edge|', 98 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Whirlipede]', 544 , 50 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Kabutops]', 141, 14, q'|Sea|', 141 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Brionne]', 729 , 8 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Nincada]', 290, 13, q'|Forest|', 42 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Deoxys]', 386, 6, q'|Rare|', 202 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Natu]', 177, 6, q'|Forest|', 161 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Kyogre]', 382, 16, q'|Sea|', 198 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Vibrava]', 329, 6, q'|Rough-terrain|', 117 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Chimecho]', 358, 22, q'|Grassland|', 151 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Lickitung]', 108, 12, q'|Grassland|', 108 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Araquanid]', 752 , 142 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Pidove]', 519 , 25 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Registeel]', 379, 10, q'|Cave|', 195 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Sandygast]', 769 , 186 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Tropius]', 357, 22, q'|Forest|', 150 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Anorith]', 347, 11, q'|Water's-edge|', 135 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Grumpig]', 326, 2, q'|Mountain|', 111 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Shiinotic]', 756 , 146 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Manaphy]', 490 , 151 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Grimer]', 88, 2, q'|Urban|', 88 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Hoothoot]', 163, 6, q'|Forest|', 15 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Breloom]', 286, 9, q'|Forest|', 35 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Tympole]', 535 , 41 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Weedle]', 13, 2, q'|Forest|', 13 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Samurott]', 503 , 9 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Wurmple]', 265, 3, q'|Forest|', 14 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Petilil]', 548 , 54 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Monferno]', 391 , 5 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Psyduck]', 54, 6, q'|Water's-edge|', 54 , 1 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Pancham]', 674 , 91, 'Ce', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Electabuzz]', 125, 18, q'|Grassland|', 125 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Mawile]', 303, 6, q'|Cave|', 69 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Torterra]', 389 , 3 , 4 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Goomy]', 704 , 19, 'Mo', 6 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Spewpa]', 665 , 21, 'Ce', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Arbok]', 24, 9, q'|Grassland|', 24 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Teddiursa]', 216, 8, q'|Mountain|', 198 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Barboach]', 339, 3, q'|Water's-edge|', 127 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Throh]', 538 , 44 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Abra]', 63, 4, q'|Urban|', 63 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Rockruff]', 744 , 103 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Jangmo-o]', 782 , 271 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Venusaur]', 3, 23, q'|Grassland|', 3 , 1 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Quilladin]', 651 , 2, 'Ce', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Musharna]', 518 , 24 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Palkia]', 484 , 150 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Skorupi]', 451 , 127 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Oddish]', 43, 8, q'|Grassland|', 43 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Heatmor]', 631 , 137 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Salazzle]', 758 , 162 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Magikarp]', 129, 2, q'|Water's-edge|', 129 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Ursaring]', 217, 8, q'|Mountain|', 199 , 2 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Mudsdale]', 750 , 133 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Castform]', 351, 22, q'|Grassland|', 142 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Volcarona]', 637 , 143 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Crawdaunt]', 342, 3, q'|Water's-edge|', 130 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Ledyba]', 165, 12, q'|Forest|', 30 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Combusken]', 256, 26, q'|Grassland|', 5 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Turtwig]', 387 , 1 , 4 );
insert into POKEMON( NAME, DEX , GEN )
values( nq'[Heatran]', 485 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Sealeo]', 364, 9, q'|Sea|', 174 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Eevee]', 133, 11, q'|Urban|', 133 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Ribombee]', 743 , 84 , 7 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Talonflame]', 663 , 16, 'Ce', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Wishiwashi]', 746 , 110 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Whimsicott]', 547 , 53 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Vanillish]', 583 , 89 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Stunky]', 434 , 84 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Kakuna]', 14, 2, q'|Forest|', 14 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Charmeleon]', 5, 16, q'|Mountain|', 5 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Reshiram]', 643 , 149 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Slaking]', 289, 16, q'|Forest|', 38 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Duskull]', 355, 23, q'|Forest|', 148 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Emolga]', 587 , 93 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Slugma]', 218, 6, q'|Mountain|', 216 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Espeon]', 196, 12, q'|Urban|', 188 , 2 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Dragalge]', 691 , 31, 'Co', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Rowlet]', 722 , 1 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Simisage]', 512 , 18 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Excadrill]', 530 , 36 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Sandile]', 551 , 57 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Aipom]', 190, 20, q'|Forest|', 123 , 2 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Grubbin]', 736 , 27 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Noctowl]', 164, 6, q'|Forest|', 16 , 2 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Inkay]', 686 , 10, 'Co', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Piloswine]', 221, 3, q'|Cave|', 196 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Jirachi]', 385, 17, q'|Mountain|', 201 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Litwick]', 607 , 113 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Fraxure]', 611 , 117 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Nidoran♂]', 32, 4, q'|Grassland|', 32 , 1 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Frogadier]', 657 , 8, 'Ce', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Hakamo-o]', 783 , 272 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Cloyster]', 91, 5, q'|Sea|', 91 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Cubone]', 104, 5, q'|Mountain|', 104 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Voltorb]', 100, 9, q'|Urban|', 100 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Cosmoem]', 790 , 290 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Tapu Lele]', 786 , 286 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Manectric]', 310, 18, q'|Grassland|', 79 , 3 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Phantump]', 708 , 61, 'Mo', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Shellos]', 422 , 60 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Maractus]', 556 , 62 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Drapion]', 452 , 128 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Gastrodon]', 423 , 61 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Chingling]', 433 , 82 , 4 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Skrelp]', 690 , 30, 'Co', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Steenee]', 762 , 172 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Zubat]', 41, 1, q'|Cave|', 41 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Empoleon]', 395 , 9 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Seedot]', 273, 10, q'|Forest|', 22 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Cottonee]', 546 , 52 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Sunflora]', 192, 6, q'|Grassland|', 104 , 2 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Dewott]', 502 , 8 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Swellow]', 277, 5, q'|Grassland|', 26 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Skiploom]', 188, 7, q'|Grassland|', 68 , 2 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Vanillite]', 582 , 88 , 5 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Barbaracle]', 689 , 22, 'Co', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Banette]', 354, 3, q'|Urban|', 147 , 3 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Binacle]', 688 , 21, 'Co', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Tepig]', 498 , 4 , 5 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Litleo]', 667 , 57, 'Ce', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Machamp]', 68, 3, q'|Mountain|', 68 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Jigglypuff]', 39, 10, q'|Grassland|', 39 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Farfetch'd]', 83, 12, q'|Grassland|', 83 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Klinklang]', 601 , 107 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Drowzee]', 96, 14, q'|Grassland|', 96 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Metapod]', 11, 1, q'|Forest|', 11 , 1 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Sliggoo]', 705 , 20, 'Mo', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Houndoom]', 229, 4, q'|Rough-terrain|', 215 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Croconaw]', 159, 14, q'|Water's-edge|', 8 , 2 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Diggersby]', 660 , 11, 'Ce', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Servine]', 496 , 2 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Skuntank]', 435 , 85 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Crobat]', 169, 1, q'|Cave|', 39 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Quagsire]', 195, 6, q'|Water's-edge|', 57 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Ditto]', 132, 10, q'|Urban|', 132 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Mesprit]', 481 , 147 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Floatzel]', 419 , 57 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Furret]', 162, 1, q'|Grassland|', 20 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Tauros]', 128, 16, q'|Grassland|', 128 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Glameow]', 431 , 76 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Lanturn]', 171, 4, q'|Sea|', 177 , 2 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Avalugg]', 713 , 80, 'Mo', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Dusclops]', 356, 23, q'|Forest|', 149 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Murkrow]', 198, 18, q'|Forest|', 213 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Delibird]', 225, 8, q'|Mountain|', 194 , 2 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Elgyem]', 605 , 111 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Kadabra]', 64, 4, q'|Urban|', 64 , 1 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Carbink]', 703 , 124, 'Co', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Wobbuffet]', 202, 8, q'|Cave|', 108 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Sableye]', 302, 6, q'|Cave|', 68 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Pachirisu]', 417 , 55 , 4 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Skiddo]', 672 , 89, 'Ce', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Munchlax]', 446 , 112 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Moltres]', 146, 2, q'|Rare|', 146 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Clamperl]', 366, 6, q'|Sea|', 176 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Foongus]', 590 , 96 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Hitmontop]', 237, 7, q'|Urban|', 148 , 2 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Passimian]', 766 , 177 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Boldore]', 525 , 31 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Charizard]', 6, 16, q'|Mountain|', 6 , 1 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Espurr]', 677 , 114, 'Ce', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Swanna]', 581 , 87 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Seel]', 86, 8, q'|Sea|', 86 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Gothitelle]', 576 , 82 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Wormadam]', 413 , 46 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Poliwag]', 60, 7, q'|Water's-edge|', 60 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Bronzong]', 437 , 89 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Landorus]', 645 , 151 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Dustox]', 269, 4, q'|Forest|', 18 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Shieldon]', 410 , 38 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Lillipup]', 506 , 12 , 5 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Delphox]', 655 , 6, 'Ce', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Porygon2]', 233, 9, q'|Urban|', 221 , 2 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Oranguru]', 765 , 176 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Magmortar]', 467 , 202 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Caterpie]', 10, 1, q'|Forest|', 10 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Pidgey]', 16, 5, q'|Forest|', 16 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Bisharp]', 625 , 131 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Muk]', 89, 2, q'|Urban|', 89 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Salandit]', 757 , 161 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Stantler]', 234, 20, q'|Forest|', 131 , 2 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Gothita]', 574 , 80 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Goldeen]', 118, 1, q'|Water's-edge|', 118 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Krokorok]', 552 , 58 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Ferrothorn]', 598 , 104 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Skarmory]', 227, 7, q'|Rough-terrain|', 203 , 2 );
insert into POKEMON( NAME, DEX , GEN )
values( nq'[Phione]', 489 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Scizor]', 212, 13, q'|Grassland|', 112 , 2 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Hawlucha]', 701 , 89, 'Co', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Marowak]', 105, 5, q'|Mountain|', 105 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Simisear]', 514 , 20 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Bayleef]', 153, 24, q'|Grassland|', 2 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Suicune]', 245, 27, q'|Grassland|', 245 , 2 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Crustle]', 558 , 64 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Machoke]', 67, 3, q'|Mountain|', 67 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Swalot]', 317, 14, q'|Grassland|', 96 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Vileplume]', 45, 8, q'|Grassland|', 45 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Buzzwole]', 794 , 294 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Umbreon]', 197, 12, q'|Urban|', 189 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Lunatone]', 337, 9, q'|Cave|', 125 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Metagross]', 376, 10, q'|Rough-terrain|', 192 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Lapras]', 131, 13, q'|Sea|', 131 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Accelgor]', 617 , 123 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Pidgeot]', 18, 5, q'|Forest|', 18 , 1 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Amaura]', 698 , 66, 'Co', 6 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Gourgeist]', 711 , 64, 'Mo', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Snover]', 459 , 142 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Slowpoke]', 79, 9, q'|Water's-edge|', 79 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Kingdra]', 230, 11, q'|Sea|', 192 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Koffing]', 109, 2, q'|Urban|', 109 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Decidueye]', 724 , 3 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Raticate]', 20, 1, q'|Grassland|', 20 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Chansey]', 113, 8, q'|Urban|', 113 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Fomantis]', 753 , 143 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Bibarel]', 400 , 14 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Mareep]', 179, 11, q'|Grassland|', 53 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Spinarak]', 167, 12, q'|Forest|', 32 , 2 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Amoonguss]', 591 , 97 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Conkeldurr]', 534 , 40 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Dugtrio]', 51, 2, q'|Cave|', 51 , 1 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Goodra]', 706 , 21, 'Mo', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Luxio]', 404 , 18 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Aron]', 304, 11, q'|Mountain|', 70 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Whiscash]', 340, 3, q'|Water's-edge|', 128 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Archeops]', 567 , 73 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Solrock]', 338, 9, q'|Cave|', 126 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Skitty]', 300, 17, q'|Forest|', 61 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Galvantula]', 596 , 102 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Bellossom]', 182, 8, q'|Grassland|', 86 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Gligar]', 207, 9, q'|Mountain|', 193 , 2 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Electivire]', 466 , 199 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Lumineon]', 457 , 135 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Marill]', 183, 8, q'|Water's-edge|', 132 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Forretress]', 205, 15, q'|Forest|', 94 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Treecko]', 252, 25, q'|Forest|', 1 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Mr. Mime]', 122, 6, q'|Urban|', 122 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Scyther]', 123, 13, q'|Grassland|', 123 , 1 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Yveltal]', 717 , 149, 'Mo', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Gurdurr]', 533 , 39 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Audino]', 531 , 37 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Octillery]', 224, 4, q'|Sea|', 175 , 2 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Marshadow]', 802 , 302 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Bounsweet]', 761 , 171 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Kyurem]', 646 , 152 , 5 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Pangoro]', 675 , 92, 'Ce', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Tornadus]', 641 , 147 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Mismagius]', 429 , 73 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Drampa]', 780 , 244 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Hydreigon]', 635 , 141 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Feebas]', 349, 10, q'|Water's-edge|', 140 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Garchomp]', 445 , 111 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Mightyena]', 262, 2, q'|Grassland|', 11 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Typhlosion]', 157, 25, q'|Grassland|', 6 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Volbeat]', 313, 14, q'|Forest|', 86 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Archen]', 566 , 72 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Ledian]', 166, 12, q'|Forest|', 31 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Pichu]', 172, 7, q'|Forest|', 21 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Ludicolo]', 272, 4, q'|Water's-edge|', 21 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Glaceon]', 471 , 170 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Palossand]', 770 , 187 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Slowking]', 199, 9, q'|Water's-edge|', 82 , 2 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Bonsly]', 438 , 92 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Piplup]', 393 , 7 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Lickilicky]', 463 , 162 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Gliscor]', 472 , 154 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Scrafty]', 560 , 66 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Raichu]', 26, 7, q'|Forest|', 26 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Ninjask]', 291, 13, q'|Forest|', 43 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Stakataka]', 805 , 392 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Shinx]', 403 , 17 , 4 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Swirlix]', 684 , 131, 'Ce', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Heracross]', 214, 21, q'|Forest|', 114 , 2 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Clauncher]', 692 , 32, 'Co', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Pineco]', 204, 15, q'|Forest|', 93 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Sandshrew]', 27, 2, q'|Rough-terrain|', 27 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Happiny]', 440 , 96 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Medicham]', 308, 7, q'|Mountain|', 77 , 3 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Krookodile]', 553 , 59 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Porygon-Z]', 474 , 194 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Togetic]', 176, 24, q'|Forest|', 47 , 2 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Comfey]', 764 , 174 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Magnezone]', 462 , 180 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Kricketune]', 402 , 16 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Dusknoir]', 477 , 191 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Raikou]', 243, 27, q'|Grassland|', 243 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Flareon]', 136, 11, q'|Urban|', 136 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Quilava]', 156, 25, q'|Grassland|', 5 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Ho-Oh]', 250, 4, q'|Rare|', 253 , 2 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Braixen]', 654 , 5, 'Ce', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Jynx]', 124, 6, q'|Urban|', 124 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Cobalion]', 638 , 144 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Venonat]', 48, 11, q'|Forest|', 48 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Feraligatr]', 160, 14, q'|Water's-edge|', 9 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Cradily]', 346, 15, q'|Sea|', 134 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Donphan]', 232, 4, q'|Rough-terrain|', 201 , 2 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Yanmega]', 469 , 184 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Genesect]', 649 , 155 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Staraptor]', 398 , 12 , 4 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Mandibuzz]', 630 , 136 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Snorlax]', 143, 13, q'|Mountain|', 143 , 1 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Chikorita]', 152, 24, q'|Grassland|', 1 , 2 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Vanilluxe]', 584 , 90 , 5 );
insert into POKEMON( NAME, DEX , GEN )
values( nq'[Darkrai]', 491 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Nuzleaf]', 274, 10, q'|Forest|', 23 , 3 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Entei]', 244, 27, q'|Grassland|', 244 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Misdreavus]', 200, 5, q'|Cave|', 219 , 2 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN )
values( nq'[Electrode]', 101, 9, q'|Urban|', 101 , 1 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Naganadel]', 804 , 262 , 7 );
create table SPECIES(
DEX number(4,0) CONSTRAINT ck_DEX_PosZero2 check(DEX>=0), --Pokedex number of the Pokemon
CLASS varchar2(100 char) , --Discribing the form or type diffirence
DEX_SUFFIX varchar2(2 byte) CONSTRAINT ck_DEX_SUFFIX_Cap check(regexp_like(DEX_SUFFIX, '[A-Z][a-zA-Z]?')), --Dex Suffix of the Pokemon to distinguish between types
ITEM varchar2(50) references ITEMS(NAME), --The item used to get the form
EGGGROUP1 varchar2(30) default on null 'Undiscovered' references eggGroups(NAME), --The first Egg Group the Pokemon Falls in
EGGGROUP2 varchar2(30) references eggGroups(NAME), --The second Egg Group the Pokemon Falls in
TYPE varchar2(30) default on null 'Normal' references TYPES(TYPE), --The first type of the Pokemon
TYPE2 varchar2(30) references TYPES(TYPE), --The second type of the Pokemon
BODY varchar2(50) references BODY(BODY), --The body classification of the Pokemon
COLOR varchar2(15) , --The color classification of the Pokemon
CALL_RATE_SM number(2,0) check(CALL_RATE_SM>=0), --The call rate in SOS battles in Sun and Moon
CALL_RATE_USUM number(2,0) check(CALL_RATE_USUM>=0), --The call rate in SOS battles in Ultra Sun and Ultra Moon
STAR number(2,0) check(STAR>=0), --A bininary mask indicating what has a star
GENDER_RATIO varchar2(4) references GENDER_RATIO(KEY), --The ratio between male and female
CYCLES number(3,0) CONSTRAINT ck_CYCLES_Pos check(CYCLES>0), --A stat that help determines egg hatching
ABILITY1 varchar2(30) references ABILITY(NAME), --The first ability a Pokemon of this species can have
ABILITY2 varchar2(30) references ABILITY(NAME), --The second ability a Pokemon of this species can have, NULL if no more
HIDDEN_ABILITY varchar2(30) references ABILITY(NAME), --The special hidden ability of the species, NULL if none
WEIGHTKG number(6,2) CONSTRAINT ck_WEIGHTKG_PosZero check(WEIGHTKG>=0), --The weight of the Pokemon in kilograms
WEIGHTLBS number(6,2) CONSTRAINT ck_WEIGHTLBS_PosZero check(WEIGHTLBS>=0), --The weight of the Pokemon in pounds
HEIGHT_M number(2,0) check(HEIGHT_M>=0), --The height in Meeters
HEIGHT_FT number(2,0) check(HEIGHT_FT>=0), --The Foot part of the height
HEIGHT_IN number(2,0) check(HEIGHT_IN>=0), --The intch part of the height
CONSTRAINT fk_SPECIES foreign key(DEX) references POKEMON(DEX), --Enforce the foreign key
CONSTRAINT un_SPECIES unique(Dex, Dex_Suffix, Class), --Enforce that Dex and Class are unique (Can't be primary key)
CONSTRAINT ck_Type check(Type!=Type2), --Make sure that type cannot be the same
CONSTRAINT ck_Egg check(EggGroup1!=EggGroup2), --Make sure that egg groups don't duplicate
CONSTRAINT ck_Weight check(WeightKg/WeightLbs between .35 and .55), --Ensure there is no typo in weight (Soft checking)
CONSTRAINT un_Dex_Class unique(Dex, Class) --Ensure that no class has duplicates
);

insert into SPECIES( DEX , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 787 , 'Grass', 'Fairy', q'{Head and arms}', 'Red' , 0, 'GU', 15, 'Grassy Surge' , 'Telepathy', 45.5, 100.3, 1.9, 6, 3 );
insert into SPECIES( DEX , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 360 , 'Psychic' , q'{Bipedal, tailed form}', 'Blue' , 0, '1:1U', 20, 'Shadow Tag' , 'Telepathy', 14, 30.9, 0.6, 2, 0 );
insert into SPECIES( DEX , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 341 , 'Water' , q'{Insectoid body}', 'Red' , 9, 0, '1:1', 15, 'Hyper Cutter', 'Shell Armor', 'Adaptability', 11.5, 25.4, 0.6, 2, 0 );
insert into SPECIES( DEX , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 738 , 'Bug', 'Electric', q'{Insectoid body}', 'Blue' , 0, 0, '1:1', 15, 'Levitate' , 45, 99.2, 1.5, 4, 11 );
insert into SPECIES( DEX , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 494 , 'Psychic', 'Fire', q'{Bipedal, tailless form}', 'Yellow' , 0, 'GU', 120, 'Victory Star' , 4, 8.8, 0.4, 1, 4 );
insert into SPECIES( DEX , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 534 , 'Fighting' , q'{Bipedal, tailless form}', 'Brown' , 0, '1:3U', 20, 'Guts', 'Sheer Force', 'Iron Fist', 87, 191.8, 1.5, 4, 11 );
insert into SPECIES( DEX , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 496 , 'Field', 'Grass', 'Grass' , q'{Bipedal, tailed form}', 'Green' , 0, '1:7', 20, 'Overgrow' , 'Contrary', 16, 35.3, 0.8, 2, 7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 301 , 'Field', 'Fairy', 'Normal' , q'{Quadruped body}', 'Purple' , 2, '3:1', 15, 'Cute Charm', 'Normalize', 'Wonder Skin', 32.6, 71.9, 1.1, 3, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 639 , 'Undiscovered' , 'Rock', 'Fighting', q'{Quadruped body}', 'Gray' , 0, 'GU', 80, 'Justified' , 260, 573.2, 1.9, 6, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 49 , 'Bug' , 'Bug', 'Poison', q'{Two or more pairs of wings}', 'Purple' , 2, '1:1', 20, 'Shield Dust', 'Tinted Lens', 'Wonder Skin', 12.5, 27.6, 1.5, 4, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 74 , 'Mineral' , 'Rock', 'Ground', q'{Head and arms}', 'Brown', 9, 9, 0, '1:1', 15, 'Rock Head', 'Sturdy', 'Sand Veil', 20, 44.1, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 625 , 'Human-Like' , 'Dark', 'Steel', q'{Bipedal, tailless form}', 'Red' , 15, 0, '1:1', 20, 'Defiant', 'Inner Focus', 'Pressure', 70, 154.3, 1.6, 5, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 81 , 'Mineral' , 'Electric', 'Steel', q'{Head and arms}', 'Gray', 9, 9, 0, 'G', 20, 'Magnet Pull', 'Sturdy', 'Analytic', 6, 13.2, 0.3, 1, 0 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 646, q'|Normal|' , 'Undiscovered' , 'Dragon', 'Ice', q'{Bipedal, tailed form}', 'Gray' , 0, 'GU', 120, 'Pressure' , 325, 716.5, 3.3, 10, 10 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 153 , 'Monster', 'Grass', 'Grass' , q'{Quadruped body}', 'Green' , 0, '1:7', 20, 'Overgrow' , 'Leaf Guard', 15.8, 34.8, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 613 , 'Field' , 'Ice' , q'{Bipedal, tailed form}', 'White' , 2, '1:1', 20, 'Snow Cloak', 'Slush Rush', 'Rattled', 8.5, 18.7, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 708 , 'Grass', 'Amorphous', 'Ghost', 'Grass', q'{Head and arms}', 'Brown', 9, 9, 0, '1:1', 20, 'Natural Cure', 'Frisk', 'Harvest', 7, 15.4, 0.4, 1, 4 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 130, q'|Mega|', 'M', q'|Gyaradosite|', 'Water 2', 'Dragon', 'Water', 'Dark', q'{Serpentine bodies}', 'Blue', 3, 3, 0, '1:1', 5, 'Mold Breaker' , 235, 518.1, 6.5, 21, 4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 274 , 'Field', 'Grass', 'Grass', 'Dark', q'{Bipedal, tailless form}', 'Brown' , 0, '1:1', 15, 'Chlorophyll', 'Early Bird', 'Pickpocket', 28, 61.7, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 365 , 'Water 1', 'Field', 'Ice', 'Water', q'{Quadruped body}', 'Blue' , 2, '1:1', 20, 'Thick Fat', 'Ice Body', 'Oblivious', 150.6, 332, 1.4, 4, 7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 495 , 'Field', 'Grass', 'Grass' , q'{Bipedal, tailed form}', 'Green' , 0, '1:7', 20, 'Overgrow' , 'Contrary', 8.1, 17.9, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 501 , 'Field' , 'Water' , q'{Bipedal, tailed form}', 'Blue' , 0, '1:7', 20, 'Torrent' , 'Shell Armor', 5.9, 13, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 587 , 'Field' , 'Electric', 'Flying', q'{Quadruped body}', 'White', 9, 9, 0, '1:1', 20, 'Static' , 'Motor Drive', 5, 11, 0.4, 1, 4 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 666, q'|Modern Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 37.5, 1.2, 3, 11 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 773, q'|Type: Fire|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'RKS System' , 100.5, 221.6, 2.3, 7, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 344 , 'Mineral' , 'Ground', 'Psychic', q'{Head and arms}', 'Black' , 15, 0, 'G', 20, 'Levitate' , 107.9, 238, 1.5, 4, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 508 , 'Field' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, '1:1', 15, 'Intimidate', 'Sand Rush', 'Scrappy', 61, 134.5, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 354 , 'Amorphous' , 'Ghost' , q'{Bipedal, tailed form}', 'Black' , 6, 2, '1:1', 25, 'Insomnia', 'Frisk', 'Cursed Body', 12.5, 27.6, 1.1, 3, 7 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 254, q'|Mega|', 'M', q'|Sceptilite|', 'Monster', 'Dragon', 'Grass', 'Dragon', q'{Bipedal, tailed form}', 'Green' , 0, '1:7', 20, 'Lightning Rod' , 52.2, 115.1, 1.9, 6, 3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 666, q'|Sun Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 37.5, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 319 , 'Water 2' , 'Water', 'Dark', q'{Fins}', 'Blue', 3, 3, 0, '1:1', 20, 'Rough Skin' , 'Speed Boost', 88.8, 195.8, 1.8, 5, 11 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 710, q'|Average Size|' , 'Amorphous' , 'Ghost', 'Grass', q'{Head}', 'Brown' , 0, '1:1', 20, 'Pickup', 'Frisk', 'Insomnia', 5, 11, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 478 , 'Fairy', 'Mineral', 'Ice', 'Ghost', q'{Head and arms}', 'White' , 0, '1:0', 20, 'Snow Cloak' , 'Cursed Body', 26.6, 58.6, 1.3, 4, 3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 773, q'|Type: Steel|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'RKS System' , 100.5, 221.6, 2.3, 7, 7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 493, q'|Type: Dragon|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Multitype' , 320, 705.5, 3.2, 10, 6 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 4 , 'Monster', 'Dragon', 'Fire' , q'{Bipedal, tailed form}', 'Red' , 0, '1:7', 20, 'Blaze' , 'Solar Power', 8.5, 18.7, 0.6, 2, 0 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 676, q'|Matron Trim|' , 'Field' , 'Normal' , q'{Quadruped body}', 'White' , 6, 0, '1:1', 20, 'Fur Coat' , 28, 61.7, 1.2, 3, 11 );
insert into SPECIES( DEX, CLASS , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 25, q'|Hoenn Cap|' , 'Field', 'Fairy', 'Electric' , q'{Quadruped body}', 'Yellow', 6, 6, 0, '1:1', 10, 'Static' , 'Lightning Rod', 6, 13.2, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 78 , 'Field' , 'Fire' , q'{Quadruped body}', 'Yellow' , 0, '1:1', 20, 'Run Away', 'Flash Fire', 'Flame Body', 95, 209.4, 1.7, 5, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 124 , 'Human-Like' , 'Ice', 'Psychic', q'{Bipedal, tailless form}', 'Red' , 0, 2, '1:0', 25, 'Oblivious', 'Forewarn', 'Dry Skin', 40.6, 89.5, 1.4, 4, 7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 716, q'|Neutral Mode|' , 'Undiscovered' , 'Fairy' , q'{Quadruped body}', 'Blue' , 0, 'GU', 120, 'Fairy Aura' , 215, 474, 3, 9, 10 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 576 , 'Human-Like' , 'Psychic' , q'{Bipedal, tailless form}', 'Purple' , 2, '3:1', 20, 'Frisk', 'Competitive', 'Shadow Tag', 44, 97, 1.5, 4, 11 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 362, q'|Mega|', 'M', q'|Glalitite|', 'Fairy', 'Mineral', 'Ice' , q'{Head}', 'Gray', 3, 3, 0, '1:1', 20, 'Refrigerate' , 256.5, 565.5, 2.1, 6, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 434 , 'Field' , 'Poison', 'Dark', q'{Quadruped body}', 'Purple' , 0, '1:1', 20, 'Stench', 'Aftermath', 'Keen Eye', 19.2, 42.3, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 779 , 'Water 2' , 'Water', 'Psychic', q'{Fins}', 'Pink', 6, 6, 0, '1:1', 15, 'Dazzling', 'Strong Jaw', 'Wonder Skin', 19, 41.9, 0.9, 2, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 141 , 'Water 1', 'Water 3', 'Rock', 'Water', q'{Bipedal, tailed form}', 'Brown' , 0, '1:7', 30, 'Swift Swim', 'Battle Armor', 'Weak Armor', 40.5, 89.3, 1.3, 4, 3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 321 , 'Field', 'Water 2', 'Water' , q'{Fins}', 'Blue', 6, 6, 0, '1:1', 40, 'Water Veil', 'Oblivious', 'Pressure', 398, 877.4, 14.5, 47, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 201 , 'Undiscovered' , 'Psychic' , q'{Head}', 'Black' , 0, 'GU', 40, 'Levitate' , 5, 11, 0.5, 1, 8 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 671, q'|Orange Flower|' , 'Fairy' , 'Fairy' , q'{Head and arms}', 'White' , 0, '1:0', 20, 'Flower Veil' , 'Symbiosis', 10, 22, 1.1, 3, 7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 666, q'|Poké Ball Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 37.5, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 464 , 'Monster', 'Field', 'Ground', 'Rock', q'{Bipedal, tailed form}', 'Gray' , 0, '1:1', 20, 'Lightning Rod', 'Solid Rock', 'Reckless', 282.8, 623.5, 2.4, 7, 10 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 267 , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'Yellow' , 0, '1:1', 15, 'Swarm' , 'Rivalry', 28.4, 62.6, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 335 , 'Field' , 'Normal' , q'{Bipedal, tailed form}', 'White' , 0, '1:1', 20, 'Immunity' , 'Toxic Boost', 40.3, 88.8, 1.3, 4, 3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 283 , 'Water 1', 'Bug', 'Bug', 'Water', q'{Insectoid body}', 'Blue', 9, 9, 0, '1:1', 15, 'Swift Swim' , 'Rain Dish', 1.7, 3.7, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 148 , 'Water 1', 'Dragon', 'Dragon' , q'{Serpentine bodies}', 'Blue', 6, 6, 0, '1:1', 40, 'Shed Skin' , 'Marvel Scale', 16.5, 36.4, 4, 13, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 701 , 'Human-Like' , 'Fighting', 'Flying', q'{Bipedal, tailless form}', 'Green' , 3, 0, '1:1', 20, 'Limber', 'Unburden', 'Mold Breaker', 21.5, 47.4, 0.8, 2, 7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 686 , 'Water 1', 'Water 2', 'Dark', 'Psychic', q'{Tentacles or a multiped body}', 'Blue' , 9, 0, '1:1', 20, 'Contrary', 'Suction Cups', 'Infiltrator', 3.5, 7.7, 0.4, 1, 4 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 51, q'|Alolan|', 'A' , 'Field' , 'Ground', 'Steel', q'{Multiple bodies}', 'Brown', 6, 6, 0, '1:1', 20, 'Sand Veil', 'Tangling Hair', 'Sand Force', 33.3, 73.4, 0.7, 2, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 408 , 'Monster' , 'Rock' , q'{Bipedal, tailed form}', 'Blue' , 0, '1:7', 30, 'Mold Breaker' , 'Sheer Force', 31.5, 69.4, 0.9, 2, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 327 , 'Field', 'Human-Like', 'Normal' , q'{Bipedal, tailed form}', 'Brown', 6, 6, 2, '1:1', 15, 'Own Tempo', 'Tangled Feet', 'Contrary', 5, 11, 1.1, 3, 7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 258 , 'Monster', 'Water 1', 'Water' , q'{Quadruped body}', 'Blue' , 0, '1:7', 20, 'Torrent' , 'Damp', 7.6, 16.8, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 261 , 'Field' , 'Dark' , q'{Quadruped body}', 'Gray' , 2, '1:1', 15, 'Run Away', 'Quick Feet', 'Rattled', 13.6, 30, 0.5, 1, 8 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 671, q'|Blue Flower|' , 'Fairy' , 'Fairy' , q'{Head and arms}', 'White' , 0, '1:0', 20, 'Flower Veil' , 'Symbiosis', 10, 22, 1.1, 3, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 288 , 'Field' , 'Normal' , q'{Bipedal, tailed form}', 'White' , 0, '1:1', 15, 'Vital Spirit' , 46.5, 102.5, 1.4, 4, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 22 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Brown', 6, 6, 0, '1:1', 15, 'Keen Eye' , 'Sniper', 38, 83.8, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 527 , 'Field', 'Flying', 'Psychic', 'Flying', q'{Single pair of wings}', 'Blue' , 0, '1:1', 15, 'Unaware', 'Klutz', 'Simple', 2.1, 4.6, 0.4, 1, 4 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 445, q'|Mega|', 'M', q'|Garchompite|', 'Monster', 'Dragon', 'Dragon', 'Ground', q'{Bipedal, tailed form}', 'Blue' , 0, '1:1', 40, 'Sand Force' , 95, 209.4, 1.9, 6, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 426 , 'Amorphous' , 'Ghost', 'Flying', q'{Head and arms}', 'Purple', 6, 6, 0, '1:1', 30, 'Aftermath', 'Unburden', 'Flare Boost', 15, 33.1, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 284 , 'Water 1', 'Bug', 'Bug', 'Flying', q'{Two or more pairs of wings}', 'Blue', 6, 6, 0, '1:1', 15, 'Intimidate' , 'Unnerve', 3.6, 7.9, 0.8, 2, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 85 , 'Flying' , 'Normal', 'Flying', q'{Head and legs}', 'Brown' , 0, '1:1', 20, 'Run Away', 'Early Bird', 'Tangled Feet', 85.2, 187.8, 1.8, 5, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 371 , 'Dragon' , 'Dragon' , q'{Bipedal, tailless form}', 'Blue', 9, 9, 0, '1:1', 40, 'Rock Head' , 'Sheer Force', 42.1, 92.8, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 597 , 'Grass', 'Mineral', 'Grass', 'Steel', q'{Head}', 'Gray' , 0, '1:1', 20, 'Iron Barbs' , 18.8, 41.5, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 349 , 'Water 1', 'Dragon', 'Water' , q'{Fins}', 'Brown', 9, 9, 2, '1:1', 20, 'Swift Swim', 'Oblivious', 'Adaptability', 7.4, 16.3, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 86 , 'Water 1', 'Field', 'Water' , q'{Fins}', 'White' , 9, 2, '1:1', 20, 'Thick Fat', 'Hydration', 'Ice Body', 90, 198.4, 1.1, 3, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 436 , 'Mineral' , 'Steel', 'Psychic', q'{Head}', 'Green' , 0, 'G', 20, 'Levitate', 'Heatproof', 'Heavy Metal', 60.5, 133.4, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 396 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Brown' , 1, '1:1', 15, 'Keen Eye' , 'Reckless', 2, 4.4, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 322 , 'Field' , 'Fire', 'Ground', q'{Quadruped body}', 'Yellow' , 2, '1:1', 20, 'Oblivious', 'Simple', 'Own Tempo', 24, 52.9, 0.7, 2, 4 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 555, q'|Zen Mode|', 'Z' , 'Field' , 'Fire', 'Psychic', q'{Quadruped body}', 'Blue' , 0, '1:1', 20, 'Zen Mode' , 92.9, 204.8, 1.3, 4, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 705 , 'Dragon' , 'Dragon' , q'{Serpentine bodies}', 'Purple', 0, 0, 0, '1:1', 40, 'Sap Sipper', 'Hydration', 'Gooey', 17.5, 38.6, 0.8, 2, 7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 479, q'|Mow|' , 'Amorphous' , 'Electric', 'Ghost', q'{Head}', 'Red' , 0, 'G', 20, 'Levitate' , 0.3, 0.7, 0.3, 1, 0 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 585, q'|Spring Form|' , 'Field' , 'Normal', 'Grass', q'{Quadruped body}', 'Pink' , 0, '1:1', 20, 'Chlorophyll', 'Sap Sipper', 'Serene Grace', 19.5, 43, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 215 , 'Field' , 'Dark', 'Ice', q'{Bipedal, tailed form}', 'Black', 9, 9, 0, '1:1', 20, 'Inner Focus', 'Keen Eye', 'Pickpocket', 28, 61.7, 0.9, 2, 11 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 773, q'|Type: Ghost|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'RKS System' , 100.5, 221.6, 2.3, 7, 7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 773, q'|Type: Electric|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'RKS System' , 100.5, 221.6, 2.3, 7, 7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 272 , 'Water 1', 'Grass', 'Water', 'Grass', q'{Bipedal, tailless form}', 'Green' , 0, '1:1', 15, 'Swift Swim', 'Rain Dish', 'Own Tempo', 55, 121.3, 1.5, 4, 11 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 741, q'|Pom-Pom Style|' , 'Flying' , 'Fire', 'Flying', q'{Single pair of wings}', 'Yellow', 6, 6, 0, '3:1', 20, 'Dancer' , 3.4, 7.5, 0.6, 2, 0 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 645, q'|Incarnate Forme|' , 'Undiscovered' , 'Ground', 'Flying', q'{Head and arms}', 'Brown' , 0, '0:1U', 120, 'Sand Force' , 'Sheer Force', 68, 149.9, 1.3, 4, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 326 , 'Field' , 'Psychic' , q'{Bipedal, tailed form}', 'Purple' , 0, '1:1', 20, 'Thick Fat', 'Own Tempo', 'Gluttony', 71.5, 157.6, 0.9, 2, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 446 , 'Undiscovered' , 'Normal' , q'{Bipedal, tailless form}', 'Black', 6, 6, 0, '1:7U', 40, 'Pickup', 'Thick Fat', 'Gluttony', 105, 231.5, 0.6, 2, 0 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 666, q'|Polar Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 37.5, 1.2, 3, 11 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 306, q'|Mega|', 'M', q'|Aggronite|', 'Monster' , 'Steel' , q'{Bipedal, tailed form}', 'Gray' , 0, '1:1', 35, 'Filter' , 360, 793.7, 2.2, 7, 3 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 382, q'|Primal|', 'P', q'|Blue Orb|', 'Undiscovered' , 'Water' , q'{Fins}', 'Blue' , 0, 'GU', 120, 'Primordial Sea' , 352, 776, 9.8, 32, 2 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 362 , 'Fairy', 'Mineral', 'Ice' , q'{Head}', 'Gray', 3, 3, 2, '1:1', 20, 'Inner Focus', 'Ice Body', 'Moody', 256.5, 565.5, 1.5, 4, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 266 , 'Bug' , 'Bug' , q'{Head}', 'White' , 0, '1:1', 15, 'Shed Skin' , 10, 22, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 256 , 'Field' , 'Fire', 'Fighting', q'{Bipedal, tailed form}', 'Red' , 0, '1:7', 20, 'Blaze' , 'Speed Boost', 19.5, 43, 0.9, 2, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 178 , 'Flying' , 'Psychic', 'Flying', q'{Single pair of wings}', 'Green' , 6, 0, '1:1', 20, 'Synchronize', 'Early Bird', 'Magic Bounce', 15, 33.1, 1.5, 4, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 16 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Brown' , 2, '1:1', 15, 'Keen Eye', 'Tangled Feet', 'Big Pecks', 1.8, 4, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 27 , 'Field' , 'Ground' , q'{Bipedal, tailed form}', 'Yellow', 9, 9, 0, '1:1', 20, 'Sand Veil' , 'Sand Rush', 12, 26.5, 0.6, 2, 0 );
insert into SPECIES( DEX, CLASS , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 25, q'|Alola Cap|' , 'Field', 'Fairy', 'Electric' , q'{Quadruped body}', 'Yellow', 6, 6, 0, '1:1', 10, 'Static' , 'Lightning Rod', 6, 13.2, 0.4, 1, 4 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 208, q'|Mega|', 'M', q'|Steelixite|', 'Mineral' , 'Steel', 'Ground', q'{Serpentine bodies}', 'Gray' , 0, '1:1', 25, 'Sand Force' , 400, 881.8, 10.5, 34, 5 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 225 , 'Water 1', 'Field', 'Ice', 'Flying', q'{Single pair of wings}', 'Red', 9, 9, 0, '1:1', 20, 'Vital Spirit', 'Hustle', 'Insomnia', 16, 35.3, 0.9, 2, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 649 , 'Undiscovered' , 'Bug', 'Steel', q'{Bipedal, tailless form}', 'Purple' , 0, 'GU', 120, 'Download' , 82.5, 181.9, 1.5, 4, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 122 , 'Human-Like' , 'Psychic', 'Fairy', q'{Bipedal, tailless form}', 'Pink' , 0, 2, '1:1', 25, 'Soundproof', 'Filter', 'Technician', 54.5, 120.1, 1.3, 4, 3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 773, q'|Type: Fairy|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'RKS System' , 100.5, 221.6, 2.3, 7, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 61 , 'Water 1' , 'Water' , q'{Bipedal, tailless form}', 'Blue', 6, 6, 0, '1:1', 20, 'Water Absorb', 'Damp', 'Swift Swim', 20, 44.1, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 546 , 'Grass', 'Fairy', 'Grass', 'Fairy', q'{Head}', 'Green', 9, 9, 0, '1:1', 20, 'Prankster', 'Infiltrator', 'Chlorophyll', 0.6, 1.3, 0.3, 1, 0 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 354, q'|Mega|', 'M', q'|Banettite|', 'Amorphous' , 'Ghost' , q'{Bipedal, tailed form}', 'Black' , 6, 0, '1:1', 25, 'Prankster' , 12.5, 27.6, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 740 , 'Water 3' , 'Fighting', 'Ice', q'{Insectoid body}', 'White' , 0, '1:1', 20, 'Hyper Cutter', 'Iron Fist', 'Anger Point', 180, 396.8, 1.7, 5, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 538 , 'Human-Like' , 'Fighting' , q'{Bipedal, tailless form}', 'Red' , 0, '0:1', 20, 'Guts', 'Inner Focus', 'Mold Breaker', 55.5, 122.4, 1.3, 4, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 52 , 'Field' , 'Normal' , q'{Quadruped body}', 'Yellow', 9, 9, 2, '1:1', 20, 'Pickup', 'Technician', 'Unnerve', 4.2, 9.3, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 431 , 'Field' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, '3:1', 20, 'Limber', 'Own Tempo', 'Keen Eye', 3.9, 8.6, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 577 , 'Amorphous' , 'Psychic' , q'{Head}', 'Green' , 0, '1:1', 20, 'Overcoat', 'Magic Guard', 'Regenerator', 1, 2.2, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 377 , 'Undiscovered' , 'Rock' , q'{Bipedal, tailless form}', 'Brown' , 0, 'GU', 80, 'Clear Body' , 'Sturdy', 230, 507.1, 1.7, 5, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 790 , 'Undiscovered' , 'Psychic' , q'{Head}', 'Blue' , 0, 'GU', 120, 'Sturdy' , 999.9, 2204.4, 0.1, 0, 4 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 89, q'|Alolan|', 'A' , 'Amorphous' , 'Poison', 'Dark', q'{Head and arms}', 'Green', 6, 6, 0, '1:1', 20, 'Poison Touch', 'Gluttony', 'Power of Alchemy', 30, 66.1, 1, 3, 3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 801, q'|Original Color|' , 'Undiscovered' , 'Steel', 'Fairy', q'{Bipedal, tailless form}', 'Red' , 0, 'GU', 120, 'Soul-Heart' , 80.5, 177.5, 1, 3, 3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 25, q'|Belle|' , 'Field', 'Fairy', 'Electric' , q'{Quadruped body}', 'Yellow', 6, 6, 0, '1:1', 10, 'Static' , 'Lightning Rod', 6, 13.2, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 234 , 'Field' , 'Normal' , q'{Quadruped body}', 'Brown' , 2, '1:1', 20, 'Intimidate', 'Frisk', 'Sap Sipper', 71.2, 157, 1.4, 4, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 533 , 'Human-Like' , 'Fighting' , q'{Bipedal, tailless form}', 'Gray' , 0, '1:3', 20, 'Guts', 'Sheer Force', 'Iron Fist', 40, 88.2, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 238 , 'Undiscovered' , 'Ice', 'Psychic', q'{Bipedal, tailless form}', 'Pink' , 15, 2, '1:0U', 25, 'Oblivious', 'Forewarn', 'Hydration', 6, 13.2, 0.4, 1, 4 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 666, q'|River Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 37.5, 1.2, 3, 11 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 671, q'|Yellow Flower|' , 'Fairy' , 'Fairy' , q'{Head and arms}', 'White' , 0, '1:0', 20, 'Flower Veil' , 'Symbiosis', 10, 22, 1.1, 3, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 375 , 'Mineral' , 'Steel', 'Psychic', q'{Head and arms}', 'Blue', 6, 6, 0, 'G', 40, 'Clear Body' , 'Light Metal', 202.5, 446.4, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 180 , 'Monster', 'Field', 'Electric' , q'{Bipedal, tailed form}', 'Pink' , 6, 0, '1:1', 20, 'Static' , 'Plus', 13.3, 29.3, 0.8, 2, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 58 , 'Field' , 'Fire' , q'{Quadruped body}', 'Brown', 9, 9, 0, '1:3', 20, 'Intimidate', 'Flash Fire', 'Justified', 19, 41.9, 0.7, 2, 4 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 676, q'|Diamond Trim|' , 'Field' , 'Normal' , q'{Quadruped body}', 'White' , 6, 0, '1:1', 20, 'Fur Coat' , 28, 61.7, 1.2, 3, 11 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 260, q'|Mega|', 'M', q'|Swampertite|', 'Monster', 'Water 1', 'Water', 'Ground', q'{Bipedal, tailed form}', 'Blue' , 0, '1:7', 20, 'Swift Swim' , 81.9, 180.6, 1.9, 6, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 706 , 'Dragon' , 'Dragon' , q'{Bipedal, tailed form}', 'Purple' , 0, '1:1', 40, 'Sap Sipper', 'Hydration', 'Gooey', 150.5, 331.8, 2, 6, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 128 , 'Field' , 'Normal' , q'{Quadruped body}', 'Brown', 3, 3, 2, '0:1', 20, 'Intimidate', 'Anger Point', 'Sheer Force', 88.4, 194.9, 1.4, 4, 7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 428 , 'Field', 'Human-Like', 'Normal' , q'{Bipedal, tailed form}', 'Brown' , 6, 0, '1:1', 20, 'Cute Charm', 'Klutz', 'Limber', 33.3, 73.4, 1.2, 3, 11 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 212, q'|Mega|', 'M', q'|Scizorite|', 'Bug' , 'Bug', 'Steel', q'{Two or more pairs of wings}', 'Red' , 0, '1:1', 25, 'Technician' , 118, 260.1, 2, 6, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 193 , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'Red' , 0, '1:1', 20, 'Speed Boost', 'Compound Eyes', 'Frisk', 38, 83.8, 1.2, 3, 11 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 773, q'|Type: Flying|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'RKS System' , 100.5, 221.6, 2.3, 7, 7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 493, q'|Type: Normal|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Multitype' , 320, 705.5, 3.2, 10, 6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 509 , 'Field' , 'Dark' , q'{Quadruped body}', 'Purple' , 0, '1:1', 20, 'Limber', 'Unburden', 'Prankster', 10.1, 22.3, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 771 , 'Water 1' , 'Water' , q'{Serpentine bodies}', 'Black', 6, 6, 0, '1:1', 15, 'Innards Out' , 'Unaware', 1.2, 2.6, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 749 , 'Field' , 'Ground' , q'{Quadruped body}', 'Brown', 9, 9, 0, '1:1', 20, 'Own Tempo', 'Stamina', 'Inner Focus', 110, 242.5, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 31 , 'Undiscovered' , 'Poison', 'Ground', q'{Bipedal, tailed form}', 'Blue' , 2, '1:0U', 20, 'Poison Point', 'Rivalry', 'Sheer Force', 60, 132.3, 1.3, 4, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 88 , 'Amorphous' , 'Poison' , q'{Head and arms}', 'Purple', 9, 9, 0, '1:1', 20, 'Stench', 'Sticky Hold', 'Poison Touch', 30, 66.1, 0.9, 2, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 506 , 'Field' , 'Normal' , q'{Quadruped body}', 'Brown', 9, 9, 0, '1:1', 15, 'Vital Spirit', 'Pickup', 'Run Away', 4.1, 9, 0.4, 1, 4 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 383, q'|Primal|', 'P', q'|Red Orb|', 'Undiscovered' , 'Ground', 'Fire', q'{Bipedal, tailed form}', 'Red' , 0, 'GU', 120, 'Desolate Land' , 950, 2094.4, 5, 16, 5 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 493, q'|Type: Steel|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Multitype' , 320, 705.5, 3.2, 10, 6 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 716, q'|Active Mode|' , 'Undiscovered' , 'Fairy' , q'{Quadruped body}', 'Blue' , 0, 'GU', 120, 'Fairy Aura' , 215, 474, 3, 9, 10 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 711, q'|Average Size|' , 'Amorphous' , 'Ghost', 'Grass', q'{Head and a base}', 'Brown' , 0, '1:1', 20, 'Pickup', 'Frisk', 'Insomnia', 12.5, 27.6, 0.9, 2, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 665 , 'Bug' , 'Bug' , q'{Head and a base}', 'Black' , 0, '1:1', 15, 'Shed Skin' , 'Friend Guard', 8.4, 18.5, 0.3, 1, 0 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 641, q'|Therian Forme|', 'T' , 'Undiscovered' , 'Flying' , q'{Single pair of wings}', 'Green' , 0, '0:1U', 120, 'Regenerator' , 63, 138.9, 1.4, 4, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 328 , 'Bug' , 'Ground' , q'{Insectoid body}', 'Brown', 9, 9, 0, '1:1', 20, 'Hyper Cutter', 'Arena Trap', 'Sheer Force', 15, 33.1, 0.7, 2, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 137 , 'Mineral' , 'Normal' , q'{Head and legs}', 'Pink', 9, 9, 2, 'G', 20, 'Trace', 'Download', 'Analytic', 36.5, 80.5, 0.8, 2, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 801 , 'Undiscovered' , 'Steel', 'Fairy', q'{Bipedal, tailless form}', 'Gray' , 0, 'GU', 120, 'Soul-Heart' , 80.5, 177.5, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 260 , 'Monster', 'Water 1', 'Water', 'Ground', q'{Bipedal, tailed form}', 'Blue' , 0, '1:7', 20, 'Torrent' , 'Damp', 81.9, 180.6, 1.5, 4, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 164 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Brown' , 6, 0, '1:1', 15, 'Insomnia', 'Keen Eye', 'Tinted Lens', 40.8, 89.9, 1.6, 5, 3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 567 , 'Flying', 'Water 3', 'Rock', 'Flying', q'{Single pair of wings}', 'Yellow' , 0, '1:7', 30, 'Defeatist' , 32, 70.5, 1.4, 4, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 488 , 'Undiscovered' , 'Psychic' , q'{Serpentine bodies}', 'Yellow' , 0, '1:0U', 120, 'Levitate' , 85.6, 188.7, 1.5, 4, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 789 , 'Undiscovered' , 'Psychic' , q'{Head}', 'Blue' , 0, 'GU', 120, 'Unaware' , 0.1, 0.2, 0.2, 0, 8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 389 , 'Monster', 'Grass', 'Grass', 'Ground', q'{Quadruped body}', 'Green' , 0, '1:7', 20, 'Overgrow' , 'Shell Armor', 310, 683.4, 2.2, 7, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 591 , 'Grass' , 'Grass', 'Poison', q'{Head and arms}', 'White' , 0, '1:1', 20, 'Effect Spore' , 'Regenerator', 10.5, 23.1, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 54 , 'Water 1', 'Field', 'Water' , q'{Bipedal, tailed form}', 'Yellow', 15, 15, 0, '1:1', 20, 'Damp', 'Cloud Nine', 'Swift Swim', 19.6, 43.2, 0.8, 2, 7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 2 , 'Monster', 'Grass', 'Grass', 'Poison', q'{Quadruped body}', 'Green' , 0, '1:7', 20, 'Overgrow' , 'Chlorophyll', 13, 28.7, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 388 , 'Monster', 'Grass', 'Grass' , q'{Quadruped body}', 'Green' , 0, '1:7', 20, 'Overgrow' , 'Shell Armor', 97, 213.8, 1.1, 3, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 325 , 'Field' , 'Psychic' , q'{Head and arms}', 'Black' , 0, '1:1', 20, 'Thick Fat', 'Own Tempo', 'Gluttony', 30.6, 67.5, 0.7, 2, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 204 , 'Bug' , 'Bug' , q'{Head}', 'Gray' , 9, 0, '1:1', 20, 'Sturdy' , 'Overcoat', 7.2, 15.9, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 455 , 'Grass' , 'Grass' , q'{Tentacles or a multiped body}', 'Green' , 0, '1:1', 25, 'Levitate' , 27, 59.5, 1.4, 4, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 385 , 'Undiscovered' , 'Steel', 'Psychic', q'{Bipedal, tailless form}', 'Yellow' , 0, 'GU', 120, 'Serene Grace' , 1.1, 2.4, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 320 , 'Field', 'Water 2', 'Water' , q'{Fins}', 'Blue', 9, 9, 0, '1:1', 40, 'Water Veil', 'Oblivious', 'Pressure', 130, 286.6, 2, 6, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 240 , 'Undiscovered' , 'Fire' , q'{Bipedal, tailed form}', 'Red', 15, 15, 0, '1:3U', 25, 'Flame Body' , 'Vital Spirit', 21.4, 47.2, 0.7, 2, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 242 , 'Fairy' , 'Normal' , q'{Bipedal, tailless form}', 'Pink' , 0, 0, '1:0', 40, 'Natural Cure', 'Serene Grace', 'Healer', 46.8, 103.2, 1.5, 4, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 602 , 'Amorphous' , 'Electric' , q'{Fins}', 'White' , 0, '1:1', 20, 'Levitate' , 0.3, 0.7, 0.2, 0, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 172 , 'Undiscovered' , 'Electric' , q'{Quadruped body}', 'Yellow', 15, 15, 0, '1:1U', 10, 'Static' , 'Lightning Rod', 2, 4.4, 0.3, 1, 0 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 670, q'|Red Flower|' , 'Fairy' , 'Fairy' , q'{Head and arms}', 'White' , 9, 0, '1:0', 20, 'Flower Veil' , 'Symbiosis', 0.9, 2, 0.2, 0, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 441 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Black' , 0, '1:1', 20, 'Keen Eye', 'Tangled Feet', 'Big Pecks', 1.9, 4.2, 0.5, 1, 8 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 773, q'|Type: Ice|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'RKS System' , 100.5, 221.6, 2.3, 7, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 734 , 'Field' , 'Normal' , q'{Quadruped body}', 'Brown', 9, 9, 0, '1:1', 15, 'Stakeout', 'Strong Jaw', 'Adaptability', 6, 13.2, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 451 , 'Bug', 'Water 3', 'Poison', 'Bug', q'{Insectoid body}', 'Purple' , 0, '1:1', 20, 'Battle Armor', 'Sniper', 'Keen Eye', 12, 26.5, 0.8, 2, 7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 423, q'|West Sea|' , 'Water 1', 'Amorphous', 'Water', 'Ground', q'{Serpentine bodies}', 'Purple', 6, 6, 0, '1:1', 20, 'Sticky Hold', 'Storm Drain', 'Sand Force', 29.9, 65.9, 0.9, 2, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 270 , 'Water 1', 'Grass', 'Water', 'Grass', q'{Insectoid body}', 'Green' , 0, '1:1', 15, 'Swift Swim', 'Rain Dish', 'Own Tempo', 2.6, 5.7, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 768 , 'Bug', 'Water 3', 'Bug', 'Water', q'{Bipedal, tailless form}', 'Gray' , 0, '1:1', 20, 'Emergency Exit' , 108, 238.1, 2, 6, 7 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 18, q'|Mega|', 'M', q'|Pidgeotite|', 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Brown' , 0, '1:1', 15, 'No Guard' , 39.5, 87.1, 2.2, 7, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 624 , 'Human-Like' , 'Dark', 'Steel', q'{Bipedal, tailless form}', 'Red' , 0, 0, '1:1', 20, 'Defiant', 'Inner Focus', 'Pressure', 10.2, 22.5, 0.5, 1, 8 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 412, q'|Sandy Cloak|', 'G' , 'Bug' , 'Bug' , q'{Head and a base}', 'Green' , 0, '1:1', 15, 'Shed Skin' , 'Overcoat', 3.4, 7.5, 0.2, 0, 8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 87 , 'Water 1', 'Field', 'Water', 'Ice', q'{Fins}', 'White' , 6, 2, '1:1', 20, 'Thick Fat', 'Hydration', 'Ice Body', 120, 264.6, 1.7, 5, 7 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 386, q'|Speed Forme|', 'S' , 'Undiscovered' , 'Psychic' , q'{Bipedal, tailless form}', 'Red' , 0, 'GU', 120, 'Pressure' , 60.8, 134, 1.7, 5, 7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 791, q'|Radiant Sun phase|' , 'Undiscovered' , 'Psychic', 'Steel', q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Full Metal Body' , 230, 507.1, 3.4, 11, 2 );
insert into SPECIES( DEX, CLASS , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 25, q'|Sinnoh Cap|' , 'Field', 'Fairy', 'Electric' , q'{Quadruped body}', 'Yellow', 6, 6, 0, '1:1', 10, 'Static' , 'Lightning Rod', 6, 13.2, 0.4, 1, 4 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 666, q'|Continental Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 37.5, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 330 , 'Bug' , 'Ground', 'Dragon', q'{Single pair of wings}', 'Green' , 0, '1:1', 20, 'Levitate' , 82, 180.8, 2, 6, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 590 , 'Grass' , 'Grass', 'Poison', q'{Head and arms}', 'White' , 0, '1:1', 20, 'Effect Spore' , 'Regenerator', 1, 2.2, 0.2, 0, 8 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 671, q'|Red Flower|' , 'Fairy' , 'Fairy' , q'{Head and arms}', 'White' , 0, '1:0', 20, 'Flower Veil' , 'Symbiosis', 10, 22, 1.1, 3, 7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 773, q'|Type: Fighting|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'RKS System' , 100.5, 221.6, 2.3, 7, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 652 , 'Field' , 'Grass', 'Fighting', q'{Bipedal, tailed form}', 'Green' , 0, '1:7', 20, 'Overgrow' , 'Bulletproof', 90, 198.4, 1.6, 5, 3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 676, q'|Pharaoh Trim|' , 'Field' , 'Normal' , q'{Quadruped body}', 'White' , 6, 0, '1:1', 20, 'Fur Coat' , 28, 61.7, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 294 , 'Monster', 'Field', 'Normal' , q'{Bipedal, tailed form}', 'Blue' , 0, '1:1', 20, 'Soundproof' , 'Scrappy', 40.5, 89.3, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 110 , 'Amorphous' , 'Poison' , q'{Multiple bodies}', 'Purple' , 0, '1:1', 20, 'Levitate' , 9.5, 20.9, 1.2, 3, 11 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 88, q'|Alolan|', 'A' , 'Amorphous' , 'Poison', 'Dark', q'{Head and arms}', 'Purple', 9, 9, 0, '1:1', 20, 'Poison Touch', 'Gluttony', 'Power of Alchemy', 30, 66.1, 0.7, 2, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 84 , 'Flying' , 'Normal', 'Flying', q'{Head and legs}', 'Brown' , 0, '1:1', 20, 'Run Away', 'Early Bird', 'Tangled Feet', 39.2, 86.4, 1.4, 4, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 644 , 'Undiscovered' , 'Dragon', 'Electric', q'{Bipedal, tailed form}', 'Black' , 0, 'GU', 120, 'Teravolt' , 345, 760.6, 2.9, 9, 6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 466 , 'Human-Like' , 'Electric' , q'{Bipedal, tailed form}', 'Yellow' , 0, '1:3', 25, 'Motor Drive' , 'Vital Spirit', 138.6, 305.6, 1.8, 5, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 241 , 'Field' , 'Normal' , q'{Bipedal, tailed form}', 'Pink', 3, 3, 2, '1:0', 20, 'Thick Fat', 'Scrappy', 'Sap Sipper', 75.5, 166.4, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 561 , 'Flying' , 'Psychic', 'Flying', q'{Single pair of wings}', 'Black' , 0, '1:1', 20, 'Wonder Skin', 'Magic Guard', 'Tinted Lens', 14, 30.9, 1.4, 4, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 38 , 'Field' , 'Fire' , q'{Quadruped body}', 'Yellow' , 0, '3:1', 20, 'Flash Fire' , 'Drought', 19.9, 43.9, 1.1, 3, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 462 , 'Mineral' , 'Electric', 'Steel', q'{Head and arms}', 'Gray' , 0, 'G', 20, 'Magnet Pull', 'Sturdy', 'Analytic', 180, 396.8, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 24 , 'Field', 'Dragon', 'Poison' , q'{Serpentine bodies}', 'Purple' , 6, 0, '1:1', 20, 'Intimidate', 'Shed Skin', 'Unnerve', 65, 143.3, 3.5, 11, 6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 19 , 'Field' , 'Normal' , q'{Quadruped body}', 'Purple', 9, 9, 0, '1:1', 15, 'Run Away', 'Guts', 'Hustle', 3.5, 7.7, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 499 , 'Field' , 'Fire', 'Fighting', q'{Bipedal, tailed form}', 'Red' , 0, '1:7', 20, 'Blaze' , 'Thick Fat', 55.5, 122.4, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 226 , 'Water 1' , 'Water', 'Flying', q'{Single pair of wings}', 'Purple' , 0, '1:1', 25, 'Swift Swim', 'Water Absorb', 'Water Veil', 220, 485, 2.1, 6, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 484 , 'Undiscovered' , 'Water', 'Dragon', q'{Bipedal, tailed form}', 'Purple' , 0, 'GU', 120, 'Pressure' , 'Telepathy', 336, 740.8, 4.2, 13, 9 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 181, q'|Mega|', 'M', q'|Ampharosite|', 'Monster', 'Field', 'Electric', 'Dragon', q'{Bipedal, tailed form}', 'Yellow' , 0, '1:1', 20, 'Mold Breaker' , 61.5, 135.6, 1.4, 4, 7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 696 , 'Monster', 'Dragon', 'Rock', 'Dragon', q'{Bipedal, tailed form}', 'Brown' , 0, '1:7', 30, 'Strong Jaw' , 'Sturdy', 26, 57.3, 0.8, 2, 7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 421, q'|Sunshine Form|' , 'Fairy', 'Grass', 'Grass' , q'{Head and legs}', 'Pink' , 0, '1:1', 20, 'Flower Gift' , 9.3, 20.5, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 755 , 'Grass' , 'Grass', 'Fairy', q'{Head and a base}', 'Purple', 9, 9, 0, '1:1', 20, 'Illuminate', 'Effect Spore', 'Rain Dish', 1.5, 3.3, 0.2, 0, 8 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 20, q'|Alolan|', 'A' , 'Field' , 'Dark', 'Normal', q'{Quadruped body}', 'Black', 6, 6, 0, '1:1', 15, 'Gluttony', 'Hustle', 'Thick Fat', 18.5, 40.8, 0.7, 2, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 513 , 'Field' , 'Fire' , q'{Bipedal, tailed form}', 'Red' , 0, '1:7', 20, 'Gluttony' , 'Blaze', 11, 24.3, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 37 , 'Field' , 'Fire' , q'{Quadruped body}', 'Brown', 9, 9, 0, '3:1', 20, 'Flash Fire' , 'Drought', 9.9, 21.8, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 271 , 'Water 1', 'Grass', 'Water', 'Grass', q'{Bipedal, tailless form}', 'Green' , 0, '1:1', 15, 'Swift Swim', 'Rain Dish', 'Own Tempo', 32.5, 71.6, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 474 , 'Mineral' , 'Normal' , q'{Head and arms}', 'Red' , 0, 'G', 20, 'Adaptability', 'Download', 'Analytic', 34, 75, 0.9, 2, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 704 , 'Dragon' , 'Dragon' , q'{Serpentine bodies}', 'Purple' , 0, '1:1', 40, 'Sap Sipper', 'Hydration', 'Gooey', 2.8, 6.2, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 664 , 'Bug' , 'Bug' , q'{Insectoid body}', 'Black' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 2.5, 5.5, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 763 , 'Grass' , 'Grass' , q'{Bipedal, tailless form}', 'Purple' , 0, '1:0', 20, 'Leaf Guard', 'Queenly Majesty', 'Sweet Veil', 21.4, 47.2, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 475 , 'Amorphous' , 'Psychic', 'Fighting', q'{Bipedal, tailless form}', 'White' , 0, '0:1', 20, 'Steadfast' , 'Justified', 52, 114.6, 1.6, 5, 3 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 351, q'|Rainy Form|', 'R' , 'Fairy', 'Amorphous', 'Water' , q'{Head}', 'Blue', 0, 0, 0, '1:1', 25, 'Forecast' , 0.8, 1.8, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 254 , 'Monster', 'Dragon', 'Grass' , q'{Bipedal, tailed form}', 'Green' , 0, '1:7', 20, 'Overgrow' , 'Unburden', 52.2, 115.1, 1.7, 5, 7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 460 , 'Monster', 'Grass', 'Grass', 'Ice', q'{Bipedal, tailed form}', 'White' , 0, '1:1', 20, 'Snow Warning' , 'Soundproof', 135.5, 298.7, 2.2, 7, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 794 , 'Undiscovered' , 'Bug', 'Fighting', q'{Tentacles or a multiped body}', 'Red' , 0, 'GU', 120, 'Beast Boost' , 333.6, 735.5, 2.4, 7, 10 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 788 , 'Undiscovered' , 'Water', 'Fairy', q'{Head and arms}', 'Purple' , 0, 'GU', 15, 'Misty Surge' , 'Telepathy', 21.2, 46.7, 1.3, 4, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 155 , 'Field' , 'Fire' , q'{Bipedal, tailless form}', 'Yellow' , 0, '1:7', 20, 'Blaze' , 'Flash Fire', 7.9, 17.4, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 287 , 'Field' , 'Normal' , q'{Quadruped body}', 'Brown' , 0, '1:1', 15, 'Truant' , 24, 52.9, 0.8, 2, 7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 315 , 'Fairy', 'Grass', 'Grass', 'Poison', q'{Bipedal, tailless form}', 'Green' , 0, '1:1', 20, 'Natural Cure', 'Poison Point', 'Leaf Guard', 2, 4.4, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 440 , 'Undiscovered' , 'Normal' , q'{Bipedal, tailless form}', 'Pink', 0, 0, 0, '1:0U', 40, 'Natural Cure', 'Serene Grace', 'Friend Guard', 24.4, 53.8, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 135 , 'Field' , 'Electric' , q'{Quadruped body}', 'Yellow' , 0, '1:7', 35, 'Volt Absorb' , 'Quick Feet', 24.5, 54, 0.8, 2, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 765 , 'Field' , 'Normal', 'Psychic', q'{Bipedal, tailless form}', 'White', 15, 15, 0, '1:1', 20, 'Inner Focus', 'Telepathy', 'Symbiosis', 76, 167.6, 1.5, 4, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 142 , 'Flying' , 'Rock', 'Flying', q'{Single pair of wings}', 'Purple' , 0, '1:7', 35, 'Rock Head', 'Pressure', 'Unnerve', 59, 130.1, 1.8, 5, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 228 , 'Field' , 'Dark', 'Fire', q'{Quadruped body}', 'Black' , 9, 0, '1:1', 20, 'Early Bird', 'Flash Fire', 'Unnerve', 10.8, 23.8, 0.6, 2, 0 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 493, q'|Type: Water|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Multitype' , 320, 705.5, 3.2, 10, 6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 479 , 'Amorphous' , 'Electric', 'Ghost', q'{Head}', 'Red' , 0, 'G', 20, 'Levitate' , 0.3, 0.7, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 628 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Red', 6, 6, 0, '0:1', 20, 'Keen Eye', 'Sheer Force', 'Defiant', 41, 90.4, 1.5, 4, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 545 , 'Bug' , 'Bug', 'Poison', q'{Insectoid body}', 'Red' , 9, '1:1', 20, 'Poison Point', 'Swarm', 'Speed Boost', 200.5, 442, 2.5, 8, 2 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 248, q'|Mega|', 'M', q'|Tyranitarite|', 'Monster' , 'Rock', 'Dark', q'{Bipedal, tailed form}', 'Green' , 0, '1:1', 40, 'Sand Stream' , 202, 445.3, 2.5, 8, 2 );
insert into SPECIES( DEX, CLASS , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 25, q'|Unova Cap|' , 'Field', 'Fairy', 'Electric' , q'{Quadruped body}', 'Yellow', 6, 6, 0, '1:1', 10, 'Static' , 'Lightning Rod', 6, 13.2, 0.4, 1, 4 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 718, q'|50% Forme|' , 'Undiscovered' , 'Dragon', 'Ground', q'{Serpentine bodies}', 'Green' , 0, 'GU', 120, 'Aura Break', 'Power Construct' , 305, 672.4, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 544 , 'Bug' , 'Bug', 'Poison', q'{Head}', 'Gray' , 9, '1:1', 15, 'Poison Point', 'Swarm', 'Speed Boost', 58.5, 129, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 273 , 'Field', 'Grass', 'Grass' , q'{Head and legs}', 'Brown' , 0, '1:1', 15, 'Chlorophyll', 'Early Bird', 'Pickpocket', 4, 8.8, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 143 , 'Monster' , 'Normal' , q'{Bipedal, tailless form}', 'Black', 0, 0, 0, '1:7', 40, 'Immunity', 'Thick Fat', 'Gluttony', 460, 1014.1, 2.1, 6, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 732 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Black', 9, 9, 0, '1:1', 15, 'Keen Eye', 'Skill Link', 'Pickup', 14.8, 32.6, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 461 , 'Field' , 'Dark', 'Ice', q'{Bipedal, tailed form}', 'Black' , 0, '1:1', 20, 'Pressure' , 'Pickpocket', 34, 75, 1.1, 3, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 756 , 'Grass' , 'Grass', 'Fairy', q'{Bipedal, tailless form}', 'Purple', 6, 6, 0, '1:1', 20, 'Illuminate', 'Effect Spore', 'Rain Dish', 11.5, 25.4, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 698 , 'Monster' , 'Rock', 'Ice', q'{Quadruped body}', 'Blue' , 0, '1:7', 30, 'Refrigerate' , 'Snow Warning', 25.2, 55.6, 1.3, 4, 3 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 550, q'|Blue-Striped Form|', 'B' , 'Water 2' , 'Water' , q'{Fins}', 'Green' , 0, 8, '1:1', 40, 'Rock Head', 'Adaptability', 'Mold Breaker', 18, 39.7, 1, 3, 3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 670, q'|Yellow Flower|' , 'Fairy' , 'Fairy' , q'{Head and arms}', 'White' , 0, 0, '1:0', 20, 'Flower Veil' , 'Symbiosis', 0.9, 2, 0.2, 0, 8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 692 , 'Water 1', 'Water 3', 'Water' , q'{Insectoid body}', 'Blue' , 9, 0, '1:1', 15, 'Mega Launcher' , 8.3, 18.3, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 83 , 'Flying', 'Field', 'Normal', 'Flying', q'{Single pair of wings}', 'Brown' , 0, '1:1', 20, 'Keen Eye', 'Inner Focus', 'Defiant', 15, 33.1, 0.8, 2, 7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 25, q'|Partner Cap|' , 'Field', 'Fairy', 'Electric' , q'{Quadruped body}', 'Yellow', 6, 6, 0, '1:1', 10, 'Static' , 'Lightning Rod', 6, 13.2, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 530 , 'Field' , 'Ground', 'Steel', q'{Bipedal, tailless form}', 'Gray' , 0, '1:1', 20, 'Sand Rush', 'Sand Force', 'Mold Breaker', 40.4, 89.1, 0.7, 2, 4 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 493, q'|Type: Ground|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Multitype' , 320, 705.5, 3.2, 10, 6 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 598 , 'Grass', 'Mineral', 'Grass', 'Steel', q'{Tentacles or a multiped body}', 'Gray' , 1, '1:1', 20, 'Iron Barbs' , 'Anticipation', 110, 242.5, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 99 , 'Water 3' , 'Water' , q'{Insectoid body}', 'Red' , 0, '1:1', 20, 'Hyper Cutter', 'Shell Armor', 'Sheer Force', 60, 132.3, 1.3, 4, 3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 666, q'|Garden Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 37.5, 1.2, 3, 11 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 676, q'|Debutante Trim|' , 'Field' , 'Normal' , q'{Quadruped body}', 'White' , 6, 0, '1:1', 20, 'Fur Coat' , 28, 61.7, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 458 , 'Undiscovered' , 'Water', 'Flying', q'{Single pair of wings}', 'Blue' , 15, 0, '1:1U', 25, 'Swift Swim', 'Water Absorb', 'Water Veil', 65, 143.3, 1, 3, 3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 746, q'|Solo Form|' , 'Water 2' , 'Water' , q'{Fins}', 'Blue', 9, 9, 0, '1:1', 15, 'Schooling' , 0.3, 0.7, 0.2, 0, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 17 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Brown' , 2, '1:1', 15, 'Keen Eye', 'Tangled Feet', 'Big Pecks', 30, 66.1, 1.1, 3, 7 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 303, q'|Mega|', 'M', q'|Mawilite|', 'Field', 'Fairy', 'Steel', 'Fairy', q'{Bipedal, tailless form}', 'Black' , 6, 0, '1:1', 20, 'Huge Power' , 11.5, 25.4, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 432 , 'Field' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, '3:1', 20, 'Thick Fat', 'Own Tempo', 'Defiant', 43.8, 96.6, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 48 , 'Bug' , 'Bug', 'Poison', q'{Bipedal, tailless form}', 'Purple' , 2, '1:1', 20, 'Compound Eyes', 'Tinted Lens', 'Run Away', 30, 66.1, 1, 3, 3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 172, q'|Spiky-eared|' , 'Undiscovered' , 'Electric' , q'{Quadruped body}', 'Yellow', 15, 15, 0, '1:1U', 10, 'Static' , 'Lightning Rod', 2, 4.4, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 8 , 'Monster', 'Water 1', 'Water' , q'{Bipedal, tailed form}', 'Blue' , 0, '1:7', 20, 'Torrent' , 'Rain Dish', 22.5, 49.6, 1, 3, 3 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 65, q'|Mega|', 'M', q'|Alakazite|', 'Human-Like' , 'Psychic' , q'{Bipedal, tailless form}', 'Brown' , 0, '1:3', 20, 'Trace' , 48, 105.8, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 167 , 'Bug' , 'Bug', 'Poison', q'{Insectoid body}', 'Green', 9, 9, 0, '1:1', 15, 'Swarm', 'Insomnia', 'Sniper', 8.5, 18.7, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 556 , 'Grass' , 'Grass' , q'{Head and a base}', 'Green' , 0, '1:1', 20, 'Water Absorb', 'Chlorophyll', 'Storm Drain', 28, 61.7, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 637 , 'Bug' , 'Bug', 'Fire', q'{Two or more pairs of wings}', 'White' , 0, 0, '1:1', 40, 'Flame Body' , 'Swarm', 46, 101.4, 1.6, 5, 3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 687 , 'Water 1', 'Water 2', 'Dark', 'Psychic', q'{Head and a base}', 'Blue' , 6, 0, '1:1', 20, 'Contrary', 'Suction Cups', 'Infiltrator', 47, 103.6, 1.5, 4, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 435 , 'Field' , 'Poison', 'Dark', q'{Quadruped body}', 'Purple' , 0, '1:1', 20, 'Stench', 'Aftermath', 'Keen Eye', 38, 83.8, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 798 , 'Undiscovered' , 'Grass', 'Steel', q'{Bipedal, tailless form}', 'White' , 0, 'GU', 120, 'Beast Boost' , 0.1, 0.2, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 667 , 'Field' , 'Fire', 'Normal', q'{Quadruped body}', 'Brown' , 9, 0, '7:1', 20, 'Rivalry', 'Unnerve', 'Moxie', 13.5, 29.8, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 622 , 'Mineral' , 'Ground', 'Ghost', q'{Bipedal, tailless form}', 'Green' , 15, 0, 'G', 25, 'Iron Fist', 'Klutz', 'No Guard', 92, 202.8, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 44 , 'Grass' , 'Grass', 'Poison', q'{Bipedal, tailless form}', 'Blue' , 0, '1:1', 20, 'Chlorophyll' , 'Stench', 8.6, 19, 0.8, 2, 7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 619 , 'Field', 'Human-Like', 'Fighting' , q'{Bipedal, tailed form}', 'Yellow' , 6, 0, '1:1', 25, 'Inner Focus', 'Regenerator', 'Reckless', 20, 44.1, 0.9, 2, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 80 , 'Monster', 'Water 1', 'Water', 'Psychic', q'{Bipedal, tailed form}', 'Pink', 3, 3, 0, '1:1', 20, 'Oblivious', 'Own Tempo', 'Regenerator', 78.5, 173.1, 1.6, 5, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 573 , 'Field' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, '3:1', 15, 'Cute Charm', 'Technician', 'Skill Link', 7.5, 16.5, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 799 , 'Undiscovered' , 'Dark', 'Dragon', q'{Bipedal, tailed form}', 'Black' , 0, 'GU', 120, 'Beast Boost' , 888, 1957.7, 5.5, 18, 1 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 140 , 'Water 1', 'Water 3', 'Rock', 'Water', q'{Insectoid body}', 'Brown' , 0, '1:7', 30, 'Swift Swim', 'Battle Armor', 'Weak Armor', 11.5, 25.4, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 784 , 'Dragon' , 'Dragon', 'Fighting', q'{Bipedal, tailed form}', 'Gray', 0, 0, 0, '1:1', 40, 'Bulletproof', 'Soundproof', 'Overcoat', 78.2, 172.4, 1.6, 5, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 136 , 'Field' , 'Fire' , q'{Quadruped body}', 'Red' , 0, '1:7', 35, 'Flash Fire' , 'Guts', 25, 55.1, 0.9, 2, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 658 , 'Water 1' , 'Water', 'Dark', q'{Bipedal, tailless form}', 'Blue' , 0, '1:7', 20, 'Torrent' , 'Protean', 40, 88.2, 1.5, 4, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 303 , 'Field', 'Fairy', 'Steel', 'Fairy', q'{Bipedal, tailless form}', 'Black' , 6, 0, '1:1', 20, 'Hyper Cutter', 'Intimidate', 'Sheer Force', 11.5, 25.4, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 194 , 'Water 1', 'Field', 'Water', 'Ground', q'{Head and legs}', 'Blue' , 0, '1:1', 20, 'Damp', 'Water Absorb', 'Unaware', 8.5, 18.7, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 498 , 'Field' , 'Fire' , q'{Quadruped body}', 'Red' , 0, '1:7', 20, 'Blaze' , 'Thick Fat', 9.9, 21.8, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 643 , 'Undiscovered' , 'Dragon', 'Fire', q'{Single pair of wings}', 'White' , 0, 'GU', 120, 'Turboblaze' , 330, 727.5, 3.2, 10, 6 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 28, q'|Alolan|', 'A' , 'Field' , 'Ice', 'Steel', q'{Bipedal, tailed form}', 'Blue' , 0, '1:1', 20, 'Snow Cloak' , 'Slush Rush', 29.5, 65, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 615 , 'Mineral' , 'Ice' , q'{Head}', 'Blue' , 0, 'G', 25, 'Levitate' , 148, 326.3, 1.1, 3, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 542 , 'Bug' , 'Bug', 'Grass', q'{Bipedal, tailless form}', 'Yellow' , 0, '1:1', 15, 'Swarm', 'Chlorophyll', 'Overcoat', 20.5, 45.2, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 735 , 'Field' , 'Normal' , q'{Quadruped body}', 'Brown', 6, 6, 0, '1:1', 15, 'Stakeout', 'Strong Jaw', 'Adaptability', 14.2, 31.3, 0.7, 2, 4 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 773, q'|Type: Rock|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'RKS System' , 100.5, 221.6, 2.3, 7, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 781 , 'Mineral' , 'Ghost', 'Grass', q'{Head and a base}', 'Green', 3, 3, 0, 'G', 25, 'Steelworker' , 210, 463, 3.9, 12, 10 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 403 , 'Field' , 'Electric' , q'{Quadruped body}', 'Blue' , 0, '1:1', 20, 'Rivalry', 'Intimidate', 'Guts', 9.5, 20.9, 0.5, 1, 8 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 710, q'|Large Size|' , 'Amorphous' , 'Ghost', 'Grass', q'{Head}', 'Brown' , 0, '1:1', 20, 'Pickup', 'Frisk', 'Insomnia', 7.5, 16.5, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 376 , 'Mineral' , 'Steel', 'Psychic', q'{Multiple bodies}', 'Blue' , 0, 'G', 40, 'Clear Body' , 'Light Metal', 550, 1212.5, 1.6, 5, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 219 , 'Amorphous' , 'Fire', 'Rock', q'{Serpentine bodies}', 'Red' , 0, '1:1', 20, 'Magma Armor', 'Flame Body', 'Weak Armor', 55, 121.3, 0.8, 2, 7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 560 , 'Field', 'Dragon', 'Dark', 'Fighting', q'{Bipedal, tailed form}', 'Red' , 6, 0, '1:1', 15, 'Shed Skin', 'Moxie', 'Intimidate', 30, 66.1, 1.1, 3, 7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 558 , 'Bug', 'Mineral', 'Bug', 'Rock', q'{Insectoid body}', 'Red' , 0, '1:1', 20, 'Sturdy', 'Shell Armor', 'Weak Armor', 200, 440.9, 1.4, 4, 7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 363 , 'Water 1', 'Field', 'Ice', 'Water', q'{Fins}', 'Blue' , 2, '1:1', 20, 'Thick Fat', 'Ice Body', 'Oblivious', 39.5, 87.1, 0.8, 2, 7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 195 , 'Water 1', 'Field', 'Water', 'Ground', q'{Bipedal, tailed form}', 'Blue' , 0, '1:1', 20, 'Damp', 'Water Absorb', 'Unaware', 75, 165.3, 1.4, 4, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 569 , 'Mineral' , 'Poison' , q'{Bipedal, tailless form}', 'Green', 6, 6, 0, '1:1', 20, 'Stench', 'Weak Armor', 'Aftermath', 107.3, 236.6, 1.9, 6, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 161 , 'Field' , 'Normal' , q'{Quadruped body}', 'Brown' , 0, '1:1', 15, 'Run Away', 'Keen Eye', 'Frisk', 6, 13.2, 0.8, 2, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 229 , 'Field' , 'Dark', 'Fire', q'{Quadruped body}', 'Black' , 6, 0, '1:1', 20, 'Early Bird', 'Flash Fire', 'Unnerve', 35, 77.2, 1.4, 4, 7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 332 , 'Grass', 'Human-Like', 'Grass', 'Dark', q'{Bipedal, tailless form}', 'Green' , 0, '1:1', 20, 'Sand Veil' , 'Water Absorb', 77.4, 170.6, 1.3, 4, 3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 621 , 'Dragon', 'Monster', 'Dragon' , q'{Bipedal, tailed form}', 'Red' , 3, 0, '1:1', 30, 'Rough Skin', 'Sheer Force', 'Mold Breaker', 139, 306.4, 1.6, 5, 3 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 376, q'|Mega|', 'M', q'|Metagrossite|', 'Mineral' , 'Steel', 'Psychic', q'{Multiple bodies}', 'Blue' , 0, 'G', 40, 'Tough Claws' , 550, 1212.5, 2.5, 8, 2 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 199 , 'Monster', 'Water 1', 'Water', 'Psychic', q'{Bipedal, tailed form}', 'Pink', 0, 0, 0, '1:1', 20, 'Oblivious', 'Own Tempo', 'Regenerator', 79.5, 175.3, 2, 6, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 65 , 'Human-Like' , 'Psychic' , q'{Bipedal, tailless form}', 'Brown' , 0, '1:3', 20, 'Synchronize', 'Inner Focus', 'Magic Guard', 48, 105.8, 1.5, 4, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 690 , 'Water 1', 'Dragon', 'Poison', 'Water', q'{Head and a base}', 'Brown' , 9, 0, '1:1', 20, 'Poison Point', 'Poison Touch', 'Adaptability', 7.3, 16.1, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 482 , 'Undiscovered' , 'Psychic' , q'{Bipedal, tailed form}', 'Blue' , 0, 'GU', 80, 'Levitate' , 0.3, 0.7, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 491 , 'Undiscovered' , 'Dark' , q'{Bipedal, tailless form}', 'Black' , 0, 'GU', 120, 'Bad Dreams' , 50.5, 111.3, 1.5, 4, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 610 , 'Monster', 'Dragon', 'Dragon' , q'{Bipedal, tailed form}', 'Green' , 0, '1:1', 40, 'Rivalry', 'Mold Breaker', 'Unnerve', 18, 39.7, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 76 , 'Mineral' , 'Rock', 'Ground', q'{Bipedal, tailless form}', 'Brown' , 0, '1:1', 15, 'Rock Head', 'Sturdy', 'Sand Veil', 300, 661.4, 1.4, 4, 7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 493, q'|Type: Fighting|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Multitype' , 320, 705.5, 3.2, 10, 6 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 176 , 'Flying', 'Fairy', 'Fairy', 'Flying', q'{Bipedal, tailless form}', 'White' , 0, '1:7', 10, 'Hustle', 'Serene Grace', 'Super Luck', 3.2, 7.1, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 384 , 'Undiscovered' , 'Dragon', 'Flying', q'{Serpentine bodies}', 'Green' , 0, 'GU', 120, 'Air Lock' , 206.5, 455.2, 7, 23, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 11 , 'Bug' , 'Bug' , q'{Serpentine bodies}', 'Green', 15, 15, 0, '1:1', 15, 'Shed Skin' , 9.9, 21.8, 0.7, 2, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 299 , 'Mineral' , 'Rock' , q'{Bipedal, tailless form}', 'Gray', 9, 9, 0, '1:1', 20, 'Sturdy', 'Magnet Pull', 'Sand Force', 97, 213.8, 1, 3, 3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 666, q'|Sandstorm Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 37.5, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 392 , 'Field', 'Human-Like', 'Fire', 'Fighting', q'{Bipedal, tailed form}', 'Brown' , 0, '1:7', 20, 'Blaze' , 'Iron Fist', 55, 121.3, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 606 , 'Human-Like' , 'Psychic' , q'{Bipedal, tailless form}', 'Brown' , 15, 0, '1:1', 20, 'Telepathy', 'Synchronize', 'Analytic', 34.5, 76.1, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 797 , 'Undiscovered' , 'Steel', 'Flying', q'{Bipedal, tailless form}', 'Green' , 0, 'GU', 120, 'Beast Boost' , 999.9, 2204.4, 9.2, 30, 2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 614 , 'Field' , 'Ice' , q'{Quadruped body}', 'White' , 2, '1:1', 20, 'Snow Cloak', 'Slush Rush', 'Swift Swim', 260, 573.2, 2.6, 8, 6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 96 , 'Human-Like' , 'Psychic' , q'{Bipedal, tailless form}', 'Yellow', 9, 9, 2, '1:1', 20, 'Insomnia', 'Forewarn', 'Inner Focus', 32.4, 71.4, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 444 , 'Monster', 'Dragon', 'Dragon', 'Ground', q'{Bipedal, tailed form}', 'Blue', 0, 0, 0, '1:1', 40, 'Sand Veil' , 'Rough Skin', 56, 123.5, 1.4, 4, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 748 , 'Water 1' , 'Poison', 'Water', q'{Tentacles or a multiped body}', 'Blue' , 0, '1:1', 20, 'Merciless', 'Limber', 'Regenerator', 14.5, 32, 0.7, 2, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 632 , 'Bug' , 'Bug', 'Steel', q'{Insectoid body}', 'Gray' , 0, '1:1', 20, 'Swarm', 'Hustle', 'Truant', 33, 72.8, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 118 , 'Water 2' , 'Water' , q'{Fins}', 'Red', 9, 9, 0, '1:1', 20, 'Swift Swim', 'Water Veil', 'Lightning Rod', 15, 33.1, 0.6, 2, 0 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 648, q'|Aria Forme|' , 'Undiscovered' , 'Normal', 'Psychic', q'{Bipedal, tailless form}', 'White' , 0, 'GU', 120, 'Serene Grace' , 6.5, 14.3, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 391 , 'Field', 'Human-Like', 'Fire', 'Fighting', q'{Bipedal, tailed form}', 'Brown' , 0, '1:7', 20, 'Blaze' , 'Iron Fist', 22, 48.5, 0.9, 2, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 675 , 'Field', 'Human-Like', 'Fighting', 'Dark', q'{Bipedal, tailless form}', 'White', 0, 0, 0, '1:1', 25, 'Iron Fist', 'Mold Breaker', 'Scrappy', 136, 299.8, 2.1, 6, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 42 , 'Flying' , 'Poison', 'Flying', q'{Single pair of wings}', 'Purple', 9, 9, 0, '1:1', 15, 'Inner Focus' , 'Infiltrator', 55, 121.3, 1.6, 5, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 255 , 'Field' , 'Fire' , q'{Head and legs}', 'Red' , 0, '1:7', 20, 'Blaze' , 'Speed Boost', 2.5, 5.5, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 717 , 'Undiscovered' , 'Dark', 'Flying', q'{Single pair of wings}', 'Red' , 0, 'GU', 120, 'Dark Aura' , 203, 447.5, 5.8, 19, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 783 , 'Dragon' , 'Dragon', 'Fighting', q'{Bipedal, tailed form}', 'Gray', 6, 6, 0, '1:1', 40, 'Bulletproof', 'Soundproof', 'Overcoat', 47, 103.6, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 94 , 'Amorphous' , 'Ghost', 'Poison', q'{Bipedal, tailed form}', 'Purple', 0, 0, 8, '1:1', 20, 'Cursed Body' , 40.5, 89.3, 1.5, 4, 11 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 479, q'|Fan|' , 'Amorphous' , 'Electric', 'Ghost', q'{Head}', 'Red' , 0, 'G', 20, 'Levitate' , 0.3, 0.7, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 608 , 'Amorphous' , 'Ghost', 'Fire', q'{Head and arms}', 'Black' , 9, '1:1', 20, 'Flash Fire', 'Flame Body', 'Infiltrator', 13, 28.7, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 239 , 'Undiscovered' , 'Electric' , q'{Bipedal, tailless form}', 'Yellow', 15, 15, 0, '1:3U', 25, 'Static' , 'Vital Spirit', 23.5, 51.8, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 345 , 'Water 3' , 'Rock', 'Grass', q'{Head and a base}', 'Purple' , 0, '1:7', 30, 'Suction Cups' , 'Storm Drain', 23.8, 52.5, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 620 , 'Field', 'Human-Like', 'Fighting' , q'{Bipedal, tailed form}', 'Purple' , 3, 0, '1:1', 25, 'Inner Focus', 'Regenerator', 'Reckless', 35.5, 78.3, 1.4, 4, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 304 , 'Monster' , 'Steel', 'Rock', q'{Quadruped body}', 'Gray' , 0, '1:1', 35, 'Sturdy', 'Rock Head', 'Heavy Metal', 60, 132.3, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 427 , 'Field', 'Human-Like', 'Normal' , q'{Bipedal, tailed form}', 'Brown' , 9, 0, '1:1', 20, 'Run Away', 'Klutz', 'Limber', 5.5, 12.1, 0.4, 1, 4 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 334, q'|Mega|', 'M', q'|Altarianite|', 'Flying', 'Dragon', 'Dragon', 'Fairy', q'{Single pair of wings}', 'Blue' , 0, '1:1', 20, 'Pixilate' , 20.6, 45.4, 1.5, 4, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 249 , 'Undiscovered' , 'Psychic', 'Flying', q'{Single pair of wings}', 'White' , 0, 'GU', 120, 'Pressure' , 'Multiscale', 216, 476.2, 5.2, 17, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 437 , 'Mineral' , 'Steel', 'Psychic', q'{Head and arms}', 'Green' , 0, 'G', 20, 'Levitate', 'Heatproof', 'Heavy Metal', 187, 412.3, 1.3, 4, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 359 , 'Field' , 'Dark' , q'{Quadruped body}', 'White', 3, 3, 2, '1:1', 25, 'Pressure', 'Super Luck', 'Justified', 47, 103.6, 1.2, 3, 11 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 643, q'|Overdrive mode|' , 'Undiscovered' , 'Dragon', 'Fire', q'{Single pair of wings}', 'White' , 0, 'GU', 120, 'Turboblaze' , 330, 727.5, 3.2, 10, 6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 712 , 'Monster' , 'Ice' , q'{Quadruped body}', 'Blue' , 0, '1:1', 20, 'Own Tempo', 'Ice Body', 'Sturdy', 99.5, 219.4, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 378 , 'Undiscovered' , 'Ice' , q'{Bipedal, tailless form}', 'Blue' , 0, 'GU', 80, 'Clear Body' , 'Ice Body', 175, 385.8, 1.8, 5, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 147 , 'Water 1', 'Dragon', 'Dragon' , q'{Serpentine bodies}', 'Blue', 9, 9, 0, '1:1', 40, 'Shed Skin' , 'Marvel Scale', 3.3, 7.3, 1.8, 5, 11 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 493, q'|Type: Flying|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Multitype' , 320, 705.5, 3.2, 10, 6 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 666, q'|Ocean Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 37.5, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 62 , 'Water 1' , 'Water', 'Fighting', q'{Bipedal, tailless form}', 'Blue', 0, 0, 0, '1:1', 20, 'Water Absorb', 'Damp', 'Swift Swim', 54, 119, 1.3, 4, 3 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 74, q'|Alolan|', 'A' , 'Mineral' , 'Rock', 'Electric', q'{Head and arms}', 'Gray', 9, 9, 0, '1:1', 15, 'Magnet Pull', 'Sturdy', 'Galvanize', 20, 44.1, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 549 , 'Grass' , 'Grass' , q'{Head and a base}', 'Green' , 0, '1:0', 20, 'Chlorophyll', 'Own Tempo', 'Leaf Guard', 16.3, 35.9, 1.1, 3, 7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 669, q'|Blue Flower|' , 'Fairy' , 'Fairy' , q'{Head and arms}', 'White' , 15, 0, '1:0', 20, 'Flower Veil' , 'Symbiosis', 0.1, 0.2, 0.1, 0, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 358 , 'Amorphous' , 'Psychic' , q'{Head and arms}', 'Blue' , 0, '1:1', 25, 'Levitate' , 1, 2.2, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 589 , 'Bug' , 'Bug', 'Steel', q'{Head and arms}', 'Gray' , 0, '1:1', 15, 'Swarm', 'Shell Armor', 'Overcoat', 33, 72.8, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 347 , 'Water 3' , 'Rock', 'Bug', q'{Insectoid body}', 'Gray' , 0, '1:7', 30, 'Battle Armor' , 'Swift Swim', 12.5, 27.6, 0.7, 2, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 796 , 'Undiscovered' , 'Electric' , q'{Bipedal, tailed form}', 'Black' , 0, 'GU', 120, 'Beast Boost' , 100, 220.5, 3.8, 12, 6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 75 , 'Mineral' , 'Rock', 'Ground', q'{Bipedal, tailless form}', 'Brown', 6, 6, 0, '1:1', 15, 'Rock Head', 'Sturdy', 'Sand Veil', 105, 231.5, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 211 , 'Water 2' , 'Water', 'Poison', q'{Fins}', 'Gray' , 0, '1:1', 20, 'Poison Point', 'Swift Swim', 'Intimidate', 3.9, 8.6, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 12 , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White', 0, 0, 0, '1:1', 15, 'Compound Eyes' , 'Tinted Lens', 32, 70.5, 1.1, 3, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 45 , 'Grass' , 'Grass', 'Poison', q'{Bipedal, tailless form}', 'Red' , 0, '1:1', 20, 'Chlorophyll' , 'Effect Spore', 18.6, 41, 1.2, 3, 11 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 802, q'|Zenith|' , 'Undiscovered' , 'Fighting', 'Ghost', q'{Bipedal, tailless form}', 'Gray' , 0, 'GU', 120, 'Technician' , 22.2, 48.9, 0.7, 2, 4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 47 , 'Bug', 'Grass', 'Bug', 'Grass', q'{Insectoid body}', 'Red', 6, 6, 2, '1:1', 20, 'Effect Spore', 'Dry Skin', 'Damp', 29.5, 65, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 540 , 'Bug' , 'Bug', 'Grass', q'{Insectoid body}', 'Yellow' , 0, '1:1', 15, 'Swarm', 'Chlorophyll', 'Overcoat', 2.5, 5.5, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 165 , 'Bug' , 'Bug', 'Flying', q'{Single pair of wings}', 'Red', 9, 9, 0, '1:1', 15, 'Swarm', 'Early Bird', 'Rattled', 10.8, 23.8, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 127 , 'Bug' , 'Bug' , q'{Bipedal, tailless form}', 'Brown', 3, 3, 2, '1:1', 25, 'Hyper Cutter', 'Mold Breaker', 'Moxie', 55, 121.3, 1.5, 4, 11 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 493, q'|Type: Rock|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Multitype' , 320, 705.5, 3.2, 10, 6 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 29 , 'Monster', 'Field', 'Poison' , q'{Quadruped body}', 'Blue' , 2, '1:0', 20, 'Poison Point', 'Rivalry', 'Hustle', 7, 15.4, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 105 , 'Monster' , 'Ground' , q'{Bipedal, tailed form}', 'Brown', 3, 3, 0, '1:1', 20, 'Rock Head', 'Lightning Rod', 'Battle Armor', 45, 99.2, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 566 , 'Flying', 'Water 3', 'Rock', 'Flying', q'{Single pair of wings}', 'Yellow' , 0, '1:7', 30, 'Defeatist' , 9.5, 20.9, 0.6, 2, 0 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 282, q'|Mega|', 'M', q'|Gardevoirite|', 'Amorphous' , 'Psychic', 'Fairy', q'{Bipedal, tailless form}', 'White' , 0, '1:1', 20, 'Pixilate' , 48.4, 106.7, 1.6, 5, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 630 , 'Flying' , 'Dark', 'Flying', q'{Single pair of wings}', 'Brown', 6, 6, 0, '1:0', 20, 'Big Pecks', 'Overcoat', 'Weak Armor', 39.5, 87.1, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 337 , 'Mineral' , 'Rock', 'Psychic', q'{Head}', 'Yellow' , 0, 'G', 25, 'Levitate' , 168, 370.4, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 662 , 'Flying' , 'Fire', 'Flying', q'{Single pair of wings}', 'Red', 6, 6, 0, '1:1', 15, 'Flame Body' , 'Gale Wings', 16, 35.3, 0.7, 2, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 507 , 'Field' , 'Normal' , q'{Quadruped body}', 'Gray', 6, 6, 0, '1:1', 15, 'Intimidate', 'Sand Rush', 'Scrappy', 14.7, 32.4, 0.9, 2, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 113 , 'Fairy' , 'Normal' , q'{Bipedal, tailed form}', 'Pink', 0, 9, 0, '1:0', 40, 'Natural Cure', 'Serene Grace', 'Healer', 34.6, 76.3, 1.1, 3, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 56 , 'Field' , 'Fighting' , q'{Bipedal, tailed form}', 'Brown', 9, 9, 2, '1:1', 20, 'Vital Spirit', 'Anger Point', 'Defiant', 28, 61.7, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 1 , 'Monster', 'Grass', 'Grass', 'Poison', q'{Quadruped body}', 'Green' , 0, '1:7', 20, 'Overgrow' , 'Chlorophyll', 6.9, 15.2, 0.7, 2, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 470 , 'Field' , 'Grass' , q'{Quadruped body}', 'Green' , 0, '1:7', 35, 'Leaf Guard' , 'Chlorophyll', 25.5, 56.2, 1, 3, 3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 676, q'|Star Trim|' , 'Field' , 'Normal' , q'{Quadruped body}', 'White' , 6, 0, '1:1', 20, 'Fur Coat' , 28, 61.7, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 700 , 'Field' , 'Fairy' , q'{Quadruped body}', 'Pink' , 0, '1:7', 35, 'Cute Charm' , 'Pixilate', 23.5, 51.8, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 618 , 'Water 1', 'Amorphous', 'Ground', 'Electric', q'{Fins}', 'Brown' , 0, '1:1', 20, 'Static', 'Limber', 'Sand Veil', 11, 24.3, 0.7, 2, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 169 , 'Flying' , 'Poison', 'Flying', q'{Two or more pairs of wings}', 'Purple', 0, 0, 0, '1:1', 15, 'Inner Focus' , 'Infiltrator', 75, 165.3, 1.8, 5, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 721 , 'Undiscovered' , 'Fire', 'Water', q'{Quadruped body}', 'Brown' , 0, 'GU', 120, 'Water Absorb' , 195, 429.9, 1.7, 5, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 21 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Brown', 9, 9, 0, '1:1', 15, 'Keen Eye' , 'Sniper', 2, 4.4, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 583 , 'Mineral' , 'Ice' , q'{Head and a base}', 'White', 0, 0, 2, '1:1', 20, 'Ice Body', 'Snow Cloak', 'Weak Armor', 41, 90.4, 1.1, 3, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 43 , 'Grass' , 'Grass', 'Poison', q'{Head and legs}', 'Blue' , 0, '1:1', 20, 'Chlorophyll' , 'Run Away', 5.4, 11.9, 0.5, 1, 8 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 741, q'|Pa'u Style|' , 'Flying' , 'Fire', 'Flying', q'{Single pair of wings}', 'Pink', 6, 6, 0, '3:1', 20, 'Dancer' , 3.4, 7.5, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 268 , 'Bug' , 'Bug' , q'{Head}', 'Purple' , 0, '1:1', 15, 'Shed Skin' , 11.5, 25.4, 0.7, 2, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 329 , 'Bug' , 'Ground', 'Dragon', q'{Two or more pairs of wings}', 'Green', 6, 6, 0, '1:1', 20, 'Levitate' , 15.3, 33.7, 1.1, 3, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 762 , 'Grass' , 'Grass' , q'{Bipedal, tailless form}', 'Purple', 6, 6, 0, '1:0', 20, 'Leaf Guard', 'Oblivious', 'Sweet Veil', 8.2, 18.1, 0.7, 2, 4 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 773, q'|Type: Dragon|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'RKS System' , 100.5, 221.6, 2.3, 7, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 539 , 'Human-Like' , 'Fighting' , q'{Bipedal, tailless form}', 'Blue' , 0, '0:1', 20, 'Sturdy', 'Inner Focus', 'Mold Breaker', 51, 112.4, 1.4, 4, 7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 776 , 'Monster', 'Dragon', 'Fire', 'Dragon', q'{Bipedal, tailed form}', 'Red', 3, 3, 0, '1:1', 20, 'Shell Armor' , 212, 467.4, 2, 6, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 297 , 'Human-Like' , 'Fighting' , q'{Bipedal, tailless form}', 'Brown', 6, 6, 0, '1:3', 20, 'Thick Fat', 'Guts', 'Sheer Force', 253.8, 559.5, 2.3, 7, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 35 , 'Fairy' , 'Fairy' , q'{Bipedal, tailed form}', 'Pink', 6, 6, 2, '3:1', 10, 'Cute Charm', 'Magic Guard', 'Friend Guard', 7.5, 16.5, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 306 , 'Monster' , 'Steel', 'Rock', q'{Bipedal, tailed form}', 'Gray' , 0, '1:1', 35, 'Sturdy', 'Rock Head', 'Heavy Metal', 360, 793.7, 2.1, 6, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 183 , 'Water 1', 'Fairy', 'Water', 'Fairy', q'{Bipedal, tailed form}', 'Blue' , 0, '1:1', 10, 'Thick Fat', 'Huge Power', 'Sap Sipper', 8.5, 18.7, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 430 , 'Flying' , 'Dark', 'Flying', q'{Single pair of wings}', 'Black' , 0, '1:1', 20, 'Insomnia', 'Super Luck', 'Moxie', 27.3, 60.2, 0.9, 2, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 657 , 'Water 1' , 'Water' , q'{Bipedal, tailless form}', 'Blue' , 0, '1:7', 20, 'Torrent' , 'Protean', 10.9, 24, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 59 , 'Field' , 'Fire' , q'{Quadruped body}', 'Brown' , 0, '1:3', 20, 'Intimidate', 'Flash Fire', 'Justified', 155, 341.7, 1.9, 6, 3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 555, q'|Standard Mode|' , 'Field' , 'Fire' , q'{Quadruped body}', 'Red' , 0, '1:1', 20, 'Sheer Force' , 'Zen Mode', 92.9, 204.8, 1.3, 4, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 60 , 'Water 1' , 'Water' , q'{Head and legs}', 'Blue', 9, 9, 0, '1:1', 20, 'Water Absorb', 'Damp', 'Swift Swim', 12.4, 27.3, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 685 , 'Fairy' , 'Fairy' , q'{Bipedal, tailless form}', 'White' , 0, '1:1', 20, 'Sweet Veil' , 'Unburden', 5, 11, 0.8, 2, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 356 , 'Amorphous' , 'Ghost' , q'{Bipedal, tailless form}', 'Black' , 1, '1:1', 25, 'Pressure' , 'Frisk', 30.6, 67.5, 1.6, 5, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 654 , 'Field' , 'Fire' , q'{Bipedal, tailed form}', 'Red' , 0, '1:7', 20, 'Blaze' , 'Magician', 14.5, 32, 1, 3, 3 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 150, q'|Mega  X|', 'MX' , 'Undiscovered' , 'Psychic' , q'{Bipedal, tailed form}', 'Purple' , 0, 'GU', 120, 'Steadfast' , 122, 269, 2.3, 7, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 247 , 'Monster' , 'Rock', 'Ground', q'{Serpentine bodies}', 'Gray' , 9, 0, '1:1', 40, 'Shed Skin' , 152, 335.1, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 158 , 'Monster', 'Water 1', 'Water' , q'{Bipedal, tailed form}', 'Blue' , 0, '1:7', 20, 'Torrent' , 'Sheer Force', 9.5, 20.9, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 752 , 'Water 1', 'Bug', 'Water', 'Bug', q'{Insectoid body}', 'Green', 6, 6, 0, '1:1', 15, 'Water Bubble' , 'Water Absorb', 82, 180.8, 1.8, 5, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 25 , 'Field', 'Fairy', 'Electric' , q'{Quadruped body}', 'Yellow', 6, 6, 0, '1:1', 10, 'Static' , 'Lightning Rod', 6, 13.2, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 515 , 'Field' , 'Water' , q'{Bipedal, tailed form}', 'Blue' , 0, '1:7', 20, 'Gluttony' , 'Torrent', 13.5, 29.8, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 281 , 'Amorphous' , 'Psychic', 'Fairy', q'{Bipedal, tailless form}', 'White' , 0, '1:1', 20, 'Synchronize', 'Trace', 'Telepathy', 20.2, 44.5, 0.8, 2, 7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 275 , 'Field', 'Grass', 'Grass', 'Dark', q'{Bipedal, tailless form}', 'Brown' , 0, '1:1', 15, 'Chlorophyll', 'Early Bird', 'Pickpocket', 59.6, 131.4, 1.3, 4, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 517 , 'Field' , 'Psychic' , q'{Quadruped body}', 'Pink' , 0, '1:1', 10, 'Forewarn', 'Synchronize', 'Telepathy', 23.3, 51.4, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 339 , 'Water 2' , 'Water', 'Ground', q'{Fins}', 'Gray', 9, 9, 2, '1:1', 20, 'Oblivious', 'Anticipation', 'Hydration', 1.9, 4.2, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 324 , 'Field' , 'Fire' , q'{Quadruped body}', 'Brown', 6, 6, 2, '1:1', 20, 'White Smoke', 'Drought', 'Shell Armor', 80.4, 177.2, 0.5, 1, 8 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 26, q'|Alolan|', 'A' , 'Field', 'Fairy', 'Electric', 'Psychic', q'{Bipedal, tailed form}', 'Brown' , 0, '1:1', 10, 'Surge Surfer' , 30, 66.1, 0.7, 2, 4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 407 , 'Fairy', 'Grass', 'Grass', 'Poison', q'{Bipedal, tailless form}', 'Green' , 0, '1:1', 20, 'Natural Cure', 'Poison Point', 'Technician', 14.5, 32, 0.9, 2, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 251 , 'Undiscovered' , 'Psychic', 'Grass', q'{Bipedal, tailless form}', 'Green' , 0, 'GU', 120, 'Natural Cure' , 5, 11, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 264 , 'Field' , 'Normal' , q'{Quadruped body}', 'White' , 2, '1:1', 15, 'Pickup', 'Gluttony', 'Quick Feet', 32.5, 71.6, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 210 , 'Field', 'Fairy', 'Fairy' , q'{Bipedal, tailed form}', 'Purple', 6, 6, 2, '3:1', 20, 'Intimidate', 'Quick Feet', 'Rattled', 48.7, 107.4, 1.4, 4, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 523 , 'Field' , 'Electric' , q'{Quadruped body}', 'Black' , 0, '1:1', 20, 'Lightning Rod', 'Motor Drive', 'Sap Sipper', 79.5, 175.3, 1.6, 5, 3 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 428, q'|Mega|', 'M', q'|Lopunnite|', 'Field', 'Human-Like', 'Normal', 'Fighting', q'{Bipedal, tailed form}', 'Brown' , 6, 0, '1:1', 20, 'Scrappy' , 33.3, 73.4, 1.3, 4, 3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 418 , 'Water 1', 'Field', 'Water' , q'{Quadruped body}', 'Brown' , 0, '1:1', 20, 'Swift Swim' , 'Water Veil', 29.5, 65, 0.7, 2, 4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 580 , 'Water 1', 'Flying', 'Water', 'Flying', q'{Single pair of wings}', 'Blue' , 0, '1:1', 20, 'Keen Eye', 'Big Pecks', 'Hydration', 5.5, 12.1, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 355 , 'Amorphous' , 'Ghost' , q'{Head and arms}', 'Black' , 1, '1:1', 25, 'Levitate' , 'Frisk', 15, 33.1, 0.8, 2, 7 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 413, q'|Sandy Cloak|', 'G' , 'Bug' , 'Bug', 'Ground', q'{Head and a base}', 'Brown' , 0, '1:0', 15, 'Anticipation' , 'Overcoat', 6.5, 14.3, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 791 , 'Undiscovered' , 'Psychic', 'Steel', q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Full Metal Body' , 230, 507.1, 3.4, 11, 2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 232 , 'Field' , 'Ground' , q'{Quadruped body}', 'Gray' , 0, '1:1', 20, 'Sturdy' , 'Sand Veil', 120, 264.6, 1.1, 3, 7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 676, q'|La Reine Trim|' , 'Field' , 'Normal' , q'{Quadruped body}', 'White' , 6, 0, '1:1', 20, 'Fur Coat' , 28, 61.7, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 233 , 'Mineral' , 'Normal' , q'{Head and legs}', 'Red', 6, 6, 2, 'G', 20, 'Trace', 'Download', 'Analytic', 32.5, 71.6, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 633 , 'Dragon' , 'Dark', 'Dragon', q'{Quadruped body}', 'Blue' , 0, '1:1', 40, 'Hustle' , 17.3, 38.1, 0.8, 2, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 724 , 'Flying' , 'Grass', 'Ghost', q'{Single pair of wings}', 'Brown' , 0, '1:7', 15, 'Overgrow' , 'Long Reach', 36.6, 80.7, 1.6, 5, 3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 493, q'|Type: Poison|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Multitype' , 320, 705.5, 3.2, 10, 6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 120 , 'Water 3' , 'Water' , q'{Head and a base}', 'Brown', 9, 9, 0, 'G', 20, 'Illuminate', 'Natural Cure', 'Analytic', 34.5, 76.1, 0.8, 2, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 292 , 'Mineral' , 'Bug', 'Ghost', q'{Head and a base}', 'Brown' , 0, 'G', 15, 'Wonder Guard' , 1.2, 2.6, 0.8, 2, 7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 412, q'|Plant Cloak|' , 'Bug' , 'Bug' , q'{Head and a base}', 'Green' , 0, '1:1', 15, 'Shed Skin' , 'Overcoat', 3.4, 7.5, 0.2, 0, 8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 357 , 'Monster', 'Grass', 'Grass', 'Flying', q'{Quadruped body}', 'Green' , 3, 2, '1:1', 25, 'Chlorophyll', 'Solar Power', 'Harvest', 100, 220.5, 2, 6, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 579 , 'Amorphous' , 'Psychic' , q'{Head and arms}', 'Green' , 0, '1:1', 20, 'Overcoat', 'Magic Guard', 'Regenerator', 20.1, 44.3, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 485 , 'Undiscovered' , 'Fire', 'Steel', q'{Quadruped body}', 'Brown' , 0, '1:1U', 10, 'Flash Fire' , 'Flame Body', 430, 948, 1.7, 5, 7 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 642, q'|Therian Forme|', 'T' , 'Undiscovered' , 'Electric', 'Flying', q'{Bipedal, tailed form}', 'Blue' , 0, '0:1U', 120, 'Volt Absorb' , 61, 134.5, 3, 9, 10 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 51 , 'Field' , 'Ground' , q'{Multiple bodies}', 'Brown', 6, 6, 0, '1:1', 20, 'Sand Veil', 'Arena Trap', 'Sand Force', 33.3, 73.4, 0.7, 2, 4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 387 , 'Monster', 'Grass', 'Grass' , q'{Quadruped body}', 'Green' , 0, '1:7', 20, 'Overgrow' , 'Shell Armor', 10.2, 22.5, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 7 , 'Monster', 'Water 1', 'Water' , q'{Bipedal, tailed form}', 'Blue' , 0, '1:7', 20, 'Torrent' , 'Rain Dish', 9, 19.8, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 265 , 'Bug' , 'Bug' , q'{Insectoid body}', 'Red' , 0, '1:1', 15, 'Shield Dust' , 'Run Away', 3.6, 7.9, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 71 , 'Grass' , 'Grass', 'Poison', q'{Head and a base}', 'Green' , 0, '1:1', 20, 'Chlorophyll' , 'Gluttony', 15.5, 34.2, 1.7, 5, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 747 , 'Water 1' , 'Poison', 'Water', q'{Head and a base}', 'Blue', 0, 0, 0, '1:1', 20, 'Merciless', 'Limber', 'Regenerator', 8, 17.6, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 609 , 'Amorphous' , 'Ghost', 'Fire', q'{Head and arms}', 'Black' , 9, '1:1', 20, 'Flash Fire', 'Flame Body', 'Infiltrator', 34.3, 75.6, 1, 3, 3 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 487, q'|Origin Forme|', 'O' , 'Undiscovered' , 'Ghost', 'Dragon', q'{Tentacles or a multiped body}', 'Black' , 0, 'GU', 120, 'Levitate' , 650, 1433, 6.9, 22, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 640 , 'Undiscovered' , 'Grass', 'Fighting', q'{Quadruped body}', 'Green' , 0, 'GU', 80, 'Justified' , 200, 440.9, 2, 6, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 207 , 'Bug' , 'Ground', 'Flying', q'{Single pair of wings}', 'Purple' , 0, '1:1', 20, 'Hyper Cutter', 'Sand Veil', 'Immunity', 64.8, 142.9, 1.1, 3, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 792 , 'Undiscovered' , 'Psychic', 'Ghost', q'{Single pair of wings}', 'Purple' , 0, 'GU', 120, 'Shadow Shield' , 120, 264.6, 4, 13, 1 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 399 , 'Water 1', 'Field', 'Normal' , q'{Quadruped body}', 'Brown' , 0, '1:1', 15, 'Simple', 'Unaware', 'Moody', 20, 44.1, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 419 , 'Water 1', 'Field', 'Water' , q'{Quadruped body}', 'Brown' , 0, '1:1', 20, 'Swift Swim' , 'Water Veil', 33.5, 73.9, 1.1, 3, 7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 184 , 'Water 1', 'Fairy', 'Water', 'Fairy', q'{Bipedal, tailed form}', 'Blue' , 0, '1:1', 10, 'Thick Fat', 'Huge Power', 'Sap Sipper', 28.5, 62.8, 0.8, 2, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 656 , 'Water 1' , 'Water' , q'{Quadruped body}', 'Blue' , 0, '1:7', 20, 'Torrent' , 'Protean', 7, 15.4, 0.3, 1, 0 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 773, q'|Type: Ground|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'RKS System' , 100.5, 221.6, 2.3, 7, 7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 33 , 'Monster', 'Field', 'Poison' , q'{Quadruped body}', 'Purple' , 2, '0:1', 20, 'Poison Point', 'Rivalry', 'Hustle', 19.5, 43, 0.9, 2, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 175 , 'Undiscovered' , 'Fairy' , q'{Bipedal, tailless form}', 'White' , 0, '1:7U', 10, 'Hustle', 'Serene Grace', 'Super Luck', 1.5, 3.3, 0.3, 1, 0 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 15, q'|Mega|', 'M', q'|Beedrillite|', 'Bug' , 'Bug', 'Poison', q'{Two or more pairs of wings}', 'Yellow' , 0, '1:1', 15, 'Adaptability' , 29.5, 65, 1.4, 4, 7 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 422, q'|East Sea|', 'E' , 'Water 1', 'Amorphous', 'Water' , q'{Serpentine bodies}', 'Blue', 9, 9, 0, '1:1', 20, 'Sticky Hold', 'Storm Drain', 'Sand Force', 6.3, 13.9, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 163 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Brown' , 9, 0, '1:1', 15, 'Insomnia', 'Keen Eye', 'Tinted Lens', 21.2, 46.7, 0.7, 2, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 512 , 'Field' , 'Grass' , q'{Bipedal, tailed form}', 'Green' , 0, '1:7', 20, 'Gluttony' , 'Overgrow', 30.5, 67.2, 1.1, 3, 7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 130 , 'Water 2', 'Dragon', 'Water', 'Flying', q'{Serpentine bodies}', 'Blue', 3, 3, 0, '1:1', 5, 'Intimidate' , 'Moxie', 235, 518.1, 6.5, 21, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 736 , 'Bug' , 'Bug' , q'{Insectoid body}', 'Gray', 9, 9, 0, '1:1', 15, 'Swarm' , 4.4, 9.7, 0.4, 1, 4 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 386, q'|Defense Forme|', 'D' , 'Undiscovered' , 'Psychic' , q'{Bipedal, tailless form}', 'Red' , 0, 'GU', 120, 'Pressure' , 60.8, 134, 1.7, 5, 7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 3 , 'Monster', 'Grass', 'Grass', 'Poison', q'{Quadruped body}', 'Green' , 0, '1:7', 20, 'Overgrow' , 'Chlorophyll', 100, 220.5, 2, 6, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 520 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Gray' , 0, '1:1', 15, 'Big Pecks', 'Super Luck', 'Rivalry', 15, 33.1, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 216 , 'Field' , 'Normal' , q'{Bipedal, tailed form}', 'Brown' , 2, '1:1', 20, 'Pickup', 'Quick Feet', 'Honey Gather', 8.8, 19.4, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 511 , 'Field' , 'Grass' , q'{Bipedal, tailed form}', 'Green' , 0, '1:7', 20, 'Gluttony' , 'Overgrow', 10.5, 23.1, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 374 , 'Mineral' , 'Steel', 'Psychic', q'{Head and a base}', 'Blue', 9, 9, 0, 'G', 40, 'Clear Body' , 'Light Metal', 95.2, 209.9, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 152 , 'Monster', 'Grass', 'Grass' , q'{Quadruped body}', 'Green' , 0, '1:7', 20, 'Overgrow' , 'Leaf Guard', 6.4, 14.1, 0.9, 2, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 159 , 'Monster', 'Water 1', 'Water' , q'{Bipedal, tailed form}', 'Blue' , 0, '1:7', 20, 'Torrent' , 'Sheer Force', 25, 55.1, 1.1, 3, 7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 479, q'|Wash|' , 'Amorphous' , 'Electric', 'Ghost', q'{Head}', 'Red' , 0, 'G', 20, 'Levitate' , 0.3, 0.7, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 689 , 'Water 3' , 'Rock', 'Water', q'{Multiple bodies}', 'Brown' , 0, '1:1', 20, 'Sniper', 'Tough Claws', 'Pickpocket', 96, 211.6, 1.3, 4, 3 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 384, q'|Mega|', 'M', q'|Meteorite|', 'Undiscovered' , 'Dragon', 'Flying', q'{Serpentine bodies}', 'Green' , 0, 'GU', 120, 'Delta Stream' , 206.5, 455.2, 10.8, 35, 5 );
insert into SPECIES( DEX, CLASS , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 421, q'|Overcast Form|' , 'Fairy', 'Grass', 'Grass' , q'{Head and legs}', 'Purple' , 0, '1:1', 20, 'Flower Gift' , 9.3, 20.5, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 564 , 'Water 1', 'Water 3', 'Water', 'Rock', q'{Quadruped body}', 'Blue' , 0, '1:7', 30, 'Solid Rock', 'Sturdy', 'Swift Swim', 16.5, 36.4, 0.7, 2, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 782 , 'Dragon' , 'Dragon' , q'{Quadruped body}', 'Gray', 9, 9, 0, '1:1', 40, 'Bulletproof', 'Soundproof', 'Overcoat', 29.7, 65.5, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 723 , 'Flying' , 'Grass', 'Flying', q'{Single pair of wings}', 'Brown' , 0, '1:7', 15, 'Overgrow' , 'Long Reach', 16, 35.3, 0.7, 2, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 68 , 'Human-Like' , 'Fighting' , q'{Bipedal, tailless form}', 'Gray' , 2, '1:3', 20, 'Guts', 'No Guard', 'Steadfast', 130, 286.6, 1.6, 5, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 486 , 'Undiscovered' , 'Normal' , q'{Bipedal, tailless form}', 'White' , 0, 'GU', 120, 'Slow Start' , 420, 925.9, 3.7, 12, 2 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 719, q'|Mega|', 'M', q'|Diancite|', 'Undiscovered' , 'Rock', 'Fairy', q'{Head and arms}', 'Pink' , 0, 'GU', 25, 'Magic Bounce' , 8.8, 19.4, 1.1, 3, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 516 , 'Field' , 'Water' , q'{Bipedal, tailed form}', 'Blue' , 0, '1:7', 20, 'Gluttony' , 'Torrent', 29, 63.9, 1, 3, 3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 493, q'|Type: Psychic|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Multitype' , 320, 705.5, 3.2, 10, 6 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 493, q'|Type: Ghost|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Multitype' , 320, 705.5, 3.2, 10, 6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 668 , 'Field' , 'Fire', 'Normal', q'{Quadruped body}', 'Brown' , 6, 0, '7:1', 20, 'Rivalry', 'Unnerve', 'Moxie', 81.5, 179.7, 1.5, 4, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 173 , 'Undiscovered' , 'Fairy' , q'{Bipedal, tailed form}', 'Pink', 15, 15, 2, '3:1U', 10, 'Cute Charm', 'Magic Guard', 'Friend Guard', 3, 6.6, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 519 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Gray' , 0, '1:1', 15, 'Big Pecks', 'Super Luck', 'Rivalry', 2.1, 4.6, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 543 , 'Bug' , 'Bug', 'Poison', q'{Insectoid body}', 'Red' , 9, '1:1', 15, 'Poison Point', 'Swarm', 'Speed Boost', 5.3, 11.7, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 174 , 'Undiscovered' , 'Normal', 'Fairy', q'{Bipedal, tailless form}', 'Pink', 15, 15, 2, '3:1U', 10, 'Cute Charm', 'Competitive', 'Friend Guard', 1, 2.2, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 39 , 'Fairy' , 'Normal', 'Fairy', q'{Bipedal, tailless form}', 'Pink', 6, 6, 2, '3:1', 10, 'Cute Charm', 'Competitive', 'Friend Guard', 5.5, 12.1, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 565 , 'Water 1', 'Water 3', 'Water', 'Rock', q'{Bipedal, tailed form}', 'Blue' , 0, '1:7', 30, 'Solid Rock', 'Sturdy', 'Swift Swim', 81, 178.6, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 203 , 'Field' , 'Normal', 'Psychic', q'{Quadruped body}', 'Yellow' , 0, '1:1', 20, 'Inner Focus', 'Early Bird', 'Sap Sipper', 41.5, 91.5, 1.5, 4, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 764 , 'Grass' , 'Fairy' , q'{Head}', 'Green', 9, 9, 0, '3:1', 20, 'Flower Veil', 'Triage', 'Natural Cure', 0.3, 0.7, 0.1, 0, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 177 , 'Flying' , 'Psychic', 'Flying', q'{Single pair of wings}', 'Green' , 9, 0, '1:1', 20, 'Synchronize', 'Early Bird', 'Magic Bounce', 2, 4.4, 0.2, 0, 8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 139 , 'Water 1', 'Water 3', 'Rock', 'Water', q'{Tentacles or a multiped body}', 'Blue' , 0, '1:7', 30, 'Swift Swim', 'Shell Armor', 'Weak Armor', 35, 77.2, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 202 , 'Amorphous' , 'Psychic' , q'{Head and a base}', 'Blue' , 0, '1:1', 20, 'Shadow Tag' , 'Telepathy', 28.5, 62.8, 1.3, 4, 3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 670, q'|White Flower|' , 'Fairy' , 'Fairy' , q'{Head and arms}', 'White' , 0, 0, '1:0', 20, 'Flower Veil' , 'Symbiosis', 0.9, 2, 0.2, 0, 8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 112 , 'Monster', 'Field', 'Ground', 'Rock', q'{Bipedal, tailed form}', 'Gray' , 0, '1:1', 20, 'Lightning Rod', 'Rock Head', 'Reckless', 120, 264.6, 1.9, 6, 3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 694 , 'Monster', 'Dragon', 'Electric', 'Normal', q'{Bipedal, tailed form}', 'Yellow' , 0, '1:1', 20, 'Dry Skin', 'Sand Veil', 'Solar Power', 6, 13.2, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 571 , 'Field' , 'Dark' , q'{Bipedal, tailed form}', 'Gray' , 6, 0, '1:7', 20, 'Illusion' , 81.1, 178.8, 1.6, 5, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 424 , 'Field' , 'Normal' , q'{Bipedal, tailed form}', 'Purple' , 0, 0, '1:1', 20, 'Technician', 'Pickup', 'Skill Link', 20.3, 44.8, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 532 , 'Human-Like' , 'Fighting' , q'{Bipedal, tailless form}', 'Gray' , 0, '1:3', 20, 'Guts', 'Sheer Force', 'Iron Fist', 12.5, 27.6, 0.6, 2, 0 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 479, q'|Frost|' , 'Amorphous' , 'Electric', 'Ghost', q'{Head}', 'Red' , 0, 'G', 20, 'Levitate' , 0.3, 0.7, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 531 , 'Fairy' , 'Normal' , q'{Bipedal, tailed form}', 'Pink' , 0, '1:1', 20, 'Healer', 'Regenerator', 'Klutz', 31, 68.3, 1.1, 3, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 414 , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'Yellow' , 0, '0:1', 15, 'Swarm' , 'Tinted Lens', 23.3, 51.4, 0.9, 2, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 551 , 'Field' , 'Ground', 'Dark', q'{Quadruped body}', 'Brown', 9, 9, 0, '1:1', 20, 'Intimidate', 'Moxie', 'Anger Point', 15.2, 33.5, 0.7, 2, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 98 , 'Water 3' , 'Water' , q'{Insectoid body}', 'Red' , 0, '1:1', 20, 'Hyper Cutter', 'Shell Armor', 'Sheer Force', 6.5, 14.3, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 70 , 'Grass' , 'Grass', 'Poison', q'{Head and a base}', 'Green' , 0, '1:1', 20, 'Chlorophyll' , 'Gluttony', 6.4, 14.1, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 518 , 'Field' , 'Psychic' , q'{Bipedal, tailless form}', 'Pink' , 0, '1:1', 10, 'Forewarn', 'Synchronize', 'Telepathy', 60.5, 133.4, 1.1, 3, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 802 , 'Undiscovered' , 'Fighting', 'Ghost', q'{Bipedal, tailless form}', 'Gray' , 0, 'GU', 120, 'Technician' , 22.2, 48.9, 0.7, 2, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 726 , 'Field' , 'Fire' , q'{Quadruped body}', 'Red' , 0, '1:7', 15, 'Blaze' , 'Intimidate', 25, 55.1, 0.7, 2, 4 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 38, q'|Alolan|', 'A' , 'Field' , 'Ice', 'Fairy', q'{Quadruped body}', 'Blue' , 0, '3:1', 20, 'Snow Cloak' , 'Snow Warning', 19.9, 43.9, 1.1, 3, 7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 773, q'|Type: Psychic|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'RKS System' , 100.5, 221.6, 2.3, 7, 7 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 214, q'|Mega|', 'M', q'|Heracronite|', 'Bug' , 'Bug', 'Fighting', q'{Bipedal, tailless form}', 'Blue' , 3, 0, '1:1', 25, 'Skill Link' , 54, 119, 1.7, 5, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 425 , 'Amorphous' , 'Ghost', 'Flying', q'{Head and arms}', 'Purple', 9, 9, 0, '1:1', 30, 'Aftermath', 'Unburden', 'Flare Boost', 1.2, 2.6, 0.4, 1, 4 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 676, q'|Kabuki Trim|' , 'Field' , 'Normal' , q'{Quadruped body}', 'White' , 6, 0, '1:1', 20, 'Fur Coat' , 28, 61.7, 1.2, 3, 11 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 94, q'|Mega|', 'M', q'|Gengarite|', 'Amorphous' , 'Ghost', 'Poison', q'{Bipedal, tailed form}', 'Purple', 0, 0, 0, '1:1', 20, 'Shadow Tag' , 40.5, 89.3, 1.4, 4, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 280 , 'Amorphous' , 'Psychic', 'Fairy', q'{Bipedal, tailless form}', 'White' , 0, '1:1', 20, 'Synchronize', 'Trace', 'Telepathy', 6.6, 14.6, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 611 , 'Monster', 'Dragon', 'Dragon' , q'{Bipedal, tailed form}', 'Green' , 0, '1:1', 40, 'Rivalry', 'Mold Breaker', 'Unnerve', 36, 79.4, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 552 , 'Field' , 'Ground', 'Dark', q'{Quadruped body}', 'Brown', 6, 6, 0, '1:1', 20, 'Intimidate', 'Moxie', 'Anger Point', 33.4, 73.6, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 117 , 'Water 1', 'Dragon', 'Water' , q'{Head and a base}', 'Blue' , 2, '1:1', 20, 'Poison Point', 'Sniper', 'Damp', 25, 55.1, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 100 , 'Mineral' , 'Electric' , q'{Head}', 'Red' , 0, 'G', 20, 'Soundproof', 'Static', 'Aftermath', 10.4, 22.9, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 629 , 'Flying' , 'Dark', 'Flying', q'{Single pair of wings}', 'Brown', 9, 9, 0, '1:0', 20, 'Big Pecks', 'Overcoat', 'Weak Armor', 9, 19.8, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 393 , 'Water 1', 'Field', 'Water' , q'{Bipedal, tailless form}', 'Blue' , 0, '1:7', 20, 'Torrent' , 'Defiant', 5.2, 11.5, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 688 , 'Water 3' , 'Rock', 'Water', q'{Multiple bodies}', 'Brown' , 0, '1:1', 20, 'Sniper', 'Tough Claws', 'Pickpocket', 31, 68.3, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 480 , 'Undiscovered' , 'Psychic' , q'{Bipedal, tailed form}', 'Yellow' , 0, 'GU', 80, 'Levitate' , 0.3, 0.7, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 235 , 'Field' , 'Normal' , q'{Bipedal, tailed form}', 'White', 9, 9, 2, '1:1', 20, 'Own Tempo', 'Technician', 'Moody', 58, 127.9, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 317 , 'Amorphous' , 'Poison' , q'{Head and arms}', 'Purple' , 0, '1:1', 20, 'Liquid Ooze', 'Sticky Hold', 'Gluttony', 80, 176.4, 1.7, 5, 7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 286 , 'Fairy', 'Grass', 'Grass', 'Fighting', q'{Bipedal, tailed form}', 'Green' , 2, '1:1', 15, 'Effect Spore', 'Poison Heal', 'Technician', 39.2, 86.4, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 145 , 'Undiscovered' , 'Electric', 'Flying', q'{Single pair of wings}', 'Yellow' , 9, 'GU', 80, 'Pressure' , 'Static', 52.6, 116, 1.6, 5, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 257 , 'Field' , 'Fire', 'Fighting', q'{Bipedal, tailed form}', 'Red' , 0, '1:7', 20, 'Blaze' , 'Speed Boost', 52, 114.6, 1.9, 6, 3 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 359, q'|Mega|', 'M', q'|Absolite|', 'Field' , 'Dark' , q'{Quadruped body}', 'White', 3, 3, 0, '1:1', 25, 'Magic Bounce' , 47, 103.6, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 276 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Blue' , 0, '1:1', 15, 'Guts' , 'Scrappy', 2.3, 5.1, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 278 , 'Water 1', 'Flying', 'Water', 'Flying', q'{Single pair of wings}', 'White', 9, 9, 2, '1:1', 20, 'Keen Eye', 'Hydration', 'Rain Dish', 9.5, 20.9, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 677 , 'Field' , 'Psychic' , q'{Bipedal, tailed form}', 'Gray' , 0, '1:1', 20, 'Keen Eye', 'Infiltrator', 'Own Tempo', 3.5, 7.7, 0.3, 1, 0 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 642, q'|Incarnate Forme|' , 'Undiscovered' , 'Electric', 'Flying', q'{Head and arms}', 'Blue' , 0, '0:1U', 120, 'Prankster' , 'Defiant', 61, 134.5, 3, 9, 10 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 217 , 'Field' , 'Normal' , q'{Bipedal, tailed form}', 'Brown' , 2, '1:1', 20, 'Guts', 'Quick Feet', 'Unnerve', 125.8, 277.3, 1.8, 5, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 450 , 'Field' , 'Ground' , q'{Quadruped body}', 'Brown' , 0, '1:1', 30, 'Sand Stream' , 'Sand Force', 300, 661.4, 2, 6, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 18 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Brown' , 2, '1:1', 15, 'Keen Eye', 'Tangled Feet', 'Big Pecks', 39.5, 87.1, 1.5, 4, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 635 , 'Dragon' , 'Dark', 'Dragon', q'{Bipedal, tailed form}', 'Blue' , 0, '1:1', 40, 'Levitate' , 160, 352.7, 1.8, 5, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 663 , 'Flying' , 'Fire', 'Flying', q'{Single pair of wings}', 'Red' , 0, '1:1', 15, 'Flame Body' , 'Gale Wings', 24.5, 54, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 452 , 'Bug', 'Water 3', 'Poison', 'Dark', q'{Insectoid body}', 'Purple' , 0, '1:1', 20, 'Battle Armor', 'Sniper', 'Keen Eye', 61.5, 135.6, 1.3, 4, 3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 138 , 'Water 1', 'Water 3', 'Rock', 'Water', q'{Tentacles or a multiped body}', 'Blue' , 0, '1:7', 30, 'Swift Swim', 'Shell Armor', 'Weak Armor', 7.5, 16.5, 0.4, 1, 4 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 666, q'|Icy Snow Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 37.5, 1.2, 3, 11 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 741, q'|Sensu Style|' , 'Flying' , 'Fire', 'Flying', q'{Single pair of wings}', 'Purple', 6, 6, 0, '3:1', 20, 'Dancer' , 3.4, 7.5, 0.6, 2, 0 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 201, q'|One form|' , 'Undiscovered' , 'Psychic' , q'{Head}', 'Black' , 0, 'GU', 40, 'Levitate' , 5, 11, 0.5, 1, 8 );
insert into SPECIES( DEX, CLASS , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 25, q'|Cosplay|' , 'Field', 'Fairy', 'Electric' , q'{Quadruped body}', 'Yellow', 6, 6, 0, '1:1', 10, 'Static' , 'Lightning Rod', 6, 13.2, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 20 , 'Field' , 'Normal' , q'{Quadruped body}', 'Brown', 6, 6, 0, '1:1', 15, 'Run Away', 'Guts', 'Hustle', 18.5, 40.8, 0.7, 2, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 126 , 'Human-Like' , 'Fire' , q'{Bipedal, tailed form}', 'Red', 6, 6, 0, '1:3', 25, 'Flame Body' , 'Vital Spirit', 44.5, 98.1, 1.3, 4, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 198 , 'Flying' , 'Dark', 'Flying', q'{Single pair of wings}', 'Black', 9, 9, 2, '1:1', 20, 'Insomnia', 'Super Luck', 'Prankster', 2.1, 4.6, 0.5, 1, 8 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 586, q'|Summer Form|' , 'Field' , 'Normal', 'Grass', q'{Quadruped body}', 'Brown' , 0, '1:1', 20, 'Chlorophyll', 'Sap Sipper', 'Serene Grace', 92.5, 203.9, 1.9, 6, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 449 , 'Field' , 'Ground' , q'{Quadruped body}', 'Brown' , 0, '1:1', 30, 'Sand Stream' , 'Sand Force', 49.5, 109.1, 0.8, 2, 7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 187 , 'Fairy', 'Grass', 'Grass', 'Flying', q'{Bipedal, tailed form}', 'Pink' , 2, '1:1', 20, 'Chlorophyll', 'Leaf Guard', 'Infiltrator', 0.5, 1.1, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 401 , 'Bug' , 'Bug' , q'{Bipedal, tailless form}', 'Red' , 0, '1:1', 15, 'Shed Skin' , 'Run Away', 2.2, 4.9, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 97 , 'Human-Like' , 'Psychic' , q'{Bipedal, tailless form}', 'Yellow', 6, 6, 2, '1:1', 20, 'Insomnia', 'Forewarn', 'Inner Focus', 75.6, 166.7, 1.6, 5, 3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 666, q'|Fancy Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 37.5, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 693 , 'Water 1', 'Water 3', 'Water' , q'{Serpentine bodies}', 'Blue' , 6, 0, '1:1', 15, 'Mega Launcher' , 35.3, 77.8, 1.3, 4, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 651 , 'Field' , 'Grass' , q'{Bipedal, tailed form}', 'Green' , 0, '1:7', 20, 'Overgrow' , 'Bulletproof', 29, 63.9, 0.7, 2, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 655 , 'Field' , 'Fire', 'Psychic', q'{Bipedal, tailed form}', 'Red' , 0, '1:7', 20, 'Blaze' , 'Magician', 39, 86, 1.5, 4, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 115 , 'Monster' , 'Normal' , q'{Bipedal, tailed form}', 'Brown', 3, 3, 2, '1:0', 20, 'Early Bird', 'Scrappy', 'Inner Focus', 80, 176.4, 2.2, 7, 3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 666, q'|Jungle Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 37.5, 1.2, 3, 11 );
insert into SPECIES( DEX, CLASS , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 25, q'|Libre|' , 'Field', 'Fairy', 'Electric' , q'{Quadruped body}', 'Yellow', 6, 6, 0, '1:1', 10, 'Static' , 'Lightning Rod', 6, 13.2, 0.4, 1, 4 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 644, q'|Overdrive mode|' , 'Undiscovered' , 'Dragon', 'Electric', q'{Bipedal, tailed form}', 'Black' , 0, 'GU', 120, 'Teravolt' , 345, 760.6, 2.9, 9, 6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 806 , 'Undiscovered' , 'Fire', 'Ghost', q'{Bipedal, tailless form}', 'White' , 0, 'GU', 120, 'Beast Boost' , 13, 28.7, 1.8, 5, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 722 , 'Flying' , 'Grass', 'Flying', q'{Single pair of wings}', 'Brown' , 0, '1:7', 15, 'Overgrow' , 'Long Reach', 1.5, 3.3, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 151 , 'Undiscovered' , 'Psychic' , q'{Bipedal, tailed form}', 'Pink' , 0, 'GU', 120, 'Synchronize' , 4, 8.8, 0.4, 1, 4 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 412, q'|Trash Cloak|', 'S' , 'Bug' , 'Bug' , q'{Head and a base}', 'Green' , 0, '1:1', 15, 'Shed Skin' , 'Overcoat', 3.4, 7.5, 0.2, 0, 8 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 666, q'|Monsoon Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 37.5, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 684 , 'Fairy' , 'Fairy' , q'{Head and legs}', 'White' , 0, '1:1', 20, 'Sweet Veil' , 'Unburden', 3.5, 7.7, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 457 , 'Water 2' , 'Water' , q'{Fins}', 'Blue', 6, 6, 0, '1:1', 20, 'Swift Swim', 'Storm Drain', 'Water Veil', 24, 52.9, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 15 , 'Bug' , 'Bug', 'Poison', q'{Two or more pairs of wings}', 'Yellow' , 0, '1:1', 15, 'Swarm' , 'Sniper', 29.5, 65, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 134 , 'Field' , 'Water' , q'{Quadruped body}', 'Blue' , 0, '1:7', 35, 'Water Absorb' , 'Hydration', 29, 63.9, 1, 3, 3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 670, q'|Orange Flower|' , 'Fairy' , 'Fairy' , q'{Head and arms}', 'White' , 0, 0, '1:0', 20, 'Flower Veil' , 'Symbiosis', 0.9, 2, 0.2, 0, 8 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 6, q'|Mega  X|', 'MX' , 'Monster', 'Dragon', 'Fire', 'Flying', q'{Bipedal, tailed form}', 'Black' , 0, '1:7', 20, 'Tough Claws' , 90.5, 199.5, 1.7, 5, 7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 493, q'|Type: Fairy|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Multitype' , 320, 705.5, 3.2, 10, 6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 244 , 'Undiscovered' , 'Fire' , q'{Quadruped body}', 'Brown' , 8, 'GU', 80, 'Pressure' , 'Inner Focus', 198, 436.5, 2.1, 6, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 524 , 'Mineral' , 'Rock' , q'{Head and legs}', 'Blue', 9, 9, 2, '1:1', 15, 'Sturdy', 'Weak Armor', 'Sand Force', 18, 39.7, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 526 , 'Mineral' , 'Rock' , q'{Tentacles or a multiped body}', 'Blue' , 2, '1:1', 15, 'Sturdy', 'Sand Stream', 'Sand Force', 260, 573.2, 1.7, 5, 7 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 448, q'|Mega|', 'M', q'|Lucarionite|', 'Field', 'Human-Like', 'Fighting', 'Steel', q'{Bipedal, tailed form}', 'Blue', 0, 0, 0, '1:7', 25, 'Adaptability' , 54, 119, 1.3, 4, 3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 697 , 'Monster', 'Dragon', 'Rock', 'Dragon', q'{Bipedal, tailed form}', 'Red' , 0, '1:7', 30, 'Strong Jaw' , 'Rock Head', 270, 595.2, 2.5, 8, 2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 584 , 'Mineral' , 'Ice' , q'{Multiple bodies}', 'White' , 0, 2, '1:1', 20, 'Ice Body', 'Snow Warning', 'Weak Armor', 57.5, 126.8, 1.3, 4, 3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 586, q'|Spring Form|' , 'Field' , 'Normal', 'Grass', q'{Quadruped body}', 'Brown' , 0, '1:1', 20, 'Chlorophyll', 'Sap Sipper', 'Serene Grace', 92.5, 203.9, 1.9, 6, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 553 , 'Field' , 'Ground', 'Dark', q'{Bipedal, tailed form}', 'Red' , 0, '1:1', 20, 'Intimidate', 'Moxie', 'Anger Point', 96.3, 212.3, 1.5, 4, 11 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 105, q'|Alolan|', 'A' , 'Monster' , 'Fire', 'Ghost', q'{Bipedal, tailed form}', 'Purple', 3, 3, 0, '1:1', 20, 'Cursed Body', 'Lightning Rod', 'Rock Head', 45, 99.2, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 490 , 'Water 1', 'Fairy', 'Water' , q'{Bipedal, tailless form}', 'Blue' , 0, 'G', 10, 'Hydration' , 1.4, 3.1, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 368 , 'Water 1' , 'Water' , q'{Serpentine bodies}', 'Pink' , 0, 0, '1:1', 20, 'Swift Swim' , 'Hydration', 22.6, 49.8, 1.8, 5, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 469 , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'Green' , 0, '1:1', 20, 'Speed Boost', 'Tinted Lens', 'Frisk', 51.5, 113.5, 1.9, 6, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 514 , 'Field' , 'Fire' , q'{Bipedal, tailed form}', 'Red' , 0, '1:7', 20, 'Gluttony' , 'Blaze', 28, 61.7, 1, 3, 3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 669, q'|White Flower|' , 'Fairy' , 'Fairy' , q'{Head and arms}', 'White' , 15, 0, '1:0', 20, 'Flower Veil' , 'Symbiosis', 0.1, 0.2, 0.1, 0, 4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 777 , 'Field', 'Fairy', 'Electric', 'Steel', q'{Bipedal, tailed form}', 'Gray', 9, 9, 0, '1:1', 10, 'Iron Barbs', 'Lightning Rod', 'Sturdy', 3.3, 7.3, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 212 , 'Bug' , 'Bug', 'Steel', q'{Two or more pairs of wings}', 'Red' , 2, '1:1', 25, 'Swarm', 'Technician', 'Light Metal', 118, 260.1, 1.8, 5, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 253 , 'Monster', 'Dragon', 'Grass' , q'{Bipedal, tailed form}', 'Green' , 0, '1:7', 20, 'Overgrow' , 'Unburden', 21.6, 47.6, 0.9, 2, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 191 , 'Grass' , 'Grass' , q'{Head}', 'Yellow' , 2, '1:1', 20, 'Chlorophyll', 'Solar Power', 'Early Bird', 1.8, 4, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 372 , 'Dragon' , 'Dragon' , q'{Quadruped body}', 'White', 6, 6, 0, '1:1', 40, 'Rock Head' , 'Overcoat', 110.5, 243.6, 1.1, 3, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 623 , 'Mineral' , 'Ground', 'Ghost', q'{Bipedal, tailless form}', 'Green' , 15, 0, 'G', 25, 'Iron Fist', 'Klutz', 'No Guard', 330, 727.5, 2.8, 9, 2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 733 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Black' , 0, 0, '1:1', 15, 'Keen Eye', 'Skill Link', 'Sheer Force', 26, 57.3, 1.1, 3, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 607 , 'Amorphous' , 'Ghost', 'Fire', q'{Head and a base}', 'White' , 9, '1:1', 20, 'Flash Fire', 'Flame Body', 'Infiltrator', 3.1, 6.8, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 525 , 'Mineral' , 'Rock' , q'{Tentacles or a multiped body}', 'Blue', 6, 6, 2, '1:1', 15, 'Sturdy', 'Weak Armor', 'Sand Force', 102, 224.9, 0.9, 2, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 220 , 'Field' , 'Ice', 'Ground', q'{Quadruped body}', 'Brown' , 2, '1:1', 20, 'Oblivious', 'Snow Cloak', 'Thick Fat', 6.5, 14.3, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 116 , 'Water 1', 'Dragon', 'Water' , q'{Head and a base}', 'Blue' , 2, '1:1', 20, 'Swift Swim', 'Sniper', 'Damp', 8, 17.6, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 208 , 'Mineral' , 'Steel', 'Ground', q'{Serpentine bodies}', 'Gray' , 0, '1:1', 25, 'Rock Head', 'Sturdy', 'Sheer Force', 400, 881.8, 9.2, 30, 2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 263 , 'Field' , 'Normal' , q'{Quadruped body}', 'Brown' , 2, '1:1', 15, 'Pickup', 'Gluttony', 'Quick Feet', 17.5, 38.6, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 307 , 'Human-Like' , 'Fighting', 'Psychic', q'{Bipedal, tailless form}', 'Blue' , 0, '1:1', 20, 'Pure Power' , 'Telepathy', 11.2, 24.7, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 231 , 'Field' , 'Ground' , q'{Quadruped body}', 'Blue' , 0, '1:1', 20, 'Pickup' , 'Sand Veil', 33.5, 73.9, 0.5, 1, 8 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 586, q'|Autumn Form|' , 'Field' , 'Normal', 'Grass', q'{Quadruped body}', 'Brown' , 0, '1:1', 20, 'Chlorophyll', 'Sap Sipper', 'Serene Grace', 92.5, 203.9, 1.9, 6, 3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 728 , 'Water 1', 'Field', 'Water' , q'{Fins}', 'Blue' , 0, '1:7', 15, 'Torrent' , 'Liquid Voice', 7.5, 16.5, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 259 , 'Monster', 'Water 1', 'Water', 'Ground', q'{Bipedal, tailed form}', 'Blue' , 0, '1:7', 20, 'Torrent' , 'Damp', 28, 61.7, 0.7, 2, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 800 , 'Undiscovered' , 'Psychic' , q'{Head and arms}', 'Black' , 0, 'GU', 120, 'Prism Armor' , 230, 507.1, 4.2, 13, 9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 146 , 'Undiscovered' , 'Fire', 'Flying', q'{Single pair of wings}', 'Yellow' , 0, 'GU', 80, 'Pressure' , 'Flame Body', 60, 132.3, 2, 6, 7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 493, q'|Type: Electric|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Multitype' , 320, 705.5, 3.2, 10, 6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 456 , 'Water 2' , 'Water' , q'{Fins}', 'Blue', 9, 9, 0, '1:1', 20, 'Swift Swim', 'Storm Drain', 'Water Veil', 7, 15.4, 0.4, 1, 4 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 9, q'|Mega|', 'M', q'|Blastoisinite|', 'Monster', 'Water 1', 'Water' , q'{Bipedal, tailed form}', 'Blue' , 0, '1:7', 20, 'Mega Launcher' , 85.5, 188.5, 1.6, 5, 3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 395 , 'Water 1', 'Field', 'Water', 'Steel', q'{Bipedal, tailed form}', 'Blue' , 0, '1:7', 20, 'Torrent' , 'Defiant', 84.5, 186.3, 1.7, 5, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 236 , 'Undiscovered' , 'Fighting' , q'{Bipedal, tailless form}', 'Purple' , 2, '0:1U', 25, 'Guts', 'Steadfast', 'Vital Spirit', 21, 46.3, 0.7, 2, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 447 , 'Undiscovered' , 'Fighting' , q'{Bipedal, tailed form}', 'Blue', 15, 15, 0, '1:7U', 25, 'Steadfast', 'Inner Focus', 'Prankster', 20.2, 44.5, 0.7, 2, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 382 , 'Undiscovered' , 'Water' , q'{Fins}', 'Blue' , 0, 'GU', 120, 'Drizzle' , 352, 776, 4.5, 14, 9 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 209 , 'Field', 'Fairy', 'Fairy' , q'{Bipedal, tailless form}', 'Pink', 9, 9, 0, '3:1', 20, 'Intimidate', 'Run Away', 'Rattled', 7.8, 17.2, 0.6, 2, 0 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 386, q'|Normal Forme|' , 'Undiscovered' , 'Psychic' , q'{Bipedal, tailless form}', 'Red' , 0, 'GU', 120, 'Pressure' , 60.8, 134, 1.7, 5, 7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 400 , 'Water 1', 'Field', 'Normal', 'Water', q'{Bipedal, tailed form}', 'Brown' , 0, '1:1', 15, 'Simple', 'Unaware', 'Moody', 31.5, 69.4, 1, 3, 3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 773, q'|Type: Bug|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'RKS System' , 100.5, 221.6, 2.3, 7, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 90 , 'Water 3' , 'Water' , q'{Head}', 'Purple', 9, 9, 2, '1:1', 20, 'Shell Armor', 'Skill Link', 'Overcoat', 4, 8.8, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 578 , 'Amorphous' , 'Psychic' , q'{Head}', 'Green' , 0, '1:1', 20, 'Overcoat', 'Magic Guard', 'Regenerator', 8, 17.6, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 757 , 'Monster', 'Dragon', 'Poison', 'Fire', q'{Quadruped body}', 'Black', 9, 9, 0, '1:7', 20, 'Corrosion' , 'Oblivious', 4.8, 10.6, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 402 , 'Bug' , 'Bug' , q'{Two or more pairs of wings}', 'Red' , 0, '1:1', 15, 'Swarm' , 'Technician', 25.5, 56.2, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 170 , 'Water 2' , 'Water', 'Electric', q'{Fins}', 'Blue', 9, 9, 0, '1:1', 20, 'Volt Absorb', 'Illuminate', 'Water Absorb', 12, 26.5, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 23 , 'Field', 'Dragon', 'Poison' , q'{Serpentine bodies}', 'Purple' , 9, 0, '1:1', 20, 'Intimidate', 'Shed Skin', 'Unnerve', 6.9, 15.2, 2, 6, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 744 , 'Field' , 'Rock' , q'{Quadruped body}', 'Brown', 9, 9, 0, '1:1', 15, 'Keen Eye', 'Vital Spirit', 'Steadfast', 9.2, 20.3, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 89 , 'Amorphous' , 'Poison' , q'{Head and arms}', 'Purple', 6, 6, 0, '1:1', 20, 'Stench', 'Sticky Hold', 'Poison Touch', 30, 66.1, 1.2, 3, 11 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 257, q'|Mega|', 'M', q'|Blazikenite|', 'Field' , 'Fire', 'Fighting', q'{Bipedal, tailed form}', 'Red' , 0, '1:7', 20, 'Speed Boost' , 52, 114.6, 1.9, 6, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 483 , 'Undiscovered' , 'Steel', 'Dragon', q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Pressure' , 'Telepathy', 683, 1505.8, 5.4, 17, 9 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 562 , 'Mineral', 'Amorphous', 'Ghost' , q'{Head and arms}', 'Black' , 0, '1:1', 25, 'Mummy' , 1.5, 3.3, 0.5, 1, 8 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 493, q'|Type: Grass|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Multitype' , 320, 705.5, 3.2, 10, 6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 472 , 'Bug' , 'Ground', 'Flying', q'{Single pair of wings}', 'Purple' , 0, '1:1', 20, 'Hyper Cutter', 'Sand Veil', 'Poison Heal', 42.5, 93.7, 2, 6, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 93 , 'Amorphous' , 'Ghost', 'Poison', q'{Head and arms}', 'Purple', 6, 6, 0, '1:1', 20, 'Levitate' , 0.1, 0.2, 1.6, 5, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 214 , 'Bug' , 'Bug', 'Fighting', q'{Bipedal, tailless form}', 'Blue' , 3, 0, '1:1', 25, 'Swarm', 'Guts', 'Moxie', 54, 119, 1.5, 4, 11 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 778, q'|Busted Form|' , 'Amorphous' , 'Ghost', 'Fairy', q'{Serpentine bodies}', 'Yellow', 9, 9, 0, '1:1', 20, 'Disguise' , 0.7, 1.5, 0.2, 0, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 379 , 'Undiscovered' , 'Steel' , q'{Bipedal, tailless form}', 'Gray' , 0, 'GU', 80, 'Clear Body' , 'Light Metal', 205, 451.9, 1.9, 6, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 312 , 'Fairy' , 'Electric' , q'{Bipedal, tailed form}', 'Yellow' , 1, '1:1', 20, 'Minus' , 'Volt Absorb', 4.2, 9.3, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 780 , 'Monster', 'Dragon', 'Normal', 'Dragon', q'{Serpentine bodies}', 'White', 3, 3, 0, '1:1', 20, 'Berserk', 'Sap Sipper', 'Cloud Nine', 185, 407.9, 3, 9, 10 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 599 , 'Mineral' , 'Steel' , q'{Multiple bodies}', 'Gray' , 0, 'G', 20, 'Plus', 'Minus', 'Clear Body', 21, 46.3, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 383 , 'Undiscovered' , 'Ground' , q'{Bipedal, tailed form}', 'Red' , 0, 'GU', 120, 'Drought' , 950, 2094.4, 3.5, 11, 6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 415 , 'Bug' , 'Bug', 'Flying', q'{Multiple bodies}', 'Yellow' , 0, '1:7', 15, 'Honey Gather' , 'Hustle', 5.5, 12.1, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 596 , 'Bug' , 'Bug', 'Electric', q'{Insectoid body}', 'Yellow' , 0, '1:1', 20, 'Compound Eyes', 'Unnerve', 'Swarm', 14.3, 31.5, 0.8, 2, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 91 , 'Water 3' , 'Water', 'Ice', q'{Head}', 'Purple' , 2, '1:1', 20, 'Shell Armor', 'Skill Link', 'Overcoat', 132.5, 292.1, 1.5, 4, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 95 , 'Mineral' , 'Rock', 'Ground', q'{Serpentine bodies}', 'Gray' , 0, '1:1', 25, 'Rock Head', 'Sturdy', 'Weak Armor', 210, 463, 8.8, 28, 10 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 761 , 'Grass' , 'Grass' , q'{Head and legs}', 'Purple', 9, 9, 0, '1:0', 20, 'Leaf Guard', 'Oblivious', 'Sweet Veil', 3.2, 7.1, 0.3, 1, 0 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 413, q'|Plant Cloak|' , 'Bug' , 'Bug', 'Grass', q'{Head and a base}', 'Green' , 0, '1:0', 15, 'Anticipation' , 'Overcoat', 6.5, 14.3, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 443 , 'Monster', 'Dragon', 'Dragon', 'Ground', q'{Bipedal, tailed form}', 'Blue' , 0, '1:1', 40, 'Sand Veil' , 'Rough Skin', 20.5, 45.2, 0.7, 2, 4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 333 , 'Flying', 'Dragon', 'Normal', 'Flying', q'{Single pair of wings}', 'Blue' , 0, '1:1', 20, 'Natural Cure' , 'Cloud Nine', 1.2, 2.6, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 548 , 'Grass' , 'Grass' , q'{Head and a base}', 'Green', 9, 9, 0, '1:0', 20, 'Chlorophyll', 'Own Tempo', 'Leaf Guard', 6.6, 14.6, 0.5, 1, 8 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 792, q'|Full Moon phase|' , 'Undiscovered' , 'Psychic', 'Ghost', q'{Single pair of wings}', 'Purple' , 0, 'GU', 120, 'Shadow Shield' , 120, 264.6, 4, 13, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 237 , 'Human-Like' , 'Fighting' , q'{Bipedal, tailed form}', 'Brown' , 2, '0:1', 25, 'Intimidate', 'Technician', 'Steadfast', 48, 105.8, 1.4, 4, 7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 25, q'|Rock Star|' , 'Field', 'Fairy', 'Electric' , q'{Quadruped body}', 'Yellow', 6, 6, 0, '1:1', 10, 'Static' , 'Lightning Rod', 6, 13.2, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 350 , 'Water 1', 'Dragon', 'Water' , q'{Serpentine bodies}', 'Pink' , 2, '1:1', 20, 'Marvel Scale', 'Competitive', 'Cute Charm', 162, 357.1, 6.2, 20, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 713 , 'Monster' , 'Ice' , q'{Quadruped body}', 'Blue' , 0, '1:1', 20, 'Own Tempo', 'Ice Body', 'Sturdy', 505, 1113.3, 2, 6, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 14 , 'Bug' , 'Bug', 'Poison', q'{Serpentine bodies}', 'Yellow' , 0, '1:1', 15, 'Shed Skin' , 10, 22, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 604 , 'Amorphous' , 'Electric' , q'{Fins}', 'Blue' , 0, '1:1', 20, 'Levitate' , 80.5, 177.5, 2.1, 6, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 743 , 'Bug', 'Fairy', 'Bug', 'Fairy', q'{Two or more pairs of wings}', 'Yellow', 6, 6, 0, '1:1', 20, 'Honey Gather', 'Shield Dust', 'Sweet Veil', 0.5, 1.1, 0.2, 0, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 683 , 'Fairy' , 'Fairy' , q'{Bipedal, tailless form}', 'Pink' , 0, '1:1', 20, 'Healer' , 'Aroma Veil', 15.5, 34.2, 0.8, 2, 7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 279 , 'Water 1', 'Flying', 'Water', 'Flying', q'{Single pair of wings}', 'Yellow', 6, 6, 2, '1:1', 20, 'Keen Eye', 'Drizzle', 'Rain Dish', 28, 61.7, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 758 , 'Monster', 'Dragon', 'Poison', 'Fire', q'{Quadruped body}', 'Black', 15, 15, 0, '1:0', 20, 'Corrosion' , 'Oblivious', 22.2, 48.9, 1.2, 3, 11 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 666, q'|Elegant Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 37.5, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 111 , 'Monster', 'Field', 'Ground', 'Rock', q'{Quadruped body}', 'Gray' , 0, '1:1', 20, 'Lightning Rod', 'Rock Head', 'Reckless', 115, 253.5, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 366 , 'Water 1' , 'Water' , q'{Head}', 'Blue' , 15, 0, '1:1', 20, 'Shell Armor' , 'Rattled', 52.5, 115.7, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 34 , 'Monster', 'Field', 'Poison', 'Ground', q'{Bipedal, tailed form}', 'Purple' , 2, '0:1', 20, 'Poison Point', 'Rivalry', 'Sheer Force', 62, 136.7, 1.4, 4, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 617 , 'Bug' , 'Bug' , q'{Head and arms}', 'Red' , 0, '1:1', 15, 'Hydration', 'Sticky Hold', 'Unburden', 25.3, 55.8, 0.8, 2, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 397 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Brown' , 0, '1:1', 15, 'Intimidate' , 'Reckless', 15.5, 34.2, 0.6, 2, 0 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 492, q'|Land Forme|' , 'Undiscovered' , 'Grass' , q'{Quadruped body}', 'Green' , 0, 'GU', 120, 'Natural Cure' , 2.1, 4.6, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 9 , 'Monster', 'Water 1', 'Water' , q'{Bipedal, tailed form}', 'Blue' , 0, '1:7', 20, 'Torrent' , 'Rain Dish', 85.5, 188.5, 1.6, 5, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 433 , 'Undiscovered' , 'Psychic' , q'{Bipedal, tailless form}', 'Yellow' , 0, '1:1U', 25, 'Levitate' , 0.6, 1.3, 0.2, 0, 8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 559 , 'Field', 'Dragon', 'Dark', 'Fighting', q'{Bipedal, tailed form}', 'Yellow' , 9, 0, '1:1', 15, 'Shed Skin', 'Moxie', 'Intimidate', 11.8, 26, 0.6, 2, 0 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 681, q'|Shield Forme|' , 'Mineral' , 'Steel', 'Ghost', q'{Head and a base}', 'Brown' , 0, '1:1', 20, 'Stance Change' , 53, 116.8, 1.7, 5, 7 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 80, q'|Mega|', 'M', q'|Slowbronite|', 'Monster', 'Water 1', 'Water', 'Psychic', q'{Bipedal, tailed form}', 'Pink', 3, 3, 0, '1:1', 20, 'Shell Armor' , 78.5, 173.1, 2, 6, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 309 , 'Field' , 'Electric' , q'{Quadruped body}', 'Green' , 9, 0, '1:1', 20, 'Static', 'Lightning Rod', 'Minus', 15.2, 33.5, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 691 , 'Water 1', 'Dragon', 'Poison', 'Dragon', q'{Head and a base}', 'Brown' , 6, 0, '1:1', 20, 'Poison Point', 'Poison Touch', 'Adaptability', 81.5, 179.7, 1.8, 5, 11 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 778, q'|Disguised Form|' , 'Amorphous' , 'Ghost', 'Fairy', q'{Serpentine bodies}', 'Yellow', 9, 9, 0, '1:1', 20, 'Disguise' , 0.7, 1.5, 0.2, 0, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 476 , 'Mineral' , 'Rock', 'Steel', q'{Multiple bodies}', 'Gray' , 0, '1:1', 20, 'Sturdy', 'Magnet Pull', 'Sand Force', 340, 749.6, 1.4, 4, 7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 641, q'|Incarnate Forme|' , 'Undiscovered' , 'Flying' , q'{Head and arms}', 'Green' , 0, '0:1U', 120, 'Prankster' , 'Defiant', 63, 138.9, 1.4, 4, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 727 , 'Field' , 'Fire', 'Dark', q'{Bipedal, tailed form}', 'Red' , 0, '1:7', 15, 'Blaze' , 'Intimidate', 83, 183, 1.8, 5, 11 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 647, q'|Resolute Form|' , 'Undiscovered' , 'Water', 'Fighting', q'{Quadruped body}', 'Yellow' , 0, 'GU', 80, 'Justified' , 48.5, 106.9, 1.4, 4, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 108 , 'Monster' , 'Normal' , q'{Bipedal, tailed form}', 'Pink' , 3, 0, '1:1', 20, 'Own Tempo', 'Oblivious', 'Cloud Nine', 65.5, 144.4, 1.2, 3, 11 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 142, q'|Mega|', 'M', q'|Aerodactylite|', 'Flying' , 'Rock', 'Flying', q'{Single pair of wings}', 'Purple' , 0, '1:7', 35, 'Tough Claws' , 59, 130.1, 2.1, 6, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 406 , 'Undiscovered' , 'Grass', 'Poison', q'{Bipedal, tailless form}', 'Green' , 0, '1:1U', 20, 'Natural Cure', 'Poison Point', 'Leaf Guard', 1.2, 2.6, 0.2, 0, 8 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 127, q'|Mega|', 'M', q'|Pinsirite|', 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'Brown', 3, 3, 0, '1:1', 25, 'Aerilate' , 55, 121.3, 1.7, 5, 7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 581 , 'Water 1', 'Flying', 'Water', 'Flying', q'{Single pair of wings}', 'White' , 0, '1:1', 20, 'Keen Eye', 'Big Pecks', 'Hydration', 24.2, 53.4, 1.3, 4, 3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 55 , 'Water 1', 'Field', 'Water' , q'{Bipedal, tailed form}', 'Blue', 6, 6, 0, '1:1', 20, 'Damp', 'Cloud Nine', 'Swift Swim', 76.6, 168.9, 1.7, 5, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 759 , 'Field' , 'Normal', 'Fighting', q'{Quadruped body}', 'Pink', 9, 9, 0, '1:1', 15, 'Fluffy', 'Klutz', 'Cute Charm', 6.8, 15, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 467 , 'Human-Like' , 'Fire' , q'{Bipedal, tailed form}', 'Red' , 0, '1:3', 25, 'Flame Body' , 'Vital Spirit', 68, 149.9, 1.6, 5, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 41 , 'Flying' , 'Poison', 'Flying', q'{Single pair of wings}', 'Purple', 15, 15, 0, '1:1', 15, 'Inner Focus' , 'Infiltrator', 7.5, 16.5, 0.8, 2, 7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 32 , 'Monster', 'Field', 'Poison' , q'{Quadruped body}', 'Purple' , 2, '0:1', 20, 'Poison Point', 'Rivalry', 'Hustle', 9, 19.8, 0.5, 1, 8 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 386, q'|Attack Forme|', 'A' , 'Undiscovered' , 'Psychic' , q'{Bipedal, tailless form}', 'Red' , 0, 'GU', 120, 'Pressure' , 60.8, 134, 1.7, 5, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 103 , 'Grass' , 'Grass', 'Psychic', q'{Head and legs}', 'Yellow', 0, 0, 0, '1:1', 20, 'Chlorophyll' , 'Harvest', 120, 264.6, 2, 6, 7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 300 , 'Field', 'Fairy', 'Normal' , q'{Quadruped body}', 'Pink' , 2, '3:1', 15, 'Cute Charm', 'Normalize', 'Wonder Skin', 11, 24.3, 0.6, 2, 0 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 381, q'|Mega|', 'M', q'|Latiosite|', 'Undiscovered' , 'Dragon', 'Psychic', q'{Single pair of wings}', 'Purple' , 0, '0:1U', 120, 'Levitate' , 60, 132.3, 2.3, 7, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 770 , 'Amorphous' , 'Ghost', 'Ground', q'{Serpentine bodies}', 'Brown', 6, 6, 0, '1:1', 15, 'Water Compaction' , 'Sand Veil', 250, 551.2, 1.3, 4, 3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 188 , 'Fairy', 'Grass', 'Grass', 'Flying', q'{Bipedal, tailed form}', 'Green' , 2, '1:1', 20, 'Chlorophyll', 'Leaf Guard', 'Infiltrator', 1, 2.2, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 352 , 'Field' , 'Normal' , q'{Bipedal, tailed form}', 'Green' , 9, 1, '1:1', 20, 'Color Change' , 'Protean', 22, 48.5, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 353 , 'Amorphous' , 'Ghost' , q'{Head}', 'Black' , 9, 2, '1:1', 25, 'Insomnia', 'Frisk', 'Cursed Body', 2.3, 5.1, 0.6, 2, 0 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 666, q'|Marine Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 37.5, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 157 , 'Field' , 'Fire' , q'{Quadruped body}', 'Yellow' , 0, '1:7', 20, 'Blaze' , 'Flash Fire', 79.5, 175.3, 1.7, 5, 7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 361 , 'Fairy', 'Mineral', 'Ice' , q'{Bipedal, tailless form}', 'Gray', 9, 9, 2, '1:1', 20, 'Inner Focus', 'Ice Body', 'Moody', 16.8, 37, 0.7, 2, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 582 , 'Mineral' , 'Ice' , q'{Head and a base}', 'White', 0, 0, 2, '1:1', 20, 'Ice Body', 'Snow Cloak', 'Weak Armor', 5.7, 12.6, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 293 , 'Monster', 'Field', 'Normal' , q'{Bipedal, tailed form}', 'Pink' , 0, '1:1', 20, 'Soundproof' , 'Rattled', 16.3, 35.9, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 250 , 'Undiscovered' , 'Fire', 'Flying', q'{Single pair of wings}', 'Red' , 0, 'GU', 120, 'Pressure' , 'Regenerator', 199, 438.7, 3.8, 12, 6 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 50, q'|Alolan|', 'A' , 'Field' , 'Ground', 'Steel', q'{Head and a base}', 'Brown', 9, 9, 0, '1:1', 20, 'Sand Veil', 'Tangling Hair', 'Sand Force', 0.8, 1.8, 0.2, 0, 8 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 75, q'|Alolan|', 'A' , 'Mineral' , 'Rock', 'Electric', q'{Bipedal, tailless form}', 'Gray', 6, 6, 0, '1:1', 15, 'Magnet Pull', 'Sturdy', 'Galvanize', 105, 231.5, 1, 3, 3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 773, q'|Type: Dark|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'RKS System' , 100.5, 221.6, 2.3, 7, 7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 25, q'|Original Cap|' , 'Field', 'Fairy', 'Electric' , q'{Quadruped body}', 'Yellow', 6, 6, 0, '1:1', 10, 'Static' , 'Lightning Rod', 6, 13.2, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 295 , 'Monster', 'Field', 'Normal' , q'{Bipedal, tailed form}', 'Blue' , 0, '1:1', 20, 'Soundproof' , 'Scrappy', 84, 185.2, 1.5, 4, 11 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 302, q'|Mega|', 'M', q'|Sablenite|', 'Human-Like' , 'Dark', 'Ghost', q'{Bipedal, tailless form}', 'Purple', 0, 0, 0, '1:1', 25, 'Magic Bounce' , 11, 24.3, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 197 , 'Field' , 'Dark' , q'{Quadruped body}', 'Black', 0, 0, 0, '1:7', 35, 'Synchronize' , 'Inner Focus', 27, 59.5, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 72 , 'Water 3' , 'Water', 'Poison', q'{Tentacles or a multiped body}', 'Blue', 15, 15, 0, '1:1', 20, 'Clear Body', 'Liquid Ooze', 'Rain Dish', 45.5, 100.3, 0.9, 2, 11 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 492, q'|Sky Forme|', 'S' , 'Undiscovered' , 'Grass', 'Flying', q'{Quadruped body}', 'Green' , 0, 'GU', 120, 'Serene Grace' , 5.2, 11.5, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 30 , 'Undiscovered' , 'Poison' , q'{Quadruped body}', 'Blue' , 2, '1:0U', 20, 'Poison Point', 'Rivalry', 'Hustle', 20, 44.1, 0.8, 2, 7 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 103, q'|Alolan|', 'A' , 'Grass' , 'Grass', 'Dragon', q'{Head and legs}', 'Yellow', 0, 0, 0, '1:1', 20, 'Frisk' , 'Harvest', 120, 264.6, 10.9, 35, 9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 104 , 'Monster' , 'Ground' , q'{Bipedal, tailed form}', 'Brown', 15, 15, 0, '1:1', 20, 'Rock Head', 'Lightning Rod', 'Battle Armor', 6.5, 14.3, 0.4, 1, 4 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 666, q'|Savanna Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 37.5, 1.2, 3, 11 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 773, q'|Type: Normal|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'RKS System' , 100.5, 221.6, 2.3, 7, 7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 676, q'|Natural Form|' , 'Field' , 'Normal' , q'{Quadruped body}', 'White' , 6, 0, '1:1', 20, 'Fur Coat' , 28, 61.7, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 125 , 'Human-Like' , 'Electric' , q'{Bipedal, tailed form}', 'Yellow', 6, 6, 0, '1:3', 25, 'Static' , 'Vital Spirit', 30, 66.1, 1.1, 3, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 243 , 'Undiscovered' , 'Electric' , q'{Quadruped body}', 'Yellow' , 8, 'GU', 80, 'Pressure' , 'Inner Focus', 178, 392.4, 1.9, 6, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 373 , 'Dragon' , 'Dragon', 'Flying', q'{Quadruped body}', 'Blue', 0, 0, 0, '1:1', 40, 'Intimidate' , 'Moxie', 102.6, 226.2, 1.5, 4, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 600 , 'Mineral' , 'Steel' , q'{Multiple bodies}', 'Gray' , 0, 'G', 20, 'Plus', 'Minus', 'Clear Body', 51, 112.4, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 302 , 'Human-Like' , 'Dark', 'Ghost', q'{Bipedal, tailless form}', 'Purple', 0, 0, 2, '1:1', 25, 'Keen Eye', 'Stall', 'Prankster', 11, 24.3, 0.5, 1, 8 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 323, q'|Mega|', 'M', q'|Cameruptite|', 'Field' , 'Fire', 'Ground', q'{Quadruped body}', 'Red' , 0, '1:1', 20, 'Sheer Force' , 220, 485, 2.5, 8, 2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 182 , 'Grass' , 'Grass' , q'{Bipedal, tailless form}', 'Green' , 0, '1:1', 20, 'Chlorophyll' , 'Healer', 5.8, 12.8, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 767 , 'Bug', 'Water 3', 'Bug', 'Water', q'{Tentacles or a multiped body}', 'Gray', 0, 0, 0, '1:1', 20, 'Wimp Out' , 12, 26.5, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 575 , 'Human-Like' , 'Psychic' , q'{Bipedal, tailless form}', 'Purple' , 2, '3:1', 20, 'Frisk', 'Competitive', 'Shadow Tag', 18, 39.7, 0.7, 2, 4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 331 , 'Grass', 'Human-Like', 'Grass' , q'{Bipedal, tailless form}', 'Green' , 0, '1:1', 20, 'Sand Veil' , 'Water Absorb', 51.3, 113.1, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 503 , 'Field' , 'Water' , q'{Quadruped body}', 'Blue' , 0, '1:7', 20, 'Torrent' , 'Shell Armor', 94.6, 208.6, 1.5, 4, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 537 , 'Water 1' , 'Water', 'Ground', q'{Bipedal, tailless form}', 'Blue' , 0, '1:1', 20, 'Swift Swim', 'Poison Touch', 'Water Absorb', 62, 136.7, 1.5, 4, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 772 , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'Battle Armor' , 120.5, 265.7, 1.9, 6, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 101 , 'Mineral' , 'Electric' , q'{Head}', 'Red' , 0, 0, 'G', 20, 'Soundproof', 'Static', 'Aftermath', 66.6, 146.8, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 420 , 'Fairy', 'Grass', 'Grass' , q'{Multiple bodies}', 'Pink' , 0, '1:1', 20, 'Chlorophyll' , 3.3, 7.3, 0.4, 1, 4 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 37, q'|Alolan|', 'A' , 'Field' , 'Ice' , q'{Quadruped body}', 'White', 9, 9, 0, '3:1', 20, 'Snow Cloak' , 'Snow Warning', 9.9, 21.8, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 510 , 'Field' , 'Dark' , q'{Quadruped body}', 'Purple' , 0, '1:1', 20, 'Limber', 'Unburden', 'Prankster', 37.5, 82.7, 1.1, 3, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 218 , 'Amorphous' , 'Fire' , q'{Serpentine bodies}', 'Red' , 0, '1:1', 20, 'Magma Armor', 'Flame Body', 'Weak Armor', 35, 77.2, 0.7, 2, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 465 , 'Grass' , 'Grass' , q'{Bipedal, tailless form}', 'Blue' , 0, '1:1', 20, 'Chlorophyll', 'Leaf Guard', 'Regenerator', 128.6, 283.5, 2, 6, 7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 417 , 'Field', 'Fairy', 'Electric' , q'{Quadruped body}', 'White' , 0, '1:1', 10, 'Run Away', 'Pickup', 'Volt Absorb', 3.9, 8.6, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 196 , 'Field' , 'Psychic' , q'{Quadruped body}', 'Purple', 0, 0, 0, '1:7', 35, 'Synchronize' , 'Magic Bounce', 26.5, 58.4, 0.9, 2, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 162 , 'Field' , 'Normal' , q'{Quadruped body}', 'Brown' , 0, '1:1', 15, 'Run Away', 'Keen Eye', 'Frisk', 32.5, 71.6, 1.8, 5, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 775 , 'Field' , 'Normal' , q'{Bipedal, tailless form}', 'Blue', 0, 0, 0, '1:1', 20, 'Comatose' , 19.9, 43.9, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 766 , 'Field' , 'Fighting' , q'{Bipedal, tailed form}', 'White', 15, 15, 0, '1:1', 20, 'Receiver' , 'Defiant', 82.8, 182.5, 2, 6, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 348 , 'Water 3' , 'Rock', 'Bug', q'{Bipedal, tailed form}', 'Gray' , 0, '1:7', 30, 'Battle Armor' , 'Swift Swim', 68.2, 150.4, 1.5, 4, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 603 , 'Amorphous' , 'Electric' , q'{Fins}', 'Blue' , 0, '1:1', 20, 'Levitate' , 22, 48.5, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 107 , 'Human-Like' , 'Fighting' , q'{Bipedal, tailless form}', 'Brown' , 2, '0:1', 25, 'Keen Eye', 'Iron Fist', 'Inner Focus', 50.2, 110.7, 1.4, 4, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 750 , 'Field' , 'Ground' , q'{Quadruped body}', 'Brown', 6, 6, 0, '1:1', 20, 'Own Tempo', 'Stamina', 'Inner Focus', 920, 2028.3, 2.5, 8, 2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 626 , 'Field' , 'Normal' , q'{Quadruped body}', 'Brown' , 0, '1:1', 20, 'Reckless', 'Sap Sipper', 'Soundproof', 94.5, 208.3, 1.6, 5, 3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 585, q'|Summer Form|' , 'Field' , 'Normal', 'Grass', q'{Quadruped body}', 'Pink' , 0, '1:1', 20, 'Chlorophyll', 'Sap Sipper', 'Serene Grace', 19.5, 43, 0.6, 2, 0 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 741, q'|Baile Style|' , 'Flying' , 'Fire', 'Flying', q'{Single pair of wings}', 'Red', 6, 6, 0, '3:1', 20, 'Dancer' , 3.4, 7.5, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 459 , 'Monster', 'Grass', 'Grass', 'Ice', q'{Bipedal, tailed form}', 'White' , 0, '1:1', 20, 'Snow Warning' , 'Soundproof', 50.5, 111.3, 1, 3, 3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 351, q'|Normal|' , 'Fairy', 'Amorphous', 'Normal' , q'{Head}', 'Gray', 0, 0, 0, '1:1', 25, 'Forecast' , 0.8, 1.8, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 394 , 'Water 1', 'Field', 'Water' , q'{Bipedal, tailed form}', 'Blue' , 0, '1:7', 20, 'Torrent' , 'Defiant', 23, 50.7, 0.8, 2, 7 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 475, q'|Mega|', 'M', q'|Galladite|', 'Amorphous' , 'Psychic', 'Fighting', q'{Bipedal, tailless form}', 'White' , 0, '0:1', 20, 'Inner Focus' , 52, 114.6, 1.6, 5, 3 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 53, q'|Alolan|', 'A' , 'Field' , 'Dark' , q'{Quadruped body}', 'Blue', 6, 6, 0, '1:1', 20, 'Fur Coat', 'Technician', 'Rattled', 32, 70.5, 1.1, 3, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 262 , 'Field' , 'Dark' , q'{Quadruped body}', 'Gray' , 2, '1:1', 15, 'Intimidate', 'Quick Feet', 'Moxie', 37, 81.6, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 753 , 'Grass' , 'Grass' , q'{Bipedal, tailed form}', 'Pink', 9, 9, 0, '1:1', 20, 'Leaf Guard' , 'Contrary', 1.5, 3.3, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 699 , 'Monster' , 'Rock', 'Ice', q'{Quadruped body}', 'Blue' , 0, '1:7', 30, 'Refrigerate' , 'Snow Warning', 225, 496, 2.7, 8, 10 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 28 , 'Field' , 'Ground' , q'{Bipedal, tailed form}', 'Yellow' , 0, '1:1', 20, 'Sand Veil' , 'Sand Rush', 29.5, 65, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 82 , 'Mineral' , 'Electric', 'Steel', q'{Multiple bodies}', 'Gray', 6, 6, 0, 'G', 20, 'Magnet Pull', 'Sturdy', 'Analytic', 60, 132.3, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 67 , 'Human-Like' , 'Fighting' , q'{Bipedal, tailless form}', 'Gray', 6, 6, 2, '1:3', 20, 'Guts', 'No Guard', 'Steadfast', 70.5, 155.4, 1.5, 4, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 171 , 'Water 2' , 'Water', 'Electric', q'{Fins}', 'Blue', 6, 6, 0, '1:1', 20, 'Volt Absorb', 'Illuminate', 'Water Absorb', 22.5, 49.6, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 190 , 'Field' , 'Normal' , q'{Bipedal, tailed form}', 'Purple' , 9, 0, '1:1', 20, 'Run Away', 'Pickup', 'Skill Link', 11.5, 25.4, 0.8, 2, 7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 709 , 'Grass', 'Amorphous', 'Ghost', 'Grass', q'{Tentacles or a multiped body}', 'Brown' , 0, '1:1', 20, 'Natural Cure', 'Frisk', 'Harvest', 71, 156.5, 1.5, 4, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 114 , 'Grass' , 'Grass' , q'{Head and legs}', 'Blue' , 2, '1:1', 20, 'Chlorophyll', 'Leaf Guard', 'Regenerator', 35, 77.2, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 370 , 'Water 2' , 'Water' , q'{Fins}', 'Pink', 6, 6, 0, '3:1', 20, 'Swift Swim' , 'Hydration', 8.7, 19.2, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 290 , 'Bug' , 'Bug', 'Ground', q'{Insectoid body}', 'Gray' , 0, '1:1', 15, 'Compound Eyes' , 'Run Away', 5.5, 12.1, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 252 , 'Monster', 'Dragon', 'Grass' , q'{Bipedal, tailed form}', 'Green' , 0, '1:7', 20, 'Overgrow' , 'Unburden', 5, 11, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 285 , 'Fairy', 'Grass', 'Grass' , q'{Head and legs}', 'Brown' , 2, '1:1', 15, 'Effect Spore', 'Poison Heal', 'Quick Feet', 4.5, 9.9, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 682 , 'Fairy' , 'Fairy' , q'{Head and arms}', 'Pink' , 0, '1:1', 20, 'Healer' , 'Aroma Veil', 0.5, 1.1, 0.2, 0, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 653 , 'Field' , 'Fire' , q'{Quadruped body}', 'Red' , 0, '1:7', 20, 'Blaze' , 'Magician', 9.4, 20.7, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 574 , 'Human-Like' , 'Psychic' , q'{Bipedal, tailless form}', 'Purple' , 2, '3:1', 20, 'Frisk', 'Competitive', 'Shadow Tag', 5.8, 12.8, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 719 , 'Undiscovered' , 'Rock', 'Fairy', q'{Head and arms}', 'Pink' , 0, 'GU', 25, 'Clear Body' , 8.8, 19.4, 0.7, 2, 4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 563 , 'Mineral', 'Amorphous', 'Ghost' , q'{Head and a base}', 'Yellow' , 0, '1:1', 25, 'Mummy' , 76.5, 168.7, 1.7, 5, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 340 , 'Water 2' , 'Water', 'Ground', q'{Fins}', 'Blue', 6, 6, 2, '1:1', 20, 'Oblivious', 'Anticipation', 'Hydration', 23.6, 52, 0.9, 2, 11 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 648, q'|Pirouette Forme|', 'P' , 'Undiscovered' , 'Normal', 'Fighting', q'{Bipedal, tailless form}', 'White' , 0, 'GU', 120, 'Serene Grace' , 6.5, 14.3, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 36 , 'Fairy' , 'Fairy' , q'{Bipedal, tailed form}', 'Pink' , 2, '3:1', 10, 'Cute Charm', 'Magic Guard', 'Unaware', 40, 88.2, 1.3, 4, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 206 , 'Field' , 'Normal' , q'{Serpentine bodies}', 'Yellow' , 3, 0, '1:1', 20, 'Serene Grace', 'Run Away', 'Rattled', 14, 30.9, 1.5, 4, 11 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 493, q'|Type: Ice|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Multitype' , 320, 705.5, 3.2, 10, 6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 123 , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'Green', 3, 3, 2, '1:1', 25, 'Swarm', 'Technician', 'Steadfast', 56, 123.5, 1.5, 4, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 314 , 'Bug', 'Human-Like', 'Bug' , q'{Bipedal, tailless form}', 'Purple' , 2, '1:0', 15, 'Oblivious', 'Tinted Lens', 'Prankster', 17.7, 39, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 786 , 'Undiscovered' , 'Psychic', 'Fairy', q'{Head and arms}', 'Pink' , 0, 'GU', 15, 'Psychic Surge' , 'Telepathy', 18.6, 41, 1.2, 3, 11 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 711, q'|Small Size|' , 'Amorphous' , 'Ghost', 'Grass', q'{Head and a base}', 'Brown' , 0, '1:1', 20, 'Pickup', 'Frisk', 'Insomnia', 9.5, 20.9, 0.7, 2, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 156 , 'Field' , 'Fire' , q'{Quadruped body}', 'Yellow' , 0, '1:7', 20, 'Blaze' , 'Flash Fire', 19, 41.9, 0.9, 2, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 222 , 'Water 1', 'Water 3', 'Water', 'Rock', q'{Insectoid body}', 'Pink', 9, 9, 0, '3:1', 20, 'Hustle', 'Natural Cure', 'Regenerator', 5, 11, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 409 , 'Monster' , 'Rock' , q'{Bipedal, tailed form}', 'Blue' , 0, '1:7', 30, 'Mold Breaker' , 'Sheer Force', 102.5, 226, 1.6, 5, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 63 , 'Human-Like' , 'Psychic' , q'{Bipedal, tailed form}', 'Brown', 9, 9, 0, '1:3', 20, 'Synchronize', 'Inner Focus', 'Magic Guard', 19.5, 43, 0.9, 2, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 616 , 'Bug' , 'Bug' , q'{Head}', 'Red' , 0, '1:1', 15, 'Hydration', 'Shell Armor', 'Overcoat', 7.7, 17, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 804 , 'Undiscovered' , 'Poison', 'Dragon', q'{Single pair of wings}', 'Purple' , 0, 'GU', 120, 'Beast Boost' , 150, 330.7, 3.6, 11, 10 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 453 , 'Human-Like' , 'Poison', 'Fighting', q'{Bipedal, tailless form}', 'Blue' , 0, '1:1', 10, 'Anticipation', 'Dry Skin', 'Poison Touch', 23, 50.7, 0.7, 2, 4 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 585, q'|Winter Form|' , 'Field' , 'Normal', 'Grass', q'{Quadruped body}', 'Pink' , 0, '1:1', 20, 'Chlorophyll', 'Sap Sipper', 'Serene Grace', 19.5, 43, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 477 , 'Amorphous' , 'Ghost' , q'{Head and arms}', 'Black' , 1, '1:1', 25, 'Pressure' , 'Frisk', 106.6, 235, 2.2, 7, 3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 497 , 'Field', 'Grass', 'Grass' , q'{Serpentine bodies}', 'Green' , 0, '1:7', 20, 'Overgrow' , 'Contrary', 63, 138.9, 3.3, 10, 10 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 429 , 'Amorphous' , 'Ghost' , q'{Head}', 'Purple' , 0, '1:1', 25, 'Levitate' , 4.4, 9.7, 0.9, 2, 11 );
insert into SPECIES( DEX, CLASS , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 6, q'|Normal and|' , 'Monster', 'Dragon', 'Fire', 'Flying', q'{Bipedal, tailed form}', 'Red' , 0, '1:7', 20, 'Blaze' , 'Solar Power', 90.5, 199.5, 1.7, 5, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 269 , 'Bug' , 'Bug', 'Poison', q'{Two or more pairs of wings}', 'Green' , 0, '1:1', 15, 'Shield Dust' , 'Compound Eyes', 31.6, 69.7, 1.2, 3, 11 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 586, q'|Winter Form|' , 'Field' , 'Normal', 'Grass', q'{Quadruped body}', 'Brown' , 0, '1:1', 20, 'Chlorophyll', 'Sap Sipper', 'Serene Grace', 92.5, 203.9, 1.9, 6, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 502 , 'Field' , 'Water' , q'{Bipedal, tailed form}', 'Blue' , 0, '1:7', 20, 'Torrent' , 'Shell Armor', 24.5, 54, 0.8, 2, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 707 , 'Mineral' , 'Steel', 'Fairy', q'{Head}', 'Gray', 6, 6, 0, '1:1', 20, 'Prankster' , 'Magician', 3, 6.6, 0.2, 0, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 186 , 'Water 1' , 'Water' , q'{Bipedal, tailless form}', 'Green', 0, 0, 0, '1:1', 20, 'Water Absorb', 'Damp', 'Drizzle', 33.9, 74.7, 1.1, 3, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 535 , 'Water 1' , 'Water' , q'{Fins}', 'Blue' , 0, '1:1', 20, 'Swift Swim', 'Hydration', 'Water Absorb', 4.5, 9.9, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 343 , 'Mineral' , 'Ground', 'Psychic', q'{Head and arms}', 'Brown' , 15, 0, 'G', 20, 'Levitate' , 21.5, 47.4, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 277 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Blue' , 0, '1:1', 15, 'Guts' , 'Scrappy', 19.8, 43.7, 0.7, 2, 4 );
insert into SPECIES( DEX, CLASS , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 422, q'|West Sea|' , 'Water 1', 'Amorphous', 'Water' , q'{Serpentine bodies}', 'Purple', 9, 9, 0, '1:1', 20, 'Sticky Hold', 'Storm Drain', 'Sand Force', 6.3, 13.9, 0.3, 1, 0 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 52, q'|Alolan|', 'A' , 'Field' , 'Dark' , q'{Quadruped body}', 'Blue', 9, 9, 0, '1:1', 20, 'Pickup', 'Technician', 'Rattled', 4.2, 9.3, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 121 , 'Water 3' , 'Water', 'Psychic', q'{Head and a base}', 'Purple', 0, 0, 0, 'G', 20, 'Illuminate', 'Natural Cure', 'Analytic', 80, 176.4, 1.1, 3, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 679 , 'Mineral' , 'Steel', 'Ghost', q'{Head and a base}', 'Brown' , 0, '1:1', 20, 'No Guard' , 2, 4.4, 0.8, 2, 7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 773, q'|Type: Grass|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'RKS System' , 100.5, 221.6, 2.3, 7, 7 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 6, q'|Mega  Y|', 'MY' , 'Monster', 'Dragon', 'Fire', 'Flying', q'{Bipedal, tailed form}', 'Red' , 0, '1:7', 20, 'Drought' , 90.5, 199.5, 1.7, 5, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 166 , 'Bug' , 'Bug', 'Flying', q'{Single pair of wings}', 'Red', 6, 6, 0, '1:1', 15, 'Swarm', 'Early Bird', 'Iron Fist', 35.6, 78.5, 1.4, 4, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 725 , 'Field' , 'Fire' , q'{Quadruped body}', 'Red' , 0, '1:7', 15, 'Blaze' , 'Intimidate', 4.3, 9.5, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 227 , 'Flying' , 'Steel', 'Flying', q'{Single pair of wings}', 'Gray', 6, 6, 0, '1:1', 25, 'Keen Eye', 'Sturdy', 'Weak Armor', 50.5, 111.3, 1.7, 5, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 102 , 'Grass' , 'Grass', 'Psychic', q'{Multiple bodies}', 'Pink', 15, 15, 0, '1:1', 20, 'Chlorophyll' , 'Harvest', 2.5, 5.5, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 205 , 'Bug' , 'Bug', 'Steel', q'{Head}', 'Purple' , 6, 0, '1:1', 20, 'Sturdy' , 'Overcoat', 125.8, 277.3, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 40 , 'Fairy' , 'Normal', 'Fairy', q'{Bipedal, tailless form}', 'Pink' , 2, '3:1', 10, 'Cute Charm', 'Competitive', 'Frisk', 12, 26.5, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 803 , 'Undiscovered' , 'Poison' , q'{Bipedal, tailed form}', 'Purple' , 0, 'GU', 120, 'Beast Boost' , 1.8, 4, 0.6, 2, 0 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 493, q'|Type: Fire|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Multitype' , 320, 705.5, 3.2, 10, 6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 144 , 'Undiscovered' , 'Ice', 'Flying', q'{Single pair of wings}', 'Blue' , 0, 'GU', 80, 'Pressure' , 'Snow Cloak', 55.4, 122.1, 1.7, 5, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 248 , 'Monster' , 'Rock', 'Dark', q'{Bipedal, tailed form}', 'Green' , 0, '1:1', 40, 'Sand Stream' , 'Unnerve', 202, 445.3, 2, 6, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 714 , 'Flying' , 'Flying', 'Dragon', q'{Single pair of wings}', 'Purple' , 9, 0, '1:1', 20, 'Frisk', 'Infiltrator', 'Telepathy', 8, 17.6, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 650 , 'Field' , 'Grass' , q'{Bipedal, tailed form}', 'Green' , 0, '1:7', 20, 'Overgrow' , 'Bulletproof', 9, 19.8, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 703 , 'Fairy', 'Mineral', 'Rock', 'Fairy', q'{Head}', 'Gray', 9, 9, 0, 'G', 25, 'Clear Body' , 'Sturdy', 5.7, 12.6, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 313 , 'Bug', 'Human-Like', 'Bug' , q'{Bipedal, tailed form}', 'Gray' , 0, '0:1', 15, 'Illuminate', 'Swarm', 'Prankster', 17.7, 39, 0.7, 2, 4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 742 , 'Bug', 'Fairy', 'Bug', 'Fairy', q'{Insectoid body}', 'Yellow', 9, 9, 0, '1:1', 20, 'Honey Gather', 'Shield Dust', 'Sweet Veil', 0.2, 0.4, 0.1, 0, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 311 , 'Fairy' , 'Electric' , q'{Bipedal, tailed form}', 'Yellow' , 1, '1:1', 20, 'Plus' , 'Lightning Rod', 4.2, 9.3, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 26 , 'Field', 'Fairy', 'Electric' , q'{Bipedal, tailed form}', 'Yellow' , 0, '1:1', 10, 'Static' , 'Lightning Rod', 30, 66.1, 0.8, 2, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 672 , 'Field' , 'Grass' , q'{Quadruped body}', 'Brown' , 0, '1:1', 20, 'Sap Sipper' , 'Grass Pelt', 31, 68.3, 0.9, 2, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 489 , 'Water 1', 'Fairy', 'Water' , q'{Head and arms}', 'Blue' , 0, 'G', 40, 'Hydration' , 3.1, 6.8, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 185 , 'Mineral' , 'Rock' , q'{Bipedal, tailless form}', 'Brown', 0, 0, 0, '1:1', 20, 'Sturdy', 'Rock Head', 'Rattled', 38, 83.8, 1.2, 3, 11 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 27, q'|Alolan|', 'A' , 'Field' , 'Ice', 'Steel', q'{Bipedal, tailed form}', 'White', 9, 9, 0, '1:1', 20, 'Snow Cloak' , 'Slush Rush', 12, 26.5, 0.7, 2, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 213 , 'Bug' , 'Bug', 'Rock', q'{Insectoid body}', 'Yellow' , 2, '1:1', 20, 'Sturdy', 'Gluttony', 'Contrary', 20.5, 45.2, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 438 , 'Undiscovered' , 'Rock' , q'{Head and legs}', 'Brown', 15, 15, 0, '1:1U', 20, 'Sturdy', 'Rock Head', 'Rattled', 15, 33.1, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 659 , 'Field' , 'Normal' , q'{Bipedal, tailed form}', 'Brown' , 0, '1:1', 15, 'Pickup', 'Cheek Pouch', 'Huge Power', 5, 11, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 660 , 'Field' , 'Normal', 'Ground', q'{Bipedal, tailed form}', 'Brown' , 0, '1:1', 15, 'Pickup', 'Cheek Pouch', 'Huge Power', 42.4, 93.5, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 69 , 'Grass' , 'Grass', 'Poison', q'{Bipedal, tailless form}', 'Green' , 0, '1:1', 20, 'Chlorophyll' , 'Gluttony', 4, 8.8, 0.7, 2, 4 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 710, q'|Small Size|' , 'Amorphous' , 'Ghost', 'Grass', q'{Head}', 'Brown' , 0, '1:1', 20, 'Pickup', 'Frisk', 'Insomnia', 3.5, 7.7, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 793 , 'Undiscovered' , 'Rock', 'Poison', q'{Tentacles or a multiped body}', 'White' , 0, 'GU', 120, 'Beast Boost' , 55.5, 122.4, 1.2, 3, 11 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 380, q'|Mega|', 'M', q'|Latiasite|', 'Undiscovered' , 'Dragon', 'Psychic', q'{Single pair of wings}', 'Purple' , 0, '1:0U', 120, 'Levitate' , 40, 88.2, 1.8, 5, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 612 , 'Monster', 'Dragon', 'Dragon' , q'{Bipedal, tailed form}', 'Yellow' , 0, '1:1', 40, 'Rivalry', 'Mold Breaker', 'Unnerve', 105.5, 232.6, 1.8, 5, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 64 , 'Human-Like' , 'Psychic' , q'{Bipedal, tailed form}', 'Brown', 6, 6, 0, '1:3', 20, 'Synchronize', 'Inner Focus', 'Magic Guard', 56.5, 124.6, 1.3, 4, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 463 , 'Monster' , 'Normal' , q'{Bipedal, tailless form}', 'Pink' , 0, '1:1', 20, 'Own Tempo', 'Oblivious', 'Cloud Nine', 140, 308.6, 1.7, 5, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 298 , 'Undiscovered' , 'Normal', 'Fairy', q'{Head and legs}', 'Blue' , 0, '3:1U', 10, 'Thick Fat', 'Huge Power', 'Sap Sipper', 2, 4.4, 0.2, 0, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 289 , 'Field' , 'Normal' , q'{Bipedal, tailless form}', 'Brown' , 0, '1:1', 15, 'Truant' , 130.5, 287.7, 2, 6, 7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 547 , 'Grass', 'Fairy', 'Grass', 'Fairy', q'{Bipedal, tailless form}', 'Green' , 0, '1:1', 20, 'Prankster', 'Infiltrator', 'Chlorophyll', 6.6, 14.6, 0.7, 2, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 73 , 'Water 3' , 'Water', 'Poison', q'{Tentacles or a multiped body}', 'Blue', 6, 6, 0, '1:1', 20, 'Clear Body', 'Liquid Ooze', 'Rain Dish', 55, 121.3, 1.6, 5, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 680 , 'Mineral' , 'Steel', 'Ghost', q'{Multiple bodies}', 'Brown' , 0, '1:1', 20, 'No Guard' , 4.5, 9.9, 0.8, 2, 7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 710, q'|Super Size|' , 'Amorphous' , 'Ghost', 'Grass', q'{Head}', 'Brown' , 0, '1:1', 20, 'Pickup', 'Frisk', 'Insomnia', 15, 33.1, 0.8, 2, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 439 , 'Undiscovered' , 'Psychic', 'Fairy', q'{Bipedal, tailless form}', 'Pink' , 15, 0, '1:1U', 25, 'Soundproof', 'Filter', 'Technician', 13, 28.7, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 367 , 'Water 1' , 'Water' , q'{Serpentine bodies}', 'Blue' , 0, 0, '1:1', 20, 'Swift Swim' , 'Water Veil', 27, 59.5, 1.7, 5, 7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 774, q'|Brown|' , 'Mineral' , 'Rock', 'Flying', q'{Head}', 'Brown', 0, 0, 0, 'G', 25, 'Shields Down' , 40, 88.2, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 807 , 'Undiscovered' , 'Electric' , q'{Bipedal, tailless form}', 'Yellow' , 0, 'GU', 120, 'Volt Absorb' , 44.5, 98.1, 1.5, 4, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 346 , 'Water 3' , 'Rock', 'Grass', q'{Head and a base}', 'Green' , 0, '1:7', 30, 'Suction Cups' , 'Storm Drain', 60.4, 133.2, 1.5, 4, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 528 , 'Field', 'Flying', 'Psychic', 'Flying', q'{Single pair of wings}', 'Blue' , 0, '1:1', 15, 'Unaware', 'Klutz', 'Simple', 10.5, 23.1, 0.9, 2, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 150 , 'Undiscovered' , 'Psychic' , q'{Bipedal, tailed form}', 'Purple' , 0, 'GU', 120, 'Pressure' , 'Unnerve', 122, 269, 2, 6, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 323 , 'Field' , 'Fire', 'Ground', q'{Quadruped body}', 'Red' , 2, '1:1', 20, 'Magma Armor', 'Solid Rock', 'Anger Point', 220, 485, 1.9, 6, 3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 487, q'|Altered Forme|' , 'Undiscovered' , 'Ghost', 'Dragon', q'{Tentacles or a multiped body}', 'Black' , 0, 'GU', 120, 'Pressure' , 'Telepathy', 750, 1653.5, 6.9, 22, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 53 , 'Field' , 'Normal' , q'{Quadruped body}', 'Yellow', 6, 6, 2, '1:1', 20, 'Limber', 'Technician', 'Unnerve', 32, 70.5, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 541 , 'Bug' , 'Bug', 'Grass', q'{Head and arms}', 'Green' , 0, '1:1', 15, 'Leaf Guard', 'Chlorophyll', 'Overcoat', 7.3, 16.1, 0.5, 1, 8 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 773, q'|Type: Water|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'RKS System' , 100.5, 221.6, 2.3, 7, 7 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 150, q'|Mega  Y|', 'MY' , 'Undiscovered' , 'Psychic' , q'{Bipedal, tailed form}', 'Purple' , 0, 'GU', 120, 'Insomnia' , 122, 269, 1.5, 4, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 230 , 'Water 1', 'Dragon', 'Water', 'Dragon', q'{Head and a base}', 'Blue' , 2, '1:1', 20, 'Swift Swim', 'Sniper', 'Damp', 152, 335.1, 1.8, 5, 11 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 319, q'|Mega|', 'M', q'|Sharpedonite|', 'Water 2' , 'Water', 'Dark', q'{Fins}', 'Blue', 3, 3, 0, '1:1', 20, 'Strong Jaw' , 88.8, 195.8, 2.5, 8, 2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 522 , 'Field' , 'Electric' , q'{Quadruped body}', 'Black' , 0, '1:1', 20, 'Lightning Rod', 'Motor Drive', 'Sap Sipper', 29.8, 65.7, 0.8, 2, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 308 , 'Human-Like' , 'Fighting', 'Psychic', q'{Bipedal, tailless form}', 'Red' , 0, '1:1', 20, 'Pure Power' , 'Telepathy', 31.5, 69.4, 1.3, 4, 3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 179 , 'Monster', 'Field', 'Electric' , q'{Quadruped body}', 'White' , 9, 0, '1:1', 20, 'Static' , 'Plus', 7.8, 17.2, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 631 , 'Field' , 'Fire' , q'{Bipedal, tailed form}', 'Red' , 0, '1:1', 20, 'Gluttony', 'Flash Fire', 'White Smoke', 58, 127.9, 1.4, 4, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 192 , 'Grass' , 'Grass' , q'{Bipedal, tailless form}', 'Yellow' , 2, '1:1', 20, 'Chlorophyll', 'Solar Power', 'Early Bird', 8.5, 18.7, 0.8, 2, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 66 , 'Human-Like' , 'Fighting' , q'{Bipedal, tailed form}', 'Gray', 9, 9, 2, '1:3', 20, 'Guts', 'No Guard', 'Steadfast', 19.5, 43, 0.8, 2, 7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 676, q'|Dandy Trim|' , 'Field' , 'Normal' , q'{Quadruped body}', 'White' , 6, 0, '1:1', 20, 'Fur Coat' , 28, 61.7, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 473 , 'Field' , 'Ice', 'Ground', q'{Quadruped body}', 'Brown' , 0, '1:1', 20, 'Oblivious', 'Snow Cloak', 'Thick Fat', 291, 641.5, 2.5, 8, 2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 715 , 'Flying' , 'Flying', 'Dragon', q'{Single pair of wings}', 'Purple' , 6, 0, '1:1', 20, 'Frisk', 'Infiltrator', 'Telepathy', 85, 187.4, 1.5, 4, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 805 , 'Undiscovered' , 'Rock', 'Steel', q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'Beast Boost' , 820, 1807.8, 5.5, 18, 1 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 76, q'|Alolan|', 'A' , 'Mineral' , 'Rock', 'Electric', q'{Bipedal, tailless form}', 'Gray' , 0, '1:1', 15, 'Magnet Pull', 'Sturdy', 'Galvanize', 300, 661.4, 1.7, 5, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 634 , 'Dragon' , 'Dark', 'Dragon', q'{Quadruped body}', 'Blue' , 0, '1:1', 40, 'Hustle' , 50, 110.2, 1.4, 4, 7 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 310, q'|Mega|', 'M', q'|Manectite|', 'Field' , 'Electric' , q'{Quadruped body}', 'Yellow' , 6, 0, '1:1', 20, 'Intimidate' , 40.2, 88.6, 1.8, 5, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 224 , 'Water 1', 'Water 2', 'Water' , q'{Tentacles or a multiped body}', 'Red' , 0, 2, '1:1', 20, 'Suction Cups', 'Sniper', 'Moody', 28.5, 62.8, 0.9, 2, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 554 , 'Field' , 'Fire' , q'{Bipedal, tailless form}', 'Red' , 0, '1:1', 20, 'Hustle' , 'Inner Focus', 37.5, 82.7, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 133 , 'Field' , 'Normal' , q'{Quadruped body}', 'Brown', 9, 9, 2, '1:7', 35, 'Run Away', 'Adaptability', 'Anticipation', 6.5, 14.3, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 795 , 'Undiscovered' , 'Bug', 'Fighting', q'{Bipedal, tailless form}', 'White' , 0, 'GU', 120, 'Beast Boost' , 25, 55.1, 1.8, 5, 11 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 460, q'|Mega|', 'M', q'|Abomasite|', 'Monster', 'Grass', 'Grass', 'Ice', q'{Bipedal, tailed form}', 'White' , 0, '1:1', 20, 'Snow Warning' , 135.5, 298.7, 2.7, 8, 10 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 601 , 'Mineral' , 'Steel' , q'{Multiple bodies}', 'Gray' , 0, 'G', 20, 'Plus', 'Minus', 'Clear Body', 81, 178.6, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 661 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Red', 9, 9, 0, '1:1', 15, 'Big Pecks' , 'Gale Wings', 1.7, 3.7, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 557 , 'Bug', 'Mineral', 'Bug', 'Rock', q'{Insectoid body}', 'Red' , 0, '1:1', 20, 'Sturdy', 'Shell Armor', 'Weak Armor', 14.5, 32, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 468 , 'Flying', 'Fairy', 'Fairy', 'Flying', q'{Single pair of wings}', 'White' , 0, '1:7', 10, 'Hustle', 'Serene Grace', 'Super Luck', 38, 83.8, 1.5, 4, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 729 , 'Water 1', 'Field', 'Water' , q'{Fins}', 'Blue' , 0, '1:7', 15, 'Torrent' , 'Liquid Voice', 17.5, 38.6, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 129 , 'Water 2', 'Dragon', 'Water' , q'{Fins}', 'Red', 9, 9, 0, '1:1', 5, 'Swift Swim' , 'Rattled', 10, 22, 0.9, 2, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 674 , 'Field', 'Human-Like', 'Fighting' , q'{Bipedal, tailed form}', 'White', 9, 9, 0, '1:1', 25, 'Iron Fist', 'Mold Breaker', 'Scrappy', 8, 17.6, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 246 , 'Monster' , 'Rock', 'Ground', q'{Bipedal, tailed form}', 'Green' , 9, 0, '1:1', 40, 'Guts' , 'Sand Veil', 72, 158.7, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 334 , 'Flying', 'Dragon', 'Dragon', 'Flying', q'{Single pair of wings}', 'Blue' , 0, '1:1', 20, 'Natural Cure' , 'Cloud Nine', 20.6, 45.4, 1.1, 3, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 106 , 'Human-Like' , 'Fighting' , q'{Bipedal, tailless form}', 'Brown' , 2, '0:1', 25, 'Limber', 'Reckless', 'Unburden', 49.8, 109.8, 1.5, 4, 11 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 666, q'|Archipelago Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 37.5, 1.2, 3, 11 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 669, q'|Red Flower|' , 'Fairy' , 'Fairy' , q'{Head and arms}', 'White' , 15, 0, '1:0', 20, 'Flower Veil' , 'Symbiosis', 0.1, 0.2, 0.1, 0, 4 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 681, q'|Blade Forme|', 'B' , 'Mineral' , 'Steel', 'Ghost', q'{Head and a base}', 'Brown' , 0, '1:1', 20, 'Stance Change' , 53, 116.8, 1.7, 5, 7 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 19, q'|Alolan|', 'A' , 'Field' , 'Dark', 'Normal', q'{Quadruped body}', 'Black', 9, 9, 0, '1:1', 15, 'Gluttony', 'Hustle', 'Thick Fat', 3.5, 7.7, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 500 , 'Field' , 'Fire', 'Fighting', q'{Bipedal, tailed form}', 'Red' , 0, '1:7', 20, 'Blaze' , 'Reckless', 150, 330.7, 1.6, 5, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 338 , 'Mineral' , 'Rock', 'Psychic', q'{Head}', 'Red' , 0, 'G', 25, 'Levitate' , 154, 339.5, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 381 , 'Undiscovered' , 'Dragon', 'Psychic', q'{Single pair of wings}', 'Blue' , 0, '0:1U', 120, 'Levitate' , 60, 132.3, 2, 6, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 245 , 'Undiscovered' , 'Water' , q'{Quadruped body}', 'Blue' , 8, 'GU', 80, 'Pressure' , 'Inner Focus', 187, 412.3, 2, 6, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 572 , 'Field' , 'Normal' , q'{Quadruped body}', 'Gray' , 9, 0, '3:1', 15, 'Cute Charm', 'Technician', 'Skill Link', 5.8, 12.8, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 442 , 'Amorphous' , 'Ghost', 'Dark', q'{Head and a base}', 'Purple' , 0, '1:1', 30, 'Pressure' , 'Infiltrator', 108, 238.1, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 109 , 'Amorphous' , 'Poison' , q'{Head}', 'Purple' , 0, '1:1', 20, 'Levitate' , 1, 2.2, 0.6, 2, 0 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 671, q'|White Flower|' , 'Fairy' , 'Fairy' , q'{Head and arms}', 'White' , 0, '1:0', 20, 'Flower Veil' , 'Symbiosis', 10, 22, 1.1, 3, 7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 479, q'|Heat|' , 'Amorphous' , 'Electric', 'Ghost', q'{Head}', 'Red' , 0, 'G', 20, 'Levitate' , 0.3, 0.7, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 595 , 'Bug' , 'Bug', 'Electric', q'{Insectoid body}', 'Yellow' , 0, '1:1', 20, 'Compound Eyes', 'Unnerve', 'Swarm', 0.6, 1.3, 0.1, 0, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 638 , 'Undiscovered' , 'Steel', 'Fighting', q'{Quadruped body}', 'Blue' , 0, 'GU', 80, 'Justified' , 250, 551.2, 2.1, 6, 11 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 229, q'|Mega|', 'M', q'|Houndoominite|', 'Field' , 'Dark', 'Fire', q'{Quadruped body}', 'Black' , 6, 0, '1:1', 20, 'Solar Power' , 35, 77.2, 1.9, 6, 3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 702 , 'Field', 'Fairy', 'Electric', 'Fairy', q'{Bipedal, tailed form}', 'Yellow' , 9, 0, '1:1', 20, 'Cheek Pouch', 'Pickup', 'Plus', 2.2, 4.9, 0.2, 0, 8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 189 , 'Fairy', 'Grass', 'Grass', 'Flying', q'{Bipedal, tailed form}', 'Blue' , 2, '1:1', 20, 'Chlorophyll', 'Leaf Guard', 'Infiltrator', 3, 6.6, 0.8, 2, 7 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 351, q'|Sunny Form|', 'S' , 'Fairy', 'Amorphous', 'Fire' , q'{Head}', 'Red', 0, 0, 0, '1:1', 25, 'Forecast' , 0.8, 1.8, 0.3, 1, 0 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 3, q'|Mega|', 'M', q'|Venusaurite|', 'Monster', 'Grass', 'Grass', 'Poison', q'{Quadruped body}', 'Green' , 0, '1:7', 20, 'Thick Fat' , 100, 220.5, 2.4, 7, 10 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 493, q'|Type: Bug|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Multitype' , 320, 705.5, 3.2, 10, 6 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 670, q'|Blue Flower|' , 'Fairy' , 'Fairy' , q'{Head and arms}', 'White' , 0, 0, '1:0', 20, 'Flower Veil' , 'Symbiosis', 0.9, 2, 0.2, 0, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 416 , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'Yellow' , 0, '1:0', 15, 'Pressure' , 'Unnerve', 38.5, 84.9, 1.2, 3, 11 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 666, q'|High Plains Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 37.5, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 411 , 'Monster' , 'Rock', 'Steel', q'{Quadruped body}', 'Gray' , 0, '1:7', 30, 'Sturdy' , 'Soundproof', 149.5, 329.6, 1.3, 4, 3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 666, q'|Meadow Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 37.5, 1.2, 3, 11 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 585, q'|Autumn Form|' , 'Field' , 'Normal', 'Grass', q'{Quadruped body}', 'Pink' , 0, '1:1', 20, 'Chlorophyll', 'Sap Sipper', 'Serene Grace', 19.5, 43, 0.6, 2, 0 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 669, q'|Orange Flower|' , 'Fairy' , 'Fairy' , q'{Head and arms}', 'White' , 15, 0, '1:0', 20, 'Flower Veil' , 'Symbiosis', 0.1, 0.2, 0.1, 0, 4 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 711, q'|Super Size|' , 'Amorphous' , 'Ghost', 'Grass', q'{Head and a base}', 'Brown' , 0, '1:1', 20, 'Pickup', 'Frisk', 'Insomnia', 39, 86, 1.7, 5, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 404 , 'Field' , 'Electric' , q'{Quadruped body}', 'Blue' , 0, '1:1', 20, 'Rivalry', 'Intimidate', 'Guts', 30.5, 67.2, 0.9, 2, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 481 , 'Undiscovered' , 'Psychic' , q'{Bipedal, tailed form}', 'Pink' , 0, 'GU', 80, 'Levitate' , 0.3, 0.7, 0.3, 1, 0 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 647, q'|Ordinary Form|' , 'Undiscovered' , 'Water', 'Fighting', q'{Quadruped body}', 'Yellow' , 0, 'GU', 80, 'Justified' , 48.5, 106.9, 1.4, 4, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 10 , 'Bug' , 'Bug' , q'{Insectoid body}', 'Green', 15, 15, 0, '1:1', 15, 'Shield Dust' , 'Run Away', 2.9, 6.4, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 568 , 'Mineral' , 'Poison' , q'{Bipedal, tailless form}', 'Green', 9, 9, 0, '1:1', 20, 'Stench', 'Sticky Hold', 'Aftermath', 31, 68.3, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 760 , 'Field' , 'Normal', 'Fighting', q'{Bipedal, tailed form}', 'Pink', 6, 6, 0, '1:1', 15, 'Fluffy', 'Klutz', 'Unnerve', 135, 297.6, 2.1, 6, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 316 , 'Amorphous' , 'Poison' , q'{Head and arms}', 'Green' , 0, '1:1', 20, 'Liquid Ooze', 'Sticky Hold', 'Gluttony', 10.3, 22.7, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 471 , 'Field' , 'Ice' , q'{Quadruped body}', 'Blue' , 0, '1:7', 35, 'Snow Cloak' , 'Ice Body', 25.9, 57.1, 0.8, 2, 7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 751 , 'Water 1', 'Bug', 'Water', 'Bug', q'{Head and legs}', 'Green', 9, 9, 0, '1:1', 15, 'Water Bubble' , 'Water Absorb', 4, 8.8, 0.3, 1, 0 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 645, q'|Therian Forme|', 'T' , 'Undiscovered' , 'Ground', 'Flying', q'{Quadruped body}', 'Brown' , 0, '0:1U', 120, 'Intimidate' , 68, 149.9, 1.3, 4, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 92 , 'Amorphous' , 'Ghost', 'Poison', q'{Head}', 'Purple', 9, 9, 0, '1:1', 20, 'Levitate' , 0.1, 0.2, 1.3, 4, 3 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 423, q'|East Sea|', 'E' , 'Water 1', 'Amorphous', 'Water', 'Ground', q'{Serpentine bodies}', 'Blue', 6, 6, 0, '1:1', 20, 'Sticky Hold', 'Storm Drain', 'Sand Force', 29.9, 65.9, 0.9, 2, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 46 , 'Bug', 'Grass', 'Bug', 'Grass', q'{Insectoid body}', 'Red', 9, 9, 2, '1:1', 20, 'Effect Spore', 'Dry Skin', 'Damp', 5.4, 11.9, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 5 , 'Monster', 'Dragon', 'Fire' , q'{Bipedal, tailed form}', 'Red' , 0, '1:7', 20, 'Blaze' , 'Solar Power', 19, 41.9, 1.1, 3, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 405 , 'Field' , 'Electric' , q'{Quadruped body}', 'Blue' , 0, '1:1', 20, 'Rivalry', 'Intimidate', 'Guts', 42, 92.6, 1.4, 4, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 310 , 'Field' , 'Electric' , q'{Quadruped body}', 'Yellow' , 6, 0, '1:1', 20, 'Static', 'Lightning Rod', 'Minus', 40.2, 88.6, 1.5, 4, 11 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 308, q'|Mega|', 'M', q'|Medichamite|', 'Human-Like' , 'Fighting', 'Psychic', q'{Bipedal, tailless form}', 'Red' , 0, '1:1', 20, 'Pure Power' , 31.5, 69.4, 1.3, 4, 3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 25, q'|Pikachu, Ph. D|' , 'Field', 'Fairy', 'Electric' , q'{Quadruped body}', 'Yellow', 6, 6, 0, '1:1', 10, 'Static' , 'Lightning Rod', 6, 13.2, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 132 , 'Ditto' , 'Normal' , q'{Head}', 'Purple', 9, 9, 0, 'G*', 20, 'Limber' , 'Imposter', 4, 8.8, 0.3, 1, 0 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 531, q'|Mega|', 'M', q'|Audinite|', 'Fairy' , 'Normal', 'Fairy', q'{Bipedal, tailed form}', 'White' , 0, '1:1', 20, 'Healer' , 31, 68.3, 1.5, 4, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 605 , 'Human-Like' , 'Psychic' , q'{Bipedal, tailed form}', 'Blue' , 15, 0, '1:1', 20, 'Telepathy', 'Synchronize', 'Analytic', 9, 19.8, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 454 , 'Human-Like' , 'Poison', 'Fighting', q'{Bipedal, tailless form}', 'Blue' , 0, '1:1', 20, 'Anticipation', 'Dry Skin', 'Poison Touch', 44.4, 97.9, 1.3, 4, 3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 550, q'|Red-Striped Form|' , 'Water 2' , 'Water' , q'{Fins}', 'Green' , 9, 0, '1:1', 40, 'Reckless', 'Adaptability', 'Mold Breaker', 18, 39.7, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 296 , 'Human-Like' , 'Fighting' , q'{Bipedal, tailless form}', 'Yellow', 9, 9, 0, '1:3', 20, 'Thick Fat', 'Guts', 'Sheer Force', 86.4, 190.5, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 504 , 'Field' , 'Normal' , q'{Quadruped body}', 'Brown' , 0, '1:1', 15, 'Run Away', 'Keen Eye', 'Analytic', 11.6, 25.6, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 410 , 'Monster' , 'Rock', 'Steel', q'{Quadruped body}', 'Gray' , 0, '1:7', 30, 'Sturdy' , 'Soundproof', 57, 125.7, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 13 , 'Bug' , 'Bug', 'Poison', q'{Insectoid body}', 'Brown' , 0, '1:1', 15, 'Shield Dust' , 'Run Away', 3.2, 7.1, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 221 , 'Field' , 'Ice', 'Ground', q'{Quadruped body}', 'Brown' , 2, '1:1', 20, 'Oblivious', 'Snow Cloak', 'Thick Fat', 55.8, 123, 1.1, 3, 7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 676, q'|Heart Trim|' , 'Field' , 'Normal' , q'{Quadruped body}', 'White' , 6, 0, '1:1', 20, 'Fur Coat' , 28, 61.7, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 570 , 'Field' , 'Dark' , q'{Quadruped body}', 'Gray' , 9, 0, '1:7', 25, 'Illusion' , 12.5, 27.6, 0.7, 2, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 380 , 'Undiscovered' , 'Dragon', 'Psychic', q'{Single pair of wings}', 'Red' , 0, '1:0U', 120, 'Levitate' , 40, 88.2, 1.4, 4, 7 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 373, q'|Mega|', 'M', q'|Salamencite|', 'Dragon' , 'Dragon', 'Flying', q'{Quadruped body}', 'Blue', 0, 0, 0, '1:1', 40, 'Aerilate' , 102.6, 226.2, 1.8, 5, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 588 , 'Bug' , 'Bug' , q'{Bipedal, tailless form}', 'Blue' , 0, '1:1', 15, 'Swarm', 'Shed Skin', 'No Guard', 5.9, 13, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 390 , 'Field', 'Human-Like', 'Fire' , q'{Bipedal, tailed form}', 'Brown' , 0, '1:7', 20, 'Blaze' , 'Iron Fist', 6.2, 13.7, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 336 , 'Field', 'Dragon', 'Poison' , q'{Serpentine bodies}', 'Black' , 0, '1:1', 20, 'Shed Skin' , 'Infiltrator', 52.5, 115.7, 2.7, 8, 10 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 769 , 'Amorphous' , 'Ghost', 'Ground', q'{Serpentine bodies}', 'Brown', 9, 9, 0, '1:1', 15, 'Water Compaction' , 'Sand Veil', 70, 154.3, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 737 , 'Bug' , 'Bug', 'Electric', q'{Serpentine bodies}', 'Green', 15, 15, 0, '1:1', 15, 'Battery' , 10.5, 23.1, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 291 , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'Yellow' , 0, '1:1', 15, 'Speed Boost' , 'Infiltrator', 12, 26.5, 0.8, 2, 7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 493, q'|Type: Dark|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Multitype' , 320, 705.5, 3.2, 10, 6 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 445 , 'Monster', 'Dragon', 'Dragon', 'Ground', q'{Bipedal, tailed form}', 'Blue' , 0, '1:1', 40, 'Sand Veil' , 'Rough Skin', 95, 209.4, 1.9, 6, 3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 369 , 'Water 1', 'Water 2', 'Water', 'Rock', q'{Fins}', 'Gray', 3, 3, 0, '1:7', 40, 'Swift Swim', 'Rock Head', 'Sturdy', 23.4, 51.6, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 131 , 'Monster', 'Water 1', 'Water', 'Ice', q'{Fins}', 'Blue', 3, 3, 0, '1:1', 40, 'Water Absorb', 'Shell Armor', 'Hydration', 220, 485, 2.5, 8, 2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 505 , 'Field' , 'Normal' , q'{Bipedal, tailed form}', 'Brown' , 0, '1:1', 20, 'Illuminate', 'Keen Eye', 'Analytic', 27, 59.5, 1.1, 3, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 529 , 'Field' , 'Ground' , q'{Bipedal, tailed form}', 'Gray' , 0, '1:1', 20, 'Sand Rush', 'Sand Force', 'Mold Breaker', 8.5, 18.7, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 730 , 'Water 1', 'Field', 'Water', 'Fairy', q'{Fins}', 'Blue' , 0, '1:7', 15, 'Torrent' , 'Liquid Voice', 44, 97, 1.8, 5, 11 );
insert into SPECIES( DEX, CLASS , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 25, q'|Pop Star|' , 'Field', 'Fairy', 'Electric' , q'{Quadruped body}', 'Yellow', 6, 6, 0, '1:1', 10, 'Static' , 'Lightning Rod', 6, 13.2, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 318 , 'Water 2' , 'Water', 'Dark', q'{Fins}', 'Red', 9, 9, 0, '1:1', 20, 'Rough Skin' , 'Speed Boost', 20.8, 45.9, 0.8, 2, 7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 79 , 'Monster', 'Water 1', 'Water', 'Psychic', q'{Quadruped body}', 'Pink', 9, 9, 0, '1:1', 20, 'Oblivious', 'Own Tempo', 'Regenerator', 36, 79.4, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 448 , 'Field', 'Human-Like', 'Fighting', 'Steel', q'{Bipedal, tailed form}', 'Blue', 0, 0, 0, '1:7', 25, 'Steadfast', 'Inner Focus', 'Justified', 54, 119, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 695 , 'Monster', 'Dragon', 'Electric', 'Normal', q'{Bipedal, tailed form}', 'Yellow' , 0, '1:1', 20, 'Dry Skin', 'Sand Veil', 'Solar Power', 21, 46.3, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 785 , 'Undiscovered' , 'Electric', 'Fairy', q'{Head and arms}', 'Yellow' , 0, 'GU', 15, 'Electric Surge' , 'Telepathy', 20.5, 45.2, 1.8, 5, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 398 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Brown' , 0, '1:1', 15, 'Intimidate' , 'Reckless', 24.9, 54.9, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 181 , 'Monster', 'Field', 'Electric' , q'{Bipedal, tailed form}', 'Yellow' , 0, '1:1', 20, 'Static' , 'Plus', 61.5, 135.6, 1.4, 4, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 305 , 'Monster' , 'Steel', 'Rock', q'{Quadruped body}', 'Gray' , 0, '1:1', 35, 'Sturdy', 'Rock Head', 'Heavy Metal', 120, 264.6, 0.9, 2, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 282 , 'Amorphous' , 'Psychic', 'Fairy', q'{Bipedal, tailless form}', 'White' , 0, '1:1', 20, 'Synchronize', 'Trace', 'Telepathy', 48.4, 106.7, 1.6, 5, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 168 , 'Bug' , 'Bug', 'Poison', q'{Insectoid body}', 'Red', 6, 6, 0, '1:1', 15, 'Swarm', 'Insomnia', 'Sniper', 33.5, 73.9, 1.1, 3, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 77 , 'Field' , 'Fire' , q'{Quadruped body}', 'Yellow' , 0, '1:1', 20, 'Run Away', 'Flash Fire', 'Flame Body', 30, 66.1, 1, 3, 3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 773, q'|Type: Poison|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'RKS System' , 100.5, 221.6, 2.3, 7, 7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 25, q'|Kalos Cap|' , 'Field', 'Fairy', 'Electric' , q'{Quadruped body}', 'Yellow', 6, 6, 0, '1:1', 10, 'Static' , 'Lightning Rod', 6, 13.2, 0.4, 1, 4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 149 , 'Water 1', 'Dragon', 'Dragon', 'Flying', q'{Bipedal, tailed form}', 'Brown', 0, 0, 0, '1:1', 40, 'Inner Focus' , 'Multiscale', 210, 463, 2.2, 7, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 754 , 'Grass' , 'Grass' , q'{Bipedal, tailless form}', 'Pink', 3, 3, 0, '1:1', 20, 'Leaf Guard' , 'Contrary', 18.5, 40.8, 0.9, 2, 11 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 57 , 'Field' , 'Fighting' , q'{Bipedal, tailed form}', 'Brown', 6, 6, 2, '1:1', 20, 'Vital Spirit', 'Anger Point', 'Defiant', 32, 70.5, 1, 3, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 739 , 'Water 3' , 'Fighting' , q'{Insectoid body}', 'Purple', 9, 9, 0, '1:1', 20, 'Hyper Cutter', 'Iron Fist', 'Anger Point', 7, 15.4, 0.6, 2, 0 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 413, q'|Trash Cloak|', 'S' , 'Bug' , 'Bug', 'Steel', q'{Head and a base}', 'Red' , 0, '1:0', 15, 'Anticipation' , 'Overcoat', 6.5, 14.3, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 160 , 'Monster', 'Water 1', 'Water' , q'{Bipedal, tailed form}', 'Blue' , 0, '1:7', 20, 'Torrent' , 'Sheer Force', 88.8, 195.8, 2.3, 7, 7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 666, q'|Tundra Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 37.5, 1.2, 3, 11 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 670, q'|Eternal Flower|' , 'Fairy' , 'Fairy' , q'{Head and arms}', 'White' , 0, 0, '1:0', 20, 'Flower Veil' , 'Symbiosis', 0.9, 2, 0.2, 0, 8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 364 , 'Water 1', 'Field', 'Ice', 'Water', q'{Fins}', 'Blue' , 2, '1:1', 20, 'Thick Fat', 'Ice Body', 'Oblivious', 87.6, 193.1, 1.1, 3, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 200 , 'Amorphous' , 'Ghost' , q'{Head}', 'Gray', 9, 9, 0, '1:1', 25, 'Levitate' , 1, 2.2, 0.7, 2, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 50 , 'Field' , 'Ground' , q'{Head and a base}', 'Brown', 9, 9, 0, '1:1', 20, 'Sand Veil', 'Arena Trap', 'Sand Force', 0.8, 1.8, 0.2, 0, 8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 223 , 'Water 1', 'Water 2', 'Water' , q'{Fins}', 'Gray' , 3, 2, '1:1', 20, 'Hustle', 'Sniper', 'Moody', 12, 26.5, 0.6, 2, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 636 , 'Bug' , 'Bug', 'Fire', q'{Insectoid body}', 'White' , 3, 0, '1:1', 40, 'Flame Body' , 'Swarm', 28.8, 63.5, 1.1, 3, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 673 , 'Field' , 'Grass' , q'{Quadruped body}', 'Brown' , 0, '1:1', 20, 'Sap Sipper' , 'Grass Pelt', 91, 200.6, 1.7, 5, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 536 , 'Water 1' , 'Water', 'Ground', q'{Bipedal, tailed form}', 'Blue' , 0, '1:1', 20, 'Swift Swim', 'Hydration', 'Water Absorb', 17, 37.5, 0.8, 2, 7 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 115, q'|Mega|', 'M', q'|Kangaskhanite|', 'Monster' , 'Normal' , q'{Bipedal, tailed form}', 'Brown', 3, 3, 0, '1:0', 20, 'Parental Bond' , 80, 176.4, 2.2, 7, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 731 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Black', 15, 15, 0, '1:1', 15, 'Keen Eye', 'Skill Link', 'Pickup', 1.2, 2.6, 0.3, 1, 0 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 627 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'White', 9, 9, 0, '0:1', 20, 'Keen Eye', 'Sheer Force', 'Hustle', 10.5, 23.1, 0.5, 1, 8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 119 , 'Water 2' , 'Water' , q'{Fins}', 'Red', 6, 6, 0, '1:1', 20, 'Swift Swim', 'Water Veil', 'Lightning Rod', 39, 86, 1.3, 4, 3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 594 , 'Water 1', 'Water 2', 'Water' , q'{Fins}', 'Pink', 6, 6, 0, '1:1', 40, 'Healer', 'Hydration', 'Regenerator', 31.6, 69.7, 1.2, 3, 11 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 342 , 'Water 1', 'Water 3', 'Water', 'Dark', q'{Insectoid body}', 'Red' , 6, 0, '1:1', 15, 'Hyper Cutter', 'Shell Armor', 'Adaptability', 32.8, 72.3, 1.1, 3, 7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 669, q'|Yellow Flower|' , 'Fairy' , 'Fairy' , q'{Head and arms}', 'White' , 15, 0, '1:0', 20, 'Flower Veil' , 'Symbiosis', 0.1, 0.2, 0.1, 0, 4 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, WEIGHTLBS, HEIGHT_M, HEIGHT_FT, HEIGHT_IN )
values( 711, q'|Large Size|' , 'Amorphous' , 'Ghost', 'Grass', q'{Head and a base}', 'Brown' , 0, '1:1', 20, 'Pickup', 'Frisk', 'Insomnia', 14, 30.9, 1.1, 3, 7 );
--=REGEXREPLACE(JOIN(", ",A2:A17),"(\w+)","items.$0 ITEM_$0")
create or replace view mix as(
	select pokemon.NAME, pokemon.DEX, species.CLASS, species.DEX_SUFFIX,
		--body.*,
body.BODY BODY_BODY, body.PARENT BODY_PARENT, body.DESCRIPTION BODY_DESCRIPTION, body.ID BODY_ID,
		--items.*,
items.NAME ITEM_NAME, items.GEN ITEM_GEN, items.GEN2 ITEM_GEN2, items.DESCRIPTION ITEM_DESCRIPTION, items.NOTE ITEM_NOTE, items.JAPANESE_KANA ITEM_JAPANESE_KANA, items.JAPANESE_ROMAJI ITEM_JAPANESE_ROMAJI, items.FRENCH ITEM_FRENCH, items.GERMAN ITEM_GERMAN, items.ITALIAN ITEM_ITALIAN, items.SPANISH ITEM_SPANISH, items.KOREAN_HANGUL ITEM_KOREAN_HANGUL, items.KOREAN_ROMANIZED ITEM_KOREAN_ROMANIZED, items.CHINESE_HANZI ITEM_CHINESE_HANZI, items.CHINESE_ROMANIZED ITEM_CHINESE_ROMANIZED, items.STAR ITEM_STAR,
--eggGroups.*,
eggGroups.NAME EGG_GROUP_NAME, eggGroups.TYPE_ALIAS EGG_GROUP_TYPE_ALIAS, eggGroups.URL EGG_GROUP_URL,
--eggGroups2.*,
eggGroups2.NAME EGG_GROUP2_NAME, eggGroups2.TYPE_ALIAS EGG_GROUP2_TYPE_ALIAS, eggGroups2.URL EGG_GROUP2_URL,
--types.*,
types.TYPE TYPE_TYPE, types.DESCRIPTION TYPE_DESCRIPTION, types.ATK_SE TYPE_ATK_SE, types.ATK_NVE TYPE_ATK_NVE, types.ATK_NE TYPE_ATK_NE, types.DEF_SE TYPE_DEF_SE, types.DEF_NVE TYPE_DEF_NVE, types.DEF_NE TYPE_DEF_NE, types.URL TYPE_URL,
--types2.*,
types2.TYPE TYPE2_TYPE, types2.DESCRIPTION TYPE2_DESCRIPTION, types2.ATK_SE TYPE2_ATK_SE, types2.ATK_NVE TYPE2_ATK_NVE, types2.ATK_NE TYPE2_ATK_NE, types2.DEF_SE TYPE2_DEF_SE, types2.DEF_NVE TYPE2_DEF_NVE, types2.DEF_NE TYPE2_DEF_NE, types2.URL TYPE2_URL,
		--gender_ratio.*,
gender_ratio.KEY GENDER_RATIO_KEY, gender_ratio.MALE GENDER_RATIO_MALE, gender_ratio.FEMALE GENDER_RATIO_FEMALE, gender_ratio.UNBREEDABLE GENDER_RATIO_UNBREEDABLE,
--ability.*,
ability.ID ABILITY_ID, ability.NAME ABILITY_NAME, ability.EFFECT ABILITY_EFFECT, ability.GENERATION ABILITY_GENERATION, ability.SINGLE ABILITY_SINGLE, ability.DUAL ABILITY_DUAL, ability.HIDDEN ABILITY_HIDDEN, ability.JAPANESE_KANA ABILITY_JAPANESE_KANA, ability.JAPANESE_ROMAJI ABILITY_JAPANESE_ROMAJI, ability.FRENCH ABILITY_FRENCH, ability.GERMAN ABILITY_GERMAN, ability.ITALIAN ABILITY_ITALIAN, ability.SPANISH ABILITY_SPANISH, ability.KOREAN_HANGUL ABILITY_KOREAN_HANGUL, ability.KOREAN_ROMANIZED ABILITY_KOREAN_ROMANIZED, ability.CHINESE_HANZI ABILITY_CHINESE_HANZI, ability.CHINESE_ROMANIZED ABILITY_CHINESE_ROMANIZED,
--ability2.*,
ability2.ID ABILITY2_ID, ability2.NAME ABILITY2_NAME, ability2.EFFECT ABILITY2_EFFECT, ability2.GENERATION ABILITY2_GENERATION, ability2.SINGLE ABILITY2_SINGLE, ability2.DUAL ABILITY2_DUAL, ability2.HIDDEN ABILITY2_HIDDEN, ability2.JAPANESE_KANA ABILITY2_JAPANESE_KANA, ability2.JAPANESE_ROMAJI ABILITY2_JAPANESE_ROMAJI, ability2.FRENCH ABILITY2_FRENCH, ability2.GERMAN ABILITY2_GERMAN, ability2.ITALIAN ABILITY2_ITALIAN, ability2.SPANISH ABILITY2_SPANISH, ability2.KOREAN_HANGUL ABILITY2_KOREAN_HANGUL, ability2.KOREAN_ROMANIZED ABILITY2_KOREAN_ROMANIZED, ability2.CHINESE_HANZI ABILITY2_CHINESE_HANZI, ability2.CHINESE_ROMANIZED ABILITY2_CHINESE_ROMANIZED,
--hidden_ability.*,
hidden_ability.ID HIDDEN_ABILITY_ID, hidden_ability.NAME HIDDEN_ABILITY_NAME, hidden_ability.EFFECT HIDDEN_ABILITY_EFFECT, hidden_ability.GENERATION HIDDEN_ABILITY_GENERATION, hidden_ability.SINGLE HIDDEN_ABILITY_SINGLE, hidden_ability.DUAL HIDDEN_ABILITY_DUAL, hidden_ability.HIDDEN HIDDEN_ABILITY_HIDDEN, hidden_ability.JAPANESE_KANA HIDDEN_ABILITY_JAPANESE_KANA, hidden_ability.JAPANESE_ROMAJI HIDDEN_ABILITY_JAPANESE_ROMAJI, hidden_ability.FRENCH HIDDEN_ABILITY_FRENCH, hidden_ability.GERMAN HIDDEN_ABILITY_GERMAN, hidden_ability.ITALIAN HIDDEN_ABILITY_ITALIAN, hidden_ability.SPANISH HIDDEN_ABILITY_SPANISH, hidden_ability.KOREAN_HANGUL HIDDEN_ABILITY_KOREAN_HANGUL, hidden_ability.KOREAN_ROMANIZED HIDDEN_ABILITY_KOREAN_ROMANIZED, hidden_ability.CHINESE_HANZI HIDDEN_ABILITY_CHINESE_HANZI, hidden_ability.CHINESE_ROMANIZED HIDDEN_ABILITY_CHINESE_ROMANIZED,
		pokemon.PAGE, pokemon.HABITAT, pokemon.LDEX, pokemon.LDEX_SUFFIX,
--generation.*
generation.GEN GENERATION_GEN, generation.REGION GENERATION_REGION, generation.DEX_MIN GENERATION_DEX_MIN, generation.DEX_MAX GENERATION_DEX_MAX, generation.LDEX_MIN GENERATION_LDEX_MIN, generation.LDEX_MAX GENERATION_LDEX_MAX
	from
	species inner join pokemon
		on species.DEX=pokemon.DEX
	left join eggGroups
		on species.EGGGROUP1=eggGroups.NAME
	left join eggGroups eggGroups2
		on species.EGGGROUP2=eggGroups2.NAME
	left join types
		on species.TYPE=types.TYPE
	left join types types2
		on species.TYPE2=types2.TYPE
	left join body
		on species.BODY=body.BODY
	inner join gender_ratio
		on species.GENDER_RATIO=gender_ratio.key
	inner join ability
		on species.ABILITY1=ability.NAME
	left join ability ability2
		on species.ABILITY2=ability.NAME
	left join ability hidden_ability
		on species.HIDDEN_ABILITY=ability.NAME
	inner join generation
		on pokemon.GEN=generation.GEN
	left join items
		on species.ITEM=items.NAME
);

