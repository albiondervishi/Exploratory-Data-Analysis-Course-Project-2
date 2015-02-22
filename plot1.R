# load data into R
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")
data<- c(sum(NEI$Emissions[(NEI$year == "1999")]),sum(NEI$Emissions[(NEI$year == "2002")]),sum(NEI$Emissions[(NEI$year == "2005")]),sum(NEI$Emissions[(NEI$year =="2008")]))
#  extracting the year and converting year from date into factor
year <- unique(NEI$year)
year1 <- as.factor(year)
# frame the data
data1<- data.frame(data,year1 )
# creating the plot
png("plot1.png", width = 480, height = 480)
plot(data1$year1, data1$data, xlab="Year", ylab = "TotalEmissions", pch = 19, col = "black",)
title(main = "Total PM2.5 Emissions Per Year")
#close the plot
dev.off()
