# Visualize Event dataset with hc_event Extension as a Tree
# https://r-graph-gallery.com/dendrogram.html

library(collapsibleTree)
library(readr)
library(igraph)
library(RColorBrewer)


# Import data
input_data <- "data_input/FM_Humboldt_data_2024apr15.csv"
hc_event <- read_csv(input_data)

# Insert root-row
hc_root <- data.frame(
  eventID = NA,
  parentEventID = hc_event$eventID[1],
  nodeType = 'event',
  stringsAsFactors = F
)

hc_event <- plyr::rbind.fill(hc_root, hc_event)

# Assign color by site Count
hc_event$Color <- as.factor(hc_event$nodeType)
levels(hc_event$Color) <- 
  colorspace::rainbow_hcl(9,
                          c = 44,
                          l = 80,
                          start = 130, 
                          end = 790)

# Generate a tree-graph
collapsibleTreeNetwork(
  hc_event,
  attribute = "nodeType",
  fill = "Color",
  fontSize = 8,
  linkLength = 100
  # nodeSize = rep(1, NROW(hc_event))  # "leafCount"
  # tooltipHtml = "tooltip"
)

