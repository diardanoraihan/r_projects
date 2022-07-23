#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)

# data wrangling
data <- read_csv("data_publish_practice.csv")

# static plot
ggplot(data, aes(x = varX, y = varY, color = Group))+
  geom_point()

# user interface
ui <- fluidPage(
  
  titlePanel("Test"), 
  
  # minimal sidebarLayout() example:
  # sidebarLayout(sidebarPanel(), mainPanel())
  
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput(
        inputId = "checked_group", 
        label = "Which groups do you want to display?", 
        choices = c("a", "b", "c"), 
        selected = c("a", "b", "c") # default selected choices when the app opens up
      )
    ), 
    mainPanel(
      plotOutput(
        outputId = "scatter"
        )
    )
  )
  
)

# server
server <- function(input, output){
  
  output$scatter <- renderPlot({ # the curly bracket allows you to write some additional lines within the renderPlot function that will do some data management
    
    plot_data <- filter(data, Group %in% input$checked_group)
    
    plot_data %>% ggplot(aes(x = varX, y = varY, color = Group))+geom_point()
    
    # the above code is the same as doing something like:
    # ggplot(filter(data, Group %in% input$checked_group), aes(...))+ ...
  }
  )
  
}
# run the app
shinyApp(ui = ui, server = server)