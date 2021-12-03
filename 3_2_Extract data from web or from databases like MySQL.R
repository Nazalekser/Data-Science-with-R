# 1. Register an application with the Github API here 
# https://github.com/settings/applications. Access the API to get information
# on your instructors repositories (hint: this is the url you want 
# "https://api.github.com/users/jtleek/repos"). Use this data to find the 
# time that the datasharing repo was created. What time was it created? 

library(httr)

# Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/

oauth_endpoints("github")

# To make your own application, register at
#    https://github.com/settings/developers. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("github",
                   key = "4b51dbc381d0739da337",
                   secret = "09707f64105d8cbb663d26da0061274f8b9144a1"
)

# Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

#  Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/rate_limit", gtoken)
stop_for_status(req)
content(req)
json1 <- content(req)

library(jsonlite)

json2 = jsonlite::fromJSON(toJSON(json1))

names(json2)
json2$created_at

# 2013-11-07T13:25:07Z

#2. The sqldf package allows for execution of SQL commands on R data frames. 
# We will use the sqldf package to practice the queries we might send with 
# the dbSendQuery command in RMySQL. 

# Download the American Community Survey data and load it into an R object 
#called acs https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv

# Which of the following commands will select only the data for the probability 
# weights pwgtp1 with ages less than 50?

url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv'
acs <- read.csv(url)
head(sqldf("select pwgtp1 from acs where AGEP < 50"))

#4. How many characters are in the 10th, 20th, 30th and 100th lines of HTML from 
# this page: http://biostat.jhsph.edu/~jleek/contact.html (Hint: the nchar() 
# function in R may be helpful)

con <- url('http://biostat.jhsph.edu/~jleek/contact.html')
htmlCode <- readLines(url)
close(url)
nchar(htmlCode[10]); nchar(htmlCode[20]); nchar(htmlCode[30]); 
nchar(htmlCode[100])

#5. Read this data set into R and report the sum of the numbers in the fourth 
# of the nine columns. 
# https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for
# Original source of the data:
# http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for
# (Hint this is a fixed width file format)

urlfile <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
data <- read.fwf(file = url(urlFile),
                 skip = 4,
                 widths = c(12, 7, 4, 9, 4, 9, 4, 9, 4))
sum(data[4])