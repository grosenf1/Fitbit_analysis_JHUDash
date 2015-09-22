shinyUI(fluidPage(
  titlePanel("JHU DaSH - Team Fitbit"),
  
  sidebarLayout(
    sidebarPanel( 
      selectInput("id", 
                  label = "Subject", 
                  c("1","2","3","4","5")),
      
      dateRangeInput("start.end.date", 
                     label = "Dates", 
                     max=today(), 
                     start = today()-30),
      
      checkboxGroupInput("DofW", 
                         label="Days of the Week to include", 
                         choices = list("Monday" = "Mon", "Tuesday" = "Tues", "Wednesday" = "Wed", "Thursday" = "Thurs", "Friday" = "Fri", "Saturday" = "Sat", "Sunday" = "Sun"), 
                         selected = c("Mon","Tues","Wed","Thurs","Fri"))
    ),
    mainPanel(
#      textOutput("idText"),
#      textOutput("dateText"),
#      plotOutput("stepsPlot"),
      h1("Mean total steps by day of week", align="center"),
      plotOutput("stepsDayPlot"),
      hr(),
      
      h1("Mean steps per hour by time of day ", align="center"),
      plotOutput("stepsTimePlot"),
      hr(),
      
      h1("Mean hours of sleep by day of week", align="center"),
      plotOutput("sleepDaysPlot")
      )
  )
  
))