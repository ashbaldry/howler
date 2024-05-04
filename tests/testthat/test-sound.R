testthat::test_that("Sound can be play in shiny app", {
  # Don't run these tests on the CRAN build servers
  testthat::skip_on_cran()

  audio_file <- system.file("examples", "_audio", "80s_vibe.mp3", package = "howler")

  ui <- fluidPage(
    actionButton("play", "Play Sound")
  )

  server <- function(input, output, session) {
    observeEvent(input$play, playSound(audio_file))
  }

  app <- shinytest2::AppDriver$new(shinyApp(ui, server), name = "howler_app")
  on.exit(app$stop())

  app$wait_for_idle()
  expect_silent(app$click(input = "play", wait_ = FALSE))
})
