library(caret)
library(randomForest)
library(RCurl)
library(lubridate)
set.seed(321)

url.train <- getURL("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv")
url.test <- getURL("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv")

data.train <- read.csv(text = url.train)
data.test <- read.csv(text = url.test)

str(data.train)
## there lots of NAs and blanks

## determine the variables that has over 50% NAs and remove it
naColumns <- colSums(is.na(data.train) | data.train =="" | data.train == "#DIV/0!")/nrow(data.train)
naColumns <- ifelse(naColumns > 0.3, FALSE, TRUE)

data.train <- data.train[, naColumns]
names(data.train)
str(data.train)
data.test <- data.test[, naColumns]
names(data.test)
data.test <- data.test[, -c(length(data.test))]

summary(data.train)
any(is.na(data.train)) ## no more NAs
any(data.train == "") ## no more blanks

## remove id, user_name and timestamps
data.train <- data.train[, -c(1, 2, 3, 4, 5, 6, 7)]
data.test <- data.test[, -c(1, 2, 3, 4, 5, 6, 7)]


### create a partition

index <- createDataPartition(data.train$classe, 2, p = 0.65, list = FALSE)

train <- data.train[index, ]
test <- data.train[-index, ]

names <- names(train)[1:(length(train)-1)]
names.paste <- paste("classe", paste(names, collapse = "+"), sep = "~")


### use randomforest
rf.model <- randomForest(as.formula(names.paste), train, importance = TRUE, ntree = 100)
plot(rf.model)
min(rf.model$err.rate)
rf.model$importance

pred.rf <- predict(rf.model, test)
confusionMatrix(pred.rf, test[, "classe"])

pred.rf.testing <- predict(rf.model, data.test)
pred.rf.testing

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