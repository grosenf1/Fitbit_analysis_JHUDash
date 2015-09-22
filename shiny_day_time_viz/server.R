load("data/all_data.Rdata")

library(ggplot2)

shinyServer(
  
  function(input, output) {
    #data <- all_data[all_data$id==input$id,]
    
    output$idText <- renderText({ 
      paste("Displaying subject", input$id, ":")
    })
    
    output$stepsPlot <- renderPlot({
      data <- all_data[all_data$id==input$id,]
      ggplot(data=data,aes(x=time,y=steps,group=1)) + geom_line()
    })
    
    
})