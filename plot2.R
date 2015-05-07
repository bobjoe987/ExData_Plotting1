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

#add a new column that is a datetime object from joining Date and Time columns
feb_2007 <- mutate(feb_2007, DateTime = as.POSIXct(strptime(paste(as.character(Date),Time),format="%Y-%m-%d %H:%M:%S")))

png(filename="./plot2.png",width=480,height=480)
#draw a line plot with the defined labels
with(feb_2007,plot(DateTime,Global_active_power,type='l',ylab="Global Active Power (kilowatts)",xlab=""))
#close the device  
dev.off()