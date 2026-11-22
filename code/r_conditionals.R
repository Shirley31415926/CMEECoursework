is.even <- function(n) {
  if (n %% 2 == 0) {
    return(paste(n, "is even"))
  } else {
    return(paste(n, "is odd"))
  }
}
is.even(2)

report_height <- function(height_m, digits = 2) {
  round(height_m, digits = digits)
}
report_height(2.312, digits = 1)
report_height(2.312)

is.power2 <- function(n) {
  # is an integer or not
  if (log2(n) %% 1 == 0) {
    print(paste(n, "is the power of 2"))
  } else {
    print(paste(n, "is not the power of 2"))
  }
}
is.power2(4)

is.prime <- function(n) {
    if (n == 0) {
        return(paste(n, "is nero"))
    } else if (n == 1) {
        return(paste(n, "is a unit"))
    }
    ints <- 2:(n-1)
    if (all(n %% ints != 0)) {
        return(paste(n, "is a prime"))
    } else {
       return(paste(n, "is not a composite"))
    }
}
is.prime(3)