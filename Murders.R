murders = read.csv("murders.csv")
str(murders)
states_map = map_data("state")
str(states_map)
library(ggplot2)
# Plot map by use the polygons geometry of ggplot.
ggplot(states_map,aes(x = long,y = lat,group = group)) + geom_polygon(fill = "white",color="black")
# We need to make sure state names are the same in the murders data frame.
# In murder data frame start by capital letter and region lowercase.
# Create new variable call region in out murders data frame to match the state name variable in the states_map data frame.
murders$region = tolower(murders$State)
# We can join the states_map data frame with murders data frame by merge function.
# Which matches rows of data frame based on a shared identifier.
murders_map = merge(states_map,murders,by = "region")
str(murders_map)
# Now plot the number of murders on our map of the United States.
ggplot(murders_map,aes(x = long,y = lat,group = group,fill = Murders)) + geom_polygon(color = "black") + scale_fill_gradient(low = "black",high = "red",guide = "legend") 
# Create a map of the population to check.
ggplot(murders_map,aes(x = long,y = lat,group = group,fill = Population)) + geom_polygon(color = "black") + scale_fill_gradient(low = "black",high = "red",guide = "legend")
# We need to plot murders rate instead of number of murders to make sure not just plotting population map.
murders_map$MurdersRate = murders_map$Murders/murders_map$Population*100000
# We've create a new variable that the number of murders per 100,000 population.
ggplot(murders_map,aes(x = long,y = lat,group = group,fill = MurdersRate)) + geom_polygon(color = "black") + scale_fill_gradient(low = "black",high = "red",guide = "legend")
# There aren't really any red state why?
# It turn out Washinton DC is an outlier with very high murder rate.
# Such a small region on the map we can't see it.
# Now removing any observations with murders rates above 10 which we know will only exclude Washington DC.
ggplot(murders_map,aes(x = long,y = lat,group = group,fill = MurdersRate)) + geom_polygon(color = "black") + scale_fill_gradient(low = "black",high = "red",guide = "legend",limits = c(0,10))
# Test
ggplot(murders_map,aes(x = long,y = lat,group = group,fill = GunOwnership)) + geom_polygon(color = "black") + scale_fill_gradient(low = "black",high = "red",guide = "legend")
