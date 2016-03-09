library(shiny)
library(dplyr)
library(plotly)
setwd("/Users/Joycie/info498f/traffic-final/data(new)")
B_520_70 <- read.csv("Before SR 520 to NE 70th.csv")
A_520_70 <- read.csv("After SR 520 to NE 70.csv")
B_I5_527 <- read.csv("Before I-5 to SR527.csv")
A_I5_527 <- read.csv("After I-5 to SR 527.csv")
A_I5_522 <- read.csv("After I5 to 522.csv")
B_I5_522 <- read.csv("Before 1-5 to 522.csv")
A_8_527 <- read.csv("After 8th to SR 527.csv")
B_8_527 <- read.csv("Before 8th to SR 527.csv")
A_bv_tl <- read.csv("After Bellevue to Totem Lk.csv")
B_bv_tl <- read.csv("Before Bell to Ttm Lk.csv")
A_85_520 <- read.csv("After NE85th to 520.csv")
B_85_520 <- read.csv("Before NE85th to 520.csv")

shinyServer(function(input, output) {
  output$plotBefore <- renderPlotly({
    x <- list(
      title = "Time"
    )
    y <- list(
      title = "Before Avg Commute (min)"
    )
    if (input$select == 1) {
      data1 = B_520_70
    } else if (input$select == 2) {
      data1 = B_I5_522
    } else if (input$select == 3) {
      data1 = B_8_527
    } else if (input$select == 4) {
      data1 = B_bv_tl
    } else if (input$select == 5) {
      data1 = B_85_520
    } else {
      data1 = B_I5_527
    }
    plot_ly(data = data1, x = Time, y = X90..ile / 60, mode = "markers", color = X90..ile / 60) %>% 
      layout(xaxis=x, yaxis=y)
    
  })
  output$plotAfter <- renderPlotly({
    x <- list(
      title = "Time"
    )
    y <- list(
      title = "After Avg Commute (min)"
    )
    if (input$select == 1) {
      data2 = A_520_70
    } else if (input$select == 2) {
      data2 = A_I5_522
    } else if (input$select == 3) {
      data2 = A_8_527
    } else if (input$select == 4) {
      data2 = A_bv_tl
    } else if (input$select == 5) {
      data2 = A_85_520
    } else {
      data2 = A_I5_527
    }
    plot_ly(data = data2, x = Time, y = X90..ile / 60, mode = "markers", color = X90..ile /60) %>% 
      layout(xaxis=x, yaxis=y)
  })
})