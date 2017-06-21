
var admin = {

    init: function(){
        admin.set_admin_editable_events();
    },

    set_admin_editable_events: function(){
        $(".admin-editable").on("keypress", function(e){
            if ( e.keyCode==27 )
                $( e.currentTarget ).hide();

            if ( e.keyCode==13 ){
                var path        = $( e.currentTarget ).attr("data-path");
                var attr        = $( e.currentTarget ).attr("data-attr");
                var resource_id = $( e.currentTarget ).attr("data-resource-id");
                var resour_slug = $( e.currentTarget ).attr("data-resource-slug");
                var val         = $( e.currentTarget ).val();

                val = $.trim(val);
                if (val.length==0)
                    val = "&nbsp;";

                $("div#"+$( e.currentTarget ).attr("id")).html(val);
                $( e.currentTarget ).hide();

                var payload = {};
                resource_class = path.slice(0,-1); // e.g. path = meters, resource_class = meter
                payload[resource_class] = {};
                payload[resource_class][attr] = val;

                // NOTE:: исправить непонятку, когда сервер отвечает 302 ответ, скрипт считает, что ответ неудачный, и шлёт запрос 20 раз, в итоге, всё завершается исполнением error колбэка, но данные на сервере изменены

                $.ajax({
                    url: "/admin/"+path+"/"+resour_slug,
                    data: payload,
                    type: 'POST'
                }).done(function() {
                    //alert( "success" );
                })
                    .fail(function(jqXHR, textStatus) {
                        //alert( textStatus );
                    })
                    .always(function() {
                        //alert( "complete" );
                    });
            }
        });

        $(".admin-editable").on("blur", function(e){
            $( e.currentTarget ).hide();
        });
    },

    editable_text_column_do: function(el){
        var input = "input#"+$(el).attr("id")

        $(input).width( $(el).width()+4 ).height( $(el).height()+4 );
        $(input).css({top: ( $(el).offset().top-2 ), left: ( $(el).offset().left-2 ), position:'absolute'});

        val = $.trim( $(el).html() );
        if (val=="&nbsp;")
            val = "";

        $(input).val( val );
        $(input).show();
        $(input).focus();
    }
};

$( document ).ready(function() {
    admin.init();
});