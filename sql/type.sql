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