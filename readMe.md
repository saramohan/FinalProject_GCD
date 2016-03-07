
# Introduction

The script run_Analysis.R performs the steps described in the course project's.

* First, the training dataset(x,y,subject) and the test dataset(x,y,subject) are read and stored in separate variables.
* The training Dataset and test Dataset are merged using the rbind() function. For example the x_data of training dataset and x_data of test dataset are merged using rbind().
* The Features dataset is read and stored in a variable. From this dataset the features whose name contains the words mean() and std() are selected using the grep command.
* The Features subset is a vector of row numbers containing mean() and std().
* Based on the subset vector obtained , the columns with the mean and standard deviation measures are taken from the merged x_data.
* The columns extracted are given the correct name taken from the features dataset.
* We take the activity names and IDs from activity_labels.txt and they are substituted in the y-dataset.
* Finally, a new dataset is generated with all the average measures for each subject and activity type. 
* The output dataset is stored in the file final_average_data.txt.

