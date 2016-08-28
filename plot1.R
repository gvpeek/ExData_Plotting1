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
png("plot1.png", width = 480, height = 480)
hist(power_consumption$Global_active_power, 
     xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power",
     col = "red")
dev.off()