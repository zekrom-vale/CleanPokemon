library(tidyverse);
AbilityRaw_Ability_Data=read_csv("AbilityRaw - Ability Data.csv");
# Fix ID and Index to int
AbilityRaw_Ability_Data=AbilityRaw_Ability_Data%>%
	mutate(
		ID=as.integer(ID),
		Index=as.integer(Index)
	);

# Join be index and id
abilityKey=AbilityRaw_Ability_Data[1:7]%>%
	inner_join(
		AbilityRaw_Ability_Data%>%
			select(-(1:7)),
		by=c(ID="Index")
	);

# Change Generation to int
abilityKey%>%
	mutate(
		Generation=as.integer(c(I=1,II=2,III=3,IV=4,V=5,VI=6,VII=7)[Generation]),
		`Korean Hangul`=if_else(`Korean Hangul`=="--",NA_character_,`Korean Hangul`),
		`Korean Romanized`=if_else(`Korean Romanized`=="--",NA_character_,`Korean Romanized`),
		`Chinese Hànzì`=if_else(`Chinese Hànzì`=="--",NA_character_,`Chinese Hànzì`),
		`Chinese Romanized`=if_else(`Chinese Romanized`=="--",NA_character_,`Chinese Romanized`)
	)%>%
	select(-English)%>%
	View();

abilityKey=abilityKey%>%
	mutate(
		Generation=as.integer(c(I=1,II=2,III=3,IV=4,V=5,VI=6,VII=7)[Generation]),
		`Korean Hangul`=if_else(`Korean Hangul`=="--",NA_character_,`Korean Hangul`),
		`Korean Romanized`=if_else(`Korean Romanized`=="--",NA_character_,`Korean Romanized`),
		`Chinese Hànzì`=if_else(`Chinese Hànzì`=="--",NA_character_,`Chinese Hànzì`),
		`Chinese Romanized`=if_else(`Chinese Romanized`=="--",NA_character_,`Chinese Romanized`)
	)%>%
	select(-English);

write_csv(abilityKey, path="ability.csv", na="");
