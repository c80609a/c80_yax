"use strict";

// при клике по habtm кнопке "добавить",
// на всякий случай,
// инициализируем в появившемся на экране блоке
// возможный bootstrap select picker
var init_select_picker = function (){
    $('.has_many_add').on('click', function (){
        setTimeout(function() {
            $('.selectpicker').selectpicker();
        }, 40);
    });
};

var f_edit = function (){
    init_select_picker();
};

var f_new = function (){
    init_select_picker();
};

C80_YAX.strsubcats = {
    edit: f_edit,
    "new": f_new
};