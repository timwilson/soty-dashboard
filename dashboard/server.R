
library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    output$round_name <- renderUI({
        selectInput("round_name",
                    "Choose a round",
                    selected = "",
                    choices = c(rounds %>% 
                                    select(name) %>% 
                                    arrange(name)
                                )
                    )
    })

})
