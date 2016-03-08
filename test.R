#Esteban Parreno
#Final project
#r script used for testing out leaflet


install.packages("leaflet")
install.packages("sp")

library(dplyr)
library(leaflet)
library(sp)
library(jsonlite)

url_8th_to_SR527 <- ("http://dev.virtualearth.net/REST/v1/Routes?wp.0=47.617337,-122.188505&wp.1=47.794967,%20-122.214141&routePathOutput=Points&output=json&key=Ai7aXwHGDAQAsbwOL9SOsRZA-OxuCMmTurPSpN6EqzFQsr4qA65wJGuIBNLxX7At")
url_Bell_to_Totemlk <- ("http://dev.virtualearth.net/REST/v1/Routes?wp.0=47.615449,-122.188641&wp.1=47.705301,-122.179698&routePathOutput=Points&output=json&key=Ai7aXwHGDAQAsbwOL9SOsRZA-OxuCMmTurPSpN6EqzFQsr4qA65wJGuIBNLxX7At")
url_I5_to_SR522 <- ("http://dev.virtualearth.net/REST/v1/Routes?wp.0=47.827635,-122.256036&wp.1=47.762606,-122.185533&routePathOutput=Points&output=json&key=Ai7aXwHGDAQAsbwOL9SOsRZA-OxuCMmTurPSpN6EqzFQsr4qA65wJGuIBNLxX7At")
url_I5_to_SR527 <- ("http://dev.virtualearth.net/REST/v1/Routes?wp.0=47.827635,-122.256036&wp.1=47.794821,-122.214448&routePathOutput=Points&output=json&key=Ai7aXwHGDAQAsbwOL9SOsRZA-OxuCMmTurPSpN6EqzFQsr4qA65wJGuIBNLxX7At")
url_NE85th_SR520 <- ("http://dev.virtualearth.net/REST/v1/Routes?wp.0=47.679087,-122.184709&wp.1=47.637159,-122.186778&routePathOutput=Points&output=json&key=Ai7aXwHGDAQAsbwOL9SOsRZA-OxuCMmTurPSpN6EqzFQsr4qA65wJGuIBNLxX7At")
url_SR520_NE70th <- ("http://dev.virtualearth.net/REST/v1/Routes?wp.0=47.639210,-122.186392&wp.1=47.664188,-122.186911&routePathOutput=Points&output=json&key=Ai7aXwHGDAQAsbwOL9SOsRZA-OxuCMmTurPSpN6EqzFQsr4qA65wJGuIBNLxX7At")

corridors <- c(url_8th_to_SR527, url_Bell_to_Totemlk, url_I5_to_SR522, url_I5_to_SR527, url_NE85th_SR520, url_SR520_NE70th)


parseData <- function(url) {
  x <- c()
  for (i in 1:length(url)) {
    data <- fromJSON(url[i])
    position <- as.data.frame(data$resourceSet$resources)
    position <- flatten(position)
    x <- append(x, as.data.frame(position$routePath.line.coordinates))
  }
  return(x)
}

points <- parseData(corridors)


m <- leaflet() %>%
  addProviderTiles("Stamen.Toner") %>%  # Add default OpenStreetMap map tiles
  addMarkers(lat=47.5095884, lng=-122.2010203, popup="The birthplace of R") %>% 
  fitBounds(-122.152380, 47.462732, -122.286687, 47.838077) %>% 
  addPolylines(
    lng=coor$X2, lat=coor$X1, stroke = TRUE, fillOpacity = 0.01, smoothFactor = 0.5,
    color = "#FF0000")

  
m  # Print the map
 

