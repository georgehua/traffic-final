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
  output$plotBefore <- renderPlotly({
    if (input$select == 1) {
      data1 = B_520_70
    } else if (input$select == 2) {
      data1 = B_I5_522
    } else {
      data1 = B_8_527
    }
    plot_ly(data = data1, x = Time, y = Avg..TTS / 60, mode = "markers")
  })
  output$plotAfter <- renderPlotly({
    if (input$select == 1) {
      data2 = A_520_70
    } else if (input$select == 2) {
      data2 = A_I5_522
    } else {
      data2 = A_8_527
    }
    plot_ly(data = data2, x = Time, y = Avg..TTS / 60, mode = "markers")
  })
})