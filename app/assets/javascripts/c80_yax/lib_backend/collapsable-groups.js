var fHandleClickCollapsed = function () {
    $(document).ready(function () {
        $('.collapsed legend').bind('click', function (e) {

            // на тот случай, если внутрь легенды положена ссылка "например" и кликнули по этой ссылке
            if ($(e.target).attr('href') != undefined) return;

            var $tp = $(this).parent();
            var $t = $tp.find("ol");

            if ($t.css('display') == 'none') {
                $t.css('display', 'block');
                $tp.addClass('shown');
            } else {
                $t.css('display', 'none');
                $tp.removeClass('shown');
            }

        });
    });
};
fHandleClickCollapsed();