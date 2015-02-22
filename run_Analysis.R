# Load in plyr - we'll need this when working out the averages
library(plyr)

# Read the data into R

subjecttest <- read.table("./Smartphonedata/test/subject_test.txt")
subjecttrain <- read.table("./Smartphonedata/train/subject_train.txt")
xtest <- read.table("./Smartphonedata/test/X_test.txt")
xtrain <- read.table("./Smartphonedata/train/X_train.txt")
ytest <- read.table("./Smartphonedata/test/y_test.txt")
ytrain <- read.table("./Smartphonedata/train/y_train.txt")
act_labels <- read.table("./Smartphonedata/activity_labels.txt")
features <- read.table("./Smartphonedata/features.txt")  

# Using descriptive activity names to name the activities
# There's probably a better way to do this - this is all a bit brute force.

ytest$V1[which(ytest$V1==1)] <- "WALKING"
ytest$V1[which(ytest$V1==2)] <- "WALKING_UPSTAIRS"
ytest$V1[which(ytest$V1==3)] <- "WALKING_DOWNSTAIRS"
ytest$V1[which(ytest$V1==4)] <- "SITTING"
ytest$V1[which(ytest$V1==5)] <- "STANDING"
ytest$V1[which(ytest$V1==6)] <- "LAYING"

ytrain$V1[which(ytrain$V1==1)] <- "WALKING"
ytrain$V1[which(ytrain$V1==2)] <- "WALKING_UPSTAIRS"
ytrain$V1[which(ytrain$V1==3)] <- "WALKING_DOWNSTAIRS"
ytrain$V1[which(ytrain$V1==4)] <- "SITTING"
ytrain$V1[which(ytrain$V1==5)] <- "STANDING"
ytrain$V1[which(ytrain$V1==6)] <- "LAYING"

# 2. Merge all that data into one dataset
x_all <- rbind(xtrain, xtest)
y_all <- rbind(ytrain, ytest)
subject_all <- rbind(subjecttrain, subjecttest)
complete <- cbind(subject_all, y_all, x_all)


# Going to tidy up the column names a bit

# These two get rid of the - sign 
features[,2] = gsub('-mean', 'Mean', features[,2])
features[,2] = gsub('-std', 'Std', features[,2])

# This one removes the ()
features[,2] = gsub('[-()]', '', features[,2])


# Pulls in the feature names and give descriptive names to the id columns
featureNames <- as.character(features[,2])
new_columns <- c("subject", "activity", featureNames)
colnames(complete) <- new_columns


# Create a new data frame that contains the column numbers of 
# only those that contain means and stdevs

only_means <- grep("Mean", colnames(complete))
only_stdevs <- grep("Std", colnames(complete))
combined_means_and_stdevs <- c(only_means, only_stdevs)
combined_means_and_stdevs2 <- sort(combined_means_and_stdevs) 


# This is our finished raw dataset
means_and_stdevs <- complete[, c(1,2,combined_means_and_stdevs2)]


# work out the averages of each column
tidy_data <- ddply(means_and_stdevs, c('subject','activity'), numcolwise(mean)) 

# Write our final tidy data to a text file
write.table(tidy_data, "tidy.txt", sep="\t")

