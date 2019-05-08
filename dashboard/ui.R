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
            width = 3,
            selectInput("round_name",
                        "Choose a round",
                        choices = c("NFAA", "USA Archery"),
                        selected = ""
                        ),
            
            hr(),
            p("The Performance Method is a project of the Minnesota Archers Alliance. Learn more about the
              MAA and our programs at our", a(href="https://themnaa.org/", "web site"), "or on", 
              a(href="www.facebook/com/MNArchersAlliance", "Facebook"), "."),
            img(src = "MAA_logo.png", width = "100%")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            fluidRow(
                column(width = 9,
                       "Column A"),
                column(width = 3,
                       "Column B")
            )
        )
    )
))
