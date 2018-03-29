options(warn=-1)
library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)

trainData <- segmentationOriginal[segmentationOriginal$Case=="Train",-c(1,2)]
testData <- segmentationOriginal[segmentationOriginal$Case=="Test",c(-1,-2)]
set.seed(125)

library(caret)
modfit <- train(Class~.,method="rpart", data=trainData)

library(plyr)
a <- testData[0,]
a <- rbind.fill(a, data.frame(TotalIntenCh2=23000, FiberWidthCh1=10,PerimCh1=2))

b <- testData[0,]
b <- rbind.fill(b,data.frame(TotalIntenCh2=50000, FiberWidthCh1=10, VarIntenCh4 =100))

c <- testData[0,]
c <- rbind.fill(c, data.frame(TotalIntenCh2=57000, FiberWidthCh1=8, VarIntenCh4 =100))

d <- testData[0,]
d <- rbind.fill(d,data.frame(PerimStatusCh1=2 , FiberWidthCh1=8 ,VarIntenCh4 =100))

print(predict(modfit,newdata=a))
print(predict(modfit,newdata=b))
print(predict(modfit,newdata=c))
print(predict(modfit,newdata=d))
#sapply(c(a,b,c,d), function(x) {print(predict(modfit,x))})
plot(modfit$finalModel, uniform=TRUE)
text(modfit$finalModel)
print(modfit$finalModel)


options(warn=0)