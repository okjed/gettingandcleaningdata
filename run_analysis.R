# Set the working directory
setwd("~/Downloads/Coursera/Getting and Cleaning Data/Course Project/")

# Load reshape2 to assist with the reshaping the dataset
library(reshape2)

# File must be downloaded and unzipped from:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# This checks whether the file exists already and acquires/unzips if it doesn't exist.
if (!file.exists("UCI HAR Dataset")) {
        zipfileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        zipfilename <- "dataset.zip"
        download.file(url=zipfileurl,destfile=zipfilename,method="curl")
        unzip(zipfile=zipfilename)
}

# Read in the labels for the features in the datasets
features <- read.table("UCI HAR Dataset/features.txt",header=FALSE,stringsAsFactors = FALSE)

# Read in the labels for the activities in the datasets
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt",header=FALSE,stringsAsFactors = FALSE)

# Read in the training set data in order of subject and activity
# Finally read in the 561 columns of data. Each read table is joined with a column bind.
# Read and column bind the subject identifiers
training <- read.table("UCI HAR Dataset/train/subject_train.txt",header=FALSE)
# Read and column bind the activity identifiers
training <- cbind(training,read.table("UCI HAR Dataset/train/y_train.txt",header=FALSE))
# Read and column bind the accelerometer results
training <- cbind(training,read.table("UCI HAR Dataset/train/X_train.txt",header=FALSE))

# Follow the above steps for the test subjects and data
test <- read.table("UCI HAR Dataset/test/subject_test.txt",header=FALSE)
test <- cbind(test,read.table("UCI HAR Dataset/test/y_test.txt",header=FALSE))
test <- cbind(test,read.table("UCI HAR Dataset/test/X_test.txt",header=FALSE))

# Combine both sets of data
alldata <- rbind(training,test)

# Clean up the column names and assign to the dataframe
colnames(alldata) <- c("Subject","Activity",features[,2])

# Apply the activity labels to the dataframe utilizing factor capabilities.
alldata$Activity=factor(alldata$Activity,labels=activity_labels[,2])

# Pick the columns of data we wish to keep in the tidy set (mean and std)
meanandstd <- grep("mean\\(|std\\(",features[,2])
tidymeanandstd <- alldata[,c(1:2,meanandstd+2)] # Adding 2 to shift past the subject and activity

# Melt the data for reshaping
tidymeanandstd_m <- melt(tidymeanandstd,id.vars=1:2)

# Recast the melted data to create means for all variables
tidyaverages <- dcast(tidymeanandstd_m, Subject+Activity ~ variable,mean)

# Rename the columns to account for the purpose of the new numbers (averages) and eliminate the parantheses
tidycolumnnames <- gsub("\\(\\)","",colnames(tidyaverages))
colnames(tidyaverages)[3:ncol(tidyaverages)] <- gsub("^","Average",tidycolumnnames[3:length(tidycolumnnames)])

# Save the tidy dataset
write.csv(tidyaverages,"tidydata.csv",row.names=FALSE)
