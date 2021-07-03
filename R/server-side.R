#' Update howler.js Server-Side
#'
#' @description
#' Change the state of the howler player from the server.
#'
#' \code{playHowler}, \code{pauseHowler} and \code{stopHowler} will all be applied to the current track.
#'
#' \code{changeHowlerTrack} will update the track to the file specified. This file must be included when the player
#' is initialised, otherwise it won't change the track.
#'
#' @param session Shiny session
#' @param id ID of the \code{howlerPlayer} to update
#' @param file Base name of the file to change to. If the file is not included in the player nothing will happen.
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'
#'   tracks <- c("audio/track1.mp3", "audio/track2.mp3")
#'
#'   ui <- fluidPage(
#'     title = "howler.js Player",
#'     useHowlerJS(),
#'     selectInput("track", "Select Track", basename(tracks)),
#'     howlerPlayer("howler", tracks),
#'     playPauseButton("howler")
#'   )
#'
#'   server <- function(input, output) {
#'     observeEvent(input$track, changeHowlerTrack("howler", input$track))
#'   }
#'
#'   runShiny(ui, server)
#' }
#'
#' @return
#' Updates the the state of the specified \code{howlerPlayer} in the shiny application.
#'
#' @name howlerServer
#' @rdname howlerServer
#' @export
changeHowlerTrack <- function(session, id, file) {
  session$sendCustomMessage("changeHowlerTrack", list(id = id, file = file))
}

#' @rdname howlerServer
#' @export
playHowler <- function(session, id) {
  session$sendCustomMessage("playHowler", id)
}

#' @rdname howlerServer
#' @export
pauseHowler <- function(session, id) {
  session$sendCustomMessage("pauseHowler", id)
}

#' @rdname howlerServer
#' @export
stopHowler <- function(session, id) {
  session$sendCustomMessage("stopHowler", id)
}

#' @param seek Time (in seconds) to set the position of the track
#' @rdname howlerServer
#' @export
seekHowler <- function(session, id, seek) {
  session$sendCustomMessage("seekHowler", list(id = id, time = as.numeric(seek)))
}
