options(warn=-1)
#load olive oil data 
library(pgmm)
data(olive)
olive = olive[,-1]

library(caret)
modfit <- train(Area~.,method="rpart", data=olive)

newdata = as.data.frame(t(colMeans(olive)))

print(predict(modfit, newdata=newdata))

options(warn=0)

