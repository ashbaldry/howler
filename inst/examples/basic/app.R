library(shiny)
library(howler)

audio_files_dir <- system.file("examples/_audio", package = "howler")
addResourcePath("sample_audio", audio_files_dir)
audio_files <- file.path("sample_audio", list.files(audio_files_dir, ".mp3$"))

ui <- fluidPage(
  title = "howler Basic Example",
  useHowlerJS(),

  h3("howler Basic Example"),
  howlerPlayer("sound", audio_files),
  howlerPlayPauseButton("sound")
)

server <- function(input, output) {
}

shinyApp(ui, server)
