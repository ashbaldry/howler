#' Howler.js Module
#'
#' @param id ID to give to the namespace of the module. The howler player will have the ID \code{{id}-howler}.
#' @param files Vector of files
#' @param input,output,session Standard \code{shiny} input, output and session
#'
#' @return
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
#'     useHowlerJS(),
#'     howlerModuleUI("howl")
#'   )
#'
#'   server <- function(input, output, session) {
#'     moduleServer("howl", howlerModuleServer)
#'   }
#'
#'   shinyApp(ui, server)
#' }
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
    volumeSlider(howler_id)
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
