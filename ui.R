#traffic - final project

library(shiny)
library(dplyr)
library(plotly)
library(ggplot2)
setwd("/Users/Joycie/info498f/traffic-final/data(new)")
B_520_70 <- read.csv("Before SR 520 to NE 70th.csv")
A_520_70 <- read.csv("After SR 520 to NE 70.csv")
#B_I5_527 <- read.csv("Before I-5 to SR527.csv")
#A_I5_527 <- read.csv("After I-5 to SR 527.csv")
A_I5_522 <- read.csv("After I-5 to 522.csv")
B_I5_522 <- read.csv("Before 1-5 to 522.csv")
A_8_527 <- read.csv("After 8th to SR 527.csv")
B_8_527 <- read.csv("Before 8th to SR 527.csv")
A_bv_tl <- read.csv("After Bellevue to Totem Lk.csv")
B_bv_tl <- read.csv("Before Bell to Ttm Lk.csv")
A_85_520 <- read.csv("After NE85th to 520.csv")
B_85_520 <- read.csv("Before NE85th to 520.csv")

shinyUI(fluidPage(
  titlePanel("Traffic Sux"),
  sidebarPanel(
     selectInput("select", label = h3("Select Corridor"), 
               choices = list("520 to 70" = 1, "I-5 to 522" = 2, "8th to 527" = 3, "Bellevue to Totem Lk" = 4, "NE 85th to 520" = 5), 
               selected = 1)
  ),
  mainPanel(
    plotlyOutput("plotBefore"),
    plotlyOutput("plotAfter")
  )

))