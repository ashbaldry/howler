library(shiny)
library(howler)

audio_files_dir <- system.file("examples/_audio", package = "howler")
addResourcePath("sample_audio", audio_files_dir)
audio_files <- file.path("sample_audio", list.files(audio_files_dir, ".mp3$"))

ui <- fluidPage(
  title = "howler Example",
  useHowlerJS(),

  h3("Howler Example"),
  howlerPlayer("sound", audio_files),
  howlerSeekSlider("sound"),
  howlerPreviousButton("sound"),
  howlerBackButton("sound"),
  howlerPlayPauseButton("sound"),
  howlerForwardButton("sound"),
  howlerNextButton("sound"),
  howlerVolumeSlider("sound"),
  tags$br(),
  tags$br(),
  tags$p("Track Name:", textOutput("sound_track", container = tags$strong, inline = TRUE)),
  tags$p("Currently playing:", textOutput("sound_playing", container = tags$strong, inline = TRUE)),
  tags$p(
    "Duration:",
    textOutput("sound_seek", container = tags$strong, inline = TRUE),
    "/",
    textOutput("sound_duration", container = tags$strong, inline = TRUE)
  ),
)

server <- function(input, output, session) {
  output$sound_playing <- renderText(if (isTRUE(input$sound_playing)) "Yes" else "No")
  output$sound_duration <- renderText(sprintf("%02d:%02.0f", input$sound_duration %/% 60, input$sound_duration %% 60))
  output$sound_seek <- renderText(sprintf("%02d:%02.0f", input$sound_seek %/% 60, input$sound_seek %% 60))
  output$sound_track <- renderText({
    req(input$sound_track)
    sub("\\.\\w+$", "", basename(input$sound_track))
  })
}

shinyApp(ui, server)
