#' Volume Slider
#'
#' @description
#' A more user friendly way to adjust the volume of the \code{howlerPlayer} than by using buttons. There are
#' still volume up/down buttons, but a slider can be moved up/down as required.
#'
#' @param id ID given to the volume slider. For it to work with the \code{\link{howlerPlayer}}, the ID
#' must match that of the \code{howlerPlayer}.
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
#'     useHowlerJS(),
#'     howlerPlayer("sound", "audio/sound.mp3"),
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
howlerVolumeSlider <- function(id, volume = 0.7) {
  if (volume < 0 || volume > 1) {
    stop("Volume must be between 0 and 1")
  }

  tagList(
    howlerVolumeToggleButton(id),
    tags$input(
      class = "howler-volume-slider",
      id = paste0(id, "_volume_slider"),
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
#' A UI element that can be included with a \code{\link{howlerPlayer}} to manually change the location of the track.
#'
#' @param id ID given to the volume slider. For it to work with the \code{howlerPlayer}, the ID
#' must match that of the \code{howlerPlayer}.
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
#'     useHowlerJS(),
#'     howlerPlayer("sound", "audio/sound.mp3"),
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
    id = paste0(id, "_seek_slider"),
    type = "range",
    min = 0,
    max = 1,
    step = 0.01,
    value = 0
  )
}