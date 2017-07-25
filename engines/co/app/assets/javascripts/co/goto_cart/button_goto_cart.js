"use strict";

var ButtonGotoCart = function(selector) {

    var _$btn;
    var _$counter;

    //<editor-fold desc="// инициализация">
    var _fInitBehaviour = function (){
        if (_$btn.length <= 0) return;
    };
    var _fInit = function (selector){
        _$btn = $(selector);
        _$counter = $('<div class="counter"></div>');
        _$counter.appendTo(_$btn);
        _fInitBehaviour();
    };
    _fInit(selector);
    //</editor-fold>

    this.set_count = function(new_val) {
        // console.log('<ButtonGotoCart#set_count>');
        _$counter.text(new_val);
    }

};

ButtonGotoCart.instances = [];
ButtonGotoCart.refresh_count = function() {
    // console.log('<ButtonGotoCart.refresh_count>');
    var cart = coo.cart_get();
    var new_val = 0;
    for (var i = 0; i < cart.length; i++) {
        new_val += Number(cart[i]['q']);
    }
    for (var i = 0; i < ButtonGotoCart.instances.length; i++) {
        var ins = ButtonGotoCart.instances[i];
        ins.set_count(new_val);
    }
}