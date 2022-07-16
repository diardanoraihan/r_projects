### Data Wrangling with the tidyverse

# Tidyverse is a set of R packages that include many different commands for managing data and making visualization from the data.

library(tidyverse)

cces <- read_csv('cces_sample_coursera.csv')

dim(cces)

# 1. Select only women respondents (use filter function)
women <- filter(cces, gender == 2)
# note: remember the other logical operators
# >
# <
# <=
# >=
# &
# | 
# %in%

# compare the difference in dimension
dim(cces)
dim(women)
# calculate the frequencies of unique values
table(cces$gender)

# 2. Select only republican women
republican_women <- filter(cces, gender == 2 & pid7>4)
dim(republican_women)
table(republican_women$pid7)

# 3. Select certain columns from the data
select(republican_women, "educ", "employ")

# 4. Combine multiple commands using piping

# x %>% f(y) is the same as f(x,y)
# y %>% f(x, ., z) is the same as f(x, y, z) (notice the dot . in the function get replaced by y)

women_republican_educ_employ <- cces %>% filter(gender == 2 & pid7>4) %>% select("educ", "employ")

# 5. Recode variables
# This is a technique to convert the categorical variable in numeric to strings (more readable)
party <- recode(cces$pid7, '1' = "Democrat", '2' = 'Democrat', '3' = 'Democrat', '4' = 'Independent', '5' = 'Republican', '6' = 'Republican', '7' = 'Republican')

cces$party <- party

# 6. Rename variables

test <- rename(cces, trump_approval = CC18_308a)

cces <- test

# 7. Calculate the new numeric variables

rec_sen1_01 <- recode(cces$CC18_310b, '1' = 0, '5' = 0, '2' = 1, '3' = 1, '4' = 1)
rec_sen2_01 <- recode(cces$CC18_310c, '1' = 0, '5' = 0, '2' = 1, '3' = 1, '4' = 1)

# we can use mutate function to add the values of those columns together
# note: know_sens means knowing senators
cces <- mutate(cces, know_sens = rec_sen1_01 + rec_sen2_01)

# 8. Reorder rows by column values
# arrange is a fancy version of sort in base R
sorted_by_gender_and_party <- cces %>% arrange(gender, pid7)
View(sorted_by_gender_and_party)

sorted_by_gender_and_party <- cces %>% arrange(gender, desc(pid7)) # in descending order of pid7 values
View(sorted_by_gender_and_party)

# 9. Add grouping to the data
grouped_gender_pid7 <- cces %>% group_by(gender, pid7)
grouped_gender_pid7

# remove grouping with ungroup
# ungroup(grouped_gender_pid7)
# note: group_by() is not pretty useful unless we combine it with other R function in tidyverse

# 10. Summarize the data
?summarize
summarize(cces, mean_pid7 = mean(pid7), mean_faminc = mean(faminc_new))
# the same as:
cces %>% summarize(mean_pid7 = mean(pid7), mean_faminc = mean(faminc_new))

# 10.a. Summarize the data by group
grouped_gender <- cces %>% 
  group_by(gender) %>% 
  summarize(mean_pid7 = mean(pid7), mean_faminc = mean(faminc_new))

grouped_gender