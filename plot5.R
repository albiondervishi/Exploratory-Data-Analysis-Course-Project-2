# install.packages("ggplot2")
# install.packages("plyr")
library(plyr)
library(ggplot2)
## read data
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")
# subset the data to contain  only baltimore informations
baltimore<- NEI[which(NEI$fips == "24510"),]
temp<-subset(SCC,SCC.Level.One=="Mobile Sources")
baltimoremobile <- baltimore[baltimore$SCC %in% temp$SCC,]
# using plyr pocket to make possible conversion of data
pm25motor<-ddply(baltimoremobile, .(year), summarise, totalEmissions = sum(Emissions))
# creating plot
png("plot5.png", width = 480, height = 480)

plot(pm25Motor$year,pm25Motor$totalEmissions, xlab="Year", ylab = "Total PM2.5 Emission", pch = 19, col = "black")
title(main= "Total PM2.5 Emissions From Motor Vehicle Related Sources In Baltimore")
#close the plot
dev.off()