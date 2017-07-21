module C80Yax
  module Items
    module Shared
      module BuyOptionsHelper

        def render_buy_options(item)

          elems = [
              {
                  label: 'Нестандартные цвета<br>(+20% к стоимости)',
                  tag: 'super_colors',
                  value: '1',
                  style: 'small'
              },
              {
                  label: 'Цвета с металлическим блеском<br>(+20% к стоимости)',
                  tag: 'metallic',
                  value: '2',
                  style: 'small'
              },
              {
                  label: 'Заказать доставку',
                  value: '3',
                  tag: 'delivery',
                  style: 'huge'
              }
          ]

          render :partial => 'c80_yax/items/buy_options',
                 :locals => {
                     elems: elems,
                     item: item
                 }
        end

      end
    end

  end
end