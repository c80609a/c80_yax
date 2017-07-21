"use strict";

var ITEM_QUANTITY_PICKERS = {};

var _activate_q_picker = function() {
    $('.quantity_picker').each(function() {
        ITEM_QUANTITY_PICKERS[$(this).data('id')] =
            new ItemQuantityPicker(this);
    });
};

$(document).ready(function() {
    // alert(ItemQuantityPicker);
    _activate_q_picker();
});