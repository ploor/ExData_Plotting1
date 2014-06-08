## Notes:
#   The file names in the following char vectors
#   will be downloaded/stored in the working directory
#     filename
#     pngname

# My dates display in non-English, unless I change the locale
Sys.setlocale("LC_TIME", "English")

###############################################################################
## Constants (except for plot literals)
siteUrl <- "https://d396qusza40orc.cloudfront.net/"
filename <- "exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileUrl <- paste(siteUrl, filename, sep="")
filenameInZip <- "household_power_consumption.txt"
date1 <- as.Date("2007-02-01", format = "%Y-%m-%d")
date2 <- as.Date("2007-02-02", format = "%Y-%m-%d")
pngname <- "plot2.png"

###############################################################################
## download, unzip, read, and subset data
download.file(fileUrl, destfile=filename)

data <- read.table(unz(filename, filenameInZip)
                  ,header=TRUE
                  ,sep=";"
                  ,na.strings = "?")
# convert to date
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

data <- subset(data,  (data$Date == date1)
                    | (data$Date == date2))

#convert to numeric
data$Global_active_power <- as.numeric(data$Global_active_power)
#convert to POSIX
data$Time <- strptime(paste(data$Date, data$Time, sep=","), "%Y-%m-%d,%H:%M:%S")



###############################################################################
## open png device, plot, close png device
png(pngname, width=480, height=480)

plot(data$Time, data$Global_active_power
    ,pch=NA_integer_
    ,xlab=""
    ,ylab="Global Active Power (kilowatts)")

lines(data$Time, data$Global_active_power)

dev.off()