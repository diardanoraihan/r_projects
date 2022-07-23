library(tidyverse)
library(shiny)
library(DT)

# Create a dummy dataset
cities=c("Bandung","Jakarta","Surabaya")

city1 <- tibble("city"=rep(cities[1],5),
                "year"=seq(from=1990,to=1994,by=1),
                #"unit"=letters[1:5],
                "var1"=runif(5,0,5),
                "var2"=runif(5,0,5),
                "var3"=runif(5,0,5))
city2 <- tibble("city"=rep(cities[2],5),
                "year"=seq(from=1990,to=1994,by=1),
                #"unit"=letters[1:5],
                "var1"=runif(5,0,5),
                "var2"=runif(5,0,5),
                "var3"=runif(5,0,5))
city3 <- tibble("city"=rep(cities[3],5),
                "year"=seq(from=1990,to=1994,by=1),
                #"unit"=letters[1:5],
                "var1"=runif(5,0,5),
                "var2"=runif(5,0,5),
                "var3"=runif(5,0,5))

df <- bind_rows(city1,city2,city3)
data(iris)
# define ui
ui <- fluidPage(
  
  titlePanel(h1("Performance of Cities", align = "center")), 
  
  br(),
  
  fluidRow(
    column(
      4, 
      selectInput(
        inputId = "city1", 
        label = "Pick Cities here:",
        choices = cities,
        multiple = TRUE
      )
    )
  ),
  
  fluidRow(
    column(
      4, 
      offset = 4, 
      wellPanel(
        dataTableOutput(outputId = "table1")
      )
    )
  )
)

# define server func
server <- function(input, output){
  
  output$table1 <- renderDataTable({
    
    if (is.null(input$city1)){
      cities_to_filter <- c(cities)
    }
    else{
      cities_to_filter <- input$city1
    }
    
    Cities <- unique(filter(df, city %in% cities_to_filter)$city)
    datatable(tibble(Cities), 
              rownames = FALSE, # remove the index number on the table
              options = list(dom = 'tp')) # Turn on the pagination only
    })
  
}

# launch the app
shinyApp(ui = ui, server = server)
