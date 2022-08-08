---
title: "Shiny Module"
author: "Diardano Raihan"
date: "2022-08-07"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

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

```{r module1}
csvFileUI <- function(id, label = "CSV file"){
  # `NS(id)` returns a namespace function, which was saved as `ns` and will invoke later
  ns <- NS(id)
  
  tagList(
    fileInput(ns("file"), label), 
    checkboxInput(ns("heading"), label = "Has heading"), 
    selectInput(ns("quote"), label = "Quote", choices = c(
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