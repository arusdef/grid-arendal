(function(App) {

  'use strict';

  App.Controller = App.Controller || {};

  App.Controller.Activities = App.Controller.Page.extend({

    options: {
      sliderContentCardType: "card",
      sliderMediaItemType: "related-media"
    },

    index: function() {
      if($('.masonry-layout').find('.masonry-column').length === 0) {
        new App.View.Masonry({
          el: '.masonry-layout'
        });
      }
      new App.View.Filters({
        options: {trackLabel: 'Activity filters'}
      });
    },

    show: function() {
      new App.View.Anchors({
        options: {trackLabel: 'Activity Page'}
      });
      this.initSliders();
      new App.View.RelatedMedia({
        slider: this.slider
      });
      this.videoThumbnailsView = new App.View.VideoThumbnails();
      if(!this.isScreen_s) {
        _.each($('.masonry-layout'), function(element) {
          if($(element).find('.masonry-column').length === 0) {
            new App.View.Masonry({
              el: element
            });
          }
        });
      }
    },

    _paginate: function() {
      var params = _.extend({}, App.Helper.Utils.getGetParams(), { page: this.scrollPaginationView.page });
      $.ajax({
        method: "GET",
        cache: true,
        url: '/activities/paginate',
        data: params,
        beforeSend: function() {
          this.scrollPaginationView.showLoader();
        }.bind(this),
        complete: function(response) {
          this.scrollPaginationView.toggleDoingCallback();
          this.scrollPaginationView.hideLoader();

          if(response.status === 204) {
            this.scrollPaginationView.toggleBlockPagination();
          } else {
            this.scrollPaginationView._setHash();
          }

        }.bind(this)
      });
    },

    initSliders: function() {
      _.each($('.js_slider'), function(element) {
        if($(element).find(".js_slide").length > 0) {
          var sliderType = $(element).data("slider-type");
          var needLoadSlider = true;

          if(sliderType == this.options.sliderContentCardType && !this.isScreen_s) {
            needLoadSlider = false;
          }

          if(needLoadSlider) {
            var slider = lory(element, {
              enableMouseEvents: true,
              infinite: true
            });
            this.slider = slider;
          }
        }

      }.bind(this));
    }

  });

})(this.App);
