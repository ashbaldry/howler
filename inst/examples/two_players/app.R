library(shiny)
library(howler)

audio_files_dir <- system.file("examples/_audio", package = "howler")
addResourcePath("sample_audio", audio_files_dir)
audio_files <- file.path("sample_audio", list.files(audio_files_dir, ".mp3$"))

ui <- fluidPage(
  title = "howler Basic Example",
  h3("howler Basic Example"),
  howler(audio_files, elementId = "sound"),
  howlerPlayPauseButton("sound"),
  howlerPauseButton("sound"),
  howlerStopButton("sound"),

  howler(audio_files[2], elementId = "sound2"),
  howlerPlayPauseButton("sound2"),
  howlerPauseButton("sound2"),
  howlerStopButton("sound2")
)

server <- function(input, output) {
}

shinyApp(ui, server)
