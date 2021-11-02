#' Run \code{\{howler\}} Example Applications
#'
#' @param example Name of the example to load. Current examples include:
#' \describe{
#' \item{basic}{Basic example of \code{howler} in use}
#' \item{full}{Basic example of using all buttons available in \code{howler}}
#' \item{module}{Example of using the \code{howlerModule}}
#' \item{server}{Example showing server-side functionality}
#' }
#' @param display.mode The mode in which to display the application. By default set to \code{"showcase"} to show
#' code behind the example.
#' @param ... Optional arguments to send to \code{shiny::runApp}
#'
#' @examples
#' availableHowlerExamples()
#'
#' if (interactive()) {
#'   library(shiny)
#'   library(howler)
#'
#'   runHowlerExample("basic")
#' }
#'
#' @rdname examples
#' @export
runHowlerExample <- function(example = "basic", display.mode = "showcase", ...) {
  available_examples <- findHowlerExamples()
  if (!example %in% available_examples) {
    stop("Example not available. Choose from: '", paste(available_examples, collapse = "', '"), "'")
  }

  shiny::runApp(
    file.path(system.file("examples", package = "howler"), example),
    display.mode = display.mode,
    ...
  )
}

#' @rdname examples
#' @export
availableHowlerExamples <- function() {
  available_examples <- findHowlerExamples()
  cat("'", paste(available_examples, collapse = "', '"), "'\n", sep = "")

  invisible(available_examples)
}

findHowlerExamples <- function() {
  example_dir <- system.file("examples", package = "howler")
  setdiff(list.files(example_dir), "_audio")
}
