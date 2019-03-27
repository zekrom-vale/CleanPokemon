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
source("clean.R");
source("manageAlts.R", encoding="UTF-8");
source("merge.R"); #NS
source("merge2.R");
source("condense.R")

# Subtables
source("cleanAbility.R");