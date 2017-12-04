library(readr)

# Loads in full Mercari Price Prediction Dataset
mdf <- read_tsv("./data/train.tsv")

# Produces random subset of dataset with n datapoints
n <- 10000
set.seed(1234) # For reproducibility
ss_indices <- sample(1:nrow(mdf), n)
mdf_ss <- mdf[ss_indices,]
