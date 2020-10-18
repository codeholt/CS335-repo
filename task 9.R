library(readr)
library(haven)
library(readxl)
library(tidyverse)
library(downloader)
library(foreign)
library(ggplot2)
library(ggrepel)
library(scales)

covid <- read_csv("https://github.com/ktoutloud/classslides/raw/master/math335/data/covid19_p-scores.csv")

View(covid)
#cleaning the data
#make more rows with the date, nation, and pscore for the new columns

#rework spain
covid2 <- covid
covid2$Spain <- covid2$Spain *100

covidLong <- covid2 %>% 
  pivot_longer(c(Austria:`United States`),
                names_to = "Nation",
               values_to = "p_score")





str(covid)

covidLong %>% 
  filter(Nation %in% c("Spain","England & Wales","Germany","Norway")) %>% 
  ggplot(aes(x=date, y=p_score, group = Nation, color = Nation))+
    geom_line()+
    geom_point()+
    labs(x="Date", y="Percent Difference",
         title = "Difference in the number of deaths from all causes 
         in 2020 as compared to previous years")
ggsave("excess deaths 2020.png")
    


#highlight the points over 100% in 3 different ways

#1
#adds line at 100% to show that deaths are double previously
covidLong %>% 
  filter(Nation %in% c("Spain","England & Wales","Germany","Norway")) %>% 
  ggplot(aes(x=date, y=p_score, group = Nation, color = Nation))+
  geom_line()+
  geom_point()+
  geom_hline(yintercept = 100,color="red")+
  labs(x="Date", y="Percent Difference",
       title = "Difference in the number of deaths from all causes 
         in 2020 as compared to previous years")+
  scale_x_date(NULL, breaks = breaks_width(width = "1 month"))
?breaks_width

ggsave("death reference line.png")


#2

over100Text <- tibble(
  date=as.Date('2020-5-1', tryFormats = c("%Y-%m-%d", "%Y/%m/%d")),
  p_score = Inf,
  Nation = "",
  label = "The number of deaths is more than double previous years during March and April",
)

covidLong %>% 
  filter(Nation %in% c("Spain","England & Wales","Germany","Norway")) %>% 
  ggplot(aes(x=date, y=p_score, group = Nation, color = Nation))+
  geom_line()+
  geom_point()+
  geom_text(data = over100Text,mapping = aes(label = label), vjust = "top", hjust = "center", color = "black")+
  labs(x="Date", y="Percent Difference",
       title = "Difference in the number of deaths from all causes 
         in 2020 as compared to previous years")+
  scale_x_date(NULL, breaks = breaks_width(width = "1 month"))

ggsave("death Label.png")


#3

covidLong %>% 
  filter(Nation %in% c("Spain","England & Wales","Germany","Norway")) %>% 
  ggplot(aes(x=date, y=p_score, group = Nation, color = Nation))+
  geom_line(size = 1)+
  geom_point(aes(size = p_score), legend = FALSE)+
  labs(x="Date", y="Percent Difference",
       title = "Difference in the number of deaths from all causes 
         in 2020 as compared to previous years")+
  scale_x_date(NULL, breaks = breaks_width(width = "1 month"))+
  scale_y_continuous(breaks = seq(0,150, by=100))+
  guides(size = FALSE)

ggsave("death Line.png")

#with USA
covidUSA <- covidLong %>% 
  filter(Nation == "United States")

#1
covidLong %>% 
  filter(Nation %in% c("Spain","England & Wales","Germany","Norway")) %>% 
  ggplot(aes(x=date, y=p_score, group = Nation, shape = Nation))+
  geom_line(data = covidUSA,aes(x=date, y=p_score), color = "red")+
  geom_point(data = covidUSA,aes(x=date, y=p_score), color = "red")+
  geom_line()+
  geom_point()+
  labs(x="Date", y="Percent Difference",
       title = "Difference in the number of deaths from all causes 
         in 2020 as compared to previous years")+
  scale_x_date(NULL, breaks = breaks_width(width = "1 month"))+
  scale_y_continuous(breaks = seq(0,150, by=100))

ggsave("red highlight usa.png")

#2

covidLong %>% 
  filter(Nation %in% c("Spain","England & Wales","Germany","Norway")) %>% 
  ggplot(aes(x=date, y=p_score, group = Nation, color = Nation))+
  geom_line(data = covidUSA,aes(x=date, y=p_score), size = 1)+
  geom_point(data = covidUSA,aes(x=date, y=p_score), size = 2)+
  geom_line()+
  geom_point()+
  labs(x="Date", y="Percent Difference",
       title = "Difference in the number of deaths from all causes 
         in 2020 as compared to previous years")+
  scale_x_date(NULL, breaks = breaks_width(width = "1 month"))+
  scale_y_continuous(breaks = seq(0,150, by=100))

ggsave("size highlight USA.png")

