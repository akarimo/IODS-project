#Aasa Karimo
#18.11.2020
#Data wrangling for chapter 5


#read the data

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#structure and dimensions of the two datasets

str(hd)
dim(hd)

str(gii)
dim(gii)

#summaries of the variables

summary(hd)
summary(gii)


#rename the variables with (shorter) descriptive names

colnames(hd) <- c('HDI.Rank', 'country', 'HDI', 'exp_life', 'exp_edu', 'edu_mean', 'GNI', 'GNI-HDI_rank')
colnames(gii) <- c('GII.Rank', 'country', 'GII', 'mat_mor', 'ado_birth', 'rep_parl', 'edu_2_F', 'edu_2_M','lab_F', 'lab_M')


#create two new variables for education and labour force participation ratios

# access the dplyr library
library(dplyr)

gii <- mutate(gii, edu_ratio = edu_2_F/edu_2_M)
gii <- mutate(gii, lab_ratio = lab_F/lab_M)


#join the two datasets

human <- inner_join(hd, gii, by = c("country"))

#check dimensions 

dim(human) 

#saving the joined dataset to the "data" folder

write.csv(human, file.path("~/Desktop/IODS/R project for ODS/IODS-project/data", "human.csv"))
