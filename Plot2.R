#run plot1.R before running this script to load the data.

# Convert Date to Date class
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

#initial plot
with(data, plot(Date, Global_active_power))

# Create proper DateTime column
data$DateTime <- strptime(paste(data$Date, data$Time), format = "%Y-%m-%d %H:%M:%S")

# Plot the data
with(data, plot(DateTime, Global_active_power, 
                xlab = "", 
                ylab = "Global Active Power (kilowatts)",
                type = "l",
                xaxt = "n"))

# Get axis points at day breaks
day_breaks <- as.POSIXct(c("2007-02-01 00:00", "2007-02-02 00:00", "2007-02-02 23:59"), format = "%Y-%m-%d %H:%M")

# Format x-axis labels to show weekday names
axis(1, at = day_breaks, labels = format(day_breaks, "%a"))

# Copy the current screen plot to a PNG file
dev.copy(png, filename = "plot2.png", width = 480, height = 480)

# Close the device
dev.off()

