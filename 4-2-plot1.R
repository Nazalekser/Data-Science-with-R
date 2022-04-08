
# 1. Have total emissions from PM2.5 decreased in the United States from 1999 to
# 2008? Using the base plotting system, make a plot showing the total PM2.5 
# emission from all sources for each of the years 1999, 2002, 2005, and 2008.

filename <- "exdata_data_NEI_data.zip"

# Download and unzip the dataset:
if (!file.exists(filename)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(fileURL, filename, method="curl")
}  
if (!file.exists("summarySCC_PM25.rds")) { 
    unzip(filename) 
}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)

pm <- group_by(NEI, year) %>% 
    summarise(Emissions = sum(Emissions, na.rm = TRUE))
with(pm, plot(year, Emissions))

# Create plot file

# png(filename = 'plot1.png')
# Sys.setlocale("LC_TIME", "English")
# with(pm, plot(year, Emissions))
# dev.off()