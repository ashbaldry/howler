#' @export
howlerPlayer <- function(id, files, autoplay_next = TRUE, autoplay_loop = FALSE) {
  files_jsn <- jsonlite::toJSON(files)

  div(
    id = id,
    class = "howler-player",
    `data-audio-files` = files_jsn,
    `data-autoplay-next-track` = autoplay_next,
    `data-autoloop` = autoplay_loop
  )
}
