
library(data.table)
library(tidyverse)
library(tidytext)
library(dplyr)
library(tm)

#load("./dta/textDta.RData")
createUniGram <- function(textDta){
        #load("./dta/textDta.RData")
        textDta <- textDta[sample(1:nrow(textDta), nrow(textDta)), -2]
        unigram <- setDT(as.data.frame(textDta))
        unigram <- unigram[!is.na(unigram$textDta),]
        unigram$textDta <- as.character(unigram$textDta)
        sentence <- as.character(unigram$textDta)
        content <- replaceText(sentence)
        unigram <- as.data.frame(unlist(content))
        names(unigram)[1] <- 'textDta'
        #
        #wordcloud(trigram$textDta, min.freq = 10, colors = RColorBrewer::brewer.pal(6,"Spectral"),max.words=150)
        #
        unigram$textDta <- as.character(unigram$textDta)
        unigram <- unigram %>% unnest_tokens(word, textDta)
        unigram <- setDT(unigram)
        unigram <- unigram %>% count(word, sort = TRUE)
        unigram <- setDT(unigram)
        
        saveRDS(unigram, './dta/unigram.RData')
        View(unigram)
}


createBiGram <- function(textDta){
        #load("./dta/textDta.RData")
        textDta <- textDta[sample(1:nrow(textDta), 0.2*nrow(textDta)), -2]
        bigram <- setDT(as.data.frame(textDta))
        bigram <- bigram[!is.na(bigram$textDta),]
        sentence <- as.character(bigram$textDta)
        content <- replaceText(sentence)
        bigram <- as.data.frame(unlist(content))
        names(bigram)[1] <- 'textDta'
        #
        #wordcloud(trigram$textDta, min.freq = 10, colors = RColorBrewer::brewer.pal(6,"Spectral"),max.words=150)
        #
        bigram <- bigram %>% unnest_tokens(bigram, textDta, token = 'ngrams', n = 2)
        bigram <- setDT(bigram)
        bigram <- bigram %>% separate(bigram, into = paste("V", 1:2, sep = " "))
        names(bigram) <- c('typedWord', 'nextWord')
        saveRDS(bigram, './dta/bigram.RData')
        #View(bigram)
}

createTriGram <- function(textDta){
        #load("./dta/textDta.RData")
        textDta <- textDta[sample(1:nrow(textDta), 0.18*nrow(textDta)), -2]
        trigram <- setDT(as.data.frame(textDta))
        trigram <- trigram[!is.na(trigram$textDta),]
        sentence <- as.character(trigram$textDta)
        content <- replaceText(sentence)
        trigram <- as.data.frame(unlist(content))
        names(trigram)[1] <- 'textDta'
        #
        #wordcloud(trigram$textDta, min.freq = 10, colors = RColorBrewer::brewer.pal(6,"Spectral"),max.words=150)
        #
        trigram <- trigram %>% unnest_tokens(trigram, textDta, token = 'ngrams', n = 3)
        trigram <- setDT(trigram)
        trigram <- trigram %>% separate(trigram, into = paste("V", 1:3, sep = ""))
        trigram$typedWord <- paste(trigram$V1, trigram$V2, sep = " ")
        names(trigram)[3] <- 'nextWord'
        trigram <- trigram[, -c(1,2)]
        
        saveRDS(trigram, './dta/trigram.RData')
        #View(trigram)
}


createQuadGram <- function(textDta){
        #load("./dta/textDta.RData")
        textDta <- textDta[sample(1:nrow(textDta), 0.15*nrow(textDta)), -2]
        quadgram <- setDT(as.data.frame(textDta))
        quadgram <- quadgram[!is.na(quadgram$textDta),]
        sentence <- as.character(quadgram$textDta)
        content <- replaceText(sentence)
        quadgram <- as.data.frame(unlist(content))
        names(quadgram)[1] <- 'textDta'
        #
        #wordcloud(quadgram$textDta, min.freq = 10, colors = RColorBrewer::brewer.pal(6,"Spectral"),max.words=150)
        #
        quadgram <- quadgram %>% unnest_tokens(quadgram, textDta, token = 'ngrams', n = 4)
        quadgram <- setDT(quadgram)
        quadgram <- quadgram %>% separate(quadgram, into = paste("V", 1:4, sep = ""))
        quadgram$typedWord <- paste(quadgram$V1, quadgram$V2, quadgram$V3, sep = " ")
        names(quadgram)[4] <- 'nextWord'
        quadgram <- quadgram[, -c(1,2,3)]
        
        saveRDS(quadgram, './dta/quadgram.RData')
        #View(quadgram)
}

createFiveGram <- function(textDta){
        #load("./dta/textDta.RData")
        textDta <- textDta[sample(1:nrow(textDta), 0.1*nrow(textDta)), -2]
        fivegram <- setDT(as.data.frame(textDta))
        fivegram <- fivegram[!is.na(fivegram$textDta),]
        sentence <- as.character(fivegram$textDta)
        content <- replaceText(sentence)
        fivegram <- as.data.frame(unlist(content))
        names(fivegram)[1] <- 'textDta'
        #
        #wordcloud(quadgram$textDta, min.freq = 10, colors = RColorBrewer::brewer.pal(6,"Spectral"),max.words=150)
        #
        fivegram <- fivegram %>% unnest_tokens(fivegram, textDta, token = 'ngrams', n = 5)
        fivegram <- setDT(fivegram)
        fivegram <- fivegram %>% separate(fivegram, into = paste("V", 1:5, sep = ""))
        fivegram$typedWord <- paste(fivegram$V1, fivegram$V2, fivegram$V3, fivegram$V4, sep = " ")
        names(fivegram)[5] <- 'nextWord'
        fivegram <- fivegram[, -c(1,2,3,4)]
        
        saveRDS(fivegram, './dta/fivegram.RData')
        #View(quadgram)
}

