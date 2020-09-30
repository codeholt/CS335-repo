library(ggplot2)
library(tibble)
library(tidyr)
library(readr)
library(tidyverse)
library(pander)

install.packages("gapminder")
library(gapminder)
View(gapminder)
head(iris)
View(iris)

ggplot(iris,aes(x=Sepal.Length, 
                y= Petal.Length,
                color=Species))+
  geom_point()+
  labs(x="xlab",
       y="ylab",
       title="title")+
  scale_x_continuous()+
  facet_grid(.~Species)
