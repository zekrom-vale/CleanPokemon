# See how at https://dplyr.tidyverse.org/articles/programming.html
require(dplyr);
# This function returns thae values that are not distinct
not_distinct=function(df, col, ...){
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