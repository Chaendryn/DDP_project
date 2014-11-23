library(shiny) 
library(plotly)

shinyUI(fluidPage(
      
      title = "Vehicle Search Trends in South Africa - 2004 to 2014",
      
      
      tabsetPanel(type = "tabs", 
                  tabPanel("Help File",
                           h4("Trendify - Vehicle Search Trends in South Africa (2004 to 2014)"),
                           wellPanel(
                                 tags$div(
                                       HTML("<p><b>Trendify</b> is a small app that plots the search trends, basic correlation matrix and summary statistics for various vehicle makes that are popular in South Africa. By default, the application launches with the year 2010 and vehicle makes Chrysler, Jeep and Dodge selected.</p>
                                                <p>
                                                <ul>
                                                      <li> To select a specific year's data to view, change the slider value anywhere on the range from 2004 - 2014.</li>
                                                      <li> To change the vehicle makes being represented, select the checkbox next to the vehicle brand you're interested in, and deselect the brands you are no longer interested in.</li>
                                                      <li> To view the information, click on th tabs above.</li>
                                                      <li> For the correlation matrix, a minimum of two vehicle makes need to be selected.</li>
                                                </ul>
                                                </p>
                                                <p> Please note that the search trend plot is regenerated on change, it might take a minute or two to update.</p>")
                                       )
                                 
                                 )
                           
                           ),
                  tabPanel("Search Trends", htmlOutput("plot")), 
                  tabPanel("Correlation Matrix", plotOutput("corplot")), 
                  tabPanel("Summary Statistics", 
                           
                           h4("Basic Data Wrangling"),
                           
                           
                           
                           tableOutput("table")
                           
                           )),
      
      fluidRow(
            style = "background-color: #eeeeee; padding: 7px; border: 1px solid #dddddd",
            column(3,
                   h4("Select the Year:"),
                   sliderInput("year2",
                               "Year:",
                               min = 2004,
                               max = 2014,
                               value = 2010, 
                               step = 1),
                   
                   textOutput("yearText")
            ),
            column(9, offset = 0,
                   h4("Select the Vehicle Models:"),
                   tags$head(tags$link(rel="stylesheet", type="text/css", href="overrides.css")),
                   checkboxGroupInput(inputId="check_group",  
                                      label=NULL,
                                      choices=list(
                                            "Alfa Romeo" = "alfaromeo",
                                            "Audi" = "audi",
                                            "Bentley" = "bentley",
                                            "BMW" = "bmw",
                                            "Chana" = "chana",
                                            "Chery" = "chery",
                                            "Chevrolet" = "chevrolet",
                                            "Chrysler" = "chrysler",
                                            "Citroen" = "citroen",
                                            "Daihatsu" = "daihatsu",
                                            "Datsun" = "datsun",
                                            "Dodge" = "dodge",
                                            "Ducati" = "ducati",
                                            "Ferrari" = "ferrari",
                                            "Fiat" = "fiat",
                                            "Ford" = "ford",
                                            "Geely" = "geely",
                                            "GWM" = "gwm",
                                            "Honda" = "honda",
                                            "Hummer" = "hummer",
                                            "Hyundai" = "hyundai",
                                            "Infiniti" = "infiniti",
                                            "Isuzu" = "isuzu",
                                            "Jaguar" = "jaguar",
                                            "Jeep" = "jeep",
                                            "Kawasaki" = "kawasaki",
                                            "Kia" = "kia",
                                            "Lamborghini" = "lamborghini",
                                            "Land Rover" = "landrover",
                                            "Lexus" = "lexus",
                                            "Lotus" = "lotus",
                                            "Mahindra" = "mahindra",
                                            "Maserati" = "maserati",
                                            "Mazda" = "mazda",
                                            "Mercedes Benz" = "mercedes",
                                            "Mini" = "mini",
                                            "Mitsubishi" = "mitsubishi",
                                            "Nissan" = "nissan",
                                            "Opel" = "opel",
                                            "Peugeot" = "peugeot",
                                            "Porsche" = "porsche",
                                            "Proton" = "proton",
                                            "Renault" = "renault",
                                            "Rolls Royce" = "rollsroyce",
                                            "Rover" = "rover",
                                            "Saab" = "saab",
                                            "Smart" = "smart",
                                            "Ssangyong" = "ssangyong",
                                            "Subaru" = "subaru",
                                            "Suzuki" = "suzuki",
                                            "Tata" = "tata",
                                            "Toyota" = "toyota",
                                            "Triumph" = "triumph",
                                            "Volkswagen" = "volkswagen",
                                            "Volvo" = "volvo"
                                      ),
                                      
                                      selected=list("chrysler", "jeep", "dodge"))
            
            )
      )
))