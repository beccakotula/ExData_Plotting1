## Initiate libraries.
library(dplyr)

## Read data
data <- read.table("household_power_consumption.txt", sep=";", 
                   na.strings="?", stringsAsFactors = FALSE, header=TRUE)
## Subset the data to use just the dates we are looking for. 
subset <- data[data$Date %in% c("1/2/2007", "2/2/2007"),]

## Change date and time columns to date & POSIX.ct classes.
subset$Date<- as.Date(subset$Date, "%d/%m/%Y")
subset$Time <- format(as.POSIXct(strptime(subset$Time, format="%H:%M:%S")), 
                      format="%H:%M:%S")

## Combine dates/times in new column.
subset<- mutate(subset, datetime=with(subset, as.POSIXct(paste(Date, Time))))

## Make Plot 4.Set params: 
png("plot4.png", width=480, height=480)
par(mfcol= c(2,2))

## Plot 4 part 1:
plot(subset$datetime, GlobalActivePower, xlab="", ylab="Global Active Power", type="l")
## Plot 4 part 2:
plot(subset$datetime, subset$Sub_metering_1, col= "black", xlab="", 
     ylab="Energy sub metering", type="l")
lines(subset$datetime, subset$Sub_metering_2, col="red", type="l")
lines(subset$datetime, subset$Sub_metering_3, col="blue", type="l")
legend("topright", lty=1, legend=c("Sub_metering_1", "Sub_metering_2", 
                                   "Sub_metering_3"), col=c("black", "red", "blue"), bty="n")
## Plot 4 part 3: 
plot(subset$datetime, subset$Voltage, type="l", xlab="datetime", ylab="Voltage")
## Plot 4 part 4:
plot(subset$datetime, subset$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()