"use strict";

/*
 * <div class="container-fluid hits_widget more_items_list" data-type='hit|offer'>
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

    // клик по кнопке "больше товаров"
    var _fOnClickNext = function(e) {
        e.preventDefault();
        var t = _$wrapper.data('type');
        var p = $(e.target).attr('href').split('page=')[1];
        console.log('<_fOnClickNext> type: ' + t + '; page: ' + p);

        $.ajax({
            url: "/fetch_items",
            data: {
                type: t,
                page: p,
                ajax_items_div: "." + _$wrapper.attr('class').split(' ').join('.') + " .ajax_div"
            },
            dataType: "script",
            type: 'GET'
        });
    }

    // начинаем слушать клики по кнопке "больше товаров"
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