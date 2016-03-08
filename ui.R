#traffic - final project

library(shiny)
library(dplyr)
library(plotly)
library(ggplot2)
library(leaflet)

shinyUI(fluidPage(fluidPage(
  leafletOutput("mymap")
)))