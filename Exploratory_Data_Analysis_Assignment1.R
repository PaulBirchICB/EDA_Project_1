## -------------------------------------------------------------
## Exploratory Data Analysis - Course Project 1
## Author: Paul Birch
## Description: Plots household power consumption from supplied dataset 
## -------------------------------------------------------------

## 1. Set working directory
setwd("C:/Users/paulbi/OneDrive - NHS/Documents/00_Central_Resources/Learning/JHU Data Science/datasciencecoursera/Exploratory_Data_Analysis")

## 2. Unzip dataset if not already extracted
zip_path <- "C:/Users/paulbi/Downloads/exdata_data_household_power_consumption.zip"
txt_file <- "household_power_consumption.txt"

if (!file.exists(txt_file)) {
  unzip(zip_path, exdir = getwd())
}

## Confirm file exists
if (!file.exists(txt_file)) {
  stop("ERROR: household_power_consumption.txt not found after unzip.")
}

## -------------------------------------------------------------
## 3. Load dataset
## -------------------------------------------------------------
data_all <- read.table(
  txt_file,
  header = TRUE,
  sep = ";",
  na.strings = "?",
  stringsAsFactors = FALSE
)

## Convert Date column
data_all$Date <- as.Date(data_all$Date, format = "%d/%m/%Y")

## -------------------------------------------------------------
## 4. Filter for required periods
## -------------------------------------------------------------
keep <- data_all$Date >= as.Date("2007-02-01") &
  data_all$Date <= as.Date("2007-02-02")

data <- data_all[keep, ]
rm(data_all)  # free memory

## Create combined DateTime column
data$DateTime <- as.POSIXct(
  paste(data$Date, data$Time),
  format = "%Y-%m-%d %H:%M:%S"
)

## Optional sanity check per Coursera dataset subset
stopifnot(nrow(data) == 2880)

## -------------------------------------------------------------
## 5. Plot 1 - Histogram of Global Active Power
## -------------------------------------------------------------
hist(
  data$Global_active_power,
  col = "red",
  main = "Global Active Power",
  xlab = "Global Active Power (kilowatts)"
)
dev.copy(png, "plot1.png", width = 480, height = 480)
dev.off()

## -------------------------------------------------------------
## 6. Plot 2 - Global Active Power over Time
## -------------------------------------------------------------
plot(
  data$DateTime,
  data$Global_active_power,
  type = "l",
  xlab = "",
  ylab = "Global Active Power (kilowatts)"
)
dev.copy(png, "plot2.png", width = 480, height = 480)
dev.off()

## -------------------------------------------------------------
## 7. Plot 3 - Energy Sub Metering
## -------------------------------------------------------------
plot(
  data$DateTime,
  data$Sub_metering_1,
  type = "l",
  xlab = "",
  ylab = "Energy sub metering"
)
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")
legend(
  "topright",
  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
  col = c("black", "red", "blue"),
  lty = 1,
  bty = "o"
)
dev.copy(png, "plot3.png", width = 480, height = 480)
dev.off()

## -------------------------------------------------------------
## 8. Plot 4 - 2x2 Panel
## -------------------------------------------------------------
op <- par(mfrow = c(2, 2))  # split plotting area into 2x2

# 1: Global Active Power
plot(
  data$DateTime,
  data$Global_active_power,
  type = "l",
  xlab = "",
  ylab = "Global Active Power"
)

# 2: Voltage
plot(
  data$DateTime,
  data$Voltage,
  type = "l",
  xlab = "datetime",
  ylab = "Voltage"
)

# 3: Energy sub metering
plot(
  data$DateTime,
  data$Sub_metering_1,
  type = "l",
  xlab = "",
  ylab = "Energy sub metering"
)
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")
legend(
  "topright",
  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
  col = c("black", "red", "blue"),
  lty = 1,
  bty = "n"
)

# 4: Global Reactive Power
plot(
  data$DateTime,
  data$Global_reactive_power,
  type = "l",
  xlab = "datetime",
  ylab = "Global Reactive Power"
)

par(op)  # restore layout
dev.copy(png, "plot4.png", width = 480, height = 480)
dev.off()
