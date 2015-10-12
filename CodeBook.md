#Code Book
##Raw data collection
###Collection
Raw data are obtained from UCI Machine Learning repository. In particular we used the Human Activity Recognition Using Smartphones Data Set, that was used by the original collectors to conduct experiments exploiting Support Vector Machine (SVM).   

Activity Recognition (AR) aims to recognize the actions and goals of one or more agents from a series of observations on the agents' actions and the environmental conditions. The collectors used a sensor based approach employing smartphones as sensing tools. Smartphones are an effective solution for AR, because they come with embedded built-in sensors such as microphones, dual cameras, accelerometers, gyroscopes, etc.  

The data set was built from experiments carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (walking, walking upstairs, walking downstairs, sitting, standing, laying) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity were captured at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually.  

The obtained data set has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.  


**Signals**

The 3-axial time domain signals from accelerometer and gyroscope were captured at a constant rate of 50 Hz. Then they were filtered to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals using another filter. Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals. Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm. Finally a Fast Fourier Transform (FFT) was applied to some of these time domain signals to obtain frequency domain signals.  

The signals were sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window at 50 Hz). From each window, a vector of features was obtained by calculating variables from the time and frequency domain.  

The set of variables that were estimated from these signals are:  

mean(): Mean value  
std(): Standard deviation  
mad(): Median absolute deviation  
max(): Largest value in array  
min(): Smallest value in array  
sma(): Signal magnitude area  
energy(): Energy measure. Sum of the squares divided by the number of values.  
iqr(): Interquartile range  
entropy(): Signal entropy  
arCoeff(): Autoregression coefficients with Burg order equal to 4  
correlation(): Correlation coefficient between two signals  
maxInds(): Index of the frequency component with largest magnitude  
meanFreq(): Weighted average of the frequency components to obtain a mean frequency  
skewness(): Skewness of the frequency domain signal  
kurtosis(): Kurtosis of the frequency domain signal  
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.  
angle(): Angle between some vectors.  

No unit of measures is reported as all features were normalized and bounded within [-1,1].  

####Data transformation
The raw data sets are processed with run_analisys.R script to create a tidy data set.  

**Merge training and test sets**    

* Values of Varible Activity consist of data from “Y_train.txt” and “Y_test.txt”
* values of Varible Subject consist of data from “subject_train.txt” and subject_test.txt"
* Values of Varibles Features consist of data from “X_train.txt” and “X_test.txt”
* Names of Varibles Features come from “features.txt”
* levels of Varible Activity come from “activity_labels.txt”

Activity, Subject and Features are merged by rows. Variables are labelled with the names assigned by original collectors (features.txt).Columns are merged to get the data frame Data as a single data set.  


**Extract mean and standard deviation variables**  

From the merged data set a subset is extracted with only the values of estimated mean (variables with labels that contain "mean") and standard deviation (variables with labels that contain "std") from the features.  


**Use descriptive activity names**  

Descriptive activity names are read from “activity_labels.txt” and variable *activity* is factorised in the data frame *Data* using descriptive activity names
An activity label (Activity) are named as follows: 
1 WALKING  
2 WALKING_UPSTAIRS  
3 WALKING_DOWNSTAIRS  
4 SITTING  
5 STANDING  
6 LAYING  



**Label variables appropriately** 

Labels given from the original collectors were changed: to obtain valid R names without parentheses, dashes and commas to obtain more descriptive labels. Here is a list of features that are replaced with appropriate Labels.  
+ ^t-time  
+ ^f-frequency  
+ Acc-Accelerator  
+ Gyro-Gyroscope  
+ Mag-Magnitude  
+ BodyBody-Body


**Create a tidy data set**

An independent tidy data set will be created with the average of each variable for each activity and each subject based on the subset data set created in the above steps.  

The following table relates the 17 signals to the names used as prefix for the
variables names present in the data set. ".XYZ" denotes three variables, one for each axis.

Name                                | Time domain                            | Frequency domain
------------------------------------| ---------------------------------------| ------------------------------------
Body Acceleration                   | TimeDomain.BodyAcceleration.XYZ        | FrequencyDomain.BodyAcceleration.XYZ
Gravity Acceleration                | TimeDomain.GravityAcceleration.XYZ     |
Body Acceleration Jerk              | TimeDomain.BodyAccelerationJerk.XYZ    | FrequencyDomain.BodyAccelerationJerk.XYZ
Body Angular Speed                  | TimeDomain.BodyAngularSpeed.XYZ        | FrequencyDomain.BodyAngularSpeed.XYZ
Body Angular Acceleration           | TimeDomain.BodyAngularAcceleration.XYZ |
Body Acceleration Magnitude         | TimeDomain.BodyAccelerationMagnitude   | FrequencyDomain.BodyAccelerationMagnitude
Gravity Acceleration Magnitude      | TimeDomain.GravityAccelerationMagnitude|
Body Acceleration Jerk Magnitude    |TimeDomain.BodyAccelerationJerkMagnitude| FrequencyDomain.BodyAccelerationJerkMagnitude
Body Angular Speed Magnitude        | TimeDomain.BodyAngularSpeedMagnitude   | FrequencyDomain.BodyAngularSpeedMagnitude
Body Angular Acceleration Magnitude|TimeDomain.BodyAngularAccelerationMagnitude|FrequencyDomain.BodyAngularAccelerationMagnitude

For variables derived from mean and standard deviation estimation, the previous labels
The data set is written to the file **tidy.txt**.
