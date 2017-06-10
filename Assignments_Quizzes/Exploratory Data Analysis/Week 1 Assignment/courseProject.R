
library(data.table)
library(lubridate)

unzip("/Users/Grejell/Desktop/R/Coursera/Course 4 - Exploratory DA/Week 1 - Course Proj/exdata%2Fdata%2Fhousehold_power_consumption.zip")

hpc_data <- fread("/Users/Grejell/Desktop/R/Coursera/Course 4 - Exploratory DA/Week 1 - Course Proj/household_power_consumption.txt", 
                  header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".", na.strings = "?")
## hpc_data <- read.table("/Users/Grejell/Desktop/R/Coursera/Course 4 - Exploratory DA/Week 1 - Course Proj/household_power_consumption.txt", 
##                       header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")


str(hpc_data)
hpc_data <- hpc_data[, Date := dmy(Date)]
hpc_data_new <- hpc_data[Date == "2007-02-01" | Date == "2007-02-02", ]
any(is.na(hpc_data_new))

## 1.
globalActivePower <- hpc_data_new$Global_active_power
png("plot1.png", width=480, height=480)
hist(globalActivePower, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
## 2.
hpc_data_new <- hpc_data[Date == "2007-02-01" | Date == "2007-02-02", ]
hpc_data_new <- hpc_data_new[, Time := as.POSIXct(Time)]
any(is.na(hpc_data_new))

datetime <- strptime(paste(hpc_data_new$Date, hpc_data_new$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
globalActivePower <- as.numeric(hpc_data_new$Global_active_power)
png("plot2.png", width=480, height=480)
plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
