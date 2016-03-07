#Esteban Parreno
#Final project
#r script used for testing out leaflet


install.packages("leaflet")
install.packages("sp")

library(leaflet)
library(sp)

testline <- cbind(c(-122.152380, -122.286687),c(47.462732, 47.838077))

m <- leaflet() %>%
  addProviderTiles("Stamen.Toner") %>%  # Add default OpenStreetMap map tiles
  addMarkers(lat=47.5095884, lng=-122.2010203, popup="The birthplace of R") %>% 
  fitBounds(-122.152380, 47.462732, -122.286687, 47.838077) %>% 
  addPolylines(
    stroke = TRUE, fillOpacity = 0.01, smoothFactor = 0.5,
    color = "#000000", data = testline)

  
m  # Print the map
 

