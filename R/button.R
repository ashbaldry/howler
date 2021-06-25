#' @export
howlerButton <- function(id, button_type = HOWLER_BUTTON_TYPES, ...) {
  button_type <- match.arg(button_type)
  button_id <- paste0(id, "_", button_type)

  tags$button(id = button_id, class = paste0("howler-", button_type), ...)
}

HOWLER_BUTTON_TYPES <- c("play_pause", "play", "next", "previous", "volumeup", "volumedown")
