library(shiny)
library(dplyr)
library(plotly)

source("testPlot.R")
source("script.R")

shinyServer(function(input, output) {
  output$testPlot <- renderPlotly({
    build_map(points_SR520_NE70th)
  })
})