#' Howler.js Player
#'
#' @description
#' \code{howlerPlayer} is used to initialise the 'howler.js' framework by adding all of the specified tracks to the
#' player, and can be run by either including UI buttons or server-side actions.
#'
#' In order for \code{howlerPlayer} to work, \code{\link{useHowlerJS}} must be included in the application UI.
#'
#' @param id HTML id tag to be given to the howler player element
#' @param files Files that will be used in the player. This can either be a single vector, or a list where different
#' formats of the same file are kept in each element of the list
#' @param volume How loud the player should start off at. Defaults to 0.7 (70\%). If \code{\link{volumeSlider}} is
#' included, then this will be overriden by the value used there.
#' @param autoplay_next If there are multiple files, would you like to auto play the next file after the current
#' one has finished? Defaults to \code{TRUE}
#' @param autoplay_loop Once all files have been played, would you like to restart playing the playlist?
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
#' A shiny.tag containing all of the required options for a \code{Howl} JS object to be initialised in a shiny application.
#'
#' On the server side there will be up to four additional objects available as inputs:
#' \describe{
#' \item{\code{\{id\}_playing}}{A logical value as to whether or not the \code{howlerPlayer} is playing audio}
#' \item{\code{\{id\}_track}}{Basename of the file currently loaded}
#' \item{\code{\{id\}_seek}}{(If \code{seek_ping_rate > 0}) the current time of the track loaded}
#' \item{\code{\{id\}_duration}}{The duration of the track loaded}
#' }
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'
#'   ui <- fluidPage(
#'     title = "howler.js Player",
#'     useHowlerJS(),
#'     howlerPlayer("howler", "audio/sound.mp3"),
#'     playPauseButton("howler")
#'   )
#'
#'   server <- function(input, output) {
#'   }
#'
#'   runShiny(ui, server)
#' }
#'
#' @seealso \code{\link{howlerButton}}, \code{\link{howlerServer}}
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
