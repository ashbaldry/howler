#' Volume Slider
#'
#' @description
#' Temporary description
#'
#' @param id ID given to the volume slider. For it to work with the \code{\link{howlerPlayer}}, the ID
#' must match that of the \code{howlerPlayer}.
#' @param volume Initial volume to set the player at. Defaults at 70\%
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'
#'   ui <- fluidPage(
#'     title = "Initial Title",
#'     useHowlerJS(),
#'     howlerPlayer("sound"),
#'     playPauseButton("sound"),
#'     volumeSlider("sound")
#'   )
#'
#'   server <- function(input, output, session) {
#'   }
#'
#'   shinyApp(ui, server)
#' }
#'
#' @export
volumeSlider <- function(id, volume = 0.7) {
  tagList(
    tags$a(shiny::icon("volume-down")),
    tags$input(
      class = "howler-volume-slider",
      id = paste0(id, "_volume_slider"),
      type = "range",
      min = "0",
      max = "1",
      step = "0.01",
      value = volume
    ),
    tags$a(shiny::icon("volume-up"))
  )
}
