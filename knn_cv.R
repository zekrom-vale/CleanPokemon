# Import the data
source("import.R");
if(flag)file.edit("import.R");

# Can we pedict Type with weight and height?
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

species%>%
	knn_cv(WeightKg, HeightM, color=Type, nfold=10, times=20, k=1:350);
# Good, knn is quite good at predicting Type~Weight+HeightM
# Best k-value: 206 @ 14.3% error

species%>%
	knn_cv(WeightKg, HeightM, color=Type2, nfold=10, times=20, k=1:350);
# Not as good to predict

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

long%>%
	knn_cv(Type, color=Group, na.action="remove");
# Yep, knn does not accept factors and converting them into numbers
# will not work as Dark is not farther away from Grass than anything
# else, this is the same with lm with factors

# Weight and height honestly should have a relationship to Body
long%>%
	knn_cv(WeightKg, HeightM, color=Body, k=1:390, times=20);
# Best k value 204 at 22.2%
# Not that bad of a prediction for body
# Still, it should be based off of more than just Weight and
# Height