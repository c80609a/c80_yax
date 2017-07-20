"use strict";

var _activate_color_selectors = function() {
    $('.item_color_selector').each(function() {
        new ItemColorSelector(this);
    });
};

$(document).ready(function() {
    // alert(ItemColorSelector);
    _activate_color_selectors();
});