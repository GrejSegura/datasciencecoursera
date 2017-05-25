
# Coursera : Data Scientist Specialization
# Course 2 : Week 3 Assignment

#############################################
# The purpose of these 2 functions are to save time as matrix inversion is very time consuming.
# Caching the computed inverse of a matrix is beneficial as computing repeteadly may cost so much time.


# 1. This function creates a special "matrix" object that can cache its inverse.

makeCacheMatrix <- function(x = matrix()) {
  m <- NULL
  set <- function(y = matrix()) {
    x <<- y*
    m <<- NULL
  }
  get <- function() x
  setInverse <- function(inverse) m <<- inverse
  getInverse <- function() m
  list(set = set, get = get,
       setInverse = setInverse,
       getInverse = getInverse)
}


# 2. This function computes the inverse of a matrix.
# But before it computes, it checks first if the matrix has already been computed and returned by makeCacheMatrix.


cacheSolve <- function(x, ...) {
  m <- x$getInverse()
  if(!is.null(m)) {
    message("loading...")
    return(m)
  }
  data <- x$get()
  m <- solve(data, ...)
  x$setInverse(m)
  m
}
