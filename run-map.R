library(shiny)
library(leaflet)


source("testPlot.R")

# start shiny part
ui <- fluidPage(
  leafletOutput("mymap"),
  column(4,
         # Copy the line below to make a slider bar 
         sliderInput("slider", label = h3("Slider"), min = 1, 
                     max = 24, step=0.5, animate=TRUE, value = 0)
  )
)

server <- function(input, output) {
  
  output$mymap <- renderLeaflet({
    mymap <- build_map(points_SR520_NE70th, B_520_70_average, input$slider)
  })
}

shinyApp(ui, server)
