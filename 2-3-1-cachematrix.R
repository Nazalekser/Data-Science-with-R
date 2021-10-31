## Create a special "matrix" object that can cache its inverse,
## compute the inverse of the special "matrix".

# This function creates a special "matrix", which is really 
# a list containing a function to
# 1. set the values of the matrix
# 2. get the values of the matrix
# 3. set the values of the inverse of the matrix
# 4. get the values of the inverse of the matrix

makeCacheMatrix <- function(x = matrix()) {
    inv <- NULL
    set <- function(y){
        x <<- y
        inv <<- NULL
    }
    get <- function() x
    setinv <- function(inverse) inv <<- inverse
    getinv <- function() inv
    list(set = set, get = get, setinv = setinv, getinv = getinv)
}


## Computing the inverse of a square matrix

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
    inv <- x$getinv()
    if (!is.null(inv)){
        message('getting cached data')
        return(inv)
    }
    data <- x$get()
    inv <- solve(data)
    x$setinv (inv)
    inv
}
