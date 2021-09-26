library(shiny)
library(howler)

audio_files_dir <- system.file("examples/_audio", package = "howler")
addResourcePath("sample_audio", audio_files_dir)
audio_files <- file.path("sample_audio", list.files(audio_files_dir, ".mp3$"))

ui <- fluidPage(
  title = "howler Module Example",
  useHowlerJS(),

  h3("howler Module Example"),
  howlerModuleUI("sound", audio_files)
)

server <- function(input, output, session) {
  track_info <- howlerModuleServer("sound")
}

shinyApp(ui, server)
