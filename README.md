# Analysis of Physical Movement Using Activity Monitoring Devices

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
    - What is the average daily activity pattern?
      1. A time series plot of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all days (y-axis)
      2. Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps?
    - Imputing missing values [Note that there are a number of days/intervals where there are missing values NA. The presence of missing days may introduce bias into some calculations or summaries of the data.]
      1. What is the total number of missing values in the dataset?
      2. Devise a strategy for filling in all of the missing values in the dataset. 
      3. How would a new dataset that is equal to the original dataset but with the missing data filled in look like?
      4. A histogram of the total number of steps taken each day and what are the mean and median total number of steps taken per day. Do these values differ from the estimates from the first part of the project? What is the impact of imputing missing data on the estimates of the total daily number of steps?
    - Are there differences in activity patterns between weekdays and weekends?
       1. Let's create a new factor variable in the dataset with two levels – “weekday” and “weekend” indicating whether a given date is a weekday or weekend day.
       2. A panel plot containing a time series plot of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all weekday days or weekend days (y-axis). 
       
