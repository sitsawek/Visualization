library(ggplot2)
intl = read.csv("intl.csv")
str(intl)
ggplot(intl,aes(x = Region,y = PercentOfIntl)) + geom_bar(stat = "identity") + geom_text(aes(label = PercentOfIntl))
intl = transform(intl, Region = reorder(Region,-PercentOfIntl))
# Negative sign on PercentOfIntl mean decreasing order.
str(intl)
intl$PercentOfIntl = intl$PercentOfIntl * 100
ggplot(intl,aes(x = Region,y = PercentOfIntl)) + geom_bar(stat = "identity",fill = "dark blue") + geom_text(aes(label=PercentOfIntl),vjust = -0.4) + ylab("Percent of International Students") + theme(axis.title.x = element_blank(),axis.text.x=element_text(angle = 45,hjust = 1))
# vjust as text above the bar.
