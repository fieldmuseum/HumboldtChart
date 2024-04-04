# Visualize Event dataset with Humboldt Extension
# https://r-graph-gallery.com/249-igraph-network-map-a-color.html

# How to:

# # 1. Install packages if needed:
# install.packages(c("collapsibleTree",
#                    "igraph", "readr", "RColorBrewer",
#                    "data.table", "data.tree", "ggraph"))

# # 2. Copy your input-CSV to the "data_input" folder
# # 3. Name the input-CSV "FM_Humboldt_data.csv"
# #     [Or update file-path in "read_csv(...)" on line ~25]

# # 4. Run this script -- e.g.:
# #     - highlight lines & press Ctrl+Enter
# #     - &/or in the 'Console' window (lower-left), type:
# #         source('humboldtTree.R')

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

# Assign color by site Count
humboldt$Color <- as.factor(humboldt$siteCount)
levels(humboldt$Color) <- colorspace::rainbow_hcl(11)

# Generate a tree-graph
collapsibleTreeNetwork(
  humboldt, # links,
  attribute = "siteCount", # "importance",
  fill = "Color",
  nodeSize = "leafCount"
  # tooltipHtml = "tooltip"
)



# Make a more loose/messy network map:

# Set up unique list of nodes

# node_list <- data.frame()
node_list <- data.frame(
  'eventID' = unique(c(humboldt$eventID, humboldt$parentEventID)),
  stringsAsFactors = F)

nodes <- unique(
  merge(node_list, humboldt[,c("eventID", "datasetID")],
        by.x = 'eventID',
        all.x = TRUE))

names(nodes) <- c('name', 'carac')

# Turn it into igraph object
network <- graph_from_data_frame(d=humboldt, vertices=nodes, directed=T) 

# Make a palette of 3 colors
coul  <- brewer.pal(3, "Set1") 

# Create a vector of color
my_color <- coul[as.numeric(as.factor(V(network)$carac))]

# Make the plot
plot(network, vertex.color=my_color)

# Add a legend
legend("bottomleft", legend=levels(as.factor(V(network)$carac))  , col = coul , bty = "n", pch=20 , pt.cex = 3, cex = 1.5, text.col=coul , horiz = FALSE, inset = c(0.025, 0.125))

# Make rough network-graph
edges <- igraph::graph_from_edgelist(
  as.matrix(
    humboldt[2:NROW(humboldt),1:2]), 
  directed = T)

plot(edges)



# #...Alternative [less-efficient/more-limited] ways to make tree-map:


# # Alt-Way 1: Convert edge-list to tree:
# 
# tree <- FromDataFrameNetwork(links[,c("source","target")])
# treetable <- ToDataFrameTypeCol(tree, type = "level")
# 
# # collapsibleTree(el, c("from_name", "to_name"), hierarchy = c("to_name", "from_name"))
# collapsibleTree(treetable, 
#                 hierarchy = unlist(colnames(treetable)))


# # Alt-Way 2: Create separate dataframes:

# root <- data.frame(
#   source = NA,
#   target = humboldt$eventID[1],
#   importance = 0,
#   stringsAsFactors = F
# )

# links <- data.frame(
#   source = humboldt$eventID, #  c("A","A", "A", "A", "A","J", "B", "B", "C", "C", "D","I"),  # 
#   target = humboldt$parentEventID,  # c("B","B", "C", "D", "J","A","E", "F", "G", "H", "I","I"),  # 
#   importance = humboldt$siteCount,   # (sample(1:4, 12, replace=T)),
#   stringsAsFactors = F
# )

# links <- rbind(root, links)

# # assign color by site Count
# links$Color <- as.factor(links$importance)
# levels(links$Color) <- colorspace::rainbow_hcl(11)

