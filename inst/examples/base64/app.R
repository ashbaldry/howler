library(shiny)
library(howler)

base64_file <- readLines("audio.txt")
print(base64_file)

ui <- fluidPage(
  title = "howler Base64 Example",

  h1("howler Base64 Example"),
  howler(elementId = "sound", list(sound = base64_file)),
  actionButton("play", "Play Sound")
)

server <- function(input, output, session) {
  observeEvent(input$play, playHowl(session, "sound"))
}

shinyApp(ui, server)
