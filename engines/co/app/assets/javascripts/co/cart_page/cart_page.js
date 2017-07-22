"use strict";

var CartPage = function($cart_page) {
    var _$cart_page;
    var _fInitBehaviour = function (){
        var cart = coo.cart_get();
        for (var i = 0; i < cart.length; i++) {
            console.log(cart[i]);
        }
    }
    var _fInit = function($cart_page) {
        _$cart_page = $cart_page;
        _fInitBehaviour();
    };
    _fInit($cart_page);
}