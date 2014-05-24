##
##  This script is used to deal with human activity data set. 
##

train_file_set <- c(
	'train/subject_train.txt',
	'train/y_train.txt',
	'train/X_train.txt',
	'train/Inertial Signals/total_acc_x_train.txt',
	'train/Inertial Signals/total_acc_y_train.txt',
	'train/Inertial Signals/total_acc_z_train.txt',
	'train/Inertial Signals/body_acc_x_train.txt',
	'train/Inertial Signals/body_acc_y_train.txt',
	'train/Inertial Signals/body_acc_z_train.txt',
	'train/Inertial Signals/body_gyro_x_train.txt',
	'train/Inertial Signals/body_gyro_y_train.txt',
	'train/Inertial Signals/body_gyro_z_train.txt'
);


test_file_set <- c(
	'test/subject_test.txt',
	'test/y_test.txt',
	'test/X_test.txt',
	'test/Inertial Signals/total_acc_x_test.txt',
	'test/Inertial Signals/total_acc_y_test.txt',
	'test/Inertial Signals/total_acc_z_test.txt',
	'test/Inertial Signals/body_acc_x_test.txt',
	'test/Inertial Signals/body_acc_y_test.txt',
	'test/Inertial Signals/body_acc_z_test.txt',
	'test/Inertial Signals/body_gyro_x_test.txt',
	'test/Inertial Signals/body_gyro_y_test.txt',
	'test/Inertial Signals/body_gyro_z_test.txt'
);


feature_names <- gsub('^.*? ','',readLines('features.txt'));
inertial_names <- c('total_acc_x_v','total_acc_y_v','total_acc_z_v',
						'body_acc_x_v','body_acc_y_v','body_acc_z_v',
						'body_gyro_x_v','body_gyro_y_v','body_gyro_z_v');


var_names <- c('subject', 'activity', feature_names,
				paste(rep(inertial_names,each=128),1:128,sep=''));

activity_labels <- c('WALKING','WALKING_UPSTAIRS','WALKING_DOWNSTAIRS','SITTING','STANDING','LAYING');



read_data <- function(f_set)
{
	n <- length(f_set);
	mm_list <- list(n);
	for(i in 1:n)
	{
		cat('+ ',f_set[i],'\n');
		flush.console();
		mm_list[[i]] <- read.table(f_set[i],header = F);
		
		
	}
	do.call(cbind,mm_list)
}



mm_train <- read_data(train_file_set);
mm_test <- read_data(test_file_set);
mm <- rbind(mm_train,mm_test);
colnames(mm) <- var_names;

mm_ext <- mm[,c(1,2,grep('(mean|std)',names(mm)))];
mm_ext$activity <- factor(mm_ext$activity, labels = activity_labels);
mm_tidy <- aggregate(.~subject+activity , data = mm_ext,mean);

write.csv(mm_tidy,'mm_tidy.txt',row.names=F);









