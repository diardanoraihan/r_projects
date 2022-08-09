# Building an "Ipsum-App"

Reference: https://engineering-shiny.org/building-ispum-app.html

## 1.1. Fast UI Prototyping with `{shinipsum}`

Ever heard about the famous "lorem ipsum"? Yes, the fake text generator to be used as a placeholder for text is now coming to shiny with the same idea: __generating placeholders for shiny outputs__.

Note: visit [this](https://engineering-shiny.org/shinipsum/) or [this](https://engineering-shiny.org/golemhtmltemplate/) - both applications will look different everytime you open them!

### 1.1.1. Installation

```
install.packages("shinipsum")
```

`shinipsum` contains a series of functions that generates random placeholders. I.e. __`random_ggplot()`__ generates random __ggplot2__ elements. 

```
library(shinipsum)
libary(ggplot2)

random_ggplot() +
  labs(title = "Random Plot")
```

### 1.1.2. Common Functions

- Data Table Output: `random_DT()` <------> `DTOutput()`
- Plot Output: `random_ggplot()` <------> `plotOutput()`
- Text Output: `random_text()` <------> `textOutput()`
- Tables Output: `random_table()` <------> `tableOutput()`
- Print Output: `random_print()` <------> `printOutput()`
- Image Output: `random_image()` <------> `plotOutput()`  
- Etc
