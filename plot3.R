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
feb.data$Date <- as.character(feb.data$Date)
feb.data$Time <- as.character(feb.data$Time)
feb.data$time <- sapply(feb.data$Date, paste, feb.data$Time)

#turn data into data.frame for ease of plotting
feb.data <- as.data.frame(feb.data)

#combine date and time
feb.data$time <- rep.int(NA, 2880)
for (i in 1:2880){
    feb.data[i,10] <- paste(feb.data[i,1], feb.data[i,2])
}

#turn into POSIXlt class
library(lubridate)
feb.data$time <- dmy_hms(feb.data$time)


#plot time by energy sub metering
png("plot3.png")
plot(feb.data$time, feb.data[, 7], ylab = "Energy Sub Metering", 
     xlab = "", col = "black", type = "l")
lines(feb.data$time, feb.data[, 8], col = "red")
lines(feb.data$time, feb.data[, 9], col = "blue")
legend("topright", c("sub_metering_1", "sub_metering_2", "sub_metering_3"),
       lty = c(1, 1, 1), col = c("black", "red", "blue"))
dev.off()