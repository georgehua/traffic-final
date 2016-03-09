library(dplyr)

B_520_70 <- read.csv("data(new)/Before SR 520 to NE 70th.csv")
A_520_70 <- read.csv("data(new)/After SR 520 to NE 70.csv")

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

# group the dataset and calculate the average TTS
cal_index <- function(dataset) {
  average <- dataset %>% group_by(name) %>% summarise(average = mean(Avg..TTS))
  return(average)
}

B_520_70_average <- cal_index(B_520_70)

