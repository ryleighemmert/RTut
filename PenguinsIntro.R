---
title: "MyWRA_Intro"
author: "Ry Emmert"
date: "2025-06-23"
output: html_document
---
  
  # welcome to our lovely little tutorial. led by yours truly, Ry
  # we'll cover: uploading data into R, making basic graphs, and how to transform tables from long to wide and back
  # Step 1. you'll need to ensure that you have the appropriate R packages installed
  # for this tutorial, let's use: tidyverse and palmerpenguins
  install.packages("tidyverse") 
# for data wrangling and plotting
install.packages("palmerpenguins")
# for our practice dataset about penguins 
# run these. to do so, highlight the chunk of code and press command + return simultaneously
# load them packages!
library(tidyverse)
library(palmerpenguins)

# Step 2. upload penguin data! 
# this data is already installed, but I'll demonstrate how we can upload our own data later on.
data(penguins)
# let's check it out
head(penguins) 
# shows us the first few rows
glimpse(penguins) # overview of the column types + structure 
# Step 3. let's plot a basic graph
# here, we have some data about the penguins' bill characteristics
# let's make a scatterplot comparing bill length to bill depth
ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point() +
  labs(title = "Bill Length vs. Bill Depth", x = "Bill Length (mm)", y = "Bill Depth (mm)")
# let's make a bar plot of species counts
ggplot(penguins, aes(x = species)) +
  geom_bar(fill = "skyblue") +
  labs(title = "Penguin Species Counts", x = "Species", y = "Count")
# let's make a box plot of body mass by species
ggplot(penguins, aes(x = species, y = body_mass_g, fill = species)) +
  geom_boxplot() +
  labs(title = "Body Mass by Species", y = "Body Mass (g)")
# Step 4. do we like the shape of our data, however? is it actually useful for us? if not, let's pivot!
# let's try to go from long to wide, and then back to long
# first, we'll make a smaller version of our dataset
small_penguins <- penguins %>%
  select(species, island, sex, body_mass_g) %>%
  filter(!is.na(sex))  # remove NAs for reshaping
head(small_penguins) # let's check that our efforts weren't futile
# we're in LONG format here. each row is an observation, meaning: each observation gets its own row, and different categories (ex. 'sex' or 'year')
# are stored in only 1 column
# why use LONG? it's easier for grouping, filtering, and plotting in ggplot
# it's also best for statistical modeling
# let's change it to WIDE format, using sex for our columns. in WIDE format, each category becomes a column, and a single row summarizes multiple pieces of information ABOUT an observation
# why use WIDE? for reporting and tables
# more helpful for comparing values side-by-side 
wide_penguins <- small_penguins %>%
  pivot_wider(names_from = sex, values_from = body_mass_g,
              values_fn = mean)  # Take average if multiple values
print(wide_penguins) # check it out
# now go back to LONG format
long_penguins <- wide_penguins %>%
  pivot_longer(cols = c(female, male), names_to = "sex", values_to = "body_mass_g")
print(long_penguins)
# Step 5. save your work ----
# save your reshaped table to a CSV file
write_csv(wide_penguins, "wide_penguins.csv")
# Step 6. read her in!
data <- read_csv("wide_penguins.csv")
# slay. we are all done now
# thanks besties 

