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

##plot the data
png("plot2.png", width=480, height=480)
plot(sub$new, sub$Global_active_power, type = "l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
