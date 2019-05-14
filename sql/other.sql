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