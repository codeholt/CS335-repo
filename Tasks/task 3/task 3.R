nycflights13::flights
??flights
install.packages(nycflights13)
View(nycflights13::flights)



DepartDist <- ggplot(data = nycflights13::flights,
       mapping =aes(x=dep_delay, fill = dep_delay<0))+
  geom_histogram(color = "black")+ 
  xlim(-100,300)+
  labs(x="Departure Delay", 
       y="Number of Flights",
       title="Distibution of Flights Departure Delay")
ggsave("depart dist.png", DepartDist)
#In this graphic, I chose to use a histogram to display the distribution of the delay times.
#I chose this over a smooth line because the axis label for the geom_density were all decimals and might confuse people at first glance. 
#The second thing I did was restrict the x axis to be below 300. there were several data points that were above 800, and they could barely be seen on the y scale, so i though it best to remove them to give the bulk of the graph more space. 
#last, I colored the data points below 0 to show that some flights departed or arrived early.

ArriveDist <- ggplot(data = nycflights13::flights,
       mapping =aes(x=arr_delay, fill = arr_delay<0))+
  geom_histogram(color = "black")+
  xlim(-100,300)+
  labs(x="Arrival Delay", 
       y="Number of Flights",
       title="Distibution of Flights Arrival Delay")
ggsave("arrival dist.png", ArriveDist)


#For this graph, i used a scatterplot to show the delay in departure of an aircraft related to how late it arrived.
#this time I did not feel the need to remove the points that had large delays in departure and arrival as they do not "squish" the rest of the graph
#The graphic shows a positive corelation between the delay in arrival and departure times.
DelayvArrival <- ggplot(data = nycflights13::flights,
       mapping =aes(y=arr_delay,x=dep_delay))+
  geom_point()+
  labs(x="Departure Delay", 
       y="Arrival Delay",
       title="The Increased Delay of Arriving Aircraft as the Departure is Delayed")

nycflights13::flights %>% 
  filter(!is.null(nycflights13::flights$arr_delay)) %>% 
  max(arr_delay)

