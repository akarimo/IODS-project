#Aasa Karimo
#4.11.2020
#data wrangling exercise

#reading the data

learning2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

#exploring the structure and dimensions of the data

str(learning2014)
dim(learning2014)

####creating dataset for analysis

# Access the dplyr library
library(dplyr)

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(learning2014, one_of(deep_questions))
learning2014$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(learning2014, one_of(surface_questions))
learning2014$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(learning2014, one_of(strategic_questions))
learning2014$stra <- rowMeans(strategic_columns)

#averaging Attitude

learning2014$attitude <- learning2014$Attitude / 10

# choose a handful of columns to keep
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")

# select the 'keep_columns' to create a new dataset
learning2014 <- select(learning2014, one_of(keep_columns))


# select rows where points is greater than zero
learning2014 <- filter(learning2014, Points > 0)

#checking the dimensions of the dataset

dim(learning2014)

#setting working directory

setwd("~/Desktop/IODS/R project for ODS/IODS-project")

#saving the analysis dataset to the "data" folder

write.csv(learning2014, file.path("~/Desktop/IODS/R project for ODS/IODS-project/data", "learning2014.csv"), row.names = T)

#reading the data again

learning2014_double <- read.csv("~/Desktop/IODS/R project for ODS/IODS-project/data/learning2014.csv", row.names = 1)

#checking the structure and dimensions of the newly read dataset

str(learning2014_double)
dim(learning2014_double)

#seems ok!
