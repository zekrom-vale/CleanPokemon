flag=FALSE; # Do you want to open the files?
library(magrittr);
library(tidyverse);
library(reshape2);
library(class);
# Utility I made to make things simple
devtools::install_github("zekrom-vale/zUtil.R");
library(zUtil);


# open with file.edit()
# Core DB
if(flag)file.edit("core/clean.R");
source("core/clean.R");
if(flag)file.edit("core/manageAlts.R");
source("core/manageAlts.R", encoding="UTF-8");
if(flag)file.edit("core/merge.R");
source("core/merge.R");
if(flag)file.edit("core/merge2.R");
source("core/merge2.R", encoding="UTF-8");
if(flag)file.edit("core/condense.R");
source("core/condense.R", encoding="UTF-8");
if(flag)file.edit("core/separate.R");
source("core/separate.R");

# Lang DB
if(flag)file.edit("lang/clean.R");
source("lang/clean.R");

# Abilities
if(flag)file.edit("ability/cleanAbility.R");
source("ability/cleanAbility.R", encoding="UTF-8");

# Items
if(flag)file.edit("items/cleanItems.R");
source("items/cleanItems.R", encoding="UTF-8");

# Evolution
if(flag)file.edit("evolution/clean.R");
source("evolution/clean.R", encoding="UTF-8"); # Must use \u2192 and not

# IV and Base
if(flag)file.edit("IV/clean.R");
source("IV/clean.R", encoding="UTF-8");

file.edit("annalise.R");
