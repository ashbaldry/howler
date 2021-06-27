library(shiny)
library(howler)

ui <- fluidPage(
  useHowlerJS(),

  howlerPlayer("sound", file.path("audio", list.files("www/audio", ".mp3$"))[2]),
  howlerButton("sound", "play_pause", shiny::icon("play")),
  tags$br(),
  tags$br(),
  tags$p("Sound 1 playing:", textOutput("sound_playing", inline = TRUE)),
  tags$p("Sound 1 track:", textOutput("sound_track", inline = TRUE)),
  tags$p("Sound 1 duration:", textOutput("sound_duration", inline = TRUE)),
  tags$br(),
  tags$br(),
  howlerPlayer("sound2", file.path("audio", list.files("www/audio", ".mp3$"))),
  howlerButton("sound2", "previous", shiny::icon("step-backward")),
  howlerButton("sound2", "play_pause", shiny::icon("play")),
  howlerButton("sound2", "next", shiny::icon("step-forward")),
  tags$br(),
  tags$br(),
  tags$p("Sound 2 playing:", textOutput("sound2_playing", inline = TRUE)),
  tags$p("Sound 2 track:", textOutput("sound2_track", inline = TRUE)),
  tags$p("Sound 2 duration:", textOutput("sound2_duration", inline = TRUE)),
)

server <- function(input, output, session) {
  output$sound_playing <- renderText(isTRUE(input$sound_playing))
  output$sound_track <- renderText(input$sound_track)
  output$sound_duration <- renderText(sprintf("%02d:%02.0f", input$sound_duration %/% 60, input$sound_duration %% 60))

  output$sound2_playing <- renderText(isTRUE(input$sound2_playing))
  output$sound2_track <- renderText(input$sound2_track)
  output$sound2_duration <- renderText(sprintf("%02d:%02.0f", input$sound2_duration %/% 60, input$sound2_duration %% 60))
}

shinyApp(ui, server)
