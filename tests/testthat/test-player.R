testthat::context("Howler Player")

testthat::test_that("howlerPlayer fails with no `id`", {
  testthat::expect_error(howlerButton())
})

testthat::test_that("howlerPlayer fails with no files", {
  testthat::expect_error(howlerPlayer("test"))
})

testthat::test_that("howlerPlayer passes with 1 file", {
  testthat::expect_error(howlerPlayer("test", "test.mp3"), NA)
})

testthat::test_that("howlerPlayer passes with multiple files", {
  testthat::expect_error(howlerPlayer("test", rep("test.mp3", 3)), NA)
})

testthat::test_that("howlerPlayer creates 'div' shiny.tag", {
  player <- howlerPlayer("test", "test.mp3")

  testthat::expect_is(player, "shiny.tag")
  testthat::expect_equal(player$name, "div")
  testthat::expect_match(player$attribs$class, "howler-player")
})

testthat::test_that("howlerPlayer contains track names", {
  player <- howlerPlayer("test", "test.mp3")
  attributes <- paste0("data-", c("autoplay-next-track", "autoloop", "volume", "seek-rate"))

  testthat::expect_match(player$attribs$`data-audio-files`, "test.mp3")
})

testthat::test_that("howlerPlayer contains autoplay, autoloop, volume and seek rate attributes", {
  player <- howlerPlayer("test", "test.mp3")
  attributes <- paste0("data-", c("autoplay-next-track", "autoloop", "volume", "seek-rate"))

  testthat::expect_true(all(attributes %in% names(player$attribs)))
})

testthat::test_that("howlerPlayer errors when volume is negative", {
  testthat::expect_error(howlerPlayer("test", "test.mp3", volume = -1))
})

testthat::test_that("howlerPlayer errors when volume is greater than 1", {
  testthat::expect_error(howlerPlayer("test", "test.mp3", volume = 2))
})

testthat::test_that("howlerPlayer errors when seek rate is negative", {
  testthat::expect_error(howlerPlayer("test", "test.mp3", seek_ping_rate = -1))
})
