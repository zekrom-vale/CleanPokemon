###################################################################################
#																	Separate
###################################################################################
# Separate into tables
pokemon=agg%>%
	select(
		Name,
		Dex,
		Page,
		Habitat,
		LDex,
		LDex_Suffix,
		Gen,
		Group
	);

# next_evolutions,
# previous_evolution,
# family

species=agg%>%
	select(
		Name,
		Dex,
		Class,
		Dex_Suffix,
		Item,
		`Egg Group 1`,
		`Egg Group 2`,
		Type,
		Type2,
		Body,
		Color,
		Call_Rate_SM,
		Call_Rate_USUM,
		Star,
		Gender_Ratio,
		Cycles,
		`Ability 1`,
		`Ability 2`,
		Hidden,
		WeightKg,
		WeightLbs,
		HeightM,
		Ft,
		In
	);
# IS_ALOLAN
# IS_MEGA
# IS_PRIMORDIAL
###################################################################################
#																	Fix Pokemon
###################################################################################
pokemon%>%
	distinct()%>%
	not_distinct(Name, Dex)%>%
	arrange(Name);
# Only duplicates are ones that have no ldex

pokemon%<>%
	distinct();

pokemon%<>%
	only_distinct(Name, Dex)%>%
	union(
		pokemon%>%
			not_distinct(Name, Dex)%>%
			filter_not_na(LDex)
	);

write_csv(pokemon, path="datasets/pokemon.csv",na="");
write_csv(species, path="datasets/species.csv",na="");

rm(agg);