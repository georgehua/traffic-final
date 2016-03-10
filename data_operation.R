library(dplyr)
library(jsonlite)

B_520_70 <- read.csv("https://raw.githubusercontent.com/joycieyu/traffic-final/master/data(new)/Before%20SR%20520%20to%20NE%2070th.csv")
A_520_70 <- read.csv("https://raw.githubusercontent.com/joycieyu/traffic-final/master/data(new)/After%20SR%20520%20to%20NE%2070.csv")
A_8th_527 <- read.csv("https://raw.githubusercontent.com/joycieyu/traffic-final/master/data(new)/After%208th%20to%20SR%20527.csv")
B_8th_527 <- read.csv("https://raw.githubusercontent.com/joycieyu/traffic-final/master/data(new)/Before%208th%20to%20SR%20527.csv")
A_Bellvue_Totem <- read.csv("https://raw.githubusercontent.com/joycieyu/traffic-final/master/data(new)/After%20Bellevue%20to%20Totem%20Lk.csv")
B_Bellvue_totem <- read.csv("https://raw.githubusercontent.com/joycieyu/traffic-final/master/data(new)/Before%20Bell%20to%20Ttm%20Lk.csv")
A_I5_522 <- read.csv("https://raw.githubusercontent.com/joycieyu/traffic-final/master/data(new)/After%20I-5%20to%20522.csv")
B_I5_522 <- read.csv("https://raw.githubusercontent.com/joycieyu/traffic-final/master/data(new)/Before%201-5%20to%20522.csv")
A_I5_527 <- read.csv("https://raw.githubusercontent.com/joycieyu/traffic-final/master/data(new)/After%20I-5%20to%20SR%20527.csv")
B_I5_527 <- read.csv("https://raw.githubusercontent.com/joycieyu/traffic-final/master/data(new)/Before%20I-5%20to%20SR527.csv")
A_85_520 <- read.csv("https://raw.githubusercontent.com/joycieyu/traffic-final/master/data(new)/After%20NE85th%20to%20520.csv")
B_85_520 <- read.csv("https://raw.githubusercontent.com/joycieyu/traffic-final/master/data(new)/Before%20NE85th%20to%20520.csv")

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

# create the name col for every dataset
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


# This is the final df we use for displaying traffic situation
# Note the difference between A and B
B_Rd_520_70_average <- cal_index(B_520_70)
A_Rd_520_70_average <- cal_index(A_520_70)
B_Rd_8th_to_SR527_average <- cal_index(B_8th_527)
A_Rd_8th_to_SR527_average <- cal_index(A_8th_527)
B_Rd_Bellvue_Totem_average <- cal_index(B_Bellvue_totem)
A_Rd_Bellvue_totem_average <- cal_index(A_Bellvue_Totem)
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
Rd_520_70_points <- parseData(url_Bell_to_Totemlk)
Rd_I5_to_SR522_points <- parseData(url_I5_to_SR522)
Rd_I5_to_SR527_points <- parseData(url_I5_to_SR527)
Rd_NE85th_SR520_points <- parseData(url_NE85th_SR520)
Rd_SR520_NE70th_points <- parseData(url_SR520_NE70th)



