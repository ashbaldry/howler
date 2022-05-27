HTMLWidgets.widget({
  name: 'howler',
  type: 'output',

  factory: function(el, width, height) {
    var tracks, track_names, track_formats, options, sound;
    let current_track = 0;
    let auto_continue = false;
    let not_changing_seek = true;
    const seek_slider = $(`.howler-seek-slider[data-howler=${el.id}]`);

    function selectPreviousTrack() {
      if (current_track === 0) {
        current_track = tracks.length - 1;
      } else {
        current_track = current_track - 1;
      }
    }

    function selectNextTrack() {
      if (current_track === tracks.length - 1) {
        current_track = 0;
      } else {
        current_track = current_track + 1;
      }
    }

    function startNewTrack(play_track = true) {
      options.src = tracks[current_track];
      if (track_formats) {
        options.format = track_formats[current_track];
      }

      sound = new Howl(options);

      if (play_track) {
        sound.play();
      }

      return;
    }

    function updateVolume(volume, update_slider = true) {
      options.volume = volume;
      sound.volume(volume);
      if (update_slider) {
        $(`.howler-volume-slider[data-howler=${el.id}]`).val(volume);
      }
    }

    $(document).on('shiny:disconnected', () => {
      sound.stop();
    });

    // Events on button clicks
    $(`.howler-play-button[data-howler=${el.id}]`).on("click", (e) => {
      sound.play();
    });

    $(`.howler-pause-button[data-howler=${el.id}]`).on("click", (e) => {
      sound.pause();
    });

    $(`.howler-stop-button[data-howler=${el.id}]`).on("click", (e) => {
      sound.stop();
    });

    $(`.howler-play_pause-button[data-howler=${el.id}]`).on("click", (e) => {
      sound.playing() ? sound.pause() : sound.play();
    });

    $(`.howler-previous-button[data-howler=${el.id}]`).on("click", (e) => {
      sound.stop();
      selectPreviousTrack();
      startNewTrack();
    });

    $(`.howler-next-button[data-howler=${el.id}]`).on("click", (e) => {
      sound.stop();
      selectNextTrack();
      startNewTrack();
    });

    $(`.howler-back-button[data-howler=${el.id}]`).on("click", (e) => {
      sound.seek(Math.max(0, sound.seek() - 10));
    });

    $(`.howler-forward-button[data-howler=${el.id}]`).on("click", (e) => {
      sound.seek(Math.min(sound.duration(), sound.seek() + 10));
    });

    $(`.howler-volumetoggle-button[data-howler=${el.id}]`).on("click", function(e) {
      var muted = sound.mute();
      sound.mute(!muted);

      if (muted) {
        $(`.howler-volumetoggle-button[data-howler=${el.id}] i`).removeClass("fa-volume-mute").addClass("fa-volume-up");
        $(`.howler-volume-slider[data-howler=${el.id}]`).val(sound.volume());
      } else {
        $(`.howler-volumetoggle-button[data-howler=${el.id}] i`).removeClass("fa-volume-up").addClass("fa-volume-mute");
        $(`.howler-volume-slider[data-howler=${el.id}]`).val(0);
      }
    });

    $(`.howler-volumedown-button[data-howler=${el.id}]`).on("mouseup", (e) => {
      updateVolume(Math.min(1, sound.volume() + 0.1));
    });

    $(`.howler-volumeup-button[data-howler=${el.id}]`).on("mouseup", (e) => {
      updateVolume(Math.max(0, sound.volume() - 0.1));
    });

    $(`.howler-volume-slider[data-howler=${el.id}]`).on("mouseup", (e) => {
      sound.mute(false);
      $(`.howler-volumetoggle-button[data-howler=${el.id}] i`).removeClass("fa-volume-mute").addClass("fa-volume-up");
      updateVolume(Number(e.target.value), false);
    });

    if (seek_slider.length) {
      seek_slider.on("mousedown", (el) => {
        not_changing_seek = false;
      });

      seek_slider.on("mouseup", (el) => {
        not_changing_seek = true;
        sound.seek(Number(el.target.value));
      });

      setInterval(() => {
        if (not_changing_seek) {
          seek_slider.val(sound.seek());
        }
      }, 10);
    }

    // Custom Message Handlers
    Shiny.addCustomMessageHandler(`playHowler_${el.id}`, function(id) {
      sound.play();
    });

    Shiny.addCustomMessageHandler(`pauseHowler_${el.id}`, function(id) {
      sound.pause();
    });

    Shiny.addCustomMessageHandler(`stopHowler_${el.id}`, function(id) {
      sound.stop();
    });

    Shiny.addCustomMessageHandler(`seekHowler_${el.id}`, function(time) {
      sound.seek(time);
    });

    Shiny.addCustomMessageHandler(`changeHowlerTrack_${el.id}`, function(track) {
      sound.stop();
      if (isNaN(track)) {
        current_track = track_names.indexOf(track);
      } else {
        current_track = Number(track) - 1;
      }
      startNewTrack();
    });

    Shiny.addCustomMessageHandler(`addHowlerTrack_${el.id}`, function(track_info) {
      tracks.push(track_info.track);
      track_names.push(track_info.track_name);

      if (track_info.play) {
        sound.stop();
        current_track = tracks.length - 1;
        startNewTrack();
      }
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
            if (seek_slider.length) {
              seek_slider.attr("max", sound.duration());
              seek_slider.attr("value", 0);
            }

            Shiny.setInputValue(`${el.id}_track`, {name: track_names[current_track], id: current_track + 1});
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
              selectNextTrack();
              startNewTrack(auto_continue);
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
            Shiny.setInputValue(`${el.id}_seek`, Math.round(sound.seek() * 1000) / 1000);
          }, x.seek_ping_rate);
        }
      },

      resize: function(width, height) {}
    };
  }
});
