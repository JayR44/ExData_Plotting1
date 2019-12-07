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



##Create Plot 1

png(file = "plot1.png", width = 480, height = 480)

hist(electric_sub$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

dev.off()
