#' Howler.js Module
#'
#' @description
#' A simple module containing a howler player and a default set of howler buttons. The module also contains the
#' current position of the track being played and the duration of the track.
#'
#' @param id ID to give to the namespace of the module. The howler player will have the ID \code{{id}-howler}.
#' @param files Files that will be used in the player. This can either be a single vector, or a list where different
#' formats of the same file are kept in each element of the list.
#' @param ... Further arguments to send to \code{\link{howler}}
#' @param include_current_track Logical, should the current track be included in the UI of the module?
#' @param width Width (in pixels) of the player. Defaults to 400px.
#'
#' @return
#' The UI will provide a player with a play/pause button, previous and next buttons, duration information
#' and a volume slider.
#'
#' The server-side module will return a list of reactive objects:
#' \describe{
#' \item{playing}{Logical value whether or not the player is currently playing}
#' \item{track}{Name of the track currently loaded}
#' \item{duration}{Duration (in seconds) of the track currently loaded}
#' \item{seek}{Current position (in seconds) of the track currently loaded}
#' }
#'
#' @examples
#' if (interactive()) {
#'   ui <- fluidPage(
#'     title = "howler.js Module",
#'     howlerModuleUI("howl", c("audio/track1.mp3", "audio/track2.mp3"))
#'   )
#'
#'   server <- function(input, output, session) {
#'     howlerModuleServer("howl")
#'   }
#'
#'   shinyApp(ui, server)
#' }
#'
#' @name howlerModule
#' @rdname howlerModule
#' @export
howlerModuleUI <- function(id, files, ..., include_current_track = TRUE, width = "300px") {
  ns <- NS(id)
  howler_id <- ns("howler")

  div(
    class = "howler-module",
    style = paste0("width:", width, ";"),
    howler(elementId = howler_id, tracks = files, ...),
    div(
      class = "howler-module-container",
      if (include_current_track) howlerCurrentTrack(howler_id),
      howlerSeekSlider(howler_id),
      div(
        class = "howler-module-settings",
        div(
          class = "howler-module-buttons",
          if (length(files) > 1) howlerPreviousButton(howler_id),
          howlerPlayPauseButton(howler_id),
          if (length(files) > 1) howlerNextButton(howler_id)
        ),
        span(
          class = "howler-module-duration",
          howlerSeekTime(howler_id),
          "/",
          howlerDurationTime(howler_id)
        ),
        div(
          class = "howler-module-volume",
          howlerVolumeSlider(howler_id)
        )
      )
    )
  )
}

#' @rdname howlerModule
#' @export
howlerBasicModuleUI <- function(id, files, ..., width = "300px") {
  if (length(files) > 1) stop("Only one file can be included in the basic module")
  ns <- NS(id)
  howler_id <- ns("howler")

  div(
    class = "howler-module howler-basic-module",
    style = paste0("width:", width, ";"),
    howler(elementId = howler_id, tracks = files, ...),
    div(
      class = "howler-module-container",
      div(
        class = "howler-module-settings",
        div(
          class = "howler-module-buttons",
          howlerPlayPauseButton(howler_id),
        ),
        span(
          class = "howler-module-duration",
          howlerSeekTime(howler_id),
          "/",
          howlerDurationTime(howler_id)
        ),
        div(
          class = "howler-module-seek",
          howlerSeekSlider(howler_id)
        ),
        div(
          class = "howler-module-volume",
          howlerVolumeSlider(howler_id, button = FALSE),
          howlerVolumeToggleButton(howler_id)
        )
      )
    )
  )
}

#' @rdname howlerModule
#' @export
howlerModuleServer <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      return(
        list(
          playing = reactive(input$howler_playing),
          track = reactive(input$howler_track),
          duration = reactive(input$howler_duration),
          seek = reactive(input$howler_seek)
        )
      )
    }
  )
}
