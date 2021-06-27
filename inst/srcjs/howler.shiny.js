var ShinyHowler = function(el) {
    var self = this;
    this.id = el.id;
    this.index = 0;
    this.playlist = JSON.parse(el.dataset.audioFiles);
    this.autoplay = el.dataset.autoplayNextTrack === "TRUE";
    this.autoloop = el.dataset.autoloop === "TRUE";

    this.play = function() {
        return new Howl({
            src: this.playlist[self.index],
            html5: true,
            volume: 0.7,

            onload: function() {
                Shiny.setInputValue(`${self.id}_track`, self.playlist[self.index]);
                Shiny.setInputValue(`${self.id}_duration`, self.player.duration());
            },

            onplay: function() {
                self.player.seek();
                Shiny.setInputValue(`${self.id}_playing`, true);
            },

            onpause: function() {
                Shiny.setInputValue(`${self.id}_playing`, false);
            },

            onend: function() {
                if (self.autoplay && !(!self.autoloop && self.index === (self.playlist.length - 1))) {
                    self.playNextTrack();
                } else {
                    Shiny.setInputValue(`${self.id}_playing`, false);
                    self.setPlayPauseButton('play');
                }
            }
        });
    };

    this.playNextTrack = function() {
        if (self.index === (self.playlist.length - 1)) {
            self.index = 0;
        } else {
            self.index++;
        }

        self.changeTrack();
        self.setPlayPauseButton('pause');
    };

    this.changeTrack = function() {
        self.player.stop();
        self.player = self.play();
        self.player.play();
    };

    this.setPlayPauseButton = function(icon = 'play') {
      var iconElement = document.getElementById(self.id + '_play_pause').firstElementChild;

      if (iconElement) {
          var addIcon = icon === 'play' ? 'fa-play' : 'fa-pause';
          var removeIcon = icon === 'play' ? 'fa-pause' : 'fa-play';
          $(iconElement).removeClass(removeIcon).addClass(addIcon);
      }
    };

    this.player = this.play();

    $(`#${this.id}_play`).on("click", function(e) {
        self.player.play();
    });

    $(`#${this.id}_play_pause`).on("click", function(e) {
        if (self.player.playing()) {
            self.player.pause();
        } else {
            self.player.play();
        }

        var icon = document.getElementById(this.id).firstElementChild;
        $(icon).toggleClass('fa-play').toggleClass('fa-pause');
    });

    $(`#${this.id}_pause`).on("click", function(e) {
        self.player.pause();
    });

    $(`#${this.id}_stop`).on("click", function(e) {
        self.player.stop();
        Shiny.setInputValue(`${self.id}_playing`, false);
    });

    $(`#${this.id}_next`).on("click", function(e) {
        self.playNextTrack();
    });

    $(`#${this.id}_previous`).on("click", function(e) {
        if (self.index === 0) {
            self.index = self.playlist.length - 1;
        } else {
            self.index--;
        }

        self.changeTrack(self.id + '_play_pause');
    });

    $(`#${this.id}_volumeup`).on("click", function(e) {
        var vol = Math.min(1, this.player.volume() + 0.1);
        this.player.volume(vol);
    });

    $(`#${this.id}_volumedown`).on("click", function(e) {
        var vol = Math.max(0, this.player.volume() - 0.1);
        this.player.volume(vol);
    });
}

var shinyHowlers = [];

$(document).on('shiny:connected', () => {
    var howlers = document.getElementsByClassName('howler-player');

    for (i = 0; i < howlers.length; i++) {
        shinyHowlers.push(new ShinyHowler(howlers[i]));
    }
});
