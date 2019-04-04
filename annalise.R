# See the tibbles
pokemon;
items;
itemsIDs;
abilityKey;

# Normaly there should be a corelation between weight and height
pokemon%>%
	ggplot(aes(WeightKg, HeightM))+
	geom_point(aes(WeightKg, HeightM, color=Gender_Ratio))+
	geom_smooth();

# It is odd that height crests at 4.7m around 650Kg

g=pokemon%>%
	mgcv::gam(WeightKg~HeightM, data=.);

g$residuals;
g$coefficients;

# Type vs weight
pokemon%>%
	ggplot()+
	geom_point(aes(Type, WeightKg, color=Type2));
# Wow, that is a mess!
# Points are not going to work

# Try hystogram
pokemon%>%
	ggplot()+
	geom_histogram(aes(WeightKg))+
	facet_grid(vars(Type),vars(Type2));
# Looks like a quilt, soo much data

pokemon%>%
	ggplot()+
	geom_boxplot(aes(Type, WeightKg))+
	facet_grid(vars(Type2));
# Looks better and was the data I was looking for
# Some types vary little and others a lot

# Try Height
pokemon%>%
	ggplot()+
	geom_boxplot(aes(Type, HeightM))+
	facet_grid(vars(Type2));
# Same thing here with the height
# Perhapse the best thing is to create a summery with group_by

types=pokemon%>%
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

# Type and color may have a corelation
# That looks like the best
pokemon%>%
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

# Now statistics
pokemon%>%
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
pokemon%>%
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
pokemon%>%
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
