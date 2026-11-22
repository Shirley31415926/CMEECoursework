# A boilerplate R script
MyFunction <- function(Arg1, Arg2) {
  print(paste("Argument", as.character(Arg1), "is", class(Arg1)))
  print(paste("Argument", as.character(Arg2), "is", class(Arg2)))

  return(c(Arg1, Arg2))
}

MyFunction(1,2)
MyFunction("riki", "Tiki")
