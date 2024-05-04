library(shiny)
library(howler)

audio_files_dir <- system.file("examples", "_audio", package = "howler")
addResourcePath("sample_audio", audio_files_dir)
audio_files <- file.path("sample_audio", list.files(audio_files_dir, ".mp3$"))

ui <- fluidPage(
  title = "howler Server-Side Example",

  h1("howler Server-Side Example"),
  p("After 10 seconds, the sound will automatically pause. After 20 seconds, it will play the second track"),

  tags$section(
    howler(audio_files[1L:2L], auto_continue = TRUE, elementId = "sound"),
    howlerPreviousButton("sound"),
    howlerPlayPauseButton("sound"),
    howlerNextButton("sound"),
    howlerVolumeSlider("sound")
  ),
  tags$br(),

  tags$p(
    "Track Name:",
    textOutput("sound_track", container = tags$b, inline = TRUE)
  ),

  tags$p(
    "Currently playing:",
    textOutput("sound_playing", container = tags$b, inline = TRUE)
  ),

  tags$p(
    "Duration:",
    textOutput("sound_seek", container = tags$b, inline = TRUE),
    "/",
    textOutput("sound_duration", container = tags$b, inline = TRUE)
  ),

  fileInput("add_track", "Add New Track")
)

server <- function(input, output, session) {
  output$sound_playing <- renderText({
    if (isTRUE(input$sound_playing)) "Yes" else "No"
  })

  output$sound_duration <- renderText({
    sprintf(
      "%02d:%02.0f",
      input$sound_duration %/% 60L,
      input$sound_duration %% 60L
    )
  })

  output$sound_seek <- renderText({
    sprintf(
      "%02d:%02.0f",
      input$sound_seek %/% 60L,
      input$sound_seek %% 60L
    )
  })

  output$sound_track <- renderText({
    input$sound_track$name
  })

  observe({
    req(input$sound_seek)
    if (round(input$sound_seek) == 10L) {
      pauseHowl("sound")
    } else if (round(input$sound_seek) == 20L) {
      changeTrack("sound", 2L)
    }
  })

  tmp_audio_dir <- tempdir()
  addResourcePath("custom_audio", tmp_audio_dir)

  observeEvent(input$add_track, {
    saved_track <- file.path(tmp_audio_dir, input$add_track$name)
    file.copy(input$add_track$datapath, saved_track)
    upload_track <- setNames(
      file.path("custom_audio", input$add_track$name),
      sub(".mp3", "", input$add_track$name, fixed = TRUE)
    )
    addTrack("sound", upload_track, play_track = TRUE)
  })
}

shinyApp(ui, server)
