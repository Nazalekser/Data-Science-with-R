# 1. The American Community Survey distributes downloadable data about United 
# States communities. Download the 2006 microdata survey about housing for 
# the state of Idaho using download.file() and load the data into R. The code
# book, describing the variable names is here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
# How many properties are worth $1,000,000 or more?

url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
df <- read.csv(url)
length(df$VAL[df$VAL == 24 & !is.na(df$VAL)])


# 3. Download the Excel spreadsheet on Natural Gas Aquisition Program.
# Read rows 18-23 and columns 7-15 into R and assign the result to a variable
# called: dat. What is the value of: sum(dat$Zip*dat$Ext,na.rm=T)?

library(xlsx)

url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx'
df <- download.file(url, destfile = 'getdata%2Fdata%2FDATA.gov_NGAP.xlsx', 
                     mode = 'wb')
dat <- read.xlsx('getdata%2Fdata%2FDATA.gov_NGAP.xlsx', sheetIndex = 1, 
                 colIndex = 7:15, rowIndex = 18:23)
sum(dat$Zip*dat$Ext,na.rm=T)


# 4. Read the XML data on Baltimore restaurants. How many restaurants have 
# zipcode 21231? 

library(XML)

url = 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml'
doc <- xmlTreeParse(sub('s', '', url), useInternalNodes=TRUE)  # remove 's'
df <- xmlRoot(doc)
zips <- xpathSApply(df, '//zipcode', xmlValue)
length(zips[zips == '21231'])

# 5. The American Community Survey distributes downloadable data about United
# States communities. Download the 2006 microdata survey about housing for 
# the state of Idaho using download.file(). Using the fread() command load the 
# data into an R object DT. The following are ways to calculate the average 
# value of the variable pwgp15 broken down by sex. Using the data.table package,
# which will deliver the fastest user time? 

url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
file <- fread(url)

library(data.table)

#system.time(read.table())
#sapply(split(DT$pwgtp15,DT$SEX),mean)
#DT[,mean(pwgtp15),by=SEX]
#mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
#tapply(DT$pwgtp15,DT$SEX,mean)
#rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
#mean(DT$pwgtp15,by=DT$SEX)

#Dataset hasn't SEX or pwgtp16 Values!
