# Dashboard to show calculations for Performance Methods points

library(shiny)
library(tidyverse)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Performance Method Calculations"),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            width = 4,
            uiOutput("round_name"),
            uiOutput("equipment_class"),
            uiOutput("score_input"),
            
            hr(),
            p("The Performance Method is a project of the Minnesota Archers Alliance. Learn more about the
              MAA and our programs at our", a(href="https://themnaa.org/", "web site"), "or on", 
              a(href="www.facebook/com/MNArchersAlliance", "Facebook"), "."),
            img(src = "MAA_logo.png", width = "100%")
        ),
        
        # Show the points, curve, and calculator for the round
        mainPanel(
            fluidRow(
                column(width = 10,
                       plotOutput("point_plot")
                )
            ),
            fluidRow(
                column(width = 10,
                       htmlOutput("equation")
                       )
            ),
            fluidRow(
                column(width = 8,
                       tableOutput("point_table")
                )
            )
        ) #mainPanel
    ) #sidebarLayout
))
