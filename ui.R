#traffic - final project
setwd("/Users/hongtianxuhua/Documents/info498f/traffic-final")
library(shiny)
library(dplyr)
library(plotly)


shinyUI(fluidPage(

  sidebarPanel(
    column(4,
           # Copy the line below to make a slider bar 
           sliderInput("slider", label = h3("Slider"), min = 1, 
                       max = 24, step=0.5, animate=TRUE, value = 0)
    )
  ),
  mainPanel(
    plotlyOutput("testPlot")
  )
  
))
