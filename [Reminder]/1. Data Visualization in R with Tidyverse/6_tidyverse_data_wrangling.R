### Data Wrangling with the tidyverse

# Tidyverse is a set of R packages that include many different commands for managing data and making visualization from the data.

# A popular dataset to work with is mtcars
data(mtcars)
head(mtcars)

# 0. Install the tidyverse if you don't have it installed. You only need to do this once.
install.packages("tidyverse")

# 1. Load the tidyverse library
# Do this everytime you want to use tidyverse commands
library(tidyverse)

# 2. Load the dataset (user read_csv instead of read.csv)
# read_csv() will produce a tibble instead of a dataframe.
# A tible is a specialized version of a dataframe that works well with the tidyverse

cces <- read_csv('cces_sample_coursera.csv') 
cces # It will show the first 10 rows
class(cces)
vignette("tibble")

# If you need to switch back and forth between tibble and dataframe for some reason:
cces_dataframe <- as.data.frame(cces)
cces_tibble <- as_tibble(cces_dataframe)

# 3. Drop rows with missing data
cces <- drop_na(cces)

# 4. Use the filter function
women <- filter(cces, gender == 2)

