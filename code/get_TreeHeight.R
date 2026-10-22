# Generized input and output csv name
data_input <- commandArgs(trailingOnly = TRUE)
basename <- tools::file_path_sans_ext(basename(data_input))
data_output <- sprintf("%s_treeheights.csv", basename)

# Set input and output path directory
INPUT_PATH <- file.path(getwd(), data_input)
OUTPUT_PATH <- file.path(getwd(), "results", data_output)
# Read csv
MyData <- read.csv(INPUT_PATH)
class(MyData)
head(MyData)

# Calculate tree height
TreeHeight <- function(degrees, distance) {
    if (degrees > 0 && degrees < 90){
        radians <- degrees * pi / 180
    } else{
        stop("Angle degrees out of range")
    }
    if (distance > 0 && distance <= 100){
        height <- distance * tan(radians)
    } else{
        stop("Distance out of range")
    }
    return(height)
}
CalHeight <- function(data){
    data$TreeHeight <- NA_real_
    for (i in seq_len(nrow(data))) {
    degrees <- as.numeric(data[["Angle.degrees"]][i])
    distance <- as.numeric(data[["Distance.m"]][i])
    treeht <- TreeHeight(degrees, distance)
    data$TreeHeight[i] <- treeht
    }
    return(data)
}


# Write output csv
WriteHeigtcsv <- function(data = MyData){
    final_data <- CalHeight(data)
    write.csv(final_data, OUTPUT_PATH, row.names = FALSE)
}

WriteHeigtcsv()