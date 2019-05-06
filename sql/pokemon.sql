create table POKEMON(
NAME nvarchar2(100) not null, --Name of the Pokemon
DEX number(4,0) default on null 0 primary key CONSTRAINT ck_DEX_PosZero check(DEX>=0), --Pokedex number of the Pokemon
PAGE number(2,0) check(PAGE>=0), --The page the Pokemon appers in it's habitat
HABITAT varchar2(40) , --The primary habitat of the species
LDEX number(3,0) CONSTRAINT ck_LDEX_PosZero check(LDEX>=0), --The local Pokedex number of the Pokemon
LDEX_SUFFIX varchar2(2 byte) CONSTRAINT ck_LDEX_SUFFIX_Cap check(regexp_like(ldex_suffix, '[A-Z][a-zA-Z]?')), --Local Pokedex Suffix
GEN number(1,0) references GENERATION(GEN) check(gen>0), --The generation of the pokemon
IQ_GROUP char(1) , --The IQ Group of the pokemon
CONSTRAINT un_POKEMON unique(Name, Dex) --Enforce that Name and Dex are unique
);

insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Reshiram]', 643 , 149 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Tapu Koko]', 785 , 285 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Chatot]', 441 , 102 , 4, 'B' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Jynx]', 124, 6, q'|Urban|', 124 , 1, 'G' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Tapu Bulu]', 787 , 287 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Castform]', 351, 22, q'|Grassland|', 142 , 3, 'G' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Skrelp]', 690 , 30, 'Co', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Zeraora]', 807 , 403 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Camerupt]', 323, 6, q'|Mountain|', 102 , 3, 'E' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Magby]', 240, 10, q'|Mountain|', 152 , 2, 'C' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Guzzlord]', 799 , 299 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Vikavolt]', 738 , 29 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Baltoy]', 343, 8, q'|Rough-terrain|', 131 , 3, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Skitty]', 300, 17, q'|Forest|', 61 , 3, 'G' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Golett]', 622 , 128 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Poliwag]', 60, 7, q'|Water's-edge|', 60 , 1, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Jigglypuff]', 39, 10, q'|Grassland|', 39 , 1, 'B' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Koffing]', 109, 2, q'|Urban|', 109 , 1, 'E' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Lairon]', 305, 11, q'|Mountain|', 71 , 3, 'E' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Regice]', 378, 10, q'|Cave|', 194 , 3, 'E' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Mandibuzz]', 630 , 136 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Thundurus]', 642 , 148 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Skorupi]', 451 , 127 , 4, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Pikachu]', 25, 7, q'|Forest|', 25 , 1, 'D' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Patrat]', 504 , 10 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Arbok]', 24, 9, q'|Grassland|', 24 , 1, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Squirtle]', 7, 13, q'|Water's-edge|', 7 , 1, 'E' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Stakataka]', 805 , 392 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Fomantis]', 753 , 143 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Giratina]', 487 , 210 , 4, 'C' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Tangrowth]', 465 , 182 , 4, 'G' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Whirlipede]', 544 , 50 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Totodile]', 158, 14, q'|Water's-edge|', 7 , 2, 'E' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Gothorita]', 575 , 81 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Zebstrika]', 523 , 29 , 5 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Pumpkaboo]', 710 , 63, 'Mo', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Lunala]', 792 , 292 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Doduo]', 84, 5, q'|Grassland|', 84 , 1, 'D' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Cacnea]', 331, 5, q'|Rough-terrain|', 119 , 3, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Magneton]', 82, 3, q'|Rough-terrain|', 82 , 1, 'A' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Poochyena]', 261, 2, q'|Grassland|', 10 , 3, 'D' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Smeargle]', 235, 6, q'|Urban|', 159 , 2, 'F' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Sewaddle]', 540 , 46 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Lugia]', 249, 3, q'|Rare|', 252 , 2, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Persian]', 53, 1, q'|Urban|', 53 , 1, 'G' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Slaking]', 289, 16, q'|Forest|', 38 , 3, 'C' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Litwick]', 607 , 113 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Cottonee]', 546 , 52 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Seel]', 86, 8, q'|Sea|', 86 , 1, 'H' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Mankey]', 56, 2, q'|Mountain|', 56 , 1, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Geodude]', 74, 1, q'|Mountain|', 74 , 1, 'E' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Marshadow]', 802 , 302 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Beautifly]', 267, 3, q'|Forest|', 16 , 3, 'A' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Palkia]', 484 , 150 , 4, 'J' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Silvally]', 773 , 204 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Corphish]', 341, 3, q'|Water's-edge|', 129 , 3, 'B' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Rhyperior]', 464 , 188 , 4, 'E' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Vanillish]', 583 , 89 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Altaria]', 334, 22, q'|Forest|', 122 , 3, 'H' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Shinx]', 403 , 17 , 4, 'C' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Charjabug]', 737 , 28 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Armaldo]', 348, 11, q'|Water's-edge|', 136 , 3, 'E' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Avalugg]', 713 , 80, 'Mo', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Absol]', 359, 14, q'|Mountain|', 152 , 3, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Snorunt]', 361, 3, q'|Cave|', 171 , 3, 'A' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Chingling]', 433 , 82 , 4, 'B' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Shuckle]', 213, 8, q'|Mountain|', 168 , 2, 'E' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Eelektrik]', 603 , 109 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Octillery]', 224, 4, q'|Sea|', 175 , 2, 'C' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Goomy]', 704 , 19, 'Mo', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Blastoise]', 9, 13, q'|Water's-edge|', 9 , 1, 'E' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Rhyhorn]', 111, 2, q'|Rough-terrain|', 111 , 1, 'E' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Houndoom]', 229, 4, q'|Rough-terrain|', 215 , 2, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Electrike]', 309, 18, q'|Grassland|', 78 , 3, 'F' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Yveltal]', 717 , 149, 'Mo', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Emolga]', 587 , 93 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Ambipom]', 424 , 64 , 4, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Registeel]', 379, 10, q'|Cave|', 195 , 3, 'E' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Palossand]', 770 , 187 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Makuhita]', 296, 7, q'|Mountain|', 48 , 3, 'E' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Yanma]', 193, 11, q'|Forest|', 101 , 2, 'D' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Omanyte]', 138, 14, q'|Sea|', 138 , 1, 'E' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Cleffa]', 173, 4, q'|Mountain|', 40 , 2, 'B' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Mudbray]', 749 , 132 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Glalie]', 362, 3, q'|Cave|', 172 , 3, 'A' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Infernape]', 392 , 6 , 4, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Girafarig]', 203, 15, q'|Grassland|', 149 , 2, 'F' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Salazzle]', 758 , 162 , 7 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Frogadier]', 657 , 8, 'Ce', 6 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Slurpuff]', 685 , 132, 'Ce', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Tentacruel]', 73, 1, q'|Sea|', 73 , 1, 'C' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Carnivine]', 455 , 131 , 4, 'A' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Oddish]', 43, 8, q'|Grassland|', 43 , 1, 'B' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Dratini]', 147, 12, q'|Water's-edge|', 147 , 1, 'D' );
insert into POKEMON( NAME, DEX , GEN, IQ_GROUP )
values( nq'[Shaymin]', 492 , 4, 'A' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Snorlax]', 143, 13, q'|Mountain|', 143 , 1, 'E' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Grimer]', 88, 2, q'|Urban|', 88 , 1, 'G' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Wynaut]', 360, 8, q'|Cave|', 160 , 3, 'E' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Cacturne]', 332, 5, q'|Rough-terrain|', 120 , 3, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Gyarados]', 130, 2, q'|Water's-edge|', 130 , 1, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Elekid]', 239, 18, q'|Grassland|', 156 , 2, 'C' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Servine]', 496 , 2 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Dewpider]', 751 , 141 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Kirlia]', 281, 5, q'|Urban|', 30 , 3, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Salamence]', 373, 9, q'|Rough-terrain|', 189 , 3, 'E' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Togedemaru]', 777 , 225 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Shelgon]', 372, 9, q'|Rough-terrain|', 188 , 3, 'E' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Ampharos]', 181, 11, q'|Grassland|', 55 , 2, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Gengar]', 94, 7, q'|Cave|', 94 , 1, 'G' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Lotad]', 270, 4, q'|Water's-edge|', 19 , 3, 'G' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Charmander]', 4, 16, q'|Mountain|', 4 , 1, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Roselia]', 315, 6, q'|Grassland|', 94 , 3, 'H' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Combee]', 415 , 53 , 4, 'A' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Spheal]', 363, 9, q'|Sea|', 173 , 3, 'E' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Whismur]', 293, 4, q'|Cave|', 45 , 3, 'B' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Surskit]', 283, 5, q'|Water's-edge|', 32 , 3, 'D' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Kricketot]', 401 , 15 , 4, 'G' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Fearow]', 22, 1, q'|Rough-terrain|', 22 , 1, 'D' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Nidoqueen]', 31, 3, q'|Grassland|', 31 , 1, 'C' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Pawniard]', 624 , 130 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Pupitar]', 247, 12, q'|Mountain|', 250 , 2, 'C' );
insert into POKEMON( NAME, DEX , GEN, IQ_GROUP )
values( nq'[Regigigas]', 486 , 4, 'E' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Numel]', 322, 6, q'|Mountain|', 101 , 3, 'E' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Sneasel]', 215, 18, q'|Forest|', 218 , 2, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Houndour]', 228, 4, q'|Rough-terrain|', 214 , 2, 'C' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Gallade]', 475 , 160 , 4, 'F' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Stunky]', 434 , 84 , 4, 'G' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Cutiefly]', 742 , 83 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Pikipek]', 731 , 10 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Porygon-Z]', 474 , 194 , 4, 'E' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Blitzle]', 522 , 28 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Oranguru]', 765 , 176 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Tapu Fini]', 788 , 288 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Blaziken]', 257, 26, q'|Grassland|', 6 , 3, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Sandslash]', 28, 2, q'|Rough-terrain|', 28 , 1, 'D' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Raichu]', 26, 7, q'|Forest|', 26 , 1, 'D' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Wingull]', 278, 2, q'|Sea|', 27 , 3, 'D' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Gastly]', 92, 7, q'|Cave|', 92 , 1, 'G' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Nidoking]', 34, 4, q'|Grassland|', 34 , 1, 'C' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Bergmite]', 712 , 79, 'Mo', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Lampent]', 608 , 114 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Treecko]', 252, 25, q'|Forest|', 1 , 3, 'D' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Noibat]', 714 , 113, 'Mo', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Horsea]', 116, 11, q'|Sea|', 116 , 1, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Weedle]', 13, 2, q'|Forest|', 13 , 1, 'A' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Crustle]', 558 , 64 , 5 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Spritzee]', 682 , 129, 'Ce', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Grumpig]', 326, 2, q'|Mountain|', 111 , 3, 'F' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Simipour]', 516 , 22 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Jirachi]', 385, 17, q'|Mountain|', 201 , 3, 'B' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Larvesta]', 636 , 142 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Suicune]', 245, 27, q'|Grassland|', 245 , 2, 'D' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Marowak]', 105, 5, q'|Mountain|', 105 , 1, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Scyther]', 123, 13, q'|Grassland|', 123 , 1, 'D' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Claydol]', 344, 8, q'|Rough-terrain|', 132 , 3, 'F' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Monferno]', 391 , 5 , 4, 'C' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Amaura]', 698 , 66, 'Co', 6 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Gourgeist]', 711 , 64, 'Mo', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Marshtomp]', 259, 15, q'|Water's-edge|', 8 , 3, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Sandshrew]', 27, 2, q'|Rough-terrain|', 27 , 1, 'D' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Fennekin]', 653 , 4, 'Ce', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Garbodor]', 569 , 75 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Elgyem]', 605 , 111 , 5 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Froakie]', 656 , 7, 'Ce', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Bellsprout]', 69, 8, q'|Forest|', 69 , 1, 'G' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Vibrava]', 329, 6, q'|Rough-terrain|', 117 , 3, 'D' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Purrloin]', 509 , 15 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Golduck]', 55, 6, q'|Water's-edge|', 55 , 1, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Mightyena]', 262, 2, q'|Grassland|', 11 , 3, 'D' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Goodra]', 706 , 21, 'Mo', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Vullaby]', 629 , 135 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Pidgey]', 16, 5, q'|Forest|', 16 , 1, 'D' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Drapion]', 452 , 128 , 4, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Pinsir]', 127, 21, q'|Forest|', 127 , 1, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Rapidash]', 78, 17, q'|Grassland|', 78 , 1, 'D' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Unown]', 201, 1, q'|Rare|', 61 , 2, 'A' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Swalot]', 317, 14, q'|Grassland|', 96 , 3, 'G' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Toxapex]', 748 , 114 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Drowzee]', 96, 14, q'|Grassland|', 96 , 1, 'F' );
insert into POKEMON( NAME, DEX , GEN, IQ_GROUP )
values( nq'[Cresselia]', 488 , 4, 'H' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Vespiquen]', 416 , 54 , 4, 'A' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Wooper]', 194, 6, q'|Water's-edge|', 56 , 2, 'G' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Cradily]', 346, 15, q'|Sea|', 134 , 3, 'F' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Bibarel]', 400 , 14 , 4, 'F' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Yungoos]', 734 , 13 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Meloetta]', 648 , 154 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Lunatone]', 337, 9, q'|Cave|', 125 , 3, 'F' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Buizel]', 418 , 56 , 4, 'F' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Bronzong]', 437 , 89 , 4, 'E' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Kingdra]', 230, 11, q'|Sea|', 192 , 2, 'C' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Pachirisu]', 417 , 55 , 4, 'B' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Watchog]', 505 , 11 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Samurott]', 503 , 9 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Budew]', 406 , 25 , 4, 'H' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Roggenrola]', 524 , 30 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Serperior]', 497 , 3 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Kingler]', 99, 2, q'|Water's-edge|', 99 , 1, 'B' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Skarmory]', 227, 7, q'|Rough-terrain|', 203 , 2, 'C' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Staravia]', 397 , 11 , 4, 'D' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Wigglytuff]', 40, 10, q'|Grassland|', 40 , 1, 'B' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Abomasnow]', 460 , 143 , 4, 'E' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Naganadel]', 804 , 262 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Lumineon]', 457 , 135 , 4, 'A' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Leafeon]', 470 , 169 , 4, 'F' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Shiinotic]', 756 , 146 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Walrein]', 365, 9, q'|Sea|', 175 , 3, 'E' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Spiritomb]', 442 , 108 , 4, 'G' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Tympole]', 535 , 41 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Gligar]', 207, 9, q'|Mountain|', 193 , 2, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Volbeat]', 313, 14, q'|Forest|', 86 , 3, 'F' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Skiddo]', 672 , 89, 'Ce', 6 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Trevenant]', 709 , 62, 'Mo', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Kabuto]', 140, 14, q'|Sea|', 140 , 1, 'E' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Krokorok]', 552 , 58 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Kecleon]', 352, 20, q'|Forest|', 145 , 3, 'G' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Celesteela]', 797 , 297 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Leavanny]', 542 , 48 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Shelmet]', 616 , 122 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Carvanha]', 318, 10, q'|Sea|', 97 , 3, 'G' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Gigalith]', 526 , 32 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Croagunk]', 453 , 129 , 4, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Miltank]', 241, 16, q'|Grassland|', 151 , 2, 'H' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Raticate]', 20, 1, q'|Grassland|', 20 , 1, 'F' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Sylveon]', 700 , 85, 'Co', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Bouffalant]', 626 , 132 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Bisharp]', 625 , 131 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Hitmontop]', 237, 7, q'|Urban|', 148 , 2, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Psyduck]', 54, 6, q'|Water's-edge|', 54 , 1, 'C' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Klinklang]', 601 , 107 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Mewtwo]', 150, 7, q'|Rare|', 150 , 1, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Cascoon]', 268, 4, q'|Forest|', 17 , 3, 'A' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Bulbasaur]', 1, 23, q'|Grassland|', 1 , 1, 'F' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Incineroar]', 727 , 6 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Furret]', 162, 1, q'|Grassland|', 20 , 2, 'D' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Solgaleo]', 791 , 291 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Glameow]', 431 , 76 , 4, 'G' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Kyurem]', 646 , 152 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Axew]', 610 , 116 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Quilava]', 156, 25, q'|Grassland|', 5 , 2, 'C' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Trumbeak]', 732 , 11 , 7 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Aromatisse]', 683 , 130, 'Ce', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Deoxys]', 386, 6, q'|Rare|', 202 , 3, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Exeggutor]', 103, 19, q'|Forest|', 103 , 1, 'B' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Barbaracle]', 689 , 22, 'Co', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Exeggcute]', 102, 19, q'|Forest|', 102 , 1, 'B' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Ivysaur]', 2, 23, q'|Grassland|', 2 , 1, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Tentacool]', 72, 1, q'|Sea|', 72 , 1, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Dodrio]', 85, 5, q'|Grassland|', 85 , 1, 'D' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Muk]', 89, 2, q'|Urban|', 89 , 1, 'G' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Pichu]', 172, 7, q'|Forest|', 21 , 2, 'D' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Hoppip]', 187, 7, q'|Grassland|', 67 , 2, 'H' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Entei]', 244, 27, q'|Grassland|', 244 , 2, 'D' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Carracosta]', 565 , 71 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Throh]', 538 , 44 , 5 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Aurorus]', 699 , 67, 'Co', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Minior]', 774 , 213 , 7 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Clawitzer]', 693 , 33, 'Co', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Bellossom]', 182, 8, q'|Grassland|', 86 , 2, 'B' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Mimikyu]', 778 , 242 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Paras]', 46, 9, q'|Forest|', 46 , 1, 'A' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Bagon]', 371, 9, q'|Rough-terrain|', 187 , 3, 'E' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Scizor]', 212, 13, q'|Grassland|', 112 , 2, 'D' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Wobbuffet]', 202, 8, q'|Cave|', 108 , 2, 'E' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Crawdaunt]', 342, 3, q'|Water's-edge|', 130 , 3, 'B' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Alomomola]', 594 , 100 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Magcargo]', 219, 6, q'|Mountain|', 217 , 2, 'E' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Electivire]', 466 , 199 , 4, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Ekans]', 23, 9, q'|Grassland|', 23 , 1, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Rayquaza]', 384, 5, q'|Rare|', 200 , 3, 'D' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Shellos]', 422 , 60 , 4, 'E' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Florges]', 671 , 70, 'Ce', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Golbat]', 42, 1, q'|Cave|', 42 , 1, 'D' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Luvdisc]', 370, 7, q'|Sea|', 183 , 3, 'D' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Furfrou]', 676 , 93, 'Ce', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Jangmo-o]', 782 , 271 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Archen]', 566 , 72 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Wartortle]', 8, 13, q'|Water's-edge|', 8 , 1, 'E' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Tornadus]', 641 , 147 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Cherubi]', 420 , 58 , 4, 'B' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Heatmor]', 631 , 137 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Primarina]', 730 , 9 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Rattata]', 19, 1, q'|Grassland|', 19 , 1, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Hypno]', 97, 14, q'|Grassland|', 97 , 1, 'F' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Buneary]', 427 , 67 , 4, 'D' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Staraptor]', 398 , 12 , 4, 'D' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Haxorus]', 612 , 118 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Shroomish]', 285, 9, q'|Forest|', 34 , 3, 'C' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Skuntank]', 435 , 85 , 4, 'G' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Seismitoad]', 537 , 43 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Dusknoir]', 477 , 191 , 4, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Milotic]', 350, 10, q'|Water's-edge|', 141 , 3, 'H' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Banette]', 354, 3, q'|Urban|', 147 , 3, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Igglybuff]', 174, 10, q'|Grassland|', 44 , 2, 'B' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Basculin]', 550 , 56 , 5 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Bunnelby]', 659 , 10, 'Ce', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Durant]', 632 , 138 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Gliscor]', 472 , 154 , 4, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Meditite]', 307, 7, q'|Mountain|', 76 , 3, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Duskull]', 355, 23, q'|Forest|', 148 , 3, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Vaporeon]', 134, 11, q'|Urban|', 134 , 1, 'F' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Rampardos]', 409 , 37 , 4, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Nosepass]', 299, 5, q'|Cave|', 60 , 3, 'E' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Helioptile]', 694 , 46, 'Co', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Scraggy]', 559 , 65 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Crabominable]', 740 , 60 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Beedrill]', 15, 2, q'|Forest|', 15 , 1, 'A' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Mienfoo]', 619 , 125 , 5 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Braixen]', 654 , 5, 'Ce', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Trapinch]', 328, 6, q'|Rough-terrain|', 116 , 3, 'D' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Timburr]', 532 , 38 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Zorua]', 570 , 76 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Dewott]', 502 , 8 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Growlithe]', 58, 21, q'|Grassland|', 58 , 1, 'C' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Tyrantrum]', 697 , 65, 'Co', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Ponyta]', 77, 17, q'|Grassland|', 77 , 1, 'D' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Stantler]', 234, 20, q'|Forest|', 131 , 2, 'G' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Malamar]', 687 , 11, 'Co', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Ho-Oh]', 250, 4, q'|Rare|', 253 , 2, 'D' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Azumarill]', 184, 8, q'|Water's-edge|', 133 , 2, 'D' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Goldeen]', 118, 1, q'|Water's-edge|', 118 , 1, 'A' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Whimsicott]', 547 , 53 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Excadrill]', 530 , 36 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Mime Jr.]', 439 , 94 , 4, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Ariados]', 168, 12, q'|Forest|', 33 , 2, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Staryu]', 120, 3, q'|Sea|', 120 , 1, 'C' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Oshawott]', 501 , 7 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Lilligant]', 549 , 55 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Medicham]', 308, 7, q'|Mountain|', 77 , 3, 'C' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Wimpod]', 767 , 182 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Parasect]', 47, 9, q'|Forest|', 47 , 1, 'A' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Nincada]', 290, 13, q'|Forest|', 42 , 3, 'D' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Tynamo]', 602 , 108 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Happiny]', 440 , 96 , 4, 'H' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Ursaring]', 217, 8, q'|Mountain|', 199 , 2, 'B' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Pangoro]', 675 , 92, 'Ce', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Sceptile]', 254, 25, q'|Forest|', 3 , 3, 'D' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Cubchoo]', 613 , 119 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Yamask]', 562 , 68 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Chandelure]', 609 , 115 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Swampert]', 260, 15, q'|Water's-edge|', 9 , 3, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Grovyle]', 253, 25, q'|Forest|', 2 , 3, 'D' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Bonsly]', 438 , 92 , 4, 'E' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Popplio]', 728 , 7 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Misdreavus]', 200, 5, q'|Cave|', 219 , 2, 'G' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Sealeo]', 364, 9, q'|Sea|', 174 , 3, 'E' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Spearow]', 21, 1, q'|Rough-terrain|', 21 , 1, 'D' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Butterfree]', 12, 1, q'|Forest|', 12 , 1, 'A' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Klang]', 600 , 106 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Charmeleon]', 5, 16, q'|Mountain|', 5 , 1, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Kakuna]', 14, 2, q'|Forest|', 14 , 1, 'A' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Hitmonlee]', 106, 7, q'|Urban|', 106 , 1, 'C' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Cranidos]', 408 , 36 , 4, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Ledyba]', 165, 12, q'|Forest|', 30 , 2, 'F' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Pignite]', 499 , 5 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Feraligatr]', 160, 14, q'|Water's-edge|', 9 , 2, 'E' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Swadloon]', 541 , 47 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Mothim]', 414 , 47 , 4, 'G' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Hakamo-o]', 783 , 272 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Skiploom]', 188, 7, q'|Grassland|', 68 , 2, 'H' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Mudsdale]', 750 , 133 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Lurantis]', 754 , 144 , 7 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Flabébé]', 669 , 68, 'Ce', 6 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Xerneas]', 716 , 148, 'Mo', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Illumise]', 314, 14, q'|Forest|', 87 , 3, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Larvitar]', 246, 12, q'|Mountain|', 249 , 2, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Murkrow]', 198, 18, q'|Forest|', 213 , 2, 'D' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Aerodactyl]', 142, 15, q'|Mountain|', 142 , 1, 'D' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Weavile]', 461 , 145 , 4, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Seedot]', 273, 10, q'|Forest|', 22 , 3, 'C' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Beartic]', 614 , 120 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Porygon]', 137, 9, q'|Urban|', 137 , 1, 'E' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Swirlix]', 684 , 131, 'Ce', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Manaphy]', 490 , 151 , 4, 'B' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Boldore]', 525 , 31 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Haunter]', 93, 7, q'|Cave|', 93 , 1, 'G' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Nidoran♀]', 29, 3, q'|Grassland|', 29 , 1, 'C' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Gurdurr]', 533 , 39 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Victini]', 494 , 0 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Brionne]', 729 , 8 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Piloswine]', 221, 3, q'|Cave|', 196 , 2, 'A' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Venonat]', 48, 11, q'|Forest|', 48 , 1, 'A' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Steenee]', 762 , 172 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Torchic]', 255, 26, q'|Grassland|', 4 , 3, 'C' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Dhelmise]', 781 , 263 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Kangaskhan]', 115, 15, q'|Grassland|', 115 , 1, 'B' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Stoutland]', 508 , 14 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Beldum]', 374, 10, q'|Rough-terrain|', 190 , 3, 'E' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Grotle]', 388 , 2 , 4, 'E' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Bidoof]', 399 , 13 , 4, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Mr. Mime]', 122, 6, q'|Urban|', 122 , 1, 'F' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Cherrim]', 421 , 59 , 4, 'B' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Charizard]', 6, 16, q'|Mountain|', 6 , 1, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Rhydon]', 112, 2, q'|Rough-terrain|', 112 , 1, 'E' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Seadra]', 117, 11, q'|Sea|', 117 , 1, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Marill]', 183, 8, q'|Water's-edge|', 132 , 2, 'D' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Phanpy]', 231, 4, q'|Rough-terrain|', 200 , 2, 'E' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Tyrogue]', 236, 7, q'|Urban|', 145 , 2, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Plusle]', 311, 20, q'|Grassland|', 80 , 3, 'B' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Araquanid]', 752 , 142 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Azurill]', 298, 8, q'|Water's-edge|', 54 , 3, 'D' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Salandit]', 757 , 161 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Taillow]', 276, 5, q'|Grassland|', 25 , 3, 'D' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Hippowdon]', 450 , 123 , 4, 'E' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Turtwig]', 387 , 1 , 4, 'E' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Drilbur]', 529 , 35 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Eelektross]', 604 , 110 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Mesprit]', 481 , 147 , 4, 'G' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Fletchling]', 661 , 14, 'Ce', 6 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Binacle]', 688 , 21, 'Co', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Litten]', 725 , 4 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Krookodile]', 553 , 59 , 5 );
insert into POKEMON( NAME, DEX , GEN )
values( nq'[Arceus]', 493 , 4 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Seviper]', 336, 19, q'|Grassland|', 124 , 3, 'C' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Trubbish]', 568 , 74 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Wishiwashi]', 746 , 110 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Terrakion]', 639 , 145 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Keldeo]', 647 , 153 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Sigilyph]', 561 , 67 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Weezing]', 110, 2, q'|Urban|', 110 , 1, 'E' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Articuno]', 144, 2, q'|Rare|', 144 , 1, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Slugma]', 218, 6, q'|Mountain|', 216 , 2, 'E' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Braviary]', 628 , 134 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Omastar]', 139, 14, q'|Sea|', 139 , 1, 'E' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Umbreon]', 197, 12, q'|Urban|', 189 , 2, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Swellow]', 277, 5, q'|Grassland|', 26 , 3, 'D' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Mienshao]', 620 , 126 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Pidgeot]', 18, 5, q'|Forest|', 18 , 1, 'D' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Nuzleaf]', 274, 10, q'|Forest|', 23 , 3, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Aipom]', 190, 20, q'|Forest|', 123 , 2, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Politoed]', 186, 7, q'|Water's-edge|', 75 , 2, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Aggron]', 306, 11, q'|Mountain|', 72 , 3, 'E' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Zangoose]', 335, 19, q'|Grassland|', 123 , 3, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Sunkern]', 191, 6, q'|Grassland|', 103 , 2, 'B' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Escavalier]', 589 , 95 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Bounsweet]', 761 , 171 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Conkeldurr]', 534 , 40 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Tauros]', 128, 16, q'|Grassland|', 128 , 1, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Regirock]', 377, 10, q'|Cave|', 193 , 3, 'E' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Smoochum]', 238, 6, q'|Urban|', 154 , 2, 'G' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Gible]', 443 , 109 , 4, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Sudowoodo]', 185, 19, q'|Forest|', 107 , 2, 'E' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Magnezone]', 462 , 180 , 4, 'A' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Xatu]', 178, 6, q'|Forest|', 162 , 2, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Jumpluff]', 189, 7, q'|Grassland|', 69 , 2, 'H' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Crobat]', 169, 1, q'|Cave|', 39 , 2, 'D' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Primeape]', 57, 2, q'|Mountain|', 57 , 1, 'C' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Lickilicky]', 463 , 162 , 4, 'G' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Alakazam]', 65, 4, q'|Urban|', 65 , 1, 'F' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Glaceon]', 471 , 170 , 4, 'F' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Simisage]', 512 , 18 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Lillipup]', 506 , 12 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Garchomp]', 445 , 111 , 4, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Chansey]', 113, 8, q'|Urban|', 113 , 1, 'H' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Vigoroth]', 288, 16, q'|Forest|', 37 , 3, 'C' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Buzzwole]', 794 , 294 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Spinda]', 327, 9, q'|Mountain|', 114 , 3, 'G' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Clauncher]', 692 , 32, 'Co', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Amoonguss]', 591 , 97 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Gothitelle]', 576 , 82 , 5 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Noivern]', 715 , 114, 'Mo', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Flareon]', 136, 11, q'|Urban|', 136 , 1, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Dragonair]', 148, 12, q'|Water's-edge|', 148 , 1, 'D' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Sawk]', 539 , 45 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Landorus]', 645 , 151 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Chikorita]', 152, 24, q'|Grassland|', 1 , 2, 'H' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Chimecho]', 358, 22, q'|Grassland|', 151 , 3, 'B' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Aron]', 304, 11, q'|Mountain|', 70 , 3, 'E' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Galvantula]', 596 , 102 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Whiscash]', 340, 3, q'|Water's-edge|', 128 , 3, 'B' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Munchlax]', 446 , 112 , 4, 'E' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Exploud]', 295, 4, q'|Cave|', 47 , 3, 'B' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Tsareena]', 763 , 173 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Lapras]', 131, 13, q'|Sea|', 131 , 1, 'B' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Toxicroak]', 454 , 130 , 4, 'F' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Snover]', 459 , 142 , 4, 'E' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Abra]', 63, 4, q'|Urban|', 63 , 1, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Victreebel]', 71, 8, q'|Forest|', 71 , 1, 'G' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Clamperl]', 366, 6, q'|Sea|', 176 , 3, 'F' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Snivy]', 495 , 1 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Wormadam]', 413 , 46 , 4, 'G' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Bruxish]', 779 , 243 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Darmanitan]', 555 , 61 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Cloyster]', 91, 5, q'|Sea|', 91 , 1, 'E' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Torkoal]', 324, 10, q'|Mountain|', 105 , 3, 'E' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Shellder]', 90, 5, q'|Sea|', 90 , 1, 'E' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Maractus]', 556 , 62 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Nidorino]', 33, 4, q'|Grassland|', 33 , 1, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Raikou]', 243, 27, q'|Grassland|', 243 , 2, 'D' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Dunsparce]', 206, 5, q'|Cave|', 52 , 2, 'A' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Ducklett]', 580 , 86 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Gardevoir]', 282, 5, q'|Urban|', 31 , 3, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Krabby]', 98, 2, q'|Water's-edge|', 98 , 1, 'B' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Starmie]', 121, 3, q'|Sea|', 121 , 1, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Quagsire]', 195, 6, q'|Water's-edge|', 57 , 2, 'G' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Ninjask]', 291, 13, q'|Forest|', 43 , 3, 'D' );
insert into POKEMON( NAME, DEX , GEN, IQ_GROUP )
values( nq'[Darkrai]', 491 , 4, 'I' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Spinarak]', 167, 12, q'|Forest|', 32 , 2, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Tangela]', 114, 6, q'|Grassland|', 114 , 1, 'G' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Azelf]', 482 , 148 , 4, 'G' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Riolu]', 447 , 115 , 4, 'C' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Magearna]', 801 , 301 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Foongus]', 590 , 96 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Torterra]', 389 , 3 , 4, 'E' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Vanilluxe]', 584 , 90 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Pheromosa]', 795 , 295 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Cryogonal]', 615 , 121 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Petilil]', 548 , 54 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Mamoswine]', 473 , 205 , 4, 'A' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Sawsbuck]', 586 , 92 , 5 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Fletchinder]', 662 , 15, 'Ce', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Purugly]', 432 , 77 , 4, 'G' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Hoothoot]', 163, 6, q'|Forest|', 15 , 2, 'A' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Komala]', 775 , 222 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Emboar]', 500 , 6 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Mantine]', 226, 7, q'|Sea|', 202 , 2, 'H' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Archeops]', 567 , 73 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Machamp]', 68, 3, q'|Mountain|', 68 , 1, 'D' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Heracross]', 214, 21, q'|Forest|', 114 , 2, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Togepi]', 175, 24, q'|Forest|', 46 , 2, 'H' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Gorebyss]', 368, 6, q'|Sea|', 178 , 3, 'F' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Poipole]', 803 , 261 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Klink]', 599 , 105 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Clefable]', 36, 4, q'|Mountain|', 36 , 1, 'B' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Jolteon]', 135, 11, q'|Urban|', 135 , 1, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Metagross]', 376, 10, q'|Rough-terrain|', 192 , 3, 'E' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Stufful]', 759 , 169 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Gumshoos]', 735 , 14 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Cinccino]', 573 , 79 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Froslass]', 478 , 208 , 4, 'A' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Croconaw]', 159, 14, q'|Water's-edge|', 8 , 2, 'E' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Floette]', 670 , 69, 'Ce', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Snubbull]', 209, 1, q'|Urban|', 125 , 2, 'B' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Luxio]', 404 , 18 , 4, 'C' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Vivillon]', 666 , 22, 'Ce', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Qwilfish]', 211, 7, q'|Sea|', 163 , 2, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Ditto]', 132, 10, q'|Urban|', 132 , 1, 'A' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Scolipede]', 545 , 51 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Metang]', 375, 10, q'|Rough-terrain|', 191 , 3, 'E' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Reuniclus]', 579 , 85 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Rotom]', 479 , 152 , 4, 'G' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Tapu Lele]', 786 , 286 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Venipede]', 543 , 49 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Swanna]', 581 , 87 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Druddigon]', 621 , 127 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Oricorio]', 741 , 82 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Kadabra]', 64, 4, q'|Urban|', 64 , 1, 'F' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Dedenne]', 702 , 110, 'Co', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Chimchar]', 390 , 4 , 4, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Remoraid]', 223, 4, q'|Sea|', 174 , 2, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Sunflora]', 192, 6, q'|Grassland|', 104 , 2, 'B' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Lombre]', 271, 4, q'|Water's-edge|', 20 , 3, 'G' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Greninja]', 658 , 9, 'Ce', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Hydreigon]', 635 , 141 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Farfetch'd]', 83, 12, q'|Grassland|', 83 , 1, 'G' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Onix]', 95, 2, q'|Cave|', 95 , 1, 'E' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Kabutops]', 141, 14, q'|Sea|', 141 , 1, 'E' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Venusaur]', 3, 23, q'|Grassland|', 3 , 1, 'F' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Sandile]', 551 , 57 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Mantyke]', 458 , 140 , 4, 'H' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Weepinbell]', 70, 8, q'|Forest|', 70 , 1, 'G' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Pancham]', 674 , 91, 'Ce', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Roserade]', 407 , 27 , 4, 'H' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Panpour]', 515 , 21 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Wurmple]', 265, 3, q'|Forest|', 14 , 3, 'A' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Pyroar]', 668 , 58, 'Ce', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Shuppet]', 353, 3, q'|Urban|', 146 , 3, 'F' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Minccino]', 572 , 78 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Nidorina]', 30, 3, q'|Grassland|', 30 , 1, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Combusken]', 256, 26, q'|Grassland|', 5 , 3, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Noctowl]', 164, 6, q'|Forest|', 16 , 2, 'A' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Cyndaquil]', 155, 25, q'|Grassland|', 4 , 2, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Gulpin]', 316, 14, q'|Grassland|', 95 , 3, 'G' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Talonflame]', 663 , 16, 'Ce', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Tepig]', 498 , 4 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Bastiodon]', 411 , 39 , 4, 'E' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Latios]', 381, 16, q'|Water's-edge|', 197 , 3, 'D' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Starly]', 396 , 10 , 4, 'D' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Inkay]', 686 , 10, 'Co', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Simisear]', 514 , 20 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Rowlet]', 722 , 1 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Poliwrath]', 62, 7, q'|Water's-edge|', 62 , 1, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Flaaffy]', 180, 11, q'|Grassland|', 54 , 2, 'F' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Duosion]', 578 , 84 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Donphan]', 232, 4, q'|Rough-terrain|', 201 , 2, 'E' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Espurr]', 677 , 114, 'Ce', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Espeon]', 196, 12, q'|Urban|', 188 , 2, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Gloom]', 44, 8, q'|Grassland|', 44 , 1, 'B' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Sandygast]', 769 , 186 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Delcatty]', 301, 17, q'|Forest|', 62 , 3, 'G' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Ribombee]', 743 , 84 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Lanturn]', 171, 4, q'|Sea|', 177 , 2, 'A' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Audino]', 531 , 37 , 5 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Dragalge]', 691 , 31, 'Co', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Magikarp]', 129, 2, q'|Water's-edge|', 129 , 1, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Teddiursa]', 216, 8, q'|Mountain|', 198 , 2, 'B' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Electabuzz]', 125, 18, q'|Grassland|', 125 , 1, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Dragonite]', 149, 12, q'|Water's-edge|', 149 , 1, 'D' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Magmortar]', 467 , 202 , 4, 'C' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Delphox]', 655 , 6, 'Ce', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Woobat]', 527 , 33 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Solosis]', 577 , 83 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Honchkrow]', 430 , 75 , 4, 'D' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Huntail]', 367, 6, q'|Sea|', 177 , 3, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Graveler]', 75, 1, q'|Mountain|', 75 , 1, 'E' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Tyranitar]', 248, 12, q'|Mountain|', 251 , 2, 'C' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Tranquill]', 520 , 26 , 5 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Quilladin]', 651 , 2, 'Ce', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Poliwhirl]', 61, 7, q'|Water's-edge|', 61 , 1, 'F' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Blacephalon]', 806 , 393 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Loudred]', 294, 4, q'|Cave|', 46 , 3, 'B' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Zekrom]', 644 , 150 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Beheeyem]', 606 , 112 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Mew]', 151, 8, q'|Rare|', 151 , 1, 'H' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Turtonator]', 776 , 224 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Joltik]', 595 , 101 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Virizion]', 640 , 146 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Feebas]', 349, 10, q'|Water's-edge|', 140 , 3, 'H' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Pelipper]', 279, 2, q'|Sea|', 28 , 3, 'D' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Pansear]', 513 , 19 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Manectric]', 310, 18, q'|Grassland|', 79 , 3, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Spoink]', 325, 2, q'|Mountain|', 110 , 3, 'F' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Golisopod]', 768 , 183 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Silcoon]', 266, 3, q'|Forest|', 15 , 3, 'A' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Genesect]', 649 , 155 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Pansage]', 511 , 17 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Floatzel]', 419 , 57 , 4, 'F' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Finneon]', 456 , 134 , 4, 'A' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Grubbin]', 736 , 27 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Masquerain]', 284, 5, q'|Water's-edge|', 33 , 3, 'D' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Granbull]', 210, 1, q'|Urban|', 126 , 2, 'B' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Sentret]', 161, 1, q'|Grassland|', 19 , 2, 'D' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Type: Null]', 772 , 203 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Drifloon]', 425 , 65 , 4, 'G' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Zubat]', 41, 1, q'|Cave|', 41 , 1, 'D' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Swablu]', 333, 22, q'|Forest|', 121 , 3, 'H' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Dewgong]', 87, 8, q'|Sea|', 87 , 1, 'H' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Meowth]', 52, 1, q'|Urban|', 52 , 1, 'G' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Herdier]', 507 , 13 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Drampa]', 780 , 244 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Zweilous]', 634 , 140 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Minun]', 312, 20, q'|Grassland|', 81 , 3, 'B' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Swinub]', 220, 3, q'|Cave|', 195 , 2, 'A' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Kricketune]', 402 , 16 , 4, 'G' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Accelgor]', 617 , 123 , 5 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Klefki]', 707 , 50, 'Mo', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Voltorb]', 100, 9, q'|Urban|', 100 , 1, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Pidgeotto]', 17, 5, q'|Forest|', 17 , 1, 'D' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Gogoat]', 673 , 90, 'Ce', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Togekiss]', 468 , 175 , 4, 'H' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Deerling]', 585 , 91 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Ferrothorn]', 598 , 104 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Ralts]', 280, 5, q'|Urban|', 29 , 3, 'F' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Zoroark]', 571 , 77 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Necrozma]', 800 , 300 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Bronzor]', 436 , 88 , 4, 'E' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Zigzagoon]', 263, 2, q'|Grassland|', 12 , 3, 'D' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Hitmonchan]', 107, 7, q'|Urban|', 107 , 1, 'C' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Shieldon]', 410 , 38 , 4, 'E' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Caterpie]', 10, 1, q'|Forest|', 10 , 1, 'A' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Dialga]', 483 , 149 , 4, 'I' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Solrock]', 338, 9, q'|Cave|', 126 , 3, 'F' );
insert into POKEMON( NAME, DEX , GEN, IQ_GROUP )
values( nq'[Heatran]', 485 , 4, 'C' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Karrablast]', 588 , 94 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Forretress]', 205, 15, q'|Forest|', 94 , 2, 'E' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Carbink]', 703 , 124, 'Co', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Cubone]', 104, 5, q'|Mountain|', 104 , 1, 'F' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Deino]', 633 , 139 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Cofagrigus]', 563 , 69 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Dusclops]', 356, 23, q'|Forest|', 149 , 3, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Porygon2]', 233, 9, q'|Urban|', 221 , 2, 'E' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Heliolisk]', 695 , 47, 'Co', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Moltres]', 146, 2, q'|Rare|', 146 , 1, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Arcanine]', 59, 21, q'|Grassland|', 59 , 1, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Blissey]', 242, 8, q'|Urban|', 223 , 2, 'H' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Comfey]', 764 , 174 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Mareanie]', 747 , 113 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Mismagius]', 429 , 73 , 4, 'G' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Mawile]', 303, 6, q'|Cave|', 69 , 3, 'C' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Sliggoo]', 705 , 20, 'Mo', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Kommo-o]', 784 , 273 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Luxray]', 405 , 19 , 4, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Steelix]', 208, 2, q'|Cave|', 63 , 2, 'E' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Slowpoke]', 79, 9, q'|Water's-edge|', 79 , 1, 'B' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Cobalion]', 638 , 144 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Anorith]', 347, 11, q'|Water's-edge|', 135 , 3, 'E' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Barboach]', 339, 3, q'|Water's-edge|', 127 , 3, 'B' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Tyrunt]', 696 , 64, 'Co', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Prinplup]', 394 , 8 , 4, 'F' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Aegislash]', 681 , 119, 'Ce', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Toucannon]', 733 , 12 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Golurk]', 623 , 129 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Ninetales]', 38, 17, q'|Grassland|', 38 , 1, 'G' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Flygon]', 330, 6, q'|Rough-terrain|', 118 , 3, 'D' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Machoke]', 67, 3, q'|Mountain|', 67 , 1, 'D' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Relicanth]', 369, 12, q'|Sea|', 179 , 3, 'E' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Yanmega]', 469 , 184 , 4, 'D' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Honedge]', 679 , 117, 'Ce', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Togetic]', 176, 24, q'|Forest|', 47 , 2, 'H' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Darumaka]', 554 , 60 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Sharpedo]', 319, 10, q'|Sea|', 98 , 3, 'G' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Eevee]', 133, 11, q'|Urban|', 133 , 1, 'F' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Hippopotas]', 449 , 122 , 4, 'E' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Scrafty]', 560 , 66 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Volcarona]', 637 , 143 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Magmar]', 126, 10, q'|Mountain|', 126 , 1, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Mareep]', 179, 11, q'|Grassland|', 53 , 2, 'F' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Morelull]', 755 , 145 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Delibird]', 225, 8, q'|Mountain|', 194 , 2, 'B' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Tropius]', 357, 22, q'|Forest|', 150 , 3, 'E' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Shedinja]', 292, 13, q'|Forest|', 44 , 3, 'D' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Mudkip]', 258, 15, q'|Water's-edge|', 7 , 3, 'F' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Spewpa]', 665 , 21, 'Ce', 6 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Diancie]', 719 , 151, 'Ce', 6 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Litleo]', 667 , 57, 'Ce', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Fraxure]', 611 , 117 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Lickitung]', 108, 12, q'|Grassland|', 108 , 1, 'G' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Chinchou]', 170, 4, q'|Sea|', 176 , 2, 'A' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Natu]', 177, 6, q'|Forest|', 161 , 2, 'F' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Burmy]', 412 , 45 , 4, 'G' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Bayleef]', 153, 24, q'|Grassland|', 2 , 2, 'H' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Lopunny]', 428 , 68 , 4, 'D' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Slakoth]', 287, 16, q'|Forest|', 36 , 3, 'C' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Volcanion]', 721 , 153, 'Ce', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Seaking]', 119, 1, q'|Water's-edge|', 119 , 1, 'A' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Pidove]', 519 , 25 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Clefairy]', 35, 4, q'|Mountain|', 35 , 1, 'B' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Torracat]', 726 , 5 , 7 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Diggersby]', 660 , 11, 'Ce', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Bewear]', 760 , 170 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Empoleon]', 395 , 9 , 4, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Shiftry]', 275, 10, q'|Forest|', 24 , 3, 'C' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Dartrix]', 723 , 2 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Dustox]', 269, 4, q'|Forest|', 18 , 3, 'A' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Stunfisk]', 618 , 124 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Uxie]', 480 , 146 , 4, 'G' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Dugtrio]', 51, 2, q'|Cave|', 51 , 1, 'A' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Pyukumuku]', 771 , 200 , 7 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Zygarde]', 718 , 150, 'Mo', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Crabrawler]', 739 , 59 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Gabite]', 444 , 110 , 4, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Celebi]', 251, 26, q'|Forest|', 256 , 2, 'B' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Linoone]', 264, 2, q'|Grassland|', 13 , 3, 'D' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Decidueye]', 724 , 3 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Ledian]', 166, 12, q'|Forest|', 31 , 2, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Lileep]', 345, 15, q'|Sea|', 133 , 3, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Slowbro]', 80, 9, q'|Water's-edge|', 80 , 1, 'B' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Diglett]', 50, 2, q'|Cave|', 50 , 1, 'A' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Cosmoem]', 790 , 290 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Kartana]', 798 , 298 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Zapdos]', 145, 2, q'|Rare|', 145 , 1, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Pineco]', 204, 15, q'|Forest|', 93 , 2, 'E' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Liepard]', 510 , 16 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Tirtouga]', 564 , 70 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Breloom]', 286, 9, q'|Forest|', 35 , 3, 'C' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Lucario]', 448 , 116 , 4, 'C' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Palpitoad]', 536 , 42 , 5 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Chesnaught]', 652 , 3, 'Ce', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Electrode]', 101, 9, q'|Urban|', 101 , 1, 'C' );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Hawlucha]', 701 , 89, 'Co', 6 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Chespin]', 650 , 1, 'Ce', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Kyogre]', 382, 16, q'|Sea|', 198 , 3, 'E' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Swoobat]', 528 , 34 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Slowking]', 199, 9, q'|Water's-edge|', 82 , 2, 'B' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Rufflet]', 627 , 133 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Rockruff]', 744 , 103 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Probopass]', 476 , 156 , 4, 'E' );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Drifblim]', 426 , 66 , 4, 'G' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Magnemite]', 81, 3, q'|Rough-terrain|', 81 , 1, 'A' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Machop]', 66, 3, q'|Mountain|', 66 , 1, 'D' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Golem]', 76, 1, q'|Mountain|', 76 , 1, 'E' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Xurkitree]', 796 , 296 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Gastrodon]', 423 , 61 , 4, 'E' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Hariyama]', 297, 7, q'|Mountain|', 49 , 3, 'E' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Wailord]', 321, 10, q'|Sea|', 100 , 3, 'E' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Cosmog]', 789 , 289 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Sableye]', 302, 6, q'|Cave|', 68 , 3, 'C' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Munna]', 517 , 23 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Vulpix]', 37, 17, q'|Grassland|', 37 , 1, 'G' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Venomoth]', 49, 11, q'|Forest|', 49 , 1, 'A' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Latias]', 380, 16, q'|Water's-edge|', 196 , 3, 'D' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Ludicolo]', 272, 4, q'|Water's-edge|', 21 , 3, 'G' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Vanillite]', 582 , 88 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Dwebble]', 557 , 63 , 5 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Scatterbug]', 664 , 20, 'Ce', 6 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Doublade]', 680 , 118, 'Ce', 6 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Vileplume]', 45, 8, q'|Grassland|', 45 , 1, 'B' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Corsola]', 222, 7, q'|Sea|', 173 , 2, 'E' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Gothita]', 574 , 80 , 5 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Groudon]', 383, 11, q'|Rough-terrain|', 199 , 3, 'E' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Wailmer]', 320, 10, q'|Sea|', 99 , 3, 'E' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Musharna]', 518 , 24 , 5 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Passimian]', 766 , 177 , 7 );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Ferroseed]', 597 , 103 , 5 );
insert into POKEMON( NAME, DEX , LDEX, LDEX_SUFFIX, GEN )
values( nq'[Phantump]', 708 , 61, 'Mo', 6 );
insert into POKEMON( NAME, DEX , LDEX , GEN, IQ_GROUP )
values( nq'[Piplup]', 393 , 7 , 4, 'F' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Nidoran♂]', 32, 4, q'|Grassland|', 32 , 1, 'C' );
insert into POKEMON( NAME, DEX , LDEX , GEN )
values( nq'[Nihilego]', 793 , 293 , 7 );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Typhlosion]', 157, 25, q'|Grassland|', 6 , 2, 'C' );
insert into POKEMON( NAME, DEX, PAGE, HABITAT, LDEX , GEN, IQ_GROUP )
values( nq'[Metapod]', 11, 1, q'|Forest|', 11 , 1, 'A' );
insert into POKEMON( NAME, DEX , GEN, IQ_GROUP )
values( nq'[Phione]', 489 , 4, 'B' );