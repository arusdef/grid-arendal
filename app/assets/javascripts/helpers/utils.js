(function(App) {

  'use strict';

  App.Helper = App.Helper || {};

  /**
   * Helper function to correctly set up the prototype chain for subclasses.
   * Similar to `goog.inherits`, but uses a hash of prototype properties and
   * class properties to be extended.
   * @param {Object} attributes
  */

  $.fn.serializeObject = function(){
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
      if (o[this.name] !== undefined) {
        if (!o[this.name].push) {
          o[this.name] = [o[this.name]];
        }
        o[this.name].push(this.value || '');
      } else {
        o[this.name] = this.value || '';
      }
    });
    return o;
  };

  App.Helper.Utils = {
    getGetParams: function () {
      var params = {};
      location.search
        .substr(1)
        .split("&")
        .forEach(function (item) {
          var param = item.split("=");
          if(param[0] !== "" && param[1] !== ""){
            params[param[0]] = param[1];
          }
        });
      return params;
    }
  }

})(this.App);
