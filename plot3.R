# install.packages("ggplot2")
# install.packages("plyr")
library(plyr)
library(ggplot2)
# load data into R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# subset the data to contain  only baltimore informations
baltimore <- subset(NEI,NEI$fips == "24510")
# using plyr pocket to make possible conversion of data
pm25TypeBaltimore <- ddply(baltimore, .(year, type), summarise, totalEmissions = sum(Emissions))
# creating the plot
png("plot3.png", width = 800, height = 600)
q <- ggplot(data=pm25TypeBaltimore, aes(x=year, y=totalEmissions, fill=type)) + geom_bar(stat="identity", position=position_dodge())
q + ggtitle("The total emission of Baltimore City from 1999-2008 ")
#close the plot
dev.off()