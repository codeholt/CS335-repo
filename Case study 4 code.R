library(readr)
library(haven)
library(readxl)
library(tidyverse)
library(downloader)
library(foreign)
library(ggplot2)

#data set 1
germanDat <- read_dta(url("https://byuistats.github.io/M335/data/heights/germanconscr.dta"))
#View(germanDat)

g19 <- germanDat %>% 
  mutate(birthYear = bdec,
         height.in = height * 0.3937008,
         height.cm = height,
         study = "g19") %>% 
  select(birthYear, height.in, height.cm, study)
#View(g19)

#data set 2
bavMaleConscripts <- read_dta(url("https://byuistats.github.io/M335/data/heights/germanprison.dta"))
#View(bavMaleConscripts)

b19 <- bavMaleConscripts %>% 
  mutate(birthYear = bdec,
         height.in = height * 0.3937008,
         height.cm = height,
         study = "b19") %>% 
  select(birthYear, height.in, height.cm, study)
#View(b19)

#data set 3
download("https://byuistats.github.io/M335/data/heights/Heights_south-east.zip",
         destfile= "Heights_south_east.zip")
unzip("Heights_south_east.zip")
southGerman <- read.dbf("B6090.DBF")

#View(southGerman)

g18 <- southGerman %>% 
  mutate(birthYear = GEBJ,
         height.in = CMETER * 0.3937008,
         height.cm = CMETER,
         study = "g18") %>% 
  select(birthYear, height.in, height.cm, study)
#View(g18)

#data set 4
laborStats <- read_csv(url("https://github.com/hadley/r4ds/raw/master/data/heights.csv"))

#View(laborStats)

us20 <- laborStats %>% 
  mutate(birthYear = 1950,
         height.in = height,
         height.cm = height/0.3937008,
         study = "us20") %>% 
  select(birthYear, height.in, height.cm, study)
#View(us20)

#data set 5
wisconsonDat <- read_sav(url("http://www.ssc.wisc.edu/nsfh/wave3/NSFH3%20Apr%202005%20release/main05022005.sav"))

#View(wisconsonDat)
??wisconsonDat
wisconsonDat %>% 
  select(RT216I)
#creates the columns to take
w20 <- wisconsonDat %>% 
  filter(RT216I > 0) %>% 
  mutate(birthYear = DOBY + 1900,
         height.in = RT216I + (12*RT216F),
         height.cm = (RT216I + (12*RT216F))/0.3937008,
         study = "w20") %>% 
  select(birthYear, height.in, height.cm, study)
#View(w20)


allData <- bind_rows(w20, us20, b19, g18, g19)
#View(allData)



#graph for showing the data
allData$birthYear <- as.character(allData$birthYear)
allData$birthYear <- as.Date(allData$birthYear, "%Y")


allData %>% 
  filter(height.in < 100) %>% 
  ggplot(aes(x=birthYear, y=height.in))+
  geom_dotplot()

plot(height.in ~ birthYear, data = allData)
str(allData)


is.atomic(allData$study)





