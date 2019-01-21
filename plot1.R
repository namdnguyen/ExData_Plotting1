#! /usr/bin/env Rscript

## Exploratory Data Analysis Course Project 1: Creating Plot 1

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
  filter(Date == "2007-02-01" | Date == "2007-02-02")

## Create and save plot 1 as PNG file
png(filename = "plot1.png")
hist(df$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()
