# Shiny App 101
## Components of a Shiny App
1. __User Interface__: controls visual elements
  - Created with `fluidPage` function.
  - Where users can provide input (i.e. sliderInput(inputId = "input_value", . . .)), 
  - and see output (i.e. plotOutput(outputId = "plot"))
  
2. __Server Function__: controls how inputted information will be used to draw tables and figures, assigning rendered tables and figures to output slots.
  - `output$plot <- renderPlot(hist(input$input_value))`

3. Combine these in the `shinyApp()` function.
