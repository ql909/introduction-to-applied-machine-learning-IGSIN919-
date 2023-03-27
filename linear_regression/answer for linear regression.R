library(dplyr) # is used for data manipulation
library(ggplot2) # for visualization
library(caTools) # for train/test split
library(caret)    # for cross-validation, etc.


setwd('/Users/qinyiliu/Downloads/ml course')
df <- read.csv('insurance.csv')
head(df)

# Load libraries
#install.packages("ggplot2")
#install.packages("ggthemes")
#install.packages("psych") 
#please use this if you don't download these packages
library(ggplot2)
library(ggthemes)
library(psych)
install.packages("relaimpo")
library(relaimpo)

# Descriptive Statistics
summary(df)

ggplot(data = df,aes(as.factor(children),charges)) + geom_boxplot(fill = c(2:7)) +
  theme_classic() +  xlab("children") +
  ggtitle("Boxplot of Medical Charges by Number of Children")

# Build a model using variables
library(caret)
set.seed(1560)
ins_model <- lm(charges ~ age + sex + bmi + children + smoker + region, data = df)
summary(ins_model)

#Using 10-fold cross-validation, run a linear regression and show the performance
library(caret)
set.seed(1560)
ctrl <- trainControl(method = "cv", number = 10)
cv.fit <- train(charges~ age + sex + bmi + children + smoker + region,
                data = df,
                preProcess = "range",
                method = "lm",
                metric = "RMSE",
                control = ctrl)
cv.fit$results

#Using 10-fold cross-validation, estimate a lasso regression. Which features survive the lasso. 
#How does it perform relative to the regression you ran previously?
set.seed(1560)
ctrl <- trainControl(method = "cv", number = 10)
grid <- expand.grid(alpha = 1, lambda = seq(0,25,0.1))
lasso.fit <- train(charges~ age + sex + bmi + children + smoker + region,
                   data = df,
                   preProcess = "range",
                   method = "glmnet",
                   metric = "RMSE",
                   control = ctrl,
                   tuneGrid = grid)
lasso.fit$bestTune #251
lasso.fit$results[251,]

library(pls)
set.seed(6180)
pcr.fit <- pcr(charges~ age + sex + bmi + children + smoker + region,
               data = df,
               scale = TRUE,
               validation = "CV",
               segments = 10)
validationplot(pcr.fit)
