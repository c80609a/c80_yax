"use strict";

// добавляет
var AddRowToCart = function(item_id) {
    this.call = function() {
        console.log("<AddRowToCart.call>")

        var row_as_hash = new CollectDataForRow(item_id).call();
        // var cart = cookies.get('cart');
        // cart.push(row_as_hash);
        // cookies.set('cart', cart);

        return {
            result: true,
            message: '12 товаров добавлены в корзину'
        }
    }
};