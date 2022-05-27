HTMLWidgets.widget({
  name: 'howler',
  type: 'output',

  factory: function(el, width, height) {
    var tracks, track_names, track_formats, options, sound;
    let current_track = 0;
    let auto_continue = false;

    function chooseNextTrack (play_track = true, previous_track = false) {
      if (previous_track) {
        if (current_track === 0) {
          current_track = tracks.length - 1;
        } else {
          current_track = current_track - 1;
        }
      } else {
        if (current_track === tracks.length - 1) {
          current_track = 0;
        } else {
          current_track = current_track + 1;
        }
      }

      options.src = tracks[current_track];
      if (track_formats) {
        options.format = track_formats[current_track];
      }

      sound = new Howl(options);


      if (play_track) {
        sound.play();
        Shiny.setInputValue(`${el.id}_playing`, true);
      } else {
        Shiny.setInputValue(`${el.id}_playing`, false);
      }

      return;
    }

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

    $(`.howler-previous-button[data-howler=${el.id}]`).on("click", (el) => {
      sound.stop();
      chooseNextTrack(play_track = true, previous_track = true);
    });

    $(`.howler-next-button[data-howler=${el.id}]`).on("click", (el) => {
      sound.stop();
      chooseNextTrack(play_track = true);
    });

    Shiny.addCustomMessageHandler(`pauseHowler_${el.id}`, function(id) {
      sound.pause();
    });

    $(`.howler-volume-slider[data-howler=${el.id}]`).on("mouseup", (el) => {
      var volume = Number(el.target.value);
      options.volume = volume;
      sound.volume(volume);
    });

    return {
      renderValue: function(x) {
        auto_continue = x.auto_continue;
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

        options = x.options;
        options.src = tracks[0];

        if (!options.onload) {
          options.onload = function() {
            Shiny.setInputValue(`${el.id}_current_track`, tracks[0]);
            Shiny.setInputValue(`${el.id}_seek`, this.seek());
            Shiny.setInputValue(`${el.id}_duration`, this.duration());
            Shiny.setInputValue(`${el.id}_playing`, false);
          };
        }

        if (!options.onpause) {
          options.onpause = function() {
            $(`.howler-play_pause-button[data-howler=${el.id}] i`).removeClass("fa-pause").addClass("fa-play");
            Shiny.setInputValue(`${el.id}_playing`, false);
          };
        }

        if (!options.onstop) {
          options.onstop = function() {
            $(`.howler-play_pause-button[data-howler=${el.id}] i`).removeClass("fa-pause").addClass("fa-play");
            Shiny.setInputValue(`${el.id}_playing`, false);
          };
        }

        if (!options.onplay) {
          options.onplay = function() {
            $(`.howler-play_pause-button[data-howler=${el.id}] i`).removeClass("fa-play").addClass("fa-pause");
            Shiny.setInputValue(`${el.id}_playing`, true);
          };
        }

        if (!options.onend) {
          options.onend = function() {
            if (tracks.length > 1) {
              chooseNextTrack(auto_continue);
            }
          };
        }

        if (!options.onseek) {
          options.onseek = function() {
            Shiny.setInputValue(`${el.id}_seek`, sound.seek());
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

        // Shiny inputs
        if (x.seek_ping_rate > 0) {
          setInterval(() => {
            Shiny.setInputValue(`${el.id}_seek`, Math.round(sound.seek() * 100) / 100);
          }, x.seek_ping_rate);
        }
      },

      resize: function(width, height) {}
    };
  }
});
