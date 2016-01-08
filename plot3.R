# Check for required packages and install if necessary
curPackages <- installed.packages()[,1]
reqPackages <- c("data.table","dplyr","lubridate")
for (pkg in reqPackages){
     if (!is.element(pkg,curPackages))
          install.packages(pkg)
}

# Load the required packages if necessary
library(data.table)
library(dplyr)
library(lubridate)

# Load, filter, mutate (i.e. create "datetime" column), and subset the data
pwr_dt <- fread("./household_power_consumption.txt",header=TRUE,sep=";",na.strings = "?") %>%
     filter(Date=='1/2/2007' | Date=='2/2/2007') %>%
     mutate(datetime=dmy_hms(paste(Date,Time)))

# Plot 3 Code
png(file="plot3.png",width=480,height=480)
par(mar=c(3,4,4,2))
with(pwr_dt, {
     plot(datetime,Sub_metering_1,type="l",ylab="Energy sub metering")
     points(datetime,Sub_metering_2,col="red",type="l")
     points(datetime,Sub_metering_3,col="blue",type="l")
})
legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1))
dev.off()
