#' Volume Slider
#'
#' @export
volumeSlider <- function(id, volume = 0.7) {
  tagList(
    tags$a(shiny::icon("volume-up")),
    tags$input(
      class = "howler-volume-slider",
      id = paste0(id, "_volume_slider"),
      type = "range",
      min = "0",
      max = "100",
      value = volume * 100
    ),
  )
}
