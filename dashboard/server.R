library(shiny)
library(ggplot2)
library(ggrepel)
library(kableExtra)

# Define server logic required to create the plots and other outputs

shinyServer(function(input, output) {

  # "Pretty print" the data frame in a multi-column table
  # Credit to Onyambu via Stack Overflow
  # https://stackoverflow.com/users/8380272/onyambu
  reshape_table <- function(dat, cols = 4) {
    n = nrow(dat)
    m = ceiling(n/cols)
    time=rep(1:cols, each = m, len = n)
    id = rep(1:m, times = cols, len = n)
    reshape(cbind(id, time, dat), idvar = 'id', dir='wide')[-1]
  }
  
  round_data <- reactive({
    req(input$round_name, input$equipment_class)
    rounds %>% 
      filter(name == input$round_name,
             discipline == input$equipment_class
      )
  })
  
  point_table_data <- reactive({
    req(round_data())
    min_pts <- round_data()$low_score
    max_pts <- round_data()$max_score
    point_tbl <- tibble(Score = seq(min_pts, max_pts))
    if (round_data()$model == "exp") {
      point_tbl %>% mutate(Points = 100 * exp(round_data()$a * (Score - round_data()$high_score)))
    } else {
      point_tbl %>% mutate(Points = round_data()$slope * Score + round_data()$intercept)
    }
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
  
  output$equation <- renderUI({
    withMathJax(
      helpText('Performance Point Equation')
      )
  })
  
  output$equipment_class <- renderUI({
    radioButtons("equipment_class",
                 "Equipment Class",
                 selected = "Compound",
                 choices = c("Compound", "Recurve")
    )
  })

  output$score_input <- renderUI({
    sliderInput("score_input",
                "Score",
                min = round_data()$low_score,
                max = round_data()$max_score,
                value = quantile(seq(round_data()$low_score, round_data()$max_score), 0.75)
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
      geom_label_repel(aes(x = pt_x, y = pt_y[[1]]),
                       label = str_c("Score = ", pt_x, "\nPoints = ", round(pt_y, 1), sep = ""),
                       nudge_x = -25,
                       nudge_y = 10,
                       xlim = c(round_data()$low_score + 10, round_data()$max_score - 10)
                       ) +
      geom_point(aes(x = pt_x, y = pt_y[[1]]),
                 color = "red", size = 3) +
      labs(
        title = "Performance Points Curve",
        subtitle = str_c(input$round_name, " Round (", input$equipment_class, ")", sep = ""),
        x = "Score",
        y = "Performance Points"
      )
  })
  
  output$point_table <- function() {
    req(point_table_data())
    multicol_table <- reshape_table(point_table_data(), 5)
    options(knitr.kable.NA = '')
    kable(multicol_table,
          col.names = c("Score", "Points", "Score", "Points", "Score", "Points", "Score", "Points", "Score", "Points"),
          align = c("c", "c", "c", "c", "c", "c", "c", "c", "c", "c"),
          digits = c(0, 1, 0, 1, 0, 1, 0, 1, 0, 1),
          caption = "Table of Scores and Performance Points"
    ) %>% 
      column_spec(column = 2, border_right = T) %>% 
      column_spec(column = 4, border_right = T) %>% 
      column_spec(column = 6, border_right = T) %>% 
      column_spec(column = 8, border_right = T) %>%
      kable_styling(bootstrap_options = c("striped", "responsive"), full_width = F, position = "left")
  }
})
