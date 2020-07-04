# Analysis of Personal Movement Using Activity Monitoring Devices

## Data

**Dataset:** The dataset used in the project is named [Activity monitoring data](https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip) which is about 52K.

**Variables:** The variables included in this dataset are:
  - *steps:* Number of steps taking in a 5-minute interval (missing values are coded as NA)
  - *date:* The date on which the measurement was taken in YYYY-MM-DD format
  - *interval:* Identifier for the 5-minute interval in which measurement was taken

**File type:** The dataset is stored in a comma-separated-value (CSV) file and there are a total of 17,568 observations in this dataset.

## Files
There are 5 types of files in the repository:
 - physical_activity.R is the full version of the code used for this analysis
 - codebook.md epitomizes the whole code in simple text
 - readme.md explains the repository
 - figure directory containes all the figure produced in the analysis
 - codebook.html comprises the html version of the explanation
 
## Code 
Summary of the analysis is given below:

 - **Lead with the question:** We are going to answer the below questions using the dataset.
   - What is mean total number of steps taken per day?
     (For this part of the project, we ignored the missing values in the dataset.)
      1. What is the total number of steps taken per day?
      2. A histogram of the total number of steps taken each day
      3. What are the mean and median of the total number of steps taken per day?
