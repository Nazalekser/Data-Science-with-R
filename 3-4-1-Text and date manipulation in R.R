# 1. The American Community Survey distributes downloadable data about United States
# communities. Download the 2006 microdata survey about housing for the state of
# Idaho using download.file() from here: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
# and load the data into R. The code book, describing the variable names is here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
# Apply strsplit() to split all the names of the data frame on the characters 
# "wgtp". What is the value of the 123 element of the resulting list?

url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
download.file(url, destfile = 'getdata%2Fdata%2Fss06hid.csv', mode = 'wb')
data <- read.csv('getdata%2Fdata%2Fss06hid.csv')

print(strsplit(names(data), 'wgtp')[123])

# 2. Load the Gross Domestic Product data for the 190 ranked countries in this
# data set: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# Remove the commas from the GDP numbers in millions of dollars and average them.
# What is the average?
# Original data sources: http://data.worldbank.org/data-catalog/GDP-ranking-table

data <- read.csv('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv')

gdp <- data[, 5][!is.na(as.numeric(data[, 2]))] # load GDP for 190 counties
gdp <- gsub(',', '', gdp) # remove the comas

print(mean(as.numeric(gdp))) # average of GDP

# 3. In the data set from Question 2 what is a regular expression that would
# allow you to count the number of countries whose name begins with "United"? 
# Assume that the variable with the country names in it is named countryNames. 
# How many countries begin with United? 

print(length(grep("^United",data$X.2)))

# 4. Load the Gross Domestic Product data for the 190 ranked countries in this data
# set: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 
# Load the educational data from this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
# Match the data based on the country shortcode. Of the countries for which the
# end of the fiscal year is available, how many end in June?
# Original data sources: 
# http://data.worldbank.org/data-catalog/GDP-ranking-table
# http://data.worldbank.org/data-catalog/ed-stats

data1 = read.csv('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv')

mergedData <- merge(data, data1, by.x = 'X', by.y = 'CountryCode')

print(length(grep('June', mergedData$Special.Notes)))

# 5. You can use the quantmod (http://www.quantmod.com/) package to get 
# historical stock prices for publicly traded companies on the NASDAQ and NYSE.
# Use the following code to download data on Amazon's stock price and get the
# times the data was sampled. How many values were collected in 2012? How many 
# values were collected on Mondays in 2012?

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

library(lubridate)

print(length(sampleTimes[year(sampleTimes) == 2012]))
print(length(sampleTimes[year(sampleTimes) == 2012 & wday(sampleTimes) == 2]))