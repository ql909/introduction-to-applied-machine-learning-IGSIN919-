# first step
install.packages("e1071") 
install.packages("caTools") 
install.packages("caret") 
library(e1071) 
library(caTools) 
library(caret)  

# second step
data <- iris         # use the iris dataset 
head(data)           # head() returns the top 6 rows of the dataframe 
summary(data)       # returns the statistical summary of the data columns 
dim(data)            # returns number of rows and columns in the dataset 

# third step
iris$SL.d <- ifelse(iris$Sepal.Length>median(iris$Sepal.Length), 1, 0)
iris$SW.d <- ifelse(iris$Sepal.Width>median(iris$Sepal.Width), 1, 0)
iris$PL.d <- ifelse(iris$Petal.Length>median(iris$Petal.Length), 1, 0)
iris$PW.d <- ifelse(iris$Petal.Width>median(iris$Petal.Width), 1, 0)
iris$SL.d <- factor(iris$SL.d, labels = c("Small", "Large")) 
iris$SW.d <- factor(iris$SW.d, labels = c("Small", "Large")) 
iris$PL.d <- factor(iris$PL.d, labels = c("Small", "Large")) 
iris$PW.d <- factor(iris$PW.d, labels = c("Small", "Large"))
summary(iris)

# third step continues
idx <- createDataPartition(iris$Species, p = 0.8, list = FALSE)
d.Train <- iris[idx, 5:9]
d.Test <- iris[-idx, 5:9]

set.seed(1)
naive.fit1 <- naiveBayes(Species~., data = d.Train)
naive.fit1

# Predicting on test data 
mytable <- table(predict(naive.fit1, newdata = d.Test), d.Test$Species)
mytable

accuracy <- 100*sum(diag(mytable))/nrow(d.Test) 
accuracy

# 10-fold cv
install.packages("klaR")
library(klaR)
library(caret)
x = iris[,-5]
y = iris$Species
model = train(x,y,'nb',trControl=trainControl(method='cv',number=10))

model

predict(model$finalModel,x)

table(predict(model$finalModel,x)$class,y)

summary(iris$Species)


