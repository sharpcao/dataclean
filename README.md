dataclean
=========

explain
---------

* train_file_set,test_file_set are the set of data files of tain and test to read.
* var_names is a vector of  all variables' names.
* read_data(f_set) function take a file set parameter to read all data, using cbind to merge columns .  


steps
------
1. Read train, test data to mm_tain, mm_test
2. Use rbind merge mm_tain, mm_test to mm
3. Set variable  names
4. Find out  all mean & std variables, together with subject and activity
5. Labels the data set with activity names
6. Using aggregate function to get the mean for each subject and each activity
7. Ouput mm_tidy.txt