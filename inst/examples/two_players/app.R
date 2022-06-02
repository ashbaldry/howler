library(shiny)
library(howler)

audio_files_dir <- system.file("examples/_audio", package = "howler")
addResourcePath("sample_audio", audio_files_dir)
audio_files <- file.path("sample_audio", list.files(audio_files_dir, ".mp3$"))

ui <- fluidPage(
  title = "Two howler.js Players Example",
  h1("Two howler.js Players Example"),

  fluidRow(
    column(
      width = 3,
      offset = 2,
      tags$section(
        h2("Player 1"),
        howler(audio_files[1], elementId = "sound"),
        howlerPlayPauseButton("sound"),
        howlerStopButton("sound2")
      )
    ),
    column(
      width = 3,
      offset = 2,
      tags$section(
        h2("Player 2"),
        howler(audio_files[2], elementId = "sound2"),
        howlerPlayPauseButton("sound2"),
        howlerStopButton("sound2")
      )
    )
  )
)

server <- function(input, output) {
}

shinyApp(ui, server)
