##################
# Merge with data
##################


###############################################################################
# 																		Join with dex
###############################################################################
dexes=c("Dex"="Dex", Name="Name");
dexsuff=c(dexes, "Dex_Suffix"="Dex_Suffix");

types.agg%>%
	inner_join(
		dex,
		by=dexes,
		suffix=c("",".d")
	)%>%View();

types.agg%>%
	anti_join(
		dex,
		by=dexes
	);
# That is fine, just stragalers left over

types.agg%>%
	inner_join(
		dex,
		by=dexes,
		suffix=c("",".d")
	)%>%
	filter(
		Dex_Suffix!=Dex_Suffix.d|is.na(Dex_Suffix)|is.na(Dex_Suffix.d)
	)%>%
	mutate(
		Dex_Suffix=if_else(is.na(Dex_Suffix),Dex_Suffix.d,Dex_Suffix),
		Dex_Suffix.d=NULL
	)%>%
	distinct()%>%
	View();# Many duplicates
# Need to separate to match by Dex_Suffix


types.agg%>%
	filter(!is.na(Dex_Suffix))%>%
	inner_join(
		dex%>%filter(!is.na(Dex_Suffix)),
		by=dexsuff
	);

types.agg%>%
	filter(is.na(Dex_Suffix))%>%
	inner_join(
		dex%>%filter(is.na(Dex_Suffix))
		,
		by=dexes,
		suffix=c("",".d")
	)%>%
	select(-Dex_Suffix.d)%>%
	distinct()%>%
	View();

# Now uniton them into agg

agg=types.agg%>%
	filter(!is.na(Dex_Suffix))%>%
	inner_join(
		dex%>%filter(!is.na(Dex_Suffix)),
		by=dexsuff
	)%>%
	union(
		types.agg%>%
			filter(is.na(Dex_Suffix))%>%
			inner_join(
				dex%>%filter(is.na(Dex_Suffix))
				,
				by=dexes,
				suffix=c("",".d")
			)%>%
			select(-Dex_Suffix.d)%>%
			distinct()
	);

# Find what did not match
types.agg%>%
	select(Name, Dex, Dex_Suffix, Alt, Class)%>%
	setdiff(
		agg%>%
			select(Name, Dex, Dex_Suffix, Alt, Class)
	);

dex%>%
	select(Name, Dex, Dex_Suffix)%>%
	setdiff(
		agg%>%
			select(Name, Dex, Dex_Suffix)
	);

# Need to join them

types.agg.j=types.agg%>%
	select(Name, Dex, Dex_Suffix, Alt, Class, Item, Form_Type1, Form_Type2)%>%
	setdiff(
		agg%>%
			select(Name, Dex, Dex_Suffix, Alt, Class, Item, Form_Type1, Form_Type2)
	)%>%
	inner_join(
		dex,
		by=dexes,
		suffix=c("",".d")
	)%>%
	select(-Dex_Suffix.d);


dex%>%
	select(Name, Dex, Dex_Suffix)%>%
	setdiff(
		agg%>%
			select(Name, Dex, Dex_Suffix)
	)%>%
	inner_join(
		types.agg,
		by=dexes
	)%>%
	View();


# Need to manualy select

dex.j=dex%>%
	select(Name, Dex, Dex_Suffix, Type, LDex, LDex_Suffix, Type2)%>%
	setdiff(
		agg%>%
			select(Name, Dex, Dex_Suffix, Type, LDex, LDex_Suffix, Type2)
	)%>%
	inner_join(
		types.agg,
		by=dexes,
		suffix=c("",".d")
	)%>%
	filter(
		Name=="Castform"&(
			Dex_Suffix=="S"&Class=="Sunny Form"|
			Dex_Suffix=="R"&Class=="Rainy Form"|
			Dex_Suffix=="H"&Class=="Snowy Form" # Duplicates in agg
		)|(
		Name=="Burmy"&(
			Dex_Suffix=="S"&Class=="Trash Cloak"|
			Dex_Suffix=="G"&Class=="Sandy Cloak" # Duplicates in agg
		)|(
			Name=="Shellos"|Name=="Gastrodon"
		)&Dex_Suffix=="E"&Class=="East Sea" # Duplicates in agg
		)|
		Name=="Unfezant"
		|
    Name=="Basculin"&Dex_Suffix=="B"&Class=="Blue-Striped Form" # Duplicates in agg
		|
		Name=="Frillish"
	  |
		Name=="Jellicent"
    #|
		#Name=="Oricorio" # Odd that there are not more
	)%>%
	select(-Dex_Suffix.d);


# Oricorio is wrong
# Need to remove Oricorio Duds
agg.j=agg%>%
	filter(
		Name=="Oricorio"
	)%>%
	union(
		agg%>%
			filter(Name=="Oricorio"&Class=="Baile Style")%>%
			slice(1:1)%>%
			mutate(
				Dex_Suffix=NA_character_
			)
	)%>%
	filter(
		Dex_Suffix=="Se"&Class=="Sensu Style"|
			Dex_Suffix=="Pa"&Class=="Pa'u Style"|
			Dex_Suffix=="Po"&Class=="Pom-Pom Style"|
			is.na(Dex_Suffix)
	);


# Now combine

agg=agg%>%
	filter(# Remove duplicates
		!(
		(
			Name=="Castform"&(
				Class=="Sunny Form"|
					Class=="Rainy Form"|
					Class=="Snowy Form" # Duplicates in agg
			)|(
				Name=="Burmy"&(
					Class=="Trash Cloak"|
						Class=="Sandy Cloak" # Duplicates in agg
				)|(
					Name=="Shellos"|Name=="Gastrodon"
				)&Class=="East Sea" # Duplicates in agg
			)|
				Name=="Unfezant"
			|
				Name=="Basculin"&Class=="Blue-Striped Form" # Duplicates in agg
			|
				Name=="Frillish"
			|
				Name=="Jellicent"
			#|
			#	Name=="Oricorio" # Odd that there are not more
			|
				Name=="Rotom"&!is.na(Class)&!is.na(Dex_Suffix)
		)
		)
	)%>%
	union(
		dex.j
	)%>%
	union(
		types.agg.j
	);

# Unoin them
agg%>%
	union(
		agg.j
	);

agg=agg%>%
	filter(
		Name
	)%>%
	union(
		agg.j
	);

# Fix Type

agg%>%
	mutate(
		Type=if_else(!is.na(Form_Type1), Form_Type1, Type),
		Type2=if_else(!is.na(Form_Type1), Form_Type2, Type2),
		Form_Type1=NULL,
		Form_Type2=NULL
	);

# Save

agg=agg%>%
	mutate(
		Type=if_else(!is.na(Form_Type1), Form_Type1, Type),
		Type2=if_else(!is.na(Form_Type1), Form_Type2, Type2),
		Form_Type1=NULL,
		Form_Type2=NULL
	);

# Duplicates are created

agg%>%
	setdiff(
		agg%>%
			distinct(Dex, Class, .keep_all=TRUE)
	);
# Manualy fix them

agg%>%
	filter(
		Name=="Greninja"&(
			is.na(Dex_Suffix)&is.na(Class)|
			Dex_Suffix=="A"&Class=="Ash-Greninja"
		)|Name=="Necrozma"&(
			is.na(Dex_Suffix)&is.na(Class)|
			Dex_Suffix=="DW"&Class=="Dawn Wings"|
			Dex_Suffix=="DM"&Class=="Dusk Mane"|
			Dex_Suffix=="U"&Class=="Ultra"
		)
	)%>%
	union(
		agg%>%
			filter(
				Name=="Necrozma"&is.na(Dex_Suffix)
			)%>%
			slice(1:1)%>%
			mutate(
				Class=NA_character_
			)
	);

agg%>%
	filter(
		Name!="Greninja"&Name!="Necrozma"
	)%>%
	union(
		agg%>%
			filter(
				Name=="Greninja"&(
					is.na(Dex_Suffix)&is.na(Class)|
						Dex_Suffix=="A"&Class=="Ash-Greninja"
				)|Name=="Necrozma"&(
					is.na(Dex_Suffix)&is.na(Class)|
						Dex_Suffix=="DW"&Class=="Dawn Wings"|
						Dex_Suffix=="DM"&Class=="Dusk Mane"|
						Dex_Suffix=="U"&Class=="Ultra"
				)
			)%>%
			union(
				agg%>%
					filter(
						Name=="Necrozma"&is.na(Dex_Suffix)
					)%>%
					slice(1:1)%>%
					mutate(
						Class=NA_character_
					)
			)
	)%>%distinct(Dex, Class, .keep_all=TRUE);# No duplicates!
# Save
agg=.Last.value;

test=agg%>%distinct(Dex, Class);
###############################################################################
#																Join with gender
###############################################################################
agg%>%
	inner_join(
		gender,
		by=dexes
	);

# Did not miss anything!

agg=agg%>%
	inner_join(
		gender,
		by=dexes
	);
###############################################################################
# 															Join with egg group
###############################################################################
agg%>%
	left_join(
		eggGroup,
		by=c(Dex="ID", Name="Name")
	);

# Save
agg=agg%>%
	left_join(
		eggGroup,
		by=c(Dex="ID", Name="Name")
	);
###############################################################################
# 																Join with weight
###############################################################################

agg%>%
	inner_join(
		weight,
		by=c(dexes, Dex_Suffix="Dex_Suffix")
	);

# See what did not match

agg%>%
	anti_join(
		weight,
		by=c(dexes, Dex_Suffix="Dex_Suffix")
	)%>%
	inner_join(
		weight%>%
			select(-Dex_Suffix),
		by=c("Dex"="Dex")
	);

agg%>%
	anti_join(
		weight,
		by=c(dexes, Dex_Suffix="Dex_Suffix")
	)%>%
	anti_join(
		weight%>%
			select(-Dex_Suffix),
		by=c("Dex"="Dex")
	);

# WARNING
# Jpined by less specific, to make it match

agg%>%
	inner_join(
		weight,
		by=c(dexes, Dex_Suffix="Dex_Suffix")
	)%>%
	union(
		agg%>%
			anti_join(
				weight,
				by=c(dexes, Dex_Suffix="Dex_Suffix")
			)%>%
			inner_join(
				weight%>%
					select(-c(Dex_Suffix,Name)),
				by=c("Dex"="Dex")
			)
	)%>%
	distinct()%>%View();
# We gained somthing
# Giritna
# Need to split name

weight%>%
	separate(
		Name,
		into=c("Name", "Class"),
		sep="\n"
	);
# Save
weight=weight%>%
	separate(
		Name,
		into=c("Name", "Class"),
		sep="\n"
	);

# Merge

agg%>%
	inner_join(
		weight,
		by=c(dexes, Dex_Suffix="Dex_Suffix") # , Class="Class"
	);

agg%>%
	anti_join(
		weight,
		by=c(dexes, Dex_Suffix="Dex_Suffix") # , Class="Class"
	)%>%
	inner_join(
		weight,
		by=c(dexes),
		suffix=c("",".d")
	)%>%
	filter(
		Class==Class.d|is.na(Class)|is.na(Class.d)
	);
# Still missing some

agg.t=agg%>%
	anti_join(
		weight,
		by=c(dexes, Dex_Suffix="Dex_Suffix") # , Class="Class"
	)%>%
	inner_join(
		weight,
		by=c(dexes),
		suffix=c("",".d")
	)%>%
	filter(
		Class==Class.d|is.na(Class)|is.na(Class.d)
	)%>%
	select(-Class.d,-Dex_Suffix.d)%>%
	union(
		agg%>%
			inner_join(
				weight,
				by=c(dexes, Dex_Suffix="Dex_Suffix"), # , Class="Class"
				suffix=c("",".d")
			)%>%
			select(-Class.d)
	);

setdiff_r=function(x,y) {
	setdiff(y,x)
};

# What did not match?
agg.t%>%
	select(
		-WeightKg,
		-WeightLbs
	)%>%
	setdiff_r(
		agg
	)%>%View();

agg%>%
	setdiff(
		agg.t%>%
			select(
				-WeightKg,
				-WeightLbs
			)
	)%>%
	inner_join(
		weight%>%select(-Class),
		by=c(Dex="Dex"),
		suffix=c("",".d")
	)%>%
	filter(
		str_detect(Name.d, Class)
	)%>%View();

# Unoin them now


agg%>%
	setdiff(
		agg.t%>%
			select(
				-WeightKg,
				-WeightLbs
			)
	)%>%
	inner_join(
		weight%>%select(-Class),
		by=c(Dex="Dex"),
		suffix=c("",".d")
	)%>%
	filter(
		str_detect(Name.d, Class)
	)%>%
	select(
		-Dex_Suffix.d,-Name.d
	)%>%
	union(
		agg%>%
			inner_join(
				weight,
				by=c(dexes, Dex_Suffix="Dex_Suffix"),
				suffix=c("",".d")
			)%>%
			select(-Class.d)
	)%>%
	union(
		agg.t
	);

# Save
agg=.Last.value;

rm(agg.t);

# Merge with exp

agg%>%
	inner_join(
		exp,
		by=dexes
	);

# Save as nothing got lost
agg=agg%>%
	inner_join(
		exp,
		by=dexes
	);
###############################################################################
# 																Join with body
###############################################################################
agg%>%
	left_join(
		body,
		by=dexes,
		suffix=c("",".d")
	)%>%
	filter(
		Dex_Suffix==Dex_Suffix.d|is.na(Dex_Suffix.d)
	)%>%
	distinct(Name, Dex_Suffix, Class, Dex, WeightKg, WeightLbs, .keep_all=TRUE)%>%
	select(-c(Dex_Suffix.d, Type2.d))%>%
	View();

# Save
agg=agg%>%
	inner_join(
		body,
		by=dexes,
		suffix=c("",".d")
	)%>%
	filter(
		Dex_Suffix==Dex_Suffix.d|is.na(Dex_Suffix.d)
	)%>%
	distinct(Name, Dex_Suffix, Class, Dex, .keep_all=TRUE)%>%
	select(-c(Dex_Suffix.d, Type2.d));

# Missing stuff

agg%>%
	select(
		c(Dex,Class)
	)%>%
	setdiff(
		test%>%
			select(c(Dex,Class))
	);

# body%>%filter(Dex==808);
# Missed in body and other places

###############################################################################
#																 Add gen
###############################################################################

agg%>%
	mutate(
		Gen=case_when(
			Dex<=151~1,
			Dex<=251~2,
			Dex<=386~3,
			Dex<=493~4,
			Dex<=649~5,
			Dex<=721~6,
			TRUE~7
		)
	);

# Save

agg=.Last.value;
