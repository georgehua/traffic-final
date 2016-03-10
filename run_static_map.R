library(sp)
library(shiny)
library(leaflet)
source("map_function.R")

# start shiny part
ui <- fluidPage(
  fluidRow(
    column(6,
           leafletOutput("map1")
    ),
    column(6,
           leafletOutput("map2")
    )
  ),
  hr(),
  
  fluidRow(
    column(4,   selectInput("corridor", label = h3("Corridor"), 
                            choices = list("Rd_8th_to_SR527" = "Rd_8th_to_SR527", "Rd_520_70" = "Rd_520_70",
                                           "Rd_I5_to_SR522" = "Rd_I5_to_SR522", "Rd_I5_to_SR527" = "Rd_I5_to_SR527",
                                           "Rd_NE85th_SR520" = "Rd_NE85th_SR520", "Rd_SR520_NE70th" = "Rd_SR520_NE70th"), 
                            selected = "Rd_8th_to_SR527")
    ),
    column(8,   sliderInput("slider", label = h3("Slider"), min = 0, 
                            max = 24, step=0.5, animate= animationOptions(loop = TRUE, interval = 300), value = 0, width = "100%")
    )
    
  )
)

server <- function(input, output) {
  
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
    data_avg_B <- average_B()
    colorNumeric(palette = c("green", "red"), domain = data_avg_B$average)
  })
  colorpal_A <- reactive({
    data_avg_A <- average_A()
    colorNumeric(palette = c("green", "red"), domain = data_avg_A$average)
  })
  
  # get average data based on user input
  # need [data_avg, input$slider]
  input_slider_B <- reactive({ 
    data_avg_B <- average_B()
    return_value <- data_avg_B[which(data_avg_B$name == 1.0 * input$slider),"average"]
    as.numeric(return_value)
  })
  input_slider_A <- reactive({ 
    data_avg_A <- average_A()
    return_value <- data_avg_A[which(data_avg_A$name == 1.0 * input$slider),"average"]
    as.numeric(return_value)
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
        lng=coor_data$X2, lat=coor_data$X1, stroke = TRUE, opacity = input_slider_value_B/1000+0.3, smoothFactor = 0.5,
        color = pal_B(input_slider_value_B), weight = round(input_slider_value_B/80, digits=0)+10) 
  })
  observe({
    coor_data <- coor()
    pal_A <- colorpal_A()
    input_slider_value_A <- input_slider_A()
    
    leafletProxy("map2") %>%
      clearShapes() %>% 
      addPolylines(
        lng=coor_data$X2, lat=coor_data$X1, stroke = TRUE, opacity = input_slider_value_A/1000+0.3, smoothFactor = 0.5,
        color = pal_A(input_slider_value_A), weight = round(input_slider_value_A/80, digits=0)+10) 
  })
  
}

# run shiny app
shinyApp(ui, server)
