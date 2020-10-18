library(readr)
library(ggplot2)
library(tidyverse)


dowData<- read_rds(url("https://github.com/byuistats/data/blob/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.RDS?raw=true"))
View(dowData)

#doesnt work, need to make data long
dowData %>% 
  #group_by(contest_period) %>% 
  ggplot(aes(x=contest_period,y=value, group=variable, color = variable))+
  geom_line()

doPros <- dowData %>% 
  filter(variable=PROS)
#make a graph from there

#turns the date into column names, and the rows into the variable
dowLong <- dowData %>% 
  pivot_wider(names_from = contest_period, values_from = value)
View(dowLong)

#graph using cleaned data
#nvm, have to turn it a different way
dowLong %>% 
  group_by(variable) %>% 
  ggplot(aes(x=contest_period,y=value))

#redid using variable as column name
dowTall <- dowData %>% 
  pivot_wider(names_from = variable, values_from = value)
View(dowTall)



dowLong %>% 
  group_by(variable) %>% 
  ggplot(aes(x=contest_period))+
  geom_line(aes(y=PROS))+
  geom_line(aes(y=DARTS))+
  geom_line(aes(y=DJIA))




