#Aasa Karimo
#12.11.2020
#data wrangling exercise: data from UCI Machine Learning Repository


#read the data

student_mat <- read.csv("~/Desktop/IODS/R project for ODS/IODS-project/data/student-mat.csv", sep = ";")
student_por <- read.csv("~/Desktop/IODS/R project for ODS/IODS-project/data/student-por.csv", sep = ";")

#exploring the structure and dimensions of the data

str(student_mat)
dim(student_mat)

str(student_por)
dim(student_por)

#joining the two datasets

# access the dplyr library
library(dplyr)

# common columns to use as identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

# join the two datasets by the selected identifiers
math_por <- inner_join(student_mat, student_por, by = join_by, suffix = c(".mat", ".por"))

#exploring the structure and dimensions of the joined dataset

str(math_por)
dim(math_por)


# create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# columns that were not used for joining the data
notjoined_columns <- colnames(student_mat)[!colnames(student_mat) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column  vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}


# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

#take a glimpse of the joined dataset
glimpse(alc)

#saving the joined dataset to the "data" folder

write.csv(alc, file.path("~/Desktop/IODS/R project for ODS/IODS-project/data", "alc.csv"))
