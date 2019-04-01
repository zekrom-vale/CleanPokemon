# Condence Gender_Ratio into key form
agg%<>%
	mutate(
		Unbreedable=if_else(is.na(Unbreedable),"",Unbreedable)
	)%>%
	unite(
		Gender_Ratio,
		Female,Male,
		sep=":"
	)%>%
	unite(
		Gender_Ratio,
		Gender_Ratio,
		Unbreedable,
		sep=""
	)%>%
	mutate(
		Gender_Ratio=case_when(
			Gender_Ratio=="NA:NAU"~"GU",
			Gender_Ratio=="NA:NA"~"G",
			Gender_Ratio=="NA:NAU*"~"G*",
			TRUE~Gender_Ratio
		)
	);

agg%<>%
	mutate(
		Body=gsub("Pokémon\\s*(?:consisting of( only an?)?|with an?|with|consisting of an?)\\s*", "", Body)
	)%>%
	mutate(
		Body=paste0(str_to_upper(str_sub(Body,1,1)),str_sub(Body,2,-1))
	);

# (agg%>%
#  	mutate(
#  		Star=as.integer(Star),
#  		Ability1Star=as.integer(Ability1Star),
#  		Ability2Star=if_else(is.na(Ability2Star),0L,as.integer(Ability2Star))
#  	)%>%
# 	mutate(
# 		Star=Star*2^2+Ability1Star*2^1+Ability2Star*2^0,
# 		Ability1Star=NULL,
# 		Ability2Star=NULL
# 	)
#  )$Star;

# Save
agg%<>%
	mutate(
		Star=if_else(is.na(Star), 0L, as.integer(Star*2^3))+
			if_else(is.na(Ability1Star), 0L, as.integer(Ability1Star*2^2))+
			if_else(is.na(Ability2Star), 0L, as.integer(Ability2Star*2^1))+
			if_else(is.na(HiddenAbilityStar), 0L, as.integer(HiddenAbilityStar*2^0)),
		Ability1Star=NULL,
		Ability2Star=NULL,
		HiddenAbilityStar=NULL
	);

# Decode pos 3 = x%/%2^2
# Decode pos 2 = x%/%2%%2
# Decode pos 1 = x%%2

# Remove junk
agg%<>%
	select(
		-Type1,
		-Alt
	);

# Fix mega Rayquaza
agg%<>%
	mutate(
		Item=if_else(str_detect(Item, "\\*")&Name=="Rayquaza", "Meteorite", Item)
	);

rm(dexes, dexsuff, types.agg, types.agg.j);
write_csv(agg,path="core/agg.csv",na="");
