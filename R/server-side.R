#' Server-Side Howler
#'
#' @description
#' This is a series of functions that can be used in the server
#'
#' @param session Shiny session
#' @param id ID of the \code{howlerPlayer} to update
#' @param file File to change to
#'
#' @rdname howlerServer
#' @export
changeHowlTrack <- function(session, id, file) {
  session$sendCustomMessage("changeHowlerTrack", list(id = id, file = file))
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
