library(shiny)
library(howler)

ui <- fluidPage(
  title = "howler Base64 Example",
  useHowlerJS(),

  h3("howler Base64 Example"),
  howlerPlayer("sound", readLines("audio.txt")),
  howlerPlayPauseButton("sound"),
  tags$br(),
  actionButton("play", "Play Sound")
)

server <- function(input, output, session) {
  observeEvent(input$play, playHowl(session, "sound"))
}

shinyApp(ui, server)
