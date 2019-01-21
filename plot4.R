#! /usr/bin/env Rscript

## Exploratory Data Analysis Course Project 1: Creating Plot 3

## Load libraries
library(readr)
library(dplyr)

## Set working directory and file names
setwd("./")
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file <- file.path("data", "household_power_consumption.zip")

## Create data directory
if(!file.exists("data")) {
  dir.create("data")
}

## Retrieve data file
if(!file.exists(file)) {
  download.file(fileUrl, destfile = file, method = "curl")
  dateDownloaded <- date()
  dateDownloaded
}

## Load data
dat <- read_delim(file, delim = ";", na = "?",
                  col_types = cols(Date = col_date(format = "%d/%m/%Y")))

## Filter for analysis dates
df <- dat %>%
  filter(Date == "2007-02-01" | Date == "2007-02-02") %>%
  mutate(datetime = as.POSIXct(paste(Date, Time), format = "%Y-%m-%d %H:%M:%S"))

## Create and save plot 1 as PNG file
png(filename = "plot4.png")

par(mfrow = c(2, 2))

with(df, {
  # Plot Global Active Power time series chart
  plot(datetime, Global_active_power, type = "l",
       xlab = "",
       ylab = "Global Active Power (kilowatts)")

  # Plot Voltage time series chart
  plot(datetime, Voltage , type = "l")

  # Plot Energy sub metering time series chart
  plot(datetime, Sub_metering_1, type = "l",
       xlab = "",
       ylab = "Energy sub metering")
  lines(datetime, Sub_metering_2, col = "red", type = "l")
  lines(datetime, Sub_metering_3, col = "blue", type = "l")
  legend("topright", lty = c(1, 1, 1),
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         col = c("black", "red", "blue"))

  # Plot Global Reactive Power time series chart
  plot(datetime, Global_reactive_power, type = "l")
})

dev.off()
