# PM2.5 Emissions Data (summarySCC_PM25.rds): This file contains a data frame with
# all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008. For each year, 
# the table contains number of tons of PM2.5 emitted from a specific type of 
# source for the entire year. Here are the first few rows.
# 
# fips: A five-digit number (represented as a string) indicating the U.S. county
# SCC: The name of the source as indicated by a digit string (see source code 
#      classification table)
# Pollutant: A string indicating the pollutant
# Emissions: Amount of PM2.5 emitted, in tons
# type: The type of source (point, non-point, on-road, or non-road)
# year: The year of emissions recorded
# 
# Source Classification Code Table (Source_Classification_Code.rds): This table
# provides a mapping from the SCC digit strings in the Emissions table to the
# actual name of the PM2.5 source. The sources are categorized in a few different
# ways from more general to more specific and you may choose to explore whatever
# categories you think are most useful. For example, source “10100101” is known
# as “Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal”.
# 
# The overall goal of this assignment is to explore the National Emissions 
# Inventory database and see what it say about fine particulate matter pollution 
# in the United states over the 10-year period 1999–2008. You may use any R 
# package you want to support your analysis.

# 5. How have emissions from motor vehicle sources changed from 1999–2008 
# in Baltimore City?

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

# Get vehicle pattern
vehicle_pattern <- grep('Vehicle', SCC$SCC.Level.Two, ignore.case = TRUE)
vehicle_tab <- SCC[vehicle_pattern,]

# Get vehicle related emissions
pm <- filter(NEI, fips == "24510" & SCC %in% vehicle_tab$SCC) %>%
    group_by(year) %>%
    summarise(Baltimore_Vehicle_Emissions = sum(Emissions, na.rm = TRUE))
with(pm, plot(year, Baltimore_Vehicle_Emissions, pch = 20))

# # Create plot file
# 
# png(filename = 'plot5.png')
# Sys.setlocale("LC_TIME", "English")
# with(pm, plot(year, Baltimore_Vehicle_Emissions, pch = 20))
# dev.off()