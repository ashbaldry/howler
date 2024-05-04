test_that("howlerModuleUI fails with no `id`", {
  expect_error(howlerModuleUI())
})

test_that("howlerModuleUI fails with no files", {
  expect_error(howlerModuleUI("test"))
})

test_that("howlerModuleUI passes with 1 file", {
  expect_error(howlerModuleUI("test", "test.mp3"), NA)
})

test_that("howlerModuleUI passes with multiple files", {
  expect_error(howlerModuleUI("test", rep("test.mp3", 3L)), NA)
})

test_that("howlerModuleUI errors when seek rate is negative", {
  expect_error(howlerModuleUI("test", "test.mp3", seek_ping_rate = -1L))
})

test_that("howlerBasicModuleUI fails with no `id`", {
  expect_error(howlerBasicModuleUI())
})

test_that("howlerBasicModuleUI fails with no files", {
  expect_error(howlerBasicModuleUI("test"))
})

test_that("howlerBasicModuleUI passes with 1 file", {
  expect_error(howlerBasicModuleUI("test", "test.mp3"), NA)
})

test_that("howlerBasicModuleUI errors with multiple files", {
  expect_error(howlerBasicModuleUI("test", rep("test.mp3", 3L)))
})

test_that("howlerBasicModuleUI errors when seek rate is negative", {
  expect_error(howlerBasicModuleUI("test", "test.mp3", seek_ping_rate = -1L))
})

test_that("howlerModuleServer fails with no `id`", {
  expect_error(howlerModuleServer())
})
