# Exploratory Data Analysis — Course Project 1 (JHU Data Science Specialization)

This repository contains my solution for **Course Project 1** of the **Exploratory Data Analysis** course.

## Files

- `Exploratory_Data_Analysis.R`  
  Loads the household power consumption dataset (when downloaded locally), filters it to the required dates, and generates four plots.
- `plot1.png` — Histogram of Global Active Power  
- `plot2.png` — Global Active Power over time  
- `plot3.png` — Energy sub metering (three series)  
- `plot4.png` — 2×2 panel of plots  

## How to Run

1. Download the dataset zip from the course (“exdata_data_household_power_consumption.zip”).
2. Adjust the path in `Exploratory_Data_Analysis.R` if necessary.
3. Run the script in R.  
   The script:
   - Unzips the dataset (if needed)  
   - Loads and filters the data  
   - Displays each plot in the RStudio Plots window  
   - Saves `plot1.png` to `plot4.png` in the working directory  

## Notes

- The filtered dataset should contain **2880 rows** (the script asserts this).
- Missing values are handled using `na.strings = "?"`.
- All plots follow the **480×480 PNG** specification required by the course.
