#2
library (tidyverse)
library (stats)
library(factoextra)

#3
getwd()

#4
college <-read_csv("college.csv", col_types = 'nccfffffnnnnnnnnn')

#5
glimpse (college)

#6
maryland_college <- college %>%
  filter(state == "MD") %>%
  column_to_rownames(var = "name")

#7
maryland_college %>%
  select (admission_rate, sat_avg) %>%
  summary()


#8
maryland_college_scaled <- maryland_college %>%
  select (admission_rate, sat_avg) %>%
  scale()


#9
summary(maryland_college_scaled)

#10
fviz_nbclust(maryland_college_scaled, kmeans, method="wss")

#11
fviz_nbclust(maryland_college_scaled, kmeans, method="silhouette")

#12
set.seed(1234)

#13
k_means <-  kmeans(maryland_college_scaled, centers=4, nstart = 25)

#14
fviz_cluster(k_means, data=maryland_college_scaled, repel = TRUE)

#15
maryland_college %>%
  mutate(cluster = k_means$cluster) %>%
  select(cluster,
         undergrads,
         tuition,
         faculty_salary_avg,
         admission_rate,
         sat_avg) %>%
  group_by(cluster) %>%
  summarise_all("mean")

