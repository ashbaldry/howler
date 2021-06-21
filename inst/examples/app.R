library(shiny)
library(howler)

ui <- fluidPage(
  useHowlerJS()
)

server <- function(input, output, session) {

}

shinyApp(ui, server)
