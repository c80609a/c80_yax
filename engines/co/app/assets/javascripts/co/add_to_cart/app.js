"use strict";

var $s;

var _activate_cart_button = function() {
    $s.each(function() {
        new ButtonAddToCart(this);
    });
};

$(document).ready(function() {
    $s = $('.add_to_bucket');
    if ($s.length !== 0) {
        // alert(ButtonAddToCart);
        _activate_cart_button();
    }
});