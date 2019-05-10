library(shiny)
library(ggplot2)
library(ggrepel)

# Define server logic required to create the plots and other outputs

shinyServer(function(input, output) {
  
  round_data <- reactive({
    req(input$round_name, input$equipment_class)
    rounds %>% 
      filter(name == input$round_name,
             discipline == input$equipment_class
      )
  })
  
  point_table_data <- reactive({
    req(round_data())
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
                   ),
                   options = list(
                     placeholder = 'Please type or select a round',
                     onInitialize = I('function() { this.setValue(""); }')
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

  # output$score_input <- renderUI({
  #   numericInput("score_input",
  #                "Score",
  #                min = round_data()$min_score,
  #                max = round_data()$max_score,
  #                value = quantile(seq(round_data()$min_score, round_data()$max_score), 0.75),
  #                step = 1
  #                )
  # })
  
  output$score_input <- renderUI({
    sliderInput("score_input",
                "Score",
                min = round_data()$min_score,
                max = round_data()$max_score,
                value = quantile(seq(round_data()$min_score, round_data()$max_score), 0.75)
                )
  })
  
  output$point_plot <- renderPlot({
    req(point_table_data(), input$score_input)
    pt_x <- input$score_input
    pt_y <- point_table_data() %>%
      filter(Score == input$score_input) %>%
      select(Points)
    ggplot() +
      geom_line(data = point_table_data(), aes(x = Score, y = Points), color = "blue") +
      geom_point(aes(x = pt_x, y = pt_y[[1]]),
                 color = "red", size = 3) +
      geom_label_repel(aes(x = pt_x, y = pt_y[[1]]),
                       label = str_c("Score = ", pt_x, "\nPoints = ", round(pt_y, 1), sep = ""),
                       nudge_x = -55,
                       nudge_y = 20,
                       xlim = c(round_data()$min_score + 10, round_data()$max_score - 10)
                       ) +
      labs(
        title = "Performance Points Curve"
      )
  })
  
  output$point_table <- renderTable({
    req(point_table_data())
    point_table_data()
  },
    striped = TRUE,
    digits = 0
  )
  
})
