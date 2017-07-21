"use strict";

var ITEM_OPTIONS = {};

var _activate_item_options = function() {
    $('.buy_options').each(function() {
        ITEM_OPTIONS[$(this).data('id')] =
            new ItemOptions(this);
    });
};

$(document).ready(function() {
    // alert(ItemQuantityPicker);
    _activate_item_options();
});