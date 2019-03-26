create table Pokemon(                               
 Name nvarchar2(100)  not null,     --Name of the Pokemon                      
 Dex number(4,0)  default on null 0 CONSTRAINT ck_Dex_PosZero check(Dex>=0),     --Pokedex number of the Pokemon                      
 Dex_Suffix varchar2(2 byte)  CONSTRAINT ck_Dex_Suffix_Cap check(regexp_like(Dex_Suffix, '[A-Z][a-zA-Z]?')),     --Dex Suffix of the Pokemon to distinguish between types                      
 Item nvarchar2(100)  ,     --The item used to get the form                      
 Class varchar2(100 char)  ,     --Discribing the form or type diffirence                      
 LDex number(3,0)  CONSTRAINT ck_LDex_PosZero check(LDex>=0),     --The local Pokedex number of the Pokemon                      
 LDex_Suffix varchar2(2 byte)  CONSTRAINT ck_LDex_Suffix_Cap check(regexp_like(ldex_suffix, '[A-Z][a-zA-Z]?')),     --Local Pokedex Suffix                      
 Type varchar2(30)  default on null 'Normal',     --The first type of the Pokemon                      
 Type2 varchar2(30)  ,     --The second type of the Pokemon                      
 Female number(1,0)  CONSTRAINT ck_Female_PosZero check(Female>=0),     --The male part of the geneder ratio                      
 Male number(1,0)  CONSTRAINT ck_Male_PosZero check(Male>=0),     --The female part of the gender ratio                      
 Unbreedable varchar2(2 byte)  CONSTRAINT ck_Unbreedable_U check(unbreedable in('U','U*')),     --Indicates if they are unbreedable                      
 EggGroup1 varchar2(30)  default on null 'Undiscovered',     --The first Egg Group the Pokemon Falls in                      
 EggGroup2 varchar2(30)  ,     --The second Egg Group the Pokemon Falls in                      
 Cycles number(3,0)  CONSTRAINT ck_Cycles_Pos check(Cycles>0),     --A stat that help determines egg hatching                      
 Steps_Gen2 number(6,0)  CONSTRAINT ck_Steps_Gen2_Pos check(Steps_Gen2>0),     --The steps to hatch the Pokemon in Gen 2                      
 Steps_Gen3 number(6,0)  CONSTRAINT ck_Steps_Gen3_Pos check(Steps_Gen3>0),     --The steps to hatch the Pokemon in Gen 3                      
 Steps_Gen4 number(6,0)  CONSTRAINT ck_Steps_Gen4_Pos check(Steps_Gen4>0),     --The steps to hatch the Pokemon in Gen 4                      
 Steps_Gen5 number(6,0)  CONSTRAINT ck_Steps_Gen5_Pos check(Steps_Gen5>0),     --The steps to hatch the Pokemon in Gen 5                      
 Steps_Gen7 number(6,0)  CONSTRAINT ck_Steps_Gen7_Pos check(Steps_Gen7>0),     --The steps to hatch the Pokemon in Gen 6                      
 WeightLbs number(6,2)  CONSTRAINT ck_WeightLbs_PosZero check(WeightLbs>=0),     --The weight of the Pokemon in pounds                      
 WeightKg number(6,2)  CONSTRAINT ck_WeightKg_PosZero check(WeightKg>=0),     --The weight of the Pokemon in kilograms                      
 Experience_Type varchar2(20)  ,     --The rate the Pokemon earns expereence                      
 Body varchar2(50)  ,     --The body classification of the Pokemon                      
 Gen number(1,0)  check(gen>0),     --The generation of the pokemon                      
 CONSTRAINT un_Pokemon  unique(Name, Dex, Dex_Suffix, Class),     --Enforce that Name, Dex and Class are unique                      
 CONSTRAINT ck_Type  check(Type!=Type2),     --Make sure that type cannot be the same                      
 CONSTRAINT ck_Egg  check(EggGroup1!=EggGroup2),     --Make sure that egg groups don't duplicate                      
 CONSTRAINT ck_Dex  check(Dex>=LDex),     --Make sure that Dex is bigger than or equal to LDex                      
 CONSTRAINT ck_Weight  check(WeightKg/WeightLbs between .35 and .55),     --Ensure there is no typo in weight (Soft checking)                      
 CONSTRAINT un_Dex_Class  unique(Dex, Class),     --Ensure that no class has duplicates                      
 CONSTRAINT ck_Gen2  check(Gen>2 and Steps_Gen2 is null or Gen<=2),     --Ensure the Pokemon exists in the Generation                      
 CONSTRAINT ck_Gen3  check(Gen>3 and Steps_Gen3 is null or Gen<=3),     --Ensure the Pokemon exists in the Generation                      
 CONSTRAINT ck_Gen4  check(Gen>4 and Steps_Gen4 is null or Gen<=4),     --Ensure the Pokemon exists in the Generation                      
 CONSTRAINT ck_Gen5  check(Gen>6 and Steps_Gen5 is null or Gen<=6),     --Ensure the Pokemon exists in the Generation, includes Gen 5 and 6                      
 CONSTRAINT ck_Gen7  check(Gen>7 and Steps_Gen7 is null or Gen<=7)     --Ensure the Pokemon exists in the Generation                      
);                               
                               
                               
                               
                               
                               
                               
                               
                               
                               
                               
                               
insert into Pokemon( Name, Dex   , LDex , Type , Female  , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Blissey]', 242   , 223 , 'Normal' , 1  , 'Fairy' , 40, 10240, 10496, 10455, 10280, 10240, 103.2, 46.8, 'Fast', q'{bipedal, tailless form}', 2 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Groudon]', 383, 'P', nq'|Red Orb|', q'|Primal|', 199 , 'Ground', 'Fire'  , 'U', 'Undiscovered' , 120 , 30976, 30855, 30840, 30720, 2094.4, 950, 'Slow', q'{bipedal, tailed form}', 3 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Noivern]', 715   , 114, 'Mo', 'Flying', 'Dragon', 1, 1 , 'Flying' , 20   , 5140, 5120, 187.4, 85, 'Medium Fast', q'{single pair of wings}', 6 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Gogoat]', 673   , 90, 'Ce', 'Grass' , 1, 1 , 'Field' , 20   , 5140, 5120, 200.6, 91, 'Medium Fast', q'{quadruped body}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2   , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Lunatone]', 337   , 125 , 'Rock', 'Psychic'   , 'Mineral' , 25 , 6656, 6630, 6425, 6400, 370.4, 168, 'Fast', q'{head}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Huntail]', 367   , 177 , 'Water' , 1, 1 , 'Water 1' , 20 , 5376, 5355, 5140, 5120, 59.5, 27, 'Erratic', q'{serpentine bodies}', 3 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type   , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Silvally]', 773  , q'|Type: Ice|', 204 , 'Normal'   , 'U', 'Undiscovered' , 120    , 30720, 221.6, 100.5, 'Slow', q'{quadruped body}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Eelektrik]', 603   , 109 , 'Electric' , 1, 1 , 'Amorphous' , 20   , 5140, 5120, 48.5, 22, 'Slow', q'{fins}', 5 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Talonflame]', 663   , 16, 'Ce', 'Fire', 'Flying', 1, 1 , 'Flying' , 15   , 3855, 3840, 54, 24.5, 'Medium Slow', q'{single pair of wings}', 6 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type , Female  , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Flabébé]', 669  , q'|Red Flower|', 68, 'Ce', 'Fairy' , 1  , 'Fairy' , 20   , 5140, 5120, 0.2, 0.1, 'Medium Fast', q'{head and arms}', 6 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Scatterbug]', 664   , 20, 'Ce', 'Bug' , 1, 1 , 'Bug' , 15   , 3855, 3840, 5.5, 2.5, 'Medium Fast', q'{insectoid body}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female  , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Petilil]', 548   , 54 , 'Grass' , 1  , 'Grass' , 20   , 5140, 5120, 14.6, 6.6, 'Medium Fast', q'{head and a base}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Umbreon]', 197   , 189 , 'Dark' , 1, 7 , 'Field' , 35, 8960, 9216, 9180, 8995, 8960, 59.5, 27, 'Medium Fast', q'{quadruped body}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Tynamo]', 602   , 108 , 'Electric' , 1, 1 , 'Amorphous' , 20   , 5140, 5120, 0.7, 0.3, 'Slow', q'{fins}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Shiftry]', 275   , 24 , 'Grass', 'Dark', 1, 1 , 'Field', 'Grass', 15 , 4096, 4080, 3855, 3840, 131.4, 59.6, 'Medium Slow', q'{bipedal, tailless form}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Shiinotic]', 756   , 146 , 'Grass', 'Fairy', 1, 1 , 'Grass' , 20    , 5120, 25.4, 11.5, 'Medium Fast', q'{bipedal, tailless form}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Simisage]', 512   , 18 , 'Grass' , 1, 7 , 'Field' , 20   , 5140, 5120, 67.2, 30.5, 'Medium Fast', q'{bipedal, tailed form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Cacturne]', 332   , 120 , 'Grass', 'Dark', 1, 1 , 'Grass', 'Human-Like', 20 , 5376, 5355, 5140, 5120, 170.6, 77.4, 'Medium Slow', q'{bipedal, tailless form}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Slowbro]', 80   , 80 , 'Water', 'Psychic', 1, 1 , 'Monster', 'Water 1', 20, 5120, 5376, 5355, 5140, 5120, 173.1, 78.5, 'Medium Fast', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female  , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Froslass]', 478   , 208 , 'Ice', 'Ghost', 1  , 'Fairy', 'Mineral', 20  , 5355, 5140, 5120, 58.6, 26.6, 'Medium Fast', q'{head and arms}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Krookodile]', 553   , 59 , 'Ground', 'Dark', 1, 1 , 'Field' , 20   , 5140, 5120, 212.3, 96.3, 'Medium Slow', q'{bipedal, tailed form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Buizel]', 418   , 56 , 'Water' , 1, 1 , 'Water 1', 'Field', 20  , 5355, 5140, 5120, 65, 29.5, 'Medium Fast', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Cherrim]', 421  , q'|Sunshine Form|', 59 , 'Grass' , 1, 1 , 'Fairy', 'Grass', 20  , 5355, 5140, 5120, 20.5, 9.3, 'Medium Fast', q'{head and legs}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Sandile]', 551   , 57 , 'Ground', 'Dark', 1, 1 , 'Field' , 20   , 5140, 5120, 33.5, 15.2, 'Medium Slow', q'{quadruped body}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Axew]', 610   , 116 , 'Dragon' , 1, 1 , 'Monster', 'Dragon', 40   , 10280, 10240, 39.7, 18, 'Slow', q'{bipedal, tailed form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Archen]', 566   , 72 , 'Rock', 'Flying', 1, 7 , 'Flying', 'Water 3', 30   , 7710, 7680, 20.9, 9.5, 'Medium Fast', q'{single pair of wings}', 5 );     
insert into Pokemon( Name, Dex  , Class  , Type   , Unbreedable, EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Shaymin]', 492  , q'|Land Forme|'  , 'Grass'   , 'U', 'Undiscovered' , 120  , 30855, 30840, 30720, 4.6, 2.1, 'Medium Slow', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2   , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Claydol]', 344   , 132 , 'Ground', 'Psychic'   , 'Mineral' , 20 , 5376, 5355, 5140, 5120, 238, 107.9, 'Medium Fast', q'{head and arms}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Gothorita]', 575   , 81 , 'Psychic' , 3, 1 , 'Human-Like' , 20   , 5140, 5120, 39.7, 18, 'Medium Slow', q'{bipedal, tailless form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type    , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Staryu]', 120   , 120 , 'Water'    , 'Water 3' , 20, 5120, 5376, 5355, 5140, 5120, 76.1, 34.5, 'Slow', q'{head and a base}', 1 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type, Type2 , Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Gallade]', 475, 'M', nq'|Galladite|', q'|Mega|', 160 , 'Psychic', 'Fighting' , 1 , 'Amorphous' , 20  , 5355, 5140, 5120, 114.6, 52, 'Slow', q'{bipedal, tailless form}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Kirlia]', 281   , 30 , 'Psychic', 'Fairy', 1, 1 , 'Amorphous' , 20 , 5376, 5355, 5140, 5120, 44.5, 20.2, 'Slow', q'{bipedal, tailless form}', 3 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pangoro]', 675   , 92, 'Ce', 'Fighting', 'Dark', 1, 1 , 'Field', 'Human-Like', 25   , 6425, 6400, 299.8, 136, 'Medium Fast', q'{bipedal, tailless form}', 6 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type, Type2, Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Oricorio]', 741  , q'|Pom-Pom Style|', 82 , 'Fire', 'Flying', 3, 1 , 'Flying' , 20    , 5120, 7.5, 3.4, 'Medium Fast', q'{single pair of wings}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pignite]', 499   , 5 , 'Fire', 'Fighting', 1, 7 , 'Field' , 20   , 5140, 5120, 122.4, 55.5, 'Medium Slow', q'{bipedal, tailed form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Aron]', 304   , 70 , 'Steel', 'Rock', 1, 1 , 'Monster' , 35 , 9216, 9180, 8995, 8960, 132.3, 60, 'Slow', q'{quadruped body}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Dewgong]', 87   , 87 , 'Water', 'Ice', 1, 1 , 'Water 1', 'Field', 20, 5120, 5376, 5355, 5140, 5120, 264.6, 120, 'Medium Fast', q'{fins}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Hakamo-o]', 783   , 272 , 'Dragon', 'Fighting', 1, 1 , 'Dragon' , 40    , 10240, 103.6, 47, 'Slow', q'{bipedal, tailed form}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Mr. Mime]', 122   , 122 , 'Psychic', 'Fairy', 1, 1 , 'Human-Like' , 25, 6400, 6656, 6630, 6425, 6400, 120.1, 54.5, 'Medium Fast', q'{bipedal, tailless form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Passimian]', 766   , 177 , 'Fighting' , 1, 1 , 'Field' , 20    , 5120, 182.5, 82.8, 'Slow', q'{bipedal, tailed form}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female , Unbreedable, EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Happiny]', 440   , 96 , 'Normal' , 1 , 'U', 'Undiscovered' , 40  , 10455, 10280, 10240, 53.8, 24.4, 'Fast', q'{bipedal, tailless form}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Spinarak]', 167   , 32 , 'Bug', 'Poison', 1, 1 , 'Bug' , 15, 3840, 4096, 4080, 3855, 3840, 18.7, 8.5, 'Fast', q'{insectoid body}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type   , Unbreedable, EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Regirock]', 377   , 193 , 'Rock'   , 'U', 'Undiscovered' , 80 , 20736, 20655, 20560, 20480, 507.1, 230, 'Slow', q'{bipedal, tailless form}', 3 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pikachu]', 25  , q'|Alola Cap|', 25 , 'Electric' , 1, 1 , 'Field', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 13.2, 6, 'Medium Fast', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex  , Class  , Type   , Unbreedable, EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Arceus]', 493  , q'|Type: Dragon|'  , 'Normal'   , 'U', 'Undiscovered' , 120  , 30855, 30840, 30720, 705.5, 320, 'Slow', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Hypno]', 97   , 97 , 'Psychic' , 1, 1 , 'Human-Like' , 20, 5120, 5376, 5355, 5140, 5120, 166.7, 75.6, 'Medium Fast', q'{bipedal, tailless form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Durant]', 632   , 138 , 'Bug', 'Steel', 1, 1 , 'Bug' , 20   , 5140, 5120, 72.8, 33, 'Medium Fast', q'{insectoid body}', 5 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class, LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Meloetta]', 648, 'P' , q'|Pirouette Forme|', 154 , 'Normal', 'Fighting'  , 'U', 'Undiscovered' , 120   , 30840, 30720, 14.3, 6.5, 'Slow', q'{bipedal, tailless form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Raticate]', 20   , 20 , 'Normal' , 1, 1 , 'Field' , 15, 3840, 4096, 4080, 3855, 3840, 40.8, 18.5, 'Medium Fast', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Hawlucha]', 701   , 89, 'Co', 'Fighting', 'Flying', 1, 1 , 'Human-Like' , 20   , 5140, 5120, 47.4, 21.5, 'Medium Fast', q'{bipedal, tailless form}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2 , Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Gallade]', 475   , 160 , 'Psychic', 'Fighting' , 1 , 'Amorphous' , 20  , 5355, 5140, 5120, 114.6, 52, 'Slow', q'{bipedal, tailless form}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type  , Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Throh]', 538   , 44 , 'Fighting'  , 1 , 'Human-Like' , 20   , 5140, 5120, 122.4, 55.5, 'Medium Fast', q'{bipedal, tailless form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male, Unbreedable, EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Togepi]', 175   , 46 , 'Fairy' , 1, 7, 'U', 'Undiscovered' , 10, 2560, 2816, 2805, 2570, 2560, 3.3, 1.5, 'Fast', q'{bipedal, tailless form}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Piloswine]', 221   , 196 , 'Ice', 'Ground', 1, 1 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 123, 55.8, 'Slow', q'{quadruped body}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Shuppet]', 353   , 146 , 'Ghost' , 1, 1 , 'Amorphous' , 25 , 6656, 6630, 6425, 6400, 5.1, 2.3, 'Fast', q'{head}', 3 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type   , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Silvally]', 773  , q'|Type: Dragon|', 204 , 'Normal'   , 'U', 'Undiscovered' , 120    , 30720, 221.6, 100.5, 'Slow', q'{quadruped body}', 7 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pumpkaboo]', 710  , q'|Super Size|', 63, 'Mo', 'Ghost', 'Grass', 1, 1 , 'Amorphous' , 20   , 5140, 5120, 33.1, 15, 'Medium Fast', q'{head}', 6 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Slowbro]', 80, 'M', nq'|Slowbronite|', q'|Mega|', 80 , 'Water', 'Psychic', 1, 1 , 'Monster', 'Water 1', 20, 5120, 5376, 5355, 5140, 5120, 173.1, 78.5, 'Medium Fast', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Ponyta]', 77   , 77 , 'Fire' , 1, 1 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 66.1, 30, 'Medium Fast', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Probopass]', 476   , 156 , 'Rock', 'Steel', 1, 1 , 'Mineral' , 20  , 5355, 5140, 5120, 749.6, 340, 'Medium Fast', q'{multiple bodies}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Marowak]', 105   , 105 , 'Ground' , 1, 1 , 'Monster' , 20, 5120, 5376, 5355, 5140, 5120, 99.2, 45, 'Medium Fast', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type   , Unbreedable, EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Kyogre]', 382   , 198 , 'Water'   , 'U', 'Undiscovered' , 120 , 30976, 30855, 30840, 30720, 776, 352, 'Slow', q'{fins}', 3 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Honedge]', 679   , 117, 'Ce', 'Steel', 'Ghost', 1, 1 , 'Mineral' , 20   , 5140, 5120, 4.4, 2, 'Medium Fast', q'{head and a base}', 6 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type , Female  , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Flabébé]', 669  , q'|Orange Flower|', 68, 'Ce', 'Fairy' , 1  , 'Fairy' , 20   , 5140, 5120, 0.2, 0.1, 'Medium Fast', q'{head and arms}', 6 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type, Type2, Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Salamence]', 373, 'M', nq'|Salamencite|', q'|Mega|', 189 , 'Dragon', 'Flying', 1, 1 , 'Dragon' , 40 , 10496, 10455, 10280, 10240, 226.2, 102.6, 'Slow', q'{quadruped body}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Cinccino]', 573   , 79 , 'Normal' , 3, 1 , 'Field' , 15   , 3855, 3840, 16.5, 7.5, 'Fast', q'{quadruped body}', 5 );     
insert into Pokemon( Name, Dex  , Class  , Type   , Unbreedable, EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Arceus]', 493  , q'|Type: Dark|'  , 'Normal'   , 'U', 'Undiscovered' , 120  , 30855, 30840, 30720, 705.5, 320, 'Slow', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type   , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Silvally]', 773  , q'|Type: Grass|', 204 , 'Normal'   , 'U', 'Undiscovered' , 120    , 30720, 221.6, 100.5, 'Slow', q'{quadruped body}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type   , Unbreedable, EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Registeel]', 379   , 195 , 'Steel'   , 'U', 'Undiscovered' , 80 , 20736, 20655, 20560, 20480, 451.9, 205, 'Slow', q'{bipedal, tailless form}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Dewott]', 502   , 8 , 'Water' , 1, 7 , 'Field' , 20   , 5140, 5120, 54, 24.5, 'Medium Slow', q'{bipedal, tailed form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Furret]', 162   , 20 , 'Normal' , 1, 1 , 'Field' , 15, 3840, 4096, 4080, 3855, 3840, 71.6, 32.5, 'Medium Fast', q'{quadruped body}', 2 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pikachu]', 25  , q'|Libre|', 25 , 'Electric' , 1, 1 , 'Field', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 13.2, 6, 'Medium Fast', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Drowzee]', 96   , 96 , 'Psychic' , 1, 1 , 'Human-Like' , 20, 5120, 5376, 5355, 5140, 5120, 71.4, 32.4, 'Medium Fast', q'{bipedal, tailless form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Slowking]', 199   , 82 , 'Water', 'Psychic', 1, 1 , 'Monster', 'Water 1', 20, 5120, 5376, 5355, 5140, 5120, 175.3, 79.5, 'Medium Fast', q'{bipedal, tailed form}', 2 );     
insert into Pokemon( Name, Dex     , Type , Female , Unbreedable, EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Cresselia]', 488     , 'Psychic' , 1 , 'U', 'Undiscovered' , 120  , 30855, 30840, 30720, 188.7, 85.6, 'Slow', q'{serpentine bodies}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Drapion]', 452   , 128 , 'Poison', 'Dark', 1, 1 , 'Bug', 'Water 3', 20  , 5355, 5140, 5120, 135.6, 61.5, 'Slow', q'{insectoid body}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Eevee]', 133   , 133 , 'Normal' , 1, 7 , 'Field' , 35, 8960, 9216, 9180, 8995, 8960, 14.3, 6.5, 'Medium Fast', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Vigoroth]', 288   , 37 , 'Normal' , 1, 1 , 'Field' , 15 , 4096, 4080, 3855, 3840, 102.5, 46.5, 'Slow', q'{bipedal, tailed form}', 3 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type   , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Silvally]', 773  , q'|Type: Ground|', 204 , 'Normal'   , 'U', 'Undiscovered' , 120    , 30720, 221.6, 100.5, 'Slow', q'{quadruped body}', 7 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Absol]', 359, 'M', nq'|Absolite|', q'|Mega|', 152 , 'Dark' , 1, 1 , 'Field' , 25 , 6656, 6630, 6425, 6400, 103.6, 47, 'Medium Slow', q'{quadruped body}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Gigalith]', 526   , 32 , 'Rock' , 1, 1 , 'Mineral' , 15   , 3855, 3840, 573.2, 260, 'Medium Slow', q'{tentacles or a multiped body}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Scraggy]', 559   , 65 , 'Dark', 'Fighting', 1, 1 , 'Field', 'Dragon', 15   , 3855, 3840, 26, 11.8, 'Medium Fast', q'{bipedal, tailed form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Tentacool]', 72   , 72 , 'Water', 'Poison', 1, 1 , 'Water 3' , 20, 5120, 5376, 5355, 5140, 5120, 100.3, 45.5, 'Slow', q'{tentacles or a multiped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Charjabug]', 737   , 28 , 'Bug', 'Electric', 1, 1 , 'Bug' , 15    , 3840, 23.1, 10.5, 'Medium Fast', q'{serpentine bodies}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Dunsparce]', 206   , 52 , 'Normal' , 1, 1 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 30.9, 14, 'Medium Fast', q'{serpentine bodies}', 2 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Gourgeist]', 711  , q'|Small Size|', 64, 'Mo', 'Ghost', 'Grass', 1, 1 , 'Amorphous' , 20   , 5140, 5120, 20.9, 9.5, 'Medium Fast', q'{head and a base}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Deino]', 633   , 139 , 'Dark', 'Dragon', 1, 1 , 'Dragon' , 40   , 10280, 10240, 38.1, 17.3, 'Slow', q'{quadruped body}', 5 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Vivillon]', 666  , q'|Meadow Pattern|', 22, 'Ce', 'Bug', 'Flying', 1, 1 , 'Bug' , 15   , 3855, 3840, 37.5, 17, 'Medium Fast', q'{two or more pairs of wings}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Trumbeak]', 732   , 11 , 'Normal', 'Flying', 1, 1 , 'Flying' , 15    , 3840, 32.6, 14.8, 'Medium Fast', q'{single pair of wings}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Doduo]', 84   , 84 , 'Normal', 'Flying', 1, 1 , 'Flying' , 20, 5120, 5376, 5355, 5140, 5120, 86.4, 39.2, 'Medium Fast', q'{head and legs}', 1 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Ampharos]', 181, 'M', nq'|Ampharosite|', q'|Mega|', 55 , 'Electric', 'Dragon', 1, 1 , 'Monster', 'Field', 20, 5120, 5376, 5355, 5140, 5120, 135.6, 61.5, 'Medium Slow', q'{bipedal, tailed form}', 2 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type, Type2  , Unbreedable, EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Hoopa]', 720  , q'|Confined|', 152, 'Ce', 'Psychic', 'Ghost'  , 'U', 'Undiscovered' , 120   , 30840, 30720, 19.8, 9, 'Slow', q'{head and arms}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Vibrava]', 329   , 117 , 'Ground', 'Dragon', 1, 1 , 'Bug' , 20 , 5376, 5355, 5140, 5120, 33.7, 15.3, 'Medium Slow', q'{two or more pairs of wings}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Mamoswine]', 473   , 205 , 'Ice', 'Ground', 1, 1 , 'Field' , 20  , 5355, 5140, 5120, 641.5, 291, 'Slow', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Tropius]', 357   , 150 , 'Grass', 'Flying', 1, 1 , 'Monster', 'Grass', 25 , 6656, 6630, 6425, 6400, 220.5, 100, 'Slow', q'{quadruped body}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Palossand]', 770   , 187 , 'Ghost', 'Ground', 1, 1 , 'Amorphous' , 15    , 3840, 551.2, 250, 'Medium Fast', q'{serpentine bodies}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type   , Unbreedable, EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Groudon]', 383   , 199 , 'Ground'   , 'U', 'Undiscovered' , 120 , 30976, 30855, 30840, 30720, 2094.4, 950, 'Slow', q'{bipedal, tailed form}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Aipom]', 190   , 123 , 'Normal' , 1, 1 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 25.4, 11.5, 'Fast', q'{bipedal, tailed form}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Nuzleaf]', 274   , 23 , 'Grass', 'Dark', 1, 1 , 'Field', 'Grass', 15 , 4096, 4080, 3855, 3840, 61.7, 28, 'Medium Slow', q'{bipedal, tailless form}', 3 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Deerling]', 585  , q'|Summer Form|', 91 , 'Normal', 'Grass', 1, 1 , 'Field' , 20   , 5140, 5120, 43, 19.5, 'Medium Fast', q'{quadruped body}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Lugia]', 249   , 252 , 'Psychic', 'Flying'  , 'U', 'Undiscovered' , 120, 30720, 30976, 30855, 30840, 30720, 476.2, 216, 'Slow', q'{single pair of wings}', 2 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Sylveon]', 700   , 85, 'Co', 'Fairy' , 1, 7 , 'Field' , 35   , 8995, 8960, 51.8, 23.5, 'Medium Fast', q'{quadruped body}', 6 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class, LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Eevee]', 133, 'Pa' , q'|Partner|', 133 , 'Normal' , 1, 7 , 'Field' , 35, 8960, 9216, 9180, 8995, 8960, 14.3, 6.5, 'Medium Fast', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Tyranitar]', 248   , 251 , 'Rock', 'Dark', 1, 1 , 'Monster' , 40, 10240, 10496, 10455, 10280, 10240, 445.3, 202, 'Slow', q'{bipedal, tailed form}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Hoothoot]', 163   , 15 , 'Normal', 'Flying', 1, 1 , 'Flying' , 15, 3840, 4096, 4080, 3855, 3840, 46.7, 21.2, 'Medium Fast', q'{single pair of wings}', 2 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Deerling]', 585  , q'|Autumn Form|', 91 , 'Normal', 'Grass', 1, 1 , 'Field' , 20   , 5140, 5120, 43, 19.5, 'Medium Fast', q'{quadruped body}', 5 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class, LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Castform]', 351, 'H' , q'|Snowy Form|', 142 , 'Ice' , 1, 1 , 'Fairy', 'Amorphous', 25 , 6656, 6630, 6425, 6400, 1.8, 0.8, 'Medium Fast', q'{head}', 3 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type   , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Silvally]', 773  , q'|Type: Fighting|', 204 , 'Normal'   , 'U', 'Undiscovered' , 120    , 30720, 221.6, 100.5, 'Slow', q'{quadruped body}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Smeargle]', 235   , 159 , 'Normal' , 1, 1 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 127.9, 58, 'Fast', q'{bipedal, tailed form}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Lunala]', 792   , 292 , 'Psychic', 'Ghost'  , 'U', 'Undiscovered' , 120    , 30720, 264.6, 120, 'Slow', q'{single pair of wings}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Milotic]', 350   , 141 , 'Water' , 1, 1 , 'Water 1', 'Dragon', 20 , 5376, 5355, 5140, 5120, 357.1, 162, 'Erratic', q'{serpentine bodies}', 3 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class, LDex , Type   , Unbreedable, EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Mewtwo]', 150, 'MY' , q'|Mega  Y|', 150 , 'Psychic'   , 'U', 'Undiscovered' , 120, 30720, 30976, 30855, 30840, 30720, 269, 122, 'Slow', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pidgeot]', 18   , 18 , 'Normal', 'Flying', 1, 1 , 'Flying' , 15, 3840, 4096, 4080, 3855, 3840, 87.1, 39.5, 'Medium Slow', q'{single pair of wings}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Komala]', 775   , 222 , 'Normal' , 1, 1 , 'Field' , 20    , 5120, 43.9, 19.9, 'Slow', q'{bipedal, tailless form}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Vanilluxe]', 584   , 90 , 'Ice' , 1, 1 , 'Mineral' , 20   , 5140, 5120, 126.8, 57.5, 'Slow', q'{multiple bodies}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Druddigon]', 621   , 127 , 'Dragon' , 1, 1 , 'Dragon', 'Monster', 30   , 7710, 7680, 306.4, 139, 'Medium Fast', q'{bipedal, tailed form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Linoone]', 264   , 13 , 'Normal' , 1, 1 , 'Field' , 15 , 4096, 4080, 3855, 3840, 71.6, 32.5, 'Medium Fast', q'{quadruped body}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Totodile]', 158   , 7 , 'Water' , 1, 7 , 'Monster', 'Water 1', 20, 5120, 5376, 5355, 5140, 5120, 20.9, 9.5, 'Medium Slow', q'{bipedal, tailed form}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Zekrom]', 644   , 150 , 'Dragon', 'Electric'  , 'U', 'Undiscovered' , 120   , 30840, 30720, 760.6, 345, 'Slow', q'{bipedal, tailed form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type    , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Electrode]', 101   , 101 , 'Electric'    , 'Mineral' , 20, 5120, 5376, 5355, 5140, 5120, 146.8, 66.6, 'Medium Fast', q'{head}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type   , Unbreedable, EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Regice]', 378   , 194 , 'Ice'   , 'U', 'Undiscovered' , 80 , 20736, 20655, 20560, 20480, 385.8, 175, 'Slow', q'{bipedal, tailless form}', 3 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Meloetta]', 648  , q'|Aria Forme|', 154 , 'Normal', 'Psychic'  , 'U', 'Undiscovered' , 120   , 30840, 30720, 14.3, 6.5, 'Slow', q'{bipedal, tailless form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Purrloin]', 509   , 15 , 'Dark' , 1, 1 , 'Field' , 20   , 5140, 5120, 22.3, 10.1, 'Medium Fast', q'{quadruped body}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Cradily]', 346   , 134 , 'Rock', 'Grass', 1, 7 , 'Water 3' , 30 , 7936, 7905, 7710, 7680, 133.2, 60.4, 'Erratic', q'{head and a base}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type   , Unbreedable, EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Entei]', 244   , 244 , 'Fire'   , 'U', 'Undiscovered' , 80, 20480, 20736, 20655, 20560, 20480, 436.5, 198, 'Slow', q'{quadruped body}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Bayleef]', 153   , 2 , 'Grass' , 1, 7 , 'Monster', 'Grass', 20, 5120, 5376, 5355, 5140, 5120, 34.8, 15.8, 'Medium Slow', q'{quadruped body}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Slugma]', 218   , 216 , 'Fire' , 1, 1 , 'Amorphous' , 20, 5120, 5376, 5355, 5140, 5120, 77.2, 35, 'Medium Fast', q'{serpentine bodies}', 2 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class  , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Raichu]', 26, 'A' , q'|Alolan|'  , 'Electric', 'Psychic', 1, 1 , 'Field', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 66.1, 30, 'Medium Fast', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type, Type2  , Unbreedable, EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Volcanion]', 721   , 153, 'Ce', 'Fire', 'Water'  , 'U', 'Undiscovered' , 120   , 30840, 30720, 429.9, 195, 'Slow', q'{quadruped body}', 6 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Vivillon]', 666  , q'|Poké Ball Pattern|', 22, 'Ce', 'Bug', 'Flying', 1, 1 , 'Bug' , 15   , 3855, 3840, 37.5, 17, 'Medium Fast', q'{two or more pairs of wings}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Nosepass]', 299   , 60 , 'Rock' , 1, 1 , 'Mineral' , 20 , 5376, 5355, 5140, 5120, 213.8, 97, 'Medium Fast', q'{bipedal, tailless form}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Mankey]', 56   , 56 , 'Fighting' , 1, 1 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 61.7, 28, 'Medium Fast', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Reshiram]', 643  , q'|Overdrive mode|', 149 , 'Dragon', 'Fire'  , 'U', 'Undiscovered' , 120   , 30840, 30720, 727.5, 330, 'Slow', q'{single pair of wings}', 5 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Furfrou]', 676  , q'|Heart Trim|', 93, 'Ce', 'Normal' , 1, 1 , 'Field' , 20   , 5140, 5120, 61.7, 28, 'Medium Fast', q'{quadruped body}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Toucannon]', 733   , 12 , 'Normal', 'Flying', 1, 1 , 'Flying' , 15    , 3840, 57.3, 26, 'Medium Fast', q'{single pair of wings}', 7 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Gastrodon]', 423  , q'|West Sea|', 61 , 'Water', 'Ground', 1, 1 , 'Water 1', 'Amorphous', 20  , 5355, 5140, 5120, 65.9, 29.9, 'Medium Fast', q'{serpentine bodies}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female  , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Lilligant]', 549   , 55 , 'Grass' , 1  , 'Grass' , 20   , 5140, 5120, 35.9, 16.3, 'Medium Fast', q'{head and a base}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Munna]', 517   , 23 , 'Psychic' , 1, 1 , 'Field' , 10   , 2570, 2560, 51.4, 23.3, 'Fast', q'{quadruped body}', 5 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class  , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Ninetales]', 38, 'A' , q'|Alolan|'  , 'Ice', 'Fairy', 3, 1 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 43.9, 19.9, 'Medium Fast', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Electivire]', 466   , 199 , 'Electric' , 1, 3 , 'Human-Like' , 25  , 6630, 6425, 6400, 305.6, 138.6, 'Medium Fast', q'{bipedal, tailed form}', 4 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class, LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Giratina]', 487, 'O' , q'|Origin Forme|', 210 , 'Ghost', 'Dragon'  , 'U', 'Undiscovered' , 120  , 30855, 30840, 30720, 1433, 650, 'Slow', q'{tentacles or a multiped body}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Sharpedo]', 319   , 98 , 'Water', 'Dark', 1, 1 , 'Water 2' , 20 , 5376, 5355, 5140, 5120, 195.8, 88.8, 'Slow', q'{fins}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Jumpluff]', 189   , 69 , 'Grass', 'Flying', 1, 1 , 'Fairy', 'Grass', 20, 5120, 5376, 5355, 5140, 5120, 6.6, 3, 'Medium Slow', q'{bipedal, tailed form}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Palkia]', 484   , 150 , 'Water', 'Dragon'  , 'U', 'Undiscovered' , 120  , 30855, 30840, 30720, 740.8, 336, 'Slow', q'{bipedal, tailed form}', 4 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class  , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Sandshrew]', 27, 'A' , q'|Alolan|'  , 'Ice', 'Steel', 1, 1 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 26.5, 12, 'Medium Fast', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Mawile]', 303   , 69 , 'Steel', 'Fairy', 1, 1 , 'Field', 'Fairy', 20 , 5376, 5355, 5140, 5120, 25.4, 11.5, 'Fast', q'{bipedal, tailless form}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Kakuna]', 14   , 14 , 'Bug', 'Poison', 1, 1 , 'Bug' , 15, 3840, 4096, 4080, 3855, 3840, 22, 10, 'Medium Fast', q'{serpentine bodies}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type    , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Porygon2]', 233   , 221 , 'Normal'    , 'Mineral' , 20, 5120, 5376, 5355, 5140, 5120, 71.6, 32.5, 'Medium Fast', q'{head and legs}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Farfetch'd]', 83   , 83 , 'Normal', 'Flying', 1, 1 , 'Flying', 'Field', 20, 5120, 5376, 5355, 5140, 5120, 33.1, 15, 'Medium Fast', q'{single pair of wings}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Rowlet]', 722   , 1 , 'Grass', 'Flying', 1, 7 , 'Flying' , 15    , 3840, 3.3, 1.5, 'Medium Slow', q'{single pair of wings}', 7 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type , Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Burmy]', 412  , q'|Plant Cloak|', 45 , 'Bug' , 1, 1 , 'Bug' , 15  , 4080, 3855, 3840, 7.5, 3.4, 'Medium Fast', q'{head and a base}', 4 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Amaura]', 698   , 66, 'Co', 'Rock', 'Ice', 1, 7 , 'Monster' , 30   , 7710, 7680, 55.6, 25.2, 'Medium Fast', q'{quadruped body}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Onix]', 95   , 95 , 'Rock', 'Ground', 1, 1 , 'Mineral' , 25, 6400, 6656, 6630, 6425, 6400, 463, 210, 'Medium Fast', q'{serpentine bodies}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Machop]', 66   , 66 , 'Fighting' , 1, 3 , 'Human-Like' , 20, 5120, 5376, 5355, 5140, 5120, 43, 19.5, 'Medium Slow', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Tapu Koko]', 785   , 285 , 'Electric', 'Fairy'  , 'U', 'Undiscovered' , 15    , 3840, 45.2, 20.5, 'Slow', q'{head and arms}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Squirtle]', 7   , 7 , 'Water' , 1, 7 , 'Monster', 'Water 1', 20, 5120, 5376, 5355, 5140, 5120, 19.8, 9, 'Medium Slow', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Gourgeist]', 711  , q'|Super Size|', 64, 'Mo', 'Ghost', 'Grass', 1, 1 , 'Amorphous' , 20   , 5140, 5120, 86, 39, 'Medium Fast', q'{head and a base}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male, Unbreedable, EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Elekid]', 239   , 156 , 'Electric' , 1, 3, 'U', 'Undiscovered' , 25, 6400, 6656, 6630, 6425, 6400, 51.8, 23.5, 'Medium Fast', q'{bipedal, tailless form}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Weavile]', 461   , 145 , 'Dark', 'Ice', 1, 1 , 'Field' , 20  , 5355, 5140, 5120, 75, 34, 'Medium Slow', q'{bipedal, tailed form}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Vanillite]', 582   , 88 , 'Ice' , 1, 1 , 'Mineral' , 20   , 5140, 5120, 12.6, 5.7, 'Slow', q'{head and a base}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Togedemaru]', 777   , 225 , 'Electric', 'Steel', 1, 1 , 'Field', 'Fairy', 10    , 2560, 7.3, 3.3, 'Medium Fast', q'{bipedal, tailed form}', 7 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type , Female  , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Flabébé]', 669  , q'|White Flower|', 68, 'Ce', 'Fairy' , 1  , 'Fairy' , 20   , 5140, 5120, 0.2, 0.1, 'Medium Fast', q'{head and arms}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Cranidos]', 408   , 36 , 'Rock' , 1, 7 , 'Monster' , 30  , 7905, 7710, 7680, 69.4, 31.5, 'Erratic', q'{bipedal, tailed form}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Quagsire]', 195   , 57 , 'Water', 'Ground', 1, 1 , 'Water 1', 'Field', 20, 5120, 5376, 5355, 5140, 5120, 165.3, 75, 'Medium Fast', q'{bipedal, tailed form}', 2 );     
insert into Pokemon( Name, Dex     , Type   , Unbreedable, EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Regigigas]', 486     , 'Normal'   , 'U', 'Undiscovered' , 120  , 30855, 30840, 30720, 925.9, 420, 'Slow', q'{bipedal, tailless form}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Spearow]', 21   , 21 , 'Normal', 'Flying', 1, 1 , 'Flying' , 15, 3840, 4096, 4080, 3855, 3840, 4.4, 2, 'Medium Fast', q'{single pair of wings}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Combusken]', 256   , 5 , 'Fire', 'Fighting', 1, 7 , 'Field' , 20 , 5376, 5355, 5140, 5120, 43, 19.5, 'Medium Slow', q'{bipedal, tailed form}', 3 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type   , Unbreedable, EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Xerneas]', 716  , q'|Active Mode|', 148, 'Mo', 'Fairy'   , 'U', 'Undiscovered' , 120   , 30840, 30720, 474, 215, 'Slow', q'{quadruped body}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Blitzle]', 522   , 28 , 'Electric' , 1, 1 , 'Field' , 20   , 5140, 5120, 65.7, 29.8, 'Medium Fast', q'{quadruped body}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Beedrill]', 15   , 15 , 'Bug', 'Poison', 1, 1 , 'Bug' , 15, 3840, 4096, 4080, 3855, 3840, 65, 29.5, 'Medium Fast', q'{two or more pairs of wings}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Surskit]', 283   , 32 , 'Bug', 'Water', 1, 1 , 'Water 1', 'Bug', 15 , 4096, 4080, 3855, 3840, 3.7, 1.7, 'Medium Fast', q'{insectoid body}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Geodude]', 74   , 74 , 'Rock', 'Ground', 1, 1 , 'Mineral' , 15, 3840, 4096, 4080, 3855, 3840, 44.1, 20, 'Medium Slow', q'{head and arms}', 1 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class, LDex , Type , Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Lycanroc]', 745, 'Mn' , q'|Midnight Form|', 104 , 'Rock' , 1, 1 , 'Field' , 15    , 3840, 55.1, 25, 'Medium Fast', q'{quadruped body}', 7 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class, LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Kyurem]', 646, 'B' , q'|Black|', 152 , 'Dragon', 'Ice'  , 'U', 'Undiscovered' , 120   , 30840, 30720, 716.5, 325, 'Slow', q'{bipedal, tailed form}', 5 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class, LDex, LDex_Suffix, Type, Type2  , Unbreedable, EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Zygarde]', 718, 'C' , q'|Complete Forme|', 150, 'Mo', 'Dragon', 'Ground'  , 'U', 'Undiscovered' , 120   , 30840, 30720, 1344.8, 610, 'Slow', q'{bipedal, tailed form}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Zangoose]', 335   , 123 , 'Normal' , 1, 1 , 'Field' , 20 , 5376, 5355, 5140, 5120, 88.8, 40.3, 'Erratic', q'{bipedal, tailed form}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Noctowl]', 164   , 16 , 'Normal', 'Flying', 1, 1 , 'Flying' , 15, 3840, 4096, 4080, 3855, 3840, 89.9, 40.8, 'Medium Fast', q'{single pair of wings}', 2 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type   , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Silvally]', 773  , q'|Type: Normal|', 204 , 'Normal'   , 'U', 'Undiscovered' , 120    , 30720, 221.6, 100.5, 'Slow', q'{quadruped body}', 7 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class  , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Geodude]', 74, 'A' , q'|Alolan|'  , 'Rock', 'Electric', 1, 1 , 'Mineral' , 15, 3840, 4096, 4080, 3855, 3840, 44.1, 20, 'Medium Slow', q'{head and arms}', 1 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type, Type2 , Male, Unbreedable, EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Landorus]', 645  , q'|Incarnate Forme|', 151 , 'Ground', 'Flying' , 1, 'U', 'Undiscovered' , 120   , 30840, 30720, 149.9, 68, 'Slow', q'{head and arms}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Golbat]', 42   , 42 , 'Poison', 'Flying', 1, 1 , 'Flying' , 15, 3840, 4096, 4080, 3855, 3840, 121.3, 55, 'Medium Fast', q'{single pair of wings}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Shelmet]', 616   , 122 , 'Bug' , 1, 1 , 'Bug' , 15   , 3855, 3840, 17, 7.7, 'Medium Fast', q'{head}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Cyndaquil]', 155   , 4 , 'Fire' , 1, 7 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 17.4, 7.9, 'Medium Slow', q'{bipedal, tailless form}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type   , Unbreedable, EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Azelf]', 482   , 148 , 'Psychic'   , 'U', 'Undiscovered' , 80  , 20655, 20560, 20480, 0.7, 0.3, 'Slow', q'{bipedal, tailed form}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Decidueye]', 724   , 3 , 'Grass', 'Ghost', 1, 7 , 'Flying' , 15    , 3840, 80.7, 36.6, 'Medium Slow', q'{single pair of wings}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type   , Unbreedable, EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Uxie]', 480   , 146 , 'Psychic'   , 'U', 'Undiscovered' , 80  , 20655, 20560, 20480, 0.7, 0.3, 'Slow', q'{bipedal, tailed form}', 4 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Sawsbuck]', 586  , q'|Summer Form|', 92 , 'Normal', 'Grass', 1, 1 , 'Field' , 20   , 5140, 5120, 203.9, 92.5, 'Medium Fast', q'{quadruped body}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Drifloon]', 425   , 65 , 'Ghost', 'Flying', 1, 1 , 'Amorphous' , 30  , 7905, 7710, 7680, 2.6, 1.2, 'Fluctuating', q'{head and arms}', 4 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Aerodactyl]', 142, 'M', nq'|Aerodactylite|', q'|Mega|', 142 , 'Rock', 'Flying', 1, 7 , 'Flying' , 35, 8960, 9216, 9180, 8995, 8960, 130.1, 59, 'Slow', q'{single pair of wings}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Trapinch]', 328   , 116 , 'Ground' , 1, 1 , 'Bug' , 20 , 5376, 5355, 5140, 5120, 33.1, 15, 'Medium Slow', q'{insectoid body}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Gorebyss]', 368   , 178 , 'Water' , 1, 1 , 'Water 1' , 20 , 5376, 5355, 5140, 5120, 49.8, 22.6, 'Erratic', q'{serpentine bodies}', 3 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pikachu]', 25  , q'|Sinnoh Cap|', 25 , 'Electric' , 1, 1 , 'Field', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 13.2, 6, 'Medium Fast', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Sliggoo]', 705   , 20, 'Mo', 'Dragon' , 1, 1 , 'Dragon' , 40   , 10280, 10240, 38.6, 17.5, 'Slow', q'{serpentine bodies}', 6 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class  , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Marowak]', 105, 'A' , q'|Alolan|'  , 'Fire', 'Ghost', 1, 1 , 'Monster' , 20, 5120, 5376, 5355, 5140, 5120, 99.2, 45, 'Medium Fast', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type, Type2   , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Minior]', 774  , q'|Meteor Form|', 213 , 'Rock', 'Flying'   , 'Mineral' , 25    , 6400, 88.2, 40, 'Medium Slow', q'{head}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Staravia]', 397   , 11 , 'Normal', 'Flying', 1, 1 , 'Flying' , 15  , 4080, 3855, 3840, 34.2, 15.5, 'Medium Slow', q'{single pair of wings}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Cherubi]', 420   , 58 , 'Grass' , 1, 1 , 'Fairy', 'Grass', 20  , 5355, 5140, 5120, 7.3, 3.3, 'Medium Fast', q'{multiple bodies}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Lumineon]', 457   , 135 , 'Water' , 1, 1 , 'Water 2' , 20  , 5355, 5140, 5120, 52.9, 24, 'Erratic', q'{fins}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Slowpoke]', 79   , 79 , 'Water', 'Psychic', 1, 1 , 'Monster', 'Water 1', 20, 5120, 5376, 5355, 5140, 5120, 79.4, 36, 'Medium Fast', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Swampert]', 260   , 9 , 'Water', 'Ground', 1, 7 , 'Monster', 'Water 1', 20 , 5376, 5355, 5140, 5120, 180.6, 81.9, 'Medium Slow', q'{bipedal, tailed form}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Karrablast]', 588   , 94 , 'Bug' , 1, 1 , 'Bug' , 15   , 3855, 3840, 13, 5.9, 'Medium Fast', q'{bipedal, tailless form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Nincada]', 290   , 42 , 'Bug', 'Ground', 1, 1 , 'Bug' , 15 , 4096, 4080, 3855, 3840, 12.1, 5.5, 'Erratic', q'{insectoid body}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Chinchou]', 170   , 176 , 'Water', 'Electric', 1, 1 , 'Water 2' , 20, 5120, 5376, 5355, 5140, 5120, 26.5, 12, 'Slow', q'{fins}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Bellossom]', 182   , 86 , 'Grass' , 1, 1 , 'Grass' , 20, 5120, 5376, 5355, 5140, 5120, 12.8, 5.8, 'Medium Slow', q'{bipedal, tailless form}', 2 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Vivillon]', 666  , q'|Sun Pattern|', 22, 'Ce', 'Bug', 'Flying', 1, 1 , 'Bug' , 15   , 3855, 3840, 37.5, 17, 'Medium Fast', q'{two or more pairs of wings}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Exeggutor]', 103   , 103 , 'Grass', 'Psychic', 1, 1 , 'Grass' , 20, 5120, 5376, 5355, 5140, 5120, 264.6, 120, 'Slow', q'{head and legs}', 1 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Audino]', 531, 'M', nq'|Audinite|', q'|Mega|', 37 , 'Normal', 'Fairy', 1, 1 , 'Fairy' , 20   , 5140, 5120, 68.3, 31, 'Fast', q'{bipedal, tailed form}', 5 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class, LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Gastrodon]', 423, 'E' , q'|East Sea|', 61 , 'Water', 'Ground', 1, 1 , 'Water 1', 'Amorphous', 20  , 5355, 5140, 5120, 65.9, 29.9, 'Medium Fast', q'{serpentine bodies}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Simisear]', 514   , 20 , 'Fire' , 1, 7 , 'Field' , 20   , 5140, 5120, 61.7, 28, 'Medium Fast', q'{bipedal, tailed form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Primeape]', 57   , 57 , 'Fighting' , 1, 1 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 70.5, 32, 'Medium Fast', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Mareep]', 179   , 53 , 'Electric' , 1, 1 , 'Monster', 'Field', 20, 5120, 5376, 5355, 5140, 5120, 17.2, 7.8, 'Medium Slow', q'{quadruped body}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Teddiursa]', 216   , 198 , 'Normal' , 1, 1 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 19.4, 8.8, 'Medium Fast', q'{bipedal, tailed form}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Tranquill]', 520   , 26 , 'Normal', 'Flying', 1, 1 , 'Flying' , 15   , 3855, 3840, 33.1, 15, 'Medium Slow', q'{single pair of wings}', 5 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type , Female  , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Florges]', 671  , q'|Yellow Flower|', 70, 'Ce', 'Fairy' , 1  , 'Fairy' , 20   , 5140, 5120, 22, 10, 'Medium Fast', q'{head and arms}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Timburr]', 532   , 38 , 'Fighting' , 1, 3 , 'Human-Like' , 20   , 5140, 5120, 27.6, 12.5, 'Medium Slow', q'{bipedal, tailless form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Chimecho]', 358   , 151 , 'Psychic' , 1, 1 , 'Amorphous' , 25 , 6656, 6630, 6425, 6400, 2.2, 1, 'Fast', q'{head and arms}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Blastoise]', 9   , 9 , 'Water' , 1, 7 , 'Monster', 'Water 1', 20, 5120, 5376, 5355, 5140, 5120, 188.5, 85.5, 'Medium Slow', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Machamp]', 68   , 68 , 'Fighting' , 1, 3 , 'Human-Like' , 20, 5120, 5376, 5355, 5140, 5120, 286.6, 130, 'Medium Slow', q'{bipedal, tailless form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Blaziken]', 257   , 6 , 'Fire', 'Fighting', 1, 7 , 'Field' , 20 , 5376, 5355, 5140, 5120, 114.6, 52, 'Medium Slow', q'{bipedal, tailed form}', 3 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Keldeo]', 647  , q'|Resolute Form|', 153 , 'Water', 'Fighting'  , 'U', 'Undiscovered' , 80   , 20560, 20480, 106.9, 48.5, 'Slow', q'{quadruped body}', 5 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Garchomp]', 445, 'M', nq'|Garchompite|', q'|Mega|', 111 , 'Dragon', 'Ground', 1, 1 , 'Monster', 'Dragon', 40  , 10455, 10280, 10240, 209.4, 95, 'Slow', q'{bipedal, tailed form}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type    , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Manaphy]', 490   , 151 , 'Water'    , 'Water 1', 'Fairy', 10  , 2805, 2570, 2560, 3.1, 1.4, 'Slow', q'{bipedal, tailless form}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Bellsprout]', 69   , 69 , 'Grass', 'Poison', 1, 1 , 'Grass' , 20, 5120, 5376, 5355, 5140, 5120, 8.8, 4, 'Medium Slow', q'{bipedal, tailless form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Togetic]', 176   , 47 , 'Fairy', 'Flying', 1, 7 , 'Flying', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 7.1, 3.2, 'Fast', q'{bipedal, tailless form}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Rhyhorn]', 111   , 111 , 'Ground', 'Rock', 1, 1 , 'Monster', 'Field', 20, 5120, 5376, 5355, 5140, 5120, 253.5, 115, 'Slow', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Tentacruel]', 73   , 73 , 'Water', 'Poison', 1, 1 , 'Water 3' , 20, 5120, 5376, 5355, 5140, 5120, 121.3, 55, 'Slow', q'{tentacles or a multiped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Minccino]', 572   , 78 , 'Normal' , 3, 1 , 'Field' , 15   , 3855, 3840, 12.8, 5.8, 'Fast', q'{quadruped body}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Meditite]', 307   , 76 , 'Fighting', 'Psychic', 1, 1 , 'Human-Like' , 20 , 5376, 5355, 5140, 5120, 24.7, 11.2, 'Medium Fast', q'{bipedal, tailless form}', 3 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Manectric]', 310, 'M', nq'|Manectite|', q'|Mega|', 79 , 'Electric' , 1, 1 , 'Field' , 20 , 5376, 5355, 5140, 5120, 88.6, 40.2, 'Slow', q'{quadruped body}', 3 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Vivillon]', 666  , q'|Ocean Pattern|', 22, 'Ce', 'Bug', 'Flying', 1, 1 , 'Bug' , 15   , 3855, 3840, 37.5, 17, 'Medium Fast', q'{two or more pairs of wings}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Absol]', 359   , 152 , 'Dark' , 1, 1 , 'Field' , 25 , 6656, 6630, 6425, 6400, 103.6, 47, 'Medium Slow', q'{quadruped body}', 3 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Sawsbuck]', 586  , q'|Winter Form|', 92 , 'Normal', 'Grass', 1, 1 , 'Field' , 20   , 5140, 5120, 203.9, 92.5, 'Medium Fast', q'{quadruped body}', 5 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type, Type2, Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Gardevoir]', 282, 'M', nq'|Gardevoirite|', q'|Mega|', 31 , 'Psychic', 'Fairy', 1, 1 , 'Amorphous' , 20 , 5376, 5355, 5140, 5120, 106.7, 48.4, 'Slow', q'{bipedal, tailless form}', 3 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type   , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Silvally]', 773  , q'|Type: Flying|', 204 , 'Normal'   , 'U', 'Undiscovered' , 120    , 30720, 221.6, 100.5, 'Slow', q'{quadruped body}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Seadra]', 117   , 117 , 'Water' , 1, 1 , 'Water 1', 'Dragon', 20, 5120, 5376, 5355, 5140, 5120, 55.1, 25, 'Medium Fast', q'{head and a base}', 1 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Barbaracle]', 689   , 22, 'Co', 'Rock', 'Water', 1, 1 , 'Water 3' , 20   , 5140, 5120, 211.6, 96, 'Medium Fast', q'{multiple bodies}', 6 );     
insert into Pokemon( Name, Dex  , Class  , Type   , Unbreedable, EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Arceus]', 493  , q'|Type: Fighting|'  , 'Normal'   , 'U', 'Undiscovered' , 120  , 30855, 30840, 30720, 705.5, 320, 'Slow', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Grubbin]', 736   , 27 , 'Bug' , 1, 1 , 'Bug' , 15    , 3840, 9.7, 4.4, 'Medium Fast', q'{insectoid body}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2   , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Starmie]', 121   , 121 , 'Water', 'Psychic'   , 'Water 3' , 20, 5120, 5376, 5355, 5140, 5120, 176.4, 80, 'Slow', q'{head and a base}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Meowth]', 52   , 52 , 'Normal' , 1, 1 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 9.3, 4.2, 'Medium Fast', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Jirachi]', 385   , 201 , 'Steel', 'Psychic'  , 'U', 'Undiscovered' , 120 , 30976, 30855, 30840, 30720, 2.4, 1.1, 'Slow', q'{bipedal, tailless form}', 3 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type  , Male, Unbreedable, EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Tornadus]', 641  , q'|Incarnate Forme|', 147 , 'Flying'  , 1, 'U', 'Undiscovered' , 120   , 30840, 30720, 138.9, 63, 'Slow', q'{head and arms}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2   , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Metang]', 375   , 191 , 'Steel', 'Psychic'   , 'Mineral' , 40 , 10496, 10455, 10280, 10240, 446.4, 202.5, 'Slow', q'{head and arms}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Whismur]', 293   , 45 , 'Normal' , 1, 1 , 'Monster', 'Field', 20 , 5376, 5355, 5140, 5120, 35.9, 16.3, 'Medium Slow', q'{bipedal, tailed form}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female  , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Jynx]', 124   , 124 , 'Ice', 'Psychic', 1  , 'Human-Like' , 25, 6400, 6656, 6630, 6425, 6400, 89.5, 40.6, 'Medium Fast', q'{bipedal, tailless form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Spoink]', 325   , 110 , 'Psychic' , 1, 1 , 'Field' , 20 , 5376, 5355, 5140, 5120, 67.5, 30.6, 'Fast', q'{head and arms}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Marill]', 183   , 132 , 'Water', 'Fairy', 1, 1 , 'Water 1', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 18.7, 8.5, 'Fast', q'{bipedal, tailed form}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Arbok]', 24   , 24 , 'Poison' , 1, 1 , 'Field', 'Dragon', 20, 5120, 5376, 5355, 5140, 5120, 143.3, 65, 'Medium Fast', q'{serpentine bodies}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Cloyster]', 91   , 91 , 'Water', 'Ice', 1, 1 , 'Water 3' , 20, 5120, 5376, 5355, 5140, 5120, 292.1, 132.5, 'Slow', q'{head}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Mudbray]', 749   , 132 , 'Ground' , 1, 1 , 'Field' , 20    , 5120, 242.5, 110, 'Medium Fast', q'{quadruped body}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Croconaw]', 159   , 8 , 'Water' , 1, 7 , 'Monster', 'Water 1', 20, 5120, 5376, 5355, 5140, 5120, 55.1, 25, 'Medium Slow', q'{bipedal, tailed form}', 2 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type, Type2  , Unbreedable, EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Yveltal]', 717   , 149, 'Mo', 'Dark', 'Flying'  , 'U', 'Undiscovered' , 120   , 30840, 30720, 447.5, 203, 'Slow', q'{single pair of wings}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Hydreigon]', 635   , 141 , 'Dark', 'Dragon', 1, 1 , 'Dragon' , 40   , 10280, 10240, 352.7, 160, 'Slow', q'{bipedal, tailed form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Rayquaza]', 384   , 200 , 'Dragon', 'Flying'  , 'U', 'Undiscovered' , 120 , 30976, 30855, 30840, 30720, 455.2, 206.5, 'Slow', q'{serpentine bodies}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Scrafty]', 560   , 66 , 'Dark', 'Fighting', 1, 1 , 'Field', 'Dragon', 15   , 3855, 3840, 66.1, 30, 'Medium Fast', q'{bipedal, tailed form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Brionne]', 729   , 8 , 'Water' , 1, 7 , 'Water 1', 'Field', 15    , 3840, 38.6, 17.5, 'Medium Slow', q'{fins}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Snorunt]', 361   , 171 , 'Ice' , 1, 1 , 'Fairy', 'Mineral', 20 , 5376, 5355, 5140, 5120, 37, 16.8, 'Medium Fast', q'{bipedal, tailless form}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Snubbull]', 209   , 125 , 'Fairy' , 3, 1 , 'Field', 'Fairy', 20, 5120, 5376, 5355, 5140, 5120, 17.2, 7.8, 'Fast', q'{bipedal, tailless form}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Snover]', 459   , 142 , 'Grass', 'Ice', 1, 1 , 'Monster', 'Grass', 20  , 5355, 5140, 5120, 111.3, 50.5, 'Slow', q'{bipedal, tailed form}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Swellow]', 277   , 26 , 'Normal', 'Flying', 1, 1 , 'Flying' , 15 , 4096, 4080, 3855, 3840, 43.7, 19.8, 'Medium Slow', q'{single pair of wings}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Kingler]', 99   , 99 , 'Water' , 1, 1 , 'Water 3' , 20, 5120, 5376, 5355, 5140, 5120, 132.3, 60, 'Medium Fast', q'{insectoid body}', 1 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Abomasnow]', 460, 'M', nq'|Abomasite|', q'|Mega|', 143 , 'Grass', 'Ice', 1, 1 , 'Monster', 'Grass', 20  , 5355, 5140, 5120, 298.7, 135.5, 'Slow', q'{bipedal, tailed form}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Ampharos]', 181   , 55 , 'Electric' , 1, 1 , 'Monster', 'Field', 20, 5120, 5376, 5355, 5140, 5120, 135.6, 61.5, 'Medium Slow', q'{bipedal, tailed form}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Seaking]', 119   , 119 , 'Water' , 1, 1 , 'Water 2' , 20, 5120, 5376, 5355, 5140, 5120, 86, 39, 'Medium Fast', q'{fins}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Wooper]', 194   , 56 , 'Water', 'Ground', 1, 1 , 'Water 1', 'Field', 20, 5120, 5376, 5355, 5140, 5120, 18.7, 8.5, 'Medium Fast', q'{head and legs}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Shuckle]', 213   , 168 , 'Bug', 'Rock', 1, 1 , 'Bug' , 20, 5120, 5376, 5355, 5140, 5120, 45.2, 20.5, 'Medium Slow', q'{insectoid body}', 2 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type, Type2   , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Rotom]', 479  , q'|Frost|', 152 , 'Electric', 'Ghost'   , 'Amorphous' , 20  , 5355, 5140, 5120, 0.7, 0.3, 'Medium Fast', q'{head}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2   , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Baltoy]', 343   , 131 , 'Ground', 'Psychic'   , 'Mineral' , 20 , 5376, 5355, 5140, 5120, 47.4, 21.5, 'Medium Fast', q'{head and arms}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Woobat]', 527   , 33 , 'Psychic', 'Flying', 1, 1 , 'Field', 'Flying', 15   , 3855, 3840, 4.6, 2.1, 'Medium Fast', q'{single pair of wings}', 5 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class, LDex , Type   , Unbreedable, EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Mewtwo]', 150, 'MX' , q'|Mega  X|', 150 , 'Psychic'   , 'U', 'Undiscovered' , 120, 30720, 30976, 30855, 30840, 30720, 269, 122, 'Slow', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Heracross]', 214   , 114 , 'Bug', 'Fighting', 1, 1 , 'Bug' , 25, 6400, 6656, 6630, 6425, 6400, 119, 54, 'Slow', q'{bipedal, tailless form}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Piplup]', 393   , 7 , 'Water' , 1, 7 , 'Water 1', 'Field', 20  , 5355, 5140, 5120, 11.5, 5.2, 'Medium Slow', q'{bipedal, tailless form}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Vulpix]', 37   , 37 , 'Fire' , 3, 1 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 21.8, 9.9, 'Medium Fast', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Feraligatr]', 160   , 9 , 'Water' , 1, 7 , 'Monster', 'Water 1', 20, 5120, 5376, 5355, 5140, 5120, 195.8, 88.8, 'Medium Slow', q'{bipedal, tailed form}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Murkrow]', 198   , 213 , 'Dark', 'Flying', 1, 1 , 'Flying' , 20, 5120, 5376, 5355, 5140, 5120, 4.6, 2.1, 'Medium Slow', q'{single pair of wings}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Audino]', 531   , 37 , 'Normal' , 1, 1 , 'Fairy' , 20   , 5140, 5120, 68.3, 31, 'Fast', q'{bipedal, tailed form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male, Unbreedable, EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Wynaut]', 360   , 160 , 'Psychic' , 1, 1, 'U', 'Undiscovered' , 20 , 5376, 5355, 5140, 5120, 30.9, 14, 'Medium Fast', q'{bipedal, tailed form}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Carnivine]', 455   , 131 , 'Grass' , 1, 1 , 'Grass' , 25  , 6630, 6425, 6400, 59.5, 27, 'Slow', q'{tentacles or a multiped body}', 4 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type , Female  , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Florges]', 671  , q'|Blue Flower|', 70, 'Ce', 'Fairy' , 1  , 'Fairy' , 20   , 5140, 5120, 22, 10, 'Medium Fast', q'{head and arms}', 6 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Zekrom]', 644  , q'|Overdrive mode|', 150 , 'Dragon', 'Electric'  , 'U', 'Undiscovered' , 120   , 30840, 30720, 760.6, 345, 'Slow', q'{bipedal, tailed form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Prinplup]', 394   , 8 , 'Water' , 1, 7 , 'Water 1', 'Field', 20  , 5355, 5140, 5120, 50.7, 23, 'Medium Slow', q'{bipedal, tailed form}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Camerupt]', 323   , 102 , 'Fire', 'Ground', 1, 1 , 'Field' , 20 , 5376, 5355, 5140, 5120, 485, 220, 'Medium Fast', q'{quadruped body}', 3 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class, LDex , Type   , Unbreedable, EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Deoxys]', 386, 'A' , q'|Attack Forme|', 202 , 'Psychic'   , 'U', 'Undiscovered' , 120 , 30976, 30855, 30840, 30720, 134, 60.8, 'Slow', q'{bipedal, tailless form}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male, Unbreedable, EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Chingling]', 433   , 82 , 'Psychic' , 1, 1, 'U', 'Undiscovered' , 25  , 6630, 6425, 6400, 1.3, 0.6, 'Fast', q'{bipedal, tailless form}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Crawdaunt]', 342   , 130 , 'Water', 'Dark', 1, 1 , 'Water 1', 'Water 3', 15 , 4096, 4080, 3855, 3840, 72.3, 32.8, 'Fluctuating', q'{insectoid body}', 3 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex, LDex_Suffix, Type, Type2  , Unbreedable, EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Diancie]', 719, 'M', nq'|Diancite|', q'|Mega|', 151, 'Ce', 'Rock', 'Fairy'  , 'U', 'Undiscovered' , 25   , 6425, 6400, 19.4, 8.8, 'Slow', q'{head and arms}', 6 );     
insert into Pokemon( Name, Dex  , Class  , Type   , Unbreedable, EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Arceus]', 493  , q'|Type: Ice|'  , 'Normal'   , 'U', 'Undiscovered' , 120  , 30855, 30840, 30720, 705.5, 320, 'Slow', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Sceptile]', 254, 'M', nq'|Sceptilite|', q'|Mega|', 3 , 'Grass', 'Dragon', 1, 7 , 'Monster', 'Dragon', 20 , 5376, 5355, 5140, 5120, 115.1, 52.2, 'Medium Slow', q'{bipedal, tailed form}', 3 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pikachu]', 25  , q'|Partner Cap|', 25 , 'Electric' , 1, 1 , 'Field', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 13.2, 6, 'Medium Fast', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Steelix]', 208   , 63 , 'Steel', 'Ground', 1, 1 , 'Mineral' , 25, 6400, 6656, 6630, 6425, 6400, 881.8, 400, 'Medium Fast', q'{serpentine bodies}', 2 );     
insert into Pokemon( Name, Dex     , Type, Type2  , Unbreedable, EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Victini]', 494     , 'Psychic', 'Fire'  , 'U', 'Undiscovered' , 120   , 30840, 30720, 8.8, 4, 'Slow', q'{bipedal, tailless form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type    , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Porygon]', 137   , 137 , 'Normal'    , 'Mineral' , 20, 5120, 5376, 5355, 5140, 5120, 80.5, 36.5, 'Medium Fast', q'{head and legs}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Lairon]', 305   , 71 , 'Steel', 'Rock', 1, 1 , 'Monster' , 35 , 9216, 9180, 8995, 8960, 264.6, 120, 'Slow', q'{quadruped body}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Staraptor]', 398   , 12 , 'Normal', 'Flying', 1, 1 , 'Flying' , 15  , 4080, 3855, 3840, 54.9, 24.9, 'Medium Slow', q'{single pair of wings}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Crabominable]', 740   , 60 , 'Fighting', 'Ice', 1, 1 , 'Water 3' , 20    , 5120, 396.8, 180, 'Medium Fast', q'{insectoid body}', 7 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Vivillon]', 666  , q'|Marine Pattern|', 22, 'Ce', 'Bug', 'Flying', 1, 1 , 'Bug' , 15   , 3855, 3840, 37.5, 17, 'Medium Fast', q'{two or more pairs of wings}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Yanmega]', 469   , 184 , 'Bug', 'Flying', 1, 1 , 'Bug' , 20  , 5355, 5140, 5120, 113.5, 51.5, 'Medium Fast', q'{two or more pairs of wings}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Parasect]', 47   , 47 , 'Bug', 'Grass', 1, 1 , 'Bug', 'Grass', 20, 5120, 5376, 5355, 5140, 5120, 65, 29.5, 'Medium Fast', q'{insectoid body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Blacephalon]', 806   , 393 , 'Fire', 'Ghost'  , 'U', 'Undiscovered' , 120    , 30720, 28.7, 13, 'Slow', q'{bipedal, tailless form}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Marshtomp]', 259   , 8 , 'Water', 'Ground', 1, 7 , 'Monster', 'Water 1', 20 , 5376, 5355, 5140, 5120, 61.7, 28, 'Medium Slow', q'{bipedal, tailed form}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Lurantis]', 754   , 144 , 'Grass' , 1, 1 , 'Grass' , 20    , 5120, 40.8, 18.5, 'Medium Fast', q'{bipedal, tailless form}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Duskull]', 355   , 148 , 'Ghost' , 1, 1 , 'Amorphous' , 25 , 6656, 6630, 6425, 6400, 33.1, 15, 'Fast', q'{head and arms}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Victreebel]', 71   , 71 , 'Grass', 'Poison', 1, 1 , 'Grass' , 20, 5120, 5376, 5355, 5140, 5120, 34.2, 15.5, 'Medium Slow', q'{head and a base}', 1 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Lunala]', 792  , q'|Full Moon phase|', 292 , 'Psychic', 'Ghost'  , 'U', 'Undiscovered' , 120    , 30720, 264.6, 120, 'Slow', q'{single pair of wings}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Tirtouga]', 564   , 70 , 'Water', 'Rock', 1, 7 , 'Water 1', 'Water 3', 30   , 7710, 7680, 36.4, 16.5, 'Medium Fast', q'{quadruped body}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Cottonee]', 546   , 52 , 'Grass', 'Fairy', 1, 1 , 'Grass', 'Fairy', 20   , 5140, 5120, 1.3, 0.6, 'Medium Fast', q'{head}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Gloom]', 44   , 44 , 'Grass', 'Poison', 1, 1 , 'Grass' , 20, 5120, 5376, 5355, 5140, 5120, 19, 8.6, 'Medium Slow', q'{bipedal, tailless form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Bouffalant]', 626   , 132 , 'Normal' , 1, 1 , 'Field' , 20   , 5140, 5120, 208.3, 94.5, 'Medium Fast', q'{quadruped body}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pheromosa]', 795   , 295 , 'Bug', 'Fighting'  , 'U', 'Undiscovered' , 120    , 30720, 55.1, 25, 'Slow', q'{bipedal, tailless form}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type    , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Klinklang]', 601   , 107 , 'Steel'    , 'Mineral' , 20   , 5140, 5120, 178.6, 81, 'Medium Slow', q'{multiple bodies}', 5 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type, Type2, Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Camerupt]', 323, 'M', nq'|Cameruptite|', q'|Mega|', 102 , 'Fire', 'Ground', 1, 1 , 'Field' , 20 , 5376, 5355, 5140, 5120, 485, 220, 'Medium Fast', q'{quadruped body}', 3 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type   , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Silvally]', 773  , q'|Type: Bug|', 204 , 'Normal'   , 'U', 'Undiscovered' , 120    , 30720, 221.6, 100.5, 'Slow', q'{quadruped body}', 7 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Vivillon]', 666  , q'|Icy Snow Pattern|', 22, 'Ce', 'Bug', 'Flying', 1, 1 , 'Bug' , 15   , 3855, 3840, 37.5, 17, 'Medium Fast', q'{two or more pairs of wings}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male, Unbreedable, EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Budew]', 406   , 25 , 'Grass', 'Poison', 1, 1, 'U', 'Undiscovered' , 20  , 5355, 5140, 5120, 2.6, 1.2, 'Medium Slow', q'{bipedal, tailless form}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Growlithe]', 58   , 58 , 'Fire' , 1, 3 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 41.9, 19, 'Slow', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Oshawott]', 501   , 7 , 'Water' , 1, 7 , 'Field' , 20   , 5140, 5120, 13, 5.9, 'Medium Slow', q'{bipedal, tailed form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Glaceon]', 471   , 170 , 'Ice' , 1, 7 , 'Field' , 35  , 9180, 8995, 8960, 57.1, 25.9, 'Medium Fast', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2 , Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Nidoking]', 34   , 34 , 'Poison', 'Ground' , 1 , 'Monster', 'Field', 20, 5120, 5376, 5355, 5140, 5120, 136.7, 62, 'Medium Slow', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Cofagrigus]', 563   , 69 , 'Ghost' , 1, 1 , 'Mineral', 'Amorphous', 25   , 6425, 6400, 168.7, 76.5, 'Medium Fast', q'{head and a base}', 5 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Vivillon]', 666  , q'|High Plains Pattern|', 22, 'Ce', 'Bug', 'Flying', 1, 1 , 'Bug' , 15   , 3855, 3840, 37.5, 17, 'Medium Fast', q'{two or more pairs of wings}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Whimsicott]', 547   , 53 , 'Grass', 'Fairy', 1, 1 , 'Grass', 'Fairy', 20   , 5140, 5120, 14.6, 6.6, 'Medium Fast', q'{bipedal, tailless form}', 5 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type, Type2   , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Rotom]', 479  , q'|Wash|', 152 , 'Electric', 'Ghost'   , 'Amorphous' , 20  , 5355, 5140, 5120, 0.7, 0.3, 'Medium Fast', q'{head}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Sigilyph]', 561   , 67 , 'Psychic', 'Flying', 1, 1 , 'Flying' , 20   , 5140, 5120, 30.9, 14, 'Medium Fast', q'{single pair of wings}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Butterfree]', 12   , 12 , 'Bug', 'Flying', 1, 1 , 'Bug' , 15, 3840, 4096, 4080, 3855, 3840, 70.5, 32, 'Medium Fast', q'{two or more pairs of wings}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pyukumuku]', 771   , 200 , 'Water' , 1, 1 , 'Water 1' , 15    , 3840, 2.6, 1.2, 'Fast', q'{serpentine bodies}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type  , Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Hitmontop]', 237   , 148 , 'Fighting'  , 1 , 'Human-Like' , 25, 6400, 6656, 6630, 6425, 6400, 105.8, 48, 'Medium Fast', q'{bipedal, tailed form}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Scizor]', 212   , 112 , 'Bug', 'Steel', 1, 1 , 'Bug' , 25, 6400, 6656, 6630, 6425, 6400, 260.1, 118, 'Medium Fast', q'{two or more pairs of wings}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Celebi]', 251   , 256 , 'Psychic', 'Grass'  , 'U', 'Undiscovered' , 120, 30720, 30976, 30855, 30840, 30720, 11, 5, 'Medium Slow', q'{bipedal, tailless form}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Lopunny]', 428   , 68 , 'Normal' , 1, 1 , 'Field', 'Human-Like', 20  , 5355, 5140, 5120, 73.4, 33.3, 'Medium Fast', q'{bipedal, tailed form}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male, Unbreedable, EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Igglybuff]', 174   , 44 , 'Normal', 'Fairy', 3, 1, 'U', 'Undiscovered' , 10, 2560, 2816, 2805, 2570, 2560, 2.2, 1, 'Fast', q'{bipedal, tailless form}', 2 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Quilladin]', 651   , 2, 'Ce', 'Grass' , 1, 7 , 'Field' , 20   , 5140, 5120, 63.9, 29, 'Medium Slow', q'{bipedal, tailed form}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2   , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Metagross]', 376   , 192 , 'Steel', 'Psychic'   , 'Mineral' , 40 , 10496, 10455, 10280, 10240, 1212.5, 550, 'Slow', q'{multiple bodies}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Charmander]', 4   , 4 , 'Fire' , 1, 7 , 'Monster', 'Dragon', 20, 5120, 5376, 5355, 5140, 5120, 18.7, 8.5, 'Medium Slow', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Shellos]', 422  , q'|West Sea|', 60 , 'Water' , 1, 1 , 'Water 1', 'Amorphous', 20  , 5355, 5140, 5120, 13.9, 6.3, 'Medium Fast', q'{serpentine bodies}', 4 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type, Type2   , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Rotom]', 479  , q'|Heat|', 152 , 'Electric', 'Ghost'   , 'Amorphous' , 20  , 5355, 5140, 5120, 0.7, 0.3, 'Medium Fast', q'{head}', 4 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Aggron]', 306, 'M', nq'|Aggronite|', q'|Mega|', 72 , 'Steel' , 1, 1 , 'Monster' , 35 , 9216, 9180, 8995, 8960, 793.7, 360, 'Slow', q'{bipedal, tailed form}', 3 );     
insert into Pokemon( Name, Dex  , Class  , Type   , Unbreedable, EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Arceus]', 493  , q'|Type: Steel|'  , 'Normal'   , 'U', 'Undiscovered' , 120  , 30855, 30840, 30720, 705.5, 320, 'Slow', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Gulpin]', 316   , 95 , 'Poison' , 1, 1 , 'Amorphous' , 20 , 5376, 5355, 5140, 5120, 22.7, 10.3, 'Fluctuating', q'{head and arms}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Persian]', 53   , 53 , 'Normal' , 1, 1 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 70.5, 32, 'Medium Fast', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Litten]', 725   , 4 , 'Fire' , 1, 7 , 'Field' , 15    , 3840, 9.5, 4.3, 'Medium Slow', q'{quadruped body}', 7 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pikachu]', 25  , q'|Kalos Cap|', 25 , 'Electric' , 1, 1 , 'Field', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 13.2, 6, 'Medium Fast', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Aegislash]', 681  , q'|Shield Forme|', 119, 'Ce', 'Steel', 'Ghost', 1, 1 , 'Mineral' , 20   , 5140, 5120, 116.8, 53, 'Medium Fast', q'{head and a base}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male, Unbreedable, EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Conkeldurr]', 534   , 40 , 'Fighting' , 1, 3, 'U', 'Human-Like' , 20   , 5140, 5120, 191.8, 87, 'Medium Slow', q'{bipedal, tailless form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male, Unbreedable, EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Riolu]', 447   , 115 , 'Fighting' , 1, 7, 'U', 'Undiscovered' , 25  , 6630, 6425, 6400, 44.5, 20.2, 'Medium Slow', q'{bipedal, tailed form}', 4 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type, Type2   , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Metagross]', 376, 'M', nq'|Metagrossite|', q'|Mega|', 192 , 'Steel', 'Psychic'   , 'Mineral' , 40 , 10496, 10455, 10280, 10240, 1212.5, 550, 'Slow', q'{multiple bodies}', 3 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Lopunny]', 428, 'M', nq'|Lopunnite|', q'|Mega|', 68 , 'Normal', 'Fighting', 1, 1 , 'Field', 'Human-Like', 20  , 5355, 5140, 5120, 73.4, 33.3, 'Medium Fast', q'{bipedal, tailed form}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Clefable]', 36   , 36 , 'Fairy' , 3, 1 , 'Fairy' , 10, 2560, 2816, 2805, 2570, 2560, 88.2, 40, 'Fast', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Vileplume]', 45   , 45 , 'Grass', 'Poison', 1, 1 , 'Grass' , 20, 5120, 5376, 5355, 5140, 5120, 41, 18.6, 'Medium Slow', q'{bipedal, tailless form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Kabutops]', 141   , 141 , 'Rock', 'Water', 1, 7 , 'Water 1', 'Water 3', 30, 7680, 7936, 7905, 7710, 7680, 89.3, 40.5, 'Medium Fast', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class, LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Basculin]', 550, 'B' , q'|Blue-Striped Form|', 56 , 'Water' , 1, 1 , 'Water 2' , 40   , 10280, 10240, 39.7, 18, 'Medium Fast', q'{fins}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Crustle]', 558   , 64 , 'Bug', 'Rock', 1, 1 , 'Bug', 'Mineral', 20   , 5140, 5120, 440.9, 200, 'Medium Fast', q'{insectoid body}', 5 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class, LDex , Type   , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Necrozma]', 800, 'U' , q'|Ultra|', 300 , 'Psychic'   , 'U', 'Undiscovered' , 120    , 30720, 507.1, 230, 'Slow', q'{two or more pairs of wings}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Bidoof]', 399   , 13 , 'Normal' , 1, 1 , 'Water 1', 'Field', 15  , 4080, 3855, 3840, 44.1, 20, 'Medium Fast', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Glalie]', 362   , 172 , 'Ice' , 1, 1 , 'Fairy', 'Mineral', 20 , 5376, 5355, 5140, 5120, 565.5, 256.5, 'Medium Fast', q'{head}', 3 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Lucario]', 448, 'M', nq'|Lucarionite|', q'|Mega|', 116 , 'Fighting', 'Steel', 1, 7 , 'Field', 'Human-Like', 25  , 6630, 6425, 6400, 119, 54, 'Medium Slow', q'{bipedal, tailed form}', 4 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type, Type2, Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Oricorio]', 741  , q'|Pa'u Style|', 82 , 'Fire', 'Flying', 3, 1 , 'Flying' , 20    , 5120, 7.5, 3.4, 'Medium Fast', q'{single pair of wings}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Salamence]', 373   , 189 , 'Dragon', 'Flying', 1, 1 , 'Dragon' , 40 , 10496, 10455, 10280, 10240, 226.2, 102.6, 'Slow', q'{quadruped body}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Armaldo]', 348   , 136 , 'Rock', 'Bug', 1, 7 , 'Water 3' , 30 , 7936, 7905, 7710, 7680, 150.4, 68.2, 'Erratic', q'{bipedal, tailed form}', 3 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type , Female  , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Floette]', 670  , q'|Orange Flower|', 69, 'Ce', 'Fairy' , 1  , 'Fairy' , 20   , 5140, 5120, 2, 0.9, 'Medium Fast', q'{head and arms}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female  , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Steenee]', 762   , 172 , 'Grass' , 1  , 'Grass' , 20    , 5120, 18.1, 8.2, 'Medium Slow', q'{bipedal, tailless form}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Aggron]', 306   , 72 , 'Steel', 'Rock', 1, 1 , 'Monster' , 35 , 9216, 9180, 8995, 8960, 793.7, 360, 'Slow', q'{bipedal, tailed form}', 3 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Furfrou]', 676  , q'|Kabuki Trim|', 93, 'Ce', 'Normal' , 1, 1 , 'Field' , 20   , 5140, 5120, 61.7, 28, 'Medium Fast', q'{quadruped body}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Swalot]', 317   , 96 , 'Poison' , 1, 1 , 'Amorphous' , 20 , 5376, 5355, 5140, 5120, 176.4, 80, 'Fluctuating', q'{head and arms}', 3 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Basculin]', 550  , q'|Red-Striped Form|', 56 , 'Water' , 1, 1 , 'Water 2' , 40   , 10280, 10240, 39.7, 18, 'Medium Fast', q'{fins}', 5 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type , Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pancham]', 674   , 91, 'Ce', 'Fighting' , 1, 1 , 'Field', 'Human-Like', 25   , 6425, 6400, 17.6, 8, 'Medium Fast', q'{bipedal, tailed form}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Gligar]', 207   , 193 , 'Ground', 'Flying', 1, 1 , 'Bug' , 20, 5120, 5376, 5355, 5140, 5120, 142.9, 64.8, 'Medium Slow', q'{single pair of wings}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Articuno]', 144   , 144 , 'Ice', 'Flying'  , 'U', 'Undiscovered' , 80, 20480, 20736, 20655, 20560, 20480, 122.1, 55.4, 'Slow', q'{single pair of wings}', 1 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type , Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Clauncher]', 692   , 32, 'Co', 'Water' , 1, 1 , 'Water 1', 'Water 3', 15   , 3855, 3840, 18.3, 8.3, 'Slow', q'{insectoid body}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Excadrill]', 530   , 36 , 'Ground', 'Steel', 1, 1 , 'Field' , 20   , 5140, 5120, 89.1, 40.4, 'Medium Fast', q'{bipedal, tailless form}', 5 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pikachu]', 25  , q'|Hoenn Cap|', 25 , 'Electric' , 1, 1 , 'Field', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 13.2, 6, 'Medium Fast', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class, LDex , Type  , Male, Unbreedable, EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Tornadus]', 641, 'T' , q'|Therian Forme|', 147 , 'Flying'  , 1, 'U', 'Undiscovered' , 120   , 30840, 30720, 138.9, 63, 'Slow', q'{single pair of wings}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Loudred]', 294   , 46 , 'Normal' , 1, 1 , 'Monster', 'Field', 20 , 5376, 5355, 5140, 5120, 89.3, 40.5, 'Medium Slow', q'{bipedal, tailed form}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female  , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Kangaskhan]', 115   , 115 , 'Normal' , 1  , 'Monster' , 20, 5120, 5376, 5355, 5140, 5120, 176.4, 80, 'Medium Fast', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female  , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Vullaby]', 629   , 135 , 'Dark', 'Flying', 1  , 'Flying' , 20   , 5140, 5120, 19.8, 9, 'Slow', q'{single pair of wings}', 5 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Delphox]', 655   , 6, 'Ce', 'Fire', 'Psychic', 1, 7 , 'Field' , 20   , 5140, 5120, 86, 39, 'Medium Slow', q'{bipedal, tailed form}', 6 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class, LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Charizard]', 6, 'MY' , q'|Mega  Y|', 6 , 'Fire', 'Flying', 1, 7 , 'Monster', 'Dragon', 20, 5120, 5376, 5355, 5140, 5120, 199.5, 90.5, 'Medium Slow', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Virizion]', 640   , 146 , 'Grass', 'Fighting'  , 'U', 'Undiscovered' , 80   , 20560, 20480, 440.9, 200, 'Slow', q'{quadruped body}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Mienfoo]', 619   , 125 , 'Fighting' , 1, 1 , 'Field', 'Human-Like', 25   , 6425, 6400, 44.1, 20, 'Medium Slow', q'{bipedal, tailed form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Dialga]', 483   , 149 , 'Steel', 'Dragon'  , 'U', 'Undiscovered' , 120  , 30855, 30840, 30720, 1505.8, 683, 'Slow', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Croagunk]', 453   , 129 , 'Poison', 'Fighting', 1, 1 , 'Human-Like' , 10  , 2805, 2570, 2560, 50.7, 23, 'Medium Fast', q'{bipedal, tailless form}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Meganium]', 154   , 3 , 'Grass' , 1, 7 , 'Monster', 'Grass', 20, 5120, 5376, 5355, 5140, 5120, 221.6, 100.5, 'Medium Slow', q'{quadruped body}', 2 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Furfrou]', 676  , q'|Debutante Trim|', 93, 'Ce', 'Normal' , 1, 1 , 'Field' , 20   , 5140, 5120, 61.7, 28, 'Medium Fast', q'{quadruped body}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Dragonite]', 149   , 149 , 'Dragon', 'Flying', 1, 1 , 'Water 1', 'Dragon', 40, 10240, 10496, 10455, 10280, 10240, 463, 210, 'Slow', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pidgeotto]', 17   , 17 , 'Normal', 'Flying', 1, 1 , 'Flying' , 15, 3840, 4096, 4080, 3855, 3840, 66.1, 30, 'Medium Slow', q'{single pair of wings}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Ambipom]', 424   , 64 , 'Normal' , 1, 1 , 'Field' , 20  , 5355, 5140, 5120, 44.8, 20.3, 'Fast', q'{bipedal, tailed form}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Tepig]', 498   , 4 , 'Fire' , 1, 7 , 'Field' , 20   , 5140, 5120, 21.8, 9.9, 'Medium Slow', q'{quadruped body}', 5 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class, LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Castform]', 351, 'S' , q'|Sunny Form|', 142 , 'Fire' , 1, 1 , 'Fairy', 'Amorphous', 25 , 6656, 6630, 6425, 6400, 1.8, 0.8, 'Medium Fast', q'{head}', 3 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type , Female  , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Floette]', 670  , q'|Yellow Flower|', 69, 'Ce', 'Fairy' , 1  , 'Fairy' , 20   , 5140, 5120, 2, 0.9, 'Medium Fast', q'{head and arms}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Omanyte]', 138   , 138 , 'Rock', 'Water', 1, 7 , 'Water 1', 'Water 3', 30, 7680, 7936, 7905, 7710, 7680, 16.5, 7.5, 'Medium Fast', q'{tentacles or a multiped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Aurorus]', 699   , 67, 'Co', 'Rock', 'Ice', 1, 7 , 'Monster' , 30   , 7710, 7680, 496, 225, 'Medium Fast', q'{quadruped body}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Toxicroak]', 454   , 130 , 'Poison', 'Fighting', 1, 1 , 'Human-Like' , 20  , 5355, 5140, 5120, 97.9, 44.4, 'Medium Fast', q'{bipedal, tailless form}', 4 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pikachu]', 25  , q'|Rock Star|', 25 , 'Electric' , 1, 1 , 'Field', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 13.2, 6, 'Medium Fast', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Lapras]', 131   , 131 , 'Water', 'Ice', 1, 1 , 'Monster', 'Water 1', 40, 10240, 10496, 10455, 10280, 10240, 485, 220, 'Slow', q'{fins}', 1 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class  , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Meowth]', 52, 'A' , q'|Alolan|'  , 'Dark' , 1, 1 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 9.3, 4.2, 'Medium Fast', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Stakataka]', 805   , 392 , 'Rock', 'Steel'  , 'U', 'Undiscovered' , 120    , 30720, 1807.8, 820, 'Slow', q'{quadruped body}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Wurmple]', 265   , 14 , 'Bug' , 1, 1 , 'Bug' , 15 , 4096, 4080, 3855, 3840, 7.9, 3.6, 'Medium Fast', q'{insectoid body}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2   , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Shedinja]', 292   , 44 , 'Bug', 'Ghost'   , 'Mineral' , 15 , 4096, 4080, 3855, 3840, 2.6, 1.2, 'Erratic', q'{head and a base}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pikipek]', 731   , 10 , 'Normal', 'Flying', 1, 1 , 'Flying' , 15    , 3840, 2.6, 1.2, 'Medium Fast', q'{single pair of wings}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Lickitung]', 108   , 108 , 'Normal' , 1, 1 , 'Monster' , 20, 5120, 5376, 5355, 5140, 5120, 144.4, 65.5, 'Medium Fast', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Furfrou]', 676  , q'|Dandy Trim|', 93, 'Ce', 'Normal' , 1, 1 , 'Field' , 20   , 5140, 5120, 61.7, 28, 'Medium Fast', q'{quadruped body}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Weedle]', 13   , 13 , 'Bug', 'Poison', 1, 1 , 'Bug' , 15, 3840, 4096, 4080, 3855, 3840, 7.1, 3.2, 'Medium Fast', q'{insectoid body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Houndour]', 228   , 214 , 'Dark', 'Fire', 1, 1 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 23.8, 10.8, 'Slow', q'{quadruped body}', 2 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Froakie]', 656   , 7, 'Ce', 'Water' , 1, 7 , 'Water 1' , 20   , 5140, 5120, 15.4, 7, 'Medium Slow', q'{quadruped body}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Fomantis]', 753   , 143 , 'Grass' , 1, 1 , 'Grass' , 20    , 5120, 3.3, 1.5, 'Medium Fast', q'{bipedal, tailed form}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Togekiss]', 468   , 175 , 'Fairy', 'Flying', 1, 7 , 'Flying', 'Fairy', 10  , 2805, 2570, 2560, 83.8, 38, 'Fast', q'{single pair of wings}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Exploud]', 295   , 47 , 'Normal' , 1, 1 , 'Monster', 'Field', 20 , 5376, 5355, 5140, 5120, 185.2, 84, 'Medium Slow', q'{bipedal, tailed form}', 3 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Avalugg]', 713   , 80, 'Mo', 'Ice' , 1, 1 , 'Monster' , 20   , 5140, 5120, 1113.3, 505, 'Medium Fast', q'{quadruped body}', 6 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pikachu]', 25  , q'|Cosplay|', 25 , 'Electric' , 1, 1 , 'Field', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 13.2, 6, 'Medium Fast', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Skitty]', 300   , 61 , 'Normal' , 3, 1 , 'Field', 'Fairy', 15 , 4096, 4080, 3855, 3840, 24.3, 11, 'Fast', q'{quadruped body}', 3 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class, LDex , Type , Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Wishiwashi]', 746, 'Sc' , q'|School Form|', 110 , 'Water' , 1, 1 , 'Water 2' , 15    , 3840, 173.3, 78.6, 'Fast', q'{fins}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Forretress]', 205   , 94 , 'Bug', 'Steel', 1, 1 , 'Bug' , 20, 5120, 5376, 5355, 5140, 5120, 277.3, 125.8, 'Medium Fast', q'{head}', 2 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Phantump]', 708   , 61, 'Mo', 'Ghost', 'Grass', 1, 1 , 'Grass', 'Amorphous', 20   , 5140, 5120, 15.4, 7, 'Medium Fast', q'{head and arms}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female  , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Illumise]', 314   , 87 , 'Bug' , 1  , 'Bug', 'Human-Like', 15 , 4096, 4080, 3855, 3840, 39, 17.7, 'Fluctuating', q'{bipedal, tailless form}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type   , Unbreedable, EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Mew]', 151   , 151 , 'Psychic'   , 'U', 'Undiscovered' , 120, 30720, 30976, 30855, 30840, 30720, 8.8, 4, 'Medium Slow', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class  , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Muk]', 89, 'A' , q'|Alolan|'  , 'Poison', 'Dark', 1, 1 , 'Amorphous' , 20, 5120, 5376, 5355, 5140, 5120, 66.1, 30, 'Medium Fast', q'{head and arms}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Houndoom]', 229   , 215 , 'Dark', 'Fire', 1, 1 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 77.2, 35, 'Slow', q'{quadruped body}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Seviper]', 336   , 124 , 'Poison' , 1, 1 , 'Field', 'Dragon', 20 , 5376, 5355, 5140, 5120, 115.7, 52.5, 'Fluctuating', q'{serpentine bodies}', 3 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class, LDex , Type, Type2 , Male, Unbreedable, EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Thundurus]', 642, 'T' , q'|Therian Forme|', 148 , 'Electric', 'Flying' , 1, 'U', 'Undiscovered' , 120   , 30840, 30720, 134.5, 61, 'Slow', q'{bipedal, tailed form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Psyduck]', 54   , 54 , 'Water' , 1, 1 , 'Water 1', 'Field', 20, 5120, 5376, 5355, 5140, 5120, 43.2, 19.6, 'Medium Fast', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Alomomola]', 594   , 100 , 'Water' , 1, 1 , 'Water 1', 'Water 2', 40   , 10280, 10240, 69.7, 31.6, 'Fast', q'{fins}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2   , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Rotom]', 479   , 152 , 'Electric', 'Ghost'   , 'Amorphous' , 20  , 5355, 5140, 5120, 0.7, 0.3, 'Medium Fast', q'{head}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Maractus]', 556   , 62 , 'Grass' , 1, 1 , 'Grass' , 20   , 5140, 5120, 61.7, 28, 'Medium Fast', q'{head and a base}', 5 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type   , Unbreedable, EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Xerneas]', 716  , q'|Neutral Mode|', 148, 'Mo', 'Fairy'   , 'U', 'Undiscovered' , 120   , 30840, 30720, 474, 215, 'Slow', q'{quadruped body}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Sealeo]', 364   , 174 , 'Ice', 'Water', 1, 1 , 'Water 1', 'Field', 20 , 5376, 5355, 5140, 5120, 193.1, 87.6, 'Medium Slow', q'{fins}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Reshiram]', 643   , 149 , 'Dragon', 'Fire'  , 'U', 'Undiscovered' , 120   , 30840, 30720, 727.5, 330, 'Slow', q'{single pair of wings}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type   , Unbreedable, EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Unown]', 201   , 61 , 'Psychic'   , 'U', 'Undiscovered' , 40, 10240, 10496, 10455, 10280, 10240, 11, 5, 'Medium Fast', q'{head}', 2 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class  , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Grimer]', 88, 'A' , q'|Alolan|'  , 'Poison', 'Dark', 1, 1 , 'Amorphous' , 20, 5120, 5376, 5355, 5140, 5120, 66.1, 30, 'Medium Fast', q'{head and arms}', 1 );     
insert into Pokemon( Name, Dex, Dex_Suffix  , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Unfezant]', 521, 'F'  , 27 , 'Normal', 'Flying', 1, 1 , 'Flying' , 15   , 3855, 3840, 63.9, 29, 'Medium Slow', q'{single pair of wings}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Wigglytuff]', 40   , 40 , 'Normal', 'Fairy', 3, 1 , 'Fairy' , 10, 2560, 2816, 2805, 2570, 2560, 26.5, 12, 'Fast', q'{bipedal, tailless form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Mightyena]', 262   , 11 , 'Dark' , 1, 1 , 'Field' , 15 , 4096, 4080, 3855, 3840, 81.6, 37, 'Medium Fast', q'{quadruped body}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Archeops]', 567   , 73 , 'Rock', 'Flying', 1, 7 , 'Flying', 'Water 3', 30   , 7710, 7680, 70.5, 32, 'Medium Fast', q'{single pair of wings}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Barboach]', 339   , 127 , 'Water', 'Ground', 1, 1 , 'Water 2' , 20 , 5376, 5355, 5140, 5120, 4.2, 1.9, 'Medium Fast', q'{fins}', 3 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Noibat]', 714   , 113, 'Mo', 'Flying', 'Dragon', 1, 1 , 'Flying' , 20   , 5140, 5120, 17.6, 8, 'Medium Fast', q'{single pair of wings}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Turtwig]', 387   , 1 , 'Grass' , 1, 7 , 'Monster', 'Grass', 20  , 5355, 5140, 5120, 22.5, 10.2, 'Medium Slow', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Mudkip]', 258   , 7 , 'Water' , 1, 7 , 'Monster', 'Water 1', 20 , 5376, 5355, 5140, 5120, 16.8, 7.6, 'Medium Slow', q'{quadruped body}', 3 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Binacle]', 688   , 21, 'Co', 'Rock', 'Water', 1, 1 , 'Water 3' , 20   , 5140, 5120, 68.3, 31, 'Medium Fast', q'{multiple bodies}', 6 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Gourgeist]', 711  , q'|Average Size|', 64, 'Mo', 'Ghost', 'Grass', 1, 1 , 'Amorphous' , 20   , 5140, 5120, 27.6, 12.5, 'Medium Fast', q'{head and a base}', 6 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Bunnelby]', 659   , 10, 'Ce', 'Normal' , 1, 1 , 'Field' , 15   , 3855, 3840, 11, 5, 'Medium Fast', q'{bipedal, tailed form}', 6 );     
insert into Pokemon( Name, Dex, Dex_Suffix  , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Jellicent]', 593, 'F'  , 99 , 'Water', 'Ghost', 1, 1 , 'Amorphous' , 20   , 5140, 5120, 297.6, 135, 'Medium Fast', q'{tentacles or a multiped body}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Spinda]', 327   , 114 , 'Normal' , 1, 1 , 'Field', 'Human-Like', 15 , 4096, 4080, 3855, 3840, 11, 5, 'Fast', q'{bipedal, tailed form}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Gastly]', 92   , 92 , 'Ghost', 'Poison', 1, 1 , 'Amorphous' , 20, 5120, 5376, 5355, 5140, 5120, 0.2, 0.1, 'Medium Slow', q'{head}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Stoutland]', 508   , 14 , 'Normal' , 1, 1 , 'Field' , 15   , 3855, 3840, 134.5, 61, 'Medium Slow', q'{quadruped body}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Dusknoir]', 477   , 191 , 'Ghost' , 1, 1 , 'Amorphous' , 25  , 6630, 6425, 6400, 235, 106.6, 'Fast', q'{head and arms}', 4 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Blastoise]', 9, 'M', nq'|Blastoisinite|', q'|Mega|', 9 , 'Water' , 1, 7 , 'Monster', 'Water 1', 20, 5120, 5376, 5355, 5140, 5120, 188.5, 85.5, 'Medium Slow', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type , Female  , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Kangaskhan]', 115, 'M', nq'|Kangaskhanite|', q'|Mega|', 115 , 'Normal' , 1  , 'Monster' , 20, 5120, 5376, 5355, 5140, 5120, 176.4, 80, 'Medium Fast', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class, LDex, LDex_Suffix, Type, Type2  , Unbreedable, EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Zygarde]', 718, 'T' , q'|10% Forme|', 150, 'Mo', 'Dragon', 'Ground'  , 'U', 'Undiscovered' , 120   , 30840, 30720, 73.9, 33.5, 'Slow', q'{quadruped body}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male, Unbreedable, EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Cleffa]', 173   , 40 , 'Fairy' , 3, 1, 'U', 'Undiscovered' , 10, 2560, 2816, 2805, 2570, 2560, 6.6, 3, 'Fast', q'{bipedal, tailed form}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Torkoal]', 324   , 105 , 'Fire' , 1, 1 , 'Field' , 20 , 5376, 5355, 5140, 5120, 177.2, 80.4, 'Medium Fast', q'{quadruped body}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pupitar]', 247   , 250 , 'Rock', 'Ground', 1, 1 , 'Monster' , 40, 10240, 10496, 10455, 10280, 10240, 335.1, 152, 'Slow', q'{serpentine bodies}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pidove]', 519   , 25 , 'Normal', 'Flying', 1, 1 , 'Flying' , 15   , 3855, 3840, 4.6, 2.1, 'Medium Slow', q'{single pair of wings}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Tapu Fini]', 788   , 288 , 'Water', 'Fairy'  , 'U', 'Undiscovered' , 15    , 3840, 46.7, 21.2, 'Slow', q'{head and arms}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Glameow]', 431   , 76 , 'Normal' , 3, 1 , 'Field' , 20  , 5355, 5140, 5120, 8.6, 3.9, 'Fast', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Wailord]', 321   , 100 , 'Water' , 1, 1 , 'Field', 'Water 2', 40 , 10496, 10455, 10280, 10240, 877.4, 398, 'Fluctuating', q'{fins}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Comfey]', 764   , 174 , 'Fairy' , 3, 1 , 'Grass' , 20    , 5120, 0.7, 0.3, 'Fast', q'{head}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Golisopod]', 768   , 183 , 'Bug', 'Water', 1, 1 , 'Bug', 'Water 3', 20    , 5120, 238.1, 108, 'Medium Fast', q'{bipedal, tailless form}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Panpour]', 515   , 21 , 'Water' , 1, 7 , 'Field' , 20   , 5140, 5120, 29.8, 13.5, 'Medium Fast', q'{bipedal, tailed form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Naganadel]', 804   , 262 , 'Poison', 'Dragon'  , 'U', 'Undiscovered' , 120    , 30720, 330.7, 150, 'Slow', q'{single pair of wings}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Relicanth]', 369   , 179 , 'Water', 'Rock', 1, 7 , 'Water 1', 'Water 2', 40 , 10496, 10455, 10280, 10240, 51.6, 23.4, 'Slow', q'{fins}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Sandshrew]', 27   , 27 , 'Ground' , 1, 1 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 26.5, 12, 'Medium Fast', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type , Female  , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Flabébé]', 669  , q'|Yellow Flower|', 68, 'Ce', 'Fairy' , 1  , 'Fairy' , 20   , 5140, 5120, 0.2, 0.1, 'Medium Fast', q'{head and arms}', 6 );     
insert into Pokemon( Name, Dex  , Class  , Type   , Unbreedable, EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Arceus]', 493  , q'|Type: Electric|'  , 'Normal'   , 'U', 'Undiscovered' , 120  , 30855, 30840, 30720, 705.5, 320, 'Slow', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type, Type2, Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Sableye]', 302, 'M', nq'|Sablenite|', q'|Mega|', 68 , 'Dark', 'Ghost', 1, 1 , 'Human-Like' , 25 , 6656, 6630, 6425, 6400, 24.3, 11, 'Medium Slow', q'{bipedal, tailless form}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Grovyle]', 253   , 2 , 'Grass' , 1, 7 , 'Monster', 'Dragon', 20 , 5376, 5355, 5140, 5120, 47.6, 21.6, 'Medium Slow', q'{bipedal, tailed form}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type  , Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Nidorino]', 33   , 33 , 'Poison'  , 1 , 'Monster', 'Field', 20, 5120, 5376, 5355, 5140, 5120, 43, 19.5, 'Medium Slow', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Hippopotas]', 449   , 122 , 'Ground' , 1, 1 , 'Field' , 30  , 7905, 7710, 7680, 109.1, 49.5, 'Slow', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Simipour]', 516   , 22 , 'Water' , 1, 7 , 'Field' , 20   , 5140, 5120, 63.9, 29, 'Medium Fast', q'{bipedal, tailed form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Omastar]', 139   , 139 , 'Rock', 'Water', 1, 7 , 'Water 1', 'Water 3', 30, 7680, 7936, 7905, 7710, 7680, 77.2, 35, 'Medium Fast', q'{tentacles or a multiped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Stunfisk]', 618   , 124 , 'Ground', 'Electric', 1, 1 , 'Water 1', 'Amorphous', 20   , 5140, 5120, 24.3, 11, 'Medium Fast', q'{fins}', 5 );     
insert into Pokemon( Name, Dex  , Class  , Type   , Unbreedable, EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Arceus]', 493  , q'|Type: Poison|'  , 'Normal'   , 'U', 'Undiscovered' , 120  , 30855, 30840, 30720, 705.5, 320, 'Slow', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Muk]', 89   , 89 , 'Poison' , 1, 1 , 'Amorphous' , 20, 5120, 5376, 5355, 5140, 5120, 66.1, 30, 'Medium Fast', q'{head and arms}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Krokorok]', 552   , 58 , 'Ground', 'Dark', 1, 1 , 'Field' , 20   , 5140, 5120, 73.6, 33.4, 'Medium Slow', q'{quadruped body}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Slaking]', 289   , 38 , 'Normal' , 1, 1 , 'Field' , 15 , 4096, 4080, 3855, 3840, 287.7, 130.5, 'Slow', q'{bipedal, tailless form}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Caterpie]', 10   , 10 , 'Bug' , 1, 1 , 'Bug' , 15, 3840, 4096, 4080, 3855, 3840, 6.4, 2.9, 'Medium Fast', q'{insectoid body}', 1 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Castform]', 351  , q'|Normal|', 142 , 'Normal' , 1, 1 , 'Fairy', 'Amorphous', 25 , 6656, 6630, 6425, 6400, 1.8, 0.8, 'Medium Fast', q'{head}', 3 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class, LDex, LDex_Suffix, Type, Type2  , Unbreedable, EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Hoopa]', 720, 'U' , q'|Unbound|', 152, 'Ce', 'Psychic', 'Dark'  , 'U', 'Undiscovered' , 120   , 30840, 30720, 1080.3, 490, 'Slow', q'{bipedal, tailed form}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2   , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Magneton]', 82   , 82 , 'Electric', 'Steel'   , 'Mineral' , 20, 5120, 5376, 5355, 5140, 5120, 132.3, 60, 'Medium Fast', q'{multiple bodies}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Kingdra]', 230   , 192 , 'Water', 'Dragon', 1, 1 , 'Water 1', 'Dragon', 20, 5120, 5376, 5355, 5140, 5120, 335.1, 152, 'Medium Fast', q'{head and a base}', 2 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class  , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Golem]', 76, 'A' , q'|Alolan|'  , 'Rock', 'Electric', 1, 1 , 'Mineral' , 15, 3840, 4096, 4080, 3855, 3840, 661.4, 300, 'Medium Slow', q'{bipedal, tailless form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Azumarill]', 184   , 133 , 'Water', 'Fairy', 1, 1 , 'Water 1', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 62.8, 28.5, 'Fast', q'{bipedal, tailed form}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Vaporeon]', 134   , 134 , 'Water' , 1, 7 , 'Field' , 35, 8960, 9216, 9180, 8995, 8960, 63.9, 29, 'Medium Fast', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pyroar]', 668   , 58, 'Ce', 'Fire', 'Normal', 7, 1 , 'Field' , 20   , 5140, 5120, 179.7, 81.5, 'Medium Slow', q'{quadruped body}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Delibird]', 225   , 194 , 'Ice', 'Flying', 1, 1 , 'Water 1', 'Field', 20, 5120, 5376, 5355, 5140, 5120, 35.3, 16, 'Fast', q'{single pair of wings}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type   , Unbreedable, EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Ditto]', 132   , 132 , 'Normal'   , 'U*', 'Ditto' , 20, 5120, 5376, 5355, 5140, 5120, 8.8, 4, 'Medium Fast', q'{head}', 1 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type , Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Wishiwashi]', 746  , q'|Solo Form|', 110 , 'Water' , 1, 1 , 'Water 2' , 15    , 3840, 0.7, 0.3, 'Fast', q'{fins}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type   , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Poipole]', 803   , 261 , 'Poison'   , 'U', 'Undiscovered' , 120    , 30720, 4, 1.8, 'Slow', q'{bipedal, tailed form}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Plusle]', 311   , 80 , 'Electric' , 1, 1 , 'Fairy' , 20 , 5376, 5355, 5140, 5120, 9.3, 4.2, 'Medium Fast', q'{bipedal, tailed form}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female , Unbreedable, EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Latias]', 380   , 196 , 'Dragon', 'Psychic', 1 , 'U', 'Undiscovered' , 120 , 30976, 30855, 30840, 30720, 88.2, 40, 'Slow', q'{single pair of wings}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Weezing]', 110   , 110 , 'Poison' , 1, 1 , 'Amorphous' , 20, 5120, 5376, 5355, 5140, 5120, 20.9, 9.5, 'Medium Fast', q'{multiple bodies}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Sewaddle]', 540   , 46 , 'Bug', 'Grass', 1, 1 , 'Bug' , 15   , 3855, 3840, 5.5, 2.5, 'Medium Slow', q'{insectoid body}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Krabby]', 98   , 98 , 'Water' , 1, 1 , 'Water 3' , 20, 5120, 5376, 5355, 5140, 5120, 14.3, 6.5, 'Medium Fast', q'{insectoid body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Altaria]', 334   , 122 , 'Dragon', 'Flying', 1, 1 , 'Flying', 'Dragon', 20 , 5376, 5355, 5140, 5120, 45.4, 20.6, 'Erratic', q'{single pair of wings}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Terrakion]', 639   , 145 , 'Rock', 'Fighting'  , 'U', 'Undiscovered' , 80   , 20560, 20480, 573.2, 260, 'Slow', q'{quadruped body}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female  , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Bounsweet]', 761   , 171 , 'Grass' , 1  , 'Grass' , 20    , 5120, 7.1, 3.2, 'Medium Slow', q'{head and legs}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Magmar]', 126   , 126 , 'Fire' , 1, 3 , 'Human-Like' , 25, 6400, 6656, 6630, 6425, 6400, 98.1, 44.5, 'Medium Fast', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type   , Unbreedable, EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Mewtwo]', 150   , 150 , 'Psychic'   , 'U', 'Undiscovered' , 120, 30720, 30976, 30855, 30840, 30720, 269, 122, 'Slow', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pidgey]', 16   , 16 , 'Normal', 'Flying', 1, 1 , 'Flying' , 15, 3840, 4096, 4080, 3855, 3840, 4, 1.8, 'Medium Slow', q'{single pair of wings}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Seel]', 86   , 86 , 'Water' , 1, 1 , 'Water 1', 'Field', 20, 5120, 5376, 5355, 5140, 5120, 198.4, 90, 'Medium Fast', q'{fins}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Bewear]', 760   , 170 , 'Normal', 'Fighting', 1, 1 , 'Field' , 15    , 3840, 297.6, 135, 'Medium Fast', q'{bipedal, tailed form}', 7 );     
insert into Pokemon( Name, Dex  , Class  , Type   , Unbreedable, EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Arceus]', 493  , q'|Type: Flying|'  , 'Normal'   , 'U', 'Undiscovered' , 120  , 30855, 30840, 30720, 705.5, 320, 'Slow', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type , Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Clawitzer]', 693   , 33, 'Co', 'Water' , 1, 1 , 'Water 1', 'Water 3', 15   , 3855, 3840, 77.8, 35.3, 'Slow', q'{serpentine bodies}', 6 );     
insert into Pokemon( Name, Dex  , Class  , Type   , Unbreedable, EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Arceus]', 493  , q'|Type: Psychic|'  , 'Normal'   , 'U', 'Undiscovered' , 120  , 30855, 30840, 30720, 705.5, 320, 'Slow', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Dustox]', 269   , 18 , 'Bug', 'Poison', 1, 1 , 'Bug' , 15 , 4096, 4080, 3855, 3840, 69.7, 31.6, 'Medium Fast', q'{two or more pairs of wings}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Ribombee]', 743   , 84 , 'Bug', 'Fairy', 1, 1 , 'Bug', 'Fairy', 20    , 5120, 1.1, 0.5, 'Medium Fast', q'{two or more pairs of wings}', 7 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Vivillon]', 666  , q'|Elegant Pattern|', 22, 'Ce', 'Bug', 'Flying', 1, 1 , 'Bug' , 15   , 3855, 3840, 37.5, 17, 'Medium Fast', q'{two or more pairs of wings}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Xatu]', 178   , 162 , 'Psychic', 'Flying', 1, 1 , 'Flying' , 20, 5120, 5376, 5355, 5140, 5120, 33.1, 15, 'Medium Fast', q'{single pair of wings}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2   , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Magnemite]', 81   , 81 , 'Electric', 'Steel'   , 'Mineral' , 20, 5120, 5376, 5355, 5140, 5120, 13.2, 6, 'Medium Fast', q'{head and arms}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Rampardos]', 409   , 37 , 'Rock' , 1, 7 , 'Monster' , 30  , 7905, 7710, 7680, 226, 102.5, 'Erratic', q'{bipedal, tailed form}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Venonat]', 48   , 48 , 'Bug', 'Poison', 1, 1 , 'Bug' , 20, 5120, 5376, 5355, 5140, 5120, 66.1, 30, 'Medium Fast', q'{bipedal, tailless form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Whirlipede]', 544   , 50 , 'Bug', 'Poison', 1, 1 , 'Bug' , 15   , 3855, 3840, 129, 58.5, 'Medium Slow', q'{head}', 5 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class  , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Rattata]', 19, 'A' , q'|Alolan|'  , 'Dark', 'Normal', 1, 1 , 'Field' , 15, 3840, 4096, 4080, 3855, 3840, 7.7, 3.5, 'Medium Fast', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female , Unbreedable, EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Nidoqueen]', 31   , 31 , 'Poison', 'Ground', 1 , 'U', 'Undiscovered' , 20, 5120, 5376, 5355, 5140, 5120, 132.3, 60, 'Medium Slow', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Zweilous]', 634   , 140 , 'Dark', 'Dragon', 1, 1 , 'Dragon' , 40   , 10280, 10240, 110.2, 50, 'Slow', q'{quadruped body}', 5 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Klefki]', 707   , 50, 'Mo', 'Steel', 'Fairy', 1, 1 , 'Mineral' , 20   , 5140, 5120, 6.6, 3, 'Fast', q'{head}', 6 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Gyarados]', 130, 'M', nq'|Gyaradosite|', q'|Mega|', 130 , 'Water', 'Dark', 1, 1 , 'Water 2', 'Dragon', 5, 1280, 1536, 1530, 1285, 1280, 518.1, 235, 'Slow', q'{serpentine bodies}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Qwilfish]', 211   , 163 , 'Water', 'Poison', 1, 1 , 'Water 2' , 20, 5120, 5376, 5355, 5140, 5120, 8.6, 3.9, 'Medium Fast', q'{fins}', 2 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Glalie]', 362, 'M', nq'|Glalitite|', q'|Mega|', 172 , 'Ice' , 1, 1 , 'Fairy', 'Mineral', 20 , 5376, 5355, 5140, 5120, 565.5, 256.5, 'Medium Fast', q'{head}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female , Unbreedable, EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Smoochum]', 238   , 154 , 'Ice', 'Psychic', 1 , 'U', 'Undiscovered' , 25, 6400, 6656, 6630, 6425, 6400, 13.2, 6, 'Medium Fast', q'{bipedal, tailless form}', 2 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class, LDex , Type, Type2, Female  , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Wormadam]', 413, 'S' , q'|Trash Cloak|', 46 , 'Bug', 'Steel', 1  , 'Bug' , 15  , 4080, 3855, 3840, 14.3, 6.5, 'Medium Fast', q'{head and a base}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Honchkrow]', 430   , 75 , 'Dark', 'Flying', 1, 1 , 'Flying' , 20  , 5355, 5140, 5120, 60.2, 27.3, 'Medium Slow', q'{single pair of wings}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Larvitar]', 246   , 249 , 'Rock', 'Ground', 1, 1 , 'Monster' , 40, 10240, 10496, 10455, 10280, 10240, 158.7, 72, 'Slow', q'{bipedal, tailed form}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Emolga]', 587   , 93 , 'Electric', 'Flying', 1, 1 , 'Field' , 20   , 5140, 5120, 11, 5, 'Medium Fast', q'{quadruped body}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Hippowdon]', 450   , 123 , 'Ground' , 1, 1 , 'Field' , 30  , 7905, 7710, 7680, 661.4, 300, 'Slow', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Goodra]', 706   , 21, 'Mo', 'Dragon' , 1, 1 , 'Dragon' , 40   , 10280, 10240, 331.8, 150.5, 'Slow', q'{bipedal, tailed form}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Empoleon]', 395   , 9 , 'Water', 'Steel', 1, 7 , 'Water 1', 'Field', 20  , 5355, 5140, 5120, 186.3, 84.5, 'Medium Slow', q'{bipedal, tailed form}', 4 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class, LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Kyurem]', 646, 'W' , q'|White|', 152 , 'Dragon', 'Ice'  , 'U', 'Undiscovered' , 120   , 30840, 30720, 716.5, 325, 'Slow', q'{bipedal, tailed form}', 5 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Deerling]', 585  , q'|Spring Form|', 91 , 'Normal', 'Grass', 1, 1 , 'Field' , 20   , 5140, 5120, 43, 19.5, 'Medium Fast', q'{quadruped body}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Dratini]', 147   , 147 , 'Dragon' , 1, 1 , 'Water 1', 'Dragon', 40, 10240, 10496, 10455, 10280, 10240, 7.3, 3.3, 'Slow', q'{serpentine bodies}', 1 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class  , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Diglett]', 50, 'A' , q'|Alolan|'  , 'Ground', 'Steel', 1, 1 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 1.8, 0.8, 'Medium Fast', q'{head and a base}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Tapu Lele]', 786   , 286 , 'Psychic', 'Fairy'  , 'U', 'Undiscovered' , 15    , 3840, 41, 18.6, 'Slow', q'{head and arms}', 7 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Furfrou]', 676  , q'|Natural Form|', 93, 'Ce', 'Normal' , 1, 1 , 'Field' , 20   , 5140, 5120, 61.7, 28, 'Medium Fast', q'{quadruped body}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female  , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Vespiquen]', 416   , 54 , 'Bug', 'Flying', 1  , 'Bug' , 15  , 4080, 3855, 3840, 84.9, 38.5, 'Medium Slow', q'{two or more pairs of wings}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Cubone]', 104   , 104 , 'Ground' , 1, 1 , 'Monster' , 20, 5120, 5376, 5355, 5140, 5120, 14.3, 6.5, 'Medium Fast', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2   , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Dhelmise]', 781   , 263 , 'Ghost', 'Grass'   , 'Mineral' , 25    , 6400, 463, 210, 'Medium Fast', q'{head and a base}', 7 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pumpkaboo]', 710  , q'|Large Size|', 63, 'Mo', 'Ghost', 'Grass', 1, 1 , 'Amorphous' , 20   , 5140, 5120, 16.5, 7.5, 'Medium Fast', q'{head}', 6 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type, Type2, Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Mimikyu]', 778  , q'|Busted Form|', 242 , 'Ghost', 'Fairy', 1, 1 , 'Amorphous' , 20    , 5120, 1.5, 0.7, 'Medium Fast', q'{serpentine bodies}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male, Unbreedable, EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pichu]', 172   , 21 , 'Electric' , 1, 1, 'U', 'Undiscovered' , 10, 2560, 2816, 2805, 2570, 2560, 4.4, 2, 'Medium Fast', q'{quadruped body}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type  , Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Sawk]', 539   , 45 , 'Fighting'  , 1 , 'Human-Like' , 20   , 5140, 5120, 112.4, 51, 'Medium Fast', q'{bipedal, tailless form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Buzzwole]', 794   , 294 , 'Bug', 'Fighting'  , 'U', 'Undiscovered' , 120    , 30720, 735.5, 333.6, 'Slow', q'{tentacles or a multiped body}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Seismitoad]', 537   , 43 , 'Water', 'Ground', 1, 1 , 'Water 1' , 20   , 5140, 5120, 136.7, 62, 'Medium Slow', q'{bipedal, tailless form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Sudowoodo]', 185   , 107 , 'Rock' , 1, 1 , 'Mineral' , 20, 5120, 5376, 5355, 5140, 5120, 83.8, 38, 'Medium Fast', q'{bipedal, tailless form}', 2 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Litleo]', 667   , 57, 'Ce', 'Fire', 'Normal', 7, 1 , 'Field' , 20   , 5140, 5120, 29.8, 13.5, 'Medium Slow', q'{quadruped body}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type   , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Cosmoem]', 790   , 290 , 'Psychic'   , 'U', 'Undiscovered' , 120    , 30720, 2204.4, 999.9, 'Slow', q'{head}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Zoroark]', 571   , 77 , 'Dark' , 1, 7 , 'Field' , 20   , 5140, 5120, 178.8, 81.1, 'Medium Slow', q'{bipedal, tailed form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Poliwag]', 60   , 60 , 'Water' , 1, 1 , 'Water 1' , 20, 5120, 5376, 5355, 5140, 5120, 27.3, 12.4, 'Medium Slow', q'{head and legs}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Genesect]', 649   , 155 , 'Bug', 'Steel'  , 'U', 'Undiscovered' , 120   , 30840, 30720, 181.9, 82.5, 'Slow', q'{bipedal, tailless form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Metapod]', 11   , 11 , 'Bug' , 1, 1 , 'Bug' , 15, 3840, 4096, 4080, 3855, 3840, 21.8, 9.9, 'Medium Fast', q'{serpentine bodies}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Lotad]', 270   , 19 , 'Water', 'Grass', 1, 1 , 'Water 1', 'Grass', 15 , 4096, 4080, 3855, 3840, 5.7, 2.6, 'Medium Slow', q'{insectoid body}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Combee]', 415   , 53 , 'Bug', 'Flying', 1, 7 , 'Bug' , 15  , 4080, 3855, 3840, 12.1, 5.5, 'Medium Slow', q'{multiple bodies}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Slakoth]', 287   , 36 , 'Normal' , 1, 1 , 'Field' , 15 , 4096, 4080, 3855, 3840, 52.9, 24, 'Slow', q'{quadruped body}', 3 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Magearna]', 801  , q'|Original Color|', 301 , 'Steel', 'Fairy'  , 'U', 'Undiscovered' , 120    , 30720, 177.5, 80.5, 'Slow', q'{bipedal, tailless form}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Sceptile]', 254   , 3 , 'Grass' , 1, 7 , 'Monster', 'Dragon', 20 , 5376, 5355, 5140, 5120, 115.1, 52.2, 'Medium Slow', q'{bipedal, tailed form}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Lanturn]', 171   , 177 , 'Water', 'Electric', 1, 1 , 'Water 2' , 20, 5120, 5376, 5355, 5140, 5120, 49.6, 22.5, 'Slow', q'{fins}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Incineroar]', 727   , 6 , 'Fire', 'Dark', 1, 7 , 'Field' , 15    , 3840, 183, 83, 'Medium Slow', q'{bipedal, tailed form}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Oddish]', 43   , 43 , 'Grass', 'Poison', 1, 1 , 'Grass' , 20, 5120, 5376, 5355, 5140, 5120, 11.9, 5.4, 'Medium Slow', q'{head and legs}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Magearna]', 801   , 301 , 'Steel', 'Fairy'  , 'U', 'Undiscovered' , 120    , 30720, 177.5, 80.5, 'Slow', q'{bipedal, tailless form}', 7 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type, Type2, Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Oricorio]', 741  , q'|Baile Style|', 82 , 'Fire', 'Flying', 3, 1 , 'Flying' , 20    , 5120, 7.5, 3.4, 'Medium Fast', q'{single pair of wings}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Ursaring]', 217   , 199 , 'Normal' , 1, 1 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 277.3, 125.8, 'Medium Fast', q'{bipedal, tailed form}', 2 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class, LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Shellos]', 422, 'E' , q'|East Sea|', 60 , 'Water' , 1, 1 , 'Water 1', 'Amorphous', 20  , 5355, 5140, 5120, 13.9, 6.3, 'Medium Fast', q'{serpentine bodies}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Jangmo-o]', 782   , 271 , 'Dragon' , 1, 1 , 'Dragon' , 40    , 10240, 65.5, 29.7, 'Slow', q'{quadruped body}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type  , Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Nidoran♂]', 32   , 32 , 'Poison'  , 1 , 'Monster', 'Field', 20, 5120, 5376, 5355, 5140, 5120, 19.8, 9, 'Medium Slow', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Inkay]', 686   , 10, 'Co', 'Dark', 'Psychic', 1, 1 , 'Water 1', 'Water 2', 20   , 5140, 5120, 7.7, 3.5, 'Medium Fast', q'{tentacles or a multiped body}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Silcoon]', 266   , 15 , 'Bug' , 1, 1 , 'Bug' , 15 , 4096, 4080, 3855, 3840, 22, 10, 'Medium Fast', q'{head}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Shelgon]', 372   , 188 , 'Dragon' , 1, 1 , 'Dragon' , 40 , 10496, 10455, 10280, 10240, 243.6, 110.5, 'Slow', q'{quadruped body}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Abomasnow]', 460   , 143 , 'Grass', 'Ice', 1, 1 , 'Monster', 'Grass', 20  , 5355, 5140, 5120, 298.7, 135.5, 'Slow', q'{bipedal, tailed form}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Spiritomb]', 442   , 108 , 'Ghost', 'Dark', 1, 1 , 'Amorphous' , 30  , 7905, 7710, 7680, 238.1, 108, 'Medium Fast', q'{head and a base}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type   , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Xurkitree]', 796   , 296 , 'Electric'   , 'U', 'Undiscovered' , 120    , 30720, 220.5, 100, 'Slow', q'{bipedal, tailed form}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Chandelure]', 609   , 115 , 'Ghost', 'Fire', 1, 1 , 'Amorphous' , 20   , 5140, 5120, 75.6, 34.3, 'Medium Slow', q'{head and arms}', 5 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type   , Unbreedable, EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Kyogre]', 382, 'P', nq'|Blue Orb|', q'|Primal|', 198 , 'Water'   , 'U', 'Undiscovered' , 120 , 30976, 30855, 30840, 30720, 776, 352, 'Slow', q'{fins}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Herdier]', 507   , 13 , 'Normal' , 1, 1 , 'Field' , 15   , 3855, 3840, 32.4, 14.7, 'Medium Slow', q'{quadruped body}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Sunkern]', 191   , 103 , 'Grass' , 1, 1 , 'Grass' , 20, 5120, 5376, 5355, 5140, 5120, 4, 1.8, 'Medium Slow', q'{head}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Tapu Bulu]', 787   , 287 , 'Grass', 'Fairy'  , 'U', 'Undiscovered' , 15    , 3840, 100.3, 45.5, 'Slow', q'{head and arms}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Solosis]', 577   , 83 , 'Psychic' , 1, 1 , 'Amorphous' , 20   , 5140, 5120, 2.2, 1, 'Medium Slow', q'{head}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Joltik]', 595   , 101 , 'Bug', 'Electric', 1, 1 , 'Bug' , 20   , 5140, 5120, 1.3, 0.6, 'Medium Fast', q'{insectoid body}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Guzzlord]', 799   , 299 , 'Dark', 'Dragon'  , 'U', 'Undiscovered' , 120    , 30720, 1957.7, 888, 'Slow', q'{bipedal, tailed form}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Bulbasaur]', 1   , 1 , 'Grass', 'Poison', 1, 7 , 'Monster', 'Grass', 20, 5120, 5376, 5355, 5140, 5120, 15.2, 6.9, 'Medium Slow', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type    , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Klink]', 599   , 105 , 'Steel'    , 'Mineral' , 20   , 5140, 5120, 46.3, 21, 'Medium Slow', q'{multiple bodies}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Skuntank]', 435   , 85 , 'Poison', 'Dark', 1, 1 , 'Field' , 20  , 5355, 5140, 5120, 83.8, 38, 'Medium Fast', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type , Female  , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Floette]', 670  , q'|White Flower|', 69, 'Ce', 'Fairy' , 1  , 'Fairy' , 20   , 5140, 5120, 2, 0.9, 'Medium Fast', q'{head and arms}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Cutiefly]', 742   , 83 , 'Bug', 'Fairy', 1, 1 , 'Bug', 'Fairy', 20    , 5120, 0.4, 0.2, 'Medium Fast', q'{insectoid body}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pansear]', 513   , 19 , 'Fire' , 1, 7 , 'Field' , 20   , 5140, 5120, 24.3, 11, 'Medium Fast', q'{bipedal, tailed form}', 5 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Meowstic]', 678   , 115, 'Ce', 'Psychic' , 1, 1 , 'Field' , 20   , 5140, 5120, 18.7, 8.5, 'Medium Fast', q'{bipedal, tailed form}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Leafeon]', 470   , 169 , 'Grass' , 1, 7 , 'Field' , 35  , 9180, 8995, 8960, 56.2, 25.5, 'Medium Fast', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Granbull]', 210   , 126 , 'Fairy' , 3, 1 , 'Field', 'Fairy', 20, 5120, 5376, 5355, 5140, 5120, 107.4, 48.7, 'Fast', q'{bipedal, tailed form}', 2 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Scizor]', 212, 'M', nq'|Scizorite|', q'|Mega|', 112 , 'Bug', 'Steel', 1, 1 , 'Bug' , 25, 6400, 6656, 6630, 6425, 6400, 260.1, 118, 'Medium Fast', q'{two or more pairs of wings}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Poochyena]', 261   , 10 , 'Dark' , 1, 1 , 'Field' , 15 , 4096, 4080, 3855, 3840, 30, 13.6, 'Medium Fast', q'{quadruped body}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Kricketune]', 402   , 16 , 'Bug' , 1, 1 , 'Bug' , 15  , 4080, 3855, 3840, 56.2, 25.5, 'Medium Slow', q'{two or more pairs of wings}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Electrike]', 309   , 78 , 'Electric' , 1, 1 , 'Field' , 20 , 5376, 5355, 5140, 5120, 33.5, 15.2, 'Slow', q'{quadruped body}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Vikavolt]', 738   , 29 , 'Bug', 'Electric', 1, 1 , 'Bug' , 15    , 3840, 99.2, 45, 'Medium Fast', q'{insectoid body}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Toxapex]', 748   , 114 , 'Poison', 'Water', 1, 1 , 'Water 1' , 20    , 5120, 32, 14.5, 'Medium Fast', q'{tentacles or a multiped body}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Flareon]', 136   , 136 , 'Fire' , 1, 7 , 'Field' , 35, 8960, 9216, 9180, 8995, 8960, 55.1, 25, 'Medium Fast', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Sandslash]', 28   , 28 , 'Ground' , 1, 1 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 65, 29.5, 'Medium Fast', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Reuniclus]', 579   , 85 , 'Psychic' , 1, 1 , 'Amorphous' , 20   , 5140, 5120, 44.3, 20.1, 'Medium Slow', q'{head and arms}', 5 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pikachu]', 25  , q'|Pikachu, Ph. D|', 25 , 'Electric' , 1, 1 , 'Field', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 13.2, 6, 'Medium Fast', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Corsola]', 222   , 173 , 'Water', 'Rock', 3, 1 , 'Water 1', 'Water 3', 20, 5120, 5376, 5355, 5140, 5120, 11, 5, 'Fast', q'{insectoid body}', 2 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Steelix]', 208, 'M', nq'|Steelixite|', q'|Mega|', 63 , 'Steel', 'Ground', 1, 1 , 'Mineral' , 25, 6400, 6656, 6630, 6425, 6400, 881.8, 400, 'Medium Fast', q'{serpentine bodies}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Crobat]', 169   , 39 , 'Poison', 'Flying', 1, 1 , 'Flying' , 15, 3840, 4096, 4080, 3855, 3840, 165.3, 75, 'Medium Fast', q'{two or more pairs of wings}', 2 );     
insert into Pokemon( Name, Dex     , Type, Type2, Female, Male, Unbreedable, EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Heatran]', 485     , 'Fire', 'Steel', 1, 1, 'U', 'Undiscovered' , 10  , 2805, 2570, 2560, 948, 430, 'Slow', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Gible]', 443   , 109 , 'Dragon', 'Ground', 1, 1 , 'Monster', 'Dragon', 40  , 10455, 10280, 10240, 45.2, 20.5, 'Slow', q'{bipedal, tailed form}', 4 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class  , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Vulpix]', 37, 'A' , q'|Alolan|'  , 'Ice' , 3, 1 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 21.8, 9.9, 'Medium Fast', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female , Unbreedable, EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Nidorina]', 30   , 30 , 'Poison' , 1 , 'U', 'Undiscovered' , 20, 5120, 5376, 5355, 5140, 5120, 44.1, 20, 'Medium Slow', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Graveler]', 75   , 75 , 'Rock', 'Ground', 1, 1 , 'Mineral' , 15, 3840, 4096, 4080, 3855, 3840, 231.5, 105, 'Medium Slow', q'{bipedal, tailless form}', 1 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Greninja]', 658   , 9, 'Ce', 'Water', 'Dark', 1, 7 , 'Water 1' , 20   , 5140, 5120, 88.2, 40, 'Medium Slow', q'{bipedal, tailless form}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Monferno]', 391   , 5 , 'Fire', 'Fighting', 1, 7 , 'Field', 'Human-Like', 20  , 5355, 5140, 5120, 48.5, 22, 'Medium Slow', q'{bipedal, tailed form}', 4 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type, Type2  , Unbreedable, EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Zygarde]', 718  , q'|50% Forme|', 150, 'Mo', 'Dragon', 'Ground'  , 'U', 'Undiscovered' , 120   , 30840, 30720, 672.4, 305, 'Slow', q'{serpentine bodies}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Feebas]', 349   , 140 , 'Water' , 1, 1 , 'Water 1', 'Dragon', 20 , 5376, 5355, 5140, 5120, 16.3, 7.4, 'Erratic', q'{fins}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Foongus]', 590   , 96 , 'Grass', 'Poison', 1, 1 , 'Grass' , 20   , 5140, 5120, 2.2, 1, 'Medium Fast', q'{head and arms}', 5 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Sawsbuck]', 586  , q'|Spring Form|', 92 , 'Normal', 'Grass', 1, 1 , 'Field' , 20   , 5140, 5120, 203.9, 92.5, 'Medium Fast', q'{quadruped body}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Accelgor]', 617   , 123 , 'Bug' , 1, 1 , 'Bug' , 15   , 3855, 3840, 55.8, 25.3, 'Medium Fast', q'{head and arms}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Kabuto]', 140   , 140 , 'Rock', 'Water', 1, 7 , 'Water 1', 'Water 3', 30, 7680, 7936, 7905, 7710, 7680, 25.4, 11.5, 'Medium Fast', q'{insectoid body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Mantine]', 226   , 202 , 'Water', 'Flying', 1, 1 , 'Water 1' , 25, 6400, 6656, 6630, 6425, 6400, 485, 220, 'Slow', q'{single pair of wings}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Weepinbell]', 70   , 70 , 'Grass', 'Poison', 1, 1 , 'Grass' , 20, 5120, 5376, 5355, 5140, 5120, 14.1, 6.4, 'Medium Slow', q'{head and a base}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Wimpod]', 767   , 182 , 'Bug', 'Water', 1, 1 , 'Bug', 'Water 3', 20    , 5120, 26.5, 12, 'Medium Fast', q'{tentacles or a multiped body}', 7 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class, LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Aegislash]', 681, 'B' , q'|Blade Forme|', 119, 'Ce', 'Steel', 'Ghost', 1, 1 , 'Mineral' , 20   , 5140, 5120, 116.8, 53, 'Medium Fast', q'{head and a base}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Clefairy]', 35   , 35 , 'Fairy' , 3, 1 , 'Fairy' , 10, 2560, 2816, 2805, 2570, 2560, 16.5, 7.5, 'Fast', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type   , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Silvally]', 773  , q'|Type: Fairy|', 204 , 'Normal'   , 'U', 'Undiscovered' , 120    , 30720, 221.6, 100.5, 'Slow', q'{quadruped body}', 7 );     
insert into Pokemon( Name, Dex     , Type    , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Phione]', 489     , 'Water'    , 'Water 1', 'Fairy', 40  , 10455, 10280, 10240, 6.8, 3.1, 'Slow', q'{head and arms}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Haunter]', 93   , 93 , 'Ghost', 'Poison', 1, 1 , 'Amorphous' , 20, 5120, 5376, 5355, 5140, 5120, 0.2, 0.1, 'Medium Slow', q'{head and arms}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Magmortar]', 467   , 202 , 'Fire' , 1, 3 , 'Human-Like' , 25  , 6630, 6425, 6400, 149.9, 68, 'Medium Fast', q'{bipedal, tailed form}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Carvanha]', 318   , 97 , 'Water', 'Dark', 1, 1 , 'Water 2' , 20 , 5376, 5355, 5140, 5120, 45.9, 20.8, 'Slow', q'{fins}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Wobbuffet]', 202   , 108 , 'Psychic' , 1, 1 , 'Amorphous' , 20, 5120, 5376, 5355, 5140, 5120, 62.8, 28.5, 'Medium Fast', q'{head and a base}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Garchomp]', 445   , 111 , 'Dragon', 'Ground', 1, 1 , 'Monster', 'Dragon', 40  , 10455, 10280, 10240, 209.4, 95, 'Slow', q'{bipedal, tailed form}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type   , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Type: Null]', 772   , 203 , 'Normal'   , 'U', 'Undiscovered' , 120    , 30720, 265.7, 120.5, 'Slow', q'{quadruped body}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Cubchoo]', 613   , 119 , 'Ice' , 1, 1 , 'Field' , 20   , 5140, 5120, 18.7, 8.5, 'Medium Fast', q'{bipedal, tailed form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Beautifly]', 267   , 16 , 'Bug', 'Flying', 1, 1 , 'Bug' , 15 , 4096, 4080, 3855, 3840, 62.6, 28.4, 'Medium Fast', q'{two or more pairs of wings}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Musharna]', 518   , 24 , 'Psychic' , 1, 1 , 'Field' , 10   , 2570, 2560, 133.4, 60.5, 'Fast', q'{bipedal, tailless form}', 5 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Swirlix]', 684   , 131, 'Ce', 'Fairy' , 1, 1 , 'Fairy' , 20   , 5140, 5120, 7.7, 3.5, 'Medium Fast', q'{head and legs}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female  , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Tsareena]', 763   , 173 , 'Grass' , 1  , 'Grass' , 20    , 5120, 47.2, 21.4, 'Medium Slow', q'{bipedal, tailless form}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Lampent]', 608   , 114 , 'Ghost', 'Fire', 1, 1 , 'Amorphous' , 20   , 5140, 5120, 28.7, 13, 'Medium Slow', q'{head and arms}', 5 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Helioptile]', 694   , 46, 'Co', 'Electric', 'Normal', 1, 1 , 'Monster', 'Dragon', 20   , 5140, 5120, 13.2, 6, 'Medium Fast', q'{bipedal, tailed form}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Ledyba]', 165   , 30 , 'Bug', 'Flying', 1, 1 , 'Bug' , 15, 3840, 4096, 4080, 3855, 3840, 23.8, 10.8, 'Fast', q'{single pair of wings}', 2 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class, LDex , Type   , Unbreedable, EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Deoxys]', 386, 'S' , q'|Speed Forme|', 202 , 'Psychic'   , 'U', 'Undiscovered' , 120 , 30976, 30855, 30840, 30720, 134, 60.8, 'Slow', q'{bipedal, tailless form}', 3 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Diggersby]', 660   , 11, 'Ce', 'Normal', 'Ground', 1, 1 , 'Field' , 15   , 3855, 3840, 93.5, 42.4, 'Medium Fast', q'{bipedal, tailed form}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Kecleon]', 352   , 145 , 'Normal' , 1, 1 , 'Field' , 20 , 5376, 5355, 5140, 5120, 48.5, 22, 'Medium Slow', q'{bipedal, tailed form}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Vanillish]', 583   , 89 , 'Ice' , 1, 1 , 'Mineral' , 20   , 5140, 5120, 90.4, 41, 'Slow', q'{head and a base}', 5 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Espurr]', 677   , 114, 'Ce', 'Psychic' , 1, 1 , 'Field' , 20   , 5140, 5120, 7.7, 3.5, 'Medium Fast', q'{bipedal, tailed form}', 6 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type, Type2   , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Rotom]', 479  , q'|Mow|', 152 , 'Electric', 'Ghost'   , 'Amorphous' , 20  , 5355, 5140, 5120, 0.7, 0.3, 'Medium Fast', q'{head}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Goldeen]', 118   , 118 , 'Water' , 1, 1 , 'Water 2' , 20, 5120, 5376, 5355, 5140, 5120, 33.1, 15, 'Medium Fast', q'{fins}', 1 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class, LDex , Type , Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Burmy]', 412, 'G' , q'|Sandy Cloak|', 45 , 'Bug' , 1, 1 , 'Bug' , 15  , 4080, 3855, 3840, 7.5, 3.4, 'Medium Fast', q'{head and a base}', 4 );     
insert into Pokemon( Name, Dex  , Class  , Type   , Unbreedable, EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Arceus]', 493  , q'|Type: Fire|'  , 'Normal'   , 'U', 'Undiscovered' , 120  , 30855, 30840, 30720, 705.5, 320, 'Slow', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type, Type2, Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Medicham]', 308, 'M', nq'|Medichamite|', q'|Mega|', 77 , 'Fighting', 'Psychic', 1, 1 , 'Human-Like' , 20 , 5376, 5355, 5140, 5120, 69.4, 31.5, 'Medium Fast', q'{bipedal, tailless form}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female  , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Nidoran♀]', 29   , 29 , 'Poison' , 1  , 'Monster', 'Field', 20, 5120, 5376, 5355, 5140, 5120, 15.4, 7, 'Medium Slow', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Heracross]', 214, 'M', nq'|Heracronite|', q'|Mega|', 114 , 'Bug', 'Fighting', 1, 1 , 'Bug' , 25, 6400, 6656, 6630, 6425, 6400, 119, 54, 'Slow', q'{bipedal, tailless form}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female  , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Chansey]', 113   , 113 , 'Normal' , 1  , 'Fairy' , 40, 10240, 10496, 10455, 10280, 10240, 76.3, 34.6, 'Fast', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2   , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Golurk]', 623   , 129 , 'Ground', 'Ghost'   , 'Mineral' , 25   , 6425, 6400, 727.5, 330, 'Medium Fast', q'{bipedal, tailless form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Wailmer]', 320   , 99 , 'Water' , 1, 1 , 'Field', 'Water 2', 40 , 10496, 10455, 10280, 10240, 286.6, 130, 'Fluctuating', q'{fins}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Gabite]', 444   , 110 , 'Dragon', 'Ground', 1, 1 , 'Monster', 'Dragon', 40  , 10455, 10280, 10240, 123.5, 56, 'Slow', q'{bipedal, tailed form}', 4 );     
insert into Pokemon( Name, Dex  , Class  , Type   , Unbreedable, EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Arceus]', 493  , q'|Type: Ground|'  , 'Normal'   , 'U', 'Undiscovered' , 120  , 30855, 30840, 30720, 705.5, 320, 'Slow', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Hoppip]', 187   , 67 , 'Grass', 'Flying', 1, 1 , 'Fairy', 'Grass', 20, 5120, 5376, 5355, 5140, 5120, 1.1, 0.5, 'Medium Slow', q'{bipedal, tailed form}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2   , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Magnezone]', 462   , 180 , 'Electric', 'Steel'   , 'Mineral' , 20  , 5355, 5140, 5120, 396.8, 180, 'Medium Fast', q'{head and arms}', 4 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Swampert]', 260, 'M', nq'|Swampertite|', q'|Mega|', 9 , 'Water', 'Ground', 1, 7 , 'Monster', 'Water 1', 20 , 5376, 5355, 5140, 5120, 180.6, 81.9, 'Medium Slow', q'{bipedal, tailed form}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Drifblim]', 426   , 66 , 'Ghost', 'Flying', 1, 1 , 'Amorphous' , 30  , 7905, 7710, 7680, 33.1, 15, 'Fluctuating', q'{head and arms}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Magcargo]', 219   , 217 , 'Fire', 'Rock', 1, 1 , 'Amorphous' , 20, 5120, 5376, 5355, 5140, 5120, 121.3, 55, 'Medium Fast', q'{serpentine bodies}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Ferroseed]', 597   , 103 , 'Grass', 'Steel', 1, 1 , 'Grass', 'Mineral', 20   , 5140, 5120, 41.5, 18.8, 'Medium Fast', q'{head}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Espeon]', 196   , 188 , 'Psychic' , 1, 7 , 'Field' , 35, 8960, 9216, 9180, 8995, 8960, 58.4, 26.5, 'Medium Fast', q'{quadruped body}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Araquanid]', 752   , 142 , 'Water', 'Bug', 1, 1 , 'Water 1', 'Bug', 15    , 3840, 180.8, 82, 'Medium Fast', q'{insectoid body}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Starly]', 396   , 10 , 'Normal', 'Flying', 1, 1 , 'Flying' , 15  , 4080, 3855, 3840, 4.4, 2, 'Medium Slow', q'{single pair of wings}', 4 );     
insert into Pokemon( Name, Dex  , Class  , Type   , Unbreedable, EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Arceus]', 493  , q'|Type: Water|'  , 'Normal'   , 'U', 'Undiscovered' , 120  , 30855, 30840, 30720, 705.5, 320, 'Slow', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Litwick]', 607   , 113 , 'Ghost', 'Fire', 1, 1 , 'Amorphous' , 20   , 5140, 5120, 6.8, 3.1, 'Medium Slow', q'{head and a base}', 5 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Bergmite]', 712   , 79, 'Mo', 'Ice' , 1, 1 , 'Monster' , 20   , 5140, 5120, 219.4, 99.5, 'Medium Fast', q'{quadruped body}', 6 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Vivillon]', 666  , q'|Modern Pattern|', 22, 'Ce', 'Bug', 'Flying', 1, 1 , 'Bug' , 15   , 3855, 3840, 37.5, 17, 'Medium Fast', q'{two or more pairs of wings}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Lombre]', 271   , 20 , 'Water', 'Grass', 1, 1 , 'Water 1', 'Grass', 15 , 4096, 4080, 3855, 3840, 71.6, 32.5, 'Medium Slow', q'{bipedal, tailless form}', 3 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class  , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Sandslash]', 28, 'A' , q'|Alolan|'  , 'Ice', 'Steel', 1, 1 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 65, 29.5, 'Medium Fast', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type , Female  , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Floette]', 670  , q'|Eternal Flower|', 69, 'Ce', 'Fairy' , 1  , 'Fairy' , 20   , 5140, 5120, 2, 0.9, 'Medium Fast', q'{head and arms}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Stunky]', 434   , 84 , 'Poison', 'Dark', 1, 1 , 'Field' , 20  , 5355, 5140, 5120, 42.3, 19.2, 'Medium Fast', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Dartrix]', 723   , 2 , 'Grass', 'Flying', 1, 7 , 'Flying' , 15    , 3840, 35.3, 16, 'Medium Slow', q'{single pair of wings}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Whiscash]', 340   , 128 , 'Water', 'Ground', 1, 1 , 'Water 2' , 20 , 5376, 5355, 5140, 5120, 52, 23.6, 'Medium Fast', q'{fins}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Machoke]', 67   , 67 , 'Fighting' , 1, 3 , 'Human-Like' , 20, 5120, 5376, 5355, 5140, 5120, 155.4, 70.5, 'Medium Slow', q'{bipedal, tailless form}', 1 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class, LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Castform]', 351, 'R' , q'|Rainy Form|', 142 , 'Water' , 1, 1 , 'Fairy', 'Amorphous', 25 , 6656, 6630, 6425, 6400, 1.8, 0.8, 'Medium Fast', q'{head}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Finneon]', 456   , 134 , 'Water' , 1, 1 , 'Water 2' , 20  , 5355, 5140, 5120, 15.4, 7, 'Erratic', q'{fins}', 4 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type , Female  , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Floette]', 670  , q'|Red Flower|', 69, 'Ce', 'Fairy' , 1  , 'Fairy' , 20   , 5140, 5120, 2, 0.9, 'Medium Fast', q'{head and arms}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female  , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Miltank]', 241   , 151 , 'Normal' , 1  , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 166.4, 75.5, 'Slow', q'{bipedal, tailed form}', 2 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type, Type2 , Male, Unbreedable, EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Latios]', 381, 'M', nq'|Latiosite|', q'|Mega|', 197 , 'Dragon', 'Psychic' , 1, 'U', 'Undiscovered' , 120 , 30976, 30855, 30840, 30720, 132.3, 60, 'Slow', q'{single pair of wings}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Drampa]', 780   , 244 , 'Normal', 'Dragon', 1, 1 , 'Monster', 'Dragon', 20    , 5120, 407.9, 185, 'Medium Fast', q'{serpentine bodies}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Yamask]', 562   , 68 , 'Ghost' , 1, 1 , 'Mineral', 'Amorphous', 25   , 6425, 6400, 3.3, 1.5, 'Medium Fast', q'{head and arms}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pinsir]', 127   , 127 , 'Bug' , 1, 1 , 'Bug' , 25, 6400, 6656, 6630, 6425, 6400, 121.3, 55, 'Slow', q'{bipedal, tailless form}', 1 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Vivillon]', 666  , q'|Tundra Pattern|', 22, 'Ce', 'Bug', 'Flying', 1, 1 , 'Bug' , 15   , 3855, 3840, 37.5, 17, 'Medium Fast', q'{two or more pairs of wings}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Manectric]', 310   , 79 , 'Electric' , 1, 1 , 'Field' , 20 , 5376, 5355, 5140, 5120, 88.6, 40.2, 'Slow', q'{quadruped body}', 3 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Altaria]', 334, 'M', nq'|Altarianite|', q'|Mega|', 122 , 'Dragon', 'Fairy', 1, 1 , 'Flying', 'Dragon', 20 , 5376, 5355, 5140, 5120, 45.4, 20.6, 'Erratic', q'{single pair of wings}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Yanma]', 193   , 101 , 'Bug', 'Flying', 1, 1 , 'Bug' , 20, 5120, 5376, 5355, 5140, 5120, 83.8, 38, 'Medium Fast', q'{two or more pairs of wings}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Skiploom]', 188   , 68 , 'Grass', 'Flying', 1, 1 , 'Fairy', 'Grass', 20, 5120, 5376, 5355, 5140, 5120, 2.2, 1, 'Medium Slow', q'{bipedal, tailed form}', 2 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Spewpa]', 665   , 21, 'Ce', 'Bug' , 1, 1 , 'Bug' , 15   , 3855, 3840, 18.5, 8.4, 'Medium Fast', q'{head and a base}', 6 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Giratina]', 487  , q'|Altered Forme|', 210 , 'Ghost', 'Dragon'  , 'U', 'Undiscovered' , 120  , 30855, 30840, 30720, 1653.5, 750, 'Slow', q'{tentacles or a multiped body}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Shellder]', 90   , 90 , 'Water' , 1, 1 , 'Water 3' , 20, 5120, 5376, 5355, 5140, 5120, 8.8, 4, 'Slow', q'{head}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Poliwhirl]', 61   , 61 , 'Water' , 1, 1 , 'Water 1' , 20, 5120, 5376, 5355, 5140, 5120, 44.1, 20, 'Medium Slow', q'{bipedal, tailless form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Corphish]', 341   , 129 , 'Water' , 1, 1 , 'Water 1', 'Water 3', 15 , 4096, 4080, 3855, 3840, 25.4, 11.5, 'Fluctuating', q'{insectoid body}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Gurdurr]', 533   , 39 , 'Fighting' , 1, 3 , 'Human-Like' , 20   , 5140, 5120, 88.2, 40, 'Medium Slow', q'{bipedal, tailless form}', 5 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Dedenne]', 702   , 110, 'Co', 'Electric', 'Fairy', 1, 1 , 'Field', 'Fairy', 20   , 5140, 5120, 4.9, 2.2, 'Medium Fast', q'{bipedal, tailed form}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Lickilicky]', 463   , 162 , 'Normal' , 1, 1 , 'Monster' , 20  , 5355, 5140, 5120, 308.6, 140, 'Medium Fast', q'{bipedal, tailless form}', 4 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Fennekin]', 653   , 4, 'Ce', 'Fire' , 1, 7 , 'Field' , 20   , 5140, 5120, 20.7, 9.4, 'Medium Slow', q'{quadruped body}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Mismagius]', 429   , 73 , 'Ghost' , 1, 1 , 'Amorphous' , 25  , 6630, 6425, 6400, 9.7, 4.4, 'Fast', q'{head}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Emboar]', 500   , 6 , 'Fire', 'Fighting', 1, 7 , 'Field' , 20   , 5140, 5120, 330.7, 150, 'Medium Slow', q'{bipedal, tailed form}', 5 );     
insert into Pokemon( Name, Dex  , Class  , Type   , Unbreedable, EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Arceus]', 493  , q'|Type: Normal|'  , 'Normal'   , 'U', 'Undiscovered' , 120  , 30855, 30840, 30720, 705.5, 320, 'Slow', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Spritzee]', 682   , 129, 'Ce', 'Fairy' , 1, 1 , 'Fairy' , 20   , 5140, 5120, 1.1, 0.5, 'Medium Fast', q'{head and arms}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Hariyama]', 297   , 49 , 'Fighting' , 1, 3 , 'Human-Like' , 20 , 5376, 5355, 5140, 5120, 559.5, 253.8, 'Fluctuating', q'{bipedal, tailless form}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Yungoos]', 734   , 13 , 'Normal' , 1, 1 , 'Field' , 15    , 3840, 13.2, 6, 'Medium Fast', q'{quadruped body}', 7 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type, Type2, Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Sharpedo]', 319, 'M', nq'|Sharpedonite|', q'|Mega|', 98 , 'Water', 'Dark', 1, 1 , 'Water 2' , 20 , 5376, 5355, 5140, 5120, 195.8, 88.8, 'Slow', q'{fins}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Numel]', 322   , 101 , 'Fire', 'Ground', 1, 1 , 'Field' , 20 , 5376, 5355, 5140, 5120, 52.9, 24, 'Medium Fast', q'{quadruped body}', 3 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Furfrou]', 676  , q'|Diamond Trim|', 93, 'Ce', 'Normal' , 1, 1 , 'Field' , 20   , 5140, 5120, 61.7, 28, 'Medium Fast', q'{quadruped body}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Garbodor]', 569   , 75 , 'Poison' , 1, 1 , 'Mineral' , 20   , 5140, 5120, 236.6, 107.3, 'Medium Fast', q'{bipedal, tailless form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Rapidash]', 78   , 78 , 'Fire' , 1, 1 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 209.4, 95, 'Medium Fast', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Tangela]', 114   , 114 , 'Grass' , 1, 1 , 'Grass' , 20, 5120, 5376, 5355, 5140, 5120, 77.2, 35, 'Medium Fast', q'{head and legs}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Remoraid]', 223   , 174 , 'Water' , 1, 1 , 'Water 1', 'Water 2', 20, 5120, 5376, 5355, 5140, 5120, 26.5, 12, 'Medium Fast', q'{fins}', 2 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Banette]', 354, 'M', nq'|Banettite|', q'|Mega|', 147 , 'Ghost' , 1, 1 , 'Amorphous' , 25 , 6656, 6630, 6425, 6400, 27.6, 12.5, 'Fast', q'{bipedal, tailed form}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Infernape]', 392   , 6 , 'Fire', 'Fighting', 1, 7 , 'Field', 'Human-Like', 20  , 5355, 5140, 5120, 121.3, 55, 'Medium Slow', q'{bipedal, tailed form}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Lileep]', 345   , 133 , 'Rock', 'Grass', 1, 7 , 'Water 3' , 30 , 7936, 7905, 7710, 7680, 52.5, 23.8, 'Erratic', q'{head and a base}', 3 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pumpkaboo]', 710  , q'|Small Size|', 63, 'Mo', 'Ghost', 'Grass', 1, 1 , 'Amorphous' , 20   , 5140, 5120, 7.7, 3.5, 'Medium Fast', q'{head}', 6 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class, LDex , Type , Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Lycanroc]', 745, 'D' , q'|Dusk Form|', 104 , 'Rock' , 1, 1 , 'Field' , 15    , 3840, 55.1, 25, 'Medium Fast', q'{quadruped body}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type  , Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Tauros]', 128   , 128 , 'Normal'  , 1 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 194.9, 88.4, 'Slow', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pidgeot]', 18, 'M', nq'|Pidgeotite|', q'|Mega|', 18 , 'Normal', 'Flying', 1, 1 , 'Flying' , 15, 3840, 4096, 4080, 3855, 3840, 87.1, 39.5, 'Medium Slow', q'{single pair of wings}', 1 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pikachu]', 25  , q'|Unova Cap|', 25 , 'Electric' , 1, 1 , 'Field', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 13.2, 6, 'Medium Fast', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type, Type2  , Unbreedable, EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Diancie]', 719   , 151, 'Ce', 'Rock', 'Fairy'  , 'U', 'Undiscovered' , 25   , 6425, 6400, 19.4, 8.8, 'Slow', q'{head and arms}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Kommo-o]', 784   , 273 , 'Dragon', 'Fighting', 1, 1 , 'Dragon' , 40    , 10240, 172.4, 78.2, 'Slow', q'{bipedal, tailed form}', 7 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Furfrou]', 676  , q'|Star Trim|', 93, 'Ce', 'Normal' , 1, 1 , 'Field' , 20   , 5140, 5120, 61.7, 28, 'Medium Fast', q'{quadruped body}', 6 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Malamar]', 687   , 11, 'Co', 'Dark', 'Psychic', 1, 1 , 'Water 1', 'Water 2', 20   , 5140, 5120, 103.6, 47, 'Medium Fast', q'{head and a base}', 6 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type , Female  , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Floette]', 670  , q'|Blue Flower|', 69, 'Ce', 'Fairy' , 1  , 'Fairy' , 20   , 5140, 5120, 2, 0.9, 'Medium Fast', q'{head and arms}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Scyther]', 123   , 123 , 'Bug', 'Flying', 1, 1 , 'Bug' , 25, 6400, 6656, 6630, 6425, 6400, 123.5, 56, 'Medium Fast', q'{two or more pairs of wings}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2   , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Beldum]', 374   , 190 , 'Steel', 'Psychic'   , 'Mineral' , 40 , 10496, 10455, 10280, 10240, 209.9, 95.2, 'Slow', q'{head and a base}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Roselia]', 315   , 94 , 'Grass', 'Poison', 1, 1 , 'Fairy', 'Grass', 20 , 5376, 5355, 5140, 5120, 4.4, 2, 'Medium Slow', q'{bipedal, tailless form}', 3 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type, Type2, Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Oricorio]', 741  , q'|Sensu Style|', 82 , 'Fire', 'Flying', 3, 1 , 'Flying' , 20    , 5120, 7.5, 3.4, 'Medium Fast', q'{single pair of wings}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Treecko]', 252   , 1 , 'Grass' , 1, 7 , 'Monster', 'Dragon', 20 , 5376, 5355, 5140, 5120, 11, 5, 'Medium Slow', q'{bipedal, tailed form}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type  , Male, Unbreedable, EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Tyrogue]', 236   , 145 , 'Fighting'  , 1, 'U', 'Undiscovered' , 25, 6400, 6656, 6630, 6425, 6400, 46.3, 21, 'Medium Fast', q'{bipedal, tailless form}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Horsea]', 116   , 116 , 'Water' , 1, 1 , 'Water 1', 'Dragon', 20, 5120, 5376, 5355, 5140, 5120, 17.6, 8, 'Medium Fast', q'{head and a base}', 1 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class, LDex , Type   , Unbreedable, EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Deoxys]', 386, 'D' , q'|Defense Forme|', 202 , 'Psychic'   , 'U', 'Undiscovered' , 120 , 30976, 30855, 30840, 30720, 134, 60.8, 'Slow', q'{bipedal, tailless form}', 3 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Alakazam]', 65, 'M', nq'|Alakazite|', q'|Mega|', 65 , 'Psychic' , 1, 3 , 'Human-Like' , 20, 5120, 5376, 5355, 5140, 5120, 105.8, 48, 'Medium Slow', q'{bipedal, tailless form}', 1 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class  , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Raticate]', 20, 'A' , q'|Alolan|'  , 'Dark', 'Normal', 1, 1 , 'Field' , 15, 3840, 4096, 4080, 3855, 3840, 40.8, 18.5, 'Medium Fast', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Bisharp]', 625   , 131 , 'Dark', 'Steel', 1, 1 , 'Human-Like' , 20   , 5140, 5120, 154.3, 70, 'Medium Fast', q'{bipedal, tailless form}', 5 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Dragalge]', 691   , 31, 'Co', 'Poison', 'Dragon', 1, 1 , 'Water 1', 'Dragon', 20   , 5140, 5120, 179.7, 81.5, 'Medium Fast', q'{head and a base}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Fearow]', 22   , 22 , 'Normal', 'Flying', 1, 1 , 'Flying' , 15, 3840, 4096, 4080, 3855, 3840, 83.8, 38, 'Medium Fast', q'{single pair of wings}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Wartortle]', 8   , 8 , 'Water' , 1, 7 , 'Monster', 'Water 1', 20, 5120, 5376, 5355, 5140, 5120, 49.6, 22.5, 'Medium Slow', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Deerling]', 585  , q'|Winter Form|', 91 , 'Normal', 'Grass', 1, 1 , 'Field' , 20   , 5140, 5120, 43, 19.5, 'Medium Fast', q'{quadruped body}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Makuhita]', 296   , 48 , 'Fighting' , 1, 3 , 'Human-Like' , 20 , 5376, 5355, 5140, 5120, 190.5, 86.4, 'Fluctuating', q'{bipedal, tailless form}', 3 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type, Type2   , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Carbink]', 703   , 124, 'Co', 'Rock', 'Fairy'   , 'Fairy', 'Mineral', 25   , 6425, 6400, 12.6, 5.7, 'Slow', q'{head}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type   , Unbreedable, EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Suicune]', 245   , 245 , 'Water'   , 'U', 'Undiscovered' , 80, 20480, 20736, 20655, 20560, 20480, 412.3, 187, 'Slow', q'{quadruped body}', 2 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type, Type2, Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Mimikyu]', 778  , q'|Disguised Form|', 242 , 'Ghost', 'Fairy', 1, 1 , 'Amorphous' , 20    , 5120, 1.5, 0.7, 'Medium Fast', q'{serpentine bodies}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2   , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Bronzor]', 436   , 88 , 'Steel', 'Psychic'   , 'Mineral' , 20  , 5355, 5140, 5120, 133.4, 60.5, 'Medium Fast', q'{head}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Shinx]', 403   , 17 , 'Electric' , 1, 1 , 'Field' , 20  , 5355, 5140, 5120, 20.9, 9.5, 'Medium Slow', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Floatzel]', 419   , 57 , 'Water' , 1, 1 , 'Water 1', 'Field', 20  , 5355, 5140, 5120, 73.9, 33.5, 'Medium Fast', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Crabrawler]', 739   , 59 , 'Fighting' , 1, 1 , 'Water 3' , 20    , 5120, 15.4, 7, 'Medium Fast', q'{insectoid body}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Dwebble]', 557   , 63 , 'Bug', 'Rock', 1, 1 , 'Bug', 'Mineral', 20   , 5140, 5120, 32, 14.5, 'Medium Fast', q'{insectoid body}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Moltres]', 146   , 146 , 'Fire', 'Flying'  , 'U', 'Undiscovered' , 80, 20480, 20736, 20655, 20560, 20480, 132.3, 60, 'Slow', q'{single pair of wings}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Salandit]', 757   , 161 , 'Poison', 'Fire', 1, 7 , 'Monster', 'Dragon', 20    , 5120, 10.6, 4.8, 'Medium Fast', q'{quadruped body}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Swinub]', 220   , 195 , 'Ice', 'Ground', 1, 1 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 14.3, 6.5, 'Slow', q'{quadruped body}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Haxorus]', 612   , 118 , 'Dragon' , 1, 1 , 'Monster', 'Dragon', 40   , 10280, 10240, 232.6, 105.5, 'Slow', q'{bipedal, tailed form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Zigzagoon]', 263   , 12 , 'Normal' , 1, 1 , 'Field' , 15 , 4096, 4080, 3855, 3840, 38.6, 17.5, 'Medium Fast', q'{quadruped body}', 3 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type , Female  , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Flabébé]', 669  , q'|Blue Flower|', 68, 'Ce', 'Fairy' , 1  , 'Fairy' , 20   , 5140, 5120, 0.2, 0.1, 'Medium Fast', q'{head and arms}', 6 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class, LDex , Type , Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Burmy]', 412, 'S' , q'|Trash Cloak|', 45 , 'Bug' , 1, 1 , 'Bug' , 15  , 4080, 3855, 3840, 7.5, 3.4, 'Medium Fast', q'{head and a base}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Charmeleon]', 5   , 5 , 'Fire' , 1, 7 , 'Monster', 'Dragon', 20, 5120, 5376, 5355, 5140, 5120, 41.9, 19, 'Medium Slow', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Sandygast]', 769   , 186 , 'Ghost', 'Ground', 1, 1 , 'Amorphous' , 15    , 3840, 154.3, 70, 'Medium Fast', q'{serpentine bodies}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Medicham]', 308   , 77 , 'Fighting', 'Psychic', 1, 1 , 'Human-Like' , 20 , 5376, 5355, 5140, 5120, 69.4, 31.5, 'Medium Fast', q'{bipedal, tailless form}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Koffing]', 109   , 109 , 'Poison' , 1, 1 , 'Amorphous' , 20, 5120, 5376, 5355, 5140, 5120, 2.2, 1, 'Medium Fast', q'{head}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Bibarel]', 400   , 14 , 'Normal', 'Water', 1, 1 , 'Water 1', 'Field', 15  , 4080, 3855, 3840, 69.4, 31.5, 'Medium Fast', q'{bipedal, tailed form}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Buneary]', 427   , 67 , 'Normal' , 1, 1 , 'Field', 'Human-Like', 20  , 5355, 5140, 5120, 12.1, 5.5, 'Medium Fast', q'{bipedal, tailed form}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Kricketot]', 401   , 15 , 'Bug' , 1, 1 , 'Bug' , 15  , 4080, 3855, 3840, 4.9, 2.2, 'Medium Slow', q'{bipedal, tailless form}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Turtonator]', 776   , 224 , 'Fire', 'Dragon', 1, 1 , 'Monster', 'Dragon', 20    , 5120, 467.4, 212, 'Medium Fast', q'{bipedal, tailed form}', 7 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Furfrou]', 676  , q'|Matron Trim|', 93, 'Ce', 'Normal' , 1, 1 , 'Field' , 20   , 5140, 5120, 61.7, 28, 'Medium Fast', q'{quadruped body}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Gardevoir]', 282   , 31 , 'Psychic', 'Fairy', 1, 1 , 'Amorphous' , 20 , 5376, 5355, 5140, 5120, 106.7, 48.4, 'Slow', q'{bipedal, tailless form}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Torracat]', 726   , 5 , 'Fire' , 1, 7 , 'Field' , 15    , 3840, 55.1, 25, 'Medium Slow', q'{quadruped body}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Swadloon]', 541   , 47 , 'Bug', 'Grass', 1, 1 , 'Bug' , 15   , 3855, 3840, 16.1, 7.3, 'Medium Slow', q'{head and arms}', 5 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pinsir]', 127, 'M', nq'|Pinsirite|', q'|Mega|', 127 , 'Bug', 'Flying', 1, 1 , 'Bug' , 25, 6400, 6656, 6630, 6425, 6400, 121.3, 55, 'Slow', q'{two or more pairs of wings}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Purugly]', 432   , 77 , 'Normal' , 3, 1 , 'Field' , 20  , 5355, 5140, 5120, 96.6, 43.8, 'Fast', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Delcatty]', 301   , 62 , 'Normal' , 3, 1 , 'Field', 'Fairy', 15 , 4096, 4080, 3855, 3840, 71.9, 32.6, 'Fast', q'{quadruped body}', 3 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type, Type2, Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Blaziken]', 257, 'M', nq'|Blazikenite|', q'|Mega|', 6 , 'Fire', 'Fighting', 1, 7 , 'Field' , 20 , 5376, 5355, 5140, 5120, 114.6, 52, 'Medium Slow', q'{bipedal, tailed form}', 3 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Keldeo]', 647  , q'|Ordinary Form|', 153 , 'Water', 'Fighting'  , 'U', 'Undiscovered' , 80   , 20560, 20480, 106.9, 48.5, 'Slow', q'{quadruped body}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Rhyperior]', 464   , 188 , 'Ground', 'Rock', 1, 1 , 'Monster', 'Field', 20  , 5355, 5140, 5120, 623.5, 282.8, 'Slow', q'{bipedal, tailed form}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type    , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Cryogonal]', 615   , 121 , 'Ice'    , 'Mineral' , 25   , 6425, 6400, 326.3, 148, 'Medium Fast', q'{head}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Swablu]', 333   , 121 , 'Normal', 'Flying', 1, 1 , 'Flying', 'Dragon', 20 , 5376, 5355, 5140, 5120, 2.6, 1.2, 'Erratic', q'{single pair of wings}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Solgaleo]', 791   , 291 , 'Psychic', 'Steel'  , 'U', 'Undiscovered' , 120    , 30720, 507.1, 230, 'Slow', q'{quadruped body}', 7 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Goomy]', 704   , 19, 'Mo', 'Dragon' , 1, 1 , 'Dragon' , 40   , 10280, 10240, 6.2, 2.8, 'Slow', q'{serpentine bodies}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type  , Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Volbeat]', 313   , 86 , 'Bug'  , 1 , 'Bug', 'Human-Like', 15 , 4096, 4080, 3855, 3840, 39, 17.7, 'Erratic', q'{bipedal, tailed form}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Quilava]', 156   , 5 , 'Fire' , 1, 7 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 41.9, 19, 'Medium Slow', q'{quadruped body}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Snivy]', 495   , 1 , 'Grass' , 1, 7 , 'Field', 'Grass', 20   , 5140, 5120, 17.9, 8.1, 'Medium Slow', q'{bipedal, tailed form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type   , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Zeraora]', 807   , 403 , 'Electric'   , 'U', 'Undiscovered' , 120    , 30720, 98.1, 44.5, 'Slow', q'{bipedal, tailless form}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type    , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Voltorb]', 100   , 100 , 'Electric'    , 'Mineral' , 20, 5120, 5376, 5355, 5140, 5120, 22.9, 10.4, 'Medium Fast', q'{head}', 1 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Vivillon]', 666  , q'|Continental Pattern|', 22, 'Ce', 'Bug', 'Flying', 1, 1 , 'Bug' , 15   , 3855, 3840, 37.5, 17, 'Medium Fast', q'{two or more pairs of wings}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Heatmor]', 631   , 137 , 'Fire' , 1, 1 , 'Field' , 20   , 5140, 5120, 127.9, 58, 'Medium Fast', q'{bipedal, tailed form}', 5 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Furfrou]', 676  , q'|Pharaoh Trim|', 93, 'Ce', 'Normal' , 1, 1 , 'Field' , 20   , 5140, 5120, 61.7, 28, 'Medium Fast', q'{quadruped body}', 6 );     
insert into Pokemon( Name, Dex  , Class  , Type   , Unbreedable, EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Arceus]', 493  , q'|Type: Ghost|'  , 'Normal'   , 'U', 'Undiscovered' , 120  , 30855, 30840, 30720, 705.5, 320, 'Slow', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Swanna]', 581   , 87 , 'Water', 'Flying', 1, 1 , 'Water 1', 'Flying', 20   , 5140, 5120, 53.4, 24.2, 'Medium Fast', q'{single pair of wings}', 5 );     
insert into Pokemon( Name, Dex     , Type   , Unbreedable, EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Darkrai]', 491     , 'Dark'   , 'U', 'Undiscovered' , 120  , 30855, 30840, 30720, 111.3, 50.5, 'Slow', q'{bipedal, tailless form}', 4 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type   , Unbreedable, EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Unown]', 201  , q'|One form|', 61 , 'Psychic'   , 'U', 'Undiscovered' , 40, 10240, 10496, 10455, 10280, 10240, 11, 5, 'Medium Fast', q'{head}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Shroomish]', 285   , 34 , 'Grass' , 1, 1 , 'Fairy', 'Grass', 15 , 4096, 4080, 3855, 3840, 9.9, 4.5, 'Fluctuating', q'{head and legs}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Gothitelle]', 576   , 82 , 'Psychic' , 3, 1 , 'Human-Like' , 20   , 5140, 5120, 97, 44, 'Medium Slow', q'{bipedal, tailless form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Torterra]', 389   , 3 , 'Grass', 'Ground', 1, 7 , 'Monster', 'Grass', 20  , 5355, 5140, 5120, 683.4, 310, 'Medium Slow', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Escavalier]', 589   , 95 , 'Bug', 'Steel', 1, 1 , 'Bug' , 15   , 3855, 3840, 72.8, 33, 'Medium Fast', q'{head and arms}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pachirisu]', 417   , 55 , 'Electric' , 1, 1 , 'Field', 'Fairy', 10  , 2805, 2570, 2560, 8.6, 3.9, 'Medium Fast', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2   , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Bronzong]', 437   , 89 , 'Steel', 'Psychic'   , 'Mineral' , 20  , 5355, 5140, 5120, 412.3, 187, 'Medium Fast', q'{head and arms}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male, Unbreedable, EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Magby]', 240   , 152 , 'Fire' , 1, 3, 'U', 'Undiscovered' , 25, 6400, 6656, 6630, 6425, 6400, 47.2, 21.4, 'Medium Fast', q'{bipedal, tailed form}', 2 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Heliolisk]', 695   , 47, 'Co', 'Electric', 'Normal', 1, 1 , 'Monster', 'Dragon', 20   , 5140, 5120, 46.3, 21, 'Medium Fast', q'{bipedal, tailed form}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Morelull]', 755   , 145 , 'Grass', 'Fairy', 1, 1 , 'Grass' , 20    , 5120, 3.3, 1.5, 'Medium Fast', q'{head and a base}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Diglett]', 50   , 50 , 'Ground' , 1, 1 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 1.8, 0.8, 'Medium Fast', q'{head and a base}', 1 );     
insert into Pokemon( Name, Dex  , Class  , Type   , Unbreedable, EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Arceus]', 493  , q'|Type: Fairy|'  , 'Normal'   , 'U', 'Undiscovered' , 120  , 30855, 30840, 30720, 705.5, 320, 'Slow', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type , Female, Male, Unbreedable, EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pichu]', 172  , q'|Spiky-eared|', 21 , 'Electric' , 1, 1, 'U', 'Undiscovered' , 10, 2560, 2816, 2805, 2570, 2560, 4.4, 2, 'Medium Fast', q'{quadruped body}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Primarina]', 730   , 9 , 'Water', 'Fairy', 1, 7 , 'Water 1', 'Field', 15    , 3840, 97, 44, 'Medium Slow', q'{fins}', 7 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Skrelp]', 690   , 30, 'Co', 'Poison', 'Water', 1, 1 , 'Water 1', 'Dragon', 20   , 5140, 5120, 16.1, 7.3, 'Medium Fast', q'{head and a base}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Luxio]', 404   , 18 , 'Electric' , 1, 1 , 'Field' , 20  , 5355, 5140, 5120, 67.2, 30.5, 'Medium Slow', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Stufful]', 759   , 169 , 'Normal', 'Fighting', 1, 1 , 'Field' , 15    , 3840, 15, 6.8, 'Medium Fast', q'{quadruped body}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Grotle]', 388   , 2 , 'Grass' , 1, 7 , 'Monster', 'Grass', 20  , 5355, 5140, 5120, 213.8, 97, 'Medium Slow', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Carracosta]', 565   , 71 , 'Water', 'Rock', 1, 7 , 'Water 1', 'Water 3', 30   , 7710, 7680, 178.6, 81, 'Medium Fast', q'{bipedal, tailed form}', 5 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Doublade]', 680   , 118, 'Ce', 'Steel', 'Ghost', 1, 1 , 'Mineral' , 20   , 5140, 5120, 9.9, 4.5, 'Medium Fast', q'{multiple bodies}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Skorupi]', 451   , 127 , 'Poison', 'Bug', 1, 1 , 'Bug', 'Water 3', 20  , 5355, 5140, 5120, 26.5, 12, 'Slow', q'{insectoid body}', 4 );     
insert into Pokemon( Name, Dex  , Class  , Type   , Unbreedable, EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Arceus]', 493  , q'|Type: Bug|'  , 'Normal'   , 'U', 'Undiscovered' , 120  , 30855, 30840, 30720, 705.5, 320, 'Slow', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type    , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Klang]', 600   , 106 , 'Steel'    , 'Mineral' , 20   , 5140, 5120, 112.4, 51, 'Medium Slow', q'{multiple bodies}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Golduck]', 55   , 55 , 'Water' , 1, 1 , 'Water 1', 'Field', 20, 5120, 5376, 5355, 5140, 5120, 168.9, 76.6, 'Medium Fast', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Sentret]', 161   , 19 , 'Normal' , 1, 1 , 'Field' , 15, 3840, 4096, 4080, 3855, 3840, 13.2, 6, 'Medium Fast', q'{quadruped body}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Jolteon]', 135   , 135 , 'Electric' , 1, 7 , 'Field' , 35, 8960, 9216, 9180, 8995, 8960, 54, 24.5, 'Medium Fast', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Charizard]', 6   , 6 , 'Fire', 'Flying', 1, 7 , 'Monster', 'Dragon', 20, 5120, 5376, 5355, 5140, 5120, 199.5, 90.5, 'Medium Slow', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Volcarona]', 637   , 143 , 'Bug', 'Fire', 1, 1 , 'Bug' , 40   , 10280, 10240, 101.4, 46, 'Slow', q'{two or more pairs of wings}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Galvantula]', 596   , 102 , 'Bug', 'Electric', 1, 1 , 'Bug' , 20   , 5140, 5120, 31.5, 14.3, 'Medium Fast', q'{insectoid body}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Beheeyem]', 606   , 112 , 'Psychic' , 1, 1 , 'Human-Like' , 20   , 5140, 5120, 76.1, 34.5, 'Medium Fast', q'{bipedal, tailless form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Chimchar]', 390   , 4 , 'Fire' , 1, 7 , 'Field', 'Human-Like', 20  , 5355, 5140, 5120, 13.7, 6.2, 'Medium Slow', q'{bipedal, tailed form}', 4 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Vivillon]', 666  , q'|Garden Pattern|', 22, 'Ce', 'Bug', 'Flying', 1, 1 , 'Bug' , 15   , 3855, 3840, 37.5, 17, 'Medium Fast', q'{two or more pairs of wings}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Nihilego]', 793   , 293 , 'Rock', 'Poison'  , 'U', 'Undiscovered' , 120    , 30720, 122.4, 55.5, 'Slow', q'{tentacles or a multiped body}', 7 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type , Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Lycanroc]', 745  , q'|Midday Form|', 104 , 'Rock' , 1, 1 , 'Field' , 15    , 3840, 55.1, 25, 'Medium Fast', q'{quadruped body}', 7 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Tyrantrum]', 697   , 65, 'Co', 'Rock', 'Dragon', 1, 7 , 'Monster', 'Dragon', 30   , 7710, 7680, 595.2, 270, 'Medium Fast', q'{bipedal, tailed form}', 6 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type, Type2, Female  , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Wormadam]', 413  , q'|Plant Cloak|', 46 , 'Bug', 'Grass', 1  , 'Bug' , 15  , 4080, 3855, 3840, 14.3, 6.5, 'Medium Fast', q'{head and a base}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Dugtrio]', 51   , 51 , 'Ground' , 1, 1 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 73.4, 33.3, 'Medium Fast', q'{multiple bodies}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Ducklett]', 580   , 86 , 'Water', 'Flying', 1, 1 , 'Water 1', 'Flying', 20   , 5140, 5120, 12.1, 5.5, 'Medium Fast', q'{single pair of wings}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Dodrio]', 85   , 85 , 'Normal', 'Flying', 1, 1 , 'Flying' , 20, 5120, 5376, 5355, 5140, 5120, 187.8, 85.2, 'Medium Fast', q'{head and legs}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Zebstrika]', 523   , 29 , 'Electric' , 1, 1 , 'Field' , 20   , 5140, 5120, 175.3, 79.5, 'Medium Fast', q'{quadruped body}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Politoed]', 186   , 75 , 'Water' , 1, 1 , 'Water 1' , 20, 5120, 5376, 5355, 5140, 5120, 74.7, 33.9, 'Medium Slow', q'{bipedal, tailless form}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male, Unbreedable, EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Azurill]', 298   , 54 , 'Normal', 'Fairy', 3, 1, 'U', 'Undiscovered' , 10 , 2816, 2805, 2570, 2560, 4.4, 2, 'Fast', q'{head and legs}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type  , Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Hitmonlee]', 106   , 106 , 'Fighting'  , 1 , 'Human-Like' , 25, 6400, 6656, 6630, 6425, 6400, 109.8, 49.8, 'Medium Fast', q'{bipedal, tailless form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Anorith]', 347   , 135 , 'Rock', 'Bug', 1, 7 , 'Water 3' , 30 , 7936, 7905, 7710, 7680, 27.6, 12.5, 'Erratic', q'{insectoid body}', 3 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type   , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Silvally]', 773  , q'|Type: Water|', 204 , 'Normal'   , 'U', 'Undiscovered' , 120    , 30720, 221.6, 100.5, 'Slow', q'{quadruped body}', 7 );     
insert into Pokemon( Name, Dex  , Class  , Type   , Unbreedable, EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Arceus]', 493  , q'|Type: Rock|'  , 'Normal'   , 'U', 'Undiscovered' , 120  , 30855, 30840, 30720, 705.5, 320, 'Slow', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Aromatisse]', 683   , 130, 'Ce', 'Fairy' , 1, 1 , 'Fairy' , 20   , 5140, 5120, 34.2, 15.5, 'Medium Fast', q'{bipedal, tailless form}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Mudsdale]', 750   , 133 , 'Ground' , 1, 1 , 'Field' , 20    , 5120, 2028.3, 920, 'Medium Fast', q'{quadruped body}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Swoobat]', 528   , 34 , 'Psychic', 'Flying', 1, 1 , 'Field', 'Flying', 15   , 3855, 3840, 23.1, 10.5, 'Medium Fast', q'{single pair of wings}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male, Unbreedable, EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Bonsly]', 438   , 92 , 'Rock' , 1, 1, 'U', 'Undiscovered' , 20  , 5355, 5140, 5120, 33.1, 15, 'Medium Fast', q'{head and legs}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type    , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Porygon-Z]', 474   , 194 , 'Normal'    , 'Mineral' , 20  , 5355, 5140, 5120, 75, 34, 'Medium Fast', q'{head and arms}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type   , Unbreedable, EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Raikou]', 243   , 243 , 'Electric'   , 'U', 'Undiscovered' , 80, 20480, 20736, 20655, 20560, 20480, 392.4, 178, 'Slow', q'{quadruped body}', 2 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class, LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Darmanitan]', 555, 'Z' , q'|Zen Mode|', 61 , 'Fire', 'Psychic', 1, 1 , 'Field' , 20   , 5140, 5120, 204.8, 92.9, 'Medium Slow', q'{quadruped body}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Clamperl]', 366   , 176 , 'Water' , 1, 1 , 'Water 1' , 20 , 5376, 5355, 5140, 5120, 115.7, 52.5, 'Erratic', q'{head}', 3 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Chespin]', 650   , 1, 'Ce', 'Grass' , 1, 7 , 'Field' , 20   , 5140, 5120, 19.8, 9, 'Medium Slow', q'{bipedal, tailed form}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Ekans]', 23   , 23 , 'Poison' , 1, 1 , 'Field', 'Dragon', 20, 5120, 5376, 5355, 5140, 5120, 15.2, 6.9, 'Medium Fast', q'{serpentine bodies}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Marshadow]', 802   , 302 , 'Fighting', 'Ghost'  , 'U', 'Undiscovered' , 120    , 30720, 48.9, 22.2, 'Slow', q'{bipedal, tailless form}', 7 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Tyrunt]', 696   , 64, 'Co', 'Rock', 'Dragon', 1, 7 , 'Monster', 'Dragon', 30   , 7710, 7680, 57.3, 26, 'Medium Fast', q'{bipedal, tailed form}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Luvdisc]', 370   , 183 , 'Water' , 3, 1 , 'Water 2' , 20 , 5376, 5355, 5140, 5120, 19.2, 8.7, 'Fast', q'{fins}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Darumaka]', 554   , 60 , 'Fire' , 1, 1 , 'Field' , 20   , 5140, 5120, 82.7, 37.5, 'Medium Slow', q'{bipedal, tailless form}', 5 );     
insert into Pokemon( Name, Dex  , Class  , Type   , Unbreedable, EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Arceus]', 493  , q'|Type: Grass|'  , 'Normal'   , 'U', 'Undiscovered' , 120  , 30855, 30840, 30720, 705.5, 320, 'Slow', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class, LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Greninja]', 658, 'A' , q'|Ash-Greninja|', 9, 'Ce', 'Water', 'Dark', 1, 7 , 'Water 1' , 20   , 5140, 5120, 88.2, 40, 'Medium Slow', q'{bipedal, tailless form}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Ludicolo]', 272   , 21 , 'Water', 'Grass', 1, 1 , 'Water 1', 'Grass', 15 , 4096, 4080, 3855, 3840, 121.3, 55, 'Medium Slow', q'{bipedal, tailless form}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Zapdos]', 145   , 145 , 'Electric', 'Flying'  , 'U', 'Undiscovered' , 80, 20480, 20736, 20655, 20560, 20480, 116, 52.6, 'Slow', q'{single pair of wings}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Natu]', 177   , 161 , 'Psychic', 'Flying', 1, 1 , 'Flying' , 20, 5120, 5376, 5355, 5140, 5120, 4.4, 2, 'Medium Fast', q'{single pair of wings}', 2 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Gengar]', 94, 'M', nq'|Gengarite|', q'|Mega|', 94 , 'Ghost', 'Poison', 1, 1 , 'Amorphous' , 20, 5120, 5376, 5355, 5140, 5120, 89.3, 40.5, 'Medium Slow', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Magikarp]', 129   , 129 , 'Water' , 1, 1 , 'Water 2', 'Dragon', 5, 1280, 1536, 1530, 1285, 1280, 22, 10, 'Slow', q'{fins}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2   , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Golett]', 622   , 128 , 'Ground', 'Ghost'   , 'Mineral' , 25   , 6425, 6400, 202.8, 92, 'Medium Fast', q'{bipedal, tailless form}', 5 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class  , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Exeggutor]', 103, 'A' , q'|Alolan|'  , 'Grass', 'Dragon', 1, 1 , 'Grass' , 20, 5120, 5376, 5355, 5140, 5120, 264.6, 120, 'Slow', q'{head and legs}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type   , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Cosmog]', 789   , 289 , 'Psychic'   , 'U', 'Undiscovered' , 120    , 30720, 0.2, 0.1, 'Slow', q'{head}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Chikorita]', 152   , 1 , 'Grass' , 1, 7 , 'Monster', 'Grass', 20, 5120, 5376, 5355, 5140, 5120, 14.1, 6.4, 'Medium Slow', q'{quadruped body}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Spheal]', 363   , 173 , 'Ice', 'Water', 1, 1 , 'Water 1', 'Field', 20 , 5376, 5355, 5140, 5120, 87.1, 39.5, 'Medium Slow', q'{fins}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Lillipup]', 506   , 12 , 'Normal' , 1, 1 , 'Field' , 15   , 3855, 3840, 9, 4.1, 'Medium Slow', q'{quadruped body}', 5 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type   , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Silvally]', 773  , q'|Type: Ghost|', 204 , 'Normal'   , 'U', 'Undiscovered' , 120    , 30720, 221.6, 100.5, 'Slow', q'{quadruped body}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pansage]', 511   , 17 , 'Grass' , 1, 7 , 'Field' , 20   , 5140, 5120, 23.1, 10.5, 'Medium Fast', q'{bipedal, tailed form}', 5 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Vivillon]', 666  , q'|Jungle Pattern|', 22, 'Ce', 'Bug', 'Flying', 1, 1 , 'Bug' , 15   , 3855, 3840, 37.5, 17, 'Medium Fast', q'{two or more pairs of wings}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Ninjask]', 291   , 43 , 'Bug', 'Flying', 1, 1 , 'Bug' , 15 , 4096, 4080, 3855, 3840, 26.5, 12, 'Erratic', q'{two or more pairs of wings}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Dragonair]', 148   , 148 , 'Dragon' , 1, 1 , 'Water 1', 'Dragon', 40, 10240, 10496, 10455, 10280, 10240, 36.4, 16.5, 'Slow', q'{serpentine bodies}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Zubat]', 41   , 41 , 'Poison', 'Flying', 1, 1 , 'Flying' , 15, 3840, 4096, 4080, 3855, 3840, 16.5, 7.5, 'Medium Fast', q'{single pair of wings}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Sneasel]', 215   , 218 , 'Dark', 'Ice', 1, 1 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 61.7, 28, 'Medium Slow', q'{bipedal, tailed form}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Stantler]', 234   , 131 , 'Normal' , 1, 1 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 157, 71.2, 'Slow', q'{quadruped body}', 2 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Mawile]', 303, 'M', nq'|Mawilite|', q'|Mega|', 69 , 'Steel', 'Fairy', 1, 1 , 'Field', 'Fairy', 20 , 5376, 5355, 5140, 5120, 25.4, 11.5, 'Fast', q'{bipedal, tailless form}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Amoonguss]', 591   , 97 , 'Grass', 'Poison', 1, 1 , 'Grass' , 20   , 5140, 5120, 23.1, 10.5, 'Medium Fast', q'{head and arms}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Ralts]', 280   , 29 , 'Psychic', 'Fairy', 1, 1 , 'Amorphous' , 20 , 5376, 5355, 5140, 5120, 14.6, 6.6, 'Slow', q'{bipedal, tailless form}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Duosion]', 578   , 84 , 'Psychic' , 1, 1 , 'Amorphous' , 20   , 5140, 5120, 17.6, 8, 'Medium Slow', q'{head}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Gothita]', 574   , 80 , 'Psychic' , 3, 1 , 'Human-Like' , 20   , 5140, 5120, 12.8, 5.8, 'Medium Slow', q'{bipedal, tailless form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Grumpig]', 326   , 111 , 'Psychic' , 1, 1 , 'Field' , 20 , 5376, 5355, 5140, 5120, 157.6, 71.5, 'Fast', q'{bipedal, tailed form}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Popplio]', 728   , 7 , 'Water' , 1, 7 , 'Water 1', 'Field', 15    , 3840, 16.5, 7.5, 'Medium Slow', q'{fins}', 7 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Fletchling]', 661   , 14, 'Ce', 'Normal', 'Flying', 1, 1 , 'Flying' , 15   , 3855, 3840, 3.7, 1.7, 'Medium Slow', q'{single pair of wings}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Roserade]', 407   , 27 , 'Grass', 'Poison', 1, 1 , 'Fairy', 'Grass', 20  , 5355, 5140, 5120, 32, 14.5, 'Medium Slow', q'{bipedal, tailless form}', 4 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Vivillon]', 666  , q'|Sandstorm Pattern|', 22, 'Ce', 'Bug', 'Flying', 1, 1 , 'Bug' , 15   , 3855, 3840, 37.5, 17, 'Medium Fast', q'{two or more pairs of wings}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Venusaur]', 3   , 3 , 'Grass', 'Poison', 1, 7 , 'Monster', 'Grass', 20, 5120, 5376, 5355, 5140, 5120, 220.5, 100, 'Medium Slow', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Samurott]', 503   , 9 , 'Water' , 1, 7 , 'Field' , 20   , 5140, 5120, 208.6, 94.6, 'Medium Slow', q'{quadruped body}', 5 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Vivillon]', 666  , q'|Polar Pattern|', 22, 'Ce', 'Bug', 'Flying', 1, 1 , 'Bug' , 15   , 3855, 3840, 37.5, 17, 'Medium Fast', q'{two or more pairs of wings}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Wingull]', 278   , 27 , 'Water', 'Flying', 1, 1 , 'Water 1', 'Flying', 20 , 5376, 5355, 5140, 5120, 20.9, 9.5, 'Medium Fast', q'{single pair of wings}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Zorua]', 570   , 76 , 'Dark' , 1, 7 , 'Field' , 25   , 6425, 6400, 27.6, 12.5, 'Medium Slow', q'{quadruped body}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Misdreavus]', 200   , 219 , 'Ghost' , 1, 1 , 'Amorphous' , 25, 6400, 6656, 6630, 6425, 6400, 2.2, 1, 'Fast', q'{head}', 2 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class, LDex , Type   , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Necrozma]', 800, 'DW' , q'|Dawn Wings|', 300 , 'Psychic'   , 'U', 'Undiscovered' , 120    , 30720, 771.6, 350, 'Slow', q'{single pair of wings}', 7 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Chesnaught]', 652   , 3, 'Ce', 'Grass', 'Fighting', 1, 7 , 'Field' , 20   , 5140, 5120, 198.4, 90, 'Medium Slow', q'{bipedal, tailed form}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Poliwrath]', 62   , 62 , 'Water', 'Fighting', 1, 1 , 'Water 1' , 20, 5120, 5376, 5355, 5140, 5120, 119, 54, 'Medium Slow', q'{bipedal, tailless form}', 1 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Vivillon]', 666  , q'|Monsoon Pattern|', 22, 'Ce', 'Bug', 'Flying', 1, 1 , 'Bug' , 15   , 3855, 3840, 37.5, 17, 'Medium Fast', q'{two or more pairs of wings}', 6 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pikachu]', 25  , q'|Pop Star|', 25 , 'Electric' , 1, 1 , 'Field', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 13.2, 6, 'Medium Fast', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Larvesta]', 636   , 142 , 'Bug', 'Fire', 1, 1 , 'Bug' , 40   , 10280, 10240, 63.5, 28.8, 'Slow', q'{insectoid body}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Grimer]', 88   , 88 , 'Poison' , 1, 1 , 'Amorphous' , 20, 5120, 5376, 5355, 5140, 5120, 66.1, 30, 'Medium Fast', q'{head and arms}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Aerodactyl]', 142   , 142 , 'Rock', 'Flying', 1, 7 , 'Flying' , 35, 8960, 9216, 9180, 8995, 8960, 130.1, 59, 'Slow', q'{single pair of wings}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Bagon]', 371   , 187 , 'Dragon' , 1, 1 , 'Dragon' , 40 , 10496, 10455, 10280, 10240, 92.8, 42.1, 'Slow', q'{bipedal, tailless form}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male, Unbreedable, EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Munchlax]', 446   , 112 , 'Normal' , 1, 7, 'U', 'Undiscovered' , 40  , 10455, 10280, 10240, 231.5, 105, 'Slow', q'{bipedal, tailless form}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Raichu]', 26   , 26 , 'Electric' , 1, 1 , 'Field', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 66.1, 30, 'Medium Fast', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Oranguru]', 765   , 176 , 'Normal', 'Psychic', 1, 1 , 'Field' , 20    , 5120, 167.6, 76, 'Slow', q'{bipedal, tailless form}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Watchog]', 505   , 11 , 'Normal' , 1, 1 , 'Field' , 20   , 5140, 5120, 59.5, 27, 'Medium Fast', q'{bipedal, tailed form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Breloom]', 286   , 35 , 'Grass', 'Fighting', 1, 1 , 'Fairy', 'Grass', 15 , 4096, 4080, 3855, 3840, 86.4, 39.2, 'Fluctuating', q'{bipedal, tailed form}', 3 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Cherrim]', 421  , q'|Overcast Form|', 59 , 'Grass' , 1, 1 , 'Fairy', 'Grass', 20  , 5355, 5140, 5120, 20.5, 9.3, 'Medium Fast', q'{head and legs}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female  , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Mandibuzz]', 630   , 136 , 'Dark', 'Flying', 1  , 'Flying' , 20   , 5140, 5120, 87.1, 39.5, 'Slow', q'{single pair of wings}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Gumshoos]', 735   , 14 , 'Normal' , 1, 1 , 'Field' , 15    , 3840, 31.3, 14.2, 'Medium Fast', q'{quadruped body}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Venipede]', 543   , 49 , 'Bug', 'Poison', 1, 1 , 'Bug' , 15   , 3855, 3840, 11.7, 5.3, 'Medium Slow', q'{insectoid body}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Ninetales]', 38   , 38 , 'Fire' , 3, 1 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 43.9, 19.9, 'Medium Fast', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class, LDex , Type, Type2 , Male, Unbreedable, EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Landorus]', 645, 'T' , q'|Therian Forme|', 151 , 'Ground', 'Flying' , 1, 'U', 'Undiscovered' , 120   , 30840, 30720, 149.9, 68, 'Slow', q'{quadruped body}', 5 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Beedrill]', 15, 'M', nq'|Beedrillite|', q'|Mega|', 15 , 'Bug', 'Poison', 1, 1 , 'Bug' , 15, 3840, 4096, 4080, 3855, 3840, 65, 29.5, 'Medium Fast', q'{two or more pairs of wings}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Venomoth]', 49   , 49 , 'Bug', 'Poison', 1, 1 , 'Bug' , 20, 5120, 5376, 5355, 5140, 5120, 27.6, 12.5, 'Medium Fast', q'{two or more pairs of wings}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male, Unbreedable, EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Mantyke]', 458   , 140 , 'Water', 'Flying', 1, 1, 'U', 'Undiscovered' , 25  , 6630, 6425, 6400, 143.3, 65, 'Slow', q'{single pair of wings}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Flygon]', 330   , 118 , 'Ground', 'Dragon', 1, 1 , 'Bug' , 20 , 5376, 5355, 5140, 5120, 180.8, 82, 'Medium Slow', q'{single pair of wings}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Serperior]', 497   , 3 , 'Grass' , 1, 7 , 'Field', 'Grass', 20   , 5140, 5120, 138.9, 63, 'Medium Slow', q'{serpentine bodies}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Luxray]', 405   , 19 , 'Electric' , 1, 1 , 'Field' , 20  , 5355, 5140, 5120, 92.6, 42, 'Medium Slow', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type   , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Silvally]', 773  , q'|Type: Poison|', 204 , 'Normal'   , 'U', 'Undiscovered' , 120    , 30720, 221.6, 100.5, 'Slow', q'{quadruped body}', 7 );     
insert into Pokemon( Name, Dex, Dex_Suffix  , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Frillish]', 592, 'F'  , 98 , 'Water', 'Ghost', 1, 1 , 'Amorphous' , 20   , 5140, 5120, 72.8, 33, 'Medium Fast', q'{tentacles or a multiped body}', 5 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Vivillon]', 666  , q'|River Pattern|', 22, 'Ce', 'Bug', 'Flying', 1, 1 , 'Bug' , 15   , 3855, 3840, 37.5, 17, 'Medium Fast', q'{two or more pairs of wings}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Typhlosion]', 157   , 6 , 'Fire' , 1, 7 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 175.3, 79.5, 'Medium Slow', q'{quadruped body}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Trubbish]', 568   , 74 , 'Poison' , 1, 1 , 'Mineral' , 20   , 5140, 5120, 68.3, 31, 'Medium Fast', q'{bipedal, tailless form}', 5 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Sawsbuck]', 586  , q'|Autumn Form|', 92 , 'Normal', 'Grass', 1, 1 , 'Field' , 20   , 5140, 5120, 203.9, 92.5, 'Medium Fast', q'{quadruped body}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2 , Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Rufflet]', 627   , 133 , 'Normal', 'Flying' , 1 , 'Flying' , 20   , 5140, 5120, 23.1, 10.5, 'Slow', q'{single pair of wings}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Ivysaur]', 2   , 2 , 'Grass', 'Poison', 1, 7 , 'Monster', 'Grass', 20, 5120, 5376, 5355, 5140, 5120, 28.7, 13, 'Medium Slow', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Leavanny]', 542   , 48 , 'Bug', 'Grass', 1, 1 , 'Bug' , 15   , 3855, 3840, 45.2, 20.5, 'Medium Slow', q'{bipedal, tailless form}', 5 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Houndoom]', 229, 'M', nq'|Houndoominite|', q'|Mega|', 215 , 'Dark', 'Fire', 1, 1 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 77.2, 35, 'Slow', q'{quadruped body}', 2 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type   , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Silvally]', 773  , q'|Type: Psychic|', 204 , 'Normal'   , 'U', 'Undiscovered' , 120    , 30720, 221.6, 100.5, 'Slow', q'{quadruped body}', 7 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type , Female  , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Florges]', 671  , q'|Red Flower|', 70, 'Ce', 'Fairy' , 1  , 'Fairy' , 20   , 5140, 5120, 22, 10, 'Medium Fast', q'{head and arms}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Minun]', 312   , 81 , 'Electric' , 1, 1 , 'Fairy' , 20 , 5376, 5355, 5140, 5120, 9.3, 4.2, 'Medium Fast', q'{bipedal, tailed form}', 3 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type   , Unbreedable, EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Deoxys]', 386  , q'|Normal Forme|', 202 , 'Psychic'   , 'U', 'Undiscovered' , 120 , 30976, 30855, 30840, 30720, 134, 60.8, 'Slow', q'{bipedal, tailless form}', 3 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type, Type2 , Male, Unbreedable, EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Thundurus]', 642  , q'|Incarnate Forme|', 148 , 'Electric', 'Flying' , 1, 'U', 'Undiscovered' , 120   , 30840, 30720, 134.5, 61, 'Slow', q'{head and arms}', 5 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Darmanitan]', 555  , q'|Standard Mode|', 61 , 'Fire' , 1, 1 , 'Field' , 20   , 5140, 5120, 204.8, 92.9, 'Medium Slow', q'{quadruped body}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Liepard]', 510   , 16 , 'Dark' , 1, 1 , 'Field' , 20   , 5140, 5120, 82.7, 37.5, 'Medium Fast', q'{quadruped body}', 5 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Furfrou]', 676  , q'|La Reine Trim|', 93, 'Ce', 'Normal' , 1, 1 , 'Field' , 20   , 5140, 5120, 61.7, 28, 'Medium Fast', q'{quadruped body}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pawniard]', 624   , 130 , 'Dark', 'Steel', 1, 1 , 'Human-Like' , 20   , 5140, 5120, 22.5, 10.2, 'Medium Fast', q'{bipedal, tailless form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Electabuzz]', 125   , 125 , 'Electric' , 1, 3 , 'Human-Like' , 25, 6400, 6656, 6630, 6425, 6400, 66.1, 30, 'Medium Fast', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Arcanine]', 59   , 59 , 'Fire' , 1, 3 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 341.7, 155, 'Slow', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Boldore]', 525   , 31 , 'Rock' , 1, 1 , 'Mineral' , 15   , 3855, 3840, 224.9, 102, 'Medium Slow', q'{tentacles or a multiped body}', 5 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type   , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Silvally]', 773  , q'|Type: Electric|', 204 , 'Normal'   , 'U', 'Undiscovered' , 120    , 30720, 221.6, 100.5, 'Slow', q'{quadruped body}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Octillery]', 224   , 175 , 'Water' , 1, 1 , 'Water 1', 'Water 2', 20, 5120, 5376, 5355, 5140, 5120, 62.8, 28.5, 'Medium Fast', q'{tentacles or a multiped body}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Lucario]', 448   , 116 , 'Fighting', 'Steel', 1, 7 , 'Field', 'Human-Like', 25  , 6630, 6425, 6400, 119, 54, 'Medium Slow', q'{bipedal, tailed form}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Rockruff]', 744   , 103 , 'Rock' , 1, 1 , 'Field' , 15    , 3840, 20.3, 9.2, 'Medium Fast', q'{quadruped body}', 7 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type   , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Silvally]', 773  , q'|Type: Steel|', 204 , 'Normal'   , 'U', 'Undiscovered' , 120    , 30720, 221.6, 100.5, 'Slow', q'{quadruped body}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Cascoon]', 268   , 17 , 'Bug' , 1, 1 , 'Bug' , 15 , 4096, 4080, 3855, 3840, 25.4, 11.5, 'Medium Fast', q'{head}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Dusclops]', 356   , 149 , 'Ghost' , 1, 1 , 'Amorphous' , 25 , 6656, 6630, 6425, 6400, 67.5, 30.6, 'Fast', q'{bipedal, tailless form}', 3 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type , Female  , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Florges]', 671  , q'|Orange Flower|', 70, 'Ce', 'Fairy' , 1  , 'Fairy' , 20   , 5140, 5120, 22, 10, 'Medium Fast', q'{head and arms}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Servine]', 496   , 2 , 'Grass' , 1, 7 , 'Field', 'Grass', 20   , 5140, 5120, 35.3, 16, 'Medium Slow', q'{bipedal, tailed form}', 5 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Solgaleo]', 791  , q'|Radiant Sun phase|', 291 , 'Psychic', 'Steel'  , 'U', 'Undiscovered' , 120    , 30720, 507.1, 230, 'Slow', q'{quadruped body}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Golem]', 76   , 76 , 'Rock', 'Ground', 1, 1 , 'Mineral' , 15, 3840, 4096, 4080, 3855, 3840, 661.4, 300, 'Medium Slow', q'{bipedal, tailless form}', 1 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Fletchinder]', 662   , 15, 'Ce', 'Fire', 'Flying', 1, 1 , 'Flying' , 15   , 3855, 3840, 35.3, 16, 'Medium Slow', q'{single pair of wings}', 6 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pikachu]', 25  , q'|Original Cap|', 25 , 'Electric' , 1, 1 , 'Field', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 13.2, 6, 'Medium Fast', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class, LDex , Type, Type2, Female  , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Wormadam]', 413, 'G' , q'|Sandy Cloak|', 46 , 'Bug', 'Ground', 1  , 'Bug' , 15  , 4080, 3855, 3840, 14.3, 6.5, 'Medium Fast', q'{head and a base}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Roggenrola]', 524   , 30 , 'Rock' , 1, 1 , 'Mineral' , 15   , 3855, 3840, 39.7, 18, 'Medium Slow', q'{head and legs}', 5 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Vivillon]', 666  , q'|Fancy Pattern|', 22, 'Ce', 'Bug', 'Flying', 1, 1 , 'Bug' , 15   , 3855, 3840, 37.5, 17, 'Medium Fast', q'{two or more pairs of wings}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Alakazam]', 65   , 65 , 'Psychic' , 1, 3 , 'Human-Like' , 20, 5120, 5376, 5355, 5140, 5120, 105.8, 48, 'Medium Slow', q'{bipedal, tailless form}', 1 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Marshadow]', 802  , q'|Zenith|', 302 , 'Fighting', 'Ghost'  , 'U', 'Undiscovered' , 120    , 30720, 48.9, 22.2, 'Slow', q'{bipedal, tailless form}', 7 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type , Female  , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Florges]', 671  , q'|White Flower|', 70, 'Ce', 'Fairy' , 1  , 'Fairy' , 20   , 5140, 5120, 22, 10, 'Medium Fast', q'{head and arms}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Cobalion]', 638   , 144 , 'Steel', 'Fighting'  , 'U', 'Undiscovered' , 80   , 20560, 20480, 551.2, 250, 'Slow', q'{quadruped body}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type   , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Necrozma]', 800   , 300 , 'Psychic'   , 'U', 'Undiscovered' , 120    , 30720, 507.1, 230, 'Slow', q'{head and arms}', 7 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Rayquaza]', 384, 'M', nq'|None*|', q'|Mega|', 200 , 'Dragon', 'Flying'  , 'U', 'Undiscovered' , 120 , 30976, 30855, 30840, 30720, 455.2, 206.5, 'Slow', q'{serpentine bodies}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Rattata]', 19   , 19 , 'Normal' , 1, 1 , 'Field' , 15, 3840, 4096, 4080, 3855, 3840, 7.7, 3.5, 'Medium Fast', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Skarmory]', 227   , 203 , 'Steel', 'Flying', 1, 1 , 'Flying' , 25, 6400, 6656, 6630, 6425, 6400, 111.3, 50.5, 'Slow', q'{single pair of wings}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Bastiodon]', 411   , 39 , 'Rock', 'Steel', 1, 7 , 'Monster' , 30  , 7905, 7710, 7680, 329.6, 149.5, 'Erratic', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Gourgeist]', 711  , q'|Large Size|', 64, 'Mo', 'Ghost', 'Grass', 1, 1 , 'Amorphous' , 20   , 5140, 5120, 30.9, 14, 'Medium Fast', q'{head and a base}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Tangrowth]', 465   , 182 , 'Grass' , 1, 1 , 'Grass' , 20  , 5355, 5140, 5120, 283.5, 128.6, 'Medium Fast', q'{bipedal, tailless form}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Snorlax]', 143   , 143 , 'Normal' , 1, 7 , 'Monster' , 40, 10240, 10496, 10455, 10280, 10240, 1014.1, 460, 'Slow', q'{bipedal, tailless form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2 , Male, Unbreedable, EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Latios]', 381   , 197 , 'Dragon', 'Psychic' , 1, 'U', 'Undiscovered' , 120 , 30976, 30855, 30840, 30720, 132.3, 60, 'Slow', q'{single pair of wings}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Mienshao]', 620   , 126 , 'Fighting' , 1, 1 , 'Field', 'Human-Like', 25   , 6425, 6400, 78.3, 35.5, 'Medium Slow', q'{bipedal, tailed form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Walrein]', 365   , 175 , 'Ice', 'Water', 1, 1 , 'Water 1', 'Field', 20 , 5376, 5355, 5140, 5120, 332, 150.6, 'Medium Slow', q'{quadruped body}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Seedot]', 273   , 22 , 'Grass' , 1, 1 , 'Field', 'Grass', 15 , 4096, 4080, 3855, 3840, 8.8, 4, 'Medium Slow', q'{head and legs}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Kartana]', 798   , 298 , 'Grass', 'Steel'  , 'U', 'Undiscovered' , 120    , 30720, 0.2, 0.1, 'Slow', q'{bipedal, tailless form}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Celesteela]', 797   , 297 , 'Steel', 'Flying'  , 'U', 'Undiscovered' , 120    , 30720, 2204.4, 999.9, 'Slow', q'{bipedal, tailless form}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Paras]', 46   , 46 , 'Bug', 'Grass', 1, 1 , 'Bug', 'Grass', 20, 5120, 5376, 5355, 5140, 5120, 11.9, 5.4, 'Medium Fast', q'{insectoid body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Masquerain]', 284   , 33 , 'Bug', 'Flying', 1, 1 , 'Water 1', 'Bug', 15 , 4096, 4080, 3855, 3840, 7.9, 3.6, 'Medium Fast', q'{two or more pairs of wings}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female  , EggGroup1, EggGroup2, Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Salazzle]', 758   , 162 , 'Poison', 'Fire', 1  , 'Monster', 'Dragon', 20    , 5120, 48.9, 22.2, 'Medium Fast', q'{quadruped body}', 7 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type, Type2   , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Rotom]', 479  , q'|Fan|', 152 , 'Electric', 'Ghost'   , 'Amorphous' , 20  , 5355, 5140, 5120, 0.7, 0.3, 'Medium Fast', q'{head}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Ariados]', 168   , 33 , 'Bug', 'Poison', 1, 1 , 'Bug' , 15, 3840, 4096, 4080, 3855, 3840, 73.9, 33.5, 'Fast', q'{insectoid body}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type   , Unbreedable, EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Mesprit]', 481   , 147 , 'Psychic'   , 'U', 'Undiscovered' , 80  , 20655, 20560, 20480, 0.7, 0.3, 'Slow', q'{bipedal, tailed form}', 4 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class, LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pikachu]', 25, 'Pa' , q'|Partner|', 25 , 'Electric' , 1, 1 , 'Field', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 13.2, 6, 'Medium Fast', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pelipper]', 279   , 28 , 'Water', 'Flying', 1, 1 , 'Water 1', 'Flying', 20 , 5376, 5355, 5140, 5120, 61.7, 28, 'Medium Fast', q'{single pair of wings}', 3 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Trevenant]', 709   , 62, 'Mo', 'Ghost', 'Grass', 1, 1 , 'Grass', 'Amorphous', 20   , 5140, 5120, 156.5, 71, 'Medium Fast', q'{tentacles or a multiped body}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Kadabra]', 64   , 64 , 'Psychic' , 1, 3 , 'Human-Like' , 20, 5120, 5376, 5355, 5140, 5120, 124.6, 56.5, 'Medium Slow', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pineco]', 204   , 93 , 'Bug' , 1, 1 , 'Bug' , 20, 5120, 5376, 5355, 5140, 5120, 15.9, 7.2, 'Medium Fast', q'{head}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Scolipede]', 545   , 51 , 'Bug', 'Poison', 1, 1 , 'Bug' , 20   , 5140, 5120, 442, 200.5, 'Medium Slow', q'{insectoid body}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Beartic]', 614   , 120 , 'Ice' , 1, 1 , 'Field' , 20   , 5140, 5120, 573.2, 260, 'Medium Fast', q'{quadruped body}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Exeggcute]', 102   , 102 , 'Grass', 'Psychic', 1, 1 , 'Grass' , 20, 5120, 5376, 5355, 5140, 5120, 5.5, 2.5, 'Slow', q'{multiple bodies}', 1 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Venusaur]', 3, 'M', nq'|Venusaurite|', q'|Mega|', 3 , 'Grass', 'Poison', 1, 7 , 'Monster', 'Grass', 20, 5120, 5376, 5355, 5140, 5120, 220.5, 100, 'Medium Slow', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2   , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Solrock]', 338   , 126 , 'Rock', 'Psychic'   , 'Mineral' , 25 , 6656, 6630, 6425, 6400, 339.5, 154, 'Fast', q'{head}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Taillow]', 276   , 25 , 'Normal', 'Flying', 1, 1 , 'Flying' , 15 , 4096, 4080, 3855, 3840, 5.1, 2.3, 'Medium Slow', q'{single pair of wings}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pikachu]', 25   , 25 , 'Electric' , 1, 1 , 'Field', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 13.2, 6, 'Medium Fast', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Chatot]', 441   , 102 , 'Normal', 'Flying', 1, 1 , 'Flying' , 20  , 5355, 5140, 5120, 4.2, 1.9, 'Medium Slow', q'{single pair of wings}', 4 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Slurpuff]', 685   , 132, 'Ce', 'Fairy' , 1, 1 , 'Fairy' , 20   , 5140, 5120, 11, 5, 'Medium Fast', q'{bipedal, tailless form}', 6 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Braixen]', 654   , 5, 'Ce', 'Fire' , 1, 7 , 'Field' , 20   , 5140, 5120, 32, 14.5, 'Medium Slow', q'{bipedal, tailed form}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Donphan]', 232   , 201 , 'Ground' , 1, 1 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 264.6, 120, 'Medium Fast', q'{quadruped body}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Girafarig]', 203   , 149 , 'Normal', 'Psychic', 1, 1 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 91.5, 41.5, 'Medium Fast', q'{quadruped body}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type  , Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Hitmonchan]', 107   , 107 , 'Fighting'  , 1 , 'Human-Like' , 25, 6400, 6656, 6630, 6425, 6400, 110.7, 50.2, 'Medium Fast', q'{bipedal, tailless form}', 1 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pikachu]', 25  , q'|Belle|', 25 , 'Electric' , 1, 1 , 'Field', 'Fairy', 10, 2560, 2816, 2805, 2570, 2560, 13.2, 6, 'Medium Fast', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Vivillon]', 666  , q'|Savanna Pattern|', 22, 'Ce', 'Bug', 'Flying', 1, 1 , 'Bug' , 15   , 3855, 3840, 37.5, 17, 'Medium Fast', q'{two or more pairs of wings}', 6 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Vivillon]', 666  , q'|Archipelago Pattern|', 22, 'Ce', 'Bug', 'Flying', 1, 1 , 'Bug' , 15   , 3855, 3840, 37.5, 17, 'Medium Fast', q'{two or more pairs of wings}', 6 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type   , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Silvally]', 773  , q'|Type: Dark|', 204 , 'Normal'   , 'U', 'Undiscovered' , 120    , 30720, 221.6, 100.5, 'Slow', q'{quadruped body}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Fraxure]', 611   , 117 , 'Dragon' , 1, 1 , 'Monster', 'Dragon', 40   , 10280, 10240, 79.4, 36, 'Slow', q'{bipedal, tailed form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Drilbur]', 529   , 35 , 'Ground' , 1, 1 , 'Field' , 20   , 5140, 5120, 18.7, 8.5, 'Medium Fast', q'{bipedal, tailed form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Eelektross]', 604   , 110 , 'Electric' , 1, 1 , 'Amorphous' , 20   , 5140, 5120, 177.5, 80.5, 'Slow', q'{fins}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Mareanie]', 747   , 113 , 'Poison', 'Water', 1, 1 , 'Water 1' , 20    , 5120, 17.6, 8, 'Medium Fast', q'{head and a base}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Tympole]', 535   , 41 , 'Water' , 1, 1 , 'Water 1' , 20   , 5140, 5120, 9.9, 4.5, 'Medium Slow', q'{fins}', 5 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class, LDex , Type   , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Necrozma]', 800, 'DM' , q'|Dusk Mane|', 300 , 'Psychic'   , 'U', 'Undiscovered' , 120    , 30720, 1014.1, 460, 'Slow', q'{quadruped body}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Dewpider]', 751   , 141 , 'Water', 'Bug', 1, 1 , 'Water 1', 'Bug', 15    , 3840, 8.8, 4, 'Medium Fast', q'{head and legs}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Flaaffy]', 180   , 54 , 'Electric' , 1, 1 , 'Monster', 'Field', 20, 5120, 5376, 5355, 5140, 5120, 29.3, 13.3, 'Medium Slow', q'{bipedal, tailed form}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Phanpy]', 231   , 200 , 'Ground' , 1, 1 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 73.9, 33.5, 'Medium Fast', q'{quadruped body}', 2 );     
insert into Pokemon( Name, Dex  , Class, LDex, LDex_Suffix, Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Pumpkaboo]', 710  , q'|Average Size|', 63, 'Mo', 'Ghost', 'Grass', 1, 1 , 'Amorphous' , 20   , 5140, 5120, 11, 5, 'Medium Fast', q'{head}', 6 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class  , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Persian]', 53, 'A' , q'|Alolan|'  , 'Dark' , 1, 1 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 70.5, 32, 'Medium Fast', q'{quadruped body}', 1 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type   , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Silvally]', 773  , q'|Type: Rock|', 204 , 'Normal'   , 'U', 'Undiscovered' , 120    , 30720, 221.6, 100.5, 'Slow', q'{quadruped body}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Gyarados]', 130   , 130 , 'Water', 'Flying', 1, 1 , 'Water 2', 'Dragon', 5, 1280, 1536, 1530, 1285, 1280, 518.1, 235, 'Slow', q'{serpentine bodies}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Rhydon]', 112   , 112 , 'Ground', 'Rock', 1, 1 , 'Monster', 'Field', 20, 5120, 5376, 5355, 5140, 5120, 264.6, 120, 'Slow', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Sunflora]', 192   , 104 , 'Grass' , 1, 1 , 'Grass' , 20, 5120, 5376, 5355, 5140, 5120, 18.7, 8.5, 'Medium Slow', q'{bipedal, tailless form}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Bruxish]', 779   , 243 , 'Water', 'Psychic', 1, 1 , 'Water 2' , 15    , 3840, 41.9, 19, 'Medium Fast', q'{fins}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Elgyem]', 605   , 111 , 'Psychic' , 1, 1 , 'Human-Like' , 20   , 5140, 5120, 19.8, 9, 'Medium Fast', q'{bipedal, tailed form}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Patrat]', 504   , 10 , 'Normal' , 1, 1 , 'Field' , 15   , 3855, 3840, 25.6, 11.6, 'Medium Fast', q'{quadruped body}', 5 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Palpitoad]', 536   , 42 , 'Water', 'Ground', 1, 1 , 'Water 1' , 20   , 5140, 5120, 37.5, 17, 'Medium Slow', q'{bipedal, tailed form}', 5 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class, LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Charizard]', 6, 'MX' , q'|Mega  X|', 6 , 'Fire', 'Flying', 1, 7 , 'Monster', 'Dragon', 20, 5120, 5376, 5355, 5140, 5120, 199.5, 90.5, 'Medium Slow', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type, Type2, Female , Unbreedable, EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Latias]', 380, 'M', nq'|Latiasite|', q'|Mega|', 196 , 'Dragon', 'Psychic', 1 , 'U', 'Undiscovered' , 120 , 30976, 30855, 30840, 30720, 88.2, 40, 'Slow', q'{single pair of wings}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Gliscor]', 472   , 154 , 'Ground', 'Flying', 1, 1 , 'Bug' , 20  , 5355, 5140, 5120, 93.7, 42.5, 'Medium Slow', q'{single pair of wings}', 4 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Kyurem]', 646  , q'|Normal|', 152 , 'Dragon', 'Ice'  , 'U', 'Undiscovered' , 120   , 30840, 30720, 716.5, 325, 'Slow', q'{bipedal, tailed form}', 5 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class  , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Dugtrio]', 51, 'A' , q'|Alolan|'  , 'Ground', 'Steel', 1, 1 , 'Field' , 20, 5120, 5376, 5355, 5140, 5120, 73.4, 33.3, 'Medium Fast', q'{multiple bodies}', 1 );     
insert into Pokemon( Name, Dex, Dex_Suffix, Item, Class, LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Tyranitar]', 248, 'M', nq'|Tyranitarite|', q'|Mega|', 251 , 'Rock', 'Dark', 1, 1 , 'Monster' , 40, 10240, 10496, 10455, 10280, 10240, 445.3, 202, 'Slow', q'{bipedal, tailed form}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Abra]', 63   , 63 , 'Psychic' , 1, 3 , 'Human-Like' , 20, 5120, 5376, 5355, 5140, 5120, 43, 19.5, 'Medium Slow', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Shieldon]', 410   , 38 , 'Rock', 'Steel', 1, 7 , 'Monster' , 30  , 7905, 7710, 7680, 125.7, 57, 'Erratic', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male, Unbreedable, EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Mime Jr.]', 439   , 94 , 'Psychic', 'Fairy', 1, 1, 'U', 'Undiscovered' , 25  , 6630, 6425, 6400, 28.7, 13, 'Medium Fast', q'{bipedal, tailless form}', 4 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Skiddo]', 672   , 89, 'Ce', 'Grass' , 1, 1 , 'Field' , 20   , 5140, 5120, 68.3, 31, 'Medium Fast', q'{quadruped body}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1, EggGroup2, Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Cacnea]', 331   , 119 , 'Grass' , 1, 1 , 'Grass', 'Human-Like', 20 , 5376, 5355, 5140, 5120, 113.1, 51.3, 'Medium Slow', q'{bipedal, tailless form}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Torchic]', 255   , 4 , 'Fire' , 1, 7 , 'Field' , 20 , 5376, 5355, 5140, 5120, 5.5, 2.5, 'Medium Slow', q'{head and legs}', 3 );     
insert into Pokemon( Name, Dex  , Class, LDex , Type   , Unbreedable, EggGroup1 , Cycles    , Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Silvally]', 773  , q'|Type: Fire|', 204 , 'Normal'   , 'U', 'Undiscovered' , 120    , 30720, 221.6, 100.5, 'Slow', q'{quadruped body}', 7 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2 , Male , EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Mothim]', 414   , 47 , 'Bug', 'Flying' , 1 , 'Bug' , 15  , 4080, 3855, 3840, 51.4, 23.3, 'Medium Fast', q'{two or more pairs of wings}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type , Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Banette]', 354   , 147 , 'Ghost' , 1, 1 , 'Amorphous' , 25 , 6656, 6630, 6425, 6400, 27.6, 12.5, 'Fast', q'{bipedal, tailed form}', 3 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Jigglypuff]', 39   , 39 , 'Normal', 'Fairy', 3, 1 , 'Fairy' , 10, 2560, 2816, 2805, 2570, 2560, 12.1, 5.5, 'Fast', q'{bipedal, tailless form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles , Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Sableye]', 302   , 68 , 'Dark', 'Ghost', 1, 1 , 'Human-Like' , 25 , 6656, 6630, 6425, 6400, 24.3, 11, 'Medium Slow', q'{bipedal, tailless form}', 3 );     
insert into Pokemon( Name, Dex   , LDex, LDex_Suffix, Type , Female, Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Frogadier]', 657   , 8, 'Ce', 'Water' , 1, 7 , 'Water 1' , 20   , 5140, 5120, 24, 10.9, 'Medium Slow', q'{bipedal, tailless form}', 6 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Ledian]', 166   , 31 , 'Bug', 'Flying', 1, 1 , 'Bug' , 15, 3840, 4096, 4080, 3855, 3840, 78.5, 35.6, 'Fast', q'{single pair of wings}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Gengar]', 94   , 94 , 'Ghost', 'Poison', 1, 1 , 'Amorphous' , 20, 5120, 5376, 5355, 5140, 5120, 89.3, 40.5, 'Medium Slow', q'{bipedal, tailed form}', 1 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2  , Unbreedable, EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Ho-Oh]', 250   , 253 , 'Fire', 'Flying'  , 'U', 'Undiscovered' , 120, 30720, 30976, 30855, 30840, 30720, 438.7, 199, 'Slow', q'{single pair of wings}', 2 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2, Female, Male , EggGroup1, EggGroup2, Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Ferrothorn]', 598   , 104 , 'Grass', 'Steel', 1, 1 , 'Grass', 'Mineral', 20   , 5140, 5120, 242.5, 110, 'Medium Fast', q'{tentacles or a multiped body}', 5 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class  , Type, Type2  , Unbreedable, EggGroup1 , Cycles  , Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Shaymin]', 492, 'S' , q'|Sky Forme|'  , 'Grass', 'Flying'  , 'U', 'Undiscovered' , 120  , 30855, 30840, 30720, 11.5, 5.2, 'Medium Slow', q'{quadruped body}', 4 );     
insert into Pokemon( Name, Dex   , LDex , Type, Type2 , Male , EggGroup1 , Cycles   , Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Braviary]', 628   , 134 , 'Normal', 'Flying' , 1 , 'Flying' , 20   , 5140, 5120, 90.4, 41, 'Slow', q'{single pair of wings}', 5 );     
insert into Pokemon( Name, Dex, Dex_Suffix , Class  , Type, Type2, Female, Male , EggGroup1 , Cycles, Steps_Gen2, Steps_Gen3, Steps_Gen4, Steps_Gen5, Steps_Gen7, WeightLbs, WeightKg, Experience_Type, Body, Gen )     
values( nq'[Graveler]', 75, 'A' , q'|Alolan|'  , 'Rock', 'Electric', 1, 1 , 'Mineral' , 15, 3840, 4096, 4080, 3855, 3840, 231.5, 105, 'Medium Slow', q'{bipedal, tailless form}', 1 );