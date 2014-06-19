## makeCacheMatrix creates a special purpose list containing
## matrix, cached inverse, and necessary functions for 
## maintaining the cached inverse

## makeCacheMatrix takes a matrix and returns a list of
## the functions necessary for accessing the set matrix
## and cached inverse, as well as methods to replace
## the set matrix and set the cached inverse
makeCacheMatrix <- function(x = matrix()) {
  i <- NULL

  # function to set stored matrix
  set <- function(y) {
    x <<- y
    i <<- NULL # matrix has changed, invalidate cached inverse
  }

  # accessor for stored matrix
  get <- function() x

  # set cached inverse
  setinverse <- function(inverse) i <<- inverse

  # retrieve cached inverse
  getinverse <- function() i

  list(set= set, get = get, 
       setinverse = setinverse, 
       getinverse = getinverse)
}


## cacheSolve takes a list returned by makeCacheMatrix()
## and returns the inverse of the matrix represented.  If
## necessary, the inverse is computed and cached in the 
## makeCacheMatrix() returned list using the methods provided
cacheSolve <- function(x, ...) {
  i <- x$getinverse()

  # if there's a cached inverse, return it
  if (!is.null(i)) return(m)

  # if getinverse() returned NULL then the inverse has not
  # been cached, or the cache was invalidated.  recompute
  # and cache new inverse
  data <- x$get()
  i <- solve(data, ...)
  x$setinverse(i)
  i
}
