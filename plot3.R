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

#initialize png plot to current working dir
png(filename="./plot3.png",width=480,height=480)
#draw 3 line plots of sub_metering_1, 2, and 3, add legend
plot(feb_2007$DateTime,feb_2007$Sub_metering_1,type='l',ylab="Energy sub metering",xlab="")
lines(feb_2007$DateTime,feb_2007$Sub_metering_2,type='l',col="red")
lines(feb_2007$DateTime,feb_2007$Sub_metering_3,type='l',col="blue")
legend("topright",lwd=1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#close the device 
dev.off()
