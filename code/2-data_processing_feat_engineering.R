library(caret)
library(dplyr)

# Splits dataset into test + training data
index <- createDataPartition(mdf$price, p=0.7, list=FALSE)

mdf$louis <- grepl("louis", tolower(mdf$item_description), fixed=TRUE)
mdf$gold  <- grepl("gold",  tolower(mdf$item_description), fixed=TRUE)
mdf$excel <- grepl("excel", tolower(mdf$item_description), fixed=TRUE)
mdf$authen <- grepl("authen", tolower(mdf$item_description), fixed=TRUE)
mdf$origin <- grepl("origin", tolower(mdf$item_description), fixed=TRUE)


mdf_train <- mdf[index,]
text_train <- mdf_train
mdf_train <- select(mdf_train, -item_description, -name)
mdf_test  <- mdf[-index,]
text_test <- mdf_test
mdf_test <- select(mdf_test, -item_description, -name)





mdf_rich <- filter(mdf, price > 700)
sms_corpus <- Corpus(VectorSource(mdf_rich$item_description))
# clean up the corpus using tm_map()
corpus_clean <- tm_map(sms_corpus, tolower)
corpus_clean <- tm_map(corpus_clean, removeNumbers)
corpus_clean <- tm_map(corpus_clean, removeWords, stopwords())
corpus_clean <- tm_map(corpus_clean, removePunctuation)
corpus_clean <- tm_map(corpus_clean, stripWhitespace)
corpus_clean <- tm_map(corpus_clean, stemDocument)

desc_dtm <- DocumentTermMatrix(corpus_clean)
sms_dtm_train <- desc_dtm
sms_train_labels <- mdf_rich$price
sms_freq_words <- findFreqTerms(sms_dtm_train, 50)
