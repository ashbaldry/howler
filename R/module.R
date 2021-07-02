#' Howler.js Module
#'
#' @param id ID to give to the namespace of the module. The howler player will have the ID \code{{id}-howler}.
#' @param files Files that will be used in the player. This can either be a single vector, or a list where different
#' formats of the same file are kept in each element of the list.
#' @param ... Other arguments sent to \code{\link{howlerPlayer}}
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
howlerModuleUI <- function(id, files, ...) {
  ns <- NS(id)
  howler_id <- ns("howler")

  div(
    class = "howler-module",
    howlerPlayer(howler_id, ...),
    if (length(files) > 1) previousButton(howler_id),
    playPauseButton(howler_id),
    if (length(files) > 1) nextButton(howler_id),
    textOutput(ns("howler_seek"), inline = TRUE),
    "/",
    textOutput(ns("howler_duration"), inline = TRUE),
    volumeSlider(howler_id)
  )
}

#' @rdname howlerModule
#' @export
howlerModuleServer <- function(input, output, session) {
  output$howler_seek <- renderText({
    sprintf("%02d:%02.0f", input$howler_seek %/% 60, input$howler_seek %% 60)
  })

  output$howler_duration <- renderText({
    sprintf("%02d:%02.0f", input$howler_duration %/% 60, input$howler_duration %% 60)
  })

  return(
    list(
      playing = reactive(input$howler_playing),
      track = reactive(input$howler_track),
      duration = reactive(input$howler_duration),
      seek = reactive(input$howler_seek)
    )
  )
}
