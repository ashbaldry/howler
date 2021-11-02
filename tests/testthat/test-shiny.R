testthat::context("Shiny Application Tests")

testthat::test_that("howlerModule works", {
  example_app <- system.file("examples/module", package = "howler")
  howler_module_app <- tryCatch(shinytest::ShinyDriver$new(example_app, 3000), error = function(e) NULL)
  testthat::skip_if(is.null(howler_module_app), "Unable to initialise application")
  on.exit(howler_module_app$stop())

  testthat::expect_error(howler_module_app$findElement("#sound-howler"), NA)
  testthat::expect_error(howler_module_app$click("sound-howler_play_pause"), NA)
})

testthat::test_that("Server-side functions work", {
  example_app <- system.file("examples/server", package = "howler")
  howler_module_app <- tryCatch(shinytest::ShinyDriver$new(example_app, 3000), error = function(e) NULL)
  testthat::skip_if(is.null(howler_module_app), "Unable to initialise application")
  on.exit(howler_module_app$stop())

  testthat::expect_error(howler_module_app$findElement("#sound"), NA)
  testthat::expect_error(howler_module_app$click("sound_play_pause"), NA)
})
