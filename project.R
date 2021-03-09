#fetch the raw data
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,destfile = "./HPC.zip")
unzip("./HPC.zip")

#construct the tidydata
library(sqldf)
HPC <- read.csv.sql("household_power_consumption.txt",
                   header=T,sep = ";",
                   "select * from file where Date = '1/2/2007' or Date = '2/2/2007'")
DateTime <- paste(HPC$Date,HPC$Time)
DateTime <- as.POSIXct(DateTime,format = "%d/%m/%Y %H:%M:%S")
tidydata <- cbind(DateTime,HPC[,-(1:2)])

#plot1
par(mfrow=c(1,1))
hist(tidydata$Global_active_power,
      main = "Global Active Power",xlab = "Global Active Power (kilowatts)",
     col="red",breaks = 12,
     xlim = c(0,6),ylim = c(0,1200))
dev.copy(png,"plot1.png", width = 480, height = 480)
dev.off()

#plot2
par(mar=c(4,4,2,2))
plot(tidydata$Global_active_power~tidydata$DateTime,
     xlab="",ylab="Global Active Power (kilowatts)",
     type = "l")
dev.copy(png,"plot2.png", width = 480, height = 480)
dev.off()

#plot3
windows(height = 7, width = 3.5)
with(tidydata, {
    plot(Sub_metering_1~DateTime,type="l",ylab="Energy sub metering", xlab="")
    lines(Sub_metering_2~DateTime,col= "Red")
    lines(Sub_metering_3~DateTime,col="Blue")
})
legend("topright",lwd=1,col = c("black","red","green"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       cex=0.25)
dev.copy(png,"plot3.png", width = 480, height = 480)
dev.off()

#plot4
par(mfrow=c(2,2),mar=c(4,4,2,2))
hist(tidydata$Global_active_power,
     main = "Global Active Power",xlab = "Global Active Power (kilowatts)",
     col="red",breaks = 12,
     xlim = c(0,6),ylim = c(0,1200))

plot(tidydata$Voltage,
     xlab="datetime",ylab="Voltage",
     type = "l")

with(tidydata, {
    plot(Sub_metering_1~DateTime,type="l",ylab="Energy sub metering", xlab="")
    lines(Sub_metering_2~DateTime,col= "Red")
    lines(Sub_metering_3~DateTime,col="Blue")
})
legend("topright",lwd=1,col = c("black","red","green"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       cex=0.25)

plot(HPC$Global_reactive_power,
     xlab="datetime",ylab="Global Reactive Power",
     type = "l")

dev.copy(png,"plot4.png", width = 480, height = 480)
dev.off()
