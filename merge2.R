###############################################################################
# 																Join with color
###############################################################################
agg.rec=agg;
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
color%<>%
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

agg.j%<>%
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
      Name=='Vulpix'&(
      	Dex_Suffix=='A'&Color=="White"|
      	is.na(Dex_Suffix)&Color=="Brown"
      )|
      #Name=='Minior'|
      Name=='Raichu'&(
      	Dex_Suffix=='A'&Color=="Brown"|
      	is.na(Dex_Suffix)&Color=="Yellow"
      )|
      Name=='Sandshrew'&(
      	Dex_Suffix=='A'&Color=="White"|
      	is.na(Dex_Suffix)&Color=="Yellow"
      )|
      Name=='Sandslash'&(
      	Dex_Suffix=='A'&Color=="Blue"|
      		is.na(Dex_Suffix)&Color=="Yellow"
      )|
      Name=='Graveler'&(
      	Dex_Suffix=='A'&Color=="Gray"|
      	is.na(Dex_Suffix)&Color=="Brown"
      )|
      Name=='Castform'&(
      	Dex_Suffix=="S"&Color=="Red"|
      	Dex_Suffix=="R"&Color=="Blue"|
      	Dex_Suffix=="H"&Color=="Blue"|
      	is.na(Dex_Suffix)&Color=="Gray"
      )| # More complicated
      Name=='Audino'&(
      	Dex_Suffix=="M"&Color=="White"|
      	is.na(Dex_Suffix)&Color=="Pink"
      )|
      Name=='Necrozma'&(
      	Dex_Suffix=="DW"&Color=="Blue"|
      	Dex_Suffix=="DM"&Color=="Yellow"|
      	Dex_Suffix=="U"&Color=="Yellow"|
      	is.na(Dex_Suffix)&Color=="Black"
      )| # Quite complex
      Name=='Rattata'&(
      	Dex_Suffix=='A'&Color=="Black"|
      	is.na(Dex_Suffix)&Color=="Purple"
      )|
      Name=='Muk'&(
      	Dex_Suffix=='A'&Color=="Green"|
      	is.na(Dex_Suffix)&Color=="Purple"
      )|
      Name=='Ninetales'&(
      	Dex_Suffix=='A'&Color=="Blue"|
      	is.na(Dex_Suffix)&Color=="Yellow"
      )|
      Name=='Latios'&(
      	Dex_Suffix=='M'&Color=="Purple"|
      	is.na(Dex_Suffix)&Color=="Blue"
      )|
      Name=='Golem'&(
      	Dex_Suffix=='A'&Color=="Gray"|
      	is.na(Dex_Suffix)&Color=="Brown"
      )|
      Name=='Raticate'&(
      	Dex_Suffix=='A'&Color=="Black"|
      	is.na(Dex_Suffix)&Color=="Brown"
      )|
      Name=='Latias'&(
      	Dex_Suffix=='M'&Color=="Purple"|
      	is.na(Dex_Suffix)&Color=="Red"
      )|
      Name=='Meowstic'| # ???
      Name=='Meowth'&(
      	Dex_Suffix=='A'&Color=="Blue"|
      	is.na(Dex_Suffix)&Color=="Yellow"
      )|
      Name=='Grimer'&(
      	Dex_Suffix=='A'&Color!="Green"|
      	is.na(Dex_Suffix)&Color=="Purple"
      )|
      Name=='Magearna'&(
      	Class=="Original Color"&Color=="Red"|
      	is.na(Class)&Color=="Gray"
      )|
      Name=='Geodude'&(
      	Dex_Suffix=='A'&Color=="Gray"|
      	is.na(Dex_Suffix)&Color=="Brown"
      )|
      Name=='Marowak'&(
      	Dex_Suffix=='A'&Color=="Purple"|
      	is.na(Dex_Suffix)&Color=="Brown"
      )|
      Name=='Persian'&(
      	Dex_Suffix=='A'&Color=="Blue"|
      	is.na(Dex_Suffix)&Color=="Yellow"
      )|
      Name=='Charizard'&(
      	Dex_Suffix=='MX'&Color=="Black"|
      	(Dex_Suffix!='MX'|is.na(Dex_Suffix))&Color=="Red"
      )
	);
# Missing normal Charizard

# Set diff
agg.j%<>%
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


agg.miss%<>%
	inner_join(
		color,
		by=dexes,
		suffix=c("",".d")
	);

# agg.miss%>%filter(Name=="Cherrim")%>%select(Name, Dex, Dex_Suffix, Class, Dex_Suffix.d, Class1, Class2, Color)

agg.miss%<>%
	filter(
		Name=="Cherrim"&(
			Class=="Sunshine Form"&Color=="Pink"|
			Class=="Overcast Form"&Color=="Purple"
		)|
		(
			Name=="Zygarde"|
			Name=="Wormadam"|
			Name=="Darmanitan"|
			Name=="Shellos"|
			Name=="Gastrodon"|
			Name=="Lycanroc"
		)&(
			Dex_Suffix==Dex_Suffix.d|
			is.na(Dex_Suffix)&is.na(Dex_Suffix.d)
		)|
		Name=="Oricorio"&(# Need to add Dex_Suffix to them
			Dex_Suffix.d=="Po"&Class=="Pom-Pom Style"|
			Dex_Suffix.d=="Se"&Class=="Sensu Style"|
			Dex_Suffix.d=="Pa"&Class=="Pa'u Style"|
			is.na(Dex_Suffix.d)&Class=="Baile Style"
		)|
		Name=="Minior"| # Need to add
		Name=="Charizard"&Class1=="Normal and"
	);

# Fix Dex_Suffix

agg.miss%<>%
	mutate(
		Dex_Suffix=if_else(is.na(Dex_Suffix),Dex_Suffix.d,Dex_Suffix),
		Class=if_else(is.na(Class),Class1,Class)
	);
	#filter(Class!=Class1);

# Union them

agg.j%>%
	union(
		agg.miss%>%
			select(-c(Class1,Class2,Dex_Suffix.d))
	);

# Save
agg=.Last.value;

rm(agg.j, agg.miss);

agg%>%distinct(Name, Dex, Class, Dex_Suffix)
# Missing 1 value, unless it is from elsewere

###############################################################################
# 															Join with iq
###############################################################################
# Fix Weepinbell
iq=iq%>%
	mutate(
		Dex=if_else(Name=="Weepinbell",70:70,Dex)
	);

# Join
agg%>%
	left_join(
		iq,
		by=c(dexes,Dex_Suffix="Dex_Suffix"),
		suffix=c("",".d")
	)%>%
	select(-c(Type.d,Type2.d));

# See what did not match
iq%>%
	anti_join(
		agg,
		by=c(dexes,Dex_Suffix="Dex_Suffix"),
		suffix=c("",".d")
	);

# Save
agg%<>%
	left_join(
		iq,
		by=c(dexes,Dex_Suffix="Dex_Suffix"),
		suffix=c("",".d")
	)%>%
	select(-c(Type.d,Type2.d));

###############################################################################
# 															Join with friend
###############################################################################

# Join them
agg%>%
	left_join(
		friend,
		by=dexes
	);

# See what was missed
agg%>%
	anti_join(
		friend,
		by=dexes
	);

friend%>%
	anti_join(
		agg,
		by=dexes
	)%>%filter(
		!is.na(Dex)
	);

# Nothing missed
# Save

agg=agg%>%
	left_join(
		friend,
		by=dexes
	);

###############################################################################
# 															Join with evolution
###############################################################################
# Remove na's
evolution=evolution%>%filter(!is.na(Dex));

# Join
agg%>%
	left_join(
		evolution%>%
			select(-Dex_Suffix)%>%
			filter(!is.na(Dex)),
		by=dexes
	);

# Too big, somthing is not distinct in evolution
evolution%>%
	setdiff(
		evolution%>%
			distinct(Name,Dex,.keep_all=T)
	);

# ???

agg%>%
	inner_join(
		evolution%>%
			select(-Dex_Suffix)%>%
			filter(!is.na(Dex)),
		by=dexes
	)%>%
	group_by(
		Dex, Name
	)%>%
	summarise(
		ns=if_else(n()>1,T,F)
	)%>%
	filter(ns==T);

# See the things duplicated
evolution.dup=(agg%>%
							 	inner_join(
							 		evolution%>%
							 			select(-Dex_Suffix)%>%
							 			filter(!is.na(Dex)),
							 		by=dexes
							 	)%>%
							 	group_by(
							 		Dex, Name
							 	)%>%
							 	summarise(
							 		ns=if_else(n()>1,T,F)
							 	)%>%
							 	filter(ns==T))$Dex;

evolution%>%
	filter(
		Dex%in%evolution.dup
	)%>%View();
# I now see many things are from agg, not evolution

# Try distinct the rows
evolution%>%
	distinct();

evolution%>%
	distinct(
		Dex, Dex_Suffix, Name
	);

# Now they are the same
# Save
evolution%<>%
	distinct();

# Join
agg%>%
	left_join(
		evolution%>%
			select(-Dex_Suffix)%>%
			filter(!is.na(Dex)),
		by=dexes
	);

# Now the same size

agg=.Last.value;

rm(evolution.dup);
###############################################################################
# 															Join with Call rate
###############################################################################
# Remove na's
call%<>%
	filter(!is.na(Dex));

# See if there are duplicates
call%>%distinct() # 10 Row dups

# Save
call%<>%distinct();

call%>%distinct(
	Name,Dex,.keep_all=T
); # 2 Duplicates

call.dup=(
	call%>%
		group_by(Dex)%>%
		summarise(
			ns=if_else(n()>1,T,F)
		)%>%
		filter(ns==T)
)$Dex;

call%>%
	filter(
		Dex%in%call.dup # Can not use in line
	);

# Apperently the class is important
# Fix to add the class
call.f=call%>%
	mutate(
		Class=if_else(
			Dex==550,
			if_else(
				Call_Rate_USUM==9,
				"Red-Striped Form",
				"Blue-Striped Form"
			),
			if_else(
				Dex==670,
				if_else(
					Call_Rate_USUM==9,
					"Red Flower",
					"Flower"
				),
				NA_character_
			)
		)
	)%>%filter(!is.na(Class));

agg.j=agg%>%
	left_join(
		call.f,
		by=dexes,
		suffix=c("",".d")
	);

agg.j%>%
	filter(
		Dex==670&(
			Class==Class.d|
			Class.d=="Flower"&Class!="Red Flower"
		)|
		Dex==550&Class==Class.d
	)%>%
	union(
		agg.j%>%
			filter(
				!Dex%in%c(670L, 550L)
			)
	)%>%
	select(-c(Class.d));

# No duplicates so
# Save
agg=.Last.value;

rm(agg.j, call.f, call.dup, dex.j);

# agg.rec is 7 rows shorter, should be fine as color added some types
# One thing is not distinct
agg%>%not_distinct(Name, Name, Dex, Dex_Suffix, Class);

###############################################################################
# 															Join with ability
###############################################################################
# Cut the star out
ability%<>%
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
