###############################################################################
# 																Join with color
###############################################################################
color%>%
	separate(
		Name,
		into=c("Name",paste0("Class",1:2)),
		sep="\n"
	)%>%
	filter(
		!is.na(Class1)
	);

# Save
color=color%>%
	separate(
		Name,
		into=c("Name",paste0("Class",1:2)),
		sep="\n"
	);


# Join where class1 is na or equal to "All forms"
color.all=agg%>%
	inner_join(
		color%>%
			filter(
				is.na(Class1)|Class1=="All forms"|
				Class1=="Normal"&is.na(Dex_Suffix)
			)%>%
			select(-c(Dex_Suffix, Class1, Class2))
		,
		by=dexes,
		suffix=c("", ".d")
	);

# Join when Dex_Suffix match
color.dex=agg%>%
	inner_join(
		color%>%
			select(-c(Class1, Class2)),
		by=dexsuff,
		suffix=c("", ".d")
	)%>%
	filter(
		!is.na(Dex_Suffix) # Have to match via Existing Dex_Suffixes
	);

# See what did not match
agg%>%
	anti_join(
		color%>%
			filter(
				is.na(Class1)|Class1=="All forms"
			)%>%
			select(-c(Dex_Suffix, Class1, Class2))
		,
		by=dexes
	);

# Join by Class1
color.class=agg%>%
	inner_join(
		color,
		by=c(dexes, Class="Class1"),
		suffix=c("", ".d")
	)%>%
	filter(
		!is.na(Class)
	);


# Union them
agg.j=color.all%>%
	union(
		color.class%>%
			select(-Class2, -Dex_Suffix.d)
	)%>%
	union(
		color.dex
	);



# What we missed
agg%>%
	setdiff(
		agg.j%>%
			select(
				-c(Color)
			)
	);

color.miss=color%>%
	select(Color, Name, Dex, Dex_Suffix)%>%
	setdiff(
		agg.j%>%select(Color, Name, Dex, Dex_Suffix)
	)%>%
	inner_join(
		color,
		by=c("Color", "Name", "Dex", "Dex_Suffix")
	)%>%filter(
		!is.na(Name)
	);

color.miss.fix=agg%>%
	inner_join(
		color.miss,
		by=c("Name","Dex"),
		suffix=c("", ".d")
	)%>%
	# filter(
	# 	Name!="Cherrim"&
	# 	Name!="Vivillon"&
	# 	Name!="Oricorio"&
	# 	Name!="Magearna"&
	# 	Name!="Frillish"&
	# 	Name!="Unfezant"&
	# 	Name!="Jellicent"
	# )%>%
	filter(
		Name=="Meowstic"| # ???

		Name=="Minior"| # Need to mutate

	  Name=="Charizard"&Class!="Mega X"
	)#%>%
	#select(Name, Dex, Dex_Suffix, Class, Color, Dex_Suffix.d, Class1, Class2);

agg.j=agg.j%>%
	union(
		color.miss.fix%>%
			select(-Class2, -Dex_Suffix.d, -Class1)
	);

# See what got duplicated
agg.d=agg.j%>%
	filter(
		Name%in%(agg.j%>%
						 	distinct(Name, Dex, Dex_Suffix, Class,.keep_all=T)%>%
						 	setdiff_r(agg.j))$Name
	);

# Remove duplicates
# agg.d%>%filter(Name=='Raichu')%>%select(Name, Dex, Dex_Suffix, Color)
agg.d.f=agg.d%>%
	filter(
      Name=='Vulpix'&(Dex_Suffix=='A'&Color!="Brown"|is.na(Dex_Suffix))|
      #Name=='Minior'|
      Name=='Raichu'&(Dex_Suffix=='A'&Color!="Yellow"|is.na(Dex_Suffix))|
      Name=='Sandshrew'&(Dex_Suffix=='A'&Color!="Yellow"|is.na(Dex_Suffix))|
      Name=='Sandslash'&(Dex_Suffix=='A'&Color!="Yellow"|is.na(Dex_Suffix))|
      Name=='Graveler'&(Dex_Suffix=='A'&Color!="Brown"|is.na(Dex_Suffix))|
      Name=='Castform'&(
      	Dex_Suffix=="S"&Color=="Red"|
      	Dex_Suffix=="R"&Color=="Blue"|
      	Dex_Suffix=="H"&Color=="Blue"|
      	is.na(Dex_Suffix)&Color=="Gray"
      )| # More complicated
      Name=='Audino'&(Dex_Suffix=="M"&Color!="Pink"|is.na(Dex_Suffix))|
      Name=='Necrozma'&(
      	Dex_Suffix=="DW"&Color=="Blue"|
      	Dex_Suffix=="DM"&Color=="Yellow"|
      	Dex_Suffix=="U"&Color=="Yellow"|
      	is.na(Dex_Suffix)&Color=="Black"
      )| # Quite complex
      Name=='Rattata'&(Dex_Suffix=='A'&Color!="Purple"|is.na(Dex_Suffix))|
      Name=='Muk'&(Dex_Suffix=='A'&Color!="Purple"|is.na(Dex_Suffix))|
      Name=='Ninetales'&(Dex_Suffix=='A'&Color!="Yellow"|is.na(Dex_Suffix))|
      Name=='Latios'&(Dex_Suffix=='M'&Color!="Blue"|is.na(Dex_Suffix))|
      Name=='Golem'&(Dex_Suffix=='A'&Color!="Brown"|is.na(Dex_Suffix))|
      Name=='Raticate'&(Dex_Suffix=='A'&Color!="Brown"|is.na(Dex_Suffix))|
      Name=='Latias'&(Dex_Suffix=='M'&Color!="Red"|is.na(Dex_Suffix))|
      Name=='Meowstic'| # ???
      Name=='Meowth'&(Dex_Suffix=='A'&Color!="Yellow"|is.na(Dex_Suffix))|
      Name=='Grimer'&(Dex_Suffix=='A'&Color!="Purple"|is.na(Dex_Suffix))|
      Name=='Magearna'&(Class=="Original Color"&Color!="Gray"|is.na(Class))|
      Name=='Geodude'&(Dex_Suffix=='A'&Color!="Brown"|is.na(Dex_Suffix))|
      Name=='Marowak'&(Dex_Suffix=='A'&Color!="Brown"|is.na(Dex_Suffix))|
      Name=='Persian'&(Dex_Suffix=='A'&Color!="Yellow"|is.na(Dex_Suffix))|
      Name=='Charizard'&(Dex_Suffix=='MX'&Color!="Red"|Dex_Suffix!='MX')
	);
# Missing normal Charizard

# Set diff
agg.j=agg.j%>%
	setdiff(
		agg.d
	)%>%
	union(
		agg.d.f
	);
# Remove junk
rm(agg.d,agg.d.f,color.all,color.class,color.dex,color.miss,color.miss.fix)

# See what we missed
agg.miss=agg%>%
	setdiff(
		agg.j%>%
			select(-Color)
	);

agg.miss%>%
	inner_join(
		color,
		by=dexes,
		suffix=c("",".d")
	)%>%
	filter(

		Name=="Charizard"&Class1=="Normal and"
	);


# Save
agg=.Last.value;

###############################################################################
# 															Join with ability
###############################################################################
# Cut the star out
ability=ability%>%
	mutate(
		Star=str_detect(Name, "\\*"),
		Name=gsub("\\*","", Name)
	);

agg%>%
	inner_join(
		ability,
		by=dexsuff,
		suffix=c("",".d")
	)%>%
	distinct(Name, Dex, Dex_Suffix, Class, `Ability 1`, `Ability 2`, Hidden);


agg%>%
	anti_join(
		ability,
		by=dexsuff, # c("Dex"="Dex")
		suffix=c("",".d")
	)%>%
	inner_join(
		ability,
		by=dexes,
		suffix=c("",".d")
	)%>%
	select(Name, Name.d, Dex, Dex_Suffix, Dex_Suffix.d, Class, `Ability 1`, `Ability 2`, Hidden);

# Union them
agg%>%
	inner_join(
		ability,
		by=dexsuff,
		suffix=c("",".d")
	)%>%
	union(
		agg%>%
			anti_join(
				ability,
				by=dexsuff, # c("Dex"="Dex")
				suffix=c("",".d")
			)%>%
			inner_join(
				ability,
				by=dexes,
				suffix=c("",".d")
			)%>%
			select(-Dex_Suffix.d)
	);
# Save
agg.j=.Last.value;


agg%>%
	anti_join(
		ability,
		by=dexsuff, # c("Dex"="Dex")
		suffix=c("",".d")
	)%>%
	anti_join(
		ability,
		by=dexes,
		suffix=c("",".d")
	)%>%
	inner_join(
		ability,
		by=c("Dex"="Dex"),
		suffix=c("",".d")
	)%>%
	select(Name, Name.d, Dex, Dex_Suffix, Dex_Suffix.d, Class, `Ability 1`, `Ability 2`, Hidden);

# Color is wrong