library(dplyr)
library(leaflet)
library(sp)
library(jsonlite)
source("script.R")

url_8th_to_SR527 <- ("http://dev.virtualearth.net/REST/v1/Routes?wp.0=47.617597,-122.188537&wp.1=47.794967,%20-122.214141&routePathOutput=Points&output=json&key=Ai7aXwHGDAQAsbwOL9SOsRZA-OxuCMmTurPSpN6EqzFQsr4qA65wJGuIBNLxX7At")
url_Bell_to_Totemlk <- ("http://dev.virtualearth.net/REST/v1/Routes?wp.0=47.615449,-122.188641&wp.1=47.705301,-122.179698&routePathOutput=Points&output=json&key=Ai7aXwHGDAQAsbwOL9SOsRZA-OxuCMmTurPSpN6EqzFQsr4qA65wJGuIBNLxX7At")
url_I5_to_SR522 <- ("http://dev.virtualearth.net/REST/v1/Routes?wp.0=47.827635,-122.256036&wp.1=47.762606,-122.185533&routePathOutput=Points&output=json&key=Ai7aXwHGDAQAsbwOL9SOsRZA-OxuCMmTurPSpN6EqzFQsr4qA65wJGuIBNLxX7At")
url_I5_to_SR527 <- ("http://dev.virtualearth.net/REST/v1/Routes?wp.0=47.827635,-122.256036&wp.1=47.794821,-122.214448&routePathOutput=Points&output=json&key=Ai7aXwHGDAQAsbwOL9SOsRZA-OxuCMmTurPSpN6EqzFQsr4qA65wJGuIBNLxX7At")
url_NE85th_SR520 <- ("http://dev.virtualearth.net/REST/v1/Routes?wp.0=47.679087,-122.184709&wp.1=47.637159,-122.186778&routePathOutput=Points&output=json&key=Ai7aXwHGDAQAsbwOL9SOsRZA-OxuCMmTurPSpN6EqzFQsr4qA65wJGuIBNLxX7At")
url_SR520_NE70th <- ("http://dev.virtualearth.net/REST/v1/Routes?wp.0=47.639210,-122.186392&wp.1=47.664188,-122.186911&routePathOutput=Points&output=json&key=Ai7aXwHGDAQAsbwOL9SOsRZA-OxuCMmTurPSpN6EqzFQsr4qA65wJGuIBNLxX7At")

parseData <- function(url) {
  data <- fromJSON(url)
  position <- as.data.frame(data$resourceSet$resources)
  position <- flatten(position)
  return(as.data.frame(position$routePath.line.coordinates))
}

points_8th_to_SR527 <- parseData(url_8th_to_SR527)
points_Bell_to_Totemlk <- parseData(url_Bell_to_Totemlk)
points_I5_to_SR522 <- parseData(url_I5_to_SR522)
points_I5_to_SR527 <- parseData(url_I5_to_SR527)
points_NE85th_SR520 <- parseData(url_NE85th_SR520)
points_SR520_NE70th <- parseData(url_SR520_NE70th)


build_map <- function(data_avg, input_slider, dataset) {
  data <- eval(parse(text = dataset))
  input_slider_value <- data_avg[which(data_avg$name == 1.0 * input_slider),"average"]
  input_slider_value <- as.numeric(input_slider_value)
  
  pal <- colorNumeric(
  palette = "Red",
  domain = input_slider_value
  )
  
  m <- leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%  # Add default OpenStreetMap map tiles
    fitBounds(lng1 = min(data$X2), lat1 = max(data$X1), lng2 = max(data$X2), lat2 = min(data$X1)) %>% 
    addPolylines(
      lng=data$X2, lat=data$X1, stroke = TRUE, opacity = input_slider_value/1000+0.3, smoothFactor = 0.5,
      color = pal(input_slider_value), weight = round(input_slider_value/80, digits=0)+10)
    
  return(m)
}

