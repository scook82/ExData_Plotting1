
## read in dataset
filename <- "household_power_consumption.txt"
DF4 <- read.table(filename, sep=";", header= TRUE, colClasses = c("Date", "character", "character", "character","character","character","character","character"))

## filter subset of data into DFFeb for 01-02 Feb 2007 
DFFeb <- subset(DF4, as.Date(Date, format = "%d/%m/%Y") >= as.Date('2007/02/01') &  as.Date(Date, format = "%d/%m/%Y") <= as.Date('2007/02/02') & Sub_metering_1 != "?" & Sub_metering_2 != "?" & Sub_metering_3 != "?" , drop = FALSE
                , select = c(Date, Time, Sub_metering_1, Sub_metering_2, Sub_metering_3))

x <- as.Date(DFFeb$Date, format = "%d/%m/%Y")
# get the position in the array where to put the Fri and Sat labels
FriDPts <- length(x[x<="2007-02-01"])
SatDPts <- length(x[x<="2007-02-02"]) - 1

# create png device
png("plot3.png")
#plot on the png device
plot(DFFeb$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="", xaxt='n')
lines(DFFeb$Sub_metering_2, col="red")
lines(DFFeb$Sub_metering_3, col="blue")
axis(side=1, at = c(0, FriDPts, SatDPts)
     , labels = c("Thu", "Fri", "Sat")
     , tick = TRUE
     , line = NA
     , pos = NA, outer = FALSE, font = NA, lty = "solid")
legend("topright" # places a legend at the appropriate place 
       ,lty=c(1,1, 1) # line symbol for legend
       ,col=c("black", "red","blue")
       ,legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# turn device off
dev.off()


