#Aasa Karimo
#18.11.2020 and 26.11.2020
#Data wrangling for chapter 5
#Working with "human" data, more info on data here https://raw.githubusercontent.com/TuomoNieminen/Helsinki-Open-Data-Science/master/datasets/human_meta.txt

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

####### work continues 26.11.2020

#the dataset used is the "human" data that combines the “Human development” and “Gender inequality” datas

#transform GNI to numeric
# access the stringr package
library(stringr)

# remove the commas from GNI and replace it with a numeric version
human$GNI <- str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric

#exclude unneeded variables
keep <- c('country', 'edu_ratio', 'lab_ratio', 'exp_edu', 'exp_life', 'GNI', 'mat_mor', 'ado_birth', 'rep_parl')
human <- select(human, one_of(keep))

#remove rows with missing values
human <- filter(human, complete.cases(human))

#Remove the observations which relate to regions instead of countries

# look at the last 10 observations of human
tail(human, n = 10L)

# define the last indice we want to keep
last <- nrow(human) - 7

# choose everything until the last 7 observations
human <- human[1:last, ]

# add countries as rownames
rownames(human) <- human$country

#remove variable country
human <- select(human, -country)

dim(human)

#save the data with row names
write.csv(human, file.path("~/Desktop/IODS/R project for ODS/IODS-project/data", "human.csv"), row.names=TRUE)

