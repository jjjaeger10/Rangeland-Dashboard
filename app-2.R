#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# load libraries
library(shiny)
library(dplyr)
library(ggplot2)

## source functions
func_paths <- list.files(path = paste0(getwd(), "/R"), pattern = ".R",
                         full.names = T)
for(i in 1:length(func_paths)){
  source(func_paths[i])
}

# Define UI for application
ui <- fluidPage(
  
  # Application title
  titlePanel("USSES Rangeland Dashboard - v1"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    # list vars that   
    sidebarPanel(
      # Sidebar explainer text
      helpText("Interact with data from the sheep station. Add further explanation as needed"),
      # select type of data to look at  
      selectInput("Datasets", h3("Data type of interest:"),
                  c(Biomass="Biomass", FloralDensity="FloralDensity")),
      # select date range
      dateRangeInput("dates", h3("Date range"),
      ),
      
      ## conditionally show variables to display depending on dataset
      # biomass type
      conditionalPanel(
        condition = "input.Datasets == 'Biomass'",
        checkboxGroupInput("biomass_type", "Biomass Type",
                           choices =list("Grass Dry"=1, "Forb Dry"=2,
                                         "Dead Weight"=3, "Total Biomass"=4))),
      # plant species
      conditionalPanel(
        condition = "input.Datasets == 'FloralDensity'",
        checkboxGroupInput("plant_species", "Plant Species",
                           ### CHANGE THESE TO COMMON NAMES?
                           choices =list("ACMI2"=1, "N"=2, "GEVI2"=3, "COLI2"=4, "PHMU3"=5, "GETR"=6,
                                         "LUCA"=7, "ANAN2"=8)))
    ),
    
    # Main panel
    mainPanel("Sample Image from Table Mountain",
              # sample image
              img(src = "images/excl119_cam2_08012023_DCIM0071.JPG", height=307, width = 408)
              
              # Show a plot of the generated distribution
              #plotOutput("distPlot")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'orange3', border = 'orange',
         xlab = 'Waiting time to next eruption (in mins)',
         main = 'Histogram of waiting times')
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
