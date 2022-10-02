library(shiny)
library(howler)

audio_files_dir <- system.file("examples/_audio", package = "howler")
addResourcePath("sample_audio", audio_files_dir)
audio_files <- file.path("sample_audio", list.files(audio_files_dir, ".mp3$"))

ui <- fluidPage(
  title = "howler Server-Side Example",

  h1("howler Server-Side Example"),
  p("After 10 seconds, the sound will automatically pause. After 20 seconds, it will play the second track"),

  tags$section(
    howler(audio_files[1:2], auto_continue = TRUE, elementId = "sound"),
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

  actionButton("add_track", "Add New Track")
)

server <- function(input, output, session) {
  output$sound_playing <- renderText({
    if (isTRUE(input$sound_playing)) "Yes" else "No"
  })

  output$sound_duration <- renderText({
    sprintf(
      "%02d:%02.0f",
      input$sound_duration %/% 60,
      input$sound_duration %% 60
    )
  })

  output$sound_seek <- renderText({
    sprintf(
      "%02d:%02.0f",
      input$sound_seek %/% 60,
      input$sound_seek %% 60
    )
  })

  output$sound_track <- renderText({
    input$sound_track$name
  })

  observe({
    req(input$sound_seek)
    if (round(input$sound_seek) == 10) {
      pauseHowl("sound")
    } else if (round(input$sound_seek) == 20) {
      changeTrack("sound", 2)
    }
  })

  observeEvent(input$add_track, {
    addTrack("sound", setNames(rep(audio_files[3], 3), paste("running_out", LETTERS[1:3])), play_track = TRUE)
  })
}

shinyApp(ui, server)
