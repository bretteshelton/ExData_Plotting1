## This is the plot1.R file for a course assignment project, authored by 
## Brett E. Shelton
## "Exploratory Data Analysis" Week #1
## Offered by Johns Hopkins as a certificate through Coursera.
## Our overall goal here is simply to examine how household energy usage varies 
## over a 2-day period in February, 2007. Your task is to reconstruct the following 
## plots below, all of which were constructed using the base plotting system.

# Initial libraries
library(dplyr); library(grDevices); library(lubridate)

#read datafile
temp <- tempfile()  
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
unzip(temp)
testRaw <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE)
testRaw <- as_tibble(testRaw)

#Paste date and time characters together
#paste(testRaw$Date,testRaw$Time, sep = " ")

#change the date format
testRaw$Date <- as.Date(dmy(testRaw$Date))
#testRaw$DateTime <- ymd_hms(testRaw$DateTime)

#Filter the total data to just the 2 days we are plotting
twoDays <- filter(testRaw,Date == "2007-02-01" | Date == "2007-02-02")

#Add new weekday column to the dataset
twoDays$Day <- weekdays(twoDays$Date)



png(filename = "plot1.png",
   width = 480, height = 480, units = "px", pointsize = 12,
   bg = "white", res = NA, family = "", restoreConsole = TRUE,
   type = c("windows", "cairo", "cairo-png"))

#Plot histogram of Global Active Power with color and labels
with(twoDays, hist(as.numeric(Global_active_power),col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)"))

#Turn off device to view
dev.off()