library(gapminder)
library(ggplot2)
library(tidyverse)


View(gapminder)
gapminder %>% 
  filter(country != "Kuwait") %>% 
  ggplot(aes(x=lifeExp,
             y=gdpPercap,
             size=pop/100000,
             color=continent))+
  geom_point()+
  #makes each year a seperate graph
  facet_grid(. ~ year)+
  scale_y_continuous(trans = "sqrt")+
  labs(y= "GDP per capita", x="Life Expectancy",
       size ="Population (100k)",
       title = "Life expectancy rise by a countries Rise in GDP")
ggsave("LifeExpectancy(case study2).png",width = 15,
       units = "in")
?ggsave
