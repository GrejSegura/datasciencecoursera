
library(data.table)
library(tidyverse)
library(tidytext)
library(dplyr)
library(tm)
source("./src/3_createNGramData.R")

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


replaceText <- function(sentence){
        
        sentence <- gsub("\\bcant\\b", "cannot", sentence)
        sentence <- gsub("\\bwont\\b", "will not", sentence)
        sentence <- gsub("\\bshant\\b", "shall not", sentence)
        sentence <- gsub("\\baint\\b", "am not", sentence)
        # verb + negation (isn't, aren't, wasn't, etc.)
        sentence <- gsub("n't\\b", " not", sentence)
        # miscellaneous forms
        sentence <- gsub("\\blets\\b", "let us", sentence)
        sentence <- gsub("\\bc'mon\\b", "come on", sentence)
        sentence <- gsub("'n\\b", " and", sentence)
        # pronoun + verb
        sentence <- gsub("\\bim\\b", "i am", sentence)
        sentence <- gsub("'re\\b", " are", sentence)
        sentence <- gsub("'s\\b", " is", sentence)
        sentence <- gsub("'d\\b", " would", sentence)
        sentence <- gsub("'ll\\b", " will", sentence)
        sentence <- gsub("'ve\\b", " have", sentence)
        # Replace contractions with full words
        sentence <- gsub("\\bb\\b", "be", sentence)
        sentence <- gsub("\\bc\\b", "see", sentence)
        sentence <- gsub("\\bm\\b", "am", sentence)
        sentence <- gsub("\\bn\\b", "and", sentence)
        sentence <- gsub("\\bo\\b", "oh", sentence)
        sentence <- gsub("\\br\\b", "are", sentence)
        sentence <- gsub("\\bu\\b", "you", sentence)
        sentence <- gsub("\\by\\b", "why", sentence)
        sentence <- gsub("\\b1\\b", "one", sentence)
        sentence <- gsub("\\b2\\b", "to", sentence)
        sentence <- gsub("\\b4\\b", "for", sentence)
        sentence <- gsub("\\b8\\b", "ate", sentence)
        sentence <- gsub("\\b2b\\b", "to be", sentence)
        sentence <- gsub("\\b2day\\b", "today", sentence)
        sentence <- gsub("\\b2moro\\b", "tomorrow", sentence)
        sentence <- gsub("\\b2morow\\b", "tomorrow", sentence)
        sentence <- gsub("\\b2nite\\b", "tonight", sentence)
        sentence <- gsub("\\bl8r\\b", "later", sentence)
        sentence <- gsub("\\b4vr\\b", "forever", sentence)
        sentence <- gsub("\\b4eva\\b", "forever", sentence)
        sentence <- gsub("\\b4ever\\b", "forever", sentence)
        sentence <- gsub("\\bb4\\b", "before", sentence)
        sentence <- gsub("\\bcu\\b", "see you", sentence)
        sentence <- gsub("\\bcuz\\b", "because", sentence)
        sentence <- gsub("\\btnx\\b", "thanks", sentence)
        sentence <- gsub("\\btks\\b", "thanks", sentence)
        sentence <- gsub("\\bthks\\b", "thanks", sentence)
        sentence <- gsub("\\bthanx\\b", "thanks", sentence)
        sentence <- gsub("\\bu2\\b", "you too", sentence)
        sentence <- gsub("\\bur\\b", "your", sentence)
        sentence <- gsub("\\bgr8\\b", "great", sentence)
        sentence <- gsub('[^A-z0-9[:space:]]',"", sentence)
        
        content2 = Corpus(VectorSource(sentence))
        content2 = tm_map(content2, removeNumbers)
        #content2 = tm_map(content2, removeWords, stopwords(kind = 'en'))
        content2 = tm_map(content2, removePunctuation)
        content2 = tm_map(content2, trimws)
        content2 = tm_map(content2, tolower)
        content2 = tm_map(content2, PlainTextDocument)
        return(content2)
}