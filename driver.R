library(magrittr);
library(tidyverse);
library(reshape2);
# Utility
library(zUtil);

# Core DB
source("core/clean.R");
source("core/manageAlts.R", encoding="UTF-8");
source("core/merge.R");
source("core/merge2.R", encoding="UTF-8"); # Removes Alolans
source("core/condense.R", encoding="UTF-8");
source("core/separate.R");

# Lang DB
source("lang/clean.R");

# Abilities
source("ability/cleanAbility.R", encoding="UTF-8");

# Items
source("items/cleanItems.R", encoding="UTF-8");

# Evolution
source("evolution/clean.R", encoding="UTF-8"); # Must use \u2192 and not →

# IV and Base
source("IV/clean.R", encoding="UTF-8");