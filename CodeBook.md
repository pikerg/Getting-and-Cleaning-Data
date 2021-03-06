#Human Activity Recognition Using Smartphones Data Set
*The following information was copied from the README.txt file included in the data download. Additional information about the use of this data within the scope of the project are located in the "Project Process Steps" section below.*

Description
===========
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

*The above information was copied from the README.txt file included in the data download. Additional information about the use of this data within the scope of the project are located in the "Project Process Steps" section below.*

##Detailed information about the Data set used in this assignment can be found at this web address

##Project Process Steps
* The data set for this assignment were dowloaded from the following web address:
	https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* The files were unzipped into the working directory of a local machine.
* Using the run_analysis.R script the data set was processed as followes:
	+ The following files were read into the Global Environment of RStudio and saved as variables:
		- y_test.txt
		- X_test.txt
		- subject_test.txt
		- y_train.txt
		- X_train.txt
		- subject_train.txt
		- features.txt
		- activity_labels.txt)
	+ Variables for the above files in order as listed:
		- yTest
		- xTest
		- subjectTest
		- yTrain
		- xTrain
		- subjectTrain
		- features
		- actLabels
	+ The files were then merged together to create a complete data table as follows:
	 	- Row bind the subject with the following code
	 	~~~~~~~
		subject <- rbind(subjectTrain, subjectTest)
		~~~~~~~
	 	- Re-name the subject column
	 	~~~~~~~
		names(subject) <- "subject"
		~~~~~~~
	 	- Row bind the xTest and xTrain data
	 	~~~~~~~
		x <- rbind(xTrain, xTest)
		~~~~~~~ 
		- Re-name the columns with the features variable
		~~~~~~~
		names(x) <- features[,2]
		~~~~~~~
		- Row bind the yTest and yTrain data
		~~~~~~~
		y <- rbind(yTrain, yTest)
		~~~~~~~
		- Update v1 to the correct activity name and name the column
	 	~~~~~~~
		y[,1] <- actLabels[y[,1],2]
		~~~~~~~
		- Re-name the column of activety
	 	~~~~~~~
		names(y) <- "activity"
		~~~~~~~
		- Create the complete data set
		~~~~~~~
		completeData <- cbind(subject,y,x)
		~~~~~~~
	+ A subset of the complete data table was created by using the "subject", "activity" columns.
	~~~~~~~
	meanSubSet <- subset(completeData, select=c("subject","activity"))
	~~~~~~~
	+ Any column name containing "mean()" and "std()" was then column bound to the meanSubSet subset data table.
	~~~~~~~
	meanSubSet <- cbind(meanSubSet, completeData[,grep("mean\\(\\)|std\\(\\)", names(completeData))])
	~~~~~~~
	+ The colMeans() function was then applied to the meanSubSet to produce the required tidyData table. This creates the second, independent tidy data set with the average of each variable for each activity and each subject.
	~~~~~~~
	tidyData <- ddply(meanSubSet, .(subject, activity), function(x) colMeans(x[, 3:68]))
	~~~~~~~
	+ Write the tidyData table to a text file "averages_data.txt" using row.name=FALSE.
	~~~~~~~
	write.table(tidyData, "averages_data.txt", row.name=FALSE)
	~~~~~~~
