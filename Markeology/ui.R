require(shiny)

shinyUI(fluidPage(
      titlePanel("Markeology - Excavating your Bookmarks"),
      sidebarLayout(
            sidebarPanel(
                  textInput(inputId = 'dirname', label = "Choose a Name for your file directory"),
                  
                  
                  fileInput('file1', 'Choose a bookmark File',
                            accept=c('text/csv', 
                                     'text/comma-separated-values,text/plain', 
                                     '.csv',
                                     '.html',
                                     '.htm')),
                  tags$hr(),
                  checkboxInput('header', 'Header', TRUE),
                  radioButtons('sep', 'Separator',
                               c(Comma=',',
                                 Semicolon=';',
                                 Tab='\t'),
                               ','),
                  radioButtons('quote', 'Quote',
                               c(None='',
                                 'Double Quote'='"',
                                 'Single Quote'="'"),
                               '"')
            ),
            mainPanel(
                  tableOutput('contents'),
                  textOutput('dirname'),
                  plotOutput('plot1')
            )
      )
))