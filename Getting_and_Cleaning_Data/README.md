###Files###
* run_analysis.R
    * Transforms the data from the data folder into results.txt
* results.txt
    * Output from the transformation
### Purpose ###
run_analysis.R creates a tidy data set from the UCI HAR Dataset. It improves the data's usefulness by including only mean and standard deviation for the combined test and training data and utilizing the activity and feature names.
###Script###
The run_analysis.R script creates the tidy data set via the following algorithm:
1. Reads in the list of features
2. Filters the feature list, keeps only mean and standard deviation features
3. Reads in the test and training data discarding the un-needed features
4. Reads in a list of activities
5. Reads in a list of subjects
6. Binds all the data together
7. Cleans up column names
8. Outputs the data into results.txt
###Dependencies###
This script relies on the plyr library to map the activity ids to the activity labels associated with them.
