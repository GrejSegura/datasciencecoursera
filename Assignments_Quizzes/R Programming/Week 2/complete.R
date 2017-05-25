
complete <- function(directory, id = 1:332) {
  
  dir_1 <- paste("C:/Users/mr_gr/Desktop/Coursera Assignments/Course 2/Week 2 - Programming Assignment/", directory, sep ="")
  
  file_names <- list.files(path = dir_1, pattern = ".csv", full.names = TRUE)
  
  
  ids <- numeric()
  nobs <- numeric()
  
  for (i in id) {
    
    x <- read.csv(file_names[i], header = TRUE)
    
    x <- x[which(!(is.na(x$sulfate))),]
    
    p <- nrow(x)
    
    nobs <- c(nobs, p)
    ids <- c(ids, i)
    
  }
  
  complete_data <- cbind(ids, nobs)
  print(complete_data)
}
