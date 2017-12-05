library(caret)
library(ggplot2)
library(ranger)


pp <- c("center", "scale", "nzv")
# Logistic Regression

set.seed(1234)
n <- 100000
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

library(SnowballC)
corpus_clean <- tm_map(corpus_clean, stemDocument)

rand_train.nb[1,]
inspect(corpus_clean[1])

sms_dtm <- DocumentTermMatrix(corpus_clean)

sms_dtm_train <- sms_dtm[1:4169, ]
sms_dtm_test  <- sms_dtm[4170:5559, ]


sms_train_labels <- text_train$price[1:4169]
sms_test_labels  <- text_train$price[4170:5559]

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
sms_classifier <- naiveBayes(sms_train, sms_train_labels)
sms_classifier

sms_test_pred <- predict(sms_classifier, sms_test)

yhat.nb <- predict(sms_classifier, newdata=sms_test)
rmse.nb <- sqrt(mean((yhat.nb - sms_test_labels)^2))
rsq.nb  <- cor(yhat.nb, sms_test$price)^2

