library(shiny)
library(dplyr)
library(plotly)
setwd("/Users/Joycie/info498f/traffic-final/data(new)")
B_520_70 <- read.csv("Before SR 520 to NE 70th.csv")
A_520_70 <- read.csv("After SR 520 to NE 70.csv")
#B_I5_527 <- read.csv("Before I-5 to SR527.csv")
#A_I5_527 <- read.csv("After I-5 to SR 527.csv")
A_I5_522 <- read.csv("After I-5 to 522.csv")
B_I5_522 <- read.csv("Before 1-5 to 522.csv")

shinyServer(function(input, output) {
  output$plot <- renderPlotly({
    if (input$select == 1) {
      data1 = B_520_70
      data2 = A_520_70
    } else {
      data1 = B_I5_522
      data2 = A_I5_522
    }
    plot_ly(data = data1, x = Time, y = Avg..TTS, mode = "markers")
    #plot_ly(data = data2, x = Time, y = Avg..TTS , mode = "markers")
  
  })
})