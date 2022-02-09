# The function takes three arguments: the 2-character 
# abbreviated name of a state (state), an outcome 
# (outcome),and the ranking of a hospital in that state
# for that outcome (num).The function reads the 
# outcome-of-care-measures.csv file and returns a 
# character vector with the name of the hospital that 
# has the ranking specified by the num argument. The rule 
# of the outcome is the same as for the function 'best'.
# The num argument can take values \best", \worst", or an 
# integer indicating the ranking (smaller numbers are better).

rankhospital <- function(state, outcome, num = 'best') {
  
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
    if(outcome %in% outcomes == FALSE) {stop("invalid outcome")}
    states <- unique(data[, 2])
    if(state %in% states == FALSE) {stop("invalid state")}
    
    # Get only the rows with our state value    
    data <- data[data$state == state & data[outcome] != 'Not Available', ]

    # Order the data by name and outcome
    data[outcome] <- as.data.frame(sapply(data[outcome], as.numeric))
    data <- data[order( data[outcome], data$name), ]
    
    # Check if outcome is the 'best' or 'worst'
    if( num == "best" ) {num <- which.min(data[, outcome])}
    else if( num == "worst" ) {num <- which.max(data[, outcome])}
    
    # Return hospital name in that state with lowest 30-day death rate
    return (data[num, ]$name)
    
}