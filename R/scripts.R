#' Enable \code{HowlerJS}
#'
#' @description
#' Add \code{useHowlerJS} to the UI of a shiny application so that the necessary resources can be added to the application.
#'
#' @return
#' HTML tags that link to relevant JavaScript and CSS files used to display and run \code{howler.js}.
#'
#' @examplesIf interactive()
#' library(shiny)
#'
#' ui <- fluidPage(
#'   title = "howler.js Player Title",
#'   useHowlerJS(),
#'   howlerPlayer("sound", "audio/track1.mp3"),
#'   howlerPlayPauseButton("sound"),
#'   howlerVolumeSlider("sound")
#' )
#'
#' server <- function(input, output, session) {}
#'
#' shinyApp(ui, server)
#'
#' @import shiny
#' @export
useHowlerJS <- function() {
  file <- system.file("srcjs", package = "howler", mustWork = TRUE)
  shiny::addResourcePath("howlerjs", file)

  shiny::tags$head(
    shiny::tags$script(src = "howlerjs/howler.shiny.js"),
    shiny::tags$link(href = "howlerjs/howler.shiny.css", rel = "stylesheet")
  )
}
