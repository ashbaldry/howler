library(shiny)
library(howler)

addResourcePath("audio", "../_audio")


ui <- fluidPage(
  title = "howler Module Example",
  useHowlerJS(),

  h3("howler Module Example"),
  textOutput("track", container = h4),
  howlerModuleUI("sound", file.path("audio", list.files("../_audio", ".mp3$")))
)

server <- function(input, output, session) {
  track_info <- howlerModuleServer("sound")

  output$track <- renderText({
    req(track_info$track())
    sub("\\.\\w*", "", basename(track_info$track()))
  })
}

shinyApp(ui, server)
