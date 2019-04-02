family=read_csv("evolution/EvolutionRaw - Family.csv");

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

