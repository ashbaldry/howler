context("Checking JS Scripts")

testthat::test_that("JS scripts exist in correct location", {
  howler_scripts <- useHowlerJS(spatial = TRUE)
  howler_script_paths <- sapply(howler_scripts$children, function(x) {
    if (x$name == "script") x$attribs$src else x$attribs$href
  })

  testthat::expect_true(all(grepl("howlerjs/.*\\.(js|css)", howler_script_paths)))
})
