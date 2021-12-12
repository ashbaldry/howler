#' Update howler.js Server-Side
#'
#' @description
#' Change the state of the howler player from the server.
#'
#' \code{playHowl}, \code{pauseHowl} and \code{stopHowl} will all be applied to the current track.
#'
#' \code{changeTrack} will update the track to the file specified. This file must be included when the player
#' is initialised, otherwise it won't change the track.
#'
#' \code{addTrack} will add a new track to the specified player.
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
#'     howlerPlayPauseButton("howler")
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
changeTrack <- function(session, id, file) {
  session$sendCustomMessage("changeHowlerTrack", list(id = id, file = file))
}

#' @param play_track Logical, should the new track be played on addition?
#'
#' @rdname howlerServer
#' @export
addTrack <- function(session, id, file, play_track = FALSE) {
  session$sendCustomMessage("addHowlerTrack", list(id = id, file = file, play = play_track))
}

#' @rdname howlerServer
#' @export
playHowl <- function(session, id) {
  session$sendCustomMessage("playHowler", id)
}

#' @rdname howlerServer
#' @export
pauseHowl <- function(session, id) {
  session$sendCustomMessage("pauseHowler", id)
}

#' @rdname howlerServer
#' @export
stopHowl <- function(session, id) {
  session$sendCustomMessage("stopHowler", id)
}

#' @param seek Time (in seconds) to set the position of the track
#' @rdname howlerServer
#' @export
seekHowl <- function(session, id, seek) {
  session$sendCustomMessage("seekHowler", list(id = id, time = as.numeric(seek)))
}
