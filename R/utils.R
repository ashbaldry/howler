#' Enable \code{HowlerJS}
#'
#' @description
#' Add this function to the UI of a shiny application in order for you to be able to use HowlerJS
#'
#' @return A script tag that enables \code{howler} to work within a shiny app.
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'
#'   ui <- fluidPage(
#'     title = "Initial Title",
#'     useHowlerJS(),
#'     actionButton("button", "Play Sound"),
#'   )
#'
#'   server <- function(input, output, session) {
#'     observeEvent(input$button, playSound(session))
#'   }
#'
#'   shinyApp(ui, server)
#' }
#'
#' @export
useHowlerJS <- function(spatial = FALSE) {
  file <- system.file("srcjs", package = "howler", mustWork = TRUE)
  shiny::addResourcePath("howlerjs", file)

  shiny::tags$head(
    shiny::tags$script(src = "howlerjs/howler.core.min.js"),
    if (spatial) shiny::tags$script(src = "howlerjs/howler.spatial.min.js"),
    shiny::tags$script(src = "howlerjs/howler.shiny.js")
  )
}
