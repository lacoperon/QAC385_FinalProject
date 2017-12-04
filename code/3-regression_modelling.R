library(caret)
library(ggplot2)


pp <- c("center", "scale", "nzv")
# Logistic Regression

set.seed(1234)
n <- 500
rand_train <- mdf_train[sample(1:nrow(mdf_train), n, replace=FALSE),]
  
model.glm <- train(price ~ .,
                   data = rand_train,
                   method = "glm",
                   preProcess = pp
                   )
