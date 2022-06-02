testthat::context("Shiny Application Tests")

testthat::test_that("howlerModule works", {
  # Don't run these tests on the CRAN build servers
  testthat::skip_on_cran()

  audio_files_dir <- system.file("examples/_audio", package = "howler")
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

  Sys.sleep(1)

  testthat::expect_false(app$get_value(input = "howler_playing"))
  testthat::expect_equal(app$get_value(input = "howler_seek"), 0)
  testthat::expect_gte(app$get_value(input = "howler_duration"), 0)

  first_track <- list(name = sub(".mp3", "", basename(audio_files[1])), id = 1)
  testthat::expect_equal(app$get_value(input = "howler_track"), first_track)

  app$click(selector = ".howler-next-button")
  Sys.sleep(1)
  second_track <- list(name = sub(".mp3", "", basename(audio_files[2])), id = 2)
  testthat::expect_equal(app$get_value(input = "howler_track"), second_track)
})
