// собирает данные для строки после
// нажатия мелкой кнопки "в корзину"

var CollectDataForRowSm = function(item_id) {
    this.call = function() {
        console.log("<CollectDataForRowSm.call> item_id = " + item_id);

        var $item_show = $('.li_item.i_'+item_id);

        var q = 1;
        var price_per_item = Number($item_show.find('.price_props p.cur span.pvalue').text().split(',').join('.'));
        var price = q * price_per_item;
        var title = $item_show.data('title');
        var color = '';
        var color_title = 'не указан';
        var options = {delivery:false, super_colors:false, metallic:false};

        return {
            id: item_id,
            title: title,
            q: q,
            color: color,
            color_title: color_title,
            price: price,
            price_per_item: price_per_item,
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