"use strict";

// _color_selector.html.erb

var ItemColorSelector = function(wrapper) {

    var _$wrapper;
    var _$lic;
    var _sel_color;
    var _sel_color_title;

    var _get_sel_color = function(mark_return_title) {
        return (mark_return_title) ? _sel_color_title:_sel_color;
    };

    var _set_sel_color = function(new_color, new_color_title) {
        _sel_color = new_color;
        _sel_color_title = new_color_title;
    };

    var _onClickColorBox = function(e) {
        e.preventDefault();
        var $t = $(e.target);
        var t_color = $t.data('color');
        var t_color_title = $t.data('color_title');
        _set_sel_color(t_color, t_color_title);
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
        _sel_color = '';
        _sel_color_title = 'не указан';

        _fInitRadioBehaviour();

    };

    _fInit(wrapper);

    return {
        get_cur_val: _get_sel_color
    }

};