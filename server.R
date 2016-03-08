library(shiny)
library(dplyr)
library(plotly)
setwd("/Users/hongtianxuhua/Documents/info498f/traffic-final/data(new)")
B_520_70 <- read.csv("Before SR 520 to NE 70th.csv")
A_520_70 <- read.csv("After SR 520 to NE 70.csv")
#B_I5_527 <- read.csv("Before I-5 to SR527.csv")
#A_I5_527 <- read.csv("After I-5 to SR 527.csv")
A_I5_522 <- read.csv("After I-5 to 522.csv")
B_I5_522 <- read.csv("Before 1-5 to 522.csv")
A_8_527 <- read.csv("After 8th to SR 527.csv")
B_8_527 <- read.csv("Before 8th to SR 527.csv")

shinyServer(function(input, output) {
  
  # You can access the value of the widget with input$slider1, e.g.
  output$value <- renderPrint({ input$slider1 })
  
  # You can access the values of the second widget with input$slider2, e.g.
  output$range <- renderPrint({ input$slider2 })
})