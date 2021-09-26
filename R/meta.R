#' Current Track
#'
#' @description
#' A way to display the current track in the UI without having to communicate with the server.
#'
#' @param id ID given to the current track label. For it to work with the \code{\link{howlerPlayer}}, the ID
#' must match that of the \code{howlerPlayer}.
#'
#' @return
#' A \code{div} tag that will be linked to the \code{\link{HowlerPlayer}} to show the current track.
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'
#'   ui <- fluidPage(
#'     title = "howler.js Player",
#'     useHowlerJS(),
#'     howlerCurrentTrack("sound"),
#'     howlerPlayer("sound", "audio/sound.mp3"),
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
  div(class = "howler-current-track", id = paste0(id, "_current_track"))
}
