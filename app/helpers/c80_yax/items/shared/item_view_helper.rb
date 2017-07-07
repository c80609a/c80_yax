module C80Yax
  module Items
    module Shared
      module ItemViewHelper

        # вывести первого попавшегося Производителя, назначенного Товару
        def print_vendor(itm)
          str = '-'
          # noinspection RubyResolve
          if itm.vendors.count > 0
            str = itm.vendors.first.title
          end
          str
        end

        def item_print_full_desc(itm)
          r = ''
          # noinspection RubyResolve
          r = itm.full_desc if itm.full_desc.present?
          r.html_safe
        end

      end
    end

  end
end