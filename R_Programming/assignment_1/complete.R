complete <- function(directory, id = 1:332) {
  WD <- getwd()
  setwd(directory)
  nobs <- c()
  for(i in id) {
    prefix <- if(i < 10) {
      "00"
    }
    else if(i < 100) {
      "0"
    }
    fileName <- paste(prefix, as.character(i), ".csv", sep = "")
    complete <- complete.cases(read.csv(fileName))
    nobs <- c(nobs, length(complete[complete == TRUE]))
  }
  setwd(WD)
  
  data.frame(id, nobs)
}