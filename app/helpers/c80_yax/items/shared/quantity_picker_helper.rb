module C80Yax
  module Items
    module Shared
      module QuantityPickerHelper

        def render_quantity_picker(item)
            render :partial => 'c80_yax/items/quantity_picker',
                   :locals => {
                       item: item
                   }
        end

      end
    end
  end
end