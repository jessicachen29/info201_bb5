# INFORMATICS 201 TEAM BB5
# HELENA, SCARLETT, JESSICA, LUCY
# This app visualizes and explains student data
# from a learning management system.

library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(DT)

# Define UI for application
shinyUI(
  # Make tabs/nav bars
  navbarPage(
    "Learning Management System Data",
    tabPanel(
      "Overview",
      mainPanel(
        h3("Project Overview"),
        p("In order to teach effectively, it is important that educators
          understand the factors that influence student performance. This
          project seeks to provide that information by visualizing data from
          a learning management system."),
        h4("Audience"),
        p("Our target audience is educators who want to learn what factors
          affect student performance, particularly in relation to learning
          management systems."),
        h4("Data"),
        p("The dataset we will be using is \"Students' Academic Performance
          Dataset,\" which was collected by Elaf Abu Amrieh, Thair Hamtini,
          and Ibrahim Aljarah from the University of Jordan. We accessed it
          on Kaggle (https://www.kaggle.com/aljarah/xAPI-Edu-Data/home). It
          is an educational dataset collected from the learning management
          system Kalboard 360, which allows students to access educational
          resources from any device connected to the internet and monitors
          their learning progress and behaviors. The dataset consists of a
          sample of 480 students and their associated attributes, including
          gender, grade level, participation in discussion groups, absences,
          and more. The students are also classified into numeric intervals
          based on their grades."),
        h4("Questions to Consider"),
        tags$ol(
          tags$li("Which grade category has the highest average participation?
                  How does this vary between genders?"), 
          tags$li("Which country's students get the greatest proportion
                  of high grades? Low grades?"), 
          tags$li("Which grade category has the highest parental survey
                  response rate? How does the response rate differ by
                  school stages?")
          ),
        h4("Project Creators"),
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
          # Make participation type selection buttons
          radioButtons(
            "participation_select",
            "Type of Participation",
            c(
              "Raised hand" = "raisedhands",
              "Visiting Resources" = "VisITedResources",
              "Viewing Announcements" = "AnnouncementsView",
              "Discussion Groups" = "Discussion"
            )
          ),
          # Make gender split selection buttons
          radioButtons(
            "by_gender",
            "View by Gender?",
            c("Yes" = TRUE, "No" = FALSE),
            selected = FALSE
          )
        ),
        mainPanel(
          h3("Participation and Academic Achievement"),
          p("The bar graph below shows the average number of times students
            from each grade category (low, middle, or high) engage in each
            type of participation recorded in the dataset. Use the buttons on
            the upper left to choose the type of participation displayed. To
            see the information split by gender, select \"Yes\" from the lower
            set of buttons."),
          p("For every type of participation shown, the average number of
            times a student participates increases as student grade
            increases, so students with high grades participated the most
            times on average. This trend mostly holds when the data are
            split by gender, except that females with low grades have an
            unexpectedly high average number of times participating in
            discussions."),
          p("Because we do not know how students' overall grades were
            calculated, we also do not know how they relate to participation.
            If students' grades were based directly on these numbers, at
            least part of the correlation would be easily explained. If these
            types of participation were optional, it could suggest that
            actively participating causes students to get better grades, or
            that there is an additional variable causing both participation
            and grades to increase at the same time. Unfortunately this
            relationship cannot be determined with the given data, but
            more research should be done. In the meantime, it couldn't hurt
            to encourage students to actively participate using their
            learning management systems."),
          br(),
          plotOutput("plot1"),
          textOutput("mean_participation"),
          br()
          )
          )
        ),
    tabPanel(
      "Nationality vs. Grades",
      sidebarLayout(
        sidebarPanel(
          # Make buttons with three choices of grade sectors
          radioButtons(
            "grades",
            "Grades",
            c(
              "High-Level (90-100)",
              "Middle-Level (70-89)",
              "Low-Level (0-69)"
            )
          )
        ),
        mainPanel(
          # Provide tab overview and summary 
          h3("Nationality and Academic Achievement"),
          p("The students are classified into three numerical intervals based
            on their total grade or mark: Low-Level (interval includes values
            from 0 to 69), Middle-Level (70 to 89), and High-Level (90-100)."),
          p("Explore the percentages of students belonging to each grade category
            for the countries in the data by adjusting the displayed category
            with the buttons on the left."),
          p("The country with the greatest percentage of students with high
            grades is Venezuela (100%), but this is because there is only
            one student in the entire dataset from that country. The country
            with the next greatest percent of high grades is Iraq. For middle
            level grades, students of Iran had the highest percentage and
            closely followed by Palestine. Lastly, for the lowest grade,
            the students of Lybia had the highest percent."),
          p("Unfortunately there are limitations due to the size of the
            dataset. For example, it is impossible to determine anything
            about grades in Venezuela with only a single observation. In
            addition, it is impossible to determine the reasons for the
            differences in grades based on these data alone. For these reasons,
            a large study examining academic achievement across countries would
            be beneficial. However, the data here do show clear differences
            between the countries, so it may be wise to consider these when
            teaching in different countries."),
          br(),
          # Draw plot
          plotOutput("plot2"),
          br()
          )
          )
          ),
    tabPanel(
      "Parental Involvement vs. Grades",
      sidebarLayout(
        sidebarPanel(
          # Make school stage selection dropdown
          selectInput(
            inputId = "stage",
            label = "School stage: ",
            c(
              "Elementary School" = "lowerlevel",
              "Middle School" = "MiddleSchool",
              "High School" = "HighSchool"
            )
          )
        ),
        mainPanel(
          h3("Parental Involvement and Academic Achievement"),
          p("The bar graph below displays the percentage of parents that
            responded to school surveys for students from each of the three
            different grade categories. The drop down menu on the side can
            be used to select the type of the student represented in the graph:
            elementary school, middle school, or high school."),
          p("From the chart of each school stage, we can see that parents'
            response rates on surveys tend to be higher for students who have
            higher grades. As the chart displays, students who have high grades
            have the highest parental survey response rate, followed by
            students with grades in the middle and low ranges."),
          p("Parental survey response rate, as a form of parental involvement
            in students' academic performance, seems to be associated
            with students' academic achievement. That is, students who have
            higher academic achievement tend to have parents that are attentive
            to their school performances."),
          p("It is important to note that this does not imply causation,
            so it is not possible to tell from these data whether increasing
            parental involvement would increase student achievement. However,
            the data do indicate that students whose parents do not answer
            school surveys are statistically less likely to succeed. Therefore,
            regardless of the reason, it may be beneficial to provide students
            with additional attention and resources if they appear to be at
            risk of underachievement based on a lack of indicators of parental
            involvement, such as response to school surveys."),
          br(),
          plotOutput("plot3"),
          textOutput("numOfResponse"),
          br()
          )
          )
          ),
    tabPanel("Data",
             sidebarLayout(
               # Make dropdowns that filter data table
               sidebarPanel(
                 selectInput(
                   "gender",
                   "Gender:",
                   c("All", unique(as.character(data$gender)))
                 ),
                 selectInput(
                   "NationalITy",
                   "Nationality:",
                   c("All", unique(as.character(data$NationalITy)))
                 ),
                 selectInput(
                   "PlaceofBirth",
                   "Place of Birth:",
                   c("All", unique(as.character(data$PlaceofBirth)))
                 ),
                 selectInput(
                   "StageID",
                   "Educational Stages:",
                   c("All", unique(as.character(data$StageID)))
                 ),
                 selectInput(
                   "GradeID",
                   "Grade Levels:",
                   c("All", unique(as.character(data$GradeID)))
                 ),
                 selectInput(
                   "SectionID",
                   "Classroom Student Belongs:",
                   c("All", unique(as.character(data$SectionID)))
                 ),
                 selectInput(
                   "Topic",
                   "Course Topic:",
                   c("All", unique(as.character(data$Topic)))
                 ),
                 selectInput(
                   "Semester",
                   "Semester:",
                   c("All", unique(as.character(data$Semester)))
                 ),
                 selectInput(
                   "Relation",
                   "Relation:",
                   c("All", unique(as.character(data$Relation)))
                 ),
                 selectInput(
                   "ParentAnsweringSurvey",
                   "Parent Answering Survey:",
                   c("All", unique(as.character(data$ParentAnsweringSurvey)))
                 ),
                 selectInput(
                   "ParentschoolSatisfaction",
                   "Parent School Satisfaction:",
                   c("All", unique(as.character(data$ParentschoolSatisfaction)))
                 ),
                 selectInput(
                   "StudentAbsenceDays",
                   "Student Absence Days:",
                   c("All", unique(as.character(data$StudentAbsenceDays)))
                 ),
                 selectInput(
                   "Class",
                   "Class:",
                   c("All", unique(as.character(data$Class)))
                 ),
                 width = 2
               ),
               mainPanel(
                 h3("Data"),
                 p("Here you can view the data this project is based on.
          Use the dropdown menus to the left to filter the data so only
          students who match the chosen conditions are displayed. The
          search bar can be used to search for specific values; for example,
          searching \"USA\" would cause the table to display only those
          students who were born in or live in the United States."),
                 br(),
                 DT::dataTableOutput("table")
               )
             )
    )
    )
  )