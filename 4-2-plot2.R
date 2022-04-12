# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make a 
# plot answering this question.

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

pm <- filter(NEI, fips == "24510") %>% group_by(year) %>% 
    summarise(Emissions = sum(Emissions, na.rm = TRUE))
with(pm, plot(year, Emissions))

# #Create plot file
# 
# png(filename = 'plot2.png')
# Sys.setlocale("LC_TIME", "English")
# with(pm, plot(year, Emissions))
# dev.off()