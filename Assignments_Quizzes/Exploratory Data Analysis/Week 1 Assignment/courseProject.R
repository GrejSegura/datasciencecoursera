## 1.

library(data.table)
library(lubridate)

unzip("/Users/Grejell/Desktop/R/Coursera/Course 4 - Exploratory DA/Week 1 - Course Proj/exdata%2Fdata%2Fhousehold_power_consumption.zip")

hpc_data <- fread("/Users/Grejell/Desktop/R/Coursera/Course 4 - Exploratory DA/Week 1 - Course Proj/household_power_consumption.txt", 
                  header = TRUE, sep = ";", stringsAsFactors = FALSE, dec = ".", na.strings = "?")

str(hpc_data)
hpc_data <- hpc_data[, Date := dmy(Date)]
hpc_data_new <- hpc_data[Date == "2007-02-01" | Date == "2007-02-02", ]
any(is.na(hpc_data_new))

png("./plot1.png", width = 480, height = 480)
hist(hpc_data_new$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()

## 2.

library(data.table)
library(lubridate)

unzip("/Users/Grejell/Desktop/R/Coursera/Course 4 - Exploratory DA/Week 1 - Course Proj/exdata%2Fdata%2Fhousehold_power_consumption.zip")

hpc_data <- fread("/Users/Grejell/Desktop/R/Coursera/Course 4 - Exploratory DA/Week 1 - Course Proj/household_power_consumption.txt", 
                  header = TRUE, sep = ";", stringsAsFactors = FALSE, dec = ".", na.strings = "?")

str(hpc_data)
hpc_data <- hpc_data[, Date := dmy(Date)]
hpc_data_new <- hpc_data[Date == "2007-02-01" | Date == "2007-02-02", ]
any(is.na(hpc_data_new))

hpc_data_new <- hpc_data_new[, Date_Time := ymd_hms(paste(Date, Time))]
png("./plot2.png", width = 480, height = 480)
plot(hpc_data_new$Date_Time, hpc_data_new$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()

## 3. 
library(data.table)
library(lubridate)

unzip("/Users/Grejell/Desktop/R/Coursera/Course 4 - Exploratory DA/Week 1 - Course Proj/exdata%2Fdata%2Fhousehold_power_consumption.zip")

hpc_data <- fread("/Users/Grejell/Desktop/R/Coursera/Course 4 - Exploratory DA/Week 1 - Course Proj/household_power_consumption.txt", 
                  header = TRUE, sep = ";", stringsAsFactors=FALSE, dec = ".", na.strings = "?")

str(hpc_data)
hpc_data <- hpc_data[, Date := dmy(Date)]
hpc_data_new <- hpc_data[Date == "2007-02-01" | Date == "2007-02-02", ]
any(is.na(hpc_data_new))

hpc_data_new <- hpc_data_new[, Date_Time := ymd_hms(paste(Date, Time))]

png("./plot3.png", width = 480, height = 480)
plot(hpc_data_new$Date_Time, hpc_data_new$Sub_metering_1, type = "l", xlab = "", ylab = "Energy Submetering")
lines(hpc_data_new$Date_Time, hpc_data_new$Sub_metering_2, type = "l", xlab = "", ylab = "", col = "red")
lines(hpc_data_new$Date_Time, hpc_data_new$Sub_metering_3, type = "l", xlab = "", ylab = "", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, lwd = 2.5, col = c("black", "red", "blue"))
dev.off()



## 4. 
library(data.table)
library(lubridate)

unzip("/Users/Grejell/Desktop/R/Coursera/Course 4 - Exploratory DA/Week 1 - Course Proj/exdata%2Fdata%2Fhousehold_power_consumption.zip")

hpc_data <- fread("/Users/Grejell/Desktop/R/Coursera/Course 4 - Exploratory DA/Week 1 - Course Proj/household_power_consumption.txt", 
                  header = TRUE, sep = ";", stringsAsFactors = FALSE, dec = ".", na.strings = "?")

str(hpc_data)
hpc_data <- hpc_data[, Date := dmy(Date)]
hpc_data_new <- hpc_data[Date == "2007-02-01" | Date == "2007-02-02", ]
any(is.na(hpc_data_new))

hpc_data_new <- hpc_data_new[, Date_Time := ymd_hms(paste(Date, Time))]

png("./plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2)) 
plot(hpc_data_new$Date_Time, hpc_data_new$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

plot(hpc_data_new$Date_Time, hpc_data_new$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

plot(hpc_data_new$Date_Time, hpc_data_new$Sub_metering_1, type = "l", xlab = "", ylab = "Energy Submetering")
lines(hpc_data_new$Date_Time, hpc_data_new$Sub_metering_2, type = "l", xlab = "", ylab = "", col = "red")
lines(hpc_data_new$Date_Time, hpc_data_new$Sub_metering_3, type = "l", xlab = "", ylab = "", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, lwd = 2.5, col = c("black", "red", "blue"))

plot(hpc_data_new$Date_Time, hpc_data_new$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()
