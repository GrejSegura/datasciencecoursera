
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


## download the data ##

if(!file.exists("./dta/raw")){
        dir.create("./dta/raw")
}

url <- "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"

download.file(url, destfile = "./dta/raw/Coursera-SwiftKey.zip", mode = "wb")
unzip(zipfile = "./dta/raw/Coursera-SwiftKey.zip", exdir = "./dta/raw")    ## unzip to open files

path <- file.path("./dta/raw" , "en_US")
files <- list.files(path, recursive = TRUE)


## open twitter data ##

con <- file("./dta/raw/final/en_US/en_US.twitter.txt", "r") 

twitterDta <- readLines(con, skipNul = TRUE)
twitterDta <- as.data.frame(twitterDta)
names(twitterDta)[1] <- "text"
close(con)


## open news data ##

con <- file("./dta/raw/final/en_US/en_US.news.txt", "r") 

newsDta <- readLines(con, skipNul = TRUE)
newsDta <- as.data.frame(newsDta)
names(newsDta)[1] <- "text"
close(con)


## open blog data ##

con <- file("./dta/raw/final/en_US/en_US.blogs.txt", "r") 

blogDta <- readLines(con, skipNul = TRUE)
blogDta <- as.data.frame(blogDta)
names(blogDta)[1] <- "text"
close(con)


## bind data to make 1 data frame ## 




textData <- rbind(blogDta, newsDta, twitterDta)
save(textData, file = "./dta/textData.RData")

