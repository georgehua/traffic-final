library(shiny)
library(leaflet)


source("testPlot.R")

# start shiny part
ui <- fluidPage(
  leafletOutput("mymap"),
  selectInput("corridor", label = h3("Corridor"), 
              choices = list("points_8th_to_SR527" = "points_8th_to_SR527", "points_Bell_to_Totemlk" = "points_Bell_to_Totemlk",
                             "points_I5_to_SR522" = "points_I5_to_SR522", "points_I5_to_SR527" = "points_I5_to_SR527",
                             "points_NE85th_SR520" = "points_NE85th_SR520", "points_SR520_NE70th" = "points_SR520_NE70th"), 
              selected = "points_8th_to_SR527"),

  sliderInput("slider", label = h3("Slider"), min = 1, 
          max = 24, step=0.5, animate=TRUE, value = 0)
)

server <- function(input, output) {
  
  output$mymap <- renderLeaflet({
    mymap <- build_map(B_520_70_average, input$slider, input$corridor)
  })
}

shinyApp(ui, server)
