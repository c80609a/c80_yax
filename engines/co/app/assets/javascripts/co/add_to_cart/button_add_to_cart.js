"use strict";

var ButtonAddToCart = function(selector) {

    var _$btn;
    var _item_id;

    var _onClickBtn = function(e) {
        // console.log('<_onClickBtn>');
        e.preventDefault();
        var c = new AddRowToCart(_item_id).call();
        if (c.result) {
            // com.showDouble(c.message);
            ButtonGotoCart.refresh_count();
            com.showDouble('Продолжить покупки?');
        }
    };

    var _fInitBehaviour = function (){
        if (_$btn.length <= 0) return;
        _$btn.on('click', _onClickBtn);
    };

    /**
     * selector = "add_to_bucket_#{item.id}"
     * @param selector
     */
    var _fInit = function (selector){
        _$btn = $(selector);
        _item_id = _$btn.data('id');
        _fInitBehaviour();
    };

    _fInit(selector);

};