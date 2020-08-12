## This is the plot3.R file for a course assignment project, authored by 
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


#change the date format
testRaw$Date <- as.Date(dmy(testRaw$Date))
#testRaw$DateTime <- ymd_hms(testRaw$DateTime)

#Filter the total data to just the 2 days we are plotting
twoDays <- filter(testRaw,Date == "2007-02-01" | Date == "2007-02-02")

#Paste date and time characters together, make a new column "dateTime"
twoDays$dateTime <- paste(twoDays$Date,twoDays$Time,sep = " ")
#and convert it to dateTime format
twoDays$dateTime <- ymd_hms(twoDays$dateTime)

#Add new weekday column to the dataset
twoDays$Day <- weekdays(twoDays$Date)



png(filename = "plot3.png",
   width = 480, height = 480, units = "px", pointsize = 12,
   bg = "white", res = NA, family = "", restoreConsole = TRUE,
   type = c("windows", "cairo", "cairo-png"))

#Plot Energy Sub Metering for dateTime with labels
plot(twoDays$dateTime, twoDays$Sub_metering_1, type = "l",xlab = "",ylab = "Energy Sub Metering")
points(twoDays$dateTime, twoDays$Sub_metering_2, type = "l", col = "red")
points(twoDays$dateTime, twoDays$Sub_metering_3, type = "l", col = "blue")
legend("topright",lty = c(1,1,1),col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#Turn off device to view
dev.off()