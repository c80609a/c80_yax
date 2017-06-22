module C80Yax
  module Items
    module ShowItemHelper

      # напечатать название товара, завёрнутое в H1
      # с помощью +do_render+ можно ничего не печатать
      # переопределить в host приложении
      def h1_item_title(item, do_render = true)
        if do_render
          title = item.title
          "<h1>#{title}</h1>".html_safe
        end
      end

      def render_item_main_props(item)

      end

    end
  end
end
