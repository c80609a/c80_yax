module C80Yax
  module Items
    module Photos
      module ItemPhotosHelper

        # вывести первую фотку и кол-во всего
        # noinspection RubyResolve
        def item_photos_short(item)
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

        # вывести lazy magnific popup slider фотографий товара
        # С помощью +thumb_type+ можно задать, какие версии фотографий будут использованы в слайдере
        def item_photos(item, thumb_type = 'thumb_lg')

          # TODO-0:: реализовать gem и использовать его тут в том виде, какой описан в комментах
          #
          # photos = {
          #   thumb_list: ['image01_thumb_lg.jpg'], # на основе этого строится slider
          #   big_list: ['image01.jpg'] # эти фотки magnific открываются
          # }
          # c80_lazy_maginific_popup_slider(photos)

          r = ''
          if item.iphotos.count > 0
            r = image_tag(item.iphotos.first.image.send(thumb_type))
          end
          r.html_safe

        end

      end
    end
  end
end