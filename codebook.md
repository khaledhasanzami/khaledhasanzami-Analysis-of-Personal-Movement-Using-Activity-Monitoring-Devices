---
title: Analysis of Physical Movement Using Activity Monitoring Devices
author: "Md Khaled Hasan Zami"
date: "July 1, 2020"
email: "khaled.kuece15@gmail.com"
output: 
  html_document: 
    keep_md: true 
---

# Introduction
It is now possible to collect a large amount of data about personal movement using activity monitoring devices such as a [Fitbit](http://www.fitbit.com/), [Nike Fuelband](http://www.nike.com/us/en_us/c/nikeplus-fuelband), or [Jawbone Up](https://jawbone.com/up). These type of devices are part of the "quantified self" movement -- a group of enthusiasts who take measurements about themselves regularly to improve their health, to find patterns in their behavior, or because they are tech geeks. But these data remain under-utilized both because the raw data are hard to obtain and there is a lack of statistical methods and software for processing and interpreting the data.

This project makes use of data from a personal activity monitoring device. This device collects data at 5 minute intervals through out the day. The data consists of two months of data from an anonymous individual collected during the months of October and November, 2012 and include the number of steps taken in 5 minute intervals each day.

# A. Loading and preprocessing the data
For this part of the project, we will perform two types of works. 
 
 1. We will load the data from the dataset [Activity monitoring data](https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip)
 
 2. We will perform some pre-processing of the dataset for the suitability of our analysis.
 

## 1. Loading the data

Let's create a directory to store the dataset. We named it as **data**. We will be downloading and saving all the files in it. If there is an existing directory named **data**, a new directory will not be created. Hence, the existing **data** directory will be in use for the same purposes.


```r
if (!file.exists("data")) {
        dir.create("data")
}
```

As a new directory has been created for our work now it is time to download the dataset.

Let's assign the dataset url to a variable. Then, download the file from the url and save it to our directory named **data**. We can give it a name Activity_monitoring_data.zip or anything else. For this project we named it as Activity_monitoring_data.zip as the link comprises a .zip file.

> method = "curl" $\rightarrow$ for mac users

> method = "wininet" $\rightarrow$ for windows users


```r
dataset_url <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip" 
download.file(dataset_url, destfile="./data/Activity_monitoring_data.zip", method = "wininet")
```

We can unzip the downloaded zip file with `unzip()` function.

```r
unzip("./data/Activity_monitoring_data.zip")
```

Let's see what file was in the zipped file. We will find a **.csv** file.

```r
list.files("./data",  all.files=T)
```

```
## [1] "."                            ".."                          
## [3] "Activity_monitoring_data.zip"
```

We have our **.csv** file. We need to read the file using `read.csv()`.

```r
activity <- read.csv("activity.csv", header = TRUE, sep = ",", na.strings = "NA")
```

**The dataset is loaded successfully**

## 2. Preprocessing the data

We have read our dataset. Now, it is time to look inside. Let's `str()` the loaded dataset.

```r
str(activity)
```

```
## 'data.frame':	17568 obs. of  3 variables:
##  $ steps   : int  NA NA NA NA NA NA NA NA NA NA ...
##  $ date    : Factor w/ 61 levels "2012-10-01","2012-10-02",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ interval: int  0 5 10 15 20 25 30 35 40 45 ...
```
As we can see that we have 3 types of varibales. But the date column is in **factor** class which was supposed to be in **Date** class. So, let's convert it into **date** class. We can do it using the `as.Date()`. The date measurement was taken in YYYY-MM-DD format. So, we declared the format argument as `%Y-%m-%d` to read as follows. Note that, **%Y** reads 4 letters of the year whereas **%y** reads only last 2 letters of the years.

```r
activity$date <- as.Date(activity$date, format = "%Y-%m-%d")
```
Now we have converted the date column in **Date** class which was previously in **factor** class. 

# B. What is the mean total number of steps taken per day?

For this part of the project, we will be performing three things:
 
 1. We will be calculating the total number of steps taken per day
 
 2. We will be making a histogram of the total number of steps taken per day.
 
 3. We will be calculating the **mean** and **meadian** of the total number of steps taken.

## 1. The total number of steps taken per day

Now, let's create a new data frame named **steps_per_day** and save the total number of steps taken each day. We have done it using the `aggregate()` function. We have defined the operation to `sum`. What this `aggregate()` function does is it sum up the steps column where date are same. This is why we get the total number of step taken each day.

```r
steps_per_day <- aggregate(steps ~ date, activity, sum)
head(steps_per_day)
```

```
##         date steps
## 1 2012-10-02   126
## 2 2012-10-03 11352
## 3 2012-10-04 12116
## 4 2012-10-05 13294
## 5 2012-10-06 15420
## 6 2012-10-07 11015
```

## 2. Histogram of the total number of steps taken each day

As the data has been saved to a new dataframe, let's make the histogram of the total number of steps taken per day. We used the `hist()` function for this purpose. `main` argument was used to set the histograms title, `xlab` for naming the x-axis, `col` was directed as red for the histogram to be red and `breaks` was used to devide the histogram in 20 bars.

```r
hist(steps_per_day$steps, main = paste("The total number of steps taken per day"),  breaks = 20, col="red", xlab="Number of Steps")
```

![](codebook_files/figure-html/unnamed-chunk-9-1.png)<!-- -->
 
## 3. Mean and meadian of the total number of steps taken

R has a generic function called `mean()` to calculate the mean.

```r
rmean <- mean(steps_per_day$steps)
rmean
```

```
## [1] 10766.19
```
**So, the mean of the total number of steps taken is 10766.19**

Additionally, R has a generic function called `median()` to calculate the median.

```r
rmedian <- median(steps_per_day$steps)
rmedian
```

```
## [1] 10765
```
**So, the median of the total number of steps taken is 10765**

# C. What is the average daily activity pattern?

For this part of the project, we will be performing two things:

 1. We will be making a time series plot of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all days (y-axis)
 2. We will be finding on Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps

## 1. Making a time series plot

First of all, we created a data frame named **steps_by_interval** by averaging the steps taken on each time interval.
Then, we ploted having the the intervals in x-axis and average number of steps in y-axis. The plot was titles using the `main` argument and colored using the `col` argument.

```r
steps_by_interval<- aggregate(steps ~ interval, activity, mean)
plot(steps_by_interval$interval, steps_by_interval$steps, 
      type = "l", 
      main = 'Average number of steps taken in 5-minute interval, averaged across all days',
      xlab='Intervals',
      ylab='Average number of steps',
      col = "#00AFBB")
```

![](codebook_files/figure-html/unnamed-chunk-12-1.png)<!-- -->

## 2. 5-minute interval that contains the maximum number of steps

We calculated the maximum number of steps taken in the interval using the `which.max` function then printed out the on which interval it was maximum.


```r
intervale_max_steps<-steps_by_interval[which.max(steps_by_interval$steps),]$interval
intervale_max_steps
```

```
## [1] 835
```

# D. Imputing missing values

There are a number of days/intervals where there are missing values (coded as NA). The presence of missing days may introduce bias into some calculations or summaries of the data.

For this part of the project, we will be performing four things:

 1. We will be calculating and reporting the total number of missing values in the dataset 
 2. We will be using Mean values for fullfiling missing values
 3. We will be creating a new dataset including the imputed missing values
 4. We will be making a histogram of the total number of steps taken each day and calculating and reporting the mean and median total number of steps taken per day

## 1. Calculation of the total number of missing values in the dataset

There is a function `complete.cases()` in R which calculates the complete cases that means they finds out the obeservations or rows that does not a have a NA value in them. If we negate the result we will find the number of missing values or the number of observation having NA values. By summing up we will find out the total number of missing values in the dataset.

```r
 totalNA<- sum(!complete.cases(activity))
 totalNA
```

```
## [1] 2304
```
**Total Number of Missing values are 2304**

## 2. Fullfiling missing values

We fullfilled the missing values according to the mean value of 5 minute interval. For this, we calculated the mean value for 5 minute interval using `aggregate()` function and setting the `FUN` argument as `mean`. This calculates the mean for each 5 minute interval. Then, we ran a loop through all the observations to find the missing places. If there was a missing place then we put there the mean value and if not then it was filled with the corresponding value. We stored all the new values of the steps in fillNA.


```r
StepsAverage <- aggregate(steps ~ interval, data = activity, FUN = mean)
fillNA <- numeric()
for (i in 1:nrow(activity)) {
    obs <- activity[i, ]
    if (is.na(obs$steps)) {
        steps <- subset(StepsAverage, interval == obs$interval)$steps
    } else {
        steps <- obs$steps
    }
    fillNA <- c(fillNA, steps)
}
```

## 3. Creating a new dataset including the imputed missing values

We created a new data frame named **new_activity** and stored the same values there were in the **activity** dataset. Then we filled the steps column with new **fillNA** having no missing values. 


```r
new_activity <- activity
new_activity$steps <- fillNA
```

## 4. Making a histogram of the total number of steps taken each day and calculating and reporting the mean and median total number of steps taken per day

Now that we have two datasets one having some missing values, one new having no missing values. We calculated the total number of steps taken using `aggregate()` function like before for new dataset and drew the histogram for that. For a better understanding of what missing values may differ the conclusion, we drew another histogram with the old dataset. and compared them in the same histogram. Here, we can see imputed data have more number of steps per day defined by the maroon color. 


```r
StepsTotalUnion <- aggregate(steps ~ date, data = new_activity, sum, na.rm = TRUE)
hist(StepsTotalUnion$steps, main = "Total Steps Each Day", col="#00AFBB", xlab="Number of Steps")
 
hist(steps_per_day$steps, main = "Total Steps Each Day", col="maroon", xlab="Number of Steps", add=T)
legend("topright", c("Imputed", "Non-imputed"), col=c("#00AFBB", "maroon"), lwd=10)
```

![](codebook_files/figure-html/unnamed-chunk-17-1.png)<!-- -->

### Calculating Mean

R has a generic function called `mean()` to calculate the mean.


```r
rmeantotal <- mean(StepsTotalUnion$steps)
rmeantotal
```

```
## [1] 10766.19
```

### Calculating Median

Additionally, R has a generic function called `median()` to calculate the median.


```r
rmediantotal <- median(StepsTotalUnion$steps)
rmediantotal
```

```
## [1] 10766.19
```

### Do these values differ from the estimates from the first part of the assignment?

We subtracted the old mean and meadian form the new mean and meadian for the difference.


```r
rmediandiff <- rmediantotal - rmedian
rmediandiff
```

```
## [1] 1.188679
```

```r
rmeandiff <- rmeantotal - rmean
rmeandiff
```

```
## [1] 0
```

**The mean(Mean Var: 0) is the same however the median does have a small variance(Median Var:1.1886792). between the total which includes the missing values to the base**

### What is the impact of imputing missing data on the estimates of the total daily number of steps?

On observation the impact of the missing data has the biggest effect on the 10000 - 150000 step interval and changes frequency from 27.5 to 35 a variance of 7.5


# E. Are there differences in activity patterns between weekdays and weekends?

For this part of the project, we will be performing two things:

 1. We will be creating a new factor variable in the dataset with two levels - "weekday" and "weekend" indicating whether a given date is a weekday or weekend day
 2. We will be making a panel plot containing a time series plot
 
## 1. Creating a new factor variable in the dataset with two levels - "weekday" and "weekend" indicating whether a given date is a weekday or weekend day

We created a vector named **weekdays** containing the weekdays. R has a built in `weekdays()` for indicating weekdays in the **Date** class. We converted the **date** column as Date class. Then, we turned them into the day the date belongs to. We checked the day with `is.element()` if it is a weekday or not with the help og `ifelse()`. We coverted the the two types weekdays and weekend into two factor or catagory then saved them in **new_activity** declaring a new column named **dow**. 

```r
weekdays <- c("Monday", "Tuesday", "Wednesday", "Thursday", 
              "Friday")
new_activity$dow = as.factor(ifelse(is.element(weekdays(as.Date(new_activity$date)),weekdays), "Weekday", "Weekend"))
```

## 2. A panel plot containing a time series plot
We calculated the mean of the toal number of steps taken according to 5 minute interval and weekdays or weekend. Finally we made the panel plot where one plot is for weekend days and other is for weekdays.

```r
StepsTotalUnion <- aggregate(steps ~ interval + dow, new_activity, mean)
library(lattice)
xyplot(StepsTotalUnion$steps ~ StepsTotalUnion$interval|StepsTotalUnion$dow, main="Average Steps per Day by Interval",xlab="Interval", ylab="Steps",layout=c(1,2), type="l")
```

![](codebook_files/figure-html/unnamed-chunk-23-1.png)<!-- -->


