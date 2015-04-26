library(plyr)
library(reshape2)

# Helper method to log messages to console
log <- function(...) {
  cat("run_analysis: ", ..., "\n")
}

runanalysis <- function() {
  
  log("Loading test data..")
  xtestdata <- read.table(".\\UCI HAR Dataset\\test\\x_test.txt")
  ytestdata <- read.table(".\\UCI HAR Dataset\\test\\y_test.txt")
  subjecttestdata <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt")
  
  log("Loading train data..")
  xtraindata <- read.table(".\\UCI HAR Dataset\\train\\X_train.txt")
  ytraindata <- read.table(".\\UCI HAR Dataset\\train\\y_train.txt")
  subjecttraindata <- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt")  
  
  log("Concatenate test and train data for X, Y and Subject..")
  xfulldata <- rbind(xtestdata, xtraindata)
  yfulldata <- rbind(ytestdata, ytraindata)
  subjectfulldata <- rbind(subjecttestdata, subjecttraindata)
  
  log("Loading column names from features file..")
  featurescontent <- read.table(".\\UCI HAR Dataset\\features.txt", colClasses = c("character"))
  
  log("Add additional column names for subject and activityId..")
  featurescontent <- rbind(rbind(featurescontent, c(562, "Subject")), c(563, "ActivityId"))
  
  log("Load activity names from activity labels file..")
  activitiesdata <- read.table(".\\UCI HAR Dataset\\activity_labels.txt")
  
  log("Create y factor with the actual activity names in Y files..")
  #Note in activities file the first column is id which maps to Y file and second column is description
  yfactor <- as.factor(yfulldata[,1])
  yfactor <- mapvalues(yfactor,from = as.character(activitiesdata[,1]), to = as.character(activitiesdata[,2]))
  
  log("Create complete data with appropriate column names and activity labels..")
  #Note at this point the activities has right names and complete (1), (3), (4) parts
  completedata <- cbind(cbind(xfulldata, subjectfulldata), yfactor)
  colnames(completedata) <- featurescontent[,2]
  
  log("Get the mean and std columns..")
  #Task (2)
  meanstdcols<- grepl("mean|std|Subject|ActivityId",colnames(completedata))
  meanstddata <- completedata[,meanstdcols]
  
  log("Create clean data set with avg for each variable by activity and subject..")
  #Task (5)
  meltdata <- melt(meanstddata,id.vars=c("Subject","ActivityId"))
  tidydataset <- dcast(meltdata, Subject + ActivityId ~ ..., mean)
  write.table(tidydataset, file ="tidy_data_by_subject_activityId.txt", row.name=FALSE)
}