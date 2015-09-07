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