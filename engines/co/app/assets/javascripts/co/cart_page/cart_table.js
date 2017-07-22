"use strict";

var CartTable = function ($table){

    var _rows;
    var _$table;
    var _$tbody;
    var _support;

    //<editor-fold desc="// Инициализация">
    var _fInitBehaviour = function (){
    };
    var _fInit = function ($table){
        _$table = $table;
        _$tbody = _$table.find('tbody');
        _support = new RowMaker();
        _rows = [];
        _fInitBehaviour();
    };
    _fInit($table);
    //</editor-fold>

    this.add_row = function(row_hash) {
        _rows.push(row_hash);
        var $row = $(_support.make_row_htmlstr(row_hash));
        _$tbody.append($row);
        _activate_q_picker();
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