## This file is part of the Programming Assignment 2 of the R programming course session 09 from John Hopkins University
## The purpose of these functions are to show how lexical scoping can be used to avoid lengthy computations when calculating
## the inverse of a Matrix. These functions create a list of four functions with setter and getter methods in the parent.environment

## Creates a list of four functions that allow to modify the contents of the input matrix and it´s inverse

makeCacheMatrix <- function(x = matrix()) {
    minv <- NULL
    
    set <- function(y) {
      x <<- y
      minv <<- NULL
    }
    get <- function() x
    setinverse <- function(inverse) minv <<- inverse
    getinverse <- function() minv
    list(set = set, get = get,
         setinverse = setinverse,
         getinverse = getinverse)
}



## Receives the list of functions and access the original matrix to calculate the inverse if it has not yet been calculated.

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
        minv <- x$getinverse()
        if(!is.null(minv)) {
          message("getting cached inverse")
          return(minv)
        }
        originalmatrix <- x$get()
        minv <- solve(originalmatrix,...)
        x$setinverse(minv)
        minv
}
