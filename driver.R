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
source("core/clean.R");
source("core/manageAlts.R", encoding="UTF-8");
source("core/merge.R"); #NS
source("core/merge2.R");
source("core/condense.R");
write_csv(agg,path="core/agg.csv",na="");

# Abilities
source("ability/cleanAbility.R", encoding="UTF-8");
