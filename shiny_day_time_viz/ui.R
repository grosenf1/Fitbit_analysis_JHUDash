shinyUI(fluidPage(
  titlePanel("JHU DaSH - Team Fitbit"),
  
  sidebarLayout(
    sidebarPanel( 
      selectInput("id", 
                  label = "Subject", 
                  c("1","2","3","4","5")),
      
      dateRangeInput("start.end.date", 
                     label = "Dates", 
                     start = "2015-01-01",
                     end = "2015-09-20"
      ),
      
      #       checkboxGroupInput("DofW", 
      #                          label="Days of the Week to include", 
      #                          choices = list("Monday" = "Mon", "Tuesday" = "Tues", "Wednesday" = "Wed", "Thursday" = "Thurs", "Friday" = "Fri", "Saturday" = "Sat", "Sunday" = "Sun"), 
      #                          selected = c("Mon","Tues","Wed","Thurs","Fri")),
      
      h5("Plots to include"),
      
      checkboxInput("stepsDay",
                    label = "Step Totals by day of week",
                    value = T),
      
      checkboxInput("sleep",
                    label = "Hours of sleep per day",
                    value = T),
      
      checkboxInput("density",
                    label = "Density Plot of step totals",
                    value = F),
      
      checkboxInput("stepsTime",
                    label = "Step Totals by time of day",
                    value = F),
      
      checkboxInput("stepsTrend",
                    label = "Step Count trend over time",
                    value = F)
    ),
    mainPanel(
      #      textOutput("idText"),
      #      textOutput("dateText"),
      #      plotOutput("stepsPlot"),
      
      conditionalPanel(
        condition = "input.stepsDay == true",
        h1("Mean total steps by day of week", align="center"),
        plotOutput("stepsDayPlot"),
        hr()
      ),
      
      conditionalPanel(
        condition = "input.sleep == true",
        h1("Mean hours of sleep by day of week", align="center"),
        plotOutput("sleepDaysPlot"),
        hr()
      ),
      
      conditionalPanel(
        condition = "input.stepsTime == true",
        h1("Mean steps per hour by time of day ", align="center"),
        plotOutput("stepsTimePlot"),
        hr()
      ),
      
      conditionalPanel(
        condition = "input.density == true",
        h1("Density plot of step counts", align="center"),
        plotOutput("stepcountDensity"),
        hr()
      ),
      
      conditionalPanel(
        condition = "input.stepsTrend == true",
      h1("Step count trend over time", align="center"),
      plotOutput("trendOverTimePlot")
      )
    )
  )
  
))