#Before you start the analysis, you're going to want to download the data set from the following link, 
#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip, into folder on
#your desktop called "Data_Science" 

#From here, you'll want to extract that zip folder into the same folder which should result in the
#creation of another folder in the "Data_Science" directory called "UCI HAR Dataset" 

#Load relevant packages
library(dplyr)
library(data.table)
library(tidyr)

#Set Path 
Path <- "~/Desktop/Data_Science/UCI HAR Dataset"

#Pull activity, subject, and features data for both test and train subjects
testActivity <- tbl_df(read.table(file.path(Path, "test", "Y_test.txt")))
trainActivity <- tbl_df(read.table(file.path(Path, "train", "Y_train.txt")))

trainSubject <- tbl_df(read.table(file.path(Path, "train", "subject_train.txt")))
testSubject <- tbl_df(read.table(file.path(Path,"test", "subject_test.txt")))

testData <- tbl_df(read.table(file.path(Path, "test", "X_test.txt")))
trainData <- tbl_df(read.table(file.path(Path,"train", "X_train.txt")))

#Pull features data and name the two columns "featureNum" and "featureName"
featuresData <- tbl_df(read.table(file.path(Path, "features.txt")))
featuresData <- setNames(featuresData, c("featureNum", "featureName"))
                         
#Append the train and test subject data together by row and name the column "subject"
subjectData <- rbind(trainSubject, testSubject)
subjectData <- setNames(subjectData, "subject")
                         
#Append the train and test activity data together by row and name the column "activitynum"
activityData <- rbind(trainActivity, testActivity)
activityData <- setNames(activityData, "activityNum")
                         
#Pull the activity labels data and name the two columns "activityNum" and "activityName"
activityLabels <- tbl_df(read.table(file.path(Path, "activity_labels.txt")))
activityLabels <- setNames(activityLabels, c("activityNum", "activityName"))
                         
#Append the train and test features data by row 
allData <- rbind(trainData, testData)
                         
#Name the columns in allData the feature names in featuresData
colnames(allData) <- featuresData$featureName
                         
#Append the columns of the subject data and the activity data
subjectData <- cbind(subjectData, activityData)
                         
#Append the subject data the train and test data
allData <- cbind(subjectData, allData)
                         
#Take measurements only for mean and standard deviation
featuresDataMeanStd <- grep("mean\\(\\)|std\\(\\)", featuresData$featureName, value = TRUE)
featuresDataMeanStd <- union(c("subject", "activityNum"), featuresDataMeanStd)
allData <- subset(allData, select = featuresDataMeanStd)
                         
#Gets the activity name into the allData table by its associated activity number
allData <- merge(activityLabels, allData, by = "activityNum", all.x = TRUE)
allData <- select(allData, -activityNum)
allData$activityName <- as.character(allData$activityName)
                         
#Calculate the mean for each variable, by subject and activity
aggregatedData <- aggregate(. ~ subject - activityName, data = allData, mean)
allData <- tbl_df(arrange(aggregatedData, subject, activityName))
                         
#Make the variable names more clear and descriptive
names(allData)<-gsub("std\\(\\)", "Standard Deviation", names(allData))
names(allData)<-gsub("mean\\(\\)", "Mean", names(allData))
names(allData)<-gsub("^t", "Time", names(allData))
names(allData)<-gsub("^f", "Frequency", names(allData))
names(allData)<-gsub("Acc", "Accelerometer", names(allData))
names(allData)<-gsub("Gyro", "Gyroscope", names(allData))
names(allData)<-gsub("Mag", "Magnitude", names(allData))
names(allData)<-gsub("BodyBody", "Body", names(allData))
                         
#Write the table to a file called newTidy.txt
write.table(allData,"UCI_HAR.txt", row.name=FALSE)

