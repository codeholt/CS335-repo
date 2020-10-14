library(ggplot2)
#can assign variables
x <- "hello world"
x
aNameThatsWayTooLong <- 2.5
aNameThatsWayTooLong

#names are case sensitive
r_rocks <- 2^3
r_Rocks
R_rocks
r_rocks

#sequence function
seq(1,10)
y <- seq(1,10, length.out = 5)
y
#or
(y <- seq(1,10, length.out = 5)) #this is new, and its kinda cool

#exercise 1
my_variable <- 10
my_variable
#variable names dont match. the "I" is replaced with an "l"
library(tidyverse)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y=hwy))

filter(mpg, cyl == 8)
filter(diamonds, carat > 3)
