#' Howler.js Player
#'
#' @description
#' \code{howlerPlayer} contains all of the logic that is required for howler.js to be able to work.
#'
#' @param id HTML id tag to be given to the player element
#' @param files Files that will be used in the player. This can either be a single vector, or a list where different
#' formats of the same file are kept in each element of the list.
#' @param volume How loud the player should start off at. Defaults to 70\%
#' @param autoplay_next If there are multiple files, would you like to auto play the next file after the current
#' one has finished? Defaults to \code{TRUE}
#' @param autoplay_loop Once all files have been played, would you like to restart the playlist?
#' Defaults to \code{FALSE}
#' @param seek_ping_rate Number of milliseconds between each update of `input$\{id\}_seek` while playing. Default is
#' set to 1000. If set to 0, then `input$\{id\}_seek` will not exist.
#'
#' @details
#' All buttons associated with the \code{howlerPlayer} should be given the same \code{id} argument. This is to ensure
#' that the buttons are linked to the player.
#'
#' i.e. If \code{howlerPlayer(id = "howler")}, then \code{playButton(id = "howler")}
#'
#' @return
#' A shiny.tag containing all of the required options for a \code{Howler} object to be created in a shiny application
#'
#' On the server side there will be three/four objects available as inputs:
#' \describe{
#' \item{\code{\{id\}_playing}}{A binary as to whether or not the \code{howlerPlayer} is playing audio}
#' \item{\code{\{id\}_track}}{Basename of the file currently loaded}
#' \item{\code{\{id\}_seek}}{(If \code{seek_ping_rate > 0}) the current time of the track loaded}
#' \item{\code{\{id\}_duration}}{The duratio of the track loaded}
#' }
#'
#' @examples
#' \dontrun{
#' library(shiny)
#'
#' ui <- fluidPage(
#'   useHowlerJS(),
#'   howlerPlayer("howler", "audio/sound.mp3"),
#'   howlerButton("howler", "play_pause")
#' )
#'
#' server <- function(input, output) {
#' }
#'
#' runShiny(ui, server)
#' }
#'
#' @export
howlerPlayer <- function(id, files, volume = 0.7, autoplay_next = TRUE, autoplay_loop = FALSE, seek_ping_rate = 1000) {
  files_jsn <- jsonlite::toJSON(files)

  div(
    id = id,
    class = "howler-player",
    `data-audio-files` = files_jsn,
    `data-autoplay-next-track` = autoplay_next,
    `data-autoloop` = autoplay_loop,
    `data-volume` = volume,
    `data-seek-rate` = seek_ping_rate
  )
}
