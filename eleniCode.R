# Load required libraries
library(readxl)
library(tidyverse)

# CHANGE THESE FOR YOUR CODE. IMPORTANT.
# directory for the CSV files
working_dir <- "~/Desktop/alberto"
# name for the output file (will go in the working dir)
output <- "master_sheet.csv"

setwd(working_dir)

# Utility function to process an individual CSV file
process_file <- function(file_path) {
  # Load the CSV file into a data frame
  data <- read.csv(file_path)
  
  # Extract the single cyprid length value
  cyprid_length <- data$Cyprid.length..pixels.[1]
  
  # Process the data file.
  data <- data %>% 
    mutate(
      # Standardise X and Y columns to be numeric with 2 decimal places.
      X = round(as.numeric(X), 2),
      Y = round(as.numeric(Y), 2),
      # Calculate distance traveled and speed.
      Distance_Traveled = c(0, sqrt(diff(X)^2 + diff(Y)^2)),
      Distance_Standardized = Distance_Traveled / cyprid_length,
      Velocity_BL_sec = Distance_Standardized / (1/30)  
    ) %>% slice(-n())
  
  # Another data file with all rows with 0 velocity removed.
  data2 <- filter(data, Velocity_BL_sec > 0)
  
  # Find percentage of frames where no movement occurs, using the fact 0 = FALSE
  still_frame_percentage <- mean(!data$Velocity_BL_sec) * 100
  
  # Average speed, including still frames
  avg_speed <- mean(data$Velocity_BL_sec)
  # Average speed, not including still frames
  avg_speed_2 <- mean(data2$Velocity_BL_sec)
  
  # Return a list of necessary values
  return( list (
    percent_still = signif(still_frame_percentage, 6),
    avg_speed = signif(avg_speed, 6),
    avg_speed_no_0 = signif(avg_speed_2, 6)
  ))
}

file_names <- c(
  # Enter file names to process here.
  "Bath1_1_Aug15_24hr_EditedforR.csv",
  "Bath1_1_Aug15_48hr_EditedforR.csv",
  "Bath1_2_Aug15_24hr_EditedforR.csv",
  "Bath1_2_Aug15_48hr_EditedforR.csv",
  "Bath1_3_Aug15_24hr_EditedforR.csv",
  "Bath1_3_Aug15_48hr_EditedforR.csv",
  "Bath1_4_Aug15_24hr_EditedforR.csv",
  "Bath1_4_Aug15_48hr_EditedforR.csv",
  "Bath1_5_Aug15_24hr_EditedforR.csv",
  "Bath1_5_Aug15_48hr_EditedforR.csv",
  "Bath1_6_Aug15_24hr_EditedforR.csv",
  "Bath1_6_Aug15_48hr_EditedforR.csv",
  "Bath1_7_Aug15_24hr_EditedforR.csv",
  "Bath1_7_Aug15_48hr_EditedforR.csv",
  "Bath1_8_Aug15_24hr_EditedforR.csv",
  "Bath1_8_Aug15_48hr_EditedforR.csv",
  "Bath1_9_Aug15_24hr_EditedforR.csv",
  "Bath1_9_Aug15_48hr_EditedforR.csv",
  "Bath1_10_Aug15_24hr_EditedforR.csv",
  "Bath1_10_Aug15_48hr_EditedforR.csv",
  "Bath1_11_Aug15_24hr_EditedforR.csv",
  "Bath1_11_Aug15_48hr_EditedforR.csv",
  "Bath1_12_Aug15_24hr_EditedforR.csv",
  "Bath1_12_Aug15_48hr_EditedforR.csv",
  "Bath1_13_Aug15_24hr_EditedforR.csv",
  "Bath1_13_Aug15_48hr_EditedforR.csv",
  "Bath1_14_Aug15_24hr_EditedforR.csv",
  "Bath1_14_Aug15_48hr_EditedforR.csv",
  "Bath1_15_Aug15_24hr_EditedforR.csv",
  "Bath1_15_Aug15_48hr_EditedforR.csv",
  "Bath2_1_Aug15_24hr_EditedforR.csv",
  "Bath2_1_Aug15_48hr_EditedforR.csv",
  "Bath2_2_Aug15_24hr_EditedforR.csv",
  "Bath2_2_Aug15_48hr_EditedforR.csv",
  "Bath2_3_Aug15_24hr_EditedforR.csv",
  "Bath2_3_Aug15_48hr_EditedforR.csv",
  "Bath2_4_Aug15_24hr_EditedforR.csv",
  "Bath2_4_Aug15_48hr_EditedforR.csv",
  "Bath2_5_Aug15_24hr_EditedforR.csv",
  "Bath2_5_Aug15_48hr_EditedforR.csv",
  "Bath2_6_Aug15_24hr_EditedforR.csv",
  "Bath2_6_Aug15_48hr_EditedforR.csv",
  "Bath2_7_Aug15_24hr_EditedforR.csv",
  "Bath2_7_Aug15_48hr_EditedforR.csv",
  "Bath2_8_Aug15_24hr_EditedforR.csv",
  "Bath2_8_Aug15_48hr_EditedforR.csv",
  "Bath2_9_Aug15_24hr_EditedforR.csv",
  "Bath2_9_Aug15_48hr_EditedforR.csv",
  "Bath2_10_Aug15_24hr_EditedforR.csv",
  "Bath2_10_Aug15_48hr_EditedforR.csv",
  "Bath2_11_Aug15_24hr_EditedforR.csv",
  "Bath2_11_Aug15_48hr_EditedforR.csv",
  "Bath2_12_Aug15_24hr_EditedforR.csv",
  "Bath2_12_Aug15_48hr_EditedforR.csv",
  "Bath2_13_Aug15_24hr_EditedforR.csv",
  "Bath2_13_Aug15_48hr_EditedforR.csv",
  "Bath2_14_Aug15_24hr_EditedforR.csv",
  "Bath2_14_Aug15_48hr_EditedforR.csv",
  "Bath2_15_Aug15_24hr_EditedforR.csv",
  "Bath2_15_Aug15_48hr_EditedforR.csv",
  "Bath3_1_Aug15_24hr_EditedforR.csv",
  "Bath3_1_Aug15_48hr_EditedforR.csv",
  "Bath3_2_Aug15_24hr_EditedforR.csv",
  "Bath3_2_Aug15_48hr_EditedforR.csv",
  "Bath3_3_Aug15_24hr_EditedforR.csv",
  "Bath3_3_Aug15_48hr_EditedforR.csv",
  "Bath3_4_Aug15_24hr_EditedforR.csv",
  "Bath3_4_Aug15_48hr_EditedforR.csv",
  "Bath3_5_Aug15_24hr_EditedforR.csv",
  "Bath3_5_Aug15_48hr_EditedforR.csv",
  "Bath3_6_Aug15_24hr_EditedforR.csv",
  "Bath3_6_Aug15_48hr_EditedforR.csv",
  "Bath3_7_Aug15_24hr_EditedforR.csv",
  "Bath3_7_Aug15_48hr_EditedforR.csv",
  "Bath3_8_Aug15_24hr_EditedforR.csv",
  "Bath3_8_Aug15_48hr_EditedforR.csv",
  "Bath3_9_Aug15_24hr_EditedforR.csv",
  "Bath3_9_Aug15_48hr_EditedforR.csv",
  "Bath3_10_Aug15_24hr_EditedforR.csv",
  "Bath3_10_Aug15_48hr_EditedforR.csv",
  "Bath3_11_Aug15_24hr_EditedforR.csv",
  "Bath3_11_Aug15_48hr_EditedforR.csv",
  "Bath3_12_Aug15_24hr_EditedforR.csv",
  "Bath3_12_Aug15_48hr_EditedforR.csv",
  "Bath3_13_Aug15_24hr_EditedforR.csv",
  "Bath3_13_Aug15_48hr_EditedforR.csv",
  "Bath3_14_Aug15_24hr_EditedforR.csv",
  "Bath3_14_Aug15_48hr_EditedforR.csv",
  "Bath3_15_Aug15_24hr_EditedforR.csv",
  "Bath3_15_Aug15_48hr_EditedforR.csv",
  "Bath1_1_Sep15_24hr_EditedforR.csv",
  "Bath1_1_Sep15_48hr_EditedforR.csv",
  "Bath1_2_Sep15_24hr_EditedforR.csv",
  "Bath1_2_Sep15_48hr_EditedforR.csv",
  "Bath1_3_Sep15_24hr_EditedforR.csv",
  "Bath1_3_Sep15_48hr_EditedforR.csv",
  "Bath1_4_Sep15_24hr_EditedforR.csv",
  "Bath1_4_Sep15_48hr_EditedforR.csv",
  "Bath1_5_Sep15_24hr_EditedforR.csv",
  "Bath1_5_Sep15_48hr_EditedforR.csv",
  "Bath1_6_Sep15_24hr_EditedforR.csv",
  "Bath1_6_Sep15_48hr_EditedforR.csv",
  "Bath1_7_Sep15_24hr_EditedforR.csv",
  "Bath1_7_Sep15_48hr_EditedforR.csv",
  "Bath1_8_Sep15_24hr_EditedforR.csv",
  "Bath1_8_Sep15_48hr_EditedforR.csv",
  "Bath1_9_Sep15_24hr_EditedforR.csv",
  "Bath1_9_Sep15_48hr_EditedforR.csv",
  "Bath1_10_Sep15_24hr_EditedforR.csv",
  "Bath1_10_Sep15_48hr_EditedforR.csv",
  "Bath1_11_Sep15_24hr_EditedforR.csv",
  "Bath1_11_Sep15_48hr_EditedforR.csv",
  "Bath1_12_Sep15_24hr_EditedforR.csv",
  "Bath1_12_Sep15_48hr_EditedforR.csv",
  "Bath1_13_Sep15_24hr_EditedforR.csv",
  "Bath1_13_Sep15_48hr_EditedforR.csv",
  "Bath1_14_Sep15_24hr_EditedforR.csv",
  "Bath1_14_Sep15_48hr_EditedforR.csv",
  "Bath1_15_Sep15_24hr_EditedforR.csv",
  "Bath1_15_Sep15_48hr_EditedforR.csv",
  "Bath2_1_Sep15_24hr_EditedforR.csv",
  "Bath2_1_Sep15_48hr_EditedforR.csv",
  "Bath2_2_Sep15_24hr_EditedforR.csv",
  "Bath2_2_Sep15_48hr_EditedforR.csv",
  "Bath2_3_Sep15_24hr_EditedforR.csv",
  "Bath2_3_Sep15_48hr_EditedforR.csv",
  "Bath2_4_Sep15_24hr_EditedforR.csv",
  "Bath2_4_Sep15_48hr_EditedforR.csv",
  "Bath2_5_Sep15_24hr_EditedforR.csv",
  "Bath2_5_Sep15_48hr_EditedforR.csv",
  "Bath2_6_Sep15_24hr_EditedforR.csv",
  "Bath2_6_Sep15_48hr_EditedforR.csv",
  "Bath2_7_Sep15_24hr_EditedforR.csv",
  "Bath2_7_Sep15_48hr_EditedforR.csv",
  "Bath2_8_Sep15_24hr_EditedforR.csv",
  "Bath2_8_Sep15_48hr_EditedforR.csv",
  "Bath2_9_Sep15_24hr_EditedforR.csv",
  "Bath2_9_Sep15_48hr_EditedforR.csv",
  "Bath2_10_Sep15_24hr_EditedforR.csv",
  "Bath2_10_Sep15_48hr_EditedforR.csv",
  "Bath2_11_Sep15_24hr_EditedforR.csv",
  "Bath2_11_Sep15_48hr_EditedforR.csv",
  "Bath2_12_Sep15_24hr_EditedforR.csv",
  "Bath2_12_Sep15_48hr_EditedforR.csv",
  "Bath2_13_Sep15_24hr_EditedforR.csv",
  "Bath2_13_Sep15_48hr_EditedforR.csv",
  "Bath2_14_Sep15_24hr_EditedforR.csv",
  "Bath2_14_Sep15_48hr_EditedforR.csv",
  "Bath2_15_Sep15_24hr_EditedforR.csv",
  "Bath2_15_Sep15_48hr_EditedforR.csv",
  "Bath3_1_Sep15_24hr_EditedforR.csv",
  "Bath3_1_Sep15_48hr_EditedforR.csv",
  "Bath3_2_Sep15_24hr_EditedforR.csv",
  "Bath3_2_Sep15_48hr_EditedforR.csv",
  "Bath3_3_Sep15_24hr_EditedforR.csv",
  "Bath3_3_Sep15_48hr_EditedforR.csv",
  "Bath3_4_Sep15_24hr_EditedforR.csv",
  "Bath3_4_Sep15_48hr_EditedforR.csv",
  "Bath3_5_Sep15_24hr_EditedforR.csv",
  "Bath3_5_Sep15_48hr_EditedforR.csv",
  "Bath3_6_Sep15_24hr_EditedforR.csv",
  "Bath3_6_Sep15_48hr_EditedforR.csv",
  "Bath3_7_Sep15_24hr_EditedforR.csv",
  "Bath3_7_Sep15_48hr_EditedforR.csv",
  "Bath3_8_Sep15_24hr_EditedforR.csv",
  "Bath3_8_Sep15_48hr_EditedforR.csv",
  "Bath3_9_Sep15_24hr_EditedforR.csv",
  "Bath3_9_Sep15_48hr_EditedforR.csv",
  "Bath3_10_Sep15_24hr_EditedforR.csv",
  "Bath3_10_Sep15_48hr_EditedforR.csv",
  "Bath3_11_Sep15_24hr_EditedforR.csv",
  "Bath3_11_Sep15_48hr_EditedforR.csv",
  "Bath3_12_Sep15_24hr_EditedforR.csv",
  "Bath3_12_Sep15_48hr_EditedforR.csv",
  "Bath3_13_Sep15_24hr_EditedforR.csv",
  "Bath3_13_Sep15_48hr_EditedforR.csv",
  "Bath3_14_Sep15_24hr_EditedforR.csv",
  "Bath3_14_Sep15_48hr_EditedforR.csv",
  "Bath3_15_Sep15_24hr_EditedforR.csv",
  "Bath3_15_Sep15_48hr_EditedforR.csv",
  "Bath1_1_Sep18_24hr_EditedforR.csv",
  "Bath1_1_Sep18_48hr_EditedforR.csv",
  "Bath1_2_Sep18_24hr_EditedforR.csv",
  "Bath1_2_Sep18_48hr_EditedforR.csv",
  "Bath1_3_Sep18_24hr_EditedforR.csv",
  "Bath1_3_Sep18_48hr_EditedforR.csv",
  "Bath1_4_Sep18_24hr_EditedforR.csv",
  "Bath1_4_Sep18_48hr_EditedforR.csv",
  "Bath1_5_Sep18_24hr_EditedforR.csv",
  "Bath1_5_Sep18_48hr_EditedforR.csv",
  "Bath1_6_Sep18_24hr_EditedforR.csv",
  "Bath1_6_Sep18_48hr_EditedforR.csv",
  "Bath1_7_Sep18_24hr_EditedforR.csv",
  "Bath1_7_Sep18_48hr_EditedforR.csv",
  "Bath1_8_Sep18_24hr_EditedforR.csv",
  "Bath1_8_Sep18_48hr_EditedforR.csv",
  "Bath1_9_Sep18_24hr_EditedforR.csv",
  "Bath1_9_Sep18_48hr_EditedforR.csv",
  "Bath1_10_Sep18_24hr_EditedforR.csv",
  "Bath1_10_Sep18_48hr_EditedforR.csv",
  "Bath1_11_Sep18_24hr_EditedforR.csv",
  "Bath1_11_Sep18_48hr_EditedforR.csv",
  "Bath1_12_Sep18_24hr_EditedforR.csv",
  "Bath1_12_Sep18_48hr_EditedforR.csv",
  "Bath1_13_Sep18_24hr_EditedforR.csv",
  "Bath1_13_Sep18_48hr_EditedforR.csv",
  "Bath1_14_Sep18_24hr_EditedforR.csv",
  "Bath1_14_Sep18_48hr_EditedforR.csv",
  "Bath1_15_Sep18_24hr_EditedforR.csv",
  "Bath1_15_Sep18_48hr_EditedforR.csv",
  "Bath2_1_Sep18_24hr_EditedforR.csv",
  "Bath2_1_Sep18_48hr_EditedforR.csv",
  "Bath2_2_Sep18_24hr_EditedforR.csv",
  "Bath2_2_Sep18_48hr_EditedforR.csv",
  "Bath2_3_Sep18_24hr_EditedforR.csv",
  "Bath2_3_Sep18_48hr_EditedforR.csv",
  "Bath2_4_Sep18_24hr_EditedforR.csv",
  "Bath2_4_Sep18_48hr_EditedforR.csv",
  "Bath2_5_Sep18_24hr_EditedforR.csv",
  "Bath2_5_Sep18_48hr_EditedforR.csv",
  "Bath2_6_Sep18_24hr_EditedforR.csv",
  "Bath2_6_Sep18_48hr_EditedforR.csv",
  "Bath2_7_Sep18_24hr_EditedforR.csv",
  "Bath2_7_Sep18_48hr_EditedforR.csv",
  "Bath2_8_Sep18_24hr_EditedforR.csv",
  "Bath2_8_Sep18_48hr_EditedforR.csv",
  "Bath2_9_Sep18_24hr_EditedforR.csv",
  "Bath2_9_Sep18_48hr_EditedforR.csv",
  "Bath2_10_Sep18_24hr_EditedforR.csv",
  "Bath2_10_Sep18_48hr_EditedforR.csv",
  "Bath2_11_Sep18_24hr_EditedforR.csv",
  "Bath2_11_Sep18_48hr_EditedforR.csv",
  "Bath2_12_Sep18_24hr_EditedforR.csv",
  "Bath2_12_Sep18_48hr_EditedforR.csv",
  "Bath2_13_Sep18_24hr_EditedforR.csv",
  "Bath2_13_Sep18_48hr_EditedforR.csv",
  "Bath2_14_Sep18_24hr_EditedforR.csv",
  "Bath2_14_Sep18_48hr_EditedforR.csv",
  "Bath2_15_Sep18_24hr_EditedforR.csv",
  "Bath2_15_Sep18_48hr_EditedforR.csv",
  "Bath3_1_Sep18_24hr_EditedforR.csv",
  "Bath3_1_Sep18_48hr_EditedforR.csv",
  "Bath3_2_Sep18_24hr_EditedforR.csv",
  "Bath3_2_Sep18_48hr_EditedforR.csv",
  "Bath3_3_Sep18_24hr_EditedforR.csv",
  "Bath3_3_Sep18_48hr_EditedforR.csv",
  "Bath3_4_Sep18_24hr_EditedforR.csv",
  "Bath3_4_Sep18_48hr_EditedforR.csv",
  "Bath3_5_Sep18_24hr_EditedforR.csv",
  "Bath3_5_Sep18_48hr_EditedforR.csv",
  "Bath3_6_Sep18_24hr_EditedforR.csv",
  "Bath3_6_Sep18_48hr_EditedforR.csv",
  "Bath3_7_Sep18_24hr_EditedforR.csv",
  "Bath3_7_Sep18_48hr_EditedforR.csv",
  "Bath3_8_Sep18_24hr_EditedforR.csv",
  "Bath3_8_Sep18_48hr_EditedforR.csv",
  "Bath3_9_Sep18_24hr_EditedforR.csv",
  "Bath3_9_Sep18_48hr_EditedforR.csv",
  "Bath3_10_Sep18_24hr_EditedforR.csv",
  "Bath3_10_Sep18_48hr_EditedforR.csv",
  "Bath3_11_Sep18_24hr_EditedforR.csv",
  "Bath3_11_Sep18_48hr_EditedforR.csv",
  "Bath3_12_Sep18_24hr_EditedforR.csv",
  "Bath3_12_Sep18_48hr_EditedforR.csv",
  "Bath3_13_Sep18_24hr_EditedforR.csv",
  "Bath3_13_Sep18_48hr_EditedforR.csv",
  "Bath3_14_Sep18_24hr_EditedforR.csv",
  "Bath3_14_Sep18_48hr_EditedforR.csv",
  "Bath3_15_Sep18_24hr_EditedforR.csv",
  "Bath3_15_Sep18_48hr_EditedforR.csv",
  "Bath1_1_Sep22_24hr_EditedforR.csv",
  "Bath1_1_Sep22_48hr_EditedforR.csv",
  "Bath1_2_Sep22_24hr_EditedforR.csv",
  "Bath1_2_Sep22_48hr_EditedforR.csv",
  "Bath1_3_Sep22_24hr_EditedforR.csv",
  "Bath1_3_Sep22_48hr_EditedforR.csv",
  "Bath1_4_Sep22_24hr_EditedforR.csv",
  "Bath1_4_Sep22_48hr_EditedforR.csv",
  "Bath1_5_Sep22_24hr_EditedforR.csv",
  "Bath1_5_Sep22_48hr_EditedforR.csv",
  "Bath1_6_Sep22_24hr_EditedforR.csv",
  "Bath1_6_Sep22_48hr_EditedforR.csv",
  "Bath1_7_Sep22_24hr_EditedforR.csv",
  "Bath1_7_Sep22_48hr_EditedforR.csv",
  "Bath1_8_Sep22_24hr_EditedforR.csv",
  "Bath1_8_Sep22_48hr_EditedforR.csv",
  "Bath1_9_Sep22_24hr_EditedforR.csv",
  "Bath1_9_Sep22_48hr_EditedforR.csv",
  "Bath1_10_Sep22_24hr_EditedforR.csv",
  "Bath1_10_Sep22_48hr_EditedforR.csv",
  "Bath1_11_Sep22_24hr_EditedforR.csv",
  "Bath1_11_Sep22_48hr_EditedforR.csv",
  "Bath1_12_Sep22_24hr_EditedforR.csv",
  "Bath1_12_Sep22_48hr_EditedforR.csv",
  "Bath1_13_Sep22_24hr_EditedforR.csv",
  "Bath1_13_Sep22_48hr_EditedforR.csv",
  "Bath1_14_Sep22_24hr_EditedforR.csv",
  "Bath1_14_Sep22_48hr_EditedforR.csv",
  "Bath1_15_Sep22_24hr_EditedforR.csv",
  "Bath1_15_Sep22_48hr_EditedforR.csv",
  "Bath2_1_Sep22_24hr_EditedforR.csv",
  "Bath2_1_Sep22_48hr_EditedforR.csv",
  "Bath2_2_Sep22_24hr_EditedforR.csv",
  "Bath2_2_Sep22_48hr_EditedforR.csv",
  "Bath2_3_Sep22_24hr_EditedforR.csv",
  "Bath2_3_Sep22_48hr_EditedforR.csv",
  "Bath2_4_Sep22_24hr_EditedforR.csv",
  "Bath2_4_Sep22_48hr_EditedforR.csv",
  "Bath2_5_Sep22_24hr_EditedforR.csv",
  "Bath2_5_Sep22_48hr_EditedforR.csv",
  "Bath2_6_Sep22_24hr_EditedforR.csv",
  "Bath2_6_Sep22_48hr_EditedforR.csv",
  "Bath2_7_Sep22_24hr_EditedforR.csv",
  "Bath2_7_Sep22_48hr_EditedforR.csv",
  "Bath2_8_Sep22_24hr_EditedforR.csv",
  "Bath2_8_Sep22_48hr_EditedforR.csv",
  "Bath2_9_Sep22_24hr_EditedforR.csv",
  "Bath2_9_Sep22_48hr_EditedforR.csv",
  "Bath2_10_Sep22_24hr_EditedforR.csv",
  "Bath2_10_Sep22_48hr_EditedforR.csv",
  "Bath2_11_Sep22_24hr_EditedforR.csv",
  "Bath2_11_Sep22_48hr_EditedforR.csv",
  "Bath2_12_Sep22_24hr_EditedforR.csv",
  "Bath2_12_Sep22_48hr_EditedforR.csv",
  "Bath2_13_Sep22_24hr_EditedforR.csv",
  "Bath2_13_Sep22_48hr_EditedforR.csv",
  "Bath2_14_Sep22_24hr_EditedforR.csv",
  "Bath2_14_Sep22_48hr_EditedforR.csv",
  "Bath2_15_Sep22_24hr_EditedforR.csv",
  "Bath2_15_Sep22_48hr_EditedforR.csv",
  "Bath3_1_Sep22_24hr_EditedforR.csv",
  "Bath3_1_Sep22_48hr_EditedforR.csv",
  "Bath3_2_Sep22_24hr_EditedforR.csv",
  "Bath3_2_Sep22_48hr_EditedforR.csv",
  "Bath3_3_Sep22_24hr_EditedforR.csv",
  "Bath3_3_Sep22_48hr_EditedforR.csv",
  "Bath3_4_Sep22_24hr_EditedforR.csv",
  "Bath3_4_Sep22_48hr_EditedforR.csv",
  "Bath3_5_Sep22_24hr_EditedforR.csv",
  "Bath3_5_Sep22_48hr_EditedforR.csv",
  "Bath3_6_Sep22_24hr_EditedforR.csv",
  "Bath3_6_Sep22_48hr_EditedforR.csv",
  "Bath3_7_Sep22_24hr_EditedforR.csv",
  "Bath3_7_Sep22_48hr_EditedforR.csv",
  "Bath3_8_Sep22_24hr_EditedforR.csv",
  "Bath3_8_Sep22_48hr_EditedforR.csv",
  "Bath3_9_Sep22_24hr_EditedforR.csv",
  "Bath3_9_Sep22_48hr_EditedforR.csv",
  "Bath3_10_Sep22_24hr_EditedforR.csv",
  "Bath3_10_Sep22_48hr_EditedforR.csv",
  "Bath3_11_Sep22_24hr_EditedforR.csv",
  "Bath3_11_Sep22_48hr_EditedforR.csv",
  "Bath3_12_Sep22_24hr_EditedforR.csv",
  "Bath3_12_Sep22_48hr_EditedforR.csv",
  "Bath3_13_Sep22_24hr_EditedforR.csv",
  "Bath3_13_Sep22_48hr_EditedforR.csv",
  "Bath3_14_Sep22_24hr_EditedforR.csv",
  "Bath3_14_Sep22_48hr_EditedforR.csv",
  "Bath3_15_Sep22_24hr_EditedforR.csv",
  "Bath3_15_Sep22_48hr_EditedforR.csv",
  "Bath1_1_Sep26_24hr_EditedforR.csv",
  "Bath1_1_Sep26_48hr_EditedforR.csv",
  "Bath1_2_Sep26_24hr_EditedforR.csv",
  "Bath1_2_Sep26_48hr_EditedforR.csv",
  "Bath1_3_Sep26_24hr_EditedforR.csv",
  "Bath1_3_Sep26_48hr_EditedforR.csv",
  "Bath1_4_Sep26_24hr_EditedforR.csv",
  "Bath1_4_Sep26_48hr_EditedforR.csv",
  "Bath1_5_Sep26_24hr_EditedforR.csv",
  "Bath1_5_Sep26_48hr_EditedforR.csv",
  "Bath1_6_Sep26_24hr_EditedforR.csv",
  "Bath1_6_Sep26_48hr_EditedforR.csv",
  "Bath1_7_Sep26_24hr_EditedforR.csv",
  "Bath1_7_Sep26_48hr_EditedforR.csv",
  "Bath1_8_Sep26_24hr_EditedforR.csv",
  "Bath1_8_Sep26_48hr_EditedforR.csv",
  "Bath1_9_Sep26_24hr_EditedforR.csv",
  "Bath1_9_Sep26_48hr_EditedforR.csv",
  "Bath1_10_Sep26_24hr_EditedforR.csv",
  "Bath1_10_Sep26_48hr_EditedforR.csv",
  "Bath1_11_Sep26_24hr_EditedforR.csv",
  "Bath1_11_Sep26_48hr_EditedforR.csv",
  "Bath1_12_Sep26_24hr_EditedforR.csv",
  "Bath1_12_Sep26_48hr_EditedforR.csv",
  "Bath1_13_Sep26_24hr_EditedforR.csv",
  "Bath1_13_Sep26_48hr_EditedforR.csv",
  "Bath1_14_Sep26_24hr_EditedforR.csv",
  "Bath1_14_Sep26_48hr_EditedforR.csv",
  "Bath1_15_Sep26_24hr_EditedforR.csv",
  "Bath1_15_Sep26_48hr_EditedforR.csv",
  "Bath2_1_Sep26_24hr_EditedforR.csv",
  "Bath2_1_Sep26_48hr_EditedforR.csv",
  "Bath2_2_Sep26_24hr_EditedforR.csv",
  "Bath2_2_Sep26_48hr_EditedforR.csv",
  "Bath2_3_Sep26_24hr_EditedforR.csv",
  "Bath2_3_Sep26_48hr_EditedforR.csv",
  "Bath2_4_Sep26_24hr_EditedforR.csv",
  "Bath2_4_Sep26_48hr_EditedforR.csv",
  "Bath2_5_Sep26_24hr_EditedforR.csv",
  "Bath2_5_Sep26_48hr_EditedforR.csv",
  "Bath2_6_Sep26_24hr_EditedforR.csv",
  "Bath2_6_Sep26_48hr_EditedforR.csv",
  "Bath2_7_Sep26_24hr_EditedforR.csv",
  "Bath2_7_Sep26_48hr_EditedforR.csv",
  "Bath2_8_Sep26_24hr_EditedforR.csv",
  "Bath2_8_Sep26_48hr_EditedforR.csv",
  "Bath2_9_Sep26_24hr_EditedforR.csv",
  "Bath2_9_Sep26_48hr_EditedforR.csv",
  "Bath2_10_Sep26_24hr_EditedforR.csv",
  "Bath2_10_Sep26_48hr_EditedforR.csv",
  "Bath2_11_Sep26_24hr_EditedforR.csv",
  "Bath2_11_Sep26_48hr_EditedforR.csv",
  "Bath2_12_Sep26_24hr_EditedforR.csv",
  "Bath2_12_Sep26_48hr_EditedforR.csv",
  "Bath2_13_Sep26_24hr_EditedforR.csv",
  "Bath2_13_Sep26_48hr_EditedforR.csv",
  "Bath2_14_Sep26_24hr_EditedforR.csv",
  "Bath2_14_Sep26_48hr_EditedforR.csv",
  "Bath2_15_Sep26_24hr_EditedforR.csv",
  "Bath2_15_Sep26_48hr_EditedforR.csv",
  "Bath3_1_Sep26_24hr_EditedforR.csv",
  "Bath3_1_Sep26_48hr_EditedforR.csv",
  "Bath3_2_Sep26_24hr_EditedforR.csv",
  "Bath3_2_Sep26_48hr_EditedforR.csv",
  "Bath3_3_Sep26_24hr_EditedforR.csv",
  "Bath3_3_Sep26_48hr_EditedforR.csv",
  "Bath3_4_Sep26_24hr_EditedforR.csv",
  "Bath3_4_Sep26_48hr_EditedforR.csv",
  "Bath3_5_Sep26_24hr_EditedforR.csv",
  "Bath3_5_Sep26_48hr_EditedforR.csv",
  "Bath3_6_Sep26_24hr_EditedforR.csv",
  "Bath3_6_Sep26_48hr_EditedforR.csv",
  "Bath3_7_Sep26_24hr_EditedforR.csv",
  "Bath3_7_Sep26_48hr_EditedforR.csv",
  "Bath3_8_Sep26_24hr_EditedforR.csv",
  "Bath3_8_Sep26_48hr_EditedforR.csv",
  "Bath3_9_Sep26_24hr_EditedforR.csv",
  "Bath3_9_Sep26_48hr_EditedforR.csv",
  "Bath3_10_Sep26_24hr_EditedforR.csv",
  "Bath3_10_Sep26_48hr_EditedforR.csv",
  "Bath3_11_Sep26_24hr_EditedforR.csv",
  "Bath3_11_Sep26_48hr_EditedforR.csv",
  "Bath3_12_Sep26_24hr_EditedforR.csv",
  "Bath3_12_Sep26_48hr_EditedforR.csv",
  "Bath3_13_Sep26_24hr_EditedforR.csv",
  "Bath3_13_Sep26_48hr_EditedforR.csv",
  "Bath3_14_Sep26_24hr_EditedforR.csv",
  "Bath3_14_Sep26_48hr_EditedforR.csv",
  "Bath3_15_Sep26_24hr_EditedforR.csv",
  "Bath3_15_Sep26_48hr_EditedforR.csv",
  "Bath1_1_Oct10_24hr_EditedforR.csv",
  "Bath1_1_Oct10_48hr_EditedforR.csv",
  "Bath1_2_Oct10_24hr_EditedforR.csv",
  "Bath1_2_Oct10_48hr_EditedforR.csv",
  "Bath1_3_Oct10_24hr_EditedforR.csv",
  "Bath1_3_Oct10_48hr_EditedforR.csv",
  "Bath1_4_Oct10_24hr_EditedforR.csv",
  "Bath1_4_Oct10_48hr_EditedforR.csv",
  "Bath1_5_Oct10_24hr_EditedforR.csv",
  "Bath1_5_Oct10_48hr_EditedforR.csv",
  "Bath1_6_Oct10_24hr_EditedforR.csv",
  "Bath1_6_Oct10_48hr_EditedforR.csv",
  "Bath1_7_Oct10_24hr_EditedforR.csv",
  "Bath1_7_Oct10_48hr_EditedforR.csv",
  "Bath1_8_Oct10_24hr_EditedforR.csv",
  "Bath1_8_Oct10_48hr_EditedforR.csv",
  "Bath1_9_Oct10_24hr_EditedforR.csv",
  "Bath1_9_Oct10_48hr_EditedforR.csv",
  "Bath1_10_Oct10_24hr_EditedforR.csv",
  "Bath1_10_Oct10_48hr_EditedforR.csv",
  "Bath1_11_Oct10_24hr_EditedforR.csv",
  "Bath1_11_Oct10_48hr_EditedforR.csv",
  "Bath1_12_Oct10_24hr_EditedforR.csv",
  "Bath1_12_Oct10_48hr_EditedforR.csv",
  "Bath1_13_Oct10_24hr_EditedforR.csv",
  "Bath1_13_Oct10_48hr_EditedforR.csv",
  "Bath1_14_Oct10_24hr_EditedforR.csv",
  "Bath1_14_Oct10_48hr_EditedforR.csv",
  "Bath1_15_Oct10_24hr_EditedforR.csv",
  "Bath1_15_Oct10_48hr_EditedforR.csv",
  "Bath2_1_Oct10_24hr_EditedforR.csv",
  "Bath2_1_Oct10_48hr_EditedforR.csv",
  "Bath2_2_Oct10_24hr_EditedforR.csv",
  "Bath2_2_Oct10_48hr_EditedforR.csv",
  "Bath2_3_Oct10_24hr_EditedforR.csv",
  "Bath2_3_Oct10_48hr_EditedforR.csv",
  "Bath2_4_Oct10_24hr_EditedforR.csv",
  "Bath2_4_Oct10_48hr_EditedforR.csv",
  "Bath2_5_Oct10_24hr_EditedforR.csv",
  "Bath2_5_Oct10_48hr_EditedforR.csv",
  "Bath2_6_Oct10_24hr_EditedforR.csv",
  "Bath2_6_Oct10_48hr_EditedforR.csv",
  "Bath2_7_Oct10_24hr_EditedforR.csv",
  "Bath2_7_Oct10_48hr_EditedforR.csv",
  "Bath2_8_Oct10_24hr_EditedforR.csv",
  "Bath2_8_Oct10_48hr_EditedforR.csv",
  "Bath2_9_Oct10_24hr_EditedforR.csv",
  "Bath2_9_Oct10_48hr_EditedforR.csv",
  "Bath2_10_Oct10_24hr_EditedforR.csv",
  "Bath2_10_Oct10_48hr_EditedforR.csv",
  "Bath2_11_Oct10_24hr_EditedforR.csv",
  "Bath2_11_Oct10_48hr_EditedforR.csv",
  "Bath2_12_Oct10_24hr_EditedforR.csv",
  "Bath2_12_Oct10_48hr_EditedforR.csv",
  "Bath2_13_Oct10_24hr_EditedforR.csv",
  "Bath2_13_Oct10_48hr_EditedforR.csv",
  "Bath2_14_Oct10_24hr_EditedforR.csv",
  "Bath2_14_Oct10_48hr_EditedforR.csv",
  "Bath2_15_Oct10_24hr_EditedforR.csv",
  "Bath2_15_Oct10_48hr_EditedforR.csv",
  "Bath3_1_Oct10_24hr_EditedforR.csv",
  "Bath3_1_Oct10_48hr_EditedforR.csv",
  "Bath3_2_Oct10_24hr_EditedforR.csv",
  "Bath3_2_Oct10_48hr_EditedforR.csv",
  "Bath3_3_Oct10_24hr_EditedforR.csv",
  "Bath3_3_Oct10_48hr_EditedforR.csv",
  "Bath3_4_Oct10_24hr_EditedforR.csv",
  "Bath3_4_Oct10_48hr_EditedforR.csv",
  "Bath3_5_Oct10_24hr_EditedforR.csv",
  "Bath3_5_Oct10_48hr_EditedforR.csv",
  "Bath3_6_Oct10_24hr_EditedforR.csv",
  "Bath3_6_Oct10_48hr_EditedforR.csv",
  "Bath3_7_Oct10_24hr_EditedforR.csv",
  "Bath3_7_Oct10_48hr_EditedforR.csv",
  "Bath3_8_Oct10_24hr_EditedforR.csv",
  "Bath3_8_Oct10_48hr_EditedforR.csv",
  "Bath3_9_Oct10_24hr_EditedforR.csv",
  "Bath3_9_Oct10_48hr_EditedforR.csv",
  "Bath3_10_Oct10_24hr_EditedforR.csv",
  "Bath3_10_Oct10_48hr_EditedforR.csv",
  "Bath3_11_Oct10_24hr_EditedforR.csv",
  "Bath3_11_Oct10_48hr_EditedforR.csv",
  "Bath3_12_Oct10_24hr_EditedforR.csv",
  "Bath3_12_Oct10_48hr_EditedforR.csv",
  "Bath3_13_Oct10_24hr_EditedforR.csv",
  "Bath3_13_Oct10_48hr_EditedforR.csv",
  "Bath3_14_Oct10_24hr_EditedforR.csv",
  "Bath3_14_Oct10_48hr_EditedforR.csv",
  "Bath3_15_Oct10_24hr_EditedforR.csv",
  "Bath3_15_Oct10_48hr_EditedforR.csv"
)

# For matching bath to its temperature
temps <- list(
  "Aug15_1" = 37,
  "Aug15_2" = 34,
  "Aug15_3" = 29,
  "Sep15_1" = 38,
  "Sep15_2" = 40,
  "Sep15_3" = 20,
  "Sep18_1" = 28,
  "Sep18_2" = 36,
  "Sep18_3" = 30,
  "Sep22_1" = 24,
  "Sep22_2" = 50,
  "Sep22_3" = 16,
  "Sep26_1" = 34,
  "Sep26_2" = 42,
  "Sep26_3" = 22,
  "Oct10_1" = 18,
  "Oct10_2" = 27,
  "Oct10_3" = 32
)

# ASSUMING EVERY FILE IN FORMAT:
# Bath[bath]_[cyprid]_[date]_[time]_EditedforR.csv
masterdata <- data.frame(
  date = character(), 
  temp = numeric(), 
  cyprid = character(), 
  post = character(),
  hr24 = numeric(), 
  hr24_0 = numeric(), 
  hr24_still = numeric(),
  hr48 = numeric(), 
  hr48_0 = numeric(),
  hr48_still = numeric(),
  notes = character(),
  stringsAsFactors = FALSE,
  check.names = FALSE
)

# Processes the files, one by one, adds rows to the master table
for(file_name in file_names ) {
  stats <- process_file(file_name)
  
  vars <- unlist(strsplit(sub('....','',file_name), "_")[1])
  cyprid <- paste(vars[1], vars[2], sep="_")
  date <- vars[3]
  time <- vars[4]
  bath <- paste(date, vars[1], sep="_")
  
  temp <- temps[[bath]]
  
  if(time == "24hr") {
    masterdata <- masterdata %>% 
      add_row(date = date, temp = temp, cyprid = cyprid, 
              hr24 = stats$avg_speed, hr24_0 = stats$avg_speed_no_0, 
              hr24_still = stats$percent_still)
  } else {
    masterdata <- masterdata %>% 
      add_row(date = date, temp = temp, cyprid = cyprid, 
              hr48 = stats$avg_speed, hr48_0 = stats$avg_speed_no_0, 
              hr48_still = stats$percent_still)
  }
}

# Groups the columns of the master data
# by date and cyprid.
masterdata <- as.data.frame(masterdata %>%
                              group_by(date,temp,cyprid) %>%
                              summarise_all(list(~ .[!is.na(.)][1])))


# Delete  any line in this bit if unnecessary:
masterdata <- masterdata %>%
  # Changes column names for readability.
  rename("Experiment Date" = date, "Cyprid" = cyprid, "Temp" = temp,
         "Post exp - Protein Concentration" = post, 
         "24 hr Speed (BL/sec)" = hr24, 
         "24 hr Speed (BL/sec) [moving only]" = hr24_0,
         "Percentage of frames still (24hr)" = hr24_still,
         "48 hr Speed (BL/sec)" = hr48, 
         "48 hr Speed (BL/sec) [moving only]" = hr48_0,
         "Percentage of frames still (48hr)" = hr48_still,
         "Notes" = notes) %>%
  # Replaces all the data.frame NAs with blank spaces for readability. 
  mutate(across(everything(), ~ replace(.x, is.na(.x), "")))

write.csv(masterdata, paste(working_dir, output, sep="/"), row.names=FALSE)

