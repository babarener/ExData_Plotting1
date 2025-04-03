#RUN Plot1.R before this script to load the data.

# Convert Date to Date class
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Create proper DateTime column
data$DateTime <- strptime(paste(data$Date, data$Time), format = "%Y-%m-%d %H:%M:%S")

#plot the sub_metering_1 against DateTime first
with(data, plot(DateTime, Sub_metering_1, 
                xlab = "", 
                ylab = "Energy sub metering",
                type = "l",
                xaxt = "n"))

#Add Sub_metering_2 to the plot in red Sub_metering_3 in blue 
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")

# Get axis points at day breaks
day_breaks <- as.POSIXct(c("2007-02-01 00:00", "2007-02-02 00:00", "2007-02-02 23:59"), format = "%Y-%m-%d %H:%M")

# Format x-axis labels to show weekday names
axis(1, at = day_breaks, labels = format(day_breaks, "%a"))

# Add a legend to the top-right corner
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1)

# Copy the current screen plot to a PNG file
dev.copy(png, filename = "plot3.png", width = 480, height = 480)

# Close the device
dev.off()
