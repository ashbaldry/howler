var Howler = function(el) {
  var self = this;
  this.id = el.id;
  this.index = 0;

  if (document.getElementById(`$(el.id}_volume_slider`)) {
    this.volume = document.getElementById(`$(el.id}_volume_slider`).dataset.volume;
  } else {
    this.volume = el.dataset.volume;
  }

  this.seekRate = el.dataset.seekRate;
  this.playlist = JSON.parse(el.dataset.audioFiles);
  this.autoContinue = el.dataset.autocontinue === "TRUE";
  this.autoLoop = el.dataset.autoloop === "TRUE";
  this.autoPlayNext = true;
  this.autoPlayPrevious = true;

  this.play = function() {
    return new Howl({
      src: self.playlist[self.index],
      volume: self.volume,

      onload: function() {
        Shiny.setInputValue(`${self.id}_track`, self.playlist[self.index]);
        Shiny.setInputValue(`${self.id}_duration`, self.player.duration());
        if (self.seekRate > 0) {
          Shiny.setInputValue(`${self.id}_seek`, self.player.seek());
        }
      },

      onplay: function() {
        Shiny.setInputValue(`${self.id}_playing`, true);
        self.setPlayPauseButton('pause');
      },

      onpause: function() {
        Shiny.setInputValue(`${self.id}_playing`, false);
        self.setPlayPauseButton('play');
      },

      onstop: function() {
        Shiny.setInputValue(`${self.id}_playing`, false);
        self.setPlayPauseButton('play');
      },

      onend: function() {
        if (self.autoContinue && !(!self.autoLoop && self.index === (self.playlist.length - 1))) {
          self.changeNextTrack();
        } else {
          Shiny.setInputValue(`${self.id}_playing`, false);
          self.setPlayPauseButton('play');
        }
      },

      onseek: function() {
        Shiny.setInputValue(`${self.id}_seek`, self.player.seek());
      }
    });
  };

  this.changeNextTrack = function(playTrack = true) {
    if (self.index === (self.playlist.length - 1)) {
      self.index = 0;
    } else {
      self.index++;
    }

    self.changeTrack(playTrack);
  };

  this.changePreviousTrack = function(playTrack = true) {
    if (self.index === 0) {
      self.index = self.playlist.length - 1;
    } else {
      self.index--;
    }

    self.changeTrack(playTrack);
  }

  this.changeTrack = function(playTrack = true) {
    self.player.stop();
    self.player = self.play();

    if (playTrack) {
      self.player.play();
      self.setPlayPauseButton('pause');
    }
  };

  this.setPlayPauseButton = function(icon = 'play') {
    var iconElement = document.getElementById(self.id + '_play_pause').firstElementChild;

    if (iconElement) {
      var addIcon = icon === 'play' ? 'fa-play' : 'fa-pause';
      var removeIcon = icon === 'play' ? 'fa-pause' : 'fa-play';
      $(iconElement).removeClass(removeIcon).addClass(addIcon);
    }
  };

  this.moveVolumeSlider = function() {
    var sliderElement = document.getElementById(self.id + '_volume_slider');

    if (sliderElement) {
      sliderElement.value = self.volume;
    }
  };

  this.player = this.play();

  this.player.once('play', function() {
    if (self.seekRate > 0) {
      setInterval(
        () => {
          var trackSeek = self.player.seek();
          Shiny.setInputValue(`${self.id}_seek`, Math.round(trackSeek * 100) / 100);
        },
        self.seekRate
      )
    }
  })

  $(`#${this.id}_play`).on("click", function(e) {
    self.player.play();
  });

  $(`#${this.id}_play_pause`).on("click", function(e) {
    if (self.player.playing()) {
      self.player.pause();
    } else {
      self.player.play();
    }

  });

  $(`#${this.id}_pause`).on("click", function(e) {
    self.player.pause();
  });

  $(`#${this.id}_stop`).on("click", function(e) {
    self.player.stop();
    Shiny.setInputValue(`${self.id}_playing`, false);
  });

  $(`#${this.id}_next`).on("click", function(e) {
    self.changeNextTrack(self.autoPlayNext);
  });

  $(`#${this.id}_previous`).on("click", function(e) {
    self.changePreviousTrack(self.autoPlayPrevious);
  });

  $(`#${this.id}_volumeup`).on("click", function(e) {
    var volumeChange = this.dataset.volumeChange ? Number(this.dataset.volumeChange) : 0.1;

    self.volume = Math.min(1, Number(self.player.volume()) + volumeChange);
    self.player.volume(self.volume);
    self.moveVolumeSlider();
  });

  $(`#${this.id}_volumedown`).on("click", function(e) {
    var volumeChange = this.dataset.volumeChange ? Number(this.dataset.volumeChange) : 0.1;

    self.volume = Math.max(0, Number(self.player.volume()) - volumeChange);
    self.player.volume(self.volume);
    self.moveVolumeSlider();
  });

  $(`#${this.id}_volume_slider`).on("change", function(e) {
    var vol = this.value;
    self.volume = vol;
    self.player.volume(vol);
  });
}

var howlerPlayers = [];

$(document).on('shiny:connected', () => {
  var howlers = document.getElementsByClassName('howler-player');

  for (i = 0; i < howlers.length; i++) {
    howlerPlayers.push(new Howler(howlers[i]));
  }
});

Shiny.addCustomMessageHandler('changeHowlerTrack', function(message) {
  var howl = howlerPlayers.filter(x => x.id === message.id)[0];
  var playlist = howl.playlist.map(x => {
    if (typeof(x) === '') {
      return x.split('/').pop();
    } else {
      return x.map(y => { return y.split('/').pop(); });
    }
  })

  var newIndex = playlist.findIndex(x => { return x.includes(message.file); });
  if (newIndex > -1) {
    howl.index = newIndex;
    howl.changeTrack()
  }
});

Shiny.addCustomMessageHandler('playHowler', function(message) {
  var howl = howlerPlayers.filter(x => x.id === message)[0];
  howl.player.play();
})

Shiny.addCustomMessageHandler('pauseHowler', function(message) {
  var howl = howlerPlayers.filter(x => x.id === message)[0];
  howl.player.pause();
})

Shiny.addCustomMessageHandler('stopHowler', function(message) {
  var howl = howlerPlayers.filter(x => x.id === message)[0];
  howl.player.stop();
})
