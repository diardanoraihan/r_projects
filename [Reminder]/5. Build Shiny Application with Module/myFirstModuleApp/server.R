#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define the server module
counterServer <- function(id){
  moduleServer(
    id = id, 
    module = function(input, output, session){
      count <- reactiveVal( value = 0) # construct a "reactive value" object.
      observeEvent(input$button, {
        count(count() + 1)
      })
      output$out <- renderText({
        count()
      })
    }
  )
}

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  counterServer("counter1")
})
