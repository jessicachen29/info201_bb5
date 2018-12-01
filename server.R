# INFORMATICS 201 TEAM BB5
# HELENA, SCARLETT, JESSICA, LUCY
# THIS PROGRAM REPRESENTS...

library(shiny)
library(ggplot2)
library(dplyr)

data <- data.table::fread("data/xAPI-Edu-Data.csv")
participation <-
  data %>%
  select(raisedhands, VisITedResources, AnnouncementsView, Discussion, Class) %>% 
  group_by(Class) %>% 
  summarize(
    avg_hands = mean(raisedhands),
    avg_resources = mean(VisITedResources),
    avg_announcements = mean(AnnouncementsView),
    avg_discuss = mean(Discussion)
  )

shinyServer(function(input, output) {

  output$plot1 <- renderPlot({
    ggplot(participation) +
      geom_col(mapping = aes(x = reorder(Class, c(3, 1, 2)), y = avg_hands)) +
      labs(x = "Grade", y = "Average Hands Raised")
  })
  
  output$table <- renderDataTable({
    datatable(data)
  })

})
