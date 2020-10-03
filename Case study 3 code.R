library(ggplot2)
library(tidyverse)
library(dplyr)
library(nycflights13)
library(pander)

View(nycflights13::flights)

beforeNoonDepart <- nycflights13::flights %>% 
  filter(sched_dep_time < 1200)
#Question 1
#finding the distribution of the arr_delay for each airport and each airline
airportDistributions <- beforeNoonDepart %>% 
  group_by(origin) %>%
  summarise(min = min(arr_delay, na.rm = TRUE),
            Q1 = quantile(arr_delay, 0.25,na.rm = TRUE),
            Q2 = median(arr_delay,na.rm = TRUE),
            Q3 = quantile(arr_delay, 0.75,na.rm = TRUE),
            max = max(arr_delay,na.rm = TRUE))

airportDistributions
  
#calculation for those above 75th percent for low arrival times

#futureproof code maybe?
#edit: not working as expected, Omitted for now
"CarrierDistributions <- beforeNoonDepart %>% 
  group_by(origin, carrier) %>% 
  filter(arr_delay <= airportDistributions$Q1[airportDistributions$origin == origin]) 
  
View(CarrierDistributions)
"
#using hard coded option because It returns values properly
CarrierDistributions1 <- beforeNoonDepart %>% 
  group_by(origin, carrier) %>% 
  filter(arr_delay <= 
           if(origin == "EWR"){-18}
         else if(origin == "JFK"){-18}
         else if(origin == "LGA"){-19})

#using a graph to view my new dataset
ggplot(CarrierDistributions1, aes(x=arr_delay))+
  geom_histogram(aes(fill = carrier), position = "dodge")

#I realized I overcomplicated things, as usual. starting over

#I copy-pasted all of this code from earlier attempts

percentileByCarrier <- beforeNoonDepart %>% 
  group_by(origin, carrier) %>% 
  #used q1 because it would be the 75th percentile if we wanted small on the right side of the graph
  summarise(Q1 = quantile(arr_delay, 0.25,na.rm = TRUE))
View(percentileByCarrier)  

#removed the values above zero. They made the scaling really wierd
percentileByCarrier %>% 
  filter(Q1 <= 0) %>% 
  #inverted the Q1 value. easier to understand that larger bar is better
  #also makes label number of minutes early
  ggplot(mapping = aes(x=carrier,y=Q1*-1, fill = carrier))+
  geom_col(color = "black")+
  labs(y="Time save by being early (Minutes)",
       x="Airline",
       title = "Time saved by being early for flights in the \n75th percentile of each airport for being Early")+
  facet_grid(. ~ origin)
#View(CarrierDistributions1)
#?flights
#View(airlines)
#finally done with that. onto question 2

#Question 2
#Which airport has the lowest probability of a late arrival when im using delta?

#first things first, gotta figure out which code is delta's
View(nycflights13::airlines)
#Deltas is DL

#for the probability of a late arrival, I need to know how much of the arr_delay distribution is greater than 0

deltaFlights <- nycflights13::flights %>%
  filter(carrier == "DL")
View(deltaFlights)

#I just need to look at the data real quick to see what im working with
deltaFlights %>% 
  group_by(origin) %>% 
  ggplot(aes(x=arr_delay, fill = origin))+
  geom_histogram(color = "black")+
  facet_grid(. ~ origin)

#I could calculate the x number of observations above zero out of y total. there has to be a better way, but oh well

#incomplete, Ill get back to this later. plus meds are wearing off
?count

  sum(deltaFlights$arr_delay > 0)
numLate
totalObs <- deltaFlights %>% 
  group_by(origin) %>% 
  tally(arr_delay)

#screw what I was doing earlier. Im making a histogram and a distribution summary
flightSummary <- deltaFlights %>% 
  group_by(origin) %>% 
  summarise(min = min(arr_delay, na.rm = TRUE),
            Q1 = quantile(arr_delay, 0.25,na.rm = TRUE),
            Q2 = median(arr_delay,na.rm = TRUE),
            Q3 = quantile(arr_delay, 0.75,na.rm = TRUE),
            max = max(arr_delay,na.rm = TRUE),
            wMean = weighted.mean(arr_delay, na.rm = TRUE),
            mean = mean(arr_delay,na.rm = TRUE))
flightSummary
  
deltaFlights %>% 
  group_by(origin) %>% 
  ggplot(aes(x=arr_delay, fill = origin))+
  geom_density(alpha = .5)+
  scale_x_continuous(limits = c(-75, 200))+
  labs(x= "Minutes Late")
  

flightSummary %>% pander()
?alpha
