"use strict";

var RowPrinter = function() {

    var _ROW = '<tr>' +
        '<td style="width:290px;">' +
            '<a href=" {{ item_url }}" title="{{ title }}">' +
                '{{ title }}' +
            '</a>' +
        '</td>' +
        '<td style="width:130px;">' +
            'Цвет: {{ color_title }}' +
        '</td>' +
        '<td style="width:150px;">' +
            'Кол-во: {{ q }}' +
        '</td>' +
        '<td style="width:190px;">Цена: {{ price }}</td>' +
        '</tr>';

    var _BOTTOM_ROW = '<tr>' +
            '<td colspan="2">Итого: {{ order_price }}</td>' +
            '<td colspan="2">Доставка: {{ deliver }}</td>' +
        '</tr>';

    var _print = function(obj, pattern) {
        var res = pattern;
        var al;
        for ( var key in obj ){
            al = "{{ " + key + " }}";
            res = res.split(al).join(obj[key]);
        }
        return res;
    };

    this.print_row = function(obj) {
        return _print(obj, _ROW);
    };

    this.print_bottom_row = function(obj) {
        return _print(obj, _BOTTOM_ROW);
    };

};