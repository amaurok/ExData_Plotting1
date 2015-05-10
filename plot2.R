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

#Plot the requested graphic.
plot(dataSubSet$Global_active_power~dataSubSet$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
