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
		1:4
	)%>%
	rename(
		ID=ID_2,
		Hex=HEX_2,
		Name=Name_2,
		Pokcet=Pokcet_2
	);

ItemRaw_ItemIDs%<>%
	select(
		-(1:4)
	);

items_Gen3=ItemRaw_ItemIDs%>%
	select(
		1:4
	)%>%
	rename(
		ID=ID_3,
		Hex=HEX_3,
		Name=Name_3,
		Pokcet=Pokcet_3
	);

ItemRaw_ItemIDs%<>%
	select(
		-(1:4)
	);

items_Gen3Colo=ItemRaw_ItemIDs%>%
	select(
		1:4
	)%>%
	rename(
		ID=ID_3Colo,
		Hex=HEX_3Colo,
		Name=Name_3Colo,
		Pokcet=Pokcet_3Colo
	);

ItemRaw_ItemIDs%<>%
	select(
		-(1:4)
	);

items_Gen3XD=ItemRaw_ItemIDs%>%
	select(
		1:4
	)%>%
	rename(
		ID=ID_3XD,
		Hex=HEX_3XD,
		Name=Name_3XD,
		Pokcet=Pokcet_3XD
	);

ItemRaw_ItemIDs%<>%
	select(
		-(1:4)
	);

items_Gen4=ItemRaw_ItemIDs%>%
	select(
		1:4
	)%>%
	rename(
		ID=ID_4,
		Hex=HEX_4,
		Name=Name_4,
		Pokcet=Pokcet_4
	);

ItemRaw_ItemIDs%<>%
	select(
		-(1:4)
	);

items_Gen5=ItemRaw_ItemIDs%>%
	select(
		1:4
	)%>%
	rename(
		ID=ID_5,
		Hex=HEX_5,
		Name=Name_5,
		Pokcet=Pokcet_5
	);

ItemRaw_ItemIDs%<>%
	select(
		-(1:4)
	);

items_Gen6=ItemRaw_ItemIDs%>%
	select(
		1:4
	)%>%
	rename(
		ID=ID_6,
		Hex=HEX_6,
		Name=Name_6,
		Pokcet=Pokcet_6
	);

ItemRaw_ItemIDs%<>%
	select(
		-(1:4)
	);

items_Gen7=ItemRaw_ItemIDs%>%
	select(
		1:4
	)%>%
	rename(
		ID=ID_7,
		Hex=HEX_7,
		Name=Name_7,
		Pokcet=Pokcet_7
	);

ItemRaw_ItemIDs%<>%
	select(
		-(1:4)
	);

items_Gen7LG=ItemRaw_ItemIDs%>%
	select(
		1:4
	)%>%
	rename(
		ID=ID_7LG,
		Hex=HEX_7LG,
		Name=Name_7LG,
		Pokcet=Pokcet_7LG
	);
rm(ItemRaw_ItemIDs, ItemRaw_Items);

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

itemsIDs%>%
	not_distinct(ID, Gen, Game);
