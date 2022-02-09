# Write a function called rankall that takes two arguments: an outcome name 
# (outcome) and a hospital ranking (num). The function reads the
# outcome-of-care-measures.csv file and returns a 2-column data frame containing
# the hospital in each state that has the ranking specifed in num. The function
# should return a value for every state (some may be NA). The first column in 
# the data frame is named hospital, which contains the hospital name, and the 
# second column is named state, which contains the 2-character abbreviation for
# the state name. Hospitals that do not have data on a particular outcome should
# be excluded from the set of hospitals when deciding the rankings.

rankall <- function(outcome, num = 'best') {
    
    # Read outcome data
    data <- read.csv('outcome-of-care-measures.csv', colClasses = 'character')
    
    data <- data[c(2, 7, 11, 17, 23)]
    names(data)[1] <- "name"
    names(data)[2] <- "state"
    names(data)[3] <- "heart attack"
    names(data)[4] <- "heart failure"
    names(data)[5] <- "pneumonia"
    
    # Check that state and outcome are valid
    outcomes = c("heart attack", "heart failure", "pneumonia")
    if(outcome %in% outcomes == FALSE) stop("invalid outcome")
    
    states <- unique(data[, 'state'])
    
    # Get only the rows with not NA value    
    data <- data[data[outcome] != 'Not Available', ]
    
    # Order the data by name and outcome
    data[outcome] <- as.data.frame(sapply(data[outcome], as.numeric))
    data <- data[order(data[outcome], data$name), ]
    
    result <- data.frame()
    
    # Find the hospital of given rank for each state
    for (s in states){
        data_state <- data[data$state == s, ]
        vals <- data_state[, outcome]
        if( num == "best" ) rowNum <- which.min(vals)
        else if( num == "worst" ) rowNum <- which.max(vals)
        else rowNum <- num
        #result <- rbind(result, data_state[rowNum, c('name', 'state')])
        result <- rbind(result, data.frame(name=data_state[rowNum, ]$name, state=s))
    }
    
    return (result[order(result['state']), ])
}    