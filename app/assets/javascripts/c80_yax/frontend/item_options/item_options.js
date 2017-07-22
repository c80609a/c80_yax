"use strict";

var ItemOptions = function (wrapper){

    var _$wrapper;
    var _cur_val = {

    };

    var _get_cur_val = function() {
        return _cur_val;
    };

    var _fCollectOptions = function() {
        _$wrapper.find('div.checkbox').each(function() {
            var $t = $(this);
            var tag = $t.data('tag');
            var $inp = $t.find('input');
            var val = $inp[0].checked;
            _cur_val[tag] = val;
            console.log('<_fCollectOptions> val = ' + val + ": " + tag);
        });
        console.log(_cur_val);
    }

    var _fInitBehaviour = function (){
        _fCollectOptions();
    };

    var _fInit = function (wrapper){
        _$wrapper = $(wrapper);
        _fInitBehaviour();
    };

    _fInit(wrapper);

    return {
        get_cur_val: _get_cur_val
    }

};