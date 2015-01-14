library(shiny)
library(leaflet)
library(shinyTable)
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Cartographie avec Shiny"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      tags$head(
        #tags$style(type='text/css', ".span4 { max-width: 265px; }")
      ),
      helpText("Exemple d'utilisation de Shiny + leaflet "),
      HTML("<hr/>"),
                 
               fileInput('file1', 'Fichier CSV de Coordonnées :',
                         accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv'))
      ,
               #submitButton("Update View")  ,
      HTML("<hr/>"),
      helpText("Paramètres :"),
      checkboxInput("bulles", "Afficher les bulles", value = TRUE),
      checkboxInput("cercles", "Afficher les cercles", value = TRUE),
      HTML("<hr/>"),
      sliderInput("bins",
                  "Coefficient multiplicateur du rayon :",
                  min = 1,
                  max = 200,
                  value = 100)
      ,
      HTML("<hr/>"),
      HTML("Le Boucher Benjamin (<a href='https://twitter.com/Darkyben'>@Darkyben</a>)"),
      HTML("<a href='http://darky-ben.fr/'>http://darky-ben.fr</a> "),
      br(),
      br(),
      HTML("&copy; 2015 | créé avec <a href='www.r-project.org/'>R</a> et <a href='http://www.rstudio.com/shiny/'>Shiny</a> ")
    
    ),
    
    
    # Show a plot of the generated distribution
    mainPanel(
      
     # leafletOutput('myMap',width = "100%")
      tabsetPanel(
        ##################Tabela######################
        tabPanel("Carte",
                 leafletOutput('myMap',width = "100%")
                 
        ),
        ##################GrÃ¡ficos####################
        tabPanel("Données",
                 #dataTableOutput("mytable2")
                 htable("tbl",colHeaders="provided",rowNames="provided")
                 )
      )
      
    )
  )
))