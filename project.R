library(sqldf)
HPC <- read.csv.sql("household_power_consumption.txt",
                   header=T,sep = ";",
                   "select * from file where Date = '1/2/2007' or Date = '2/2/2007'")
HPC$Date <- as.Date(HPC$Date)
HPC$Time <- strptime(HPC$Time,"%H:%M:%S")

par(mfrow=c(1,1))
hist(HPC$Global_active_power,
      main = "Global Active Power",xlab = "Global Active Power (kilowatts)",
     col="red",breaks = 12,
     xlim = c(0,6),ylim = c(0,1200))

plot(HPC$Global_active_power,
     xlab="",ylab="Global Active Power (kilowatts)",
     type = "l")
axis(1,at=c(0,1440,2880),labels=c("Thu","Fri","Sat"))

dat <- data.matrix(HPC[,c(7,8,9)])
matplot(dat,type="l",pch=1,col=c("black","red","blue"))
axis(1,at=c(0,1440,2880),labels=c("Thu","Fri","Sat"))
legend("topright",lty = c(1,1,1),col = c("black","red","green"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

par(mfrow=c(2,2),mar=c(2,2,2,2))
plot(HPC$Global_active_power,
     xlab="",ylab="Global Active Power (kilowatts)",
     type = "l")

plot(HPC$Voltage,
     xlab="datetime",ylab="Voltage",
     type = "l")

dat <- data.matrix(HPC[,c(7,8,9)])
matplot(dat,type="l",pch=1,col=c("black","red","blue"))
axis(1,at=c(0,1440,2880),labels=c("Thu","Fri","Sat"))
legend("topright",lty = c(1,1,1),col = c("black","red","green"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

plot(HPC$Global_reactive_power,
     xlab="datetime",ylab="Global Reactive Power",
     type = "l")

