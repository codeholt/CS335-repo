library(nycflights13)
library(tidyverse)

View(flights)
View(airports)

#make sure key is unique
airports %>% count(faa) %>% filter(n > 1)
flights %>% count(dest) %>% filter(n > 1)
#for composite keys
weather %>% count(origin, year, month, day, hour) %>% filter(n > 1)
weather %>% count(origin, time_hour) %>% filter(n > 1)

View(airlines)

#joins the tables by the carrier column
flights %>% left_join(airlines, by = "carrier")








