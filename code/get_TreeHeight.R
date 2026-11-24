#!/usr/bin/env Rscript

# Generalised input and output CSV names
data_input <- commandArgs(trailingOnly = TRUE)

# Check that exactly one input file is provided
if (length(data_input) != 1) {
    stop("Usage: Rscript code/get_TreeHeight.R <input_csv>")
}

# Set input and output paths
INPUT_PATH <- file.path(getwd(), data_input)

# Check that the input file exists
if (!file.exists(INPUT_PATH)) {
    stop("Input file does not exist: ", INPUT_PATH)
}

if (file.access(INPUT_PATH, 4) != 0) {
    stop("Input file is not readable: ", INPUT_PATH)
}

# Generate output filename from input filename
input_basename <- tools::file_path_sans_ext(basename(data_input))
data_output <- sprintf("%s_treeheights.csv", input_basename)

OUTPUT_PATH <- file.path(getwd(), "results", data_output)

# Create results directory if it does not exist
dir.create(dirname(OUTPUT_PATH), recursive = TRUE, showWarnings = FALSE)

# Read CSV
MyData <- read.csv(INPUT_PATH)

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
    data$TreeHeight <- NA_real_

    for (i in seq_len(nrow(data))) {
        degrees <- as.numeric(data[["Angle.degrees"]][i])
        distance <- as.numeric(data[["Distance.m"]][i])
        treeht <- TreeHeight(degrees, distance)
        data$TreeHeight[i] <- treeht
    }

    return(data)
}

# Write output CSV
WriteHeigtcsv <- function(data = MyData) {
    final_data <- CalHeight(data)
    write.csv(final_data, OUTPUT_PATH, row.names = FALSE)
}

WriteHeigtcsv()
