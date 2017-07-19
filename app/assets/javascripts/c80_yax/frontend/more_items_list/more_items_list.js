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

    var loading = (function () {

        var _$lo;

        var _fInit = function () {
            _$lo = $('<div id="lo"></div>');
        };

        var fShow = function ($clickedButton) {
            // console.log('fShow');

            _$lo.appendTo($('body'));

            var top = $clickedButton.offset().top;
            var left = $clickedButton.offset().left;
            top = top + $clickedButton.height()/2 - _$lo.height()/2;

            _$lo.css("top",top+"px");
            _$lo.css("left",left+"px");
        };

        var fHide = function () {
            _$lo.addClass('invis');
            setTimeout(function () {
                _$lo.remove();
                _$lo.removeClass('invis');
            }, 1000);
        };

        _fInit();

        return {
            show:fShow,
            hide:fHide
        }

    })();

    // клик по кнопке "больше товаров"
    var _fOnClickNext = function(e) {
        e.preventDefault();
        var $t = $(e.target);
        var t = _$wrapper.data('type');
        var p = $t.attr('href').split('page=')[1];
        console.log('<_fOnClickNext> type: ' + t + '; page: ' + p);

        loading.show($t);

        $.ajax({
            url: "/fetch_items",
            data: {
                type: t,
                page: p,
                ajax_items_div: "." + _$wrapper.attr('class').split(' ').join('.') + " .ajax_div"
            },
            dataType: "script",
            type: 'GET'
        }).done(function() {
            loading.hide();
        });
    };

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