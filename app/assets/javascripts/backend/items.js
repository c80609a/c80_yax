"use strict";

var fCheckItemProperties = function () {

    var result = true;

    if ($("input#item_title").val().length == 0) {
        jAlert('Укажите название.');
        result = false;
    }

    if ($("select#item_strsubcat_id").val() == "") {
        jAlert('Укажите подкатегорию.');
        result = false;
    }

    var item_props_input_list = $("li.item_props").find("input");
    var inputs_count = item_props_input_list.length;

    if (inputs_count == 0) {
        result = false;
        jAlert('Не получится создать товар без характеристик.');
    } else {
        item_props_input_list.each(function () {
            if ($(this).val() != '') {
                inputs_count--;
            }
        });
        if (inputs_count > 0) {
            result = false;
            jAlert('Заполните все характеристики товара.');
        }
    }



    return result;
};

var jsinit = {

    _debug:true,
    $select_strsubcat: null,
    $btn_add_item_prop: null,       // кнопка "Добавить "
    $item_props_container: null,    // в этом контейнере живут fieldset-ы, каждый из которых соответствует одному свойству предмета
    $item_props_container_span: null,    // заголовок контейнера, в котором живут fieldset-ы свойств предмета

    // допишем поясняющий текст "сначала выберите подкатегорию"
    _fWelcomeTextAdd: function () {
        jsinit.$item_props_container_span.text("Характеристики [сначала выберите подкатегорию, тогда появятся свойства, присущие выбранной категории]");
    },

    // удалим поясняющий текст "сначала выберите подкатегорию"
    _fWelcomeTextRemove: function () {
        jsinit.$item_props_container_span.text("Характеристики");
    },

    go: function () {
        //jsinit._log("[go]");

        jsinit.$select_strsubcat = $("select#item_strsubcat_id");
        jsinit.$item_props_container = $("li.item_props");
        jsinit.$item_props_container_span = jsinit.$item_props_container.parent().parent().find("> legend > span");
        jsinit.$btn_add_item_prop = jsinit.$item_props_container.find("a.has_many_add");
        jsinit.$btn_submin = $("fieldset.actions").find("input[name=commit]");

        //jsinit.$btn_add_item_prop.css("display","none"); // прячем сразу кнопку "Добавить Item prop"
        jsinit.$select_strsubcat.on("change", jsinit._onSelectStrSubcatChange);
        jsinit._onSelectStrSubcatChange();

        // в момент нажатия кнопки "отправить" - "разлачиваем" все селекты
        jsinit.$btn_submin.click(function (e) {
            if (fCheckItemProperties()) {
                jsinit.$item_props_container.find("select").attr("disabled", false);
                fLoadingShow();
            } else {
                e.preventDefault();
            }
        });

        // пока пользователь не выбрал подкатегорию - допишем поясняющий текст "сначала выберите подкатегорию"
        jsinit._fWelcomeTextAdd();

    },

    // слушает изменения селекта с подкатегориями
    _onSelectStrSubcatChange: function () {
        var strsubcat_id = jsinit.$select_strsubcat[0].value;
        //jsinit._log("[_onSelectStrSubcatChange]: strsubcat_id = " + strsubcat_id);
        if (strsubcat_id == '') {
            jsinit._removeMayBeAddedProps();
            jsinit._fWelcomeTextAdd();
        } else {
            fLoadingShow();
            jsinit._reqStrsubcatPropnames(strsubcat_id);
            jsinit._fWelcomeTextRemove();
        }
    },

    // запрашиваем список имён свойств указанной подкатегории
    _reqStrsubcatPropnames: function (strsubcat_id) {
        //jsinit._log("[_reqStrsubcatPropnames]: strsubcat_id = " + strsubcat_id);

        $.ajax({
            url: "/admin_data_get_strsubcat_propnames",
            data: { strsubcat_id:strsubcat_id },
            dataType: "json",
            type: 'POST'
        }).done(function(data,result) {
            //jsinit._log( data );

            if (result == "success") {
                jsinit._log( "Кол-во свойств: " + data.length );

                // удалим, возможно уже добавленные в форму, свойства
                jsinit._removeMayBeAddedProps();

                // количество свойств
                var n = data.length;

                // "цикловые" переменные
                var $ifs,        // fieldset,
                    $iselprop,   // очередной селект "имя свойства"
                    $iinputprop, // очередной input "значение свойства"
                    $ifindbyid,  // вспомогательная переменная: содержит результат поиска по id с помощью регулярки
                    ielem;      // очередной элемент из data

                for (var i=0; i<n; i++) {

                    // фиксируем объект с данными, описывающий свойство предмета
                    ielem = data[i];

                    // нажмём кнопку "Добавить Item prop"
                    jsinit.$btn_add_item_prop.click();

                    // фиксируем добавленный в форму fieldset

                    //<fieldset class="inputs has_many_fields processed">
                    //    <ol>
                    //        <li id="item_item_props_attributes_37_prop_name_input">
                    //            <select id="item_item_props_attributes_37_prop_name_id">
                    //                <option value="37">Артикул</option>
                    //            </select>
                    //        </li>
                    //        <li id="item_item_props_attributes_37_value_input">
                    //            <input id="item_item_props_attributes_37_value" type="text">
                    //        </li>
                    //    </ol>
                    //</fieldset>

                    $ifs = jsinit.$item_props_container.find("fieldset").not(".processed");
                    $ifs.addClass("processed");

                    $ifindbyid = $ifs.find('[id^="item_item_props_attributes_"]');

                    // находим в ifs селект, отвечающий за имя свойства
                    $iselprop = $ifindbyid.find('select');
                    //console.log(iselprop);

                    // находим в ifs input, отвечающий за значение свойства
                    $iinputprop = $ifindbyid.find('input');

                    // в этот селект жестоко предустанавливаем значение из data, дописываем единицу измерения
                    $iselprop.find("option")
                        .filter(function () {
                            //console.log($(this).val() + " vs " + ielem["id"]);
                            return $(this).val() == ielem["id"]; //return $(this).text() == ielem["title"];
                        })
                        .prop('selected', true)
                        .text(function () {
                            var t = $(this).text();
                            if (ielem["uom_title"] != null) {
                                t += ", " + ielem["uom_title"];
                            }
                            return t;
                        }); // дописываем в конец единицу измерения

                    //делаем его readonly
                    $iselprop.attr("disabled", true); // NOTE:: но в момент нажатия кнопки "Отправить" мы "разлачиваем" селект, чтобы параметры формы "правильно" отправлялись;

                    // в input "бренд" - ставим "-1" и прячем его от пользователя
                    if (ielem["id"] == 36) {
                        $iinputprop.val("-1");
                        $ifs.css("display",'none');
                    }

                }

                fLoadingHide();

            } else {
                alert( "done: не удалось получить данные о свойствах выбранной подкатегории." );
            }

        })
            .fail(function(jqXHR, textStatus) {
                alert( "fail: не удалось получить данные о свойствах выбранной подкатегории: " + textStatus );
            })
            .always(function() {
                //alert( "complete" );
            });
    },

    // удалим, возможно уже добавленные в форму, свойства
    _removeMayBeAddedProps: function () {
        $("a.has_many_remove").click();
    },

    _log: function () {
        if (jsinit._debug) {
            //console.log(arguments[0]);
        }
    }

};

var fEdit = function () {

    var $select_item_strsubcat; // селект подкатегории, которой принадлежит редактируемый предмет
    var $item_props_container;  // здесь живут селекты свойств
    var $btn_submit;
    var strsubcat_id;           // id подкатегории, которой принадлежит редактируемый предмет, извлекается из селекта $select_item_strsubcat
    var $btn_add_item_prop;     // кнопка "добавить свойство"

    // вернёт true, если найдёт в $item_props_container селект свойства strsubcat_id
    var _fCheckSelect = function (strsubcat_id) {
        var result = false;
        var $selects = $item_props_container.find("fieldset").find('select');
        $selects.each(function () {
            if ($(this).val() == strsubcat_id) {
                result = true;
            }
        });
        return result;
    };

    var fReqPropList = function (strsubcat_id) {
        $.ajax({
            url: "/admin_data_get_strsubcat_propnames",
            data: { strsubcat_id:strsubcat_id },
            dataType: "json",
            type: 'POST'
        }).done(function (data,result) {
            //data - это список свойств, которые должны быть у предмета
            if (result == "success") {

                /* обходим data, ищем соответствующие селекты,
                 * по ходу формируем список toAdd - индексы массива data
                 * отсутствующих свойств. Затем обрабатываем
                 * получившийся список и добавляем отсутствующие селекты. */

                var toAdd = [];

                // количество свойств
                var n = data.length;

                var ielem;

                // обходим список свойств, которые должны быть у предмета
                // и выясняем, кто отсутствует в форме
                for (var i=0; i<n; i++) {

                    // фиксируем объект с данными
                    ielem = data[i];

                    // если такой селекта нет в форме - запомним id свойства
                    if (_fCheckSelect(ielem["id"])) {

                    } else {
                        toAdd.push(i);
                    }
                }

                var $ifs, $iselprop;

                // теперь добавляем отсутствующие селекты
                n = toAdd.length;
                for (i = 0; i<n; i++) {
                    ielem = data[ toAdd[i] ];

                    // нажмём кнопку "Добавить Item prop"
                    $btn_add_item_prop.click();

                    // фиксируем добавленный в форму fieldset
                    $ifs = $item_props_container.find("fieldset").not(".was_before");
                    $ifs.addClass("was_before");

                    // находим в ifs селект, отвечающий за имя свойства
                    $iselprop = $ifs.find('[id^="item_item_props_attributes_"]').find('select');

                    // в этот селект жестоко предустанавливаем значение из data и делаем его readonly
                    $iselprop.find("option").filter(function () {
                        //console.log(this);
                        return $(this).val() == ielem["id"]; //return $(this).text() == ielem["title"];
                    }).prop('selected', true);
                    $iselprop.attr("disabled", true); // NOTE:: но в момент нажатия кнопки "Отправить" мы "разлачиваем" селект, чтобы параметры формы "правильно" отправлялись

                }

                /*дописываем единицы измерения всем селектам*/

                // перед циклом: фиксируем все fieldset
                $ifs = $item_props_container.find("fieldset");

                // перед циклом: фиксируем все интерактивные элементы с таким id
                var $ifindbyid = $ifs.find('[id^="item_item_props_attributes_"]');
                $iselprop = $ifindbyid.find('select');

                n = data.length;
                for (i = 0; i<n; i++) {
                    ielem = data[i];

                    // находим селект, отвечающий за имя свойства и дописываем единицу измерения
                    $iselprop.find("option").filter(function () {
                        //console.log(this);
                        return $(this).val() == ielem["id"]; //return $(this).text() == ielem["title"];
                    }).text(function () {
                        var t = $(this).text();
                        if (ielem["uom_title"] != null) {
                            t += ", " + ielem["uom_title"]
                        }
                        return t;
                    });

                    // в input "бренд" - ставим "-1" и прячем весь fieldset от пользователя
                    if (ielem["id"] == 36) {
                        // находим опцию id=36 селекта "имя свойства"
                        var $opt = $iselprop.find("option").filter(function () {
                            var $t = $(this);
                            return $t.val() == 36 && $t.prop('selected');
                        });
                        // из этой опции добираемся до fieldset, который её содержит
                        var $fieldset = $opt.parent().parent().parent();
                        // а затем уже находим input
                        $fieldset.find("input").val("-1");
                        // прячем
                        $fieldset.css('display','none');

                    }

                }

                fLoadingHide();

            } else {
                alert( "done: не удалось получить данные о свойствах выбранной подкатегории." );
            }
        }).fail(function(jqXHR, textStatus) {
            alert( "fail: не удалось получить данные о свойствах выбранной подкатегории: " + textStatus );
        });
    };

    $(document).ready(function () {

        // инициализация
        $select_item_strsubcat = $('select#item_strsubcat_id');
        $btn_submit = $("fieldset.actions").find("input[name=commit]");
        $item_props_container = $("li.item_props");
        strsubcat_id = $select_item_strsubcat[0].value;
        $btn_add_item_prop = $item_props_container.find("a.has_many_add");

        // блокируем селект "подкатегория"
        $select_item_strsubcat.attr("disabled", true);

        // блокируем селекты "свойства товара"
        $item_props_container.find("select").attr("disabled", true);

        // отмечаем уже имеющиеся fieldsets
        $item_props_container.find("fieldset").each(function () {
            $(this).addClass("was_before");
        });

        //совершаем запрос за свойствами, которые присущи данной подкатегории
        fReqPropList(strsubcat_id);

        // в момент нажатия кнопки "отправить" - "разлачиваем" все селекты
        // и добавляем модальный предзагрузчик
        $btn_submit.click(function (e) {
            if (fCheckItemProperties()) {
                $item_props_container.find("select").attr("disabled", false);
                fLoadingShow();
                //e.preventDefault(); // for debug
            } else {
                e.preventDefault();
            }
        });

        var $link_dub_item = $('.dublicate_item');
        var item_id = window.location.href.split('/items/')[1].split('/edit')[0]; // localhost:3000/admin/items/19/edit
        $link_dub_item.data('item-id',item_id);
        $link_dub_item.click(function (e) {

            e.preventDefault();
            fLoadingShow();

            $.ajax({
                url: '/dublicate_item',
                type: 'POST',
                data: {
                    item_id: item_id
                },
                dataType: 'script'
            })

        });

    });

    fLoadingShow();
};

YOUR_APP.items = {
    edit: fEdit,
    "new": jsinit.go//,
    //create: jsinit.go
};