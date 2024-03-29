test_that("howlerModuleUI fails with no `id`", {
  testthat::expect_error(howlerModuleUI())
})

test_that("howlerModuleUI fails with no files", {
  testthat::expect_error(howlerModuleUI("test"))
})

test_that("howlerModuleUI passes with 1 file", {
  testthat::expect_error(howlerModuleUI("test", "test.mp3"), NA)
})

test_that("howlerModuleUI passes with multiple files", {
  testthat::expect_error(howlerModuleUI("test", rep("test.mp3", 3)), NA)
})

test_that("howlerModuleUI errors when seek rate is negative", {
  testthat::expect_error(howlerModuleUI("test", "test.mp3", seek_ping_rate = -1))
})

test_that("howlerBasicModuleUI fails with no `id`", {
  testthat::expect_error(howlerBasicModuleUI())
})

test_that("howlerBasicModuleUI fails with no files", {
  testthat::expect_error(howlerBasicModuleUI("test"))
})

test_that("howlerBasicModuleUI passes with 1 file", {
  testthat::expect_error(howlerBasicModuleUI("test", "test.mp3"), NA)
})

test_that("howlerBasicModuleUI errors with multiple files", {
  testthat::expect_error(howlerBasicModuleUI("test", rep("test.mp3", 3)))
})

test_that("howlerBasicModuleUI errors when seek rate is negative", {
  testthat::expect_error(howlerBasicModuleUI("test", "test.mp3", seek_ping_rate = -1))
})

test_that("howlerModuleServer fails with no `id`", {
  testthat::expect_error(howlerModuleServer())
})
