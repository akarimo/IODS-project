# Aasa Karimo
# 2.12.2020
# data wrangling for chapter 6


library(tidyverse)

#readin data

BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep = " ", header = TRUE )
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep = "\t", header = TRUE)

#checking structure and dimensions of the data

str(BPRS)
dim(BPRS)

#with a closer look it seems that the data has only 20 numbers for subjects, so let's change that
BPRS$subject <- factor(1:40)

str(RATS)
dim(RATS)

#summaries of variables

summary(BPRS)
summary(RATS)

#Convert the categorical variables of both data sets to factors

BPRS$treatment <- as.factor(BPRS$treatment)
BPRS$subject <- as.factor(BPRS$subject)

RATS$ID <- as.factor(RATS$ID)
RATS$Group <- as.factor(RATS$Group)

#Convert the data sets to long form and add a week variable to BPRS and a Time variable to RATS

BPRSL <- gather(BPRS, key = weeks, value = bprs_score, -treatment, - subject) %>% mutate(week = as.integer(substr(weeks, 5,5)))

RATSL <- gather(RATS, key = WD, value = Weight, -ID, -Group) %>% mutate(Time = as.integer(substr(WD, 3,4)))

#take a look at the data and compare to wide version

glimpse(BPRS)
glimpse(BPRSL)
#the long data has a separate row for each observation (week)


glimpse(RATS)
glimpse(RATSL)
#the long data has a separate row for each observation (WD/Time)

#save the data both on wide and long form

#wide form
write.csv(BPRS, file.path("~/Desktop/IODS/R project for ODS/IODS-project/data", "BPRS.csv"))
write.csv(RATS, file.path("~/Desktop/IODS/R project for ODS/IODS-project/data", "RATS.csv"))

#long form
write.csv(BPRSL, file.path("~/Desktop/IODS/R project for ODS/IODS-project/data", "BPRSL.csv"))
write.csv(RATSL, file.path("~/Desktop/IODS/R project for ODS/IODS-project/data", "RATSL.csv"))
