# Concats files based on driver.txt
library(readr);

# Read driver as a csv (tsv would be fine too)
# Use R # as comment
files=read_csv("sql/driver.txt", col_names="File", comment="#")$File;

# Clear the file
write_file("", "sql/long.sql"); # Write nothing to the file
# For all strings in files
for(file in files){
	write_file(# Append the folowing to sql/long.sql
		read_file(paste0("sql/",file)), # Read the contents of sql/<file>
		"sql/long.sql",
		append=TRUE # Don't overite the file, append it
	);
	write_file("\n","sql/long.sql", append=TRUE);# add a return to separate files
}