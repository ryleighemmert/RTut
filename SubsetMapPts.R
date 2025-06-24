
# very quick and short Tut for subsetting data (has many applications)
# set your wd if necessary - this helps R know where the file is that you're referencing
setwd("~/Documents/R Code/Tutorials")

library(dplyr)

# read your dataset (CSV format works better for what we're doing today)
data <- read.csv("fellows_Location.csv")

# woaaaa there. there's a crap ton of sites in the file. let's subset the data! 

# subset to only include the sites that you need...in our case, we'll use the specific site name 
# use the column name to tell R where to yoink that data from (here, the column is ID)

data %>% filter(ID == "UPLSHBC")
data %>% filter(ID == "CAMD45OF0000")

fellows_MAP <- data %>%
  filter(ID %in% c("UPLSHBC", "CAMD45OF0000"))

# write the subset to a new CSV that we can upload to Google MyMaps
write.csv(fellows_MAP, "fellows_MAP.csv", row.names = FALSE)

# check her out
head(fellows_MAP)

