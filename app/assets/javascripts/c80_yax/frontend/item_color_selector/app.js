"use strict";

var ITEM_COLOR_SELECTOR = {};

var _activate_color_selectors = function() {
    $('.item_color_selector').each(function() {
        ITEM_COLOR_SELECTOR[$(this).data('id')] =
            new ItemColorSelector(this);
    });
};

$(document).ready(function() {
    // alert(ItemColorSelector);
    _activate_color_selectors();
});