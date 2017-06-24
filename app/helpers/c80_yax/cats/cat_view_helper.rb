module C80Yax
  module Cats
    module CatViewHelper

      def cat_image(cat)
        res = ''
        if cat.image.present?
          res = image_tag cat.image.thumb_md
        end
        res.html_safe
      end

    end
  end
end