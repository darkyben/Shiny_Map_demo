library(shiny)
library(leaflet)
library(shinyTable)
# Define server logic required to draw a histogram
shinyServer(function(input, output,session) {
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should be automatically
  #     re-executed when inputs change
  #  2) Its output type is a plot
  
  
  # shiny_demo_map
  # X=read.table("Terrains.csv",header=TRUE,sep=";",dec=",",row.names=1)
  
  mydata <- reactive({  
    inFile <- input$file1
    if (is.null(inFile)){
      Terrain <- as.matrix(rbind(
        c(lng=53.888737,lat=-8.198971,val=100),
        c(lng=53.974292,lat=-6.713545,val=40),
        c(lng=53.073484,lat=-9.111097,val=300),
        c(lng=52.034836,lat=-9.317090,val=150)
      ))
      #row.names(Terrain)<-c("Terrain1","Terrain2","Terrain3","Terrain4")
      return(Terrain)
    }
    read.table(inFile$datapath,header=TRUE,sep=";",dec=",",row.names=1)
  })
  
  
  
  output$tbl <- renderHtable({
    cachedTbl <- mydata()
    if (is.null(input$tbl)){
      rows <- 5
      
      tbl <- as.data.frame(mydata())
      
      
      cachedTbl <<- tbl
      print(tbl)
      return(tbl)
    } else{
      cachedTbl <<- input$tbl
      print(input$tbl)
      return(input$tbl)
    }
  })  
  
  output$myMap <- renderLeaflet({
    m = leaflet() %>% addTiles(  'http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}')
    
    if(input$bulles) m = m  %>% addPopups(mydata()[,2], mydata()[,1], paste('Terrain',1:nrow(mydata())))
    if(input$cercles) m = m %>% addCircles(mydata()[,2], mydata()[,1], radius = input$bins*mydata()[,3])
    
    m  
  })
})