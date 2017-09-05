library(caret)
library(randomForest)
library(RCurl)
set.seed(321)

url.train <- getURL("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv")
url.test <- getURL("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv")

data.train <- read.csv(text = url.train)
data.test <- read.csv(text = url.train)

str(data.train)
## there lots of NAs and blanks

## determine the variables that has over 50% NAs and remove it
naColumns <- colSums(is.na(data.train) | data.train =="" | data.train == "#DIV/0!")/nrow(data.train)
naColumns <- ifelse(naColumns > 0.5, FALSE, TRUE)

data.train <- data.train[, naColumns]
names(data.train)
str(data.train)
data.test <- data.test[, naColumns]
names(data.test)

summary(data.train)
any(is.na(data.train)) ## no more NAs
any(data.train == "") ## no more blanks




########################## NOT INCLUDED ##########################

'## determine the variables that has over 50% blanks and remove it
blankColumns <- colSums(data.train == "")/nrow(data.train)
blankColumns <- ifelse(blankColumns > 0.5, FALSE, TRUE)
data.train <- data.train[, blankColumns]
data.test <- data.test[, blankColumns]
names(data.train)
str(data.train)

summary(data.train)


names <- names(data.train)
for (i in names) {
        
        ifelse("#DIV/0!"

library("rjson")
json_file <- "http://api.worldbank.org/country?per_page=10&region=OED&lendingtype=LNX&format=json"
json_data <- fromJSON(file=json_file)'
