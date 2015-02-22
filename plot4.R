# install.packages("ggplot2")
# install.packages("plyr")
library(plyr)
library(ggplot2)
# load data into R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# coal combustion-related sources in SCC data
CoalRelated <- grep("Coal", unique(SCC$EI.Sector), value = T)
split <- SCC$EI.Sector %in% CoalRelated
SCCCoal <- subset(SCC, split == T)$SCC

# subset of the data in NEI,  contain only coal combustion-related 
split <- NEI$SCC %in% SCCCoal
coal <- subset(NEI, split == T)

# using plyr pocket to make possible conversion of data
data1 <- ddply(coal, .(year), summarise, totalEmissions = sum(Emissions))

# creating plot
png("plot4.png", width = 480, height = 480)

ggplot(data=data1, aes(x=year, y=totalEmissions)) + geom_point(stat="identity", position=position_dodge()) + ggtitle("The emissions from coal combustion-related sources")
#close the plot
dev.off()