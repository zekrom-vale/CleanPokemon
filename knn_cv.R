####################################################################
#															Intro
####################################################################
# Do note that I have more code and documentation on other files
# as well as the utility package I made (I have included that in
# counting the code requierments)

# Import the data
source("import.R");
if(flag)file.edit("import.R");

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
# Long is the table that is joined together
long;

# See the functions I created to automaticaly handle the
# knn cross validation (Based off of some of your functions)
# I would have made it parallel, but parallel:: is not automatic
# See at
browseURL("https://github.com/zekrom-vale/zUtil.R/blob/master/R/cfknn.R");
# Documentation included for
?zUtil::knn_cv

####################################################################
#															Type
####################################################################

# Can we pedict Type with weight and height?
# As there is a corelation between Type and Height and Weight
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
# So we should be able to as there is a different line for each
# Type
# The problem is that we don't need to pridict that ever
# as they don't give a species without Type

# There appers to be a corelation between Weight and Height
# that can predict Type by knn.
# This is that graph.
species%>%
	ggplot(aes(WeightKg, HeightM, color=Type))+
	geom_point()+
	geom_smooth(se=FALSE);

# Use the log to improve loess and graphing
species%>%
	ggplot(aes(log(WeightKg), log(HeightM), color=Type))+
	geom_point()+
	geom_smooth(se=FALSE);

species%>%
	knn_cv(WeightKg, HeightM, color=Type, nfold=10, times=20, k=1:350);
# Good, knn is quite good at predicting Type~Weight+HeightM
# Best k-value: 206 @ 14.3% error
# This shows that 206nn is quite good for predicting the first type
# of a species.  This would make sence as the first typpe is the
# primary type and that species of rock or steel would be heaver
# and shorter than species of say flying or normal.

# species%>%
#		knn_fill(WeightKg, HeightM, color=Type, k=206);
# # Code for this is off, returns an unamed list

species%>%
	knn_cv(WeightKg, HeightM, color=Type2, nfold=10, times=20, k=1:350);
# Not as good to predict
# This is likely less acurate as the second type is less of a
# factor in weight and height.  Why else would there be pokemon
# with the same types but in a different order?

####################################################################
#															Group
####################################################################

# The only data that we do not have for all species is Group
# this is because Groups were introduced in 3rd generation
# and have not been used since.
# The only problem is that class::knn does not work for factors
# looking this up, some knn algoriums do support this
# (not class:knn)
long%>%
	ggplot()+
	geom_point(aes(WeightKg, HeightM, color=Group))+
	geom_smooth(aes(WeightKg, HeightM));

# The only numerical data we have is height and weight
# As mentioned above, class::knn does not work for factors
long%>%
	knn_cv(WeightKg, HeightM, color=Group, na.action="remove", k=1:390);
# k-284 @18.8% error is not that bad
# Still, it would be nice to use other descreet varables
# such as Type
# I would increase the knn k-value, but class::knn gives out around 400 to 600


####################################################################
#															Body
####################################################################

long%>%
	ggplot()+
	geom_point(aes(WeightKg, HeightM, color=Body))+
	geom_smooth(aes(WeightKg, HeightM));

long%>%
	knn_cv(Type, color=Group, na.action="remove");
# Yep, knn does not accept factors and converting them into numbers
# will not work as Dark is not farther away from Grass than anything
# else, this is the same with lm with factors

# Weight and height honestly should have a relationship to Body
long%>%
	knn_cv(WeightKg, HeightM, color=Body, k=1:390, times=20);
# Best k value 204 at 22.2%
# Not that bad of a prediction for body.  This makes sence as
# a head body type would weigh less than a bipedaled tailed
# creture and be taller.
# Still, it should be based off of more than just Weight and
# Height
