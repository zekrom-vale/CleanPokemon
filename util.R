# See how at https://dplyr.tidyverse.org/articles/programming.html
require(dplyr);
# This function returns thae values that are not distinct

print("This small utility package was developed by zekrom_vale to fill in the gaps missing.");
not_distinct_=function(df, col, ...){
	nd_vars=enquos(col,...);
	nd_col=enquo(col);

	dups=(
		df%>%
			setdiff(
				df%>%
					distinct(!!!nd_vars, .keep_all=TRUE)
			)
	)%>%select(!!nd_col);

	df%>%
		filter(
			!!nd_col%in%dups[[1]]
		);
}

not_distinct=function(df, ...){
	nd_vars=enquos(...);
	df%>%
		group_by(
			!!!nd_vars
		)%>%
		filter(
			reduce(c(!!!nd_vars), function(a,x)a&(n()>1), .init=TRUE)
		);
}

# Visulization functions
chunk=function(df,index=1, start=1, end=20){
	slice(df,(start:end)+end*index)
}

see=function(df,index=1, start=1, end=10){
	slice(df,(start:end)+end*index)
}

chunks=function(df,first=1, last=3, start=1, end=20){
	i=first;
	while(i<=last){
		i=i+1;
		print(chunk(df, i, start=start, end=end));
	}
}

panH=function(df, index=2, start=1, end=8, frozen=NULL){
	frozen=enquos(frozen);
	arr=Filter(function(x)x<length(df),(start:end)+end*(index-1));
	select(df, !!!frozen, arr);
}

pan=function(df, index=2, start=1, end=12, frozen=NULL){
	frozen=enquos(frozen);
	arr=Filter(function(x)x<length(df),(start:end)+end*(index-1));
	select(df,!!!frozen, arr);
}

v=function(.){
	View(.)
}
