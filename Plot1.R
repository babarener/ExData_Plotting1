# Download the zipfile into current directory
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile <- "household_power_consumption.zip"

if (!file.exists(zipfile)) {
  download.file(url, destfile = zipfile)
}

#unzip the file, household_power_consumption.txt will be in your current dir
unzip(zipfile)

#load the data
data <- read.table("household_power_consumption.txt", 
                   header = TRUE, 
                   sep = ";", 
                   na.strings = "?")

#Select data from the dates 2007-02-01 and 2007-02-02.
data <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")

#Plot the graph on screen
hist(data$Global_active_power, col = "red", main = "Global Active Power")

#Adjust parameter settings
par(mar = c(4,4,2,1))

# Plot a refined histogram and add custom y-axis interval
hist(data$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", breaks = 12, yaxt = "n")
axis(2, at = seq(0, 1200, by = 200))

# Copy the current screen plot to a PNG file
dev.copy(png, filename = "plot1.png", width = 480, height = 480)

# Close the device
dev.off()
