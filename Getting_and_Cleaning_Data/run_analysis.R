library(plyr)
library(reshape2)

activityLabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", col.names = c("Id", "Activity"), colClasses = c("numeric", "character"))
features <- read.table("./data/UCI HAR Dataset/features.txt", col.names = c("Id", "Feature"))
filteredFeatures <- features[grepl(".*(mean|std)[()].*", features$Feature),]
filteredTestData <- read.table("./data/UCI HAR Dataset/test/X_test.txt", col.names = features[,2])[,filteredFeatures[,2]]
filteredTestData$Activity <- as.factor(read.table("./data/UCI HAR Dataset/test/y_test.txt")[,1])
filteredTrainData <- read.table("./data/UCI HAR Dataset/train/X_train.txt", col.names = features[,2])[,filteredFeatures[,2]]
filteredTrainData$Activity <- as.factor(read.table("./data/UCI HAR Dataset/train/y_train.txt")[,1])
testSubjects <- as.factor(read.table("./data/UCI HAR Dataset/test/subject_test.txt")[,1])
trainSubjects <- as.factor(read.table("./data/UCI HAR Dataset/train/subject_train.txt")[,1])
subjects <- c(testSubjects, trainSubjects)

combinedData <- rbind(filteredTestData, filteredTrainData)
activities <- as.factor(mapvalues(combinedData$Activity, from=activityLabels[,1], to=activityLabels[,2]))
combinedData$Activity <- NULL
splitData <- split(combinedData, list(subjects, activities))
tidyData <- sapply(splitData, colMeans)
meltedData <- melt(tidyData)
temp <- colsplit(meltedData$Var2, pattern = "\\.", names = c('Subject', 'Activity'))
meltedData$Subject <- temp$Subject
meltedData$Activity <- temp$Activity
meltedData$Var2 <- NULL
names(meltedData) <- c("Measurement", "Mean", "Subject", "Activity")

rm(filteredTestData)
rm(filteredTrainData)
rm(activityLabels)
rm(features)
rm(filteredFeatures)
rm(activities)
rm(subjects)
rm(testSubjects)
rm(trainSubjects)

write.table(meltedData, row.names = F, file = "./tidy_data.txt")
