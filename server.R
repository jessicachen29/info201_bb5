# INFORMATICS 201 TEAM BB5
# HELENA, SCARLETT, JESSICA, LUCY
# This app visualizes and explains student data
# from a learning management system.

library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(DT)

# Process and store data
data <- data.table::fread("data/xAPI-Edu-Data.csv")

shinyServer(function(input, output) {
  # Finds participation averages
  participation <- reactive({
    if (input$by_gender) {
      data <- group_by(data, Class, gender)
    } else {
      data <- group_by(data, Class)
    }
    data <- summarize(
      data,
      raisedhands = mean(raisedhands),
      VisITedResources = mean(VisITedResources),
      AnnouncementsView = mean(AnnouncementsView),
      Discussion = mean(Discussion)
    )
  })
  
  # Renders text displaying the overall average
  # participation of the selected type
  output$mean_participation <- renderText({
    paste(
      "For the selected type of participation, the average score",
      "across all grade categories and genders is",
      round(mean(data[, get(input$participation_select)]), 2),
      "."
    )
  })
  
  # Renders a bar graph of grades vs. participation
  output$plot1 <- renderPlot({
    if (input$by_gender) {
      fill <- "gender"
      color <- c("#F8766D", "#00BFC4")
      legend <- guide_legend(title = "Gender")
    } else {
      fill <- "Class"
      color <- c("L" = "turquoise", "M" = "darkblue", "H" = "purple")
      legend <- FALSE
    }
    
    if (input$participation_select == "raisedhands") {
      y_lab <- "Avg. Number of Hands Raised"
    } else if (input$participation_select == "VisITedResources") {
      y_lab <- "Avg. Number of Times Visiting Resources"
    } else if (input$participation_select == "AnnouncementsView") {
      y_lab <- "Avg. Number of Announcements Viewed"
    } else {
      y_lab <- "Avg. Number of Times Participating in Online Discussions"
    }
    
    ggplot(participation()) +
      geom_col(
        mapping = aes(
          x = Class,
          y = get(input$participation_select),
          fill = get(fill)
        ),
        position = position_dodge()
      ) +
      labs(x = "Grade", y = y_lab, title = paste(y_lab, "vs. Grade")) +
      ylim(0, 100) +
      scale_x_discrete(
        limits = c("L", "M", "H"),
        labels = c("Low (0-69)", "Middle (70-89)", "High (90-100)")
      ) +
      scale_fill_manual("legend", values = color) +
      guides(fill = legend)
  })
  
  # Renders a pie chart of country percentages
  # for the selected grade category
  output$plot2 <- renderPlot({
    grades <- select(data, Class, NationalITy)
    
    high <- filter(grades, Class == "H") 
    mid <- filter(grades, Class == "M")
    low <- filter(grades, Class == "L")
    
    country_counts <- 
      grades %>% 
      group_by(NationalITy) %>% 
      summarize(n = n())
    country_counts_grades <- 
      grades %>% 
      group_by(NationalITy, Class) %>% 
      summarize(n = n())
    
    country_counts_grades <-
      country_counts_grades %>% 
      left_join(country_counts, by = "NationalITy")
    
    if (input$grades == "High-Level (90-100)") {
      g <- country_counts_grades %>% 
        filter(Class == "H") %>% 
        ggplot()
      g + geom_col(aes(x = NationalITy, y = n.x / n.y * 100, fill = NationalITy)) +
        labs(x = "Nationality", y = "Percent of Students with High Grades", 
             title = "Nationality vs. Percent of Students with High Grades",
             fill = "Nationality")
      
    } else if (input$grades == "Middle-Level (70-89)") {
      g <- country_counts_grades %>% 
        filter(Class == "M") %>% 
        ggplot()
      g + geom_col(aes(x = NationalITy, y = n.x / n.y * 100, fill = NationalITy)) +
        labs(x = "Nationality", y = "Percent of Students with Mid Grades", 
             title = "Nationality vs. Percent of Students with Mid Grades",
             fill = "Nationality")
      
    } else {
      g <- country_counts_grades %>% 
        filter(Class == "L") %>% 
        ggplot()
      g + geom_col(aes(x = NationalITy, y = n.x / n.y * 100, fill = NationalITy)) +
        labs(x = "Nationality", y = "Percent of Students with Low Grades",
             title = "Nationality vs. Percent of Students with Low Grades",
             fill = "Nationality")
      
    }
  })
  
  # Renders a bar graph of grades vs. parent survey response
  # for the selected school stage
  output$plot3 <- renderPlot({
    data <- data %>% 
      filter(StageID == input$stage) %>% 
      group_by(Class) %>% 
      count(ParentAnsweringSurvey) %>% 
      mutate(percentage = n / sum(n) * 100) %>% 
      mutate(ypos = cumsum(n) - 0.5 * n)
    
    data$Class <- factor(
      data$Class,
      levels = c("L", "M", "H"),
      label = c("Low (0-69)", "Middle (70-89)", "High (90-100)")
    )
    ggplot(
      data,
      aes(x = Class, y = percentage, fill = ParentAnsweringSurvey)
    ) +
      geom_bar(stat = "identity") +
      geom_text(aes(label = paste0(sprintf("%1.1f", percentage), "%")),
                position = position_stack(vjust = 0.5)) +
      labs(title = "Parental Survey Response Rate by Students' Grades",
           fill = "Parent Responded to Survey") +
      xlab ("Grade Level") +
      ylab("Percentage of Parents Responding Survey (%)")
  })
  
  # Renders text displaying the total number of
  # students in the displayed data and the number
  # of those who responded to the survey
  output$numOfResponse <- renderText({
    numberOfStudents <- data %>% 
      filter(StageID == input$stage) %>% 
      nrow()
    numberOfResponses <- data %>% 
      filter(StageID == input$stage) %>%  
      filter(ParentAnsweringSurvey == "Yes") %>% 
      nrow()
    paste0(
      "There are ",
      numberOfStudents,
      " students in the selected school stage, out of which ",
      numberOfResponses, 
      " students had their parents respond to the school survey."
    )
  })
  
  # Renders a data table filtered by selected dropdowns
  output$table <- DT::renderDataTable(DT::datatable({
    if (input$gender != "All") {
      data <- data[data$gender == input$gender, ]
    }
    if (input$NationalITy != "All") {
      data <- data[data$NationalITy == input$NationalITy, ]
    }
    if (input$PlaceofBirth != "All") {
      data <- data[data$PlaceofBirth == input$PlaceofBirth, ]
    }
    if (input$StageID != "All") {
      data <- data[data$StageID == input$StageID, ]
    }
    if (input$GradeID != "All") {
      data <- data[data$GradeID == input$GradeID, ]
    }
    if (input$SectionID != "All") {
      data <- data[data$SectionID == input$SectionID, ]
    }
    if (input$Topic != "All") {
      data <- data[data$Topic == input$Topic, ]
    }
    if (input$Semester != "All") {
      data <- data[data$Semester == input$Semester, ]
    }
    if (input$Relation != "All") {
      data <- data[data$Relation == input$Relation, ]
    }
    if (input$ParentAnsweringSurvey != "All") {
      data <- data[data$ParentAnsweringSurvey == input$ParentAnsweringSurvey, ]
    }
    if (input$ParentschoolSatisfaction != "All") {
      data <-
        data[data$ParentschoolSatisfaction == input$ParentschoolSatisfaction, ]
    }
    if (input$StudentAbsenceDays != "All") {
      data <- data[data$StudentAbsenceDays == input$StudentAbsenceDays, ]
    }
    if (input$Class != "All") {
      data <- data[data$Class == input$Class, ]
    }
    data
  }))
})