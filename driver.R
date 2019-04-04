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
library(reshape2);
# Utility
library(zUtil);

# Core DB
source("core/clean.R");
source("core/manageAlts.R", encoding="UTF-8");
source("core/merge.R"); #NS
source("core/merge2.R"); #NS
source("core/condense.R"); #NS (Incorect)

# Lang DB
source("lang/clean.R");

# Abilities
source("ability/cleanAbility.R", encoding="UTF-8");

# Items
source("items/cleanItems.R", encoding="UTF-8");

# Evolution
source("evolution/clean.R", encoding="UTF-8");

# IV and Base
source("IV/clean.R", encoding="UTF-8");