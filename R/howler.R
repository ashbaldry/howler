#' Create a Howler Audio Player
#'
#' @description
#'
#' @import htmlwidgets
#'
#' @export
howler <- function(tracks, options = list(),
                   width = "100%", height = "100px", elementId = NULL) {

  if (is.null(names(tracks))) {
    tracks <- setNames(
      as.list(tracks),
      sapply(tracks, function(x) sub("\\.[^\\.]+$", "", basename(x[1])))
    )
  }

  htmlwidgets::createWidget(
    name = "howler",
    x = c(list(tracks = tracks), options),
    width = width,
    height = height,
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
howlerOutput <- function(outputId, width = '100%', height = '400px') {
  htmlwidgets::shinyWidgetOutput(outputId, 'howler', package = 'howler')
}

#' @rdname howler-shiny
#' @export
renderHowler <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, howlerOutput, env, quoted = TRUE)
}
