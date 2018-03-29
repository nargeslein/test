#remove existing variables
rm(list = ls())

#load libraries
library(caret)
library(mlbench)
library(parallel)
library(doParallel)
library(lubridate)
library(dplyr)

#create cluster for parallel processing
cluster <- makeCluster(detectCores() - 1) # convention to leave 1 core for OS
registerDoParallel(cluster)

#change training control in order to allow parallel processing
fitControl <- trainControl(method = "cv",
                           number = 5,
                           allowParallel = TRUE)



trainingURL <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
testingURL <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"

trainingfile <- "pml-training.csv"
testingfile <- "pml-testing.csv"

setwd("C:/Users/hosseinn/Documents/Training/Data Science/Practical Machine Learning")

if(!file.exists(trainingfile))
  download.file(trainingURL, destfile = file.path(getwd(),trainingfile))

if(!file.exists(testingfile))
  download.file(testingURL, destfile = file.path(getwd(),testingfile))

#read csv files
trainingData <- read.csv(trainingfile)
testingData <- read.csv(testingfile)

#remove 7 first columns 
testing <- testingData[,-(1:7)]
training <- trainingData[,-(1:7)]

#remove NA colums from testing and training
colNA <- colSums(is.na(testing)) == nrow(testing)
colNamesNA <- colnames(testing[,names(which(colNA))])
testing <- testing[,!names(testing) %in% colNamesNA]
training <- training[,!names(training) %in% colNamesNA]

#remove incomplete cases and columns with zero variance
#training <- training[,-c(nearZeroVar(training))]
#training <- training[complete.cases(training),]


#split the training data into a training and a validation set
inTrain <- createDataPartition(y=training$classe, p=0.7, list=FALSE)

training <- training[inTrain,]
validation <- training[-inTrain,]


#fit rf model
start <- now()
print ("Starting at"); print(start)

modelrf <- train(classe~., method="rf", data=training, trControl=fitControl)
end<- now()
print("ending at");print(end)
execution <- end-start
print("model fitting took");print(execution)

validation_pred <- predict(modelrf, validation)
print(confusionMatrix(validation$classe,validation_pred))

test_pred <- predict(modelrf, testing[,-60])
print(data.frame(test_pred))


stopCluster(cluster)
registerDoSEQ()







