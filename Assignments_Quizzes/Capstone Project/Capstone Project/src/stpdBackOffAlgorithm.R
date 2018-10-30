# A simple stupid backoff algorithm

library(data.table)
library(tidyverse)
library(tidytext)
library(dplyr)
library(tm)

unigramDta <- readRDS('./dta/unigram.RData')
bigramDta <- readRDS('./dta/bigram.RData')
trigramDta <- readRDS('./dta/trigram.RData')
quadgramDta <- readRDS('./dta/quadgram.RData')
fivegramDta <- readRDS('./dta/fivegram.RData')

fiveWordsMatchPredict <- function(sentence){
        sentence <- unlist(replaceText(sentence))
        wordBreakDown <- strsplit(sentence, split = " ")[[1]]
        lastFourWords <- as.data.frame(wordBreakDown[(length(wordBreakDown) - 3):length(wordBreakDown)])
        lastFourWords <- as.data.frame(t(lastFourWords))
        lastFourWords <- as.data.frame(apply(lastFourWords, 1, paste, collapse = " "))
        typedWord <- as.character(lastFourWords[1,1])
        matchedWords <- as.data.frame(fivegramDta$nextWord[fivegramDta$typedWord == typedWord])
        names(matchedWords)[1] <- 'nextWord'
        matchedWords <- matchedWords %>% count(nextWord, sort = TRUE)
        matchedWords <- setDT(matchedWords)
        unlist(matchedWords[1:5,1])
        }


fourWordsMatchPredict <- function(sentence){
        sentence <- unlist(replaceText(sentence))
        wordBreakDown <- strsplit(sentence, split = " ")[[1]]
        lastThreeWords <- as.data.frame(wordBreakDown[(length(wordBreakDown) - 2):length(wordBreakDown)])
        lastThreeWords <- as.data.frame(t(lastThreeWords))
        lastThreeWords <- as.data.frame(apply(lastThreeWords, 1, paste, collapse = " "))
        typedWord <- as.character(lastThreeWords[1,1])
        matchedWords <- as.data.frame(quadgramDta$nextWord[quadgramDta$typedWord == typedWord])
        names(matchedWords)[1] <- 'nextWord'
        matchedWords <- matchedWords %>% count(nextWord, sort = TRUE)
        matchedWords <- setDT(matchedWords)
        unlist(matchedWords[1:5,1])
        }


threeWordsMatchPredict <- function(sentence){
        sentence <- unlist(replaceText(sentence))
        wordBreakDown <- strsplit(sentence, split = " ")[[1]]
        lastTwoWords <- as.data.frame(wordBreakDown[(length(wordBreakDown) - 1):length(wordBreakDown)])
        lastTwoWords <- as.data.frame(t(lastTwoWords))
        lastTwoWords <- as.data.frame(apply(lastTwoWords, 1, paste, collapse = " "))
        typedWord <- as.character(lastTwoWords[1,1])
        matchedWords <- as.data.frame(trigramDta$nextWord[trigramDta$typedWord == typedWord])
        names(matchedWords)[1] <- 'nextWord'
        matchedWords <- matchedWords %>% count(nextWord, sort = TRUE)
        matchedWords <- setDT(matchedWords)
        unlist(matchedWords[1:5,1])
        }


twoWordsMatchPredict <- function(sentence){
        sentence <- unlist(replaceText(sentence))
        wordBreakDown <- strsplit(sentence, split = " ")[[1]]
        lastWord <- as.data.frame(wordBreakDown[length(wordBreakDown)])
        typedWord <- as.character(lastWord[1,1])
        matchedWords <- as.data.frame(bigramDta$nextWord[bigramDta$typedWord == typedWord])
        names(matchedWords)[1] <- 'nextWord'
        matchedWords <- matchedWords %>% count(nextWord, sort = TRUE)
        matchedWords <- setDT(matchedWords)
        unlist(matchedWords[1:5,1])
        }


