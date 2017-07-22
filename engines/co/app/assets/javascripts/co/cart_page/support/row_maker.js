"use strict";

var RowMaker = function() {

    var _ROW = '<tr class="tr_{{ id }}" data-price_per_item="{{ price_per_item }}">' +
        '<td class="image">' +
            '<a class="lazy-image-wrapper" href=" {{ item_url }}" target="_blank" title="{{ title }}">' +
                '<img data-original="{{ image_url }}" alt="{{ title }}">' +
            '</a>' +
        '</td>' +
        '<td class="title">{{ title }}</td>' +
        '<td class="color">' +
            '<ul class="item_color_selector" data-id="{{ id }}">' +
            '<li style="background-color:{{ color }}" class="c"></li>' +
            '</ul>' +
        '</td>' +
        '<td class="q">' +
        '<div class="quantity_picker" data-id="{{ id }}">' +
                '<a href="#" class="l">-</a>' +
                '<input name="val" id="val" value="{{ q }}">' +
                '<a href="#" class="g">+</a>' +
            '</div>' +
        '</td>' +
        '<td class="price">{{ price }}</td>' +
        '<td class="actions"><a title="Удалить" class="del_action" data-id="{{ id }}">Удалить</a></td>' +
        '</tr>';

    this.make_row_htmlstr = function(obj) {
        var res = _ROW;
        var al;
        for ( var key in obj ){
            al = "{{ " + key + " }}";
            res = res.split(al).join(obj[key]);
        }
        return res;
    }

}