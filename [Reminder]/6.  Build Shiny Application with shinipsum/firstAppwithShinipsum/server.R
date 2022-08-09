#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$data_table <- renderDataTable({
    random_DT(5,5)
  })
  
  output$plot <- renderPlot({
    random_ggplot()
  })
  
  output$text <- renderText({
    random_text(nwords = 50)
  })
  
  output$image <- renderImage({
    random_image()
  })
})
