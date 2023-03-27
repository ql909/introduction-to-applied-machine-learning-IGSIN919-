install.packages("ISwR")
library(ISwR)
?juul
df_new<-subset(juul, sex==1, c(age, igf1)) 
summary(df_new)