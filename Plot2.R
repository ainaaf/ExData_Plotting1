setwd("~/Desktop/Aina/ExploratoryDataAnalysis/Week1" )

# Download file if it hasn't already been done
if(!"exdata_data_household_power_consumption.zip" %in% list.files()){
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                      "exdata_data_household_power_consumption.zip", method = "curl")
}

# Unzip file if it hasn't already been done and rename directory
if(!"dataset.txt" %in% list.files()){
        library(utils)
        unzip("exdata_data_household_power_consumption.zip")
        file.rename("household_power_consumption.txt","dataset.txt")
}

# Read the data into a dataframe
classes <- c("factor","factor", rep("numeric",7))
dataset <- read.table("dataset.txt", header = TRUE, sep = ";", nrows = 2075259, 
                      comment.char = "", colClasses = classes, na.strings = "?")
dataset$Date  <- as.Date(dataset$Date, "%d/%m/%Y")


#Subset the data to select only the dates 2007-02-01 and 2007-02-02
d1  <- as.Date("2007-02-01", "%Y-%m-%d")
d2  <- as.Date("2007-02-02", "%Y-%m-%d")
dataset <- dataset[dataset$Date == d1|dataset$Date == d2,]
dataset$Time <- strptime(paste(dataset$Date,dataset$Time), format = "%Y-%m-%d %T")

# Plot the second plot
png("Plot2.png")
plot(dataset$Time, dataset$Global_active_power, type = "n", 
     xlab = "", ylab = "Global Active Power (kilowatts)")
lines(dataset$Time, dataset$Global_active_power)
dev.off()
