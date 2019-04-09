PokemonRaw_Base_IV=read_csv("IV/PokemonRaw - Base_IV.csv");

# Extract
base_7=PokemonRaw_Base_IV[1:11]%>%
	rename(
		ID=ID,
		ID_EXT=ID_EXT,
		NAME=NAME,
		Base_HP=Base_HP_7,
		Base_Attack=Base_Attack_7,
		Base_Defense=Base_Defense_7,
		Base_Sp_Attack=Base_Sp_Attack_7,
		Base_Sp_Defense=Base_Sp_Defense_7,
		Base_Speed=Base_Speed_7,
		Base_Total=Base_Total_7,
		Base_Average=Base_Average_7
	);
PokemonRaw_Base_IV%<>%select(-(1:11));

base_1=PokemonRaw_Base_IV[1:9]%>%
	rename(
		ID=ID_1,
		NAME=Pokémon,
		Base_HP=Base_HP_1,
		Base_Attack=Base_Attack_1,
		Base_Defense=Base_Defense_1,
		Base_Speed=Base_Speed_1,
		Base_Total=Base_Total_1,
		Base_Average=Base_Average_1
	)%>%mutate(
		Base_Sp_Attack=Base_Special_1,
		Base_Sp_Defense=Base_Special_1,
		Base_Special_1=NULL
	);
PokemonRaw_Base_IV%<>%select(-(1:9));

base_2_5=PokemonRaw_Base_IV[1:10]%>%
	rename(
		ID=ID_2,
		NAME=Pokémon_1,
		Base_HP=Base_HP_2_5,
		Base_Attack=Base_Attack_2_5,
		Base_Defense=Base_Defense_2_5,
		Base_Sp_Attack=Base_Sp_Attack_2_5,
		Base_Sp_Defense=Base_Sp_Defense_2_5,
		Base_Speed=Base_Speed_2_5,
		Base_Total=Base_Total_2_5,
		Base_Average=Base_Average_2_5
	);


PokemonRaw_Base_IV%<>%select(-(1:10));

base_6=PokemonRaw_Base_IV%>%
	rename(
		ID=ID_3,
		ID_EXT=ID_EX,
		NAME=Name,
		Base_HP=Base_HP_6,
		Base_Attack=Base_Attack_6,
		Base_Defense=Base_Defense_6,
		Base_Sp_Attack=Base_Sp_Attack_6,
		Base_Sp_Defense=Base_Sp_Defense_6,
		Base_Speed=Base_Speed_6,
		Base_Total=Base_Total_6,
		Base_Average=Base_Average_6
	);

# Add ID_EXT to one that don't have it
base_1%<>%
	mutate(
		ID_EXT=as.character(ID)
	);

base_2_5%<>%
	mutate(
		ID_EXT=as.character(ID)
	);

#################################################################
#												Union
#################################################################
base=base_7%>%
	add_column(
		GEN=7L,
		GEN2=NA_integer_
	)%>%
	union(
		base_6%>%
			add_column(
				GEN=6L,
				GEN2=NA_integer_
			)
	)%>%
	union(
		base_2_5%>%
			add_column(
				GEN=2L,
				GEN2=5L
			)
	)%>%
	union(
		base_1%>%
			add_column(
				GEN=1L,
				GEN2=NA_integer_
			)
	);

rm(base_1, base_2_5, base_6, base_7, PokemonRaw_Base_IV);

#################################################################
#												Fix Data
#################################################################

# Remove NAs
base%<>%filter_not_na(NAME);

# Extract Letters from ID_EXT
base%<>%extract(
	ID_EXT,
	into="ID_EXT",
	regex="([[:alpha:]]+)"
);

# Split NAME into name and class
base%<>%
	extract(
		NAME,
		into=c("Name","Class"),
		regex="([^()]+)\\s*(?:\\((.+)\\))?\\s*"
	);

pokemon%>%
	select(Name, Dex, Dex_Suffix, Class)%>%
	right_join(
		base,
		by=c("Name", "Dex"="ID", "Dex_Suffix"="ID_EXT")
	);
# Does not work that well, will be complicated to join

write_csv(base, "datasets/base.csv", na="");
