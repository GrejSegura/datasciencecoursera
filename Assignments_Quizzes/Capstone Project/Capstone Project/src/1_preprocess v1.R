
## This is my capstone project for the Data Science Specialization course in Coursera
## Author : Grejell B. Segura
## Date : 03/37/2038

## This is the first part of the project which loads and process the data

## Part 3 - Preprocessing the data

rm(list = ls())
library(data.table)
library(tidyverse)
library(tidytext)
library(ggplot2)
data("stop_words")

'# loading the news data 
textData3 <- readLines("./dta/en_US.news.txt")
textData3 <- as.data.frame(textData3)
# loading the blogs data 
textData2 <- readLines("./dta/en_US.blogs.txt")
textData2 <- as.data.frame(textData2)

# loading the twitter data 
textData3 <- readLines("./dta/en_US.twitter.txt")
textData3 <- as.data.frame(textData3)'
# textData <- setDT(textData)
# fwrite(textData, "./dta/twitterData.csv")

newsData <- fread("./dta/newsData.csv", sep = ",")
blogsData <- fread("./dta/blogsData.csv", sep = ",")
twitterData <- fread("./dta/twitterData.csv", sep = ",")

textData <- rbind(blogsData, newsData, twitterData)

index <- sample(nrow(textData), 5000)
textData <- textData[index, ]

token <- textData %>% unnest_tokens(word, textData)
tokenData <- setDT(token)

tokenData <- tokenData %>% anti_join(stop_words)

count <- tokenData %>% count(word, sort = TRUE)
count <- setDT(count)
count[1:300,]

## 3-gram
trigram <- textData %>% unnest_tokens(trigram, textData, token = 'ngrams', n = 3)
trigram <- setDT(trigram)
trigram <- trigram %>% count(trigram, sort = TRUE)
trigram <- setDT(trigram)
trigram[1:300,]

names <- paste("v", c(1:3), sep = "")
trigram[, names := strsplit(trigram, " "), with = FALSE]
