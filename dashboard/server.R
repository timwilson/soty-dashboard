library(shiny)
library(DT)

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
      mutate(Points = round(100 * exp(round_data()$a * (Score - round_data()$high_score)))
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
  
  output$point_table <- DT::renderDataTable({
    datatable(point_table_data(),
              #columnDefs = list(list(orderable = FALSE, targets = c(1, 2))),
              options = list(
                columns = list(
                  list(orderable = FALSE, targets = c(1,2))#,
                  #list(visible = TRUE, targets = c(1,2))
                  ),
                paging = TRUE,
                pagingType = "simple",
                pageLength = 50,
                searching = FALSE
              )
    )
  })
  
})
