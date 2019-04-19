family=read_csv("evolution/EvolutionRaw - Family.csv");

##################################################################################
#																	Extract
##################################################################################

# Extract Dex into Dex and Dex_Suffix
reg="\\s*#?(\\d+)?([[:alpha:]]+)?\\s*";
into=c("Dex","Dex_Suffix");

family%<>%
	extract(
		Dex,
		into=into,
		regex=reg,
		convert=TRUE
	)%>%
	extract(
		Dex_2,
		into=paste0(into,"_2"),
		regex=reg,
		convert=TRUE
	)%>%
	extract(
		Dex_3,
		into=paste0(into,"_3"),
		regex=reg,
		convert=TRUE
	);

# Drop junk from Region
family%<>%
	separate(
		Region,
		into="Region",
		sep="-based",
		extra="drop"
	);

# Remove Spaces
family%<>%
	mutate(
		`Condition or Class`=if_else(str_detect(`Condition or Class`,"^\\s*$"), NA_character_, `Condition or Class`),
		`Condition or Class_2`=if_else(str_detect(`Condition or Class_2`,"^\\s*$"), NA_character_, `Condition or Class_2`)
	);

# Seperate Condition or class
reg="^([^→]+)\\s*$|^(?:Level\\s*(?=\\d))?([^()]+?)\\s*(?:\\((.+)\\))?\\s*→\\s*$";
into=c("Class", "Condition", "Sub_Condition");
family%<>%
	extract(
		`Condition or Class`,
		into=into,
		regex=reg
	)%>%
	extract(
		`Condition or Class_2`,
		into=paste0(into, "_2"),
		regex=reg
	)%>%
	mutate(
		Level=as.integer(str_extract(Condition, "\\d+")),
		Condition=gsub("\\d", "", Condition),
		Condition=if_else(str_detect(Condition, "^\\s*$"), NA_character_, Condition),
		Level_2=as.integer(str_extract(Condition_2, "\\d+")),
		Condition_2=gsub("\\d", "", Condition_2),
		Condition_2=if_else(str_detect(Condition_2, "^\\s*$"), NA_character_, Condition_2)
	);

# Fix order
family%<>%
	select(
		Region, Family,
		Dex, Dex_Suffix, Name, Class, Condition, Sub_Condition, Level,
		Dex_2, Dex_Suffix_2, Name_2, Class_2, Condition_2, Sub_Condition_2, Level_2,
		everything()
);
# Fix Espeon and Umbreon
family%<>%
	mutate(
		Sub_Condition=case_when(
			Name_2=="Espeon"~"night",
			Name_2=="Umbreon"~"day",
			TRUE~Sub_Condition
		)
	);

##################################################################################
#																	Split
##################################################################################

# Split seperate evolutions and families
evolutions=family%>%
	filter(!is.na(Condition)|!is.na(Sub_Condition)|!is.na(Level));

family.o=family%>%
	filter_na(Condition, Sub_Condition, Level);


# Condence the Class and Dex suffix
evolutions%<>%
	mutate(
		Class=case_when(
			!is.na(Class)~Class,
			!is.na(Class_2)~Class_2,
			TRUE~NA_character_
		),
		Dex_Suffix=case_when(
			!is.na(Dex_Suffix)~Dex_Suffix,
			!is.na(Dex_Suffix_2)~Dex_Suffix_2,
			!is.na(Dex_Suffix_3)~Dex_Suffix_3,
			TRUE~NA_character_
		),
		Class_2=NULL,
		Dex_Suffix_2=NULL,
		Dex_Suffix_3=NULL
	);


# Split the table up
evolutions1=evolutions%>%
	select(1:11)%>%
	rename(
		Next_Dex=Dex_2,
		Next_Name=Name_2
	)%>%
	add_column(
		Previous_Dex=NA_integer_,
		Previous_Name=NA_character_,
		Stage=1L
	);

evolutions2=evolutions%>%
	select(
		-c(Condition, Sub_Condition, Level)
	)%>%
	rename(
		Previous_Dex=Dex,
		Previous_Name=Name,

		Dex=Dex_2,
		Name=Name_2,

		Next_Dex=Dex_3,
		Next_Name=Name_3,

		Condition=Condition_2,
		Sub_Condition=Sub_Condition_2,
		Level=Level_2
	)%>%
	add_column(
		Stage=2L
	);

evolutions3=evolutions%>%
	select(
		-c(Condition, Sub_Condition, Level, Level_2, Condition_2, Sub_Condition_2, Name, Dex)
	)%>%
	rename(
		Previous_Dex=Dex_2,
		Previous_Name=Name_2,

		Dex=Dex_3,
		Name=Name_3
	)%>%
	add_column(
		Next_Dex=NA_integer_,
		Next_Name=NA_character_,
		Condition=NA_character_,
		Sub_Condition=NA_character_,
		Level=NA_integer_,
		Stage=3L
	);

# Remove junk
family.o%<>%
	select(
		-c(Condition, Condition_2, Level, Level_2, Sub_Condition, Sub_Condition_2)
	);

# Fix Class
family.o%<>%
	mutate(
		Class=case_when(
			!is.na(Class)~Class,
			!is.na(Class_2)~Class_2,
			TRUE~NA_character_
		),
		Class_2=NULL
	);

# Split family
family=family.o%>%
	select(
		1:6
	)%>%
	union(
		family.o%>%
			select(
				1:2,
				Class,
				Dex_2, Dex_Suffix_2, Name_2
			)%>%
			rename(
				Dex=Dex_2,
				Dex_Suffix=Dex_Suffix_2,
				Name=Name_2
			)
	)%>%
	union(
		family.o%>%
			select(
				1:2,
				Class,
				Dex_3, Dex_Suffix_3, Name_3
			)%>%
			rename(
				Dex=Dex_3,
				Dex_Suffix=Dex_Suffix_3,
				Name=Name_3
			)
	);


##################################################################################
#																	Union
##################################################################################
# Union with evolutions
evolutions=evolutions1%>%
	union(
		evolutions2
	)%>%
	union(
		evolutions3
	);

##################################################################################
#																Remove Invalid
##################################################################################
evolutions%<>%
	filter_not_na(
		Dex, Name
	);

family%<>%
	filter_not_na(
		Dex, Name
	);	# Many invalid

##################################################################################
#																Add evolutions to family
##################################################################################
family%<>%
	union(
		evolutions%>%
			distinct(
				Region, Family, Dex, Dex_Suffix, Name, Class
			)
	);#%>%not_distinct(Dex, Dex_Suffix, Name);# Nothing not distinct

# Fix Unknown
family%<>%
	mutate(
		Class=if_else(str_detect(Name,"^Unown [A-Z!?]$"),str_extract(Name, "(?<= )[A-Z!?]"),Class),
		Name=if_else(str_detect(Name,"^Unown [A-Z!?]$"),"Unown",Name)
	);

rm(evolutions1, evolutions2, evolutions3, family.o);

write_csv(evolutions, "datasets/evolutions.csv",na="");
write_csv(family, "datasets/family.csv",na="");


##################################################################################
#																Join with species
##################################################################################

species.j=species%>%
	left_join(
		family%>%
			left_join(
				evolutions,
				by=c("Dex", "Dex_Suffix", "Name", "Class", "Region", "Family")
			),
		by=c("Dex", "Name"),
		suffix=c("", ".d")
	)%>%
	filter(
		Class==Class.d|
		Dex_Suffix==Dex_Suffix.d|
		is.na(Class)|
		is.na(Dex_Suffix)|
		is.na(Class.d)|
		is.na(Dex_Suffix.d)
	);

# See what did not match
species.j%>%
	filter(
		Class!=Class.d|
		Dex_Suffix!=Dex_Suffix.d
	)%>%View();
# Need to fix them


species.j.f=species.j%>%
	group_by(Name, Dex, Next_Dex, Next_Name)%>%
	filter(# Do Burmy manualy
		str_detect(Sub_Condition, Class)&Next_Name=="Wormadam"|
		Next_Name=="Mothim"|
		Name!="Burmy"&(
			all(is.na(Dex_Suffix.d))|
			all(is.na(Dex_Suffix))|
			(
				Dex_Suffix==Dex_Suffix.d|
				is.na(Dex_Suffix)&is.na(Dex_Suffix.d)
			)
		)&(
			all(is.na(Class.d))|
			all(is.na(Class))|
			(
				Class==Class.d|
				is.na(Class)&is.na(Class.d)
			)
		)
	);

species.j.f%>%
	filter(
	is.na(Class)&!is.na(Class.d)|
	is.na(Class)&!is.na(Class.d)
);
# Only Unknowns

species.j.f%>%
	filter(
		is.na(Dex_Suffix)&!is.na(Dex_Suffix.d)|
		is.na(Dex_Suffix.d)&!is.na(Dex_Suffix)
	)%>%View();
# Many things here
# Don't think it is an issue

# Unite class and account for compound classes
species.j.f%<>%
	mutate(
		Class=if_else(is.na(Class),"",Class),
		Class.d=if_else(is.na(Class.d),"",Class.d)
	)%>%
	unite(
		Class, Class, Class.d,
		sep=" "
	)%>%
	mutate(
		Class=trimws(Class),
		Class=if_else(Class=="", NA_character_, Class)
	);

# Unite Dex_Suffix
species.j.f%<>%
	mutate(
		Dex_Suffix=if_else(is.na(Dex_Suffix),Dex_Suffix.d, Dex_Suffix),
		Dex_Suffix.d=NULL
	);

species.j.f%>%
	not_distinct(Name, Dex, Dex_Suffix, Class, Next_Dex, Next_Name)%>%
	arrange(Name);
# Nothing now

# Save and Export
species=species.j.f;
rm(species.j, species.j.f);

write_csv(species, "datasets/species.csv",na="");
