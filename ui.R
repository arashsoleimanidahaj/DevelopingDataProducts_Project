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