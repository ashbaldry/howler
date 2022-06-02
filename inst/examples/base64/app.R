library(shiny)
library(howler)

base64_file <- readLines("audio.txt")

ui <- fluidPage(
  title = "howler Base64 Example",

  h1("howler Base64 Example"),
  howler(elementId = "sound", list(sound = base64_file)),
  howlerPlayButton("sound")
)

server <- function(input, output) {}

shinyApp(ui, server)
