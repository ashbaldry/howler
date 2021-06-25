#' @export
howlerPlayer <- function(id, files) {
  files_jsn <- jsonlite::toJSON(files)

  div(id = id, class = "howler-player", `data-audio-files` = files_jsn)
}
