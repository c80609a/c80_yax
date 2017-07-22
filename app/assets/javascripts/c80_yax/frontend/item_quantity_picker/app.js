"use strict";

var ITEM_QUANTITY_PICKERS = {};

var _activate_q_picker = function(onChange) {
    $('.quantity_picker').each(function() {
        var id = $(this).data('id');
        var ip = new ItemQuantityPicker(this);
        ITEM_QUANTITY_PICKERS[ id ] = ip;

        if (onChange !== undefined) {
            ip.on_change(onChange);
        }
    });
};

$(document).ready(function() {
    // alert(ItemQuantityPicker);
    _activate_q_picker();
});