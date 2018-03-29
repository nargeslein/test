library(ElemStatLearn)
data(vowel.train)
data(vowel.test)
#set the y variable to be a factor variable
vowel.train$y <- factor(vowel.train$y)
vowel.train$y <- factor(vowel.train$y)

#set seed
set.seed(33833)
library(randomForest)
library(caret)

variables <- varImp(randomForest(y~., data=vowel.train))