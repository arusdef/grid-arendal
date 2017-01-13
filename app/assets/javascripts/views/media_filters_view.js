(function(App) {

  'use strict';

  App.View = App.View || {};

  App.View.MediaFilters = Backbone.View.extend({

    el: '.c-filters',

    events: {
      'click .js-filters-maximizer' : '_onClickToggleFilters'
    },

    options: {
      opened: false,
      isFixed: false,
      showFiltersClass: "-show-filters",
      openFiltersAnimateSpeed: 0.5,
      filterTriggerClass: ".js-filter",
      fixedClass: "-fixed",
    },

    initialize: function(settings) {
      var opts = settings && settings.options ? settings.options : {};
      this.options = _.extend({}, this.options, opts);

      this._loadFilters();
      this._cache();
      this._setSelectFilters();
      this._loadStickyEvent();
    },

    _cache: function() {
      this.$container = this.$el.find('.container');
      if ( this.$container.length > 0 ) {
        this.offsetTop = this.$el.offset().top + 6;
      }
    },

    _loadFilters: function() {
      this.filters = [];
      _.each(this.$el.find(this.options.filterTriggerClass), function(item) {
        var filter = $(item);
        switch (filter.data("filter-type")) {
          case "select":
            this._loadSelect(this._getHelperFilterObject(filter));
            break;
          case "tags":
            this._loadTag(this._getHelperFilterObject(filter));
            break;
          case "years":
            this._loadYears(this._getHelperFilterObject(filter));
            break;
        }
      }.bind(this));
    },

    _loadSelect: function(helperFilter) {
      this.filters.push(new App.Helper.SelectHandler(helperFilter));
    },

    _loadTag: function(helperFilter) {
      this.filters.push(new App.Helper.TagSelectHandler(helperFilter));
    },

    _loadYears: function(helperFilter) {
      this.filters.push(new App.Helper.YearsFilter(helperFilter));
    },

    _getHelperFilterObject: function(filter) {
      return {
        el: filter,
        options: {
          callback: this._filterMedia.bind(this)
        }
      };
    },

    _filterMedia: function() {
      this._setHash();
    },

    _setHash: function () {
      var url = '?' + this.getFilterValues();
      Turbolinks.visit(url, {})
    },

    _onClickToggleFilters: function() {
      if (!this.opened) {
        if (typeof this.filtersHeight == "undefined") {
          this.filtersHeight = this._getFiltersHeight();
        }
        this.$container.css("height", this.filtersHeight);
      } else {
        this.$container.attr("style", "");
      }

      this.opened = !this.opened;
      this.$el.toggleClass(this.options.showFiltersClass);
    },

    _getFiltersHeight: function() {
      var elem = this.$container.clone().css("height", "auto").appendTo(this.$el);
      var height = elem.css("height");
      elem.remove();

      return height;
    },

    getFilterValues: function() {
      var queryStr = '';
      _.each(this.filters, function (filter) {
        if ( filter.selectedValues.length > 0 ) {
          if ( queryStr !== '' ) {
            queryStr += '&';
          }
          queryStr += filter.key + '=';
          _.each(filter.selectedValues.sort(), function (value, index) {
            queryStr += value;
            if ( index < filter.selectedValues.length - 1 ) {
              queryStr += ',';
            }
          });
        }
      });
      return queryStr;
    },

    _getFiltersFromUrl: function() {
      var vars = {}, hash;
      var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
      var route = 'http://' + window.location.host + window.location.pathname;
      if ( hashes[0] === route || hashes[0] === "") {
        return false
      }
      for ( var i = 0; i < hashes.length; i++ ) {
          hash = hashes[i].split('=');
          vars[hash[0]] = hash[1];
      }
      return vars;
    },

    _setSelectFilters: function() {
      var activeFilters = this._getFiltersFromUrl();
      if ( activeFilters === false ) {
        return false
      }
      _.each(activeFilters, function(value, filter) {
        var selectedValues = value.split(",")
        if(filter !== 'media') {
          selectedValues = selectedValues.map(Number);
        }
        var filter = _.findWhere(this.filters, {key: filter});
        if(typeof filter != "undefined") {
          filter.selectedValues = selectedValues;
        }
      }.bind(this));
    },

    _loadStickyEvent: function () {
      $(window).scroll(function () {
        var scrollTop = $(window).scrollTop();

        if(!this.options.isFixed && scrollTop >= this.offsetTop) {
          this.$el.addClass(this.options.fixedClass);
          this.options.isFixed = true;
        } else if(this.options.isFixed && scrollTop < this.offsetTop) {
          this.$el.removeClass(this.options.fixedClass);
          this.options.isFixed = false;
        }
      }.bind(this));
    }

  });

})(this.App);
