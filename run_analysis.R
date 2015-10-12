
temp <- tempfile()
###Download the file 
download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",temp)
###Unzip the file
###This provides the list of variables and I choose the ones that are applicable for this data set
unzip(temp, exdir="./Getting and Cleaning data/assignment")

path_rf <- file.path("./Getting and Cleaning data/assignment" , "UCI HAR Dataset")
files<-list.files(path_rf, recursive=TRUE)
files

#Read data from the files into the variables

#Read the Activity files
dataActivityTest  <- read.table(file.path(path_rf, "test" , "Y_test.txt" ),header = FALSE)
dataActivityTrain <- read.table(file.path(path_rf, "train", "Y_train.txt"),header = FALSE)

#Read the Subject files

dataSubjectTrain <- read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)
dataSubjectTest  <- read.table(file.path(path_rf, "test" , "subject_test.txt"),header = FALSE)

#Read Fearures files
dataFeaturesTest  <- read.table(file.path(path_rf, "test" , "X_test.txt" ),header = FALSE)
dataFeaturesTrain <- read.table(file.path(path_rf, "train", "X_train.txt"),header = FALSE)

##Merges the training and the test sets to create one data set
dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
dataActivity<- rbind(dataActivityTrain, dataActivityTest)
dataFeatures<- rbind(dataFeaturesTrain, dataFeaturesTest)

##Set names to variables

names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
dataFeaturesNames <- read.table(file.path(path_rf, "features.txt"),head=FALSE)
names(dataFeatures)<- dataFeaturesNames$V2

##Merge columns to get the data frame Data for all data

dataCombine <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, dataCombine)

##Extracts only the measurements on the mean and standard deviation for each measurement
###Subset Name of Features by measurements on the mean and standard deviation
###i.e taken Names of Features with "mean()" or "std()"

subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]

###Subset the data frame Data by seleted names of Features
selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
Data<-subset(Data,select=selectedNames)
names(Data)

##Uses descriptive activity names to name the activities in the data set
##1.Read descriptive activity names from "activity_labels.txt"



activityLabels <- read.table(file.path(path_rf, "activity_labels.txt"),header = FALSE)

##facorize Variale activity in the data frame Data using descriptive activity names
Data$activity <- as.character(Data$activity)
Data$activity[Data$activity == 1] <- "Walking"
Data$activity[Data$activity == 2] <- "Walking_Upstairs"
Data$activity[Data$activity == 3] <- "Walking_Downstairs"
Data$activity[Data$activity == 4] <- "Sitting"
Data$activity[Data$activity == 5] <- "Standing"
Data$activity[Data$activity == 6] <- "Laying"
Data$activity <- as.factor(Data$activity)

head(Data$activity,30)

##Appropriately labels the data set with descriptive variable names
names(Data)<-gsub("^t", "TimeDomain.", names(Data))
names(Data)<-gsub("^f", "FrequencyDomain.", names(Data))
names(Data)<-gsub("Acc", "Acceleration", names(Data))
names(Data)<-gsub("Gyro", "AngularSpeed", names(Data))
names(Data)<-gsub("GyroJerk", "Acceleration", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))
names(Data)

#Creates a second,independent tidy data set and ouput it

library(plyr);
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "./Getting and Cleaning data/assignment/tidydata.txt",row.name=FALSE)



