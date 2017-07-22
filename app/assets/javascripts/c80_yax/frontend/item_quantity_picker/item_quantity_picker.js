"use strict";

var ItemQuantityPicker = function (wrapper){

    var _$wrapper;
    var _$less, _$great, _$input;
    var _cur_val;
    var __callbacks;

    var _on_change = function(fun) {
        if (__callbacks === null) return;
        __callbacks.push(fun);
    };

    var _call_on_change = function() {
        if (__callbacks === null) return;

        for (var i = 0; i < __callbacks.length; i++) {
            if (__callbacks[i] !== undefined) {
                __callbacks[i](_get_cur_val());
            }
        }
    };

    var _set_cur_val = function (new_val){
        _cur_val = (new_val === 0) ? 1:new_val;
        _call_on_change();
    };

    var _get_cur_val = function() {
        return _cur_val;
    };

    var _onClickLess = function(e) {
        console.log('<_onClickLess>');
        _set_cur_val(_cur_val - 1);
        _afterClick();
        e.preventDefault();
    };

    var _onClickGreat = function(e) {
        console.log('<_onClickGreat>');
        _set_cur_val(Number(_cur_val) + 1);
        _afterClick();
        e.preventDefault();
    };

    var _afterClick = function() {
        _$input.val(_cur_val);
    };

    var _onChangeInput = function(e) {
        console.log('<_onChangeInput>');
    };

    var _fInitBehaviour = function (){
        _$less.on('click', _onClickLess);
        _$great.on('click', _onClickGreat);
        _$input.on('change', _onChangeInput);
    };

    var _fInit = function (wrapper){

        _$wrapper = $(wrapper);
        _$less = _$wrapper.find('a.l');
        _$great = _$wrapper.find('a.g');
        _$input = _$wrapper.find('input');
        _cur_val = _$input.val();
        __callbacks = [];

        _fInitBehaviour();

    };

    _fInit(wrapper);

    return {
        get_cur_val: _get_cur_val,
        on_change: _on_change
    }

};