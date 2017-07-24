var $cart_page;
var aCartPage;

$(document).ready(function() {
    $cart_page = $('div#cart_page');
    if ($cart_page.length !== 0) {
        aCartPage = new CartPage($cart_page);
    }
});