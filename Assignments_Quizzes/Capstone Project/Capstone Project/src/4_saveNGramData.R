# Saves a corpus of n-grams using the function created in 3_createNGramData.R

library(data.table)
library(tidyverse)
library(tidytext)
library(dplyr)
library(tm)
source("./src/3_createNGramData.R")
source("./src/replaceText.R")


load("./dta/textDta.RData")

createUniGram(textDta)
createBiGram(textDta)
createTriGram(textDta)
createQuadGram(textDta)
createFiveGram(textDta)
