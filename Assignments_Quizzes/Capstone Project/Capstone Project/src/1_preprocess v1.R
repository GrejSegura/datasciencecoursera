
## This is my capstone project for the Data Science Specialization course in Coursera
## Author : Grejell B. Segura
## Date : 01/17/2018

## This is the first part of the project which loads and process the data

## Part 1 - Preprocessing the data

rm(list = ls())
library(data.table)
library(tidyverse)

# loading the data -- the lines were limited to 60000 to minimize the size
# textData <- readLines("./dta/en_US.twitter.txt", 60000)
# textData <- as.data.frame(textData)
# textData <- setDT(textData)
# fwrite(textData, "./dta/twitterData.csv")

