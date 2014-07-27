# CodeBook

 This document describes the variables, the data, and transformations performed to tidy a set of data
 
## The Data

- The dataset: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
- The dataset description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The above description is extensive but for the purposes of this project we are tidying the results
for 30 subjects that have already been divided between two groups, ```training``` and ```test```.

From the dataset's ```README.txt```:

> For each record it is provided:
> ======================================
>
>- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
>- Triaxial Angular velocity from the gyroscope. 
>- A 561-feature vector with time and frequency domain variables. 
>- Its activity label. 
>- An identifier of the subject who carried out the experiment.

## The Loading

1. The script ```run_analysis.R``` downloads and unzips the dataset if it is not already available.
2. The file providing the features, ```features.txt``` is loaded into the ```features``` variable
3. The file providing the activity names, ```activity_labels.txt``` is loaded into the ```activity_labels``` variable
4. For both the training and test sets of data, the following occurs (showing with train set as example):
	1. Read in the ```subject_train.txt```
	2. Read in the activity identifiers ```y_train.txt```and column bind it to the subjects
	3. Read in the 561-feature vector ```X_train.txt```and column bind with the previous results
5. Combine both the test and training sets with a row bind into ```alldata```.

## The Tidying
1. Utilizing the ```features``` vector, replace the associated column names of ```alldata```
2. Utilizing the ```activity_labels``` vector, factorize the ```activity``` column of ```alldata``` to provide descriptive names
3. With the pattern ```mean\\(|std\\(```, keep only the means and standard deviation features
4. Leveraging ```reshape2```, ```melt``` and ```cast``` the resulting dataframe to provide the mean for each of the variables against the observation IDs and create the new dataframe ```tidyaverages```
5. Rename the columns to take into account these are now averages for each of the subjects and activities

## The Results
The final dataset after tidying per the projects requirements is then saved as a comma separated file ```tidydata.csv```

## Variable Descriptions
The sourced data provides subject identifiers and activity labels which were remapped into the tidy data as ```Subject``` and ```Activity```. The 561 feature vector was ultimately narrowed to the averages per subject and activity of 66 elements from the original dataset, only those resulting from either mean() or std().

```
 [1] "AveragetBodyAcc-mean-X"           "AveragetBodyAcc-mean-Y"          
 [3] "AveragetBodyAcc-mean-Z"           "AveragetBodyAcc-std-X"           
 [5] "AveragetBodyAcc-std-Y"            "AveragetBodyAcc-std-Z"           
 [7] "AveragetGravityAcc-mean-X"        "AveragetGravityAcc-mean-Y"       
 [9] "AveragetGravityAcc-mean-Z"        "AveragetGravityAcc-std-X"        
[11] "AveragetGravityAcc-std-Y"         "AveragetGravityAcc-std-Z"        
[13] "AveragetBodyAccJerk-mean-X"       "AveragetBodyAccJerk-mean-Y"      
[15] "AveragetBodyAccJerk-mean-Z"       "AveragetBodyAccJerk-std-X"       
[17] "AveragetBodyAccJerk-std-Y"        "AveragetBodyAccJerk-std-Z"       
[19] "AveragetBodyGyro-mean-X"          "AveragetBodyGyro-mean-Y"         
[21] "AveragetBodyGyro-mean-Z"          "AveragetBodyGyro-std-X"          
[23] "AveragetBodyGyro-std-Y"           "AveragetBodyGyro-std-Z"          
[25] "AveragetBodyGyroJerk-mean-X"      "AveragetBodyGyroJerk-mean-Y"     
[27] "AveragetBodyGyroJerk-mean-Z"      "AveragetBodyGyroJerk-std-X"      
[29] "AveragetBodyGyroJerk-std-Y"       "AveragetBodyGyroJerk-std-Z"      
[31] "AveragetBodyAccMag-mean"          "AveragetBodyAccMag-std"          
[33] "AveragetGravityAccMag-mean"       "AveragetGravityAccMag-std"       
[35] "AveragetBodyAccJerkMag-mean"      "AveragetBodyAccJerkMag-std"      
[37] "AveragetBodyGyroMag-mean"         "AveragetBodyGyroMag-std"         
[39] "AveragetBodyGyroJerkMag-mean"     "AveragetBodyGyroJerkMag-std"     
[41] "AveragefBodyAcc-mean-X"           "AveragefBodyAcc-mean-Y"          
[43] "AveragefBodyAcc-mean-Z"           "AveragefBodyAcc-std-X"           
[45] "AveragefBodyAcc-std-Y"            "AveragefBodyAcc-std-Z"           
[47] "AveragefBodyAccJerk-mean-X"       "AveragefBodyAccJerk-mean-Y"      
[49] "AveragefBodyAccJerk-mean-Z"       "AveragefBodyAccJerk-std-X"       
[51] "AveragefBodyAccJerk-std-Y"        "AveragefBodyAccJerk-std-Z"       
[53] "AveragefBodyGyro-mean-X"          "AveragefBodyGyro-mean-Y"         
[55] "AveragefBodyGyro-mean-Z"          "AveragefBodyGyro-std-X"          
[57] "AveragefBodyGyro-std-Y"           "AveragefBodyGyro-std-Z"          
[59] "AveragefBodyAccMag-mean"          "AveragefBodyAccMag-std"          
[61] "AveragefBodyBodyAccJerkMag-mean"  "AveragefBodyBodyAccJerkMag-std"  
[63] "AveragefBodyBodyGyroMag-mean"     "AveragefBodyBodyGyroMag-std"     
[65] "AveragefBodyBodyGyroJerkMag-mean" "AveragefBodyBodyGyroJerkMag-std"
```

