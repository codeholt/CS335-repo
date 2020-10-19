library(readr)
library(haven)
library(readxl)
library(tidyverse)
library(downloader)

dowRDS <- read_rds(url("https://github.com/byuistats/data/blob/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.RDS?raw=true"))
dowCSV <- read_csv(url("https://github.com/byuistats/data/blob/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.csv?raw=true"))
dowDTA <- read_dta("https://github.com/byuistats/data/blob/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.dta?raw=true")
dowSAV <- read_sav(url("https://github.com/byuistats/data/blob/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.sav?raw=true"))

#creates directory for temporary r file
destDl <- tempfile(pattern = "", fileext = ".xlsx")

#downloads the file to the temporary directory
download("https://github.com/byuistats/data/blob/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.xlsx?raw=true",
                        destfile = destDl,
                        mode = "wb")

#reads file into r
dowXLSX <- read_xlsx(destDl)

all.equal(dowCSV, dowRDS)
all.equal(dowCSV, dowDTA)
all.equal(dowCSV, dowSAV)
all.equal(dowCSV, dowXLSX)

dowMean <- dowCSV %>% 
  group_by(variable) %>% 
  mean(value)

dowCSV %>% 
  ggplot(aes(y=value,x=variable, group = variable, fill = variable))+
  geom_boxplot()+
  geom_dotplot(binaxis = "y",position = "Jitter", dotsize = .25)+
  geom_dotplot(aes(y=mean(value)), binaxis = "y")

