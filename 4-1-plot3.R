# Measurements of electric power consumption in one household with a one-minute
# sampling rate over a period of almost 4 years. Different electrical quantities
# and some sub-metering values are available.
# https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption
# Our overall goal here is simply to examine how household energy usage varies
# over a 2-day period in February, 2007. Your task is to reconstruct the
# following plots below, all of which were constructed using the base plotting 
# system.

# For each plot you should:
 # - Construct the plot and save it to a PNG file with a width of 480 pixels and 
 #   a height of 480 pixels.
 # - Name each of the plot files as plot1.png, plot2.png etc.
 # - Create a separate R code file (plot1.R, plot2.R etc.) that constructs the
 #   corresponding plot, i.e. code in plot1.R constructs the plot1.png plot. 
 #   Your code file should include code for reading the data so that the plot 
 #   can be fully reproduced. You must also include the code that creates the 
 #   PNG file.
 # - Add the PNG file and R code file to the top-level folder of your git 
 #   repository (no need for separate sub-folders)

filename <- "household_power_consumption.zip"

# Download and unzip the dataset:
if (!file.exists(filename)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileURL, filename, method="curl")
}  
if (!file.exists("household_power_consumption.txt")) { 
    unzip(filename) 
}

# Fast loading data with fread (data.table package)

library(data.table)

col_names <- colnames(fread("household_power_consumption.txt", nrows = 100))
data <- fread("household_power_consumption.txt", nrows = 4000, skip = 66000,
              col.names = col_names)

# Check missing values

which(data == '?')

library(lubridate)
library(dplyr)

# Filter needed variables

data1 <- data
data1$Date <- dmy(data$Date)
data1 <- filter(data1, Date > '2007-01-31' & Date < '2007-02-03')

# Join dates and times to a new variable

data1$joined_date <- paste(data1$Date, data1$Time)

# Convert joined_date variable to the Date/Time class

data2 <- data1
data2$joined_date <- ymd_hms (data2$joined_date)

# Plot graph

Sys.setlocale("LC_TIME", "English")
with(data2, plot(joined_date, Sub_metering_1, type = 'l', xlab = "",
                 ylab = 'Energy sub metering'))
lines(data2$joined_date, data2$Sub_metering_2, col = 'red')
lines(data2$joined_date, data2$Sub_metering_3, col = 'blue')

legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       lty = c(1, 1, 1), col = c('black', 'red', 'blue'))

# Create plot file

#png(filename = 'plot3.png')
#Sys.setlocale("LC_TIME", "English")
#with(data2, plot(joined_date, Sub_metering_1, type = 'l', xlab = "",
#                 ylab = 'Energy sub metering'))
#lines(data2$joined_date, data2$Sub_metering_2, col = 'red')
#lines(data2$joined_date, data2$Sub_metering_3, col = 'blue')

#legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
#       lty = c(1, 1, 1), col = c('black', 'red', 'blue'))
# dev.off()
