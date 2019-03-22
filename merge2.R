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