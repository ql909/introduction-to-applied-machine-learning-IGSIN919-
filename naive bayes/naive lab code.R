#set your local path

#import your dataset

# import the packages

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

#expore the dataset

# Transform the variable “Outcome” to a factor and give it two levels called “health” and “ill”

# Transform all the ‘0’ values from 2nd columns to 7th columns to NA 

