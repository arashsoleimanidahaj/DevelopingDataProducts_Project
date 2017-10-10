Developing Data Products: Course Project
========================================================
author: Arash
date: October 10, 2017
autosize: true

Introduction
========================================================

Application Title: Download 3 sample R Built-in Datasets

In this application you can select and download 3 sample built-in R datasets 

Datasets
========================================================


In this applications the following datasets are selected:

-"Titanic": Survival of passengers on the Titanic	

-"mtcars": Motor Trend Car Road Tests	

-"Tooth Growth": The Effect of Vitamin C on Tooth Growth in Guinea Pigs

The codes in server.R
========================================================


```r
function(input, output) {
  datasetInput <- reactive({

    switch(input$dataset,
           "Titanic" = Titanic,
           "mtcars" = mtcars,
           "Tooth Growth" = ToothGrowth)
  })
  
  output$table <- renderTable({
    datasetInput()
  })
  
  # downloadHandler() takes two arguments, both functions.

  output$downloadData <- downloadHandler(
    
    # This function returns a string which tells the client
    # browser what name to use when saving the file.
    filename = function() {
      paste(input$dataset, input$filetype, sep = ".")
    },
    

    content = function(file) {
      sep <- switch(input$filetype, "csv" = ",", "tsv" = "\t")
            write.table(datasetInput(), file, sep = sep,
                  row.names = FALSE)
    }
  )
}
```

The codes in ui.R
========================================================


```r
fluidPage(
  titlePanel('R Built-in Datasets Download'),
  sidebarLayout(
    sidebarPanel(
      selectInput("dataset", "Choose a R Built-in Dataset:", 
                  choices = c("Titanic", "mtcars", "Tooth Growth")),
      radioButtons("filetype", "File type:",
                   choices = c("csv", "tsv")),
      downloadButton('downloadData', 'Download')
    ),
    mainPanel(
      tableOutput('table')
    )
  )
)
```
