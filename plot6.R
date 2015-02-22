# install.packages("ggplot2")
# install.packages("plyr")
library(plyr)
library(ggplot2)
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")
# subset the data to contain  only LA informations
losangelesdata <- subset(NEI, NEI$fips == "06037")
temp<-subset(SCC,SCC.Level.One=="Mobile Sources")
losangelesmobile <- losangelesdata[losangelesdata$SCC %in% temp$SCC,]
# using plyr pocket to make possible conversion of data
pm24motor<-ddply(losangelesmobile, .(year), summarise, totalEmissions = sum(Emissions))
# subset the data to contain  only baltimore informations
baltimore<- subset(NEI, NEI$fips == "24510")
temp<-subset(SCC,SCC.Level.One=="Mobile Sources")
baltimoremobile <- baltimore[baltimore$SCC %in% temp$SCC,]
# using plyr pocket to make possible conversion of data
pm25motor<-ddply(baltimoremobile, .(year), summarise, totalEmissions = sum(Emissions))
# add the city factor to the file 
pm24motor$location <- "Los Angeles County"
pm25motor$location <- "Baltimore"
#bind the data in one file
data7 <- rbind(pm24motor, pm25motor)
# creating plot
png("plot6.png", width = 640, height = 640)
ggplot(data=data7, aes(x=year, y=totalEmissions, fill = location)) + geom_bar(stat="identity", position=position_dodge()) + ggtitle("MotorVehicle Emissions between Baltimore and Los Angeles")
#close the plot
dev.off()