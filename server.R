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
  
  output$plot3 <- renderPlot({
    data <- data %>% 
      filter(StageID == input$stage) %>% 
      group_by(Class) %>% 
      count(ParentAnsweringSurvey) %>% 
      mutate(percentage = n / sum(n) * 100)
    data$Class <- factor(data$Class, levels=c("L", "M", "H"))
    
    ggplot(data, aes(x=Class, y=percentage, fill=ParentAnsweringSurvey)) + 
               geom_bar(stat="identity") +
               labs(title= "Parental Invovlement by Students' Grades")+
                xlab("Grade Level") + ylab("Percentage (%)")
  })
})
