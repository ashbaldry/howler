test_that("howlerModule works", {
  # Don't run these tests on the CRAN build servers
  skip_on_cran()

  audio_files_dir <- system.file("examples", "_audio", package = "howler")
  addResourcePath("sample_audio", audio_files_dir)
  audio_files <- file.path("sample_audio", list.files(audio_files_dir, ".mp3$"))

  ui <- fluidPage(
    howlerModuleUI(NULL, audio_files)
  )

  server <- function(input, output, session) {
    howlerModuleServer(NULL)
  }

  app <- shinytest2::AppDriver$new(shinyApp(ui, server), name = "howler_app")
  on.exit(app$stop())

  Sys.sleep(1L)

  expect_false(app$get_value(input = "howler_playing"))
  expect_identical(app$get_value(input = "howler_seek"), 0L)
  expect_gte(app$get_value(input = "howler_duration"), 0L)

  first_track <- list(name = sub(".mp3", "", basename(audio_files[1L])), id = 1L)
  expect_identical(app$get_value(input = "howler_track"), first_track)

  app$click(selector = ".howler-next-button")
  Sys.sleep(1L)
  second_track <- list(name = sub(".mp3", "", basename(audio_files[2L])), id = 2L)
  expect_identical(app$get_value(input = "howler_track"), second_track)
})
