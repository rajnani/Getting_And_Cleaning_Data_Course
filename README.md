# Getting_And_Cleaning_Data_Course

As long as the current working directory has the appropriate files, compile the run_analysis.R and
execute the command

runanalysis()

This will automatically read the data, complete the steps as required in the assignment and creates
a file tidy_data_by_subject_activityId.txt in the working directory.

The program will also show the output in the console

> runanalysis()
run_analysis:  Loading test data.. 
run_analysis:  Loading train data.. 
run_analysis:  Concatenate test and train data for X, Y and Subject.. 
run_analysis:  Loading column names from features file.. 
run_analysis:  Add additional column names for subject and activityId.. 
run_analysis:  Load activity names from activity labels file.. 
run_analysis:  Create y factor with the actual activity names in Y files.. 
run_analysis:  Create complete data with appropriate column names and activity labels.. 
run_analysis:  Get the mean and std columns.. 
run_analysis:  Create clean data set with avg for each variable by activity and subject.. 
> 


