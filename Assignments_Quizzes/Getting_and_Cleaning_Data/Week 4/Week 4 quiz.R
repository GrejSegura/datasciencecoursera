
## 1. 

data_1 <- read.csv("/Users/Grejell/Downloads/getdata%2Fdata%2Fss06hid.csv")

var_names <- names(data_1)

strsplit(var_names, "wgtp")

## 2.

data_2 <- read.csv("/Users/Grejell/Downloads/getdata%2Fdata%2FGDP.csv")

data_2[, 5] <- gsub(",", "", data_2[, 5])

data_2[, 5] <- as.numeric(data_2[, 5])
data_2 <- data_2[5:194 , 5]


ave <- mean(data_2, na.rm = TRUE)
ave

## 4.

data_3 <- read.csv("/Users/Grejell/Downloads/getdata%2Fdata%2FEDSTATS_Country.csv")
data_2 <- read.csv("/Users/Grejell/Downloads/getdata%2Fdata%2FGDP.csv")

names(data_2)[1] <- "code"
names(data_3)[1] <- "code"

data_3_new <- merge(data_2, data_3)

fiscal <- grep("Fiscal", data_3_new$Special.Notes)

data_3_new_fiscal <- data_3_new[fiscal, ]

june <- grep("June", data_3_new_fiscal$Special.Notes)

length(june)

## 5.

install.packages("quantmod")

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

amzn <- as.data.frame(amzn)
amzn$date <- row.names(amzn)

library(lubridate)

amzn$wday <- wday(amzn$date, label = TRUE)
amzn$year <- year(amzn$date)


yr <- amzn[amzn$year == 2012,]
wdy <- amzn[amzn$year == 2012 & amzn$wday == "Mon",]
