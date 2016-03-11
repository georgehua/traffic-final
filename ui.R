library(shiny)
library(dplyr)
library(plotly)
library(jsonlite)
library(leaflet)
library(rsconnect)

# start shiny part
ui <- fluidPage( theme = "style.css",
                 
                 tags$head(tags$link(rel="shortcut icon", href="/favcon.png")),
                 
                 tags$div(id="innerBody",
                 
                 tags$h1(id="title1","I-405 Changes", tags$h6(id="title2", "Travel Time Analysis of the Toll Lane Implementation")),
            
                 tags$div(id="introText", 
                          tags$p("The charts describes the travel time changes occurring in the I-405 corridor between downtown Bellevue and I-5 at Lynnwood for different trips.  In all cases, it compares changes in travel times from the before period of October 1, 2014, to January 1, 2015, before implementation of the Express Toll Lanes, with the After period of October 1, 2015, to January 31, 2016, after the lanes' implementation.  All trips examined are in the general purpose lanes.
                                 The selected time period, October through January, includes two major holidays, Christmas and New Year's. It also includes some of the worst weather Seattle typically observes during the year.  As a result, both the Before and After periods likely experienced traffic conditions that were more variable than at other times of the year.",  tags$sup("Sourced from Mark Hallenbeck"))
                          ),
                 
                 fluidRow(
                   column(4,   selectInput("corridor", label = h3("Corridor"), 
                                           choices = list("Northbound 8th to 527" = "Rd_8th_to_SR527", 
                                                          "Northbound Bellevue to Totem Lake" = "Rd_Bellvue_Totem",
                                                          "Northbound SR520 to NE 70th" = "Rd_SR520_NE70th",
                                                          "Southbound I-5 to 522" = "Rd_I5_to_SR522", 
                                                          "Southbound I-5 to 527" = "Rd_I5_to_SR527",
                                                          "Southbound 85th to 520" = "Rd_NE85th_SR520" 
                                           ), 
                                           selected = "Rd_8th_to_SR527"))
                 ),
                 
                 fluidRow(
                   column(6,
                          tags$div(class="BA", "Before"),
                          leafletOutput("map1"),
                          tags$div(class="traveltime",textOutput("traveltimeB"))
                   ),
                   column(6,
                          tags$div(class="BA", "After"),
                          leafletOutput("map2"),
                          tags$div(class="traveltime",textOutput("traveltimeA"))
                          
                   )
                 ),
                 
                 tags$div(id="time", textOutput("time_count")),
                 
                 fluidRow(


                   column(12,   tags$div(id="sliderhide",sliderInput("slider", label = h6("Select Time or Press Play"), min = 1, 
                                                                     max = 288, step=1, animate= animationOptions(loop = TRUE, interval = 100), value = 0, width = "100%", ticks = FALSE)
                 )),

                 fluidRow(
                   column(12,
                          plotlyOutput("plotBefore"))
                 ),
                 tags$p("Special thanks to Mark Hallenbeck and TRAC-UW for providing us with the data."),
                 tags$p("Created by Denny Lim, Esteban Parreno, George Hua, Joycie Yu")
                )
                )
)
