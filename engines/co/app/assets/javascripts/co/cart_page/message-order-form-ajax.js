
// =[ interface ]=====================================================================================================================

var $cart_form_container;
var markInvalidateInProgress = false;
var markWasPasted = false;
var fCartFormInvalidate;
var fCartFormOnScroll;

// =[ implementation ]=====================================================================================================================

$(function () {

    $cart_form_container = $("div#cart_form_container");

    if ($cart_form_container.length === 1) {

        fCartFormInvalidate = function () {
            if (!markInvalidateInProgress) {
                markInvalidateInProgress = true;

                if (!markWasPasted) {

                    $('<div id="loading"></div>').appendTo($cart_form_container);

                    $.ajax({
                        url: '/give_me_cart_order_form',
                        type: 'GET',
                        dataType: 'script'
                    }).done(function (data, result) {
                        if (result === "success") {
                            markWasPasted = true;
                        }
                    });
                }
            }
        };

        fCartFormOnScroll = function(event) {
            var closeToBottom = jQuery(window).scrollTop() >= 0;
            if (closeToBottom) {
                fCartFormInvalidate();
            }
        };

        // start
        $(document).bind('scroll', fCartFormOnScroll);
        setTimeout(function () {
            fCartFormOnScroll();
        },300);

    }
});