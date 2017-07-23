"use strict";

var $ss;

var _activate_goto_card = function() {
    $ss.each(function() {
        var ins = new ButtonGotoCart(this);
        ButtonGotoCart.instances.push(ins);
    });
    ButtonGotoCart.refresh_count();
};

$(document).ready(function() {
    $ss = $('.b_make_order a');
    if ($ss.length !== 0) {
        // alert(ButtonAddToCart);
        _activate_goto_card();
    }
});