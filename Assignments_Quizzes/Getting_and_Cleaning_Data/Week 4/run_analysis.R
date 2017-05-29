
library(dplyr)


## Download the zip file and extract

path <- getwd()

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

destfile <- paste(path, "/UCI HAR Dataset.zip", sep = "")

download.file(url, destfile = destfile)

unzip(destfile)

####################################################################################################
####################################################################################################

## read the features and activity_labels data

feature_data <- read.table("./UCI HAR Dataset/features.txt")
activity_label <- read.table("./UCI HAR Dataset/activity_labels.txt")

## read the data in test folder
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")


## read the data in train folder
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")


## 1. Merges the training and the test sets to create one data set.

x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train,  subject_test)


## 2. Extracts only the measurements on the mean and standard deviation for each measurement.

features <- as.character(feature_data[, 2])

feature_needed <- features[grep("mean\\(|std\\(", features)]

feat_index <- which(features %in% feature_needed)

x_data <- x_data[, feat_index]


## 3. Uses descriptive activity names to name the activities in the data set

y_data[, 1] <- factor(y_data[, 1], levels = activity_label[, 1], labels = activity_label[, 2])


## 4. Appropriately labels the data set with descriptive variable names.

names(x_data) <- features[feat_index]
names(y_data) <- "Activity"
names(subject_data) <- "Subject"


## 5. From the data set in step 4, creates a second, 
## independent tidy data set with the average of each 
## variable for each activity and each subject.


data_1 <- cbind(y_data, x_data, subject_data)

tidy_data <- data_1 %>% group_by(Activity, Subject) %>% summarise_each(funs(mean))

write.table(tidy_data, file = "./UCI HAR Dataset/tidy_data.txt", row.names = FALSE, col.names = TRUE)

