
## read in dataset
filename <- "household_power_consumption.txt"
DF4 <- read.table(filename, sep=";", header= TRUE, colClasses = c("character", "character", "character", "character","character","character","character","character"))

## filter subset of data into DFFeb for 01-02 Feb 2007 
DF <- subset(DF4, as.Date(Date, format = "%d/%m/%Y") >= as.Date('2007/02/01') &  as.Date(Date, format = "%d/%m/%Y") <= as.Date('2007/02/02') & Global_active_power != "?" & !is.na(Global_active_power) , drop = FALSE, select = c(Date, Time, Global_active_power))


#create a matrix with the Date and the Global_active_power
d <- matrix(DF$Date)
d<- cbind(d,as.numeric(as.character(DF$Global_active_power)))

x <- as.Date(d[,1], format = "%d/%m/%Y")
# get the position in the array where to put the Fri and Sat labels
FriDPts <- length(x[x<="2007-02-01"])
SatDPts <- length(x[x<="2007-02-02"]) - 1


# create png device
png("plot2.png")
#plot on the png device
plot(as.numeric(as.numeric(as.character(d[,2]))),type="l", xaxt='n', xlab="", ylab="Global Active Power (kilowatts)")
# Add labels for the days on the 
axis(side=1, at = c(0, FriDPts, SatDPts), labels = c("Thu", "Fri", "Sat"), tick = TRUE, line = NA,
     pos = NA, outer = FALSE, font = NA, lty = "solid")
# turn device off
dev.off()

