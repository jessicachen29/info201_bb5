# INFORMATICS 201 TEAM BB5
# HELENA, SCARLETT, JESSICA, LUCY
# THIS PROGRAM REPRESENTS...

library(shiny)
library(ggplot2)
library(dplyr)

data <- data.table::fread("data/xAPI-Edu-Data.csv")

shinyServer(function(input, output) {
   
  output$plot <- renderPlot({
    plot(data$AnnouncementsView, type=input$plotType)
  })
  
  output$table <- renderDataTable({
    datatable(data)
  })
  
  output$plot3 <- renderPlot({
    data <- data %>% 
      filter(StageID == input$stage) %>% 
      group_by(Class) %>% 
      count(ParentAnsweringSurvey) %>% 
      mutate(percentage = n / sum(n) * 100)
    
    ggplot(data, aes(x=Class, y=percentage, fill=ParentAnsweringSurvey)) + 
               geom_bar(stat="identity")
  })
  
})
