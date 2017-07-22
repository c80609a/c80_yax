// собирает данные с формы просмотра/заказа товара, на основе которых
// создастся row to cart

var CollectDataForRow = function(item_id) {
    this.call = function() {
        console.log("<CollectDataForRow.call> item_id = " + item_id);

        var $item_show = $('.item_show_'+item_id);

        var q = ITEM_QUANTITY_PICKERS[item_id].get_cur_val();
        var price = q * Number($item_show.find('.price_props p.cur span.pvalue').text().split(',').join('.'));
        var title = $item_show.data('title');
        var color = ITEM_COLOR_SELECTOR[item_id].get_cur_val();
        var options = ITEM_OPTIONS[item_id].get_cur_val();

        return {
            id: item_id,
            title: title,
            q: q,
            color: color,
            price: price,
            image_url: $item_show.data('image_url'),
            item_url: $item_show.data('item_url'),
            options: {
                mark_delivery: options['delivery'],
                mark_super_colors: options['super_colors'],
                mark_metallic: options['metallic']
            }
        }

    }

};