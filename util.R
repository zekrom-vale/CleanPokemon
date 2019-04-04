require(dplyr);
print("This small utility package was developed by zekrom_vale to fill in the gaps missing.");
################################################################################
#																	Elements
################################################################################
# See how at https://dplyr.tidyverse.org/articles/programming.html
# This function returns thae values that are not distinct
# List the columns you want to get the rows that are not distinct
not_distinct=function(df, ...){
	nd_vars=enquos(...);
	df%>%
		group_by(
			!!!nd_vars
		)%>%
		filter(
			reduce(!!!nd_vars, function(a,x)a&(n()>1), .init=TRUE)
		);
}
# Legacy alternative function using distinct and %in%
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

# Filter where NA
# ... is for the columns
filter_na=function(df, ...){
	names=map(unlist(enquos(...)), .f=function(x)quo(is.na(!!x)));
	filter(
		df, !!!names
	);
}

# Filter where not NA
# ... is for the columns
filter_not_na=function(df, ...){
	names=map(unlist(enquos(...)), .f=function(x)quo(!is.na(!!x)));
	filter(
		df, !!!names
	);
}

# Filter when it detects the string
# Use <Column to Test>=<Value to Detect>
# .op defults to `&`
where=function(df, ..., .negate=FALSE, .op=NULL){
	names=quos(..., .named=TRUE);
	if(.negate){
		names=map2(
			names,
			names%>%names()%>%syms(),
			.f=function(val, name)quo(!str_detect(!!name,!!val))
		);
	}
	else{
		names=map2(
			names,
			names%>%names()%>%syms(),
			.f=function(val, name)quo(str_detect(!!name,!!val))
		);
	}
	if(is.null(.op)){
		names=unlist(names, use.names=FALSE);
		filter(df, !!!names);
	}
	else{
		filter(
			df,
			reduce(
				list(!!!names),
				.f=.op
			)
		)
	}
}

# function(){
# 	lv=.init;
# 	print(names);
# 	for(i in names){
# 		.op(!!i, lv);
# 	}
# 	return(lv);
# }

# reduce(
# 	names,
# 	.f=function(acc, cur){
# 		print(cur);
# 		.op(acc, !!cur); # Why does this not work!?
# 	},
# 	.init=.init
# )

################################################################################
#																		Sets
################################################################################

# Count if matching a string
count_when=function(vector, value){
	reduce(
		vector,
		.f=function(accumulaton, current){
			accumulaton+if_else(
				is.na(current),
				0L,
				as.integer(str_detect(current,value))
			)
		},
		.init=0L
	)
}

# Count only rows that match the condition
count_if=function(vector, condition{
	reduce(
		vector,
		.f=function(accumulaton, current){
			accumulaton+if_else(
				is.na(current),
				0L,
				as.integer(condition(current))
			)
		},
		.init=0L
	)
}
# Allows the use of multiple values in a dataframe
# ... is for conditions
# .group is passed to count as ...
# .wt and .sort is passed to count / tally as wt and sort (Resp)
count_ifs=function(df, ..., .group=NULL, .wt=NULL, .sort=FALSE){
	vars=quos(...);
	if(is.null(.wt)){
		if(is.null(.group)){
			(
				tally(
					filter(df, !!!vars),
					sort=.sort
				)
			)$n;
		}
		else{
			.group=enquos(.group);
			(
				count(
					filter(df, !!!vars),
					!!!.group,
					sort=.sort
				)
			)$n;
		}
	}
	else{
		if(is.null(.group)){
			(
				tally(
					filter(df, !!!vars),
					wt=.wt,
					sort=.sort
				)
			)$n;
		}
		else{
			.group=enquos(.group);
			(
				count(
					filter(df, !!!vars),
					!!!.group,
					wt=.wt,
					sort=.sort
				)
			)$n;
		}
	}
}


# length=length(df[[1]]);
# row=1;
# while(row<=length){
#
# 	row=row+1;
# }

# auto union, slices the tables down to match to union
auto_union=function(x,y){
	names=syms(
		intersect(
			names(x),
			names(y)
		)
	);
	names=map(names, function(x)enquo(x));
	union(
		select(x, !!!names),
		select(y, !!!names)
	)
}
# Automatic set difference
auto_setdiff=function(x,y){
	names=syms(
		intersect(
			names(x),
			names(y)
		)
	);
	names=map(names, function(x)enquo(x));
	setdiff(
		select(x, !!!names),
		select(y, !!!names)
	)
}

symdiff=function(A, B, ...){
	setdiff(
		union(
			A, B, ...
		),
		intersect(
			A, B, ...
		)
	);
}

################################################################################
# 													Visulization functions
################################################################################
# See the nth chunk of 20 rows
chunk=function(df,index=1, start=1, end=20){
	slice(df,(start:end)+end*index)
}

# See the nth chunk of 10 rows
see=function(df,index=1, start=1, end=10){
	slice(df,(start:end)+end*index)
}


# See the n1st to n2ed chunk of 20 rows
chunks=function(df,first=1, last=3, start=1, end=20){
	i=first;
	while(i<=last){
		i=i+1;
		print(chunk(df, i, start=start, end=end));
	}
}

# Pan over, freese columns with frozen (Keep them to the left)
panH=function(df, index=2, start=1, end=8, frozen=NULL){
	frozen=enquos(frozen);
	arr=Filter(function(x)x<length(df),(start:end)+end*(index-1));
	select(df, !!!frozen, arr);
}

# Pan over, freese columns with frozen (Keep them to the left)
pan=function(df, index=2, start=1, end=12, frozen=NULL){
	frozen=enquos(frozen);
	arr=Filter(function(x)x<length(df),(start:end)+end*(index-1));
	select(df,!!!frozen, arr);
}

# Quick function to view the contents
v=function(.){
	View(.)
}

