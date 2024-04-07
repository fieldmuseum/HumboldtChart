# Humboldt Chart scripts
...scripts to visualize [Darwin Core Event core](https://www.gbif.org/darwin-core) datasets with [Humboldt extensions](https://eco.tdwg.org/) as trees, networks, etc.

## Examples:

[Interactive Event-tree chart](https://fmnh.shinyapps.io/event_tree/) generated with the [event_tree app](https://github.com/fieldmuseum/HumboldtChart/tree/main/event_tree) which references humboldtTree.R

## Setup / How-to:

0. Clone or download this repo, and open its 'Rproj' file in RStudio.

1. **Install packages** if needed:
```r
# Paste and run this in the RStudio console (lower-left panel)
install.packages(c("collapsibleTree",
                   "igraph", "readr", "RColorBrewer",
                   "data.table", "data.tree", "ggraph"))
```

2. **Copy your input-CSV** to the "data_input" folder

3. Name the input-CSV **"FM_Humboldt_data.csv"**

4. **Run** a charting script. e.g. in the RStudio console, type: `source("humboldtTree.R")`


## [humboldtTree.R](https://github.com/fieldmuseum/HumboldtChart/blob/main/event_tree/humboldtTree.R)
Generates a collapsible tree/dendrogram to illustrate parent-child relationships

<img src="https://github.com/fieldmuseum/HumboldtChart/assets/8563362/ea672693-57e0-4cee-9c15-b0f2ab5466ee" width="750px"/>


## [humboldtNetwork.R](https://github.com/fieldmuseum/HumboldtChart/blob/main/humboldtNetwork.R)
Generates a less organized network for clusters/relationships

<img src="https://github.com/fieldmuseum/HumboldtChart/assets/8563362/7a859cde-30f9-4b79-a9d8-61ba10976692" width="500px"/>

## Resources 
[Shiny App How-to](https://shiny.posit.co/r/articles/share/shinyapps/)
