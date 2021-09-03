# Copyright 2021 Andrew J Marx. All rights reservered.
# Licensed under the MIT License. See LICENSE file in the project root for details.

library(dplyr)
library(tidyr)

# Data import
items <- read.csv("data/data-1.csv", stringsAsFactors = FALSE)


#
#
# Part 1: assigning items randomly to groups
#
#

# Vectors containing info about the groups. It doesn't need to be a numeric vector;
# it can be a vector of character names. E.g., could be c("plate 1", "plate 2", ...)
group_names <- 1:4

# If the items you want split across groups have attributes that you would also
# like to have evenly distributed across the groups, you can specifify those attribute
# columns in the group_by(). If you want to limit how many items you keep for each
# combination of attributes, just replace `Inf` with the limit you want to set.
groups <- items %>% group_by(location, sex) %>% sample_n(min(Inf, n())) %>% ungroup() #Shuffle the items, keeping attributes together

groups <- groups %>% mutate(group = rep(group_names, length.out = n())) # Assign a group name to each item

write.csv(groups, file = "output/groups-1.csv", row.names = FALSE) # Save


#
#
# Part 2: Randomization of items within groups
#
#

# We can arrange our items randomly in grid. This is useful for something like
# assigning samples to a PCR plate for DNA extractions. If you don't care about
# a 2D grid, but still want to randomize the order of the items within groups,
# just set the row_names or column names to a single value. The vectors for
# row_names and col_names do not have to be numbers; they can be character name vectors.
row_names <- LETTERS[1:8]
col_names <- 1:12

# Shuffle the items within the groups. Then assign them row and column names.
groups <- groups %>% group_by(group) %>% sample_n(n()) %>%
  # Assign column and row numbers to the samples
  mutate(col = rep(col_names, length.out = n())) %>%
  mutate(row = rep(row_names, each = length(col_names), length.out = n())) %>% 
  ungroup()

# Since we restricted how many rows/cols there can be within a group, we need to
# make sure we actually have enough space for all of our items.If any group/col/row
# combinations show up twice, it means there weren't spots available for some items.
counts <- groups %>%  group_by(group, col, row) %>% summarise(count = n())
if (any(counts$count > 1)) print("You do not have enough groups for all of your items. Either increase the number of groups, the number of cols/rows per group, or reduce the number of items.")

# Save out the group assignments
write.csv(groups, file = "output/groups_within-1.csv", row.names = FALSE)


#
#
# Part 3: Making an assignment map
#
#

# The values_from parameter determines what is shown in your map cells, makes sure to change it for your data
maps <- pivot_wider(groups, id_cols = c(group, row) , names_from = col, values_from = id)

# Got a warning about "values not uniquely identified"? Then you didn't have enough plates for all your items

# Save out the group maps
write.csv(maps, file = "output/group_maps-1.csv", row.names = FALSE)
