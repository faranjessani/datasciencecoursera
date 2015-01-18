corr <- function(directory, threshold = 0) {
  WD <- getwd()
  setwd(directory)
  correlations <- c()
  tryCatch({
    for(i in list.files()) {
      data <- read.csv(i)
      complete <- complete.cases(data)
      if(length(complete[complete == TRUE]) > threshold) {
        correlations <- c(correlations, cor(data$sulfate, data$nitrate, use = "complete.obs"))
      }
    }
    
    if(is.null(correlations)) {
      correlations <- vector("numeric")
    }
  }, finally = {
    setwd(WD)
  })
  
  correlations
}