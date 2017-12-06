library(caret)
library(dplyr)

# Splits dataset into test + training data
index <- createDataPartition(mdf$price, p=0.7, list=FALSE)
# 
mdf$condit <- grepl("condit", tolower(mdf$item_description), fixed=TRUE)
mdf$new  <- grepl("new",  tolower(mdf$item_description), fixed=TRUE)
mdf$used <- grepl("used", tolower(mdf$item_description), fixed=TRUE)
mdf$authen <- grepl("authen", tolower(mdf$item_description), fixed=TRUE)
mdf$origin <- grepl("origin", tolower(mdf$item_description), fixed=TRUE)
mdf$great <- grepl("great", tolower(mdf$item_description), fixed=TRUE)
mdf$item <- grepl("item", tolower(mdf$item_description), fixed=TRUE)
mdf$color <- grepl("color", tolower(mdf$item_description), fixed=TRUE)
mdf$size  <- grepl("size", tolower(mdf$item_description), fixed=TRUE)
mdf$pleas <- grepl("pleas", tolower(mdf$item_description), fixed=TRUE)
mdf$bundl <- grepl("bundl", tolower(mdf$item_description), fixed=TRUE)
mdf$one <- grepl("one", tolower(mdf$item_description), fixed=TRUE)
mdf$ship <- grepl("ship", tolower(mdf$item_description), fixed=TRUE)
mdf$never <- grepl("never", tolower(mdf$item_description), fixed=TRUE)
mdf$will <- grepl("will", tolower(mdf$item_description), fixed=TRUE)
mdf$includ <- grepl("includ", tolower(mdf$item_description), fixed=TRUE)
mdf$box <- grepl("box", tolower(mdf$item_description), fixed=TRUE)
mdf$bag <- grepl("bag", tolower(mdf$item_description), fixed=TRUE)
mdf$brand <- grepl("brand", tolower(mdf$item_description), fixed=TRUE)
mdf$price <- grepl("price", tolower(mdf$item_description), fixed=TRUE)


mdf_train <- mdf[index,]
text_train <- mdf_train
mdf_train <- select(mdf_train, -item_description, -name)
mdf_test  <- mdf[-index,]
text_test <- mdf_test
mdf_test <- select(mdf_test, -item_description, -name)




library(tm)
mdf_rich <- filter(mdf, price > 100)
mdf_poor <- filter(mdf, price < 10)
sms_corpus <- Corpus(VectorSource(mdf_rich$item_description))
# clean up the corpus using tm_map()
corpus_clean <- tm_map(sms_corpus, tolower)
corpus_clean <- tm_map(corpus_clean, removeNumbers)
corpus_clean <- tm_map(corpus_clean, removeWords, stopwords())
corpus_clean <- tm_map(corpus_clean, removePunctuation)
corpus_clean <- tm_map(corpus_clean, stripWhitespace)
corpus_clean <- tm_map(corpus_clean, stemDocument)


sms_corpus_poor <- Corpus(VectorSource(mdf_poor$item_description))
# clean up the corpus using tm_map()
corpus_clean_poor <- tm_map(sms_corpus_poor, tolower)
corpus_clean_poor <- tm_map(corpus_clean_poor, removeNumbers)
corpus_clean_poor <- tm_map(corpus_clean_poor, removeWords, stopwords())
corpus_clean_poor <- tm_map(corpus_clean_poor, removePunctuation)
corpus_clean_poor <- tm_map(corpus_clean_poor, stripWhitespace)
corpus_clean_poor <- tm_map(corpus_clean_poor, stemDocument)

desc_dtm <- DocumentTermMatrix(corpus_clean)
desc_dtm_poor <- DocumentTermMatrix(corpus_clean_poor)
sms_dtm_train <- desc_dtm

rich_freq_words <- findFreqTerms(desc_dtm, 5000)
poor_freq_words <- findFreqTerms(desc_dtm_poor, 25000)
