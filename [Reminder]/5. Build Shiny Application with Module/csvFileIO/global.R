csvFileUI <- function(id, label = "CSV file"){
  # `NS(id)` returns a namespace function, which was saved as `ns` and will invoke later
  ns <- NS(id) # i.e. id = 'myId'
  
  tagList(
    fileInput(ns("file"), label), #inputId = 'myId-file'
    checkboxInput(ns("heading"), label = "Has heading"), #inputId = 'myId-heading'
    selectInput(ns("quote"), label = "Quote", choices = c(  #inputId = 'myId-quote'
      "None" = "", 
      "Double quote" = "\"", 
      "Single quote" = "'"
    ))
  )
}

csvFileServer <- function(id, stringsAsFactors){
  moduleServer(
    
    id = id,
    
    # Below is the module function 
    module =  function(input, output, session){
      # The selected file, if any
      userFile <- reactive({
        # If no file is selected, don't do anything
        validate(need(input$file, message = FALSE))
        input$file
      })
      
      # The user's data, parsed into a data frame
      dataframe <- reactive({
        read.csv(userFile()$datapath,
                 header = input$heading,
                 quote = input$quote,
                 stringsAsFactors = stringsAsFactors)
      })
      
      # We can run observers in here if we want to
      observe({
        msg <- sprintf("File %s was uploaded", userFile()$name)
        cat(msg, "\n")
      })
      
      # Return the reactive that yields the data frame
      return(dataframe)
    }
  )   
}