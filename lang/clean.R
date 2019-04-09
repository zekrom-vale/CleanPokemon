PokemonRaw_Pokemon_Names_Lang=read_csv("lang/PokemonRaw - Pokemon Names Lang.csv");

PokemonRaw_Pokemon_Names_Lang

##################################################################
# 														Extract
##################################################################

japanese=PokemonRaw_Pokemon_Names_Lang[1:5];

PokemonRaw_Pokemon_Names_Lang%<>%
	select(-(1:5));

german=PokemonRaw_Pokemon_Names_Lang[1:3]%>%
	rename(
		ID=ID_1,
		English=English_1
	);

PokemonRaw_Pokemon_Names_Lang%<>%
	select(-(1:3));

french=PokemonRaw_Pokemon_Names_Lang[1:3]%>%
	rename(
		ID=ID_2,
		English=English_2
	);

PokemonRaw_Pokemon_Names_Lang%<>%
	select(-(1:3));

korean=PokemonRaw_Pokemon_Names_Lang[1:6]%>%
	rename(
		ID=ID_3,
		English=English_3
	);

PokemonRaw_Pokemon_Names_Lang%<>%
	select(-(1:6));

chinese=PokemonRaw_Pokemon_Names_Lang[1:7]%>%
	rename(
		ID=ID_4,
		English=English_4
	);

rm(PokemonRaw_Pokemon_Names_Lang);


##################################################################
# 														Join
##################################################################

by=c("ID", "English");
pokemonLang=japanese%>%
	left_join(
		german,
		by=by
	)%>%
	left_join(
		french,
		by=by
	)%>%
	left_join(
		korean,
		by=by
	)%>%
	left_join(
		chinese,
		by=by
	);

# Somthing missing

japanese%>%
	anti_join(
		german,
		by=by,
		na_matches=
	)%>%
	anti_join(
		french,
		by=by
	)%>%
	anti_join(
		korean,
		by=by
	)%>%
	anti_join(
		chinese,
		by=by
	);
# Not joining on NA
# No, some tables do not have them

rm(japanese, german, french, korean, chinese, by);

# Convet ID to int
pokemonLang%<>%
	mutate(
		ID=if_else(str_detect(ID, "\\?{3}"),-1L, as.integer(ID))
	);

write_csv(pokemonLang, "datasets/pokemonLang.csv", na="");
write_csv(pokemonLang%>%filter(!is.na(ID),ID>=0), "datasets/pokemonLang_noNA.csv", na="");
