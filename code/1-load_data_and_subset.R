library(readr)
library(dplyr)
library(tidyr)

# Loads in full Mercari Price Prediction Dataset
mdf <- read_tsv("./data/train.tsv")
mdf$item_condition_id <- as.ordered(mdf$item_condition_id)
mdf <- separate(mdf, category_name, into= c("C1","C2","C3","C4","C5","C6"), sep="/")

#Now, we want to mark all non-branded items as 'Generic(NoBrand)'
mdf$brand_name[is.na(mdf$brand_name)] <- "Generic(NoBrand)"

#drop the category columns that aren't often used
mdf <- select(mdf, -C4, -C5, -C6)
mdf$C1 <- as.factor(mdf$C1)
mdf$C2 <- as.factor(mdf$C2)
mdf$C3 <- as.factor(mdf$C3)
mdf$brand_name <- as.factor(mdf$brand_name)
mdf$shipping <- as.factor(mdf$shipping)

#Now, we want to drop all rows for which there are NA values remaining
mdf <- na.omit(mdf)

#Also, we don't really care what the names / train_ids of the products are 
#(perhaps there's information here that we're losing -- to look at later)
mdf <- select(mdf, -train_id, -name)


# # Produces random subset of dataset with n datapoints
# n <- 100
# set.seed(1234) # For reproducibility
# ss_indices <- sample(1:nrow(mdf), n)
# mdf_ss <- mdf[ss_indices,]


