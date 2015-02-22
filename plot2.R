
# load data into R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# subset the data to contain  only baltimore informations
baltimore <- subset(NEI,NEI$fips == "24510")
# substraction of the data for each year in baltimore
data <- c(sum(baltimore$Emissions[(baltimore$year =="1999")]),sum(baltimore$Emissions[(baltimore$year =="2002")]),sum(baltimore$Emissions[(baltimore$year =="2005")]),sum(baltimore$Emissions[(baltimore$year =="2008")]))
#  extracting the year and converting year from Integer into Factor
year <- unique(NEI$year)
year1 <- as.factor(year)
# frame the data
data1<- data.frame(TotalEmissions = data, year1)

# creating the plot
png("plot2.png", width = 480, height = 480)

plot(data1$year1, data1$TotalEmissions, xlab="year", ylab = "Total PM2.5 Emissions", pch = 19, col = "black")
#close the plot
dev.off()
