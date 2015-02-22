# Getting and Cleaning Data Course Project

## Instructions

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## About the script

This script assumes the relevant data is in a subfolder of the working directory called **Smartphonedata**

Once the data is read in, descriptive labels are applied and one complete dataset is created.

The some tidying up of column names takes place and a new data frame is created that only contains the data for the mean and standard deviation for each measurement.

The averages of each column are then calculated and the finished tidy set is exported as a text file named tidy.txt.
