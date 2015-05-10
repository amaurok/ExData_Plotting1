##Download the file, and unzip it.
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
path <- getwd()
if(!file.exists(path)){ 
  dir.create(path)
}
fileName <- "DataSet.zip"
download.file(url, file.path(path, fileName))
unzip(fileName)

#Read the unzipped file.
data <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                 nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

#Subset the data between the requested dates.
dataSubSet <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data)

# Convert dates and transform datetime to account for the amount of seconds.
datetime <- paste(as.Date(dataSubSet$Date), dataSubSet$Time)
dataSubSet$Datetime <- as.POSIXct(datetime)

#Define the number of rows and columns, to plot the graphics.
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

#Apply the expressions to the dataset, in order to plot the graphics.
with(dataSubSet, {
  plot(Global_active_power~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~Datetime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

# Save to file
dev.copy(png, file="plot4.png", height=480, width=480)

#Close the device.
dev.off()