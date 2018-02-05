rm(list = ls())
library(data.table)
library(tidyverse)
library(tidytext)
library(ggplot2)
data("stop_words")

textData <- load("./dta/raw/textData.RData")

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

