"use strict";

/*
 * <div class="container-fluid hits_widget more_items_list">
 *      <div class="container">
 *           <h2 class="yield_h2">Хиты продаж</h2>
 *           <div class="ajax_div">
 *              <%= orima_render_items_hits %>
 *              <div class="will_paginate">
                  ...
                  <span class="next_page disabled">&gt;</span>
                  <a class="next_page" href="/?page=2">&gt;</span>
                </div>
 *          </div>
 *      </div>
 * </div>
 * */

var MoreItemsList = function (wrapper) {

    var _$wrapper;
    var _$next_btn;

    var _fOnClickNext = function(e) {
        e.preventDefault();
        console.log('<_fOnClickNext>');
    }

    var _fSetNextPageBehaviour = function() {

        // находим в нем next кнопку will paginate
        _$next_btn = _$wrapper.find('a.next_page');
        console.log('<_fSetNextPageBehaviour> ');

        if (_$next_btn.data('processed')) {

        } else {
            _$next_btn.data('processed', 1);
            _$next_btn.on('click', _fOnClickNext);
        }
    }

    var _fInit = function(wrapper) {
        _$wrapper = $(wrapper);

        _fSetNextPageBehaviour();

    };

    _fInit(wrapper);
}