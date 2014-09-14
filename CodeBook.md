# Code Book

## Source dataset

The data has been downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

For information about the experiment and the way data was collected, please read README.txt contained in the data source zip file.

## Variables

All the column names are described in features_info.txt data source zip file, except for the following:

* activity: the string representing an activity of the subject

LAYING
SITTING
STANDING
WALKING
WALKING_UPSTAIRS
WALKING_DOWNSTAIRS

* subject_id: the integer corresponding to the subject of the experiment
* Rules applied to the other columns by script (run_analysis.R)
 :it removes extra dots and 
 :it removes "(", ")" 
 :it renames mean to Mean and std to StdDev in all columns of the result.

# Result

* tidy_dataset.txt: 

If you want to load those files using R, use the following command:

```
read.table("tidy_dataset.txt", header=TRUE)
```