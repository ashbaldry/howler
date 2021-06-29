#' Howler.js Module
#'
#' @param id ID
#' @param files Vector of files
#' @param input,output,session Standard \code{shiny} input, output and session
#'
#' @rdname howlerModule
#' @export
howlerModuleUI <- function(id, files) {
  ns <- NS(id)
  howler_id <- ns("howler")

  div(
    class = "howler-module",
    howlerPlayer(howler_id, files),
    previousButton(howler_id),
    playPauseButton(howler_id),
    nextButton(howler_id),
    volumeDownButton(howler_id),
    volumeUpButton(howler_id)
  )
}

#' @rdname howlerModule
#' @export
howlerModuleServer <- function(input, output, session) {
  return(
    list(
      playing = reactive(input$howler_playing),
      track = reactive(input$howler_track),
      duration = reactive(input$howler_duration),
      seek = reactive(input$howler_seek)
    )
  )
}
