# Saves a corpus of n-grams using the function created in 3_createNGramData.R

library(data.table)
library(tidyverse)
library(tidytext)
library(dplyr)
library(tm)
source("./src/3_createNGramData.R")
source("./src/replaceText.R")


load("./dta/textDta.RData")

textDta <- textDta[sample(1:nrow(textDta), 0.5*nrow(textDta)),] ## use only 5% of the data to minimize memory

createUniGram(textDta)
createBiGram(textDta)
createTriGram(textDta)
createQuadGram(textDta)
createFiveGram(textDta)

unigramDta <- readRDS('./dta/unigram.RData')
bigramDta <- readRDS('./dta/bigram.RData')
trigramDta <- readRDS('./dta/trigram.RData')
quadgramDta <- readRDS('./dta/quadgram.RData')
fivegramDta <- readRDS('./dta/fivegram.RData')

nGramData <- as.data.frame(rbind(bigramDta, trigramDta, quadgramDta, fivegramDta))
saveRDS(nGramData, './dta/nGramData.RData')
