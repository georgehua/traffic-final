library(shiny)
library(dplyr)
library(plotly)
library(jsonlite)
library(leaflet)

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



shinyServer(function(input, output) {
    
  create_map2 <- eventReactive(input$render, {
    p <- leaflet() %>%
    addProviderTiles("CartoDB.Positron") 
    
    
    
    if (input$corridor == "8th_to_SR527") {
      p <- addPolylines(p,
        lng=points_8th_to_SR527$X2, lat=points_8th_to_SR527$X1, stroke = TRUE, fillOpacity = 1, smoothFactor = 0.5,
        color = "#0000FF")
    } else if (input$corridor == "Bell_to_Totemlk") {
      p <- addPolylines(p,
        lng=points_Bell_to_Totemlk$X2, lat=points_Bell_to_Totemlk$X1, stroke = TRUE, fillOpacity = 1, smoothFactor = 0.5,
        color = "#0000FF")
    } else if (input$corridor == "I5_to_SR522") {
      p <- addPolylines(p,
        lng=points_I5_to_SR522$X2, lat=points_I5_to_SR522$X1, stroke = TRUE, fillOpacity = 1, smoothFactor = 0.5,
        color = "#0000FF")        
    } else if (input$corridor == "I5_to_SR527") {
      p <- addPolylines(p,
        lng=points_I5_to_SR527$X2, lat=points_I5_to_SR527$X1, stroke = TRUE, fillOpacity = 1, smoothFactor = 0.5,
        color = "#0000FF")   
    } else if (input$corridor == "NE85th_SR520") {
      p <- addPolylines(p,
        lng=points_NE85th_SR520$X2, lat=points_NE85th_SR520$X1, stroke = TRUE, fillOpacity = 1, smoothFactor = 0.5,
        color = "#0000FF")    
    } else if (input$corridor == "SR520_NE70th") {
      p <- addPolylines(p,
        lng=points_SR520_NE70th$X2, lat=points_SR520_NE70th$X1, stroke = TRUE, fillOpacity = 1, smoothFactor = 0.5,
        color = "#0000FF")
    }
      
      
    return(p)
  })
    
  output$mymap <- renderLeaflet({
    create_map2()
  })
})