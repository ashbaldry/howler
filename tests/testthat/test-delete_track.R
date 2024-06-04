test_that("Delete track works as expected", {
  skip_on_cran()
  skip_if(is.null(chromote::find_chrome()))

  audio_files_dir <- system.file("examples", "_audio", package = "howler")
  addResourcePath("sample_audio", audio_files_dir)
  audio_files <- file.path("sample_audio", list.files(audio_files_dir, ".mp3$"))

  ui <- shiny::fluidPage(
    howler(audio_files[1L:2L], auto_continue = TRUE, elementId = "sound"),
    shiny::actionButton("delete_track", "Delete Selected Track")
  )

  server <- function(input, output, session) {
    shiny::observeEvent(input$delete_track, {
      deleteTrack("sound", input$sound_track$name)
    })
  }

  app <- shinytest2::AppDriver$new(shinyApp(ui, server), name = "howler_app")
  on.exit(app$stop())

  app$wait_for_idle()
  current_track <- app$get_value(input = "sound_track")
  app$click("delete_track")
  app$wait_for_idle(duration = 1000L)
  new_track <- app$get_value(input = "sound_track")

  expect_false(identical(new_track$name, current_track$name))

  app$click("delete_track")
  app$wait_for_idle(duration = 1000L)
  expect_null(app$get_value(input = "sound_track")$name)
})

test_that("Delete track produces warning when track not present", {
  skip_on_cran()
  skip_if(is.null(chromote::find_chrome()))

  audio_files_dir <- system.file("examples", "_audio", package = "howler")
  addResourcePath("sample_audio", audio_files_dir)
  audio_files <- file.path("sample_audio", list.files(audio_files_dir, ".mp3$"))

  ui <- shiny::fluidPage(
    howler(audio_files[1L:2L], auto_continue = TRUE, elementId = "sound"),
    shiny::actionButton("delete_track", "Delete Selected Track")
  )

  server <- function(input, output, session) {
    shiny::observeEvent(input$delete_track, {
      deleteTrack("sound", "Missing song")
    })
  }

  app <- shinytest2::AppDriver$new(shinyApp(ui, server), name = "howler_app")
  on.exit(app$stop())

  app$wait_for_idle()
  current_track <- app$get_value(input = "sound_track")
  app$click("delete_track")
  expect_match(tail(app$get_logs(), 1L)$message, "Missing song not available")
})
