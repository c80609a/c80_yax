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

    end
  end
end