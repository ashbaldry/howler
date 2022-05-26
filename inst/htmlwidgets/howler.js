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
      const iconElement = $(el.currentTarget).find("i");

      if (sound.playing()) {
        sound.pause();
        $(iconElement).removeClass("fa-pause").addClass("fa-play");
      } else {
        sound.play();
        $(iconElement).removeClass("fa-play").addClass("fa-pause");
      }
    });

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
        if (track_formats) {
          options.format = track_formats[0];
        }

        sound = new Howl(options);
      },

      resize: function(width, height) {
      }
    };
  }
});
