
corr <- function(directory, threshold = 0) {
  
  dir_1 <- paste("C:/Users/mr_gr/Desktop/Coursera Assignments/Course 2/Week 2 - Programming Assignment/", 
                 directory, sep ="")
  
  file_names <- list.files(path = dir_1, pattern = ".csv", full.names = TRUE)
  
  
  cor_values <- numeric()
  
  for (i in 1:length(file_names)) {
    
    x <- read.csv(file_names[i], header = TRUE)
    
    x <- x[which(!(is.na(x$sulfate))),]
    x <- x[which(!(is.na(x$nitrate))),]
    
    
    p <- nrow(x)
    
    if (p < threshold) {
      
      next
      
    }
    
    value <- cor(x$sulfate,x$nitrate, use = "na.or.complete")
    cor_values <- c(cor_values, value)
    
  }
  
  print(cor_values)

  }
