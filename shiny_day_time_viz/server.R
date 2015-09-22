load("data/all_data.Rdata")

library(ggplot2)

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
    
    output$stepsDayPlot <- renderPlot({
      # subset data by subject, dates, day of week
      data <- all_data[all_data$id==input$id,]
      data <- data[as.Date(data$date) >= as.Date(input$start.end.date[1]),]
      data <- data[as.Date(data$date) <= as.Date(input$start.end.date[2]),]
      data <- data[data$DofW.steps %in% input$DofW,]
      
      # Make plot
      ggplot(data=data, aes(x=factor(DofW.steps), y=tot_steps, fill=time)) +
        stat_summary(fun.y="mean", geom="bar")
      
    })
    
    output$stepsTimePlot <- renderPlot({
      # subset data by subject, dates, day of week
      data <- all_data[all_data$id==input$id,]
      data <- data[as.Date(data$date) >= as.Date(input$start.end.date[1]),]
      data <- data[as.Date(data$date) <= as.Date(input$start.end.date[2]),]
      data <- data[data$DofW.steps %in% input$DofW,]
      
      # Make plot
      ggplot(data=data, aes(x=factor(TOD), y=4*steps, fill=time)) +
        stat_summary(fun.y="mean", geom="bar")
      
    })
    
    
})