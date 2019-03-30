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
DISCRIPTION clob, --An expanded explination of the form
ID number(2,0) unique --The ID of the body type according to the images used
);
create table GENERATION(
GEN number(3,1) primary key, --The generation number
REGION varchar2(100), --The main region that the generation belongs to
DEX_MIN number(4,0), --The lowest DEX value in the generation
DEX_MAX number(4,0), --The highest DEX value in the generation
LDEX_MIN number(3,0), --The lowest Local DEX value in the generation
LDEX_MAX number(3,0), --The highest Local DEX value in the generation
CONSTRAINT ck_DEX_RANGE check(DEX_MIN<DEX_MAX), --Ensure the range is valid
CONSTRAINT ck_LDEX_RANGE check(LDEX_MIN<LDEX_MAX) --Ensure the range is valid
);
create table GENDER_RATIO(
KEY varchar2(6) primary key, --The auto generated key to refference the ratio
MALE number(2,0), --The male part of the ratio
FEMALE number(2,0), --The female part of the ratio
UNBREEDABLE char(1) default on null 'F' check(unbreedable in('T', 'F', '*')), --Indicates if they are unbreeadable
CONSTRAINT un_KEY unique(MALE, FEMALE, UNBREEDABLE) --Ensure Key will produce a valid primary key
);-- BEGIN TYPE PL/SQL
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
for each row when(new.KEY is not null)
begin
:new.KEY:= :new.MALE||':'||:new.FEMALE||
case :new.UNBREEDABLE
when 'T' then 'U'
when '*' then '*'
else ''
end;
end;
/

insert into Types(TYPE, ATK_NVE, ATK_NE)
values('Normal', q'|["Rock", "Steel"]|', q'|["Ghost"]|');
insert into Types(TYPE, ATK_SE, ATK_NVE, ATK_NE)
values('Fighting', q'|["Dark", "Ice", "Normal", "Rock", "Steel"]|', q'|["Bug", "Fairy", "Flying", "Poison", "Psychic"]|', q'|["Ghost"]|');
insert into Types(TYPE, ATK_SE, ATK_NVE)
values('Flying', q'|["Bug", "Fighting", "Grass"]|', q'|["Electric", "Rock", "Steel"]|');
insert into Types(TYPE, ATK_SE, ATK_NVE, ATK_NE)
values('Poison', q'|["Fairy", "Grass"]|', q'|["Poison", "Ground", "Rock", "Ghost"]|', q'|["Steel"]|');
insert into Types(TYPE, ATK_SE, ATK_NVE, ATK_NE)
values('Ground', q'|["Electric", "Fire", "Poison", "Rock", "Steel"]|', q'|["Bug", "Grass"]|', q'|["Flying"]|');
insert into Types(TYPE, ATK_SE, ATK_NVE)
values('Rock', q'|["Bug", "Fire", "Flying", "Ice"]|', q'|["Fighting", "Ground"]|');
insert into Types(TYPE, ATK_SE, ATK_NVE)
values('Bug', q'|["Dark", "Grass", "Psychic"]|', q'|["Fairy", "Fighting", "Fire", "Flying", "Ghost", "Poison", "Steel"]|');
insert into Types(TYPE, ATK_SE, ATK_NVE, ATK_NE)
values('Ghost', q'|["Ghost", "Psychic"]|', q'|["Dark"]|', q'|["Normal"]|');
insert into Types(TYPE, ATK_SE, ATK_NVE)
values('Steel', q'|["Fairy", "Ice", "Rock"]|', q'|["Electric", "Fire", "Steel", "Rock"]|');
insert into Types(TYPE, ATK_SE, ATK_NVE)
values('Fire', q'|["Bug", "Grass", "Ice", "Steel"]|', q'|["Dragon", "Fire", "Rock", "Water"]|');
insert into Types(TYPE, ATK_SE, ATK_NVE)
values('Water', q'|["Fire", "Ground", "Rock"]|', q'|["Dragon", "Grass", "Water"]|');
insert into Types(TYPE, ATK_SE, ATK_NVE)
values('Grass', q'|["Ground", "Rock", "Water"]|', q'|["Bug", "Dragon", "Fire", "Flying", "Grass", "Poison", "Steel"]|');
insert into Types(TYPE, ATK_SE, ATK_NVE, ATK_NE)
values('Electric', q'|["Flying", "Water"]|', q'|["Dragon", "Electric", "Grass"]|', q'|["Ground"]|');
insert into Types(TYPE, ATK_SE, ATK_NVE, ATK_NE)
values('Psychic', q'|["Fighting", "Poison"]|', q'|["Psychic", "Steel"]|', q'|["Dark"]|');
insert into Types(TYPE, ATK_SE, ATK_NVE)
values('Ice', q'|["Dragon", "Flying", "Grass", "Ground"]|', q'|["Fire", "Ice", "Steel", "Water"]|');
insert into Types(TYPE, ATK_SE, ATK_NVE, ATK_NE)
values('Dragon', q'|["Dragon"]|', q'|["Steel"]|', q'|["Fairy"]|');
insert into Types(TYPE, ATK_SE, ATK_NVE)
values('Dark', q'|["Ghost", "Psychic"]|', q'|["Dark", "Fairy", "Fighting"]|');
insert into Types(TYPE, ATK_SE, ATK_NVE)
values('Fairy', q'|["Dark", "Dragon", "Fighting"]|', q'|["Fire", "Poison", "Steel"]|');

insert into eggGroups(NAME)
values('Monster');
insert into eggGroups(NAME, TYPE_ALIAS)
values('Water 1', 'Water');
insert into eggGroups(NAME, TYPE_ALIAS)
values('Bug', 'Bug');
insert into eggGroups(NAME, TYPE_ALIAS)
values('Flying', 'Flying');
insert into eggGroups(NAME)
values('Field');
insert into eggGroups(NAME, TYPE_ALIAS)
values('Fairy', 'Fairy');
insert into eggGroups(NAME, TYPE_ALIAS)
values('Grass', 'Grass');
insert into eggGroups(NAME)
values('Undiscovered');
insert into eggGroups(NAME)
values('Gender unknown');
insert into eggGroups(NAME)
values('Human-Like');
insert into eggGroups(NAME, TYPE_ALIAS)
values('Water 3', 'Water');
insert into eggGroups(NAME)
values('Mineral');
insert into eggGroups(NAME)
values('Amorphous');
insert into eggGroups(NAME, TYPE_ALIAS)
values('Water 2', 'Water');
insert into eggGroups(NAME, TYPE_ALIAS)
values('Ditto', 'Normal');
insert into eggGroups(NAME, TYPE_ALIAS)
values('Dragon', 'Dragon');

insert into BODY(BODY, DISCRIPTION, ID)
values('Bipedal, tailless form', q'|With a bipedal, tailless form|', 12);
insert into BODY(BODY, PARENT, DISCRIPTION, ID)
values('Bipedal, tailed form', 'Bipedal, tailless form', q'|With a bipedal, tailed form|', 6);
insert into BODY(BODY, DISCRIPTION, ID)
values('Fins', q'|With fins|', 3);
insert into BODY(BODY, DISCRIPTION, ID)
values('Head', q'|Consisting of only a head|', 1);
insert into BODY(BODY, PARENT, DISCRIPTION, ID)
values('Head and a base', 'Head', q'|Consisting of a head and a base|', 5);
insert into BODY(BODY, PARENT, DISCRIPTION, ID)
values('Head and arms', 'Head and a base', q'|Consisting of a head and arms|', 4);
insert into BODY(BODY, PARENT, DISCRIPTION, ID)
values('Head and legs', 'Head and a base', q'|Consisting of a head and legs|', 7);
insert into BODY(BODY, DISCRIPTION, ID)
values('Insectoid body', q'|With an insectoid body|', 14);
insert into BODY(BODY, DISCRIPTION, ID)
values('Multiple bodies', q'|Consisting of multiple bodies|', 11);
insert into BODY(BODY, DISCRIPTION, ID)
values('Quadruped body', q'|With a quadruped body|', 8);
insert into BODY(BODY, DISCRIPTION, ID)
values('Serpentine bodies', q'|With serpentine bodies|', 2);
insert into BODY(BODY, DISCRIPTION, ID)
values('Single pair of wings', q'|With a single pair of wings|', 9);
insert into BODY(BODY, PARENT, DISCRIPTION, ID)
values('Two or more pairs of wings', 'Single pair of wings', q'|With two or more pairs of wings|', 13);
insert into BODY(BODY, DISCRIPTION, ID)
values('Tentacles or a multiped body', q'|With tentacles or a multiped body|', 10);

insert into GENERATION(GEN, REGION, DEX_MIN, DEX_MAX, LDEX_MIN, LDEX_MAX)
values(1, 'Kanto', 1, 151, 1, 151);
insert into GENERATION(GEN, REGION, DEX_MIN, DEX_MAX, LDEX_MIN, LDEX_MAX)
values(2, 'Johto', 152, 251, 1, 256);
insert into GENERATION(GEN, REGION, DEX_MIN, DEX_MAX, LDEX_MIN, LDEX_MAX)
values(3, 'Hoenn', 252, 386, 1, 386);
insert into GENERATION(GEN, REGION, DEX_MIN, DEX_MAX, LDEX_MIN, LDEX_MAX)
values(4, 'Sinnoh', 387, 487, 1, 210);
insert into GENERATION(GEN, REGION, DEX_MIN, DEX_MAX, LDEX_MIN, LDEX_MAX)
values(5, 'Unova', 494, 649, 0, 155);
insert into GENERATION(GEN, REGION, DEX_MIN, DEX_MAX, LDEX_MIN, LDEX_MAX)
values(5.1, 'New Unova', 494, 649, 0, 300);
insert into GENERATION(GEN, REGION, DEX_MIN, DEX_MAX, LDEX_MIN, LDEX_MAX)
values(6, 'Kalos', 650, 718, 1, 151);
insert into GENERATION(GEN, REGION, DEX_MIN, DEX_MAX, LDEX_MIN, LDEX_MAX)
values(7, 'Alola', 722, 802, 1, 302);
insert into GENERATION(GEN, REGION, DEX_MIN, DEX_MAX, LDEX_MIN, LDEX_MAX)
values(7.1, 'AlolaUSUM', 722, 807, 1, 403);

insert into GENDER_RATIO(MALE, FEMALE)
values(1, 0);
insert into GENDER_RATIO(MALE, FEMALE, UNBREEDABLE)
values(1, 0, 'T');
insert into GENDER_RATIO(MALE, FEMALE)
values(7, 1);
insert into GENDER_RATIO(MALE, FEMALE, UNBREEDABLE)
values(7, 1, 'T');
insert into GENDER_RATIO(MALE, FEMALE)
values(3, 1);
insert into GENDER_RATIO(MALE, FEMALE, UNBREEDABLE)
values(3, 1, 'T');
insert into GENDER_RATIO(MALE, FEMALE)
values(1, 1);
insert into GENDER_RATIO(MALE, FEMALE, UNBREEDABLE)
values(1, 1, 'T');
insert into GENDER_RATIO(MALE, FEMALE)
values(1, 3);
insert into GENDER_RATIO(MALE, FEMALE, UNBREEDABLE)
values(1, 3, 'T');
insert into GENDER_RATIO(MALE, FEMALE)
values(1, 7);
insert into GENDER_RATIO(MALE, FEMALE, UNBREEDABLE)
values(1, 7, 'T');
insert into GENDER_RATIO(MALE, FEMALE)
values(0, 1);
insert into GENDER_RATIO(MALE, FEMALE, UNBREEDABLE)
values(0, 1, 'T');
insert into GENDER_RATIO(KEY)
values('G');
insert into GENDER_RATIO(KEY, UNBREEDABLE)
values('GU', 'T');
insert into GENDER_RATIO(KEY, UNBREEDABLE)
values('G*', '*');begin
TYPE_FINAL();
end;
/create table ABILITY(
ID number(3,0) unique, --The identification number of the ability
NAME varchar2(30) primary key, --The name of the ability
EFFECT varchar2(1000), --The effect of the ability
GENERATION number(2,0) references GENERATION(GEN), --The generation of the ability
SINGLE number(2,0), --???
DUAL number(2,0), --???
HIDDEN number(2,0), --???
JAPANESE_KANA nvarchar2(100), --The name of the ability in JAPANESE_KANA
JAPANESE_ROMAJI nvarchar2(100), --The name of the ability in JAPANESE_ROMAJI
FRENCH nvarchar2(100), --The name of the ability in FRENCH
GERMAN nvarchar2(100), --The name of the ability in GERMAN
ITALIAN nvarchar2(100), --The name of the ability in ITALIAN
SPANISH nvarchar2(100), --The name of the ability in SPANISH
KOREAN_HANGUL nvarchar2(100), --The name of the ability in KOREAN_HANGUL
KOREAN_ROMANIZED nvarchar2(100), --The name of the ability in KOREAN_ROMANIZED
CHINESE_HANZI nvarchar2(100), --The name of the ability in CHINESE_HANZI
CHINESE_ROMANIZED nvarchar2(100) --The name of the ability in CHINESE_ROMANIZED
);

insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH)
values(0, 'Cacophony', q'|Avoids sound-based moves.|', 3, 0, 0, 0, nq'|そうおん|', nq'|Sō On|', nq'|Cacophonie|', nq'|Energieaufladung|', nq'|Cacofonia|', nq'|Cacofonía|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(1, 'Stench', q'|By releasing stench when attacking, this Pokémon may cause the target to flinch.|', 3, 0, 6, 1, nq'|あくしゅう|', nq'|Akushū|', nq'|Puanteur|', nq'|Duftnote|', nq'|Tanfo|', nq'|Hedor|', nq'|악취|', nq'|Akchwi|', nq'|惡臭 / 恶臭|', nq'|Èchòu / Okchau|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(2, 'Drizzle', q'|The Pokémon makes it rain when it enters a battle.|', 3, 1, 1, 1, nq'|あめふらし|', nq'|Amefurashi|', nq'|Crachin|', nq'|Niesel|', nq'|Piovischio|', nq'|Llovizna|', nq'|잔비|', nq'|Janbi|', nq'|降雨|', nq'|Jiàngyǔ / Gongyúh|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(3, 'Speed Boost', q'|Its Speed stat is boosted every turn.|', 3, 2, 2, 8, nq'|かそく|', nq'|Kasoku|', nq'|Turbo|', nq'|Temposchub|', nq'|Acceleratore|', nq'|Impulso|', nq'|가속|', nq'|Gasok|', nq'|加速|', nq'|Jiāsù / Gāchūk|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(4, 'Battle Armor', q'|Hard armor protects the Pokémon from critical hits.|', 3, 3, 4, 2, nq'|カブトアーマー|', nq'|Kabuto Armor|', nq'|Armurbaston|', nq'|Kampfpanzer|', nq'|Lottascudo|', nq'|Armadura Batalla*|', nq'|전투 무장|', nq'|Jeontu Mujang|', nq'|戰鬥盔甲 / 战斗盔甲|', nq'|Zhàndòu Kuījiǎ / Jindau Kwāigaap|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(5, 'Sturdy', q'|It cannot be knocked out with one hit. One-hit KO moves cannot knock it out, either.|', 3, 6, 28, 7, nq'|がんじょう|', nq'|Ganjō|', nq'|Fermeté|', nq'|Robustheit|', nq'|Vigore|', nq'|Robustez|', nq'|옹골참|', nq'|Onggolcham|', nq'|結實 / 结实|', nq'|Jiēshi / Gitsaht|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(6, 'Damp', q'|Prevents the use of explosive moves such as Self-Destruct by dampening its surroundings.|', 3, 0, 8, 10, nq'|しめりけ|', nq'|Shimerike|', nq'|Moiteur|', nq'|Feuchtigkeit|', nq'|Umidità|', nq'|Humedad|', nq'|습기|', nq'|Seupgi|', nq'|濕氣 / 湿气|', nq'|Shīqì / Sāphei|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(7, 'Limber', q'|Its limber body protects the Pokémon from paralysis.|', 3, 1, 9, 2, nq'|じゅうなん|', nq'|Jūnan|', nq'|Échauffement|', nq'|Flexibilität|', nq'|Scioltezza|', nq'|Flexibilidad|', nq'|유연|', nq'|Yuyeon|', nq'|柔軟 / 柔软|', nq'|Róuruǎn / Yàuhyúhn|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(8, 'Sand Veil', q'|Boosts the Pokémon's evasion in a sandstorm.|', 3, 7, 8, 9, nq'|すながくれ|', nq'|Sunagakure|', nq'|Voile Sable|', nq'|Sandschleier|', nq'|Sabbiavelo|', nq'|Velo Arena|', nq'|모래숨기|', nq'|Morae Sumgi|', nq'|沙隱 / 沙隐|', nq'|Shā Yǐn / Sā Yán|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(9, 'Static', q'|The Pokémon is charged with static electricity, so contact with it may cause paralysis.|', 3, 9, 5, 1, nq'|せいでんき|', nq'|Seidenki|', nq'|Statik|', nq'|Statik|', nq'|Statico|', nq'|Elec. Estática*|', nq'|정전기|', nq'|Jeongjeon'gi|', nq'|靜電 / 静电|', nq'|Jìngdiàn / Jihngdihn|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(10, 'Volt Absorb', q'|Restores HP if hit by an Electric-type move, instead of taking damage.|', 3, 3, 2, 2, nq'|ちくでん|', nq'|Chikuden|', nq'|Absorb Volt|', nq'|Voltabsorber|', nq'|Assorbivolt|', nq'|Absorbe Elec*|', nq'|축전|', nq'|Chukjeon|', nq'|蓄電 / 蓄电|', nq'|Xùdiàn / Chūkdihn|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(11, 'Water Absorb', q'|Restores HP if hit by a Water-type move, instead of taking damage.|', 3, 2, 12, 9, nq'|ちょすい|', nq'|Chosui|', nq'|Absorb Eau|', nq'|H2O-Absorber|', nq'|Assorbacqua|', nq'|Absorbe Agua*|', nq'|저수|', nq'|Jeosu|', nq'|儲水 / 储水|', nq'|Chúshuǐ / Chyúhséui|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(12, 'Oblivious', q'|The Pokémon is oblivious, and that keeps it from being infatuated or falling for taunts.|', 3, 0, 19, 5, nq'|どんかん|', nq'|Donkan|', nq'|Benêt|', nq'|Dösigkeit|', nq'|Indifferenza|', nq'|Despiste|', nq'|둔감|', nq'|Dungam|', nq'|遲鈍 / 迟钝|', nq'|Chídùn / Chìhdeuhn|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(13, 'Cloud Nine', q'|Eliminates the effects of weather.|', 3, 0, 2, 5, nq'|ノーてんき|', nq'|Nō Tenki|', nq'|Ciel Gris|', nq'|Wolke Sieben|', nq'|Antimeteo|', nq'|Aclimatación|', nq'|날씨 부정|', nq'|Nalssi Bujeong|', nq'|無關天氣 / 无关天气|', nq'|Wúguān Tiānqì / Mòuhgwāan Tīnhei|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(14, 'Compound Eyes', q'|The Pokémon's compound eyes boost its accuracy.|', 3, 2, 6, 1, nq'|ふくがん|', nq'|Fukugan|', nq'|Œil Composé|', nq'|Facettenauge|', nq'|Insettocchi|', nq'|Ojo Compuesto*|', nq'|복안|', nq'|Bok'an|', nq'|複眼 / 复眼|', nq'|Fùyǎn / Fūkngáahn|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(15, 'Insomnia', q'|The Pokémon is suffering from insomnia and cannot fall asleep.|', 3, 1, 10, 3, nq'|ふみん|', nq'|Fumin|', nq'|Insomnia|', nq'|Insomnia|', nq'|Insonnia|', nq'|Insomnio|', nq'|불면|', nq'|Bulmyeon|', nq'|不眠|', nq'|Bùmián / Bātmìhn|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(16, 'Color Change', q'|The Pokémon's type becomes the type of the move used on it.|', 3, 1, 0, 0, nq'|へんしょく|', nq'|Henshoku|', nq'|Déguisement|', nq'|Farbwechsel|', nq'|Cambiacolore|', nq'|Cambio Color|', nq'|변색|', nq'|Byeonsaek|', nq'|變色 / 变色|', nq'|Biànsè / Binsīk|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(17, 'Immunity', q'|The immune system of the Pokémon prevents it from getting poisoned.|', 3, 1, 1, 1, nq'|めんえき|', nq'|Men'eki|', nq'|Vaccin|', nq'|Immunität|', nq'|Immunità|', nq'|Inmunidad|', nq'|면역|', nq'|Myeon'yeok|', nq'|免疫|', nq'|Miǎnyì / Míhnyihk|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(18, 'Flash Fire', q'|Powers up the Pokémon's Fire-type moves if it's hit by one.|', 3, 4, 10, 3, nq'|もらいび|', nq'|Moraibi|', nq'|Torche|', nq'|Feuerfänger|', nq'|Fuocardore|', nq'|Absorbe Fuego*|', nq'|타오르는 불꽃|', nq'|Taoreuneun Bulkkot|', nq'|引火|', nq'|Yǐnhuǒ / Yáhnfó|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(19, 'Shield Dust', q'|This Pokémon's dust blocks the additional effects of attacks taken.|', 3, 4, 5, 0, nq'|りんぷん|', nq'|Rinpun|', nq'|Écran Poudre|', nq'|Puderabwehr|', nq'|Polvoscudo|', nq'|Polvo Escudo|', nq'|인분|', nq'|Inbun|', nq'|鱗粉 / 鳞粉|', nq'|Línfěn / Lèuhnfán|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(20, 'Own Tempo', q'|This Pokémon has its own tempo, and that prevents it from becoming confused.|', 3, 0, 18, 5, nq'|マイペース|', nq'|My Pace|', nq'|Tempo Perso|', nq'|Tempomacher|', nq'|Mente Locale|', nq'|Ritmo Propio|', nq'|마이페이스|', nq'|My Pace|', nq'|我行我素|', nq'|Wǒxíngwǒsù / Ngóhhàhngngóhsou|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(21, 'Suction Cups', q'|This Pokémon uses suction cups to stay in one spot to negate all moves and items that force switching out.|', 3, 2, 3, 0, nq'|きゅうばん|', nq'|Kyūban|', nq'|Ventouse|', nq'|Saugnapf|', nq'|Ventose|', nq'|Ventosas|', nq'|흡반|', nq'|Heupban|', nq'|吸盤 / 吸盘|', nq'|Xīpán / Kāppún|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(22, 'Intimidate', q'|The Pokémon intimidates opposing Pokémon upon entering battle, lowering their Attack stat.|', 3, 7, 19, 6, nq'|いかく|', nq'|Ikaku|', nq'|Intimidation|', nq'|Bedroher|', nq'|Prepotenza|', nq'|Intimidación|', nq'|위협|', nq'|Wihyeop|', nq'|威嚇 / 威吓|', nq'|Wēihè / Wāihaak|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(23, 'Shadow Tag', q'|This Pokémon steps on the opposing Pokémon's shadow to prevent it from escaping.|', 3, 3, 0, 3, nq'|かげふみ|', nq'|Kage Fumi|', nq'|Marque Ombre|', nq'|Wegsperre|', nq'|Pedinombra|', nq'|Sombra Trampa*|', nq'|그림자 밟기|', nq'|Geurimja Balgi|', nq'|踩影|', nq'|Cǎi Yǐng / Cháai Yíng|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(24, 'Rough Skin', q'|This Pokémon inflicts damage with its rough skin to the attacker on contact.|', 3, 2, 1, 3, nq'|さめはだ|', nq'|Samehada|', nq'|Peau Dure|', nq'|Rauhaut|', nq'|Cartavetro|', nq'|Piel Tosca|', nq'|까칠한 피부|', nq'|Kkachilhan Pibu|', nq'|粗糙皮膚 / 粗糙皮肤|', nq'|Cūcào Pífū / Chōuchou Pèihfū|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(25, 'Wonder Guard', q'|Its mysterious power only lets supereffective moves hit the Pokémon.|', 3, 1, 0, 0, nq'|ふしぎなまもり|', nq'|Fushigina Mamori|', nq'|Garde Mystik|', nq'|Wunderwache|', nq'|Magidifesa|', nq'|Superguarda|', nq'|불가사의 부적|', nq'|Bulgasayi Bujeok|', nq'|神奇守護 / 神奇守护|', nq'|Shénqí Shǒuhù / Sàhnkèih Sáuwuh|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(26, 'Levitate', q'|By floating in the air, the Pokémon receives full immunity to all Ground-type moves.|', 3, 31, 2, 0, nq'|ふゆう|', nq'|Fuyū|', nq'|Lévitation|', nq'|Schwebe|', nq'|Levitazione|', nq'|Levitación|', nq'|부유|', nq'|Buyu|', nq'|飄浮 / 飘浮|', nq'|Piāofú / Pīufàuh|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(27, 'Effect Spore', q'|Contact with the Pokémon may inflict poison, sleep, or paralysis on its attacker.|', 3, 2, 6, 1, nq'|ほうし|', nq'|Hōshi|', nq'|Pose Spore|', nq'|Sporenwirt|', nq'|Spargispora|', nq'|Efecto Espora*|', nq'|포자|', nq'|Poja|', nq'|孢子|', nq'|Bāozǐ / Bāaují|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(28, 'Synchronize', q'|The attacker will receive the same status condition if it inflicts a burn, poison, or paralysis to the Pokémon.|', 3, 3, 12, 0, nq'|シンクロ|', nq'|Shinkuro|', nq'|Synchro|', nq'|Synchro|', nq'|Sincronismo|', nq'|Sincronía|', nq'|싱크로|', nq'|Synchro|', nq'|同步|', nq'|Tóngbù / Tùhngbouh|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(29, 'Clear Body', q'|Prevents other Pokémon's moves or Abilities from lowering the Pokémon's stats.|', 3, 8, 2, 3, nq'|クリアボディ|', nq'|Kuria Bodi|', nq'|Corps Sain|', nq'|Neutraltorso|', nq'|Corpochiaro|', nq'|Cuerpo Puro|', nq'|클리어 바디|', nq'|Clear Body|', nq'|恆淨之軀 / 恒净之躯|', nq'|Héngjìng-zhī Qū / Hàhngjihng-jī Kēui|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(30, 'Natural Cure', q'|All status conditions heal when the Pokémon switches out.|', 3, 4, 11, 1, nq'|しぜんかいふく|', nq'|Shizen Kaifuku|', nq'|Médic Nature|', nq'|Innere Kraft|', nq'|Alternacura|', nq'|Cura Natural|', nq'|자연회복|', nq'|Jayeon Hoebok|', nq'|自然回復 / 自然回复|', nq'|Zìrán Huífù / Jihyìhn Wùihfuhk|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(31, 'Lightning Rod', q'|The Pokémon draws in all Electric-type moves. Instead of being hit by Electric-type moves, it boosts its Sp. Atk.|', 3, 1, 11, 6, nq'|ひらいしん|', nq'|Hiraishin|', nq'|Paratonnerre|', nq'|Blitzfänger|', nq'|Parafulmine|', nq'|Pararrayos|', nq'|피뢰침|', nq'|Piroechim|', nq'|避雷針 / 避雷针|', nq'|Bìléizhēn / Beihlèuihjām|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(32, 'Serene Grace', q'|Boosts the likelihood of additional effects occurring when attacking.|', 3, 3, 7, 2, nq'|てんのめぐみ|', nq'|Ten no Megumi|', nq'|Sérénité|', nq'|Edelmut|', nq'|Leggiadro|', nq'|Dicha|', nq'|하늘의 은총|', nq'|Haneul-yi Eunchong|', nq'|天恩|', nq'|Tiān'ēn / Tīnyān|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(33, 'Swift Swim', q'|Boosts the Pokémon's Speed stat in rain.|', 3, 8, 21, 10, nq'|すいすい|', nq'|Suisui|', nq'|Glissade|', nq'|Wassertempo|', nq'|Nuotovelox|', nq'|Nado Rápido|', nq'|쓱쓱|', nq'|Sseuksseuk|', nq'|悠游自如|', nq'|Yōuyóu Zìrú / Yàuhyàuh Jihyùh|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(34, 'Chlorophyll', q'|Boosts the Pokémon's Speed stat in sunshine.|', 3, 10, 19, 6, nq'|ようりょくそ|', nq'|Yōryokuso|', nq'|Chlorophylle*|', nq'|Chlorophyll|', nq'|Clorofilla|', nq'|Clorofila|', nq'|엽록소|', nq'|Yeoprokso|', nq'|葉綠素 / 叶绿素|', nq'|Yèlǜsù / Yihpluhksou|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(35, 'Illuminate', q'|Raises the likelihood of meeting wild Pokémon by illuminating the surroundings.|', 3, 0, 8, 0, nq'|はっこう|', nq'|Hakkō|', nq'|Lumiattirance|', nq'|Erleuchtung|', nq'|Risplendi|', nq'|Iluminación|', nq'|발광|', nq'|Balgwang|', nq'|發光 / 发光|', nq'|Fāguāng / Faatgwōng|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(36, 'Trace', q'|When it enters a battle, the Pokémon copies an opposing Pokémon's Ability.|', 3, 1, 5, 0, nq'|トレース|', nq'|Torēsu|', nq'|Calque|', nq'|Fährte|', nq'|Traccia|', nq'|Rastro|', nq'|트레이스|', nq'|Trace|', nq'|複製 / 复制|', nq'|Fùzhì / Fūkjai|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(37, 'Huge Power', q'|Doubles the Pokémon's Attack stat.|', 3, 1, 3, 2, nq'|ちからもち|', nq'|Chikara Mochi|', nq'|Coloforce|', nq'|Kraftkoloss|', nq'|Macroforza|', nq'|Potencia|', nq'|천하장사|', nq'|Cheonhajangsa|', nq'|大力士|', nq'|Dà Lìshì / Daaih Lihksih|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(38, 'Poison Point', q'|Contact with the Pokémon may poison the attacker.|', 3, 0, 16, 0, nq'|どくのトゲ|', nq'|Doku no Toge|', nq'|Point Poison|', nq'|Giftdorn|', nq'|Velenopunto|', nq'|Punto Tóxico|', nq'|독가시|', nq'|Dokgasi|', nq'|毒刺|', nq'|Dúcì / Duhkchi|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(39, 'Inner Focus', q'|The Pokémon's intensely focused, and that protects the Pokémon from flinching.|', 3, 5, 17, 11, nq'|せいしんりょく|', nq'|Seishinryoku|', nq'|Attention|', nq'|Konzentrator|', nq'|Forza Interiore*|', nq'|Foco Interno|', nq'|정신력|', nq'|Jeongsinryeok|', nq'|精神力|', nq'|Jīngshén Lì / Jīngsàhn Lihk|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(40, 'Magma Armor', q'|The Pokémon is covered with hot magma, which prevents the Pokémon from becoming frozen.|', 3, 0, 3, 0, nq'|マグマのよろい|', nq'|Magma no Yoroi|', nq'|Armumagma|', nq'|Magmapanzer|', nq'|Magmascudo|', nq'|Escudo Magma|', nq'|마그마의 무장|', nq'|Magma-yi Mujang|', nq'|熔岩鎧甲 / 熔岩铠甲|', nq'|Róngyán Kǎijiǎ / Yùhngngàahm Hóigaap|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(41, 'Water Veil', q'|The Pokémon is covered with a water veil, which prevents the Pokémon from getting a burn.|', 3, 0, 4, 7, nq'|みずのベール|', nq'|Mizu no Bēru|', nq'|Ignifu-Voile|', nq'|Aquahülle|', nq'|Idrovelo|', nq'|Velo Agua|', nq'|수의 베일|', nq'|Su-yi Veil|', nq'|水幕|', nq'|Shuǐ Mù / Séui Mohk|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(42, 'Magnet Pull', q'|Prevents Steel-type Pokémon from escaping using its magnetic force.|', 3, 0, 8, 0, nq'|じりょく|', nq'|Jiryoku|', nq'|Magnépiège|', nq'|Magnetfalle|', nq'|Magnetismo|', nq'|Imán|', nq'|자력|', nq'|Jiryeok|', nq'|磁力|', nq'|Cílì / Chìhlihk|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(43, 'Soundproof', q'|Soundproofing of the Pokémon itself gives full immunity to all sound-based moves.|', 3, 3, 7, 5, nq'|ぼうおん|', nq'|Bō'on|', nq'|Anti-Bruit|', nq'|Lärmschutz|', nq'|Antisuono|', nq'|Insonorizar|', nq'|방음|', nq'|Bang'eum|', nq'|隔音|', nq'|Géyīn / Gaakyām|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(44, 'Rain Dish', q'|The Pokémon gradually regains HP in rain.|', 3, 0, 3, 10, nq'|あめうけざら|', nq'|Ame Ukezara|', nq'|Cuvette|', nq'|Regengenuss|', nq'|Copripioggia|', nq'|Cura Lluvia|', nq'|젖은접시|', nq'|Jeoj'eun Jeopsi|', nq'|雨盤 / 雨盘|', nq'|Yǔ Pán / Yúh Pùhn|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(45, 'Sand Stream', q'|The Pokémon summons a sandstorm when it enters a battle.|', 3, 4, 1, 0, nq'|すなおこし|', nq'|Suna Okoshi|', nq'|Sable Volant|', nq'|Sandsturm|', nq'|Sabbiafiume|', nq'|Chorro Arena|', nq'|모래날림|', nq'|Morae Nallim|', nq'|揚沙 / 扬沙|', nq'|Yáng Shā / Yèuhng Sā|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(46, 'Pressure', q'|By putting pressure on the opposing Pokémon, it raises their PP usage.|', 3, 19, 2, 4, nq'|プレッシャー|', nq'|Puresshā|', nq'|Pression|', nq'|Erzwinger|', nq'|Pressione|', nq'|Presión|', nq'|프레셔|', nq'|Pressure|', nq'|壓迫感 / 压迫感|', nq'|Yāpò Gǎn / Aatbīk Gám|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(47, 'Thick Fat', q'|The Pokémon is protected by a layer of thick fat, which halves the damage taken from Fire- and Ice-type moves.|', 3, 1, 16, 7, nq'|あついしぼう|', nq'|Atsui Shibō|', nq'|Isograisse|', nq'|Speckschicht|', nq'|Grassospesso|', nq'|Sebo|', nq'|두꺼운 지방|', nq'|Dukkeoun Jibang|', nq'|厚脂肪|', nq'|Hòu Zhīfáng / Háuh Jīfōng|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(48, 'Early Bird', q'|The Pokémon awakens twice as fast as other Pokémon from sleep.|', 3, 0, 13, 2, nq'|はやおき|', nq'|Hayaoki|', nq'|Matinal|', nq'|Frühwecker|', nq'|Sveglialampo|', nq'|Madrugar|', nq'|일찍 기상|', nq'|Iljjik Gisang|', nq'|早起|', nq'|Zǎoqǐ / Jóuhéi|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(49, 'Flame Body', q'|Contact with the Pokémon may burn the attacker.|', 3, 7, 5, 4, nq'|ほのおのからだ|', nq'|Honō no Karada|', nq'|Corps Ardent|', nq'|Flammkörper|', nq'|Corpodifuoco|', nq'|Cuerpo Llama|', nq'|불꽃몸|', nq'|Bulkkot Mom|', nq'|火焰之軀 / 火焰之躯|', nq'|Huǒyàn-zhī Qū / Fóyihm-jī Kēui|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(50, 'Run Away', q'|Enables a sure getaway from wild Pokémon.|', 3, 0, 16, 8, nq'|にげあし|', nq'|Nige Ashi|', nq'|Fuite|', nq'|Angsthase|', nq'|Fugafacile|', nq'|Fuga|', nq'|도주|', nq'|Doju|', nq'|逃跑|', nq'|Táopǎo / Tòuhpáau|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(51, 'Keen Eye', q'|Keen eyes prevent other Pokémon from lowering this Pokémon's accuracy.|', 3, 3, 30, 5, nq'|するどいめ|', nq'|Surudoi Me|', nq'|Regard Vif|', nq'|Adlerauge|', nq'|Sguardofermo|', nq'|Vista Lince|', nq'|날카로운 눈|', nq'|Nalkaroun Nun|', nq'|銳利目光 / 锐利目光|', nq'|Ruìlì Mùguāng / Yeuihleih Muhkgwōng|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(52, 'Hyper Cutter', q'|The Pokémon's proud of its powerful pincers. They prevent other Pokémon from lowering its Attack stat.|', 3, 0, 11, 0, nq'|かいりきバサミ|', nq'|Kairiki Basami|', nq'|Hyper Cutter|', nq'|Scherenmacht|', nq'|Ipertaglio|', nq'|Corte Fuerte|', nq'|괴력집게|', nq'|Goeryeok Jipge|', nq'|怪力鉗 / 怪力钳|', nq'|Guàilì Qián / Gwaailihk Kìhm|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(53, 'Pickup', q'|The Pokémon may pick up the item an opposing Pokémon used during a battle. It may pick up items outside of battle, too.|', 3, 1, 15, 2, nq'|ものひろい|', nq'|Mono Hiroi|', nq'|Ramassage|', nq'|Mitnahme|', nq'|Raccolta|', nq'|Recogida|', nq'|픽업|', nq'|Pick-Up|', nq'|撿拾 / 捡拾|', nq'|Jiǎnshí / Gímsahp|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(54, 'Truant', q'|The Pokémon can't use a move the following turn if it uses one.|', 3, 2, 0, 1, nq'|なまけ|', nq'|Namake|', nq'|Absentéisme|', nq'|Schnarchnase|', nq'|Pigrone|', nq'|Ausente|', nq'|게으름|', nq'|Geeureum|', nq'|懶惰 / 懒惰|', nq'|Lǎnduò / Láahndoh|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(55, 'Hustle', q'|Boosts the Attack stat, but lowers accuracy.|', 3, 3, 9, 8, nq'|はりきり|', nq'|Harikiri|', nq'|Agitation|', nq'|Übereifer|', nq'|Tuttafretta|', nq'|Entusiasmo|', nq'|의욕|', nq'|Yiyok|', nq'|活力|', nq'|Huólì / Wuhtlihk|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(56, 'Cute Charm', q'|Contact with the Pokémon may cause infatuation.|', 3, 1, 11, 2, nq'|メロメロボディ|', nq'|Meromero Bodi|', nq'|Joli Sourire|', nq'|Charmebolzen|', nq'|Incantevole|', nq'|Gran Encanto|', nq'|헤롱헤롱 바디|', nq'|Herongherong Body|', nq'|迷人之軀 / 迷人之躯|', nq'|Mírén-zhī Qū / Màihyàhn-jī Kēui|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(57, 'Plus', q'|Boosts the Sp. Atk stat of the Pokémon if an ally with the Plus or Minus Ability is also in battle.|', 3, 1, 3, 4, nq'|プラス|', nq'|Purasu|', nq'|Plus|', nq'|Plus|', nq'|Più|', nq'|Más|', nq'|플러스|', nq'|Plus|', nq'|正電 / 正电|', nq'|Zhèngdiàn / Jingdihn|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(58, 'Minus', q'|Boosts the Sp. Atk stat of the Pokémon if an ally with the Plus or Minus Ability is also in battle.|', 3, 1, 3, 2, nq'|マイナス|', nq'|Mainasu|', nq'|Minus|', nq'|Minus|', nq'|Meno|', nq'|Menos|', nq'|마이너스|', nq'|Minus|', nq'|負電 / 负电|', nq'|Fùdiàn / Fuhdihn|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(59, 'Forecast', q'|The Pokémon transforms with the weather to change its type to Water, Fire, or Ice.|', 3, 1, 0, 0, nq'|てんきや|', nq'|Tenkiya|', nq'|Météo|', nq'|Prognose|', nq'|Previsioni|', nq'|Predicción|', nq'|기분파|', nq'|Gibunpa|', nq'|陰晴不定 / 阴晴不定|', nq'|Yīnqíng Bùdìng / Yāmchìhng Bātdihng|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(60, 'Sticky Hold', q'|Items held by the Pokémon are stuck fast and cannot be removed by other Pokémon.|', 3, 0, 8, 0, nq'|ねんちゃく|', nq'|Nenchaku|', nq'|Glue|', nq'|Wertehalter|', nq'|Antifurto|', nq'|Viscosidad|', nq'|점착|', nq'|Jeomchak|', nq'|黏著 / 黏着|', nq'|Niánzhuó / Nìhmjeuhk|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(61, 'Shed Skin', q'|The Pokémon may heal its own status conditions by shedding its skin.|', 3, 11, 5, 0, nq'|だっぴ|', nq'|Dappi|', nq'|Mue|', nq'|Expidermis|', nq'|Muta|', nq'|Mudar|', nq'|탈피|', nq'|Talpi|', nq'|蛻皮 / 蜕皮|', nq'|Tuìpí / Teuipèih|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(62, 'Guts', q'|It's so gutsy that having a status condition boosts the Pokémon's Attack stat.|', 3, 3, 14, 4, nq'|こんじょう|', nq'|Konjō|', nq'|Cran|', nq'|Adrenalin|', nq'|Dentistretti|', nq'|Agallas|', nq'|근성|', nq'|Geunseong|', nq'|毅力|', nq'|Yìlì / Ngaihlihk|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(63, 'Marvel Scale', q'|The Pokémon's marvelous scales boost the Defense stat if it has a status condition.|', 3, 0, 1, 2, nq'|ふしぎなうろこ|', nq'|Fushigi na Uroko|', nq'|Écaille Spéciale*|', nq'|Notschutz|', nq'|Pelledura|', nq'|Escama Especial*|', nq'|이상한 비늘|', nq'|Isanghan Bineul|', nq'|神奇鱗片 / 神奇鳞片|', nq'|Shénqí Línpiàn / Sàhnkèih Lèuhnpin|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(64, 'Liquid Ooze', q'|Oozed liquid has strong stench, which damages attackers using any draining move.|', 3, 0, 4, 0, nq'|ヘドロえき|', nq'|Hedoro Eki|', nq'|Suintement|', nq'|Kloakensoße|', nq'|Melma|', nq'|Lodo Líquido|', nq'|해감액|', nq'|Haegam Aek|', nq'|污泥漿 / 污泥浆|', nq'|Wūní Jiāng / Wūnàih Jēung|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(65, 'Overgrow', q'|Powers up Grass-type moves when the Pokémon's HP is low.|', 3, 21, 0, 2, nq'|しんりょく|', nq'|Shinryoku|', nq'|Engrais|', nq'|Notdünger|', nq'|Erbaiuto|', nq'|Espesura|', nq'|심록|', nq'|Simrok|', nq'|茂盛|', nq'|Màoshèng / Mauhsihng|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(66, 'Blaze', q'|Powers up Fire-type moves when the Pokémon's HP is low.|', 3, 21, 0, 2, nq'|もうか|', nq'|Mōka|', nq'|Brasier|', nq'|Großbrand|', nq'|Aiutofuoco|', nq'|Mar Llamas|', nq'|맹화|', nq'|Menghwa|', nq'|猛火|', nq'|Měnghuǒ / Máahngfó|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(67, 'Torrent', q'|Powers up Water-type moves when the Pokémon's HP is low.|', 3, 21, 0, 2, nq'|げきりゅう|', nq'|Gekiryū|', nq'|Torrent|', nq'|Sturzbach|', nq'|Acquaiuto|', nq'|Torrente|', nq'|급류|', nq'|Geupryu|', nq'|激流|', nq'|Jīliú / Gīklàuh|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(68, 'Swarm', q'|Powers up Bug-type moves when the Pokémon's HP is low.|', 3, 5, 16, 4, nq'|むしのしらせ|', nq'|Mushi no Shirase|', nq'|Essaim|', nq'|Hexaplaga|', nq'|Aiutinsetto|', nq'|Enjambre|', nq'|벌레의 알림|', nq'|Beolle-yi Allim|', nq'|蟲之預感 / 虫之预感|', nq'|Chóng-zhī Yùgǎn / Chùhng-jī Yuhgám|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(69, 'Rock Head', q'|Protects the Pokémon from recoil damage.|', 3, 2, 17, 2, nq'|いしあたま|', nq'|Ishi Atama|', nq'|Tête de Roc|', nq'|Steinhaupt|', nq'|Testadura|', nq'|Cabeza Roca|', nq'|돌머리|', nq'|Dol Meori|', nq'|堅硬腦袋 / 坚硬脑袋|', nq'|Jiānyìng Nǎodai / Gīnngaahng Nóuhdói|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(70, 'Drought', q'|Turns the sunlight harsh when the Pokémon enters a battle.|', 3, 2, 1, 2, nq'|ひでり|', nq'|Hideri|', nq'|Sécheresse|', nq'|Dürre|', nq'|Siccità|', nq'|Sequía|', nq'|가뭄|', nq'|Gamum|', nq'|日照|', nq'|Rìzhào / Yahtjiu|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(71, 'Arena Trap', q'|Prevents opposing Pokémon from fleeing.|', 3, 0, 3, 0, nq'|ありじごく|', nq'|Ariji Goku|', nq'|Piège Sable*|', nq'|Ausweglos|', nq'|Trappoarena|', nq'|Trampa Arena|', nq'|개미지옥|', nq'|Gaemi Jiok|', nq'|沙穴|', nq'|Shāxué / Sāyuht|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(72, 'Vital Spirit', q'|The Pokémon is full of vitality, and that prevents it from falling asleep.|', 3, 1, 6, 7, nq'|やるき|', nq'|Yaruki|', nq'|Esprit Vital|', nq'|Munterkeit|', nq'|Spiritovivo|', nq'|Espíritu Vital*|', nq'|의기양양|', nq'|Yigiyang'yang|', nq'|幹勁 / 干劲|', nq'|Gànjìng / Gongihng|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(73, 'White Smoke', q'|The Pokémon is protected by its white smoke, which prevents other Pokémon from lowering its stats.|', 3, 0, 1, 1, nq'|しろいけむり|', nq'|Shiroi Kemuri|', nq'|Écran Fumée|', nq'|Pulverrauch|', nq'|Fumochiaro|', nq'|Humo Blanco|', nq'|하얀연기|', nq'|Hayan Yeongi|', nq'|白色煙霧 / 白色烟雾|', nq'|Báisè Yānwù / Baahksīk Yīnmouh|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(74, 'Pure Power', q'|Using its pure power, the Pokémon doubles its Attack stat.|', 3, 2, 0, 0, nq'|ヨガパワー|', nq'|Yoga Pawā|', nq'|Force Pure|', nq'|Mentalkraft|', nq'|Forzapura|', nq'|Energía pura|', nq'|순수한힘|', nq'|Sunsuhan Him|', nq'|瑜伽之力|', nq'|Yújiā-zhī Lì / Yùhgā-jī Lihk|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(75, 'Shell Armor', q'|A hard shell protects the Pokémon from critical hits.|', 3, 3, 13, 7, nq'|シェルアーマー|', nq'|Sheru Āmā|', nq'|Coque Armure|', nq'|Panzerhaut|', nq'|Guscioscudo|', nq'|Caparazón|', nq'|조가비 갑옷|', nq'|Jogabi Gab'ot|', nq'|硬殼盔甲 / 硬壳盔甲|', nq'|Yìngké Kuījiǎ / Ngaahnghok Kwāigaap|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(76, 'Air Lock', q'|Eliminates the effects of weather.|', 3, 1, 0, 0, nq'|エアロック|', nq'|Ea Rokku|', nq'|Air Lock|', nq'|Klimaschutz|', nq'|Riparo|', nq'|Bucle Aire|', nq'|에어록|', nq'|Air-Lock|', nq'|氣閘 / 气闸|', nq'|Qì Zhá / Hei Jaahp|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(77, 'Tangled Feet', q'|Raises evasion if the Pokémon is confused.|', 4, 0, 5, 2, nq'|ちどりあし|', nq'|Chidori Ashi|', nq'|Pieds Confus|', nq'|Fußangel|', nq'|Intricopiedi|', nq'|Tumbos|', nq'|갈지자걸음|', nq'|Galjija Geor'eum|', nq'|蹣跚 / 蹒跚|', nq'|Pánshān / Pùhnsāan|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(78, 'Motor Drive', q'|Boosts its Speed stat if hit by an Electric-type move, instead of taking damage.|', 4, 1, 2, 1, nq'|でんきエンジン|', nq'|Denki Engine|', nq'|Motorisé|', nq'|Starthilfe|', nq'|Elettrorapid|', nq'|Electromotor|', nq'|전기엔진|', nq'|Jeongi Engine|', nq'|電氣引擎 / 电气引擎|', nq'|Diànqì Yǐnqíng / Dihnhei Yáhnkìhng|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(79, 'Rivalry', q'|Becomes competitive and deals more damage to Pokémon of the same gender, but deals less to Pokémon of the opposite gender.|', 4, 0, 14, 4, nq'|とうそうしん|', nq'|Tōsōshin|', nq'|Rivalité|', nq'|Rivalität|', nq'|Antagonismo|', nq'|Rivalidad|', nq'|투쟁심|', nq'|Tujaengsim|', nq'|鬥爭心 / 斗争心|', nq'|Dòuzhēng Xīn / Daujāng Sām|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(80, 'Steadfast', q'|The Pokémon's determination boosts the Speed stat each time the Pokémon flinches.|', 4, 2, 3, 7, nq'|ふくつのこころ|', nq'|Fukutsu no Kokoro|', nq'|Impassible|', nq'|Felsenfest|', nq'|Cuordeciso|', nq'|Impasible|', nq'|불굴의 마음|', nq'|Bulgul-yi Ma'eum|', nq'|不屈之心|', nq'|Bùqū-zhī Xīn / Bātwāt-jī Sām|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(81, 'Snow Cloak', q'|Boosts evasion in a hailstorm.|', 4, 6, 7, 1, nq'|ゆきがくれ|', nq'|Yukigakure|', nq'|Rideau Neige|', nq'|Schneemantel|', nq'|Mantelneve|', nq'|Manto Níveo|', nq'|눈숨기|', nq'|Nun Sumgi|', nq'|雪隱 / 雪隐|', nq'|Xuěyǐn / Syutyán|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(82, 'Gluttony', q'|Makes the Pokémon eat a held Berry when its HP drops to half or less, which is sooner than usual.|', 4, 6, 8, 9, nq'|くいしんぼう|', nq'|Kuishinbō|', nq'|Gloutonnerie|', nq'|Völlerei|', nq'|Voracità|', nq'|Gula|', nq'|먹보|', nq'|Meokbo|', nq'|貪吃鬼 / 贪吃鬼|', nq'|Tānchīguǐ / Tāamhekgwái|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(83, 'Anger Point', q'|The Pokémon is angered when it takes a critical hit, and that maxes its Attack stat.|', 4, 0, 3, 6, nq'|いかりのつぼ|', nq'|Ikari no Tsubo|', nq'|Colérique|', nq'|Kurzschluss|', nq'|Grancollera|', nq'|Irascible|', nq'|분노의 경혈|', nq'|Bunno-yi Gyeonghyeol|', nq'|憤怒穴位 / 愤怒穴位|', nq'|Fènnù Xuèwèi / Fáhnnouh Yuhtwái|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(84, 'Unburden', q'|Boosts the Speed stat if the Pokémon's held item is used or lost.|', 4, 0, 5, 7, nq'|かるわざ|', nq'|Karuwaza|', nq'|Délestage|', nq'|Entlastung|', nq'|Agiltecnica|', nq'|Liviano|', nq'|곡예|', nq'|Gok'ye|', nq'|輕裝 / 轻装|', nq'|Qīngzhuāng / Hīngjōng|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(85, 'Heatproof', q'|The heatproof body of the Pokémon halves the damage from Fire-type moves that hit it.|', 4, 0, 2, 0, nq'|たいねつ|', nq'|Tainetsu|', nq'|Ignifugé|', nq'|Hitzeschutz|', nq'|Antifuoco|', nq'|Ignífugo|', nq'|내열|', nq'|Naeyeol|', nq'|耐熱 / 耐热|', nq'|Nàirè / Noihyiht|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(86, 'Simple', q'|The stat changes the Pokémon receives are doubled.|', 4, 0, 3, 2, nq'|たんじゅん|', nq'|Tanjun|', nq'|Simple|', nq'|Wankelmut|', nq'|Disinvoltura|', nq'|Simple|', nq'|단순|', nq'|Dansun|', nq'|單純 / 单纯|', nq'|Dānchún / Dāansèuhn|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(87, 'Dry Skin', q'|Restores HP in rain or when hit by Water-type moves. Reduces HP in sunshine, and increases the damage received from Fire-type moves.|', 4, 0, 6, 1, nq'|かんそうはだ|', nq'|Kansō Hada|', nq'|Peau Sèche|', nq'|Trockenheit|', nq'|Pellearsa|', nq'|Piel Seca|', nq'|건조피부|', nq'|Geonjo Pibu|', nq'|乾燥皮膚 / 干燥皮肤|', nq'|Gānzào Pífū / Gōnchou Pèihfū|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(88, 'Download', q'|Compares an opposing Pokémon's Defense and Sp. Def stats before raising its own Attack or Sp. Atk stat—whichever will be more effective.|', 4, 1, 3, 0, nq'|ダウンロード|', nq'|Download|', nq'|Télécharge|', nq'|Download|', nq'|Download|', nq'|Descarga|', nq'|다운로드|', nq'|Download|', nq'|下載 / 下载|', nq'|Xiàzài / Hahjoi|');
insert into ABILITY(ID, NAME, EFFECT, GENERATION, SINGLE, DUAL, HIDDEN, JAPANESE_KANA, JAPANESE_ROMAJI, FRENCH, GERMAN, ITALIAN, SPANISH, KOREAN_HANGUL, KOREAN_ROMANIZED, CHINESE_HANZI, CHINESE_ROMANIZED)
values(89, 'Iron Fist', q'|Powers up punching moves.|', 4, 0, 7, 7, nq'|てつのこぶし|', nq'|Tetsu no Kobushi|', nq'|Poing de Fer|', nq'|Eisenfaust|', nq'|Ferropugno|', nq'|Puño Férreo|', nq'|철주먹|', nq'|Cheol Jumeok|', nq'|鐵拳 / 铁拳|', nq'|Tiěquán / Titkyùhn|');