library(ggplot2)
library(tidyverse)
library(dplyr)
library(readr)




gunDeaths <- read_csv(url("https://github.com/fivethirtyeight/guns-data/blob/master/full_data.csv?raw=true"))
View(gunDeaths)

gunDeaths <- mutate(season = 
                      case_when(
                        month %in% c(12,01,02) ~ "Winter"
                        month %in% c(03,04,05) ~ "Spring"
                        month %in% c(06,07,08) ~ "Summer"
                        month %in% c(09,10,11) ~ "Winter"
                      ))

gunDeaths %>% 
  ggplot(aes(x=intent, group = education, fill = education), 
         color = "black") +
  geom_bar(stat = "count", position = )


#lubridate::days_in_month(1:12) will give you the number of days in each month
