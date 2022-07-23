# Shiny App 101
## A. Components of a Shiny App
1. __User Interface__: controls visual elements
  - Created with `fluidPage` function.
  - Where users can provide input (i.e. sliderInput(inputId = "input_value", . . .)), 
  - and see output (i.e. plotOutput(outputId = "plot"))
  
2. __Server Function__: controls how inputted information will be used to draw tables and figures, assigning rendered tables and figures to output slots.
  - `output$plot <- renderPlot(hist(input$input_value))`

3. Combine these in the `shinyApp()` function.

## B. Basic Input Options in the UI-side
- `textInput()`: allows the user to write in text
- `numericInput()`: lets users type numbers
- `sliderInput()`: tells users to select values from a slider
- `selectInput()`: lets users select options from a dropdown menu
- `radiobuttons()`: presents radio buttons
- `checkboxInput()` or `checkboxGroupInput()`: presents checkboxes

## C. Basic Output Options in the UI-side
- `textOutput()`: to print text
- `verbatimTextOutput()`: to print the output form the R console
- `tableOutput()`: to display a formatted HTML table of a data frame or some kind of other object that you can provide
- `dataTableOutput()`: to display fancier HTML table with some additional navigation options
- `plotOutput()`: to display the plot
- `plotlyOutput()`: to display the plotly figure

## D. Basic Rendering Functions in the Server-side
- `renderText()`
- `renderPrint()`
- `renderTable()`
- `renderDataTable()`
- `renderPlot()`
- `renderPlotly()`

__How These Work Together: __
- `textOutput()` -----------------> `renderText()`
- `verbatimTextOutput()` ---------> `renderPrint()`
- `tableOutput()` ----------------> `renderTable()`
- `dataTableOutput()` ------------> `renderDataTable()`
- `plotOutput()` -----------------> `renderPlot()`
- `plotlyOutput()` ---------------> `renderPlotly()`