library(dplyr)
library(leaflet)
library(sp)
library(jsonlite)
source("script.R")

url_SR520_NE70th <- ("http://dev.virtualearth.net/REST/v1/Routes?wp.0=47.639210,-122.186392&wp.1=47.664188,-122.186911&routePathOutput=Points&output=json&key=Ai7aXwHGDAQAsbwOL9SOsRZA-OxuCMmTurPSpN6EqzFQsr4qA65wJGuIBNLxX7At")

parseData <- function(url) {
  data <- fromJSON(url)
  position <- as.data.frame(data$resourceSet$resources)
  position <- flatten(position)
  return(as.data.frame(position$routePath.line.coordinates))
}

points_SR520_NE70th <- parseData(url_SR520_NE70th)


build_map <- function(dataset, data_avg, input) {
  
  pal <- colorNumeric(
  palette = "Green",
  domain = data_avg[data_avg$name==input,"average"]
  )
  
  m <- leaflet() %>%
    addProviderTiles("Stamen.Toner") %>%  # Add default OpenStreetMap map tiles
    fitBounds(-122.152380, 47.462732, -122.286687, 47.838077) %>% 
    addPolylines(
      lng=dataset$X2, lat=dataset$X1, stroke = TRUE, opacity = 0.4, smoothFactor = 0.5,
      color = pal(data_avg), weight = 10)
  
  return(m)
}

