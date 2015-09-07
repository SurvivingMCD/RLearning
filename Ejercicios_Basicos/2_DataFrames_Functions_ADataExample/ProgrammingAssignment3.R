
outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome)
lapply(outcome,class)
ncol(outcome) # 46 columns
names(outcome)

outcome[, 11] <- as.numeric(outcome[, 11])#rewrites the data in numeric format
hist(outcome[, 11])#plots the histogram of the data


outcome[which(outcome[, 11] < 12),c(2,6,7,11)]#on my own, check which hospital have a heart rate mortality less than 12%

best <- function(state, outcome) {
  #print(state)
  #print(outcome)
  #state <- "TX"
  #outcome <- "pneumonia"
  outcomes <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  validoutcomes <- c("heart attack","heart failure","pneumonia")
  outcomecolumn <- c(11,17,23)
  validStates <- levels(as.factor(outcomes[,7]))
  stateindex <- which(state == states)
  outcomeindex <- which(outcome == validoutcomes)
  if(length(stateindex) == 0) {
    #stop(state," is not a valid state name")
    stop("invalid state")
  }
  if(length(outcomeindex) == 0) {
    #stop(outcome," is not a valid outcome name, must be heart attack or heart failure or pneumonia")
    stop("invalid outcome")
  }
  subset.outcomes <-outcomes[which(outcomes[,7]==state),]
  subset.outcomes <- cbind(subset.outcomes[,c(2,7)],as.numeric((subset.outcomes[,outcomecolumn[outcomeindex]])))
  subset.outcomes <- subset.outcomes[order(subset.outcomes[,3],subset.outcomes[,1]),]
  subset.outcomes[1,1]
  ## Read outcome data
  ## Check that state and outcome are valid
  ## Return hospital name in that state with lowest 30-day death
  ## rate
}


rankhospital <- function(state, outcome, num = "best") {
  #state <- "TX"
  #outcome <- "pneumonia"
  outcomes <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  validoutcomes <- c("heart attack","heart failure","pneumonia")
  outcomecolumn <- c(11,17,23)
  validStates <- levels(as.factor(outcomes[,7]))
  stateindex <- which(state == states)
  outcomeindex <- which(outcome == validoutcomes)
  if(length(stateindex) == 0) {
    #stop(state," is not a valid state name")
    stop("invalid state")
  }
  if(length(outcomeindex) == 0) {
    #stop(outcome," is not a valid outcome name, must be heart attack or heart failure or pneumonia")
    stop("invalid outcome")
  }
  subset.outcomes <- outcomes[which(outcomes[,7]==state),]
  subset.outcomes <- cbind(subset.outcomes[,c(2,7)],as.numeric((subset.outcomes[,outcomecolumn[outcomeindex]])))
  subset.outcomes <- subset.outcomes[order(subset.outcomes[,3],subset.outcomes[,1]),]
  subset.outcomes <- subset.outcomes[which(complete.cases(subset.outcomes)),]
  if(num == "best"){
    num <- 1
  }
  if(num == "worst"){
    num <-  nrow(subset.outcomes)
  }
  if(num > nrow(subset.outcomes)) {
    return(NA)
  }
  subset.outcomes[num,1]
  
  
  ## Read outcome data
  ## Check that state and outcome are valid
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
}

rankall <- function(outcome, num = "best") {
  outcomes <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  validoutcomes <- c("heart attack","heart failure","pneumonia")
  outcomecolumn <- c(11,17,23)
  validStates <- levels(as.factor(outcomes[,7]))
  outcomeindex <- which(outcome == validoutcomes)
  if(length(outcomeindex) == 0) {
    #stop(outcome," is not a valid outcome name, must be heart attack or heart failure or pneumonia")
    stop("invalid outcome")
  }
  result.df <- data.frame(rep(NA,54),rep(NA,2))#creates an empty data frame of 54 rows and 2 columns
  names(result.df) <- c("hospital","state")
  for(i in seq_along(validStates)) {
    tempnum <- num
    result.df[i,2] <- validStates[i]
    subset.outcomes <- outcomes[which(outcomes[,7]==validStates[i]),]
    subset.outcomes <- cbind(subset.outcomes[,c(2,7)],as.numeric((subset.outcomes[,outcomecolumn[outcomeindex]])))
    subset.outcomes <- subset.outcomes[order(subset.outcomes[,3],subset.outcomes[,1]),]
    subset.outcomes <- subset.outcomes[which(complete.cases(subset.outcomes)),]
    tempnum <- num
    if(num == "best"){
      tempnum <- 1
    }
    if(num == "worst"){
      tempnum <-  nrow(subset.outcomes)
    }
    if(tempnum > nrow(subset.outcomes)) {
      result.df[i,1] <- "<NA>"
    }
    else {
      result.df[i,1] <- subset.outcomes[tempnum,1]
    }
    
  }
  result.df
  ## Read outcome data
  ## Check that state and outcome are valid
  ## For each state, find the hospital of the given rank
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
}







