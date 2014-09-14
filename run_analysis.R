# dependency package plyr needs to be installed. In case you would need to install it, use follow:
# install.packages("plyr")
library(plyr)

# URL of file necessary for this assignment. Raw dataset will be downloaded and unzipped in 
# current workdirectory
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "raw_data.zip", method="curl")
unzip("raw_data.zip")

# Setting workdirectory to unzipped file - 
setwd("./UCI HAR Dataset/")

## 1. Merges the training and the test sets to create one data set. 
# Reads in all neccessary files and assigns column names directly to imported data
features        <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt",       col.names = c("id","name"))
xtrain          <- read.table("./train/X_train.txt",       col.names = features[,2])
xtest           <- read.table("./test/X_test.txt",         col.names = features[,2])
ytrain          <- read.table("./train/y_train.txt",       col.names = "activity_id")
ytest           <- read.table("./test/y_test.txt",         col.names = "activity_id")
subject_train   <- read.table("./train/subject_train.txt", col.names = "subject_id")
subject_test    <- read.table("./test/subject_test.txt",   col.names = "subject_id")

# Binds together training dataset
training <- cbind(ytrain, subject_train, xtrain)
# Binds together test dataset
test <- cbind(ytest, subject_test, xtest)
# Merges together traing and test data to create one data set. (still not tidy data yet.)
merged_data <- rbind(training, test)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# Creates a vector that can be used to select mean() and std() columns plus activity_id
# and subject_id
col_labels <- names(merged_data)
# Creates a local vector via grepl function to idenfity desired columns
selected_columns <- (grepl("activity",col_labels) | grepl("subject",col_labels) | grepl("mean",col_labels) | grepl("std",col_labels)) & !grepl("meanFreq",col_labels)
# Subsets merged dataset with only desired columns
tidy <- merged_data[selected_columns==TRUE]

## 3. Uses descriptive activity names to name the activities in the data set
# Loops over activity_id column in merged dataset and renaming id numbers to descriptive
# activity names from activity_lables table
for (i in 1:length(activity_labels$name)) { 
  tidy$activity_id <- sub(i, activity_labels$name[i], tidy$activity_id) }

## 4. Appropriately labels the data set with descriptive variable names. 
# Performing multiple renaming/replacing names operations to make labels more descriptive
names(tidy) <- sub("activity_id", "activity", names(tidy)) ## renaming column to activity
names(tidy) <- sub("std", "StdDev", names(tidy))          ## changes std to StdDev
names(tidy) <- sub("\\.\\.", "", names(tidy))            ## removes two dots away
names(tidy) <- sub("mean", "Mean", names(tidy))         ## changes mean to Mean 
names(tidy) <- sub("BodyBody", "Body", names(tidy))    ## removes one Body from BodyBody

## 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.                                                                
# Excludes activity and subject_id because we wont calculate means from these columns
excluded <- which(names(tidy) %in% c("activity", "subject_id"))
# Summarizes the result table using plyr function ddply - more info on ?ddply
result <- ddply(tidy,.(activity, subject_id),.fun=function(x){colMeans(x[,-excluded])})
# Goes back to workdirectory (not necessary step but it looks better)
setwd("../")
# Exports the tidy_dataset.txt to current workdirectory
write.table(result, "tidy_dataset.txt", row.names=FALSE, sep='\t')

# Cleans up workspace
rm(list=ls())