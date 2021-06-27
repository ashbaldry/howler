#' Howler.js Player
#'
#' @description
#' \code{howlerPlayer} contains all of the logic that is required for howler.js to be able to work.
#'
#' @param id HTML id tag to be given to the player
#' @param files Files that will be used in the player
#' @param volume How loud the player should start off at. Defaults to 70\%
#' @param autoplay_next If there are multiple files, would you like to auto play the next file after the current
#' one has finished? Defaults to \code{TRUE}
#' @param autoplay_loop Once all files have been played, would you like to restart the playlist?
#' Defaults to \code{FALSE}
#'
#' @details
#' All buttons associated with the \code{howlerPlayer} should be given the same \code{id} argument. This is to ensure
#' that the buttons are linked to the player.
#'
#' i.e. If \code{howlerPlayer(id = "howler")}, then \code{playButton(id = "howler")}
#'
#' @return
#' A shiny.tag containing all of the required options for a \code{howler} object to be created in a shiny application
#'
#' @examples
#' \dontrun{
#' library(shiny)
#'
#' ui <- fluidPage(
#'   useHowlerJS(),
#'   howlerPlayer("howler", "audio/sound.mp3"),
#'   playButton("howler")
#' )
#'
#' server <- function(input, output) {
#' }
#'
#' runShiny(ui, server)
#' }
#'
#' @export
howlerPlayer <- function(id, files, volume = 0.7, autoplay_next = TRUE, autoplay_loop = FALSE) {
  files_jsn <- jsonlite::toJSON(files)

  div(
    id = id,
    class = "howler-player",
    `data-audio-files` = files_jsn,
    `data-autoplay-next-track` = autoplay_next,
    `data-autoloop` = autoplay_loop,
    `data-volume` = volume,
  )
}
