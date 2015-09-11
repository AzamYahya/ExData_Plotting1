library(plyr)
library(dplyr)

a <- read.table("Z:/Ferguson 13 march/other assignment/DS/Coursera/Courses/exploratory data analysis/Course project/Assignment 1/Data/household_power_consumption.txt",sep = ";",header = TRUE,stringsAsFactors = FALSE)


a <- a[ which(a$Date=='1/2/2007'| a$Date=='2/2/2007'), ]
dates <- as.vector(a$Date)
dates <- as.Date(dates,"%d/%m/%Y")
times <- a$Time
x <- paste(dates,times)
a$DateTime <- strptime(x, "%Y-%m-%d %H:%M:%S")

b <- a[- grep("?", a),]
b <- na.omit(b)


b <- transform(b, Global_active_power = as.numeric(Global_active_power), 
               Global_reactive_power = as.numeric(Global_reactive_power),
               Voltage = as.numeric(Voltage),
               Global_intensity = as.numeric(Global_intensity),
               Sub_metering_1 =  as.numeric(Sub_metering_1),
               Sub_metering_2 =  as.numeric(Sub_metering_2))


meter_range <- range(0, b$Sub_metering_1,b$Sub_metering_2,b$Sub_metering_3)

par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(b,{
  plot(DateTime, Global_active_power,ann = FALSE,type = "l")
  title(ylab = "Global Active power")
  plot(DateTime, Voltage, ylab = "Voltage", xlab = "datetime",type = "l")
  plot(b$Sub_metering_1, type="l", ylim=meter_range,ann = FALSE)
  title(ylab ="Energy sub metering")
  lines(b$Sub_metering_2, type="l", col="red",)
  lines(b$Sub_metering_3, type="l", col="blue")
  legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black","red","blue"),pch = "-")
  plot(DateTime, Global_reactive_power,ylab = "Global_reactive_power",xlab = "datetime",type = "l")
})

dev.copy(png,file = "plot4.png", width= 480,height = 480)
dev.off()