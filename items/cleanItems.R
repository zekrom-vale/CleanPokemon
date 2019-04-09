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
# 										Convert color to game
###############################################################################
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
# 										Convert to long table
###############################################################################
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
				Game="Colosseum"
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
				Game="Let's Go"
			)
	);

# Union with itemsIDs
itemsIDs%<>%
	union(
		items_Gen1%>%
			add_column(
				Sub_Game=NA_character_,
				Gen=1L,
				Game=NA_character_
			)%>%
			add_column(
				d1=" (",
				d2=" - ",
				d3=")"
			)%>%
			unite(
				Name,
				Name, d1, Translation, d2, Type, d3,
				sep=""
			)%>%
			mutate(
				Name=gsub("\\s*(?:\\(NA - NA\\)| - NA|NA - )\\s*", "", Name),
				Pokcet=as.character(Pokcet)
			)%>%
			filter(
				Name!="NA"&!is.na(Name)
			)
	);

rm(items_Gen1, items_Gen2, items_Gen3, items_Gen3Colo, items_Gen3XD ,items_Gen4, items_Gen5, items_Gen6, items_Gen7, items_Gen7LG);

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
#													Remove pocket and unknown pocket
###############################################################################
itemsIDs%<>%
	mutate(
		Pokcet=if_else(
			Pokcet=="Unknown pocket",
			NA_character_,
			gsub(" pocket","",Pokcet)
		)
	);

###############################################################################
#															Remove NA items
###############################################################################

itemsIDs%<>%
	filter(
		!is.na(Name)
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
###############################################################################
#														Join items lang and items
###############################################################################
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

# Remove — and NA's
itemsLang.melt%<>%
	filter(
		Name!="—"&!is.na(Name)
	);

# Cast
itemsLang.melt.f=itemsLang.melt%>%
	dcast(
		formula=English~Language,
		fun.aggregate=function(x){
			ret=paste(x, sep="\n", collapse="\n");
			if(str_detect(ret,"^\\s*$"))return(NA_character_)
			else return(ret)
		},
		value.var="Name"
	)%>%
	as_tibble();

# See if it worked
itemsLang.melt.f%>%chunk(4)

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

reg=regex("\\*\\s*$",multiline=TRUE);
# Remove stars
items%<>%
	mutate(
		NameStar=str_detect(Name, reg),
		Name=gsub(reg,"",Name)
	);

itemsLang.f=itemsLang%>%
	rename(
		`Japanese Romaji`=`Japanese Rōmaji`
	)%>%
	mutate(
		EnglishStar=str_detect(English, reg),
		English=gsub(reg,"",English),
		`Japanese Kana Star`=str_detect(`Japanese Kana`, reg),
		`Japanese Kana`=gsub(reg,"",`Japanese Kana`),
		`Japanese Romaji Star`=str_detect(`Japanese Romaji`,reg),
		`Japanese Romaji`=gsub(reg,"",`Japanese Romaji`),
		FrenchStar=str_detect(French, reg),
		French=gsub(reg,"",French),
		GermanStar=str_detect(German, reg),
		German=gsub(reg,"",German),
		ItalianStar=str_detect(Italian,reg),
		Italian=gsub(reg,"",Italian),
		SpanishStar=str_detect(Spanish, reg),
		Spanish=gsub(reg,"",Spanish),
		`Korean Hangul Star`=str_detect(`Korean Hangul`,reg),
		`Korean Hangul`=gsub(reg,"",`Korean Hangul`),
		`Korean Romanized Star`=str_detect(`Korean Romanized`,reg),
		`Korean Romanized`=gsub(reg,"",`Korean Romanized`),
		`Chinese Hànzì Star`=str_detect(`Chinese Hànzì`, reg),
		`Chinese Hànzì`=gsub(reg,"",`Chinese Hànzì`),
		`Chinese Romanized Star`=str_detect(`Chinese Romanized`, reg),
		`Chinese Romanized`=gsub(reg,"",`Chinese Romanized`)
	);

# Create the mask
itemsLang.f%<>%
	mutate(
		Star=(
			if_else(!is.na(EnglishStar),EnglishStar*2^10, 0)+
			if_else(!is.na(`Japanese Kana Star`),`Japanese Kana Star`*2^9, 0)+
			if_else(!is.na(`Japanese Romaji Star`),`Japanese Romaji Star`*2^8, 0)+
			if_else(!is.na(FrenchStar),FrenchStar*2^7, 0)+
			if_else(!is.na(GermanStar),GermanStar*2^6, 0)+
			if_else(!is.na(ItalianStar),ItalianStar*2^5, 0)+
			if_else(!is.na(SpanishStar),SpanishStar*2^4, 0)+
			if_else(!is.na(`Korean Hangul Star`),`Korean Hangul Star`*2^3, 0)+
			if_else(!is.na(`Korean Romanized Star`),`Korean Romanized Star`*2^2, 0)+
			if_else(!is.na(`Chinese Hànzì Star`),`Chinese Hànzì Star`*2^1, 0)+
			if_else(!is.na(`Chinese Romanized Star`),`Chinese Romanized Star`*2^0, 0)
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
rm(itemsLang.f, reg);

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
rm(items.j, itemsLang);

# Add NameStar to Star
items%<>%
	mutate(
		Star=if_else(
			!is.na(NameStar),
			as.integer(NameStar*2^11)+
				if_else(
					!is.na(Star),
					as.integer(Star),
					0L
				),
			Star
		),
		NameStar=NULL
	);

###############################################################################
# See if all items are in items
itemsIDs%>%
	inner_join(
		items,
		by="Name"
	);

# No, many items are missed

# How many?
itemsIDs%>%
	anti_join(
		items,
		by="Name"
	)%>%
	distinct(Name)%>%
	`$`(Name);

# Too many and includes glitch items as well as TMs and dev items
# Items also have aleses


###############################################################################

# Export list of items
write_csv(items,"datasets/items.csv",na="");

# Export item ids
write_csv(itemsIDs,"datasets/itemIDs.csv",na="");