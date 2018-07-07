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

##Update the types
power_cons$Date <- as.Date(power_cons$Date, format="%d/%m/%Y")
power_cons$Time <- strptime(power_cons$Time, format="%H:%M:%S")
power_cons$Global_active_power <- as.numeric(power_cons$Global_active_power)
power_cons$Global_reactive_power <- as.numeric(power_cons$Global_reactive_power)
power_cons$Voltage <- as.numeric(power_cons$Voltage)
power_cons$Global_intensity <- as.numeric(power_cons$Global_intensity)
power_cons$Sub_metering_1 <- as.numeric(power_cons$Sub_metering_1)
power_cons$Sub_metering_2 <- as.numeric(power_cons$Sub_metering_2)
power_cons$Sub_metering_3 <- as.numeric(power_cons$Sub_metering_3)

## Select the data from 2007-02-01 and 2007-02-02
subset_power_cons <- subset(power_cons, Date >= "2007-02-01" & Date <="2007-02-02")

png("plot1.png", width=480, height=480)
hist(subset_power_cons$Global_active_power,
     col="red",
     main ="Global Active Power", 
     xlab="Global Active Power (kilowatts)", 
     ylab="Frequency")
dev.off()

