library(tidyverse)

#Download the zip file
setwd("C:/Users/JWatkinson/Documents/R Data Science Course/ExData_Plotting1")

filename <- "exdata%2Fdata%2Fhousehold_power_consumption.zip"

if(!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, filename, method = "curl")
}


if(!file.exists("./household_power_consumption.txt")){
  unzip(filename)
}

#Read household power dataset into R
electric_data <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")

#Convert the Date column to dates
electric_data$Date <- as.Date(electric_data$Date, "%d/%m/%Y")

#Select dates '2007-02-01' and -2007-02-02' only
electric_sub <- electric_data %>% filter(Date == "2007-02-01" | Date == "2007-02-02")

#Add a datetime column
electric_sub <- electric_sub %>% mutate(datetime = paste(Date,Time))

#Convert datetime to Date/Time class
electric_sub$datetime <- strptime(electric_sub$datetime, "%Y-%m-%d %H:%M:%S")



##Create Plot 4

png(file = "plot4.png", width = 480, height = 480)

par(mfrow = c(2,2))

with(electric_sub, {
  plot(datetime, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
  
  plot(datetime, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
  
  plot(datetime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
  lines(datetime, Sub_metering_2, col = "red")
  lines(datetime, Sub_metering_3,col = "blue")
  legend("topright", lty = 1, bty = "n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(datetime, Global_reactive_power, type = "l", xlab = "datetime")
  })

dev.off()
