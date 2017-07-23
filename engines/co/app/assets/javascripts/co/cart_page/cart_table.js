"use strict";

var CartTable = function ($table, on_changd){

    var _rows;
    var _$table;
    var _$tbody;
    var _support;
    var __on_changed;

    //<editor-fold desc="// Инициализация">
    var _fInitBehaviour = function (){
    };
    var _fInit = function ($table, on_changed){
        _$table = $table;
        _$tbody = _$table.find('tbody');
        _support = new RowMaker();
        _rows = [];
        __on_changed = on_changed;
        _fInitBehaviour();
    };
    _fInit($table, on_changd);
    //</editor-fold>

    this.add_row = function(row_hash) {
        _rows.push(row_hash);
        var $row = $(_support.make_row_htmlstr(row_hash));
        _$tbody.append($row);
        _activate_q_picker(function(value_after_change) {
            console.log('<value_after_change> ' + value_after_change);
            var new_price = value_after_change * $row.data('price_per_item');
            $row.find('td.price').text(new_price);
            __on_changed($row.data('id'), {price: new_price});
        });
    };

    this.clear = function() {
        var i, n = _rows.length;
        for (i = 0; i<n; i++) {
            $('.tr_' + _rows[i]['id']).remove();
        }
        _rows = [];
    };

    this.remove_row = function(id) {
        var i, n = _rows.length;
        for (i = n; i>=0; i--) {
            if (_rows[i]['id'] === id) {
                _rows.splice(i, 1);
                break;
            }
        }
        $('.tr_'+id).remove();
    };

};