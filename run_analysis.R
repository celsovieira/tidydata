#read trainning

train <- read.table("../UCI HAR Dataset/train/X_train.txt")
trainLabels <- read.table("../UCI HAR Dataset/train/y_train.txt")
subtrain <-  read.table("../UCI HAR Dataset/train/subject_train.txt")

#read testing

test <- read.table("../UCI HAR Dataset/test/X_test.txt")
testLabels <- read.table("../UCI HAR Dataset/test/Y_test.txt")
subtest <-  read.table("../UCI HAR Dataset/test/subject_test.txt")

#merge testing trainning
ttsub <- rbind(subtrain, subtest)
names(ttsub) <- c("subject") #naming (giving a head)
ttlab <- rbind(trainLabels, testLabels)
names(ttlab) <- c("activity") #naming (giving a head)
tt <- rbind(train, test)
features <- read.table("../UCI HAR Dataset/features.txt")
names(tt) <- features$V2 #using V2 from features to name tt 

tt_all <- cbind(tt, ttlab, ttsub) # binding named columns as one whole dataset

# select Means and Stds

featsel <- grep("mean\\(\\)|std\\(\\)", features$V2, value = TRUE) #in features
selnames <- c(featsel, "subject", "activity") #in the data
tt_all2 <- subset(tt_all, select = selnames)

#descriptive names for activities
tt_all2$activity <- gsub(1, "walking", tt_all2$activity)
tt_all2$activity <- gsub(2, "walking_upstairs", tt_all2$activity)
tt_all2$activity <- gsub(3, "walking_downstairs", tt_all2$activity)
tt_all2$activity <- gsub(4, "siting", tt_all2$activity)
tt_all2$activity <- gsub(5, "standing", tt_all2$activity)
tt_all2$activity <- gsub(6, "laying", tt_all2$activity)

#descriptive labels
names(tt_all2)<-gsub("^t", "time_", names(tt_all2))
names(tt_all2)<-gsub("^f", "frequency_", names(tt_all2))
names(tt_all2)<-gsub("Acc", "Accelerometer_", names(tt_all2))
names(tt_all2)<-gsub("Gyro", "Gyroscope_", names(tt_all2))
names(tt_all2)<-gsub("Mag", "Magnitude_", names(tt_all2))
names(tt_all2)<-gsub("BodyBody", "Body_", names(tt_all2))
names(tt_all2)<-gsub("Body", "Body_", names(tt_all2))
names(tt_all2)<-gsub("Gravity", "Gravity_", names(tt_all2))
names(tt_all2)<-gsub("-mean", "Mean", names(tt_all2))
names(tt_all2)<-gsub("-std", "Std", names(tt_all2))
names(tt_all2)<-gsub("Jerk", "Jerksignal_", names(tt_all2))

#a dataset with the averages
options(warn = -1)
tt_ind <- aggregate(tt_all2, by=list(activity = tt_all2$activity, subject=tt_all2$subject), mean)
tt_ind[,70] = NULL
tt_ind[,69] = NULL

write.table(tt_ind, file = "tidydata.txt",row.name=FALSE)
