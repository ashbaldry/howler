HTMLWidgets.widget({
  name: 'howler',
  type: 'output',

  factory: function(el, width, height) {
    var tracks, track_names;
    var sound;
    let track_played = 0;

    // Events on button clicks
    $(`.howler-play-button[data-howler=${el.id}]`).on("click", (el) => {
      sound.play();
    });

    $(`.howler-pause-button[data-howler=${el.id}]`).on("click", (el) => {
      sound.pause();
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
        tracks = x.tracks;
        track_names = x.names;

        // TODO: code to render the widget, e.g.
        el.innerHTML = `<div>THIS IS A TEST ${x.names[0]}</div>`;

        sound = new Howl({
          src: [x.tracks[0]]
        });
      },

      resize: function(width, height) {
      }
    };
  }
});
