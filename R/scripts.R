#' Enable \code{HowlerJS}
#'
#' @description
#' Add \code{useHowlerJS} to the UI of a shiny application so that the necessary resources can be added to the application.
#'
#' @param spatial Logical, whether or not the spatial aspects of \code{howler.js} are required. Default is set to \code{FALSE}.
#' (Unless writing custom functionality, this is not used).
#'
#' @return HTML tags that link to relevant JavaScript and CSS files used to display and run \code{howler.js}.
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'
#'   ui <- fluidPage(
#'     title = "howler.js Player Title",
#'     useHowlerJS(),
#'     howlerPlayer("sound", "audio/track1.mp3"),
#'     howlerPlayPauseButton("sound"),
#'     howlerVolumeSlider("sound")
#'   )
#'
#'   server <- function(input, output, session) {
#'   }
#'
#'   shinyApp(ui, server)
#' }
#'
#' @import shiny
#' @export
useHowlerJS <- function(spatial = FALSE) {
  file <- system.file("srcjs", package = "howler", mustWork = TRUE)
  shiny::addResourcePath("howlerjs", file)

  shiny::tags$head(
    shiny::tags$script(src = "howlerjs/howler.core.min.js"),
    if (spatial) shiny::tags$script(src = "howlerjs/howler.spatial.min.js"),
    shiny::tags$script(src = "howlerjs/howler.shiny.js"),
    shiny::tags$link(href = "howlerjs/howler.shiny.css", rel = "stylesheet")
  )
}
