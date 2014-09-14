# Getting and cleaning data - Course Project

## Overview

Welcome to the project for "Getting and cleaning data" coursera.org course.
This exercise aims to wind up skills in getting and cleaning raw data from an
instructed data source.

For more information - click [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

## Assignment description

You should create one R script called run_analysis.R that does the following. 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Dependencies and pre-requisites

* Online connection and R or RStudio.
* Plyr package (run install.packages("plyr") in R if you don't have it yet.)

## Running the Script (run_analysis.R)

Open RStudio or R, download the script and run it from the software once you have installed Plyr package.
This script runs the download itself. Make sure you are connected to the Internet.
In case you need more description about the steps - see comments inside the script.

## Reading the result

run_analysis.R creates 1 file:

* tidy_dataset.txt: a tab-delimited file containing tidy data set with the mean of each variable for each activity and each subject

 To access the result type follow in R: `read.table("tidy_dataset.txt", header=TRUE)`

## Code Book

Check [here](CodeBook.md).