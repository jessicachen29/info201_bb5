# INFORMATICS 201 TEAM BB5
# HELENA, SCARLETT, JESSICA, LUCY
# THIS PROGRAM REPRESENTS...

library(shiny)
library(ggplot2)

data <- data.table::fread("data/xAPI-Edu-Data.csv")

shinyServer(function(input, output) {
   
  output$plot <- renderPlot({
    plot(data$AnnouncementsView, type=input$plotType)
  })
  
  output$table <- renderDataTable({
    datatable(data)
  })
})
