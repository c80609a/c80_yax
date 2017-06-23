module C80Yax
  module Items
    module BuyOptionsHelper

      def render_buy_options

        elems = [
            {
                label: 'Нестандартные цвета<br>(+20% к стоимости)',
                value: '1',
                style: 'small'
            },
            {
                label: 'Цвета с металлическим блеском<br>(+20% к стоимости)',
                value: '2',
                style: 'small'
            },
            {
                label: 'Заказать доставку',
                value: '3',
                style: 'huge'
            }
        ]

        render :partial => 'c80_yax/items/buy_options',
               :locals => {
                   elems: elems
               }
      end

    end
  end
end