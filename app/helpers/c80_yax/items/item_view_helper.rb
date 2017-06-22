module C80Yax
  module Items
    module ItemViewHelper

      # вывести первую фотку и кол-во всего
      # noinspection RubyResolve
      def iphotos_short_view(item)
        r = ''
        if item.iphotos.count > 0
          r = link_to image_tag(item.iphotos.first.image.thumb_md,
                                style: 'width:150px'),
                      item.iphotos.first.image.url,
                      target: '_blank'
          r = "#{r}<br><sup>Всего фотографий: #{item.iphotos.count}</sup>".html_safe
        end
        r
      end

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