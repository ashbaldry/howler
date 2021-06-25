library(shiny)
library(howler)

ui <- fluidPage(
  useHowlerJS(),

  howlerPlayer("sound", file.path("audio", list.files("www/audio", ".mp3$"))),
  howlerButton("sound", "previous", shiny::icon("step-backward")),
  howlerButton("sound", "play_pause", shiny::icon("play")),
  howlerButton("sound", "next", shiny::icon("step-forward")),
  tags$br(),
  howlerPlayer("sound2", file.path("audio", list.files("www/audio", ".mp3$"))[2]),
  howlerButton("sound2", "previous", shiny::icon("step-backward")),
  howlerButton("sound2", "play_pause", shiny::icon("play")),
  howlerButton("sound2", "next", shiny::icon("step-forward")),
  tags$br(),
  tags$br(),
  tags$p("Sound 1 playing:", textOutput("sound_playing", inline = TRUE)),
  tags$p("Sound 2 playing:", textOutput("sound2_playing", inline = TRUE))
)

server <- function(input, output, session) {
  output$sound_playing <- renderText(isTRUE(input$sound_playing))
  output$sound2_playing <- renderText(isTRUE(input$sound2_playing))
}

shinyApp(ui, server)
