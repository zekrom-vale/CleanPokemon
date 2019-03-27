PokemonRaw_Core_Pokemon=read_csv("PokemonRaw - Core Pokemon.csv");
#####################
# Cleen and Seperate
#####################
PokemonRaw_Core_Pokemon

reg="\\s*#?(\\d+)?([[:alpha:]]+)?\\s*";
into=c("Dex","Dex_Suffix");

# Extract Dex

exc=PokemonRaw_Core_Pokemon%>%
	extract(
		ID_Ext,
		into=into,
		regex=reg
	)%>%
	extract(
		Ldex,
		into=paste0("L",into),
		regex=reg
	)%>%
	mutate(
		LDex=as.integer(LDex),
		Dex=as.integer(Dex),
		ID=NULL
	);

# Save
dex=exc[1:7];
PokemonRaw_Core_Pokemon=exc%>%select(-c(1:7));

# Extract gender
exc=PokemonRaw_Core_Pokemon%>%
	mutate(
	  ID_1=as.integer(ID_1)
  )%>%
	rename(Dex=ID_1,Name=Name_1);

gender=exc[1:5];
PokemonRaw_Core_Pokemon=exc%>%select(-c(1:5));

# Extract Egg group

exc=PokemonRaw_Core_Pokemon%>%
	mutate(
		ID_2=as.integer(ID_2),
		`Egg Group 1`=if_else(`Egg Group 1`=="—",NA_character_,`Egg Group 1`),
		`Egg Group 2`=if_else(`Egg Group 2`=="—",NA_character_,`Egg Group 2`),
		Cycles=as.integer(Cycles),
		Steps_Gen2=as.integer(Steps_Gen2),
		Steps_Gen3=as.integer(Steps_Gen3),
		Steps_Gen4=as.integer(Steps_Gen4),
		Steps_Gen5=as.integer(Steps_Gen5),
		Steps_Gen6=as.integer(Steps_Gen6)
	)%>%
	rename(
		ID=ID_2,
		Name=Name_2
	);

# Save
eggGroup=exc[1:10];
PokemonRaw_Core_Pokemon=exc%>%select(-c(1:10));

# Extract weight

exc=PokemonRaw_Core_Pokemon%>%
	extract(
		ID_Ext_1,
		into=into,
		regex=reg
	)%>%
	mutate(
		Dex=as.integer(Dex),
		WeightLbs=as.double(gsub("\\s*lbs\\.\\s*","", WeightLbs)),
		WeightKg=as.double(gsub("\\s*kg\\s*","", WeightKg))
	)%>%
	rename(
		Name=Name_3
	);
# Save
weight=exc[1:5];
PokemonRaw_Core_Pokemon=exc%>%select(-c(1:5));

# Fix weight
weight%>%
	filter(
		WeightKg!=0&WeightLbs!=0
	);

# What am I removing?
weight%>%
	filter(
		WeightKg==0|WeightLbs==0
	)%>%View();

# Save
weight=weight%>%
	filter(
		WeightKg!=0&WeightLbs!=0
	);

# Extract Exp
exc=PokemonRaw_Core_Pokemon%>%
	rename(Dex=ID_3, Name=Name_4)%>%mutate(
		Dex=as.integer(Dex)
	);

# Save
exp=exc[1:3];
PokemonRaw_Core_Pokemon=exc%>%select(-(1:3));

# Extract body
exc=PokemonRaw_Core_Pokemon%>%
	extract(
		ID_Ext_2,
		into=into,
		regex=reg
	)%>%
	mutate(
		Body=gsub("Pokémon\\s*(?:consisting of( only an?)?|with an?|with|consisting of an?)\\s*", "", Body),
		Dex=as.integer(Dex)
	)%>%
	rename(
		Name=Name_5,
		Type2=Type2_1
	);

# Save
body=exc[1:7];
PokemonRaw_Core_Pokemon=exc%>%select(-(1:7));

# Remove NA Dex and ID_4
body%>%
	filter(
		!is.na(Dex)
	)%>%
	select(-ID_4);

# Save
body=body%>%
	filter(
		!is.na(Dex)
	)%>%
	select(-ID_4);

# Extract color

exc=PokemonRaw_Core_Pokemon%>%
	extract(
		ID_5,
		into=into,
		regex=reg
	)%>%
	rename(Name=Name_6)%>%
	mutate(
		Dex=as.integer(Dex)
	);

# Save
color=exc[1:4];
PokemonRaw_Core_Pokemon=exc%>%select(-(1:4));

# Extract Ability
exc=PokemonRaw_Core_Pokemon%>%
	extract(
		ID_Ext_3,
		into=into,
		regex=reg
	)%>%
	mutate(
		Dex=as.integer(Dex)
	)%>%
	rename(
		ID=ID_10,
		Name=Name_7
	);

# Save
ability=exc[1:7];
PokemonRaw_Core_Pokemon=exc%>%select(-(1:7));

# Remove ID_6
ability=ability%>%select(-ID_6);

# Extract Evolution

exc=PokemonRaw_Core_Pokemon%>%
	extract(
		ID_7,
		into=into,
		regex=reg
	)%>%
	mutate(
		Dex=as.integer(Dex)
	)%>%
	rename(Name=Name_8);

# Save
evolution=exc[1:4];
PokemonRaw_Core_Pokemon=exc%>%select(-(1:4));

# Extract Firendship
exc=PokemonRaw_Core_Pokemon%>%
	rename(
		Dex=ID_8,
		Name=Name_9
	)%>%
	mutate(
		`Base friendship`=as.integer(`Base friendship`),
		Dex=as.integer(Dex)
	);

# Save
friend=exc[1:3];
PokemonRaw_Core_Pokemon=exc%>%select(-(1:3));

# Extract Call rate
PokemonRaw_Core_Pokemon$Call_Rate_SM
# Has —'s
exc=PokemonRaw_Core_Pokemon%>%
	mutate(
		Call_Rate_SM=as.integer(Call_Rate_SM),
		Call_Rate_USUM=as.integer(Call_Rate_USUM),
		ID_9=as.integer(ID_9)
	)%>%
	rename(Dex=ID_9, Name=Name_10);

# Save
call=exc[1:4];
PokemonRaw_Core_Pokemon=exc%>%select(-(1:4));

# Extract Habitat
exc=PokemonRaw_Core_Pokemon%>%
	extract(
		Ndex,
		into=into,
		regex=reg
	)%>%
	mutate(
		Habitat=gsub("\\s*Pokémon.*$","",Habitat),
		Page=as.integer(gsub("Page\\s*","",Page)),
		Dex=as.integer(Dex)
	)%>%
	rename(
		Name=Name_11
	);

# Save
habatat=exc[1:7];
iq=exc%>%
	select(-(1:7))%>%
	rename(
		Name=Name_12,
		Type=Type_2,
		Type2=Type2_3
	)%>%
	extract(
		ID,
		into=into,
		regex=reg
	)%>%
	mutate(
		Group=gsub("Group\\s*","",Group),
		Dex=as.integer(Dex)
	)%>%
	filter(
		!is.na(Dex)
	);

rm(exc, PokemonRaw_Core_Pokemon, reg, into, agg.j, agg.comp, dex.j);

