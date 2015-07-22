####################################################################################################
## Assignment Objectives:
##    Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each
##    activity and each subject.
##
## A detailed description of the code steps is provided in the CodeBook.md located in this
## repository

####################################################################################################
## Read all of the required data
## a. Read the Traing and Test data sets
yTest <- read.table("UCI HAR Dataset/test/y_test.txt")
xTest <- read.table("UCI HAR Dataset/test/X_test.txt")
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")
yTrain <- read.table("UCI HAR Dataset/train/y_train.txt")
xTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")

## b. Read the names of the features
features <- read.table("UCI HAR Dataset/features.txt")

## c. read the activity labels (walking, walking upstairs, walking downstairs,
##    sitting standing, laying)
actLabels <- read.table("UCI HAR Dataset/activity_labels.txt")

####################################################################################################
## Combine objectives 1, 3, and 4 in order to create a data set that is complete. This is intended
## to create one big data set that is useful for further analysis outside of the assignment
## objectives
## 1. Merge the training and the test sets to create one data set.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.

## bind and label subject
subject <- rbind(subjectTrain, subjectTest)
names(subject) <- "subject"
## bind and label features
x <- rbind(xTrain, xTest)
names(x) <- features[,2]
## bind, update v1 to the correct activity name and name the column, and label activity
y <- rbind(yTrain, yTest)
y[,1] <- actLabels[y[,1],2]
names(y) <- "activity"
## create complete data set
completeData <- cbind(subject,y,x)

####################################################################################################
## 2. Extracts only the measurements on the mean and standard deviation for each measurement by
##    first getting the subject and activity columns and then binding the columns that contain
##    data on mean and standard deviation.

meanSubSet <- subset(completeData, select=c("subject","activity"))
meanSubSet <- cbind(meanSubSet, completeData[,grep("mean\\(\\)|std\\(\\)", names(completeData))])


####################################################################################################
## 5. Creates a second, independent tidy data set with the average of each variable for each
##    activity and each subject.

tidyData <- ddply(meanSubSet, .(subject, activity), function(x) colMeans(x[, 3:68]))

####################################################################################################
## Write the reselt of the assignment objectives to a text file
write.table(tidyData, "averages_data.txt", row.name=FALSE)

