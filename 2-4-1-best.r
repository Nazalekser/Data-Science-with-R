# The function takes two arguments: the 2-character
# abbreviated name of a state and an outcome name. The 
# function reads the outcome-of-care-measures.csv file 
# and returns a character vector with the name of the
# hospital that has the best (i.e. lowest) 30-day 
# mortality for the specified outcome in that state. The
# hospital name is the name provided in the Hospital.Name 
# variable. The outcomes can be one of \heart attack", 
# \heart failure", or \pneumonia". Hospitals that do not
# have data on a particular outcome should be excluded
# from the set of hospitals when deciding the rankings.

# If hospitals \b", \c", and \f" are tied for best, then
# hospital \b" should be returned (alphabetical order).
# The function should check the validity of its arguments.

best <- function(state, outcome) {
    # Read outcome data
    outcome_data <- read.csv('outcome-of-care-measures.csv', 
                             colClasses = 'character')
    
    # Check that state and outcome are valid
    if (!is.element(state, outcome_data$State)) 
        stop('invalid state')
    if (outcome == 'heart attack'){
        outcome_data[, 11] <- as.numeric(outcome_data[, 11])
        raw_data <- outcome_data[, 11]
    }else if (outcome == 'heart failure') {
        outcome_data[, 17] <- as.numeric(outcome_data[, 17])
        raw_data <- outcome_data[, 17]
    }else if (outcome == 'pneumonia') {
        outcome_data[, 23] <- as.numeric(outcome_data[, 23])
        raw_data <- outcome_data[, 23]
    }else {
        stop('invalid outcome')
    }

    # Delete rows with NA on a particular outcome
    data_without_na <- raw_data[!is.na(raw_data)]
    all_states <- outcome_data$State[!is.na(raw_data)]
    all_hospitals <- outcome_data$Hospital.Name[!is.na(raw_data)]

    # Vectors of the 30-day mortality and Hospital's 
    # names for the specified outcome in that state
    data_state <- data_without_na[all_states == state]
    hospital_names <- all_hospitals[all_states == state]
    
    # Vector of the index(es) of the lowest 30-day 
    # mortality for the specified outcome in that state
    min_data_state <- which(data_state == min(data_state))
        
    # Hospital(s) that has(ve) the lowest 30-day 
    # mortality for the specified outcome in that state
    hospital_names <- hospital_names[min_data_state]
    
    # Return hospital name in that state with lowest
    # 30-day death rate (first sorted)
    return(sort(hospital_names)[1])
    
}