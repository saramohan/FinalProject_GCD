library(plyr)

filename <- "getdata-projectfiles.zip"

# Download the zipped data set
################################## 

if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename)
} 

if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}


# 1. Merge the training and test sets to create one data set
###############################################################

# Training DataSet
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

# Test DataSet
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Creating merged X-Data
merge_x <- rbind(x_train, x_test)

# Creating merged Y-Data
merge_y <- rbind(y_train, y_test)

# Creating merged Subject-Data
merge_subject_data <- rbind(subject_train, subject_test)


# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
##############################################################################################

features <- read.table("UCI HAR Dataset/features.txt")

# get feature names with mean() or std() in their names
mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])

# subset the desired columns from merged set
subset_x <- merge_x[, mean_and_std_features]

# names of the columns of the subset
names(subset_x) <- features[mean_and_std_features, 2]


# 3. Use descriptive activity names to name the activities in the data set.
###############################################################################

activities <- read.table("UCI HAR Dataset/activity_labels.txt")

# update Y-values with correct activity names
merge_y[, 1] <- activities[merge_y[, 1], 2]

# Giving the correct name for the column
names(merge_y) <- "ActivityName"


# 4. Appropriately label the data set with descriptive variable names.
###########################################################################

names(merge_subject_data) <- "Subject"

# bind all the data in a single data set
final_data <- cbind(subset_x, merge_y, merge_subject_data)


# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.
#####################################################################################################################

# finding the average of the final data as requested
averages_data <- ddply(final_data, .(Subject, ActivityName), function(x) colMeans(x[, 1:66]))

write.table(averages_data, "final_average_data.txt", row.name=FALSE)


