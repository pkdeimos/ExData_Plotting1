## Load required libraries
library(dplyr)
library(lubridate)

## Read the dataset

fulldata <- read.table("household_power_consumption.txt", header = TRUE, 
                       sep=";", na.strings = "?", 
                       colClasses = c("character","character",
                                      rep("double", 7)))

## Convert Date and Time columns to appropriate formats
fulldata$datetime <- as.POSIXct(paste(fulldata$Date, fulldata$Time), format="%d/%m/%Y %H:%M:%S")
fulldata$Date <- dmy(fulldata$Date)
fulldata$Time <- hms(fulldata$Time)


## Filter data from 1st Feb 2007 and 2nd Feb 2007
reqdata <- filter(fulldata, Date %in% c(ymd("2007-02-01"), ymd("2007-02-02")))


## Plot the Global Active power vs time graph 
plot(reqdata$datetime, reqdata$Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering")

## Add lines for Sub_metering_2 and Sub_metering_3
points(reqdata$datetime, reqdata$Sub_metering_2, type = "l", col="red")
points(reqdata$datetime, reqdata$Sub_metering_3, type = "l", col="blue")

## Add legend
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1)

## Copy the plot to a png file
dev.copy(png, "plot3.png", width=800, height=600)
dev.off()
