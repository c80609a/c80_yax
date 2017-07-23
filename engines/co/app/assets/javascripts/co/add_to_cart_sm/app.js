"use strict";

var $ss;

var _activate_cart_button_sm = function() {
    $ss.each(function() {
        new ButtonAddToCartSm(this);
    });
};

$(document).ready(function() {
    $ss = $('.add_to_bucket_sm');
    if ($ss.length !== 0) {
        // alert(ButtonAddToCart);
        _activate_cart_button_sm();
    }
});