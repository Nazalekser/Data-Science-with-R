# 4. Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?

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

# Get coal consumption pattern
coal_pattern <- grep('.Coal.',SCC$Short.Name)
coal_tab <- SCC[coal_pattern,]

# Get coal consumption related emissions
pm <- filter(NEI, SCC==coal_tab$SCC) %>% 
    group_by(year) %>% 
    summarise(Emissions = sum(Emissions, na.rm = TRUE))

with(pm, plot(year, Emissions))

# Create plot file

png(filename = 'plot4.png')
Sys.setlocale("LC_TIME", "English")
with(pm, plot(year, Emissions))
dev.off()