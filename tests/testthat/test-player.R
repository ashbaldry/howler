testthat::context("Howler Player")

testthat::test_that("howler fails with no `id`", {
  testthat::expect_error(howler())
})

testthat::test_that("howler fails with no files", {
  testthat::expect_error(howler(elementId = "test"))
})

testthat::test_that("howler passes with 1 file", {
  testthat::expect_error(howler(elementId = "test", "test.mp3"), NA)
})

testthat::test_that("howler passes with multiple files", {
  testthat::expect_error(howler(elementId = "test", rep("test.mp3", 3)), NA)
})

testthat::test_that("Valid howler creates htmlwidget", {
  testthat::expect_is(howler(elementId = "test", "test.mp3"), c("howler", "htmlwidget"))
})

testthat::test_that("howler contains track names", {
  player <- howler(elementId = "test", "test.mp3")
  attribs <- c("tracks", "names", "auto_continue", "auto_loop", "seek_ping_rate", "options")

  testthat::expect_true(all(attribs %in% names(player$x)))
  testthat::expect_match(player$x$tracks[[1]], "test.mp3")
  testthat::expect_match(player$x$names[[1]], "test")
})

testthat::test_that("howler errors when seek rate is negative", {
  testthat::expect_error(howler(elementId = "test", "test.mp3", seek_ping_rate = -1))
})
