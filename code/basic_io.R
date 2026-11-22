# A simple R script illustrating file input and output.
# Run from the coursework project root with:
# Rscript code/basic_io.R

MyData <- read.csv("data/trees.csv", header = TRUE)

write.csv(MyData, "results/MyData.csv")

write.table(MyData[1, ], file = "results/MyData.csv", append = TRUE)

write.csv(MyData, "results/MyData.csv", row.names = TRUE)

write.table(MyData, "results/MyData.csv", col.names = FALSE)


TestData <- data.frame(
    Species = c("Populus tremula", "Fagus sylvatica", "Betula pendula"),
    Distance.m = c(80, 70, 60),
    Angle.degrees = c(30, 45, 45)
) # Explore how to add data into data frame

write.csv(TestData, "sandbox/test_trees.csv", row.names = FALSE)
