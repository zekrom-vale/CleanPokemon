###############################################################################
#															Import Items
###############################################################################
ItemRaw_Items=read_csv("items/ItemRaw - Items.csv");

# Split and join properly
items=ItemRaw_Items[1:3]%>%
	inner_join(
		ItemRaw_Items%>%
			select(-(1:3)),
			by=c("Name"="English")
	)%>%
	filter(
		!is.na(Name)
	);

items%>%
	distinct()%>%
	not_distinct(Name, Gen)%>%
	View();
# Duplicates introduced due to language
# Keep as a seprate table??

items=ItemRaw_Items%>%
	select(
		1:3
	);
itemsLang=ItemRaw_Items%>%
	select(-(1:3));


# Convert romans into numbers
items%<>%
	separate(
		Gen,
		into=c("Gen", "Gen2")
	)%>%
	mutate(
		Gen=as.integer(as.roman(Gen)),
		Gen2=as.integer(as.roman(Gen2))
	);

# See if I can extract note
items%<>%
	separate(
		Description,
		into=c("Description", "Note"),
		sep="\nNote:\\s*"
	);


###############################################################################
#															Import Item IDs
###############################################################################
ItemRaw_ItemIDs=read_csv("items/ItemRaw - ItemIDs.csv");

items_Gen1=ItemRaw_ItemIDs%>%
	select(
		1:6
	)%>%
	rename(
		ID=ID_1,
		Hex=HEX_1,
		Name=Name_1,
		Pokcet=Pokcet_1,
		Translation=Translation_1,
		Type=Type_1
	);

ItemRaw_ItemIDs%<>%
	select(
		-(1:6)
	);

items_Gen2=ItemRaw_ItemIDs%>%
	select(
		1:5
	)%>%
	rename(
		ID=ID_2,
		Hex=HEX_2,
		Name=Name_2,
		Pokcet=Pokcet_2,
		Color=Color_2
	);

ItemRaw_ItemIDs%<>%
	select(
		-(1:5)
	);

items_Gen3=ItemRaw_ItemIDs%>%
	select(
		1:5
	)%>%
	rename(
		ID=ID_3,
		Hex=HEX_3,
		Name=Name_3,
		Pokcet=Pokcet_3,
		Color=Color_3
	);

ItemRaw_ItemIDs%<>%
	select(
		-(1:5)
	);

items_Gen3Colo=ItemRaw_ItemIDs%>%
	select(
		1:5
	)%>%
	rename(
		ID=ID_3Colo,
		Hex=HEX_3Colo,
		Name=Name_3Colo,
		Pokcet=Pokcet_3Colo,
		Color=Color_3Colo
	);

ItemRaw_ItemIDs%<>%
	select(
		-(1:5)
	);

items_Gen3XD=ItemRaw_ItemIDs%>%
	select(
		1:5
	)%>%
	rename(
		ID=ID_3XD,
		Hex=HEX_3XD,
		Name=Name_3XD,
		Pokcet=Pokcet_3XD,
		Color=Color_3XD
	);

ItemRaw_ItemIDs%<>%
	select(
		-(1:5)
	);

items_Gen4=ItemRaw_ItemIDs%>%
	select(
		1:5
	)%>%
	rename(
		ID=ID_4,
		Hex=HEX_4,
		Name=Name_4,
		Pokcet=Pokcet_4,
		Color=Color_4
	);

ItemRaw_ItemIDs%<>%
	select(
		-(1:5)
	);

items_Gen5=ItemRaw_ItemIDs%>%
	select(
		1:5
	)%>%
	rename(
		ID=ID_5,
		Hex=HEX_5,
		Name=Name_5,
		Pokcet=Pokcet_5,
		Color=Color_5
	);

ItemRaw_ItemIDs%<>%
	select(
		-(1:5)
	);

items_Gen6=ItemRaw_ItemIDs%>%
	select(
		1:5
	)%>%
	rename(
		ID=ID_6,
		Hex=HEX_6,
		Name=Name_6,
		Pokcet=Pokcet_6,
		Color=Color_6
	);

ItemRaw_ItemIDs%<>%
	select(
		-(1:5)
	);

items_Gen7=ItemRaw_ItemIDs%>%
	select(
		1:5
	)%>%
	rename(
		ID=ID_7,
		Hex=HEX_7,
		Name=Name_7,
		Pokcet=Pokcet_7,
		Color=Color_7
	);

ItemRaw_ItemIDs%<>%
	select(
		-(1:5)
	);

items_Gen7LG=ItemRaw_ItemIDs%>%
	select(
		1:5
	)%>%
	rename(
		ID=ID_7LG,
		Hex=HEX_7LG,
		Name=Name_7LG,
		Pokcet=Pokcet_7LG,
		Color=Color_7LG
	);
rm(ItemRaw_ItemIDs, ItemRaw_Items);

###############################################################################
# Convert color to game
items_Gen2%<>%
	mutate(
		Sub_Game=case_when(
			Color=="rgb(140, 230, 255)"~"Crystal",
			Color=="rgb(255, 255, 255)"~NA_character_
		),
		Color=NULL
	);

items_Gen3%<>%
	mutate(
		Sub_Game=case_when(
			Color=="rgb(255, 164, 114)"~"FireRed, LeefGreen, Emerald",
			Color=="rgb(89, 193, 89)"~"Emerald",
			Color=="rgb(255, 255, 255)"~NA_character_
		),
		Color=NULL
	);

items_Gen3Colo%<>%
	mutate(
		Sub_Game=NA_character_,
		Color=NULL
	);

items_Gen3XD%<>%
	mutate(
		Sub_Game=NA_character_,
		Color=NULL
	);

items_Gen4%<>%
	mutate(
		Sub_Game=case_when(
			Color=="rgb(189, 189, 189)"~"Platinum, HeartGold, SoulSilver",
			Color=="rgb(231, 196, 110)"~"HeartGold, SoulSilver",
			Color=="rgb(255, 255, 255)"~NA_character_
		),
		Color=NULL
	);

items_Gen5%<>%
	mutate(
		Sub_Game=case_when(
			Color=="rgb(132, 138, 141)"~"Black 2, White 2",
			Color=="rgb(255, 255, 255)"~NA_character_
		),
		Color=NULL
	);

items_Gen6%<>%
	mutate(
		Sub_Game=case_when(
			Color=="rgb(90, 150, 197)"~"X, Y",
			Color=="rgb(200, 115, 101)"~"Omega Ruby, Alpha Sapphire",
			Color=="rgb(255, 255, 255)"~NA_character_
		),
		Color=NULL
	);

items_Gen7%<>%
	mutate(
		Sub_Game=case_when(
			Color=="rgb(246, 183, 117)"~"Sun, Moon",
			Color=="rgb(241, 148, 117)"~"Ultra Sun, Ultra Moon",
			Color=="rgb(255, 255, 255)"~NA_character_
		),
		Color=NULL
	);

items_Gen7LG%<>%
	mutate(
		Sub_Game=NA_character_,
		Color=NULL
	);

###############################################################################
# Convert to long table
# Skip gen 1 for now
items_Gen1%>%
	add_column(
		Gen="1"
	);

itemsIDs=items_Gen2%>%
	add_column(
		Gen=2L,
		Game=NA_character_
	)%>%
	union(
		items_Gen3%>%
			add_column(
				Gen=3L,
				Game=NA_character_
			)
	)%>%
	union(
		items_Gen3Colo%>%
			add_column(
				Gen=3L,
				Game="Colo"
			)
	)%>%
	union(
		items_Gen3XD%>%
			add_column(
				Gen=3L,
				Game="XD"
			)
	)%>%
	union(
		items_Gen4%>%
			add_column(
				Gen=4L,
				Game=NA_character_
			)
	)%>%
	union(
		items_Gen5%>%
			add_column(
				Gen=5L,
				Game=NA_character_
			)
	)%>%
	union(
		items_Gen6%>%
			add_column(
				Gen=6L,
				Game=NA_character_
			)
	)%>%
	union(
		items_Gen7%>%
			add_column(
				Gen=7L,
				Game=NA_character_
			)
	)%>%
	union(
		items_Gen7LG%>%
			add_column(
				Gen=7L,
				Game="LG"
			)
	);

# Remove *'s and mutate id to int
itemsIDs%<>%
	mutate(
		ID=as.integer(ID),
		Name=gsub("\\*\\s*$","",Name)
	);

# See if game and sub game can be mergeed
itemsIDs%>%
	filter(
		!is.na(Sub_Game)&!is.na(Game)
	);

# No overlap so can merge

itemsIDs%<>%
	mutate(
		Game=if_else(
			is.na(Game),
			"",
			Game
		),
		Sub_Game=if_else(
			is.na(Sub_Game),
			"",
			Sub_Game
		)
	)%>%
	unite(
		Game,
		Sub_Game, Game,
		sep=""
	)%>%
	mutate(
		Game=if_else(Game=="",NA_character_,Game)
	);

###############################################################################
# Try joining them

itemsIDs%>%
	left_join(
		itemsLang,
		by=c("Name"="English")
	);

itemsLang%>%
	not_distinct(
		English
	)%>%
	arrange(
		English
	);

# Melt
itemsLang.melt=itemsLang%>%
	melt(
		"English",
		variable.name="Language",
		value.name="Name"
	)%>%
	as_tibble();

# Remove dups
itemsLang.melt%<>%
	distinct();

# Cast
itemsLang.melt.f=itemsLang.melt%>%
	dcast(
		formula=English~Language,
		fun.aggregate=function(x)paste(x, sep="\n", collapse="\n"),
		value.var="Name"
	)%>%
	as_tibble();

# Nothing miss maptched
itemsLang.melt.f%>%
	not_distinct(English)

itemsLang.melt.f%>%
	filter(
		str_detect(French,"\n")
	);

# Save to itemsLang
itemsLang=itemsLang.melt.f;
rm(itemsLang.melt,itemsLang.melt.f);

###############################################################################
# Finaly join them
# Ensure no duplicates
itemsLang%>%
	not_distinct(English);

# Remove stars
items%<>%
	mutate(
		NameStar=str_detect("\\*\\s*$", Name),
		Name=gsub("\\*\\s*$","",Name)
	);

reg=regex("\\*\\s*$");
itemsLang.f=itemsLang%>%
	rename(
		`Japanese Romaji`=`Japanese Rōmaji`
	)%>%
	mutate(
		EnglishStar=str_detect(English, reg),
		English=sub(reg,"",English),
		`Japanese Kana Star`=str_detect(`Japanese Kana`, reg),
		`Japanese Kana`=sub(reg,"",`Japanese Kana`),
		`Japanese Romaji Star`=str_detect(`Japanese Romaji`,reg),
		`Japanese Romaji`=sub(reg,"",`Japanese Romaji`),
		FrenchStar=str_detect(French, reg),
		French=sub(reg,"",French),
		GermanStar=str_detect(German, reg),
		German=sub(reg,"",German),
		ItalianStar=str_detect(Italian,reg),
		Italian=sub(reg,"",Italian),
		SpanishStar=str_detect(Spanish, reg),
		Spanish=sub(reg,"",Spanish),
		`Korean Hangul Star`=str_detect(`Korean Hangul`,reg),
		`Korean Hangul`=sub(reg,"",`Korean Hangul`),
		`Korean Romanized Star`=str_detect(`Korean Romanized`,reg),
		`Korean Romanized`=sub(reg,"",`Korean Romanized`),
		`Chinese Hànzì Star`=str_detect(`Chinese Hànzì`, reg),
		`Chinese Hànzì`=sub(reg,"",`Chinese Hànzì`),
		`Chinese Romanized Star`=str_detect(`Chinese Romanized`, reg),
		`Chinese Romanized`=sub(reg,"",`Chinese Romanized`)
	);

# Create the mask
itemsLang.f%<>%
	mutate(
		Star=(
			EnglishStar*2^10+
				`Japanese Kana Star`*2^9+
				`Japanese Romaji Star`*2^8+
				FrenchStar*2^7+
				GermanStar*2^6+
				ItalianStar*2^5+
				SpanishStar*2^4+
				`Korean Hangul Star`*2^3+
				`Korean Romanized Star`*2^2+
				`Chinese Hànzì Star`*2^1+
				`Chinese Romanized Star`*2^0
		),
		EnglishStar=NULL,
		`Japanese Kana Star`=NULL,
		`Japanese Romaji Star`=NULL,
		FrenchStar=NULL,
		GermanStar=NULL,
		ItalianStar=NULL,
		SpanishStar=NULL,
		`Korean Hangul Star`=NULL,
		`Korean Romanized Star`=NULL,
		`Chinese Hànzì Star`=NULL,
		`Chinese Romanized Star`=NULL
	);

itemsLang.f%<>%
	mutate(
		Star=as.integer(Star)
	);

itemsLang=itemsLang.f;
rm(itemsLang.f);

# Join with items
items%>%
	left_join(
		itemsLang,
		by=c("Name"="English")
	);

itemsLang%>%
	anti_join(
		items,
		by=c("English"="Name")
	);

items%>%
	anti_join(
		itemsLang,
		by=c("Name"="English")
	);

# Since there are missmatched items, I will be right AND left joining

items.j=items%>%
	left_join(
		itemsLang,
		by=c("Name"="English")
	)%>%
	union(
		items%>%
			right_join(
				itemsLang,
				by=c("Name"="English")
			)
	)%>%
	distinct();

# Worked
items.j%>%
	filter(
		is.na(Description)|is.na(French)
	);

# Save
items=items.j;
rm(items.j);

# Export list of items
write_csv(items,"items/items.csv",na="");
###############################################################################