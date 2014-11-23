
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Trendify"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30),
      selectInput("dataset", "Choose vehicle make:", choices = c("Alfa Romeo","Audi","Bentley","BMW","Chana","Chery","Chevrolet",
                                                                 "Chrysler","Citroen","Colt","Daihatsu","Datsun","Dodge",
                                                                 "Ducati","FAW","Ferrari","Fiat","Ford",
                                                                 "Geely","GWM","Hino","Honda","Hummer","Hyundai","Infiniti",
                                                                 "Isuzu","Jaguar","Jeep","Kawasaki","Kia","Lamborghini",
                                                                 "Land Rover","Lexus","Lotus","Mahindra","Maserati","Mazda",
                                                                 "Mercedes Benz","Mini","Mitsubishi","Nissan","Opel","Peugeot",
                                                                 "Porsche","Proton","Renault","Rolls Royce","Rover","Saab",
                                                                 "Smart","Ssangyong","Subaru","Suzuki","Tata","Toyota","Triumph",
                                                                 "Volkswagen","Volvo","Yamaha")),
      textInput("textIn1", "First Input"),
      textInput("textIn2", "Second Input")
    ),

    # Show a plot of the generated distribution
    mainPanel(
          plotOutput("myPlot1"),
      plotOutput("myPlot"),    
      plotOutput("distPlot"),
      textOutput("text1"),
      textOutput("text2")
    )
  )
))
