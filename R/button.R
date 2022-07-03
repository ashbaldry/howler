#' Audio Buttons
#'
#' @description
#' Buttons that can be used to interact with the \code{\link{howler}}.
#'
#' \code{howlerPlayButton}, \code{howlerPauseButton}, \code{howlerPlayPauseButton} and
#' \code{howlerStopButton} will all be applied to the current track.
#'
#' \code{howlerBackButton} and \code{howlerForwardButton} will
#' change the track position by a specified amount of time.
#'
#' \code{howlerPreviousButton} and \code{howlerNextButton} will
#' play the previous/following track supplied to the player.
#'
#' \code{howlerVolumeDownButton} and \code{howlerVolumeUpButton} will
#' change the volume of the player by a specified percentage.
#'
#' \code{howlerButton} is a customisable version of any of the above individual button.
#'
#' @param howler_id ID given to the \code{\link{howler}} player.
#' @param button_type Type of button to create. Available buttons are in the details, default set to \code{play_pause}.
#' @param ... Attributes/Inner tags added to the button
#'
#' @return
#' An HTML tag containing the audio button.
#'
#' An additional input will be available in the server side in the form \code{\{id\}_\{button_type\}}. For example
#' \code{howlerBackButton("howler")} will create an input element of \code{input$howler_back}. All of these will work in
#' the same way as \code{\link[shiny]{actionButton}}
#'
#' @details
#' The following \code{button_type} are available to create:
#'
#' \describe{
#' \item{\code{play_pause}}{(default) Switch between playing and pausing the track}
#' \item{\code{play}}{Resumes the current track}
#' \item{\code{pause}}{Pauses the current track}
#' \item{\code{stop}}{Stops current track, when played will start from beginning}
#' \item{\code{previous},\code{next}}{Switches to the previous/following track}
#' \item{\code{volumedown},\code{volumeup}}{Decreases/Increases the volume by 10\%
#' (If using \code{howlerButton} include the attribute \code{`data-volume-change`})}
#' \item{\code{back},\code{forward}}{Seek forward/backwards 10s
#' (If using \code{howlerButton} include the attribute \code{`data-seek-change`} with negative values to go backwards)}
#' }
#'
#' When using a \code{play_pause} button, the icon will toggle between the play and pause button
#' depending on whether or not the track is playing.
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'
#'   ui <- fluidPage(
#'     tile = "howler.js Player",
#'     howler(elementId = "howler", "audio/sound.mp3"),
#'     howlerPreviousButton("howler"),
#'     howlerBackButton("howler"),
#'     howlerPlayPauseButton("howler"),
#'     howlerForwardButton("howler"),
#'     howlerNextButton("howler"),
#'     howlerVolumeDownButton("howler"),
#'     howlerVolumeUpButton("howler")
#'   )
#'
#'   server <- function(input, output) {
#'   }
#'
#'   shinyApp(ui, server)
#' }
#'
#' @rdname howlerButton
#' @export
howlerButton <- function(howler_id, button_type = HOWLER_BUTTON_TYPES, ...) {
  button_type <- match.arg(button_type)

  tags$button(
    `data-howler` = howler_id,
    class = paste0("action-button howler-button howler-", button_type, "-button"),
    `aria-label` = button_type,
    title = button_type,
    type = "button",
    ...
  )
}

#' @rdname howlerButton
#' @export
howlerPlayButton <- function(howler_id) {
  howlerButton(howler_id, "play", shiny::icon("play"))
}

#' @rdname howlerButton
#' @export
howlerPauseButton <- function(howler_id) {
  howlerButton(howler_id, "pause", shiny::icon("pause"))
}

#' @rdname howlerButton
#' @export
howlerPlayPauseButton <- function(howler_id) {
  btn <- howlerButton(howler_id, "play_pause", shiny::icon("play"))
  btn$attribs$`aria-label` <- "play"
  btn$attribs$title <- "play"
  btn
}

#' @rdname howlerButton
#' @export
howlerStopButton <- function(howler_id) {
  howlerButton(howler_id, "stop", shiny::icon("stop"))
}

#' @param seek_change Time (in seconds) to move forward/backward the track when clicked. Default is 10 seconds
#'
#' @rdname howlerButton
#' @export
howlerBackButton <- function(howler_id, seek_change = 10) {
  howlerButton(howler_id, "back", shiny::icon("backward"), `data-seek-change` = -abs(seek_change))
}

#' @rdname howlerButton
#' @export
howlerForwardButton <- function(howler_id, seek_change = 10) {
  howlerButton(howler_id, "forward", shiny::icon("forward"), `data-seek-change` = seek_change)
}

#' @rdname howlerButton
#' @export
howlerPreviousButton <- function(howler_id) {
  howlerButton(howler_id, "previous", shiny::icon("step-backward"))
}

#' @rdname howlerButton
#' @export
howlerNextButton <- function(howler_id) {
  howlerButton(howler_id, "next", shiny::icon("step-forward"))
}

#' @param volume_change How much to change the volume by. Default is 10\%.
#'
#' @rdname howlerButton
#' @export
howlerVolumeUpButton <- function(howler_id, volume_change = 0.1) {
  howlerButton(howler_id, "volumeup", shiny::icon("volume-up"), `data-volume-change` = volume_change)
}

#' @rdname howlerButton
#' @export
howlerVolumeDownButton <- function(howler_id, volume_change = 0.1) {
  howlerButton(howler_id, "volumedown", shiny::icon("volume-down"), `data-volume-change` = volume_change)
}

#' @rdname howlerButton
#' @export
howlerVolumeToggleButton <- function(howler_id) {
  howlerButton(howler_id, "volumetoggle", shiny::icon("volume-up"))
}

HOWLER_BUTTON_TYPES <- c(
  "play_pause", "play", "pause", "stop", "previous", "next",
  "volumeup", "volumedown", "volumetoggle", "forward", "back"
)
