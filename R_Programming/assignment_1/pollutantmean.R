pollutantmean <- function(directory, pollutant, id = 1:332) {
  WD <- getwd()
  setwd(directory)
  data <- c()
  for(i in id) {
    prefix <- if(i < 10) {
      "00"
    }
    else if(i < 100) {
      "0"
    }
    fileName <- paste(prefix, as.character(i), ".csv", sep = "")
    data <- c(read.csv(fileName)[[pollutant]], data)
  }
  setwd(WD)
  
  round(mean(data, na.rm = TRUE), 3)
}