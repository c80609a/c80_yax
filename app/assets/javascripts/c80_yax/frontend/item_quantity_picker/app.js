"use strict";

var _activate_q_picker = function() {
    $('.quantity_picker').each(function() {
        new ItemQuantityPicker(this);
    });
};

$(document).ready(function() {
    // alert(ItemQuantityPicker);
    _activate_q_picker();
});