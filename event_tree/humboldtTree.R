# Visualize Event dataset with hc_event Extension as a Tree
# https://r-graph-gallery.com/dendrogram.html

library(collapsibleTree)
library(readr)
library(igraph)
library(RColorBrewer)


# Import data
input_data <- "data_input/FM_Humboldt_data_2024apr.csv"
hc_event <- read_csv(input_data)

# Insert root-row
hc_root <- data.frame(
  eventID = hc_event$parentEventID[1], # NA,
  parentEventID = NA, # hc_event$eventID[1],
  nodeType = 'event',
  stringsAsFactors = F
)

hc_event <- plyr::rbind.fill(hc_root, hc_event)

hc_event <- hc_event[,c("parentEventID","eventID","nodeType")]

# Assign color by site Count
hc_event$Color <- as.factor(hc_event$nodeType)
levels(hc_event$Color) <- 
  colorspace::rainbow_hcl(9,
                          c = 56,
                          l = 78,
                          start = -1100, 
                          end = 90)

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

