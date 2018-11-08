library(ggplot2)
intlall = read.csv("intlall.csv",stringsAsFactors = FALSE)
head(intlall)
# All NA should be 0's
intlall[is.na(intlall)] = 0
head(intlall)
# Load world map.
world_map = map_data("world")
str(world_map)
# Shove the world_map data frame and intlall data frame into one data frame.
world_map = merge(world_map,intlall,by.x = "region",by.y="Citizenship")
str(world_map)
ggplot(world_map,aes(x = long,y = lat,group = group)) + geom_polygon(fill = "white",color = "black") + coord_map("mercator") 
# We have to reorder the data in the correct order.
world_map = world_map[order(world_map$group,world_map$order),]
ggplot(world_map,aes(x = long,y = lat,group = group)) + geom_polygon(fill = "white",color = "black") + coord_map("mercator") 
# Some country are missing.
# See what it's called in the MIT data frame.
table(intlall$Citizenship)
intlall$Citizenship[intlall$Citizenship=="China (People's Republic Of)"] = "China"
table(intlall$Citizenship)
# Now we have to go through the merge again.
world_map = merge(map_data("world"),intlall,by.x= "region",by.y = "Citizenship")
# We need to reordering again.
world_map = world_map[order(world_map$group,world_map$order),]
ggplot(world_map,aes(x = long,y = lat,group = group )) + geom_polygon(aes(fill = Total),color = "black") + coord_map("mercator")
# Orthographic projection.
ggplot(world_map,aes(x = long,y = lat,group = group )) + geom_polygon(aes(fill = Total),color = "black") + coord_map("ortho",orientation = c(20,30,0))
# Try another thing.
ggplot(world_map,aes(x = long,y = lat,group = group )) + geom_polygon(aes(fill = Total),color = "black") + coord_map("ortho",orientation = c(-37,175,0))
