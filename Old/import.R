library(tidyverse);
PokemonRaw_Core_Pokemon=read_csv("PokemonRaw - Core Pokemon.csv");
View(PokemonRaw_Core_Pokemon);

names(PokemonRaw_Core_Pokemon);
# Split tables
dex=PokemonRaw_Core_Pokemon[1:5]; # Done
gender=PokemonRaw_Core_Pokemon[6:10];
#eggGroup=PokemonRaw_Core_Pokemon[11:14];
# Found it is identical
eggGroup=PokemonRaw_Core_Pokemon[15:24]; # Done
weight=PokemonRaw_Core_Pokemon[25:30];
exp=PokemonRaw_Core_Pokemon[31:33]; # Done
body=PokemonRaw_Core_Pokemon[34:36]; # Done
color=PokemonRaw_Core_Pokemon[37:39];
ability=PokemonRaw_Core_Pokemon[40:44];
evolution=PokemonRaw_Core_Pokemon[45:47];
friend=PokemonRaw_Core_Pokemon[48:50]; # Done
call=PokemonRaw_Core_Pokemon[51:54]; # Done
habatat=PokemonRaw_Core_Pokemon[55:60]; # Done
iq=PokemonRaw_Core_Pokemon[61:65];

rm(PokemonRaw_Core_Pokemon);

PokemonRaw_Varations=read_csv("PokemonRaw - Varations.csv");
View(PokemonRaw_Varations);

PokemonRaw_Alts=read_csv("PokemonRaw - Alts.csv");
View(PokemonRaw_Alts);

PokemonRaw_Base_IV=read_csv("PokemonRaw - Base_IV.csv");
View(PokemonRaw_Base_IV);

varations=PokemonRaw_Varations[1:3];
varations.names=PokemonRaw_Varations;
alts=PokemonRaw_Alts;
types=PokemonRaw_Base_IV[1:3];

rm(PokemonRaw_Varations, PokemonRaw_Alts, PokemonRaw_Base_IV);
