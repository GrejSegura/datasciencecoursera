
pollutantmean <- function(directory, pollutant, id = 1:332) {
  
  dir_1 <- paste("C:/Users/mr_gr/Desktop/Coursera Assignments/Course 2/Week 2 - Programming Assignment/", directory, sep ="")

  file_names <- list.files(path = dir_1, pattern = ".csv", full.names = TRUE)
  
  
  data_1 <- numeric()
  
  
  for (i in id){
    
    x <- read.csv(file_names[i], header = TRUE)
    data_1 <- c(data_1, x[[pollutant]])
    
  }
  
  m <- mean(data_1, na.rm = TRUE)
  print(m)
  
}
