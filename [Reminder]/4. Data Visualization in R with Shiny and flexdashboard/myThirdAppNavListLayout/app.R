# When you have more than a handful of tabPanels the navlistPanel() may be a good alternative to tabsetPanel().

# A navlist presents the various components as a sidebar list rather than using tabs. It also supports section heading and separators for longer lists. Here’s an example of a navlistPanel()

library(shiny)
library(tidyverse)
library(plotly)

cities=c("Hong Kong","Macau","Dubai")

city1 <- data.frame("city"=rep(cities[1],5),
                    "year"=seq(from=1990,to=1994,by=1),
                    #"unit"=letters[1:5],
                    "var1"=runif(5,0,5),
                    "var2"=runif(5,0,5),
                    "var3"=runif(5,0,5))
city2 <- data.frame("city"=rep(cities[2],5),
                    "year"=seq(from=1990,to=1994,by=1),
                    #"unit"=letters[1:5],
                    "var1"=runif(5,0,5),
                    "var2"=runif(5,0,5),
                    "var3"=runif(5,0,5))
city3 <- data.frame("city"=rep(cities[3],5),
                    "year"=seq(from=1990,to=1994,by=1),
                    #"unit"=letters[1:5],
                    "var1"=runif(5,0,5),
                    "var2"=runif(5,0,5),
                    "var3"=runif(5,0,5))

df <- bind_rows(city1,city2,city3)


# ui <- fluidPage(
# 
#   titlePanel("Application Title"),
# 
#   navlistPanel(
#     "Header A",
#     tabPanel(title="Component 1",
#             sliderInput(),
#             checkboxGroupInput(),
#             plotOutput()
#             ),
#     tabPanel("Component 2"),
#     "Header B",
#     tabPanel("Component 3"),
#     tabPanel("Component 4"),
#     "-----",
#     tabPanel("Component 5")
#   )
# )

# Define the UI
ui <- fluidPage(
  
  titlePanel(h1("Navigation List Layout Format", align = "center")), 
  
  navlistPanel(
    "Header A", 
    tabPanel(
      title = "Component 1", 
      sliderInput(
        inputId = "year_input", 
        label = "Year", 
        min = 1990, 
        max = 1994, 
        value = c(1990, 1994), 
        sep = ""
      ), 
      p("Selected Value:", textOutput(outputId = "year_output", inline = TRUE)),
      plotlyOutput(outputId = "plot1")
    ), 
    tabPanel(
      title = "Component 2", 
      sidebarLayout(
        position = "right", 
        sidebarPanel = sidebarPanel(
          selectInput(
            inputId = "cities_input", 
            label = "City", 
            choices = cities, 
            multiple = TRUE
          )
        ), 
        mainPanel = mainPanel(
          plotlyOutput("plot2")
        )
      )
    ), 
    "Header B", 
    tabPanel(
      title = "Component 3"
    ), 
    "Header C", 
    tabPanel(
      title = "Component 4"
    )
  )
  
  
)

# Define the server function
server <- function(input, output){
  
  output$year_output <- renderText({
    seq(from = min(input$year_input), to = max(input$year_input))
  })
  
  output$plot1 <- renderPlotly({
    plot_data <- filter(df, year %in% input$year_input)
    ggplot(plot_data, aes(x = city, y = var1, fill = city))+geom_bar(stat = "identity")
  })
  
  output$plot2 <- renderPlotly({
    
    cities_to_filter <- input$cities_input
    
    if(is.null(cities_to_filter)){
      cities_to_filter <- cities
    } 
    else{
      cities_to_filter
    }
    
    plot_data <- filter(df, city %in% cities_to_filter)
    ggplot(plot_data, aes(x = city, y = var1, fill = city))+geom_bar(stat = "identity")
  })
}

# Launch the App
shinyApp(ui = ui, server = server)