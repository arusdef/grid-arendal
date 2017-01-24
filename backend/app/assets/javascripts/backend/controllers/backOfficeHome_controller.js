(function(App) {

  'use strict';

  App.Controller = App.Controller || {};

  App.Controller.BackOfficeHome = App.Controller.Page.extend({

    index: function() {
      new App.View.Phrases({});
      new App.View.IndexItems({});
      new App.View.Form({});
      this.indexPaginationView = new App.View.IndexPagination({
        callback: this._indexPaginate.bind(this)
      });
    },

    show: function(params) {
      console.log(params);
      new App.View.Form({});
      new App.View.IndexItems({});
      this.indexPaginationView = new App.View.IndexPagination({
        callback: this._indexPaginate.bind(this, params)
      });
    },

    _indexPaginate: function(params) {
      params = _.extend({}, params, { page: this.indexPaginationView.page });
      var path = window.location.pathname.split("/");

      $.ajax({
        method: "GET",
        cache: true,
        url: '/' + path[1] + '/' + path[2] + '/paginate',
        data: params,
        beforeSend: function() {
          this.indexPaginationView.showLoader();
        }.bind(this),
        complete: function(response) {
          this.indexPaginationView.toggleDoingCallback();
          this.indexPaginationView.hideLoader();

          if(response.status === 204) {
            this.indexPaginationView.toggleBlockPagination();
          }
        }.bind(this)
      });
    },

  });

})(this.App);
