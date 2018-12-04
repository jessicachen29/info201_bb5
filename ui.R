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
  navbarPage("Learning Management System Data",
             tabPanel("Overview",
                      mainPanel(
                        tags$h1("Learning Management System Data"),
                        tags$br(),
                        tags$h4("Project Overview"),
                        tags$p("In order to teach effectively, it is important that educators understand the 
                               factors that influence student performance. This project seeks to provide that 
                               information by visualizing data from a learning management system. "),
                        tags$br(),
                        tags$h4("Audience"),
                        tags$p("Our target audience is educators who want to learn what factors affect student 
                               performance, particularly in relation to learning management systems."),
                        tags$br(),
                        tags$h4("Data"),
                        tags$p("The dataset we will be using is “Students’ Academic Performance Dataset,” 
                               which was collected by Elaf Abu Amrieh, Thair Hamtini, and Ibrahim Aljarah 
                               from the University of Jordan. We accessed it on Kaggle (https://www.kaggle.com/aljarah/xAPI-Edu-Data/home). 
                               It is an educational dataset collected from the learning management system Kalboard 360, 
                               which allows students to access educational resources from any device connected 
                               to the internet and monitors their learning progress and behaviors. The dataset 
                               consists of a sample of 480 students and their associated attributes, including gender, 
                               grade level, participation in discussion groups, absences, and more. The students are also 
                               classified into numeric intervals based on their grades."),
                        tags$br(),
                        tags$h4("Questions"),
                        tags$ol(
                          tags$li("Which grade category has the highest average participation? What are the differences in 
                                  the average participation scores? How does this vary between genders?"), 
                          tags$li("Which country’s students have the highest and lowest mean of academic achievements?"), 
                          tags$li("Which grade category has the highest parental survey response rate? How does the response 
                                  rate differ by school stages?")
                          ),
                        tags$br(),
                        tags$h4("Project Creators"),
                        tags$ol(
                          tags$li("Helena Stafford"), 
                          tags$li("Scarlett Hwang"), 
                          tags$li("Jessica Chen"),
                          tags$li("Lucy Lee")
                        ),
                        tags$br(),
                        tags$br()
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
                            c("Elementary School" = "lowerlevel", "Middle School" = "MiddleSchool",
                              "High School" = "HighSchool")
                          )
                        ),
                        mainPanel(
                          h2("Parental Involvment and Academic Achievement"),
                          p("The bar graph below displays percentages of parents, of students from 
                              three different grade categories, that have responded to school surveys.
                              The drop down menu on the side can be used to show data by three school 
                              stages: elementary school, middle school, and high school."),
                          p("From the chart of each school stage, we can see that parents’ response rate on
                              surveys tend to be higher for students who have higher grades. As the chart displays,
                              students who’re placed in High grade category have the highest parental survey response rate,
                              followed by students being placed in Middle grade category and Low grade category."),
                          p("Parental survey response rate, as a form of parental involvement in students’ academic 
                              performance, seems to have an association with students’ academic achievement. That is, students
                              who have higher academic achievement tend to have parents that are attentive to their school performances."),
                          plotOutput("plot3"),
                          textOutput("numOfResponse")
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