
## this is my week 1 quiz solution
## Author : Grejell B. Segura
## Date : 03/37/2038

## This is the first part of the project which loads and process the data

rm(list = ls())
library(data.table)
library(tidyverse)
library(tidytext)
library(ggplot2)
data("stop_words")

# loading the news data 
textData3 <- readLines("./dta/en_US.news.txt")
textData3 <- as.data.frame(textData3)
# loading the blogs data 
textData2 <- readLines("./dta/en_US.blogs.txt")
textData2 <- as.data.frame(textData2)

# loading the twitter data 
textData3 <- readLines("./dta/en_US.twitter.txt")
textData3 <- as.data.frame(textData3)
# textData <- setDT(textData)
# fwrite(textData, "./dta/twitterData.csv")

newsData <- fread("./dta/newsData.csv", sep = ",")
blogsData <- fread("./dta/blogsData.csv", sep = ",")
twitterData <- fread("./dta/twitterData.csv", sep = ",")

textData <- rbind(blogsData, newsData, twitterData)

token <- textData %>% unnest_tokens(word, textData)
tokenData <- setDT(token)

tokenData <- tokenData %>% anti_join(stop_words)

count <- tokenData %>% count(word, sort = TRUE)
count <- setDT(count)
count[3:300,]

## 2.
nrow(textData3)


## 3.
##########################
textData3$charlen <- nchar(as.character(unlist(textData3$textData3)))
str(textData3)
max(textData3$charlen)
textData2$charlen <- nchar(as.character(unlist(textData2$textData2)))
str(textData2)
max(textData2$charlen)
textData3$charlen <- nchar(as.character(unlist(textData3$textData3)))
str(textData3)
max(textData3$charlen)

## 4.
love <- grep("love", textData3$textData3)
hate <- grep("hate", textData3$textData3)
length(love)/length(hate)

## 5.
biostats <- grep("biostats", textData3$textData3)
textData3$textData3[biostats]

## 6.

number6 <- grep("A computer once beat me at chess, but it was no match for me at kickboxing", textData3$textData3)
length(number6)
