# This script assumes your working directory contains the "household_power_consumption.txt" file
# and that the lubridate and dplyr packages are installed
library(lubridate)
library(dplyr)

# Read and prepare dataset
power_consumption <- read.table("household_power_consumption.txt", 
                                sep = ";", 
                                header = FALSE, 
                                skip = 66637, 
                                nrows = 2880,
                                stringsAsFactors = FALSE)
header <- read.table("household_power_consumption.txt", 
                     sep = ";", 
                     header = FALSE, 
                     nrows = 1,
                     stringsAsFactors = FALSE)
names(power_consumption) <- unlist(header)
power_consumption <- mutate(power_consumption, Date = dmy_hms(paste(Date, Time)))

# Generate plot
png("plot4.png", width = 480, height = 480)
power_consumption_subset <- subset(power_consumption, wday(Date) %in% c(5, 6))
par(mfrow = c(2, 2))
# Graph 1
plot(power_consumption_subset$Date,
     power_consumption_subset$Global_active_power,
     type = "l",
     xlab = "", 
     ylab = "Global Active Power")

# Graph 2
plot(power_consumption_subset$Date,
     power_consumption_subset$Voltage, 
     type = "l",
     xlab = "datetime", 
     ylab = "Voltage")

# Graph 3
plot(power_consumption_subset$Date, 
     power_consumption_subset$Sub_metering_1, 
     type = "l",
     col = "black",
     xlab = "", 
     ylab = "Energy sub metering")
lines(power_consumption_subset$Date, 
     power_consumption_subset$Sub_metering_2, 
     type = "l",
     col = "red",
     xlab = "", 
     ylab = "")
lines(power_consumption_subset$Date, 
     power_consumption_subset$Sub_metering_3, 
     type = "l",
     col = "blue",
     xlab = "", 
     ylab = "")
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = "solid",
       bty = "n")

# Graph 4
plot(power_consumption_subset$Date,
     power_consumption_subset$Global_reactive_power, 
     type = "l",
     xlab = "datetime", 
     ylab = "Global_reactive_power")
dev.off()