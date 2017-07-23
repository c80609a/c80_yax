"use strict";

var CartPage = function($cart_page) {
    var _$cart_page;
    var _cart_table;
    var _$clear_btn;
    var _$result_price_val;
    var _fill_table = function() {
        var cart = coo.cart_get();
        for (var i = 0; i < cart.length; i++) {
            _cart_table.add_row(cart[i]);
        }
    };
    var _calc_result_price = function() {
        var cart = coo.cart_get();
        var result = 0;
        for (var i = 0; i < cart.length; i++) {
            result += Number(cart[i]['price']);
        }
        _$result_price_val.text(result);
    };
    var _on_click_clear = function(e) {
        e.preventDefault();
        _cart_table.clear();
        coo.cart_clean();
        _calc_result_price();
    };
    var _on_row_changed = function(row_id, color, obj_with_new_values) {
        console.log('<_on_row_changed>');
        coo.cart_update_row(row_id, color, obj_with_new_values);
        _calc_result_price();
    }
    var _fInitBehaviour = function (){
        _fill_table();
        _calc_result_price();
        _$clear_btn.on('click', _on_click_clear);

    };
    var _fInit = function($cart_page) {
        _$cart_page = $cart_page;
        _cart_table = new CartTable(_$cart_page.find('table.cart_table'), _on_row_changed);
        _$clear_btn = $cart_page.find('.clear_btn');
        _$result_price_val = $cart_page.find('.bottom_row .result .val');
        _fInitBehaviour();
    };
    _fInit($cart_page);
};