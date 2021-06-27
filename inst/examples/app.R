library(shiny)
library(howler)

ui <- fluidPage(
  useHowlerJS(),

  tags$br(),
  howlerPlayer("sound", file.path("audio", list.files("www/audio", ".mp3$"))),
  howlerButton("sound", "previous", shiny::icon("step-backward")),
  howlerButton("sound", "play_pause", shiny::icon("play")),
  howlerButton("sound", "next", shiny::icon("step-forward")),
  tags$br(),
  tags$br(),
  tags$p("Track Name:", textOutput("sound_track", container = tags$strong, inline = TRUE)),
  tags$p("Currently playing:", textOutput("sound_playing", inline = TRUE)),
  tags$p("Duration:", textOutput("sound_seek", inline = TRUE), "/", textOutput("sound_duration", inline = TRUE)),
)

server <- function(input, output, session) {
  output$sound_playing <- renderText(isTRUE(input$sound_playing))
  output$sound_track <- renderText(input$sound_track)
  output$sound_duration <- renderText(sprintf("%02d:%02.0f", input$sound_duration %/% 60, input$sound_duration %% 60))
  output$sound_seek <- renderText(sprintf("%02d:%02.0f", input$sound_seek %/% 60, input$sound_seek %% 60))
}

shinyApp(ui, server)
