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
write_csv(SE, "type/SE.csv");
write_csv(NVE, "type/NVE.csv");
write_csv(NE, "type/NE.csv");
write_csv(typeDes, "type/type.csv");