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
HEIGHT_M number(2,0) check(HEIGHT_M>=0), --The height in Meeters
CONSTRAINT fk_SPECIES foreign key(DEX) references POKEMON(DEX), --Enforce the foreign key
CONSTRAINT un_SPECIES unique(Dex, Dex_Suffix, Class), --Enforce that Dex and Class are unique (Can't be primary key)
CONSTRAINT ck_Type check(Type!=Type2), --Make sure that type cannot be the same
CONSTRAINT ck_Egg check(EggGroup1!=EggGroup2), --Make sure that egg groups don't duplicate
CONSTRAINT un_Dex_Class unique(Dex, Class) --Ensure that no class has duplicates
);





insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 787 , 'Undiscovered' , 'Grass', 'Fairy', q'{Head and arms}', 'Red' , 0, 'GU', 15, 'Grassy Surge' , 'Telepathy', 45.5, 1.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 360 , 'Undiscovered' , 'Psychic' , q'{Bipedal, tailed form}', 'Blue' , 0, '1:1U', 20, 'Shadow Tag' , 'Telepathy', 14, 0.6 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 341 , 'Water 1', 'Water 3', 'Water' , q'{Insectoid body}', 'Red' , 9, 0, '1:1', 15, 'Hyper Cutter', 'Shell Armor', 'Adaptability', 11.5, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 738 , 'Bug' , 'Bug', 'Electric', q'{Insectoid body}', 'Blue' , 0, 0, '1:1', 15, 'Levitate' , 45, 1.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 494 , 'Undiscovered' , 'Psychic', 'Fire', q'{Bipedal, tailless form}', 'Yellow' , 0, 'GU', 120, 'Victory Star' , 4, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 534 , 'Human-Like' , 'Fighting' , q'{Bipedal, tailless form}', 'Brown' , 0, '1:3U', 20, 'Guts', 'Sheer Force', 'Iron Fist', 87, 1.5 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 496 , 'Field', 'Grass', 'Grass' , q'{Bipedal, tailed form}', 'Green' , 0, '1:7', 20, 'Overgrow' , 'Contrary', 16, 0.8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 301 , 'Field', 'Fairy', 'Normal' , q'{Quadruped body}', 'Purple' , 2, '3:1', 15, 'Cute Charm', 'Normalize', 'Wonder Skin', 32.6, 1.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 639 , 'Undiscovered' , 'Rock', 'Fighting', q'{Quadruped body}', 'Gray' , 0, 'GU', 80, 'Justified' , 260, 1.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 49 , 'Bug' , 'Bug', 'Poison', q'{Two or more pairs of wings}', 'Purple' , 2, '1:1', 20, 'Shield Dust', 'Tinted Lens', 'Wonder Skin', 12.5, 1.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 74 , 'Mineral' , 'Rock', 'Ground', q'{Head and arms}', 'Brown', 9, 9, 0, '1:1', 15, 'Rock Head', 'Sturdy', 'Sand Veil', 20, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 625 , 'Human-Like' , 'Dark', 'Steel', q'{Bipedal, tailless form}', 'Red' , 15, 0, '1:1', 20, 'Defiant', 'Inner Focus', 'Pressure', 70, 1.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 81 , 'Mineral' , 'Electric', 'Steel', q'{Head and arms}', 'Gray', 9, 9, 0, 'G', 20, 'Magnet Pull', 'Sturdy', 'Analytic', 6, 0.3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 646, q'|Normal|' , 'Undiscovered' , 'Dragon', 'Ice', q'{Bipedal, tailed form}', 'Gray' , 0, 'GU', 120, 'Pressure' , 325, 3.3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 153 , 'Monster', 'Grass', 'Grass' , q'{Quadruped body}', 'Green' , 0, '1:7', 20, 'Overgrow' , 'Leaf Guard', 15.8, 1.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 613 , 'Field' , 'Ice' , q'{Bipedal, tailed form}', 'White' , 2, '1:1', 20, 'Snow Cloak', 'Slush Rush', 'Rattled', 8.5, 0.5 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 708 , 'Grass', 'Amorphous', 'Ghost', 'Grass', q'{Head and arms}', 'Brown', 9, 9, 0, '1:1', 20, 'Natural Cure', 'Frisk', 'Harvest', 7, 0.4 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 130, q'|Mega|', 'M', q'|Gyaradosite|', 'Water 2', 'Dragon', 'Water', 'Dark', q'{Serpentine bodies}', 'Blue', 3, 3, 0, '1:1', 5, 'Mold Breaker' , 235, 6.5 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 274 , 'Field', 'Grass', 'Grass', 'Dark', q'{Bipedal, tailless form}', 'Brown' , 0, '1:1', 15, 'Chlorophyll', 'Early Bird', 'Pickpocket', 28, 1 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 365 , 'Water 1', 'Field', 'Ice', 'Water', q'{Quadruped body}', 'Blue' , 2, '1:1', 20, 'Thick Fat', 'Ice Body', 'Oblivious', 150.6, 1.4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 495 , 'Field', 'Grass', 'Grass' , q'{Bipedal, tailed form}', 'Green' , 0, '1:7', 20, 'Overgrow' , 'Contrary', 8.1, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 501 , 'Field' , 'Water' , q'{Bipedal, tailed form}', 'Blue' , 0, '1:7', 20, 'Torrent' , 'Shell Armor', 5.9, 0.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 587 , 'Field' , 'Electric', 'Flying', q'{Quadruped body}', 'White', 9, 9, 0, '1:1', 20, 'Static' , 'Motor Drive', 5, 0.4 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 666, q'|Modern Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 1.2 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 773, q'|Type: Fire|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'RKS System' , 100.5, 2.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 344 , 'Mineral' , 'Ground', 'Psychic', q'{Head and arms}', 'Black' , 15, 0, 'G', 20, 'Levitate' , 107.9, 1.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 508 , 'Field' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, '1:1', 15, 'Intimidate', 'Sand Rush', 'Scrappy', 61, 1.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 354 , 'Amorphous' , 'Ghost' , q'{Bipedal, tailed form}', 'Black' , 6, 2, '1:1', 25, 'Insomnia', 'Frisk', 'Cursed Body', 12.5, 1.1 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 254, q'|Mega|', 'M', q'|Sceptilite|', 'Monster', 'Dragon', 'Grass', 'Dragon', q'{Bipedal, tailed form}', 'Green' , 0, '1:7', 20, 'Lightning Rod' , 52.2, 1.9 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 666, q'|Sun Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 1.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 319 , 'Water 2' , 'Water', 'Dark', q'{Fins}', 'Blue', 3, 3, 0, '1:1', 20, 'Rough Skin' , 'Speed Boost', 88.8, 1.8 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 710, q'|Average Size|' , 'Amorphous' , 'Ghost', 'Grass', q'{Head}', 'Brown' , 0, '1:1', 20, 'Pickup', 'Frisk', 'Insomnia', 5, 0.4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 478 , 'Fairy', 'Mineral', 'Ice', 'Ghost', q'{Head and arms}', 'White' , 0, '1:0', 20, 'Snow Cloak' , 'Cursed Body', 26.6, 1.3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 773, q'|Type: Steel|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'RKS System' , 100.5, 2.3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 493, q'|Type: Dragon|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Multitype' , 320, 3.2 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 4 , 'Monster', 'Dragon', 'Fire' , q'{Bipedal, tailed form}', 'Red' , 0, '1:7', 20, 'Blaze' , 'Solar Power', 8.5, 0.6 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 676, q'|Matron Trim|' , 'Field' , 'Normal' , q'{Quadruped body}', 'White' , 6, 0, '1:1', 20, 'Fur Coat' , 28, 1.2 );
insert into SPECIES( DEX, CLASS , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 25, q'|Hoenn Cap|' , 'Field', 'Fairy', 'Electric' , q'{Quadruped body}', 'Yellow', 6, 6, 0, '1:1', 10, 'Static' , 'Lightning Rod', 6, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 78 , 'Field' , 'Fire' , q'{Quadruped body}', 'Yellow' , 0, '1:1', 20, 'Run Away', 'Flash Fire', 'Flame Body', 95, 1.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 124 , 'Human-Like' , 'Ice', 'Psychic', q'{Bipedal, tailless form}', 'Red' , 0, 2, '1:0', 25, 'Oblivious', 'Forewarn', 'Dry Skin', 40.6, 1.4 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 716, q'|Neutral Mode|' , 'Undiscovered' , 'Fairy' , q'{Quadruped body}', 'Blue' , 0, 'GU', 120, 'Fairy Aura' , 215, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 576 , 'Human-Like' , 'Psychic' , q'{Bipedal, tailless form}', 'Purple' , 2, '3:1', 20, 'Frisk', 'Competitive', 'Shadow Tag', 44, 1.5 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 362, q'|Mega|', 'M', q'|Glalitite|', 'Fairy', 'Mineral', 'Ice' , q'{Head}', 'Gray', 3, 3, 0, '1:1', 20, 'Refrigerate' , 256.5, 2.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 434 , 'Field' , 'Poison', 'Dark', q'{Quadruped body}', 'Purple' , 0, '1:1', 20, 'Stench', 'Aftermath', 'Keen Eye', 19.2, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 779 , 'Water 2' , 'Water', 'Psychic', q'{Fins}', 'Pink', 6, 6, 0, '1:1', 15, 'Dazzling', 'Strong Jaw', 'Wonder Skin', 19, 0.9 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 141 , 'Water 1', 'Water 3', 'Rock', 'Water', q'{Bipedal, tailed form}', 'Brown' , 0, '1:7', 30, 'Swift Swim', 'Battle Armor', 'Weak Armor', 40.5, 1.3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 321 , 'Field', 'Water 2', 'Water' , q'{Fins}', 'Blue', 6, 6, 0, '1:1', 40, 'Water Veil', 'Oblivious', 'Pressure', 398, 14.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 201 , 'Undiscovered' , 'Psychic' , q'{Head}', 'Black' , 0, 'GU', 40, 'Levitate' , 5, 0.5 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 671, q'|Orange Flower|' , 'Fairy' , 'Fairy' , q'{Head and arms}', 'White' , 0, '1:0', 20, 'Flower Veil' , 'Symbiosis', 10, 1.1 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 666, q'|Poké Ball Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 1.2 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 464 , 'Monster', 'Field', 'Ground', 'Rock', q'{Bipedal, tailed form}', 'Gray' , 0, '1:1', 20, 'Lightning Rod', 'Solid Rock', 'Reckless', 282.8, 2.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 267 , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'Yellow' , 0, '1:1', 15, 'Swarm' , 'Rivalry', 28.4, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 335 , 'Field' , 'Normal' , q'{Bipedal, tailed form}', 'White' , 0, '1:1', 20, 'Immunity' , 'Toxic Boost', 40.3, 1.3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 283 , 'Water 1', 'Bug', 'Bug', 'Water', q'{Insectoid body}', 'Blue', 9, 9, 0, '1:1', 15, 'Swift Swim' , 'Rain Dish', 1.7, 0.5 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 148 , 'Water 1', 'Dragon', 'Dragon' , q'{Serpentine bodies}', 'Blue', 6, 6, 0, '1:1', 40, 'Shed Skin' , 'Marvel Scale', 16.5, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 701 , 'Human-Like' , 'Fighting', 'Flying', q'{Bipedal, tailless form}', 'Green' , 3, 0, '1:1', 20, 'Limber', 'Unburden', 'Mold Breaker', 21.5, 0.8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 686 , 'Water 1', 'Water 2', 'Dark', 'Psychic', q'{Tentacles or a multiped body}', 'Blue' , 9, 0, '1:1', 20, 'Contrary', 'Suction Cups', 'Infiltrator', 3.5, 0.4 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 51, q'|Alolan|', 'A' , 'Field' , 'Ground', 'Steel', q'{Multiple bodies}', 'Brown', 6, 6, 0, '1:1', 20, 'Sand Veil', 'Tangling Hair', 'Sand Force', 33.3, 0.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 408 , 'Monster' , 'Rock' , q'{Bipedal, tailed form}', 'Blue' , 0, '1:7', 30, 'Mold Breaker' , 'Sheer Force', 31.5, 0.9 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 327 , 'Field', 'Human-Like', 'Normal' , q'{Bipedal, tailed form}', 'Brown', 6, 6, 2, '1:1', 15, 'Own Tempo', 'Tangled Feet', 'Contrary', 5, 1.1 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 258 , 'Monster', 'Water 1', 'Water' , q'{Quadruped body}', 'Blue' , 0, '1:7', 20, 'Torrent' , 'Damp', 7.6, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 261 , 'Field' , 'Dark' , q'{Quadruped body}', 'Gray' , 2, '1:1', 15, 'Run Away', 'Quick Feet', 'Rattled', 13.6, 0.5 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 671, q'|Blue Flower|' , 'Fairy' , 'Fairy' , q'{Head and arms}', 'White' , 0, '1:0', 20, 'Flower Veil' , 'Symbiosis', 10, 1.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 288 , 'Field' , 'Normal' , q'{Bipedal, tailed form}', 'White' , 0, '1:1', 15, 'Vital Spirit' , 46.5, 1.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 22 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Brown', 6, 6, 0, '1:1', 15, 'Keen Eye' , 'Sniper', 38, 1.2 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 527 , 'Field', 'Flying', 'Psychic', 'Flying', q'{Single pair of wings}', 'Blue' , 0, '1:1', 15, 'Unaware', 'Klutz', 'Simple', 2.1, 0.4 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 445, q'|Mega|', 'M', q'|Garchompite|', 'Monster', 'Dragon', 'Dragon', 'Ground', q'{Bipedal, tailed form}', 'Blue' , 0, '1:1', 40, 'Sand Force' , 95, 1.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 426 , 'Amorphous' , 'Ghost', 'Flying', q'{Head and arms}', 'Purple', 6, 6, 0, '1:1', 30, 'Aftermath', 'Unburden', 'Flare Boost', 15, 1.2 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 284 , 'Water 1', 'Bug', 'Bug', 'Flying', q'{Two or more pairs of wings}', 'Blue', 6, 6, 0, '1:1', 15, 'Intimidate' , 'Unnerve', 3.6, 0.8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 85 , 'Flying' , 'Normal', 'Flying', q'{Head and legs}', 'Brown' , 0, '1:1', 20, 'Run Away', 'Early Bird', 'Tangled Feet', 85.2, 1.8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 371 , 'Dragon' , 'Dragon' , q'{Bipedal, tailless form}', 'Blue', 9, 9, 0, '1:1', 40, 'Rock Head' , 'Sheer Force', 42.1, 0.6 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 597 , 'Grass', 'Mineral', 'Grass', 'Steel', q'{Head}', 'Gray' , 0, '1:1', 20, 'Iron Barbs' , 18.8, 0.6 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 349 , 'Water 1', 'Dragon', 'Water' , q'{Fins}', 'Brown', 9, 9, 2, '1:1', 20, 'Swift Swim', 'Oblivious', 'Adaptability', 7.4, 0.6 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 86 , 'Water 1', 'Field', 'Water' , q'{Fins}', 'White' , 9, 2, '1:1', 20, 'Thick Fat', 'Hydration', 'Ice Body', 90, 1.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 436 , 'Mineral' , 'Steel', 'Psychic', q'{Head}', 'Green' , 0, 'G', 20, 'Levitate', 'Heatproof', 'Heavy Metal', 60.5, 0.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 396 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Brown' , 1, '1:1', 15, 'Keen Eye' , 'Reckless', 2, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 322 , 'Field' , 'Fire', 'Ground', q'{Quadruped body}', 'Yellow' , 2, '1:1', 20, 'Oblivious', 'Simple', 'Own Tempo', 24, 0.7 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 555, q'|Zen Mode|', 'Z' , 'Field' , 'Fire', 'Psychic', q'{Quadruped body}', 'Blue' , 0, '1:1', 20, 'Zen Mode' , 92.9, 1.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 705 , 'Dragon' , 'Dragon' , q'{Serpentine bodies}', 'Purple', 0, 0, 0, '1:1', 40, 'Sap Sipper', 'Hydration', 'Gooey', 17.5, 0.8 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 479, q'|Mow|' , 'Amorphous' , 'Electric', 'Ghost', q'{Head}', 'Red' , 0, 'G', 20, 'Levitate' , 0.3, 0.3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 585, q'|Spring Form|' , 'Field' , 'Normal', 'Grass', q'{Quadruped body}', 'Pink' , 0, '1:1', 20, 'Chlorophyll', 'Sap Sipper', 'Serene Grace', 19.5, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 215 , 'Field' , 'Dark', 'Ice', q'{Bipedal, tailed form}', 'Black', 9, 9, 0, '1:1', 20, 'Inner Focus', 'Keen Eye', 'Pickpocket', 28, 0.9 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 773, q'|Type: Ghost|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'RKS System' , 100.5, 2.3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 773, q'|Type: Electric|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'RKS System' , 100.5, 2.3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 272 , 'Water 1', 'Grass', 'Water', 'Grass', q'{Bipedal, tailless form}', 'Green' , 0, '1:1', 15, 'Swift Swim', 'Rain Dish', 'Own Tempo', 55, 1.5 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 741, q'|Pom-Pom Style|' , 'Flying' , 'Fire', 'Flying', q'{Single pair of wings}', 'Yellow', 6, 6, 0, '3:1', 20, 'Dancer' , 3.4, 0.6 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 645, q'|Incarnate Forme|' , 'Undiscovered' , 'Ground', 'Flying', q'{Head and arms}', 'Brown' , 0, '0:1U', 120, 'Sand Force' , 'Sheer Force', 68, 1.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 326 , 'Field' , 'Psychic' , q'{Bipedal, tailed form}', 'Purple' , 0, '1:1', 20, 'Thick Fat', 'Own Tempo', 'Gluttony', 71.5, 0.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 446 , 'Undiscovered' , 'Normal' , q'{Bipedal, tailless form}', 'Black', 6, 6, 0, '1:7U', 40, 'Pickup', 'Thick Fat', 'Gluttony', 105, 0.6 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 666, q'|Polar Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 1.2 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 306, q'|Mega|', 'M', q'|Aggronite|', 'Monster' , 'Steel' , q'{Bipedal, tailed form}', 'Gray' , 0, '1:1', 35, 'Filter' , 360, 2.2 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 382, q'|Primal|', 'P', q'|Blue Orb|', 'Undiscovered' , 'Water' , q'{Fins}', 'Blue' , 0, 'GU', 120, 'Primordial Sea' , 352, 9.8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 362 , 'Fairy', 'Mineral', 'Ice' , q'{Head}', 'Gray', 3, 3, 2, '1:1', 20, 'Inner Focus', 'Ice Body', 'Moody', 256.5, 1.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 266 , 'Bug' , 'Bug' , q'{Head}', 'White' , 0, '1:1', 15, 'Shed Skin' , 10, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 256 , 'Field' , 'Fire', 'Fighting', q'{Bipedal, tailed form}', 'Red' , 0, '1:7', 20, 'Blaze' , 'Speed Boost', 19.5, 0.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 178 , 'Flying' , 'Psychic', 'Flying', q'{Single pair of wings}', 'Green' , 6, 0, '1:1', 20, 'Synchronize', 'Early Bird', 'Magic Bounce', 15, 1.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 16 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Brown' , 2, '1:1', 15, 'Keen Eye', 'Tangled Feet', 'Big Pecks', 1.8, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 27 , 'Field' , 'Ground' , q'{Bipedal, tailed form}', 'Yellow', 9, 9, 0, '1:1', 20, 'Sand Veil' , 'Sand Rush', 12, 0.6 );
insert into SPECIES( DEX, CLASS , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 25, q'|Alola Cap|' , 'Field', 'Fairy', 'Electric' , q'{Quadruped body}', 'Yellow', 6, 6, 0, '1:1', 10, 'Static' , 'Lightning Rod', 6, 0.4 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 208, q'|Mega|', 'M', q'|Steelixite|', 'Mineral' , 'Steel', 'Ground', q'{Serpentine bodies}', 'Gray' , 0, '1:1', 25, 'Sand Force' , 400, 10.5 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 225 , 'Water 1', 'Field', 'Ice', 'Flying', q'{Single pair of wings}', 'Red', 9, 9, 0, '1:1', 20, 'Vital Spirit', 'Hustle', 'Insomnia', 16, 0.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 649 , 'Undiscovered' , 'Bug', 'Steel', q'{Bipedal, tailless form}', 'Purple' , 0, 'GU', 120, 'Download' , 82.5, 1.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 122 , 'Human-Like' , 'Psychic', 'Fairy', q'{Bipedal, tailless form}', 'Pink' , 0, 2, '1:1', 25, 'Soundproof', 'Filter', 'Technician', 54.5, 1.3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 773, q'|Type: Fairy|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'RKS System' , 100.5, 2.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 61 , 'Water 1' , 'Water' , q'{Bipedal, tailless form}', 'Blue', 6, 6, 0, '1:1', 20, 'Water Absorb', 'Damp', 'Swift Swim', 20, 1 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 546 , 'Grass', 'Fairy', 'Grass', 'Fairy', q'{Head}', 'Green', 9, 9, 0, '1:1', 20, 'Prankster', 'Infiltrator', 'Chlorophyll', 0.6, 0.3 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 354, q'|Mega|', 'M', q'|Banettite|', 'Amorphous' , 'Ghost' , q'{Bipedal, tailed form}', 'Black' , 6, 0, '1:1', 25, 'Prankster' , 12.5, 1.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 740 , 'Water 3' , 'Fighting', 'Ice', q'{Insectoid body}', 'White' , 0, '1:1', 20, 'Hyper Cutter', 'Iron Fist', 'Anger Point', 180, 1.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 538 , 'Human-Like' , 'Fighting' , q'{Bipedal, tailless form}', 'Red' , 0, '0:1', 20, 'Guts', 'Inner Focus', 'Mold Breaker', 55.5, 1.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 52 , 'Field' , 'Normal' , q'{Quadruped body}', 'Yellow', 9, 9, 2, '1:1', 20, 'Pickup', 'Technician', 'Unnerve', 4.2, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 431 , 'Field' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, '3:1', 20, 'Limber', 'Own Tempo', 'Keen Eye', 3.9, 0.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 577 , 'Amorphous' , 'Psychic' , q'{Head}', 'Green' , 0, '1:1', 20, 'Overcoat', 'Magic Guard', 'Regenerator', 1, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 377 , 'Undiscovered' , 'Rock' , q'{Bipedal, tailless form}', 'Brown' , 0, 'GU', 80, 'Clear Body' , 'Sturdy', 230, 1.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 790 , 'Undiscovered' , 'Psychic' , q'{Head}', 'Blue' , 0, 'GU', 120, 'Sturdy' , 999.9, 0.1 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 89, q'|Alolan|', 'A' , 'Amorphous' , 'Poison', 'Dark', q'{Head and arms}', 'Green', 6, 6, 0, '1:1', 20, 'Poison Touch', 'Gluttony', 'Power of Alchemy', 30, 1 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 801, q'|Original Color|' , 'Undiscovered' , 'Steel', 'Fairy', q'{Bipedal, tailless form}', 'Red' , 0, 'GU', 120, 'Soul-Heart' , 80.5, 1 );
insert into SPECIES( DEX, CLASS , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 25, q'|Belle|' , 'Field', 'Fairy', 'Electric' , q'{Quadruped body}', 'Yellow', 6, 6, 0, '1:1', 10, 'Static' , 'Lightning Rod', 6, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 234 , 'Field' , 'Normal' , q'{Quadruped body}', 'Brown' , 2, '1:1', 20, 'Intimidate', 'Frisk', 'Sap Sipper', 71.2, 1.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 533 , 'Human-Like' , 'Fighting' , q'{Bipedal, tailless form}', 'Gray' , 0, '1:3', 20, 'Guts', 'Sheer Force', 'Iron Fist', 40, 1.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 238 , 'Undiscovered' , 'Ice', 'Psychic', q'{Bipedal, tailless form}', 'Pink' , 15, 2, '1:0U', 25, 'Oblivious', 'Forewarn', 'Hydration', 6, 0.4 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 666, q'|River Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 1.2 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 671, q'|Yellow Flower|' , 'Fairy' , 'Fairy' , q'{Head and arms}', 'White' , 0, '1:0', 20, 'Flower Veil' , 'Symbiosis', 10, 1.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 375 , 'Mineral' , 'Steel', 'Psychic', q'{Head and arms}', 'Blue', 6, 6, 0, 'G', 40, 'Clear Body' , 'Light Metal', 202.5, 1.2 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 180 , 'Monster', 'Field', 'Electric' , q'{Bipedal, tailed form}', 'Pink' , 6, 0, '1:1', 20, 'Static' , 'Plus', 13.3, 0.8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 58 , 'Field' , 'Fire' , q'{Quadruped body}', 'Brown', 9, 9, 0, '1:3', 20, 'Intimidate', 'Flash Fire', 'Justified', 19, 0.7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 676, q'|Diamond Trim|' , 'Field' , 'Normal' , q'{Quadruped body}', 'White' , 6, 0, '1:1', 20, 'Fur Coat' , 28, 1.2 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 260, q'|Mega|', 'M', q'|Swampertite|', 'Monster', 'Water 1', 'Water', 'Ground', q'{Bipedal, tailed form}', 'Blue' , 0, '1:7', 20, 'Swift Swim' , 81.9, 1.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 706 , 'Dragon' , 'Dragon' , q'{Bipedal, tailed form}', 'Purple' , 0, '1:1', 40, 'Sap Sipper', 'Hydration', 'Gooey', 150.5, 2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 128 , 'Field' , 'Normal' , q'{Quadruped body}', 'Brown', 3, 3, 2, '0:1', 20, 'Intimidate', 'Anger Point', 'Sheer Force', 88.4, 1.4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 428 , 'Field', 'Human-Like', 'Normal' , q'{Bipedal, tailed form}', 'Brown' , 6, 0, '1:1', 20, 'Cute Charm', 'Klutz', 'Limber', 33.3, 1.2 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 212, q'|Mega|', 'M', q'|Scizorite|', 'Bug' , 'Bug', 'Steel', q'{Two or more pairs of wings}', 'Red' , 0, '1:1', 25, 'Technician' , 118, 2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 193 , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'Red' , 0, '1:1', 20, 'Speed Boost', 'Compound Eyes', 'Frisk', 38, 1.2 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 773, q'|Type: Flying|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'RKS System' , 100.5, 2.3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 493, q'|Type: Normal|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Multitype' , 320, 3.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 509 , 'Field' , 'Dark' , q'{Quadruped body}', 'Purple' , 0, '1:1', 20, 'Limber', 'Unburden', 'Prankster', 10.1, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 771 , 'Water 1' , 'Water' , q'{Serpentine bodies}', 'Black', 6, 6, 0, '1:1', 15, 'Innards Out' , 'Unaware', 1.2, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 749 , 'Field' , 'Ground' , q'{Quadruped body}', 'Brown', 9, 9, 0, '1:1', 20, 'Own Tempo', 'Stamina', 'Inner Focus', 110, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 31 , 'Undiscovered' , 'Poison', 'Ground', q'{Bipedal, tailed form}', 'Blue' , 2, '1:0U', 20, 'Poison Point', 'Rivalry', 'Sheer Force', 60, 1.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 88 , 'Amorphous' , 'Poison' , q'{Head and arms}', 'Purple', 9, 9, 0, '1:1', 20, 'Stench', 'Sticky Hold', 'Poison Touch', 30, 0.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 506 , 'Field' , 'Normal' , q'{Quadruped body}', 'Brown', 9, 9, 0, '1:1', 15, 'Vital Spirit', 'Pickup', 'Run Away', 4.1, 0.4 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 383, q'|Primal|', 'P', q'|Red Orb|', 'Undiscovered' , 'Ground', 'Fire', q'{Bipedal, tailed form}', 'Red' , 0, 'GU', 120, 'Desolate Land' , 950, 5 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 493, q'|Type: Steel|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Multitype' , 320, 3.2 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 716, q'|Active Mode|' , 'Undiscovered' , 'Fairy' , q'{Quadruped body}', 'Blue' , 0, 'GU', 120, 'Fairy Aura' , 215, 3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 711, q'|Average Size|' , 'Amorphous' , 'Ghost', 'Grass', q'{Head and a base}', 'Brown' , 0, '1:1', 20, 'Pickup', 'Frisk', 'Insomnia', 12.5, 0.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 665 , 'Bug' , 'Bug' , q'{Head and a base}', 'Black' , 0, '1:1', 15, 'Shed Skin' , 'Friend Guard', 8.4, 0.3 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 641, q'|Therian Forme|', 'T' , 'Undiscovered' , 'Flying' , q'{Single pair of wings}', 'Green' , 0, '0:1U', 120, 'Regenerator' , 63, 1.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 328 , 'Bug' , 'Ground' , q'{Insectoid body}', 'Brown', 9, 9, 0, '1:1', 20, 'Hyper Cutter', 'Arena Trap', 'Sheer Force', 15, 0.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 137 , 'Mineral' , 'Normal' , q'{Head and legs}', 'Pink', 9, 9, 2, 'G', 20, 'Trace', 'Download', 'Analytic', 36.5, 0.8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 801 , 'Undiscovered' , 'Steel', 'Fairy', q'{Bipedal, tailless form}', 'Gray' , 0, 'GU', 120, 'Soul-Heart' , 80.5, 1 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 260 , 'Monster', 'Water 1', 'Water', 'Ground', q'{Bipedal, tailed form}', 'Blue' , 0, '1:7', 20, 'Torrent' , 'Damp', 81.9, 1.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 164 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Brown' , 6, 0, '1:1', 15, 'Insomnia', 'Keen Eye', 'Tinted Lens', 40.8, 1.6 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 567 , 'Flying', 'Water 3', 'Rock', 'Flying', q'{Single pair of wings}', 'Yellow' , 0, '1:7', 30, 'Defeatist' , 32, 1.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 488 , 'Undiscovered' , 'Psychic' , q'{Serpentine bodies}', 'Yellow' , 0, '1:0U', 120, 'Levitate' , 85.6, 1.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 789 , 'Undiscovered' , 'Psychic' , q'{Head}', 'Blue' , 0, 'GU', 120, 'Unaware' , 0.1, 0.2 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 389 , 'Monster', 'Grass', 'Grass', 'Ground', q'{Quadruped body}', 'Green' , 0, '1:7', 20, 'Overgrow' , 'Shell Armor', 310, 2.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 591 , 'Grass' , 'Grass', 'Poison', q'{Head and arms}', 'White' , 0, '1:1', 20, 'Effect Spore' , 'Regenerator', 10.5, 0.6 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 54 , 'Water 1', 'Field', 'Water' , q'{Bipedal, tailed form}', 'Yellow', 15, 15, 0, '1:1', 20, 'Damp', 'Cloud Nine', 'Swift Swim', 19.6, 0.8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 2 , 'Monster', 'Grass', 'Grass', 'Poison', q'{Quadruped body}', 'Green' , 0, '1:7', 20, 'Overgrow' , 'Chlorophyll', 13, 1 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 388 , 'Monster', 'Grass', 'Grass' , q'{Quadruped body}', 'Green' , 0, '1:7', 20, 'Overgrow' , 'Shell Armor', 97, 1.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 325 , 'Field' , 'Psychic' , q'{Head and arms}', 'Black' , 0, '1:1', 20, 'Thick Fat', 'Own Tempo', 'Gluttony', 30.6, 0.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 204 , 'Bug' , 'Bug' , q'{Head}', 'Gray' , 9, 0, '1:1', 20, 'Sturdy' , 'Overcoat', 7.2, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 455 , 'Grass' , 'Grass' , q'{Tentacles or a multiped body}', 'Green' , 0, '1:1', 25, 'Levitate' , 27, 1.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 385 , 'Undiscovered' , 'Steel', 'Psychic', q'{Bipedal, tailless form}', 'Yellow' , 0, 'GU', 120, 'Serene Grace' , 1.1, 0.3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 320 , 'Field', 'Water 2', 'Water' , q'{Fins}', 'Blue', 9, 9, 0, '1:1', 40, 'Water Veil', 'Oblivious', 'Pressure', 130, 2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 240 , 'Undiscovered' , 'Fire' , q'{Bipedal, tailed form}', 'Red', 15, 15, 0, '1:3U', 25, 'Flame Body' , 'Vital Spirit', 21.4, 0.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 242 , 'Fairy' , 'Normal' , q'{Bipedal, tailless form}', 'Pink' , 0, 0, '1:0', 40, 'Natural Cure', 'Serene Grace', 'Healer', 46.8, 1.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 602 , 'Amorphous' , 'Electric' , q'{Fins}', 'White' , 0, '1:1', 20, 'Levitate' , 0.3, 0.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 172 , 'Undiscovered' , 'Electric' , q'{Quadruped body}', 'Yellow', 15, 15, 0, '1:1U', 10, 'Static' , 'Lightning Rod', 2, 0.3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 670, q'|Red Flower|' , 'Fairy' , 'Fairy' , q'{Head and arms}', 'White' , 9, 0, '1:0', 20, 'Flower Veil' , 'Symbiosis', 0.9, 0.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 441 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Black' , 0, '1:1', 20, 'Keen Eye', 'Tangled Feet', 'Big Pecks', 1.9, 0.5 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 773, q'|Type: Ice|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'RKS System' , 100.5, 2.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 734 , 'Field' , 'Normal' , q'{Quadruped body}', 'Brown', 9, 9, 0, '1:1', 15, 'Stakeout', 'Strong Jaw', 'Adaptability', 6, 0.4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 451 , 'Bug', 'Water 3', 'Poison', 'Bug', q'{Insectoid body}', 'Purple' , 0, '1:1', 20, 'Battle Armor', 'Sniper', 'Keen Eye', 12, 0.8 );
insert into SPECIES( DEX, CLASS , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 423, q'|West Sea|' , 'Water 1', 'Amorphous', 'Water', 'Ground', q'{Serpentine bodies}', 'Purple', 6, 6, 0, '1:1', 20, 'Sticky Hold', 'Storm Drain', 'Sand Force', 29.9, 0.9 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 270 , 'Water 1', 'Grass', 'Water', 'Grass', q'{Insectoid body}', 'Green' , 0, '1:1', 15, 'Swift Swim', 'Rain Dish', 'Own Tempo', 2.6, 0.5 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 768 , 'Bug', 'Water 3', 'Bug', 'Water', q'{Bipedal, tailless form}', 'Gray' , 0, '1:1', 20, 'Emergency Exit' , 108, 2 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 18, q'|Mega|', 'M', q'|Pidgeotite|', 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Brown' , 0, '1:1', 15, 'No Guard' , 39.5, 2.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 624 , 'Human-Like' , 'Dark', 'Steel', q'{Bipedal, tailless form}', 'Red' , 0, 0, '1:1', 20, 'Defiant', 'Inner Focus', 'Pressure', 10.2, 0.5 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 412, q'|Sandy Cloak|', 'G' , 'Bug' , 'Bug' , q'{Head and a base}', 'Green' , 0, '1:1', 15, 'Shed Skin' , 'Overcoat', 3.4, 0.2 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 87 , 'Water 1', 'Field', 'Water', 'Ice', q'{Fins}', 'White' , 6, 2, '1:1', 20, 'Thick Fat', 'Hydration', 'Ice Body', 120, 1.7 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 386, q'|Speed Forme|', 'S' , 'Undiscovered' , 'Psychic' , q'{Bipedal, tailless form}', 'Red' , 0, 'GU', 120, 'Pressure' , 60.8, 1.7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 791, q'|Radiant Sun phase|' , 'Undiscovered' , 'Psychic', 'Steel', q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Full Metal Body' , 230, 3.4 );
insert into SPECIES( DEX, CLASS , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 25, q'|Sinnoh Cap|' , 'Field', 'Fairy', 'Electric' , q'{Quadruped body}', 'Yellow', 6, 6, 0, '1:1', 10, 'Static' , 'Lightning Rod', 6, 0.4 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 666, q'|Continental Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 1.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 330 , 'Bug' , 'Ground', 'Dragon', q'{Single pair of wings}', 'Green' , 0, '1:1', 20, 'Levitate' , 82, 2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 590 , 'Grass' , 'Grass', 'Poison', q'{Head and arms}', 'White' , 0, '1:1', 20, 'Effect Spore' , 'Regenerator', 1, 0.2 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 671, q'|Red Flower|' , 'Fairy' , 'Fairy' , q'{Head and arms}', 'White' , 0, '1:0', 20, 'Flower Veil' , 'Symbiosis', 10, 1.1 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 773, q'|Type: Fighting|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'RKS System' , 100.5, 2.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 652 , 'Field' , 'Grass', 'Fighting', q'{Bipedal, tailed form}', 'Green' , 0, '1:7', 20, 'Overgrow' , 'Bulletproof', 90, 1.6 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 676, q'|Pharaoh Trim|' , 'Field' , 'Normal' , q'{Quadruped body}', 'White' , 6, 0, '1:1', 20, 'Fur Coat' , 28, 1.2 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 294 , 'Monster', 'Field', 'Normal' , q'{Bipedal, tailed form}', 'Blue' , 0, '1:1', 20, 'Soundproof' , 'Scrappy', 40.5, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 110 , 'Amorphous' , 'Poison' , q'{Multiple bodies}', 'Purple' , 0, '1:1', 20, 'Levitate' , 9.5, 1.2 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 88, q'|Alolan|', 'A' , 'Amorphous' , 'Poison', 'Dark', q'{Head and arms}', 'Purple', 9, 9, 0, '1:1', 20, 'Poison Touch', 'Gluttony', 'Power of Alchemy', 30, 0.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 84 , 'Flying' , 'Normal', 'Flying', q'{Head and legs}', 'Brown' , 0, '1:1', 20, 'Run Away', 'Early Bird', 'Tangled Feet', 39.2, 1.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 644 , 'Undiscovered' , 'Dragon', 'Electric', q'{Bipedal, tailed form}', 'Black' , 0, 'GU', 120, 'Teravolt' , 345, 2.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 466 , 'Human-Like' , 'Electric' , q'{Bipedal, tailed form}', 'Yellow' , 0, '1:3', 25, 'Motor Drive' , 'Vital Spirit', 138.6, 1.8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 241 , 'Field' , 'Normal' , q'{Bipedal, tailed form}', 'Pink', 3, 3, 2, '1:0', 20, 'Thick Fat', 'Scrappy', 'Sap Sipper', 75.5, 1.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 561 , 'Flying' , 'Psychic', 'Flying', q'{Single pair of wings}', 'Black' , 0, '1:1', 20, 'Wonder Skin', 'Magic Guard', 'Tinted Lens', 14, 1.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 38 , 'Field' , 'Fire' , q'{Quadruped body}', 'Yellow' , 0, '3:1', 20, 'Flash Fire' , 'Drought', 19.9, 1.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 462 , 'Mineral' , 'Electric', 'Steel', q'{Head and arms}', 'Gray' , 0, 'G', 20, 'Magnet Pull', 'Sturdy', 'Analytic', 180, 1.2 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 24 , 'Field', 'Dragon', 'Poison' , q'{Serpentine bodies}', 'Purple' , 6, 0, '1:1', 20, 'Intimidate', 'Shed Skin', 'Unnerve', 65, 3.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 19 , 'Field' , 'Normal' , q'{Quadruped body}', 'Purple', 9, 9, 0, '1:1', 15, 'Run Away', 'Guts', 'Hustle', 3.5, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 499 , 'Field' , 'Fire', 'Fighting', q'{Bipedal, tailed form}', 'Red' , 0, '1:7', 20, 'Blaze' , 'Thick Fat', 55.5, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 226 , 'Water 1' , 'Water', 'Flying', q'{Single pair of wings}', 'Purple' , 0, '1:1', 25, 'Swift Swim', 'Water Absorb', 'Water Veil', 220, 2.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 484 , 'Undiscovered' , 'Water', 'Dragon', q'{Bipedal, tailed form}', 'Purple' , 0, 'GU', 120, 'Pressure' , 'Telepathy', 336, 4.2 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 181, q'|Mega|', 'M', q'|Ampharosite|', 'Monster', 'Field', 'Electric', 'Dragon', q'{Bipedal, tailed form}', 'Yellow' , 0, '1:1', 20, 'Mold Breaker' , 61.5, 1.4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 696 , 'Monster', 'Dragon', 'Rock', 'Dragon', q'{Bipedal, tailed form}', 'Brown' , 0, '1:7', 30, 'Strong Jaw' , 'Sturdy', 26, 0.8 );
insert into SPECIES( DEX, CLASS , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 421, q'|Sunshine Form|' , 'Fairy', 'Grass', 'Grass' , q'{Head and legs}', 'Pink' , 0, '1:1', 20, 'Flower Gift' , 9.3, 0.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 755 , 'Grass' , 'Grass', 'Fairy', q'{Head and a base}', 'Purple', 9, 9, 0, '1:1', 20, 'Illuminate', 'Effect Spore', 'Rain Dish', 1.5, 0.2 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 20, q'|Alolan|', 'A' , 'Field' , 'Dark', 'Normal', q'{Quadruped body}', 'Black', 6, 6, 0, '1:1', 15, 'Gluttony', 'Hustle', 'Thick Fat', 18.5, 0.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 513 , 'Field' , 'Fire' , q'{Bipedal, tailed form}', 'Red' , 0, '1:7', 20, 'Gluttony' , 'Blaze', 11, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 37 , 'Field' , 'Fire' , q'{Quadruped body}', 'Brown', 9, 9, 0, '3:1', 20, 'Flash Fire' , 'Drought', 9.9, 0.6 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 271 , 'Water 1', 'Grass', 'Water', 'Grass', q'{Bipedal, tailless form}', 'Green' , 0, '1:1', 15, 'Swift Swim', 'Rain Dish', 'Own Tempo', 32.5, 1.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 474 , 'Mineral' , 'Normal' , q'{Head and arms}', 'Red' , 0, 'G', 20, 'Adaptability', 'Download', 'Analytic', 34, 0.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 704 , 'Dragon' , 'Dragon' , q'{Serpentine bodies}', 'Purple' , 0, '1:1', 40, 'Sap Sipper', 'Hydration', 'Gooey', 2.8, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 664 , 'Bug' , 'Bug' , q'{Insectoid body}', 'Black' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 2.5, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 763 , 'Grass' , 'Grass' , q'{Bipedal, tailless form}', 'Purple' , 0, '1:0', 20, 'Leaf Guard', 'Queenly Majesty', 'Sweet Veil', 21.4, 1.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 475 , 'Amorphous' , 'Psychic', 'Fighting', q'{Bipedal, tailless form}', 'White' , 0, '0:1', 20, 'Steadfast' , 'Justified', 52, 1.6 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 351, q'|Rainy Form|', 'R' , 'Fairy', 'Amorphous', 'Water' , q'{Head}', 'Blue', 0, 0, 0, '1:1', 25, 'Forecast' , 0.8, 0.3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 254 , 'Monster', 'Dragon', 'Grass' , q'{Bipedal, tailed form}', 'Green' , 0, '1:7', 20, 'Overgrow' , 'Unburden', 52.2, 1.7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 460 , 'Monster', 'Grass', 'Grass', 'Ice', q'{Bipedal, tailed form}', 'White' , 0, '1:1', 20, 'Snow Warning' , 'Soundproof', 135.5, 2.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 794 , 'Undiscovered' , 'Bug', 'Fighting', q'{Tentacles or a multiped body}', 'Red' , 0, 'GU', 120, 'Beast Boost' , 333.6, 2.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 788 , 'Undiscovered' , 'Water', 'Fairy', q'{Head and arms}', 'Purple' , 0, 'GU', 15, 'Misty Surge' , 'Telepathy', 21.2, 1.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 155 , 'Field' , 'Fire' , q'{Bipedal, tailless form}', 'Yellow' , 0, '1:7', 20, 'Blaze' , 'Flash Fire', 7.9, 0.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 287 , 'Field' , 'Normal' , q'{Quadruped body}', 'Brown' , 0, '1:1', 15, 'Truant' , 24, 0.8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 315 , 'Fairy', 'Grass', 'Grass', 'Poison', q'{Bipedal, tailless form}', 'Green' , 0, '1:1', 20, 'Natural Cure', 'Poison Point', 'Leaf Guard', 2, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 440 , 'Undiscovered' , 'Normal' , q'{Bipedal, tailless form}', 'Pink', 0, 0, 0, '1:0U', 40, 'Natural Cure', 'Serene Grace', 'Friend Guard', 24.4, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 135 , 'Field' , 'Electric' , q'{Quadruped body}', 'Yellow' , 0, '1:7', 35, 'Volt Absorb' , 'Quick Feet', 24.5, 0.8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 765 , 'Field' , 'Normal', 'Psychic', q'{Bipedal, tailless form}', 'White', 15, 15, 0, '1:1', 20, 'Inner Focus', 'Telepathy', 'Symbiosis', 76, 1.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 142 , 'Flying' , 'Rock', 'Flying', q'{Single pair of wings}', 'Purple' , 0, '1:7', 35, 'Rock Head', 'Pressure', 'Unnerve', 59, 1.8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 228 , 'Field' , 'Dark', 'Fire', q'{Quadruped body}', 'Black' , 9, 0, '1:1', 20, 'Early Bird', 'Flash Fire', 'Unnerve', 10.8, 0.6 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 493, q'|Type: Water|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Multitype' , 320, 3.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 479 , 'Amorphous' , 'Electric', 'Ghost', q'{Head}', 'Red' , 0, 'G', 20, 'Levitate' , 0.3, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 628 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Red', 6, 6, 0, '0:1', 20, 'Keen Eye', 'Sheer Force', 'Defiant', 41, 1.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 545 , 'Bug' , 'Bug', 'Poison', q'{Insectoid body}', 'Red' , 9, '1:1', 20, 'Poison Point', 'Swarm', 'Speed Boost', 200.5, 2.5 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 248, q'|Mega|', 'M', q'|Tyranitarite|', 'Monster' , 'Rock', 'Dark', q'{Bipedal, tailed form}', 'Green' , 0, '1:1', 40, 'Sand Stream' , 202, 2.5 );
insert into SPECIES( DEX, CLASS , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 25, q'|Unova Cap|' , 'Field', 'Fairy', 'Electric' , q'{Quadruped body}', 'Yellow', 6, 6, 0, '1:1', 10, 'Static' , 'Lightning Rod', 6, 0.4 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2 , WEIGHTKG, HEIGHT_M )
values( 718, q'|50% Forme|' , 'Undiscovered' , 'Dragon', 'Ground', q'{Serpentine bodies}', 'Green' , 0, 'GU', 120, 'Aura Break', 'Power Construct' , 305, 1.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 544 , 'Bug' , 'Bug', 'Poison', q'{Head}', 'Gray' , 9, '1:1', 15, 'Poison Point', 'Swarm', 'Speed Boost', 58.5, 1.2 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 273 , 'Field', 'Grass', 'Grass' , q'{Head and legs}', 'Brown' , 0, '1:1', 15, 'Chlorophyll', 'Early Bird', 'Pickpocket', 4, 0.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 143 , 'Monster' , 'Normal' , q'{Bipedal, tailless form}', 'Black', 0, 0, 0, '1:7', 40, 'Immunity', 'Thick Fat', 'Gluttony', 460, 2.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 732 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Black', 9, 9, 0, '1:1', 15, 'Keen Eye', 'Skill Link', 'Pickup', 14.8, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 461 , 'Field' , 'Dark', 'Ice', q'{Bipedal, tailed form}', 'Black' , 0, '1:1', 20, 'Pressure' , 'Pickpocket', 34, 1.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 756 , 'Grass' , 'Grass', 'Fairy', q'{Bipedal, tailless form}', 'Purple', 6, 6, 0, '1:1', 20, 'Illuminate', 'Effect Spore', 'Rain Dish', 11.5, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 698 , 'Monster' , 'Rock', 'Ice', q'{Quadruped body}', 'Blue' , 0, '1:7', 30, 'Refrigerate' , 'Snow Warning', 25.2, 1.3 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 550, q'|Blue-Striped Form|', 'B' , 'Water 2' , 'Water' , q'{Fins}', 'Green' , 0, 8, '1:1', 40, 'Rock Head', 'Adaptability', 'Mold Breaker', 18, 1 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 670, q'|Yellow Flower|' , 'Fairy' , 'Fairy' , q'{Head and arms}', 'White' , 0, 0, '1:0', 20, 'Flower Veil' , 'Symbiosis', 0.9, 0.2 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 692 , 'Water 1', 'Water 3', 'Water' , q'{Insectoid body}', 'Blue' , 9, 0, '1:1', 15, 'Mega Launcher' , 8.3, 0.5 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 83 , 'Flying', 'Field', 'Normal', 'Flying', q'{Single pair of wings}', 'Brown' , 0, '1:1', 20, 'Keen Eye', 'Inner Focus', 'Defiant', 15, 0.8 );
insert into SPECIES( DEX, CLASS , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 25, q'|Partner Cap|' , 'Field', 'Fairy', 'Electric' , q'{Quadruped body}', 'Yellow', 6, 6, 0, '1:1', 10, 'Static' , 'Lightning Rod', 6, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 530 , 'Field' , 'Ground', 'Steel', q'{Bipedal, tailless form}', 'Gray' , 0, '1:1', 20, 'Sand Rush', 'Sand Force', 'Mold Breaker', 40.4, 0.7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 493, q'|Type: Ground|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Multitype' , 320, 3.2 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 598 , 'Grass', 'Mineral', 'Grass', 'Steel', q'{Tentacles or a multiped body}', 'Gray' , 1, '1:1', 20, 'Iron Barbs' , 'Anticipation', 110, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 99 , 'Water 3' , 'Water' , q'{Insectoid body}', 'Red' , 0, '1:1', 20, 'Hyper Cutter', 'Shell Armor', 'Sheer Force', 60, 1.3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 666, q'|Garden Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 1.2 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 676, q'|Debutante Trim|' , 'Field' , 'Normal' , q'{Quadruped body}', 'White' , 6, 0, '1:1', 20, 'Fur Coat' , 28, 1.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 458 , 'Undiscovered' , 'Water', 'Flying', q'{Single pair of wings}', 'Blue' , 15, 0, '1:1U', 25, 'Swift Swim', 'Water Absorb', 'Water Veil', 65, 1 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 746, q'|Solo Form|' , 'Water 2' , 'Water' , q'{Fins}', 'Blue', 9, 9, 0, '1:1', 15, 'Schooling' , 0.3, 0.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 17 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Brown' , 2, '1:1', 15, 'Keen Eye', 'Tangled Feet', 'Big Pecks', 30, 1.1 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 303, q'|Mega|', 'M', q'|Mawilite|', 'Field', 'Fairy', 'Steel', 'Fairy', q'{Bipedal, tailless form}', 'Black' , 6, 0, '1:1', 20, 'Huge Power' , 11.5, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 432 , 'Field' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, '3:1', 20, 'Thick Fat', 'Own Tempo', 'Defiant', 43.8, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 48 , 'Bug' , 'Bug', 'Poison', q'{Bipedal, tailless form}', 'Purple' , 2, '1:1', 20, 'Compound Eyes', 'Tinted Lens', 'Run Away', 30, 1 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 172, q'|Spiky-eared|' , 'Undiscovered' , 'Electric' , q'{Quadruped body}', 'Yellow', 15, 15, 0, '1:1U', 10, 'Static' , 'Lightning Rod', 2, 0.3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 8 , 'Monster', 'Water 1', 'Water' , q'{Bipedal, tailed form}', 'Blue' , 0, '1:7', 20, 'Torrent' , 'Rain Dish', 22.5, 1 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 65, q'|Mega|', 'M', q'|Alakazite|', 'Human-Like' , 'Psychic' , q'{Bipedal, tailless form}', 'Brown' , 0, '1:3', 20, 'Trace' , 48, 1.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 167 , 'Bug' , 'Bug', 'Poison', q'{Insectoid body}', 'Green', 9, 9, 0, '1:1', 15, 'Swarm', 'Insomnia', 'Sniper', 8.5, 0.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 556 , 'Grass' , 'Grass' , q'{Head and a base}', 'Green' , 0, '1:1', 20, 'Water Absorb', 'Chlorophyll', 'Storm Drain', 28, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 637 , 'Bug' , 'Bug', 'Fire', q'{Two or more pairs of wings}', 'White' , 0, 0, '1:1', 40, 'Flame Body' , 'Swarm', 46, 1.6 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 687 , 'Water 1', 'Water 2', 'Dark', 'Psychic', q'{Head and a base}', 'Blue' , 6, 0, '1:1', 20, 'Contrary', 'Suction Cups', 'Infiltrator', 47, 1.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 435 , 'Field' , 'Poison', 'Dark', q'{Quadruped body}', 'Purple' , 0, '1:1', 20, 'Stench', 'Aftermath', 'Keen Eye', 38, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 798 , 'Undiscovered' , 'Grass', 'Steel', q'{Bipedal, tailless form}', 'White' , 0, 'GU', 120, 'Beast Boost' , 0.1, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 667 , 'Field' , 'Fire', 'Normal', q'{Quadruped body}', 'Brown' , 9, 0, '7:1', 20, 'Rivalry', 'Unnerve', 'Moxie', 13.5, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 622 , 'Mineral' , 'Ground', 'Ghost', q'{Bipedal, tailless form}', 'Green' , 15, 0, 'G', 25, 'Iron Fist', 'Klutz', 'No Guard', 92, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 44 , 'Grass' , 'Grass', 'Poison', q'{Bipedal, tailless form}', 'Blue' , 0, '1:1', 20, 'Chlorophyll' , 'Stench', 8.6, 0.8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 619 , 'Field', 'Human-Like', 'Fighting' , q'{Bipedal, tailed form}', 'Yellow' , 6, 0, '1:1', 25, 'Inner Focus', 'Regenerator', 'Reckless', 20, 0.9 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 80 , 'Monster', 'Water 1', 'Water', 'Psychic', q'{Bipedal, tailed form}', 'Pink', 3, 3, 0, '1:1', 20, 'Oblivious', 'Own Tempo', 'Regenerator', 78.5, 1.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 573 , 'Field' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, '3:1', 15, 'Cute Charm', 'Technician', 'Skill Link', 7.5, 0.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 799 , 'Undiscovered' , 'Dark', 'Dragon', q'{Bipedal, tailed form}', 'Black' , 0, 'GU', 120, 'Beast Boost' , 888, 5.5 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 140 , 'Water 1', 'Water 3', 'Rock', 'Water', q'{Insectoid body}', 'Brown' , 0, '1:7', 30, 'Swift Swim', 'Battle Armor', 'Weak Armor', 11.5, 0.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 784 , 'Dragon' , 'Dragon', 'Fighting', q'{Bipedal, tailed form}', 'Gray', 0, 0, 0, '1:1', 40, 'Bulletproof', 'Soundproof', 'Overcoat', 78.2, 1.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 136 , 'Field' , 'Fire' , q'{Quadruped body}', 'Red' , 0, '1:7', 35, 'Flash Fire' , 'Guts', 25, 0.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 658 , 'Water 1' , 'Water', 'Dark', q'{Bipedal, tailless form}', 'Blue' , 0, '1:7', 20, 'Torrent' , 'Protean', 40, 1.5 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 303 , 'Field', 'Fairy', 'Steel', 'Fairy', q'{Bipedal, tailless form}', 'Black' , 6, 0, '1:1', 20, 'Hyper Cutter', 'Intimidate', 'Sheer Force', 11.5, 0.6 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 194 , 'Water 1', 'Field', 'Water', 'Ground', q'{Head and legs}', 'Blue' , 0, '1:1', 20, 'Damp', 'Water Absorb', 'Unaware', 8.5, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 498 , 'Field' , 'Fire' , q'{Quadruped body}', 'Red' , 0, '1:7', 20, 'Blaze' , 'Thick Fat', 9.9, 0.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 643 , 'Undiscovered' , 'Dragon', 'Fire', q'{Single pair of wings}', 'White' , 0, 'GU', 120, 'Turboblaze' , 330, 3.2 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 28, q'|Alolan|', 'A' , 'Field' , 'Ice', 'Steel', q'{Bipedal, tailed form}', 'Blue' , 0, '1:1', 20, 'Snow Cloak' , 'Slush Rush', 29.5, 1.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 615 , 'Mineral' , 'Ice' , q'{Head}', 'Blue' , 0, 'G', 25, 'Levitate' , 148, 1.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 542 , 'Bug' , 'Bug', 'Grass', q'{Bipedal, tailless form}', 'Yellow' , 0, '1:1', 15, 'Swarm', 'Chlorophyll', 'Overcoat', 20.5, 1.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 735 , 'Field' , 'Normal' , q'{Quadruped body}', 'Brown', 6, 6, 0, '1:1', 15, 'Stakeout', 'Strong Jaw', 'Adaptability', 14.2, 0.7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 773, q'|Type: Rock|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'RKS System' , 100.5, 2.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 781 , 'Mineral' , 'Ghost', 'Grass', q'{Head and a base}', 'Green', 3, 3, 0, 'G', 25, 'Steelworker' , 210, 3.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 403 , 'Field' , 'Electric' , q'{Quadruped body}', 'Blue' , 0, '1:1', 20, 'Rivalry', 'Intimidate', 'Guts', 9.5, 0.5 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 710, q'|Large Size|' , 'Amorphous' , 'Ghost', 'Grass', q'{Head}', 'Brown' , 0, '1:1', 20, 'Pickup', 'Frisk', 'Insomnia', 7.5, 0.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 376 , 'Mineral' , 'Steel', 'Psychic', q'{Multiple bodies}', 'Blue' , 0, 'G', 40, 'Clear Body' , 'Light Metal', 550, 1.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 219 , 'Amorphous' , 'Fire', 'Rock', q'{Serpentine bodies}', 'Red' , 0, '1:1', 20, 'Magma Armor', 'Flame Body', 'Weak Armor', 55, 0.8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 560 , 'Field', 'Dragon', 'Dark', 'Fighting', q'{Bipedal, tailed form}', 'Red' , 6, 0, '1:1', 15, 'Shed Skin', 'Moxie', 'Intimidate', 30, 1.1 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 558 , 'Bug', 'Mineral', 'Bug', 'Rock', q'{Insectoid body}', 'Red' , 0, '1:1', 20, 'Sturdy', 'Shell Armor', 'Weak Armor', 200, 1.4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 363 , 'Water 1', 'Field', 'Ice', 'Water', q'{Fins}', 'Blue' , 2, '1:1', 20, 'Thick Fat', 'Ice Body', 'Oblivious', 39.5, 0.8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 195 , 'Water 1', 'Field', 'Water', 'Ground', q'{Bipedal, tailed form}', 'Blue' , 0, '1:1', 20, 'Damp', 'Water Absorb', 'Unaware', 75, 1.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 569 , 'Mineral' , 'Poison' , q'{Bipedal, tailless form}', 'Green', 6, 6, 0, '1:1', 20, 'Stench', 'Weak Armor', 'Aftermath', 107.3, 1.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 161 , 'Field' , 'Normal' , q'{Quadruped body}', 'Brown' , 0, '1:1', 15, 'Run Away', 'Keen Eye', 'Frisk', 6, 0.8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 229 , 'Field' , 'Dark', 'Fire', q'{Quadruped body}', 'Black' , 6, 0, '1:1', 20, 'Early Bird', 'Flash Fire', 'Unnerve', 35, 1.4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 332 , 'Grass', 'Human-Like', 'Grass', 'Dark', q'{Bipedal, tailless form}', 'Green' , 0, '1:1', 20, 'Sand Veil' , 'Water Absorb', 77.4, 1.3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 621 , 'Dragon', 'Monster', 'Dragon' , q'{Bipedal, tailed form}', 'Red' , 3, 0, '1:1', 30, 'Rough Skin', 'Sheer Force', 'Mold Breaker', 139, 1.6 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 376, q'|Mega|', 'M', q'|Metagrossite|', 'Mineral' , 'Steel', 'Psychic', q'{Multiple bodies}', 'Blue' , 0, 'G', 40, 'Tough Claws' , 550, 2.5 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 199 , 'Monster', 'Water 1', 'Water', 'Psychic', q'{Bipedal, tailed form}', 'Pink', 0, 0, 0, '1:1', 20, 'Oblivious', 'Own Tempo', 'Regenerator', 79.5, 2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 65 , 'Human-Like' , 'Psychic' , q'{Bipedal, tailless form}', 'Brown' , 0, '1:3', 20, 'Synchronize', 'Inner Focus', 'Magic Guard', 48, 1.5 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 690 , 'Water 1', 'Dragon', 'Poison', 'Water', q'{Head and a base}', 'Brown' , 9, 0, '1:1', 20, 'Poison Point', 'Poison Touch', 'Adaptability', 7.3, 0.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 482 , 'Undiscovered' , 'Psychic' , q'{Bipedal, tailed form}', 'Blue' , 0, 'GU', 80, 'Levitate' , 0.3, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 491 , 'Undiscovered' , 'Dark' , q'{Bipedal, tailless form}', 'Black' , 0, 'GU', 120, 'Bad Dreams' , 50.5, 1.5 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 610 , 'Monster', 'Dragon', 'Dragon' , q'{Bipedal, tailed form}', 'Green' , 0, '1:1', 40, 'Rivalry', 'Mold Breaker', 'Unnerve', 18, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 76 , 'Mineral' , 'Rock', 'Ground', q'{Bipedal, tailless form}', 'Brown' , 0, '1:1', 15, 'Rock Head', 'Sturdy', 'Sand Veil', 300, 1.4 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 493, q'|Type: Fighting|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Multitype' , 320, 3.2 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 176 , 'Flying', 'Fairy', 'Fairy', 'Flying', q'{Bipedal, tailless form}', 'White' , 0, '1:7', 10, 'Hustle', 'Serene Grace', 'Super Luck', 3.2, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 384 , 'Undiscovered' , 'Dragon', 'Flying', q'{Serpentine bodies}', 'Green' , 0, 'GU', 120, 'Air Lock' , 206.5, 7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 11 , 'Bug' , 'Bug' , q'{Serpentine bodies}', 'Green', 15, 15, 0, '1:1', 15, 'Shed Skin' , 9.9, 0.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 299 , 'Mineral' , 'Rock' , q'{Bipedal, tailless form}', 'Gray', 9, 9, 0, '1:1', 20, 'Sturdy', 'Magnet Pull', 'Sand Force', 97, 1 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 666, q'|Sandstorm Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 1.2 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 392 , 'Field', 'Human-Like', 'Fire', 'Fighting', q'{Bipedal, tailed form}', 'Brown' , 0, '1:7', 20, 'Blaze' , 'Iron Fist', 55, 1.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 606 , 'Human-Like' , 'Psychic' , q'{Bipedal, tailless form}', 'Brown' , 15, 0, '1:1', 20, 'Telepathy', 'Synchronize', 'Analytic', 34.5, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 797 , 'Undiscovered' , 'Steel', 'Flying', q'{Bipedal, tailless form}', 'Green' , 0, 'GU', 120, 'Beast Boost' , 999.9, 9.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 614 , 'Field' , 'Ice' , q'{Quadruped body}', 'White' , 2, '1:1', 20, 'Snow Cloak', 'Slush Rush', 'Swift Swim', 260, 2.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 96 , 'Human-Like' , 'Psychic' , q'{Bipedal, tailless form}', 'Yellow', 9, 9, 2, '1:1', 20, 'Insomnia', 'Forewarn', 'Inner Focus', 32.4, 1 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 444 , 'Monster', 'Dragon', 'Dragon', 'Ground', q'{Bipedal, tailed form}', 'Blue', 0, 0, 0, '1:1', 40, 'Sand Veil' , 'Rough Skin', 56, 1.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 748 , 'Water 1' , 'Poison', 'Water', q'{Tentacles or a multiped body}', 'Blue' , 0, '1:1', 20, 'Merciless', 'Limber', 'Regenerator', 14.5, 0.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 632 , 'Bug' , 'Bug', 'Steel', q'{Insectoid body}', 'Gray' , 0, '1:1', 20, 'Swarm', 'Hustle', 'Truant', 33, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 118 , 'Water 2' , 'Water' , q'{Fins}', 'Red', 9, 9, 0, '1:1', 20, 'Swift Swim', 'Water Veil', 'Lightning Rod', 15, 0.6 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 648, q'|Aria Forme|' , 'Undiscovered' , 'Normal', 'Psychic', q'{Bipedal, tailless form}', 'White' , 0, 'GU', 120, 'Serene Grace' , 6.5, 0.6 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 391 , 'Field', 'Human-Like', 'Fire', 'Fighting', q'{Bipedal, tailed form}', 'Brown' , 0, '1:7', 20, 'Blaze' , 'Iron Fist', 22, 0.9 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 675 , 'Field', 'Human-Like', 'Fighting', 'Dark', q'{Bipedal, tailless form}', 'White', 0, 0, 0, '1:1', 25, 'Iron Fist', 'Mold Breaker', 'Scrappy', 136, 2.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 42 , 'Flying' , 'Poison', 'Flying', q'{Single pair of wings}', 'Purple', 9, 9, 0, '1:1', 15, 'Inner Focus' , 'Infiltrator', 55, 1.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 255 , 'Field' , 'Fire' , q'{Head and legs}', 'Red' , 0, '1:7', 20, 'Blaze' , 'Speed Boost', 2.5, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 717 , 'Undiscovered' , 'Dark', 'Flying', q'{Single pair of wings}', 'Red' , 0, 'GU', 120, 'Dark Aura' , 203, 5.8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 783 , 'Dragon' , 'Dragon', 'Fighting', q'{Bipedal, tailed form}', 'Gray', 6, 6, 0, '1:1', 40, 'Bulletproof', 'Soundproof', 'Overcoat', 47, 1.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 94 , 'Amorphous' , 'Ghost', 'Poison', q'{Bipedal, tailed form}', 'Purple', 0, 0, 8, '1:1', 20, 'Cursed Body' , 40.5, 1.5 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 479, q'|Fan|' , 'Amorphous' , 'Electric', 'Ghost', q'{Head}', 'Red' , 0, 'G', 20, 'Levitate' , 0.3, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 608 , 'Amorphous' , 'Ghost', 'Fire', q'{Head and arms}', 'Black' , 9, '1:1', 20, 'Flash Fire', 'Flame Body', 'Infiltrator', 13, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 239 , 'Undiscovered' , 'Electric' , q'{Bipedal, tailless form}', 'Yellow', 15, 15, 0, '1:3U', 25, 'Static' , 'Vital Spirit', 23.5, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 345 , 'Water 3' , 'Rock', 'Grass', q'{Head and a base}', 'Purple' , 0, '1:7', 30, 'Suction Cups' , 'Storm Drain', 23.8, 1 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 620 , 'Field', 'Human-Like', 'Fighting' , q'{Bipedal, tailed form}', 'Purple' , 3, 0, '1:1', 25, 'Inner Focus', 'Regenerator', 'Reckless', 35.5, 1.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 304 , 'Monster' , 'Steel', 'Rock', q'{Quadruped body}', 'Gray' , 0, '1:1', 35, 'Sturdy', 'Rock Head', 'Heavy Metal', 60, 0.4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 427 , 'Field', 'Human-Like', 'Normal' , q'{Bipedal, tailed form}', 'Brown' , 9, 0, '1:1', 20, 'Run Away', 'Klutz', 'Limber', 5.5, 0.4 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 334, q'|Mega|', 'M', q'|Altarianite|', 'Flying', 'Dragon', 'Dragon', 'Fairy', q'{Single pair of wings}', 'Blue' , 0, '1:1', 20, 'Pixilate' , 20.6, 1.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 249 , 'Undiscovered' , 'Psychic', 'Flying', q'{Single pair of wings}', 'White' , 0, 'GU', 120, 'Pressure' , 'Multiscale', 216, 5.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 437 , 'Mineral' , 'Steel', 'Psychic', q'{Head and arms}', 'Green' , 0, 'G', 20, 'Levitate', 'Heatproof', 'Heavy Metal', 187, 1.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 359 , 'Field' , 'Dark' , q'{Quadruped body}', 'White', 3, 3, 2, '1:1', 25, 'Pressure', 'Super Luck', 'Justified', 47, 1.2 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 643, q'|Overdrive mode|' , 'Undiscovered' , 'Dragon', 'Fire', q'{Single pair of wings}', 'White' , 0, 'GU', 120, 'Turboblaze' , 330, 3.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 712 , 'Monster' , 'Ice' , q'{Quadruped body}', 'Blue' , 0, '1:1', 20, 'Own Tempo', 'Ice Body', 'Sturdy', 99.5, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 378 , 'Undiscovered' , 'Ice' , q'{Bipedal, tailless form}', 'Blue' , 0, 'GU', 80, 'Clear Body' , 'Ice Body', 175, 1.8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 147 , 'Water 1', 'Dragon', 'Dragon' , q'{Serpentine bodies}', 'Blue', 9, 9, 0, '1:1', 40, 'Shed Skin' , 'Marvel Scale', 3.3, 1.8 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 493, q'|Type: Flying|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Multitype' , 320, 3.2 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 666, q'|Ocean Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 1.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 62 , 'Water 1' , 'Water', 'Fighting', q'{Bipedal, tailless form}', 'Blue', 0, 0, 0, '1:1', 20, 'Water Absorb', 'Damp', 'Swift Swim', 54, 1.3 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 74, q'|Alolan|', 'A' , 'Mineral' , 'Rock', 'Electric', q'{Head and arms}', 'Gray', 9, 9, 0, '1:1', 15, 'Magnet Pull', 'Sturdy', 'Galvanize', 20, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 549 , 'Grass' , 'Grass' , q'{Head and a base}', 'Green' , 0, '1:0', 20, 'Chlorophyll', 'Own Tempo', 'Leaf Guard', 16.3, 1.1 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 669, q'|Blue Flower|' , 'Fairy' , 'Fairy' , q'{Head and arms}', 'White' , 15, 0, '1:0', 20, 'Flower Veil' , 'Symbiosis', 0.1, 0.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 358 , 'Amorphous' , 'Psychic' , q'{Head and arms}', 'Blue' , 0, '1:1', 25, 'Levitate' , 1, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 589 , 'Bug' , 'Bug', 'Steel', q'{Head and arms}', 'Gray' , 0, '1:1', 15, 'Swarm', 'Shell Armor', 'Overcoat', 33, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 347 , 'Water 3' , 'Rock', 'Bug', q'{Insectoid body}', 'Gray' , 0, '1:7', 30, 'Battle Armor' , 'Swift Swim', 12.5, 0.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 796 , 'Undiscovered' , 'Electric' , q'{Bipedal, tailed form}', 'Black' , 0, 'GU', 120, 'Beast Boost' , 100, 3.8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 75 , 'Mineral' , 'Rock', 'Ground', q'{Bipedal, tailless form}', 'Brown', 6, 6, 0, '1:1', 15, 'Rock Head', 'Sturdy', 'Sand Veil', 105, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 211 , 'Water 2' , 'Water', 'Poison', q'{Fins}', 'Gray' , 0, '1:1', 20, 'Poison Point', 'Swift Swim', 'Intimidate', 3.9, 0.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 12 , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White', 0, 0, 0, '1:1', 15, 'Compound Eyes' , 'Tinted Lens', 32, 1.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 45 , 'Grass' , 'Grass', 'Poison', q'{Bipedal, tailless form}', 'Red' , 0, '1:1', 20, 'Chlorophyll' , 'Effect Spore', 18.6, 1.2 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 802, q'|Zenith|' , 'Undiscovered' , 'Fighting', 'Ghost', q'{Bipedal, tailless form}', 'Gray' , 0, 'GU', 120, 'Technician' , 22.2, 0.7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 47 , 'Bug', 'Grass', 'Bug', 'Grass', q'{Insectoid body}', 'Red', 6, 6, 2, '1:1', 20, 'Effect Spore', 'Dry Skin', 'Damp', 29.5, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 540 , 'Bug' , 'Bug', 'Grass', q'{Insectoid body}', 'Yellow' , 0, '1:1', 15, 'Swarm', 'Chlorophyll', 'Overcoat', 2.5, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 165 , 'Bug' , 'Bug', 'Flying', q'{Single pair of wings}', 'Red', 9, 9, 0, '1:1', 15, 'Swarm', 'Early Bird', 'Rattled', 10.8, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 127 , 'Bug' , 'Bug' , q'{Bipedal, tailless form}', 'Brown', 3, 3, 2, '1:1', 25, 'Hyper Cutter', 'Mold Breaker', 'Moxie', 55, 1.5 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 493, q'|Type: Rock|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Multitype' , 320, 3.2 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 29 , 'Monster', 'Field', 'Poison' , q'{Quadruped body}', 'Blue' , 2, '1:0', 20, 'Poison Point', 'Rivalry', 'Hustle', 7, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 105 , 'Monster' , 'Ground' , q'{Bipedal, tailed form}', 'Brown', 3, 3, 0, '1:1', 20, 'Rock Head', 'Lightning Rod', 'Battle Armor', 45, 1 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 566 , 'Flying', 'Water 3', 'Rock', 'Flying', q'{Single pair of wings}', 'Yellow' , 0, '1:7', 30, 'Defeatist' , 9.5, 0.6 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 282, q'|Mega|', 'M', q'|Gardevoirite|', 'Amorphous' , 'Psychic', 'Fairy', q'{Bipedal, tailless form}', 'White' , 0, '1:1', 20, 'Pixilate' , 48.4, 1.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 630 , 'Flying' , 'Dark', 'Flying', q'{Single pair of wings}', 'Brown', 6, 6, 0, '1:0', 20, 'Big Pecks', 'Overcoat', 'Weak Armor', 39.5, 1.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 337 , 'Mineral' , 'Rock', 'Psychic', q'{Head}', 'Yellow' , 0, 'G', 25, 'Levitate' , 168, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 662 , 'Flying' , 'Fire', 'Flying', q'{Single pair of wings}', 'Red', 6, 6, 0, '1:1', 15, 'Flame Body' , 'Gale Wings', 16, 0.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 507 , 'Field' , 'Normal' , q'{Quadruped body}', 'Gray', 6, 6, 0, '1:1', 15, 'Intimidate', 'Sand Rush', 'Scrappy', 14.7, 0.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 113 , 'Fairy' , 'Normal' , q'{Bipedal, tailed form}', 'Pink', 0, 9, 0, '1:0', 40, 'Natural Cure', 'Serene Grace', 'Healer', 34.6, 1.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 56 , 'Field' , 'Fighting' , q'{Bipedal, tailed form}', 'Brown', 9, 9, 2, '1:1', 20, 'Vital Spirit', 'Anger Point', 'Defiant', 28, 0.5 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 1 , 'Monster', 'Grass', 'Grass', 'Poison', q'{Quadruped body}', 'Green' , 0, '1:7', 20, 'Overgrow' , 'Chlorophyll', 6.9, 0.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 470 , 'Field' , 'Grass' , q'{Quadruped body}', 'Green' , 0, '1:7', 35, 'Leaf Guard' , 'Chlorophyll', 25.5, 1 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 676, q'|Star Trim|' , 'Field' , 'Normal' , q'{Quadruped body}', 'White' , 6, 0, '1:1', 20, 'Fur Coat' , 28, 1.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 700 , 'Field' , 'Fairy' , q'{Quadruped body}', 'Pink' , 0, '1:7', 35, 'Cute Charm' , 'Pixilate', 23.5, 1 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 618 , 'Water 1', 'Amorphous', 'Ground', 'Electric', q'{Fins}', 'Brown' , 0, '1:1', 20, 'Static', 'Limber', 'Sand Veil', 11, 0.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 169 , 'Flying' , 'Poison', 'Flying', q'{Two or more pairs of wings}', 'Purple', 0, 0, 0, '1:1', 15, 'Inner Focus' , 'Infiltrator', 75, 1.8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 721 , 'Undiscovered' , 'Fire', 'Water', q'{Quadruped body}', 'Brown' , 0, 'GU', 120, 'Water Absorb' , 195, 1.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 21 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Brown', 9, 9, 0, '1:1', 15, 'Keen Eye' , 'Sniper', 2, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 583 , 'Mineral' , 'Ice' , q'{Head and a base}', 'White', 0, 0, 2, '1:1', 20, 'Ice Body', 'Snow Cloak', 'Weak Armor', 41, 1.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 43 , 'Grass' , 'Grass', 'Poison', q'{Head and legs}', 'Blue' , 0, '1:1', 20, 'Chlorophyll' , 'Run Away', 5.4, 0.5 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 741, q'|Pa'u Style|' , 'Flying' , 'Fire', 'Flying', q'{Single pair of wings}', 'Pink', 6, 6, 0, '3:1', 20, 'Dancer' , 3.4, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 268 , 'Bug' , 'Bug' , q'{Head}', 'Purple' , 0, '1:1', 15, 'Shed Skin' , 11.5, 0.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 329 , 'Bug' , 'Ground', 'Dragon', q'{Two or more pairs of wings}', 'Green', 6, 6, 0, '1:1', 20, 'Levitate' , 15.3, 1.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 762 , 'Grass' , 'Grass' , q'{Bipedal, tailless form}', 'Purple', 6, 6, 0, '1:0', 20, 'Leaf Guard', 'Oblivious', 'Sweet Veil', 8.2, 0.7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 773, q'|Type: Dragon|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'RKS System' , 100.5, 2.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 539 , 'Human-Like' , 'Fighting' , q'{Bipedal, tailless form}', 'Blue' , 0, '0:1', 20, 'Sturdy', 'Inner Focus', 'Mold Breaker', 51, 1.4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 776 , 'Monster', 'Dragon', 'Fire', 'Dragon', q'{Bipedal, tailed form}', 'Red', 3, 3, 0, '1:1', 20, 'Shell Armor' , 212, 2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 297 , 'Human-Like' , 'Fighting' , q'{Bipedal, tailless form}', 'Brown', 6, 6, 0, '1:3', 20, 'Thick Fat', 'Guts', 'Sheer Force', 253.8, 2.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 35 , 'Fairy' , 'Fairy' , q'{Bipedal, tailed form}', 'Pink', 6, 6, 2, '3:1', 10, 'Cute Charm', 'Magic Guard', 'Friend Guard', 7.5, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 306 , 'Monster' , 'Steel', 'Rock', q'{Bipedal, tailed form}', 'Gray' , 0, '1:1', 35, 'Sturdy', 'Rock Head', 'Heavy Metal', 360, 2.1 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 183 , 'Water 1', 'Fairy', 'Water', 'Fairy', q'{Bipedal, tailed form}', 'Blue' , 0, '1:1', 10, 'Thick Fat', 'Huge Power', 'Sap Sipper', 8.5, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 430 , 'Flying' , 'Dark', 'Flying', q'{Single pair of wings}', 'Black' , 0, '1:1', 20, 'Insomnia', 'Super Luck', 'Moxie', 27.3, 0.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 657 , 'Water 1' , 'Water' , q'{Bipedal, tailless form}', 'Blue' , 0, '1:7', 20, 'Torrent' , 'Protean', 10.9, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 59 , 'Field' , 'Fire' , q'{Quadruped body}', 'Brown' , 0, '1:3', 20, 'Intimidate', 'Flash Fire', 'Justified', 155, 1.9 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 555, q'|Standard Mode|' , 'Field' , 'Fire' , q'{Quadruped body}', 'Red' , 0, '1:1', 20, 'Sheer Force' , 'Zen Mode', 92.9, 1.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 60 , 'Water 1' , 'Water' , q'{Head and legs}', 'Blue', 9, 9, 0, '1:1', 20, 'Water Absorb', 'Damp', 'Swift Swim', 12.4, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 685 , 'Fairy' , 'Fairy' , q'{Bipedal, tailless form}', 'White' , 0, '1:1', 20, 'Sweet Veil' , 'Unburden', 5, 0.8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 356 , 'Amorphous' , 'Ghost' , q'{Bipedal, tailless form}', 'Black' , 1, '1:1', 25, 'Pressure' , 'Frisk', 30.6, 1.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 654 , 'Field' , 'Fire' , q'{Bipedal, tailed form}', 'Red' , 0, '1:7', 20, 'Blaze' , 'Magician', 14.5, 1 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 150, q'|Mega  X|', 'MX' , 'Undiscovered' , 'Psychic' , q'{Bipedal, tailed form}', 'Purple' , 0, 'GU', 120, 'Steadfast' , 122, 2.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 247 , 'Monster' , 'Rock', 'Ground', q'{Serpentine bodies}', 'Gray' , 9, 0, '1:1', 40, 'Shed Skin' , 152, 1.2 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 158 , 'Monster', 'Water 1', 'Water' , q'{Bipedal, tailed form}', 'Blue' , 0, '1:7', 20, 'Torrent' , 'Sheer Force', 9.5, 0.6 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 752 , 'Water 1', 'Bug', 'Water', 'Bug', q'{Insectoid body}', 'Green', 6, 6, 0, '1:1', 15, 'Water Bubble' , 'Water Absorb', 82, 1.8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 25 , 'Field', 'Fairy', 'Electric' , q'{Quadruped body}', 'Yellow', 6, 6, 0, '1:1', 10, 'Static' , 'Lightning Rod', 6, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 515 , 'Field' , 'Water' , q'{Bipedal, tailed form}', 'Blue' , 0, '1:7', 20, 'Gluttony' , 'Torrent', 13.5, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 281 , 'Amorphous' , 'Psychic', 'Fairy', q'{Bipedal, tailless form}', 'White' , 0, '1:1', 20, 'Synchronize', 'Trace', 'Telepathy', 20.2, 0.8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 275 , 'Field', 'Grass', 'Grass', 'Dark', q'{Bipedal, tailless form}', 'Brown' , 0, '1:1', 15, 'Chlorophyll', 'Early Bird', 'Pickpocket', 59.6, 1.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 517 , 'Field' , 'Psychic' , q'{Quadruped body}', 'Pink' , 0, '1:1', 10, 'Forewarn', 'Synchronize', 'Telepathy', 23.3, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 339 , 'Water 2' , 'Water', 'Ground', q'{Fins}', 'Gray', 9, 9, 2, '1:1', 20, 'Oblivious', 'Anticipation', 'Hydration', 1.9, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 324 , 'Field' , 'Fire' , q'{Quadruped body}', 'Brown', 6, 6, 2, '1:1', 20, 'White Smoke', 'Drought', 'Shell Armor', 80.4, 0.5 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 26, q'|Alolan|', 'A' , 'Field', 'Fairy', 'Electric', 'Psychic', q'{Bipedal, tailed form}', 'Brown' , 0, '1:1', 10, 'Surge Surfer' , 30, 0.7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 407 , 'Fairy', 'Grass', 'Grass', 'Poison', q'{Bipedal, tailless form}', 'Green' , 0, '1:1', 20, 'Natural Cure', 'Poison Point', 'Technician', 14.5, 0.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 251 , 'Undiscovered' , 'Psychic', 'Grass', q'{Bipedal, tailless form}', 'Green' , 0, 'GU', 120, 'Natural Cure' , 5, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 264 , 'Field' , 'Normal' , q'{Quadruped body}', 'White' , 2, '1:1', 15, 'Pickup', 'Gluttony', 'Quick Feet', 32.5, 0.5 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 210 , 'Field', 'Fairy', 'Fairy' , q'{Bipedal, tailed form}', 'Purple', 6, 6, 2, '3:1', 20, 'Intimidate', 'Quick Feet', 'Rattled', 48.7, 1.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 523 , 'Field' , 'Electric' , q'{Quadruped body}', 'Black' , 0, '1:1', 20, 'Lightning Rod', 'Motor Drive', 'Sap Sipper', 79.5, 1.6 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 428, q'|Mega|', 'M', q'|Lopunnite|', 'Field', 'Human-Like', 'Normal', 'Fighting', q'{Bipedal, tailed form}', 'Brown' , 6, 0, '1:1', 20, 'Scrappy' , 33.3, 1.3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 418 , 'Water 1', 'Field', 'Water' , q'{Quadruped body}', 'Brown' , 0, '1:1', 20, 'Swift Swim' , 'Water Veil', 29.5, 0.7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 580 , 'Water 1', 'Flying', 'Water', 'Flying', q'{Single pair of wings}', 'Blue' , 0, '1:1', 20, 'Keen Eye', 'Big Pecks', 'Hydration', 5.5, 0.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 355 , 'Amorphous' , 'Ghost' , q'{Head and arms}', 'Black' , 1, '1:1', 25, 'Levitate' , 'Frisk', 15, 0.8 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 413, q'|Sandy Cloak|', 'G' , 'Bug' , 'Bug', 'Ground', q'{Head and a base}', 'Brown' , 0, '1:0', 15, 'Anticipation' , 'Overcoat', 6.5, 0.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 791 , 'Undiscovered' , 'Psychic', 'Steel', q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Full Metal Body' , 230, 3.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 232 , 'Field' , 'Ground' , q'{Quadruped body}', 'Gray' , 0, '1:1', 20, 'Sturdy' , 'Sand Veil', 120, 1.1 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 676, q'|La Reine Trim|' , 'Field' , 'Normal' , q'{Quadruped body}', 'White' , 6, 0, '1:1', 20, 'Fur Coat' , 28, 1.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 233 , 'Mineral' , 'Normal' , q'{Head and legs}', 'Red', 6, 6, 2, 'G', 20, 'Trace', 'Download', 'Analytic', 32.5, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 633 , 'Dragon' , 'Dark', 'Dragon', q'{Quadruped body}', 'Blue' , 0, '1:1', 40, 'Hustle' , 17.3, 0.8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 724 , 'Flying' , 'Grass', 'Ghost', q'{Single pair of wings}', 'Brown' , 0, '1:7', 15, 'Overgrow' , 'Long Reach', 36.6, 1.6 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 493, q'|Type: Poison|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Multitype' , 320, 3.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 120 , 'Water 3' , 'Water' , q'{Head and a base}', 'Brown', 9, 9, 0, 'G', 20, 'Illuminate', 'Natural Cure', 'Analytic', 34.5, 0.8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 292 , 'Mineral' , 'Bug', 'Ghost', q'{Head and a base}', 'Brown' , 0, 'G', 15, 'Wonder Guard' , 1.2, 0.8 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 412, q'|Plant Cloak|' , 'Bug' , 'Bug' , q'{Head and a base}', 'Green' , 0, '1:1', 15, 'Shed Skin' , 'Overcoat', 3.4, 0.2 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 357 , 'Monster', 'Grass', 'Grass', 'Flying', q'{Quadruped body}', 'Green' , 3, 2, '1:1', 25, 'Chlorophyll', 'Solar Power', 'Harvest', 100, 2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 579 , 'Amorphous' , 'Psychic' , q'{Head and arms}', 'Green' , 0, '1:1', 20, 'Overcoat', 'Magic Guard', 'Regenerator', 20.1, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 485 , 'Undiscovered' , 'Fire', 'Steel', q'{Quadruped body}', 'Brown' , 0, '1:1U', 10, 'Flash Fire' , 'Flame Body', 430, 1.7 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 642, q'|Therian Forme|', 'T' , 'Undiscovered' , 'Electric', 'Flying', q'{Bipedal, tailed form}', 'Blue' , 0, '0:1U', 120, 'Volt Absorb' , 61, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 51 , 'Field' , 'Ground' , q'{Multiple bodies}', 'Brown', 6, 6, 0, '1:1', 20, 'Sand Veil', 'Arena Trap', 'Sand Force', 33.3, 0.7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 387 , 'Monster', 'Grass', 'Grass' , q'{Quadruped body}', 'Green' , 0, '1:7', 20, 'Overgrow' , 'Shell Armor', 10.2, 0.4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 7 , 'Monster', 'Water 1', 'Water' , q'{Bipedal, tailed form}', 'Blue' , 0, '1:7', 20, 'Torrent' , 'Rain Dish', 9, 0.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 265 , 'Bug' , 'Bug' , q'{Insectoid body}', 'Red' , 0, '1:1', 15, 'Shield Dust' , 'Run Away', 3.6, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 71 , 'Grass' , 'Grass', 'Poison', q'{Head and a base}', 'Green' , 0, '1:1', 20, 'Chlorophyll' , 'Gluttony', 15.5, 1.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 747 , 'Water 1' , 'Poison', 'Water', q'{Head and a base}', 'Blue', 0, 0, 0, '1:1', 20, 'Merciless', 'Limber', 'Regenerator', 8, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 609 , 'Amorphous' , 'Ghost', 'Fire', q'{Head and arms}', 'Black' , 9, '1:1', 20, 'Flash Fire', 'Flame Body', 'Infiltrator', 34.3, 1 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 487, q'|Origin Forme|', 'O' , 'Undiscovered' , 'Ghost', 'Dragon', q'{Tentacles or a multiped body}', 'Black' , 0, 'GU', 120, 'Levitate' , 650, 6.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 640 , 'Undiscovered' , 'Grass', 'Fighting', q'{Quadruped body}', 'Green' , 0, 'GU', 80, 'Justified' , 200, 2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 207 , 'Bug' , 'Ground', 'Flying', q'{Single pair of wings}', 'Purple' , 0, '1:1', 20, 'Hyper Cutter', 'Sand Veil', 'Immunity', 64.8, 1.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 792 , 'Undiscovered' , 'Psychic', 'Ghost', q'{Single pair of wings}', 'Purple' , 0, 'GU', 120, 'Shadow Shield' , 120, 4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 399 , 'Water 1', 'Field', 'Normal' , q'{Quadruped body}', 'Brown' , 0, '1:1', 15, 'Simple', 'Unaware', 'Moody', 20, 0.5 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 419 , 'Water 1', 'Field', 'Water' , q'{Quadruped body}', 'Brown' , 0, '1:1', 20, 'Swift Swim' , 'Water Veil', 33.5, 1.1 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 184 , 'Water 1', 'Fairy', 'Water', 'Fairy', q'{Bipedal, tailed form}', 'Blue' , 0, '1:1', 10, 'Thick Fat', 'Huge Power', 'Sap Sipper', 28.5, 0.8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 656 , 'Water 1' , 'Water' , q'{Quadruped body}', 'Blue' , 0, '1:7', 20, 'Torrent' , 'Protean', 7, 0.3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 773, q'|Type: Ground|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'RKS System' , 100.5, 2.3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 33 , 'Monster', 'Field', 'Poison' , q'{Quadruped body}', 'Purple' , 2, '0:1', 20, 'Poison Point', 'Rivalry', 'Hustle', 19.5, 0.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 175 , 'Undiscovered' , 'Fairy' , q'{Bipedal, tailless form}', 'White' , 0, '1:7U', 10, 'Hustle', 'Serene Grace', 'Super Luck', 1.5, 0.3 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 15, q'|Mega|', 'M', q'|Beedrillite|', 'Bug' , 'Bug', 'Poison', q'{Two or more pairs of wings}', 'Yellow' , 0, '1:1', 15, 'Adaptability' , 29.5, 1.4 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 422, q'|East Sea|', 'E' , 'Water 1', 'Amorphous', 'Water' , q'{Serpentine bodies}', 'Blue', 9, 9, 0, '1:1', 20, 'Sticky Hold', 'Storm Drain', 'Sand Force', 6.3, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 163 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Brown' , 9, 0, '1:1', 15, 'Insomnia', 'Keen Eye', 'Tinted Lens', 21.2, 0.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 512 , 'Field' , 'Grass' , q'{Bipedal, tailed form}', 'Green' , 0, '1:7', 20, 'Gluttony' , 'Overgrow', 30.5, 1.1 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 130 , 'Water 2', 'Dragon', 'Water', 'Flying', q'{Serpentine bodies}', 'Blue', 3, 3, 0, '1:1', 5, 'Intimidate' , 'Moxie', 235, 6.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 736 , 'Bug' , 'Bug' , q'{Insectoid body}', 'Gray', 9, 9, 0, '1:1', 15, 'Swarm' , 4.4, 0.4 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 386, q'|Defense Forme|', 'D' , 'Undiscovered' , 'Psychic' , q'{Bipedal, tailless form}', 'Red' , 0, 'GU', 120, 'Pressure' , 60.8, 1.7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 3 , 'Monster', 'Grass', 'Grass', 'Poison', q'{Quadruped body}', 'Green' , 0, '1:7', 20, 'Overgrow' , 'Chlorophyll', 100, 2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 520 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Gray' , 0, '1:1', 15, 'Big Pecks', 'Super Luck', 'Rivalry', 15, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 216 , 'Field' , 'Normal' , q'{Bipedal, tailed form}', 'Brown' , 2, '1:1', 20, 'Pickup', 'Quick Feet', 'Honey Gather', 8.8, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 511 , 'Field' , 'Grass' , q'{Bipedal, tailed form}', 'Green' , 0, '1:7', 20, 'Gluttony' , 'Overgrow', 10.5, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 374 , 'Mineral' , 'Steel', 'Psychic', q'{Head and a base}', 'Blue', 9, 9, 0, 'G', 40, 'Clear Body' , 'Light Metal', 95.2, 0.6 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 152 , 'Monster', 'Grass', 'Grass' , q'{Quadruped body}', 'Green' , 0, '1:7', 20, 'Overgrow' , 'Leaf Guard', 6.4, 0.9 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 159 , 'Monster', 'Water 1', 'Water' , q'{Bipedal, tailed form}', 'Blue' , 0, '1:7', 20, 'Torrent' , 'Sheer Force', 25, 1.1 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 479, q'|Wash|' , 'Amorphous' , 'Electric', 'Ghost', q'{Head}', 'Red' , 0, 'G', 20, 'Levitate' , 0.3, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 689 , 'Water 3' , 'Rock', 'Water', q'{Multiple bodies}', 'Brown' , 0, '1:1', 20, 'Sniper', 'Tough Claws', 'Pickpocket', 96, 1.3 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 384, q'|Mega|', 'M', q'|Meteorite|', 'Undiscovered' , 'Dragon', 'Flying', q'{Serpentine bodies}', 'Green' , 0, 'GU', 120, 'Delta Stream' , 206.5, 10.8 );
insert into SPECIES( DEX, CLASS , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 421, q'|Overcast Form|' , 'Fairy', 'Grass', 'Grass' , q'{Head and legs}', 'Purple' , 0, '1:1', 20, 'Flower Gift' , 9.3, 0.5 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 564 , 'Water 1', 'Water 3', 'Water', 'Rock', q'{Quadruped body}', 'Blue' , 0, '1:7', 30, 'Solid Rock', 'Sturdy', 'Swift Swim', 16.5, 0.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 782 , 'Dragon' , 'Dragon' , q'{Quadruped body}', 'Gray', 9, 9, 0, '1:1', 40, 'Bulletproof', 'Soundproof', 'Overcoat', 29.7, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 723 , 'Flying' , 'Grass', 'Flying', q'{Single pair of wings}', 'Brown' , 0, '1:7', 15, 'Overgrow' , 'Long Reach', 16, 0.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 68 , 'Human-Like' , 'Fighting' , q'{Bipedal, tailless form}', 'Gray' , 2, '1:3', 20, 'Guts', 'No Guard', 'Steadfast', 130, 1.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 486 , 'Undiscovered' , 'Normal' , q'{Bipedal, tailless form}', 'White' , 0, 'GU', 120, 'Slow Start' , 420, 3.7 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 719, q'|Mega|', 'M', q'|Diancite|', 'Undiscovered' , 'Rock', 'Fairy', q'{Head and arms}', 'Pink' , 0, 'GU', 25, 'Magic Bounce' , 8.8, 1.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 516 , 'Field' , 'Water' , q'{Bipedal, tailed form}', 'Blue' , 0, '1:7', 20, 'Gluttony' , 'Torrent', 29, 1 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 493, q'|Type: Psychic|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Multitype' , 320, 3.2 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 493, q'|Type: Ghost|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Multitype' , 320, 3.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 668 , 'Field' , 'Fire', 'Normal', q'{Quadruped body}', 'Brown' , 6, 0, '7:1', 20, 'Rivalry', 'Unnerve', 'Moxie', 81.5, 1.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 173 , 'Undiscovered' , 'Fairy' , q'{Bipedal, tailed form}', 'Pink', 15, 15, 2, '3:1U', 10, 'Cute Charm', 'Magic Guard', 'Friend Guard', 3, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 519 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Gray' , 0, '1:1', 15, 'Big Pecks', 'Super Luck', 'Rivalry', 2.1, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 543 , 'Bug' , 'Bug', 'Poison', q'{Insectoid body}', 'Red' , 9, '1:1', 15, 'Poison Point', 'Swarm', 'Speed Boost', 5.3, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 174 , 'Undiscovered' , 'Normal', 'Fairy', q'{Bipedal, tailless form}', 'Pink', 15, 15, 2, '3:1U', 10, 'Cute Charm', 'Competitive', 'Friend Guard', 1, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 39 , 'Fairy' , 'Normal', 'Fairy', q'{Bipedal, tailless form}', 'Pink', 6, 6, 2, '3:1', 10, 'Cute Charm', 'Competitive', 'Friend Guard', 5.5, 0.5 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 565 , 'Water 1', 'Water 3', 'Water', 'Rock', q'{Bipedal, tailed form}', 'Blue' , 0, '1:7', 30, 'Solid Rock', 'Sturdy', 'Swift Swim', 81, 1.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 203 , 'Field' , 'Normal', 'Psychic', q'{Quadruped body}', 'Yellow' , 0, '1:1', 20, 'Inner Focus', 'Early Bird', 'Sap Sipper', 41.5, 1.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 764 , 'Grass' , 'Fairy' , q'{Head}', 'Green', 9, 9, 0, '3:1', 20, 'Flower Veil', 'Triage', 'Natural Cure', 0.3, 0.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 177 , 'Flying' , 'Psychic', 'Flying', q'{Single pair of wings}', 'Green' , 9, 0, '1:1', 20, 'Synchronize', 'Early Bird', 'Magic Bounce', 2, 0.2 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 139 , 'Water 1', 'Water 3', 'Rock', 'Water', q'{Tentacles or a multiped body}', 'Blue' , 0, '1:7', 30, 'Swift Swim', 'Shell Armor', 'Weak Armor', 35, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 202 , 'Amorphous' , 'Psychic' , q'{Head and a base}', 'Blue' , 0, '1:1', 20, 'Shadow Tag' , 'Telepathy', 28.5, 1.3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 670, q'|White Flower|' , 'Fairy' , 'Fairy' , q'{Head and arms}', 'White' , 0, 0, '1:0', 20, 'Flower Veil' , 'Symbiosis', 0.9, 0.2 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 112 , 'Monster', 'Field', 'Ground', 'Rock', q'{Bipedal, tailed form}', 'Gray' , 0, '1:1', 20, 'Lightning Rod', 'Rock Head', 'Reckless', 120, 1.9 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 694 , 'Monster', 'Dragon', 'Electric', 'Normal', q'{Bipedal, tailed form}', 'Yellow' , 0, '1:1', 20, 'Dry Skin', 'Sand Veil', 'Solar Power', 6, 0.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 571 , 'Field' , 'Dark' , q'{Bipedal, tailed form}', 'Gray' , 6, 0, '1:7', 20, 'Illusion' , 81.1, 1.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 424 , 'Field' , 'Normal' , q'{Bipedal, tailed form}', 'Purple' , 0, 0, '1:1', 20, 'Technician', 'Pickup', 'Skill Link', 20.3, 1.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 532 , 'Human-Like' , 'Fighting' , q'{Bipedal, tailless form}', 'Gray' , 0, '1:3', 20, 'Guts', 'Sheer Force', 'Iron Fist', 12.5, 0.6 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 479, q'|Frost|' , 'Amorphous' , 'Electric', 'Ghost', q'{Head}', 'Red' , 0, 'G', 20, 'Levitate' , 0.3, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 531 , 'Fairy' , 'Normal' , q'{Bipedal, tailed form}', 'Pink' , 0, '1:1', 20, 'Healer', 'Regenerator', 'Klutz', 31, 1.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 414 , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'Yellow' , 0, '0:1', 15, 'Swarm' , 'Tinted Lens', 23.3, 0.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 551 , 'Field' , 'Ground', 'Dark', q'{Quadruped body}', 'Brown', 9, 9, 0, '1:1', 20, 'Intimidate', 'Moxie', 'Anger Point', 15.2, 0.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 98 , 'Water 3' , 'Water' , q'{Insectoid body}', 'Red' , 0, '1:1', 20, 'Hyper Cutter', 'Shell Armor', 'Sheer Force', 6.5, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 70 , 'Grass' , 'Grass', 'Poison', q'{Head and a base}', 'Green' , 0, '1:1', 20, 'Chlorophyll' , 'Gluttony', 6.4, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 518 , 'Field' , 'Psychic' , q'{Bipedal, tailless form}', 'Pink' , 0, '1:1', 10, 'Forewarn', 'Synchronize', 'Telepathy', 60.5, 1.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 802 , 'Undiscovered' , 'Fighting', 'Ghost', q'{Bipedal, tailless form}', 'Gray' , 0, 'GU', 120, 'Technician' , 22.2, 0.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 726 , 'Field' , 'Fire' , q'{Quadruped body}', 'Red' , 0, '1:7', 15, 'Blaze' , 'Intimidate', 25, 0.7 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 38, q'|Alolan|', 'A' , 'Field' , 'Ice', 'Fairy', q'{Quadruped body}', 'Blue' , 0, '3:1', 20, 'Snow Cloak' , 'Snow Warning', 19.9, 1.1 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 773, q'|Type: Psychic|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'RKS System' , 100.5, 2.3 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 214, q'|Mega|', 'M', q'|Heracronite|', 'Bug' , 'Bug', 'Fighting', q'{Bipedal, tailless form}', 'Blue' , 3, 0, '1:1', 25, 'Skill Link' , 54, 1.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 425 , 'Amorphous' , 'Ghost', 'Flying', q'{Head and arms}', 'Purple', 9, 9, 0, '1:1', 30, 'Aftermath', 'Unburden', 'Flare Boost', 1.2, 0.4 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 676, q'|Kabuki Trim|' , 'Field' , 'Normal' , q'{Quadruped body}', 'White' , 6, 0, '1:1', 20, 'Fur Coat' , 28, 1.2 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 94, q'|Mega|', 'M', q'|Gengarite|', 'Amorphous' , 'Ghost', 'Poison', q'{Bipedal, tailed form}', 'Purple', 0, 0, 0, '1:1', 20, 'Shadow Tag' , 40.5, 1.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 280 , 'Amorphous' , 'Psychic', 'Fairy', q'{Bipedal, tailless form}', 'White' , 0, '1:1', 20, 'Synchronize', 'Trace', 'Telepathy', 6.6, 0.4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 611 , 'Monster', 'Dragon', 'Dragon' , q'{Bipedal, tailed form}', 'Green' , 0, '1:1', 40, 'Rivalry', 'Mold Breaker', 'Unnerve', 36, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 552 , 'Field' , 'Ground', 'Dark', q'{Quadruped body}', 'Brown', 6, 6, 0, '1:1', 20, 'Intimidate', 'Moxie', 'Anger Point', 33.4, 1 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 117 , 'Water 1', 'Dragon', 'Water' , q'{Head and a base}', 'Blue' , 2, '1:1', 20, 'Poison Point', 'Sniper', 'Damp', 25, 1.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 100 , 'Mineral' , 'Electric' , q'{Head}', 'Red' , 0, 'G', 20, 'Soundproof', 'Static', 'Aftermath', 10.4, 0.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 629 , 'Flying' , 'Dark', 'Flying', q'{Single pair of wings}', 'Brown', 9, 9, 0, '1:0', 20, 'Big Pecks', 'Overcoat', 'Weak Armor', 9, 0.5 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 393 , 'Water 1', 'Field', 'Water' , q'{Bipedal, tailless form}', 'Blue' , 0, '1:7', 20, 'Torrent' , 'Defiant', 5.2, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 688 , 'Water 3' , 'Rock', 'Water', q'{Multiple bodies}', 'Brown' , 0, '1:1', 20, 'Sniper', 'Tough Claws', 'Pickpocket', 31, 0.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 480 , 'Undiscovered' , 'Psychic' , q'{Bipedal, tailed form}', 'Yellow' , 0, 'GU', 80, 'Levitate' , 0.3, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 235 , 'Field' , 'Normal' , q'{Bipedal, tailed form}', 'White', 9, 9, 2, '1:1', 20, 'Own Tempo', 'Technician', 'Moody', 58, 1.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 317 , 'Amorphous' , 'Poison' , q'{Head and arms}', 'Purple' , 0, '1:1', 20, 'Liquid Ooze', 'Sticky Hold', 'Gluttony', 80, 1.7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 286 , 'Fairy', 'Grass', 'Grass', 'Fighting', q'{Bipedal, tailed form}', 'Green' , 2, '1:1', 15, 'Effect Spore', 'Poison Heal', 'Technician', 39.2, 1.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 145 , 'Undiscovered' , 'Electric', 'Flying', q'{Single pair of wings}', 'Yellow' , 9, 'GU', 80, 'Pressure' , 'Static', 52.6, 1.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 257 , 'Field' , 'Fire', 'Fighting', q'{Bipedal, tailed form}', 'Red' , 0, '1:7', 20, 'Blaze' , 'Speed Boost', 52, 1.9 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 359, q'|Mega|', 'M', q'|Absolite|', 'Field' , 'Dark' , q'{Quadruped body}', 'White', 3, 3, 0, '1:1', 25, 'Magic Bounce' , 47, 1.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 276 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Blue' , 0, '1:1', 15, 'Guts' , 'Scrappy', 2.3, 0.3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 278 , 'Water 1', 'Flying', 'Water', 'Flying', q'{Single pair of wings}', 'White', 9, 9, 2, '1:1', 20, 'Keen Eye', 'Hydration', 'Rain Dish', 9.5, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 677 , 'Field' , 'Psychic' , q'{Bipedal, tailed form}', 'Gray' , 0, '1:1', 20, 'Keen Eye', 'Infiltrator', 'Own Tempo', 3.5, 0.3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 642, q'|Incarnate Forme|' , 'Undiscovered' , 'Electric', 'Flying', q'{Head and arms}', 'Blue' , 0, '0:1U', 120, 'Prankster' , 'Defiant', 61, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 217 , 'Field' , 'Normal' , q'{Bipedal, tailed form}', 'Brown' , 2, '1:1', 20, 'Guts', 'Quick Feet', 'Unnerve', 125.8, 1.8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 450 , 'Field' , 'Ground' , q'{Quadruped body}', 'Brown' , 0, '1:1', 30, 'Sand Stream' , 'Sand Force', 300, 2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 18 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Brown' , 2, '1:1', 15, 'Keen Eye', 'Tangled Feet', 'Big Pecks', 39.5, 1.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 635 , 'Dragon' , 'Dark', 'Dragon', q'{Bipedal, tailed form}', 'Blue' , 0, '1:1', 40, 'Levitate' , 160, 1.8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 663 , 'Flying' , 'Fire', 'Flying', q'{Single pair of wings}', 'Red' , 0, '1:1', 15, 'Flame Body' , 'Gale Wings', 24.5, 1.2 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 452 , 'Bug', 'Water 3', 'Poison', 'Dark', q'{Insectoid body}', 'Purple' , 0, '1:1', 20, 'Battle Armor', 'Sniper', 'Keen Eye', 61.5, 1.3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 138 , 'Water 1', 'Water 3', 'Rock', 'Water', q'{Tentacles or a multiped body}', 'Blue' , 0, '1:7', 30, 'Swift Swim', 'Shell Armor', 'Weak Armor', 7.5, 0.4 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 666, q'|Icy Snow Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 1.2 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 741, q'|Sensu Style|' , 'Flying' , 'Fire', 'Flying', q'{Single pair of wings}', 'Purple', 6, 6, 0, '3:1', 20, 'Dancer' , 3.4, 0.6 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 201, q'|One form|' , 'Undiscovered' , 'Psychic' , q'{Head}', 'Black' , 0, 'GU', 40, 'Levitate' , 5, 0.5 );
insert into SPECIES( DEX, CLASS , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 25, q'|Cosplay|' , 'Field', 'Fairy', 'Electric' , q'{Quadruped body}', 'Yellow', 6, 6, 0, '1:1', 10, 'Static' , 'Lightning Rod', 6, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 20 , 'Field' , 'Normal' , q'{Quadruped body}', 'Brown', 6, 6, 0, '1:1', 15, 'Run Away', 'Guts', 'Hustle', 18.5, 0.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 126 , 'Human-Like' , 'Fire' , q'{Bipedal, tailed form}', 'Red', 6, 6, 0, '1:3', 25, 'Flame Body' , 'Vital Spirit', 44.5, 1.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 198 , 'Flying' , 'Dark', 'Flying', q'{Single pair of wings}', 'Black', 9, 9, 2, '1:1', 20, 'Insomnia', 'Super Luck', 'Prankster', 2.1, 0.5 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 586, q'|Summer Form|' , 'Field' , 'Normal', 'Grass', q'{Quadruped body}', 'Brown' , 0, '1:1', 20, 'Chlorophyll', 'Sap Sipper', 'Serene Grace', 92.5, 1.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 449 , 'Field' , 'Ground' , q'{Quadruped body}', 'Brown' , 0, '1:1', 30, 'Sand Stream' , 'Sand Force', 49.5, 0.8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 187 , 'Fairy', 'Grass', 'Grass', 'Flying', q'{Bipedal, tailed form}', 'Pink' , 2, '1:1', 20, 'Chlorophyll', 'Leaf Guard', 'Infiltrator', 0.5, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 401 , 'Bug' , 'Bug' , q'{Bipedal, tailless form}', 'Red' , 0, '1:1', 15, 'Shed Skin' , 'Run Away', 2.2, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 97 , 'Human-Like' , 'Psychic' , q'{Bipedal, tailless form}', 'Yellow', 6, 6, 2, '1:1', 20, 'Insomnia', 'Forewarn', 'Inner Focus', 75.6, 1.6 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 666, q'|Fancy Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 1.2 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 693 , 'Water 1', 'Water 3', 'Water' , q'{Serpentine bodies}', 'Blue' , 6, 0, '1:1', 15, 'Mega Launcher' , 35.3, 1.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 651 , 'Field' , 'Grass' , q'{Bipedal, tailed form}', 'Green' , 0, '1:7', 20, 'Overgrow' , 'Bulletproof', 29, 0.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 655 , 'Field' , 'Fire', 'Psychic', q'{Bipedal, tailed form}', 'Red' , 0, '1:7', 20, 'Blaze' , 'Magician', 39, 1.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 115 , 'Monster' , 'Normal' , q'{Bipedal, tailed form}', 'Brown', 3, 3, 2, '1:0', 20, 'Early Bird', 'Scrappy', 'Inner Focus', 80, 2.2 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 666, q'|Jungle Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 1.2 );
insert into SPECIES( DEX, CLASS , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 25, q'|Libre|' , 'Field', 'Fairy', 'Electric' , q'{Quadruped body}', 'Yellow', 6, 6, 0, '1:1', 10, 'Static' , 'Lightning Rod', 6, 0.4 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 644, q'|Overdrive mode|' , 'Undiscovered' , 'Dragon', 'Electric', q'{Bipedal, tailed form}', 'Black' , 0, 'GU', 120, 'Teravolt' , 345, 2.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 806 , 'Undiscovered' , 'Fire', 'Ghost', q'{Bipedal, tailless form}', 'White' , 0, 'GU', 120, 'Beast Boost' , 13, 1.8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 722 , 'Flying' , 'Grass', 'Flying', q'{Single pair of wings}', 'Brown' , 0, '1:7', 15, 'Overgrow' , 'Long Reach', 1.5, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 151 , 'Undiscovered' , 'Psychic' , q'{Bipedal, tailed form}', 'Pink' , 0, 'GU', 120, 'Synchronize' , 4, 0.4 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 412, q'|Trash Cloak|', 'S' , 'Bug' , 'Bug' , q'{Head and a base}', 'Green' , 0, '1:1', 15, 'Shed Skin' , 'Overcoat', 3.4, 0.2 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 666, q'|Monsoon Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 1.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 684 , 'Fairy' , 'Fairy' , q'{Head and legs}', 'White' , 0, '1:1', 20, 'Sweet Veil' , 'Unburden', 3.5, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 457 , 'Water 2' , 'Water' , q'{Fins}', 'Blue', 6, 6, 0, '1:1', 20, 'Swift Swim', 'Storm Drain', 'Water Veil', 24, 1.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 15 , 'Bug' , 'Bug', 'Poison', q'{Two or more pairs of wings}', 'Yellow' , 0, '1:1', 15, 'Swarm' , 'Sniper', 29.5, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 134 , 'Field' , 'Water' , q'{Quadruped body}', 'Blue' , 0, '1:7', 35, 'Water Absorb' , 'Hydration', 29, 1 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 670, q'|Orange Flower|' , 'Fairy' , 'Fairy' , q'{Head and arms}', 'White' , 0, 0, '1:0', 20, 'Flower Veil' , 'Symbiosis', 0.9, 0.2 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 6, q'|Mega  X|', 'MX' , 'Monster', 'Dragon', 'Fire', 'Flying', q'{Bipedal, tailed form}', 'Black' , 0, '1:7', 20, 'Tough Claws' , 90.5, 1.7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 493, q'|Type: Fairy|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Multitype' , 320, 3.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 244 , 'Undiscovered' , 'Fire' , q'{Quadruped body}', 'Brown' , 8, 'GU', 80, 'Pressure' , 'Inner Focus', 198, 2.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 524 , 'Mineral' , 'Rock' , q'{Head and legs}', 'Blue', 9, 9, 2, '1:1', 15, 'Sturdy', 'Weak Armor', 'Sand Force', 18, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 526 , 'Mineral' , 'Rock' , q'{Tentacles or a multiped body}', 'Blue' , 2, '1:1', 15, 'Sturdy', 'Sand Stream', 'Sand Force', 260, 1.7 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 448, q'|Mega|', 'M', q'|Lucarionite|', 'Field', 'Human-Like', 'Fighting', 'Steel', q'{Bipedal, tailed form}', 'Blue', 0, 0, 0, '1:7', 25, 'Adaptability' , 54, 1.3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 697 , 'Monster', 'Dragon', 'Rock', 'Dragon', q'{Bipedal, tailed form}', 'Red' , 0, '1:7', 30, 'Strong Jaw' , 'Rock Head', 270, 2.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 584 , 'Mineral' , 'Ice' , q'{Multiple bodies}', 'White' , 0, 2, '1:1', 20, 'Ice Body', 'Snow Warning', 'Weak Armor', 57.5, 1.3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 586, q'|Spring Form|' , 'Field' , 'Normal', 'Grass', q'{Quadruped body}', 'Brown' , 0, '1:1', 20, 'Chlorophyll', 'Sap Sipper', 'Serene Grace', 92.5, 1.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 553 , 'Field' , 'Ground', 'Dark', q'{Bipedal, tailed form}', 'Red' , 0, '1:1', 20, 'Intimidate', 'Moxie', 'Anger Point', 96.3, 1.5 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 105, q'|Alolan|', 'A' , 'Monster' , 'Fire', 'Ghost', q'{Bipedal, tailed form}', 'Purple', 3, 3, 0, '1:1', 20, 'Cursed Body', 'Lightning Rod', 'Rock Head', 45, 1 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 490 , 'Water 1', 'Fairy', 'Water' , q'{Bipedal, tailless form}', 'Blue' , 0, 'G', 10, 'Hydration' , 1.4, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 368 , 'Water 1' , 'Water' , q'{Serpentine bodies}', 'Pink' , 0, 0, '1:1', 20, 'Swift Swim' , 'Hydration', 22.6, 1.8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 469 , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'Green' , 0, '1:1', 20, 'Speed Boost', 'Tinted Lens', 'Frisk', 51.5, 1.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 514 , 'Field' , 'Fire' , q'{Bipedal, tailed form}', 'Red' , 0, '1:7', 20, 'Gluttony' , 'Blaze', 28, 1 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 669, q'|White Flower|' , 'Fairy' , 'Fairy' , q'{Head and arms}', 'White' , 15, 0, '1:0', 20, 'Flower Veil' , 'Symbiosis', 0.1, 0.1 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 777 , 'Field', 'Fairy', 'Electric', 'Steel', q'{Bipedal, tailed form}', 'Gray', 9, 9, 0, '1:1', 10, 'Iron Barbs', 'Lightning Rod', 'Sturdy', 3.3, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 212 , 'Bug' , 'Bug', 'Steel', q'{Two or more pairs of wings}', 'Red' , 2, '1:1', 25, 'Swarm', 'Technician', 'Light Metal', 118, 1.8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 253 , 'Monster', 'Dragon', 'Grass' , q'{Bipedal, tailed form}', 'Green' , 0, '1:7', 20, 'Overgrow' , 'Unburden', 21.6, 0.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 191 , 'Grass' , 'Grass' , q'{Head}', 'Yellow' , 2, '1:1', 20, 'Chlorophyll', 'Solar Power', 'Early Bird', 1.8, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 372 , 'Dragon' , 'Dragon' , q'{Quadruped body}', 'White', 6, 6, 0, '1:1', 40, 'Rock Head' , 'Overcoat', 110.5, 1.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 623 , 'Mineral' , 'Ground', 'Ghost', q'{Bipedal, tailless form}', 'Green' , 15, 0, 'G', 25, 'Iron Fist', 'Klutz', 'No Guard', 330, 2.8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 733 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Black' , 0, 0, '1:1', 15, 'Keen Eye', 'Skill Link', 'Sheer Force', 26, 1.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 607 , 'Amorphous' , 'Ghost', 'Fire', q'{Head and a base}', 'White' , 9, '1:1', 20, 'Flash Fire', 'Flame Body', 'Infiltrator', 3.1, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 525 , 'Mineral' , 'Rock' , q'{Tentacles or a multiped body}', 'Blue', 6, 6, 2, '1:1', 15, 'Sturdy', 'Weak Armor', 'Sand Force', 102, 0.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 220 , 'Field' , 'Ice', 'Ground', q'{Quadruped body}', 'Brown' , 2, '1:1', 20, 'Oblivious', 'Snow Cloak', 'Thick Fat', 6.5, 0.4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 116 , 'Water 1', 'Dragon', 'Water' , q'{Head and a base}', 'Blue' , 2, '1:1', 20, 'Swift Swim', 'Sniper', 'Damp', 8, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 208 , 'Mineral' , 'Steel', 'Ground', q'{Serpentine bodies}', 'Gray' , 0, '1:1', 25, 'Rock Head', 'Sturdy', 'Sheer Force', 400, 9.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 263 , 'Field' , 'Normal' , q'{Quadruped body}', 'Brown' , 2, '1:1', 15, 'Pickup', 'Gluttony', 'Quick Feet', 17.5, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 307 , 'Human-Like' , 'Fighting', 'Psychic', q'{Bipedal, tailless form}', 'Blue' , 0, '1:1', 20, 'Pure Power' , 'Telepathy', 11.2, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 231 , 'Field' , 'Ground' , q'{Quadruped body}', 'Blue' , 0, '1:1', 20, 'Pickup' , 'Sand Veil', 33.5, 0.5 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 586, q'|Autumn Form|' , 'Field' , 'Normal', 'Grass', q'{Quadruped body}', 'Brown' , 0, '1:1', 20, 'Chlorophyll', 'Sap Sipper', 'Serene Grace', 92.5, 1.9 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 728 , 'Water 1', 'Field', 'Water' , q'{Fins}', 'Blue' , 0, '1:7', 15, 'Torrent' , 'Liquid Voice', 7.5, 0.4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 259 , 'Monster', 'Water 1', 'Water', 'Ground', q'{Bipedal, tailed form}', 'Blue' , 0, '1:7', 20, 'Torrent' , 'Damp', 28, 0.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 800 , 'Undiscovered' , 'Psychic' , q'{Head and arms}', 'Black' , 0, 'GU', 120, 'Prism Armor' , 230, 4.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 146 , 'Undiscovered' , 'Fire', 'Flying', q'{Single pair of wings}', 'Yellow' , 0, 'GU', 80, 'Pressure' , 'Flame Body', 60, 2 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 493, q'|Type: Electric|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Multitype' , 320, 3.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 456 , 'Water 2' , 'Water' , q'{Fins}', 'Blue', 9, 9, 0, '1:1', 20, 'Swift Swim', 'Storm Drain', 'Water Veil', 7, 0.4 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 9, q'|Mega|', 'M', q'|Blastoisinite|', 'Monster', 'Water 1', 'Water' , q'{Bipedal, tailed form}', 'Blue' , 0, '1:7', 20, 'Mega Launcher' , 85.5, 1.6 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 395 , 'Water 1', 'Field', 'Water', 'Steel', q'{Bipedal, tailed form}', 'Blue' , 0, '1:7', 20, 'Torrent' , 'Defiant', 84.5, 1.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 236 , 'Undiscovered' , 'Fighting' , q'{Bipedal, tailless form}', 'Purple' , 2, '0:1U', 25, 'Guts', 'Steadfast', 'Vital Spirit', 21, 0.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 447 , 'Undiscovered' , 'Fighting' , q'{Bipedal, tailed form}', 'Blue', 15, 15, 0, '1:7U', 25, 'Steadfast', 'Inner Focus', 'Prankster', 20.2, 0.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 382 , 'Undiscovered' , 'Water' , q'{Fins}', 'Blue' , 0, 'GU', 120, 'Drizzle' , 352, 4.5 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 209 , 'Field', 'Fairy', 'Fairy' , q'{Bipedal, tailless form}', 'Pink', 9, 9, 0, '3:1', 20, 'Intimidate', 'Run Away', 'Rattled', 7.8, 0.6 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 386, q'|Normal Forme|' , 'Undiscovered' , 'Psychic' , q'{Bipedal, tailless form}', 'Red' , 0, 'GU', 120, 'Pressure' , 60.8, 1.7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 400 , 'Water 1', 'Field', 'Normal', 'Water', q'{Bipedal, tailed form}', 'Brown' , 0, '1:1', 15, 'Simple', 'Unaware', 'Moody', 31.5, 1 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 773, q'|Type: Bug|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'RKS System' , 100.5, 2.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 90 , 'Water 3' , 'Water' , q'{Head}', 'Purple', 9, 9, 2, '1:1', 20, 'Shell Armor', 'Skill Link', 'Overcoat', 4, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 578 , 'Amorphous' , 'Psychic' , q'{Head}', 'Green' , 0, '1:1', 20, 'Overcoat', 'Magic Guard', 'Regenerator', 8, 0.6 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 757 , 'Monster', 'Dragon', 'Poison', 'Fire', q'{Quadruped body}', 'Black', 9, 9, 0, '1:7', 20, 'Corrosion' , 'Oblivious', 4.8, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 402 , 'Bug' , 'Bug' , q'{Two or more pairs of wings}', 'Red' , 0, '1:1', 15, 'Swarm' , 'Technician', 25.5, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 170 , 'Water 2' , 'Water', 'Electric', q'{Fins}', 'Blue', 9, 9, 0, '1:1', 20, 'Volt Absorb', 'Illuminate', 'Water Absorb', 12, 0.5 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 23 , 'Field', 'Dragon', 'Poison' , q'{Serpentine bodies}', 'Purple' , 9, 0, '1:1', 20, 'Intimidate', 'Shed Skin', 'Unnerve', 6.9, 2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 744 , 'Field' , 'Rock' , q'{Quadruped body}', 'Brown', 9, 9, 0, '1:1', 15, 'Keen Eye', 'Vital Spirit', 'Steadfast', 9.2, 0.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 89 , 'Amorphous' , 'Poison' , q'{Head and arms}', 'Purple', 6, 6, 0, '1:1', 20, 'Stench', 'Sticky Hold', 'Poison Touch', 30, 1.2 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 257, q'|Mega|', 'M', q'|Blazikenite|', 'Field' , 'Fire', 'Fighting', q'{Bipedal, tailed form}', 'Red' , 0, '1:7', 20, 'Speed Boost' , 52, 1.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 483 , 'Undiscovered' , 'Steel', 'Dragon', q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Pressure' , 'Telepathy', 683, 5.4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 562 , 'Mineral', 'Amorphous', 'Ghost' , q'{Head and arms}', 'Black' , 0, '1:1', 25, 'Mummy' , 1.5, 0.5 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 493, q'|Type: Grass|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Multitype' , 320, 3.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 472 , 'Bug' , 'Ground', 'Flying', q'{Single pair of wings}', 'Purple' , 0, '1:1', 20, 'Hyper Cutter', 'Sand Veil', 'Poison Heal', 42.5, 2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 93 , 'Amorphous' , 'Ghost', 'Poison', q'{Head and arms}', 'Purple', 6, 6, 0, '1:1', 20, 'Levitate' , 0.1, 1.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 214 , 'Bug' , 'Bug', 'Fighting', q'{Bipedal, tailless form}', 'Blue' , 3, 0, '1:1', 25, 'Swarm', 'Guts', 'Moxie', 54, 1.5 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 778, q'|Busted Form|' , 'Amorphous' , 'Ghost', 'Fairy', q'{Serpentine bodies}', 'Yellow', 9, 9, 0, '1:1', 20, 'Disguise' , 0.7, 0.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 379 , 'Undiscovered' , 'Steel' , q'{Bipedal, tailless form}', 'Gray' , 0, 'GU', 80, 'Clear Body' , 'Light Metal', 205, 1.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 312 , 'Fairy' , 'Electric' , q'{Bipedal, tailed form}', 'Yellow' , 1, '1:1', 20, 'Minus' , 'Volt Absorb', 4.2, 0.4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 780 , 'Monster', 'Dragon', 'Normal', 'Dragon', q'{Serpentine bodies}', 'White', 3, 3, 0, '1:1', 20, 'Berserk', 'Sap Sipper', 'Cloud Nine', 185, 3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 599 , 'Mineral' , 'Steel' , q'{Multiple bodies}', 'Gray' , 0, 'G', 20, 'Plus', 'Minus', 'Clear Body', 21, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 383 , 'Undiscovered' , 'Ground' , q'{Bipedal, tailed form}', 'Red' , 0, 'GU', 120, 'Drought' , 950, 3.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 415 , 'Bug' , 'Bug', 'Flying', q'{Multiple bodies}', 'Yellow' , 0, '1:7', 15, 'Honey Gather' , 'Hustle', 5.5, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 596 , 'Bug' , 'Bug', 'Electric', q'{Insectoid body}', 'Yellow' , 0, '1:1', 20, 'Compound Eyes', 'Unnerve', 'Swarm', 14.3, 0.8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 91 , 'Water 3' , 'Water', 'Ice', q'{Head}', 'Purple' , 2, '1:1', 20, 'Shell Armor', 'Skill Link', 'Overcoat', 132.5, 1.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 95 , 'Mineral' , 'Rock', 'Ground', q'{Serpentine bodies}', 'Gray' , 0, '1:1', 25, 'Rock Head', 'Sturdy', 'Weak Armor', 210, 8.8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 761 , 'Grass' , 'Grass' , q'{Head and legs}', 'Purple', 9, 9, 0, '1:0', 20, 'Leaf Guard', 'Oblivious', 'Sweet Veil', 3.2, 0.3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 413, q'|Plant Cloak|' , 'Bug' , 'Bug', 'Grass', q'{Head and a base}', 'Green' , 0, '1:0', 15, 'Anticipation' , 'Overcoat', 6.5, 0.5 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 443 , 'Monster', 'Dragon', 'Dragon', 'Ground', q'{Bipedal, tailed form}', 'Blue' , 0, '1:1', 40, 'Sand Veil' , 'Rough Skin', 20.5, 0.7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 333 , 'Flying', 'Dragon', 'Normal', 'Flying', q'{Single pair of wings}', 'Blue' , 0, '1:1', 20, 'Natural Cure' , 'Cloud Nine', 1.2, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 548 , 'Grass' , 'Grass' , q'{Head and a base}', 'Green', 9, 9, 0, '1:0', 20, 'Chlorophyll', 'Own Tempo', 'Leaf Guard', 6.6, 0.5 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 792, q'|Full Moon phase|' , 'Undiscovered' , 'Psychic', 'Ghost', q'{Single pair of wings}', 'Purple' , 0, 'GU', 120, 'Shadow Shield' , 120, 4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 237 , 'Human-Like' , 'Fighting' , q'{Bipedal, tailed form}', 'Brown' , 2, '0:1', 25, 'Intimidate', 'Technician', 'Steadfast', 48, 1.4 );
insert into SPECIES( DEX, CLASS , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 25, q'|Rock Star|' , 'Field', 'Fairy', 'Electric' , q'{Quadruped body}', 'Yellow', 6, 6, 0, '1:1', 10, 'Static' , 'Lightning Rod', 6, 0.4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 350 , 'Water 1', 'Dragon', 'Water' , q'{Serpentine bodies}', 'Pink' , 2, '1:1', 20, 'Marvel Scale', 'Competitive', 'Cute Charm', 162, 6.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 713 , 'Monster' , 'Ice' , q'{Quadruped body}', 'Blue' , 0, '1:1', 20, 'Own Tempo', 'Ice Body', 'Sturdy', 505, 2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 14 , 'Bug' , 'Bug', 'Poison', q'{Serpentine bodies}', 'Yellow' , 0, '1:1', 15, 'Shed Skin' , 10, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 604 , 'Amorphous' , 'Electric' , q'{Fins}', 'Blue' , 0, '1:1', 20, 'Levitate' , 80.5, 2.1 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 743 , 'Bug', 'Fairy', 'Bug', 'Fairy', q'{Two or more pairs of wings}', 'Yellow', 6, 6, 0, '1:1', 20, 'Honey Gather', 'Shield Dust', 'Sweet Veil', 0.5, 0.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 683 , 'Fairy' , 'Fairy' , q'{Bipedal, tailless form}', 'Pink' , 0, '1:1', 20, 'Healer' , 'Aroma Veil', 15.5, 0.8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 279 , 'Water 1', 'Flying', 'Water', 'Flying', q'{Single pair of wings}', 'Yellow', 6, 6, 2, '1:1', 20, 'Keen Eye', 'Drizzle', 'Rain Dish', 28, 1.2 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 758 , 'Monster', 'Dragon', 'Poison', 'Fire', q'{Quadruped body}', 'Black', 15, 15, 0, '1:0', 20, 'Corrosion' , 'Oblivious', 22.2, 1.2 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 666, q'|Elegant Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 1.2 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 111 , 'Monster', 'Field', 'Ground', 'Rock', q'{Quadruped body}', 'Gray' , 0, '1:1', 20, 'Lightning Rod', 'Rock Head', 'Reckless', 115, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 366 , 'Water 1' , 'Water' , q'{Head}', 'Blue' , 15, 0, '1:1', 20, 'Shell Armor' , 'Rattled', 52.5, 0.4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 34 , 'Monster', 'Field', 'Poison', 'Ground', q'{Bipedal, tailed form}', 'Purple' , 2, '0:1', 20, 'Poison Point', 'Rivalry', 'Sheer Force', 62, 1.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 617 , 'Bug' , 'Bug' , q'{Head and arms}', 'Red' , 0, '1:1', 15, 'Hydration', 'Sticky Hold', 'Unburden', 25.3, 0.8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 397 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Brown' , 0, '1:1', 15, 'Intimidate' , 'Reckless', 15.5, 0.6 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 492, q'|Land Forme|' , 'Undiscovered' , 'Grass' , q'{Quadruped body}', 'Green' , 0, 'GU', 120, 'Natural Cure' , 2.1, 0.4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 9 , 'Monster', 'Water 1', 'Water' , q'{Bipedal, tailed form}', 'Blue' , 0, '1:7', 20, 'Torrent' , 'Rain Dish', 85.5, 1.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 433 , 'Undiscovered' , 'Psychic' , q'{Bipedal, tailless form}', 'Yellow' , 0, '1:1U', 25, 'Levitate' , 0.6, 0.2 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 559 , 'Field', 'Dragon', 'Dark', 'Fighting', q'{Bipedal, tailed form}', 'Yellow' , 9, 0, '1:1', 15, 'Shed Skin', 'Moxie', 'Intimidate', 11.8, 0.6 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 681, q'|Shield Forme|' , 'Mineral' , 'Steel', 'Ghost', q'{Head and a base}', 'Brown' , 0, '1:1', 20, 'Stance Change' , 53, 1.7 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 80, q'|Mega|', 'M', q'|Slowbronite|', 'Monster', 'Water 1', 'Water', 'Psychic', q'{Bipedal, tailed form}', 'Pink', 3, 3, 0, '1:1', 20, 'Shell Armor' , 78.5, 2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 309 , 'Field' , 'Electric' , q'{Quadruped body}', 'Green' , 9, 0, '1:1', 20, 'Static', 'Lightning Rod', 'Minus', 15.2, 0.6 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 691 , 'Water 1', 'Dragon', 'Poison', 'Dragon', q'{Head and a base}', 'Brown' , 6, 0, '1:1', 20, 'Poison Point', 'Poison Touch', 'Adaptability', 81.5, 1.8 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 778, q'|Disguised Form|' , 'Amorphous' , 'Ghost', 'Fairy', q'{Serpentine bodies}', 'Yellow', 9, 9, 0, '1:1', 20, 'Disguise' , 0.7, 0.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 476 , 'Mineral' , 'Rock', 'Steel', q'{Multiple bodies}', 'Gray' , 0, '1:1', 20, 'Sturdy', 'Magnet Pull', 'Sand Force', 340, 1.4 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 641, q'|Incarnate Forme|' , 'Undiscovered' , 'Flying' , q'{Head and arms}', 'Green' , 0, '0:1U', 120, 'Prankster' , 'Defiant', 63, 1.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 727 , 'Field' , 'Fire', 'Dark', q'{Bipedal, tailed form}', 'Red' , 0, '1:7', 15, 'Blaze' , 'Intimidate', 83, 1.8 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 647, q'|Resolute Form|' , 'Undiscovered' , 'Water', 'Fighting', q'{Quadruped body}', 'Yellow' , 0, 'GU', 80, 'Justified' , 48.5, 1.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 108 , 'Monster' , 'Normal' , q'{Bipedal, tailed form}', 'Pink' , 3, 0, '1:1', 20, 'Own Tempo', 'Oblivious', 'Cloud Nine', 65.5, 1.2 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 142, q'|Mega|', 'M', q'|Aerodactylite|', 'Flying' , 'Rock', 'Flying', q'{Single pair of wings}', 'Purple' , 0, '1:7', 35, 'Tough Claws' , 59, 2.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 406 , 'Undiscovered' , 'Grass', 'Poison', q'{Bipedal, tailless form}', 'Green' , 0, '1:1U', 20, 'Natural Cure', 'Poison Point', 'Leaf Guard', 1.2, 0.2 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 127, q'|Mega|', 'M', q'|Pinsirite|', 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'Brown', 3, 3, 0, '1:1', 25, 'Aerilate' , 55, 1.7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 581 , 'Water 1', 'Flying', 'Water', 'Flying', q'{Single pair of wings}', 'White' , 0, '1:1', 20, 'Keen Eye', 'Big Pecks', 'Hydration', 24.2, 1.3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 55 , 'Water 1', 'Field', 'Water' , q'{Bipedal, tailed form}', 'Blue', 6, 6, 0, '1:1', 20, 'Damp', 'Cloud Nine', 'Swift Swim', 76.6, 1.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 759 , 'Field' , 'Normal', 'Fighting', q'{Quadruped body}', 'Pink', 9, 9, 0, '1:1', 15, 'Fluffy', 'Klutz', 'Cute Charm', 6.8, 0.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 467 , 'Human-Like' , 'Fire' , q'{Bipedal, tailed form}', 'Red' , 0, '1:3', 25, 'Flame Body' , 'Vital Spirit', 68, 1.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 41 , 'Flying' , 'Poison', 'Flying', q'{Single pair of wings}', 'Purple', 15, 15, 0, '1:1', 15, 'Inner Focus' , 'Infiltrator', 7.5, 0.8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 32 , 'Monster', 'Field', 'Poison' , q'{Quadruped body}', 'Purple' , 2, '0:1', 20, 'Poison Point', 'Rivalry', 'Hustle', 9, 0.5 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 386, q'|Attack Forme|', 'A' , 'Undiscovered' , 'Psychic' , q'{Bipedal, tailless form}', 'Red' , 0, 'GU', 120, 'Pressure' , 60.8, 1.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 103 , 'Grass' , 'Grass', 'Psychic', q'{Head and legs}', 'Yellow', 0, 0, 0, '1:1', 20, 'Chlorophyll' , 'Harvest', 120, 2 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 300 , 'Field', 'Fairy', 'Normal' , q'{Quadruped body}', 'Pink' , 2, '3:1', 15, 'Cute Charm', 'Normalize', 'Wonder Skin', 11, 0.6 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 381, q'|Mega|', 'M', q'|Latiosite|', 'Undiscovered' , 'Dragon', 'Psychic', q'{Single pair of wings}', 'Purple' , 0, '0:1U', 120, 'Levitate' , 60, 2.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 770 , 'Amorphous' , 'Ghost', 'Ground', q'{Serpentine bodies}', 'Brown', 6, 6, 0, '1:1', 15, 'Water Compaction' , 'Sand Veil', 250, 1.3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 188 , 'Fairy', 'Grass', 'Grass', 'Flying', q'{Bipedal, tailed form}', 'Green' , 2, '1:1', 20, 'Chlorophyll', 'Leaf Guard', 'Infiltrator', 1, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 352 , 'Field' , 'Normal' , q'{Bipedal, tailed form}', 'Green' , 9, 1, '1:1', 20, 'Color Change' , 'Protean', 22, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 353 , 'Amorphous' , 'Ghost' , q'{Head}', 'Black' , 9, 2, '1:1', 25, 'Insomnia', 'Frisk', 'Cursed Body', 2.3, 0.6 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 666, q'|Marine Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 1.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 157 , 'Field' , 'Fire' , q'{Quadruped body}', 'Yellow' , 0, '1:7', 20, 'Blaze' , 'Flash Fire', 79.5, 1.7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 361 , 'Fairy', 'Mineral', 'Ice' , q'{Bipedal, tailless form}', 'Gray', 9, 9, 2, '1:1', 20, 'Inner Focus', 'Ice Body', 'Moody', 16.8, 0.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 582 , 'Mineral' , 'Ice' , q'{Head and a base}', 'White', 0, 0, 2, '1:1', 20, 'Ice Body', 'Snow Cloak', 'Weak Armor', 5.7, 0.4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 293 , 'Monster', 'Field', 'Normal' , q'{Bipedal, tailed form}', 'Pink' , 0, '1:1', 20, 'Soundproof' , 'Rattled', 16.3, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 250 , 'Undiscovered' , 'Fire', 'Flying', q'{Single pair of wings}', 'Red' , 0, 'GU', 120, 'Pressure' , 'Regenerator', 199, 3.8 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 50, q'|Alolan|', 'A' , 'Field' , 'Ground', 'Steel', q'{Head and a base}', 'Brown', 9, 9, 0, '1:1', 20, 'Sand Veil', 'Tangling Hair', 'Sand Force', 0.8, 0.2 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 75, q'|Alolan|', 'A' , 'Mineral' , 'Rock', 'Electric', q'{Bipedal, tailless form}', 'Gray', 6, 6, 0, '1:1', 15, 'Magnet Pull', 'Sturdy', 'Galvanize', 105, 1 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 773, q'|Type: Dark|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'RKS System' , 100.5, 2.3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 25, q'|Original Cap|' , 'Field', 'Fairy', 'Electric' , q'{Quadruped body}', 'Yellow', 6, 6, 0, '1:1', 10, 'Static' , 'Lightning Rod', 6, 0.4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 295 , 'Monster', 'Field', 'Normal' , q'{Bipedal, tailed form}', 'Blue' , 0, '1:1', 20, 'Soundproof' , 'Scrappy', 84, 1.5 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 302, q'|Mega|', 'M', q'|Sablenite|', 'Human-Like' , 'Dark', 'Ghost', q'{Bipedal, tailless form}', 'Purple', 0, 0, 0, '1:1', 25, 'Magic Bounce' , 11, 0.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 197 , 'Field' , 'Dark' , q'{Quadruped body}', 'Black', 0, 0, 0, '1:7', 35, 'Synchronize' , 'Inner Focus', 27, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 72 , 'Water 3' , 'Water', 'Poison', q'{Tentacles or a multiped body}', 'Blue', 15, 15, 0, '1:1', 20, 'Clear Body', 'Liquid Ooze', 'Rain Dish', 45.5, 0.9 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 492, q'|Sky Forme|', 'S' , 'Undiscovered' , 'Grass', 'Flying', q'{Quadruped body}', 'Green' , 0, 'GU', 120, 'Serene Grace' , 5.2, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 30 , 'Undiscovered' , 'Poison' , q'{Quadruped body}', 'Blue' , 2, '1:0U', 20, 'Poison Point', 'Rivalry', 'Hustle', 20, 0.8 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 103, q'|Alolan|', 'A' , 'Grass' , 'Grass', 'Dragon', q'{Head and legs}', 'Yellow', 0, 0, 0, '1:1', 20, 'Frisk' , 'Harvest', 120, 10.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 104 , 'Monster' , 'Ground' , q'{Bipedal, tailed form}', 'Brown', 15, 15, 0, '1:1', 20, 'Rock Head', 'Lightning Rod', 'Battle Armor', 6.5, 0.4 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 666, q'|Savanna Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 1.2 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 773, q'|Type: Normal|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'RKS System' , 100.5, 2.3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 676, q'|Natural Form|' , 'Field' , 'Normal' , q'{Quadruped body}', 'White' , 6, 0, '1:1', 20, 'Fur Coat' , 28, 1.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 125 , 'Human-Like' , 'Electric' , q'{Bipedal, tailed form}', 'Yellow', 6, 6, 0, '1:3', 25, 'Static' , 'Vital Spirit', 30, 1.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 243 , 'Undiscovered' , 'Electric' , q'{Quadruped body}', 'Yellow' , 8, 'GU', 80, 'Pressure' , 'Inner Focus', 178, 1.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 373 , 'Dragon' , 'Dragon', 'Flying', q'{Quadruped body}', 'Blue', 0, 0, 0, '1:1', 40, 'Intimidate' , 'Moxie', 102.6, 1.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 600 , 'Mineral' , 'Steel' , q'{Multiple bodies}', 'Gray' , 0, 'G', 20, 'Plus', 'Minus', 'Clear Body', 51, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 302 , 'Human-Like' , 'Dark', 'Ghost', q'{Bipedal, tailless form}', 'Purple', 0, 0, 2, '1:1', 25, 'Keen Eye', 'Stall', 'Prankster', 11, 0.5 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 323, q'|Mega|', 'M', q'|Cameruptite|', 'Field' , 'Fire', 'Ground', q'{Quadruped body}', 'Red' , 0, '1:1', 20, 'Sheer Force' , 220, 2.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 182 , 'Grass' , 'Grass' , q'{Bipedal, tailless form}', 'Green' , 0, '1:1', 20, 'Chlorophyll' , 'Healer', 5.8, 0.4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 767 , 'Bug', 'Water 3', 'Bug', 'Water', q'{Tentacles or a multiped body}', 'Gray', 0, 0, 0, '1:1', 20, 'Wimp Out' , 12, 0.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 575 , 'Human-Like' , 'Psychic' , q'{Bipedal, tailless form}', 'Purple' , 2, '3:1', 20, 'Frisk', 'Competitive', 'Shadow Tag', 18, 0.7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 331 , 'Grass', 'Human-Like', 'Grass' , q'{Bipedal, tailless form}', 'Green' , 0, '1:1', 20, 'Sand Veil' , 'Water Absorb', 51.3, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 503 , 'Field' , 'Water' , q'{Quadruped body}', 'Blue' , 0, '1:7', 20, 'Torrent' , 'Shell Armor', 94.6, 1.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 537 , 'Water 1' , 'Water', 'Ground', q'{Bipedal, tailless form}', 'Blue' , 0, '1:1', 20, 'Swift Swim', 'Poison Touch', 'Water Absorb', 62, 1.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 772 , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'Battle Armor' , 120.5, 1.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 101 , 'Mineral' , 'Electric' , q'{Head}', 'Red' , 0, 0, 'G', 20, 'Soundproof', 'Static', 'Aftermath', 66.6, 1.2 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 420 , 'Fairy', 'Grass', 'Grass' , q'{Multiple bodies}', 'Pink' , 0, '1:1', 20, 'Chlorophyll' , 3.3, 0.4 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 37, q'|Alolan|', 'A' , 'Field' , 'Ice' , q'{Quadruped body}', 'White', 9, 9, 0, '3:1', 20, 'Snow Cloak' , 'Snow Warning', 9.9, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 510 , 'Field' , 'Dark' , q'{Quadruped body}', 'Purple' , 0, '1:1', 20, 'Limber', 'Unburden', 'Prankster', 37.5, 1.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 218 , 'Amorphous' , 'Fire' , q'{Serpentine bodies}', 'Red' , 0, '1:1', 20, 'Magma Armor', 'Flame Body', 'Weak Armor', 35, 0.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 465 , 'Grass' , 'Grass' , q'{Bipedal, tailless form}', 'Blue' , 0, '1:1', 20, 'Chlorophyll', 'Leaf Guard', 'Regenerator', 128.6, 2 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 417 , 'Field', 'Fairy', 'Electric' , q'{Quadruped body}', 'White' , 0, '1:1', 10, 'Run Away', 'Pickup', 'Volt Absorb', 3.9, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 196 , 'Field' , 'Psychic' , q'{Quadruped body}', 'Purple', 0, 0, 0, '1:7', 35, 'Synchronize' , 'Magic Bounce', 26.5, 0.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 162 , 'Field' , 'Normal' , q'{Quadruped body}', 'Brown' , 0, '1:1', 15, 'Run Away', 'Keen Eye', 'Frisk', 32.5, 1.8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 775 , 'Field' , 'Normal' , q'{Bipedal, tailless form}', 'Blue', 0, 0, 0, '1:1', 20, 'Comatose' , 19.9, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 766 , 'Field' , 'Fighting' , q'{Bipedal, tailed form}', 'White', 15, 15, 0, '1:1', 20, 'Receiver' , 'Defiant', 82.8, 2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 348 , 'Water 3' , 'Rock', 'Bug', q'{Bipedal, tailed form}', 'Gray' , 0, '1:7', 30, 'Battle Armor' , 'Swift Swim', 68.2, 1.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 603 , 'Amorphous' , 'Electric' , q'{Fins}', 'Blue' , 0, '1:1', 20, 'Levitate' , 22, 1.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 107 , 'Human-Like' , 'Fighting' , q'{Bipedal, tailless form}', 'Brown' , 2, '0:1', 25, 'Keen Eye', 'Iron Fist', 'Inner Focus', 50.2, 1.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 750 , 'Field' , 'Ground' , q'{Quadruped body}', 'Brown', 6, 6, 0, '1:1', 20, 'Own Tempo', 'Stamina', 'Inner Focus', 920, 2.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 626 , 'Field' , 'Normal' , q'{Quadruped body}', 'Brown' , 0, '1:1', 20, 'Reckless', 'Sap Sipper', 'Soundproof', 94.5, 1.6 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 585, q'|Summer Form|' , 'Field' , 'Normal', 'Grass', q'{Quadruped body}', 'Pink' , 0, '1:1', 20, 'Chlorophyll', 'Sap Sipper', 'Serene Grace', 19.5, 0.6 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 741, q'|Baile Style|' , 'Flying' , 'Fire', 'Flying', q'{Single pair of wings}', 'Red', 6, 6, 0, '3:1', 20, 'Dancer' , 3.4, 0.6 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 459 , 'Monster', 'Grass', 'Grass', 'Ice', q'{Bipedal, tailed form}', 'White' , 0, '1:1', 20, 'Snow Warning' , 'Soundproof', 50.5, 1 );
insert into SPECIES( DEX, CLASS , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 351, q'|Normal|' , 'Fairy', 'Amorphous', 'Normal' , q'{Head}', 'Gray', 0, 0, 0, '1:1', 25, 'Forecast' , 0.8, 0.3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 394 , 'Water 1', 'Field', 'Water' , q'{Bipedal, tailed form}', 'Blue' , 0, '1:7', 20, 'Torrent' , 'Defiant', 23, 0.8 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 475, q'|Mega|', 'M', q'|Galladite|', 'Amorphous' , 'Psychic', 'Fighting', q'{Bipedal, tailless form}', 'White' , 0, '0:1', 20, 'Inner Focus' , 52, 1.6 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 53, q'|Alolan|', 'A' , 'Field' , 'Dark' , q'{Quadruped body}', 'Blue', 6, 6, 0, '1:1', 20, 'Fur Coat', 'Technician', 'Rattled', 32, 1.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 262 , 'Field' , 'Dark' , q'{Quadruped body}', 'Gray' , 2, '1:1', 15, 'Intimidate', 'Quick Feet', 'Moxie', 37, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 753 , 'Grass' , 'Grass' , q'{Bipedal, tailed form}', 'Pink', 9, 9, 0, '1:1', 20, 'Leaf Guard' , 'Contrary', 1.5, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 699 , 'Monster' , 'Rock', 'Ice', q'{Quadruped body}', 'Blue' , 0, '1:7', 30, 'Refrigerate' , 'Snow Warning', 225, 2.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 28 , 'Field' , 'Ground' , q'{Bipedal, tailed form}', 'Yellow' , 0, '1:1', 20, 'Sand Veil' , 'Sand Rush', 29.5, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 82 , 'Mineral' , 'Electric', 'Steel', q'{Multiple bodies}', 'Gray', 6, 6, 0, 'G', 20, 'Magnet Pull', 'Sturdy', 'Analytic', 60, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 67 , 'Human-Like' , 'Fighting' , q'{Bipedal, tailless form}', 'Gray', 6, 6, 2, '1:3', 20, 'Guts', 'No Guard', 'Steadfast', 70.5, 1.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 171 , 'Water 2' , 'Water', 'Electric', q'{Fins}', 'Blue', 6, 6, 0, '1:1', 20, 'Volt Absorb', 'Illuminate', 'Water Absorb', 22.5, 1.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 190 , 'Field' , 'Normal' , q'{Bipedal, tailed form}', 'Purple' , 9, 0, '1:1', 20, 'Run Away', 'Pickup', 'Skill Link', 11.5, 0.8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 709 , 'Grass', 'Amorphous', 'Ghost', 'Grass', q'{Tentacles or a multiped body}', 'Brown' , 0, '1:1', 20, 'Natural Cure', 'Frisk', 'Harvest', 71, 1.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 114 , 'Grass' , 'Grass' , q'{Head and legs}', 'Blue' , 2, '1:1', 20, 'Chlorophyll', 'Leaf Guard', 'Regenerator', 35, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 370 , 'Water 2' , 'Water' , q'{Fins}', 'Pink', 6, 6, 0, '3:1', 20, 'Swift Swim' , 'Hydration', 8.7, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 290 , 'Bug' , 'Bug', 'Ground', q'{Insectoid body}', 'Gray' , 0, '1:1', 15, 'Compound Eyes' , 'Run Away', 5.5, 0.5 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 252 , 'Monster', 'Dragon', 'Grass' , q'{Bipedal, tailed form}', 'Green' , 0, '1:7', 20, 'Overgrow' , 'Unburden', 5, 0.5 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 285 , 'Fairy', 'Grass', 'Grass' , q'{Head and legs}', 'Brown' , 2, '1:1', 15, 'Effect Spore', 'Poison Heal', 'Quick Feet', 4.5, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 682 , 'Fairy' , 'Fairy' , q'{Head and arms}', 'Pink' , 0, '1:1', 20, 'Healer' , 'Aroma Veil', 0.5, 0.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 653 , 'Field' , 'Fire' , q'{Quadruped body}', 'Red' , 0, '1:7', 20, 'Blaze' , 'Magician', 9.4, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 574 , 'Human-Like' , 'Psychic' , q'{Bipedal, tailless form}', 'Purple' , 2, '3:1', 20, 'Frisk', 'Competitive', 'Shadow Tag', 5.8, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 719 , 'Undiscovered' , 'Rock', 'Fairy', q'{Head and arms}', 'Pink' , 0, 'GU', 25, 'Clear Body' , 8.8, 0.7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 563 , 'Mineral', 'Amorphous', 'Ghost' , q'{Head and a base}', 'Yellow' , 0, '1:1', 25, 'Mummy' , 76.5, 1.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 340 , 'Water 2' , 'Water', 'Ground', q'{Fins}', 'Blue', 6, 6, 2, '1:1', 20, 'Oblivious', 'Anticipation', 'Hydration', 23.6, 0.9 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 648, q'|Pirouette Forme|', 'P' , 'Undiscovered' , 'Normal', 'Fighting', q'{Bipedal, tailless form}', 'White' , 0, 'GU', 120, 'Serene Grace' , 6.5, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 36 , 'Fairy' , 'Fairy' , q'{Bipedal, tailed form}', 'Pink' , 2, '3:1', 10, 'Cute Charm', 'Magic Guard', 'Unaware', 40, 1.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 206 , 'Field' , 'Normal' , q'{Serpentine bodies}', 'Yellow' , 3, 0, '1:1', 20, 'Serene Grace', 'Run Away', 'Rattled', 14, 1.5 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 493, q'|Type: Ice|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Multitype' , 320, 3.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 123 , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'Green', 3, 3, 2, '1:1', 25, 'Swarm', 'Technician', 'Steadfast', 56, 1.5 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 314 , 'Bug', 'Human-Like', 'Bug' , q'{Bipedal, tailless form}', 'Purple' , 2, '1:0', 15, 'Oblivious', 'Tinted Lens', 'Prankster', 17.7, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 786 , 'Undiscovered' , 'Psychic', 'Fairy', q'{Head and arms}', 'Pink' , 0, 'GU', 15, 'Psychic Surge' , 'Telepathy', 18.6, 1.2 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 711, q'|Small Size|' , 'Amorphous' , 'Ghost', 'Grass', q'{Head and a base}', 'Brown' , 0, '1:1', 20, 'Pickup', 'Frisk', 'Insomnia', 9.5, 0.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 156 , 'Field' , 'Fire' , q'{Quadruped body}', 'Yellow' , 0, '1:7', 20, 'Blaze' , 'Flash Fire', 19, 0.9 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 222 , 'Water 1', 'Water 3', 'Water', 'Rock', q'{Insectoid body}', 'Pink', 9, 9, 0, '3:1', 20, 'Hustle', 'Natural Cure', 'Regenerator', 5, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 409 , 'Monster' , 'Rock' , q'{Bipedal, tailed form}', 'Blue' , 0, '1:7', 30, 'Mold Breaker' , 'Sheer Force', 102.5, 1.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 63 , 'Human-Like' , 'Psychic' , q'{Bipedal, tailed form}', 'Brown', 9, 9, 0, '1:3', 20, 'Synchronize', 'Inner Focus', 'Magic Guard', 19.5, 0.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 616 , 'Bug' , 'Bug' , q'{Head}', 'Red' , 0, '1:1', 15, 'Hydration', 'Shell Armor', 'Overcoat', 7.7, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 804 , 'Undiscovered' , 'Poison', 'Dragon', q'{Single pair of wings}', 'Purple' , 0, 'GU', 120, 'Beast Boost' , 150, 3.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 453 , 'Human-Like' , 'Poison', 'Fighting', q'{Bipedal, tailless form}', 'Blue' , 0, '1:1', 10, 'Anticipation', 'Dry Skin', 'Poison Touch', 23, 0.7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 585, q'|Winter Form|' , 'Field' , 'Normal', 'Grass', q'{Quadruped body}', 'Pink' , 0, '1:1', 20, 'Chlorophyll', 'Sap Sipper', 'Serene Grace', 19.5, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 477 , 'Amorphous' , 'Ghost' , q'{Head and arms}', 'Black' , 1, '1:1', 25, 'Pressure' , 'Frisk', 106.6, 2.2 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 497 , 'Field', 'Grass', 'Grass' , q'{Serpentine bodies}', 'Green' , 0, '1:7', 20, 'Overgrow' , 'Contrary', 63, 3.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 429 , 'Amorphous' , 'Ghost' , q'{Head}', 'Purple' , 0, '1:1', 25, 'Levitate' , 4.4, 0.9 );
insert into SPECIES( DEX, CLASS , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 6, q'|Normal and|' , 'Monster', 'Dragon', 'Fire', 'Flying', q'{Bipedal, tailed form}', 'Red' , 0, '1:7', 20, 'Blaze' , 'Solar Power', 90.5, 1.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 269 , 'Bug' , 'Bug', 'Poison', q'{Two or more pairs of wings}', 'Green' , 0, '1:1', 15, 'Shield Dust' , 'Compound Eyes', 31.6, 1.2 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 586, q'|Winter Form|' , 'Field' , 'Normal', 'Grass', q'{Quadruped body}', 'Brown' , 0, '1:1', 20, 'Chlorophyll', 'Sap Sipper', 'Serene Grace', 92.5, 1.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 502 , 'Field' , 'Water' , q'{Bipedal, tailed form}', 'Blue' , 0, '1:7', 20, 'Torrent' , 'Shell Armor', 24.5, 0.8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 707 , 'Mineral' , 'Steel', 'Fairy', q'{Head}', 'Gray', 6, 6, 0, '1:1', 20, 'Prankster' , 'Magician', 3, 0.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 186 , 'Water 1' , 'Water' , q'{Bipedal, tailless form}', 'Green', 0, 0, 0, '1:1', 20, 'Water Absorb', 'Damp', 'Drizzle', 33.9, 1.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 535 , 'Water 1' , 'Water' , q'{Fins}', 'Blue' , 0, '1:1', 20, 'Swift Swim', 'Hydration', 'Water Absorb', 4.5, 0.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 343 , 'Mineral' , 'Ground', 'Psychic', q'{Head and arms}', 'Brown' , 15, 0, 'G', 20, 'Levitate' , 21.5, 0.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 277 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Blue' , 0, '1:1', 15, 'Guts' , 'Scrappy', 19.8, 0.7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 422, q'|West Sea|' , 'Water 1', 'Amorphous', 'Water' , q'{Serpentine bodies}', 'Purple', 9, 9, 0, '1:1', 20, 'Sticky Hold', 'Storm Drain', 'Sand Force', 6.3, 0.3 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 52, q'|Alolan|', 'A' , 'Field' , 'Dark' , q'{Quadruped body}', 'Blue', 9, 9, 0, '1:1', 20, 'Pickup', 'Technician', 'Rattled', 4.2, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 121 , 'Water 3' , 'Water', 'Psychic', q'{Head and a base}', 'Purple', 0, 0, 0, 'G', 20, 'Illuminate', 'Natural Cure', 'Analytic', 80, 1.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 679 , 'Mineral' , 'Steel', 'Ghost', q'{Head and a base}', 'Brown' , 0, '1:1', 20, 'No Guard' , 2, 0.8 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 773, q'|Type: Grass|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'RKS System' , 100.5, 2.3 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 6, q'|Mega  Y|', 'MY' , 'Monster', 'Dragon', 'Fire', 'Flying', q'{Bipedal, tailed form}', 'Red' , 0, '1:7', 20, 'Drought' , 90.5, 1.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 166 , 'Bug' , 'Bug', 'Flying', q'{Single pair of wings}', 'Red', 6, 6, 0, '1:1', 15, 'Swarm', 'Early Bird', 'Iron Fist', 35.6, 1.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 725 , 'Field' , 'Fire' , q'{Quadruped body}', 'Red' , 0, '1:7', 15, 'Blaze' , 'Intimidate', 4.3, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 227 , 'Flying' , 'Steel', 'Flying', q'{Single pair of wings}', 'Gray', 6, 6, 0, '1:1', 25, 'Keen Eye', 'Sturdy', 'Weak Armor', 50.5, 1.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 102 , 'Grass' , 'Grass', 'Psychic', q'{Multiple bodies}', 'Pink', 15, 15, 0, '1:1', 20, 'Chlorophyll' , 'Harvest', 2.5, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 205 , 'Bug' , 'Bug', 'Steel', q'{Head}', 'Purple' , 6, 0, '1:1', 20, 'Sturdy' , 'Overcoat', 125.8, 1.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 40 , 'Fairy' , 'Normal', 'Fairy', q'{Bipedal, tailless form}', 'Pink' , 2, '3:1', 10, 'Cute Charm', 'Competitive', 'Frisk', 12, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 803 , 'Undiscovered' , 'Poison' , q'{Bipedal, tailed form}', 'Purple' , 0, 'GU', 120, 'Beast Boost' , 1.8, 0.6 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 493, q'|Type: Fire|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Multitype' , 320, 3.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 144 , 'Undiscovered' , 'Ice', 'Flying', q'{Single pair of wings}', 'Blue' , 0, 'GU', 80, 'Pressure' , 'Snow Cloak', 55.4, 1.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 248 , 'Monster' , 'Rock', 'Dark', q'{Bipedal, tailed form}', 'Green' , 0, '1:1', 40, 'Sand Stream' , 'Unnerve', 202, 2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 714 , 'Flying' , 'Flying', 'Dragon', q'{Single pair of wings}', 'Purple' , 9, 0, '1:1', 20, 'Frisk', 'Infiltrator', 'Telepathy', 8, 0.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 650 , 'Field' , 'Grass' , q'{Bipedal, tailed form}', 'Green' , 0, '1:7', 20, 'Overgrow' , 'Bulletproof', 9, 0.4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 703 , 'Fairy', 'Mineral', 'Rock', 'Fairy', q'{Head}', 'Gray', 9, 9, 0, 'G', 25, 'Clear Body' , 'Sturdy', 5.7, 0.3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 313 , 'Bug', 'Human-Like', 'Bug' , q'{Bipedal, tailed form}', 'Gray' , 0, '0:1', 15, 'Illuminate', 'Swarm', 'Prankster', 17.7, 0.7 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 742 , 'Bug', 'Fairy', 'Bug', 'Fairy', q'{Insectoid body}', 'Yellow', 9, 9, 0, '1:1', 20, 'Honey Gather', 'Shield Dust', 'Sweet Veil', 0.2, 0.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 311 , 'Fairy' , 'Electric' , q'{Bipedal, tailed form}', 'Yellow' , 1, '1:1', 20, 'Plus' , 'Lightning Rod', 4.2, 0.4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 26 , 'Field', 'Fairy', 'Electric' , q'{Bipedal, tailed form}', 'Yellow' , 0, '1:1', 10, 'Static' , 'Lightning Rod', 30, 0.8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 672 , 'Field' , 'Grass' , q'{Quadruped body}', 'Brown' , 0, '1:1', 20, 'Sap Sipper' , 'Grass Pelt', 31, 0.9 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 489 , 'Water 1', 'Fairy', 'Water' , q'{Head and arms}', 'Blue' , 0, 'G', 40, 'Hydration' , 3.1, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 185 , 'Mineral' , 'Rock' , q'{Bipedal, tailless form}', 'Brown', 0, 0, 0, '1:1', 20, 'Sturdy', 'Rock Head', 'Rattled', 38, 1.2 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 27, q'|Alolan|', 'A' , 'Field' , 'Ice', 'Steel', q'{Bipedal, tailed form}', 'White', 9, 9, 0, '1:1', 20, 'Snow Cloak' , 'Slush Rush', 12, 0.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 213 , 'Bug' , 'Bug', 'Rock', q'{Insectoid body}', 'Yellow' , 2, '1:1', 20, 'Sturdy', 'Gluttony', 'Contrary', 20.5, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 438 , 'Undiscovered' , 'Rock' , q'{Head and legs}', 'Brown', 15, 15, 0, '1:1U', 20, 'Sturdy', 'Rock Head', 'Rattled', 15, 0.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 659 , 'Field' , 'Normal' , q'{Bipedal, tailed form}', 'Brown' , 0, '1:1', 15, 'Pickup', 'Cheek Pouch', 'Huge Power', 5, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 660 , 'Field' , 'Normal', 'Ground', q'{Bipedal, tailed form}', 'Brown' , 0, '1:1', 15, 'Pickup', 'Cheek Pouch', 'Huge Power', 42.4, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 69 , 'Grass' , 'Grass', 'Poison', q'{Bipedal, tailless form}', 'Green' , 0, '1:1', 20, 'Chlorophyll' , 'Gluttony', 4, 0.7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 710, q'|Small Size|' , 'Amorphous' , 'Ghost', 'Grass', q'{Head}', 'Brown' , 0, '1:1', 20, 'Pickup', 'Frisk', 'Insomnia', 3.5, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 793 , 'Undiscovered' , 'Rock', 'Poison', q'{Tentacles or a multiped body}', 'White' , 0, 'GU', 120, 'Beast Boost' , 55.5, 1.2 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 380, q'|Mega|', 'M', q'|Latiasite|', 'Undiscovered' , 'Dragon', 'Psychic', q'{Single pair of wings}', 'Purple' , 0, '1:0U', 120, 'Levitate' , 40, 1.8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 612 , 'Monster', 'Dragon', 'Dragon' , q'{Bipedal, tailed form}', 'Yellow' , 0, '1:1', 40, 'Rivalry', 'Mold Breaker', 'Unnerve', 105.5, 1.8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 64 , 'Human-Like' , 'Psychic' , q'{Bipedal, tailed form}', 'Brown', 6, 6, 0, '1:3', 20, 'Synchronize', 'Inner Focus', 'Magic Guard', 56.5, 1.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 463 , 'Monster' , 'Normal' , q'{Bipedal, tailless form}', 'Pink' , 0, '1:1', 20, 'Own Tempo', 'Oblivious', 'Cloud Nine', 140, 1.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 298 , 'Undiscovered' , 'Normal', 'Fairy', q'{Head and legs}', 'Blue' , 0, '3:1U', 10, 'Thick Fat', 'Huge Power', 'Sap Sipper', 2, 0.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 289 , 'Field' , 'Normal' , q'{Bipedal, tailless form}', 'Brown' , 0, '1:1', 15, 'Truant' , 130.5, 2 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 547 , 'Grass', 'Fairy', 'Grass', 'Fairy', q'{Bipedal, tailless form}', 'Green' , 0, '1:1', 20, 'Prankster', 'Infiltrator', 'Chlorophyll', 6.6, 0.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 73 , 'Water 3' , 'Water', 'Poison', q'{Tentacles or a multiped body}', 'Blue', 6, 6, 0, '1:1', 20, 'Clear Body', 'Liquid Ooze', 'Rain Dish', 55, 1.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 680 , 'Mineral' , 'Steel', 'Ghost', q'{Multiple bodies}', 'Brown' , 0, '1:1', 20, 'No Guard' , 4.5, 0.8 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 710, q'|Super Size|' , 'Amorphous' , 'Ghost', 'Grass', q'{Head}', 'Brown' , 0, '1:1', 20, 'Pickup', 'Frisk', 'Insomnia', 15, 0.8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 439 , 'Undiscovered' , 'Psychic', 'Fairy', q'{Bipedal, tailless form}', 'Pink' , 15, 0, '1:1U', 25, 'Soundproof', 'Filter', 'Technician', 13, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 367 , 'Water 1' , 'Water' , q'{Serpentine bodies}', 'Blue' , 0, 0, '1:1', 20, 'Swift Swim' , 'Water Veil', 27, 1.7 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 774, q'|Brown|' , 'Mineral' , 'Rock', 'Flying', q'{Head}', 'Brown', 0, 0, 0, 'G', 25, 'Shields Down' , 40, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 807 , 'Undiscovered' , 'Electric' , q'{Bipedal, tailless form}', 'Yellow' , 0, 'GU', 120, 'Volt Absorb' , 44.5, 1.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 346 , 'Water 3' , 'Rock', 'Grass', q'{Head and a base}', 'Green' , 0, '1:7', 30, 'Suction Cups' , 'Storm Drain', 60.4, 1.5 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 528 , 'Field', 'Flying', 'Psychic', 'Flying', q'{Single pair of wings}', 'Blue' , 0, '1:1', 15, 'Unaware', 'Klutz', 'Simple', 10.5, 0.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 150 , 'Undiscovered' , 'Psychic' , q'{Bipedal, tailed form}', 'Purple' , 0, 'GU', 120, 'Pressure' , 'Unnerve', 122, 2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 323 , 'Field' , 'Fire', 'Ground', q'{Quadruped body}', 'Red' , 2, '1:1', 20, 'Magma Armor', 'Solid Rock', 'Anger Point', 220, 1.9 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 487, q'|Altered Forme|' , 'Undiscovered' , 'Ghost', 'Dragon', q'{Tentacles or a multiped body}', 'Black' , 0, 'GU', 120, 'Pressure' , 'Telepathy', 750, 6.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 53 , 'Field' , 'Normal' , q'{Quadruped body}', 'Yellow', 6, 6, 2, '1:1', 20, 'Limber', 'Technician', 'Unnerve', 32, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 541 , 'Bug' , 'Bug', 'Grass', q'{Head and arms}', 'Green' , 0, '1:1', 15, 'Leaf Guard', 'Chlorophyll', 'Overcoat', 7.3, 0.5 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 773, q'|Type: Water|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'RKS System' , 100.5, 2.3 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 150, q'|Mega  Y|', 'MY' , 'Undiscovered' , 'Psychic' , q'{Bipedal, tailed form}', 'Purple' , 0, 'GU', 120, 'Insomnia' , 122, 1.5 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 230 , 'Water 1', 'Dragon', 'Water', 'Dragon', q'{Head and a base}', 'Blue' , 2, '1:1', 20, 'Swift Swim', 'Sniper', 'Damp', 152, 1.8 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 319, q'|Mega|', 'M', q'|Sharpedonite|', 'Water 2' , 'Water', 'Dark', q'{Fins}', 'Blue', 3, 3, 0, '1:1', 20, 'Strong Jaw' , 88.8, 2.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 522 , 'Field' , 'Electric' , q'{Quadruped body}', 'Black' , 0, '1:1', 20, 'Lightning Rod', 'Motor Drive', 'Sap Sipper', 29.8, 0.8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 308 , 'Human-Like' , 'Fighting', 'Psychic', q'{Bipedal, tailless form}', 'Red' , 0, '1:1', 20, 'Pure Power' , 'Telepathy', 31.5, 1.3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 179 , 'Monster', 'Field', 'Electric' , q'{Quadruped body}', 'White' , 9, 0, '1:1', 20, 'Static' , 'Plus', 7.8, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 631 , 'Field' , 'Fire' , q'{Bipedal, tailed form}', 'Red' , 0, '1:1', 20, 'Gluttony', 'Flash Fire', 'White Smoke', 58, 1.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 192 , 'Grass' , 'Grass' , q'{Bipedal, tailless form}', 'Yellow' , 2, '1:1', 20, 'Chlorophyll', 'Solar Power', 'Early Bird', 8.5, 0.8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 66 , 'Human-Like' , 'Fighting' , q'{Bipedal, tailed form}', 'Gray', 9, 9, 2, '1:3', 20, 'Guts', 'No Guard', 'Steadfast', 19.5, 0.8 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 676, q'|Dandy Trim|' , 'Field' , 'Normal' , q'{Quadruped body}', 'White' , 6, 0, '1:1', 20, 'Fur Coat' , 28, 1.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 473 , 'Field' , 'Ice', 'Ground', q'{Quadruped body}', 'Brown' , 0, '1:1', 20, 'Oblivious', 'Snow Cloak', 'Thick Fat', 291, 2.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 715 , 'Flying' , 'Flying', 'Dragon', q'{Single pair of wings}', 'Purple' , 6, 0, '1:1', 20, 'Frisk', 'Infiltrator', 'Telepathy', 85, 1.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 805 , 'Undiscovered' , 'Rock', 'Steel', q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'Beast Boost' , 820, 5.5 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 76, q'|Alolan|', 'A' , 'Mineral' , 'Rock', 'Electric', q'{Bipedal, tailless form}', 'Gray' , 0, '1:1', 15, 'Magnet Pull', 'Sturdy', 'Galvanize', 300, 1.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 634 , 'Dragon' , 'Dark', 'Dragon', q'{Quadruped body}', 'Blue' , 0, '1:1', 40, 'Hustle' , 50, 1.4 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 310, q'|Mega|', 'M', q'|Manectite|', 'Field' , 'Electric' , q'{Quadruped body}', 'Yellow' , 6, 0, '1:1', 20, 'Intimidate' , 40.2, 1.8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 224 , 'Water 1', 'Water 2', 'Water' , q'{Tentacles or a multiped body}', 'Red' , 0, 2, '1:1', 20, 'Suction Cups', 'Sniper', 'Moody', 28.5, 0.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 554 , 'Field' , 'Fire' , q'{Bipedal, tailless form}', 'Red' , 0, '1:1', 20, 'Hustle' , 'Inner Focus', 37.5, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 133 , 'Field' , 'Normal' , q'{Quadruped body}', 'Brown', 9, 9, 2, '1:7', 35, 'Run Away', 'Adaptability', 'Anticipation', 6.5, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 795 , 'Undiscovered' , 'Bug', 'Fighting', q'{Bipedal, tailless form}', 'White' , 0, 'GU', 120, 'Beast Boost' , 25, 1.8 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 460, q'|Mega|', 'M', q'|Abomasite|', 'Monster', 'Grass', 'Grass', 'Ice', q'{Bipedal, tailed form}', 'White' , 0, '1:1', 20, 'Snow Warning' , 135.5, 2.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 601 , 'Mineral' , 'Steel' , q'{Multiple bodies}', 'Gray' , 0, 'G', 20, 'Plus', 'Minus', 'Clear Body', 81, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 661 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Red', 9, 9, 0, '1:1', 15, 'Big Pecks' , 'Gale Wings', 1.7, 0.3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 557 , 'Bug', 'Mineral', 'Bug', 'Rock', q'{Insectoid body}', 'Red' , 0, '1:1', 20, 'Sturdy', 'Shell Armor', 'Weak Armor', 14.5, 0.3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 468 , 'Flying', 'Fairy', 'Fairy', 'Flying', q'{Single pair of wings}', 'White' , 0, '1:7', 10, 'Hustle', 'Serene Grace', 'Super Luck', 38, 1.5 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 729 , 'Water 1', 'Field', 'Water' , q'{Fins}', 'Blue' , 0, '1:7', 15, 'Torrent' , 'Liquid Voice', 17.5, 0.6 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 129 , 'Water 2', 'Dragon', 'Water' , q'{Fins}', 'Red', 9, 9, 0, '1:1', 5, 'Swift Swim' , 'Rattled', 10, 0.9 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 674 , 'Field', 'Human-Like', 'Fighting' , q'{Bipedal, tailed form}', 'White', 9, 9, 0, '1:1', 25, 'Iron Fist', 'Mold Breaker', 'Scrappy', 8, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 246 , 'Monster' , 'Rock', 'Ground', q'{Bipedal, tailed form}', 'Green' , 9, 0, '1:1', 40, 'Guts' , 'Sand Veil', 72, 0.6 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 334 , 'Flying', 'Dragon', 'Dragon', 'Flying', q'{Single pair of wings}', 'Blue' , 0, '1:1', 20, 'Natural Cure' , 'Cloud Nine', 20.6, 1.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 106 , 'Human-Like' , 'Fighting' , q'{Bipedal, tailless form}', 'Brown' , 2, '0:1', 25, 'Limber', 'Reckless', 'Unburden', 49.8, 1.5 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 666, q'|Archipelago Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 1.2 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 669, q'|Red Flower|' , 'Fairy' , 'Fairy' , q'{Head and arms}', 'White' , 15, 0, '1:0', 20, 'Flower Veil' , 'Symbiosis', 0.1, 0.1 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 681, q'|Blade Forme|', 'B' , 'Mineral' , 'Steel', 'Ghost', q'{Head and a base}', 'Brown' , 0, '1:1', 20, 'Stance Change' , 53, 1.7 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 19, q'|Alolan|', 'A' , 'Field' , 'Dark', 'Normal', q'{Quadruped body}', 'Black', 9, 9, 0, '1:1', 15, 'Gluttony', 'Hustle', 'Thick Fat', 3.5, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 500 , 'Field' , 'Fire', 'Fighting', q'{Bipedal, tailed form}', 'Red' , 0, '1:7', 20, 'Blaze' , 'Reckless', 150, 1.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 338 , 'Mineral' , 'Rock', 'Psychic', q'{Head}', 'Red' , 0, 'G', 25, 'Levitate' , 154, 1.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 381 , 'Undiscovered' , 'Dragon', 'Psychic', q'{Single pair of wings}', 'Blue' , 0, '0:1U', 120, 'Levitate' , 60, 2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 245 , 'Undiscovered' , 'Water' , q'{Quadruped body}', 'Blue' , 8, 'GU', 80, 'Pressure' , 'Inner Focus', 187, 2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 572 , 'Field' , 'Normal' , q'{Quadruped body}', 'Gray' , 9, 0, '3:1', 15, 'Cute Charm', 'Technician', 'Skill Link', 5.8, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 442 , 'Amorphous' , 'Ghost', 'Dark', q'{Head and a base}', 'Purple' , 0, '1:1', 30, 'Pressure' , 'Infiltrator', 108, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 109 , 'Amorphous' , 'Poison' , q'{Head}', 'Purple' , 0, '1:1', 20, 'Levitate' , 1, 0.6 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 671, q'|White Flower|' , 'Fairy' , 'Fairy' , q'{Head and arms}', 'White' , 0, '1:0', 20, 'Flower Veil' , 'Symbiosis', 10, 1.1 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 479, q'|Heat|' , 'Amorphous' , 'Electric', 'Ghost', q'{Head}', 'Red' , 0, 'G', 20, 'Levitate' , 0.3, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 595 , 'Bug' , 'Bug', 'Electric', q'{Insectoid body}', 'Yellow' , 0, '1:1', 20, 'Compound Eyes', 'Unnerve', 'Swarm', 0.6, 0.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 638 , 'Undiscovered' , 'Steel', 'Fighting', q'{Quadruped body}', 'Blue' , 0, 'GU', 80, 'Justified' , 250, 2.1 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 229, q'|Mega|', 'M', q'|Houndoominite|', 'Field' , 'Dark', 'Fire', q'{Quadruped body}', 'Black' , 6, 0, '1:1', 20, 'Solar Power' , 35, 1.9 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 702 , 'Field', 'Fairy', 'Electric', 'Fairy', q'{Bipedal, tailed form}', 'Yellow' , 9, 0, '1:1', 20, 'Cheek Pouch', 'Pickup', 'Plus', 2.2, 0.2 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 189 , 'Fairy', 'Grass', 'Grass', 'Flying', q'{Bipedal, tailed form}', 'Blue' , 2, '1:1', 20, 'Chlorophyll', 'Leaf Guard', 'Infiltrator', 3, 0.8 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 351, q'|Sunny Form|', 'S' , 'Fairy', 'Amorphous', 'Fire' , q'{Head}', 'Red', 0, 0, 0, '1:1', 25, 'Forecast' , 0.8, 0.3 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 3, q'|Mega|', 'M', q'|Venusaurite|', 'Monster', 'Grass', 'Grass', 'Poison', q'{Quadruped body}', 'Green' , 0, '1:7', 20, 'Thick Fat' , 100, 2.4 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 493, q'|Type: Bug|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Multitype' , 320, 3.2 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 670, q'|Blue Flower|' , 'Fairy' , 'Fairy' , q'{Head and arms}', 'White' , 0, 0, '1:0', 20, 'Flower Veil' , 'Symbiosis', 0.9, 0.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 416 , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'Yellow' , 0, '1:0', 15, 'Pressure' , 'Unnerve', 38.5, 1.2 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 666, q'|High Plains Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 1.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 411 , 'Monster' , 'Rock', 'Steel', q'{Quadruped body}', 'Gray' , 0, '1:7', 30, 'Sturdy' , 'Soundproof', 149.5, 1.3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 666, q'|Meadow Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 1.2 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 585, q'|Autumn Form|' , 'Field' , 'Normal', 'Grass', q'{Quadruped body}', 'Pink' , 0, '1:1', 20, 'Chlorophyll', 'Sap Sipper', 'Serene Grace', 19.5, 0.6 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 669, q'|Orange Flower|' , 'Fairy' , 'Fairy' , q'{Head and arms}', 'White' , 15, 0, '1:0', 20, 'Flower Veil' , 'Symbiosis', 0.1, 0.1 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 711, q'|Super Size|' , 'Amorphous' , 'Ghost', 'Grass', q'{Head and a base}', 'Brown' , 0, '1:1', 20, 'Pickup', 'Frisk', 'Insomnia', 39, 1.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 404 , 'Field' , 'Electric' , q'{Quadruped body}', 'Blue' , 0, '1:1', 20, 'Rivalry', 'Intimidate', 'Guts', 30.5, 0.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 481 , 'Undiscovered' , 'Psychic' , q'{Bipedal, tailed form}', 'Pink' , 0, 'GU', 80, 'Levitate' , 0.3, 0.3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 647, q'|Ordinary Form|' , 'Undiscovered' , 'Water', 'Fighting', q'{Quadruped body}', 'Yellow' , 0, 'GU', 80, 'Justified' , 48.5, 1.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 10 , 'Bug' , 'Bug' , q'{Insectoid body}', 'Green', 15, 15, 0, '1:1', 15, 'Shield Dust' , 'Run Away', 2.9, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 568 , 'Mineral' , 'Poison' , q'{Bipedal, tailless form}', 'Green', 9, 9, 0, '1:1', 20, 'Stench', 'Sticky Hold', 'Aftermath', 31, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 760 , 'Field' , 'Normal', 'Fighting', q'{Bipedal, tailed form}', 'Pink', 6, 6, 0, '1:1', 15, 'Fluffy', 'Klutz', 'Unnerve', 135, 2.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 316 , 'Amorphous' , 'Poison' , q'{Head and arms}', 'Green' , 0, '1:1', 20, 'Liquid Ooze', 'Sticky Hold', 'Gluttony', 10.3, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 471 , 'Field' , 'Ice' , q'{Quadruped body}', 'Blue' , 0, '1:7', 35, 'Snow Cloak' , 'Ice Body', 25.9, 0.8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 751 , 'Water 1', 'Bug', 'Water', 'Bug', q'{Head and legs}', 'Green', 9, 9, 0, '1:1', 15, 'Water Bubble' , 'Water Absorb', 4, 0.3 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 645, q'|Therian Forme|', 'T' , 'Undiscovered' , 'Ground', 'Flying', q'{Quadruped body}', 'Brown' , 0, '0:1U', 120, 'Intimidate' , 68, 1.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 92 , 'Amorphous' , 'Ghost', 'Poison', q'{Head}', 'Purple', 9, 9, 0, '1:1', 20, 'Levitate' , 0.1, 1.3 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 423, q'|East Sea|', 'E' , 'Water 1', 'Amorphous', 'Water', 'Ground', q'{Serpentine bodies}', 'Blue', 6, 6, 0, '1:1', 20, 'Sticky Hold', 'Storm Drain', 'Sand Force', 29.9, 0.9 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 46 , 'Bug', 'Grass', 'Bug', 'Grass', q'{Insectoid body}', 'Red', 9, 9, 2, '1:1', 20, 'Effect Spore', 'Dry Skin', 'Damp', 5.4, 0.3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 5 , 'Monster', 'Dragon', 'Fire' , q'{Bipedal, tailed form}', 'Red' , 0, '1:7', 20, 'Blaze' , 'Solar Power', 19, 1.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 405 , 'Field' , 'Electric' , q'{Quadruped body}', 'Blue' , 0, '1:1', 20, 'Rivalry', 'Intimidate', 'Guts', 42, 1.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 310 , 'Field' , 'Electric' , q'{Quadruped body}', 'Yellow' , 6, 0, '1:1', 20, 'Static', 'Lightning Rod', 'Minus', 40.2, 1.5 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 308, q'|Mega|', 'M', q'|Medichamite|', 'Human-Like' , 'Fighting', 'Psychic', q'{Bipedal, tailless form}', 'Red' , 0, '1:1', 20, 'Pure Power' , 31.5, 1.3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 25, q'|Pikachu, Ph. D|' , 'Field', 'Fairy', 'Electric' , q'{Quadruped body}', 'Yellow', 6, 6, 0, '1:1', 10, 'Static' , 'Lightning Rod', 6, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 132 , 'Ditto' , 'Normal' , q'{Head}', 'Purple', 9, 9, 0, 'G*', 20, 'Limber' , 'Imposter', 4, 0.3 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 531, q'|Mega|', 'M', q'|Audinite|', 'Fairy' , 'Normal', 'Fairy', q'{Bipedal, tailed form}', 'White' , 0, '1:1', 20, 'Healer' , 31, 1.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 605 , 'Human-Like' , 'Psychic' , q'{Bipedal, tailed form}', 'Blue' , 15, 0, '1:1', 20, 'Telepathy', 'Synchronize', 'Analytic', 9, 0.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 454 , 'Human-Like' , 'Poison', 'Fighting', q'{Bipedal, tailless form}', 'Blue' , 0, '1:1', 20, 'Anticipation', 'Dry Skin', 'Poison Touch', 44.4, 1.3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 550, q'|Red-Striped Form|' , 'Water 2' , 'Water' , q'{Fins}', 'Green' , 9, 0, '1:1', 40, 'Reckless', 'Adaptability', 'Mold Breaker', 18, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 296 , 'Human-Like' , 'Fighting' , q'{Bipedal, tailless form}', 'Yellow', 9, 9, 0, '1:3', 20, 'Thick Fat', 'Guts', 'Sheer Force', 86.4, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 504 , 'Field' , 'Normal' , q'{Quadruped body}', 'Brown' , 0, '1:1', 15, 'Run Away', 'Keen Eye', 'Analytic', 11.6, 0.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 410 , 'Monster' , 'Rock', 'Steel', q'{Quadruped body}', 'Gray' , 0, '1:7', 30, 'Sturdy' , 'Soundproof', 57, 0.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 13 , 'Bug' , 'Bug', 'Poison', q'{Insectoid body}', 'Brown' , 0, '1:1', 15, 'Shield Dust' , 'Run Away', 3.2, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 221 , 'Field' , 'Ice', 'Ground', q'{Quadruped body}', 'Brown' , 2, '1:1', 20, 'Oblivious', 'Snow Cloak', 'Thick Fat', 55.8, 1.1 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 676, q'|Heart Trim|' , 'Field' , 'Normal' , q'{Quadruped body}', 'White' , 6, 0, '1:1', 20, 'Fur Coat' , 28, 1.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 570 , 'Field' , 'Dark' , q'{Quadruped body}', 'Gray' , 9, 0, '1:7', 25, 'Illusion' , 12.5, 0.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 380 , 'Undiscovered' , 'Dragon', 'Psychic', q'{Single pair of wings}', 'Red' , 0, '1:0U', 120, 'Levitate' , 40, 1.4 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 373, q'|Mega|', 'M', q'|Salamencite|', 'Dragon' , 'Dragon', 'Flying', q'{Quadruped body}', 'Blue', 0, 0, 0, '1:1', 40, 'Aerilate' , 102.6, 1.8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 588 , 'Bug' , 'Bug' , q'{Bipedal, tailless form}', 'Blue' , 0, '1:1', 15, 'Swarm', 'Shed Skin', 'No Guard', 5.9, 0.5 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 390 , 'Field', 'Human-Like', 'Fire' , q'{Bipedal, tailed form}', 'Brown' , 0, '1:7', 20, 'Blaze' , 'Iron Fist', 6.2, 0.5 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 336 , 'Field', 'Dragon', 'Poison' , q'{Serpentine bodies}', 'Black' , 0, '1:1', 20, 'Shed Skin' , 'Infiltrator', 52.5, 2.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 769 , 'Amorphous' , 'Ghost', 'Ground', q'{Serpentine bodies}', 'Brown', 9, 9, 0, '1:1', 15, 'Water Compaction' , 'Sand Veil', 70, 0.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 737 , 'Bug' , 'Bug', 'Electric', q'{Serpentine bodies}', 'Green', 15, 15, 0, '1:1', 15, 'Battery' , 10.5, 0.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 291 , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'Yellow' , 0, '1:1', 15, 'Speed Boost' , 'Infiltrator', 12, 0.8 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 493, q'|Type: Dark|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'White' , 0, 'GU', 120, 'Multitype' , 320, 3.2 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 445 , 'Monster', 'Dragon', 'Dragon', 'Ground', q'{Bipedal, tailed form}', 'Blue' , 0, '1:1', 40, 'Sand Veil' , 'Rough Skin', 95, 1.9 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 369 , 'Water 1', 'Water 2', 'Water', 'Rock', q'{Fins}', 'Gray', 3, 3, 0, '1:7', 40, 'Swift Swim', 'Rock Head', 'Sturdy', 23.4, 1 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 131 , 'Monster', 'Water 1', 'Water', 'Ice', q'{Fins}', 'Blue', 3, 3, 0, '1:1', 40, 'Water Absorb', 'Shell Armor', 'Hydration', 220, 2.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 505 , 'Field' , 'Normal' , q'{Bipedal, tailed form}', 'Brown' , 0, '1:1', 20, 'Illuminate', 'Keen Eye', 'Analytic', 27, 1.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 529 , 'Field' , 'Ground' , q'{Bipedal, tailed form}', 'Gray' , 0, '1:1', 20, 'Sand Rush', 'Sand Force', 'Mold Breaker', 8.5, 0.3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 730 , 'Water 1', 'Field', 'Water', 'Fairy', q'{Fins}', 'Blue' , 0, '1:7', 15, 'Torrent' , 'Liquid Voice', 44, 1.8 );
insert into SPECIES( DEX, CLASS , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 25, q'|Pop Star|' , 'Field', 'Fairy', 'Electric' , q'{Quadruped body}', 'Yellow', 6, 6, 0, '1:1', 10, 'Static' , 'Lightning Rod', 6, 0.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 318 , 'Water 2' , 'Water', 'Dark', q'{Fins}', 'Red', 9, 9, 0, '1:1', 20, 'Rough Skin' , 'Speed Boost', 20.8, 0.8 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 79 , 'Monster', 'Water 1', 'Water', 'Psychic', q'{Quadruped body}', 'Pink', 9, 9, 0, '1:1', 20, 'Oblivious', 'Own Tempo', 'Regenerator', 36, 1.2 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 448 , 'Field', 'Human-Like', 'Fighting', 'Steel', q'{Bipedal, tailed form}', 'Blue', 0, 0, 0, '1:7', 25, 'Steadfast', 'Inner Focus', 'Justified', 54, 1.2 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 695 , 'Monster', 'Dragon', 'Electric', 'Normal', q'{Bipedal, tailed form}', 'Yellow' , 0, '1:1', 20, 'Dry Skin', 'Sand Veil', 'Solar Power', 21, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 785 , 'Undiscovered' , 'Electric', 'Fairy', q'{Head and arms}', 'Yellow' , 0, 'GU', 15, 'Electric Surge' , 'Telepathy', 20.5, 1.8 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 398 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Brown' , 0, '1:1', 15, 'Intimidate' , 'Reckless', 24.9, 1.2 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 181 , 'Monster', 'Field', 'Electric' , q'{Bipedal, tailed form}', 'Yellow' , 0, '1:1', 20, 'Static' , 'Plus', 61.5, 1.4 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 305 , 'Monster' , 'Steel', 'Rock', q'{Quadruped body}', 'Gray' , 0, '1:1', 35, 'Sturdy', 'Rock Head', 'Heavy Metal', 120, 0.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 282 , 'Amorphous' , 'Psychic', 'Fairy', q'{Bipedal, tailless form}', 'White' , 0, '1:1', 20, 'Synchronize', 'Trace', 'Telepathy', 48.4, 1.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 168 , 'Bug' , 'Bug', 'Poison', q'{Insectoid body}', 'Red', 6, 6, 0, '1:1', 15, 'Swarm', 'Insomnia', 'Sniper', 33.5, 1.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 77 , 'Field' , 'Fire' , q'{Quadruped body}', 'Yellow' , 0, '1:1', 20, 'Run Away', 'Flash Fire', 'Flame Body', 30, 1 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 773, q'|Type: Poison|' , 'Undiscovered' , 'Normal' , q'{Quadruped body}', 'Gray' , 0, 'GU', 120, 'RKS System' , 100.5, 2.3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 25, q'|Kalos Cap|' , 'Field', 'Fairy', 'Electric' , q'{Quadruped body}', 'Yellow', 6, 6, 0, '1:1', 10, 'Static' , 'Lightning Rod', 6, 0.4 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 149 , 'Water 1', 'Dragon', 'Dragon', 'Flying', q'{Bipedal, tailed form}', 'Brown', 0, 0, 0, '1:1', 40, 'Inner Focus' , 'Multiscale', 210, 2.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 754 , 'Grass' , 'Grass' , q'{Bipedal, tailless form}', 'Pink', 3, 3, 0, '1:1', 20, 'Leaf Guard' , 'Contrary', 18.5, 0.9 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 57 , 'Field' , 'Fighting' , q'{Bipedal, tailed form}', 'Brown', 6, 6, 2, '1:1', 20, 'Vital Spirit', 'Anger Point', 'Defiant', 32, 1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 739 , 'Water 3' , 'Fighting' , q'{Insectoid body}', 'Purple', 9, 9, 0, '1:1', 20, 'Hyper Cutter', 'Iron Fist', 'Anger Point', 7, 0.6 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 413, q'|Trash Cloak|', 'S' , 'Bug' , 'Bug', 'Steel', q'{Head and a base}', 'Red' , 0, '1:0', 15, 'Anticipation' , 'Overcoat', 6.5, 0.5 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 160 , 'Monster', 'Water 1', 'Water' , q'{Bipedal, tailed form}', 'Blue' , 0, '1:7', 20, 'Torrent' , 'Sheer Force', 88.8, 2.3 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 666, q'|Tundra Pattern|' , 'Bug' , 'Bug', 'Flying', q'{Two or more pairs of wings}', 'White' , 0, '1:1', 15, 'Shield Dust', 'Compound Eyes', 'Friend Guard', 17, 1.2 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 670, q'|Eternal Flower|' , 'Fairy' , 'Fairy' , q'{Head and arms}', 'White' , 0, 0, '1:0', 20, 'Flower Veil' , 'Symbiosis', 0.9, 0.2 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 364 , 'Water 1', 'Field', 'Ice', 'Water', q'{Fins}', 'Blue' , 2, '1:1', 20, 'Thick Fat', 'Ice Body', 'Oblivious', 87.6, 1.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 200 , 'Amorphous' , 'Ghost' , q'{Head}', 'Gray', 9, 9, 0, '1:1', 25, 'Levitate' , 1, 0.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 50 , 'Field' , 'Ground' , q'{Head and a base}', 'Brown', 9, 9, 0, '1:1', 20, 'Sand Veil', 'Arena Trap', 'Sand Force', 0.8, 0.2 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 223 , 'Water 1', 'Water 2', 'Water' , q'{Fins}', 'Gray' , 3, 2, '1:1', 20, 'Hustle', 'Sniper', 'Moody', 12, 0.6 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 636 , 'Bug' , 'Bug', 'Fire', q'{Insectoid body}', 'White' , 3, 0, '1:1', 40, 'Flame Body' , 'Swarm', 28.8, 1.1 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 673 , 'Field' , 'Grass' , q'{Quadruped body}', 'Brown' , 0, '1:1', 20, 'Sap Sipper' , 'Grass Pelt', 91, 1.7 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 536 , 'Water 1' , 'Water', 'Ground', q'{Bipedal, tailed form}', 'Blue' , 0, '1:1', 20, 'Swift Swim', 'Hydration', 'Water Absorb', 17, 0.8 );
insert into SPECIES( DEX, CLASS, DEX_SUFFIX, ITEM, EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , WEIGHTKG, HEIGHT_M )
values( 115, q'|Mega|', 'M', q'|Kangaskhanite|', 'Monster' , 'Normal' , q'{Bipedal, tailed form}', 'Brown', 3, 3, 0, '1:0', 20, 'Parental Bond' , 80, 2.2 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 731 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'Black', 15, 15, 0, '1:1', 15, 'Keen Eye', 'Skill Link', 'Pickup', 1.2, 0.3 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 627 , 'Flying' , 'Normal', 'Flying', q'{Single pair of wings}', 'White', 9, 9, 0, '0:1', 20, 'Keen Eye', 'Sheer Force', 'Hustle', 10.5, 0.5 );
insert into SPECIES( DEX , EGGGROUP1 , TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 119 , 'Water 2' , 'Water' , q'{Fins}', 'Red', 6, 6, 0, '1:1', 20, 'Swift Swim', 'Water Veil', 'Lightning Rod', 39, 1.3 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE , BODY, COLOR, CALL_RATE_SM, CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 594 , 'Water 1', 'Water 2', 'Water' , q'{Fins}', 'Pink', 6, 6, 0, '1:1', 40, 'Healer', 'Hydration', 'Regenerator', 31.6, 1.2 );
insert into SPECIES( DEX , EGGGROUP1, EGGGROUP2, TYPE, TYPE2, BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 342 , 'Water 1', 'Water 3', 'Water', 'Dark', q'{Insectoid body}', 'Red' , 6, 0, '1:1', 15, 'Hyper Cutter', 'Shell Armor', 'Adaptability', 32.8, 1.1 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE , BODY, COLOR , CALL_RATE_USUM, STAR, GENDER_RATIO, CYCLES, ABILITY1 , HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 669, q'|Yellow Flower|' , 'Fairy' , 'Fairy' , q'{Head and arms}', 'White' , 15, 0, '1:0', 20, 'Flower Veil' , 'Symbiosis', 0.1, 0.1 );
insert into SPECIES( DEX, CLASS , EGGGROUP1 , TYPE, TYPE2, BODY, COLOR , STAR, GENDER_RATIO, CYCLES, ABILITY1, ABILITY2, HIDDEN_ABILITY, WEIGHTKG, HEIGHT_M )
values( 711, q'|Large Size|' , 'Amorphous' , 'Ghost', 'Grass', q'{Head and a base}', 'Brown' , 0, '1:1', 20, 'Pickup', 'Frisk', 'Insomnia', 14, 1.1 );