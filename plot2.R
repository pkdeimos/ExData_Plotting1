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
plot(reqdata$datetime, reqdata$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

## Copy the plot to a png file
dev.copy(png, "plot2.png")
dev.off()
