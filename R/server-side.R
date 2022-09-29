#' Update howler.js Server-Side
#'
#' @description
#' Change the state of the howler player from the server.
#'
#' \code{playHowl}, \code{pauseHowl} and \code{stopHowl} will all be applied to the current track.
#'
#' \code{changeTrack} will update the track to the file specified.
#'
#' \code{addTrack} will add a new track to the specified player.
#'
#' @param session Shiny session
#' @param id ID of the \code{howler} to update
#' @param track Either the track name of the file to change to, or the index of the file to play.
#' If the file is not included in the player nothing will happen.
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'
#'   tracks <- c("audio/track1.mp3", "audio/track2.mp3")
#'
#'   ui <- fluidPage(
#'     title = "howler.js Player",
#'     selectInput("track", "Select Track", basename(tracks)),
#'     howler(elementId = "howler", tracks),
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
#' Updates the the state of the specified \code{howler} in the shiny application.
#'
#' @name howlerServer
#' @rdname howlerServer
#' @export
changeTrack <- function(id, track, session = getDefaultReactiveDomain()) {
  message_name <- paste0("changeHowlerTrack_", session$ns(id))
  session$sendCustomMessage(message_name, track)
}

#' @param play_track Logical, should the new track be played on addition?
#'
#' @rdname howlerServer
#' @export
addTrack <- function(id, track, play_track = FALSE, session = getDefaultReactiveDomain()) {
  if (is.null(names(track))) {
    track_name <- sub("\\.[^\\.]+$", "", basename(track[1]))
  } else {
    track_name <- names(track)
  }

  message_name <- paste0("addHowlerTrack_", session$ns(id))
  track_info <- list(
    track = as.list(unname(track)),
    track_name = track_name,
    play = play_track
  )
  session$sendCustomMessage(message_name, track_info)
}

#' @rdname howlerServer
#' @export
playHowl <- function(id, session = getDefaultReactiveDomain()) {
  message_name <- paste0("playHowler_", session$ns(id))
  session$sendCustomMessage(message_name, id)
}

#' @rdname howlerServer
#' @export
pauseHowl <- function(id, session = getDefaultReactiveDomain()) {
  message_name <- paste0("pauseHowler_", session$ns(id))
  session$sendCustomMessage(message_name, id)
}

#' @rdname howlerServer
#' @export
stopHowl <- function(id, session = getDefaultReactiveDomain()) {
  message_name <- paste0("stopHowler_", session$ns(id))
  session$sendCustomMessage(message_name, id)
}

#' @param seek Time (in seconds) to set the position of the track
#' @rdname howlerServer
#' @export
seekHowl <- function(id, seek, session = getDefaultReactiveDomain()) {
  message_name <- paste0("seekHowler_", session$ns(id))
  session$sendCustomMessage(message_name, as.numeric(seek))
}
