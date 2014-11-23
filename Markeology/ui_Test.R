require(shiny)

shinyUI(fluidPage(
      titlePanel("Markeology - Excavating your Bookmarks"),
      sidebarLayout(
            sidebarPanel(
                  textInput(inputId = 'dirname', label = "1. Choose a Name for your file directory"),
                  tags$hr(),
                  textOutput('dirname'),
                  fileInput('file1', '2. Choose a bookmark file',
                            accept=c('text/csv', 
                                     'text/comma-separated-values,text/plain', 
                                     '.csv',
                                     '.html',
                                     '.htm')),
                  actionButton("update", "Change")
                  
            ),
            mainPanel(
                  tableOutput('contents')
                  
            )
      )
))