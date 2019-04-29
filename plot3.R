library(lubridate)
## Writing data, assuming file "household_power_consumption.txt" is in your current working directoy
data <- read.table("household_power_consumption.txt", sep = ";")
## Various data cleaning steps
for(i in 1:length(names(data))) {
  names(data)[i] <- as.character(data[1,i])
}
data <- data[-1,]
## Create combined date/time column
data$datetime <- dmy_hms(paste(data$Date,data$Time))
## Select data for first two days in Feb 07
febdata <- data[grep("^2007-02-01|^2007-02-02",data$datetime),]
## Change class from factor to numeric
febdata$Sub_metering_1 <- as.numeric(as.character(febdata$Sub_metering_1))
febdata$Sub_metering_2 <- as.numeric(as.character(febdata$Sub_metering_2))
febdata$Sub_metering_3 <- as.numeric(as.character(febdata$Sub_metering_3))
## Open graphics device
png("plot3.png", width=480, height=480)
## Create plots
plot(febdata$datetime,
     febdata$Sub_metering_1,
     type="n",
     xlab = "",
     ylab = "Energy sub metering")
lines(febdata$datetime, febdata$Sub_metering_1, col = "black")
lines(febdata$datetime, febdata$Sub_metering_2, col = "red")
lines(febdata$datetime, febdata$Sub_metering_3, col = "blue")
legend("topright",
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"),
       lty = c(1,1,1))
## Close graphics device
dev.off()