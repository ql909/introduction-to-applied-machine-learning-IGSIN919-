#1 Download wisc_bc_data from mittuib

#2 load a csv file
wbcd <- read.csv ("wisc_bc_data.csv")

#3 examine the dataset a bit to understand the variables and information inside
str (wbcd)
summary (wbcd)

#4 Remove the id column from your data
wbcd <- wbcd [-1]


#5 count na's
sum(is.na(wbcd))

#6 Check out ‘diagnosis’ feature
table (wbcd$diagnosis)

#7 Change labels of this variable to “Benign” for B and “Malignant” for M.
wbcd$diagnosis <- factor(wbcd$diagnosis, labels= c("Benign", "Maligant"))
 
 # Percentage of M and B
round (prop.table(table(wbcd$diagnosis)) * 100, digits = 1)


#8 summary and normaize function and lapply
summary (wbcd[c("radius_mean", "area_mean", "smoothness_mean")])

#--------#
normalize <- function(x) {
  return((x - min(x)) / (max(x) - min(x)))
}

#--------#
wbcd_n <- lapply(wbcd[2:31], normalize)
wbcd_n <- data.frame (wbcd_n)


#9 Create two datasets (training, and testing)..aka (subsetting)
wbcd_train <- wbcd_n [1:469,]
wbcd_test <- wbcd_n [470:569,]

#10 create the labels of diagnosis 
wbcd_train_labels <- wbcd[1:469, 1]
wbcd_test_labels <- wbcd[470:569, 1]

#11 install the class library
install.packages("class")
library(class)


#12 runn the knn
wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test, cl= wbcd_train_labels, k= 15)

#13 install gmodels and run crosstable
install.packages("gmodels")
library(gmodels)

CrossTable(x=wbcd_test_labels, y= wbcd_test_pred, prop.chisq = FALSE)
