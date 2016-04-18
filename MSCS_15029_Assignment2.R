# some required libraries
require(caret)
require(MASS)
library(rpart)
require(e1071)
library(outliers)
library(sampling)
library(e1071)
# Set working directory
getwd();
setwd("~/Desktop/ITU-SPRING-2016/Data Mining/")
# Read train_v2.csv file
if (!exists("csv_data"))
{
  csv_data <- read.csv(file="~/Desktop/ITU-SPRING-2016/Data Mining/train_v2.csv",head=TRUE,sep=",")
}
# i.	Summary of a data
summary(csv_data)
# Fine the best co-relation from the features with respect to the last 'loss' column
loss = csv_data[,ncol(csv_data)]
correlation_matrix = order(cor(loss,csv_data[2:770],use="pairwise.complete.obs"))
# high corelation columns with 'loss' are order on the base of corelation
new_matrix_of_high_corelation <- matrix(1,nrow(csv_data),5)

for (i in 1:ncol(new_matrix_of_high_corelation)){
  new_matrix_of_high_corelation[,i] <- csv_data[,correlation_matrix[i]]
  print(paste0("The column with highest corelation value is : ", correlation_matrix[i]))
}

# new best corelation_matrix with best 5 features
print(new_matrix_of_high_corelation)
print("End of Coorelation Matrix")

# Function to remove outliers
remove_outliers <- function(x, na.rm=TRUE){
  L_limit <- quantile(x, 0.25) - 1.5*IQR(x) # Calculate the lower bound
  U_limit <- quantile(x, 0.75) + 1.5*IQR(x) # Calculate the upper bound
  ind <- x > L_limit & x < U_limit          # Find indices that satisfy the bounds
} # Function in R returns the last calculated value if not pre-specified, so it will
# return indices of instances satisfying the condition.


# # function to remove NA values from the dataset with the means of the features
removeNAvalues <- function(csv_data, env = parent.frame()) {
   # in order to remove the missing values, take the mean of the values and replace with NA value
   for (i in 1:ncol(csv_data)){
     csv_data[is.na(csv_data[,i]),i] <- mean(csv_data[,i], na.rm = TRUE)
     #print(csv_data[,i])
   } 
  }
# 
# calculate total NA columns and if greater than 1000 we will remove for data-preprocessing
columns_to_remove = 1
new_csv = csv_data[,apply(csv_data, 2, function(x){sum(is.na(x))}) > 1500 ]
for(i in 1:ncol(new_csv))
{
  columns_to_remove[i]<-colnames(new_csv)[i]
}
# Remove columns with specific threshold
drops <- c(columns_to_remove)
updated_CSV <- csv_data[,!(names(csv_data) %in% drops)]

removeNAvalues(csv_data) # remove all NA values from the data.
# Find the zero variance columns from the data set
left_unfilter_data <- nearZeroVar(csv_data, freqCut = 95/5, uniqueCut = 10, saveMetrics =TRUE, 
                                  names = FALSE,foreach = FALSE, allowParallel = TRUE)

surplus_data<-left_unfilter_data[left_unfilter_data[,"zeroVar"] > 0, ]
# find the column_names_of the zero variance columns
columns_to_remove_variance = 1
for(i in 1:nrow(surplus_data))
{
  columns_to_remove_variance[i]<-rownames(surplus_data)[i]
}

# Now Remove these columns from Main Data set
drops <- c(columns_to_remove_variance)
updated_CSV <- csv_data[,!(names(csv_data) %in% drops)]

#last remove outliers from the data and clean for processing
for (i in 1: ncol(updated_CSV)){
  if (class(updated_CSV[,i]) %in% c("integer", "numeric")) {
    ind <- remove_outliers(updated_CSV[,i]) # Outliers will be removed for numeric
  }                                      # instances only
  updated_CSV <- updated_CSV[ind,] # Update the data after checking each attribute
}

# naiveBays random predictor on 70% of the data

random_sample<- floor(0.75 * nrow(updated_CSV)) # We get the size of 75% dataset
test_data <- sample(seq_len(nrow(updated_CSV)), size=random_sample) # We get indices of 75% randomly selected instances
# Now we can split data using random_i calculated above
train <- updated_CSV[test_data,]
test <- updated_CSV[-test_data,]
model <- naiveBayes(as.factor(loss)~., data = train,threshold=1)
TestModel = union(predict(model, test), test$loss)
PredictModel = table(factor(predict(model, testData), TestModel), factor(test$loss, TestModel))
confusionMatrix(PredictModel)
original <- test
test$loss = predict(model,test)
sum(original$loss==test$loss)/nrow(test)
# model the data and apply decision tree
decision_tree <- function(df){
  # We create a random sample of 75% instances (to be used as training)
  random_s<- floor(0.75 * nrow(df)) # We get the size of 75% dataset
  random_i <- sample(seq_len(nrow(df)), size=random_s) # We get indices of 75% randomly selected instances
  
  # Now we can split data using random_i calculated above
  train <- df[random_i,]
  test <- df[-random_i,]
  org <- test$Species # We shall extract the class variable from test set and set it to NULL
  test$Species <- NULL
  
  # Learn the model
  model <- rpart(Species~., data=train, method="class")
  prd <- predict(model, newdata = test, type="class")
  print(table(prd, org))
  correct_inst <- prd == org
  return(accuracy <- sum(correct_inst) / nrow(test))
}

# Decision tree before preprocessing

accuracy_before <- decision_tree(csv_data)
print(paste0("Accuracy original = ", accuracy_before))

# Decision tree after preprocessing

accuracy_after <- decision_tree(updated_CSV)
print(paste0("Accuracy pre-processed = ", accuracy_after))

# Before concluding your program, free your memory
rm(list=ls())
