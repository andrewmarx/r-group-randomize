# Example data. Assuming 3 groups of 96 (e.g., 3 96-well pcr plates).
spots <- 3*96
sample_count <- 220

# Won't be enough to fill all 3 groups, which is fine.
data1 <- data.frame(id = 1:sample_count,
                    sex = sample(c("M", "F"), sample_count, replace = TRUE),
                    location = sample(c("site-a", "site-b", "site-c", "site-d", "site-e", "site-f"), sample_count, replace = TRUE),
                    weight = rnorm(sample_count, 50, 10))

write.csv(data1, "data/data-1.csv", row.names = FALSE)


# Let's use some of the extra space for replicates and blanks.
# Let's do 9 replicates (3 per plate) and 12 blanks (4 per plate)
rep_count <- 9
rep_data <- data.frame(id = paste("REP", 1:rep_count, sep = "-"),
                       sex = NA,
                       location = rep("replicate", rep_count),
                       weight = NA)

blank_count <- 12
blank_data <- data.frame(id = paste("BLANK", 1:blank_count, sep = "-"),
                         sex = NA,
                         location = rep("blank", blank_count),
                         weight = NA)

data2 <- rbind(data1, rep_data, blank_data)
write.csv(data2, "data/data-2.csv", row.names = FALSE)


# We still have a bunch of unused space in the groups. The map script fills out the groups
# from the top, leaving unused spots at the bottom. If we want to make use of that extra space,
# we just need to fill out rows in the data so that the number of rows is equal to the number
# of wells. Here, I just fill it out with "EXTRA", but we could allocate more replicates or blanks
# to fill it out if we wanted.
extra_count <- spots - nrow(data2)

extra_data <- data.frame(id = paste("EXTRA", 1:extra_count, sep = "-"),
                         sex = NA,
                         location = rep("extra", extra_count),
                         weight = NA)

data3 <- rbind(data2, extra_data)
write.csv(data3, "data/data-3.csv", row.names = FALSE)
