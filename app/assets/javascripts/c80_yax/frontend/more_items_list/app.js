"use strict";

var _activate_more_items = function() {
    $('.more_items_list').each(function() {
        new MoreItemsList(this);
    });
};

$(document).ready(function() {
    // alert(MoreItemsList);
    _activate_more_items();
});