who = read.csv("WHO.csv")
str(who)
plot(who$GNI,who$FertilityRate)
library(ggplot2)
# We need at least three thing to create a plot using ggplot.
# 1.Data 2.aesthetic mapping of variable in data frame to visual output 3.geometric.
scatterplot = ggplot(who, aes(x = GNI,y = FertilityRate))
# We need to tell ggplot what geometic object to put in the plot.
scatterplot + geom_point()
# Try to made line graph.
scatterplot + geom_line()
# It not make sense and we back to geom_point()
# And change geom_point()
scatterplot + geom_point(color = "blue",size = 3,shape = 17)
# Try another.
scatterplot + geom_point(color = "darkred",size = 3 ,shape = 15)
# Now add title.
scatterplot + geom_point(color = "darkred",size = 3 ,shape = 8) + ggtitle("Fertility Rate VS Gross National Income")
# Now save to variable.
FertilityGNIplot = scatterplot + geom_point(color = "darkred",size = 3 ,shape = 8) + ggtitle("Fertility Rate VS Gross National Income")
# Save to pdf.
pdf("Myplot.pdf")
print(FertilityGNIplot)
dev.off()
# We want to add a color option to our aesthetic.
ggplot(who,aes(x = GNI ,y = FertilityRate, color = Region)) + geom_point()
# Try life expectancy.
ggplot(who,aes(x = GNI,y = FertilityRate,color = LifeExpectancy)) + geom_point()
# We interested in seeing whether the fertility rate of a country was a good predictor of the percentage of the population under 15.
ggplot(who,aes(x = FertilityRate,y = Under15)) + geom_point()
# Now suspect log transformation of fertility rate.
ggplot(who,aes(x = log(FertilityRate),y = Under15)) + geom_point()
# Building simple linear regression model.
model = lm(Under15~log(FertilityRate),data = who)
summary(model)
# Add linear regresstion to plot.
ggplot(who,aes(x=log(FertilityRate),y = Under15)) + geom_point() + stat_smooth(method = "lm",col = "red")
# Default ggplot will draw 95% confidence interval shaded around the line.
# We will add to 99% confidence.
ggplot(who,aes(x=log(FertilityRate),y = Under15)) + geom_point() + stat_smooth(method = "lm",level = 0.99,col = "red")
# Deleting level 0.99
ggplot(who,aes(x=log(FertilityRate),y = Under15)) + geom_point() + stat_smooth(method = "lm",se = FALSE,col = "red")
# To find which region are low fertility rate and low percentage under 15.
ggplot(who,aes(x = FertilityRate,y = Under15,color = Region))+ geom_point() + scale_color_brewer(palette = "Dark2")
