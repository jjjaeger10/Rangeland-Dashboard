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
      sidebarPanel(
          # Sidebar explainer text
          helpText("Interact with data from the sheep station. Add further explanation as needed"),
          br(),
          # sample image
          img(src = "images/excl119_cam2_08012023_DCIM0071.JPG", height=76, width=102),
          br(),
          br(),
          # select type of data to look at  
          selectInput("Datasets", h3("Data type of interest:"),
                      c(Biomass="Biomass", FloralDensity="FloralDensity", LPI="LPI")),
          br(),
          # select date range
          dateRangeInput("dates", h3("Date range"),
                         start = "2022-07-01", end = "2023-07-31"),
          br(),
          br(),
      
      ## conditionally show variables to display depending on dataset
        # biomass type
        conditionalPanel(
          condition = "input.Datasets == 'Biomass'",
          checkboxGroupInput("biomass_type", "Biomass Type",
                           choices =list("Grass Dry"=1, "Forb Dry"=2,
                                         "Dead Weight"=3, "Total Biomass"=4))),
        # plant species for floral density
        conditionalPanel(
          condition = "input.Datasets == 'FloralDensity'",
          checkboxGroupInput("plant_species", "Plant Species",
                             ### CHANGE THESE TO COMMON NAMES?
                           choices =list("ACMI2"=1, "N"=2, "GEVI2"=3, "COLI2"=4, "PHMU3"=5, "GETR"=6,
                                         "LUCA"=7, "ANAN2"=8))),
      # plant species for floral density
      conditionalPanel(
        condition = "input.Datasets == 'LPI'",
        checkboxGroupInput("plant_species", "Plant Species",
                           ### CHANGE THESE TO COMMON NAMES?
                           choices =list("ACMI2"=1, "N"=2, "GEVI2"=3, "COLI2"=4, "PHMU3"=5, "GETR"=6,
                                         "LUCA"=7, "ANAN2"=8))),
      
      # submit button to view data
      actionButton("submit", "Submit"),
      p("Click Submit to update your data choices.")
      
      ),

        # Main panel
        mainPanel(
          
          # Text output chosen vars
          textOutput("message"),
          
          # Show a plot of the generated distribution
          plotOutput("simplePlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  # define vars for user inputs
  df <- eventReactive(input$Datasets, {
    # select data input
    if(input$Datasets == "Biomass") {"biomass"}
    if(input$Datasets == "FloralDensity") {"floral"}
    if(input$Datasets == "LPI") {"lpi"} 
    })
  start_date <- reactive(input$dates[1])
  end_date <- reactive(input$dates[2]) 
  cats <- eventReactive(input$Datasets,
    if(input$Datasets == "Biomass") {input$biomass_type}
    else {input$plant_species})

  # format plot
  output$simplePlot <- renderPlot({
     if(df == "lpi"){
       lpi_onesp_pc(cats, start_date, end_date)
     }
  }) %>%
    bindEvent(input$submit)
}

# Run the application 
shinyApp(ui = ui, server = server)
