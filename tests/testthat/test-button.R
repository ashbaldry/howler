test_that("howlerButton fails with no `id`", {
  expect_error(howlerButton())
})

test_that("howlerButton passes with any `id`", {
  expect_error(howlerButton("test"), regexp = NA)
})

test_that("Basic howlerButton creates 'button' shiny.tag", {
  button <- howlerButton("test")

  expect_is(button, "shiny.tag")
  expect_identical(button$name, "button")
  expect_match(button$attribs$class, "\\baction-button\\b")
  expect_match(button$attribs$class, "\\bhowler-")
})

test_that("howlerButton works for all `HOWLER_BUTTON_TYPES`", {
  for (i in HOWLER_BUTTON_TYPES) {
    expect_error(howlerButton("test", button_type = i), regexp = NA)
  }
})

test_that("howlerButton fails for random button_type", {
  expect_error(howlerButton("test", button_type = "this will fail"))
})

test_that("All specific buttons produce a valid howlerButton with icon", {
  button_functions <- ls("package:howler", pattern = "howler.+Button")

  for (button_function in button_functions) {
    button <- get(button_function)("test")

    expect_is(button, "shiny.tag")
    expect_identical(button$name, "button")
    expect_match(button$attribs$class, "\\baction-button\\b")
    expect_match(button$attribs$class, "\\bhowler-")

    expect_is(button$children[[1L]], "shiny.tag")
    expect_identical(button$children[[1L]]$name, "i")
    expect_match(button$children[[1L]]$attribs$class, "\\bfa\\b")
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

  expect_true(all(paste0("howler-", HOWLER_BUTTON_TYPES) %in% classes))
})
