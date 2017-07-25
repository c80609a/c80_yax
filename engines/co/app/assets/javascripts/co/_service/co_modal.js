"use strict";

// показывает окна

var CoModal = function() {

    var _modals = {};

    var _init_modal = function(modal_name) {
        var $modal;

        // if (_modals[modal_name] === undefined) {
            $modal = $('#' + modal_name + '_modal');
            $modal.modal();
            // _modals[modal_name] = $modal;
            // $modal.on('hidden.bs.modal', function () {
            //     $modal.remove();
            // });
        // }

        // $modal = _modals[modal_name];

        return $modal;
    };

    // _double_modal.html.erb
    this.showDouble = function(message) {
        // console.log('<showDouble> message: ' + message);
        var $modal = _init_modal('double');
        $modal.find('.modal-body').text(message);
        $modal.find('.btn_close').on('click', function(e) {
            $modal.modal('hide');
        });
        $modal.find('.btn_go_to_cart').on('click', function(e) {
            window.location.href = '/cart';
        });
        $modal.show();
    }
};