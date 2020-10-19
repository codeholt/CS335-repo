library(ggplot2)
library(tidyverse)
library(dplyr)
library(readr)
library(lubridate)



gunDeaths <- read_csv(url("https://github.com/fivethirtyeight/guns-data/blob/master/full_data.csv?raw=true"))
View(gunDeaths)

gunDeaths$month <- as.numeric(gunDeaths$month)
str(gunDeaths)

gunDeaths <- gunDeaths %>% 
  mutate(season = 
            case_when(
              month %in% c(12,01,02) ~ "Winter",
              month %in% c(03,04,05) ~ "Spring",
              month %in% c(06,07,08) ~ "Summer",
              month %in% c(09,10,11) ~ "Fall"
              )
            )

#just getting a general overview
gunDeaths %>% 
  ggplot(aes(group = education, fill = education), 
         color = "black") +
  geom_bar(aes(x = intent),stat = "count", position = "dodge")+
  facet_grid(. ~ education)+ 
  theme(axis.text.x = element_text(angle = 90, hjust = 1))



#lubridate::days_in_month(1:12) will give you the number of days in each month

#filtering down to suicides
suicides <- gunDeaths %>% 
  filter(intent == "Suicide") %>% 
  group_by(year, month) %>% 
  summarise(totalSuicides = n()) %>% 
  mutate(suicidesPerDay = totalSuicides/lubridate::days_in_month(1:12),
         season = 
           case_when(
             month %in% c(12,01,02) ~ "Winter",
             month %in% c(03,04,05) ~ "Spring",
             month %in% c(06,07,08) ~ "Summer",
             month %in% c(09,10,11) ~ "Fall"
           )
         )
#adding season back in

View(suicides)

avgSeasonSuicide <- suicides %>% 
  group_by(season) %>% 
  summarise(suicidesPerDay = mean(suicidesPerDay))

View(avgMonthSuicide)


#Shows the average number of suicides per day for three years


ggplot(gunDeaths, aes(x=season, fill = season))+
 geom_bar()+
  facet_grid(. ~ year)


#average number of suicides per season

avgPerMonth<- gunDeaths %>% 
  filter(intent=="Suicide") %>% 
  group_by(sex,month) %>% 
  summarise(totalPerMonth = n()) %>% 
  mutate(suicidesPerDay = totalPerMonth/lubridate::days_in_month(1:12))

View(avgPerMonth)

#shows who they can target with ads
ggplot(avgPerMonth, aes(x=month, y= suicidesPerDay, group = sex, color = sex))+
  geom_line()+
  geom_point()+
  scale_x_continuous(breaks =seq(1,12,by =1))









