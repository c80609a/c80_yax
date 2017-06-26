module C80Yax
  module Cats
    module CatViewHelper

      # выдать html строку с image_tag картинки категории
      def cat_image_tag(cat, thumb_type = 'thumb_md')
        res = ''
        if cat.image.present?
          res = image_tag cat.image.thumb_md
        end
        res.html_safe
      end

      # выдать урл картинки категории
      def cat_image_url(cat, thumb_type = 'thumb_md')
        res = ''
        if cat.image.present?
          res = cat.image.send(thumb_type)
        end
        res
      end

    end
  end
end