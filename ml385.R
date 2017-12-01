# Install necessary packages
library(httr)
library(dplyr)
library(jsonlite)

## Staging
## my_url <- "http://api.walmartlabs.com/v1/items/52129514?format=json&apiKey=4v8v4rm827cdkeze2ekd6zgf"
## out <- GET(url = my_url)
## http_status(out)
## data <- content(out)


multi_url <- c("http://api.walmartlabs.com/v1/items?ids=52129514,51755641,53753317,44465721,51306158,51306158,54827145,53150951,150807922,53126987,54827148&format=json&apiKey=4v8v4rm827cdkeze2ekd6zgf")

df_list <- read_json(multi_url)
df_list <- df_list$items

## Traverse each list to determine the list length. 
lapply(df_list, FUN = length)

## What are the columns we need to prepare ?
names(df_list[[1]])

require(plyr)
kk <- plyr:: rbind.fill(lapply(df_list, function(y){as.data.frame(t(y),stringsAsFactors=FALSE)}))


df_total = data.frame(itemId= character(0), 
                      name= character(0), 
                      msrp = character(0),
                      salePrice = character(0),
                      upc = character(0),
                      categoryPath = character(0),
                      shortDescription = character(0),
                      longDescription= character(0), 
                      brandName= character(0), 
                      thumbnailImage = character(0),
                      mediumImage = character(0),
                      largeImage = character(0),
                      productTrackingUrl = character(0),
                      ninetySevenCentShipping = character(0),
                      standardShipRate= character(0), 
                      size= character(0), 
                      color = character(0),
                      marketplace = character(0),
                      shipToStore = character(0),
                      freeShipToStore = character(0),
                      modelNumber = character(0),
                      productUrl= character(0), 
                      customerRating= character(0), 
                      numReviews = character(0),
                      variants = character(0),
                      customerRatingImage = character(0),
                      categoryNode = character(0),
                      bundle = character(0),
                      clearance= character(0), 
                      preOrder= character(0), 
                      stock = character(0),
                      attributes = character(0),
                      addToCartUrl = character(0),
                      affiliateAddToCartUrl = character(0),
                      freeShippingOver50Dollars = character(0),
                      maxItemsInOrder = character(0),
                      giftOptions = character(0),
                      imageEntities = character(0),
                      offerType = character(0),
                      isTwoDayShippingEligible = character(0), 
                      availableOnline= character(0))


df_list

for (i in 1:length(df_list)){
  multi_url <- c("http://api.walmartlabs.com/v1/items?ids=52129514,51755641,53753317,44465721,51306158,51306158,54827145,53150951,150807922,53126987,54827148&format=json&apiKey=4v8v4rm827cdkeze2ekd6zgf")
  df_list2 <- read_json(multi_url)
  info1 = ifelse(is.null(df_list2$itemId) == TRUE, NA, df_list2$itemId)
  info2 = ifelse(is.null(df_list2$name) == TRUE, NA, df_list2$name)
  info3 = ifelse(is.null(df_list2$msrp) == TRUE, NA, df_list2$msrp)
  info4 = ifelse(is.null(df_list2$salePrice) == TRUE, NA, df_list2$salePrice)
  info5 = ifelse(is.null(df_list2$upc) == TRUE, NA, df_list2$upc)
  info6 = ifelse(is.null(df_list2$categoryPath) == TRUE, NA, df_list2$categoryPath)
  info7 = ifelse(is.null(df_list2$shortDescription) == TRUE, NA, df_list2$shortDescription)
  info8 = ifelse(is.null(df_list2$longDescription) == TRUE, NA, df_list2$longDescription)
  info9 = ifelse(is.null(df_list2$brandName) == TRUE, NA, df_list2$brandName)
  info10 = ifelse(is.null(df_list2$thumbnailImage) == TRUE, NA, df_list2$thumbnailImage)
  info11 = ifelse(is.null(df_list2$mediumImage) == TRUE, NA, df_list2$mediumImage)
  info12 = ifelse(is.null(df_list2$largeImage) == TRUE, NA, df_list2$largeImage)
  info13 = ifelse(is.null(df_list2$productTrackingUrl) == TRUE, NA, df_list2$productTrackingUrl)
  info14 = ifelse(is.null(df_list2$ninetySevenCentShipping) == TRUE, NA, df_list2$ninetySevenCentShipping)
  info15 = ifelse(is.null(df_list2$standardShipRate) == TRUE, NA, df_list2$standardShipRate)
  info16 = ifelse(is.null(df_list2$size) == TRUE, NA, df_list2$size)
  info17 = ifelse(is.null(df_list2$color) == TRUE, NA, df_list2$color)
  info18 = ifelse(is.null(df_list2$marketplace) == TRUE, NA, df_list2$marketplace)
  info19 = ifelse(is.null(df_list2$shipToStore) == TRUE, NA, df_list2$shipToStore)
  info20 = ifelse(is.null(df_list2$freeShipToStore) == TRUE, NA, df_list2$freeShipToStore)
  info21 = ifelse(is.null(df_list2$modelNumber) == TRUE, NA, df_list2$modelNumber)
  info22 = ifelse(is.null(df_list2$productUrl) == TRUE, NA, df_list2$productUrl)
  info23 = ifelse(is.null(df_list2$customerRating) == TRUE, NA, df_list2$customerRating)
  info24 = ifelse(is.null(df_list2$numReviews) == TRUE, NA, df_list2$numReviews)
  info25 = ifelse(is.null(df_list2$variants) == TRUE, NA, df_list2$variants)
  info26 = ifelse(is.null(df_list2$customerRatingImage) == TRUE, NA, df_list2$customerRatingImage)
  info27 = ifelse(is.null(df_list2$categoryNode) == TRUE, NA, df_list2$categoryNode)
  info28 = ifelse(is.null(df_list2$bundle) == TRUE, NA, df_list2$bundle)
  info29 = ifelse(is.null(df_list2$clearance) == TRUE, NA, df_list2$clearance)
  info30 = ifelse(is.null(df_list2$preOrder) == TRUE, NA, df_list2$preOrder)
  info31 = ifelse(is.null(df_list2$stock) == TRUE, NA, df_list2$stock)
  info32 = ifelse(is.null(df_list2$attributes) == TRUE, NA, df_list2$attributes)
  info33 = ifelse(is.null(df_list2$addToCartUrl) == TRUE, NA, df_list2$addToCartUrl)
  info34 = ifelse(is.null(df_list2$affiliateAddToCartUrl) == TRUE, NA, df_list2$affiliateAddToCartUrl)
  info35 = ifelse(is.null(df_list2$freeShippingOver50Dollars) == TRUE, NA, df_list2$freeShippingOver50Dollars)
  info36 = ifelse(is.null(df_list2$maxItemsInOrder) == TRUE, NA, df_list2$maxItemsInOrder)
  info37 = ifelse(is.null(df_list2$giftOptions) == TRUE, NA, df_list2$giftOptions)
  info38 = ifelse(is.null(df_list2$imageEntities) == TRUE, NA, df_list2$imageEntities)
  info39 = ifelse(is.null(df_list2$offerType) == TRUE, NA, df_list2$offerType)
  info40 = ifelse(is.null(df_list2$isTwoDayShippingEligible) == TRUE, NA, df_list2$isTwoDayShippingEligible)
  info41 = ifelse(is.null(df_list2$availableOnline) == TRUE, NA, df_list2$availableOnline)
  df <- data.frame(itemId= info1, 
                   name= info2, 
                   msrp = info3,
                   salePrice = info4,
                   upc = info5,
                   categoryPath = info6,
                   shortDescription = info7,
                   longDescription= info8, 
                   brandName= info9, 
                   thumbnailImage = info10,
                   mediumImage = info11,
                   largeImage = info12,
                   productTrackingUrl = info13,
                   ninetySevenCentShipping = info14,
                   standardShipRate= info15, 
                   size= info16, 
                   color = info17,
                   marketplace = info18,
                   shipToStore = info19,
                   freeShipToStore = info20,
                   modelNumber = info21,
                   productUrl= info22, 
                   customerRating= info23, 
                   numReviews = info24,
                   variants = info25,
                   customerRatingImage = info26,
                   categoryNode = info27,
                   bundle = info28,
                   clearance= info29, 
                   preOrder= info30, 
                   stock = info31,
                   attributes = info32,
                   addToCartUrl = info33,
                   affiliateAddToCartUrl = info34,
                   freeShippingOver50Dollars = info35,
                   maxItemsInOrder = info36,
                   giftOptions = info37,
                   imageEntities = info38,
                   offerType = info39,
                   isTwoDayShippingEligible = info40, 
                   availableOnline= info41)
  df_total <- rbind(df_total, df)
}
                      

tax_url <- "http://api.walmartlabs.com/v1/taxonomy?apiKey=4v8v4rm827cdkeze2ekd6zgf&format=json"
tax_single <- read_json(tax_url)
length(tax_single$categories)

df_parent_cat = data.frame(parent= character(0))

for (j in (1:length(tax_single$categories))){
  k1 = tax_single$categories[[j]]$id
  k2 = tax_single$categories[[j]]$name
  k3 = tax_single$categories[[j]]$path
  df <- data.frame(parent = k1,
                   name = k2,
                   path = k3)
  df_parent_cat <- rbind(df_parent_cat, df)
}

# or
for (j in (1:length(tax_single$categories))){
  print(tax_single$categories[[j]]$id)
}

tax_single$categories[[6]]$name
tax_single$categories[[2]]$path



my_url <- "http://api.walmartlabs.com/v1/search?query=e&format=json&categoryId=1334134&apiKey=mzefpbuesxtcsze7cszmyze8&numItems=25"
df_list <- read_json(my_url)


kkstaging <- data.frame(lat = c(1.234, 2.456, 3.456), lon = c(5.678, 6.789, 7.890))

for (i in 1:length(Coords$lat)){
  lat = Coords$lat[i]
  lon = Coords$lon[i] 
  url <- paste('https://maps.googleapis.com/maps/api/place/textsearch/json?query=123+main+street&location=',
               lat, ',', lon, '&radius=10000&key=YOUR_API_KEY', sep = "")
  print(url)
}


df_list <- df_list$items

out <- GET(url = my_url)
http_status(out)
data <- content(out)
