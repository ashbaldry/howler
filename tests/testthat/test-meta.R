test_that("howlerCurrentTrack fails with no id", {
  testthat::expect_error(howlerCurrentTrack())
})

test_that("howlerCurrentTrack passes with id", {
  testthat::expect_error(howlerCurrentTrack("test"), regexp = NA)
})

test_that("howlerCurrentTrack creates 'div' shiny.tag", {
  current_track_info <- howlerCurrentTrack("test")

  testthat::expect_is(current_track_info, "shiny.tag")
  testthat::expect_equal(current_track_info$name, "div")
  testthat::expect_match(current_track_info$attribs$class, "howler-current-track")
})
