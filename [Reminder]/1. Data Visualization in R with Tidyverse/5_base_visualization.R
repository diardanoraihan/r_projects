#### We will cover basic visualization plot such as: 
#### - Univariate plot: plots the distribution of values of a single variables (or a single vector in R)
#### - Multivariate plot: plots values of two or more variables in relation to each other.

# Dummy Data
numbers1 <- c(1,1,1,2,2,3,3,3,4,4,4,4,5,5,5,5,6,6,6)
numbers2 <- c(5,5,5,5,5,6,6,6,7,7,7,8,8,8,9,9,9)

# A. Univariate Statistics
# 1. Histogram
hist(numbers1)

# 2. Boxplot
# http://www.cookbook-r.com/Graphs/Box_plot/ 
boxplot(numbers1)
median(numbers1)

boxplot(numbers1, numbers2)

# B. Multivariate Statistics

# some built-in functions to generate fake data
# -> rnorm - normal distribution
# -> rpois - poisson
# -> rbinom - binomial
# -> runif - uniform

variable1 <- runif(n = 50, min = 0, max = 100)
variable2 <- runif(n = 50, min = 0, max = 100)
my_data <- data.frame(variable1, variable2)

# 1. Scatter Plot
# http://www.cookbook-r.com/Graphs/Scatterplot/  
plot(variable1, variable2)
plot(x = my_data$variable1, y = my_data$variable2)

# base R has some limited graphics customization ability
plot(x = my_data$variable1, 
     y = my_data$variable2, 
     main = "My First Plot", 
     xlab = "Variable 1", # x axis label
     ylab = "Variable 2", 
     ylim = c(0,150), xlim = c(0, 150)) # set the length of the x and y axes

# 2. Density Plot
# http://www.cookbook-r.com/Graphs/Histogram_and_density_plot/
  
   
  

