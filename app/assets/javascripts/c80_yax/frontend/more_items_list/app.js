$(document).ready(function() {
    // alert(MoreItemsList);
    $('.more_items_list').each(function() {
        new MoreItemsList(this);
    });
});