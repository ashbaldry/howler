var ShinyHowler = function(el) {
  var self = this;
  this.id = el.id;
  this.index = 0;
  this.playlist = JSON.parse(el.dataset.audioFiles);
  this.play_pause_toggle = false;

  this.play = function() {
    return new Howl({
      src: this.playlist[self.index],
      html5: true,
      volume: 0.7
    });
  },

  this.player = this.play();

    $(`#${this.id}_play`).on("click", function(e) {
		  self.player.play();
		  Shiny.setInputValue(`${self.id}_playing`, true);
	  });

	  $(`#${this.id}_play_pause`).on("click", function(e) {
		  self.play_pause_toggle ? self.player.pause() : self.player.play();

		  self.play_pause_toggle = !self.play_pause_toggle;
		  Shiny.setInputValue(`${self.id}_playing`, self.play_pause_toggle);
	  });

	  $(`#${this.id}_pause`).on("click", function(e) {
		  self.player.pause();
		  Shiny.setInputValue(`${self.id}_playing`, false);
	  });

	  $(`#${this.id}_stop`).on("click", function(e) {
		  self.player.stop();
		  Shiny.setInputValue(`${self.id}_playing`, false);
	  });

		$(`#${this.id}_next`).on("click", function(e) {
		  if (self.index === (self.playlist.length - 1)) {
		     self.index = 0;
		  } else {
		    self.index++;
		  }

		  self.player.stop();
		  self.player = self.play();
		  self.player.play();

      self.play_pause_toggle = true;
		  Shiny.setInputValue(`${self.id}_playing`, true);
	  });

		$(`#${this.id}_previous`).on("click", function(e) {
		  if (self.index === 0) {
		     self.index = self.playlist.length - 1;
		  } else {
		    self.index--;
		  }

		  self.player.stop();
		  self.player = self.play();
		  self.player.play();

      self.play_pause_toggle = true;
		  Shiny.setInputValue(`${self.id}_playing`, true);
	  });

	$(`#${this.id}_volumeup`).on("click", function(e) {
		var vol = this.player.volume();
		vol += 0.1;
		if (vol > 1) {
			vol = 1;
		}
		this.player.volume(vol);
	});

	$(`#${this.id}_volumedown`).on("click", function(e) {
		var vol = this.player.volume();
		vol -= 0.1;
		if (vol < 0) {
			vol = 0;
		}
		this.player.volume(vol);
	});
}

$(document).on('shiny:connected', () => {
  var howlers = document.getElementsByClassName('howler-player');

  for (i = 0; i < howlers.length; i++) {
    new ShinyHowler(howlers[i]);
  }
});
