library(shiny) 
library(plotly)
library(XML)
library(reshape2)
library(stats)
library(graphics)

shinyServer(function(input, output) {
      
      sliderValues <- reactive({
            YearOut <- input$year2
            
      })

      
      output$plot <- renderUI({  # "plot" to be used as argument in server.R
            data <- melt(data_table, id = c("Year", "Month"))
                              
            subset_data <- data[(data$variable %in% input$check_group & data$Year == sliderValues()), ]  
            ggVeh <- (qplot(x=Month, y=value, data=subset_data, color=variable, geom = c("path")))
            
            layout <- list(
                  autosize = FALSE, 
                  title = "Searches of Vehicle Makes by Month",
                  width = 1100, 
                  height = 400,
                  xaxis = list(
                        autotick = FALSE, 
                        ticks = "outside", 
                        tick0 = 0, 
                        dtick = 1.00, 
                        ticklen = 4, 
                        tickwidth = 1, 
                        tickcolor = "#eee",
                        title = "Month"
                  ),
                  yaxis = list(
                        autotick = TRUE, 
                        ticks = "outside", 
                        tick0 = 0, 
                        dtick = 1.00, 
                        ticklen = 4, 
                        tickwidth = 1, 
                        tickcolor = "#eee",
                        title = "Number of searches"
                  ),
                  margin = list(
                        l = 70, 
                        r = 30, 
                        b = 40, 
                        t = 40, 
                        pad = 2
                  ), 
                  paper_bgcolor = "#ffffff", 
                  plot_bgcolor = "#eeeeee"
                  )
            
            py <- plotly(username="chaendryn", key="tw7wr68s4e", base.url="https://plot.ly")  # Open Plotly connection
           
            res <- py$ggplotly(ggVeh, kwargs=list(layout = layout, 
                                                  
                                                  filename="searchTrends", 
                                                   fileopt="overwrite", # Overwrite plot in Plotly's website
                                                   auto_open=FALSE))
            tags$iframe(src=res$response$url,
                        frameBorder="0",  # Some aesthetics
                        height=400,
                        width=1200)
            
      })
      
      
      output$corplot <- renderPlot({  # "plot" to be used as argument in server.R
            lv <- (names(data_table) %in% input$check_group)
            tableData <- data_table[data_table$Year == sliderValues(), lv]
            
            ## The following code and figure is adapted from the help file for pairs and was found on http://personality-project.org/r/r.graphics.html
            
            ## Put (absolute) correlations on the upper panels, with size proportional to the correlations.
            ## Creating the function (panel.cor)
            panel.cor <- function(x, y, digits=2, prefix="", cex.cor)
            {
                  usr <- par("usr"); on.exit(par(usr))
                  par(usr = c(0, 1, 0, 1))
                  r = cor(x, y)
                  txt <- format(c(r, 0.123456789), digits=digits)[1]
                  txt <- paste(prefix, txt, sep="")
                  if(missing(cex.cor)) cex <- 0.5/strwidth(txt)
                  text(0.5, 0.5, txt, cex = cex * abs(r))
            }
            
            
            ## Plotting the pairs plot matrix
            
            corplot <- pairs(tableData, lower.panel=panel.smooth, upper.panel=panel.cor, main = "Correlation Pairs Plot")
                        
      })
      
      
      
      
      
      output$table <- renderTable ({ 
            lv <- (names(data_table) %in% input$check_group)
            tableData <- data_table[data_table$Year == sliderValues(), lv]
            summary(tableData)
            })
      
      output$yearText<- renderText({ paste("You have selected to view", input$year2) })
      
      
      
      

                                       
})      
      