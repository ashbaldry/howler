library(shiny)
library(howler)

ui <- fluidPage(
  title = "Howler Example",
  useHowlerJS(),

  tags$br(),
  howlerPlayer("sound", file.path("audio", list.files("www/audio", ".mp3$"))),
  previousButton("sound"),
  playPauseButton("sound"),
  nextButton("sound"),
  volumeDownButton("sound"),
  volumeUpButton("sound"),
  volumeSlider("sound"),
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
