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

#Plot 4 Code
png(file="plot4.png",width=480,height=480)
par(mfcol = c(2,2))
par(mar=c(4,4,4,2))
with(pwr_dt, {
     plot(datetime,Global_active_power,type="l",xlab="",ylab="Global Active Power") 
     plot(datetime,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering") 
     points(datetime,Sub_metering_2,col="red",type="l") 
     points(datetime,Sub_metering_3,col="blue",type="l") 
     legend("topright",col=c("black","red","blue"), bty="n", cex=0.75,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1))
     plot(datetime,Voltage,type="l") 
     plot(datetime,Global_reactive_power,type="l") 
})
dev.off()

