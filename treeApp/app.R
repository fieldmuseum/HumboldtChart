# App for interactive Humboldt Tree
library(shiny)
library(collapsibleTree)
# Define UI for application that draws a collapsible tree

source("https://raw.githubusercontent.com/fieldmuseum/HumboldtChart/main/humboldtTree.R")
# source("humboldtTree.R")

ui <- fluidPage(
  # Application title
  titlePanel("Collapsible Event Core / Humboldt Ext Tree example"),
  # Show a tree diagram with the selected root node
  mainPanel(
    collapsibleTreeOutput("plot")
  )
)

# Define server logic required to draw a collapsible tree diagram
server <- function(input, output) {
  output$plot <- renderCollapsibleTree({
    # hierarchy <- c("wool","tension","breaks")
    collapsibleTreeNetwork(
      humboldt,
      attribute = "siteCount",
      fill = "Color",
      nodeSize = "leafCount"
    )
  })
}
# Run the application
shinyApp(ui = ui, server = server)