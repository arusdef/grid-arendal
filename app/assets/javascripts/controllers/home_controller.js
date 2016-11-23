(function(App) {

  'use strict';

  App.Controller = App.Controller || {};

  App.Controller.Home = App.Controller.Page.extend({

    index: function() {
      this.initSliders();
      $('.l-main-content').addClass('home');
      $('.cta-mobile').addClass('home');
      $('.footer-slider').addClass('home');
      $('.js-btn-events-modal').on('click', function(e) {
        $('.c-events-modal').css('display', 'none');
      })
    },

    initSliders: function() {

      Array.prototype.slice.call(document.querySelectorAll('.js_slider')).forEach(function (element, index) {
        lory(element, {
          infinite: 3,
          slidesToScroll: 1,
          enableMouseEvents: true
        });
      });
    }

  });


})(this.App);
