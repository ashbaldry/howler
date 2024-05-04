test_that("howlerCurrentTrack fails with no id", {
  expect_error(howlerCurrentTrack())
})

test_that("howlerCurrentTrack passes with id", {
  expect_error(howlerCurrentTrack("test"), regexp = NA)
})

test_that("howlerCurrentTrack creates 'div' shiny.tag", {
  current_track_info <- howlerCurrentTrack("test")

  expect_is(current_track_info, "shiny.tag")
  expect_identical(current_track_info$name, "div")
  expect_match(current_track_info$attribs$class, "howler-current-track")
})
