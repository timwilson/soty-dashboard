
library(shiny)

# Define server logic required to create the plots and other outputs
shinyServer(function(input, output) {
    
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

})
