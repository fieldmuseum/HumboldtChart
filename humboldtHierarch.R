# Visualize Event dataset with Humboldt Extension
# https://r-graph-gallery.com/249-igraph-network-map-a-color.html

library(readr)
library(igraph)
library(RColorBrewer)

library(collapsibleTree) 



# import data
humboldt <- read_csv("data_input/FM_Humboldt_mockup.csv")

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

nodes <- merge(node_list, humboldt[,c("eventID", "datasetID")],
               by.x = 'eventID',
               all.x = TRUE)

p <- collapsibleTree( warpbreaks, c("wool", "tension", "breaks"))
p


# input data must be a nested data frame:
test <- warpbreaks
test$breaks[3] <- NA
test$wool <- as.character(test$wool)
test <- rbind(test, c("RI123", "G", NA))


# Represent this tree:
p <- collapsibleTree( test, c("wool", "tension", "breaks"))
p

# save the widget
# library(htmlwidgets)
# saveWidget(p, file=paste0( getwd(), "/HtmlWidget/dendrogram_interactive.html"))

