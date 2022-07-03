test_that("howlerButton fails with no `id`", {
  testthat::expect_error(howlerButton())
})

test_that("howlerButton passes with any `id`", {
  testthat::expect_error(howlerButton("test"), regexp = NA)
})

test_that("Basic howlerButton creates 'button' shiny.tag", {
  button <- howlerButton("test")

  testthat::expect_is(button, "shiny.tag")
  testthat::expect_equal(button$name, "button")
  testthat::expect_match(button$attribs$class, "\\baction-button\\b")
  testthat::expect_match(button$attribs$class, "\\bhowler-")
})

test_that("howlerButton works for all `HOWLER_BUTTON_TYPES`", {
  for (i in HOWLER_BUTTON_TYPES) {
    testthat::expect_error(howlerButton("test", button_type = i), regexp = NA)
  }
})

test_that("howlerButton fails for random button_type", {
  testthat::expect_error(howlerButton("test", button_type = "this will fail"))
})

test_that("All specific buttons produce a valid howlerButton with icon", {
  button_functions <- ls("package:howler", pattern = "howler.+Button")

  for (button_function in button_functions) {
    button <- get(button_function)("test")

    testthat::expect_is(button, "shiny.tag")
    testthat::expect_equal(button$name, "button")
    testthat::expect_match(button$attribs$class, "\\baction-button\\b")
    testthat::expect_match(button$attribs$class, "\\bhowler-")

    testthat::expect_is(button$children[[1]], "shiny.tag")
    testthat::expect_equal(button$children[[1]]$name, "i")
    testthat::expect_match(button$children[[1]]$attribs$class, "\\bfa\\b")
  }
})

test_that("All `HOWLER_BUTTON_TYPES` have a wrapper function", {
  button_functions <- ls("package:howler", pattern = "howler.+Button")

  classes <- sapply(
    button_functions,
    function(button_function) {
      button_class <- get(button_function)("test")$attribs$class
      sub(".*(howler-\\w+).*", "\\1", button_class)
    },
    USE.NAMES = FALSE
  )

  testthat::expect_true(all(paste0("howler-", HOWLER_BUTTON_TYPES) %in% classes))
})
