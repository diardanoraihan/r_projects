library(shiny)
library(tidyverse)
library(DT) # for data tables
library(plotly) # for plotly figures

# data generated
cities <- c("Hong Kong", "Macau", "Dubai")

city1 <- data.frame("city" = rep(cities[1], 5), 
                    "year" = as.integer(seq(from = 1990, to = 1994, by = 1)), 
                    "var1" = round(runif(5, 0, 5), 0), 
                    "var2" = round(runif(5, 0, 5), 0), 
                    "var3" = round(runif(5, 0, 5), 0))

city2 <- data.frame("city" = rep(cities[2], 5), 
                    "year" = as.integer(seq(from = 1990, to = 1994, by = 1)), 
                    "var1" = round(runif(5, 0, 5), 0), 
                    "var2" = round(runif(5, 0, 5), 0), 
                    "var3" = round(runif(5, 0, 5), 0))

city3 <- data.frame("city" = rep(cities[3], 5), 
                    "year" = as.integer(seq(from = 1990, to = 1994, by = 1)), 
                    "var1" = round(runif(5, 0, 5), 0), 
                    "var2" = round(runif(5, 0, 5), 0), 
                    "var3" = round(runif(5, 0, 5), 0))

df <- bind_rows(city1, city2, city3)

# Define the UI for different kinds of input
# Without any arguments in the functions, creating a skeleteon of the UI would look like this:

# ui <- fluidPage(
#   sliderInput(), 
#   checkboxGroupInput(), 
#   tableOutput(), 
#   h1(), # you can use HTML tags to write text -- for all of the options, see ?builder
#   h2(), 
#   p(), 
#   # and so on
# )

ui <- fluidPage(
  
  h1("This is a  sample of H1 HTML header"), 
  p("this is some sample p html text"), 
  
  h2("Text Input"), 
  textInput(inputId = "text_input", 
            label = "Enter some text here:", 
            value = "This your entered text (you can replace it)"), 
  
  h2("Text Output"), 
  textOutput(outputId = "text_output"),
  # The complement to this in the server below is output$text_output <- renderText(input$text_input)
  
  h2("Print Output"), 
  p("With print output, whatever your R console produced from an expression will be printed in the Shiny app. This is not usually preferred, because it is going to be unattractive."), 
  verbatimTextOutput(outputId = "print1"),
  # The complement to this in the server below is output$print1 <- renderPrint(table(df$var1))
  
  h2("Slider Input with Two Sliders"), 
  sliderInput(inputId = "year1", 
              label = "Select Year", 
              min = 1990, 
              max = 1994, 
              value = c(1990, 1994), 
              sep = ""),
  
  h2("Checkbox Input"), 
  checkboxGroupInput(inputId = "city1", 
                     label = "Which City Do You Want to Display?", 
                     choices = cities, 
                     selected = cities),
  
  # This tells the user interface that the output$["table"] will do here
  h2("A Standard Table"), 
  tableOutput(outputId = "table1"), 
  # matched with output$table1 <- renderTable(filter(df, city %in% input$city1 & year %in% seq(from = min(input$year1), to = max(input$year1))))
  
  # The following function will produce a fancier table output
  h2("A Data Table"), 
  dataTableOutput(outputId = "table2"),
  # matched with   output$table2 <- renderDataTable(filter(df, city %in% input$city1 & year %in% seq(from = min(input$year1), to = max(input$year1))))
  
  h2("A Standard Plot"), 
  plotOutput(outputId = "plot1"),
  
  h2("A Plotly Plot"), 
  plotlyOutput(outputId = "plot2")
)

# define the server
server <- function(input, output){
  
  output$text_output <- renderText(input$text_input)
  
  output$print1 <- renderPrint(table(df$var1))
  
  output$table1 <- renderTable(
    filter(df, city %in% input$city1 & year %in% seq(from = min(input$year1), to = max(input$year1)))
  )
  
  output$table2 <- renderDataTable(
    filter(df, city %in% input$city1 & year %in% seq(from = min(input$year1), to = max(input$year1)))
  )
  
  output$plot1 <- renderPlot(
    ggplot(
      filter(df, 
             city %in% input$city1 & year %in% seq(from = min(input$year1), 
                                                   to = max(input$year1))
             ), 
      aes(x = var1, y = var2)
      )+
      geom_point()
  )
  
  output$plot2 <- renderPlotly(
    ggplot(
      filter(df, 
             city %in% input$city1 & year %in% seq(from = min(input$year1), 
                                                   to = max(input$year1))
      ), 
      aes(x = var1)
    )+
      geom_histogram()
  )
  
}

# launch the app
shinyApp(ui = ui, server = server)

# filter(df, city %in% c("Hong Kong", "Dubai"))
