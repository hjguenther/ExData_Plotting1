
# Download data
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_p
              ower_consumption.zip", dest = "ElectricPowerConsumption.zip")

data <- read.table(unz("ElectricPowerConsumption.zip", 
                       "household_power_consumption.txt") , sep = ";", 
                   header = TRUE, na.strings = "?")

# Subset data for Dates 1/2/2007 and 2/2/2007
library(dplyr)
data <- tbl_df(data)
feb1.data <- filter(data, Date == "1/2/2007")
feb2.data <- filter(data, Date == "2/2/2007")
feb.data <- bind_rows(feb1.data, feb2.data)

# Change classes of data variables
library(lubridate)
feb.data$Date <- dmy(feb.data$Date)
feb.data$Time <- hms(feb.data$Time)

#turn data into data.frame for ease of plotting
feb.data <- as.data.frame(feb.data)



# hist of Global Active Power
png("plot1.png")
hist(feb.data[, 3], col = "red", main = "Global Active Power", xlab = "Global Active Power (Kilowatts)")
dev.off()