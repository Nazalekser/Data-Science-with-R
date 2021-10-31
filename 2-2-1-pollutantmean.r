pollutantmean <- function(directory, pollutant, id = 1:332) {
 
   ## Given a vector monitor ID numbers, 'pollutantmean' 
   ## reads that monitors' particulate matter data from 
   ## the directory specified in the 'directory' argument
   ## and returns the mean of the pollutant across all of
   ## the monitors, ignoring any missing values coded as NA.
     
   dir_1 <- 'C://Users/PC/Desktop/AI/DS/Data Science/2. R Programming/2. Programming with R/Assignment'
   dir_1 <- paste(dir_1, '/', directory, sep = '')
   p_sum <- 0
   p_len <- 0
   
   for (i in id) {         
       
       if (i %/% 100 > 0) {
           df <- read.csv(paste(dir_1, '/', i, '.csv', sep = ''))
       } else if (i %/% 10 > 0) {
           df <- read.csv(paste(dir_1, '/', paste('0', i, '.csv', sep = ''), sep = ''))
       } else {
           df <- read.csv(paste(dir_1, '/', paste('00', i, '.csv', sep = ''), sep = ''))
       }
       ## identification NAs
       is_na <- is.na(df[ , pollutant]) 
       ## delete NAs and compute sum
       p_sum <- sum(df[ , pollutant][!is_na]) + p_sum  
       ## number of cases
       p_len <- length(df[ , pollutant][!is_na]) + p_len
   }
   pmean <- p_sum / p_len
   return(pmean)
   } 

