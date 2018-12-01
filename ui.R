# INFORMATICS 201 TEAM BB5
# HELENA, SCARLETT, JESSICA, LUCY
# THIS PROGRAM REPRESENTS...

library(shiny)
library(ggplot2)

# Define UI for application that draws a histogram
shinyUI(
  navbarPage("Contents",
       tabPanel("Overview",
                mainPanel(
                  
                )
       ),
       tabPanel("One",
                # default so we could run the app
                sidebarLayout(
                  sidebarPanel(
                    radioButtons("plotType", "Plot type",
                                 c("Scatter" = "p", "Line" = "l")
                    )
                  ),
                  mainPanel(
                  )
                )
       ),
       tabPanel("Two",
                # default so we could run the app
                sidebarLayout(
                  sidebarPanel(
                    radioButtons("plotType", "Plot type",
                                 c("Scatter" = "p", "Line" = "l")
                    )
                  ),
                  mainPanel(
                  )
                )
       ),
       tabPanel("Three",
                sidebarLayout(
                  sidebarPanel(
                    radioButtons("plotType", "Plot type",
                                 c("Scatter"="p", "Line"="l")
                    )
                  ),
                  mainPanel(
                  )
                )
       ),
       tabPanel("Data Table",
                fluidRow(
                  column(3,
                         selectInput("gender",
                                     "Gender:",
                                     c("All",
                                       unique(as.character(data$gender))))
                  ),
                  column(3,
                         selectInput("NationalITy",
                                     "Nationality:",
                                     c("All",
                                       unique(as.character(data$NationalITy))))
                  ),
                  column(3,
                         selectInput("PlaceofBirth",
                                     "Place of Birth:",
                                     c("All",
                                       unique(as.character(data$PlaceofBirth))))
                  ),
                  column(3,
                         selectInput("StageID",
                                     "Educational Stages:",
                                     c("All",
                                       unique(as.character(data$StageID))))
                  ),
                  column(3,
                         selectInput("GradeID",
                                     "Grade Levels:",
                                     c("All",
                                       unique(as.character(data$GradeID))))
                  ),
                  column(3,
                         selectInput("SectionID",
                                     "Classroom Student Belongs:",
                                     c("All",
                                       unique(as.character(data$SectionID))))
                  ),
                  column(3,
                         selectInput("Topic",
                                     "Couorse Topic:",
                                     c("All",
                                       unique(as.character(data$Topic))))
                  ),
                  column(3,
                         selectInput("Semester",
                                     "Semester:",
                                     c("All",
                                       unique(as.character(data$Semester))))
                  ),
                  column(3,
                         selectInput("Relation",
                                     "Relation:",
                                     c("All",
                                       unique(as.character(data$Relation))))
                  ),
                  column(3,
                         selectInput("ParentAnsweringSurvey",
                                     "Parent Answering Survey:",
                                     c("All",
                                       unique(as.character(data$ParentAnsweringSurvey))))
                  ),
                  column(3,
                         selectInput("ParentschoolSatisfaction",
                                     "Parent School Satisfaction:",
                                     c("All",
                                       unique(as.character(data$ParentschoolSatisfaction))))
                  ),
                  column(3,
                         selectInput("StudentAbsenceDays",
                                     "Student Absence Days:",
                                     c("All",
                                       unique(as.character(data$StudentAbsenceDays))))
                  ),
                  column(3,
                         selectInput("Class",
                                     "Class:",
                                     c("All",
                                       unique(as.character(data$Class))))
                  )
                ),
                mainPanel(
                  DT::dataTableOutput("table")
                )
       ))
)
