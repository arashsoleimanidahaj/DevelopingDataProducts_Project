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