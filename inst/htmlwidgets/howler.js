HTMLWidgets.widget({
  name: 'howler',
  type: 'output',

  factory: function(el, width, height) {

    return {
      renderValue: function(x) {
        // TODO: code to render the widget, e.g.
        el.innerHTML = `<div>THIS IS A TEST ${x.player.tracks[0]}</div>`;

        var sound = new Howl({
          src: [x.player.tracks[2]]
        });
      },

      resize: function(width, height) {
      }
    };
  }
});

// Events on button clicks
if (HTMLWidgets.shinyMode) {
  $(".howler-play-button").on("click", (el) => {
    const player = $(el.currentTarget).data("howler");
    console.log(player);
  });
}
