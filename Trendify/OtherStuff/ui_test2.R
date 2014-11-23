library(shiny) 
library(plotly)

shinyUI(
      fluidPage(
            h1("Trendify - A decade of South African Vehicle Search Trends"),
            absolutePanel(
                  top = 20, right = 20,
                  draggable = TRUE,
                  wellPanel(
                        tags$head(tags$link(rel="stylesheet", type="text/css", href="overrides.css")),
                        checkboxGroupInput(inputId="check_group",  
                                           label="Select vehicle:",
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
                                                 "Colt" = "colt",
                                                 "Daihatsu" = "daihatsu",
                                                 "Datsun" = "datsun",
                                                 "Dodge" = "dodge",
                                                 "Ducati" = "ducati",
                                                 "FAW" = "faw",
                                                 "Ferrari" = "ferrari",
                                                 "Fiat" = "fiat",
                                                 "Ford" = "ford",
                                                 "Geely" = "geely",
                                                 "GWM" = "gwm",
                                                 "Hino" = "hino",
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
                                                 "Volvo" = "volvo",
                                                 "Yamaha" = "yamaha"
                                           ),
                                           
                                           selected=list("chrysler", "jeep", "dodge")),
                        
                        sliderInput("year2",
                                    "Select the Year:",
                                    min = 2004,
                                    max = 2014,
                                    value = 2010, 
                                    step = 1),
                        style = "opacity: 0.90"
                        
                        )
                  
                  ),
            mainPanel(
                  
                  tabsetPanel(type = "tabs", 
                              tabPanel("Trend", htmlOutput("plot")), 
                              tabPanel("Corrolation", plotOutput("corplot")), 
                              tabPanel("Data Table", tableOutput("table")))
            
            )

      )
)
