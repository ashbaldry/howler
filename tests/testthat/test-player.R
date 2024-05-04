test_that("howler fails with no `id`", {
  expect_error(howler())
})

test_that("howler fails with no files", {
  expect_error(howler(elementId = "test"))
})

test_that("howler passes with 1 file", {
  expect_error(howler(elementId = "test", "test.mp3"), NA)
})

test_that("howler passes with multiple files", {
  expect_error(howler(elementId = "test", rep("test.mp3", 3L)), NA)
})

test_that("Valid howler creates htmlwidget", {
  expect_is(howler(elementId = "test", "test.mp3"), c("howler", "htmlwidget"))
})

test_that("howler contains track names", {
  player <- howler(elementId = "test", "test.mp3")
  attribs <- c("tracks", "names", "auto_continue", "auto_loop", "seek_ping_rate", "options")

  expect_true(all(attribs %in% names(player$x)))
  expect_match(player$x$tracks[[1L]], "test.mp3")
  expect_match(player$x$names[[1L]], "test")
})

test_that("howler errors when seek rate is negative", {
  expect_error(howler(elementId = "test", "test.mp3", seek_ping_rate = -1L))
})
