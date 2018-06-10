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

## Make Plot 2. 
png("plot2.png", width=480, height=480)
plot(subset$datetime, GlobalActivePower, xlab="", ylab="Global Active Power (kilowatts)", type="l")
dev.off()