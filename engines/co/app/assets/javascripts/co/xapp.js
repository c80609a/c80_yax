"use strict";

var com = new CoModal();
var coo = new CookiesService();

var _activate_cart_button = function() {
    $('.add_to_bucket').each(function() {
        new ButtonAddToCart(this);
    });
};

$(document).ready(function() {
    // alert(ButtonAddToCart);
    _activate_cart_button();
});