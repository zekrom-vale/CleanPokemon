#source("import.R");

######
# dex
######

?extract
dex%>%
	extract(
		ID,
		into=c("Dex","Dex_suffix"),
		regex="\\s*#?(\\d+)?([[:alpha:]]+)?\\s*"
	)%>%
	extract(
		Ldex,
		into=c("LDex","LDex_suffix"),
		regex="\\s*#?(\\d+)?([[:alpha:]]+)?\\s*"
	)%>%
	filter(!is.na(Pokémon))%>% # Lags due to too much
	View();

# Save
dex.f=dex%>%
	extract(
		ID,
		into=c("Dex","Dex_suffix"),
		regex="\\s*#?(\\d+)?([[:alpha:]]+)?\\s*"
	)%>%
	extract(
		Ldex,
		into=c("LDex","LDex_suffix"),
		regex="\\s*#?(\\d+)?([[:alpha:]]+)?\\s*"
	)%>%
	filter(!is.na(Pokémon));

# Set undefined local dexes
dex.f%>%
	filter(is.na(LDex))%>%
	inner_join(
		dex.f%>%filter(!is.na(LDex)),
		by=c("Dex"="Dex", "Dex_suffix"="Dex_suffix"),
		suffix=c("j","")
	)%>%
	mutate( # Catch if they don't have a local index
		Pokémon=if_else(is.na(Pokémon),Pokémonj,Pokémon),
		Type=if_else(is.na(Type), Typej, Type),
		Type2=if_else(is.na(Type2), Type2j, Type2)
	)%>%
	select(-c(LDexj,LDex_suffixj,Pokémonj,Typej,Type2j));

# Union them
dex.f%>%
	filter(!is.na(LDex))%>%
	union(
		dex.f%>%
			filter(is.na(LDex))%>%
			inner_join(
				dex.f%>%filter(!is.na(LDex)),
				by=c("Dex"="Dex", "Dex_suffix"="Dex_suffix"),
				suffix=c("j","")
			)%>%
			mutate(
				Pokémon=if_else(is.na(Pokémon),Pokémonj,Pokémon),
				Type=if_else(is.na(Type), Typej, Type),
				Type2=if_else(is.na(Type2), Type2j, Type2)
			)%>%
			select(-c(LDexj,LDex_suffixj,Pokémonj,Typej,Type2j))
	)%>%View();

# Save

dex.f=dex.f%>%
	filter(!is.na(LDex))%>%
	union(
		dex.f%>%
			filter(is.na(LDex))%>%
			left_join(
				dex.f%>%filter(!is.na(LDex)),
				by=c("Dex"="Dex", "Dex_suffix"="Dex_suffix"),
				suffix=c("j","")
			)%>%
			mutate(
				Pokémon=if_else(is.na(Pokémon),Pokémonj,Pokémon),
				Type=if_else(is.na(Type), Typej, Type),
				Type2=if_else(is.na(Type2), Type2j, Type2)
			)%>%
			select(-c(LDexj,LDex_suffixj,Pokémonj,Typej,Type2j))
	);

# Fix dex to a number
dex.f%>%
	mutate(
		Dex=as.integer(Dex),
		LDex=as.integer(LDex)
	);

# Save
dex.f=dex.f%>%
	mutate(
		Dex=as.integer(Dex),
		LDex=as.integer(LDex)
	);

###########
# eggGroup
###########

# Remove — and change to ints where applicable
eggGroup%>%
	mutate(
		`Egg Group 1_1`=if_else(`Egg Group 1_1`=="—",NA_character_,`Egg Group 1_1`),
		`Egg Group 2_1`=if_else(`Egg Group 2_1`=="—",NA_character_,`Egg Group 2_1`),
		Steps_Gen2=as.integer(Steps_Gen2),
		Steps_Gen3=as.integer(Steps_Gen3),
		Steps_Gen4=as.integer(Steps_Gen4),
		Steps_Gen5=as.integer(Steps_Gen5),
		Steps_Gen6=as.integer(Steps_Gen6),
		Cycles=as.integer(Cycles)
	);

# Save
eggGroup.f=eggGroup%>%
	mutate(
		`Egg Group 1_1`=if_else(`Egg Group 1_1`=="—",NA_character_,`Egg Group 1_1`),
		`Egg Group 2_1`=if_else(`Egg Group 2_1`=="—",NA_character_,`Egg Group 2_1`),
		Steps_Gen2=as.integer(Steps_Gen2),
		Steps_Gen3=as.integer(Steps_Gen3),
		Steps_Gen4=as.integer(Steps_Gen4),
		Steps_Gen5=as.integer(Steps_Gen5),
		Steps_Gen6=as.integer(Steps_Gen6),
		Cycles=as.integer(Cycles)
	);


# inner join dex and egg
dex.f%>%
	inner_join(eggGroup.f,by=c("Dex"="ID_3", "Pokémon"="Pokémon_2"));

# Find missmatches
dex.f%>%
	anti_join(eggGroup.f,by=c("Dex"="ID_3", "Pokémon"="Pokémon_2"));

# None so Save to aggragate
agg=dex.f%>%
	inner_join(eggGroup.f,by=c("Dex"="ID_3", "Pokémon"="Pokémon_2"));

rm(dex, eggGroup, eggGroup.f);
######
# Exp
######

# Nothing to fix

agg%>%
	inner_join(exp, by=c(Dex="ID_4", Pokémon="Name_1"));
# See what diddent match
agg%>%
	anti_join(exp, by=c(Dex="ID_4", Pokémon="Name_1"));

# Nothing, so Save to agg
agg=agg%>%
	inner_join(exp, by=c(Dex="ID_4", Pokémon="Name_1"));

rm(exp);

#######
# Body
#######

# Fix Ndex to int
body%>%
	mutate(
		Ndex=as.integer(gsub("#", "", Ndex))
	);

# Save

body.f=body%>%
	mutate(
		Ndex=as.integer(gsub("#", "", Ndex))
	);

# Inner join with agg
agg%>%
	inner_join(body.f, by=c(Dex="Ndex", Pokémon="Pokémon_3"));
# See what diddent match
agg%>%
	anti_join(body.f, by=c(Dex="Ndex", Pokémon="Pokémon_3"));

# No missmatch so Save to agg
agg=agg%>%
	inner_join(body.f, by=c(Dex="Ndex", Pokémon="Pokémon_3"));

rm(body, body.f);
#########
# friend
#########
agg%>%
	inner_join(friend, by=c(Dex="ID_8", Pokémon="Pokémon_6"))%>%
	View();
# See what diddent match
agg%>%
	anti_join(friend, by=c(Dex="ID_8", Pokémon="Pokémon_6"))%>%
	View();

# Empty so save to agg

agg=agg%>%
	inner_join(friend, by=c(Dex="ID_8", Pokémon="Pokémon_6"));

rm(friend);
#######
# Call
#######

# Fix Call_Rate_SM to int
call%>%
	mutate(Call_Rate_SM=as.integer(Call_Rate_SM),Call_Rate_USUM=as.integer(Call_Rate_USUM));

# Save

call.f=call%>%
	mutate(Call_Rate_SM=as.integer(Call_Rate_SM),Call_Rate_USUM=as.integer(Call_Rate_USUM));

# Join with agg

agg%>%
	left_join(call.f, by=c(Dex="ID_9", Pokémon="Name_3"))%>%
	View();

# See what was missed from call.f
call.f%>%
	anti_join(agg, by=c("ID_9"="Dex", "Name_3"="Pokémon"))%>%
	filter(!is.na(ID_9));

# Empty so save to agg

agg=agg%>%
	left_join(call.f, by=c(Dex="ID_9", Pokémon="Name_3"));

rm(call, call.f);
##########
# habatat
##########

# Fix values
habatat%>%
	mutate(
		Habitat=gsub("\\s*Pokémon\\s*", "", Habitat),
		Page=as.integer(gsub("\\s*Page\\s*","", Page)),
		Ndex_1=as.integer(gsub("#","",Ndex_1))
	)%>%
	select(-c(Type2_1,Type_1)); # Deselect duplicate types

# Save
habatat.f=habatat%>%
	mutate(
		Habitat=gsub("\\s*Pokémon\\s*", "", Habitat),
		Page=as.integer(gsub("\\s*Page\\s*","", Page)),
		Ndex_1=as.integer(gsub("#","",Ndex_1))
	)%>%
	select(-c(Type2_1,Type_1));

agg%>%
	left_join(habatat.f, by=c(Dex="Ndex_1", Pokémon="Pokémon_7"))%>%
	View();
# See what was missed from habatat.f
habatat.f%>%
	anti_join(agg, by=c("Ndex_1"="Dex", Pokémon_7="Pokémon"))%>%
	filter(!is.na(Ndex_1));

# Empty so save

agg=agg%>%
	left_join(habatat.f, by=c(Dex="Ndex_1", Pokémon="Pokémon_7"));

rm("habatat", "habatat.f")
#####
# iq
#####

# Remove NA IDs then mutate to remove group and #
iq%>%
	filter(!is.na(ID_10))%>%
	mutate(
		Group=gsub("\\s*Group\\s*","", Group),
		ID_10=as.integer(gsub("#","",ID_10))
	)%>%
	select(-c(Type_2,Type2_2))%>% # Remove duplicate types
	rename("IQGroup"=Group); # Rename group

# Save
iq.f=iq%>%
	filter(!is.na(ID_10))%>%
	mutate(
		Group=gsub("\\s*Group\\s*","", Group),
		ID_10=as.integer(gsub("#","",ID_10))
	)%>%
	select(-c(Type_2,Type2_2))%>%
	rename("IQGroup"=Group);

# left join with agg
agg%>%
	left_join(iq.f, by=c(Dex="ID_10", Pokémon="Pokémon_8"))%>%
	View();
# See what is left in iq.f
iq.f%>%
	anti_join(agg, by=c("ID_10"="Dex", Pokémon_8="Pokémon"));

# Ok, that is odd, I found an error on their part.  The id is suposted to be 70
# Good thing I am checking both name and Dex
# Fix that error
iq.f%>%
	mutate(
		ID_10=if_else(Pokémon_8=="Weepinbell",70:70, ID_10) # Why can't it convert double into int?
	);
# save
iq.f=iq.f%>%
	mutate(
		ID_10=if_else(Pokémon_8=="Weepinbell",70:70, ID_10)
	);

# Try it again

# left join with agg
agg%>%
	left_join(iq.f, by=c(Dex="ID_10", Pokémon="Pokémon_8"))%>%
	View();
# See what is left in iq.f
iq.f%>%
	anti_join(agg, by=c("ID_10"="Dex", Pokémon_8="Pokémon"));

# Save since nothing is missing save it

agg=agg%>%
	left_join(iq.f, by=c(Dex="ID_10", Pokémon="Pokémon_8"));

rm(iq,iq.f);