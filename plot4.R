
## read in dataset
filename <- "household_power_consumption.txt"
DF4 <- read.table(filename, sep=";", header= TRUE, colClasses = c("Date", "character", "character", "character","character","character","character","character"))

## filter subset of data into DFFeb for 01-02 Feb 2007 
DFFeb <- subset(DF4, as.Date(Date, format = "%d/%m/%Y") >= as.Date('2007/02/01') &  as.Date(Date, format = "%d/%m/%Y") <= as.Date('2007/02/02') & Sub_metering_1 != "?" & Sub_metering_2 != "?" & Sub_metering_3 != "?" , drop = FALSE)

x <- as.Date(DFFeb$Date, format = "%d/%m/%Y")
# get the position in the array where to put the Fri and Sat labels
FriDPts <- length(x[x<="2007-02-01"])
SatDPts <- length(x[x<="2007-02-02"]) - 1

# create png device
png("plot4.png")
#plot on the png device
par(mfrow=c(2,2))## create 2x2 matrix of plots
# Top Right plot
  plot(as.numeric(as.numeric(as.character(d[,2]))),type="l", xaxt='n', xlab="", ylab="Global Active Power (kilowatts)")
  # Add labels for the days on the 
  axis(side=1, at = c(0, FriDPts, SatDPts), labels = c("Thu", "Fri", "Sat"), tick = TRUE, line = NA,
       pos = NA, outer = FALSE, font = NA, lty = "solid")
# Top Left plot
  plot(DFFeb$Voltage, type="l", ylab="Voltage", xlab="datetime", xaxt='n')
  axis(side=1, at = c(0, FriDPts, SatDPts) , labels = c("Thu", "Fri", "Sat")
       , tick = TRUE , line = NA , pos = NA, outer = FALSE, font = NA, lty = "solid")
# Bottom Right Plot
  plot(DFFeb$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="", xaxt='n')
  lines(DFFeb$Sub_metering_2, col="red")
  lines(DFFeb$Sub_metering_3, col="blue")
  axis(side=1, at = c(0, FriDPts, SatDPts) , labels = c("Thu", "Fri", "Sat")
       , tick = TRUE , line = NA , pos = NA, outer = FALSE, font = NA, lty = "solid")
  legend("topright" # places a legend at the appropriate place 
         ,lty=c(1,1, 1),col=c("black", "red","blue")
         ,legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
         ,bty = "n")
# Bottom Left Plot
  plot(DFFeb$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime", xaxt='n')
  axis(side=1, at = c(0, FriDPts, SatDPts) , labels = c("Thu", "Fri", "Sat")
       , tick = TRUE , line = NA , pos = NA, outer = FALSE, font = NA, lty = "solid")
 
# turn device off
dev.off()


