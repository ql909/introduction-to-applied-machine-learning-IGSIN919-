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
ins_model <- lm(charges ~ age + sex + bmi + children + smoker + region, data = df)
summary(ins_model)

#Using 10-fold cross-validation, run a linear regression and show the performance
library(caret)
set.seed(1560)
