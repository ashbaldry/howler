#' Audio Buttons
#'
#' @description
#' Buttons that can be used to change the audio of
#'
#' @param id ID given to the button. For it to work with the \code{\link{howlerPlayer}}, the ID
#' must match that of
#' @param button_type Type of button to create. Available buttons are in the details, default set to \code{play_pause}
#' @param ...
#'
#' @return
#' An HTML object containing the button.
#'
#' @details
#' The following \code{button_type} are available to create:
#' \describe{
#' \item{\code{play_pause} (default)}{}
#' }
#'
#' When using a \code{play_pause} button, the icon will toggle between the play and pause button
#' depending on whether or not the track is playing.
#'
#' @rdname howlerButton
#' @export
howlerButton <- function(id, button_type = HOWLER_BUTTON_TYPES, ...) {
  button_type <- match.arg(button_type)
  button_id <- paste0(id, "_", button_type)

  tags$a(id = button_id, class = paste0("action-button howler-", button_type), ...)
}

HOWLER_BUTTON_TYPES <- c("play_pause", "play", "pause", "previous", "next", "volumeup", "volumedown")

#' @rdname howlerButton
#' @export
playButton <- function(id) {
  howlerButton(id, "play", shiny::icon("play"))
}

#' @rdname howlerButton
#' @export
pauseButton <- function(id) {
  howlerButton(id, "pause", shiny::icon("pause"))
}

#' @rdname howlerButton
#' @export
playPauseButton <- function(id) {
  howlerButton(id, "play_pause", shiny::icon("play"))
}

#' @rdname howlerButton
#' @export
previousButton <- function(id) {
  howlerButton(id, "previous", shiny::icon("step-backward"))
}

#' @rdname howlerButton
#' @export
nextButton <- function(id) {
  howlerButton(id, "next", shiny::icon("step-forward"))
}

#' @param volume_change How much to change the volume by. Default is 10%.
#'
#' @rdname howlerButton
#' @export
volumeUpButton <- function(id, volume_change = 0.1) {
  howlerButton(id, "volumeup", shiny::icon("volume-up"), `data-volume-change` = volume_change)
}

#' @rdname howlerButton
#' @export
volumeDownButton <- function(id, volume_change = 0.1) {
  howlerButton(id, "volumedown", shiny::icon("volume-down"), `data-volume-change` = volume_change)
}
