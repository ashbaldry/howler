#' Create a Howler Audio Player
#'
#' @description
#' \code{howler} is used to initialise the 'howler.js' framework by adding all of the specified tracks to the
#' player, and can be run by either including UI buttons or server-side actions.
#'
#' @param tracks A named vector of file paths to sounds. If multiple file extensions are included, then use a named
#' list instead, with each list item containing each extension of the sound.
#' @param options A named list of options to add to the player. For a full list of options see
#' \url{https://github.com/goldfire/howler.js}
#' @param track_formats An optional list of formats of the sounds. By default 'howler' will guess the format to
#' play in. Must be the same length as tracks
#' @param auto_continue If there are multiple files, would you like to auto play the next file after the current
#' one has finished? Defaults to \code{TRUE}
#' @param auto_loop Once all files have been played, would you like to restart playing the playlist?
#' Defaults to \code{FALSE}
#' @param seek_ping_rate Number of milliseconds between each update of `input$\{id\}_seek` while playing. Default is
#' set to 1000. If set to 0, then `input$\{id\}_seek` will not exist.
#' @param elementId HTML id tag to be given to the howler player element
#'
#' @details
#' All buttons associated with the \code{howler} should be given the same \code{id} argument. This is to ensure
#' that the buttons are linked to the player.
#'
#' i.e. If \code{howler(id = "howler")}, then \code{howlerPlayButton(id = "howler")}
#'
#' @return
#' A shiny.tag containing all of the required options for a \code{Howl} JS object to be initialised in a shiny application.
#'
#' On the server side there will be up to four additional objects available as inputs:
#' \describe{
#' \item{\code{\{id\}_playing}}{A logical value as to whether or not the \code{howler} is playing audio}
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
#'     howler(elementId = "howler", c(sound = "audio/sound.mp3")),
#'     howlerPlayPauseButton("howler")
#'   )
#'
#'   server <- function(input, output) {
#'   }
#'
#'   runShiny(ui, server)
#' }
#'
#' \dontrun{
#' # Multiple file formats
#' howler(
#'   elementId = "howler",
#'   list(
#'     track_1 = c("audio/sound.webm", "audio/sound.mp3"),
#'     track_2 = c("audio/sound2.webm", "audio/sound2.mp3"),
#'   )
#' )
#' }
#'
#' @seealso \code{\link{howlerButton}}, \code{\link{howlerServer}}
#'
#' @import htmlwidgets
#' @import shiny
#'
#' @export
howler <- function(tracks, options = list(), track_formats = NULL,
                   auto_continue = FALSE, auto_loop = FALSE, seek_ping_rate = 1000, elementId = NULL) {

  if (!(is.null(track_formats) || length(tracks) == length(track_formats))) {
    stop("Track formats must be the same length as tracks")
  }

  if (seek_ping_rate < 0) {
    stop("Seek ping rate cannot be negative")
  }

  if (is.null(names(tracks))) {
    track_names <- vapply(
      tracks,
      function(x) sub("\\.[^\\.]+$", "", basename(x[1])),
      character(1),
      USE.NAMES = FALSE
    )
  } else {
    track_names <- names(tracks)
  }

  settings <- list(
    tracks = as.list(unname(tracks)),
    names = as.list(track_names),
    formats = as.list(track_formats),
    auto_continue = auto_continue,
    auto_loop = auto_loop,
    seek_ping_rate = seek_ping_rate,
    options = options
  )

  settings <- settings[!vapply(settings, is.null, logical(1))]

  htmlwidgets::createWidget(
    name = "howler",
    x = settings,
    width = "0",
    height = "0",
    package = "howler",
    elementId = elementId
  )
}

#' Shiny bindings for howler
#'
#' Output and render functions for using howler within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a howler
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name howler-shiny
#'
#' @export
howlerOutput <- function(outputId, width = '0', height = '0') {
  htmlwidgets::shinyWidgetOutput(outputId, 'howler', package = 'howler')
}

#' @rdname howler-shiny
#' @export
renderHowler <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, howlerOutput, env, quoted = TRUE)
}

howler_html <- function(id, style, class, ...) {
  tags$audio(
    id = id,
    style = style,
    class = class,
    ...
  )
}
