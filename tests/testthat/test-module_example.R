test_that("Module example works", {
  # Don't run these tests on the CRAN build servers
  testthat::skip_on_cran()

  example_dir <- system.file("examples", "module", package = "howler")
  app <- shinytest2::AppDriver$new(example_dir, name = "howler_app")
  on.exit(app$stop())

  Sys.sleep(1L)

  testthat::expect_false(app$get_value(input = "sound-howler_playing"))
  testthat::expect_identical(app$get_value(input = "sound-howler_seek"), 0L)
  testthat::expect_gte(app$get_value(input = "sound-howler_duration"), 0L)

  testthat::expect_false(app$get_value(input = "sound2-howler_playing"))
  testthat::expect_identical(app$get_value(input = "sound2-howler_seek"), 0L)
  testthat::expect_gte(app$get_value(input = "sound2-howler_duration"), 0L)
})
