install.packages("tidyverse")
library(tidyverse)
library(lubridate)

### Set up for downloading file
file_url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
my_unzip <- function(x){
  if(!file.exists(x)) {
    temp <- tempfile()
    download.file(x, temp)
    unzip(temp)
    unlink(temp)
  }
}

## Unzip and read in the file
my_unzip(file_url)
power_cons <- read.csv("household_power_consumption.txt", sep = ';', stringsAsFactors = F)
str(power_cons)


##Update the date to filter 
power_cons$Date <- dmy(power_cons$Date)

## Filter the data from 2007-02-01 and 2007-02-02
sub <- filter(power_cons, Date >= "2007-02-01" & Date <="2007-02-02")

## merge and update the times
sub$new <- paste(sub$Date, sub$Time)
sub$new <- ymd_hms(sub$new)
sub$Global_active_power <- as.numeric(sub$Global_active_power)
sub$Voltage <- as.numeric(sub$Voltage)

##plot the data
png("plot4.png", width=480, height=480)

par (mfrow = c(2,2))

plot(sub$new, sub$Global_active_power, type = "l", xlab="", ylab="Global Active Power (kilowatts)")

plot(sub$new, sub$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

plot(sub$new, sub$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="", col = "black")
lines(sub$new, sub$Sub_metering_2, type="l", col = "red")
lines(sub$new, sub$Sub_metering_3, type="l", col = "blue")
legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, 
       cex = .5,
       bty = "n",
       col=c("black", "red", "blue"))

plot(sub$new, sub$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()

