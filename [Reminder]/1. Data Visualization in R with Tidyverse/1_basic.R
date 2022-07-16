# This is commented code

# R can also act do logical tests using logical operators

#### Is equal?
2 == 2
2 == 3

#### Is not equal?
2!=2
2!=3

#### Greater than or equal to, less than or equal to
3>=1
3<=1

#### R can work with character strings
"apple"

#### It is okay to use spaces in character strings
"an apple"

#### You can use logical operators to see whether character strings exactly
#### match each other
"apple" == 'apple'
"apple" != "appla"

#### If you try to use inequalities with charactes, R will coompare how long 
#### the character string is
"apple" < "apples"
"apple" > "apples"

#### save the ourput of a command to an object
a <- 2+2
my_a <- 2+2

#### This will output error
my.a <- 2_2

#### You can save series of numbers or strings and put them into vectors using
#### combine function, c()

numbers <- c(1,2,3)
numbers
fruits <- c("apple", "banana")
fruits
numbers2 <- c(4:6) # put the range of numbers from minimum to maximum
numbers2

true_false <- c(T,F,T) # the same as true_false <- c(TRUE, FALSE, TRUE)
true_false

#### You can combine vectors together

numbers3 <- c(7:9)
numbers3

all_numbers <- c(numbers, numbers2, numbers3)
all_numbers

#### You can select certain elements of a vector
x <- c(-1, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19)

### By position in the vector
x[4] #The fourth element
x[-4] #All but the fourth
x[2:4] #Elements two to four
x[-(2:4)] #All elements except two to four
x[c(1,5)] #Elements 1 and 5

### By value
x[x == 10] #Elements which are equal to 10
x[x < 0] #All elements less than zero
x[x %in% c(10, 12, 15)] #elements in the set 2, 4, 7

#### When you save different kinds of data, that data is given a "class" that 
#### describes what kind of data are in the vector

class(numbers) #numeric
class(fruits) #character
class(true_false) #logical

#### If you combine numbers and character vectors together, the number will convert to characters

fruits_numbers = c(numbers, fruits)
fruits_numbers

#### Generally for data visualization purposes, it is good to not mix characters and numbers in the same vector

#### You can change the class of a vector using as.logical, as.numeric, as.character, and as.factor

### Here's an example with 1s and 0s

my_vector <- c(1, 0, 1, 0)
my_vector

my_vector_character <- as.character(my_vector)
my_vector_character
class(my_vector_character)

my_vector_logical <- as.logical(my_vector)
my_vector_logical

my_vector_factor <- as.factor(my_vector) # 
my_vector_factor
class(my_vector_factor)

my_vector_numeric_again <- as.numeric(my_vector_character)
my_vector_numeric_again





