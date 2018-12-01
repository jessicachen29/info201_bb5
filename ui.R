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
       tabPanel("Participation vs. Grades",
                # default so we could run the app
                sidebarLayout(
                  sidebarPanel(
                    radioButtons("participation_select", "Type of Participation",
                                 c(
                                   "Raised hand" = "raisedhands",
                                   "Visiting Resources" = "VisITedResources",
                                   "Viewing Announcements"="AnnouncementsViewed",
                                   "Discussion Groups" = "Discussion"
                                 )
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
       tabPanel("Three",
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
       tabPanel("Data Table",
                dataTableOutput("table")
       )
  ))


