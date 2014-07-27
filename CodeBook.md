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
