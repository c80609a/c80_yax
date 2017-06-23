module C80Yax
  module Items
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

    end
  end
end