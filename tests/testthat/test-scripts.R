context("Checking JS Scripts")

testthat::test_that("JS scripts exist in correct location", {
  howler_scripts <- useHowlerJS(spatial = TRUE)
  howler_script_paths <- sapply(howler_scripts$children, function(x) x$attribs$src)

  testthat::expect_true(all(grepl("howlerjs/.*\\.js", howler_script_paths)))
})
