#source("import.R");

# Clean alts
alts%>%
	mutate(
		Item=gsub("^\n","", Item)
	)%>%
	extract(
		Type,
		into=c("Type1","Type2"),
		"\\s*(\\w+)\\s*(\\w+)?\\s*"
	)%>%
	extract(
		Form_Type,
		into=c("Form_Type1","Form_Type2"),
		"\\s*(\\w+)\\s*(\\w+)?\\s*"
	)%>%
	View();

# Save
alts.f=alts%>%
	mutate(
		Item=gsub("^\n","", Item)
	)%>%
	extract(
		Type,
		into=c("Type1","Type2"),
		"\\s*(\\w+)\\s*(\\w+)?\\s*"
	)%>%
	extract(
		Form_Type,
		into=c("Form_Type1","Form_Type2"),
		"\\s*(\\w+)\\s*(\\w+)?\\s*"
	);

# ability has the types so discard them

alts.f=alts.f%>%
	select(-c(Ability,Form_Ability, Type1, Type2));

# Since the Dex_Suffix is too complicated, I will be ripping it off of Base/IV

# Clean up types
types%>%
	extract(
		NAME,
		into=c("Name","Class"),
		regex="^\\s*([^()]+?)\\s*(?:\\((.+)\\)\\s*)?$"
	)%>%
	filter(!is.na(Name));

# Save
types.f=types%>%
	extract(
		NAME,
		into=c("Name","Class"),
		regex="^\\s*([^()]+?)\\s*(?:\\((.+)\\)\\s*)?$"
	)%>%
	filter(!is.na(Name));

# Extract Dex_Suffix
types.f%>%
	mutate(
		Dex=gsub("\\D","", ID_EXT),
		Dex_Suffix=gsub("[^A-Za-z]","",ID_EXT),
		ID_EXT=NULL
	);
# Save

types.f=types.f%>%
	mutate(
		Dex=gsub("\\D","", ID_EXT),
		Dex_Suffix=gsub("[^A-Za-z]","",ID_EXT),
		ID_EXT=NULL
	);

# Try to separate on a varable
#types.f%>%
#	separate(
#		Class,
#  	into=c("Class", "Sub"),
#		sep=paste("\\s*",Name,"\\s*")
#	)
#
# Does not work


#types.f%>%
#	mutate(
#		Class=gsub(paste(Name,".+"), "", Class)
#	)

# Extract the Alts

types.f%>%
	mutate(
		temp=Dex_Suffix
	)%>%
	extract(
		temp,
		into="Alt",
		"[A-Z]([A-Z])\\s*$"
	)%>%
	View();
# Save
types.f=types.f%>%
	mutate(
		temp=Dex_Suffix
	)%>%
	extract(
		temp,
		into="Alt",
		"[A-Z]([A-Z])\\s*$"
	);

alts.f%>%
	mutate(
		temp=Item
	)%>%
	extract(
		temp,
		into="Alt",
		regex="\\s(X|Y)\\s*$"
	);
# Save
alts.f=alts.f%>%
	mutate(
		temp=Item
	)%>%
	extract(
		temp,
		into="Alt",
		regex="\\s(X|Y)\\s*$"
	);

# Merge by Name then Alt if it exists (As NAs will match NAs)
types.f%>%
	left_join(
		alts.f,
		by=c(Name="Name", Alt="Alt")
	)%>%
	View();

# Merge by Name, Class, ID
types.f%>%
	inner_join(
		varations,
		by=c(Name="Pokémon", Class="English", ID="ID")
	);

# See what did not match up from types.f
types.f%>%
	anti_join(
		alts.f,
		by=c(Name="Name", Alt="Alt")
	)%>%
	anti_join(
		varations,
		by=c(Name="Pokémon", Class="English", ID="ID")
	);

# See what did not match from varations
varations%>%
	anti_join(
		types.f,
		by=c("Pokémon"="Name", "English"="Class", ID="ID")
	)%>%
	View();
# Mostly visual only
# Some don't include there normal forms
# Some not matching due to names in the Class


# One way to separate
varations%>%
	separate(
		English,
		into=paste0("Class",1:3),
		fill="right",
		sep=" "
	)%>%
	mutate(
		Class=trimws(
			paste(if_else(Class1==Pokémon,"",Class1,""),if_else(Class2==Pokémon,"",Class2,""),if_else(Class3==Pokémon,"",Class3,""))
		)
	)%>%
	select(-c(Class1,Class2,Class3));
# Save
varations.f=varations%>%
	separate(
		English,
		into=paste0("Class",1:3),
		fill="right",
		sep=" "
	)%>%
	mutate(
		Class=trimws(
			paste(if_else(Class1==Pokémon,"",Class1,""),if_else(Class2==Pokémon,"",Class2,""),if_else(Class3==Pokémon,"",Class3,""))
		)
	)%>%
	select(-c(Class1,Class2,Class3));

types.f%>%
	separate(
		Class,
		into=paste0("Class",1:3),
		fill="right",
		sep=" "
	)%>%
	mutate(
		Class=trimws(
			paste(if_else(Class1==Name,"",Class1,""),if_else(Class2==Name,"",Class2,""),if_else(Class3==Name,"",Class3,""))
		)
	)%>%
	select(-c(Class1,Class2,Class3));
# Save
types.f.f=types.f%>%
	separate(
		Class,
		into=paste0("Class",1:3),
		fill="right",
		sep=" "
	)%>%
	mutate(
		Class=trimws(
			paste(if_else(Class1==Name,"",Class1,""),if_else(Class2==Name,"",Class2,""),if_else(Class3==Name,"",Class3,""))
		)
	)%>%
	select(-c(Class1,Class2,Class3));

varations.f%>%
	anti_join(
		types.f.f,
		by=c("Pokémon"="Name", "Class"="Class", ID="ID")
	)%>%
	View();
  # All astetic
  # Most require normal forms

types.f.f%>%
	anti_join(
		alts.f,
		by=c(Name="Name", Alt="Alt")
	)%>%
	anti_join(
		varations.f,
		by=c("Name"="Pokémon", "Class"="Class", ID="ID")
	);
	# Astetic or defult

types.f.f%>%
	inner_join(
		alts.f,
		by=c(Name="Name", Alt="Alt")
	)%>%View();
	# Does not match Ultra Burst,Dusk Mane Necrozma, Ultra Burst,Dawn Wings Necrozma

# Need to create normals for alts.f

alts.f%>%
	mutate(
		Classification="Normal",
		Item=NA_character_,
		Alt=NA_character_,
		Form_Type1=NA_character_,
		Form_Type2=NA_character_
	)%>%
	distinct();

# Merge with normal alts.f
alts.f%>%
	union(
		alts.f%>%
			mutate(
				Classification="Normal",
				Item=NA_character_,
				Alt=NA_character_,
				Form_Type1=NA_character_,
				Form_Type2=NA_character_
			)%>%
			distinct()
	)%>%
	View();
# Save

alts.m=alts.f%>%
	union(
		alts.f%>%
			mutate(
				Classification="Normal",
				Item=NA_character_,
				Alt=NA_character_,
				Form_Type1=NA_character_,
				Form_Type2=NA_character_
			)%>%
			distinct()
	);

# Need to do it differently for varations.f as some should not have normals

varations.f%>%
	mutate(
		Class=NA_character_
	)%>%
	distinct();
	# Only keep Pikachu, Pichu, Unown, Greninja, Magearna, Reshiram, Zekrom, Solgaleo, Lunala, Marshadow

varations.f%>%
	mutate(
		Class=NA_character_
	)%>%
	distinct()%>%
	filter(Pokémon%in%c("Pikachu", "Pichu", "Unown", "Greninja", "Magearna", "Reshiram", "Zekrom", "Solgaleo", "Lunala", "Marshadow"));

# Union them

varations.f%>%
	union(
		varations.f%>%
			mutate(
				Class=NA_character_
			)%>%
			distinct()%>%
			filter(Pokémon%in%c("Pikachu", "Pichu", "Unown", "Greninja", "Magearna", "Reshiram", "Zekrom", "Solgaleo", "Lunala", "Marshadow"))
	);

# Save
varations.m=varations.f%>%
	union(
		varations.f%>%
			mutate(
				Class=NA_character_
			)%>%
			distinct()%>%
			filter(Pokémon%in%c("Pikachu", "Pichu", "Unown", "Greninja", "Magearna", "Reshiram", "Zekrom", "Solgaleo", "Lunala", "Marshadow"))
	);

# Arceus is missing types
# Scrape off of Silvally
varations.m%>%
	filter(Pokémon=="Silvally")%>%
	mutate(
		Pokémon="Arceus",
		ID=493
	);

varations.m%>%
	union(
		varations.m%>%
			filter(Pokémon=="Silvally")%>%
			mutate(
				Pokémon="Arceus",
				ID=493
			)
	)%>%
	filter(
		Pokémon!="Arceus"|Class!=""
	)%>%
	filter(Pokémon=="Arceus");

varations.m%>%
	filter(Pokémon=="Silvally")%>%
	mutate(
		Pokémon="Arceus",
		ID=493
	);

varations.m=varations.m%>%
	union(
		varations.m%>%
			filter(Pokémon=="Silvally")%>%
			mutate(
				Pokémon="Arceus",
				ID=493
			)
	)%>%
	filter(
		Pokémon!="Arceus"|Class!=""# Filter out Arceus where it has no type
	);

# Join into types.f.f
types.f.f%>%
	left_join(
		alts.m,
		by=c(Name="Name", Alt="Alt")
	)%>%
	left_join(
		varations.m,
		by=c(Name="Pokémon", Class="Class", ID="ID")
	)%>%
	View();

# What did not match from types.f.f
types.f.f%>%
	anti_join(
		alts.m,
		by=c(Name="Name", Alt="Alt")
	)%>%
	anti_join(
		varations.m,
		by=c(Name="Pokémon", Class="Class", ID="ID")
	); # Those are not relevent

# What got lost from alts.m
alts.m%>%
	anti_join(
		types.f.f,
		by=c(Name="Name", Alt="Alt")
	);
# Need force add Normals
# Need to manualy add Ultra Bursts

alts.miss=alts.m%>%
	filter(str_detect(Name,"Necrozma"))%>%
	mutate(
		ID=800,
		Dex="800",
		temp=Name,
		Alt=NA_character_,
		Class=  NA_character_
	)%>%
	extract(
		temp,
		into=c("Dex_Suffix","Dex_Suffix2"),
		regex="^([A-Z])\\w*\\s+([A-Z]).+"
	)%>%
	unite(
		"Dex_Suffix",
		Dex_Suffix,
		Dex_Suffix2,
		sep=""
	)%>%
	mutate(
		Dex_Suffix=if_else(Classification=="Ultra Burst", "U", Dex_Suffix)
	);


# Fix types to include normals
types.f.f%>%
	filter(
		Name%in%c("Mewtwo","Charizard")
	)%>%
	mutate(
		Dex_Suffix=NA_character_,
		Alt=NA_character_,
		Class=NA_character_
	)%>%
	distinct()%>%
	union(
		types.f.f
	);
# Save
types.f.f=types.f.f%>%
	filter(
		Name%in%c("Mewtwo","Charizard")
	)%>%
	mutate(
		Dex_Suffix=NA_character_,
		Alt=NA_character_,
		Class=NA_character_
	)%>%
	distinct()%>%
	union(
		types.f.f
	);

# Now join them
types.f.f%>%
	left_join(
		alts.m,
		by=c(Name="Name", Alt="Alt")
	)%>%
	left_join(
		varations.m,
		by=c(Name="Pokémon", Class="Class", ID="ID")
	)%>%
	union(
		alts.miss
	)%>%
	View();

# See what did not match
types.f.f%>%
	anti_join(
		alts.m,
		by=c(Name="Name", Alt="Alt")
	)%>%
	anti_join(
		varations.m,
		by=c(Name="Pokémon", Class="Class", ID="ID")
	);
# Still aestetic

alts.m%>%
	anti_join(
		types.f.f,
		by=c(Name="Name", Alt="Alt")
	);
# All left are manual

varations.m%>%
	anti_join(
		types.f.f,
	  by=c("Pokémon"="Name", ID="ID")
  );
# Now nothing miss matches!
# Can finaly join!

types.f.f%>%
	left_join(
		alts.m,
		by=c(Name="Name", Alt="Alt", Class="Classification")
	)%>%
	left_join(
		varations.m,
		by=c(Name="Pokémon", Class="Class", ID="ID")
	)%>%
	union(
		alts.miss%>%select(-c(Classification))
	);

# Misses Where values are NA

types.agg=types.f.f%>%
	left_join(
		alts.m,
		by=c(Name="Name", Alt="Alt", Class="Classification")
	)%>%
	left_join(
		varations.m,
		by=c(Name="Pokémon", ID="ID")
	)%>%
	filter(
		is.na(Class.x)|Class.x==""|is.na(Class.y)|Class.y==""|Class.x==Class.y # I should have cleened the data prior to doing this
	)%>%
	mutate(
		Class=if_else(is.na(Class.x)|Class.x=="",Class.y,Class.x),
		Class.x=NULL,
		Class.y=NULL
	)%>%
	union(
		alts.miss%>%select(-c(Classification))
	);





# Clean up the data
types.agg%>%
	mutate(
		Dex=ID,
		ID=NULL,
		Dex_Suffix=if_else(str_detect(Dex_Suffix,"^\\s*$"),NA_character_,Dex_Suffix),
		Class=if_else(str_detect(Class,"^\\s*$"),NA_character_,Class)
	)%>%View();

# Save
types.agg=types.agg%>%
	mutate(
		Dex=ID,
		ID=NULL,
		Dex_Suffix=if_else(str_detect(Dex_Suffix,"^\\s*$"),NA_character_,Dex_Suffix),
		Class=if_else(str_detect(Class,"^\\s*$"),NA_character_,Class)
	);
