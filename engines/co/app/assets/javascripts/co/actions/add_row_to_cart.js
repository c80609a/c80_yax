"use strict";

// добавляет
var AddRowToCart = function(item_id) {
    this.call = function() {
        var row_as_hash = new CollectDataForRow(item_id).call();
        console.log("<AddRowToCart.call> row_as_hash: " + row_as_hash);
        console.log(row_as_hash);

        // var cart = cookies.get('cart');
        // cart.push(row_as_hash);
        // cookies.set('cart', cart);

        return {
            result: true,
            message: row_as_hash['q'] + ' товаров добавлено в корзину.'
        }
    }
};