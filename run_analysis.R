library(dplyr)

#set UCI HAR Datast as working directory
setwd("D:/git/git - waruini/UCI HAR Dataset")

# use read.table to read the necessary files into R
xtest <- read.table("test/X_test.txt", na.strings = NA)
xtrain <- read.table("train/X_train.txt", na.strings = NA)
ytest <- read.table("test/y_test.txt", na.strings = NA)
ytrain <- read.table("train/y_train.txt", na.strings = NA)
subject_train <- read.table("train/subject_train.txt")
subject_test <- read.table("test/subject_test.txt")
features <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt")

#name each column of dataset
colnames(xtrain) <- features[,2]
colnames(ytrain) <- "Activity ID"
colnames(xtest) <- features[,2]
colnames(ytest) <- "Activity ID"
colnames(subject_test) <- "Subject ID"
colnames(subject_train) <- "Subject ID"
colnames(activity_labels) <- "Activity ID"

# merge the training and the test sets to a new data set
xtrain_test <- rbind(xtrain, xtest)
ytrain_test <- rbind(ytrain, ytest)
subject <- rbind(subject_test, subject_train)
merge_data2 <- cbind(subject, ytrain_test, xtrain_test)

# check which colnames include mean and std
mean_std <- grepl("mean|std|Activity ID|Subject ID", colnames(merge_data2))
# extract the mean and standard deviation columns
mean_std_data <- merge_data2[, mean_std==TRUE]

# use descriptive activity names to names the activities in the data set
mean_std_data$`Activity ID` <- gsub("1","WALKING", mean_std_data$`Activity ID`)
mean_std_data$`Activity ID` <- gsub("2", " WALKING_UPSTAIRS", mean_std_data$`Activity ID`)
mean_std_data$`Activity ID` <- gsub("3", " WALKING_DOWNSTAIRS", mean_std_data$`Activity ID`)
mean_std_data$`Activity ID` <- gsub("4", " SITTING", mean_std_data$`Activity ID`)
mean_std_data$`Activity ID` <- gsub("5", " STANDING", mean_std_data$`Activity ID`)
mean_std_data$`Activity ID` <- gsub("6", " LAYING", mean_std_data$`Activity ID`)

#labels the data set with descriptive variable names
colnames(mean_std_data) <- gsub("Body", "B", colnames(mean_std_data))

# create a new data set with the average of each variable
tidy_data <- aggregate(mean_std_data[3:81], by=list(mean_std_data$`Activity ID`), mean)
tidy_data2 <- aggregate(mean_std_data[3:81], by=list(mean_std_data$`Subject ID`),mean)
new_data <- rbind(tidy_data, tidy_data2)
colnames(new_data)[1] <- "Activity_Subject"

#Write the second tidy data into tidy_data_set.txt
write.table(new_data, file="tidy_data_set.txt", row.names = FALSE)
