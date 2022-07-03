#' Current Track
#'
#' @description
#' A way to display track information in the UI without having to communicate with the server.
#'
#' @param id ID given to the current track label. For it to work with the \code{\link{howler}}, the ID
#' must match that of the \code{howler}.
#'
#' @return
#' A \code{div} tag that will be linked to the \code{\link{howler}} to show the current track.
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'
#'   ui <- fluidPage(
#'     title = "howler.js Player",
#'     howler(elementId = "sound", "audio/sound.mp3"),
#'     howlerCurrentTrack("sound"),
#'     p(
#'       howlerSeekTime("sound"),
#'       "/",
#'       howlerDurationTime("sound")
#'     ),
#'     howlerPlayPauseButton("sound")
#'   )
#'
#'   server <- function(input, output, session) {
#'   }
#'
#'   shinyApp(ui, server)
#' }
#'
#' @rdname howler_meta
#' @export
howlerCurrentTrack <- function(id, ...) {
  div(class = "howler-current-track", `data-howler` = id, ...)
}

#' @rdname howler_meta
#' @export
howlerSeekTime <- function(id, ...) {
  span(class = "howler-seek", `data-howler` = id, ...)
}

#' @rdname howler_meta
#' @export
howlerDurationTime <- function(id, ...) {
  span(class = "howler-duration", `data-howler` = id, ...)
}
