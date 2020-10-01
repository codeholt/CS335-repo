library(ggplot2)
library(tibble)
library(tidyr)
library(readr)
library(tidyverse)
View(mpg)

ggplot(data = mpg)+
  geom_point(mapping = aes(x=displ,y=hwy))

ggplot(data = mpg)#no graph shows 
?mpg #234 rows and 11 columns
#drv describes if its front wheel, back wheel or 4 wheel drive
ggplot(data = mpg)+
  geom_point(mapping = aes(x=hwy,y=cyl))
ggplot(data = mpg)+
  geom_point(mapping = aes(x=drv,y=class))
# it only tells us that there are vehicles of a class with a certain drive
ggplot(data = mpg)+
  geom_point(mapping = aes(x=displ,y=hwy, color = class))
ggplot(data = mpg)+
  geom_point(mapping = aes(x=displ,y=hwy, size = class))
ggplot(data = mpg)+
  geom_point(mapping = aes(x=displ,y=hwy, alpha = class))
ggplot(data = mpg)+
  geom_point(mapping = aes(x=displ,y=hwy, shape= class))


ggplot(data = mpg)+
  geom_point(mapping = aes(x=displ,y=hwy), color = "blue")

#3.3.1
#1. ggplot(data = mpg) + 
# geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))
#the color is being applied to variables in column  Blue

#2. model, trans, drv, fl, and class are all categorical
#3
ggplot(data = mpg)+
  geom_point(mapping = aes(x=displ,y=hwy, color=cyl, size=year))
#cant map shape to continuous. color goes from dark=low to light = high. shape goes from small=smallnum, large=largenum
#4.
ggplot(data = mpg)+
  geom_point(mapping = aes(x=displ,y=hwy, color=year, size=year))
ggplot(data = mpg)+
  geom_point(mapping = aes(x=displ,y=hwy, stroke=cyl))

ggplot(data = mpg)+
  geom_point(mapping = aes(x=displ,y=hwy, color=displ<5))
#colors them based on thier boolean variable
