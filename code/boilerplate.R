# A boilerplate R script
MyFunction <- function(Arg1, Arg2) {
  print(paste("Argument", as.character(Arg1), "is", class(Arg1)))
  print(paste("Argument", as.character(Arg2), "is", class(Arg2)))

  return(c(Arg1, Arg2))
}

MyFunction(1,2)
MyFunction("riki", "Tiki")

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
