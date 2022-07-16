#### Functions

add <- function(x,y){x+y}

add(1,2)


#### In functions, the last expression will be returned

add_and_multiple_v1 <- function(x,y){
  x+y
  x*y
}

add_and_multiple_v1(1,2)

#### You can force R to return a specific object

add_and_multiple_v2 <- function(x,y){
  total <- x+y
  product <- x*y
  total_and_product <- c(total, product)
  return(total_and_product)
}

add_and_multiple_v2(1,2)

#### R has many basic mathematical functions already built in that can be applied to numbers and vectors of numbers

sum(c(2,3,5))

sum(c(1,2), c(2,3))

my_vectors <- c(1:5)
sum(my_vectors)

#### Functions related to descriptive statistics
max(my_vectors)
min(my_vectors)
mean(my_vectors)
median(my_vectors)
sd(my_vectors)
summary(my_vectors)

#### Other functions will sort vectors or tell you information about the vector
sort(my_vectors, decreasing = TRUE)
sort(my_vectors, decreasing = FALSE)
rev(my_vectors) #reverse
table(my_vectors)
unique(my_vectors)
length(my_vectors)

#### create data fast
seq(1,5) # similar to c(1:5)
seq(1,9, by=2)

rep("a", 5) # repeat 'a' five times
rep(10,5) # repeat 10 five times
