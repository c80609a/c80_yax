"use strict";

var ItemColorSelector = function(wrapper) {

    var _$wrapper;
    var _$lic;
    var _sel_color;

    var _set_sel_color = function(new_color) {
        _sel_color = new_color;
    };

    var _onClickColorBox = function(e) {
        e.preventDefault();
        var $t = $(e.target);
        var t_color = $t.data('color');
        _set_sel_color(t_color);
        _$lic.removeClass('active');
        $t.addClass('active');
    };

    var _fInitRadioBehaviour = function() {
        _$lic.each(function() {
            $(this).on('click', _onClickColorBox);
        });
    };

    var _fInit = function(wrapper) {

        _$wrapper = $(wrapper);
        _$lic = _$wrapper.find('li.c');

        _fInitRadioBehaviour();

    };

    _fInit(wrapper);

};