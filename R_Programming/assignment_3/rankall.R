rankall <- function(outcome, num = "best") {
  ## Supress warnings incited by the cast
  options(warn=-1)
  
  ## Read outcome data
  data <- readData()
  
  ## Check that state and outcome are valid
  col <- getOutcomeColumn(outcome)
  
  if(num == "best") {
    sortOrder <- "positive"
    rowIndex <- 1
  } else if(num == "worst") {
    sortOrder <- "negative"
    rowIndex <- 1
  } else {
    sortOrder <- "positive"
    rowIndex <- num
  }
  
  filteredData <- data[, c(2, 7, col)]
  filteredData[, 3] <- sapply(filteredData[, 3], as.numeric)
  
  if(sortOrder == "negative")  {
    sortedData <- filteredData[order(filteredData$State, -filteredData[,3], filteredData[,1]),]
  } else {
    sortedData <- filteredData[order(filteredData$State, filteredData[,3], filteredData[,1]),]
  }
  
  splitData <- split(sortedData, sortedData$State)
  stateVector <- c()
  hospitalVector <- c()
  lapply(splitData, function(x) {
    stateVector <<- c(stateVector, x[1, 2])
    hospitalVector <<- c(hospitalVector, x[rowIndex, 1])
  })
  
  hospitalVector <- unlist(hospitalVector, use.names = FALSE)
  stateVector <- unlist(stateVector, use.names = FALSE)
  result <- data.frame(hospital=hospitalVector, state=stateVector)
  ## Read outcome data
  ## Check that state and outcome are valid
  ## For each state, find the hospital of the given rank
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
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
