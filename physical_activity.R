#Comments were ommited as the explanation is added in the codebook.md file#

if (!file.exists("data")) {
        dir.create("data")
}


dataset_url <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip" 
download.file(dataset_url, destfile="./data/Activity_monitoring_data.zip", method = "wininet")
unzip("./data/Activity_monitoring_data.zip")
list.files("./data",  all.files=T)

activity <- read.csv("activity.csv", header = TRUE, sep = ",", na.strings = "NA")
str(activity)
activity$date <- as.Date(activity$date, format = "%Y-%m-%d")


steps_per_day <- aggregate(steps ~ date, activity, sum)
head(steps_per_day)
hist(steps_per_day$steps, main = paste("The total number of steps taken per day"),  breaks = 20, col="red", xlab="Number of Steps")
rmean <- mean(steps_per_day$steps)
rmean
rmedian <- median(steps_per_day$steps)
rmedian


steps_by_interval<- aggregate(steps ~ interval, activity, mean)
plot(steps_by_interval$interval, steps_by_interval$steps, 
     type = "l", 
     main = 'Average number of steps taken in 5-minute interval, averaged across all days',
     xlab='Intervals',
     ylab='Average number of steps',
     col = "#00AFBB")
intervale_max_steps<-steps_by_interval[which.max(steps_by_interval$steps),]$interval
intervale_max_steps


totalNA<- sum(!complete.cases(activity))
totalNA
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
new_activity <- activity
new_activity$steps <- fillNA
StepsTotalUnion <- aggregate(steps ~ date, data = new_activity, sum, na.rm = TRUE)
hist(StepsTotalUnion$steps, main = "Total Steps Each Day", col="#00AFBB", xlab="Number of Steps")
hist(steps_per_day$steps, main = "Total Steps Each Day", col="maroon", xlab="Number of Steps", add=T)
legend("topright", c("Imputed", "Non-imputed"), col=c("#00AFBB", "maroon"), lwd=10)
rmeantotal <- mean(StepsTotalUnion$steps)
rmeantotal
rmediantotal <- median(StepsTotalUnion$steps)
rmediantotal
rmediandiff <- rmediantotal - rmedian
rmediandiff
rmeandiff <- rmeantotal - rmean
rmeandiff



weekdays <- c("Monday", "Tuesday", "Wednesday", "Thursday", 
              "Friday")
new_activity$dow = as.factor(ifelse(is.element(weekdays(as.Date(new_activity$date)),weekdays), "Weekday", "Weekend"))
StepsTotalUnion <- aggregate(steps ~ interval + dow, new_activity, mean)
library(lattice)
xyplot(StepsTotalUnion$steps ~ StepsTotalUnion$interval|StepsTotalUnion$dow, main="Average Steps per Day by Interval",xlab="Interval", ylab="Steps",layout=c(1,2), type="l")
