# use read.table to read the training and text file into R
xtest <- read.table("X_test.txt", na.strings = NA)
xtrain <- read.table("X_train.txt", na.strings = NA)

# merge the training and the test sets to a new data set
xtrain_test <- rbind(xtrain, xtest)

# extract the mean and standard deviation for each column
eachmean <- apply(xtrain_test, 2, mean)   
eachsd <- apply(xtrain_test,2,sd)   

# use descriptive activity names to names the activities in the data set
names(xtrain_test)[1:6] <- c("WALING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS", "SITTING","STANDING", "LAYING")

# label the data set with descriptive variable names
xtrain_test <- gsub("V", "body", names(xtrain_test))

# create a new data set with the average of each variable
newdata <- rbind(xtrain_test, eachmean)
