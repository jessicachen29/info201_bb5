# INFORMATICS 201 TEAM BB5
# HELENA, SCARLETT, JESSICA, LUCY
# THIS PROGRAM REPRESENTS...

library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(DT)

# Define UI for application
shinyUI(
  navbarPage("Contents",
             tabPanel("Overview",
                      mainPanel(
                      )
             ),
             tabPanel(
               "Participation vs. Grades",
               sidebarLayout(
                 sidebarPanel(
                   radioButtons(
                     "participation_select",
                     "Type of Participation",
                     c(
                       "Raised hand" = "avg_hands",
                       "Visiting Resources" = "avg_resources",
                       "Viewing Announcements" = "avg_announcements",
                       "Discussion Groups" = "avg_discuss"
                     )
                   ),
                   radioButtons(
                     "by_gender",
                     "View by Gender?",
                     c(
                       "Yes" = TRUE,
                       "No" = FALSE
                     )
                   )
                 ),
                 mainPanel(
                   plotOutput("plot1"),
                   textOutput("pwd")
                 )
               )
             ),
             tabPanel("Nationality vs Grades",
                      sidebarLayout(
                        sidebarPanel(
                          radioButtons("grades", "Grades",
                                       c("High", "Mid", "Low")
                          )
                        ),
                        mainPanel(
                          plotOutput("plot2")
                        )
                      )
             ),
             tabPanel("Parental Involvement vs. Grades",
                      sidebarLayout(
                        sidebarPanel(
                          selectInput(
                            inputId = "stage",
                            label = "School stage: ",
                            c("Elementary School" = "lowerlevel", "Middle School" = "MiddleSchool"
                              ,"High School" = "HighSchool")
                          )
                        ),
                        mainPanel(
                          plotOutput("plot3")
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
