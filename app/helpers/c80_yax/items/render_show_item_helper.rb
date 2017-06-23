module C80Yax
  module Items
    module RenderShowItemHelper

      # render partial, отображающий полуню информацию о товаре +item+
      # с помощью +is_render_title+ можно отключить печать названия товара
      def render_show_item(item, is_render_title = true)
        render partial: 'c80_yax/items/show',
               locals: {
                   item: item,
                   is_render_title: is_render_title
               }
      end

    end
  end
end