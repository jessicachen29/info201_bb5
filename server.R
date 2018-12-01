# INFORMATICS 201 TEAM BB5
# HELENA, SCARLETT, JESSICA, LUCY
# THIS PROGRAM REPRESENTS...

library(shiny)
library(ggplot2)

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
  
  output$plot3 <- renderPlot({
    data <- data %>% 
      filter(StageID == input$stage) %>% 
      group_by(Class) %>% 
      count(ParentAnsweringSurvey) %>% 
      mutate(percentage = n / sum(n) * 100)
    
    ggplot(data, aes(x=Class, y=percentage, fill=ParentAnsweringSurvey)) + 
      geom_bar(stat="identity")
  })
  
  output$table <- DT::renderDataTable(DT::datatable({
    if(input$gender != "All") {
      data <- data[data$gender == input$gender,]
    }
    if(input$NationalITy != "All") {
      data <- data[data$NationalITy == input$NationalITy,]
    }
    if(input$PlaceofBirth != "All") {
      data <- data[data$PlaceofBirth == input$PlaceofBirth,]
    }
    if(input$StageID != "All") {
      data <- data[data$StageID == input$StageID,]
    }
    if(input$GradeID != "All") {
      data <- data[data$GradeID == input$GradeID,]
    }
    if(input$SectionID != "All") {
      data <- data[data$SectionID == input$SectionID,]
    }
    if(input$Topic != "All") {
      data <- data[data$Topic == input$Topic,]
    }
    if(input$Semester != "All") {
      data <- data[data$Semester == input$Semester,]
    }
    if(input$Relation != "All") {
      data <- data[data$Relation == input$Relation,]
    }
    if(input$ParentAnsweringSurvey != "All") {
      data <- data[data$ParentAnsweringSurvey == input$ParentAnsweringSurvey,]
    }
    if(input$ParentschoolSatisfaction != "All") {
      data <- data[data$ParentschoolSatisfaction == input$ParentschoolSatisfaction,]
    }
    if(input$StudentAbsenceDays != "All") {
      data <- data[data$StudentAbsenceDays == input$StudentAbsenceDays,]
    }
    if(input$Class != "All") {
      data <- data[data$Class == input$Class,]
    }
    data
  }))
})
