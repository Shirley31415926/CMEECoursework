# Import the Pound Hill data and metadata
# The first rows describe the sampling design, so do not use one as a header yet.
MyData <- as.matrix(read.csv("data/pound_hill_data.csv", header = FALSE))
head(MyData)
dim(MyData)
str(MyData)
# The metadata file does have a header and uses semicolons as separators.
MyMetaData <- read.csv("data/pound_hill_meta_data.csv", header = TRUE,sep = ";")
head(MyMetaData)

# Transpose so species become columns and sampled quadrats become rows.
MyData <- t(MyData)
head(MyData)
dim(MyData)

# Blanks are observed absences, which allows us to record them as zero rather than NA
# Convert blank species counts to observed zeros,then reshape the counts to long form
MyData[MyData == ""] <- 0
head(MyData)

# Convert the raw matrix to a data frame
TempData <- as.data.frame(MyData[-1, ], stringsAsFactors = FALSE)
head(TempData)
colnames(TempData) <- MyData[1, ]
rownames(TempData) <- NULL

# Convert from wide to long form------------------
library(reshape2)
MyWrangledData <- melt(
  TempData,
  id = c("Cultivation", "Block", "Plot", "Quadrat"),
  variable.name = "Species",
  value.name = "Count"
)
MyWrangledData[, "Cultivation"] <- as.factor(MyWrangledData[, "Cultivation"])
MyWrangledData[, "Block"] <- as.factor(MyWrangledData[, "Block"])
MyWrangledData[, "Plot"] <- as.factor(MyWrangledData[, "Plot"])
MyWrangledData[, "Quadrat"] <- as.factor(MyWrangledData[, "Quadrat"])
MyWrangledData[, "Count"] <- as.integer(MyWrangledData[, "Count"])

str(MyWrangledData)
head(MyWrangledData)
dim(MyWrangledData)

# Save a derived table
write.csv(MyWrangledData, "results/pound_hill_long.csv", row.names = FALSE)

# Explore the data-----------------------------
require(tidyverse)
tidyverse_packages(include_self = TRUE) # the include_self = TRUE means list "tidyverse" as well
MyWrangledData <- dplyr::as_tibble(MyWrangledData)
#  Confirm counts are numeric and non-negative
class(MyWrangledData)
glimpse(MyWrangledData)
utils::View(MyWrangledData)

# Determine number of distinct species, quadrats and plots.
SpeciesTotals <- MyWrangledData %>%
  group_by(Species) %>%
    summarise(Totals = sum(Count > 0))
richness <- length(SpeciesTotals$Species)
print(richness)
dplyr::n_distinct(MyWrangledData$Quadrat)
dplyr::n_distinct(MyWrangledData$Plot)
### Another way to count species
# SpeciesCounts <- tapply(MyWrangledData$Count > 0, INDEX = MyWrangledData$Species, FUN = sum)
# utils::View(SpeciesCounts)
# length(SpeciesCounts)

# Make a quadrat-level table containing Cultivation, Block, Plot, Quadrat and Richness
TableQuadrat <- MyWrangledData %>%
    group_by(Cultivation, Block, Plot, Quadrat) %>%
        summarise(Richness = sum(Count > 0),
        .groups = "drop"
        )
utils::View(TableQuadrat)
PlotRichness <- TableQuadrat %>%
    group_by(Cultivation, Block, Plot) %>%
        summarise(ave.Richness = mean(Richness),
        .groups = "drop"
        ) #remove grouping after the process is done
utils::View(PlotRichness)
# Save plot-level summary
write.csv(PlotRichness, "results/pound_hill_plot_richness.csv")

# Plotting------------------------------------------------------------------------------
# Compare plot-level mean richness among the three cultivation treatments
p <- ggplot(PlotRichness, aes(x = Cultivation,y = ave.Richness))+
                stat_boxplot(geom = "errorbar",
                            width = 0.25) + # Add error bar
                            geom_dotplot(binaxis = 'y', stackdir = 'center', dotsize = 0.4)+
                geom_boxplot(fill = c("darkgreen","dodgerblue","orange"),
                            colour = "black",
                            alpha = 0.5, 
                            outlier.colour = "tomato2") +
                labs(title = "Average Species Richness among Cultivation",
                        x = "Cultivation",
                        y = "Average Species Richness")+ # Make plot easy to understand
                theme_bw() + # make the background white
                theme(aspect.ratio = 1) # make the plot square
print(p)
# Box plot with dot plotw
ggsave("results/pound_hill_plot_richness.pdf", p, width = 7, height = 7)

### Figure Notation
# Treatment in May has the highest typical richness, whose median value is obvious greater than the rest.
# Treatment in March has greater varibaility, as indicated by its wider interquartile range.
# The cultivation timing alone cannot be interpreted directly as impact on species richess,
# since whether the environment elements are the same among cultivation treatments and 
# whether the plots are independent should be recognised and considered.