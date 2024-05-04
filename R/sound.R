#' Play Sound
#'
#' @description
#' Using howler.js, play a sound within a shiny application.
#'
#' @param track Either a URL, file path or Base 64 character string of the
#' sound to play
#' @param options A named list of options to add to the sound. For a full list of options see
#' \url{https://github.com/goldfire/howler.js?tab=readme-ov-file#options}
#' @param session Shiny session
#'
#' @details
#' The `src` and `autoplay` options are pre-determined by `playSound` and are not required
#' in `options`. If they are included, a warning will be printed and they will be ignored
#' from the list.
#'
#'
#' @examplesIf interactive()
#' library(shiny)
#'
#' audio_files_dir <- system.file("examples/_audio", package = "howler")
#' addResourcePath("sample_audio", audio_files_dir)
#'
#' ui <- fluidPage(
#'   actionButton("play", "Play Sound")
#' )
#'
#' server <- function(input, output) {
#'   observeEvent(input$play, {
#'     playSound("sample_audio/running_out.mp3")
#'   })
#' }
#'
#' shinyApp(ui, server)
#'
#' @export
playSound <- function(track, options = NULL, session = getDefaultReactiveDomain()) {
  if ("autoplay" %in% names(options)) {
    warning("autoplay is not required for `playSound` as the sound will automatically play")
    options <- options[-match("autoplay", names(options))]
  }
  if ("src" %in% names(options)) {
    warning("src is not required for `playSound` as the track will be used for src")
    options <- options[-match("src", names(options))]
  }

  sound_settings <- append(
    list(src = track, autoplay = TRUE),
    options
  )

  if (is.null(session$userData$.howler_added) || !session$userData$.howler_added) {
    shiny::insertUI(
      "head",
      "beforeEnd",
      immediate = TRUE,
      ui = HOWLER_DEPENDENCIES
    )
    session$userData$.howler_added <- TRUE
  }

  session$sendCustomMessage(
    "playHowlerSound",
    sound_settings
  )
}

HOWLER_DEPENDENCIES <- list(
  htmltools::htmlDependency(
    "howler",
    version = "2.2.3",
    package = "howler",
    src = file.path("htmlwidgets", "howler"),
    script = "howler.min.js"
  ),
  htmltools::htmlDependency(
    "howler-bindings",
    version = packageVersion("howler"),
    package = "howler",
    src = file.path("htmlwidgets", "howler-bindings"),
    script = "howler-bindings.js"
  )
)
