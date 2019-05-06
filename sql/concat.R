# Concats files based on driver.txt
library(readr);

# Read driver as a csv (tsv would be fine too)
# Use R # as comment
files=read_csv("sql/driver.txt", col_names="File", comment="#")$File;

# Clear the file
write_file("", "sql/long.sql"); # Write nothing to the file
# For all strings in files
for(file in files){
	# Read the contents of sql/<file>
	text=read_file(paste0("sql/",file));
	# Use technique to do nothing on capture 1 to prevent modification
	# This is the only way I know how to do this, without a long workaround
	text%<>%
		gsub(
			"(--[^\n]*\n|'.*?'|q'(.).*?\\2')|[ \t]*([,\\(\\)\\|])[ \t]*",
			"\\1\\3",
			.,
			perl=TRUE # Non-perl is odd, .*? does not behave
		);
	write_file(# Append the folowing to sql/long.sql
		text,
		"sql/long.sql",
		append=TRUE # Don't overite the file, append it
	);
	write_file("\n","sql/long.sql", append=TRUE);# add a return to separate files
}