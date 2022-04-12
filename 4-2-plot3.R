# 3. Of the four types of sources indicated by the type(point, nonpoint, onroad,
# nonroad) variable, which of these four sources have seen decreases in 
# emissions from 1999–2008 for Baltimore City? Which have seen increases in 
# emissions from 1999–2008? Use the ggplot2 plotting system to make a plot 
# answer this question.

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

pm <- group_by(NEI, year, type) %>% 
    summarise(Emissions = sum(Emissions, na.rm = TRUE))

library(ggplot2)

g <- ggplot(pm, aes(year, Emissions))
g + geom_point() + facet_wrap(.~type, nrow = 2, ncol = 2)

# Create plot file

# png(filename = 'plot3.png')
# Sys.setlocale("LC_TIME", "English")
# g + geom_point() + facet_wrap(.~type, nrow = 2, ncol = 2)
# dev.off()