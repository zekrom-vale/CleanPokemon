##################################################################################
#
# 																	WARNING
#
##################################################################################
#
# 										Not all files will source correctly
#
##################################################################################

library(magrittr);
library(tidyverse);
# Utility
source("util.R");

# Core DB
source("clean.R"); # NS
source("manageAlts.R", encoding="UTF-8"); # NS
source("merge.R");
source("merge2.R");
source("condense.R")

# Subtables
source("cleanAbility.R");