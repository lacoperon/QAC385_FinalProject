library(caret)
library(dplyr)

# Splits dataset into test + training data
index <- createDataPartition(mdf$price, p=0.7, list=FALSE)
mdf_train <- mdf[index,]
text_train <- select(mdf_train, item_description, price)
mdf_train <- select(mdf_train, -item_description)
mdf_test  <- mdf[-index,]
text_test <- select(mdf_test, item_description, price)
mdf_test <- select(mdf_test, -item_description)


