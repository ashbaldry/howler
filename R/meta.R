#' Current Track
#'
#' @description
#' A way to display the current track in the UI without having to communicate with the server.
#'
#' @param id ID given to the current track label. For it to work with the \code{\link{howlerPlayer}}, the ID
#' must match that of the \code{howlerPlayer}.
#'
#' @return
#' A \code{div} tag that will be linked to the \code{\link{howlerPlayer}} to show the current track.
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'
#'   ui <- fluidPage(
#'     title = "howler.js Player",
#'     howler(elementId = "sound", "audio/sound.mp3"),
#'     howlerCurrentTrack("sound"),
#'     howlerPlayPauseButton("sound")
#'   )
#'
#'   server <- function(input, output, session) {
#'   }
#'
#'   shinyApp(ui, server)
#' }
#'
#' @export
howlerCurrentTrack <- function(id) {
  div(class = "howler-current-track", `data-howler` = id)
}
