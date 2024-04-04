# Visualize Event dataset with Humboldt Extension as a Network
# https://r-graph-gallery.com/249-igraph-network-map-a-color.html

# # # # # # # # # # # # # # # # # # # # # # # # # # # #
# How to:

# # 1. Install packages if needed:
# install.packages(c("collapsibleTree",
#                    "igraph", "readr", "RColorBrewer",
#                    "data.table", "data.tree", "ggraph"))
#
# # 2. Copy your input-CSV to the "data_input" folder
#
# # 3. Name the input-CSV "FM_Humboldt_data.csv"
#       [Or update file-path in "read_csv(...)" on line ~25]
#
# # 4. Run this script -- e.g.:
#       - highlight lines & press Ctrl+Enter
#       - &/or in the 'Console' window (lower-left), type:
#           source('humboldtTree.R')
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # #

library(collapsibleTree)
library(readr)
library(igraph)
library(RColorBrewer)
# library(data.table)
# library(data.tree)
# library(ggraph)


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

# Make a more loose/messy network map:

# Set up unique list of nodes
node_list <- data.frame(
  'eventID' = unique(c(humboldt$eventID, humboldt$parentEventID)),
  stringsAsFactors = F)

nodes <- unique(
  merge(node_list, humboldt[,c("eventID", "datasetID")],
        by.x = 'eventID',
        all.x = TRUE))

names(nodes) <- c('name', 'carac')

# Turn it into igraph object
network <- graph_from_data_frame(d=humboldt, vertices=nodes, directed=F) 

# Make a palette of 3 colors
coul  <- brewer.pal(3, "Set1") 

# Create a vector of color
my_color <- coul[as.numeric(as.factor(V(network)$carac))]

V(network)$label.cex <- .8
E(network)$width <- 2.2
# E(network)$connect <- 15

# Make the plot
plot(network, 
     vertex.color=my_color, 
     vertex.size = 6)

# # Add a legend
# legend("bottomleft", legend=levels(as.factor(V(network)$carac)),
#        col = coul , bty = "n", pch=20 , 
#        pt.cex = 1.75, cex = 1.5, text.col=coul , horiz = FALSE, 
#        inset = c(0.01, 0.01))
# 
# # Make rough network-graph
# edges <- igraph::graph_from_edgelist(
#   as.matrix(
#     humboldt[2:NROW(humboldt),1:2]), 
#   directed = T)
# 
# plot(edges)
