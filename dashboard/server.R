library(shiny)
library(ggplot2)

# Define server logic required to create the plots and other outputs

shinyServer(function(input, output) {
  
  round_data <- reactive({
    rounds %>% 
      filter(name == input$round_name,
             discipline == input$equipment_class
      )
  })
  
  point_table_data <- reactive({
    min_pts <- round_data()$min_score
    max_pts <- round_data()$max_score
    point_tbl <- tibble(Score = seq(min_pts, max_pts))
    point_tbl %>% 
      mutate(Points = 100 * exp(round_data()$a * (Score - round_data()$high_score))
      )
  })
  
  output$round_name <- renderUI({
    selectizeInput("round_name",
                   "Choose a round",
                   selected = "",
                   choices = c(rounds %>% 
                                 select(name) %>% 
                                 arrange(name)
                   )
    )
  })
  
  output$equipment_class <- renderUI({
    radioButtons("equipment_class",
                 "Equipment Class",
                 selected = "Compound",
                 choices = c("Compound", "Recurve")
    )
  })
  
  output$point_plot <- renderPlot({
    if (is.null(point_table_data()) || input$round_name == "") {
      return()
    }
    ggplot(data = point_table_data(), aes(x = Score, y = Points)) +
      geom_smooth(se = FALSE) +
      labs(
        title = "Performance Points Curve"
      )
  })
  
  output$point_table <- renderTable({
    point_table_data()
  },
    striped = TRUE,
    digits = 0
  )
  
})
