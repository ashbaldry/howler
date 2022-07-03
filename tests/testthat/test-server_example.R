test_that("Server-side example works", {
  # Don't run these tests on the CRAN build servers
  testthat::skip_on_cran()

  example_dir <- system.file("examples", "server", package = "howler")
  app <- shinytest2::AppDriver$new(example_dir, name = "howler_app")
  on.exit(app$stop())

  Sys.sleep(1)

  testthat::expect_false(app$get_value(input = "sound_playing"))
  testthat::expect_equal(app$get_value(input = "sound_seek"), 0)
  testthat::expect_gte(app$get_value(input = "sound_duration"), 0)

  app$click(selector = "#add_track")
  Sys.sleep(1)
  testthat::expect_equal(app$get_value(input = "sound_track")$name, "running_out")
})
