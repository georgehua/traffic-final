library(shiny)
library(leaflet)
library(dplyr)
library(jsonlite)

# start shiny part
ui <- fluidPage(
  fluidRow(
    column(6,
           leafletOutput("mymap")
    ),
    column(6, leafletOutput("mymap2"))

  ),
  fluidRow(
    column(4,   selectInput("corridor", label = h3("Corridor"), 
                            choices = list("8th to SR527" = "points_8th_to_SR527",
                                           "Bellevue to Totem Lake" = "points_Bell_to_Totemlk",
                                           "I-5 to SR-522" = "points_I5_to_SR522", 
                                           "I-5 to SR-527" = "points_I5_to_SR527",
                                           "NE85th to SR-520" = "points_NE85th_SR520", 
                                           "SR-520 to NE70th" = "points_SR520_NE70th"), 
                            selected = "8th to SR527")
    ),
    column(8,   sliderInput("slider", label = h3("Slider"), min = 1, 
                            max = 24, step=0.5, animate= animationOptions(loop = TRUE, interval = 500), value = 0, width = "100%")
    )
    
  )
  
  

)

server <- function(input, output) {
  
  #Used to get lat and lng for poly line
  url_8th_to_SR527 <- ("http://dev.virtualearth.net/REST/v1/Routes?wp.0=47.617597,-122.188537&wp.1=47.794967,%20-122.214141&routePathOutput=Points&output=json&key=Ai7aXwHGDAQAsbwOL9SOsRZA-OxuCMmTurPSpN6EqzFQsr4qA65wJGuIBNLxX7At")
  url_Bell_to_Totemlk <- ("http://dev.virtualearth.net/REST/v1/Routes?wp.0=47.615449,-122.188641&wp.1=47.705301,-122.179698&routePathOutput=Points&output=json&key=Ai7aXwHGDAQAsbwOL9SOsRZA-OxuCMmTurPSpN6EqzFQsr4qA65wJGuIBNLxX7At")
  url_I5_to_SR522 <- ("http://dev.virtualearth.net/REST/v1/Routes?wp.0=47.827635,-122.256036&wp.1=47.762606,-122.185533&routePathOutput=Points&output=json&key=Ai7aXwHGDAQAsbwOL9SOsRZA-OxuCMmTurPSpN6EqzFQsr4qA65wJGuIBNLxX7At")
  url_I5_to_SR527 <- ("http://dev.virtualearth.net/REST/v1/Routes?wp.0=47.827635,-122.256036&wp.1=47.794821,-122.214448&routePathOutput=Points&output=json&key=Ai7aXwHGDAQAsbwOL9SOsRZA-OxuCMmTurPSpN6EqzFQsr4qA65wJGuIBNLxX7At")
  url_NE85th_SR520 <- ("http://dev.virtualearth.net/REST/v1/Routes?wp.0=47.679087,-122.184709&wp.1=47.637159,-122.186778&routePathOutput=Points&output=json&key=Ai7aXwHGDAQAsbwOL9SOsRZA-OxuCMmTurPSpN6EqzFQsr4qA65wJGuIBNLxX7At")
  url_SR520_NE70th <- ("http://dev.virtualearth.net/REST/v1/Routes?wp.0=47.639210,-122.186392&wp.1=47.664188,-122.186911&routePathOutput=Points&output=json&key=Ai7aXwHGDAQAsbwOL9SOsRZA-OxuCMmTurPSpN6EqzFQsr4qA65wJGuIBNLxX7At")
  
  #function that parses through api
  parseData <- function(url) {
    data <- fromJSON(url)
    position <- as.data.frame(data$resourceSet$resources)
    position <- flatten(position)
    return(as.data.frame(position$routePath.line.coordinates))
  }
  
  #Points are created
  points_8th_to_SR527 <- parseData(url_8th_to_SR527)
  points_Bell_to_Totemlk <- parseData(url_Bell_to_Totemlk)
  points_I5_to_SR522 <- parseData(url_I5_to_SR522)
  points_I5_to_SR527 <- parseData(url_I5_to_SR527)
  points_NE85th_SR520 <- parseData(url_NE85th_SR520)
  points_SR520_NE70th <- parseData(url_SR520_NE70th)
  
  
  
  B_520_70 <- read.csv("https://raw.githubusercontent.com/joycieyu/traffic-final/george/data(new)/Before%20SR%20520%20to%20NE%2070th.csv")
  A_520_70 <- read.csv("https://raw.githubusercontent.com/joycieyu/traffic-final/george/data(new)/After%20SR%20520%20to%20NE%2070.csv")
  A_8th_527 <- read.csv("https://raw.githubusercontent.com/joycieyu/traffic-final/george/data(new)/After%208th%20to%20SR%20527.csv")
  B_8th_527 <- read.csv("https://raw.githubusercontent.com/joycieyu/traffic-final/george/data(new)/Before%208th%20to%20SR%20527.csv")
  A_Bellvue_Totem <- read.csv("https://raw.githubusercontent.com/joycieyu/traffic-final/george/data(new)/After%20Bellevue%20to%20Totem%20Lk.csv")
  B_Bellvue_totem <- read.csv("https://raw.githubusercontent.com/joycieyu/traffic-final/george/data(new)/Before%20Bell%20to%20Ttm%20Lk.csv")
  A_I5_522 <- read.csv("https://raw.githubusercontent.com/joycieyu/traffic-final/george/data(new)/After%20I-5%20to%20522.csv")
  B_I5_522 <- read.csv("https://raw.githubusercontent.com/joycieyu/traffic-final/george/data(new)/Before%201-5%20to%20522.csv")
  A_I5_527 <- read.csv("https://raw.githubusercontent.com/joycieyu/traffic-final/george/data(new)/After%20I-5%20to%20SR%20527.csv")
  B_I5_527 <- read.csv("https://raw.githubusercontent.com/joycieyu/traffic-final/george/data(new)/Before%20I-5%20to%20SR527.csv")
  A_85_520 <- read.csv("https://raw.githubusercontent.com/joycieyu/traffic-final/george/data(new)/After%20NE85th%20to%20520.csv")
  B_85_520 <- read.csv("https://raw.githubusercontent.com/joycieyu/traffic-final/george/data(new)/Before%20NE85th%20to%20520.csv")
  
  # the function that assign every 6 rows(30mins) the same name
  # for the sake of group_by() the dataset
  create_name <- function(dataset) {
    dataset$name
    for(i in 0:47) {
      for(j in 1:6) {
        dataset[j + 6 * i,'name'] <- (i + 1) / 2
      }
    }
    return(dataset)
  }
  
  # create the universal name col for every dataset
  B_520_70 <- create_name(B_520_70)
  A_520_70 <- create_name(A_520_70)
  A_8th_527 <- create_name(A_8th_527)
  B_8th_527 <- create_name(B_8th_527)
  A_Bellvue_Totem <- create_name(A_Bellvue_Totem)
  B_Bellvue_totem <- create_name(B_Bellvue_totem)
  A_I5_522 <- create_name(A_I5_522)
  B_I5_522 <- create_name(B_I5_522)
  A_I5_527 <- create_name(A_I5_527)
  B_I5_527 <- create_name(B_I5_527)
  A_85_520 <- create_name(A_85_520)
  B_85_520 <- create_name(B_85_520)
  
  # group the dataset and calculate the average TTS
  cal_index <- function(dataset) {
    average <- dataset %>% group_by(name) %>% summarise(average = mean(Avg..TTS))
    return(average)
  }
  
  #Calculates averages for before and after
  B_520_70_average <- cal_index(B_520_70)
  A_520_70_average <- cal_index(A_520_70)
  B_8th_527_average <- cal_index(B_8th_527)
  A_8th_527_average <- cal_index(A_8th_527)
  B_Bellvue_Totem_average <- cal_index(B_Bellvue_totem)
  A_Bellvue_totem_average <- cal_index(A_Bellvue_Totem)
  B_I5_522_average <- cal_index(B_I5_522)
  A_I5_522_average <- cal_index(A_I5_522)
  B_I5_527_average <- cal_index(B_I5_527)
  A_I5_527_average <- cal_index(A_I5_527)
  B_85_520_average <- cal_index(B_85_520)
  A_85_520_average <- cal_index(A_85_520)
  
  
  
  
  build_map <- function(data_avg, input_slider, dataset) {
    data <- eval(parse(text = dataset))
    input_slider_value <- data_avg[which(data_avg$name == 1.0 * input_slider),"average"]
    input_slider_value <- as.numeric(input_slider_value)
    
    pal <- colorNumeric(
      palette = c("green", "red"),
      domain = data_avg$average
    )
    
    m <- leaflet() %>%
      addProviderTiles("CartoDB.Positron") %>%  
      fitBounds(lng1 = min(data$X2), lat1 = max(data$X1), lng2 = max(data$X2), lat2 = min(data$X1)) %>% 
      addPolylines(
        lng=data$X2, lat=data$X1, stroke = TRUE, opacity = 0.5, smoothFactor = 0.5,
        color = pal(input_slider_value), weight = round(input_slider_value/80, digits=0)+10)
    
    return(m)
  }
  
  get_data_avg_B <- function (corridor) {
    if (corridor == "points_8th_to_SR527") {
      return(B_8th_527_average)
    } else if (corridor == "points_Bell_to_Totemlk") {
      return(B_Bellvue_Totem_average)
    } else if (corridor == "points_I5_to_SR522") {
      return(B_I5_522_average)
    } else if (corridor == "points_I5_to_SR527") {
      return(B_I5_527_average)
    } else if (corridor == "points_NE85th_SR520") {
      return(B_85_520_average)
    } else if (corridor == "points_SR520_NE70th") {
      return(B_520_70_average)
    }
  }
  
  get_data_avg_A <- function (corridor) {
    if (corridor == "points_8th_to_SR527") {
      return(A_8th_527_average)
    } else if (corridor == "points_Bell_to_Totemlk") {
      return(A_Bellvue_Totem_average)
    } else if (corridor == "points_I5_to_SR522") {
      return(A_I5_522_average)
    } else if (corridor == "points_I5_to_SR527") {
      return(A_I5_527_average)
    } else if (corridor == "points_NE85th_SR520") {
      return(A_85_520_average)
    } else if (corridor == "points_SR520_NE70th") {
      return(A_520_70_average)
    }
  }
  
  #observe({
   # data <- eval(parse(text = input$corridor))
    #input_slider_value <- data_avg[which(data_avg$name == 1.0 * input$slider),"average"]
    #input_slider_value <- as.numeric(input_slider_value)
    #leafletProxy("mymap") %>% addPolylines(
    #  lng=data$X2, lat=data$X1, stroke = TRUE, opacity = input_slider_value/1000+0.3, smoothFactor = 0.5,
     # color = pal(input_slider_value), weight = round(input_slider_value/80, digits=0)+10)
  #})
  
  output$mymap <- renderLeaflet({
    mymap <- build_map(get_data_avg_B(input$corridor), input$slider, input$corridor)
  })
  output$mymap2 <- renderLeaflet({
    mymap2 <- build_map(get_data_avg_A(input$corridor), input$slider, input$corridor)
  })
  
  
}

shinyApp(ui, server)
