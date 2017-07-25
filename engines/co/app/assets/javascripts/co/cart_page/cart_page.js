"use strict";

var CartPage = function($cart_page) {
    var _$cart_page;
    var _cart_table;
    var _$clear_btn;
    var _$result_price_val;
    var _$delivery_checkbox;
    var _support;

    var _fill_table = function() {
        var cart = coo.cart_get();
        for (var i = 0; i < cart.length; i++) {
            _cart_table.add_row(cart[i]);
        }
    };
    var _print_table = function() {
        var res = '';
        var cart = coo.cart_get();
        for (var i = 0; i < cart.length; i++) {
            res += _support.print_row(cart[i]);
        }
        res += _support.print_bottom_row({
            order_price: _$result_price_val.text(),
            deliver: _$delivery_checkbox[0].checked ? 'да':'нет'
        });
        res = "<table border='1' cellpadding='0' cellspacing='0'>" + res + "</table>";
        return res;
    };
    var _print_table_to_comment = function() {
        var ss = _print_table();
        // console.log(ss);
        $cc.find('#mess_comment').val(ss);
    }
    var _calc_result_price = function() {
        var cart = coo.cart_get();
        var result = 0;
        for (var i = 0; i < cart.length; i++) {
            result += Number(cart[i]['price']);
        }
        _$result_price_val.text(result);
    };
    var _on_click_clear = function(e) {
        if (e != undefined) e.preventDefault();
        _cart_table.clear();
        coo.cart_clean();
        _calc_result_price();
        _print_table_to_comment();
        ButtonGotoCart.refresh_count();
    };
    var _reset = function() {
        _on_click_clear();
    };
    var _on_row_changed = function(row_id, color, obj_with_new_values) {
        // console.log('<_on_row_changed>');
        coo.cart_update_row(row_id, color, obj_with_new_values);
        _calc_result_price();
        _print_table_to_comment();
        ButtonGotoCart.refresh_count();
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
        _$delivery_checkbox = $cart_page.find('.bottom_row div.checkbox input');
        _support = new RowPrinter();
        _fInitBehaviour();
    };
    _fInit($cart_page);
    return {
        print_table_to_comment: _print_table_to_comment,
        reset: _reset
    }
};