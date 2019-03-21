types.agg%>%
	anti_join(
		agg,
		by=c(Dex="Dex", Name="Pokémon")
	);

# Modify the ones that don't match

# DNE
# agg%>%filter(str_detect(Pokémon,"Meltan"))
# agg%>%filter(str_detect(Pokémon,"Melmetal"))

# Necrozma
# Need to match manualy

agg%>%
	anti_join(
		types.agg,
		by=c(Dex="Dex", Pokémon="Name")
	);
# Empty




types.agg%>%
	right_join(
		agg,
		by=c(Dex="Dex", Name="Pokémon")
	)%>%View();
# Save
agg.comp=types.agg%>%
	right_join(
		agg,
		by=c(Dex="Dex", Name="Pokémon")
	);

# Need to overite Type if Form_Type Exists

agg.comp%>%
	mutate(
		Type=if_else(is.na(Form_Type1),Type,Form_Type1),
		Type2=if_else(is.na(Form_Type2),Type2,Form_Type2),
		Form_Type1=NULL,# Remove redundent columns
		Form_Type2=NULL
	)%>%View();
# Save
agg.comp=agg.comp%>%
	mutate(
		Type=if_else(is.na(Form_Type1),Type,Form_Type1),
		Type2=if_else(is.na(Form_Type2),Type2,Form_Type2),
		Form_Type1=NULL,
		Form_Type2=NULL
	);

# What is in Dex_suffix
agg.comp%>%filter(!is.na(Dex_suffix))

# Nothing!
agg.comp%>%
	select(-Dex_suffix); # Remove the empty column

# Save
agg.comp=agg.comp%>%
	select(-Dex_suffix);

# Discovered there are many duplicates
agg.comp%>%
	distinct();
# Save
agg.comp=agg.comp%>%
	distinct();

# Matching Rotom Blindly
# types.agg%>%filter(Name=="Rotom")
# Should have waited for types and body


write_csv(agg.comp, "agg.comp.csv", na="");