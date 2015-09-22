shinyUI(fluidPage(
  titlePanel("Fitbit Steps by day and time"),
  
  sidebarLayout(
    sidebarPanel( 
      selectInput("id", label = "Subject", c("1","2","3","4","5")),
      
      dateRangeInput("start.end.date", label = "Dates", max=today(), start = today()-30)
    ),
    mainPanel(
      textOutput("idText"),
      textOutput("dateText"),
      plotOutput("stepsPlot")
      )
  )
  
))