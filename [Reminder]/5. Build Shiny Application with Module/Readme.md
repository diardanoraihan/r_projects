---
title: "Shiny Module"
author: "Diardano Raihan"
date: "2022-08-07"
output: html_document
---

# 1. Creating Shiny Module

Reference: https://shiny.rstudio.com/articles/modules.html

A shiny module consists of 2 functions: 
1. A piece of UI
2. A fragment of Server Logic that uses that UI (similar to the way that Shiny apps are split into UI and server logic)

Hence, it's obvious that the contents of shiny module will look like a normal Shiny UI/Server with a different packaging adjustment.

## 1.1. Creating UI 

A module's UI function should be given a name that is suffixed with `Input`, `Output`, or `UI`. For example: 
- `csvFileUI`
- `zoomableChoroplethOutput`
- `tabOneUI`

__The first argument to a UI function should always be `id`. This is the namespace for the module__. _(Note that the namespace for the module is decided by the `caller` by the time the module is used. This will make more sense later, when we talk about how modules are invoked.)

```
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
```

The body of this function looks similar to the UI code for a Shiny app. The main differences are: 
1. The function body starts with the statement `ns <- NS(id)`. All UI function bodies should start with this line. It takes the string `id` and creates a namespace function.
2. All __input__ and __output__ IDs that appear in the function body needs to be wrapped in a call to `ns()`. This example shows `inputId` arguments being wrapped in ns(), e.g. ns("file")). If we happened to have a `plotOutput` in our UI, we would also want to use `ns()` when declaring its `outputId` or `brush` ID, for example.
3. The results are wrapped in `tagList`, instead of `fluidPage`, `pageWithSidebar`, etc. You only need to use `tagList` if you want to return a UI fragment that consists of multiple UI objects; if you were just returning a `div` or a single input, you could skip `tagList`.

__NOTE__: we only need to make sure the the IDs `"file"`, `"heading"`, and `"quote"` are _unique within this function_, rather than unique across the entire app.

## 1.2. Writing Server Functions 

Now, we've got some UI, we can turn our attention to the server logic. The server logic is encapsulated in a single function that we'll call the __module server function__.

Module server functions should be named like their corresponding module UI functions, but with a server suffix instead of a `Input`/`Output`/`UI` suffix. For instance, since our UI function was called `csvFileUI`, we'll call our server function `csvFileServer`. 

Inside of `csvFileServer`, there is a call to `moduleServer()`, to which two things are passed: 
1. `id`
2. `module` function

```
# Module server function
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
```
__Note__:
- The outer function `csvFileServer()` takes `id` as its first parameter. After that, you can define the functions so that it takes any number of additional parameters.
- Inside we have `moduleServer()` function which is passed the `id` variable as well as the __module function__. Every module function must take 3 parameters `input`, `output`, and `session` which later will be invoked by the `moduleServer()` to create these 3 objects that are aware of the `id`.
- Inside the module function, we can use `input$file` to refer to the `ns("file")` component in the UI function. The `input`, `output` and `session` objects are special, in that they use the `id` to scope them to the specific namespace that matches up with our UI function.
- Modules by design are used to interact with their containing app __explicitly__. 
  - If a module needs to use a reactive expression, the outer function should take the reactive expression as a parameter. 
  - If a module wants to return reactive expressions to the calling app, then return a list of reactive expressions from the function.
  - If a module needs to access an input that isn't part of the module, the containing app should pass the input value wrapped in a reactive expression (i.e. `reactive(...)`). For example:
```
myModule("myModule1", reactive(input$checkbox1))
```

## 1.3. Using Modules

Assuming the above `csvFileUI` and `csvFileServer` functions are loaded, this is how we will use them in a Shiny app: 

```
library(shiny)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      csvFileUI("datafile", "User data (.csv format)")
    ),
    mainPanel(
      dataTableOutput("table")
    )
  )
)

server <- function(input, output, session) {
  datafile <- csvFileServer("datafile", stringsAsFactors = FALSE)

  output$table <- renderDataTable({
    datafile()
  })
}

shinyApp(ui, server)
```

Note: 
- The UI function `csvFileUI` is called directly using `"datafile"` as the `id`.
- The module server function is called with `csvFileServer()`, with the `id` that we will use as the namespace; __this must exactly the same__ as the `id` argument we passed to `csvFileUI`.
- Like all Shiny modules, `csvfileUI` can be embedded in a single app more than once with a unique `id` and a corresponding call to `csvFileServer()` on the server side with the same `id` for each call.

## 1.4. Nesting Modules

Modules can use other modules. When the outer module's UI function calls the inner module's UI function, ensure that the `id` is wrapped in `ns()`. In the following example, when `outerUI` calls `innerUI`, notice that the `id` argument is `ns("inner1")`.

```
innerUI <- function(id) {
  ns <- NS(id)
  "This is the inner UI"
}

outerUI <- function(id) {
  ns <- NS(id)
  wellPanel(
    innerUI(ns("inner1"))
  )
}
```

As for the module server functions, just ensure that the call to `callModule` for the inner module happens inside the outer module’s server function. There’s generally no need to use `ns()`.

```
innerServer <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      # inner logic here
    }
  )
}

outerServer <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      innerResult <- innerServer("inner1")
      # outer logic here
    }
  )
}
```