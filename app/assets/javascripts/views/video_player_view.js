(function(App) {

  'use strict';

  App.View = App.View || {};

  App.View.VideoPlayer = Backbone.View.extend({

    el: 'body',

    events: {
      'click .js-video-player-play' : 'onClickOpenVideo',
      'click .js-video-player-veil' : 'onClickCloseVideo'
    },

    options: {
      isIframeLoaded: false,
      videoPlayerId: "videoPlayer",
      videoPlayerClass: ".c-video-player",
      videoPayerContainerClass: ".js-video-player-container"
    },

    initialize: function(settings) {
      this.trackOnOpen = _.isUndefined(settings.trackOnOpen) ? null : settings.trackOnOpen;
      this._cache();
    },

    _cache: function() {
      this.$videoPlayer = this.$el.find(this.options.videoPlayerClass);
      this.$videoPlayerContainer = this.$el.find(this.options.videoPayerContainerClass);
      this.$html = $('html');
      this.$body = $('body');
    },

    onClickOpenVideo: function() {
      this.$videoPlayer.show().animate({
        opacity: 1
      }, 300, function() {
        if(this.trackOnOpen !== null){
          this.trackOnOpen();
        }
        this._checkIframe();
      }.bind(this));
    },

    onClickCloseVideo: function() {
      this.$videoPlayer.animate({
        opacity: 0
      }, 300, function() {
        $(this).hide();
      });
      this._stopVideo();
    },

    _stopVideo: function() {
      var src = $("iframe#" + this.options.videoPlayerId).attr('src');
      $("iframe#" + this.options.videoPlayerId).attr('src','');
      $("iframe#" + this.options.videoPlayerId).attr('src', src);
    },

    _checkIframe: function() {
      if(!this.options.isIframeLoaded) {
        this.$videoPlayerContainer.html(this._getIframeHTML());
        this.options.isIframeLoaded = true;
      }
    },

    _getIframeHTML: function () {
      return '<iframe id="' + this.options.videoPlayerId + '" src="//player.vimeo.com/video/' + this.$videoPlayerContainer.data('video-id') + '?title=0&byline=0&portrait=0" width="100%" height="100%" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>'
    },

  });

})(this.App);
