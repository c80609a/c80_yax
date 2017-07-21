// собирает данные с формы просмотра/заказа товара, на основе которых
// создастся row to cart

var CollectDataForRow = function() {
    this.call = function() {
        console.log("<CollectDataForRow.call>");
        return {
            id: 1,
            q: 1,
            color: '#ffffff',
            options: {
                mark_delivery: true,
                mark_super_colors: false,
                mark_metallic: false
            }
        }
    }
};