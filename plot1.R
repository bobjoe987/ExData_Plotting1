library(dplyr)
setClass("myDate")
#define a function to character "day/month/year" format to "Date" year/month/day
setAs("character","myDate",function(from) as.Date(from,format="%d/%m/%Y"))
#read all the data into a table with defined colClasses
tbl <- read.table('./household_power_consumption.txt',sep=";",header=TRUE,colClasses=c("myDate","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),na.strings="?")
#extract out only the necessary row indicies
subset <- which(tbl$Date >= "2007-02-01" & tbl$Date <= "2007-02-02")
#new table with only the required rows
feb_2007 <- tbl[subset,]
#clean up the enviroment
rm("tbl")

#initialize png plot to current working dir
png(filename="./plot1.png",width=480,height=480)
#draw a histogram plot with the defined labels
hist(feb_2007$Global_active_power,xlab="Global Active Power (kilowatts)",main="Global Active Power",col="red")
#close the device 
dev.off()
