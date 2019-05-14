create table Types(
TYPE varchar2(15 byte) primary key, --The name of the type
DESCRIPTION clob , --The description of the type
URL varchar2(200 byte) --The link to see more about the type
);
create table SE(
DEF varchar2(15 byte) references Types(TYPE), --Supper effective when defending with the folowing type (Bad)
ATK varchar2(15 byte) references Types(TYPE), --Supper effective when atacking the folowing type (Good)
CONSTRAINT pk_SE primary key(ATK, DEF) --Ensure no duplicates exist and no nulls exist too
);
create table NVE(
DEF varchar2(15 byte) references Types(TYPE), --Not very effective when defending with the folowing type (Good)
ATK varchar2(15 byte) references Types(TYPE), --Not very effective when atacking the folowing type (Bad)
CONSTRAINT pk_NVE primary key(ATK, DEF) --Ensure no duplicates exist and no nulls exist too
);
create table NE(
DEF varchar2(15 byte) references Types(TYPE), --Not effective when defending with the folowing type (Best)
ATK varchar2(15 byte) references Types(TYPE), --Not effective when atacking the folowing type (Worst)
CONSTRAINT pk_NE primary key(ATK, DEF) --Ensure no duplicates exist and no nulls exist too
);


insert into Types( TYPE , URL )
values( 'Normal' , q'|https://bulbapedia.bulbagarden.net/wiki/Normal_(type)|' );
insert into Types( TYPE , URL )
values( 'Fighting' , q'|https://bulbapedia.bulbagarden.net/wiki/Fighting_(type)|' );
insert into Types( TYPE , URL )
values( 'Flying' , q'|https://bulbapedia.bulbagarden.net/wiki/Flying_(type)|' );
insert into Types( TYPE , URL )
values( 'Poison' , q'|https://bulbapedia.bulbagarden.net/wiki/Poison_(type)|' );
insert into Types( TYPE , URL )
values( 'Ground' , q'|https://bulbapedia.bulbagarden.net/wiki/Ground_(type)|' );
insert into Types( TYPE , URL )
values( 'Rock' , q'|https://bulbapedia.bulbagarden.net/wiki/Rock_(type)|' );
insert into Types( TYPE , URL )
values( 'Bug' , q'|https://bulbapedia.bulbagarden.net/wiki/Bug_(type)|' );
insert into Types( TYPE , URL )
values( 'Ghost' , q'|https://bulbapedia.bulbagarden.net/wiki/Ghost_(type)|' );
insert into Types( TYPE , URL )
values( 'Steel' , q'|https://bulbapedia.bulbagarden.net/wiki/Steel_(type)|' );
insert into Types( TYPE , URL )
values( 'Fire' , q'|https://bulbapedia.bulbagarden.net/wiki/Fire_(type)|' );
insert into Types( TYPE , URL )
values( 'Water' , q'|https://bulbapedia.bulbagarden.net/wiki/Water_(type)|' );
insert into Types( TYPE , URL )
values( 'Grass' , q'|https://bulbapedia.bulbagarden.net/wiki/Grass_(type)|' );
insert into Types( TYPE , URL )
values( 'Electric' , q'|https://bulbapedia.bulbagarden.net/wiki/Electric_(type)|' );
insert into Types( TYPE , URL )
values( 'Psychic' , q'|https://bulbapedia.bulbagarden.net/wiki/Psychic_(type)|' );
insert into Types( TYPE , URL )
values( 'Ice' , q'|https://bulbapedia.bulbagarden.net/wiki/Ice_(type)|' );
insert into Types( TYPE , URL )
values( 'Dragon' , q'|https://bulbapedia.bulbagarden.net/wiki/Dragon_(type)|' );
insert into Types( TYPE , URL )
values( 'Dark' , q'|https://bulbapedia.bulbagarden.net/wiki/Dark_(type)|' );
insert into Types( TYPE , URL )
values( 'Fairy' , q'|https://bulbapedia.bulbagarden.net/wiki/Fairy_(type)|' );

insert into SE( DEF, ATK )
values( 'Dark', 'Fighting' );
insert into SE( DEF, ATK )
values( 'Ice', 'Fighting' );
insert into SE( DEF, ATK )
values( 'Normal', 'Fighting' );
insert into SE( DEF, ATK )
values( 'Rock', 'Fighting' );
insert into SE( DEF, ATK )
values( 'Steel', 'Fighting' );
insert into SE( DEF, ATK )
values( 'Bug', 'Flying' );
insert into SE( DEF, ATK )
values( 'Fighting', 'Flying' );
insert into SE( DEF, ATK )
values( 'Grass', 'Flying' );
insert into SE( DEF, ATK )
values( 'Fairy', 'Poison' );
insert into SE( DEF, ATK )
values( 'Grass', 'Poison' );
insert into SE( DEF, ATK )
values( 'Electric', 'Ground' );
insert into SE( DEF, ATK )
values( 'Fire', 'Ground' );
insert into SE( DEF, ATK )
values( 'Poison', 'Ground' );
insert into SE( DEF, ATK )
values( 'Rock', 'Ground' );
insert into SE( DEF, ATK )
values( 'Steel', 'Ground' );
insert into SE( DEF, ATK )
values( 'Bug', 'Rock' );
insert into SE( DEF, ATK )
values( 'Fire', 'Rock' );
insert into SE( DEF, ATK )
values( 'Flying', 'Rock' );
insert into SE( DEF, ATK )
values( 'Ice', 'Rock' );
insert into SE( DEF, ATK )
values( 'Dark', 'Bug' );
insert into SE( DEF, ATK )
values( 'Grass', 'Bug' );
insert into SE( DEF, ATK )
values( 'Psychic', 'Bug' );
insert into SE( DEF, ATK )
values( 'Ghost', 'Ghost' );
insert into SE( DEF, ATK )
values( 'Psychic', 'Ghost' );
insert into SE( DEF, ATK )
values( 'Fairy', 'Steel' );
insert into SE( DEF, ATK )
values( 'Ice', 'Steel' );
insert into SE( DEF, ATK )
values( 'Rock', 'Steel' );
insert into SE( DEF, ATK )
values( 'Bug', 'Fire' );
insert into SE( DEF, ATK )
values( 'Grass', 'Fire' );
insert into SE( DEF, ATK )
values( 'Ice', 'Fire' );
insert into SE( DEF, ATK )
values( 'Steel', 'Fire' );
insert into SE( DEF, ATK )
values( 'Fire', 'Water' );
insert into SE( DEF, ATK )
values( 'Ground', 'Water' );
insert into SE( DEF, ATK )
values( 'Rock', 'Water' );
insert into SE( DEF, ATK )
values( 'Ground', 'Grass' );
insert into SE( DEF, ATK )
values( 'Rock', 'Grass' );
insert into SE( DEF, ATK )
values( 'Water', 'Grass' );
insert into SE( DEF, ATK )
values( 'Flying', 'Electric' );
insert into SE( DEF, ATK )
values( 'Water', 'Electric' );
insert into SE( DEF, ATK )
values( 'Fighting', 'Psychic' );
insert into SE( DEF, ATK )
values( 'Poison', 'Psychic' );
insert into SE( DEF, ATK )
values( 'Dragon', 'Ice' );
insert into SE( DEF, ATK )
values( 'Flying', 'Ice' );
insert into SE( DEF, ATK )
values( 'Grass', 'Ice' );
insert into SE( DEF, ATK )
values( 'Ground', 'Ice' );
insert into SE( DEF, ATK )
values( 'Dragon', 'Dragon' );
insert into SE( DEF, ATK )
values( 'Ghost', 'Dark' );
insert into SE( DEF, ATK )
values( 'Psychic', 'Dark' );
insert into SE( DEF, ATK )
values( 'Dark', 'Fairy' );
insert into SE( DEF, ATK )
values( 'Dragon', 'Fairy' );
insert into SE( DEF, ATK )
values( 'Fighting', 'Fairy' );

insert into NVE( DEF, ATK )
values( 'Rock', 'Normal' );
insert into NVE( DEF, ATK )
values( 'Steel', 'Normal' );
insert into NVE( DEF, ATK )
values( 'Bug', 'Fighting' );
insert into NVE( DEF, ATK )
values( 'Fairy', 'Fighting' );
insert into NVE( DEF, ATK )
values( 'Flying', 'Fighting' );
insert into NVE( DEF, ATK )
values( 'Poison', 'Fighting' );
insert into NVE( DEF, ATK )
values( 'Psychic', 'Fighting' );
insert into NVE( DEF, ATK )
values( 'Electric', 'Flying' );
insert into NVE( DEF, ATK )
values( 'Rock', 'Flying' );
insert into NVE( DEF, ATK )
values( 'Steel', 'Flying' );
insert into NVE( DEF, ATK )
values( 'Poison', 'Poison' );
insert into NVE( DEF, ATK )
values( 'Ground', 'Poison' );
insert into NVE( DEF, ATK )
values( 'Rock', 'Poison' );
insert into NVE( DEF, ATK )
values( 'Ghost', 'Poison' );
insert into NVE( DEF, ATK )
values( 'Bug', 'Ground' );
insert into NVE( DEF, ATK )
values( 'Grass', 'Ground' );
insert into NVE( DEF, ATK )
values( 'Fighting', 'Rock' );
insert into NVE( DEF, ATK )
values( 'Ground', 'Rock' );
insert into NVE( DEF, ATK )
values( 'Fairy', 'Bug' );
insert into NVE( DEF, ATK )
values( 'Fighting', 'Bug' );
insert into NVE( DEF, ATK )
values( 'Fire', 'Bug' );
insert into NVE( DEF, ATK )
values( 'Flying', 'Bug' );
insert into NVE( DEF, ATK )
values( 'Ghost', 'Bug' );
insert into NVE( DEF, ATK )
values( 'Poison', 'Bug' );
insert into NVE( DEF, ATK )
values( 'Steel', 'Bug' );
insert into NVE( DEF, ATK )
values( 'Dark', 'Ghost' );
insert into NVE( DEF, ATK )
values( 'Electric', 'Steel' );
insert into NVE( DEF, ATK )
values( 'Fire', 'Steel' );
insert into NVE( DEF, ATK )
values( 'Steel', 'Steel' );
insert into NVE( DEF, ATK )
values( 'Rock', 'Steel' );
insert into NVE( DEF, ATK )
values( 'Dragon', 'Fire' );
insert into NVE( DEF, ATK )
values( 'Fire', 'Fire' );
insert into NVE( DEF, ATK )
values( 'Rock', 'Fire' );
insert into NVE( DEF, ATK )
values( 'Water', 'Fire' );
insert into NVE( DEF, ATK )
values( 'Dragon', 'Water' );
insert into NVE( DEF, ATK )
values( 'Grass', 'Water' );
insert into NVE( DEF, ATK )
values( 'Water', 'Water' );
insert into NVE( DEF, ATK )
values( 'Bug', 'Grass' );
insert into NVE( DEF, ATK )
values( 'Dragon', 'Grass' );
insert into NVE( DEF, ATK )
values( 'Fire', 'Grass' );
insert into NVE( DEF, ATK )
values( 'Flying', 'Grass' );
insert into NVE( DEF, ATK )
values( 'Grass', 'Grass' );
insert into NVE( DEF, ATK )
values( 'Poison', 'Grass' );
insert into NVE( DEF, ATK )
values( 'Steel', 'Grass' );
insert into NVE( DEF, ATK )
values( 'Dragon', 'Electric' );
insert into NVE( DEF, ATK )
values( 'Electric', 'Electric' );
insert into NVE( DEF, ATK )
values( 'Grass', 'Electric' );
insert into NVE( DEF, ATK )
values( 'Psychic', 'Psychic' );
insert into NVE( DEF, ATK )
values( 'Steel', 'Psychic' );
insert into NVE( DEF, ATK )
values( 'Fire', 'Ice' );
insert into NVE( DEF, ATK )
values( 'Ice', 'Ice' );
insert into NVE( DEF, ATK )
values( 'Steel', 'Ice' );
insert into NVE( DEF, ATK )
values( 'Water', 'Ice' );
insert into NVE( DEF, ATK )
values( 'Steel', 'Dragon' );
insert into NVE( DEF, ATK )
values( 'Dark', 'Dark' );
insert into NVE( DEF, ATK )
values( 'Fairy', 'Dark' );
insert into NVE( DEF, ATK )
values( 'Fighting', 'Dark' );
insert into NVE( DEF, ATK )
values( 'Fire', 'Fairy' );
insert into NVE( DEF, ATK )
values( 'Poison', 'Fairy' );
insert into NVE( DEF, ATK )
values( 'Steel', 'Fairy' );

insert into NE( DEF, ATK )
values( 'Ghost', 'Normal' );
insert into NE( DEF, ATK )
values( 'Ghost', 'Fighting' );
insert into NE( DEF, ATK )
values( 'Steel', 'Poison' );
insert into NE( DEF, ATK )
values( 'Flying', 'Ground' );
insert into NE( DEF, ATK )
values( 'Normal', 'Ghost' );
insert into NE( DEF, ATK )
values( 'Ground', 'Electric' );
insert into NE( DEF, ATK )
values( 'Dark', 'Psychic' );
insert into NE( DEF, ATK )
values( 'Fairy', 'Dragon' );