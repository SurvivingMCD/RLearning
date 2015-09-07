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