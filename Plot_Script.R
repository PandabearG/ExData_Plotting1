## Reading data for plotting
library(sqldf) # loading relevant package
df <- read.csv.sql("household_power_consumption.txt", header = T, sep = ";", 
                   sql = "select * from file where Date in 
                   ('1/2/2007', '2/2/2007')", eol = '\n'
                   ) # reading relevant data into data frame df

## Converting date time information
df$datetime <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")

## Plot 1
png(file = "plot1.png")
hist(df$Global_active_power, col = "red", breaks = 12, ylab = "Frequency",
     xlab= "Global Active Power (kilowatts)", main = "Global Active Power"
     )
dev.off()

## Plot 2
png(file = "plot2.png")
plot(df$datetime, df$Global_active_power, type = "l", 
     ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()

## Plot 3
png(file = "plot3.png")
plot(df$datetime, df$Sub_metering_1, ylab = "Energy Sub Metering", type = "l")
lines(df$datetime, df$Sub_metering_2, col = "red")
lines(df$datetime, df$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1,1), col = c("black", "red", "blue"))
dev.off()

## Plot 4
png(file = "plot4.png")
par(mfrow = c(2,2))
plot(df$datetime, df$Global_active_power, type = "l", xlab = "",
          ylab = "Global Active Power (kilowatts)")
plot(df$datetime, df$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
plot(df$datetime, df$Sub_metering_1, type = "l", xlab = "", ylab = "Energy Sub Metering")
lines(df$datetime, df$Sub_metering_2, col = "red")
lines(df$datetime, df$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1,1), col = c("black", "red", "blue"))
plot(df$datetime, df$Global_reactive_power, type = "l", xlab = "datetime", 
     ylab = "Global Reactive Power")