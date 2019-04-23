# Some plots take some time, as there are many values

# See the tibbles
pokemon;
species;
items;
itemsIDs;
abilityKey;

# Normaly there should be a corelation between weight and height
species%>%
	ggplot(aes(WeightKg, HeightM))+
	geom_point(aes(WeightKg, HeightM, color=Gender_Ratio))+
	geom_smooth();

# Spred the points out
species%>%
	ggplot(aes(log(WeightKg), log(HeightM)))+
	geom_point(aes(log(WeightKg), log(HeightM), color=Gender_Ratio))+
	geom_smooth();

# Wrap by body as that must be a factor
species%>%
	ggplot(aes(log(WeightKg), log(HeightM)))+
	geom_point(aes(log(WeightKg), log(HeightM), color=Gender_Ratio))+
	facet_wrap(vars(Body), scales="free")+
	geom_smooth();

# Try removing the logs to see what the defult is
# Definitly don't smooth by Gender_Ratio
species%>%
	ggplot()+
	geom_point(aes(WeightKg, HeightM, color=Gender_Ratio))+
	facet_wrap(vars(Body), scales="free")+
	geom_smooth(aes(WeightKg, HeightM));


# It is odd that height crests at 4.7m around 650Kg

g=species%>%
	loess(WeightKg~HeightM, data=.);

g$residuals;
g$coefficients;

#################################################################
# Other things and height and weight

# Type
species%>%
	ggplot()+
	geom_point(aes(WeightKg, HeightM, color=Type2))+
	facet_wrap(vars(Type), scales="free")+
	geom_smooth(aes(WeightKg, HeightM));

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

species%>%
	ggplot()+
	geom_point(aes(WeightKg, HeightM, color=`Egg Group 1`))+
	facet_wrap(vars(`Egg Group 2`), scales="free")+
	geom_smooth(aes(WeightKg, HeightM));

species%>%
	ggplot()+
	geom_point(aes(WeightKg, HeightM, color=`Egg Group 2`))+
	facet_wrap(vars(`Egg Group 1`), scales="free")+
	geom_smooth(aes(WeightKg, HeightM, color=`Egg Group 2`))+
	geom_smooth(aes(WeightKg, HeightM));
# Monster and water1 have enough points to create Egg Group 2 lines


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

species%>%
	ggplot()+
	geom_boxplot(aes(Type, WeightKg))+
	facet_grid(vars(Type2));
# Looks better and was the data I was looking for
# Some types vary little and others a lot

# Try Height
species%>%
	ggplot()+
	geom_boxplot(aes(Type, HeightM))+
	facet_grid(vars(Type2));
# Same thing here with the height
# Perhapse the best thing is to create a summery with group_by

types=species%>%
	group_by(Type, Type2)%>%
	summarise(
		WeightKgMean=mean(WeightKg), WeightKgMin=min(WeightKg), WeightKgMax=max(WeightKg),
		HeightMean=mean(HeightM), HeightMin=min(HeightM), HeightMax=max(HeightM)
	);

# Just this is big enough to analise or graph
# But how??

# Use raster, but can only use one
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
species%>%
	lm(HeightM~Type-1,.)

species%>%
	lm(HeightM~Type2-1,.)

species%>%
	lm(HeightM~Type+Type2-1,.)

h=species%>%
	lm(HeightM~Type*Type2-1,.)

# Since these are descreet varables, the value would be the the intersept plus the slope
# -1 removes the intersept so the value is right there

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
eq.na=function(a,b){
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
	ggplot()+
	geom_point(aes(WeightKg.delta, HeightM.delta, color=Type))+
	geom_smooth(aes(WeightKg.delta, HeightM.delta));

# Some outlyers have masive change, remove them

evolutions.delta%>%
	filter(
		abs(WeightKg.delta)<=sd(WeightKg.delta),
		abs(HeightM.delta)<=1.5*sd(HeightM.delta)
	)%>%
	ggplot()+
	geom_point(aes(WeightKg.delta, HeightM.delta, color=Type, shape=factor(paste(Stage,Stage+1, sep="-"))))+
	labs(shape="Stage")+
	geom_smooth(aes(WeightKg.delta, HeightM.delta));

# Graph other delatas
evolutions.delta%>%
	ggplot(aes(Type.delta, Type2.delta, color=Type))+
	geom_jitter();
