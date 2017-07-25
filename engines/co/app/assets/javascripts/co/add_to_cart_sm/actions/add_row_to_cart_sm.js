"use strict";

// добавляет
var AddRowToCartSm = function(item_id) {
    this.call = function() {
        var row_as_hash = new CollectDataForRowSm(item_id).call();
        // console.log("<AddRowToCartSm.call> row_as_hash: " + row_as_hash);
        // console.log(row_as_hash);

        coo.cart_push(row_as_hash);

        return {
            result: true,
            message: '1 товар добавлено в корзину.'
        }
    }
};