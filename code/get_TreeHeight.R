#!/usr/bin/env Rscript

# Generalised input and output CSV names
data_input <- commandArgs(trailingOnly = TRUE)

# Check that exactly one input file is provided
if (length(data_input) != 1) {
    stop("Usage: Rscript code/get_TreeHeight.R <input_csv>")
}

# Set input and output paths
INPUT_PATH <- normalizePath(data_input, mustWork = FALSE)

# Check that the input file exists and is readable
if (!file.exists(INPUT_PATH)) {
    stop("Input file does not exist: ", INPUT_PATH)
}

if (file.access(INPUT_PATH, 4) != 0) {
    stop("Input file is not readable: ", INPUT_PATH)
}

# Generate output filename from input basename
input_basename <- tools::file_path_sans_ext(basename(data_input))
data_output <- sprintf("%s_treeheights.csv", input_basename)

OUTPUT_PATH <- file.path(getwd(), "results", data_output)

# Read CSV
MyData <- read.csv(INPUT_PATH)

# Check required columns and their order
required_columns <- c("Species", "Distance.m", "Angle.degrees")

if (!identical(names(MyData), required_columns)) {
    stop("Input CSV must contain exactly: Species, Distance.m, Angle.degrees")
}

# Check numeric and finite measurements
if (!is.numeric(MyData$Distance.m) ||
    !is.numeric(MyData$Angle.degrees) ||
    any(!is.finite(MyData$Distance.m)) ||
    any(!is.finite(MyData$Angle.degrees))) {
    stop("Distance.m and Angle.degrees must contain finite numeric values")
}

# Check measurement ranges
if (any(MyData$Distance.m <= 0 | MyData$Distance.m > 100)) {
    stop("Distance.m must be greater than 0 and no greater than 100")
}

if (any(MyData$Angle.degrees <= 0 | MyData$Angle.degrees >= 90)) {
    stop("Angle.degrees must be greater than 0 and less than 90")
}

# Calculate tree height
TreeHeight <- function(degrees, distance) {
    if (degrees > 0 && degrees < 90) {
        radians <- degrees * pi / 180
    } else {
        stop("Angle degrees out of range")
    }

    if (distance > 0 && distance <= 100) {
        height <- distance * tan(radians)
    } else {
        stop("Distance out of range")
    }

    return(height)
}

CalHeight <- function(data) {
    data$height_m <- NA_real_

    for (i in seq_len(nrow(data))) {
        degrees <- data[["Angle.degrees"]][i]
        distance <- data[["Distance.m"]][i]
        #  browser()
        treeht <- TreeHeight(degrees, distance)
        data$height_m[i] <- treeht
    }

    return(data)
}

# Write output CSV
WriteHeigtcsv <- function(data = MyData) {
    final_data <- CalHeight(data)
    write.csv(final_data, OUTPUT_PATH, row.names = FALSE)
}

WriteHeigtcsv()
