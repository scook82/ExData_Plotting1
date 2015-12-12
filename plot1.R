
## read in dataset
filename <- "household_power_consumption.txt"
DF4 <- read.table(filename, sep=";", header= TRUE, colClasses = c("Date", "character", "numeric", "numeric","numeric","numeric","numeric","numeric"))

## filter subset of data into DFFeb for 01-02 Feb 2007 
DFFeb <- subset(DF4, as.Date(Date, format = "%d/%m/%Y") >= as.Date('2007/02/01') &  as.Date(Date, format = "%d/%m/%Y") <= as.Date('2007/02/02') & Global_active_power != "?" & !is.na(Global_active_power), drop = FALSE)

# create png device
png("plot1.png")
#plot on the png device
hist(as.numeric(as.character(DFFeb$Global_active_power)), main="Global Active Power", col="red", xlab="Global Active Power (kilowatts)")
# turn device off
dev.off()


