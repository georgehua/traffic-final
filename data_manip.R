library(dplyr)

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

