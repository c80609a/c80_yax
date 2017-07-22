module C80Yax
  module Items
    module Shared
      module ColorSelectorHelper

        def render_color_selector(item)
          colors = item.colors
          unless colors.size.zero?
            render :partial => 'c80_yax/items/color_selector',
                   :locals => {
                       colors: colors,
                       item: item
                   }
          end
        end

      end
    end
  end
end