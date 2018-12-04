# INFORMATICS 201 TEAM BB5
# HELENA, SCARLETT, JESSICA, LUCY
# THIS PROGRAM REPRESENTS...

library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(DT)

data <- data.table::fread("data/xAPI-Edu-Data.csv")


shinyServer(function(input, output) {
  participation <- reactive({
    data %>% select(raisedhands, VisITedResources, AnnouncementsView, Discussion, Class, gender)
    if (input$by_gender) {
      data <- group_by(data, Class, gender)
    } else {
      data <- group_by(data, Class)
    }
    data <- summarize(
      data,
      avg_hands = mean(raisedhands),
      avg_resources = mean(VisITedResources),
      avg_announcements = mean(AnnouncementsView),
      avg_discuss = mean(Discussion)
    )
  })
  
  output$plot1 <- renderPlot({
    if (input$by_gender) {
      fill <- "gender"
      color <- c("#F8766D", "#00BFC4")
      legend <- guide_legend(title = "Gender")
    } else {
      fill <- "Class"
      color <- c("L" = "turquoise", "M" = "darkblue", "H" = "purple")
      legend = FALSE
    }
    
    if (input$participation_select == "avg_hands") {
      y_lab <- "Avg. Number of Hands Raised"
    } else if (input$participation_select == "avg_resources") {
      y_lab <- "Avg. Number of Times Visiting Resources"
    } else if (input$participation_select == "avg_announcements") {
      y_lab <- "Avg. Number of Announcements Viewed"
    } else {
      y_lab <- "Avg. Number of Times Participating in Online Discussions"
    }
    
    ggplot(participation()) +
      geom_col(mapping = aes(x = Class, y = get(input$participation_select), fill = get(fill)), position = position_dodge()) +
      labs(x = "Grade", y = y_lab, title = paste(y_lab, "vs. Grade")) +
      ylim(0, 100) +
      scale_x_discrete(limits = c("L", "M", "H"), labels = c("Low (0-69)", "Middle (70-89)", "High (90-100)")) +
      scale_fill_manual("legend", values = color) +
      guides(fill = legend)
  })
  
  output$plot2 <- renderPlot({
    grades <- select(data, Class, NationalITy)
    
    high <- filter(grades, Class == 'H') 
    mid <- filter(grades, Class == 'M')
    low <- filter(grades, Class == 'L')
    
    if (input$grades == "High") {
      bp <- ggplot(high, aes(x="", y = nrow(high), fill = NationalITy)) +
        geom_bar(width = 1, stat = "identity")
      pie <- bp + coord_polar("y", start=0)
      
      pie <- pie + ggtitle("Students with High Grades from Different Countries") +
        xlab("") + ylab("Number of Students") +
        labs(fill = "Nationality")
      return(pie)
      
    } else if (input$grades == "Mid") {
      bp <- ggplot(mid, aes(x="", y = nrow(mid), fill = NationalITy))+
        geom_bar(width = 1, stat = "identity")
      pie <- bp + coord_polar("y", start=0)
      
      pie <- pie + ggtitle("Students with Mid Grades from Different Countries") +
        xlab("") + ylab("Number of Students") +
        labs(fill = "Nationality")
      return(pie)
      
    } else {
      bp <- ggplot(low, aes(x="", y = nrow(low), fill = NationalITy))+
        geom_bar(width = 1, stat = "identity")
      pie <- bp + coord_polar("y", start=0)
      
      pie <- pie + ggtitle("Students with Low Grades from Different Countries") +
        xlab("") + ylab("Number of Students") +
        labs(fill = "Nationality")
      return(pie)
    }
  })
  
  
  output$plot3 <- renderPlot({
    data <- data %>% 
      filter(StageID == input$stage) %>% 
      group_by(Class) %>% 
      count(ParentAnsweringSurvey) %>% 
      mutate(percentage = n / sum(n) * 100) %>% 
      mutate(ypos = cumsum(n) - 0.5*n)
    data$Class <- factor(data$Class, levels = c("L", "M", "H"), label = c("Low (0-69)", "Middle (70-89)", "High (90-100)"))
    
    ggplot(data, aes(x = Class, y = percentage, fill = ParentAnsweringSurvey)) + 
      geom_bar(stat = "identity") +
      geom_text(aes(label = paste0(sprintf("%1.1f", percentage), "%")),
                position = position_stack(vjust=0.5)) +
      labs(title = "Parental Survey Response Rate by Students' Grades") +
      xlab ("Grade Level") +
      ylab("Percentage of Parents Responding Survey (%)")
  })
  
  output$numOfResponse <- renderText({
    numberOfStudents <- data %>% 
      filter(StageID == input$stage) %>% 
      nrow()
    numberOfResponses <- data %>% 
      filter(StageID == input$stage) %>%  
      filter(ParentAnsweringSurvey == "Yes") %>% 
      nrow()
    paste0("There are ", numberOfStudents, " students in the selected school stage in which ", numberOfResponses, 
           " students have their parents responded to the school survey.")
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