"use strict";

var ButtonAddToCart = function(selector) {

    var _$btn;

    var _onClickBtn = function(e) {
        console.log('<_onClickBtn>');
        e.preventDefault();
        var c = new AddRowToCart().call();
        if (c.result) {
            // com.showDouble(c.message);
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
        _fInitBehaviour();
    };

    _fInit(selector);

};