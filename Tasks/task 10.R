library(tidyverse)
library(ggplot2)
library(devtools)
library(ourworldindata)
library(dplyr)

devtools::install_github("drsimonj/ourworldindata")

?financing_healthcare

View(financing_healthcare)

str(financing_healthcare)

financing_healthcare %>% 
  ggplot(aes(x=health_exp_public_percent,
             y=as.double(child_mort), group= year,
             ))+
  geom_dotplot()
