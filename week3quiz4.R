options(warn=-1)

#load South Africa Heart Disease Data
library(ElemStatLearn)
data(SAheart)
set.seed(8484)

#create training and test sets
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]

set.seed(13234)

#trainSA$chd <- factor(trainSA$chd)
#testSA$chd <- factor(testSA$chd)

columns <- c("chd","age","alcohol","obesity","tobacco","typea","ldl")
trainSAsubset <- subset(trainSA, select=columns)
testSAsubset <- subset(testSA, select=columns)

modfit <- train(chd~.,data=trainSAsubset, method="glm", family="binomial")

missClass = function(values,prediction){sum(((prediction > 0.5)*1) != values)/length(values)}

predictionTrain <- predict(modfit,newdata = trainSAsubset)
predictionTest <- predict(modfit,newdata = testSAsubset)

print ("test:") 
print(missClass(values=testSAsubset$chd, prediction = predictionTest)) 

print ("train:") 
print(missClass(values=trainSAsubset$chd, prediction = predictionTrain))

options(warn=0)
