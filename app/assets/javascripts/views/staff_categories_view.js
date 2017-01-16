(function(App) {

  'use strict';

  App.View = App.View || {};

  App.View.StaffCategories = Backbone.View.extend({

    el: 'body',

    events: {
      'click .js-staff-selector-item' : '_onClickShowCategory'
    },

    options: {
      selectedClass: "-selected",
      selectorItemClass: ".c-staff-selector-item",
      staffContainerClass: ".c-staff-container",
    },

    selectedIndex: null,

    _onClickShowCategory: function(e) {
      var selectedIndex = $(e.currentTarget).data('category-index');

      this._removeSelected();
      if(selectedIndex !== this.options.selectedIndex) {
        this._addSelected(selectedIndex);
      } else {
        this._addSelected(0);
      }
    },

    _removeSelected: function () {
      $(this.options.selectorItemClass).removeClass(this.options.selectedClass);
      $(this.options.staffContainerClass).removeClass(this.options.selectedClass);
    },

    _addSelected: function (index) {
      var categoryIndexCondition = '[data-category-index="' + index + '"]';
      $(this.options.selectorItemClass + categoryIndexCondition).addClass(this.options.selectedClass);
      $(this.options.staffContainerClass + categoryIndexCondition).addClass(this.options.selectedClass);

      this.options.selectedIndex = index;
    },

  });

})(this.App);
