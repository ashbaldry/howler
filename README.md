## {howler} - Interactive Audio Player

Using [howler.js](https://github.com/goldfire/howler.js) to create an audio tool that can be implemented into shiny applications.

## Installation

```r
devtools::install_github("ashbaldry/howler")
```

## Usage

## Examples

### Basic Example

This player has a single song loaded, and just has the ability to play/pause the track.

```r
library(shiny)
library(howler)

howler_example_dir <- system.file("examples/www/audio", package = "howler")
addResourcePath("audio_files", howler_example_dir)

howler_example_file <- list.files(howler_example_dir, ".mp3$")[1]

ui <- fluidPage(
  h3("Basic howler.js Player"),
  useHowlerJS(),
  howlerPlayer("sound", file.path("audio_files", howler_example_file)),
  playPauseButton("sound")
)

server <- function(input, output, session) { }

shinyApp(ui, server)
```

### All The Features

```r
library(shiny)
library(howler)

howler_example_dir <- system.file("examples/www/audio", package = "howler")
addResourcePath("audio_files", howler_example_dir)

howler_example_file <- list.files(howler_example_dir, ".mp3$")

ui <- fluidPage(
  h3("Basic howler.js Player"),
  useHowlerJS(),
  howlerPlayer("sound", file.path("audio_files", howler_example_file)),
  previousButton("sound"),
  playPauseButton("sound"),
  nextButton("sound"),
  volumeSlider("sound")
)

server <- function(input, output, session) { }

shinyApp(ui, server)
```
