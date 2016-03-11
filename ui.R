library(shiny)
library(dplyr)
library(plotly)
library(jsonlite)
library(leaflet)

# start shiny part
ui <- fluidPage( theme = "style.css",
         titlePanel("Traffic Sux"),
         fluidRow(
           column(6,
                  leafletOutput("map1"),
                  textOutput("traveltimeB")
           ),
           column(6,
                  leafletOutput("map2"),
                  textOutput("traveltimeA")
           )
         ),
         hr(),
         
         fluidRow(
           column(4,   selectInput("corridor", label = h3("Corridor"), 
                                   choices = list("Northbound 8th to 527" = "Rd_8th_to_SR527", 
                                                  "Northbound Bellevue to Totem Lake" = "Rd_Bellvue_Totem",
                                                  "Northbound SR520 to NE 70th" = "Rd_SR520_NE70th",
                                                  "Southbound I-5 to 522" = "Rd_I5_to_SR522", 
                                                  "Southbound I-5 to 527" = "Rd_I5_to_SR527",
                                                  "Southbound 85th to 520" = "Rd_NE85th_SR520" 
                                   ), 
                                   selected = "Rd_8th_to_SR527")
           ),
           column(8,   sliderInput("slider", label = h3("Slider"), min = 0.5, 
                                   max = 24, step=0.5, animate= animationOptions(loop = TRUE, interval = 300), value = 0, width = "100%")
           )
           
         ),
         fluidRow(
           column(12,
                  plotlyOutput("plotBefore"))
         )
)
