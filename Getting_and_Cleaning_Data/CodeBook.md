##Data
###Input
- The data for this data set was obtained from: http://archive.ics.uci.edu/ml/machine-learning-databases/00240/
- It contains the normalized data captured by 30 subject participating in 6 activities 
	- Full details are available in the raw data set's codebook (http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.names)
- The data from this study was split into test data and training data and includes several files for description
###Output
- The results of the cleaning up effort is a tidy data set that combines the training and testing data from the original
- The cleaned up data set removed all but the mean and standard deviation for each of the 66 features
- The results can be viewed in the results.txt file
###Variables
- There are 68 variables in the resulting data set
	- Subject
		- The Id of the subject
	- Activity
		- A description of the activity
	- Variables beginning with f
		- These variables represent frequency domain signals
	- Variables beginning with t
		- These variables represent time domain signals
- There are 30 subjects in the data set each with the own unique Id
- There are 10299 total measurements for the 30 subjects

###Transformations
- The test data and the training data were combined into one data set
- Variable names were cleaned up to remove special characters
- Abbreviated strings in the variable names were expanded for more readability
- The plyr library was utilized for its mapping functionality to map the activity numeric to its factor equivalent for readability

