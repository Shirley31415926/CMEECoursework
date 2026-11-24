# This function calculates heights of trees given distance of each tree 
# from its base and angle to its top, using  the trigonometric formula 
#
# height = distance * tan(radians)
#
# ARGUMENTS
# degrees:   The angle of elevation of tree
# distance:  The distance from base of tree (e.g., meters)
#
# OUTPUT
# The heights of the tree, same units as "distance"

# Set input and output paths
INPUT_PATH <- file.path(getwd(), "data", "trees.csv")
OUTPUT_PATH <- file.path(getwd(), "results", "TreeHts.csv")

# Check input file
if (!file.exists(INPUT_PATH)) {
    stop("Input file does not exist: ", INPUT_PATH)
}

if (file.access(INPUT_PATH, 4) != 0) {
    stop("Input file is not readable: ", INPUT_PATH)
}

# Read CSV
MyData <- read.csv(INPUT_PATH)

required_columns <- c("Species", "Distance.m", "Angle.degrees")

if (!all(required_columns %in% names(MyData))) {
    stop("Input CSV must contain: Species, Distance.m, Angle.degrees")
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
        treeht <- TreeHeight(degrees, distance)
        data$height_m[i] <- treeht
    }

    return(data)
}

# Write output CSV
WriteHeigtcsv <- function(data = MyData) {
    output_data <- CalHeight(data)
    write.csv(output_data, OUTPUT_PATH, row.names = FALSE)
}

WriteHeigtcsv()
