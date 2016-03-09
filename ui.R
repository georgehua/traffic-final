#traffic - final project

library(shiny)
library(dplyr)
library(plotly)
library(ggplot2)
library(leaflet)

shinyUI(fluidPage(
  theme = "app.css",
  
  sidebarLayout(
    
    # create Side panel
    sidebarPanel(
      
      # Doesnt work yet
      selectInput("corridor", label = h3("Choose corridor"), 
                  choices = list("Select..." = 'select',
                                 "8th to SR527" = '8th_to_SR527',
                                 "Bellevue to Totem Lake" = 'Bell_to_Totemlk',
                                 "I-5 to SR-522" = 'I5_to_SR522',
                                 "I-5 to SR-527" = 'I5_to_SR527',
                                 "NE85th to SR-520" = 'NE85th_SR520',
                                 "SR-520 to NE70th" = 'SR520_NE70th'
                                 ), 
                  selected = 'select'),
      actionButton("render", "Generate plot")
    ),
    
    mainPanel(
      leafletOutput("mymap")
    )
  
  
  
)))