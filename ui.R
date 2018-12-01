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
                                 c("Scatter"="p", "Line"="l")
                    )
                  ),
                  mainPanel(
                    plotOutput("plot")
                  )
                )
       ),
       tabPanel("Two",
                # default so we could run the app
                sidebarLayout(
                  sidebarPanel(
                    radioButtons("plotType", "Plot type",
                                 c("Scatter"="p", "Line"="l")
                    )
                  ),
                  mainPanel(
                    plotOutput("plot")
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
                dataTableOutput("table")
       )
  ))


