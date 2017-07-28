var activate_collapsed_ti = function () {
    $(document).ready(function () {
        $('.tech_info_list h3').bind('click', function (e) {

            // на тот случай, если внутрь легенды положена ссылка "например" и кликнули по этой ссылке
            if ($(e.target).attr('href') !== undefined) return;

            var $li_parent = $(this).parent();
            var $ul_docs = $li_parent.find('ul.docs');

            if ($ul_docs.css('display') === 'none') {
                $ul_docs.css('display', 'block');
                $li_parent.addClass('shown');
            } else {
                $ul_docs.css('display', 'none');
                $li_parent.removeClass('shown');
            }

        });
    });
};
activate_collapsed_ti();