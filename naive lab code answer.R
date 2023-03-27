setwd('/Users/qinyiliu/Downloads/ml course')

df<-read.csv("diabetes.csv")

library(e1071) 
library(caTools) 
library(caret)  
install.packages('caretEnsemble')
library(caretEnsemble)
#install.packages('psych')
library(psych)
install.packages('Amelia')
library(Amelia)
install.packages('mice')
library(mice)
install.packages('GGally')
library(GGally)
install.packages('rpart')
library(rpart)
head(df)

df$Outcome<-factor(df$Outcome, labels = c("health", "ill"))

str(df)

#Convert '0' values into NA
df[, 2:7][df[, 2:7] == 0] <- NA

#visualize the missing data
library(Amelia)
missmap(df)

#Data Visualization
#Visual 1
library(ggplot2)
ggplot(df, aes(Age, colour = Outcome)) +
  geom_freqpoly(binwidth = 1) + labs(title="Age Distribution by Outcome")

#visual 2
c <- ggplot(df, aes(x=Pregnancies, fill=Outcome, color=Outcome)) +
  geom_histogram(binwidth = 1) + labs(title="Pregnancy Distribution by Outcome")
c + theme_bw()

#Building a model
#split data into training and test data sets
set.seed(7)
indxTrain <- createDataPartition(y = df$Outcome,p = 0.75,list = FALSE)
training <- df[indxTrain,]
testing <- df[-indxTrain,]

#create objects x which holds the predictor variables and y which holds the response variables
x = training[,-9]
y = training$Outcome

library(e1071)  #oad the e1071 package that holds the Naive Bayes function

model = train(x,y,'nb',trControl=trainControl(method='cv',number=10))
model

