testthat::context("Howler Volume Slider")

testthat::test_that("howlerVolumeSlider fails with no `id`", {
  testthat::expect_error(howlerVolumeSlider())
})

testthat::test_that("howlerVolumeSlider passes with any `id`", {
  testthat::expect_error(howlerVolumeSlider("test"), regexp = NA)
})

testthat::test_that("Basic howlerVolumeSlider creates two shiny tags: volume button and slider input", {
  slider <- howlerVolumeSlider("test")

  testthat::expect_is(slider, "shiny.tag.list")
  testthat::expect_length(slider, 2)

  testthat::expect_equal(slider[[1]]$name, "a")
  testthat::expect_match(slider[[1]]$attribs$class, "action-button")
  testthat::expect_match(slider[[1]]$attribs$class, "howler-volumetoggle")

  testthat::expect_equal(slider[[2]]$name, "input")
  testthat::expect_match(slider[[2]]$attribs$class, "howler-volume-slider")
})

testthat::test_that("Basic howlerVolumeSlider has volume of 1", {
  slider <- howlerVolumeSlider("test")

  testthat::expect_equal(slider[[2]]$attribs$value, 1)
})

testthat::test_that("howlerVolumeSlider errors when volume is negative", {
  testthat::expect_error(howlerVolumeSlider("test", -1))
})

testthat::test_that("howlerVolumeSlider errors when volume is greater than 1", {
  testthat::expect_error(howlerVolumeSlider("test", 2))
})


testthat::context("Howler Seek Slider")

testthat::test_that("howlerSeekSlider fails with no `id`", {
  testthat::expect_error(howlerSeekSlider())
})

testthat::test_that("howlerVolumeSlider passes with any `id`", {
  testthat::expect_error(howlerSeekSlider("test"), regexp = NA)
})

testthat::test_that("Basic howlerSeekSlider creates a slider input", {
  slider <- howlerSeekSlider("test")

  testthat::expect_is(slider, "shiny.tag")
  testthat::expect_equal(slider$name, "input")
  testthat::expect_match(slider$attribs$class, "howler-seek-slider")
})
