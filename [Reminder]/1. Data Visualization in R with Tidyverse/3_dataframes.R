#### Dataframes: data tables (spreadsheets) stored in the R environment

### Creating a dataframes

col1 <- c(1,2,3,4,5)
col2 <- c(6,7,8,9,10)

data.frame(col1, col2)

my_data <- data.frame("height"= col1, "weight" = col2)

class(my_data)

### get a single column of a dataframe using a dollar sign (similar to my_data[weight] in Python)
my_data$weight

### use a column in a function
mean(my_data$height)

### save a column to another object
my_heights <- my_data$weight
my_heights

#### Selecting data from dataframes

### remember you specify row, then column in the brackets

## first row, all columns
my_data[1,]

## first column, all rows
my_data[,1]

## first column, first three rows
my_data[1:3, 1]

#### Creating new columns

### single value repeated
my_data$col3 <- 100
my_data

## add vector with same length
my_data$fruits <- c("apple", "orange", "grape", "cherry", "melon")
my_data

## this won't work because the vector is too short - needs to be the same length as other vectors/columns in the dataframe
my_data$fruits <- c("apple", "orange")

#### Get the dimensions of a dataframe (rows and columns)
dim(my_data)

#### get more informaiton about the structure of a data frame
nrow(my_data)
ncol(my_data)
str(my_data)

#### get the column names of the data frame
names(my_data)

#### if you have a big dataframes, use head() or tail() to see the first or last few rows
head(my_data)
tail(my_data)

#### spreadsheet view
View(my_data)

#### Missing data causes lots of problems. Some functions "break" and throw errors if you include missing data
with_missing <- c(1,2,3, NA)
sum(with_missing)

#### You should look at the documentation for a function to understand how it handles missing data. Sometimes, you can use an argument with a function to tell it how to deal with the missing data, often telling the function to ignore the missing cells.

?sum # see the documentation for sum function

sum(with_missing, na.rm = TRUE)

#### Combining two data frames with cbind (column combination)

my_data2 <- data.frame('col5' = 400:499, 'col6'= 500:599)

all_data <- cbind(my_data, my_data2)

head(all_data)

#### combining two data frames with rbind (row combination)
#### make sure the two dataframes have the same column names and order

#### adding a row
new_row <- c(1000, 2000, 3000, 4000, 5000, 6000)

all_dat_plus_new_row <- rbind(all_data, new_row)

tail(all_dat_plus_new_row)





