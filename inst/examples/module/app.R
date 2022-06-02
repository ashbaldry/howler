library(shiny)
library(howler)

audio_files_dir <- system.file("examples/_audio", package = "howler")
addResourcePath("sample_audio", audio_files_dir)
audio_files <- file.path("sample_audio", list.files(audio_files_dir, ".mp3$"))

ui <- fluidPage(
  title = "howler Module Example",
  h1("howler Module Example"),

  tags$section(
    h2("Full Module"),
    howlerModuleUI("sound", audio_files, include_current_track = TRUE)
  ),

  tags$section(
    h2("Basic Module"),
    p(tags$b("Note:"), "Must only contain one track"),
    howlerBasicModuleUI("sound2", audio_files[3])
  ),

  tags$section(
    h2("Example audio tag"),
    tags$audio(controls = NA, src = audio_files[3])
  )
)

server <- function(input, output, session) {
  track_info <- howlerModuleServer("sound")
  track_info2 <- howlerModuleServer("sound2")
}

shinyApp(ui, server)
