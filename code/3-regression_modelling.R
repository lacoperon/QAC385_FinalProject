library(caret)
library(ggplot2)
library(ranger)


pp <- c("center", "scale", "nzv")
# Logistic Regression

set.seed(1234)
n <- 60000
rand_train <- mdf_train[sample(1:nrow(mdf_train), n, replace=FALSE),]

model.glm <- train(price ~ .,
                   data = rand_train,
                   method = "glm",
                   preProcess = pp
)

yhat.glm <- predict(model.glm, newdata=mdf_test)
rmse.glm <- sqrt(mean((yhat.glm - mdf_test$price)^2))
rsq.glm  <- cor(yhat.glm, mdf_test$price)^2


# Training a random forest model

set.seed(1234)
n <- 10000
rand_train <- mdf_train[sample(1:nrow(mdf_train), n, replace=FALSE),]
control <- trainControl(method="repeatedcv", number=4, repeats=2)

set.seed(1234)
rand_train <- select(rand_train, -C2)
model.rf <- train(price ~ .,
                  data = rand_train,
                  method = "rf",
                  preProcess = pp,
                  control = control)

yhat.rf <- predict(model.rf, newdata=mdf_test)
rmse.rf <- sqrt(mean((yhat.rf - mdf_test$price)^2))
rsq.rf  <- cor(yhat.rf, mdf_test$price)^2

## Training using naive bayes
library(e1071)
library(tm)
n <- 6000
rand_train.nb <- text_train[sample(1:nrow(text_train), n, replace=FALSE),]
sms_corpus <- Corpus(VectorSource(rand_train.nb$item_description))


# clean up the corpus using tm_map()
corpus_clean <- tm_map(sms_corpus, tolower)
corpus_clean <- tm_map(corpus_clean, removeNumbers)
corpus_clean <- tm_map(corpus_clean, removeWords, stopwords())
corpus_clean <- tm_map(corpus_clean, removePunctuation)
corpus_clean <- tm_map(corpus_clean, stripWhitespace)

rand_test.nb <- text_test[sample(1:nrow(text_test), n, replace=FALSE),]
sms_corpus_test <- Corpus(VectorSource(rand_test.nb$item_description))

corpus_clean_test <- tm_map(sms_corpus_test, tolower)
corpus_clean_test <- tm_map(corpus_clean_test, removeNumbers)
corpus_clean_test <- tm_map(corpus_clean_test, removeWords, stopwords())
corpus_clean_test <- tm_map(corpus_clean_test, removePunctuation)
corpus_clean_test <- tm_map(corpus_clean_test, stripWhitespace)

library(SnowballC)
corpus_clean <- tm_map(corpus_clean, stemDocument)
corpus_clean_test <- tm_map(corpus_clean_test, stemDocument)

desc_dtm <- DocumentTermMatrix(corpus_clean)
desc_dtm_test <- DocumentTermMatrix(corpus_clean_test)

sms_dtm_train <- desc_dtm
sms_dtm_test  <- desc_dtm_test


sms_train_labels <- rand_train.nb$price
sms_test_labels  <- rand_test.nb$price

sms_freq_words <- findFreqTerms(sms_dtm_train, 5)
head(sms_freq_words, 20)

sms_dtm_freq_train <- sms_dtm_train[, sms_freq_words]
sms_dtm_freq_test  <- sms_dtm_test[, sms_freq_words]

# convert counts to a factor
convert_counts <- function(x) {
  x <- ifelse(x > 0, 1, 0)
  x <- factor(x, levels = c(0, 1), labels = c("No", "Yes"))
}

# apply() convert_counts() to columns of train/test data
sms_train <- apply(sms_dtm_freq_train, 2, convert_counts)
sms_test  <- apply(sms_dtm_freq_test,  2, convert_counts)

library(e1071)
sms_classifier <- naiveBayes(sms_train, sms_train_labels > 100, laplace=1)
sms_classifier

sms_test_pred <- predict(sms_classifier, sms_test)
rand_test.nb$nb_pred <- sms_test_pred

model.glm <- train(price ~ .,
                   data = rand_train,
                   method = "glm",
                   preProcess = pp
)

# Lasso training data

set.seed(1234)
n <- 400000 #marginal return on code running after this point
rand_train <- mdf_train[sample(1:nrow(mdf_train), n, replace=FALSE),]
control <- trainControl(method="repeatedcv", number=4, repeats=2)

x <- model.matrix(price ~ ., rand_train)[,-1] # gets rid of the intercept column
# dependent variable
y <- rand_train$price

# specify the lamba values to investigate
grid <- 10^seq(8, -4, length=250)

library(glmnet)
model.lasso <- glmnet(x, y, alpha=1, lambda=grid)
plot(model.lasso, xvar="lambda", main="Lasso")


# 10-fold cross validation of lambda values on MSE
set.seed(1234)
cv.lambda <- cv.glmnet(x, y, lambda=grid, alpha=1)
plot(cv.lambda)
bestlam <- cv.lambda$lambda.min
bestlam

coef(model.lasso, s=bestlam)

x <- model.matrix(price ~ ., mdf_test)[,-1]
lasso.pred <- predict(model.lasso, s=bestlam, newx=x)
rmse.lasso <- sqrt(mean((lasso.pred - mdf_test$price)^2))

rmse.lasso <- sqrt(mean((lasso.pred - mdf_test$price)^2))
rsq.lasso  <- cor(lasso.pred, mdf_test$price)^2


# Attempt at XGB Boosting

set.seed(1234)
n <- 400000 #marginal return on code running after this point

library(xgboost)

model.xgboost <- xgboost(data = rand_tr) 




