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