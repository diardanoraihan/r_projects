# Explanation
# 1. NS() is used within counterButton() to encapsulate the module's UI
# 2. counterServer() is a function which calls moduleServer()
# 3. The call to moduleServer() is passed the id, as well as a module function. 
# 4. In this particular example, the module function returns a reactive value, but it could return any value.
# 5. Inside of the application server function, counterServer() is called to initialize the module.

library(shiny)

# Define the ui module 
counterButton <- function(id, label = 'Counter'){
  ns <- NS(id)
  tagList(
    actionButton(ns("button"), label = label), 
    verbatimTextOutput(ns("out"))
  )
}

# Define UI for application that draws a histogram
ui <- fluidPage(
  counterButton("counter1", label = "Counter #1")
)
