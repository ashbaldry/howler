HTMLWidgets.widget({
  name: 'howler',
  type: 'output',

  factory: function(el, width, height) {
    var tracks, track_names, track_formats;
    var sound;
    let track_played = 0;

    // Events on button clicks
    $(`.howler-play-button[data-howler=${el.id}]`).on("click", (el) => {
      sound.play();
    });

    $(`.howler-pause-button[data-howler=${el.id}]`).on("click", (el) => {
      sound.pause();
    });

    $(`.howler-stop-button[data-howler=${el.id}]`).on("click", (el) => {
      sound.stop();
    });

    $(`.howler-play_pause-button[data-howler=${el.id}]`).on("click", (el) => {
      sound.playing() ? sound.pause() : sound.play();
    });

    Shiny.addCustomMessageHandler(`pauseHowler_${el.id}`, function(id) {
      sound.pause();
    });

    $(`.howler-volume-slider[data-howler=${el.id}]`).on("mouseup", (el) => {
      sound.volume(Number(el.target.value));
    });

    // Shiny inputs
    setInterval(() => {
      var trackSeek = sound.seek();
      Shiny.setInputValue(`${el.id}_seek`, Math.round(trackSeek * 100) / 100);
    }, 1000);

    return {
      renderValue: function(x) {
        if (Array.isArray(x.tracks)) {
          tracks = x.tracks;
          track_names = x.names;
          if (x.formats) {
            track_formats = x.formats;
          }
        } else {
          tracks = [x.tracks];
          track_names = [x.names];
          if (x.formats) {
            track_formats = [x.formats];
          }
        }

        // TODO: code to render the widget, e.g.
        el.innerHTML = `<div>THIS IS A TEST ${track_names[0]}</div>`;

        var options = x.options;
        options.src = tracks[0];

        if (!options.onload) {
          options.onload = function() {
            Shiny.setInputValue(`${el.id}_current_track`, tracks[0]);
            Shiny.setInputValue(`${el.id}_seek`, this.seek());
            Shiny.setInputValue(`${el.id}_duration`, this.duration());
          };
        }

        if (!options.onpause) {
          options.onpause = function() {
            $(`.howler-play_pause-button[data-howler=${el.id}] i`).removeClass("fa-pause").addClass("fa-play");
          };
        }

        if (!options.onstop) {
          options.onstop = function() {
            $(`.howler-play_pause-button[data-howler=${el.id}] i`).removeClass("fa-pause").addClass("fa-play");
          };
        }

        if (!options.onplay) {
          options.onplay = function() {
            $(`.howler-play_pause-button[data-howler=${el.id}] i`).removeClass("fa-play").addClass("fa-pause");
          };
        }

        if (!options.onend) {
          options.onend = function() {
          };
        }

        if (!options.onseek) {
          options.onseek = function() {
            Shiny.setInputValue(`${el.id}_seek`, this.seek());
          };
        }

        if (track_formats) {
          options.format = track_formats[0];
        }

        if (options.volume) {
          $(`.howler-volume-slider[data-howler=${el.id}]`).val(options.volume);
        } else {
          var slider_volume = $(`.howler-volume-slider[data-howler=${el.id}]`).val();
          if (slider_volume) {
            options.volume = Number(slider_volume);
          }
        }

        sound = new Howl(options);
      },

      resize: function(width, height) {
      }
    };
  }
});
