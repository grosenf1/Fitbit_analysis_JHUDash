load("data/all_data.Rdata")

library(ggplot2)

shinyServer(
  
  function(input, output) {
    #data <- all_data[all_data$id==input$id,]
    
    output$idText <- renderText({ 
      paste("Displaying subject", input$id, ":")
    })
    
    output$dateText<- renderText({
      paste(input$start.end.date[1], "until", input$start.end.date[2])
    })
    
    output$stepsPlot <- renderPlot({
      data <- all_data[all_data$id==input$id,]
      data <- data[as.Date(data$date) >= as.Date(input$start.end.date[1]),]
      data <- data[as.Date(data$date) <= as.Date(input$start.end.date[2]),]
      ggplot(data=data,aes(x=time,y=steps,group=1)) + geom_line()
    })
    
    
})