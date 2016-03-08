#traffic - final project

library(shiny)
library(dplyr)
library(plotly)
library(ggplot2)
setwd("/Users/hongtianxuhua/Documents/info498f/traffic-final/data(new)")
B_520_70 <- read.csv("Before SR 520 to NE 70th.csv")
A_520_70 <- read.csv("After SR 520 to NE 70.csv")
#B_I5_527 <- read.csv("Before I-5 to SR527.csv")
#A_I5_527 <- read.csv("After I-5 to SR 527.csv")
A_I5_522 <- read.csv("After I-5 to 522.csv")
B_I5_522 <- read.csv("Before 1-5 to 522.csv")
A_8_527 <- read.csv("After 8th to SR 527.csv")
B_8_527 <- read.csv("Before 8th to SR 527.csv")

shinyUI(fluidPage(
  fluidRow(
    column(4,
           
           # Copy the line below to make a slider bar 
           sliderInput("slider1", label = h3("Slider"), min = 0, 
                       max = 100, value = 50)
    ),
    column(4,
           
           # Copy the line below to make a slider range 
           sliderInput("slider2", label = h3("Slider Range"), min = 0, 
                       max = 100, value = c(40, 60))
    )
  ),
  
  hr(),
  
  fluidRow(
    column(4, verbatimTextOutput("value")),
    column(4, verbatimTextOutput("range"))
  )
  
))