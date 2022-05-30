library(shiny)
library(howler)

audio_files_dir <- system.file("examples/_audio", package = "howler")
addResourcePath("sample_audio", audio_files_dir)
audio_files <- file.path("sample_audio", list.files(audio_files_dir, ".mp3$"))

ui <- fluidPage(
  title = "howler Basic Example",
  h1("howler Basic Example"),
  howler(elementId = "sound", audio_files),
  tags$p(
    howlerPlayPauseButton("sound"),
    "Play or pause the track"
  ),
  tags$p(
    howlerStopButton("sound"),
    "Stop the track and return to the start"
  )
)

server <- function(input, output) {
}

shinyApp(ui, server)
