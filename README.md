Getting and Cleaning Data
=========================

### Purpose
This repository is for the **Getting and Cleaning Data** Course Project. It consists of
the document you're reading, the [script](run_analysis.R) to provide a tidy data set
from an extensive set of accelerometer data and the [codebook](CodeBook.md)
that provides all the details about the work that is accomplished.

### Use
The script, ```run_analysis.R``` assumes the reshape2 library is already installed.
Rather than handle the install within the script and making assumptions on local policy
for your R install, please make sure you have the library available.

The script will need to be modified for your preferred working directory in the second
line. The script handles the downloading, unzipping and utilizing data from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

From within R, you may ```source("run_analysis.R")``` and the script results in a tidy data set
which is saved in your working directory named ```tidydata.csv```
