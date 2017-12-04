library(caret)
library(dplyr)

# Splits dataset into test + training data
index <- createDataPartition(mdf$price, p=0.7, list=FALSE)
mdf_train <- mdf[index,]
mdf_test  <- mdf[-index,]

