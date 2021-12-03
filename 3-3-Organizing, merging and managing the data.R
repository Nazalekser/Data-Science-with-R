# 1. The American Community Survey distributes downloadable data about United
# States communities. Download the 2006 microdata survey about housing for the 
# state of Idaho using download.file() and load the data into R. The code book,
# describing the variable names is here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
# Create a logical vector that identifies the households on greater than 10 
# acres who sold more than $10,000 worth of agriculture products. Assign that 
# logical vector to the variable agricultureLogical. Apply the which() function 
# like this to identify the rows of the data frame where the logical vector is 
# TRUE. which(agricultureLogical) - What are the first 3 values that result?

url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
download.file(url, destfile = 'getdata%2Fdata%2Fss06hid.csv', mode='wb')
data <- read.csv('getdata%2Fdata%2Fss06hid.csv')
agricultrureLogical <- data$ACR ==3 & data$AGS == 6
print(which(agricultrureLogical))

# 2. Using the jpeg package read in the following picture of your instructor
# into R: https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg 
# Use the parameter native=TRUE. What are the 30th and 80th quantiles of the 
# resulting data? (some Linux systems may produce an answer 638 different for
# the 30th quantile)

library(jpeg)
url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg'
download.file(url, destfile = 'getdata%2Fjeff.jpg', mode = 'wb')
data <- readJPEG('getdata%2Fjeff.jpg', native = TRUE)
print(quantile(data, probs = c(0.3, 0.8)))

# 3. Load the Gross Domestic Product data for the 190 ranked countries in this 
# data set: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 
# Load the educational data from this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
# Match the data based on the country shortcode. How many of the IDs match?
# Sort the data frame in descending order by GDP rank (so United States is last).
# What is the 13th country in the resulting data frame?

data <- read.csv('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv')
data1 <- read.csv('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv')

mergedData <- merge(data, data1, by.x = 'X', by.y = 'CountryCode')
mergedData$Gross.domestic.product.2012 <- as.numeric(mergedData$Gross.domestic.product.2012)
sortedData <- mergedData[order(mergedData$Gross.domestic.product.2012, 
                               decreasing = TRUE, na.last = NA),]
print(length(sortedData$X))
print(sortedData$X.2[13])

# 4. What is the average GDP ranking for the "High income: OECD" and "High 
# income: nonOECD" group?  

library(dplyr)

HighIncOECD <- filter(sortedData, Income.Group == 'High income: OECD')
print(mean(HighIncOECD$Gross.domestic.product.2012))

HighIncNonOECD <- filter(sortedData, Income.Group == 'High income: nonOECD')
print(mean(HighIncNonOECD$Gross.domestic.product.2012))

# 5. Cut the GDP ranking into 5 separate quantile groups. Make a table versus 
# Income.Group. How many countries are Lower middle income but among the 38 
# nations with highest GDP?

qq <- quantile(sortedData$Gross.domestic.product.2012)
sortedData <- mutate(sortedData, GDP.quint = cut(Gross.domestic.product.2012,
                                                 qq, include.lowest = TRUE))
View(sortedData[, c("Gross.domestic.product.2012", "GDP.quint", "Income.Group")])
print(nrow(filter(sortedData, Gross.domestic.product.2012 <= 38
                  & Income.Group == 'Lower middle income')))