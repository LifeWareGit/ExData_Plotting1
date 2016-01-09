# Check for required packages and install if necessary
curPackages <- installed.packages()[,1]
reqPackages <- c("data.table","dplyr","lubridate","sqldf")
for (pkg in reqPackages){
     if (!is.element(pkg,curPackages))
          install.packages(pkg)
}

# Load the required packages if necessary
library(data.table)
library(dplyr)
library(lubridate)
library(sqldf)

# Load a subset of the data and combine the Date and Time columns
dataFile <- file("./household_power_consumption.txt")
pwr_dt <- sqldf("select * from dataFile where Date in ('1/2/2007','2/2/2007')",
            file.format = list(header = TRUE, sep = ";")) %>%
     mutate(datetime=dmy_hms(paste(Date,Time)))
close(dataFile)

# Plot 1 Code
png(file="plot1.png",width=480,height=480)
with(pwr_dt,hist(Global_active_power, 
                        col="red",main="Global Active Power", 
                        xlab="Global Active Power (kilowatts)"))
dev.off()