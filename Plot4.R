#RUN Plot1.R before this script to load the data.

# Convert Date to Date class
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Create proper DateTime column
data$DateTime <- strptime(paste(data$Date, data$Time), format = "%Y-%m-%d %H:%M:%S")

#change global parameters
par(mfrow = c(2,2), mar = c(4, 4, 2, 1))

# Get axis points at day breaks
day_breaks <- as.POSIXct(c("2007-02-01 00:00", "2007-02-02 00:00", "2007-02-02 23:59"), format = "%Y-%m-%d %H:%M")

# Plot 1: Global Active Power
with(data, plot(DateTime, Global_active_power, 
                xlab = "", 
                ylab = "Global Active Power (kilowatts)",
                type = "l", 
                xaxt = "n"))
axis(1, at = day_breaks, labels = format(day_breaks, "%a"))

# Plot 2: Voltage
with(data, plot(DateTime, Voltage, 
                xlab = "datetime", 
                ylab = "Voltage",
                type = "l", 
                xaxt = "n"))
axis(1, at = day_breaks, labels = format(day_breaks, "%a"))

# Plot 3: Energy Sub Metering
with(data, plot(DateTime, Sub_metering_1, 
                xlab = "", 
                ylab = "Energy sub metering",
                type = "l", 
                xaxt = "n"))
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")

# Format x-axis labels to show weekday names
axis(1, at = day_breaks, labels = format(day_breaks, "%a"))

# Add a legend and adjust the size
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1, cex = 0.4)  # Adjust cex for smaller legend


# Plot 4: Global Reactive Power
with(data, plot(DateTime, Global_reactive_power, 
                xlab = "datetime", 
                ylab = "Global Reactive Power",
                type = "l", 
                xaxt = "n"))
axis(1, at = day_breaks, labels = format(day_breaks, "%a"))

# Copy the current screen plot to a PNG file
dev.copy(png, filename = "plot4.png", width = 480, height = 480)

# Close the device
dev.off()
