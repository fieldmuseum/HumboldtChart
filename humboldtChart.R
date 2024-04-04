# Visualize Event dataset with Humboldt Extension
# https://r-graph-gallery.com/249-igraph-network-map-a-color.html

library(ggraph)
library(readr)
library(igraph)
library(RColorBrewer)
library(data.table)
library(data.tree)

# import data
humboldt <- read_csv("data_input/FM_Humboldt_mockup2.csv")

# create data:
links <- data.frame(
  source = humboldt$eventID, #  c("A","A", "A", "A", "A","J", "B", "B", "C", "C", "D","I"),  # 
  target = humboldt$parentEventID,  # c("B","B", "C", "D", "J","A","E", "F", "G", "H", "I","I"),  # 
  importance = humboldt$siteCount   # (sample(1:4, 12, replace=T))
)

# nodes <- data.frame(
#   name = humboldt$eventID,
#   carac = humboldt$datasetID  # c( rep("young",3),rep("adult",2), rep("old",5))
# )

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
network <- graph_from_data_frame(d=links, vertices=nodes, directed=T) 

# Make a palette of 3 colors
coul  <- brewer.pal(3, "Set1") 

# Create a vector of color
my_color <- coul[as.numeric(as.factor(V(network)$carac))]

# Make the plot
plot(network, vertex.color=my_color)

# Add a legend
legend("bottomleft", legend=levels(as.factor(V(network)$carac))  , col = coul , bty = "n", pch=20 , pt.cex = 3, cex = 1.5, text.col=coul , horiz = FALSE, inset = c(0.025, 0.125))

edges <- igraph::graph_from_edgelist(as.matrix(links[,1:2]), directed = T)
plot(edges)


# 
network2 <- igraph::as_data_frame(x = edges, what = "edges") %>%
  `colnames<-`(c("source", "target"))
p <- collapsibleTree( network2, c("target", "source")) # , "level"), )
p

edge_list_dammit <- links[order(links$target),c("target","source")]
mygraph <- graph_from_data_frame( edge_list_dammit )
el <- as_long_data_frame(mygraph)

# Try ggraph dendrogram alternative
ggraph(mygraph, layout = 'dendrogram', circular = F) + 
  geom_edge_diagonal() +
  geom_node_point() +
  theme_void()


# NOT QUITE
tree <- FromDataFrameNetwork(el)
ToDataFrameTree(tree, 
                level1 = function(x) x$path[2],
                level2 = function(x) x$path[3],
                level3 = function(x) x$path[4],
                level_number = function(x) x$level - 1)[-1,-1]


# FROM https://stackoverflow.com/questions/33069353/r-hierarchical-data-frame-from-child-parent-relations
l <- list() # initialize empty list
setDT(el) 
setkey(el, from_name) # setting up the data as keyed data.table
# current_lvl <- el[is.na(from_name), .(level_number = 1), keyby=.(level1 = name)]
current_lvl <- el[el$from_name=="FMRBSI", .(level_number = 1), keyby=.(level1 = to_name)]

# current_lvl <- current_lvl[el][ # Join the data.tables
#   !is.na(level_number)][ #exclude non-child-rows
#     ,level_number := level_number + 1] # increment level_number
# setnames(current_lvl, "to_name", paste0("level",ind+1)) # rename column
# setkeyv(current_lvl, paste0("level",ind+1)) # set key

while(nrow(current_lvl) > 0){
  ind <- length(l) + 1
  l[[ind]] <- current_lvl
  current_lvl <- current_lvl[el][!is.na(level_number)][,level_number := level_number + 1]
  if(nrow(current_lvl) == 0L){
    break
  }
  setnames(current_lvl, "to_name", paste0("level",ind+1))
  setkeyv(current_lvl, paste0("level",ind+1))
}


# el_matrix <- as_adjacency_matrix(edges)
p <- collapsibleTree(el, c("from_name", "to_name"), hierarchy = c("to_name", "from_name"))



