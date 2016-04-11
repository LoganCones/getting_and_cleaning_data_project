Before you run the run_analysis.R file, you will want to do the following to ensure that the code runs properly: 

  1. Download the data set from the following link, 
     #https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip,      into folder on your desktop called "Data_Science" 
  2. From here, you'll want to extract that zip folder into the same folder which should
     result in the creation of another folder in the "Data_Science" directory called "UCI HAR
     Dataset" 
  3. Install and load relevant packages dplyr, data.table, and tidyr

If you are unsure of the purpose of any particular line of code, commentary has been supplied in the "run_analysis.R" file for your convenience 

The "run_analysis.R" file achieves the following using the the UCI HAR Dataset acquired from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones: 
  1. Merges the training and the test sets to create one data set.
  2. Extracts only the measurements on the mean and standard deviation for each measurement.
  3. Uses descriptive activity names to name the activities in the data set
  4. Appropriately labels the data set with descriptive variable names.
  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  
In "CodeBook.md" you will find the names of the variables in the "UCI_HAR.txt"" data file as well as the descriptions for each of those variables


  

