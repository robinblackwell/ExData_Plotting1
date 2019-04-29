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
febdata$Global_active_power <- as.numeric(as.character(febdata$Global_active_power))
## Open graphics device
png("plot2.png", width=480, height=480)
## Create plots
plot(febdata$datetime,
     febdata$Global_active_power,
     type="n",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
lines(febdata$datetime, febdata$Global_active_power)
## Close graphics device
dev.off()