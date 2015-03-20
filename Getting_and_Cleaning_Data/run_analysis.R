## run_analysis.R
## This R script creates a tidy data set from the UCI HAR Dataset
## It improves the data's usefulness by including only mean and standard deviation
## for the combined test and training data and utilizing
## the activity and feature names.

library(plyr)

# Read in features from file
rawFeatures <- read.table("./UCI HAR Dataset/features.txt", col.names = c("Id", "Feature"))

# Filter feature list to include only mean and std features
features <- rawFeatures[grepl(".*(mean|std)[()].*", rawFeatures$Feature),]$Feature

# Read in X test and training data and include only columns from the filtered feature list
testData <- read.table("./UCI HAR Dataset/test/X_test.txt")[,features]
trainData <- read.table("./UCI HAR Dataset/train/X_train.txt")[,features]

# Read in Y test and training data and convert the data into a vector
rawActivities <- as.factor(c(read.table("./UCI HAR Dataset/test/y_test.txt")[,1], read.table("./UCI HAR Dataset/train/y_train.txt")[,1]))

# Read in activity labels
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("Id", "Activity"), colClasses = c("numeric", "character"))

# Create an activity vector from the Y data replacing the numeric values with the string factor values
# Utilizes the plyr library's mapvalues function
activities <- as.factor(mapvalues(rawActivities, from=activityLabels[,1], to=activityLabels[,2]))

# Read in the subject lists as a vector
subjects <- as.factor(c(read.table("./UCI HAR Dataset/test/subject_test.txt")[,1], read.table("./UCI HAR Dataset/train/subject_train.txt")[,1]))

# Bind all data together
data <- cbind(subjects, activities, rbind(testData, trainData))

# Set up clean names for the combined data
featureNames <- gsub("[-()]", "", features)
featureNames <- gsub("std", "StandardDeviation", featureNames)
featureNames <- gsub("mean", "Mean", featureNames)
names(data) <- c("Subject", "Activity", featureNames)

# Clean up unused data
rm(activityLabels, rawFeatures, rawActivities, subjects, activities, testData, trainData, features, featureNames)

# Write data to results.txt
write.table(data, file="results.txt", row.name=FALSE)
