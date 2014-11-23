library(shiny)
source("global.R")
shinyServer(function(input, output) {
      
      datasetInput <- reactive({
            df <- data
                 
            switch(input$dataset,
                  "Alfa Romeo" = df$alfaromeo,
                  "Audi" = df$audi,
                  "Bentley" = df$bentley,
                  "BMW" = df$bmw,
                  "Chana" = df$chana,
                  "Chery" = df$chery,
                  "Chevrolet" = df$chevrolet,
                  "Chrysler" = df$chrysler,
                  "Citroen" = df$citroen,
                  "Colt" = df$colt,
                  "Daihatsu" = df$daihatsu,
                  "Datsun" = df$datsun,
                  "Dodge" = df$dodge,
                  "Ducati" = df$ducati,
                  "FAW" = df$faw,
                  "Ferrari" = df$ferrari,
                  "Fiat" = df$fiat,
                  "Ford" = df$ford,
                  "Geely" = df$geely,
                  "GWM" = df$gwm,
                  "Hino" = df$hino,
                  "Honda" = df$honda,
                  "Hummer" = df$hummer,
                  "Hyundai" = df$hyundai,
                  "Infiniti" = df$infiniti,
                  "Isuzu" = df$isuzu,
                  "Jaguar" = df$jaguar,
                  "Jeep" = df$jeep,
                  "Kawasaki" = df$kawasaki,
                  "Kia" = df$kia,
                  "Lamborghini" = df$lamborghini,
                  "Land Rover" = df$landrover,
                  "Lexus" = df$lexus,
                  "Lotus" = df$lotus,
                  "Mahindra" = df$mahindra,
                  "Maserati" = df$maserati,
                  "Mazda" = df$mazda,
                  "Mercedes Benz" = df$mercedes,
                  "Mini" = df$mini,
                  "Mitsubishi" = df$mitsubishi,
                  "Nissan" = df$nissan,
                  "Opel" = df$opel,
                  "Peugeot" = df$peugeot,
                  "Porsche" = df$porsche,
                  "Proton" = df$proton,
                  "Renault" = df$renault,
                  "Rolls Royce" = df$rollsroyce,
                  "Rover" = df$rover,
                  "Saab" = df$saab,
                  "Smart" = df$smart,
                  "Ssangyong" = df$ssangyong,
                  "Subaru" = df$subaru,
                  "Suzuki" = df$suzuki,
                  "Tata" = df$tata,
                  "Toyota" = df$toyota,
                  "Triumph" = df$triumph,
                  "Volkswagen" = df$volkswagen,
                  "Volvo" = df$volvo,
                  "Yamaha" = df$yamaha)
            
            
      })
      
      output$text1 <- renderText({
            Url1 <- paste("http://www.google.com/trends/fetchComponent?q=", input$textIn1, "&cid=TIMESERIES_GRAPH_0&export=3", sep = "", collapse = NULL)
            text1 <- length(data$Month)
            ##test1 <- getURLContent(Url1)

      }) 
      
      ##output$text1 <- renderTable({
            
      ##})
      
      output$text2 <- renderText({
            Url2 <- paste("http://www.google.com/trends/fetchComponent?q=", input$textIn1, "&cid=TIMESERIES_GRAPH_0&export=3", sep = "", collapse = NULL)
            ##text2 <- Url2
            ##test2 <- getURLContent(Url2)
            ##text2 <- input$textIn2
            text2 <- length(input$dataset)
      })

  output$distPlot <- renderPlot({
      df <- data 
      x <- data$Year
      y <- datasetInput() 

    # draw the histogram with the specified number of bins
    plot(x,y, type = "lines")

  })
  
  
  output$myPlot <- renderPlot({
        df <- data 
        library(plotly)
        library(ggplot2)
        py <- plotly(username="chaendryn", key="tw7wr68s4e", base.url = "https://plot.ly")
        py$ggplotly()
        
        trace1 <- list(
              x = data$Month, 
              y = data$chrysler, 
              type = "scatter"
        )
        trace2 <- list(
              x = data$Month, 
              y = data$toyota, 
              type = "scatter"
        )
        data <- list(trace1, trace2)
        response <- py$plotly(data, kwargs=list(filename="basic-line", fileopt="overwrite"))
        url <- response$url
        
  })
  output$myPlot2 <- renderUI({
        df <- data 
        library(plotly)
        library(ggplot2)
        
        hello <- ggplot(data=df, aes(x=Year, y=chrysler)) + geom_bar(stat="identity")
        
        py <- plotly(username="chaendryn", key="tw7wr68s4e", base.url = "https://plot.ly")
        res <- py$ggplotly(hello, kwargs=list(filename="test", 
                                               fileopt="overwrite", # Overwrite plot in Plotly's website
                                               auto_open=FALSE))
        
        tags$iframe(src=res$response$url,
                    frameBorder="0",  # Some aesthetics
                    height=400,
                    width=650)
        
        
        
  })
  

})
