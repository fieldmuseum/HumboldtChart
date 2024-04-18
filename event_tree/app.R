# App for interactive Humboldt Tree
library(shiny)
library(collapsibleTree)
# Define UI for application that draws a collapsible tree

ui <- fluidPage(
  
  titlePanel("FMNH Rapid Inventory Event Core & Humboldt Extension Data"),
  
  sidebarPanel(
    p("A hierarchical tree of ",
    a("FMNH RI data", href = "https://pj.fieldmuseum.org/event/1eba8f5e-c5f5-49fe-a373-773244234822"),
    "."),
    p("For more info, see", tags$b("event_tree"),
    a("scripts", href = "https://github.com/fieldmuseum/HumboldtChart"),
    "and",
    a("data.", href = "https://github.com/fieldmuseum/HumboldtChart/blob/main/event_tree/data_input/FM_Humboldt_data.csv"))
  ),
  
  # Show a tree diagram with the selected root node
  mainPanel(
    collapsibleTreeOutput("plot")
  )
)

# Define server logic required to draw a collapsible tree diagram
server <- function(input, output) {
  
  # Import & prep data
  source("humboldtTree.R")

  # Configure a tree diagram
  output$plot <- renderCollapsibleTree({
    
    collapsibleTreeNetwork(
      hc_event,
      attribute = "nodeType",
      fill = "Color",
      fontSize = 8,
      linkLength = 100
    )
  })
}

# Run the application
shinyApp(ui = ui, server = server)