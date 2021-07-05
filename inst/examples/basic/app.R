library(shiny)
library(howler)

addResourcePath("audio", "../_audio")


ui <- fluidPage(
  title = "howler Basic Example",
  useHowlerJS(),

  h3("howler Basic Example"),
  howlerPlayer("sound", file.path("audio", list.files("../_audio", ".mp3$")[1])),
  howlerPlayPauseButton("sound")
)

server <- function(input, output) {
}

shinyApp(ui, server)
