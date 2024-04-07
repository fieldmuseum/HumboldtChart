# Visualize Event dataset with hc_event Extension as a Tree
# https://r-graph-gallery.com/dendrogram.html

library(collapsibleTree)
library(readr)
library(igraph)
library(RColorBrewer)


# Import data
input_data <- "data_input/FM_Humboldt_data.csv"
hc_event <- read_csv(input_data)

# Insert root-row
hc_root <- data.frame(
  eventID = NA,
  parentEventID = hc_event$eventID[1],
  siteCount = 0,
  stringsAsFactors = F
)

hc_event <- plyr::rbind.fill(hc_root, hc_event)

# Assign color by site Count
hc_event$Color <- as.factor(hc_event$siteCount)
levels(hc_event$Color) <- colorspace::rainbow_hcl(11)

# Generate a tree-graph
collapsibleTreeNetwork(
  hc_event,
  attribute = "siteCount",
  fill = "Color",
  nodeSize = "leafCount"
  # tooltipHtml = "tooltip"
)

