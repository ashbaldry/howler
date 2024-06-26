#' Update howler.js Server-Side
#'
#' @description
#' Change the state of the howler player from the server.
#'
#' \code{playHowl}, \code{pauseHowl}, \code{togglePlayHowl} and \code{stopHowl}
#' will all be applied to the current track.
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
    track_name <- vapply(
      track,
      function(x) sub("\\.[^\\.]+$", "", basename(x[1L])),
      character(1L),
      USE.NAMES = FALSE
    )
  } else {
    track_name <- names(track)
  }

  message_name <- paste0("addHowlerTrack_", session$ns(id))
  track_info <- list(
    track = as.list(unname(track)),
    track_name = as.list(track_name),
    play = play_track
  )
  session$sendCustomMessage(message_name, track_info)
}

#' @details
#' For `deleteTrack`, make sure that the name is used of the track
#' rather than the file name.
#'
#' @rdname howlerServer
#' @export
deleteTrack <- function(id, track, session = getDefaultReactiveDomain()) {
  tracks <- session$input[[paste0(session$ns(id), "_tracks")]]
  if (!track %in% tracks) {
    warning(track, " not available for ", id, call. = FALSE)
    return(invisible())
  }

  session$sendCustomMessage(paste0("deleteHowlerTrack_", session$ns(id)), track)
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
togglePlayHowl <- function(id, session = getDefaultReactiveDomain()) {
  message_name <- paste0("togglePlayHowler_", session$ns(id))
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

#' @param rate Rate (from 0.5 to 4.0) of the audio playback speed
#' @rdname howlerServer
#' @export
changeHowlSpeed <- function(id, rate = 1.0, session = getDefaultReactiveDomain()) {
  message_name <- paste0("changeHowlerRate_", session$ns(id))
  session$sendCustomMessage(message_name, as.numeric(rate))
}
