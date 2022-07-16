#### Importing data in R

# 1. Import CSV
df <- read.csv('cces_sample_coursera.csv')
head(df)
View(df)

# 2. Write CSV
write.csv(df, 'test.csv')

# type in you r directory path in setwd() or use the Session -> Set Working Directory menu options

working_dir <- getwd() # find the working directory to get the exact file path

setwd(working_dir)

# Note: you only can have one working directory at a time