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
png("plot2.png", width = 480, height = 480)
power_consumption_subset <- subset(power_consumption, wday(Date) %in% c(5, 6))
plot(power_consumption_subset$Date, 
     power_consumption_subset$Global_active_power, 
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()