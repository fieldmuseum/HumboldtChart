# Visualize Event dataset with Humboldt Extension as a Tree
# https://r-graph-gallery.com/dendrogram.html

library(collapsibleTree)
library(readr)
library(igraph)
library(RColorBrewer)


# Import data
humboldt <- read_csv("data_input/FM_Humboldt_data.csv")

# Insert root-row
humb_root <- data.frame(
  eventID = NA,
  parentEventID = humboldt$eventID[1],
  siteCount = 0,
  stringsAsFactors = F
)

humboldt <- plyr::rbind.fill(humb_root, humboldt)

# Assign color by site Count
humboldt$Color <- as.factor(humboldt$siteCount)
levels(humboldt$Color) <- colorspace::rainbow_hcl(11)

# Generate a tree-graph
collapsibleTreeNetwork(
  humboldt,
  attribute = "siteCount",
  fill = "Color",
  nodeSize = "leafCount"
  # tooltipHtml = "tooltip"
)

