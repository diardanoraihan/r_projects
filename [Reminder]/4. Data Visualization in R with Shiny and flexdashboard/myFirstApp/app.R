#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/

# R Shiny Introduction
# Two Parts to a Shiny App:
# 1. User Interface
#   - Controls all of the visual elements of the app that the users will actualy see. 
# 2. Server Function
#   - Controls how the information for figures and tables and other kind of output is going to be processed.

# At the most basic level, we create a Shiny App by defining these two things, a UI object and a server function. Then, you tie those together with the Shiny App function at the end.


library(shiny)

# Define the user interface to create a page with fluid layout
?fluidPage
# Notice that all the arguments inside fluidPage function are in function forms themselves
ui <- fluidPage(
  
  # Application Title
  titlePanel("My Simple App"), 
  
  # Put the type of input (i.e. sliderInput(), selectInput(), numericInput(), textInput()) into the UI
  # textInput() allows user to type / input text into the app
  # ?textInput
  textInput( inputId = "my_text", 
             label = "Enter some text:"), 

  # The server will produce output "print_text" that will show up in the UI
  textOutput(outputId = "print_text")
  
)


# Create an object called server that will be function that has input and output
server <- function(input, output){
  
  # The input from the UI "my_text" will go to the server
  output$print_text <- renderText(input$my_text)
  
}

# On the final line, you write shinyApp
shinyApp(ui = ui, server = server)
