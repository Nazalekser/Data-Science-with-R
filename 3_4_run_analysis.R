# The experiments have been carried out with a group of 30 volunteers within an
# age bracket of 19-48 years. Each person performed six activities (WALKING,
# WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a
# smartphone (Samsung Galaxy S II) on the waist. Using its embedded 
# accelerometer and gyroscope, we captured 3-axial linear acceleration and
# 3-axial angular velocity at a constant rate of 50Hz. The experiments have been
# video-recorded to label the data manually. The obtained dataset has been 
# randomly partitioned into two sets, where 70% of the volunteers was selected
# for generating the training data and 30% the test data. 

# Load data to variables
x_train <- read.table('C:/Users/PC/Desktop/AI/DS/Data Science/3. Getting and Cleaning Data/4. Text and date manipulation in R/data/UCI HAR Dataset/train/X_train.txt')
x_test <- read.table('C:/Users/PC/Desktop/AI/DS/Data Science/3. Getting and Cleaning Data/4. Text and date manipulation in R/data/UCI HAR Dataset/test/X_test.txt')
y_train <- read.table('C:/Users/PC/Desktop/AI/DS/Data Science/3. Getting and Cleaning Data/4. Text and date manipulation in R/data/UCI HAR Dataset/train/y_train.txt')
y_test <- read.table('C:/Users/PC/Desktop/AI/DS/Data Science/3. Getting and Cleaning Data/4. Text and date manipulation in R/data/UCI HAR Dataset/test/y_test.txt')

# 1. Merge the training and the test sets to create one data set
x_mergedData <- rbind(x_train, x_test)
y_mergedData <- rbind(y_train, y_test)

# 2. Extract only the measurements on the mean and standard deviation for each 
# measurement.

features <- read.table('C:/Users/PC/Desktop/AI/DS/Data Science/3. Getting and Cleaning Data/4. Text and date manipulation in R/data/UCI HAR Dataset/features.txt')
names(x_mergedData) <- features[, 2] # rename the variables
mean_std_data <- x_mergedData[, grep('[Mm]ean|std', features[, 2])]

# 3. Use descriptive activity names to name the activities in the data set

activities <- read.table('C:/Users/PC/Desktop/AI/DS/Data Science/3. Getting and Cleaning Data/4. Text and date manipulation in R/data/UCI HAR Dataset/activity_labels.txt')
y_mergedData$V1 <- factor(y_mergedData$V1, levels = activities[,1], labels = activities[,2])

# 4. Appropriately label the data set with descriptive variable names. 

subject_train <- read.table('C:/Users/PC/Desktop/AI/DS/Data Science/3. Getting and Cleaning Data/4. Text and date manipulation in R/data/UCI HAR Dataset/train/subject_train.txt')
subject_test <- read.table('C:/Users/PC/Desktop/AI/DS/Data Science/3. Getting and Cleaning Data/4. Text and date manipulation in R/data/UCI HAR Dataset/test/subject_test.txt')
subject <- rbind(subject_train, subject_test)
allData <- cbind(subject, y_mergedData, mean_std_data)

colnames(allData) <- c("subject", "activity", colnames(mean_std_data))

# 5. From the data set in step 4, create a second, independent tidy data 
# set with the average of each variable for each activity and each subject.

library(reshape2)

meltedData <- melt(allData, id = c("subject", "activity"))
act_sub_mean <- dcast(meltedData, subject + activity ~ variable, mean)

library(xlsx)

write.xlsx(act_sub_mean, "act_sub_mean.xlsx", row.names = FALSE)