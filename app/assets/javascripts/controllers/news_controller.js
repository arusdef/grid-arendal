(function(App) {

  'use strict';

  App.Controller = App.Controller || {};

  App.Controller.News = App.Controller.Page.extend({

    index: function(params) {
      var masonryView = new App.View.Masonry({
        el: '#masonry-layout'
      });
    },

    show: function(params) { },

  });

})(this.App);
