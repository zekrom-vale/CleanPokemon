# Some plots take some time, as there are many values
# Others may not display unless zoomed in
# Many plots need to be zoomed in to see,
# others you nned to maximise the window to re-render
# Others don't render the legend correctoly, if at all,
# zomming in fixes that
# Resolution may differ as I use a 4K monitor

# See the tibbles
types;
gender_ratio;
generations;
eggGroups;
body;
abilityKey;
items;
itemsIDs;

pokemon;
species;
pokemonLang;
base;
evolutions;
family;
# Wow this is actualy a lot of data, about 700Kb
# True, encoding as a human readable format (csv, tsv and not
# bianary) is not the most effecent way to stor non string values


#library(ggcorrplot); # Does not work with factors

# Get the cor matrix
#ggcorrplot(cor(species), hc.order=TRUE, type="lower", lab=TRUE);
# cor can only use numbers
# http://www.sthda.com/english/wiki/ggcorrplot-visualization-of-a-correlation-matrix-using-ggplot2

# Normaly there should be a corelation between weight and height
species%>%
	ggplot(aes(WeightKg, HeightM))+
	geom_point(aes(WeightKg, HeightM, color=Gender_Ratio))+
	geom_smooth();
# Looks like it, but the points are clustered twards (0,0)


# Spred the points out
species%>%
	ggplot(aes(log(WeightKg), log(HeightM)))+
	geom_point(aes(log(WeightKg), log(HeightM), color=Gender_Ratio))+
	geom_smooth();
# Definetly a corelation, odd clustering lines (delta weight)

# Wrap by body as that must be a factor, perhapse even use
# different calculations per body type
species%>%
	ggplot(aes(log(WeightKg), log(HeightM)))+
	geom_point(aes(log(WeightKg), log(HeightM), color=Gender_Ratio))+
	facet_wrap(vars(Body), scales="free")+
	geom_smooth();
# Better graph, still does not answer the clusters

# Try removing the logs to see what the defult is
# Definitly don't smooth by Gender_Ratio
species%>%
	mutate(
		WeightKg=log(WeightKg),
		HeightM=log(HeightM)
	)%>%
	ggplot()+
	xlab("ln(WeightKg)")+
	ylab("ln(HeightM)")+
	geom_point(aes(WeightKg, HeightM, color=Gender_Ratio))+
	facet_wrap(vars(Body), scales="free")+
	geom_smooth(aes(WeightKg, HeightM), method="lm", color="red")+
	geom_smooth(aes(WeightKg, HeightM), method="loess", color="blue");
# Not using color in aes will not create a legend


# It is odd that height crests at 4.7m around 650Kg

(function(){ # Prevent global scope polution
	g=species%>%
		loess(WeightKg~HeightM, data=.);

	print(g$residuals);
	print(g$coefficients);

	# Try using lm and
	g.=species%>%
		lm(WeightKg~HeightM:Body, data=.);

	print(predict(g., tibble(HeightM=2, Body="Quadruped body")));
})();


#################################################################
# Other things and height and weight

# Type
species%>%
	ggplot()+
	geom_point(aes(WeightKg, HeightM, color=Type2))+
	facet_wrap(vars(Type), scales="free")+
	geom_smooth(aes(WeightKg, HeightM), color="red", method="lm")+
	geom_smooth(aes(WeightKg, HeightM), color="blue", method="loess");
# There is a corelation, try using log to get a btter result?

species%>%
	mutate(
		WeightKg=log(WeightKg),
		HeightM=log(HeightM)
	)%>%
	ggplot()+
	ylab("ln(WeightKg)")+
	xlab("ln(HeightM)")+
	geom_point(aes(WeightKg, HeightM, color=Type2))+
	facet_wrap(vars(Type), scales="free")+
	geom_smooth(aes(WeightKg, HeightM), color="red", method="lm")+
	geom_smooth(aes(WeightKg, HeightM), color="blue", method="loess");
# This appers to be better as the points are not clustered up like before

species%>%
	ggplot()+
	geom_point(aes(WeightKg, HeightM, color=Type))+
	facet_wrap(vars(Type2), scales="free")+
	geom_smooth(aes(WeightKg, HeightM));

species%>%
	ggplot()+
	geom_point(aes(WeightKg, HeightM, color=Type2))+
	facet_wrap(vars(Type), scales="free")+
	geom_smooth(aes(WeightKg, HeightM, color=Type2))+
	geom_smooth(aes(WeightKg, HeightM));
# Psychic is the only one that has enough points to create Type2 lines


# Egg Group
species%>%
	ggplot()+
	geom_point(aes(WeightKg, HeightM, color=`Egg Group 2`))+
	facet_wrap(vars(`Egg Group 1`), scales="free")+
	geom_smooth(aes(WeightKg, HeightM));

# Alt way
species%>%
	ggplot()+
	geom_point(aes(WeightKg, HeightM, color=`Egg Group 1`))+
	facet_wrap(vars(`Egg Group 2`), scales="free")+
	geom_smooth(aes(WeightKg, HeightM));
# `near singularities` warning, perhapse loess is not good for this

species%>%
	ggplot()+
	geom_point(aes(WeightKg, HeightM, color=`Egg Group 2`))+
	facet_wrap(vars(`Egg Group 1`), scales="free")+
	geom_smooth(aes(WeightKg, HeightM, color=`Egg Group 2`))+
	geom_smooth(aes(WeightKg, HeightM));
# Monster and water1 have enough points to create Egg Group 2 lines
# Also many more warnings


#################################################################
# Type vs weight
species%>%
	ggplot()+
	geom_point(aes(Type, WeightKg, color=Type2));
# Wow, that is a mess!
# Points are not going to work

# Try hystogram
species%>%
	ggplot()+
	geom_histogram(aes(WeightKg))+
	facet_grid(vars(Type),vars(Type2));
# Looks like a quilt, soo much data
# Also, very vary slow

species%>%
	ggplot()+
	geom_boxplot(aes(Type, WeightKg))+
	facet_grid(vars(Type2));
# Looks better and was the data I was looking for
# Some types vary little and others a lot

# Try adding jitter
species%>%
	ggplot()+
	geom_point(aes(Type, WeightKg, color=Type2), position="jitter");
# This is the best, now you can see the amount AND the color

# Can I add height?
species%>%
	ggplot()+
	geom_point(aes(Type, WeightKg, color=Type2, size=HeightM), position="jitter");
# Yes, and it still looks good!


# Try Height
species%>%
	ggplot()+
	geom_boxplot(aes(Type, HeightM))+
	facet_grid(vars(Type2));
# Same thing here with the height

species%>%
	ggplot()+
	geom_point(aes(Type, HeightM, color=Type2, size=WeightKg), position="jitter");
# Looks like the one above (2 above)

# Perhapse the best thing is to create a summery with group_by
types=species%>%
	group_by(Type, Type2)%>%
	summarise(
		WeightKgMean=mean(WeightKg), WeightKgMin=min(WeightKg), WeightKgMax=max(WeightKg),
		HeightMean=mean(HeightM), HeightMin=min(HeightM), HeightMax=max(HeightM)
	);
# Just this is big enough to analise or graph
# But how??

# Use raster, but can only use one value
# Now that I know of jitter, this is not the best ot get the full picture
types%>%
	ggplot()+
	geom_raster(aes(Type, Type2, fill=WeightKgMean));

types%>%
	ggplot()+
	geom_raster(aes(Type, Type2, fill=WeightKgMax));

types%>%
	ggplot()+
	geom_raster(aes(Type, Type2, fill=WeightKgMin));

types%>%
	ggplot()+
	geom_raster(aes(Type, Type2, fill=HeightMean));

types%>%
	ggplot()+
	geom_raster(aes(Type, Type2, fill=HeightMin));

types%>%
	ggplot()+
	geom_raster(aes(Type, Type2, fill=HeightMax));

#################################################################
# Type and color may have a corelation
# That looks like the best
species%>%
	ggplot()+
	geom_jitter(aes(Type, Type2, color=Color))+
	scale_color_identity()+# Make color use real color
	xlab("Primary Type")+
	ylab("Secondary Type")+
	labs(title="Pokemon color by types");

# scale_color_identity is cool, it uses the colors in the data!
# Thiss looks like the best way to do it
# Dark~Dark colors
# Electric~Yellows
# Fairy~Whites and Pinks
# Fire~Reds
# Ghosts~Browns and Purples
# Grass~Green
# Ground~Dull colors
# Ice~White and Blue
# Normal~Browns
# Poison~Purples
# Steel~Gray
# Water~Blue

# Get a predictable version
species%>%
	mutate(
		TypeMix=paste(Type, Type2)
	)%>%
	count(TypeMix, Color)%>%
	ggplot(aes(TypeMix, Color, size=n))+
	geom_point();

# Seperate into type and type2
species%>%
	ggplot(aes(Type%>%vapply(function(x)str_sub(x,1,3), ""), fill=Type2))+
	geom_bar()+
	facet_wrap(vars(Color));

species%>%
	ggplot(aes(Type2%>%vapply(function(x)str_sub(x,1,3), ""), fill=Type))+
	geom_bar()+
	facet_wrap(vars(Color));

# Since I know scale_color_identity exists prehapse use fill
species%>%
	ggplot(aes(Type%>%vapply(function(x)str_sub(x,1,3), ""), fill=Color))+
	scale_fill_identity()+
	geom_bar()+
	facet_wrap(vars(Type2));

# Count the Type and Color
species%>%
	count(Type, Color);

species%>%
	count(Type2, Color);

# Now statistics
species%>%
	group_by(Type, Type2, Color)%>%
	summarise(
		Count=n()
	)%>%dcast(
		formula=paste(Type, Type2)~Color, # formula only allows 2 values, so paste them
		value.var="Count"
	)%>%
	as_tibble()%>%
	extract(# Then extract them except drop NAs
		`paste(Type, Type2)`,
		into=c("Type", "Type2"),
		regex="(\\S+)\\s+N?A?(\\S+)?"
	);

# Count megas per gen
species%>%
	group_by(
		Gen
	)%>%
	filter(# Remove all instances that don't have mega
		str_detect(Class,"(?i)mega")
	)%>%
	summarise(
		megas=n()# Can't count if
	);

# Alternative way with reduce
species%>%
	group_by(
		Gen
	)%>%
	summarise(
		megas=count_when(Class, "(?i)mega"),
		alola=count_when(Class, "(?i)Alola"),
		primal=count_when(Class, "(?i)Primal")
	);
# reduce(
# 	Class,
# 	.f=function(acc, cur)accumFn(acc, cur, "(?i)primal"),
# 	.init=0L
# )

# accumFn=function(accumulaton, current, value){
# 	accumulaton+if_else(
# 		is.na(current),
# 		0L,
# 		as.integer(str_detect(current,value))
# 	)
# }

#################################################################
# Analise Ability

# Merge abilitys into one
# Ignore Hidden as that is different
species.a=species%>%
	mutate(
		Ability=`Ability 1`,
		`Ability 2`=NULL,
		`Ability 1`=NULL
	)%>%
	union(
		species%>%
			mutate(
				Ability=`Ability 2`,
				`Ability 2`=NULL,
				`Ability 1`=NULL
			)
	);

species.a%>%
	ggplot(aes(Ability, fill=Type))+
	geom_bar()+
	facet_wrap(vars(str_sub(Ability,1,2)), scales="free");


#################################################################
# Predict weight and height by type
species%>%
	ggplot(aes(Type, Type2, size=HeightM, color=WeightKg))+
	scale_color_distiller("Blues", direction=0)+
	geom_jitter();

# Nice graph, but not very concreat

species%>%
	ggplot(aes(HeightM, fill=Type2))+
	facet_wrap(vars(Type))+
	geom_histogram(bins=100);

# Still not the best


# Try using lm
#Height
species%>%
	lm(HeightM~Type-1,.);# `%>%` will autocompleat, unlike not using it

species%>%
	lm(HeightM~Type2-1,.);

species%>%
	lm(HeightM~Type+Type2-1,.);

h=species%>%
	lm(HeightM~Type*Type2-1,.);

# Weight

species%>%
	lm(WeightKg~Type-1,.);

species%>%
	lm(WeightKg~Type2-1,.);

species%>%
	lm(WeightKg~Type+Type2-1,.);

species%>%
	lm(WeightKg~Type*Type2-1,.);

# Since these are descreet varables, the value would be the
# intersept plus the slope
# -1 removes the intersept so the value is right there

# Usee predict to make it easy
predict(h, tibble(Type="Dragon",Type2="Electric"));

#################################################################
# Get deltas

evolutions.delta=species%>%
	inner_join(
		evolutions,
		by=c("Name","Dex","Dex_Suffix","Class")
	)%>%
	inner_join(
		species,
		by=c("Next_Name"="Name","Next_Dex"="Dex","Dex_Suffix","Class"),
		suffix=c("",".next")
	)%>%
	rename(
		Dex.next=Next_Dex,
		Name.next=Next_Name
	);

# Get deltas
eq.na=function(a,b){# Define an equals function including NA==NA
	fun=function(a,b){
		if(is.na(a)&is.na(b)|!is.na(a)&!is.na(b)&a==b)return(TRUE)
		else return(FALSE);
	};
	mapply(fun,a,b);
}
evolutions.delta%<>%
	mutate(
		WeightKg.delta=WeightKg.next-WeightKg,
		HeightM.delta=HeightM.next-HeightM,
		Cycles.delta=Cycles.next-Cycles,
		`Ability 1.delta`=eq.na(`Ability 1`,`Ability 1.next`),
		`Ability 2.delta`=eq.na(`Ability 2`,`Ability 2.next`),
		Hidden.delta=eq.na(Hidden,Hidden.next),
		Type.delta=eq.na(Type,Type.next),
		Type2.delta=eq.na(Type2,Type2.next)
	);

# Plot WeightKg.delta vs HeightM.delta
evolutions.delta%>%
	ggplot()+# aes will inheret with geom_smooth, so declare it in geom_*
	geom_point(aes(WeightKg.delta, HeightM.delta, color=Type))+
	geom_smooth(aes(WeightKg.delta, HeightM.delta));

# Some outlyers have masive change, remove them

evolutions.delta%>%
	filter(
		abs(WeightKg.delta)<=sd(WeightKg.delta),
		abs(HeightM.delta)<=1.5*sd(HeightM.delta)
	)%>%
	mutate(
		WeightKg.delta=log(WeightKg.delta),
		HeightM.delta=log(HeightM.delta)
	)%>%
	ggplot()+
	xlab("lm(HeightM.delta)")+
	ylab("lm(WeightKg.delta)")+
	geom_point(aes(WeightKg.delta, HeightM.delta, color=Type, shape=factor(paste(Stage,Stage+1, sep="-"))))+
	labs(shape="Stage")+
	geom_smooth(aes(WeightKg.delta, HeightM.delta));
# Again with the clustering

evolutions.delta%>%
	filter(
		abs(WeightKg.delta)<=sd(WeightKg.delta),
		abs(HeightM.delta)<=1.5*sd(HeightM.delta)
	)%>%
	mutate(
		WeightKg.delta=log(WeightKg.delta),
		HeightM.delta=log(HeightM.delta)
	)%>%
	ggplot()+
	xlab("lm(HeightM.delta)")+
	ylab("lm(WeightKg.delta)")+
	geom_point(aes(WeightKg.delta, HeightM.delta, color=Type, size=WeightKg))+
	facet_wrap(aes(factor(paste(Stage,Stage+1, sep="-"))))+
	labs(facet="Stage")+
	geom_smooth(aes(WeightKg.delta, HeightM.delta));

# Try doing size
evolutions.delta%>%
	mutate(
		WeightKg=log(WeightKg),
		WeightKg.next=log(WeightKg.next)
	)%>%
	ggplot()+
	xlab("lm(WeightKg.next)")+
	ylab("lm(WeightKg)")+
	geom_smooth(aes(WeightKg, WeightKg.next))+
	geom_point(aes(WeightKg, WeightKg.next, size=WeightKg.delta, color=Type));

# Graph other delatas
evolutions.delta%>%
	ggplot(aes(Type.delta, Type2.delta, color=Type))+
	geom_jitter();
# Many evolutions do not change types

evolutions.delta%>%
	ggplot(aes(paste(Type.delta,Type2.delta), fill=Type))+ # color will create borders with geom_bar()
	xlab("Type.deltas")+
	geom_bar();

evolutions.delta%>%
	ggplot(aes(paste(Type.delta,Type2.delta), fill=Type2))+ # color will create borders with geom_bar()
	xlab("Type.deltas")+
	geom_bar();

# Less here but still many

evolutions.delta%>%
	ggplot(aes(paste(`Ability 1.delta`,`Ability 2.delta`), fill=`Ability 1`))+
	xlab("Ability.deltas")+
	geom_bar(position="dodge");

evolutions.delta%>%
	ggplot(aes(`Ability 2`, fill=paste(`Ability 1.delta`,`Ability 2.delta`)))+
	labs(fill="Ability.deltas")+
	facet_wrap(~str_sub(`Ability 2`,1,2), scales="free_x")+
	geom_bar(position="dodge");

# Don't know how to graph this

#################################################################
# Items

# While cleaning the data I found some duplicate item names
items%>%
	select(Name, Gen, Gen2, Description)%>%
	not_distinct(Name)%>%
	arrange(Name);
# I can join the discriptions together
# And increase the gen range

#################################################################
# WeightKg ~ WeightLbs and HeightM ~ HeightFt + HeightIn/12
# should be a R^2 aprox 1 relationship

# Weight
species%>%
	ggplot(aes(WeightKg, WeightLbs))+
	geom_point()+
	geom_smooth(method="lm");

species%>%
	lm(WeightKg~WeightLbs,.)%>%
	summary();

# Height
species%>%
	ggplot(aes(HeightM, Ft+In/12))+
	geom_point()+
	geom_smooth(method="lm");

species%>%
	mutate(
		FtIn=Ft+In/12 # Cannot do this in lm method as `+`` is different
	)%>%
	lm(HeightM~FtIn,.)%>%
	summary();

# As predicted R^2 is 1 as it should be as they only differ in units
# Because the Inch unit can only can hold an int value,
# there will be coversion inacuracy due to rounding.
# Besides, it is imposible to represent the exact metric value
# in an floating point number (Or double) as Feet and Inches

