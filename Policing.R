# Load data and make sure string as factor.
mvt = read.csv("mvt.csv",stringsAsFactors = FALSE)
str(mvt)
# We want to convert the date variable to a format.
mvt$Date = strptime(mvt$Date,format = "%m/%d/%y %H:%M")
mvt$Weekday = weekdays(mvt$Date)
mvt$Hour = mvt$Date$hour
str(mvt)
# We want to plot as the value the total number of crimes on each day of the week.
# Create table to get information.
table(mvt$Weekday)
# Save to data frame.
weekday_counts = as.data.frame(table(mvt$Weekday))
str(weekday_counts)
# Now make a plot.
library(ggplot2)
ggplot(weekday_counts,aes(x = Var1,y = Freq)) + geom_line(aes(group = 1))
# This group data to one line.
# Now put day of week to alphabetical order.
weekday_counts$Var1 = factor(weekday_counts$Var1, ordered = TRUE ,levels = c("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"))
ggplot(weekday_counts,aes(x = Var1,y = Freq)) + geom_line(aes(group = 1)) + xlab("Day of the Week") + ylab("Total Motor Vehicle Theft") + ggtitle("Yes")
# Test 
ggplot(weekday_counts,aes(x = Var1,y = Freq)) + geom_line(aes(group = 1),linetype = 2)
ggplot(weekday_counts,aes(x = Var1,y = Freq)) + geom_line(aes(group = 1),alpha = 0.3)
# Make heat map by first create table.
# Save to data frame.
dh_counts = as.data.frame(table(mvt$Weekday,mvt$Hour))
str(dh_counts)
# Convert Var2 to actual numbers and call it hour.
dh_counts$Hour = as.numeric(as.character(dh_counts$Var2))
ggplot(dh_counts,aes(x = Hour,y = Freq)) + geom_line(aes(group = Var1))
# Change colors of the lines to correspond to the day of the week. 
ggplot(dh_counts,aes(x = Hour,y = Freq)) + geom_line(aes(group = Var1,color = Var1))
# Quite hard to interpret and now make heat map.
# We need to fix the order of the day instead of in alphabetical order.
dh_counts$Var1 = factor(dh_counts$Var1,ordered = TRUE,levels = c("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"))
ggplot(dh_counts,aes(x = Hour,y = Var1)) + geom_tile(aes(fill = Freq))
# Build more nicer
ggplot(dh_counts,aes(x = Hour,y = Var1)) + geom_tile(aes(fill = Freq)) + scale_fill_gradient(name = "Total MV Theft") + theme(axis.title.y = element_blank())
# Change color scheme.
ggplot(dh_counts,aes(x = Hour,y = Var1)) + geom_tile(aes(fill = Freq)) + scale_fill_gradient(name = "Total MV Theft",low = "white",high = "red") + theme(axis.title.y = element_blank())
# Test change axis
ggplot(dh_counts,aes(x = Var1,y = Hour)) + geom_tile(aes(fill = Freq)) + scale_fill_gradient(name = "Total MV Theft",low = "white",high = "red") + theme(axis.title.y = element_blank())
# Test change color
ggplot(dh_counts,aes(x = Hour,y = Var1)) + geom_tile(aes(fill = Freq)) + scale_fill_gradient(name = "Total MV Theft",low = "white",high = "black") + theme(axis.title.y = element_blank())
# Plot crime on a map of Chicago.
library(maps)
library(ggmap)
chicago = get_map(location = "chicago",zoom = 11)
# Load map in Chicago into R
library(devtools)
# install_github("dkahle/ggmap", ref = "tidyup", force = TRUE)
if(!requireNamespace("devtools")) install.packages("devtools") devtools::install_github("dkahle/ggmap", ref = "tidyup", force = TRUE)
register_google(key = "AIzaSyBEG7AiZuawuNvPBhLEEk8xNSq2j6CUSsQ")
get_map(location= c(lon = -87.6298, lat = 41.8781), zoom=11)
chicago = get_map(location = "chicago", zoom = 11)
str(mvt)
get_map(location= c(lon = -87.6298, lat = 41.8781), zoom=11)
chicago = get_map(location = "chicago", zoom = 11)
ggmap(chicago) + geom_point(data = mvt[1:100,],aes(x = Longitude,y = Latitude))
latlon_counts = as.data.frame(table(round(mvt$Longitude,2),round(mvt$Latitude,2)))
# This give us a total crimes at every point on a grid.
str(latlon_counts)
latlon_counts$Long = as.numeric(as.character(latlon_counts$Var1))
latlon_counts$Lat = as.numeric(as.character(latlon_counts$Var2)) 
ggmap(chicago) + geom_point(data = latlon_counts,aes(x = Long,y = Lat,color = Freq,size = Freq))
# Change scheme by add.
gmap(chicago) + geom_point(data = latlon_counts,aes(x = Long,y = Lat,color = Freq,size = Freq)) + scale_color_gradient(low = "yellow",high = "red")
ggmap(chicago) + geom_title(data = latlon_counts,aes(x = Long,y = Lat,alpha = Freq),fill = "red")
# Delete which observation equal 0.
str(latlon_counts)
latlon_counts2 = subset(latlon_counts,Freq != 0)
str(latlon_counts2)
1638-686
