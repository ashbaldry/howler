library(shiny)
library(howler)

addResourcePath("audio", "../_audio")


ui <- fluidPage(
  title = "howler Module Example",
  useHowlerJS(),

  h3("howler Module Example"),
  howlerModuleUI("sound", file.path("audio", list.files("../_audio", ".mp3$")))
)

server <- function(input, output, session) {
  moduleServer("sound", howlerModuleServer)
}

shinyApp(ui, server)
