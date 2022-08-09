# Define UI for application that draws a histogram
shinyUI(
  
  fluidPage(

    # Application title
    titlePanel("Shinipsum"),
    
    h2("A Random DT"),
    DTOutput(outputId = "data_table"), 
    h2("A Random Plot"), 
    plotOutput(outputId = "plot"), 
    h2("A Random Text"), 
    textOutput(outputId = "text"),
    h2("A Random Image"), 
    plotOutput(outputId = "image")
    
  )
)
