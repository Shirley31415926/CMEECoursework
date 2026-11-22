# Reference code
# observations <- read.csv("data/bootcamp_observations.csv", colClasses = "character", na.strings = "", check.names = FALSE) # nolint
# str(observations)
# print(observations)

# My defined function: read_observations()
# Check the exact column names, reject empty sites or dates
# Stop with an informative error when a rule fails.
# It stops when value is not a non-negative integer.


invalid_obs <- "data/bootcamp_observations_invalid.csv"
obs <- "data/bootcamp_observations.csv"
read_observations <- function(path) {
  observations_invalid <- read.csv(file = path,
    colClasses = "character", na.strings = "", check.names = TRUE
  )
  valid_values <- c()
  for (value in observations_invalid$count) {
    if (is.na(value)) {
      valid_values <- c(valid_values, value)
    } else if (grepl("^(0|[1-9][0-9]*)$", value)) {
      valid_values <- c(valid_values, as.integer(value))
    } else {
      stop(paste(value, "is not a non-negative integer."))
    }
  }
  observations_invalid$count <- valid_values
  write.csv(observations_invalid,
    "results/bootcamp_observations_validated.csv", row.names = FALSE
  )
  return("Validated data stored")
}

read_observations(obs)
read_observations(invalid_obs)

summarise_observations <- function(data) {

}

invalid_obs <- "data/bootcamp_observations_invalid.csv"
obs <- "data/bootcamp_observations.csv"
observations_invalid <- read.csv(file = obs,
  colClasses = "character", na.strings = "", check.names = TRUE
)
print(observations_invalid)
class(observations_invalid)


