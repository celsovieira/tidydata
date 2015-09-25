The script merges the Data of Measurements for Trainning with the respective Activities and Subjects
Then it merges the Data of Measurements for Testing with the respective Activities and Subjects
After that, it merges Trainning and Testing in a Dataset and uses Features to get the Labels of the Measurements

For the next step it selects only the Measurements whose labels contain Mean or Std
and make a Dataset out of it
Then descriptive names are added to the Activities and to the Measurements

Finally, the script creates a Dataset with the averages of each Measurement grouped by the subject and activity
