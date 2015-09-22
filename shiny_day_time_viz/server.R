load("data/all_data.Rdata")

library(ggplot2)
library(RColorBrewer)
library(lubridate)

shinyServer(
  
  function(input, output) {
    #data <- all_data[all_data$id==input$id,]
    
    #     output$idText <- renderText({ 
    #       paste("Displaying subject", input$id, ":")
    #     })
    
    #     output$dateText<- renderText({
    #       paste(input$start.end.date[1], "until", input$start.end.date[2])
    #     })
    
    
    output$stepsPlot <- renderPlot({
      # Subset data by subject, dates, day of week
      data <- all_data[all_data$id==input$id,]
      data <- data[as.Date(data$date) >= as.Date(input$start.end.date[1]),]
      data <- data[as.Date(data$date) <= as.Date(input$start.end.date[2]),]
      data <- data[data$DofW.steps %in% input$DofW,]
      
      # Plot! Needs to be prettier
      ggplot(data=data,aes(x=time,y=steps,group=1)) + geom_line()
    })
    
    #==============================================
    # Plot steps per day of week
    output$stepsDayPlot <- renderPlot({
      # subset data by subject, dates, day of week
      data <- all_data[all_data$id==input$id,]
      data <- data[as.Date(data$date) >= as.Date(input$start.end.date[1]),]
      data <- data[as.Date(data$date) <= as.Date(input$start.end.date[2]),]
      data <- data[data$DofW.steps %in% input$DofW,]
      
      # Strip zero-step days
      z <- (data$tot_steps==0)
      data <- data[!z,]
      
      # Make plot
      ggplot(data=data,
             aes(x=factor(DofW.steps, levels(DofW.steps)[c(2:7,1)]), 
                 y=tot_steps, 
                 fill=factor(DofW.steps))) +
        stat_summary(fun.y="mean", geom="bar") +
        labs(x = "Day of week", y = "") +
        theme(axis.text.x=element_text(size=20, vjust=0.5),
              axis.title.x=element_text(size = 25, vjust = -.3),
              axis.text.y=element_text(size=20, vjust=0.5),
              legend.position="none"
        )
    })
    
    #===================================================================
    # Plot steps per time of day
    output$stepsTimePlot <- renderPlot({
      # subset data by subject, dates, day of week
      data <- all_data[all_data$id==input$id,]
      data <- data[as.Date(data$date) >= as.Date(input$start.end.date[1]),]
      data <- data[as.Date(data$date) <= as.Date(input$start.end.date[2]),]
      data <- data[data$DofW.steps %in% input$DofW,]
      
      # Strip zero-step days
      z <- (data$tot_steps==0)
      data <- data[!z,]
      
      # Make plot
      ggplot(data=data, 
             aes(x=factor(TOD, levels(TOD)[c(2:5,1)]), 
                 y=4*steps, 
                 fill=factor(TOD, levels(TOD)[c(2:5,1)])
             )) +
        scale_fill_brewer() +
        stat_summary(fun.y="mean", geom="bar") +
        labs(x = "Time of Day", y = "") +
        theme(axis.text.x=element_text(size=20, vjust=0.5),
              axis.title.x=element_text(size = 25, vjust = -.3),
              axis.text.y=element_text(size=20, vjust=0.5),
              legend.position="none"
        )
      
    })
    
    #===================================================================
    # Plot sleep duration per day of week
    
    output$sleepDaysPlot <- renderPlot({
      # subset data by subject, dates, day of week
      data <- all_data[all_data$id==input$id,]
      data <- data[as.Date(data$date) >= as.Date(input$start.end.date[1]),]
      data <- data[as.Date(data$date) <= as.Date(input$start.end.date[2]),]
      data <- data[data$DofW.steps %in% input$DofW,]
      
      # Make plot
      ggplot(data=data,
             aes(x=factor(DofW.steps, levels(DofW.steps)[c(2:7,1)]), 
                 y=sleep.duration/60, 
                 fill=factor(DofW.steps))
             ) +
        stat_summary(fun.y="mean", geom="bar") +
        labs(x = "Day of Week", y = "") +
        theme(axis.text.x=element_text(size=20, vjust=0.5),
              axis.title.x=element_text(size = 25, vjust = -.3),
              axis.text.y=element_text(size=20, vjust=0.5),
              legend.position="none"
        )
      
    })
    
  })