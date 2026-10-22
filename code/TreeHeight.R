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

# Set input and output path directory 
INPUT_PATH <- file.path(getwd(), "data", "trees.csv")
OUTPUT_PATH <- file.path(getwd(), "results", "TreeHts.csv")
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
    output_data <- CalHeight(data)
    write.csv(output_data, OUTPUT_PATH, row.names = FALSE)
}

WriteHeigtcsv()

# print(TreeHeight(980, 40))

