#' Volume Slider
#'
#' @description
#' A more user friendly way to adjust the volume of the \code{howler} than by using buttons. There are
#' still volume up/down buttons, but a slider can be moved up/down as required.
#'
#' @param id ID given to the volume slider. For it to work with the \code{\link{howler}}, the ID
#' must match that of the \code{howler}.
#' @param volume Initial volume to set the player at. Defaults at 70\%
#'
#' @return
#' A volume slider with a \code{\link{howlerVolumeDownButton}} and a \code{\link{howlerVolumeUpButton}} either side.
#'
#' @details
#' If using \code{howlerVolumeSlider}, avoid using the volume buttons, as this will cause duplicate IDs to appear in the
#' shiny application and prevents the slider from working properly.
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'
#'   ui <- fluidPage(
#'     title = "howler.js Player",
#'     howler(elementId = "sound", "audio/sound.mp3"),
#'     howlerPlayPauseButton("sound"),
#'     howlerVolumeSlider("sound")
#'   )
#'
#'   server <- function(input, output, session) {
#'   }
#'
#'   shinyApp(ui, server)
#' }
#'
#' @export
howlerVolumeSlider <- function(id, volume = 1) {
  if (volume < 0 || volume > 1) {
    stop("Volume must be between 0 and 1")
  }

  tagList(
    howlerVolumeToggleButton(id),
    tags$input(
      class = "howler-volume-slider",
      `data-howler` = id,
      type = "range",
      min = 0,
      max = 1,
      step = 0.01,
      value = volume
    )
  )
}

#' Seek Slider
#'
#' @description
#' A UI element that can be included with a \code{\link{howler}} to manually change the location of the track.
#'
#' @param id ID given to the volume slider. For it to work with the \code{howler}, the ID
#' must match that of the \code{howler}.
#'
#' @return A slider element of class \code{howler-seek-slider} that will display the position of the current track
#' playing.
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'
#'   ui <- fluidPage(
#'     title = "howler.js Player",
#'     howler(elementId = "sound", "audio/sound.mp3"),
#'     howlerPlayPauseButton("sound"),
#'     howlerSeekSlider("sound")
#'   )
#'
#'   server <- function(input, output, session) {
#'   }
#'
#'   shinyApp(ui, server)
#' }
#'
#' @export
howlerSeekSlider <- function(id) {
  tags$input(
    class = "howler-seek-slider",
    `data-howler` = id,
    type = "range",
    min = 0,
    max = 1,
    step = 0.01,
    value = 0
  )
}
