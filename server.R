library(shiny)
library(dplyr)
library(plotly)
library(jsonlite)
library(leaflet)
library(rsconnect)
library(httr)

server <- function(input, output) {
  
  B_SR520_NE70th <- GET("http://raw.githubusercontent.com/joycieyu/traffic-final/master/data(new)/Before%20SR%20520%20to%20NE%2070th.csv")
  B_SR520_NE70th <- read.csv(textConnection(content(B_SR520_NE70th, as="text")))
  A_SR520_NE70th <- GET("http://raw.githubusercontent.com/joycieyu/traffic-final/master/data(new)/After%20SR%20520%20to%20NE%2070.csv")
  A_SR520_NE70th <- read.csv(textConnection(content(A_SR520_NE70th, as="text")))
  A_8th_527 <- GET("http://raw.githubusercontent.com/joycieyu/traffic-final/master/data(new)/After%208th%20to%20SR%20527.csv")
  A_8th_527 <- read.csv(textConnection(content(A_8th_527, as="text")))
  B_8th_527 <- GET("http://raw.githubusercontent.com/joycieyu/traffic-final/master/data(new)/Before%208th%20to%20SR%20527.csv")
  B_8th_527 <- read.csv(textConnection(content(B_8th_527, as="text")))
  A_Bellvue_Totem <- GET("http://raw.githubusercontent.com/joycieyu/traffic-final/master/data(new)/After%20Bellevue%20to%20Totem%20Lk.csv")
  A_Bellvue_Totem <- read.csv(textConnection(content(A_Bellvue_Totem, as="text")))
  B_Bellvue_Totem <- GET("http://raw.githubusercontent.com/joycieyu/traffic-final/master/data(new)/Before%20Bell%20to%20Ttm%20Lk.csv")
  B_Bellvue_Totem <- read.csv(textConnection(content(B_Bellvue_Totem, as="text")))
  A_I5_522 <- GET("http://raw.githubusercontent.com/joycieyu/traffic-final/master/data(new)/After%20I5%20to%20522.csv")
  A_I5_522 <- read.csv(textConnection(content(A_I5_522, as="text")))
  B_I5_522 <- GET("http://raw.githubusercontent.com/joycieyu/traffic-final/master/data(new)/Before%201-5%20to%20522.csv")
  B_I5_522 <- read.csv(textConnection(content(B_I5_522, as="text")))
  A_I5_527 <- GET("http://raw.githubusercontent.com/joycieyu/traffic-final/master/data(new)/After%20I-5%20to%20SR%20527.csv")
  A_I5_527 <- read.csv(textConnection(content(A_I5_527, as="text")))
  B_I5_527 <- GET("http://raw.githubusercontent.com/joycieyu/traffic-final/master/data(new)/Before%20I-5%20to%20SR527.csv")
  B_I5_527 <- read.csv(textConnection(content(B_I5_527, as="text")))
  A_85_520 <- GET("http://raw.githubusercontent.com/joycieyu/traffic-final/master/data(new)/After%20NE85th%20to%20520.csv")
  A_85_520 <- read.csv(textConnection(content(A_85_520, as="text")))
  B_85_520 <- GET("http://raw.githubusercontent.com/joycieyu/traffic-final/master/data(new)/Before%20NE85th%20to%20520.csv")
  B_85_520 <- read.csv(textConnection(content(B_85_520, as="text")))
  
  # the function that assign every 6 rows(30mins) the same name
  # for the sake of group_by() the dataset
  output$plotBefore <- renderPlotly({
    
    # sorts what user input that selects the database according to chosen corridor
    if (input$corridor == "Rd_8th_to_SR527") {
      data1 = B_8th_527
      data2 = A_8th_527
    } else if (input$corridor == "Rd_I5_to_SR522") {
      data1 = B_I5_522
      data2 = A_I5_522
    } else if (input$corridor == "Rd_Bellvue_Totem") {
      data1 = B_Bellvue_Totem
      data2 = A_Bellvue_Totem
    } else if (input$corridor == "Rd_I5_to_SR527") {
      data1 = B_I5_527
      data2 = A_I5_527
    } else if (input$corridor == "Rd_NE85th_SR520") {
      data1 = B_85_520
      data2 = A_85_520
    } else {
      data1 = B_SR520_NE70th
      data2 = A_SR520_NE70th
    }
    
    #sets margins for graph
    m = list(
      l = 0,
      r = 0,
      b = 100,
      t = 25,
      pad = 4)
    
    # plots graph with after data on top
    p <- plot_ly(data = data1, x = Time, y = Avg..TTS / 60, mode = "markers", name = "Before", showlegend = FALSE)  
    p <- add_trace(data = data2, x = Time, y = Avg..TTS / 60, mode = "markers", name = "After") %>% 
      layout(margin = m, paper_bgcolor = "#000000", plot_bgcolor = "#000000", xaxis = list(gridcolor = "#000000"), yaxis = list(gridcolor = "#000000"))
  })
  
  create_name <- function(dataset) {
    df <- dataset %>% select(Time, Avg..TTS)
    return(df)
  }
  
  # create the name col for every dataset
  B_SR520_NE70th <- create_name(B_SR520_NE70th)
  A_SR520_NE70th <- create_name(A_SR520_NE70th)
  A_8th_527 <- create_name(A_8th_527)
  B_8th_527 <- create_name(B_8th_527)
  A_Bellvue_Totem <- create_name(A_Bellvue_Totem)
  B_Bellvue_Totem <- create_name(B_Bellvue_Totem)
  A_I5_522 <- create_name(A_I5_522)
  B_I5_522 <- create_name(B_I5_522)
  A_I5_527 <- create_name(A_I5_527)
  B_I5_527 <- create_name(B_I5_527)
  A_85_520 <- create_name(A_85_520)
  B_85_520 <- create_name(B_85_520)
  
  
  # group the dataset and calculate the average TTS
  cal_index <- function(dataset) {
    return(dataset)
  }
  
  
  # This is the final df we use for displaying traffic situation
  # Note the difference between A and B
  B_Rd_SR520_NE70th_average <- cal_index(B_SR520_NE70th)
  A_Rd_SR520_NE70th_average <- cal_index(A_SR520_NE70th)
  B_Rd_8th_to_SR527_average <- cal_index(B_8th_527)
  A_Rd_8th_to_SR527_average <- cal_index(A_8th_527)
  B_Rd_Bellvue_Totem_average <- cal_index(B_Bellvue_Totem)
  A_Rd_Bellvue_Totem_average <- cal_index(A_Bellvue_Totem)
  B_Rd_I5_to_SR522_average <- cal_index(B_I5_522)
  A_Rd_I5_to_SR522_average <- cal_index(A_I5_522)
  B_Rd_I5_to_SR527_average <- cal_index(B_I5_527)
  A_Rd_I5_to_SR527_average <- cal_index(A_I5_527)
  B_Rd_NE85th_SR520_average <- cal_index(B_85_520)
  A_Rd_NE85th_SR520_average <- cal_index(A_85_520)
  
  # read in road  coor info 
  url_8th_to_SR527 <- ("http://dev.virtualearth.net/REST/v1/Routes?wp.0=47.617597,-122.188537&wp.1=47.794967,%20-122.214141&routePathOutput=Points&output=json&key=Ai7aXwHGDAQAsbwOL9SOsRZA-OxuCMmTurPSpN6EqzFQsr4qA65wJGuIBNLxX7At")
  url_Bell_to_Totemlk <- ("http://dev.virtualearth.net/REST/v1/Routes?wp.0=47.615449,-122.188641&wp.1=47.705301,-122.179698&routePathOutput=Points&output=json&key=Ai7aXwHGDAQAsbwOL9SOsRZA-OxuCMmTurPSpN6EqzFQsr4qA65wJGuIBNLxX7At")
  url_I5_to_SR522 <- ("http://dev.virtualearth.net/REST/v1/Routes?wp.0=47.827635,-122.256036&wp.1=47.762606,-122.185533&routePathOutput=Points&output=json&key=Ai7aXwHGDAQAsbwOL9SOsRZA-OxuCMmTurPSpN6EqzFQsr4qA65wJGuIBNLxX7At")
  url_I5_to_SR527 <- ("http://dev.virtualearth.net/REST/v1/Routes?wp.0=47.827635,-122.256036&wp.1=47.794821,-122.214448&routePathOutput=Points&output=json&key=Ai7aXwHGDAQAsbwOL9SOsRZA-OxuCMmTurPSpN6EqzFQsr4qA65wJGuIBNLxX7At")
  url_NE85th_SR520 <- ("http://dev.virtualearth.net/REST/v1/Routes?wp.0=47.679087,-122.184709&wp.1=47.637159,-122.186778&routePathOutput=Points&output=json&key=Ai7aXwHGDAQAsbwOL9SOsRZA-OxuCMmTurPSpN6EqzFQsr4qA65wJGuIBNLxX7At")
  url_SR520_NE70th <- ("http://dev.virtualearth.net/REST/v1/Routes?wp.0=47.639210,-122.186392&wp.1=47.664188,-122.186911&routePathOutput=Points&output=json&key=Ai7aXwHGDAQAsbwOL9SOsRZA-OxuCMmTurPSpN6EqzFQsr4qA65wJGuIBNLxX7At")
  
  # function that accept url as parameter and return the df which contains coors
  parseData <- function(url) {
    data <- fromJSON(url)
    position <- as.data.frame(data$resourceSet$resources)
    position <- flatten(position)
    return(as.data.frame(position$routePath.line.coordinates))
  }
  
  # they are the df we use to locate the road
  Rd_8th_to_SR527_points <- parseData(url_8th_to_SR527)
  Rd_Bellvue_Totem_points <- parseData(url_Bell_to_Totemlk)
  Rd_I5_to_SR522_points <- parseData(url_I5_to_SR522)
  Rd_I5_to_SR527_points <- parseData(url_I5_to_SR527)
  Rd_NE85th_SR520_points <- parseData(url_NE85th_SR520)
  Rd_SR520_NE70th_points <- parseData(url_SR520_NE70th)
  
  
  
  # data for points
  coor <- reactive({ 
    eval(parse(text = paste0(input$corridor, "_points")))
    
  })
  
  # data for average
  average_B <- reactive({ 
    eval(parse(text = paste0("B_", input$corridor, "_average")))
  })
  average_A <- reactive({ 
    eval(parse(text = paste0("A_", input$corridor, "_average")))
  })
  
  # palette 
  colorpal_B <- reactive({
    data_avg_A <- average_A()
    data_avg_B <- average_B()
    
    if (sum(data_avg_A$x2) > sum(data_avg_B$x2)) {
      this_domain <- data_avg_A
      this_domain_min <- data_avg_B
    } else {
      this_domain <- data_avg_B
      this_domain_min <- data_avg_A
    }  
    
    colorNumeric(palette = c("green", "red"), domain = c(min(this_domain_min$Avg..TTS)-10, max(this_domain$Avg..TTS)))
  })  
  colorpal_A <- reactive({
    data_avg_A <- average_A()
    data_avg_B <- average_B()
    
    if (sum(data_avg_A$x2) > sum(data_avg_B$x2)) {
      this_domain <- data_avg_A
      this_domain_min <- data_avg_B
    } else {
      this_domain <- data_avg_B
      this_domain_min <- data_avg_A
    }  
    
    colorNumeric(palette = c("green", "red"), domain = c(min(this_domain_min$Avg..TTS)-10, max(this_domain$Avg..TTS)))
  })
  
  # get average data based on user input
  # need [data_avg, input$slider]
  input_slider_B <- reactive({ 
    data_avg_B <- average_B()
    return_value <- data_avg_B[input$slider,"Avg..TTS"]
    as.numeric(return_value)
  })
  input_slider_A <- reactive({ 
    data_avg_A <- average_A()
    return_value <- data_avg_A[input$slider,"Avg..TTS"]
    as.numeric(return_value)
  })
  time_count_A <- reactive({
    data_avg_A <- average_A()
    return_value <- data_avg_A[input$slider,"Time"]
    as.character(return_value)
  })
  
  
  # output map 1
  # need [coor_data]
  output$map1 <- renderLeaflet({
    coor_data <- coor()
    leaflet() %>%
      addProviderTiles("CartoDB.Positron") %>%  # Add default OpenStreetMap map tiles
      fitBounds(lng1 = min(coor_data$X2), lat1 = max(coor_data$X1), lng2 = max(coor_data$X2), lat2 = min(coor_data$X1)) 
  })
  output$map2 <- renderLeaflet({
    coor_data <- coor()
    leaflet() %>%
      addProviderTiles("CartoDB.Positron") %>%  # Add default OpenStreetMap map tiles
      fitBounds(lng1 = min(coor_data$X2), lat1 = max(coor_data$X1), lng2 = max(coor_data$X2), lat2 = min(coor_data$X1))
  })
  
  
  
  # add stuffs on map1 
  # [need read: data_avg, coor_data, input$slider, input_slider_value, pal]
  observe({
    coor_data <- coor()
    pal_B <- colorpal_B()
    input_slider_value_B <- input_slider_B()
    
    leafletProxy("map1") %>%
      clearShapes() %>% 
      addPolylines(
        lng=coor_data$X2, lat=coor_data$X1, stroke = TRUE, opacity = 0.5, smoothFactor = 0.5,
        color = pal_B(input_slider_value_B), weight = round(input_slider_value_B/100, digits=0)+5) 
    
    output$traveltimeB <- renderText({paste(round(input_slider_value_B/60, digits = 2), "min")})
  })
  observe({
    coor_data <- coor()
    pal_A <- colorpal_A()
    input_slider_value_A <- input_slider_A()
    data_avg_A <- average_A()
    time_A <- time_count_A()

    
    leafletProxy("map2") %>%
      clearShapes() %>% 
      addPolylines(
        lng=coor_data$X2, lat=coor_data$X1, stroke = TRUE, opacity = 0.5, smoothFactor = 0.5,
        color = pal_A(input_slider_value_A), weight = round(input_slider_value_A/100, digits=0)+5) 
    
    output$time_count <- renderText({time_A})
    output$traveltimeA <- renderText({paste(round(input_slider_value_A/60, digits = 2), "min")})
  })
  
}