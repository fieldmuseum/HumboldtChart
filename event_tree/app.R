# App for interactive Humboldt Tree
library(shiny)
library(collapsibleTree)
# Define UI for application that draws a collapsible tree

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
  
  # Import data
  # source("https://raw.githubusercontent.com/fieldmuseum/HumboldtChart/main/humboldtTree.R")
  source("humboldtTree.R")
  # input_data <- "https://raw.githubusercontent.com/fieldmuseum/HumboldtChart/main/data_input/FM_Humboldt_data.csv"
  # hc_event <- read_csv(input_data)
  # 
  # # Insert root-row
  # hc_root <- data.frame(
  #   eventID = NA,
  #   parentEventID = hc_event$eventID[1],
  #   siteCount = 0,
  #   stringsAsFactors = F
  # )
  # 
  # hc_event <- plyr::rbind.fill(hc_root, hc_event)
  # 
  # # Assign color by site Count
  # hc_event$Color <- as.factor(hc_event$siteCount)
  # levels(hc_event$Color) <- colorspace::rainbow_hcl(5)
  
  output$plot <- renderCollapsibleTree({
    # hierarchy <- c("wool","tension","breaks")
    collapsibleTreeNetwork(
      hc_event,
      attribute = "siteCount",
      fill = "Color",
      nodeSize = "leafCount"
    )
  })
}
# Run the application
shinyApp(ui = ui, server = server)