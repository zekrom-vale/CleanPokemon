typeDes=types%>%
	select(TYPE, DISCRIPTION, URL);

# Expand JSON into seperate rows via separate_rows
SE=types%>%
	rename("ATK"="TYPE", "DEF"="ATK_SE")%>%
	select(DEF, ATK)%>%
	separate_rows(DEF)%>%
	filter_all(all_vars(!is.na(.)&.!=""))%>%
	mutate(
		DEF=factor(DEF)
	);

NVE=types%>%
	rename("ATK"="TYPE", "DEF"="ATK_NVE")%>%
	select(DEF, ATK)%>%
	separate_rows(DEF)%>%
	filter_all(all_vars(!is.na(.)&.!=""))%>%
	mutate(
		DEF=factor(DEF)
	);

NE=types%>%
	rename("ATK"="TYPE", "DEF"="ATK_NE")%>%
	select(DEF, ATK)%>%
	separate_rows(DEF)%>%
	filter_all(all_vars(!is.na(.)&.!=""))%>%
	mutate(
		DEF=factor(DEF)
	);

# Write as CSV
write_csv(SE, "datasets/type/SE.csv", na="");
write_csv(NVE, "datasets/type/NVE.csv", na="");
write_csv(NE, "datasets/type/NE.csv", na="");
write_csv(typeDes, "datasets/type/type.csv", na="");