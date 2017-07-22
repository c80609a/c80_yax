var $cart_page;

$(document).ready(function() {
    $cart_page = $('div#cart_page');
    if ($cart_page.length !== 0) {
        new CartPage($cart_page);
    }
});