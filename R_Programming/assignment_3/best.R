best <- function(state, outcome) {
  ## Supress warnings incited by the cast
  options(warn=-1)
  
  ## Read outcome data
  data <- readData()
  
  ## Check that state and outcome are valid
  col <- getOutcomeColumn(outcome)
  
  if(sum(data$State == state) == 0) {
    stop("invalid state")
  }

  ## Return hospital name in that state with lowest 30-day death
  ## rate
  filteredData <- data[data$State == state, c(2, col)]
  filteredData[, 2] <- sapply(filteredData[, 2], as.numeric)
  hospitalName <- filteredData[order(filteredData[2], filteredData[1]),][1, 1]
  print(hospitalName)
}

readData <- function() {
  read.csv("outcome-of-care-measures.csv", colClasses = "character")
}

getOutcomeColumn <- function(outcome) {
  if(outcome == "heart attack") {
    col <- 11
  }
  else if(outcome == "heart failure") {
    col <- 17
  }
  else if(outcome == "pneumonia") {
    col <- 23
  }
  else {
    stop("invalid outcome")
  }
}
