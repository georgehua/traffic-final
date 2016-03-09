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


build_map <- function(dataset) {
#  pal <- colorNumeric(
 #   palette = "Green",
#    domain = data_avg$average
#  )
  m <- leaflet() %>%
    addProviderTiles("Stamen.Toner") %>%  # Add default OpenStreetMap map tiles
    addMarkers(lat=47.617337, lng=-122.188505, popup="Start and End of I-405 Toll Lanes") %>% 
    addMarkers(lat=47.827635, lng=-122.256036, popup="Start and End of I-405 Toll Lanes") %>% 
    fitBounds(-122.152380, 47.462732, -122.286687, 47.838077) %>% 
    addPolylines(
      lng=dataset$X2, lat=dataset$X1, stroke = TRUE, opacity = 0.1, smoothFactor = 0.5,
      color = "green", weight = 10)
  return(m)
}
