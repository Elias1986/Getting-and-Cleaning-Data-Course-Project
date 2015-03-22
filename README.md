#Assign the files to variables

x_train <- read.table("~/Desktop/R/Data Cleaning/Week3/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("~/Desktop/R/Data Cleaning/Week3/UCI HAR Dataset/train/Y_train.txt")
subject_train <- read.table("~/Desktop/R/Data Cleaning/Week3/UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("~/Desktop/R/Data Cleaning/Week3/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("~/Desktop/R/Data Cleaning/Week3/UCI HAR Dataset/test/Y_test.txt")
subject_test <- read.table("~/Desktop/R/Data Cleaning/Week3/UCI HAR Dataset/test/subject_test.txt")

#Merge training, test & subject for x, y & subject

xmerge <- rbind(x_test, x_train)
ymerge <- rbind(y_test, y_train)
subjectmerge <- rbind(subject_test, subject_train)

#Define the columns containing mean & std as the and asign names in xmerge

feat <- read.table("~/Desktop/R/Data Cleaning/Week3/UCI HAR Dataset/features.txt")

ms <- grep("-(mean|std)\\(\\)", feat [, 2])

xmerge <- xmerge[, ms]

names(xmerge) <- feat[ms, 2]

#Define the columns containing mean & std as the and asign names in xmerge

act <- read.table("~/Desktop/R/Data Cleaning/Week3/UCI HAR Dataset/activity_labels.txt")
ymerge[,1] <- act[ymerge[,1],2]

#Define names for the columens in ymerge & subjectmerge

names(ymerge) <- "activity"

names(subjectmerge) <- "Subject"

#Merge all files

database <- cbind(xmerge, ymerge, subjectmerge)

#Obtain average of columns with mean & std excluding in the average subject and activity column
averages_data <- ddply(database, .(Subject, Activity), function(x) colMeans(x[, 1:66]))