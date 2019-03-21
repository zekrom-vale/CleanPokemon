#library(tidyverse);
#source("clean.R");
#source("manageAlts.R");
##################
# Merge with data
##################

# Join with dex

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
    |
		Name=="Oricorio" # Odd that there are not more
	)%>%
	select(-Dex_Suffix.d);

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
			|
				Name=="Oricorio" # Odd that there are not more
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

# Join with gender

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

# Join with egg group

agg%>%
	inner_join(
		eggGroup,
		by=c(Dex="ID", Name="Name")
	);

# Save
agg=agg%>%
	inner_join(
		eggGroup,
		by=c(Dex="ID", Name="Name")
	);

# Join with weight
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

# Join with body

agg%>%
	inner_join(
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
	distinct(Name, Dex_Suffix, Class, Dex, WeightKg, WeightLbs, .keep_all=TRUE)%>%
	select(-c(Dex_Suffix.d, Type2.d));

# Join with color

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
agg%>%
	inner_join(
		color%>%
			filter(
			  is.na(Class1)|Class1=="All forms"
		  )%>%
		  select(-c(Dex_Suffix, Class1, Class2))
		,
		by=dexes
	);

# Join when Dex_Suffix match
agg%>%
	inner_join(
		color%>%
			select(-c(Class1, Class2)),
		by=dexsuff
	);

# Union them
agg.j=agg%>%
	inner_join(
		color%>%
			filter(
				is.na(Class1)|Class1=="All forms"
			)%>%
			select(-c(Dex_Suffix, Class1, Class2))
		,
		by=dexes
	)%>%
	union(
		agg%>%
			inner_join(
				color%>%
					select(-c(Class1, Class2)),
				by=dexsuff
			)
	);

agg%>%
	setdiff(
		agg.j%>%
			select(
				-c(Color)
			)
	);

# There are duplicates in agg

agg.j%>%distinct(
	Dex, Dex_Suffix, Name, Color, Class, .keep_all=TRUE
);

# Union them

agg.j%>%distinct(
	Dex, Dex_Suffix, Name, Color, Class, .keep_all=TRUE
)%>%
	union(
		agg%>%
			setdiff(
				agg.j%>%
					select(
						-c(Color)
					)
			)%>%
			inner_join(
				color,
				by=dexes,
				suffix=c("",".d")
			)%>%
			filter(
				Class2=="Mega Charizard Y"
			)%>%select(-c(Class1,Class2,Dex_Suffix.d))
	);

# Save
agg=.Last.value;


# Join with ability
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