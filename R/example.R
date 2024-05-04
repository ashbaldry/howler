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
#' @return
#' This function does not return a value; interrupt R to stop the application (usually by pressing Ctrl+C or Esc).
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
runHowlerExample <- function(example = "basic", display.mode = "showcase", ...) { # nolint object_name_linter
  available_examples <- findHowlerExamples()
  if (!example %in% available_examples) {
    stop(
      "Example not available. Choose from: ",
      toString(paste0("'", available_examples, "'")),
      call. = FALSE
    )
  }

  shiny::runApp(
    system.file("examples", example, package = "howler"),
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
