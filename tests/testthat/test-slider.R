test_that("howlerVolumeSlider fails with no `id`", {
  testthat::expect_error(howlerVolumeSlider())
})

test_that("howlerVolumeSlider passes with any `id`", {
  testthat::expect_error(howlerVolumeSlider("test"), regexp = NA)
})

test_that("Basic howlerVolumeSlider creates two shiny tags: volume button and slider input", {
  slider <- howlerVolumeSlider("test")

  testthat::expect_is(slider, "shiny.tag.list")
  testthat::expect_length(slider, 2L)

  testthat::expect_identical(slider[[1L]]$name, "button")
  testthat::expect_match(slider[[1L]]$attribs$class, "action-button")
  testthat::expect_match(slider[[1L]]$attribs$class, "howler-volumetoggle")

  testthat::expect_identical(slider[[2L]]$name, "input")
  testthat::expect_match(slider[[2L]]$attribs$class, "howler-volume-slider")
})

test_that("Basic howlerVolumeSlider has volume of 1", {
  slider <- howlerVolumeSlider("test")

  testthat::expect_identical(slider[[2L]]$attribs$value, 1.0)
})

test_that("howlerVolumeSlider errors when volume is negative", {
  testthat::expect_error(howlerVolumeSlider("test", -1.0))
})

test_that("howlerVolumeSlider errors when volume is greater than 1", {
  testthat::expect_error(howlerVolumeSlider("test", 2.0))
})


testthat::context("Howler Seek Slider")

test_that("howlerSeekSlider fails with no `id`", {
  testthat::expect_error(howlerSeekSlider())
})

test_that("howlerVolumeSlider passes with any `id`", {
  testthat::expect_error(howlerSeekSlider("test"), regexp = NA)
})

test_that("Basic howlerSeekSlider creates a slider input", {
  slider <- howlerSeekSlider("test")

  testthat::expect_is(slider, "shiny.tag")
  testthat::expect_identical(slider$name, "input")
  testthat::expect_match(slider$attribs$class, "howler-seek-slider")
})
