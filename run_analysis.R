# Read in train tables:
xtrain = read.table("train/X_train.txt")
ytrain = read.table("train/y_train.txt")
subjecttrain = read.table("train/subject_train.txt")

# Read in test tables:
xtest = read.table("test/X_test.txt")
ytest = read.table("test/y_test.txt")
subjecttest = read.table("test/subject_test.txt")

# Read in feature vector:
features = read.table('features.txt')

# Read in activity labels:
activityLabels = read.table('activity_labels.txt')

# Col Names
colnames(xtrain) = features[,2] 
colnames(ytrain) = "activityId"
colnames(subjecttrain) = "subjectId"
colnames(xtest) = features[,2] 
colnames(ytest) = "activityId"
colnames(subjecttest) = "subjectId"
colnames(activityLabels) = c('activityId','activityType')

# combine data frames
train = cbind(ytrain, subjecttrain, xtrain)
test = cbind(ytest, subjecttest, xtest)
testtrain = rbind(train, test)

# subsets
TidyAct <- aggregate(.~testtrain$activityId, testtrain, mean)
TidySub <- aggregate(.~testtrain$subjectId, testtrain, mean)

#remove first columns of TidySub & TidyAct
TidySub = TidySub[,-c(1:2)]
TidyAct = TidyAct[,-c(1,3)]

#Rename category columns
names(TidySub)[1] <- "Sub/Act"
names(TidyAct)[1] <- "Sub/Act"

#Make 1st column a factor for TidyAct
TidyAct$'Sub/Act'= activityLabels[,2] 

#Combine rows
Tidy = rbind(TidyAct, TidySub)

#write data table
write.table(Tidy, file = "TidyData.txt")
