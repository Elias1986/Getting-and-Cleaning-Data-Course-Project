library(plyr)

x_train <- read.table("~/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("~/UCI HAR Dataset/train/Y_train.txt")
subject_train <- read.table("~/UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("~/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("~/UCI HAR Dataset/test/Y_test.txt")
subject_test <- read.table("~/UCI HAR Dataset/test/subject_test.txt")

xmerge <- rbind(x_test, x_train)
ymerge <- rbind(y_test, y_train)
subjectmerge <- rbind(subject_test, subject_train)

feat <- read.table("~/UCI HAR Dataset/features.txt")

ms <- grep("-(mean|std)\\(\\)", feat [, 2])

xmerge <- xmerge[, ms]

names(xmerge) <- feat[ms, 2]

act <- read.table("~/UCI HAR Dataset/activity_labels.txt")
ymerge[,1] <- act[ymerge[,1],2]

names(ymerge) <- "Activity"

names(subjectmerge) <- "Subject"

database <- cbind(xmerge, ymerge, subjectmerge)
averages_data <- ddply(database, .(Subject, Activity), function(x) colMeans(x[, 1:66]))

write.table(averages_data, "averages_data.txt", row.name=FALSE)


