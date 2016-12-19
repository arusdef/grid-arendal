(function(App) {

  'use strict';

  App.Controller = App.Controller || {};

  App.Controller.Activities = App.Controller.Page.extend({

    index: function(params) {
      new App.View.Masonry({
        el: '#masonry-layout'
      });
      this.filtersView = new App.View.MediaFilters({
        callback: this._filter.bind(this)
      });
    },

    show: function(params) {
      new App.View.ActivitiesAnchors({});
      if(this.isMobile) {
        this.initSliders();
      } else {
        new App.View.Masonry({
          el: '#masonry-layouts'
        });
      }
    },

    _filter: function() {
      jQuery.ajaxSetup({cache: true});
      $.getScript($(location).attr('href'));
      return false;
    },

    initSliders: function() {
      Array.prototype.slice.call(document.querySelectorAll('.js_slider')).forEach(function (element, index) {
        var loryOptions = {
          enableMouseEvents: true
        };
        if(false) {
          loryOptions['infinite'] = 1;
        } else {
          loryOptions['rewind'] = true;
        }

        lory(element, loryOptions);
      });
    }

  });

})(this.App);
